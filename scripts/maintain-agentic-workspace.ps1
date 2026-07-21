#Requires -Version 7
<#
.SYNOPSIS
    Orchestrates repository and agentic toolchain maintenance on Windows.

.DESCRIPTION
    Updates the Level-0 checkout and all discovered Level-1/Level-2 repositories
    by fast-forward only, synchronizes the local home baseline, checks the local
    GSDB registry and canonical maintenance package, and then maintains the
    WinGet-based machine toolchain. The script never commits or pushes target
    repositories and never switches branches.

    Without parameters, the script performs the complete mutating maintenance
    workflow. Use -CheckOnly for a read-oriented status run or -WhatIf for a
    preview of mutating operations.

.PARAMETER CheckOnly
    Fetch and report only. Do not pull repositories, synchronize files, update
    the registry, propagate files, or update packages.

.PARAMETER ScriptsOnly
    Maintain repositories, home sync, registry, and propagation only. Skip
    WinGet and other machine-toolchain changes.

.PARAMETER RepairDrift
    Repair canonical maintenance-package drift in Level-1/Level-2 repositories.
    The affected repositories remain uncommitted and unpushed for review.

.PARAMETER IncludeOptional
    Install optional WinGet, VS Code, CLI, and npm registry entries too.

.PARAMETER HomeDir
    Alternative home directory, primarily for isolated tests or a second profile.

.EXAMPLE
    pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1

    Performs the complete maintenance workflow.

.EXAMPLE
    pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly

    Fetches and reports repository and toolchain state without applying updates.

.EXAMPLE
    pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf

    Previews all mutating steps.

.EXAMPLE
    pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -ScriptsOnly -RepairDrift

    Updates repositories and repairs maintenance files locally without commits.

.NOTES
    Exit codes: 0 = current/success, 1 = drift found, 2 = operational error,
    3 = drift repaired and affected repositories need separate review/commit/push.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [switch] $CheckOnly,
    [switch] $ScriptsOnly,
    [switch] $RepairDrift,
    [switch] $IncludeOptional,
    [string] $HomeDir = [Environment]::GetFolderPath('UserProfile')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($CheckOnly -and $WhatIfPreference) {
    Write-Host 'Fehler / Error: -CheckOnly und / and -WhatIf sind nicht kombinierbar / cannot be combined.' -ForegroundColor Red
    exit 2
}
if ($RepairDrift -and ($CheckOnly -or $WhatIfPreference)) {
    Write-Host 'Fehler / Error: -RepairDrift ist nur im echten Lauf erlaubt / is only allowed in an actual run.' -ForegroundColor Red
    exit 2
}
if ($IncludeOptional -and $ScriptsOnly) {
    Write-Host 'Fehler / Error: -IncludeOptional passt nicht zu / cannot be combined with -ScriptsOnly.' -ForegroundColor Red
    exit 2
}

$sourceRoot = (Resolve-Path -LiteralPath (Split-Path -Parent $PSScriptRoot)).Path
$HomeDir = (Resolve-Path -LiteralPath $HomeDir).Path
$homeScriptsDir = Join-Path $HomeDir 'scripts'
if ((Test-Path -LiteralPath $homeScriptsDir -PathType Container) -and
    ((Resolve-Path -LiteralPath $PSScriptRoot).Path -eq (Resolve-Path -LiteralPath $homeScriptsDir).Path)) {
    . (Join-Path $PSScriptRoot 'lib/resolve-home-baseline-source.ps1')
    $sourceRoot = Resolve-HBSourceRepository -StartPath $PSScriptRoot -AllowLegacy
    $repoScript = Join-Path $sourceRoot 'scripts/maintain-agentic-workspace.ps1'
    if (-not (Test-Path -LiteralPath $repoScript -PathType Leaf)) {
        throw "Canonical maintenance script missing: $repoScript"
    }
    $forward = @{}
    if ($CheckOnly) { $forward.CheckOnly = $true }
    if ($ScriptsOnly) { $forward.ScriptsOnly = $true }
    if ($RepairDrift) { $forward.RepairDrift = $true }
    if ($IncludeOptional) { $forward.IncludeOptional = $true }
    if ($WhatIfPreference) { $forward.WhatIf = $true }
    $forward.HomeDir = $HomeDir
    & $repoScript @forward
    exit $LASTEXITCODE
}
$registry = Join-Path $HomeDir '.home-baseline/level2-repository-registry.json'
$stateDir = Join-Path $HomeDir '.home-baseline'
$lockDir = Join-Path $stateDir 'locks/agentic-workspace-maintenance.lock'
$logDir = Join-Path $stateDir 'logs'
$script:Findings = 0
$script:RepairApplied = $false
$exitCode = 0
$transcriptStarted = $false

function Write-HBInfo {
    param([Parameter(Mandatory)][string] $Message)
    Write-Host "`n==> $Message"
}

function Write-HBWarning {
    param([Parameter(Mandatory)][string] $Message)
    Write-Warning $Message
}

function Test-HBHomeSync {
    $syncScript = Join-Path $sourceRoot 'scripts/sync-home.ps1'
    & $syncScript -NoPull -CheckOnly
    $status = if ($null -eq $LASTEXITCODE) { 0 } else { $LASTEXITCODE }
    switch ($status) {
        0 { Write-Host 'OK: Lokale Home-Baseline ist manifestkonform / local home baseline matches manifest' }
        1 {
            Write-HBWarning 'Lokale Home-Baseline hat Drift oder Konflikte / local home baseline has drift or conflicts'
            $script:Findings++
        }
        default { throw 'sync-home Check fehlgeschlagen / check failed.' }
    }
}

function Invoke-HBGit {
    param(
        [Parameter(Mandatory)][string] $Repository,
        [Parameter(Mandatory)][string[]] $Arguments,
        [switch] $Capture
    )
    if ($Capture) {
        $output = & git -C $Repository @Arguments 2>$null
        if ($LASTEXITCODE -ne 0) {
            throw "git $($Arguments -join ' ') fehlgeschlagen / failed: ${Repository}"
        }
        return @($output)
    }
    & git -C $Repository @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "git $($Arguments -join ' ') fehlgeschlagen / failed: ${Repository}"
    }
}

function Get-HBGitCounts {
    param(
        [Parameter(Mandatory)][string] $Repository,
        [Parameter(Mandatory)][string] $Upstream
    )
    $raw = (Invoke-HBGit -Repository $Repository -Arguments @('rev-list', '--left-right', '--count', "HEAD...${Upstream}") -Capture) -join ' '
    $parts = $raw.Trim() -split '\s+'
    if ($parts.Count -ne 2) {
        throw "Unerwartete Ahead/Behind-Ausgabe / unexpected output: ${raw}"
    }
    return [pscustomobject]@{ Ahead = [int]$parts[0]; Behind = [int]$parts[1] }
}

function Test-HBRepository {
    param(
        [Parameter(Mandatory)][string] $Repository,
        [Parameter(Mandatory)][string] $Label,
        [switch] $AllowRepairDirty
    )

    if (-not (Test-Path -LiteralPath (Join-Path $Repository '.git'))) {
        Write-HBWarning "${Label} ist kein Git-Repository / is not a Git repository: ${Repository}"
        $script:Findings++
        return $false
    }

    $branch = (& git -C $Repository symbolic-ref --quiet --short HEAD 2>$null) -join ''
    if ($LASTEXITCODE -ne 0 -or -not $branch) {
        Write-HBWarning "${Label} hat einen detached HEAD / has a detached HEAD: ${Repository}"
        $script:Findings++
        return $false
    }
    $upstream = (& git -C $Repository rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>$null) -join ''
    if ($LASTEXITCODE -ne 0 -or -not $upstream) {
        Write-HBWarning "${Label} hat keinen Upstream / has no upstream: ${Repository} (${branch})"
        $script:Findings++
        return $false
    }

    $status = (& git -C $Repository status --porcelain=v1 --untracked-files=all) -join "`n"
    if ($status -and -not $AllowRepairDirty) {
        Write-HBWarning "${Label} ist nicht sauber / is dirty: ${Repository}"
        $script:Findings++
        return $false
    }

    Invoke-HBGit -Repository $Repository -Arguments @('fetch', '--prune')
    $counts = Get-HBGitCounts -Repository $Repository -Upstream $upstream
    if ($counts.Ahead -gt 0) {
        Write-HBWarning "${Label} ist $($counts.Ahead) Commit(s) voraus; kein automatischer Push / is ahead; no automatic push: ${Repository}"
        $script:Findings++
        return $false
    }
    if ($counts.Behind -gt 0) {
        if ($CheckOnly) {
            Write-HBWarning "${Label} ist $($counts.Behind) Commit(s) zurueck / is behind: ${Repository}"
            $script:Findings++
            return $false
        }
        if ($WhatIfPreference) {
            Write-Host "[WhatIf] git -C `"${Repository}`" pull --ff-only"
            return $true
        }
        Invoke-HBGit -Repository $Repository -Arguments @('pull', '--ff-only')
    }

    $counts = Get-HBGitCounts -Repository $Repository -Upstream $upstream
    if ($counts.Ahead -ne 0 -or $counts.Behind -ne 0) {
        Write-HBWarning "${Label} ist nach der Wartung nicht synchron / is not synchronized: ${Repository} ($($counts.Ahead)/$($counts.Behind))"
        $script:Findings++
        return $false
    }
    Write-Host "OK: ${Label}: ${Repository} (${branch}, 0/0)"
    return $true
}

function Test-HBManagedRepository {
    param([Parameter(Mandatory)][string] $Path)
    return (Test-Path -LiteralPath (Join-Path $Path '.git')) -and
        ((Test-Path -LiteralPath (Join-Path $Path 'AGENTS.md')) -or
         (Test-Path -LiteralPath (Join-Path $Path 'CLAUDE.md')))
}

function Get-HBManagedRepositories {
    $repos = @{}
    if (Test-Path -LiteralPath $HomeDir -PathType Container) {
        foreach ($path in Get-ChildItem -LiteralPath $HomeDir -Directory -Force -ErrorAction SilentlyContinue) {
            if ($path.FullName -eq $sourceRoot -or -not (Test-HBManagedRepository -Path $path.FullName)) { continue }
            $repos[$path.FullName] = 1
            foreach ($child in Get-ChildItem -LiteralPath $path.FullName -Directory -Force -ErrorAction SilentlyContinue) {
                if (Test-HBManagedRepository -Path $child.FullName) {
                    $repos[$child.FullName] = 2
                }
            }
        }
    }

    if (Test-Path -LiteralPath $registry -PathType Leaf) {
        $data = Get-Content -LiteralPath $registry -Raw | ConvertFrom-Json
        foreach ($entry in @($data.repositories)) {
            if ($entry.level -notin @(1, 2) -or -not $entry.path) { continue }
            $path = [IO.Path]::GetFullPath((Join-Path $HomeDir ([string]$entry.path)))
            if ($path.StartsWith($HomeDir, [StringComparison]::OrdinalIgnoreCase) -and
                $path -ne $sourceRoot -and -not $repos.ContainsKey($path) -and
                (Test-HBManagedRepository -Path $path)) {
                $repos[$path] = [int]$entry.level
            }
        }
    }

    return @(
        $repos.GetEnumerator() |
            ForEach-Object { [pscustomobject]@{ Path = $_.Key; Level = $_.Value } } |
            Sort-Object Level, Path
    )
}

function Test-HBRegistry {
    $registerScript = Join-Path $sourceRoot 'scripts/register-level2-repository.ps1'
    if (-not (Test-Path -LiteralPath $registerScript -PathType Leaf)) {
        throw "Registry-Skript fehlt / missing: ${registerScript}"
    }
    $level1 = @(Get-HBManagedRepositories | Where-Object Level -eq 1 | ForEach-Object Path)
    if ($level1.Count -eq 0) {
        if (-not (Test-Path -LiteralPath $registry -PathType Leaf)) {
            Write-HBWarning 'Keine Level-1-Wurzel fuer Registry-Aufbau gefunden / no Level-1 root found for registry creation.'
            $script:Findings++
            return
        }
        return
    }

    foreach ($root in $level1) {
        $rootParameters = @{
            Repo     = @($root)
            Level    = '1'
            Registry = $registry
            Source   = 'maintenance-discovery'
        }
        $childParameters = @{
            ScanRoot = @($root)
            Level    = '2'
            Registry = $registry
            Source   = 'maintenance-discovery'
        }
        if ($CheckOnly -or $WhatIfPreference) {
            $rootParameters.WhatIf = $true
            $childParameters.WhatIf = $true
        }
        if ($CheckOnly -or $WhatIfPreference) {
            $rootOutput = @(& $registerScript @rootParameters 6>&1)
            $childOutput = @(& $registerScript @childParameters 6>&1)
            @($rootOutput + $childOutput) | ForEach-Object { Write-Host "$_" }
            if (@($rootOutput + $childOutput) -match '^\[WhatIf\] (added|updated):') {
                Write-HBWarning 'Registry-Drift gefunden / registry drift found.'
                $script:Findings++
            }
        } else {
            & $registerScript @rootParameters
            & $registerScript @childParameters
        }
    }
    if (-not (Test-Path -LiteralPath $registry -PathType Leaf)) {
        Write-HBWarning "Registry fehlt und wuerde erzeugt / registry is missing and would be created: ${registry}"
        $script:Findings++
    }
}

function Invoke-HBPropagationCheck {
    $propagation = Join-Path $sourceRoot 'scripts/propagate-agentic-toolchain-maintenance.ps1'
    & $propagation -HomeDir $HomeDir -Registry $registry -CheckOnly
    return $LASTEXITCODE
}

function Invoke-HBPropagation {
    $propagation = Join-Path $sourceRoot 'scripts/propagate-agentic-toolchain-maintenance.ps1'
    if (-not (Test-Path -LiteralPath $propagation -PathType Leaf)) {
        throw "Propagationsskript fehlt / missing: ${propagation}"
    }

    if ($WhatIfPreference) {
        & $propagation -HomeDir $HomeDir -Registry $registry -DryRun
        if ($LASTEXITCODE -ne 0) { $script:Findings++ }
        return
    }

    $status = Invoke-HBPropagationCheck
    switch ($status) {
        0 { Write-Host 'OK: Wartungspaket ist homogen / maintenance package is homogeneous' }
        1 {
            if ($CheckOnly -or -not $RepairDrift) {
                Write-HBWarning 'Wartungspaket-Drift gefunden; fuer Reparatur -RepairDrift verwenden / use -RepairDrift to repair.'
                $script:Findings++
                return
            }
            & $propagation -HomeDir $HomeDir -Registry $registry -DryRun
            if ($LASTEXITCODE -ne 0) { throw 'Propagation-Vorschau fehlgeschlagen / preview failed.' }
            & $propagation -HomeDir $HomeDir -Registry $registry
            if ($LASTEXITCODE -ne 0) { throw 'Propagation fehlgeschlagen / failed.' }
            if ((Invoke-HBPropagationCheck) -ne 0) { throw 'Propagation-Abschlusspruefung fehlgeschlagen / final check failed.' }
            $script:RepairApplied = $true
        }
        default { throw 'Propagation konnte nicht sicher geprueft werden / could not be checked safely.' }
    }
}

function Get-HBPresetConfig {
    param([Parameter(Mandatory)][string] $ProfileName)
    switch ($ProfileName) {
        'standard-eight-governance-presets' {
            return (Join-Path $sourceRoot 'scripts/config/spec-kit-governance-presets.json')
        }
        'intake-review-nine-governance-presets' {
            return (Join-Path $sourceRoot 'scripts/config/spec-kit-intake-review-governance-presets.json')
        }
        'intake-authoring-ten-governance-presets' {
            return (Join-Path $sourceRoot 'scripts/config/spec-kit-intake-authoring-governance-presets.json')
        }
        'none' { return $null }
        default { throw "Unbekanntes Preset-Profil / unknown preset profile: ${ProfileName}" }
    }
}

function Get-HBPresetTargets {
    if (-not (Test-Path -LiteralPath $registry -PathType Leaf)) { return @() }
    $data = Get-Content -LiteralPath $registry -Raw | ConvertFrom-Json
    $defaultProfile = if (($data.PSObject.Properties.Name -contains 'defaultPresetProfile') -and $data.defaultPresetProfile) {
        [string]$data.defaultPresetProfile
    } else {
        'standard-eight-governance-presets'
    }
    $targets = @([pscustomobject]@{ Level = 0; Path = $sourceRoot; Profile = $defaultProfile })
    foreach ($entry in @($data.repositories)) {
        if (-not $entry.path -or $entry.level -notin @(1, 2)) { throw 'Ungueltiger Registry-Eintrag / invalid registry entry.' }
        $path = [IO.Path]::GetFullPath((Join-Path $HomeDir ([string]$entry.path)))
        if (-not $path.StartsWith($HomeDir, [StringComparison]::OrdinalIgnoreCase) -or
            -not (Test-Path -LiteralPath (Join-Path $path '.git'))) {
            throw "Registriertes Git-Repository fehlt oder liegt ausserhalb HOME / missing or outside HOME: ${path}"
        }
        $presetProfile = if (($entry.PSObject.Properties.Name -contains 'presetProfile') -and $entry.presetProfile) {
            [string]$entry.presetProfile
        } else {
            $defaultProfile
        }
        $targets += [pscustomobject]@{ Level = [int]$entry.level; Path = $path; Profile = $presetProfile }
    }
    return @($targets)
}

function Invoke-HBPresetProfiles {
    $installer = Join-Path $sourceRoot 'scripts/install-spec-kit-governance-presets.ps1'
    if (-not (Test-Path -LiteralPath $installer -PathType Leaf)) {
        throw "Preset-Installer fehlt / missing: ${installer}"
    }
    foreach ($target in Get-HBPresetTargets) {
        $config = Get-HBPresetConfig -ProfileName $target.Profile
        if (-not $config) { continue }
        if (-not (Test-Path -LiteralPath $config -PathType Leaf)) { throw "Preset-Matrix fehlt / missing: ${config}" }
        Write-HBInfo "Preset-Profil Level-$($target.Level): $($target.Path) -> $($target.Profile)"
        if ($WhatIfPreference) {
            & $installer -Repo @($target.Path) -PresetConfig $config -WhatIf
            continue
        }
        & $installer -Repo @($target.Path) -PresetConfig $config -CheckOnly
        if ($LASTEXITCODE -eq 0) { continue }
        if ($CheckOnly -or -not $RepairDrift) {
            Write-HBWarning "Preset-Profil-Drift gefunden / preset profile drift found: $($target.Path)"
            $script:Findings++
            continue
        }
        & $installer -Repo @($target.Path) -PresetConfig $config -Force
        if ($LASTEXITCODE -ne 0) { throw "Preset-Reparatur fehlgeschlagen / repair failed: $($target.Path)" }
        $script:RepairApplied = $true
    }
}

New-Item -ItemType Directory -Path (Split-Path -Parent $lockDir), $logDir -Force | Out-Null
try {
    New-Item -ItemType Directory -Path $lockDir -ErrorAction Stop | Out-Null
} catch {
    $holder = if (Test-Path (Join-Path $lockDir 'pid')) { Get-Content (Join-Path $lockDir 'pid') -Raw } else { 'unbekannt / unknown' }
    Write-Host "Fehler / Error: Wartung laeuft bereits (PID $($holder.Trim())) / maintenance already running." -ForegroundColor Red
    exit 2
}
Set-Content -LiteralPath (Join-Path $lockDir 'pid') -Value $PID
$logFile = Join-Path $logDir "agentic-workspace-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

try {
    Start-Transcript -Path $logFile -Append | Out-Null
    $transcriptStarted = $true
    $env:HOME = $HomeDir
    $env:USERPROFILE = $HomeDir

    $mode = if ($CheckOnly) { 'check-only' } elseif ($WhatIfPreference) { 'WhatIf' } else { 'update' }
    if ($ScriptsOnly) { $mode += ', scripts-only' }
    Write-Host 'Agentic workspace maintenance'
    Write-Host "Mode / Modus: ${mode}"
    Write-Host "Level-0: ${sourceRoot}"
    Write-Host "Home: ${HomeDir}"

    Write-HBInfo 'Level-0 aktualisieren / Update Level-0'
    [void](Test-HBRepository -Repository $sourceRoot -Label 'Level-0')

    if ($script:Findings -eq 0) {
        Write-HBInfo 'Lokale Home-Baseline synchronisieren / Synchronize local home baseline'
        $syncScript = Join-Path $sourceRoot 'scripts/sync-home.ps1'
        if ($CheckOnly) {
            Test-HBHomeSync
        } elseif ($WhatIfPreference) {
            & $syncScript -NoPull -WhatIf
        } else {
            & $syncScript -NoPull
        }
        if ($LASTEXITCODE -notin @(0, $null)) { throw 'sync-home fehlgeschlagen / failed.' }
    }

    Write-HBInfo 'Level-1/Level-2 ermitteln und Registry pruefen / Discover repositories and check registry'
    Test-HBRegistry

    if ($script:Findings -eq 0 -or $CheckOnly) {
        foreach ($repo in Get-HBManagedRepositories) {
            [void](Test-HBRepository -Repository $repo.Path -Label "Level-$($repo.Level)")
        }
    }

    if ($script:Findings -eq 0 -or $CheckOnly) {
        Write-HBInfo 'Kanonisches Wartungspaket pruefen / Check canonical maintenance package'
        if (Test-Path -LiteralPath $registry -PathType Leaf) {
            Invoke-HBPropagation
        }
    }

    if (($script:Findings -eq 0 -or $CheckOnly) -and (Test-Path -LiteralPath $registry -PathType Leaf)) {
        Write-HBInfo 'Registry-gesteuerte Preset-Profile pruefen / Check registry-controlled preset profiles'
        Invoke-HBPresetProfiles
    }

    if (($script:Findings -eq 0 -or $CheckOnly) -and -not $ScriptsOnly) {
        Write-HBInfo 'Maschinen-Toolchain pflegen / Maintain machine toolchain'
        $maintenance = Join-Path $sourceRoot 'scripts/maintain-agentic-winget-apps.ps1'
        $parameters = @{}
        if ($CheckOnly) { $parameters.CompareOnly = $true }
        if ($WhatIfPreference) { $parameters.WhatIf = $true }
        if ($IncludeOptional) { $parameters.IncludeOptional = $true }
        & $maintenance @parameters
        if ($LASTEXITCODE -notin @(0, $null)) { throw 'WinGet-Wartung fehlgeschlagen / maintenance failed.' }
    }

    if ($script:Findings -eq 0) {
        Write-HBInfo 'Abschlusspruefung / Final verification'
        Test-HBHomeSync
        if ((Invoke-HBPropagationCheck) -ne 0) { throw 'Abschliessende Propagationspruefung fehlgeschlagen / final propagation check failed.' }
        [void](Test-HBRepository -Repository $sourceRoot -Label 'Level-0')
        foreach ($repo in Get-HBManagedRepositories) {
            [void](Test-HBRepository -Repository $repo.Path -Label "Level-$($repo.Level)" -AllowRepairDirty:$script:RepairApplied)
        }
    }

    if ($script:Findings -gt 0) {
        Write-HBWarning "Wartung mit $($script:Findings) offenem Befund beendet / maintenance ended with open finding(s)."
        $exitCode = 1
    } elseif ($script:RepairApplied) {
        Write-HBWarning 'Drift wurde lokal repariert. Betroffene Repositories separat pruefen, committen und pushen.'
        Write-HBWarning 'Drift was repaired locally. Review, commit, and push affected repositories separately.'
        $exitCode = 3
    } else {
        Write-Host 'OK: Wartung abgeschlossen / maintenance completed'
    }
} catch {
    Write-Host "Fehler / Error: $($_.Exception.Message)" -ForegroundColor Red
    $exitCode = 2
} finally {
    if ($transcriptStarted) { Stop-Transcript | Out-Null }
    if (Test-Path -LiteralPath $lockDir) { Remove-Item -LiteralPath $lockDir -Recurse -Force }
    Write-Host "Log / log: ${logFile}"
}

exit $exitCode
