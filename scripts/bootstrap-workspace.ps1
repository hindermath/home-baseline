#Requires -Version 7
<#
.SYNOPSIS
    Richtet ein neues Projektverzeichnis als privates GitHub-Repo ein.
.DESCRIPTION
    Automatisiert: git init · .gitignore · Scripts kopieren · gh repo create · push · Hooks installieren

    Verwendung:
        pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName WebstormProjects
        pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName WebstormProjects -RepoName webstorm-baseline -Description "..."
        pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName WebstormProjects -WhatIf
.PARAMETER WorkspaceName
    Name des Projektverzeichnisses unterhalb des Home-Verzeichnisses.
.PARAMETER RepoName
    Name des GitHub-Repositories. Standard: <workspacename-lowercased>-baseline
.PARAMETER Description
    Beschreibung für das GitHub-Repository.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [switch] $Teardown,
    [string] $WorkspaceName = '',
    [string] $RepoName      = '',
    [string] $Description   = '',
    [switch] $Backup,
    [switch] $KeepRemote,
    [switch] $Recursive,
    [switch] $Force,
    [switch] $Yes
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($Teardown) {
    if (-not $WorkspaceName) {
        throw "Fehler: -WorkspaceName ist für -Teardown erforderlich / Error: -WorkspaceName is required for -Teardown"
    }

    $teardownPath = Join-Path $PSScriptRoot 'teardown-workspace.ps1'
    & pwsh -NoProfile -File $teardownPath `
        -WorkspaceName $WorkspaceName `
        -Backup:$Backup `
        -KeepRemote:$KeepRemote `
        -Recursive:$Recursive `
        -Force:$Force `
        -Yes:$Yes `
        -WhatIf:$WhatIfPreference
    exit $LASTEXITCODE
}

if (-not $WorkspaceName) {
    throw "Fehler: -WorkspaceName ist erforderlich / Error: -WorkspaceName is required"
}

function ConvertTo-NormalizedName([string]$Name) {
    $Name.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-|-$', ''
}

$homeDir       = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })
$workspaceDir  = Join-Path $homeDir $WorkspaceName
$scriptsSource = Join-Path $homeDir 'scripts'

# GitHub-Benutzername dynamisch ermitteln
$ghUser = (gh api user --jq '.login' 2>$null).Trim()
if (-not $ghUser) {
    Write-Error "Konnte GitHub-Benutzername nicht ermitteln. Bitte 'gh auth login' ausführen."
}

if (-not $RepoName) {
    $RepoName = ($WorkspaceName -replace 'Projects$', '-baseline' -replace ' ', '-').ToLower()
}
if (-not $Description) {
    $Description = "Gemeinsame Workspace-Konfiguration für $WorkspaceName"
}

# --- Vorabprüfungen ------------------------------------------------------------

if (-not (Test-Path $workspaceDir -PathType Container)) {
    Write-Error "Verzeichnis '$workspaceDir' existiert nicht."
}
if (Test-Path (Join-Path $workspaceDir '.git') -PathType Container) {
    Write-Error "'$workspaceDir' ist bereits ein Git-Repository."
}
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
    Write-Error "gh (GitHub CLI) ist nicht installiert."
}

# --- Zusammenfassung -----------------------------------------------------------

Write-Host ''
Write-Host '╔══════════════════════════════════════════════════════════════════╗' -ForegroundColor Cyan
Write-Host '║  bootstrap-workspace – Neue Workspace-Einrichtung               ║' -ForegroundColor Cyan
Write-Host '╠══════════════════════════════════════════════════════════════════╣' -ForegroundColor Cyan
Write-Host "║  Verzeichnis : $($workspaceDir.PadRight(51))║" -ForegroundColor Cyan
Write-Host "║  GitHub-Repo : $("$ghUser/$RepoName (privat)".PadRight(51))║" -ForegroundColor Cyan
Write-Host '╚══════════════════════════════════════════════════════════════════╝' -ForegroundColor Cyan
Write-Host ''

# --- Sub-Repos ermitteln -------------------------------------------------------

Write-Host '→ Suche bestehende Sub-Repositories …'
$subRepos = Get-ChildItem -Path $workspaceDir -Directory -Recurse -Depth 1 |
    Where-Object { Test-Path (Join-Path $_.FullName '.git') -PathType Container } |
    Select-Object -ExpandProperty Name
$subRepos | ForEach-Object { Write-Host "    Gefunden: $_/" }

# --- .gitignore erstellen ------------------------------------------------------

Write-Host '→ Erstelle .gitignore …'
$gitignorePath = Join-Path $workspaceDir '.gitignore'
if ($PSCmdlet.ShouldProcess($gitignorePath, '.gitignore erstellen')) {
    $lines  = @('# Sub-Verzeichnisse mit eigenen Git-Repositories (automatisch erkannt)')
    $lines += $subRepos | ForEach-Object { "$_/" }
    $lines += @(
        '',
        '# macOS',
        '.DS_Store',
        '.AppleDouble',
        '.LSOverride',
        '',
        '# JetBrains IDEs',
        '.idea/',
        '*.iws',
        '*.iml',
        '',
        '# VS Code (lokale Einstellungen)',
        '.vscode/c_cpp_properties.json',
        '.vscode/settings.json',
        '',
        '# Build-Artefakte',
        'bin/',
        'obj/',
        'build/',
        'node_modules/'
    )
    $lines | Set-Content -Path $gitignorePath -Encoding UTF8
    Write-Host '    OK  .gitignore erstellt' -ForegroundColor Green
}

# --- Scripts kopieren ----------------------------------------------------------

Write-Host '→ Kopiere Scripts …'
$targetScripts = Join-Path $workspaceDir 'scripts'
$targetHooks   = Join-Path $targetScripts 'hooks'

if ($PSCmdlet.ShouldProcess($targetScripts, 'Scripts kopieren')) {
    New-Item -ItemType Directory -Path $targetScripts -Force | Out-Null
    New-Item -ItemType Directory -Path $targetHooks   -Force | Out-Null
    $filesToCopy = @(
        'scan-agent-secrets.sh',
        'scan-agent-secrets.ps1',
        'install-hooks.sh',
        'install-hooks.ps1'
    )
    foreach ($file in $filesToCopy) {
        Copy-Item (Join-Path $scriptsSource $file) $targetScripts -Force
    }
    Copy-Item (Join-Path $scriptsSource 'hooks' 'pre-push') $targetHooks -Force
    if ($IsLinux -or $IsMacOS) {
        Get-ChildItem $targetScripts -Filter '*.sh' | ForEach-Object { & chmod +x $_.FullName }
        & chmod +x (Join-Path $targetHooks 'pre-push')
    }
    Write-Host '    OK  Scripts kopiert' -ForegroundColor Green
}

# --- git init + commit ---------------------------------------------------------

Write-Host '→ Initialisiere Git-Repository …'
if ($PSCmdlet.ShouldProcess($workspaceDir, 'git init + commit')) {
    & git -C $workspaceDir init
    & git -C $workspaceDir add .gitignore scripts/
    $commitMsg = @"
chore: initiale Baseline-Konfiguration für $WorkspaceName

- .gitignore        – schließt Sub-Repos und Artefakte aus
- scripts/          – Secret-Scan, Hook-Installation (Bash + PowerShell)

Nach dem Clonen auf neuem Gerät:
  bash scripts/install-hooks.sh       (macOS/Linux)
  pwsh scripts/install-hooks.ps1      (Windows)

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
"@
    & git -C $workspaceDir commit -m $commitMsg
    Write-Host '    OK  Initialer Commit erstellt' -ForegroundColor Green
}

# --- GitHub-Repo erstellen und pushen ------------------------------------------

Write-Host "→ Erstelle privates GitHub-Repository '$RepoName' …"
if ($PSCmdlet.ShouldProcess("github.com/$ghUser/$RepoName", 'gh repo create')) {
    & gh repo create $RepoName --private --description $Description `
        --source $workspaceDir --remote origin --push
    Write-Host '    OK  GitHub-Repo erstellt und gepusht' -ForegroundColor Green
}

# --- Hooks installieren --------------------------------------------------------

Write-Host '→ Installiere Git-Hooks …'
if ($PSCmdlet.ShouldProcess($workspaceDir, 'Hooks installieren')) {
    pwsh (Join-Path $targetScripts 'install-hooks.ps1')
    Write-Host '    OK  Hooks installiert' -ForegroundColor Green
}

# --- ~/README.md aktualisieren ------------------------------------------------

$homeReadme = Join-Path $homeDir 'README.md'
$newRow = "| ``~/$WorkspaceName/`` | [$RepoName](https://github.com/$ghUser/$RepoName) | ``bootstrap-workspace`` |"

if (Test-Path $homeReadme) {
    Write-Host '→ Aktualisiere ~/README.md …'
    $content = Get-Content $homeReadme -Raw
    if ($content -match "~/$WorkspaceName/") {
        Write-Host "    Eintrag für '$WorkspaceName' bereits vorhanden – übersprungen." -ForegroundColor Yellow
    } elseif ($PSCmdlet.ShouldProcess($homeReadme, 'Workspace-Tabelle aktualisieren')) {
        $updated = $content -replace '<!-- workspace-table-end -->', "$newRow`n<!-- workspace-table-end -->"
        Set-Content -Path $homeReadme -Value $updated -Encoding UTF8 -NoNewline
        Write-Host '    OK  ~/README.md aktualisiert' -ForegroundColor Green
    }
}

# --- home-baseline committen und pushen ----------------------------------------

$homeGit = Join-Path $homeDir '.git'
if (Test-Path $homeGit -PathType Container) {
    Write-Host '→ Committe Änderungen in home-baseline …'
    if ($PSCmdlet.ShouldProcess('home-baseline', 'commit + push')) {
        & git -C $homeDir add README.md
        $msg = @"
chore: $WorkspaceName in Workspace-Übersicht eingetragen

Automatisch durch bootstrap-workspace.ps1 hinzugefügt.

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
"@
        & git -C $homeDir commit -m $msg
        & git -C $homeDir push
        Write-Host '    OK  home-baseline aktualisiert und gepusht' -ForegroundColor Green
    }
}



# --- Git Scope-Isolierung -------------------------------------------------------

Write-Host '→ Git Scope-Isolierung / Git Scope Isolation:'
$normalizedName = ConvertTo-NormalizedName $WorkspaceName
$gitconfigD = Join-Path $homeDir '.gitconfig.d'
$gitconfig  = Join-Path $homeDir '.gitconfig'

if (Test-Path $gitconfigD) {
    # core.autocrlf im lokalen .git/config setzen (Windows: true; macOS/Linux über .sh-Pendant)
    if ($PSCmdlet.ShouldProcess($workspaceDir, 'git config --local core.autocrlf')) {
        $autocrlf = if ($IsWindows) { 'true' } else { 'input' }
        & git -C $workspaceDir config --local core.autocrlf $autocrlf
    }

    # Idempotenz-Prüfung: includeIf-Block bereits vorhanden?
    $includeIfPattern = "gitdir:~/$WorkspaceName/"
    $alreadyPresent = (Get-Content $gitconfig -ErrorAction SilentlyContinue) |
        Select-String -SimpleMatch $includeIfPattern -Quiet

    if (-not $alreadyPresent) {
        if ($PSCmdlet.ShouldProcess($gitconfig, "includeIf für $WorkspaceName hinzufügen")) {
            $incRelPath = "~/.gitconfig.d/$normalizedName.inc"
            $block = "`n[includeIf `"gitdir:~/$WorkspaceName/`"]`n`tpath = $incRelPath"
            Add-Content -Path $gitconfig -Value $block -Encoding UTF8
        }
        Write-Host "  ✓ includeIf für $WorkspaceName / includeIf for $WorkspaceName eingetragen"
    } else {
        Write-Host "  → includeIf für $WorkspaceName bereits vorhanden — übersprungen / already present — skipped"
    }

    # .inc-Placeholder erstellen wenn nicht vorhanden
    $incFile = Join-Path $gitconfigD "$normalizedName.inc"
    if (-not (Test-Path $incFile)) {
        if ($PSCmdlet.ShouldProcess($incFile, '.inc Placeholder erstellen')) {
            @(
                "# $WorkspaceName workspace git configuration",
                '# [user]',
                '#   email = work@example.com'
            ) | Set-Content -Path $incFile -Encoding UTF8
        }
        Write-Host "  ✓ ~/.gitconfig.d/$normalizedName.inc erstellt / created"
    } else {
        Write-Host "  → ~/.gitconfig.d/$normalizedName.inc bereits vorhanden — übersprungen / already exists — skipped"
    }
} else {
    Write-Host "  → ~/.gitconfig.d/ nicht vorhanden — Scope-Isolierung übersprungen / not found — skipping scope isolation"
}

Write-Host ''
Write-Host '╔══════════════════════════════════════════════════════════════════╗' -ForegroundColor Green
Write-Host '║  Einrichtung abgeschlossen!                                      ║' -ForegroundColor Green
Write-Host '╚══════════════════════════════════════════════════════════════════╝' -ForegroundColor Green
Write-Host ''
Write-Host "  Repo  : https://github.com/$ghUser/$RepoName"
Write-Host "  Clone : git clone https://github.com/$ghUser/$RepoName.git ~/$WorkspaceName"
Write-Host "  Hooks : bash scripts/install-hooks.sh  (oder pwsh scripts/install-hooks.ps1)"
Write-Host ''
