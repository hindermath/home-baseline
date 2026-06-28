<#
.SYNOPSIS
Installiert die zentral konfigurierten GitHub-Spec-Kit-Governance-Presets.

Installs the centrally configured GitHub Spec Kit governance presets.

.DESCRIPTION
Liest die Preset-Matrix aus scripts/config/spec-kit-governance-presets.json und
installiert die dort konfigurierten Preset-Versionen in ein oder mehrere
Spec-Kit-Repositories. Die Matrix ist die einzige Stelle, an der Preset-Versionen
und Prioritaeten gepflegt werden. Nutze -WhatIf fuer eine Vorschau und -Force,
um vorhandene Presets aus der aktuellen Matrix neu zu installieren.

Reads the preset matrix from scripts/config/spec-kit-governance-presets.json and
installs the configured preset versions into one or more Spec Kit repositories.
The matrix is the only place where preset versions and priorities are maintained.
Use -WhatIf to preview actions and -Force to reinstall existing presets from the
current matrix.

.PARAMETER Repo
Ziel-Repository. Kann mehrfach uebergeben werden. Standard ist das aktuelle
Verzeichnis.

Target repository. Can be passed multiple times. Defaults to the current
directory.

.PARAMETER PresetConfig
Pfad zur Preset-Matrix als JSON.

Path to the preset matrix JSON.

.PARAMETER Force
Vorhandene Presets zuerst entfernen und danach die konfigurierten Versionen
installieren.

Remove existing presets first, then install the configured versions.

.EXAMPLE
pwsh -NoProfile -File scripts/install-spec-kit-governance-presets.ps1 -WhatIf

.EXAMPLE
pwsh -NoProfile -File scripts/install-spec-kit-governance-presets.ps1 -Repo ~/SecureCaseTrackerProjects/SecureCaseTracker-CSharp -Force
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string[]]$Repo = @($PWD.Path),
    [string]$PresetConfig = '',
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $PresetConfig) {
    $PresetConfig = Join-Path $ScriptDir 'config/spec-kit-governance-presets.json'
}

function Resolve-HBPath {
    param([string]$Path)
    if ($Path -like '~/*') {
        return (Join-Path $HOME $Path.Substring(2))
    }
    return $Path
}

function Test-PresetInstalled {
    param(
        [string]$Repository,
        [string]$PresetId
    )

    Push-Location $Repository
    try {
        $listOutput = (specify preset list 2>$null | Out-String)
        return $listOutput -match "\($([regex]::Escape($PresetId))\)"
    } finally {
        Pop-Location
    }
}

function Invoke-PresetCommand {
    param(
        [string]$Repository,
        [string[]]$Arguments,
        [string]$Description
    )

    if ($PSCmdlet.ShouldProcess($Repository, $Description)) {
        Push-Location $Repository
        try {
            & specify @Arguments
            if ($LASTEXITCODE -ne 0) {
                throw "specify $($Arguments -join ' ') failed in ${Repository}"
            }
        } finally {
            Pop-Location
        }
    }
}

if (-not (Get-Command specify -ErrorAction SilentlyContinue)) {
    throw 'specify CLI nicht gefunden / specify CLI not found'
}

$PresetConfig = Resolve-HBPath $PresetConfig
if (-not (Test-Path $PresetConfig)) {
    throw "Preset-Konfiguration nicht gefunden / preset config not found: ${PresetConfig}"
}

$matrix = Get-Content $PresetConfig -Raw | ConvertFrom-Json
foreach ($repoItem in $Repo) {
    $repository = Resolve-HBPath $repoItem
    if (-not (Test-Path (Join-Path $repository '.git'))) {
        throw "kein Git-Repository / not a Git repository: ${repository}"
    }
    if (-not (Test-Path (Join-Path $repository '.specify'))) {
        throw "Spec Kit ist nicht initialisiert / Spec Kit is not initialized: ${repository}"
    }

    Write-Host "## $repository"
    $changed = $false
    foreach ($preset in $matrix.presets) {
        $id = [string]$preset.id
        $version = [string]$preset.version
        $priority = [string]$preset.priority
        $archiveUrl = [string]$preset.archiveUrl
        $installed = Test-PresetInstalled -Repository $repository -PresetId $id

        if ($Force -and $installed) {
            Invoke-PresetCommand -Repository $repository -Arguments @('preset', 'remove', $id) -Description "remove $id"
            $changed = $true
            $installed = $false
        }

        if ($installed) {
            Write-Host "  vorhanden: $id"
            continue
        }

        Invoke-PresetCommand -Repository $repository -Arguments @('preset', 'add', '--from', $archiveUrl, '--priority', $priority) -Description "install $id $version"
        $changed = $true
    }

    if (-not $changed) {
        Write-Host '  unveraendert: alle konfigurierten Presets vorhanden'
    }
}
