#Requires -Version 7
<#
.SYNOPSIS
    Maintains WinGet packages for agentic development.

.DESCRIPTION
    Reads scripts/config/winget-apps-registry.json, updates WinGet metadata,
    upgrades installed packages, installs missing required packages, and reports
    drift between installed WinGet packages and the registry.

.PARAMETER Registry
    Alternative registry JSON path.

.PARAMETER CompareOnly
    Only compare installed packages with the registry.

.PARAMETER SkipUpgrade
    Skip winget update/source update and winget upgrade --all.

.PARAMETER IncludeOptional
    Also install optional registry entries.

.EXAMPLE
    pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -WhatIf
    pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -CompareOnly
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string] $Registry = '',
    [switch] $CompareOnly,
    [switch] $SkipUpgrade,
    [switch] $IncludeOptional
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
if (-not $Registry) {
    $Registry = Join-Path $repoRoot 'scripts/config/winget-apps-registry.json'
}

if (-not (Test-Path -Path $Registry -PathType Leaf)) {
    Write-Error "Registry nicht gefunden: $Registry"
}

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error 'winget ist nicht installiert oder nicht im PATH.'
}

$registryData = Get-Content -Path $Registry -Raw | ConvertFrom-Json
$installScope = if ($IncludeOptional) { @('required', 'optional') } else { @('required') }
$allRegistryIds = @($registryData.packages | ForEach-Object { $_.id } | Sort-Object -Unique)
$installIds = @(
    $registryData.packages |
        Where-Object { $installScope -contains $_.scope } |
        ForEach-Object { $_.id } |
        Sort-Object -Unique
)

function Invoke-HBWinget {
    param(
        [Parameter(Mandatory)][string[]] $Arguments,
        [Parameter(Mandatory)][string] $Action
    )

    $display = "winget $($Arguments -join ' ')"
    if ($PSCmdlet.ShouldProcess($display, $Action)) {
        & winget @Arguments
        return $LASTEXITCODE
    }

    Write-Host "WHATIF: $display"
    return 0
}

function Test-HBWingetSearchId {
    param([Parameter(Mandatory)][string] $Id)

    $output = & winget search --id $Id --exact --accept-source-agreements 2>$null
    if ($LASTEXITCODE -ne 0) { return $false }
    return (($output -join "`n") -match [regex]::Escape($Id))
}

function Test-HBWingetInstalledId {
    param([Parameter(Mandatory)][string] $Id)

    $output = & winget list --id $Id --exact --accept-source-agreements 2>$null
    if ($LASTEXITCODE -ne 0) { return $false }
    return (($output -join "`n") -match [regex]::Escape($Id))
}

function Get-HBWingetInstalledIds {
    $output = & winget list --accept-source-agreements 2>$null
    if ($LASTEXITCODE -ne 0) { return @() }

    $ids = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($line in $output) {
        $matches = [regex]::Matches($line, '\s([A-Za-z0-9][A-Za-z0-9._-]+(?:\.[A-Za-z0-9][A-Za-z0-9._-]+)+)\s+([0-9][^\s]*)')
        foreach ($match in $matches) {
            [void]$ids.Add($match.Groups[1].Value)
        }
    }

    return @($ids | Sort-Object)
}

Write-Host 'Agentic WinGet registry maintenance'
Write-Host "Registry: $Registry"

if (-not $CompareOnly -and -not $SkipUpgrade) {
    $updateStatus = Invoke-HBWinget -Arguments @('update') -Action 'WinGet package metadata update'
    if ($updateStatus -ne 0) {
        Write-Warning 'winget update ist nicht verfuegbar oder fehlgeschlagen; nutze winget source update als Fallback.'
        [void](Invoke-HBWinget -Arguments @('source', 'update') -Action 'WinGet source update')
    }
    [void](Invoke-HBWinget -Arguments @('upgrade', '--all', '--accept-package-agreements', '--accept-source-agreements') -Action 'WinGet package upgrade')
}

if (-not $CompareOnly) {
    foreach ($id in $installIds) {
        if (Test-HBWingetInstalledId -Id $id) {
            Write-Host "OK package: $id"
            continue
        }

        if (-not (Test-HBWingetSearchId -Id $id)) {
            Write-Error "WinGet-ID nicht gefunden: $id"
        }

        Write-Host "INSTALL package: $id"
        [void](Invoke-HBWinget -Arguments @('install', '--id', $id, '--exact', '--accept-package-agreements', '--accept-source-agreements') -Action "Install $id")
    }
}

$installedIds = @(Get-HBWingetInstalledIds)
$missingOnMachine = @($allRegistryIds | Where-Object { $installedIds -notcontains $_ })
$missingFromRegistry = @($installedIds | Where-Object { $allRegistryIds -notcontains $_ })

if ($missingOnMachine.Count -gt 0) {
    Write-Host 'missing_on_machine.packages'
    $missingOnMachine | ForEach-Object { Write-Host "  - $_" }
} else {
    Write-Host 'missing_on_machine.packages: none'
}

if ($missingFromRegistry.Count -gt 0) {
    Write-Host 'missing_from_registry.packages'
    $missingFromRegistry | ForEach-Object { Write-Host "  - $_" }
} else {
    Write-Host 'missing_from_registry.packages: none'
}
