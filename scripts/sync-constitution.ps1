# sync-constitution.ps1 — constitution.md in alle Level-1-Workspaces synchronisieren
# FR-REV-F01, FR-REV-F02; Contract: sync-constitution-cli.md
#Requires -Version 7

[CmdletBinding(SupportsShouldProcess)]
param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module (Join-Path $ScriptDir 'lib/managed-file-hardening.psm1') -Force
$HomeRoot = $(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })
$HomeConstitution = Get-HBManagedPath -Root $HomeRoot -RelativePath 'constitution.md'

# ─── 1. Version aus ~/constitution.md extrahieren ────────────────────────────

if (-not (Test-Path -LiteralPath $HomeConstitution -PathType Leaf)) {
    Write-Error "ERROR: ~/constitution.md nicht gefunden — bitte zuerst erstellen."
    exit 2
}

$firstLine = [IO.File]::ReadLines($HomeConstitution) | Select-Object -First 1
if ($firstLine -notmatch '(v\d+\.\d+\.\d+)') {
    Write-Error "ERROR: constitution.md hat keine Versionszeile (erwartet: # Constitution vX.Y.Z)"
    exit 2
}
$ConstVer = $Matches[1]

Write-Host "Sync constitution $ConstVer -> Level-1-Workspaces"
Write-Host ('=' * 50)

# ─── 2. Level-1-Workspaces ermitteln ─────────────────────────────────────────

$Workspaces = @(Get-ChildItem -LiteralPath $HomeRoot -Directory |
    Where-Object { Test-Path (Join-Path $_.FullName '.git') } |
    Sort-Object Name)

if ($Workspaces.Count -eq 0) {
    Write-Host "Keine Level-1-Workspaces gefunden."
    exit 0
}

foreach ($ws in $Workspaces) {
    $null = Get-HBManagedPath -Root $ws.FullName -RelativePath 'constitution.md' -AllowMissingParent
}

# ─── Preview ─────────────────────────────────────────────────────────────────

$WsStatus = @{}
foreach ($ws in $Workspaces) {
    $wsShort  = $ws.FullName -replace [regex]::Escape($HomeRoot), '~'
    $wsConst  = Get-HBManagedPath -Root $ws.FullName -RelativePath 'constitution.md' -AllowMissingParent
    if (Test-Path -LiteralPath $wsConst -PathType Leaf) {
        $wsFirstLine = [IO.File]::ReadLines($wsConst) | Select-Object -First 1
        if ($wsFirstLine -match '(v\d+\.\d+\.\d+)') { $wsVer = $Matches[1] } else { $wsVer = '?' }
        if ($wsVer -eq $ConstVer) {
            $WsStatus[$ws.FullName] = 'ALREADY UP-TO-DATE'
        } else {
            $WsStatus[$ws.FullName] = "WOULD UPDATE ($wsVer -> $ConstVer)"
        }
    } else {
        $WsStatus[$ws.FullName] = 'WOULD CREATE'
    }
    Write-Host "  $($WsStatus[$ws.FullName]): $wsShort"
}
Write-Host ""

if ($WhatIfPreference) {
    Write-Host "[WhatIf] Keine Änderungen vorgenommen."
    exit 0
}

# ─── 3. Proceed-Prompt ───────────────────────────────────────────────────────

if (-not $Force) {
    $answer = Read-Host "Fortfahren? Proceed? [y/N]"
    if ($answer -notmatch '^[yYjJ]') {
        Write-Host "Abgebrochen."; exit 0
    }
}

# ─── 4. Sync pro Workspace ───────────────────────────────────────────────────

$Updated = 0; $Skipped = 0; $Already = 0

foreach ($ws in $Workspaces) {
    $wsShort = $ws.FullName -replace [regex]::Escape($HomeRoot), '~'
    $status  = $WsStatus[$ws.FullName]

    if ($status -eq 'ALREADY UP-TO-DATE') {
        Write-Host "  ALREADY UP-TO-DATE: $wsShort"
        $Already++
        continue
    }

    # Check for uncommitted changes
    $dirty = git -C $ws.FullName status --porcelain 2>$null
    if ($dirty) {
        Write-Host "  WARN: $wsShort hat uncommittete Aenderungen -- uebersprungen"
        $Skipped++
        continue
    }

    # Copy constitution.md
    Copy-HBManagedFileAtomic -SourceRoot $HomeRoot -SourceRelativePath 'constitution.md' `
        -Root $ws.FullName -RelativePath 'constitution.md'
    git -C $ws.FullName add 'constitution.md' 2>$null | Out-Null
    $msg = "chore: sync constitution to $ConstVer`n`nCo-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
    git -C $ws.FullName commit -m $msg 2>$null | Out-Null

    Write-Host "  UPDATED: $wsShort ($ConstVer)"
    $Updated++
}

# ─── Zusammenfassung ─────────────────────────────────────────────────────────

Write-Host ""
Write-Host ('=' * 50)
Write-Host "  Fertig: UPDATED=$Updated  SKIPPED=$Skipped  ALREADY=$Already"

if ($Skipped -gt 0) { exit 1 }
exit 0
