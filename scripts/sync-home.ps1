#Requires -Version 7
# sync-home.ps1 — Synchronisiert ~/home-baseline-tmp nach ~/
# Verwendung: pwsh ~/scripts/sync-home.ps1 [-NoPull] [-NoCommit] [-WhatIf]

[CmdletBinding(SupportsShouldProcess)]
param(
    [switch]$NoPull,
    [switch]$NoCommit
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoDir   = Split-Path -Parent $ScriptDir   # ein Verzeichnis über scripts/
$HomeDir   = if ($env:HOME) { $env:HOME } else { $env:USERPROFILE }

$DoPull   = -not $NoPull
$DoCommit = -not $NoCommit
if ($WhatIfPreference) { $DoPull = $false; $DoCommit = $false }

Write-Host "╔══════════════════════════════════════════════════╗"
Write-Host "║  sync-home — Home-Baseline Sync                  ║"
Write-Host "╚══════════════════════════════════════════════════╝"
Write-Host ""
Write-Host "  Quelle : $RepoDir"
Write-Host "  Ziel   : $HomeDir"
Write-Host "  Pull   : $DoPull"
Write-Host "  Commit : $DoCommit"
if ($WhatIfPreference) { Write-Host "  WhatIf : true (kein Schreiben)" }
Write-Host ""

# ── 1. git pull ──────────────────────────────────────────────────────────────
if ($DoPull) {
    Write-Host "→ git pull in $RepoDir..."
    git -C $RepoDir pull --ff-only
    Write-Host ""
}

# ── 2. Dateien kopieren ──────────────────────────────────────────────────────
function Sync-File {
    param([string]$RelPath)
    $src = Join-Path $RepoDir $RelPath
    $dst = Join-Path $HomeDir $RelPath
    if (-not (Test-Path $src)) { return }
    if ($WhatIfPreference) {
        Write-Host "  [WhatIf] $RelPath"
        return
    }
    $dstDir = Split-Path $dst -Parent
    if (-not (Test-Path $dstDir)) { New-Item -ItemType Directory -Path $dstDir -Force | Out-Null }
    Copy-Item $src $dst -Force
    Write-Host "  ✓ $RelPath"
}

function Sync-Dir {
    param([string]$RelPath)
    $src = Join-Path $RepoDir $RelPath
    $dst = Join-Path $HomeDir $RelPath
    if (-not (Test-Path $src)) { return }
    if ($WhatIfPreference) {
        Write-Host "  [WhatIf] $RelPath/"
        return
    }
    if (-not (Test-Path $dst)) { New-Item -ItemType Directory -Path $dst -Force | Out-Null }
    Copy-Item "$src\*" $dst -Recurse -Force
    Write-Host "  ✓ $RelPath/"
}

Write-Host "→ Dateien synchronisieren..."

# Root-Dateien
foreach ($f in @('AGENTS.md','CLAUDE.md','GEMINI.md','README.md','STATS.md',
                  'constitution.md','.gitconfig','.gitignore','LICENSE')) {
    Sync-File $f
}

# Lastenheft (Glob)
Get-ChildItem -Path $RepoDir -Filter 'Lastenheft*.md' -File -ErrorAction SilentlyContinue |
    ForEach-Object { Sync-File $_.Name }

# Verzeichnisse
Sync-Dir 'scripts'
Sync-Dir '.github'
Sync-Dir 'specs'
Sync-Dir '.specify'

Write-Host ""

# ── 3. git commit in ~/ ──────────────────────────────────────────────────────
if ($DoCommit) {
    Push-Location $HomeDir
    try {
        $status = git status --short
        if (-not $status) {
            Write-Host "→ Keine Änderungen in ~/ — kein Commit nötig."
        } else {
            git add -A
            $remoteSha = (git -C $RepoDir rev-parse --short HEAD 2>$null) ?? 'unbekannt'
            git commit -m "chore: sync mit home-baseline @ ${remoteSha}`n`nCo-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
            Write-Host "→ Commit in ~/ erstellt."
        }
    } finally {
        Pop-Location
    }
}

Write-Host ""
Write-Host "✓ sync-home abgeschlossen."
