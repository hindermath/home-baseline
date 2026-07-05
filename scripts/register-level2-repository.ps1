<#
.SYNOPSIS
Registriert Level-1-/Level-2-Repositories in der operativen GSDB-Registry.

Registers level-1/level-2 repositories in the operational GSDB registry.

.DESCRIPTION
Aktualisiert standardmaessig die lokale Registry
~/.home-baseline/level2-repository-registry.json idempotent. Das Repository
enthaelt nur eine public-safe Beispiel-Registry unter scripts/config/.

Mit -ScanRoot koennen Workspace-Wurzeln nach Git-Repositories durchsucht
werden. So erkennt die wiederkehrende Wartung neue GSDB-Kandidaten, ohne
maschinenbezogene Pfade in das oeffentliche Repository zu schreiben.

Updates the local ~/.home-baseline/level2-repository-registry.json registry by
default. The repository only contains a public-safe example registry under
scripts/config/.

With -ScanRoot, workspace roots can be scanned for Git repositories. This lets
recurring maintenance detect new GSDB candidates without writing machine-
specific paths to the public repository.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [string[]]$Repo = @(),
    [string[]]$ScanRoot = @(),
    [string]$Registry = '',
    [ValidateSet('1','2')][string]$Level = '',
    [string]$PrimaryLanguage = '',
    [ValidateSet('true','false','')][string]$GsdbRequired = '',
    [string]$PresetProfile = '',
    [string]$Role = '',
    [string]$Source = ''
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

function Get-HBInferredLevel {
    param([string]$Repository)
    $parent = Split-Path -Parent $Repository
    if (Test-Path (Join-Path $parent '.git')) { return '2' }
    return '1'
}

function Get-HBDiscoveredRepository {
    param([string[]]$Roots)
    foreach ($root in $Roots) {
        $resolvedRoot = Resolve-HBPath $root
        if (-not (Test-Path $resolvedRoot)) {
            Write-Warning "Scan-Root nicht gefunden / scan root not found: ${resolvedRoot}"
            continue
        }
        $rootFull = [System.IO.Path]::GetFullPath($resolvedRoot).TrimEnd([IO.Path]::DirectorySeparatorChar)
        Get-ChildItem -LiteralPath $resolvedRoot -Directory -Force -Recurse -Filter '.git' -ErrorAction SilentlyContinue |
            ForEach-Object {
                $repoPath = Split-Path -Parent $_.FullName
                $repoFull = [System.IO.Path]::GetFullPath($repoPath).TrimEnd([IO.Path]::DirectorySeparatorChar)
                if ($repoFull -ne $rootFull) { $repoPath }
            }
    }
}

function Register-HBRepository {
    param(
        [string]$Repository,
        [string]$RegistryPath,
        [string]$RegistrationSource
    )

    if (-not (Test-Path (Join-Path $Repository '.git'))) {
        throw "kein Git-Repository / not a Git repository: ${Repository}"
    }

    $projectName = Split-Path -Leaf $Repository
    $effectiveLevel = if ($Level) { $Level } else { Get-HBInferredLevel -Repository $Repository }

    $language = $PrimaryLanguage
    if (-not $language) {
        $language = Get-SdhPrimaryLanguage -Repo $Repository -ProjectName $projectName -ExplicitLanguage ''
    }
    if (-not $language) { $language = 'unknown' }

    $mslStatus = 'unknown'
    if (Test-SdhMslLanguage $language) { $mslStatus = 'msl' }
    elseif (Test-SdhKnownNonMslLanguage $language) { $mslStatus = 'non-msl' }
    elseif ($language -eq 'none') { $mslStatus = 'n/a' }

    $gsdbRequiredValue = $GsdbRequired
    if (-not $gsdbRequiredValue) {
        $gsdbRequiredValue = if (($effectiveLevel -eq '2') -and ($mslStatus -eq 'msl')) { 'true' } else { 'false' }
    }

    $effectivePresetProfile = $PresetProfile
    if (-not $effectivePresetProfile) {
        $effectivePresetProfile = if (($effectiveLevel -eq '2') -and ($mslStatus -eq 'msl')) { 'standard-six-governance-presets' } else { 'none' }
    }
    $effectiveRole = $Role
    if (-not $effectiveRole) {
        $effectiveRole = if ($effectiveLevel -eq '2') { 'level-2-project' } else { 'level-1-workspace' }
    }

    $today = Get-Date -Format 'yyyy-MM-dd'
    $repoRel = Get-HomeRelativePath $Repository

    if (Test-Path $RegistryPath) {
        $data = Get-Content $RegistryPath -Raw | ConvertFrom-Json
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
        level = [int]$effectiveLevel
        primaryLanguage = $language
        mslStatus = $mslStatus
        gsdbRequired = ($gsdbRequiredValue -eq 'true')
        presetProfile = $effectivePresetProfile
        role = $effectiveRole
        source = $RegistrationSource
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

    $shouldWrite = $PSCmdlet.ShouldProcess($RegistryPath, "$action $repoRel")
    if ($shouldWrite) {
        $data | ConvertTo-Json -Depth 8 | Set-Content -Path $RegistryPath -Encoding UTF8
    }
    if ($WhatIfPreference) {
        Write-Host "[WhatIf] ${action}: ${repoRel} -> ${RegistryPath}"
    } else {
        Write-Host "${action}: ${repoRel} -> ${RegistryPath}"
    }
}

if ((@($Repo).Count -eq 0) -and (@($ScanRoot).Count -eq 0)) {
    throw "-Repo oder -ScanRoot ist erforderlich / -Repo or -ScanRoot is required"
}

if (-not $Registry) { $Registry = Get-DefaultRegistry }
$Registry = Resolve-HBPath $Registry
$registryDirectory = Split-Path -Parent $Registry
if (-not $WhatIfPreference) {
    New-Item -ItemType Directory -Path $registryDirectory -Force | Out-Null
} elseif (-not (Test-Path $registryDirectory)) {
    Write-Host "[WhatIf] Registry-Verzeichnis erzeugen: $registryDirectory"
}

$registrationSource = $Source
if (-not $registrationSource) {
    $registrationSource = if (@($ScanRoot).Count -gt 0) { 'maintenance-discovery' } else { 'manual-registration' }
}

$repositories = @()
foreach ($repoPath in @($Repo)) {
    if ($repoPath) { $repositories += (Resolve-HBPath $repoPath) }
}
if (@($ScanRoot).Count -gt 0) {
    $repositories += @(Get-HBDiscoveredRepository -Roots $ScanRoot)
}

$repositories = @($repositories | Where-Object { $_ } | Sort-Object -Unique)
foreach ($repository in $repositories) {
    Register-HBRepository -Repository $repository -RegistryPath $Registry -RegistrationSource $registrationSource
}
