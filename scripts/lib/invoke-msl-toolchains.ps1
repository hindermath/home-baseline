#Requires -Version 7
<#
.SYNOPSIS
Interner MSL-Treiber fuer beide Paketpfleger.
Internal MSL driver shared by both package maintainers.
.DESCRIPTION
Ermittelt stabile Releases und schreibt optional atomare JSON-Evidence.
Resolves stable releases and optionally writes atomic JSON evidence.
Nur durch die Plattform-Paketpfleger aufrufen; Vorschau veraendert keine Installation.
Invoke through the platform package maintainers; preview never changes installations.
.PARAMETER Registry
Gemeinsame CLI-Registry / shared CLI registry.
.PARAMETER PackageRegistry
Plattform-Paketregistry / platform package registry.
.PARAMETER ResultFile
Optionaler JSON-Bericht / optional JSON report.
.PARAMETER CompareOnly
Nur lesen / read only.
.PARAMETER SkipUpgrade
Vorhandene Toolchains nicht aktualisieren / do not upgrade existing toolchains.
.PARAMETER AllowAdminPrompts
Aktuelle Admin-Prompt-Autoritaet / current administrator-prompt authority.
.EXAMPLE
pwsh -NoProfile -File scripts/lib/invoke-msl-toolchains.ps1 -CompareOnly
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param([string]$Registry = '', [string]$PackageRegistry = '', [string]$ResultFile = '',
    [switch]$CompareOnly, [switch]$SkipUpgrade, [switch]$AllowAdminPrompts)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$platform = if ($IsWindows) { 'Windows' } elseif ($IsMacOS) { 'Darwin' } else { 'Linux' }
if (-not $Registry) { $Registry = Join-Path $root 'config/required-cli-tools-registry.json' }
if (-not $PackageRegistry) { $PackageRegistry = Join-Path $root $(if ($IsWindows) { 'config/winget-apps-registry.json' } else { 'config/brew-apps-registry.json' }) }
Import-Module (Join-Path $PSScriptRoot 'msl-toolchains.psm1') -Force
try {
    if ($CompareOnly -and $WhatIfPreference) { throw 'Vergleich und Vorschau sind getrennte Modi / compare and preview are distinct modes.' }
    $cli = Get-Content -LiteralPath $Registry -Raw | ConvertFrom-Json -AsHashtable
    $packages = Get-Content -LiteralPath $PackageRegistry -Raw | ConvertFrom-Json -AsHashtable
    $result = Invoke-HBMslMaintenance -CliRegistry $cli -PackageRegistry $packages -Platform $platform `
        -CompareOnly:$CompareOnly -Preview:$WhatIfPreference -SkipUpgrade:$SkipUpgrade -AllowAdminPrompts:$AllowAdminPrompts
} catch {
    Write-Host 'MSL-Vertrag ungueltig / invalid MSL contract.'
    $mode = if ($CompareOnly) { 'compare-only' } elseif ($WhatIfPreference) { 'dry-run' } else { 'update' }
    $result = @{ schemaVersion = '1.0'; platform = $platform; mode = $mode;
        overallStatus = 'FAILED'; exitCode = 2; items = @(); remainingRequired = @('msl-contract');
        optionalDrift = @(); nextAction = 'MSL-Registry pruefen / check MSL registry.'; mslToolchains = @() }
}
if ($ResultFile) {
    $target = [IO.Path]::GetFullPath($ResultFile)
    [void][IO.Directory]::CreateDirectory((Split-Path -Parent $target))
    $temporary = "$target.$([guid]::NewGuid().ToString('N')).tmp"
    try {
        [IO.File]::WriteAllText($temporary, ($result | ConvertTo-Json -Depth 30) + "`n", [Text.UTF8Encoding]::new($false))
        [IO.File]::Move($temporary, $target, $true)
    } finally { if (Test-Path -LiteralPath $temporary) { [IO.File]::Delete($temporary) } }
}
exit $result.exitCode
