#Requires -Version 7
<#
.SYNOPSIS
Sammelt Windows-Testevidence und veröffentlicht ausschließlich diese Datei.

.DESCRIPTION
Requires a clean main checkout exactly based on origin/main. The output is
written through a private temporary file, checked against links/reparse points,
committed as the only changed path, and pushed only after parent/path checks.

.EXAMPLE
pwsh -NoProfile -File ~/home-baseline-source/scripts/windows-test.ps1
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$HomeDir   = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. (Join-Path $ScriptDir 'lib/resolve-home-baseline-source.ps1')
$RepoDir   = Resolve-HBSourceRepository -StartPath $MyInvocation.MyCommand.Path -AllowLegacy
$OutFile   = Join-Path $RepoDir 'windows-test-output.txt'
$OutputName = 'windows-test-output.txt'
$Date      = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
$Lines     = [System.Collections.Generic.List[string]]::new()

function Invoke-HBTestGit {
    param([Parameter(Mandatory)][string[]]$Arguments)
    $output = @(& git -C $RepoDir @Arguments 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "Git-Aufruf fehlgeschlagen: git $($Arguments -join ' ')"
    }
    return $output
}

function Assert-HBSafeCleanPublicationState {
    $repoItem = Get-Item -LiteralPath $RepoDir -Force
    if ($repoItem.Attributes -band [IO.FileAttributes]::ReparsePoint) {
        throw "Verknüpftes Repository wird abgelehnt: $RepoDir"
    }
    if (Test-Path -LiteralPath $OutFile) {
        $outputItem = Get-Item -LiteralPath $OutFile -Force
        if ($outputItem.Attributes -band [IO.FileAttributes]::ReparsePoint) {
            throw "Verknüpfte Ausgabedatei wird abgelehnt: $OutFile"
        }
    }
    $stage = @(Invoke-HBTestGit -Arguments @('ls-files', '-s', '--', $OutputName))
    if ($stage.Count -gt 0 -and ($stage[0] -split '\s+')[0] -eq '120000') {
        throw 'Git-Symlink als Ausgabedatei wird abgelehnt.'
    }
    if (@(Invoke-HBTestGit -Arguments @('status', '--porcelain=v1', '--untracked-files=all')).Count -gt 0) {
        throw 'Repository enthält bereits Änderungen oder ungetrackte Dateien.'
    }
}

function Assert-HBOriginPushMatchesFetch {
    $fetchUrl = @(Invoke-HBTestGit -Arguments @('remote', 'get-url', 'origin'))
    $pushUrls = @(Invoke-HBTestGit -Arguments @('remote', 'get-url', '--push', '--all', 'origin'))
    if ($fetchUrl.Count -ne 1 -or $pushUrls.Count -ne 1 -or $pushUrls[0] -cne $fetchUrl[0]) {
        throw 'origin-Pushziel weicht vom verifizierten Fetchziel ab.'
    }
}

function Initialize-HBExactMainBase {
    $branch = @(Invoke-HBTestGit -Arguments @('branch', '--show-current'))[-1]
    if ($branch -cne 'main') { throw 'Launcher benötigt Branch main.' }
    Assert-HBOriginPushMatchesFetch
    $null = Invoke-HBTestGit -Arguments @('fetch', '--no-tags', 'origin', 'main')
    $head = @(Invoke-HBTestGit -Arguments @('rev-parse', 'HEAD'))[-1]
    $remoteHead = @(Invoke-HBTestGit -Arguments @('rev-parse', 'origin/main'))[-1]
    if ($head -cne $remoteHead) {
        & git -C $RepoDir merge-base --is-ancestor $head $remoteHead
        if ($LASTEXITCODE -ne 0) {
            throw 'Lokale Ahead-/Diverged-Commits dürfen nicht nach main veröffentlicht werden.'
        }
        $null = Invoke-HBTestGit -Arguments @('merge', '--ff-only', $remoteHead)
    }
}

Assert-HBSafeCleanPublicationState
Initialize-HBExactMainBase
$BaseCommit = @(Invoke-HBTestGit -Arguments @('rev-parse', 'HEAD'))[-1]

function Add-Line { param([string]$Text = '') $Lines.Add($Text); Write-Host $Text }

Add-Line "Windows Test Output - ${Date}"
Add-Line ""

# === System-Info ===
Add-Line "=== System-Info ==="
$os = Get-CimInstance Win32_OperatingSystem
Add-Line "OS:        $($os.Caption) $($os.Version)"
Add-Line "Arch:      $($env:PROCESSOR_ARCHITECTURE)"
Add-Line "Shell:     PowerShell $($PSVersionTable.PSVersion)"
Add-Line "Edition:   $($PSVersionTable.PSEdition)"
Add-Line ""

# === Paketmanager ===
Add-Line "=== Paketmanager ==="
foreach ($pm in @('winget', 'choco', 'scoop')) {
    if (Get-Command $pm -ErrorAction SilentlyContinue) {
        $ver = (& $pm --version 2>$null | Select-Object -First 1) -replace '\s+', ' '
        Add-Line "  OK  ${pm}: ${ver}"
    } else {
        Add-Line "  --- ${pm}: nicht installiert"
    }
}
Add-Line ""

# === WinGet Inventar ===
Add-Line "=== WinGet Pakete ==="
if (Get-Command winget -ErrorAction SilentlyContinue) {
    $wingetList = winget list --accept-source-agreements 2>&1
    $wingetList | ForEach-Object { Add-Line "$_" }
} else {
    Add-Line "winget: nicht installiert"
}
Add-Line ""

Add-Line "=== WinGet Upgrades ==="
if (Get-Command winget -ErrorAction SilentlyContinue) {
    $wingetUpgrade = winget upgrade --accept-source-agreements 2>&1
    $wingetUpgrade | ForEach-Object { Add-Line "$_" }
} else {
    Add-Line "winget: nicht installiert"
}
Add-Line ""

Add-Line "=== Agentic WinGet Registry Vergleich ==="
$wingetMaint = Join-Path $RepoDir 'scripts\maintain-agentic-winget-apps.ps1'
if (Test-Path $wingetMaint) {
    $wingetCompare = pwsh -NoProfile -File $wingetMaint -CompareOnly 2>&1
    $wingetCompare | ForEach-Object { Add-Line "$_" }
} else {
    Add-Line "maintain-agentic-winget-apps.ps1: nicht gefunden"
}
Add-Line ""

Add-Line "=== PSScriptAnalyzer ==="
$moduleMaintainer = Join-Path $RepoDir 'scripts\maintain-powershell-modules.ps1'
$analyzerRunner = Join-Path $RepoDir 'scripts\invoke-psscriptanalyzer.ps1'
if ((Test-Path $moduleMaintainer) -and (Test-Path $analyzerRunner)) {
    $moduleComparison = pwsh -NoProfile -File $moduleMaintainer -CompareOnly 2>&1
    $moduleComparison | ForEach-Object { Add-Line "$_" }
    $analysisOutput = pwsh -NoProfile -File $analyzerRunner 2>&1
    $analysisOutput | ForEach-Object { Add-Line "$_" }
} else {
    Add-Line 'PowerShell-Modulpflege oder PSScriptAnalyzer-Runner fehlt'
}
Add-Line ""

Add-Line "=== Workspace Maintenance Check ==="
$workspaceMaint = Join-Path $RepoDir 'scripts\maintain-agentic-workspace.ps1'
if (Test-Path $workspaceMaint) {
    $workspaceCheck = pwsh -NoProfile -File $workspaceMaint -CheckOnly -ScriptsOnly 2>&1
    $workspaceCheck | ForEach-Object { Add-Line "$_" }
} else {
    Add-Line "maintain-agentic-workspace.ps1: nicht gefunden"
}
Add-Line ""

# === VS Code / Helix ===
Add-Line "=== VS Code / Helix ==="
if (Get-Command code -ErrorAction SilentlyContinue) {
    $codeVersion = code --version 2>&1
    $codeVersion | ForEach-Object { Add-Line "$_" }
    $codeExtensions = code --list-extensions 2>&1
    $codeExtensions | ForEach-Object { Add-Line "$_" }
} else {
    Add-Line 'code: nicht installiert'
}
if (Get-Command hx -ErrorAction SilentlyContinue) {
    $hxVersion = hx --version 2>&1
    $hxVersion | ForEach-Object { Add-Line "$_" }
} else {
    Add-Line 'hx: nicht installiert'
}
Add-Line ""

# === Tools ===
Add-Line "=== Tools ==="
foreach ($cmd in @('git', 'gh', 'glab', 'rg', 'gitleaks', 'pwsh', 'node', 'npm', 'uv', 'python', 'dotnet', 'go', 'java', 'javac', 'cargo', 'rustc', 'swift', 'syft', 'specify', 'podman', 'codex', 'claude', 'agy', 'copilot', 'code', 'hx')) {
    if (Get-Command $cmd -ErrorAction SilentlyContinue) {
        Add-Line "  OK  ${cmd}"
    } else {
        Add-Line "  --- ${cmd}: fehlt"
    }
}
Add-Line ""

# === WSL ===
Add-Line "=== WSL ==="
try {
    $wslList = wsl --list --verbose 2>&1
    $wslList | ForEach-Object { Add-Line "  $_" }
} catch {
    Add-Line "  WSL nicht verfuegbar oder kein Distro installiert"
}
Add-Line ""

# === sync-home ===
Add-Line "=== sync-home ==="
$syncScript = Join-Path $RepoDir 'scripts\sync-home.ps1'
$syncOutput = pwsh -NoProfile -File $syncScript -NoPull 2>&1
$syncOutput | ForEach-Object { Add-Line "$_" }
Add-Line ""

# === check-homogeneity ===
Add-Line "=== check-homogeneity ==="
$checkScript = Join-Path $HomeDir 'scripts\check-homogeneity.ps1'
$checkOutput = pwsh -NoProfile -File $checkScript -TargetDir $HomeDir 2>&1
$checkOutput | ForEach-Object { Add-Line "$_" }

$null = Invoke-HBTestGit -Arguments @('fetch', '--no-tags', 'origin', 'main')
$headBeforePublish = @(Invoke-HBTestGit -Arguments @('rev-parse', 'HEAD'))[-1]
$remoteBeforePublish = @(Invoke-HBTestGit -Arguments @('rev-parse', 'origin/main'))[-1]
if ($headBeforePublish -cne $remoteBeforePublish) {
    throw 'origin/main hat sich während des Tests geändert; bitte erneut ausführen.'
}
Assert-HBSafeCleanPublicationState

$publishTemp = Join-Path $RepoDir ".windows-test-output.$([Guid]::NewGuid().ToString('N')).tmp"
try {
    $stream = [IO.File]::Open($publishTemp, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::None)
    try {
        $writer = [IO.StreamWriter]::new($stream, [Text.UTF8Encoding]::new($false))
        try { foreach ($line in $Lines) { $writer.WriteLine($line) } } finally { $writer.Dispose() }
    } finally {
        if ($null -ne $stream) { $stream.Dispose() }
    }
    [IO.File]::Move($publishTemp, $OutFile, $true)
} finally {
    if (Test-Path -LiteralPath $publishTemp) { Remove-Item -LiteralPath $publishTemp -Force }
}

$null = Invoke-HBTestGit -Arguments @('add', '--', $OutputName)
$cached = @(Invoke-HBTestGit -Arguments @('diff', '--cached', '--name-only'))
if ($cached.Count -ne 1 -or $cached[0] -cne $OutputName) { throw 'Unerwartete Pfade im Git-Index.' }
if (@(Invoke-HBTestGit -Arguments @('diff', '--name-only')).Count -gt 0) { throw 'Nicht gestagte Änderungen erkannt.' }
if (@(Invoke-HBTestGit -Arguments @('ls-files', '--others', '--exclude-standard')).Count -gt 0) { throw 'Ungetrackte Dateien erkannt.' }
$null = Invoke-HBTestGit -Arguments @('-c', 'core.hooksPath=NUL', 'commit', '--only',
    '-m', "test: Windows Test-Output (${Date})",
    '-m', 'Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>', '--', $OutputName)
$verifiedCommit = @(Invoke-HBTestGit -Arguments @('rev-parse', 'HEAD'))[-1]
$parent = @(Invoke-HBTestGit -Arguments @('rev-parse', "${verifiedCommit}^"))[-1]
if ($parent -cne $BaseCommit) { throw 'Unerwartete Commit-Elternbeziehung.' }
$commitPaths = @(Invoke-HBTestGit -Arguments @('diff-tree', '--no-commit-id', '--name-only', '-r', "${verifiedCommit}^", $verifiedCommit))
if ($commitPaths.Count -ne 1 -or $commitPaths[0] -cne $OutputName) { throw 'Commit enthält unerwartete Pfade.' }
Assert-HBOriginPushMatchesFetch
$null = Invoke-HBTestGit -Arguments @('push', "--force-with-lease=refs/heads/main:$BaseCommit", 'origin', "${verifiedCommit}:refs/heads/main")
Add-Line "Gepusht."
