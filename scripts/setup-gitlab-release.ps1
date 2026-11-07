<#
.SYNOPSIS
Installiert die GitLab Release-Automation in ein bestehendes Repository.

.DESCRIPTION
Kopiert die generische Datei `scripts/release-gitlab.sh`, erzeugt bei Bedarf
`CHANGELOG.md`, ergaenzt `.gitlab-ci.yml` um eine manuelle Release-Stage und
aktiviert optional `ci_push_repository_for_job_token_allowed` per GitLab API.

.PARAMETER TargetRepository
Pfad zum Ziel-Repository. Standard ist das aktuelle Verzeichnis.

.PARAMETER GitLabUrl
Optionale GitLab-Basis-URL, zum Beispiel `https://gitlab-ce.gwdg.de`.

.PARAMETER SkipProjectSettings
Ueberspringt die GitLab-Projekteinstellung
`ci_push_repository_for_job_token_allowed`.

.PARAMETER ExpectedProject
Explizite Freigabe als HOST/GRUPPE/PROJEKT fuer die Projekteinstellung.

.PARAMETER Force
Ueberschreibt `scripts/release-gitlab.sh` und `CHANGELOG.md`, falls vorhanden.

.EXAMPLE
pwsh scripts/setup-gitlab-release.ps1 -TargetRepository ~/RiderProjects/MyGitLabRepo

.EXAMPLE
pwsh scripts/setup-gitlab-release.ps1 -TargetRepository ~/RiderProjects/MyGitLabRepo -GitLabUrl https://gitlab-ce.gwdg.de
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$TargetRepository = $PWD.Path,
    [string]$GitLabUrl = '',
    [string]$ExpectedProject = '',
    [switch]$SkipProjectSettings,
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$TemplatesDir = Join-Path $ScriptDir 'templates'
Import-Module (Join-Path $ScriptDir 'lib/managed-file-hardening.psm1') -Force
$TargetRepository = $TargetRepository.TrimEnd([IO.Path]::DirectorySeparatorChar)
if ($TargetRepository.StartsWith('~')) {
    $TargetRepository = Join-Path $HOME $TargetRepository.Substring(1).TrimStart('/','\')
}

function Get-GitLabRemoteMetadata([string]$RemoteUrl) {
    $hostName = ''
    $projectPath = ''
    if ($RemoteUrl -match '^https://') {
        $uri = $null
        if (-not [Uri]::TryCreate($RemoteUrl, [UriKind]::Absolute, [ref]$uri) `
            -or $uri.Scheme -cne 'https' -or $uri.UserInfo -or $uri.Query -or $uri.Fragment) { return $null }
        $hostName = if ($uri.IsDefaultPort) { $uri.Host } else { "$($uri.Host):$($uri.Port)" }
        $projectPath = $uri.AbsolutePath.Trim('/')
    } elseif ($RemoteUrl -match '^git@(?<host>[A-Za-z0-9.-]+(?::[0-9]+)?):(?<path>[^\s]+)$') {
        $hostName = $Matches.host
        $projectPath = $Matches.path
    } elseif ($RemoteUrl -match '^ssh://git@(?<host>[A-Za-z0-9.-]+(?::[0-9]+)?)/(?<path>[^\s]+)$') {
        $hostName = $Matches.host
        $projectPath = $Matches.path
    } else { return $null }
    $projectPath = $projectPath -replace '\.git$', ''
    if ($hostName -notmatch '^[A-Za-z0-9.-]+(?::[0-9]+)?$' `
        -or $projectPath -notmatch '^[A-Za-z0-9._-]+(?:/[A-Za-z0-9._-]+)+$' `
        -or "/$projectPath/" -match '/\.\./') { return $null }
    return [pscustomobject]@{ Host = $hostName; ProjectPath = $projectPath }
}

function Get-GitLabBaseHost([string]$Url) {
    $uri = $null
    if (-not [Uri]::TryCreate($Url, [UriKind]::Absolute, [ref]$uri) `
        -or $uri.Scheme -cne 'https' -or $uri.UserInfo -or $uri.Query -or $uri.Fragment `
        -or $uri.AbsolutePath.Trim('/')) { return '' }
    return $(if ($uri.IsDefaultPort) { $uri.Host } else { "$($uri.Host):$($uri.Port)" })
}

function Get-ReleaseStageContent {
    param([string]$Content)

    $content = $Content
    if ($content -match '(?m)^\s*-\s*release\s*$' -or $content -match '(?m)^stages:\s*\[[^\]]*\brelease\b[^\]]*\]') {
        return $content
    }

    if ($content -match '(?m)^stages:\s*\[(?<list>[^\]]*)\]') {
        $list = $Matches['list'].Trim()
        if ($list) {
            $replacement = "stages: [$list, release]"
        } else {
            $replacement = 'stages: [release]'
        }
        $content = [regex]::Replace($content, '(?m)^stages:\s*\[[^\]]*\]', [System.Text.RegularExpressions.MatchEvaluator]{ param($m) $replacement }, 1)
    } elseif ($content -match '(?m)^stages:\s*$') {
        $lines = [System.Collections.Generic.List[string]]::new()
        foreach ($line in @($content -split "`r?`n")) { $lines.Add($line) }
        $index = $lines.FindIndex({ param($line) $line -match '^stages:\s*$' })
        if ($index -ge 0) {
            $insertAt = $index + 1
            while ($insertAt -lt $lines.Count -and $lines[$insertAt] -match '^\s*-\s+') {
                $insertAt++
            }
            $lines.Insert($insertAt, '  - release')
            $content = ($lines -join [Environment]::NewLine)
        }
    } else {
        $content = "stages:`n  - release`n`n$content"
    }

    return $content
}

function Enable-JobTokenPush {
    param([string]$RepositoryPath)

    if ($SkipProjectSettings) {
        Write-Host '  INFO: GitLab project settings skipped'
        return
    }

    if (-not (Get-Command glab -ErrorAction SilentlyContinue)) {
        Write-Host '  WARN: glab not installed — project setting not changed'
        return
    }

    $remoteUrl = ((git -C $RepositoryPath remote get-url origin 2>$null) | Out-String).Trim()
    if (-not $remoteUrl) {
        Write-Host '  WARN: origin remote missing — project setting not changed'
        return
    }

    $metadata = Get-GitLabRemoteMetadata $remoteUrl
    if (-not $metadata) {
        Write-Host '  WARN: origin remote is not a supported credential-free GitLab URL'
        return
    }
    $projectPath = $metadata.ProjectPath
    $gitlabHost = if ($GitLabUrl) { Get-GitLabBaseHost $GitLabUrl } else { $metadata.Host }
    if (-not $gitlabHost) {
        Write-Host '  WARN: GitLab URL must identify a credential-free HTTPS host'
        return
    }
    if ($gitlabHost -cne $metadata.Host) {
        Write-Host '  WARN: GitLab URL host does not match origin; project setting not changed'
        return
    }
    if (-not $ExpectedProject) {
        Write-Host '  WARN: -ExpectedProject is required before changing project settings'
        return
    }
    $exactTarget = "$gitlabHost/$projectPath"
    if ($ExpectedProject -cne $exactTarget) {
        Write-Host '  WARN: expected GitLab project does not match origin; project setting not changed'
        return
    }
    if (-not $PSCmdlet.ShouldProcess($exactTarget, 'Enable ci_push_repository_for_job_token_allowed')) {
        return
    }

    $previousHost = $env:GITLAB_HOST
    try {
        $env:GITLAB_HOST = $gitlabHost
        & glab auth status 2>$null | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Host "  WARN: not authenticated for GitLab host $gitlabHost"
            return
        }
        $encodedProject = $projectPath -replace '/', '%2F'
        & glab api --method PUT "projects/$encodedProject?ci_push_repository_for_job_token_allowed=true" 2>$null | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  OK: enabled ci_push_repository_for_job_token_allowed for $projectPath"
        } else {
            Write-Host "  WARN: could not enable ci_push_repository_for_job_token_allowed for $projectPath"
        }
    } finally {
        $env:GITLAB_HOST = $previousHost
    }
}

foreach ($required in @(
    (Join-Path $TemplatesDir 'release-gitlab.sh.tmpl'),
    (Join-Path $TemplatesDir 'gitlab-release-job.yml.tmpl'),
    (Join-Path $TemplatesDir 'changelog-template.md')
)) {
    if (-not (Test-Path $required)) {
        throw "Missing template: $required"
    }
}

if (-not (Test-Path -LiteralPath (Join-Path $TargetRepository '.git'))) {
    throw "Target is not a git repository: $TargetRepository"
}
$targetItem = Get-Item -LiteralPath $TargetRepository -Force
if (-not $targetItem.PSIsContainer -or $targetItem.LinkType -or ($targetItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
    throw "Target repository must be a regular directory: $TargetRepository"
}
$TargetRepository = $targetItem.FullName
$gitRoot = ((git -C $TargetRepository rev-parse --show-toplevel 2>$null) | Out-String).Trim()
if ($LASTEXITCODE -ne 0 -or -not $gitRoot) { throw 'Target is not a Git repository root.' }
$gitRoot = (Get-Item -LiteralPath $gitRoot -Force).FullName
$gitPrefix = ((git -C $TargetRepository rev-parse --show-prefix 2>$null) | Out-String).Trim()
if ($LASTEXITCODE -ne 0 -or $gitPrefix) { throw 'Target must be the exact Git repository root.' }
$TargetRepository = $gitRoot

foreach ($relative in @('scripts/release-gitlab.sh', 'CHANGELOG.md', '.gitlab-ci.yml')) {
    $null = Get-HBManagedPath -Root $TargetRepository -RelativePath $relative -AllowMissingParent
}

Write-Host 'GitLab release automation'
Write-Host "Target: $TargetRepository"

$releaseScriptTarget = Join-Path $TargetRepository 'scripts/release-gitlab.sh'
if ($Force -or -not (Test-Path -LiteralPath $releaseScriptTarget)) {
    if ($PSCmdlet.ShouldProcess($releaseScriptTarget, 'Write release-gitlab.sh')) {
        $releaseContent = [IO.File]::ReadAllText((Join-Path $TemplatesDir 'release-gitlab.sh.tmpl'))
        Write-HBManagedTextAtomic -Root $TargetRepository -RelativePath 'scripts/release-gitlab.sh' -Content $releaseContent -CreateParent
        if (-not $IsWindows) {
            & chmod +x $releaseScriptTarget 2>$null | Out-Null
        }
        Write-Host '  OK: wrote scripts/release-gitlab.sh'
    }
} else {
    Write-Host '  INFO: scripts/release-gitlab.sh already present'
}

$changelogTarget = Join-Path $TargetRepository 'CHANGELOG.md'
if ($Force -or -not (Test-Path $changelogTarget)) {
    if ($PSCmdlet.ShouldProcess($changelogTarget, 'Write CHANGELOG.md')) {
        $changelogContent = [IO.File]::ReadAllText((Join-Path $TemplatesDir 'changelog-template.md'))
        Write-HBManagedTextAtomic -Root $TargetRepository -RelativePath 'CHANGELOG.md' -Content $changelogContent
        Write-Host '  OK: wrote CHANGELOG.md'
    }
} else {
    Write-Host '  INFO: CHANGELOG.md already present'
}

$ciFile = Join-Path $TargetRepository '.gitlab-ci.yml'
$jobTemplate = ([IO.File]::ReadAllText((Join-Path $TemplatesDir 'gitlab-release-job.yml.tmpl'))).TrimEnd()
if (-not (Test-Path $ciFile)) {
    if ($PSCmdlet.ShouldProcess($ciFile, 'Create .gitlab-ci.yml')) {
        Write-HBManagedTextAtomic -Root $TargetRepository -RelativePath '.gitlab-ci.yml' -Content "stages:`n  - release`n`n$jobTemplate`n"
        Write-Host '  OK: created .gitlab-ci.yml'
    }
} else {
    if ($PSCmdlet.ShouldProcess($ciFile, 'Ensure release stage')) {
        $content = Read-HBManagedText -Root $TargetRepository -RelativePath '.gitlab-ci.yml'
        $content = Get-ReleaseStageContent -Content $content
        if ($content -match 'home-baseline gitlab release automation') {
            Write-Host '  INFO: release job already present in .gitlab-ci.yml'
        } else {
            $suffix = if ($content.EndsWith([Environment]::NewLine)) { '' } else { [Environment]::NewLine }
            $content = $content + $suffix + [Environment]::NewLine + $jobTemplate + [Environment]::NewLine
            Write-Host '  OK: appended release job to .gitlab-ci.yml'
        }
        Write-HBManagedTextAtomic -Root $TargetRepository -RelativePath '.gitlab-ci.yml' -Content $content
    }
}

Enable-JobTokenPush -RepositoryPath $TargetRepository
Write-Host 'Done.'
