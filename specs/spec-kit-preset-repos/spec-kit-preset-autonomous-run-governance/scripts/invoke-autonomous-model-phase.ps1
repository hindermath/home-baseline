#Requires -Version 7.0
<#
.SYNOPSIS
    Fuehrt genau eine modellgeroutete Phase eines autonomen Spec-Kit-Laufs aus.

.DESCRIPTION
    DE: Loest die staerkste agentenneutrale Routing-Rolle fuer ein Preset-
    Kommando auf, bindet sie an ein lokales Runner-Profil und fuehrt Preflight
    und Phase ohne Shell-Evaluation aus. Modellwechsel erfolgen nur zwischen
    Prozessen. Fehlende oder nicht verfuegbare Profile blockieren fail-closed.

    EN: Resolves the strongest agent-neutral routing role for a preset command,
    binds it to a local runner profile, and executes preflight and phase without
    shell evaluation. Model changes occur only between processes. Missing or
    unavailable profiles fail closed.

    DE: TerminalAwareRunnerAdoption gilt ausschliesslich fuer die exakte Phase
    implement-closeout. Nach semantischer Resultatpruefung wird ein bereits
    vom Child publizierter Completed/168/168-State neu geladen und nur bei
    vollstaendiger Identitaets-, Hash-, Tasks-, Git- und Closeout-Bindung
    adoptiert. Danach schreibt der Parent weder im Haupt- noch im Catch-Pfad
    Featuredateien. Ergebnis und Log bleiben runnerLocal-Evidence im gebundenen
    OutputDirectory. Ein absichtlich als Verzeichnis blockierter Logpfad bleibt
    nicht blockierend; ein vorhandener Logpfad mit falschem Pfad, Bytes oder
    Hash blockiert die Terminaladoption. Jede andere Drift verlangt
    read-only Reconciliation. Normale Success- und definitive Failure-Pfade
    ohne Drift behalten ihre bisherigen atomaren Parent-Writes.

    EN: TerminalAwareRunnerAdoption applies only to exact implement-closeout.
    After semantic result validation, a child-published Completed/168/168 state
    is reloaded and adopted only when identity, hashes, tasks, Git relation,
    and closeout fields match exactly. The parent then performs no feature-file
    write in main or catch. Result and log remain runnerLocal evidence inside
    the bound OutputDirectory. A deliberately directory-blocked log path stays
    non-blocking; an existing log with the wrong path, bytes, or hash blocks
    terminal adoption. Every other drift requires read-only
    reconciliation. Normal success and definite failure without drift keep
    their existing atomic parent writes.

    DE: Die Adoption bindet die exakten feature-lokalen State-/Tasks-Pfade,
    den installierten State-Validator, Completed-Preflight, Katalog und Profil,
    symlinkfreie Pfade, committed Blobs, sauberen Index/Worktree sowie lokale
    und remote Default-Refs auf HEAD. Der zweite TOCTOU-Tupel bindet zusaetzlich
    State-, Tasks-, Result-, Payload- und Logbytes sowie Index und Worktree.

    EN: Adoption binds the exact feature-local State/Tasks paths, installed
    state validator, Completed preflight, catalog and profile, symlink-free
    paths, committed blobs, clean index/worktree, and local and remote default
    refs at HEAD. The second TOCTOU tuple additionally binds State, Tasks,
    result, payload, and log bytes plus index and worktree.

    Der Runner erteilt keine Provider-, Delivery-, Bypass-, Home-, Secret-,
    Subscription-, Budget-, Cancellation- oder Position-7-Autoritaet.
    The runner grants no provider, delivery, bypass, Home, secret,
    subscription, budget, cancellation, or Position-7 authority.

.PARAMETER Action
    Validate, Run oder Status.

.PARAMETER State
    Feature-lokaler autonomous-run-state.json.

.PARAMETER RunnerConfig
    Lokale, nicht versionierte JSON-Datei mit Agent- und Modellprofilen.

.PARAMETER RoutingRoot
    Verzeichnis mit installierten Presets und model-routing.json-Dateien.

.PARAMETER PhaseId
    Stabile ID der bei Run auszufuehrenden Phase.

.PARAMETER Worktree
    Repository beziehungsweise Worktree fuer den Agentenprozess.

.PARAMETER Prompt
    Zusaetzlicher, nicht geheimer Phasenauftrag.

.PARAMETER PromptFile
    Alternative UTF-8-Datei mit dem zusaetzlichen Phasenauftrag.

.PARAMETER OutputDirectory
    Lokaler, nicht versionierter Ergebnis- und Logbereich.

.PARAMETER OutputFormat
    Json oder barrierearmer Text.

.EXAMPLE
    pwsh -NoProfile -File scripts/invoke-autonomous-model-phase.ps1 -Action Validate -State specs/025-feature/autonomous-run-state.json -RunnerConfig ~/.home-baseline/spec-kit/runner-profiles.local.json

.EXAMPLE
    pwsh -NoProfile -File scripts/invoke-autonomous-model-phase.ps1 -Action Run -State specs/025-feature/autonomous-run-state.json -RunnerConfig ~/.home-baseline/spec-kit/runner-profiles.local.json -PhaseId plan-review -Prompt 'Review the accepted plan.'
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory)]
    [ValidateSet('Validate', 'Run', 'Status')]
    [string] $Action,

    [Parameter(Mandatory)]
    [string] $State,

    [string] $RunnerConfig = '',
    [string] $RoutingRoot = '',
    [string] $PhaseId = '',
    [string] $Worktree = '',
    [string] $Prompt = '',
    [string] $PromptFile = '',
    [string] $OutputDirectory = '',
    [ValidateSet('Json', 'Text')]
    [string] $OutputFormat = 'Json'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script:AllowedRoles = @(
    'script-only',
    'fast-mechanical',
    'long-running-implementation',
    'coding-review',
    'frontier-reasoning'
)
$script:RoleRank = @{
    'script-only' = 0
    'fast-mechanical' = 10
    'long-running-implementation' = 20
    'coding-review' = 30
    'frontier-reasoning' = 40
}
$script:AllowedPhaseStatuses = @(
    'Pending', 'Running', 'Completed', 'Blocked', 'Failed', 'NeedsRevalidation'
)

function Assert-AMRCondition {
    param(
        [Parameter(Mandatory)][bool] $Condition,
        [Parameter(Mandatory)][string] $Message
    )

    if (-not $Condition) {
        throw $Message
    }
}

function Read-AMRJson {
    param([Parameter(Mandatory)][string] $Path)

    Assert-AMRCondition (Test-Path -LiteralPath $Path -PathType Leaf) "JSON-Datei fehlt: $Path"
    try {
        return Get-Content -LiteralPath $Path -Raw -Encoding utf8 | ConvertFrom-Json -AsHashtable
    } catch {
        throw "Ungueltiges UTF-8-JSON in ${Path}: $($_.Exception.Message)"
    }
}

function Write-AMRJsonAtomic {
    param(
        [Parameter(Mandatory)][string] $Path,
        [Parameter(Mandatory)] $Value
    )

    $parent = Split-Path -Parent $Path
    if ($parent) {
        [void](New-Item -ItemType Directory -Path $parent -Force)
    }
    $temporaryPath = "${Path}.tmp.$PID"
    try {
        $Value | ConvertTo-Json -Depth 30 | Set-Content -LiteralPath $temporaryPath -Encoding utf8NoBOM
        Move-Item -LiteralPath $temporaryPath -Destination $Path -Force
    } finally {
        Remove-Item -LiteralPath $temporaryPath -Force -ErrorAction SilentlyContinue
    }
}

function Get-AMRRepositoryRoot {
    param([Parameter(Mandatory)][string] $StatePath)

    $featureDirectory = Split-Path -Parent ([IO.Path]::GetFullPath($StatePath))
    $specsDirectory = Split-Path -Parent $featureDirectory
    return Split-Path -Parent $specsDirectory
}

function Get-AMRRoutingCatalog {
    param([Parameter(Mandatory)][string] $Root)

    Assert-AMRCondition (Test-Path -LiteralPath $Root -PathType Container) "RoutingRoot fehlt: $Root"
    $effective = @{}
    $sources = @{}
    $catalogPaths = @(Get-ChildItem -LiteralPath $Root -Filter 'model-routing.json' -File -Recurse)
    Assert-AMRCondition ($catalogPaths.Count -gt 0) "Keine model-routing.json unter $Root gefunden."

    foreach ($catalogPath in $catalogPaths) {
        $catalog = Read-AMRJson $catalogPath.FullName
        Assert-AMRCondition ([string] $catalog.schemaVersion -eq '1.0') "Routing-Schema muss 1.0 sein: $($catalogPath.FullName)"
        Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace([string] $catalog.presetId)) "presetId fehlt: $($catalogPath.FullName)"
        Assert-AMRCondition ([string] $catalog.fallbackPolicy -eq 'fail-closed') "fallbackPolicy muss fail-closed sein: $($catalogPath.FullName)"
        Assert-AMRCondition ($catalog.commands -is [hashtable]) "commands muss ein Objekt sein: $($catalogPath.FullName)"
        Assert-AMRCondition ($script:AllowedRoles -contains [string] $catalog.defaultRole) "Ungueltige defaultRole: $($catalogPath.FullName)"

        foreach ($entry in $catalog.commands.GetEnumerator()) {
            $commandName = [string] $entry.Key
            $roleName = [string] $entry.Value
            Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace($commandName)) "Leerer Kommandoname: $($catalogPath.FullName)"
            Assert-AMRCondition ($script:AllowedRoles -contains $roleName) "Ungueltige Rolle '$roleName' fuer $commandName"
            if (-not $effective.ContainsKey($commandName) -or
                $script:RoleRank[$roleName] -gt $script:RoleRank[[string] $effective[$commandName]]) {
                $effective[$commandName] = $roleName
            }
            if (-not $sources.ContainsKey($commandName)) {
                $sources[$commandName] = @()
            }
            $sources[$commandName] = @($sources[$commandName]) + [ordered]@{
                presetId = [string] $catalog.presetId
                role = $roleName
            }
        }
    }

    return [ordered]@{
        commands = $effective
        sources = $sources
    }
}

function Get-AMRPhase {
    param(
        [Parameter(Mandatory)][hashtable] $StateData,
        [string] $RequestedPhaseId = ''
    )

    Assert-AMRCondition ($StateData.routing -is [hashtable]) 'State.routing fehlt.'
    Assert-AMRCondition ([string] $StateData.routing.policy -eq 'balanced-v1') 'State.routing.policy muss balanced-v1 sein.'
    Assert-AMRCondition ([string] $StateData.routing.fallbackPolicy -eq 'fail-closed') 'State.routing.fallbackPolicy muss fail-closed sein.'
    Assert-AMRCondition ($StateData.routing.phases -is [object[]]) 'State.routing.phases muss ein Array sein.'

    $phaseIds = [Collections.Generic.HashSet[string]]::new([StringComparer]::Ordinal)
    $selected = $null
    foreach ($phase in @($StateData.routing.phases)) {
        Assert-AMRCondition ($phase -is [hashtable]) 'Jede Routing-Phase muss ein Objekt sein.'
        $currentId = [string] $phase.phaseId
        Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace($currentId)) 'Routing phaseId fehlt.'
        Assert-AMRCondition ($phaseIds.Add($currentId)) "Doppelte routing phaseId: $currentId"
        Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace([string] $phase.command)) "Routing command fehlt: $currentId"
        Assert-AMRCondition ($script:AllowedRoles -contains [string] $phase.routingRole) "Ungueltige routingRole: $currentId"
        Assert-AMRCondition ($script:AllowedPhaseStatuses -contains [string] $phase.status) "Ungueltiger Phasenstatus: $currentId"
        if ($currentId -eq $RequestedPhaseId) {
            $selected = $phase
        }
    }
    if (-not [string]::IsNullOrWhiteSpace($RequestedPhaseId)) {
        Assert-AMRCondition ($null -ne $selected) "Routing-Phase nicht gefunden: $RequestedPhaseId"
    }
    return $selected
}

function Assert-AMRPhaseContract {
    param(
        [Parameter(Mandatory)][hashtable] $StateData,
        [Parameter(Mandatory)][hashtable] $Catalog
    )

    [void](Get-AMRPhase $StateData '')
    foreach ($phase in @($StateData.routing.phases)) {
        $commandName = [string] $phase.command
        Assert-AMRCondition $Catalog.commands.ContainsKey($commandName) "Kein Routing-Vertrag fuer Kommando: $commandName"
        $effectiveRole = [string] $Catalog.commands[$commandName]
        Assert-AMRCondition ([string] $phase.routingRole -eq $effectiveRole) "Routing-Rolle fuer $commandName muss '$effectiveRole' sein."
        $dependencies = if ($phase.ContainsKey('dependsOn')) { @($phase.dependsOn) } else { @() }
        foreach ($dependency in $dependencies) {
            Assert-AMRCondition (@($StateData.routing.phases | Where-Object { [string] $_.phaseId -eq [string] $dependency }).Count -eq 1) "Unbekannte Phasenabhaengigkeit '$dependency'."
        }
    }
}

function Get-AMRRunnerProfile {
    param(
        [Parameter(Mandatory)][hashtable] $RunnerData,
        [Parameter(Mandatory)][hashtable] $Phase
    )

    Assert-AMRCondition ([string] $RunnerData.schemaVersion -in @('1.0', '1.1', '2.0')) 'RunnerConfig schemaVersion muss 1.0, 1.1 oder 2.0 sein.'
    Assert-AMRCondition ($RunnerData.profiles -is [hashtable]) 'RunnerConfig.profiles muss ein Objekt sein.'
    $phaseProfile = if ($Phase.ContainsKey('runnerProfile')) { [string] $Phase.runnerProfile } else { 'N/A' }
    if (-not [string]::IsNullOrWhiteSpace($phaseProfile) -and $phaseProfile -ne 'N/A') {
        Assert-AMRCondition $RunnerData.profiles.ContainsKey($phaseProfile) "Runner-Profil fehlt: $phaseProfile"
        $profileName = $phaseProfile
    } else {
        $matching = @($RunnerData.profiles.GetEnumerator() | Where-Object {
            [string] $_.Value.routingRole -eq [string] $Phase.routingRole
        })
        Assert-AMRCondition ($matching.Count -eq 1) "Routing-Rolle '$($Phase.routingRole)' benoetigt genau ein lokales Runner-Profil."
        $profileName = [string] $matching[0].Key
    }

    $runnerProfileData = $RunnerData.profiles[$profileName]
    Assert-AMRCondition ([string] $runnerProfileData.routingRole -eq [string] $Phase.routingRole) "Runner-Profil '$profileName' hat die falsche routingRole."
    Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace([string] $runnerProfileData.agentFamily)) "agentFamily fehlt: $profileName"
    Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace([string] $runnerProfileData.executable)) "executable fehlt: $profileName"
    Assert-AMRCondition ($runnerProfileData.arguments -is [object[]]) "arguments muss ein Array sein: $profileName"
    Assert-AMRCondition ([string] $Phase.routingRole -ne 'script-only') "script-only-Phase '$($Phase.phaseId)' muss direkt ohne Modellprozess ausgefuehrt werden."
    Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace([string] $runnerProfileData.model)) "model fehlt fuer fail-closed Profil: $profileName"
    Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace([string] $runnerProfileData.reasoningEffort)) "reasoningEffort fehlt fuer fail-closed Profil: $profileName"
    Assert-AMRCondition ($runnerProfileData.preflight -is [hashtable]) "preflight fehlt fuer fail-closed Profil: $profileName"
    Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace([string] $runnerProfileData.preflight.executable)) "preflight.executable fehlt: $profileName"
    Assert-AMRCondition ($runnerProfileData.preflight.arguments -is [object[]]) "preflight.arguments muss ein Array sein: $profileName"
    Assert-AMRCondition ($null -ne (Get-Command ([string] $runnerProfileData.executable) -ErrorAction SilentlyContinue)) "Runner executable nicht gefunden: $($runnerProfileData.executable)"
    Assert-AMRCondition ($null -ne (Get-Command ([string] $runnerProfileData.preflight.executable) -ErrorAction SilentlyContinue)) "Preflight executable nicht gefunden: $($runnerProfileData.preflight.executable)"

    return [ordered]@{
        name = $profileName
        data = $runnerProfileData
    }
}

function ConvertTo-AMRArguments {
    param(
        [Parameter(Mandatory)][object[]] $Arguments,
        [Parameter(Mandatory)][hashtable] $Values
    )

    $resolved = [Collections.Generic.List[string]]::new()
    foreach ($argument in $Arguments) {
        $value = [string] $argument
        foreach ($entry in $Values.GetEnumerator()) {
            $value = $value.Replace("{$($entry.Key)}", [string] $entry.Value)
        }
        $resolved.Add($value)
    }
    return $resolved.ToArray()
}

function Invoke-AMRCommand {
    param(
        [Parameter(Mandatory)][hashtable] $CommandProfile,
        [Parameter(Mandatory)][hashtable] $Values,
        [Parameter(Mandatory)][string] $WorkingDirectory
    )

    $arguments = ConvertTo-AMRArguments @($CommandProfile.arguments) $Values
    Push-Location -LiteralPath $WorkingDirectory
    try {
        $output = @(& ([string] $CommandProfile.executable) @arguments 2>&1)
        $exitCode = if ($null -eq $LASTEXITCODE) { 0 } else { $LASTEXITCODE }
    } finally {
        Pop-Location
    }
    return [ordered]@{
        exitCode = $exitCode
        output = @($output | ForEach-Object { [string] $_ })
    }
}

function Set-AMRBlockedState {
    param(
        [Parameter(Mandatory)][hashtable] $StateData,
        [Parameter(Mandatory)][hashtable] $Phase,
        [Parameter(Mandatory)][string] $Reason,
        [Parameter(Mandatory)][string] $OperationKind
    )

    $timestamp = [DateTime]::UtcNow.ToString('o')
    $Phase.status = 'Blocked'
    $Phase.updatedAt = $timestamp
    $StateData.status = 'Blocked'
    $StateData.authorityRevalidationRequired = $true
    $StateData.nextExactAction = "Resolve routing blocker for phase '$($Phase.phaseId)' and resume explicitly."
    $StateData.lastOperation = [ordered]@{
        kind = $OperationKind
        state = 'Failed'
        summary = $Reason
    }
    $StateData.stop = [ordered]@{
        reason = $Reason
        requestedAt = $timestamp
        safeBoundary = "Before phase '$($Phase.phaseId)' completion"
    }
    $StateData.updatedAt = $timestamp
}

function Get-AMRFileSnapshot {
    param([Parameter(Mandatory)][string] $Path)

    $bytes = [IO.File]::ReadAllBytes($Path)
    return [ordered]@{
        bytes = $bytes
        sha256 = [Convert]::ToHexString(
            [Security.Cryptography.SHA256]::HashData($bytes)
        ).ToLowerInvariant()
    }
}

function Test-AMRFileSnapshot {
    param(
        [Parameter(Mandatory)][string] $Path,
        [Parameter(Mandatory)][hashtable] $Snapshot
    )

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { return $false }
    $current = Get-AMRFileSnapshot $Path
    return [string] $current.sha256 -eq [string] $Snapshot.sha256 -and
        [Linq.Enumerable]::SequenceEqual[byte]([byte[]] $current.bytes, [byte[]] $Snapshot.bytes)
}

function Resolve-AMRContainedFile {
    param(
        [Parameter(Mandatory)][string] $Root,
        [Parameter(Mandatory)][string] $Path,
        [Parameter(Mandatory)][string] $Label
    )

    Assert-AMRCondition (-not [IO.Path]::IsPathRooted($Path)) "$Label muss relativ sein."
    Assert-AMRCondition (-not (@($Path -split '[\\/]' | Where-Object { $_ -eq '..' }).Count -gt 0)) "$Label enthaelt '..'."
    $rootFull = [IO.Path]::GetFullPath($Root).TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar
    $full = [IO.Path]::GetFullPath((Join-Path $Root $Path))
    Assert-AMRCondition $full.StartsWith($rootFull, [StringComparison]::Ordinal) "$Label verlaesst den gebundenen Root."
    Assert-AMRCondition (Test-Path -LiteralPath $full -PathType Leaf) "$Label fehlt: $Path"
    $cursor = Get-Item -LiteralPath $full -Force
    while ($null -ne $cursor -and $cursor.FullName.StartsWith($rootFull, [StringComparison]::Ordinal)) {
        Assert-AMRCondition (-not ($cursor.Attributes -band [IO.FileAttributes]::ReparsePoint)) "$Label oder ein Vorfahr darf kein Symlink oder Reparse Point sein."
        $cursor = if ($cursor -is [IO.FileInfo]) { $cursor.Directory } else { $cursor.Parent }
    }
    return $full
}

function Assert-AMRExactPath {
    param(
        [Parameter(Mandatory)][string] $Actual,
        [Parameter(Mandatory)][string] $Expected,
        [Parameter(Mandatory)][string] $Label
    )

    Assert-AMRCondition ([IO.Path]::GetFullPath($Actual) -ceq [IO.Path]::GetFullPath($Expected)) "$Label ist nicht der exakt gebundene Pfad."
}

function Invoke-AMRGitRead {
    param(
        [Parameter(Mandatory)][string] $Repository,
        [Parameter(Mandatory)][string[]] $Arguments
    )

    $output = @(& git -C $Repository @Arguments 2>$null)
    $code = if ($null -eq $LASTEXITCODE) { 0 } else { [int] $LASTEXITCODE }
    return [ordered]@{ exitCode = $code; output = @($output | ForEach-Object { [string] $_ }) }
}

function Assert-AMRTerminalAwareRunnerAdoption {
    param(
        [Parameter(Mandatory)][hashtable] $ParentState,
        [Parameter(Mandatory)][hashtable] $ReloadedState,
        [Parameter(Mandatory)][string] $Repository,
        [Parameter(Mandatory)][string] $StatePath,
        [Parameter(Mandatory)][string] $PhaseId,
        [Parameter(Mandatory)][string] $ResultPath,
        [Parameter(Mandatory)][string] $ResultSha256,
        [Parameter(Mandatory)][string] $LogPath,
        [Parameter(Mandatory)][string] $LogMaterializationDisposition,
        [Parameter(Mandatory)][string] $OutputRoot,
        [Parameter(Mandatory)][hashtable] $Catalog,
        [Parameter(Mandatory)][string] $ResolvedProfileName,
        [Parameter(Mandatory)][hashtable] $ResolvedProfile
    )

    Assert-AMRCondition ($PhaseId -eq 'implement-closeout') 'Terminal adoption is limited to implement-closeout.'
    $featureDirectory = Join-Path $Repository ([string] $ParentState.featurePath)
    Assert-AMRExactPath $StatePath (Join-Path $featureDirectory 'autonomous-run-state.json') 'StatePath'
    Assert-AMRExactPath $ResultPath (Join-Path $OutputRoot "$PhaseId.result.json") 'ResultPath'
    Assert-AMRExactPath $LogPath (Join-Path $OutputRoot "$PhaseId.log.txt") 'LogPath'
    [void](Resolve-AMRContainedFile $Repository ([IO.Path]::GetRelativePath($Repository, $StatePath)) 'StatePath')
    [void](Resolve-AMRContainedFile $Repository ([IO.Path]::GetRelativePath($Repository, $ResultPath)) 'ResultPath')
    [void](Resolve-AMRContainedFile $OutputRoot ([IO.Path]::GetRelativePath($OutputRoot, $ResultPath)) 'ResultPath')
    $logSnapshot = $null
    if (Test-Path -LiteralPath $LogPath -PathType Leaf) {
        [void](Resolve-AMRContainedFile $OutputRoot ([IO.Path]::GetRelativePath($OutputRoot, $LogPath)) 'LogPath')
        Assert-AMRCondition ($LogMaterializationDisposition -eq 'Written') 'Terminal runner log bytes were not materialized exactly.'
        $logSnapshot = Get-AMRFileSnapshot $LogPath
    } else {
        Assert-AMRCondition (Test-Path -LiteralPath $LogPath -PathType Container) 'Terminal runner log is neither a file nor the allowed runner-local failure directory.'
        Assert-AMRCondition ($LogMaterializationDisposition -eq 'FailedDirectory') 'Terminal runner-local materialization failure disposition mismatch.'
    }
    foreach ($field in @('schemaVersion', 'runId', 'featurePath', 'branch', 'deliveryMode')) {
        Assert-AMRCondition ([string] $ReloadedState[$field] -eq [string] $ParentState[$field]) "Terminal identity drift: $field"
    }
    Assert-AMRCondition ([string] $ReloadedState.schemaVersion -eq '1.1') 'Terminal state schemaVersion must be 1.1.'
    Assert-AMRCondition ([string] $ReloadedState.deliveryMode -eq 'MergeAndSync') 'Terminal adoption requires MergeAndSync.'
    Assert-AMRCondition ([string] $ReloadedState.status -eq 'Completed') 'Reloaded terminal state is not Completed.'
    Assert-AMRCondition ([string] $ReloadedState.nextExactAction -eq 'N/A') 'Terminal nextExactAction must be N/A.'
    Assert-AMRCondition ([int] $ReloadedState.tasks.completed -eq 168 -and [int] $ReloadedState.tasks.total -eq 168) 'Terminal tasks must be 168/168.'
    foreach ($field in @('mergeOrPublication', 'defaultBranchSync', 'postMergeActions', 'finalValidation')) {
        Assert-AMRCondition ([string] $ReloadedState.closeout[$field] -eq 'Completed') "Terminal closeout field is not Completed: $field"
    }
    Assert-AMRCondition ([string] $ReloadedState.lastOperation.kind -eq 'ModelRoutingPhase:implement-closeout') 'Terminal lastOperation.kind mismatch.'
    Assert-AMRCondition ([string] $ReloadedState.lastOperation.state -eq 'Completed') 'Terminal lastOperation.state mismatch.'

    $tasksPath = Resolve-AMRContainedFile $Repository ([string] $ReloadedState.tasks.path) 'tasks.path'
    Assert-AMRExactPath $tasksPath (Join-Path $featureDirectory 'tasks.md') 'tasks.path'
    $tasksSnapshot = Get-AMRFileSnapshot $tasksPath
    Assert-AMRCondition ([string] $tasksSnapshot.sha256 -eq [string] $ReloadedState.tasks.sha256) 'Terminal tasks hash mismatch.'
    $taskMatches = [regex]::Matches([Text.Encoding]::UTF8.GetString($tasksSnapshot.bytes), '(?m)^- \[[xX]\] T(\d{3})\b')
    Assert-AMRCondition ($taskMatches.Count -eq 168) 'Terminal tasks file must contain 168 checked task lines.'
    for ($index = 0; $index -lt 168; $index++) {
        Assert-AMRCondition ([int] $taskMatches[$index].Groups[1].Value -eq ($index + 1)) "Terminal task sequence mismatch at index $index."
    }

    $relativeResult = [IO.Path]::GetRelativePath($Repository, $ResultPath).Replace('\\', '/')
    $reloadedPhase = Get-AMRPhase $ReloadedState $PhaseId
    $parentPhase = Get-AMRPhase $ParentState $PhaseId
    Assert-AMRCondition ([string] $reloadedPhase.command -eq 'speckit.implement') 'Terminal command mismatch.'
    Assert-AMRCondition ([string] $reloadedPhase.status -eq 'Completed' -and [int] $reloadedPhase.exitCode -eq 0) 'Terminal routing phase is not Completed/0.'
    Assert-AMRCondition ([string] $reloadedPhase.resultPath -eq $relativeResult) 'Terminal resultPath mismatch.'
    Assert-AMRCondition ([string] $reloadedPhase.resultSha256 -eq $ResultSha256) 'Terminal resultSha256 mismatch.'
    foreach ($field in @('phaseId', 'command', 'routingRole', 'runnerProfile', 'agentFamily', 'model', 'reasoningEffort')) {
        Assert-AMRCondition ([string] $reloadedPhase[$field] -eq [string] $parentPhase[$field]) "Terminal routing identity drift: $field"
    }
    Assert-AMRCondition $Catalog.commands.ContainsKey([string] $reloadedPhase.command) 'Terminal command fehlt im aufgeloesten Routing-Katalog.'
    Assert-AMRCondition ([string] $Catalog.commands[[string] $reloadedPhase.command] -eq [string] $reloadedPhase.routingRole) 'Terminal routingRole stimmt nicht mit dem Katalog ueberein.'
    Assert-AMRCondition ([string] $reloadedPhase.runnerProfile -eq $ResolvedProfileName) 'Terminal runnerProfile stimmt nicht mit dem aufgeloesten Profil ueberein.'
    foreach ($field in @('agentFamily', 'model', 'reasoningEffort')) {
        Assert-AMRCondition ([string] $reloadedPhase[$field] -eq [string] $ResolvedProfile[$field]) "Terminal $field stimmt nicht mit dem aufgeloesten Profil ueberein."
    }
    Assert-AMRCondition ([string] $reloadedPhase.preflight -eq 'Completed') 'Terminal phase preflight must be Completed.'

    $result = Read-AMRJson $ResultPath
    $resultSnapshot = Get-AMRFileSnapshot $ResultPath
    Assert-AMRCondition ([string] $result.phaseId -eq $PhaseId -and [string] $result.outcome -eq 'Completed') 'Terminal phase result identity mismatch.'
    Assert-AMRCondition ([int] $result.expectedTasks -eq 168 -and [int] $result.completedTasks -eq 168 -and [bool] $result.gatesSatisfied) 'Terminal phase result is incomplete.'
    Assert-AMRCondition ([string] $result.payloadPath -eq [string] $ReloadedState.tasks.path) 'Terminal result payloadPath must equal tasks.path.'
    Assert-AMRCondition ([string] $result.payloadSha256 -eq [string] $ReloadedState.tasks.sha256) 'Terminal result payload hash mismatch.'
    [void](Resolve-AMRContainedFile $Repository ([string] $result.payloadPath) 'payloadPath')
    $payloadSnapshot = Get-AMRFileSnapshot $tasksPath

    $stateValidator = Join-Path $PSScriptRoot 'validate-autonomous-run-state.ps1'
    Assert-AMRCondition (Test-Path -LiteralPath $stateValidator -PathType Leaf) 'Installierter State-Validator fehlt.'
    $stateValidation = @(& pwsh -NoProfile -File $stateValidator -State $StatePath 2>&1)
    Assert-AMRCondition ($LASTEXITCODE -eq 0) "Terminal state validator failed: $($stateValidation -join ' ')"

    $stateRelative = [IO.Path]::GetRelativePath($Repository, $StatePath).Replace('\\', '/')
    $head = Invoke-AMRGitRead $Repository @('rev-parse', 'HEAD')
    $parents = Invoke-AMRGitRead $Repository @('rev-list', '--parents', '-n', '1', 'HEAD')
    Assert-AMRCondition ($head.exitCode -eq 0 -and $parents.exitCode -eq 0) 'Terminal Git head cannot be read.'
    Assert-AMRCondition (([string] $parents.output[0] -split ' ').Count -eq 2) 'Terminal commit must have exactly one parent.'
    $headState = Invoke-AMRGitRead $Repository @('show', "HEAD:$stateRelative")
    $tasksRelative = [IO.Path]::GetRelativePath($Repository, $tasksPath).Replace('\\', '/')
    $headTasks = Invoke-AMRGitRead $Repository @('show', "HEAD:$tasksRelative")
    $parentStateResult = Invoke-AMRGitRead $Repository @('show', "HEAD^:$stateRelative")
    Assert-AMRCondition ($headState.exitCode -eq 0 -and $headTasks.exitCode -eq 0 -and $parentStateResult.exitCode -eq 0) 'Terminal State/Tasks Git blobs are missing.'
    $headStateText = (@($headState.output) -join "`n") + "`n"
    $diskStateText = [IO.File]::ReadAllText($StatePath, [Text.Encoding]::UTF8)
    Assert-AMRCondition ($headStateText -eq $diskStateText) 'Terminal state is not the exact HEAD blob.'
    $headTasksText = (@($headTasks.output) -join "`n") + "`n"
    Assert-AMRCondition ($headTasksText -eq [IO.File]::ReadAllText($tasksPath, [Text.Encoding]::UTF8)) 'Terminal tasks are not the exact HEAD blob.'
    $parentDiskState = (@($parentStateResult.output) -join "`n") | ConvertFrom-Json -AsHashtable
    Assert-AMRCondition ([string] $parentDiskState.status -eq 'Active' -and [int] $parentDiskState.tasks.completed -eq 167 -and [int] $parentDiskState.tasks.total -eq 168) 'Terminal parent is not Active/167/168.'
    Assert-AMRCondition ([string] $parentDiskState.lastOperation.state -eq 'NeedsRevalidation') 'Terminal parent is not NeedsRevalidation.'

    $index = Invoke-AMRGitRead $Repository @('diff', '--cached', '--quiet')
    $trackedWorktree = Invoke-AMRGitRead $Repository @('status', '--porcelain=v1', '--untracked-files=no')
    Assert-AMRCondition ($index.exitCode -eq 0) 'Terminal index is not clean.'
    Assert-AMRCondition ($trackedWorktree.exitCode -eq 0 -and @($trackedWorktree.output).Count -eq 0) 'Terminal tracked worktree is not clean.'
    $branch = Invoke-AMRGitRead $Repository @('symbolic-ref', '--quiet', '--short', 'HEAD')
    Assert-AMRCondition ($branch.exitCode -eq 0) 'Terminal local default branch cannot be resolved.'
    $localDefault = Invoke-AMRGitRead $Repository @('rev-parse', "refs/heads/$([string] $branch.output[0])")
    $remoteHead = Invoke-AMRGitRead $Repository @('symbolic-ref', '--quiet', 'refs/remotes/origin/HEAD')
    Assert-AMRCondition ($remoteHead.exitCode -eq 0) 'Terminal remote default ref cannot be resolved locally.'
    $remoteDefault = Invoke-AMRGitRead $Repository @('rev-parse', [string] $remoteHead.output[0])
    Assert-AMRCondition ($localDefault.exitCode -eq 0 -and $remoteDefault.exitCode -eq 0) 'Terminal default refs cannot be read.'
    Assert-AMRCondition ([string] $localDefault.output[0] -eq [string] $head.output[0] -and [string] $remoteDefault.output[0] -eq [string] $head.output[0]) 'Local and remote default refs must equal HEAD.'
    $parentAncestry = Invoke-AMRGitRead $Repository @('merge-base', '--is-ancestor', 'HEAD^', 'HEAD')
    $remoteAncestry = Invoke-AMRGitRead $Repository @('merge-base', '--is-ancestor', 'HEAD', [string] $remoteHead.output[0])
    Assert-AMRCondition ($parentAncestry.exitCode -eq 0 -and $remoteAncestry.exitCode -eq 0) 'Terminal default refs do not prove fast-forward ancestry.'

    return [ordered]@{
        phase = $reloadedPhase
        tasksSha256 = [string] $tasksSnapshot.sha256
        stateSha256 = [string] (Get-AMRFileSnapshot $StatePath).sha256
        head = [string] $head.output[0]
        localDefault = [string] $localDefault.output[0]
        remoteDefault = [string] $remoteDefault.output[0]
        resultSha256 = $ResultSha256
        payloadSha256 = [string] $result.payloadSha256
        resultBytesSha256 = [string] $resultSnapshot.sha256
        payloadBytesSha256 = [string] $payloadSnapshot.sha256
        logKind = if ($null -eq $logSnapshot) { 'Directory' } else { 'File' }
        logBytesSha256 = if ($null -eq $logSnapshot) { 'N/A' } else { [string] $logSnapshot.sha256 }
        indexExitCode = [int] $index.exitCode
        trackedWorktreeCount = @($trackedWorktree.output).Count
    }
}

function Write-AMRStatus {
    param(
        [Parameter(Mandatory)][hashtable] $StateData,
        [Parameter(Mandatory)][string] $Format
    )

    $routing = $StateData.routing
    if ($Format -eq 'Json') {
        [ordered]@{
            runId = [string] $StateData.runId
            status = [string] $StateData.status
            policy = [string] $routing.policy
            fallbackPolicy = [string] $routing.fallbackPolicy
            phases = @($routing.phases)
        } | ConvertTo-Json -Depth 20
        return
    }
    Write-Output "Autonomous model routing: $($StateData.runId)"
    Write-Output "Status: $($StateData.status)"
    Write-Output "Policy: $($routing.policy), fallback: $($routing.fallbackPolicy)"
    foreach ($phase in @($routing.phases)) {
        Write-Output "- $($phase.phaseId): $($phase.command), role=$($phase.routingRole), profile=$($phase.runnerProfile), status=$($phase.status)"
    }
}

$statePath = [IO.Path]::GetFullPath($State)
$stateData = Read-AMRJson $statePath
$repositoryRoot = Get-AMRRepositoryRoot $statePath
if ([string]::IsNullOrWhiteSpace($RoutingRoot)) {
    $RoutingRoot = Join-Path $repositoryRoot '.specify/presets'
}
if ([string]::IsNullOrWhiteSpace($Worktree)) {
    $Worktree = $repositoryRoot
}
$Worktree = [IO.Path]::GetFullPath($Worktree)
Assert-AMRCondition (Test-Path -LiteralPath $Worktree -PathType Container) "Worktree fehlt: $Worktree"

$catalog = Get-AMRRoutingCatalog ([IO.Path]::GetFullPath($RoutingRoot))
Assert-AMRPhaseContract $stateData $catalog

if ($Action -eq 'Status') {
    Write-AMRStatus $stateData $OutputFormat
    exit 0
}

Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace($RunnerConfig)) 'RunnerConfig ist fuer Validate und Run erforderlich.'
$runnerData = Read-AMRJson ([IO.Path]::GetFullPath($RunnerConfig))

if ($Action -eq 'Validate') {
    foreach ($phase in @($stateData.routing.phases)) {
        if ([string] $phase.routingRole -ne 'script-only') {
            [void](Get-AMRRunnerProfile $runnerData $phase)
        }
    }
    [ordered]@{
        status = 'VALID'
        policy = [string] $stateData.routing.policy
        fallbackPolicy = [string] $stateData.routing.fallbackPolicy
        phaseCount = @($stateData.routing.phases).Count
    } | ConvertTo-Json
    exit 0
}

Assert-AMRCondition (-not [string]::IsNullOrWhiteSpace($PhaseId)) 'PhaseId ist fuer Run erforderlich.'
Assert-AMRCondition (-not (-not [string]::IsNullOrWhiteSpace($Prompt) -and -not [string]::IsNullOrWhiteSpace($PromptFile))) 'Prompt und PromptFile duerfen nicht gemeinsam gesetzt werden.'
$phase = Get-AMRPhase $stateData $PhaseId
Assert-AMRCondition ([string] $phase.status -in @('Pending', 'Blocked', 'NeedsRevalidation')) "Phase '$PhaseId' ist nicht startbar: $($phase.status)"
foreach ($dependency in @(if ($phase.ContainsKey('dependsOn')) { $phase.dependsOn } else { @() })) {
    $dependencyPhase = @($stateData.routing.phases | Where-Object { [string] $_.phaseId -eq [string] $dependency })[0]
    Assert-AMRCondition ([string] $dependencyPhase.status -eq 'Completed') "Abhaengige Phase '$dependency' ist nicht Completed."
}

$profileResult = Get-AMRRunnerProfile $runnerData $phase
$profileName = [string] $profileResult.name
$runnerProfileData = $profileResult.data

if (-not [string]::IsNullOrWhiteSpace($PromptFile)) {
    Assert-AMRCondition (Test-Path -LiteralPath $PromptFile -PathType Leaf) "PromptFile fehlt: $PromptFile"
    $Prompt = Get-Content -LiteralPath $PromptFile -Raw -Encoding utf8
}
$fullPrompt = "Execute /$($phase.command) for the current repository. Follow the accepted feature artifacts and autonomous run state."
$fullPrompt += "`nWrite the machine-readable phase result to the exact output file from the runner profile. Use autonomous-phase-result-template.json and report Completed only when task and gate evidence is complete."
if (-not [string]::IsNullOrWhiteSpace($Prompt)) {
    $fullPrompt += "`n`nPhase input:`n$Prompt"
}

if ([string]::IsNullOrWhiteSpace($OutputDirectory)) {
    $OutputDirectory = Join-Path $repositoryRoot ".specify/runtime/autonomous-routing/$($stateData.runId)"
}
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
[void](New-Item -ItemType Directory -Path $OutputDirectory -Force)
$outputFile = Join-Path $OutputDirectory "$PhaseId.result.json"
$logFile = Join-Path $OutputDirectory "$PhaseId.log.txt"
$values = @{
    worktree = $Worktree
    phaseId = $PhaseId
    command = [string] $phase.command
    prompt = $fullPrompt
    outputFile = $outputFile
    logFile = $logFile
    model = [string] $runnerProfileData.model
    reasoningEffort = [string] $runnerProfileData.reasoningEffort
}

if (-not $PSCmdlet.ShouldProcess("phase '$PhaseId'", "Run fail-closed model preflight and phase with profile '$profileName'")) {
    [ordered]@{
        status = 'WHATIF'
        phaseId = $PhaseId
        command = [string] $phase.command
        routingRole = [string] $phase.routingRole
        runnerProfile = $profileName
        agentFamily = [string] $runnerProfileData.agentFamily
        model = [string] $runnerProfileData.model
        reasoningEffort = [string] $runnerProfileData.reasoningEffort
    } | ConvertTo-Json
    exit 0
}

try {
    $runningStateSnapshot = $null
    $preserveChildState = $false
    $terminalAdopted = $false
    $logMaterializationDisposition = 'NotAttempted'
    $preflight = Invoke-AMRCommand $runnerProfileData.preflight $values $Worktree
    if ([int] $preflight.exitCode -ne 0) {
        $reason = "Model preflight failed for profile '$profileName' with exit code $($preflight.exitCode)."
        Set-AMRBlockedState $stateData $phase $reason 'ModelRoutingPreflight'
        $phase.runnerProfile = $profileName
        $phase.agentFamily = [string] $runnerProfileData.agentFamily
        $phase.model = [string] $runnerProfileData.model
        $phase.reasoningEffort = [string] $runnerProfileData.reasoningEffort
        $phase.preflight = 'Failed'
        $phase.exitCode = [int] $preflight.exitCode
        Write-AMRJsonAtomic $statePath $stateData
        throw $reason
    }

    $timestamp = [DateTime]::UtcNow.ToString('o')
    $phase.status = 'Running'
    $phase.runnerProfile = $profileName
    $phase.agentFamily = [string] $runnerProfileData.agentFamily
    $phase.model = [string] $runnerProfileData.model
    $phase.reasoningEffort = [string] $runnerProfileData.reasoningEffort
    $phase.preflight = 'Completed'
    $phase.exitCode = $null
    $phase.updatedAt = $timestamp
    $stateData.status = 'Active'
    $stateData.stop = [ordered]@{ reason = 'N/A'; requestedAt = 'N/A'; safeBoundary = 'N/A' }
    $stateData.lastOperation = [ordered]@{
        kind = "ModelRoutingPhase:$PhaseId"
        state = 'NeedsRevalidation'
        summary = "Phase process started with profile '$profileName'."
    }
    $stateData.updatedAt = $timestamp
    Write-AMRJsonAtomic $statePath $stateData
    $runningStateSnapshot = Get-AMRFileSnapshot $statePath

    $execution = Invoke-AMRCommand $runnerProfileData $values $Worktree
    if ([int] $execution.exitCode -ne 0) {
        if (-not (Test-AMRFileSnapshot $statePath $runningStateSnapshot)) {
            $preserveChildState = $true
            throw 'TERMINAL_STATE_DRIFT_REQUIRES_READ_ONLY_RECONCILIATION'
        }
        $reason = "Phase '$PhaseId' failed with exit code $($execution.exitCode)."
        Set-AMRBlockedState $stateData $phase $reason "ModelRoutingPhase:$PhaseId"
        $phase.exitCode = [int] $execution.exitCode
        Write-AMRJsonAtomic $statePath $stateData
        throw $reason
    }

    if (@($execution.output).Count -gt 0) {
        try {
            @($execution.output) | Set-Content -LiteralPath $logFile -Encoding utf8NoBOM
            $logMaterializationDisposition = 'Written'
        } catch {
            # runnerLocal evidence is best effort and never changes delivery truth.
            $logMaterializationDisposition = if (Test-Path -LiteralPath $logFile -PathType Container) { 'FailedDirectory' } else { 'FailedFile' }
            Write-Verbose "runnerLocal log materialization failed without changing phase completion: $($_.Exception.Message)"
        }
    } else {
        $logMaterializationDisposition = 'NoOutput'
    }
    Assert-AMRCondition (Test-Path -LiteralPath $outputFile -PathType Leaf) "Phase '$PhaseId' produced no structured result."
    $validationOutput = @(& (Join-Path $PSScriptRoot 'validate-autonomous-phase-result.ps1') `
        -Repo $repositoryRoot -Result $outputFile -PhaseId $PhaseId -ExitCode ([int] $execution.exitCode) 2>&1)
    $validationExitCode = if ($null -eq $LASTEXITCODE) { 0 } else { $LASTEXITCODE }
    if ($validationExitCode -ne 0) {
        if (-not (Test-AMRFileSnapshot $statePath $runningStateSnapshot)) {
            $preserveChildState = $true
            throw 'TERMINAL_STATE_DRIFT_REQUIRES_READ_ONLY_RECONCILIATION'
        }
        $reason = "Phase '$PhaseId' semantic result validation failed: $($validationOutput -join ' ')"
        Set-AMRBlockedState $stateData $phase $reason "ModelRoutingPhase:$PhaseId"
        $phase.exitCode = 0
        Write-AMRJsonAtomic $statePath $stateData
        throw $reason
    }
    $validation = ($validationOutput -join "`n") | ConvertFrom-Json
    $resultHash = [string] $validation.normalizedSha256

    if (-not (Test-AMRFileSnapshot $statePath $runningStateSnapshot)) {
        $reloadedState = Read-AMRJson $statePath
        try {
            $adoption = Assert-AMRTerminalAwareRunnerAdoption `
                -ParentState $stateData `
                -ReloadedState $reloadedState `
                -Repository $repositoryRoot `
                -StatePath $statePath `
                -PhaseId $PhaseId `
                -ResultPath $outputFile `
                -ResultSha256 $resultHash `
                -LogPath $logFile `
                -LogMaterializationDisposition $logMaterializationDisposition `
                -OutputRoot $OutputDirectory `
                -Catalog $catalog `
                -ResolvedProfileName $profileName `
                -ResolvedProfile $runnerProfileData
            $stateAfterValidation = Get-AMRFileSnapshot $statePath
            $adoptionAfterValidation = Assert-AMRTerminalAwareRunnerAdoption `
                -ParentState $stateData `
                -ReloadedState (Read-AMRJson $statePath) `
                -Repository $repositoryRoot `
                -StatePath $statePath `
                -PhaseId $PhaseId `
                -ResultPath $outputFile `
                -ResultSha256 $resultHash `
                -LogPath $logFile `
                -LogMaterializationDisposition $logMaterializationDisposition `
                -OutputRoot $OutputDirectory `
                -Catalog $catalog `
                -ResolvedProfileName $profileName `
                -ResolvedProfile $runnerProfileData
            Assert-AMRCondition (Test-AMRFileSnapshot $statePath $stateAfterValidation) 'Terminal state changed during the TOCTOU recheck.'
            Assert-AMRCondition ([string] $adoption.head -eq [string] $adoptionAfterValidation.head) 'Terminal Git ref changed during the TOCTOU recheck.'
            Assert-AMRCondition ([string] $adoption.localDefault -eq [string] $adoptionAfterValidation.localDefault) 'Terminal local default ref changed during the TOCTOU recheck.'
            Assert-AMRCondition ([string] $adoption.remoteDefault -eq [string] $adoptionAfterValidation.remoteDefault) 'Terminal remote default ref changed during the TOCTOU recheck.'
            Assert-AMRCondition ([string] $adoption.resultSha256 -eq [string] $adoptionAfterValidation.resultSha256 -and [string] $adoption.payloadSha256 -eq [string] $adoptionAfterValidation.payloadSha256) 'Terminal evidence tuple changed during the TOCTOU recheck.'
            foreach ($field in @('tasksSha256', 'stateSha256', 'resultBytesSha256', 'payloadBytesSha256',
                    'logKind', 'logBytesSha256', 'indexExitCode', 'trackedWorktreeCount')) {
                Assert-AMRCondition ([string] $adoption[$field] -eq [string] $adoptionAfterValidation[$field]) "Terminal second TOCTOU tuple changed: $field"
            }
            $terminalAdopted = $true
            $reloadedPhase = $adoptionAfterValidation.phase
            [ordered]@{
                status = 'COMPLETED'
                phaseId = $PhaseId
                command = [string] $reloadedPhase.command
                routingRole = [string] $reloadedPhase.routingRole
                runnerProfile = [string] $reloadedPhase.runnerProfile
                agentFamily = [string] $reloadedPhase.agentFamily
                model = [string] $reloadedPhase.model
                reasoningEffort = [string] $reloadedPhase.reasoningEffort
                resultPath = [string] $reloadedPhase.resultPath
                resultSha256 = [string] $reloadedPhase.resultSha256
                adoption = 'TerminalAwareRunnerAdoption'
                parentFeatureWrites = 0
                catchFeatureWrites = 0
            } | ConvertTo-Json
            exit 0
        } catch {
            $preserveChildState = $true
            if ($_.Exception.Message -eq 'TERMINAL_STATE_DRIFT_REQUIRES_READ_ONLY_RECONCILIATION') { throw }
            throw "TERMINAL_STATE_DRIFT_REQUIRES_READ_ONLY_RECONCILIATION: $($_.Exception.Message)"
        }
    }

    $timestamp = [DateTime]::UtcNow.ToString('o')
    $phase.status = 'Completed'
    $phase.exitCode = 0
    $phase.resultPath = [IO.Path]::GetRelativePath($repositoryRoot, $outputFile).Replace('\\', '/')
    $phase.resultSha256 = $resultHash
    $phase.updatedAt = $timestamp
    $nextPhase = @($stateData.routing.phases | Where-Object { [string] $_.status -in @('Pending', 'NeedsRevalidation') }) | Select-Object -First 1
    $stateData.nextExactAction = if ($null -eq $nextPhase) { 'Continue autonomous validation and closeout.' } else { "Run routing phase '$($nextPhase.phaseId)'." }
    $stateData.lastOperation = [ordered]@{
        kind = "ModelRoutingPhase:$PhaseId"
        state = 'Completed'
        summary = "Phase completed with profile '$profileName' and result SHA-256 $resultHash."
    }
    $stateData.updatedAt = $timestamp
    Write-AMRJsonAtomic $statePath $stateData

    [ordered]@{
        status = 'COMPLETED'
        phaseId = $PhaseId
        command = [string] $phase.command
        routingRole = [string] $phase.routingRole
        runnerProfile = $profileName
        agentFamily = [string] $runnerProfileData.agentFamily
        model = [string] $runnerProfileData.model
        reasoningEffort = [string] $runnerProfileData.reasoningEffort
        resultPath = [string] $phase.resultPath
        resultSha256 = $resultHash
    } | ConvertTo-Json
} catch {
    if ($terminalAdopted -or $preserveChildState -or
        ($null -ne $runningStateSnapshot -and -not (Test-AMRFileSnapshot $statePath $runningStateSnapshot))) {
        throw
    }
    if ([string] $phase.status -ne 'Blocked') {
        Set-AMRBlockedState $stateData $phase $_.Exception.Message "ModelRoutingPhase:$PhaseId"
        Write-AMRJsonAtomic $statePath $stateData
    }
    throw
}
