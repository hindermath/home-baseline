#Requires -Version 7
<#
.SYNOPSIS
    Aktualisiert Spec-Kit-Integrationen in Level-0/Level-1/Level-2-Repos.

.DESCRIPTION
    Findet dynamisch Spec-Kit-Repositories unter dem Home-Verzeichnis, fuehrt
    `specify init --here --force --integration <agent>` fuer die konfigurierten
    Integrationen aus, stellt lokale Governance-Templates wieder her, bewahrt
    `.specify/memory/constitution.md` und oeffnet `.opencode/command/*.md` fuer
    Git-Tracking, falls ein Whitelist-.gitignore diese Dateien blockiert.

    The script dynamically discovers Spec-Kit repositories below the home
    directory, refreshes all configured integrations, restores local governance
    templates, preserves `.specify/memory/constitution.md`, and allows
    `.opencode/command/*.md` to be tracked where whitelist .gitignore files
    would otherwise hide them.

.PARAMETER HomeDir
    Home-Verzeichnis, unter dem Repos gesucht werden. Standard: $HOME.

.PARAMETER TemplateSource
    Repository, dessen lokale Governance-Templates kanonisch sind. Standard:
    das Repository, aus dem dieses Skript laeuft; danach ~/home-baseline-tmp.

.PARAMETER Agents
    Spec-Kit-Integrationen. Standard: claude, opencode, gemini, copilot, codex.

.PARAMETER Commit
    Commitet Aenderungen pro geaendertem Repo.

.PARAMETER Push
    Pusht den aktuellen Branch pro Repo. Aktiviert automatisch -Commit.

.PARAMETER AllowDirty
    Erlaubt das Aktualisieren von Repos mit bestehenden lokalen Aenderungen.

.EXAMPLE
    pwsh scripts/update-spec-kit.ps1 -WhatIf

.EXAMPLE
    pwsh scripts/update-spec-kit.ps1 -Commit -Push
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$HomeDir = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE }),
    [string]$TemplateSource,
    [string[]]$Agents = @('claude', 'opencode', 'gemini', 'copilot', 'codex'),
    [switch]$Commit,
    [switch]$Push,
    [switch]$AllowDirty
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepositoryRoot = Split-Path -Parent $ScriptRoot

function Test-HBSpecKitRepo {
    param([Parameter(Mandatory)][string]$Path)
    return (Test-Path (Join-Path $Path '.git')) -and (Test-Path (Join-Path $Path '.specify'))
}

function Add-HBRepo {
    param(
        [System.Collections.Generic.List[string]]$Repos,
        [Parameter(Mandatory)][string]$Path
    )

    if (-not (Test-Path $Path)) { return }
    if (-not (Test-HBSpecKitRepo -Path $Path)) { return }
    if (-not $Repos.Contains($Path)) { $Repos.Add($Path) | Out-Null }
}

function Get-HBSpecKitRepos {
    param([Parameter(Mandatory)][string]$Root)

    $repos = [System.Collections.Generic.List[string]]::new()
    Add-HBRepo -Repos $repos -Path (Join-Path $Root 'home-baseline-tmp')

    Get-ChildItem -Path $Root -Directory -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -ne (Join-Path $Root 'home-baseline-tmp') } |
        ForEach-Object {
            Add-HBRepo -Repos $repos -Path $_.FullName
            if (Test-HBSpecKitRepo -Path $_.FullName) {
                Get-ChildItem -Path $_.FullName -Directory -ErrorAction SilentlyContinue |
                    ForEach-Object { Add-HBRepo -Repos $repos -Path $_.FullName }
            }
        }

    return $repos.ToArray()
}

function Select-HBTemplateSource {
    param(
        [Parameter(Mandatory)][string]$Root,
        [string]$Requested
    )

    if ($Requested) { return $Requested }

    if (Test-Path (Join-Path $RepositoryRoot '.specify/templates')) { return $RepositoryRoot }

    $level0 = Join-Path $Root 'home-baseline-tmp'
    if (Test-Path (Join-Path $level0 '.specify/templates')) { return $level0 }

    throw 'Keine Governance-Template-Quelle gefunden; nutze -TemplateSource PATH'
}

function Copy-HBGovernanceTemplatesToCache {
    param(
        [Parameter(Mandatory)][string]$SourceRepo,
        [Parameter(Mandatory)][string]$CacheDir
    )

    $sourceTemplates = Join-Path $SourceRepo '.specify/templates'
    foreach ($name in @('spec-template.md', 'plan-template.md', 'tasks-template.md')) {
        $src = Join-Path $sourceTemplates $name
        if (-not (Test-Path $src)) { throw "Template fehlt: $src" }
        Copy-Item $src (Join-Path $CacheDir $name) -Force
    }
}

function Invoke-HBSpecifyInit {
    param(
        [Parameter(Mandatory)][string]$Repo,
        [Parameter(Mandatory)][string]$Agent
    )

    if ($WhatIfPreference) {
        Write-Host "  [WhatIf] specify init --here --force --integration $Agent"
        return
    }

    Push-Location $Repo
    try {
        specify init --here --force --integration $Agent
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "--integration fehlgeschlagen fuer $Agent, versuche legacy --ai"
            specify init --here --force --ignore-agent-tools --ai $Agent
            if ($LASTEXITCODE -ne 0) {
                throw "specify init fehlgeschlagen fuer $Agent in $Repo"
            }
        }
    } finally {
        Pop-Location
    }
}

function Restore-HBGovernanceTemplates {
    param(
        [Parameter(Mandatory)][string]$Repo,
        [Parameter(Mandatory)][string]$CacheDir
    )

    foreach ($name in @('spec-template.md', 'plan-template.md', 'tasks-template.md')) {
        $src = Join-Path $CacheDir $name
        $dst = Join-Path $Repo ".specify/templates/$name"
        if ($WhatIfPreference) {
            Write-Host "  [WhatIf] Restore $name"
        } else {
            Copy-Item $src $dst -Force
        }
    }

    if (-not $WhatIfPreference) {
        Get-ChildItem -Path (Join-Path $Repo '.specify/templates') -Filter '*.md' -File |
            ForEach-Object {
                $text = Get-Content -Raw -Path $_.FullName
                $text = $text -replace '/speckit\.checklist', '/speckit-checklist'
                $text = $text -replace '/speckit\.plan', '/speckit-plan'
                $text = $text -replace '/speckit\.tasks', '/speckit-tasks'
                Set-Content -Path $_.FullName -Value $text -NoNewline
            }
    }
}

function Enable-HBOpenCodeCommandTracking {
    param([Parameter(Mandatory)][string]$Repo)

    $commandDir = Join-Path $Repo '.opencode/command'
    $gitignore = Join-Path $Repo '.gitignore'
    if (-not (Test-Path $commandDir) -or -not (Test-Path $gitignore)) { return }

    git -C $Repo check-ignore -q .opencode/command/speckit.plan.md 2>$null
    if ($LASTEXITCODE -ne 0) { return }

    if ($WhatIfPreference) {
        Write-Host '  [WhatIf] .gitignore fuer .opencode/command/*.md oeffnen'
        return
    }

    $content = Get-Content -Raw -Path $gitignore
    if ($content.Contains('!.opencode/command/*.md')) { return }

    Add-Content -Path $gitignore -Value @'

# opencode Spec-Kit Commands (nur commands/, NICHT root - root kann Cache enthalten)
!.opencode/
.opencode/*
!.opencode/command/
!.opencode/command/*.md
'@
}

function Repair-HBGeneratedWhitespace {
    param([Parameter(Mandatory)][string]$Repo)

    if ($WhatIfPreference) {
        Write-Host '  [WhatIf] generierte Spec-Kit-Dateien von trailing whitespace bereinigen'
        return
    }

    foreach ($rel in @('.opencode/command', '.claude/skills', '.agents/skills')) {
        $dir = Join-Path $Repo $rel
        if (Test-Path $dir) {
            Get-ChildItem -Path $dir -Filter '*.md' -File -Recurse |
                ForEach-Object {
                    $lines = Get-Content -Path $_.FullName
                    $lines = $lines | ForEach-Object { $_ -replace '[ \t]+$', '' }
                    Set-Content -Path $_.FullName -Value $lines
                }
        }
    }

    $settings = Join-Path $Repo '.vscode/settings.json'
    if (Test-Path $settings) {
        $text = (Get-Content -Raw -Path $settings) -replace "(\r?\n)+\z", "`n"
        Set-Content -Path $settings -Value $text -NoNewline
    }
}

function Invoke-HBRepoCommitAndPush {
    param([Parameter(Mandatory)][string]$Repo)

    if (-not $Commit -and -not $Push) { return }

    if ($WhatIfPreference) {
        if ($Commit) { Write-Host '  [WhatIf] git add -A && git commit' }
        if ($Push) { Write-Host '  [WhatIf] git push origin <branch>' }
        return
    }

    git -C $Repo add -A
    git -C $Repo diff --cached --check
    if ($LASTEXITCODE -ne 0) { throw "git diff --check fehlgeschlagen in $Repo" }

    git -C $Repo diff --cached --quiet
    if ($Commit -and $LASTEXITCODE -ne 0) {
        git -C $Repo commit -m 'chore: update spec-kit integrations'
    }

    if ($Push) {
        $branch = git -C $Repo branch --show-current
        if (-not $branch) { throw "Kein aktueller Branch in $Repo" }
        git -C $Repo push origin $branch
    }
}

function Invoke-HBSpecKitUpdate {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory)][string]$Repo,
        [Parameter(Mandatory)][string[]]$AgentList,
        [Parameter(Mandatory)][string]$TemplateCache
    )

    Write-Host "## $Repo"

    if (-not $WhatIfPreference -and -not $AllowDirty) {
        $status = git -C $Repo status --short
        if ($status) { throw "Repo hat lokale Aenderungen: $Repo" }
    }

    $constitution = Join-Path $Repo '.specify/memory/constitution.md'
    $constitutionBackup = $null
    if (-not $WhatIfPreference -and (Test-Path $constitution)) {
        $constitutionBackup = New-TemporaryFile
        Copy-Item $constitution $constitutionBackup -Force
    }

    foreach ($agent in $AgentList) {
        Invoke-HBSpecifyInit -Repo $Repo -Agent $agent
    }

    if ($constitutionBackup) {
        Copy-Item $constitutionBackup $constitution -Force
        Remove-Item $constitutionBackup -Force
    }

    Restore-HBGovernanceTemplates -Repo $Repo -CacheDir $TemplateCache
    Enable-HBOpenCodeCommandTracking -Repo $Repo
    Repair-HBGeneratedWhitespace -Repo $Repo
    Invoke-HBRepoCommitAndPush -Repo $Repo
}

if ($Push) { $Commit = $true }

if (-not $WhatIfPreference) {
    $specify = Get-Command specify -ErrorAction SilentlyContinue
    if (-not $specify) { throw 'specify nicht gefunden' }
}

$repos = Get-HBSpecKitRepos -Root $HomeDir
if (-not $repos) { throw "Keine Spec-Kit-Repos unter $HomeDir gefunden" }

$selectedTemplateSource = Select-HBTemplateSource -Root $HomeDir -Requested $TemplateSource
$templateCache = Join-Path ([System.IO.Path]::GetTempPath()) ("spec-kit-templates-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $templateCache -Force | Out-Null

try {
    Copy-HBGovernanceTemplatesToCache -SourceRepo $selectedTemplateSource -CacheDir $templateCache

    Write-Host 'Spec-Kit Update'
    Write-Host "  Home            : $HomeDir"
    Write-Host "  Template-Quelle : $selectedTemplateSource"
    Write-Host "  Agenten         : $($Agents -join ', ')"
    Write-Host "  Commit          : $Commit"
    Write-Host "  Push            : $Push"
    Write-Host "  WhatIf          : $WhatIfPreference"
    Write-Host ''

    foreach ($repo in $repos) {
        Invoke-HBSpecKitUpdate -Repo $repo -AgentList $Agents -TemplateCache $templateCache
    }

    Write-Host ''
    Write-Host 'Spec-Kit Update abgeschlossen.'
} finally {
    Remove-Item $templateCache -Recurse -Force -ErrorAction SilentlyContinue
}
