<#
.SYNOPSIS
Registriert ein Level-1-/Level-2-Repository in der operativen GSDB-Registry.

Registers a level-1/level-2 repository in the operational GSDB registry.

.DESCRIPTION
Aktualisiert standardmaessig die lokale Registry
~/.home-baseline/level2-repository-registry.json idempotent. Das Repository
enthaelt nur eine public-safe Beispiel-Registry unter scripts/config/.

Updates the local ~/.home-baseline/level2-repository-registry.json registry by
default. The repository only contains a public-safe example registry under
scripts/config/.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [Parameter(Mandatory)][string]$Repo,
    [string]$Registry = '',
    [ValidateSet('1','2')][string]$Level = '',
    [string]$PrimaryLanguage = '',
    [ValidateSet('true','false','')][string]$GsdbRequired = '',
    [string]$PresetProfile = '',
    [string]$Role = '',
    [string]$Source = 'manual-registration'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$LibFile = Join-Path $ScriptDir 'lib/secure-development-hardening.ps1'
if (Test-Path $LibFile) {
    . $LibFile
}

function Resolve-HBPath {
    param([string]$Path)
    if ($Path -like '~/*') { return (Join-Path $HOME $Path.Substring(2)) }
    return $Path
}

function Get-DefaultRegistry {
    return (Join-Path $HOME '.home-baseline/level2-repository-registry.json')
}

function Get-HomeRelativePath {
    param([string]$Path)
    $full = [System.IO.Path]::GetFullPath($Path)
    $homeFull = [System.IO.Path]::GetFullPath($HOME).TrimEnd([IO.Path]::DirectorySeparatorChar)
    if ($full.StartsWith($homeFull + [IO.Path]::DirectorySeparatorChar)) {
        return $full.Substring($homeFull.Length + 1) -replace '\\','/'
    }
    return $full -replace '\\','/'
}

$Repo = Resolve-HBPath $Repo
if (-not (Test-Path (Join-Path $Repo '.git'))) {
    throw "kein Git-Repository / not a Git repository: ${Repo}"
}

if (-not $Registry) { $Registry = Get-DefaultRegistry }
$Registry = Resolve-HBPath $Registry
$registryDirectory = Split-Path -Parent $Registry
if (-not $WhatIfPreference) {
    New-Item -ItemType Directory -Path $registryDirectory -Force | Out-Null
} elseif (-not (Test-Path $registryDirectory)) {
    Write-Host "[WhatIf] Registry-Verzeichnis erzeugen: $registryDirectory"
}

$projectName = Split-Path -Leaf $Repo
if (-not $Level) {
    $parent = Split-Path -Parent $Repo
    $Level = if (Test-Path (Join-Path $parent '.git')) { '2' } else { '1' }
}

$language = $PrimaryLanguage
if (-not $language) {
    $language = Get-SdhPrimaryLanguage -Repo $Repo -ProjectName $projectName -ExplicitLanguage ''
}
if (-not $language) { $language = 'unknown' }

$mslStatus = 'unknown'
if (Test-SdhMslLanguage $language) { $mslStatus = 'msl' }
elseif (Test-SdhKnownNonMslLanguage $language) { $mslStatus = 'non-msl' }
elseif ($language -eq 'none') { $mslStatus = 'n/a' }

$gsdbRequiredValue = $GsdbRequired
if (-not $gsdbRequiredValue) {
    $gsdbRequiredValue = if (($Level -eq '2') -and ($mslStatus -eq 'msl')) { 'true' } else { 'false' }
}

if (-not $PresetProfile) {
    $PresetProfile = if (($Level -eq '2') -and ($mslStatus -eq 'msl')) { 'standard-six-governance-presets' } else { 'none' }
}
if (-not $Role) {
    $Role = if ($Level -eq '2') { 'level-2-project' } else { 'level-1-workspace' }
}

$today = Get-Date -Format 'yyyy-MM-dd'
$repoRel = Get-HomeRelativePath $Repo

if (Test-Path $Registry) {
    $data = Get-Content $Registry -Raw | ConvertFrom-Json
} else {
    $data = [pscustomobject]@{
        schemaVersion = 1
        description = "Local operational registry for GSDB-relevant level-1 and level-2 repositories. Paths are relative to the user's home directory."
        updatedAt = $today
        repositories = @()
    }
}

$repos = @($data.repositories)
$entry = [pscustomobject]@{
    path = $repoRel
    level = [int]$Level
    primaryLanguage = $language
    mslStatus = $mslStatus
    gsdbRequired = ($gsdbRequiredValue -eq 'true')
    presetProfile = $PresetProfile
    role = $Role
    source = $Source
    registeredAt = $today
}

$existing = $repos | Where-Object { $_.path -eq $repoRel } | Select-Object -First 1
if ($existing) {
    $repos = @($repos | Where-Object { $_.path -ne $repoRel }) + @($entry)
    $action = 'updated'
} else {
    $repos = @($repos) + @($entry)
    $action = 'added'
}

$data.updatedAt = $today
$data.repositories = @($repos | Sort-Object path)

$shouldWrite = $PSCmdlet.ShouldProcess($Registry, "$action $repoRel")
if ($shouldWrite) {
    $data | ConvertTo-Json -Depth 8 | Set-Content -Path $Registry -Encoding UTF8
}
if ($WhatIfPreference) {
    Write-Host "[WhatIf] ${action}: ${repoRel} -> ${Registry}"
} else {
    Write-Host "${action}: ${repoRel} -> ${Registry}"
}
