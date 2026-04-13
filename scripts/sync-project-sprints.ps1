param(
    [Parameter(Mandatory = $true)]
    [string]$Owner,

    [Parameter(Mandatory = $true)]
    [string]$Repo,

    [Parameter(Mandatory = $true)]
    [int]$ProjectNumber,

    [string]$ProjectOwner = $Owner,

    [string]$JsonPath = "GestaoConfiguracao/issues_github.json",

    [string]$Token = $env:GITHUB_TOKEN,

    [switch]$AutoCreateIterationField,

    [string]$IterationFieldName = "Sprint",

    [string]$IterationStartDate = (Get-Date).ToString("yyyy-MM-dd"),

    [int]$IterationDuration = 14,

    [int]$IterationCount = 5,

    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not $Token) {
    throw "Informe um token do GitHub em -Token ou na variavel de ambiente GITHUB_TOKEN."
}

$resolvedJsonPath = Resolve-Path -Path $JsonPath
$jsonContent = Get-Content -Path $resolvedJsonPath -Raw -Encoding UTF8
$jsonItems = $jsonContent | ConvertFrom-Json

if (-not $jsonItems -or $jsonItems.Count -eq 0) {
    throw "Nenhum item encontrado em $resolvedJsonPath"
}

$restHeaders = @{
    Accept = "application/vnd.github+json"
    Authorization = "Bearer $Token"
    "X-GitHub-Api-Version" = "2022-11-28"
    "User-Agent" = "lapis-project-sync"
}

$graphHeaders = @{
    Authorization = "Bearer $Token"
    "User-Agent" = "lapis-project-sync"
}

function Invoke-GitHubGraphQL {
    param(
        [string]$Query,
        [hashtable]$Variables,
        [switch]$IsMutation
    )

    $payload = @{
        query = $Query
        variables = $Variables
    }

    $jsonBody = $payload | ConvertTo-Json -Depth 20
    $utf8Body = [System.Text.Encoding]::UTF8.GetBytes($jsonBody)

    if ($DryRun -and $IsMutation) {
        Write-Host "[DRY-RUN] GraphQL mutation"
        Write-Host $jsonBody
        return $null
    }

    $response = Invoke-RestMethod -Method Post -Uri "https://api.github.com/graphql" -Headers $graphHeaders -Body $utf8Body -ContentType "application/json; charset=utf-8"

    $hasErrors = $null -ne $response.PSObject.Properties["errors"]
    if ($hasErrors -and $response.errors) {
      $messages = ($response.errors | ForEach-Object { $_.message }) -join " | "
        throw "Falha GraphQL: $messages"
    }

    return $response.data
}

function Normalize-Text {
    param([string]$Text)
    if (-not $Text) { return "" }
    return $Text.Trim().ToLowerInvariant()
}

function Resolve-IterationId {
    param(
        [string]$Sprint,
        [array]$Iterations
    )

    if ([string]::IsNullOrWhiteSpace($Sprint)) {
        return $null
    }

    $sprintNorm = Normalize-Text -Text $Sprint

    foreach ($it in $Iterations) {
        if ((Normalize-Text -Text $it.title) -eq $sprintNorm) {
            return $it.id
        }
    }

    if ($sprintNorm -match "(\d+)") {
        $num = $Matches[1]
        foreach ($it in $Iterations) {
            if ((Normalize-Text -Text $it.title) -match "\b$num\b") {
                return $it.id
            }
        }
    }

    return $null
}

Write-Host "Carregando metadados do projeto..."

$projectQuery = @"
query(
  `$login: String!,
  `$number: Int!
) {
  user(login: `$login) {
    projectV2(number: `$number) {
      id
      title
      fields(first: 50) {
        nodes {
          ... on ProjectV2IterationField {
            id
            name
            configuration {
              iterations {
                id
                title
                startDate
                duration
              }
            }
          }
        }
      }
    }
  }
}
"@

$projectData = Invoke-GitHubGraphQL -Query $projectQuery -Variables @{
    login = $ProjectOwner
    number = $ProjectNumber
}

if (-not $projectData.user -or -not $projectData.user.projectV2) {
    throw "Project v2 nao encontrado: owner '$ProjectOwner', numero '$ProjectNumber'."
}

$project = $projectData.user.projectV2
$projectId = $project.id

if ($IterationCount -lt 1) {
    throw "IterationCount deve ser >= 1."
}

$iterationField = $null
foreach ($field in $project.fields.nodes) {
  $hasConfiguration = $field -and ($null -ne $field.PSObject.Properties["configuration"])
  if ($hasConfiguration -and $field.configuration -and $field.configuration.iterations) {
        $iterationField = $field
        break
    }
}

if (-not $iterationField) {
  if (-not $AutoCreateIterationField) {
    Write-Warning "O projeto nao possui campo Iteration configurado. Tentando criar automaticamente com os parametros padrao (use -AutoCreateIterationField para explicitar este comportamento)."
  }

    Write-Host "Campo Iteration nao encontrado. Criando campo '$IterationFieldName' com $IterationCount iteracoes..."

    $newIterations = @()
    $start = [datetime]::ParseExact($IterationStartDate, "yyyy-MM-dd", [System.Globalization.CultureInfo]::InvariantCulture)
    for ($i = 1; $i -le $IterationCount; $i++) {
        $itStart = $start.AddDays(($i - 1) * $IterationDuration).ToString("yyyy-MM-dd")
        $newIterations += @{
            title = "Sprint $i"
            startDate = $itStart
            duration = $IterationDuration
        }
    }

    $createFieldMutation = @"
mutation(
  `$projectId: ID!,
  `$name: String!,
  `$startDate: Date!,
  `$duration: Int!,
  `$iterations: [ProjectV2Iteration!]!
) {
  createProjectV2Field(input: {
    projectId: `$projectId,
    dataType: ITERATION,
    name: `$name,
    iterationConfiguration: {
      startDate: `$startDate,
      duration: `$duration,
      iterations: `$iterations
    }
  }) {
    projectV2Field {
      ... on ProjectV2IterationField {
        id
        name
        configuration {
          iterations {
            id
            title
            startDate
            duration
          }
        }
      }
    }
  }
}
"@

    $createdFieldData = Invoke-GitHubGraphQL -Query $createFieldMutation -Variables @{
        projectId = $projectId
        name = $IterationFieldName
        startDate = $IterationStartDate
        duration = $IterationDuration
        iterations = $newIterations
    } -IsMutation

    if ($DryRun) {
        Write-Host "[DRY-RUN] Campo Iteration seria criado."
        throw "Dry-run encerrou apos simulacao de criacao do campo Iteration. Rode sem -DryRun para aplicar e sincronizar."
    }

    $iterationField = $createdFieldData.createProjectV2Field.projectV2Field
    Write-Host "Campo Iteration criado: $($iterationField.name)"
}

$iterationFieldId = $iterationField.id
$iterations = @($iterationField.configuration.iterations)

Write-Host "Projeto: $($project.title)"
Write-Host "Campo Iteration: $($iterationField.name)"
Write-Host "Iteracoes disponiveis: $($iterations.Count)"

Write-Host "Carregando issues do repositorio..."
$repoIssues = Invoke-RestMethod -Method Get -Uri "https://api.github.com/repos/$Owner/$Repo/issues?state=all&per_page=100" -Headers $restHeaders

$issuesByTitle = @{}
foreach ($issue in $repoIssues) {
    $isPullRequest = $null -ne $issue.PSObject.Properties["pull_request"]
    if (-not $isPullRequest) {
        $issuesByTitle[$issue.title] = $issue
    }
}

Write-Host "Carregando itens atuais do projeto..."
$projectItemsByIssueId = @{}
$cursor = $null

do {
    $itemsQuery = @"
query(
  `$projectId: ID!,
  `$cursor: String
) {
  node(id: `$projectId) {
    ... on ProjectV2 {
      items(first: 100, after: `$cursor) {
        nodes {
          id
          content {
            ... on Issue {
              id
              title
            }
          }
        }
        pageInfo {
          hasNextPage
          endCursor
        }
      }
    }
  }
}
"@

    $itemsData = Invoke-GitHubGraphQL -Query $itemsQuery -Variables @{
        projectId = $projectId
        cursor = $cursor
    }

    $itemsConn = $itemsData.node.items
    foreach ($item in $itemsConn.nodes) {
        if ($item.content -and $item.content.id) {
            $projectItemsByIssueId[$item.content.id] = $item.id
        }
    }

    $hasNext = $itemsConn.pageInfo.hasNextPage
    $cursor = $itemsConn.pageInfo.endCursor
} while ($hasNext)

$addItemMutation = @"
mutation(
  `$projectId: ID!,
  `$contentId: ID!
) {
  addProjectV2ItemById(input: {
    projectId: `$projectId,
    contentId: `$contentId
  }) {
    item {
      id
    }
  }
}
"@

$setIterationMutation = @"
mutation(
  `$projectId: ID!,
  `$itemId: ID!,
  `$fieldId: ID!,
  `$iterationId: String!
) {
  updateProjectV2ItemFieldValue(input: {
    projectId: `$projectId,
    itemId: `$itemId,
    fieldId: `$fieldId,
    value: {
      iterationId: `$iterationId
    }
  }) {
    projectV2Item {
      id
    }
  }
}
"@

Write-Host "Sincronizando itens e sprints..."

foreach ($entry in $jsonItems) {
    $title = $entry.title
    $sprint = $entry.sprint

    if (-not $issuesByTitle.ContainsKey($title)) {
        Write-Host "Issue nao encontrada no repo (pulada): $title"
        continue
    }

    $issue = $issuesByTitle[$title]
    $issueNodeId = $issue.node_id

    $itemId = $null
    if ($projectItemsByIssueId.ContainsKey($issueNodeId)) {
        $itemId = $projectItemsByIssueId[$issueNodeId]
    } else {
        $addResp = Invoke-GitHubGraphQL -Query $addItemMutation -Variables @{
            projectId = $projectId
            contentId = $issueNodeId
        } -IsMutation

        if ($DryRun) {
            Write-Host "[DRY-RUN] Adicionar ao Project: $title"
            continue
        }

        $itemId = $addResp.addProjectV2ItemById.item.id
        $projectItemsByIssueId[$issueNodeId] = $itemId
        Write-Host "Issue adicionada ao Project: $title"
    }

    $iterationId = Resolve-IterationId -Sprint $sprint -Iterations $iterations
    if (-not $iterationId) {
        Write-Host "Sem iteracao correspondente para '$sprint' (issue: $title)"
        continue
    }

    Invoke-GitHubGraphQL -Query $setIterationMutation -Variables @{
        projectId = $projectId
        itemId = $itemId
        fieldId = $iterationFieldId
        iterationId = $iterationId
    } -IsMutation | Out-Null

    if ($DryRun) {
        Write-Host "[DRY-RUN] Definir iteracao '$sprint' para issue: $title"
    } else {
        Write-Host "Iteracao definida ('$sprint'): $title"
    }
}

Write-Host "Sincronizacao concluida."