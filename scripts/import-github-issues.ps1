param(
    [Parameter(Mandatory = $true)]
    [string]$Owner,

    [Parameter(Mandatory = $true)]
    [string]$Repo,

    [string]$JsonPath = "Requisitos/Artefatos/issues_github.json",

    [string]$Token = $env:GITHUB_TOKEN,

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
    "User-Agent" = "lapis-import-script"
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

Write-Host "Importacao concluida."