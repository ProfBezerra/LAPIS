param(
    [Parameter(Mandatory = $true)]
    [string]$Owner,

    [Parameter(Mandatory = $true)]
    [string]$Repo,

    [Parameter(Mandatory = $true)]
    [int]$ProjectNumber,

    [string]$ProjectOwner = $Owner,

    [string]$JsonPath = "scripts/issues_github.json",

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
$issues = $jsonContent | ConvertFrom-Json

if (-not $issues -or $issues.Count -eq 0) {
    throw "Nenhuma issue encontrada em $resolvedJsonPath"
}

$apiBase = "https://api.github.com/repos/$Owner/$Repo"
$headers = @{
    Accept = "application/vnd.github+json"
    Authorization = "Bearer $Token"
    "X-GitHub-Api-Version" = "2022-11-28"
    "User-Agent" = "lapis-setup-script"
}

$graphHeaders = @{
    Authorization = "Bearer $Token"
    "User-Agent" = "lapis-setup-script"
}

$labelColorMap = @{
    "alta" = "B60205"
    "media" = "FBCA04"
    "baixa" = "0E8A16"
    "elicitação" = "1D76DB"
    "requisitos" = "5319E7"
    "uml" = "0052CC"
    "srs" = "C2E0C6"
    "prototipo" = "D4C5F9"
    "pitch" = "F9D0C4"
}

function Invoke-GitHubGet {
    param([string]$Uri)
    return Invoke-RestMethod -Method Get -Uri $Uri -Headers $headers
}

function Invoke-GitHubPost {
    param(
        [string]$Uri,
        [object]$Body
    )

    $jsonBody = $Body | ConvertTo-Json -Depth 10
    $utf8Body = [System.Text.Encoding]::UTF8.GetBytes($jsonBody)

    if ($DryRun) {
        Write-Host "[DRY-RUN] POST $Uri"
        Write-Host $jsonBody
        return $null
    }

    return Invoke-RestMethod -Method Post -Uri $Uri -Headers $headers -Body $utf8Body -ContentType "application/json; charset=utf-8"
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

function Normalize-SprintLabel {
    param([string]$Sprint)

    if ([string]::IsNullOrWhiteSpace($Sprint)) {
        return $null
    }

    $trimmed = $Sprint.Trim().ToLowerInvariant()
    if ($trimmed -match "^sprint\s+(\d+)$") {
        return "sprint-$($Matches[1])"
    }

    return ($trimmed -replace "\s+", "-")
}

function Normalize-Text {
    param([string]$Text)
    if (-not $Text) { return "" }
    return $Text.Trim().ToLowerInvariant()
}

function Ensure-Label {
    param(
        [string]$LabelName,
        [hashtable]$ExistingLabels
    )

    if ($ExistingLabels.ContainsKey($LabelName)) {
        return
    }

    $color = if ($labelColorMap.ContainsKey($LabelName)) { $labelColorMap[$LabelName] } else { "D4D4D4" }
    Invoke-GitHubPost -Uri "$apiBase/labels" -Body @{
        name = $LabelName
        color = $color
    } | Out-Null

    $ExistingLabels[$LabelName] = $true
    Write-Host "Label criada: $LabelName"
}

function Ensure-Milestone {
    param(
        [string]$MilestoneTitle,
        [hashtable]$ExistingMilestones
    )

    if ([string]::IsNullOrWhiteSpace($MilestoneTitle)) {
        return $null
    }

    if ($ExistingMilestones.ContainsKey($MilestoneTitle)) {
        return $ExistingMilestones[$MilestoneTitle]
    }

    $created = Invoke-GitHubPost -Uri "$apiBase/milestones" -Body @{
        title = $MilestoneTitle
    }

    if ($created) {
        $ExistingMilestones[$MilestoneTitle] = $created.number
        Write-Host "Milestone criada: $MilestoneTitle"
        return $created.number
    }

    return $null
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

# =============================================================================
# FASE 1: IMPORTAÇÃO DE LABELS, MILESTONES E ISSUES
# =============================================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "FASE 1: Importação de Issues" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

Write-Host "Carregando labels, milestones e issues existentes..."

$existingLabels = @{}
foreach ($label in (Invoke-GitHubGet -Uri "$apiBase/labels?per_page=100")) {
    $existingLabels[$label.name] = $true
}

$existingMilestones = @{}
foreach ($milestone in (Invoke-GitHubGet -Uri "$apiBase/milestones?state=all&per_page=100")) {
    $existingMilestones[$milestone.title] = $milestone.number
}

$existingIssueTitles = @{}
foreach ($issue in (Invoke-GitHubGet -Uri "$apiBase/issues?state=all&per_page=100")) {
    $isPullRequest = $issue.PSObject.Properties.Name -contains "pull_request"
    if (-not $isPullRequest) {
        $existingIssueTitles[$issue.title] = $true
    }
}

Write-Host "Processando $($issues.Count) issues..."

foreach ($item in $issues) {
    # Milestones devem existir mesmo se a issue ja tiver sido criada anteriormente.
    $milestoneNumber = Ensure-Milestone -MilestoneTitle $item.milestone -ExistingMilestones $existingMilestones

    if ($existingIssueTitles.ContainsKey($item.title)) {
        Write-Host "Ignorada (titulo ja existe): $($item.title)"
        continue
    }

    $labels = @()
    if ($item.labels) {
        $labels += @($item.labels)
    }

    $sprintLabel = Normalize-SprintLabel -Sprint $item.sprint
    if ($sprintLabel -and $labels -notcontains $sprintLabel) {
        $labels += $sprintLabel
    }

    foreach ($labelName in $labels) {
        Ensure-Label -LabelName $labelName -ExistingLabels $existingLabels
    }

    $body = $item.body
    if ($item.sprint) {
        $body = "$body`n`nSprint planejada: $($item.sprint)"
    }

    $payload = @{
        title = $item.title
        body = $body
        labels = $labels
    }

    if ($milestoneNumber) {
        $payload.milestone = $milestoneNumber
    }

    Invoke-GitHubPost -Uri "$apiBase/issues" -Body $payload | Out-Null
    $existingIssueTitles[$item.title] = $true
    Write-Host "Issue criada: $($item.title)"
}

Write-Host "Importacao de issues concluida." -ForegroundColor Green
Write-Host ""

# =============================================================================
# FASE 2: SINCRONIZAÇÃO DE SPRINTS E PROJECT
# =============================================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "FASE 2: Sincronização de Sprints" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

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
$repoIssues = Invoke-RestMethod -Method Get -Uri "https://api.github.com/repos/$Owner/$Repo/issues?state=all&per_page=100" -Headers $headers

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

foreach ($entry in $issues) {
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

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Setup completo!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
