#Requires -Version 7
# migrate-workspace.ps1 — Workspace Homogeneity Migration v1.0 (PowerShell)
# FR-REV-A01–A06; Contract: migrate-workspace-cli.md
#
# Usage: pwsh scripts/migrate-workspace.ps1 [-WorkspaceName <string>] [-WhatIf] [-Force]
# Exit codes: 0=success, 1=partial fail, 2=critical error
[CmdletBinding(SupportsShouldProcess)]
param(
    [string]$WorkspaceName = '',
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptDir    = Split-Path -Parent $MyInvocation.MyCommand.Path
$TemplatesDir = Join-Path $ScriptDir 'templates'
$HomeDir      = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })
$WorkspaceGitignoreHeader = '# Sub-Verzeichnisse mit eigenen Git-Repositories (automatisch erkannt)'

# ─── Prerequisites ────────────────────────────────────────────────────────────

foreach ($tmpl in @('a11y-section.md', 'speckit-workflow-section.md', 'azubis-section.md')) {
    if (-not (Test-Path (Join-Path $TemplatesDir $tmpl))) {
        Write-Error "ERROR: template not found: scripts/templates/$tmpl"
        exit 1
    }
}

$constitutionFile = Join-Path $HomeDir 'constitution.md'
$constitutionVersion = 'v1.0.0'
if (Test-Path $constitutionFile) {
    $vLine = Get-Content $constitutionFile | Where-Object { $_ -match '^# Constitution v' } | Select-Object -First 1
    if ($vLine -match 'v[\d.]+') { $constitutionVersion = $Matches[0] }
}

# ─── homogeneity-check.yml ────────────────────────────────────────────────────

$WorkflowYml = @'
name: Homogeneity Check

on:
  push:
  pull_request:

jobs:
  check:
    name: Agent Secret Scan (${{ matrix.os }})
    runs-on: ${{ matrix.os }}
    timeout-minutes: 10

    strategy:
      matrix:
        os: [ubuntu-22.04, macos-15, windows-2022]

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Install ripgrep (Ubuntu)
        if: runner.os == 'Linux'
        run: |
          sudo apt-get update
          sudo apt-get install -y ripgrep

      - name: Install ripgrep (macOS)
        if: runner.os == 'macOS'
        run: brew install ripgrep

      - name: Install ripgrep (Windows)
        if: runner.os == 'Windows'
        run: choco install ripgrep -y

      - name: Run Agent Secret Scan (Bash)
        if: runner.os != 'Windows'
        run: bash scripts/scan-agent-secrets.sh --fail-on-high .

      - name: Run Agent Secret Scan (Bash on Windows)
        if: runner.os == 'Windows'
        shell: bash
        run: bash scripts/scan-agent-secrets.sh --fail-on-high .
'@

function Test-LegacyWorkflowYml {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        return $false
    }
    $content = Get-Content $Path -Raw
    return $content -match 'scripts/check-homogeneity\.(sh|ps1)|-WorkspaceName'
}

function Write-WorkflowYml {
    param([string]$TargetDir)
    $ymlFile = Join-Path $TargetDir '.github/workflows/homogeneity-check.yml'
    $workflowAction = 'CREATED'
    if (Test-Path $ymlFile) {
        if (-not (Test-LegacyWorkflowYml -Path $ymlFile)) {
            Write-Host "  INFO: homogeneity-check.yml already present — skip"
            return $false
        }
        $workflowAction = 'UPDATED'
        if ($WhatIfPreference) {
            Write-Host "  WOULD UPDATE: $($ymlFile -replace [regex]::Escape($HomeDir), '~')"
            return $true
        }
    }
    if ($WhatIfPreference) {
        Write-Host "  WOULD CREATE: $($ymlFile -replace [regex]::Escape($HomeDir), '~')"
        return $true
    }
    $dir = Split-Path $ymlFile -Parent
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
    $WorkflowYml | Set-Content -Path $ymlFile
    Write-Host "  $workflowAction`: $($ymlFile -replace [regex]::Escape($HomeDir), '~')"
    return $true
}

function Write-Editorconfig {
    param([string]$TargetDir)
    $ecFile = Join-Path $TargetDir '.editorconfig'
    if (Test-Path $ecFile) {
        Write-Host "  INFO: .editorconfig already present — skip"
        return $false
    }
    $slnFiles = @(Get-ChildItem -Path $TargetDir -Filter '*.sln' -Depth 0 -ErrorAction SilentlyContinue)
    if ($slnFiles.Count -eq 0) { return $false }
    if ($WhatIfPreference) {
        Write-Host "  WOULD CREATE: $($ecFile -replace [regex]::Escape($HomeDir), '~')"
        return $true
    }
    @"
root = true

[*]
charset = utf-8
end_of_line = crlf
indent_style = space
indent_size = 4
trim_trailing_whitespace = true
insert_final_newline = true

[*.cs]
indent_size = 4

[*.md]
trim_trailing_whitespace = false
indent_size = 2

[*.{yml,yaml,json}]
indent_size = 2
"@ | Set-Content -Path $ecFile
    Write-Host "  CREATED: $($ecFile -replace [regex]::Escape($HomeDir), '~')"
    return $true
}

function Set-DefaultWorkspaceGitignore {
    param(
        [string]$Path,
        [string[]]$ProjectNames
    )

    $lines = [System.Collections.Generic.List[string]]::new()
    $lines.Add($script:WorkspaceGitignoreHeader)
    foreach ($name in $ProjectNames) {
        $lines.Add("$name/")
    }
    $lines.Add('')
    $lines.AddRange(@(
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
    ))
    $lines | Set-Content -Path $Path -Encoding UTF8
}

function Update-WorkspaceGitignoreEntry {
    param(
        [string]$WorkspaceDir,
        [string]$ProjectName
    )

    $gitignorePath = Join-Path $WorkspaceDir '.gitignore'
    $entry = "$ProjectName/"

    if (-not $ProjectName) {
        return 'Unchanged'
    }

    if (-not (Test-Path $gitignorePath)) {
        if ($WhatIfPreference) {
            return 'WouldCreate'
        }
        Set-DefaultWorkspaceGitignore -Path $gitignorePath -ProjectNames @($ProjectName)
        return 'Created'
    }

    $lines = Get-Content $gitignorePath
    if ($lines -contains $entry) {
        return 'Unchanged'
    }

    if ($WhatIfPreference) {
        return 'WouldUpdate'
    }

    $updated = [System.Collections.Generic.List[string]]::new()
    $headerIndex = [Array]::IndexOf($lines, $script:WorkspaceGitignoreHeader)
    if ($headerIndex -ge 0) {
        $insertIndex = $lines.Length
        for ($i = $headerIndex + 1; $i -lt $lines.Length; $i++) {
            if ($lines[$i] -eq '') {
                $insertIndex = $i
                break
            }
        }
        for ($i = 0; $i -lt $lines.Length; $i++) {
            if ($i -eq $insertIndex) {
                $updated.Add($entry)
            }
            $updated.Add($lines[$i])
        }
        if ($insertIndex -eq $lines.Length) {
            $updated.Add($entry)
        }
    } else {
        $updated.Add($script:WorkspaceGitignoreHeader)
        $updated.Add($entry)
        $updated.Add('')
        $updated.AddRange($lines)
    }

    $updated | Set-Content -Path $gitignorePath -Encoding UTF8
    return 'Updated'
}

function Test-EnGuidance {
    param([string]$File)
    if (-not (Test-Path $File)) { return $false }
    $content = Get-Content $File -Raw -ErrorAction SilentlyContinue
    if ($content -match '<!-- EN:') { return $true }
    if ($content -match '(?im)^#{1,6}\s+.+\s+/\s+.*(Shared|Environment|Registry|Security|Secure|Architecture|Documentation|Standards|Workflow|Maintenance|Notes|Description|Accessibility|For Apprentices|Spec[- ]Kit|Governance|Guidelines|Instructions|tooling)') {
        return $true
    }
    if (($content -match '(?i)(Gemeinsame|Barrierefreiheit|Sichere|Sicherheits|Umgebungsregister|Hinweise|Beschreibung|deutsch)') -and
        ($content -match '(?i)(Shared|Accessibility|Secure|Security|Environment|Notes|Description|English|englisch)')) {
        return $true
    }
    return $false
}

function Add-EnPlaceholder {
    param([string]$File, [string]$Label)
    if (-not (Test-Path $File)) { return $false }
    if (Test-EnGuidance -File $File) {
        Write-Host "  INFO: EN guidance already present — skip ($($File -replace [regex]::Escape($HomeDir), '~'))"
        return $false
    }
    if ($WhatIfPreference) {
        Write-Host "  WOULD APPEND: EN placeholder to $($File -replace [regex]::Escape($HomeDir), '~')"
        return $true
    }
    $placeholder = "`n<!-- EN: $Label placeholder`n[DE-Zusammenfassung: Inhalt dieser Datei auf Deutsch]`n-->"
    Add-Content -Path $File -Value $placeholder
    Write-Host "  APPENDED: EN placeholder to $($File -replace [regex]::Escape($HomeDir), '~')"
    return $true
}

function Add-ReadmeSection {
    param([string]$Readme, [string]$SectionFile, [string]$HeadingPattern)
    if (-not (Test-Path $Readme)) { return $false }
    $content = Get-Content $Readme -Raw -ErrorAction SilentlyContinue
    if ($content -match "(?im)$HeadingPattern") {
        Write-Host "  INFO: section already present — skip ($(Split-Path $SectionFile -Leaf) in $(Split-Path $Readme -Leaf))"
        return $false
    }
    if ($WhatIfPreference) {
        Write-Host "  WOULD APPEND: $(Split-Path $SectionFile -Leaf) to $($Readme -replace [regex]::Escape($HomeDir), '~')"
        return $true
    }
    Add-Content -Path $Readme -Value "`n"
    Get-Content $SectionFile | Add-Content -Path $Readme
    Write-Host "  APPENDED: $(Split-Path $SectionFile -Leaf) to $($Readme -replace [regex]::Escape($HomeDir), '~')"
    return $true
}

function Install-HookIfNeeded {
    param([string]$TargetDir)
    $hookSrc = Join-Path $HomeDir 'scripts/hooks/pre-push'
    $hookDst = Join-Path $TargetDir '.git/hooks/pre-push'
    if (-not (Test-Path (Join-Path $TargetDir '.git'))) { return $false }
    if (-not (Test-Path $hookSrc)) { return $false }
    if (Test-Path $hookDst) {
        Write-Host "  INFO: pre-push hook already installed — skip ($($TargetDir -replace [regex]::Escape($HomeDir), '~'))"
        return $false
    }
    if ($WhatIfPreference) {
        Write-Host "  WOULD INSTALL: pre-push hook in $($TargetDir -replace [regex]::Escape($HomeDir), '~')"
        return $true
    }
    $hooksDir = Join-Path $TargetDir '.git/hooks'
    New-Item -ItemType Directory -Path $hooksDir -Force | Out-Null
    Copy-Item $hookSrc $hookDst
    Write-Host "  INSTALLED: pre-push hook in $($TargetDir -replace [regex]::Escape($HomeDir), '~')"
    return $true
}

# ─── Migrate Single Workspace ────────────────────────────────────────────────

$PartialFail = $false

function Assert-SafeCleanRepository {
    param([string]$RepositoryDir, [string]$Label, [string[]]$AllowedUntrackedDirectories = @())

    $repoItem = Get-Item -LiteralPath $RepositoryDir -Force
    $gitPath = Join-Path $RepositoryDir '.git'
    $gitItem = Get-Item -LiteralPath $gitPath -Force
    if (($repoItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -or
        -not $repoItem.PSIsContainer -or
        ($gitItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -or
        -not $gitItem.PSIsContainer) {
        throw "$Label ist kein reguläres Git-Repository: $RepositoryDir"
    }
    $filterConfig = @(& git -C $RepositoryDir config --local --includes --get-regexp '^filter\..*\.(clean|process|required)$' 2>$null)
    $filterExit = $LASTEXITCODE
    if ($filterExit -eq 0) { throw "$Label enthält einen repository-gesteuerten Git-Filter: $RepositoryDir" }
    if ($filterExit -ne 1) { throw "Git-Filterkonfiguration für $Label konnte nicht geprüft werden: $RepositoryDir" }
    $configuredFsMonitor = @(& git -C $RepositoryDir config --local --includes --get core.fsmonitor 2>$null)
    $fsMonitorExit = $LASTEXITCODE
    if ($fsMonitorExit -notin @(0, 1)) { throw "FSMonitor-Konfiguration für $Label konnte nicht geprüft werden: $RepositoryDir" }
    if ($fsMonitorExit -eq 0 -and $configuredFsMonitor -and $configuredFsMonitor[0] -ne 'false') {
        throw "$Label enthält einen repository-gesteuerten FSMonitor-Hook: $RepositoryDir"
    }
    $gitPrefix = $gitPath.TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar
    $linkedItem = Get-ChildItem -LiteralPath $RepositoryDir -Force -Recurse -ErrorAction Stop |
        Where-Object {
            -not $_.FullName.StartsWith($gitPrefix, [StringComparison]::OrdinalIgnoreCase) -and
            ($_.Attributes -band [IO.FileAttributes]::ReparsePoint)
        } | Select-Object -First 1
    if ($linkedItem) { throw "$Label enthält einen symbolischen Link oder Reparse Point: $($linkedItem.FullName)" }

    $status = @(& git -C $RepositoryDir -c core.fsmonitor=false -c core.quotePath=false status --porcelain=v1 --untracked-files=normal 2>$null)
    if ($LASTEXITCODE -ne 0) { throw "Git-Status für $Label konnte nicht geprüft werden: $RepositoryDir" }
    $allowedStatus = @($AllowedUntrackedDirectories | ForEach-Object { "?? $_/" })
    $unexpectedStatus = @($status | Where-Object { $_ -and $_ -notin $allowedStatus })
    if ($unexpectedStatus.Count -gt 0) { throw "$Label enthält bereits Änderungen oder ungetrackte Dateien: $RepositoryDir" }
}

function Invoke-OwnedPathsCommit {
    param([string]$RepositoryDir, [string]$Message, [string[]]$OwnedPaths)

    $stagePaths = @($OwnedPaths | Where-Object {
        if (Test-Path -LiteralPath (Join-Path $RepositoryDir $_)) { return $true }
        & git -C $RepositoryDir ls-files --error-unmatch -- $_ 2>$null | Out-Null
        return $LASTEXITCODE -eq 0
    })
    if ($stagePaths.Count -eq 0) { return $false }
    & git -C $RepositoryDir -c core.fsmonitor=false add -A -- @stagePaths
    if ($LASTEXITCODE -ne 0) { throw "Verwaltete Pfade konnten nicht gestagt werden: $RepositoryDir" }
    $cachedPaths = @(& git -C $RepositoryDir -c core.fsmonitor=false diff --cached --name-only --diff-filter=ACDMRTUXB)
    if ($LASTEXITCODE -ne 0) { throw "Git-Index konnte nicht geprüft werden: $RepositoryDir" }
    foreach ($cachedPath in $cachedPaths) {
        if ($cachedPath -notin $OwnedPaths) { throw "Unerwarteter Pfad im Git-Index: $cachedPath" }
    }
    if ($cachedPaths.Count -eq 0) { return $false }
    & git -C $RepositoryDir -c core.fsmonitor=false -c core.hooksPath=/dev/null commit -m $Message 2>$null | Out-Null
    if ($LASTEXITCODE -ne 0) { throw "Commit fehlgeschlagen: $RepositoryDir" }
    return $true
}

function Migrate-Workspace {
    param([string]$WsDir)
    $wsName = Split-Path $WsDir -Leaf
    $projectDirs = @(Get-ChildItem -LiteralPath $WsDir -Directory -Force -ErrorAction Stop |
        Where-Object { Test-Path -LiteralPath (Join-Path $_.FullName '.git') } |
        Sort-Object Name | ForEach-Object { $_.FullName })
    $projectNames = @($projectDirs | ForEach-Object { Split-Path $_ -Leaf })
    Assert-SafeCleanRepository -RepositoryDir $WsDir -Label 'Level-1-Workspace' -AllowedUntrackedDirectories $projectNames
    foreach ($projectDir in $projectDirs) {
        Assert-SafeCleanRepository -RepositoryDir $projectDir -Label 'Level-2-Projekt'
    }
    Write-Host "Migriere: $($WsDir -replace [regex]::Escape($HomeDir), '~')"

    $changed = $false

    foreach ($agentFile in @('AGENTS.md','CLAUDE.md','GEMINI.md','constitution.md')) {
        $fullPath = Join-Path $WsDir $agentFile
        if (Test-Path $fullPath) {
            if (Add-EnPlaceholder -File $fullPath -Label $agentFile) { $changed = $true }
        }
    }

    $copilotFile = Join-Path $WsDir '.github/copilot-instructions.md'
    if (Test-Path $copilotFile) {
        if (Add-EnPlaceholder -File $copilotFile -Label 'copilot-instructions.md') { $changed = $true }
    }

    $readme = Join-Path $WsDir 'README.md'
    if (Add-ReadmeSection -Readme $readme -SectionFile (Join-Path $TemplatesDir 'a11y-section.md') -HeadingPattern '^## .*Barrierefreiheit') { $changed = $true }
    if (Add-ReadmeSection -Readme $readme -SectionFile (Join-Path $TemplatesDir 'speckit-workflow-section.md') -HeadingPattern '^## .*Spec-kit') { $changed = $true }
    if (Add-ReadmeSection -Readme $readme -SectionFile (Join-Path $TemplatesDir 'azubis-section.md') -HeadingPattern '^## .*Azubis') { $changed = $true }

    if (Write-WorkflowYml -TargetDir $WsDir) { $changed = $true }

    # Level-2 projects
    foreach ($projDir in $projectDirs) {
        $projName = Split-Path $projDir -Leaf
        Write-Host "  Level-2: $projName/"
        $workspaceGitignoreState = Update-WorkspaceGitignoreEntry -WorkspaceDir $WsDir -ProjectName $projName
        switch ($workspaceGitignoreState) {
            'Created'     { Write-Host "  CREATED: $($WsDir -replace [regex]::Escape($HomeDir), '~')/.gitignore (+ $projName/)"; $changed = $true }
            'Updated'     { Write-Host "  UPDATED: $($WsDir -replace [regex]::Escape($HomeDir), '~')/.gitignore (+ $projName/)"; $changed = $true }
            'WouldCreate' { Write-Host "  WOULD CREATE: $($WsDir -replace [regex]::Escape($HomeDir), '~')/.gitignore (+ $projName/)"; $changed = $true }
            'WouldUpdate' { Write-Host "  WOULD UPDATE: $($WsDir -replace [regex]::Escape($HomeDir), '~')/.gitignore (+ $projName/)"; $changed = $true }
            default       { Write-Host "  INFO: workspace .gitignore already lists $projName/ — skip" }
        }
        if (Write-WorkflowYml -TargetDir $projDir) { $changed = $true }
        if (Write-Editorconfig -TargetDir $projDir) { $changed = $true }
        if (Install-HookIfNeeded -TargetDir $projDir) { $changed = $true }
        if (-not $WhatIfPreference) {
            $projStatus = @(& git -C $projDir -c core.fsmonitor=false status --porcelain=v1 --untracked-files=all 2>$null)
            if ($LASTEXITCODE -ne 0) { throw "Git-Status konnte nicht geprüft werden: $projDir" }
            if ($projStatus.Count -gt 0) {
                $projMessage = "chore: migrate $projName to homogeneity baseline $constitutionVersion`n`nCo-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
                $null = Invoke-OwnedPathsCommit -RepositoryDir $projDir -Message $projMessage -OwnedPaths @(
                    'constitution.md', 'README.md', 'AGENTS.md', 'CLAUDE.md', 'GEMINI.md',
                    '.github/copilot-instructions.md', '.github/workflows/homogeneity-check.yml', '.editorconfig'
                )
                Write-Host "    COMMITTED: migrate $projName"
            }
        }
    }

    if (-not $changed) {
        Write-Host "  INFO: already compliant — nothing to do"
        return
    }

    if ($WhatIfPreference) {
        Write-Host "  [WhatIf: no changes written]"
        return
    }

    # Git commit
    $status = & git -C $WsDir -c core.fsmonitor=false status --porcelain 2>$null
    if ($status) {
        $message = "chore: migrate $wsName to homogeneity baseline $constitutionVersion`n`nCo-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
        $null = Invoke-OwnedPathsCommit -RepositoryDir $WsDir -Message $message -OwnedPaths @(
            'AGENTS.md', 'CLAUDE.md', 'GEMINI.md', 'constitution.md', 'README.md', '.gitignore',
            '.github/copilot-instructions.md', '.github/workflows/homogeneity-check.yml'
        )
        Write-Host "  COMMITTED: migrate $wsName to homogeneity baseline $constitutionVersion"
    }

    Write-Host ""
}

# ─── Build Workspace List ─────────────────────────────────────────────────────

$workspaces = @()
if ($WorkspaceName) {
    $wsDir = Join-Path $HomeDir $WorkspaceName
    if (-not (Test-Path $wsDir)) {
        Write-Error "ERROR: Workspace nicht gefunden: $wsDir"
        exit 2
    }
    $workspaces = @($wsDir)
} else {
    $workspaces = Get-ChildItem -Path $HomeDir -Directory -ErrorAction SilentlyContinue |
        Where-Object { Test-Path (Join-Path $_.FullName '.git') } |
        Sort-Object Name |
        ForEach-Object { $_.FullName }
}

if ($workspaces.Count -eq 0) {
    Write-Host "Keine Level-1-Workspaces gefunden."
    exit 0
}

# ─── Preview ─────────────────────────────────────────────────────────────────

Write-Host "Workspace Homogeneity Migration"
Write-Host "Constitution: $constitutionVersion"
Write-Host ('=' * 50)
Write-Host ""
Write-Host "Betroffene Workspaces / Affected workspaces:"
foreach ($ws in $workspaces) {
    Write-Host "  -> $($ws -replace [regex]::Escape($HomeDir), '~')"
}
Write-Host ""

if ($WhatIfPreference) {
    Write-Host "[WhatIf] Vorschau / Preview:"
    foreach ($ws in $workspaces) { Migrate-Workspace -WsDir $ws }
    exit 0
}

# ─── Prompt ──────────────────────────────────────────────────────────────────

if (-not $Force) {
    $answer = Read-Host "Proceed? [y/N]"
    if ($answer -notmatch '^[jJyY]') {
        Write-Host "Abgebrochen."
        exit 0
    }
}

# ─── Execute Migration ────────────────────────────────────────────────────────

foreach ($ws in $workspaces) {
    try {
        Migrate-Workspace -WsDir $ws
    } catch {
        Write-Warning "Migration fehlgeschlagen für $ws`: $_"
        $PartialFail = $true
    }
}

# ─── Post-Migration: init-stats ───────────────────────────────────────────────

$initStatsScript = Join-Path $ScriptDir 'init-stats.ps1'
if (-not $PartialFail -and (Test-Path $initStatsScript)) {
    Write-Host "Starte init-stats.ps1..."
    try {
        & pwsh $initStatsScript 2>$null
    } catch {
        Write-Verbose "init-stats.ps1 fehlgeschlagen / failed: $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host ('=' * 50)
if ($PartialFail) {
    Write-Host "Migration teilweise abgeschlossen (Warnungen vorhanden)"
    exit 1
}
Write-Host "Migration abgeschlossen"
exit 0
