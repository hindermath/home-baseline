#Requires -Version 7
<#
.SYNOPSIS
    Orchestrates repository and agentic toolchain maintenance on Windows.

.DESCRIPTION
    Updates the Level-0 checkout and all active canonical-fleet Level-1/Level-2
    repositories declared by the desired-state manifest by fast-forward only,
    synchronizes the local home baseline, checks the local GSDB registry and
    canonical maintenance package, and then maintains the WinGet-based machine
    toolchain. The script never commits or pushes target repositories and never
    switches branches.

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

.PARAMETER AllowAdminPrompts
    Allow administrator prompts for the current run only. No credentials are
    stored or written to logs.

.PARAMETER ManifestPath
    Alternative desired-state fleet manifest, primarily for isolated tests.

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
    [switch] $AllowAdminPrompts,
    [string] $ManifestPath,
    [string] $HomeDir = [Environment]::GetFolderPath('UserProfile')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$script:HBMaintenanceScriptPath = $PSCommandPath

function Invoke-HBAgenticWorkspaceMaintenance {
    <#
    .SYNOPSIS
        Runs the cross-platform one-command workspace maintenance.
    .DESCRIPTION
        Invokes the repository-owned script with native PowerShell parameter
        binding. Use CheckOnly or WhatIf before an update run.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [switch] $CheckOnly,
        [switch] $ScriptsOnly,
        [switch] $RepairDrift,
        [switch] $IncludeOptional,
        [switch] $AllowAdminPrompts,
        [string] $ManifestPath,
        [string] $HomeDir = [Environment]::GetFolderPath('UserProfile')
    )
    $parameters = @{
        CheckOnly = $CheckOnly
        ScriptsOnly = $ScriptsOnly
        RepairDrift = $RepairDrift
        IncludeOptional = $IncludeOptional
        AllowAdminPrompts = $AllowAdminPrompts
        HomeDir = $HomeDir
    }
    if ($ManifestPath) { $parameters.ManifestPath = $ManifestPath }
    if ($WhatIfPreference) { $parameters.WhatIf = $true }
    & $script:HBMaintenanceScriptPath @parameters
}

if ($MyInvocation.InvocationName -eq '.') {
    return
}

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
$presetProfileCatalog = Join-Path $sourceRoot 'scripts/config/spec-kit-preset-profiles.json'
$fleetEngine = Join-Path $sourceRoot 'scripts/lib/agentic_workspace_fleet.py'
if (-not $ManifestPath) {
    $ManifestPath = Join-Path $sourceRoot 'scripts/config/agentic-workspace-fleet.json'
}
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
    if ($AllowAdminPrompts) { $forward.AllowAdminPrompts = $true }
    if ($ManifestPath) { $forward.ManifestPath = $ManifestPath }
    if ($WhatIfPreference) { $forward.WhatIf = $true }
    $forward.HomeDir = $HomeDir
    & $repoScript @forward
    exit $LASTEXITCODE
}
$registry = Join-Path $HomeDir '.home-baseline/level2-repository-registry.json'
$stateDir = Join-Path $HomeDir '.home-baseline'
$lockDir = Join-Path $stateDir 'locks/agentic-workspace-maintenance.lock'
$logDir = Join-Path $stateDir 'logs'
$reportDir = Join-Path $stateDir 'reports'
$script:Findings = 0
$script:RepairApplied = $false
$exitCode = 0
$transcriptStarted = $false
$runId = [Guid]::NewGuid().ToString()
$reportFile = Join-Path $reportDir "agentic-workspace-${runId}.json"
$pythonCommand = Get-Command python3, python -ErrorAction SilentlyContinue | Select-Object -First 1
if ($null -eq $pythonCommand) {
    throw 'Python 3 ist erforderlich / Python 3 is required.'
}
if (-not (Test-Path -LiteralPath $fleetEngine -PathType Leaf)) {
    throw "Fleet-Vertragskern fehlt / fleet contract engine missing: ${fleetEngine}"
}

function Add-HBReportStage {
    param(
        [Parameter(Mandatory)][string] $StageId,
        [Parameter(Mandatory)][ValidateSet('Passed', 'Warning', 'Blocked', 'Failed', 'Skipped')][string] $Status,
        [Parameter(Mandatory)][int] $ExitCode,
        [Parameter(Mandatory)][string] $Summary,
        [string] $NextAction = 'N/A'
    )
    if (-not (Test-Path -LiteralPath $reportFile -PathType Leaf)) { return }
    & $pythonCommand.Source $fleetEngine stage `
        --report $reportFile `
        --stage-id $StageId `
        --status $Status `
        --exit-code $ExitCode `
        --summary $Summary `
        --next-action $NextAction
    if ($LASTEXITCODE -ne 0) {
        throw "Run-Bericht konnte nicht aktualisiert werden / run report update failed: ${StageId}"
    }
}

function Invoke-HBFleetContract {
    $mode = if ($CheckOnly) { 'check-only' } elseif ($WhatIfPreference) { 'dry-run' } else { 'update' }
    & $pythonCommand.Source $fleetEngine fleet `
        --manifest $ManifestPath `
        --home-dir $HomeDir `
        --mode $mode `
        --report $reportFile `
        --log $logFile `
        --run-id $runId | ForEach-Object { Write-Host $_ }
    $status = $LASTEXITCODE
    return [int]$status
}

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

function Get-HBManagedRepositories {
    $lines = @(
        & $pythonCommand.Source $fleetEngine canonical-repositories `
            --manifest $ManifestPath `
            --home-dir $HomeDir `
            --existing-only
    )
    if ($LASTEXITCODE -ne 0) {
        throw 'Kanonische Fleet-Ziele konnten nicht ermittelt werden / canonical fleet targets could not be resolved.'
    }

    return @($lines | ForEach-Object {
        $fields = [string]$_ -split "`t", 2
        if ($fields.Count -ne 2 -or $fields[0] -notin @('1', '2')) {
            throw "Ungueltige Fleet-Zielausgabe / invalid fleet target output: $_"
        }
        [pscustomobject]@{ Path = $fields[1]; Level = [int]$fields[0] }
    })
}

function Test-HBRegistry {
    $registerScript = Join-Path $sourceRoot 'scripts/register-level2-repository.ps1'
    if (-not (Test-Path -LiteralPath $registerScript -PathType Leaf)) {
        throw "Registry-Skript fehlt / missing: ${registerScript}"
    }
    $repositories = @(Get-HBManagedRepositories)
    if ($repositories.Count -eq 0) {
        if (-not (Test-Path -LiteralPath $registry -PathType Leaf)) {
            Write-HBWarning 'Keine kanonischen Fleet-Ziele fuer Registry-Aufbau gefunden / no canonical fleet targets found for registry creation.'
            $script:Findings++
            return
        }
        return
    }

    foreach ($repository in $repositories) {
        $parameters = @{
            Repo     = @($repository.Path)
            Level    = [string]$repository.Level
            Registry = $registry
            Source   = 'maintenance-discovery'
        }
        if ($CheckOnly -or $WhatIfPreference) {
            $parameters.WhatIf = $true
        }
        if ($CheckOnly -or $WhatIfPreference) {
            $output = @(& $registerScript @parameters 6>&1)
            $output | ForEach-Object { Write-Host "$_" }
            if ($output -match '^\[WhatIf\] (added|updated):') {
                Write-HBWarning 'Registry-Drift gefunden / registry drift found.'
                $script:Findings++
            }
        } else {
            & $registerScript @parameters
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
    if (-not (Test-Path -LiteralPath $presetProfileCatalog -PathType Leaf)) {
        throw "Preset-Profilkatalog fehlt / missing: ${presetProfileCatalog}"
    }
    $catalog = Get-Content -LiteralPath $presetProfileCatalog -Raw | ConvertFrom-Json
    $property = $catalog.profiles.PSObject.Properties[$ProfileName]
    if ($null -eq $property) {
        throw "Unbekanntes Preset-Profil / unknown preset profile: ${ProfileName}"
    }
    $relative = $property.Value.presetConfig
    if ([string]::IsNullOrWhiteSpace([string]$relative)) { return $null }
    $config = [IO.Path]::GetFullPath((Join-Path $sourceRoot ([string]$relative)))
    if (-not $config.StartsWith($sourceRoot + [IO.Path]::DirectorySeparatorChar, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Preset-Konfiguration liegt ausserhalb der Quelle / outside source: ${config}"
    }
    return $config
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

function Get-HBDefaultRemoteRef {
    param([Parameter(Mandatory)][string] $Repository)

    $symbolic = (& git -C $Repository symbolic-ref --quiet refs/remotes/origin/HEAD 2>$null | Out-String).Trim()
    if ($LASTEXITCODE -eq 0 -and $symbolic) {
        & git -C $Repository show-ref --verify --quiet $symbolic
        if ($LASTEXITCODE -eq 0) { return $symbolic }
        return $null
    }

    $candidates = @()
    foreach ($candidate in @('refs/remotes/origin/main', 'refs/remotes/origin/master')) {
        & git -C $Repository show-ref --verify --quiet $candidate
        if ($LASTEXITCODE -eq 0) { $candidates += $candidate }
    }
    if ($candidates.Count -ne 1) { return $null }
    return $candidates[0]
}

function New-HBPresetValidationTarget {
    param([Parameter(Mandatory)][string] $Repository)

    if ($Repository -eq $sourceRoot) {
        if (-not (Test-Path -LiteralPath (Join-Path $Repository '.specify') -PathType Container)) {
            throw "Spec Kit ist nicht initialisiert / Spec Kit is not initialized: ${Repository}"
        }
        return [pscustomobject]@{ Path = $Repository; Isolated = $false; Root = $null; Repository = $Repository }
    }

    $defaultRef = Get-HBDefaultRemoteRef -Repository $Repository
    if (-not $defaultRef) {
        throw "Kanonischer origin-Default-Branch ist nicht eindeutig / canonical origin default branch is ambiguous: ${Repository}"
    }
    $currentCommit = (& git -C $Repository rev-parse HEAD 2>$null | Out-String).Trim()
    $defaultCommit = (& git -C $Repository rev-parse $defaultRef 2>$null | Out-String).Trim()
    if (
        (Test-Path -LiteralPath (Join-Path $Repository '.specify') -PathType Container) -and
        $currentCommit -and
        $currentCommit -eq $defaultCommit
    ) {
        return [pscustomobject]@{ Path = $Repository; Isolated = $false; Root = $null; Repository = $Repository }
    }

    & git -C $Repository cat-file -e "${defaultRef}:.specify/presets/.registry" 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Spec Kit ist auch auf ${defaultRef} nicht initialisiert / is not initialized on the canonical default ref: ${Repository}"
    }

    $root = Join-Path (Join-Path $HomeDir '.home-baseline') ("preset-validation." + [Guid]::NewGuid().ToString('N'))
    $worktree = Join-Path $root 'worktree'
    New-Item -ItemType Directory -Path $root -Force | Out-Null
    & git -C $Repository worktree add --detach $worktree $defaultRef | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Remove-Item -LiteralPath $root -Recurse -Force -ErrorAction SilentlyContinue
        throw "Temporärer Preset-Prüf-Worktree konnte nicht erstellt werden / temporary preset validation worktree failed: ${Repository}"
    }
    Write-HBInfo "Preset-Profil wird isoliert auf ${defaultRef} geprüft / validating preset profile on canonical ref"
    return [pscustomobject]@{ Path = $worktree; Isolated = $true; Root = $root; Repository = $Repository }
}

function Remove-HBPresetValidationTarget {
    param([Parameter(Mandatory)][object] $Target)

    if (-not $Target.Isolated) { return }
    & git -C $Target.Repository worktree remove --force $Target.Path 2>$null
    Remove-Item -LiteralPath $Target.Root -Recurse -Force -ErrorAction SilentlyContinue
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
        $validationTarget = $null
        try {
            $validationTarget = New-HBPresetValidationTarget -Repository $target.Path
            if ($WhatIfPreference) {
                & $installer -Repo @($validationTarget.Path) -PresetConfig $config -WhatIf
                continue
            }
            & $installer -Repo @($validationTarget.Path) -PresetConfig $config -CheckOnly
            if ($LASTEXITCODE -eq 0) { continue }
            if ($validationTarget.Isolated) {
                Write-HBWarning "Preset-Profil-Drift auf dem kanonischen Default-Branch erfordert einen eigenen Branch/PR / requires a dedicated branch/PR: $($target.Path)"
                $script:Findings++
                continue
            }
            if ($CheckOnly -or -not $RepairDrift) {
                Write-HBWarning "Preset-Profil-Drift gefunden / preset profile drift found: $($target.Path)"
                $script:Findings++
                continue
            }
            & $installer -Repo @($target.Path) -PresetConfig $config -Force
            if ($LASTEXITCODE -ne 0) { throw "Preset-Reparatur fehlgeschlagen / repair failed: $($target.Path)" }
            $script:RepairApplied = $true
        } catch {
            Write-HBWarning $_.Exception.Message
            $script:Findings++
        } finally {
            if ($null -ne $validationTarget) {
                Remove-HBPresetValidationTarget -Target $validationTarget
            }
        }
    }
}

New-Item -ItemType Directory -Path (Split-Path -Parent $lockDir), $logDir, $reportDir -Force | Out-Null
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
    Write-Host "Run-ID: ${runId}"

    Write-HBInfo 'Level-0 aktualisieren / Update Level-0'
    $level0Passed = Test-HBRepository -Repository $sourceRoot -Label 'Level-0'

    $homeStatus = 'Skipped'
    if ($script:Findings -eq 0) {
        Write-HBInfo 'Lokale Home-Baseline synchronisieren / Synchronize local home baseline'
        $findingsBefore = $script:Findings
        $syncScript = Join-Path $sourceRoot 'scripts/sync-home.ps1'
        if ($CheckOnly) {
            Test-HBHomeSync
        } elseif ($WhatIfPreference) {
            & $syncScript -NoPull -WhatIf
        } else {
            & $syncScript -NoPull
        }
        if ($LASTEXITCODE -notin @(0, $null)) { throw 'sync-home fehlgeschlagen / failed.' }
        $homeStatus = if ($script:Findings -gt $findingsBefore) { 'Blocked' } else { 'Passed' }
    }

    Write-HBInfo 'Soll-Flotte pruefen und sicher warten / Check and safely maintain desired fleet'
    $fleetStatus = Invoke-HBFleetContract
    switch ($fleetStatus) {
        0 { }
        1 { $script:Findings++ }
        default {
            Add-HBReportStage -StageId 'fleet' -Status Failed -ExitCode 2 `
                -Summary 'Fleet-Vertrag fehlgeschlagen / fleet contract failed' `
                -NextAction 'Manifest und Log pruefen / review manifest and log'
            throw 'Fleet-Vertrag fehlgeschlagen / fleet contract failed.'
        }
    }
    Add-HBReportStage -StageId 'level0' -Status $(if ($level0Passed) { 'Passed' } else { 'Blocked' }) `
        -ExitCode $(if ($level0Passed) { 0 } else { 1 }) `
        -Summary 'Level-0-Pruefung / Level-0 check' `
        -NextAction $(if ($level0Passed) { 'N/A' } else { 'Branch und Upstream pruefen / review branch and upstream' })
    Add-HBReportStage -StageId 'home-sync' -Status $homeStatus `
        -ExitCode $(if ($homeStatus -eq 'Blocked') { 1 } else { 0 }) `
        -Summary 'Home-Sync / home sync' `
        -NextAction $(if ($homeStatus -eq 'Skipped') { 'Nach Level-0-Freigabe erneut ausfuehren / rerun after Level-0 passes' } else { 'N/A' })

    Write-HBInfo 'Level-1/Level-2 Registry pruefen / Check Level-1/Level-2 registry'
    $findingsBefore = $script:Findings
    Test-HBRegistry
    $registrySafe = $false
    if (Test-Path -LiteralPath $registry -PathType Leaf) {
        & $pythonCommand.Source $fleetEngine registry --manifest $ManifestPath --registry $registry |
            ForEach-Object { Write-Host $_ }
        $registryStatus = $LASTEXITCODE
        $registrySafe = $registryStatus -eq 0
        if (-not $registrySafe) { $script:Findings++ }
    }
    if ($script:Findings -gt $findingsBefore -or -not $registrySafe) {
        Add-HBReportStage -StageId 'registry' -Status Blocked -ExitCode 1 `
            -Summary 'Registry-Pruefung mit Befund / registry check has findings' `
            -NextAction 'Registry-Befund beheben / resolve registry finding'
    } else {
        Add-HBReportStage -StageId 'registry' -Status Passed -ExitCode 0 `
            -Summary 'Registry-Pruefung abgeschlossen / registry check completed'
    }

    if (($script:Findings -eq 0 -or $CheckOnly) -and $registrySafe) {
        Write-HBInfo 'Kanonisches Wartungspaket pruefen / Check canonical maintenance package'
        if (Test-Path -LiteralPath $registry -PathType Leaf) {
            $findingsBefore = $script:Findings
            Invoke-HBPropagation
            if ($script:Findings -gt $findingsBefore) {
                Add-HBReportStage -StageId 'propagation' -Status Blocked -ExitCode 1 `
                    -Summary 'Wartungspaket-Drift / maintenance package drift' `
                    -NextAction 'Drift separat pruefen / review drift separately'
            } else {
                Add-HBReportStage -StageId 'propagation' -Status Passed -ExitCode 0 `
                    -Summary 'Wartungspaket geprueft / maintenance package checked'
            }
        }
    } else {
        Add-HBReportStage -StageId 'propagation' -Status Skipped -ExitCode 0 `
            -Summary 'Propagation wegen Vorbedingung uebersprungen / skipped by prerequisite' `
            -NextAction 'Blockierende Vorbedingung beheben / resolve blocking prerequisite'
    }

    if (($script:Findings -eq 0 -or $CheckOnly) -and $registrySafe) {
        Write-HBInfo 'Registry-gesteuerte Preset-Profile pruefen / Check registry-controlled preset profiles'
        $findingsBefore = $script:Findings
        Invoke-HBPresetProfiles
        if ($script:Findings -gt $findingsBefore) {
            Add-HBReportStage -StageId 'preset-profiles' -Status Blocked -ExitCode 1 `
                -Summary 'Preset-Profil-Befund / preset profile finding' `
                -NextAction 'Preset-Drift separat beheben / resolve preset drift separately'
        } else {
            Add-HBReportStage -StageId 'preset-profiles' -Status Passed -ExitCode 0 `
                -Summary 'Preset-Profile geprueft / preset profiles checked'
        }
    } else {
        Add-HBReportStage -StageId 'preset-profiles' -Status Skipped -ExitCode 0 `
            -Summary 'Preset-Pruefung wegen Vorbedingung uebersprungen / skipped by prerequisite' `
            -NextAction 'Blockierende Vorbedingung beheben / resolve blocking prerequisite'
    }

    if (($script:Findings -eq 0 -or $CheckOnly) -and -not $ScriptsOnly) {
        Write-HBInfo 'Maschinen-Toolchain pflegen / Maintain machine toolchain'
        $maintenance = Join-Path $sourceRoot 'scripts/maintain-agentic-winget-apps.ps1'
        $parameters = @{}
        if ($CheckOnly) { $parameters.CompareOnly = $true }
        if ($WhatIfPreference) { $parameters.WhatIf = $true }
        $optionalDeferred = $IncludeOptional -and -not $AllowAdminPrompts
        if ($IncludeOptional -and $AllowAdminPrompts) { $parameters.IncludeOptional = $true }
        if ($optionalDeferred) {
            Write-HBWarning 'DEFERRED_ADMIN_REQUIRED: optionale Pakete benoetigen aktuelle Admin-Prompt-Autoritaet / optional packages require current authority.'
        }
        $env:HB_ALLOW_ADMIN_PROMPTS = if ($AllowAdminPrompts) { '1' } else { '0' }
        & $maintenance @parameters
        if ($LASTEXITCODE -notin @(0, $null)) { throw 'WinGet-Wartung fehlgeschlagen / maintenance failed.' }
        if ($optionalDeferred) {
            Add-HBReportStage -StageId 'toolchain' -Status Warning -ExitCode 0 `
                -Summary 'DEFERRED_ADMIN_REQUIRED' `
                -NextAction 'Mit aktueller Autoritaet erneut ausfuehren / rerun with current authority'
        } else {
            Add-HBReportStage -StageId 'toolchain' -Status Passed -ExitCode 0 `
                -Summary 'Toolchain-Wartung abgeschlossen / toolchain maintenance completed'
        }
    } else {
        Add-HBReportStage -StageId 'toolchain' -Status Skipped -ExitCode 0 `
            -Summary 'Toolchain durch Modus oder Vorbedingung uebersprungen / skipped by mode or prerequisite'
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
        Add-HBReportStage -StageId 'final' -Status Blocked -ExitCode 1 `
            -Summary 'Wartung mit offenen Befunden / maintenance has open findings' `
            -NextAction 'Befunde im Bericht beheben / resolve report findings'
        Write-HBWarning "Wartung mit $($script:Findings) offenem Befund beendet / maintenance ended with open finding(s)."
        $exitCode = 1
    } elseif ($script:RepairApplied) {
        Add-HBReportStage -StageId 'final' -Status Warning -ExitCode 3 `
            -Summary 'Drift lokal repariert / drift repaired locally' `
            -NextAction 'Aenderungen separat pruefen / review changes separately'
        Write-HBWarning 'Drift wurde lokal repariert. Betroffene Repositories separat pruefen, committen und pushen.'
        Write-HBWarning 'Drift was repaired locally. Review, commit, and push affected repositories separately.'
        $exitCode = 3
    } else {
        Add-HBReportStage -StageId 'final' -Status Passed -ExitCode 0 `
            -Summary 'Wartung abgeschlossen / maintenance completed'
        Write-Host 'OK: Wartung abgeschlossen / maintenance completed'
    }
} catch {
    Write-Host "Fehler / Error: $($_.Exception.Message)" -ForegroundColor Red
    $exitCode = 2
} finally {
    if ($transcriptStarted) { Stop-Transcript | Out-Null }
    if (Test-Path -LiteralPath $lockDir) { Remove-Item -LiteralPath $lockDir -Recurse -Force }
    Write-Host "Log / log: ${logFile}"
    if (Test-Path -LiteralPath $reportFile -PathType Leaf) {
        Write-Host "Report / Bericht: ${reportFile}"
    }
}

exit $exitCode
