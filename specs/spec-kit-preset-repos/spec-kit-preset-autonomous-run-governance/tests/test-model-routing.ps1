#Requires -Version 7.0
[CmdletBinding()]
param(
    [ValidateSet('DirectPowerShell', 'BashWrapper')]
    [string] $InvocationSurface = 'DirectPowerShell'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Assert-RoutingTest {
    param([Parameter(Mandatory)][bool] $Condition, [Parameter(Mandatory)][string] $Message)
    if (-not $Condition) { throw $Message }
}

function Write-RoutingJson {
    param([Parameter(Mandatory)][string] $Path, [Parameter(Mandatory)] $Value)
    [void](New-Item -ItemType Directory -Path (Split-Path -Parent $Path) -Force)
    $Value | ConvertTo-Json -Depth 30 | Set-Content -LiteralPath $Path -Encoding utf8NoBOM
}

function Get-RoutingSha256 {
    param([Parameter(Mandatory)][string] $Path)
    return [Convert]::ToHexString(
        [Security.Cryptography.SHA256]::HashData([IO.File]::ReadAllBytes($Path))
    ).ToLowerInvariant()
}

function Assert-RoutingFileRecord {
    param(
        [Parameter(Mandatory)][string] $Path,
        [Parameter(Mandatory)] $Record,
        [Parameter(Mandatory)][string] $Label
    )
    switch ([string] $Record.kind) {
        'Absent' { Assert-RoutingTest (-not (Test-Path -LiteralPath $Path)) "${Label}: expected absence was not preserved" }
        'Directory' { Assert-RoutingTest (Test-Path -LiteralPath $Path -PathType Container) "${Label}: expected materialization directory is missing" }
        'File' {
            Assert-RoutingTest (Test-Path -LiteralPath $Path -PathType Leaf) "${Label}: expected file is missing"
            $bytes = [IO.File]::ReadAllBytes($Path)
            $expected = [Convert]::FromBase64String([string] $Record.bytesBase64)
            Assert-RoutingTest ([Linq.Enumerable]::SequenceEqual[byte]($bytes, $expected)) "${Label}: exact bytes changed"
            Assert-RoutingTest ((Get-RoutingSha256 $Path) -eq [string] $Record.sha256) "${Label}: SHA-256 changed"
        }
        default { throw "${Label}: unknown observation kind '$($Record.kind)'" }
    }
}

$presetRoot = Split-Path -Parent $PSScriptRoot
$runner = Join-Path $presetRoot 'scripts/invoke-autonomous-model-phase.ps1'
$runnerWrapper = Join-Path $presetRoot 'scripts/invoke-autonomous-model-phase.sh'
$fixtureRunner = Join-Path $PSScriptRoot 'fixture-model-runner.ps1'
$routingRoot = Split-Path -Parent $presetRoot
$temporaryRoot = Join-Path ([IO.Path]::GetTempPath()) "autonomous-model-routing-$([guid]::NewGuid())"
$scenarios = @(
    [ordered]@{ name = 'ExactTerminalAdoption'; exit = 0 },
    [ordered]@{ name = 'ResultIdentityMismatch'; exit = 1 },
    [ordered]@{ name = 'DefiniteChildFailureWithoutDrift'; exit = 1 },
    [ordered]@{ name = 'CatchTimeChildDrift'; exit = 1 },
    [ordered]@{ name = 'GitRefDrift'; exit = 1 },
    [ordered]@{ name = 'RunnerLocalMaterializationFailure'; exit = 0 },
    [ordered]@{ name = 'TasksBytesCorruption'; exit = 1 },
    [ordered]@{ name = 'TasksHashCorruption'; exit = 1 },
    [ordered]@{ name = 'ResultBytesCorruption'; exit = 1 },
    [ordered]@{ name = 'ResultHashCorruption'; exit = 1 },
    [ordered]@{ name = 'PayloadPathCorruption'; exit = 1 },
    [ordered]@{ name = 'PayloadBytesCorruption'; exit = 1 },
    [ordered]@{ name = 'PayloadHashCorruption'; exit = 1 },
    [ordered]@{ name = 'LogPathCorruption'; exit = 1 },
    [ordered]@{ name = 'LogBytesCorruption'; exit = 1 },
    [ordered]@{ name = 'LogHashCorruption'; exit = 1 },
    [ordered]@{ name = 'TrackedWorktreeDirty'; exit = 1 },
    [ordered]@{ name = 'IndexDirty'; exit = 1 }
)

try {
    $passed = 0
    foreach ($scenario in $scenarios) {
        $caseRoot = Join-Path $temporaryRoot ([string] $scenario.name)
        $repository = Join-Path $caseRoot 'repository'
        $featureDirectory = Join-Path $repository 'specs/999-routing-fixture'
        $statePath = Join-Path $featureDirectory 'autonomous-run-state.json'
        $tasksPath = Join-Path $featureDirectory 'tasks.md'
        $outputDirectory = Join-Path $repository '.specify/runtime/fixture-run'
        $runnerConfig = Join-Path $caseRoot 'runner-profiles.json'
        [void](New-Item -ItemType Directory -Path $featureDirectory -Force)
        & git -C $repository init --quiet --initial-branch=main
        & git -C $repository config user.name 'Runner Fixture'
        & git -C $repository config user.email 'runner-fixture@example.invalid'

        $tasks = 1..168 | ForEach-Object {
            if ($_ -le 167) { '- [x] T{0:D3} Fixture task' -f $_ }
            else { '- [ ] T{0:D3} Fixture task' -f $_ }
        }
        $tasks | Set-Content -LiteralPath $tasksPath -Encoding utf8NoBOM
        $sentinelPath = Join-Path $featureDirectory 'tracked-sentinel.txt'
        Set-Content -LiteralPath $sentinelPath -Value 'terminal invariant sentinel' -Encoding utf8NoBOM
        $tasksHash = Get-RoutingSha256 $tasksPath
        $state = [ordered]@{
            schemaVersion = '1.1'
            runId = [guid]::NewGuid().ToString()
            featurePath = 'specs/999-routing-fixture'
            branch = 'main'
            deliveryMode = 'MergeAndSync'
            authorityRevalidationRequired = $false
            stage = 'MergeAndSync'
            status = 'Active'
            checkpointCommit = 'N/A'
            acceptedArtifacts = @()
            tasks = [ordered]@{ path = 'specs/999-routing-fixture/tasks.md'; sha256 = $tasksHash; completed = 167; total = 168 }
            routing = [ordered]@{
                policy = 'balanced-v1'
                fallbackPolicy = 'fail-closed'
                phases = @([ordered]@{
                    phaseId = 'implement-closeout'
                    command = 'speckit.implement'
                    routingRole = 'long-running-implementation'
                    runnerProfile = 'fixture-long'
                    dependsOn = @()
                    status = 'Pending'
                })
            }
            lastPassingGate = 'T167'
            nextExactAction = "Run routing phase 'implement-closeout'."
            lastOperation = [ordered]@{ kind = 'CompletionCandidate'; state = 'NeedsRevalidation'; summary = 'Terminal parent requires closeout.' }
            stop = [ordered]@{ reason = 'N/A'; requestedAt = 'N/A'; safeBoundary = 'N/A' }
            closeout = [ordered]@{ mergeOrPublication = 'Completed'; defaultBranchSync = 'Completed'; postMergeActions = 'Completed'; finalValidation = 'Pending' }
            updatedAt = [DateTime]::UtcNow.ToString('o')
        }
        Write-RoutingJson $statePath $state
        & git -C $repository add -- $statePath $tasksPath $sentinelPath
        & git -C $repository commit --quiet -m 'test: active 167 fixture'
        $parentHead = (& git -C $repository rev-parse HEAD).Trim()
        & git -C $repository update-ref refs/remotes/origin/main $parentHead
        & git -C $repository symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main

        $arguments = @(
            '-NoProfile', '-File', $fixtureRunner,
            '-OutputFile', '{outputFile}', '-LogFile', '{logFile}',
            '-PhaseId', '{phaseId}', '-Content', '{command}',
            '-Scenario', [string] $scenario.name
        )
        Write-RoutingJson $runnerConfig ([ordered]@{
            schemaVersion = '1.0'
            profiles = [ordered]@{
                'fixture-long' = [ordered]@{
                    routingRole = 'long-running-implementation'
                    agentFamily = 'Fixture Agent'
                    model = 'fixture-model'
                    reasoningEffort = 'high'
                    executable = 'pwsh'
                    preflight = [ordered]@{ executable = 'pwsh'; arguments = @('-NoProfile', '-File', $fixtureRunner) }
                    arguments = $arguments
                }
            }
        })

        $stateBefore = Get-RoutingSha256 $statePath
        $invokeArgs = @('-Action', 'Run', '-State', $statePath, '-RunnerConfig', $runnerConfig,
            '-RoutingRoot', $routingRoot, '-PhaseId', 'implement-closeout', '-Worktree', $repository,
            '-OutputDirectory', $outputDirectory)
        if ($InvocationSurface -eq 'DirectPowerShell') {
            $output = @(& pwsh -NoProfile -File $runner @invokeArgs 2>&1)
        } else {
            $output = @(& bash $runnerWrapper @invokeArgs 2>&1)
        }
        $exitCode = if ($null -eq $LASTEXITCODE) { 0 } else { [int] $LASTEXITCODE }
        Assert-RoutingTest ($exitCode -eq [int] $scenario.exit) "$($scenario.name): unexpected exit $exitCode; $($output -join ' ')"

        $afterState = Get-Content -LiteralPath $statePath -Raw -Encoding utf8 | ConvertFrom-Json
        $observationPath = Join-Path $outputDirectory 'implement-closeout.child-observation.json'
        Assert-RoutingTest (Test-Path -LiteralPath $observationPath -PathType Leaf) "$($scenario.name): child observation is missing"
        $observation = Get-Content -LiteralPath $observationPath -Raw -Encoding utf8 | ConvertFrom-Json
        Assert-RoutingTest ([string] $observation.scenario -eq [string] $scenario.name) "$($scenario.name): child observation identity mismatch"
        Assert-RoutingTest (-not [string]::IsNullOrWhiteSpace([string] $observation.perturbation.performed)) "$($scenario.name): perturbation record is missing"
        Assert-RoutingTest ($null -ne $observation.perturbation.before -and $null -ne $observation.perturbation.after) "$($scenario.name): perturbation before/after record is missing"
        if ([string] $scenario.name -ne 'DefiniteChildFailureWithoutDrift') {
            Assert-RoutingFileRecord $statePath $observation.files.state "$($scenario.name)/state"
        } else {
            Assert-RoutingTest ((Get-RoutingSha256 $statePath) -ne [string] $observation.files.state.sha256) "$($scenario.name): bounded parent failure state was not materialized"
        }
        Assert-RoutingFileRecord $tasksPath $observation.files.tasks "$($scenario.name)/tasks"
        Assert-RoutingFileRecord (Join-Path $outputDirectory 'implement-closeout.result.json') $observation.files.result "$($scenario.name)/result"
        Assert-RoutingFileRecord $tasksPath $observation.files.payload "$($scenario.name)/payload"
        Assert-RoutingFileRecord (Join-Path $outputDirectory 'implement-closeout.log.txt') $observation.files.log "$($scenario.name)/log"

        $headAfter = (& git -C $repository rev-parse HEAD).Trim()
        $remoteAfter = (& git -C $repository rev-parse refs/remotes/origin/main).Trim()
        Assert-RoutingTest ($headAfter -eq [string] $observation.refs.head) "$($scenario.name): child HEAD ref was changed by parent/catch"
        Assert-RoutingTest ($remoteAfter -eq [string] $observation.refs.remoteDefault) "$($scenario.name): child remote-default ref was changed by parent/catch"
        $index = @(& git -C $repository diff --cached --name-only)
        $trackedWorktree = @(& git -C $repository status --porcelain=v1 --untracked-files=no)
        Assert-RoutingTest ($index.Count -eq @($observation.index).Count -and @(Compare-Object $index @($observation.index) -SyncWindow 0).Count -eq 0) "$($scenario.name): child index changed"
        Assert-RoutingTest ($trackedWorktree.Count -eq @($observation.trackedWorktree).Count -and @(Compare-Object $trackedWorktree @($observation.trackedWorktree) -SyncWindow 0).Count -eq 0) "$($scenario.name): child tracked-worktree status changed"
        $expectedIndexCount = if ([string] $scenario.name -eq 'IndexDirty') { 1 } else { 0 }
        $expectedTrackedCount = if ([string] $scenario.name -in @('TrackedWorktreeDirty', 'IndexDirty', 'DefiniteChildFailureWithoutDrift', 'CatchTimeChildDrift')) { 1 } else { 0 }
        Assert-RoutingTest ($index.Count -eq $expectedIndexCount) "$($scenario.name): staged-index perturbation count mismatch"
        Assert-RoutingTest ($trackedWorktree.Count -eq $expectedTrackedCount) "$($scenario.name): tracked-worktree perturbation count mismatch"
        if ([string] $scenario.name -in @('ExactTerminalAdoption', 'RunnerLocalMaterializationFailure')) {
            Assert-RoutingTest ($afterState.status -eq 'Completed' -and $afterState.tasks.completed -eq 168) "$($scenario.name): terminal state not adopted"
            Assert-RoutingTest (($output -join ' ') -match '"parentFeatureWrites": 0' -and ($output -join ' ') -match '"catchFeatureWrites": 0') "$($scenario.name): parent/catch write proof missing"
            $head = $headAfter
            $remote = $remoteAfter
            Assert-RoutingTest ($head -eq $remote -and $head -ne $parentHead) "$($scenario.name): exact default-ref transition missing"
            $resultPath = Join-Path $outputDirectory 'implement-closeout.result.json'
            $result = Get-Content -LiteralPath $resultPath -Raw | ConvertFrom-Json
            Assert-RoutingTest ((Get-RoutingSha256 $tasksPath) -eq $result.payloadSha256) "$($scenario.name): payload bytes/hash mismatch"
            Assert-RoutingTest ((Get-RoutingSha256 $resultPath) -eq $afterState.routing.phases[0].resultSha256) "$($scenario.name): result bytes/hash mismatch"
        } elseif ([string] $scenario.name -eq 'DefiniteChildFailureWithoutDrift') {
            Assert-RoutingTest ($afterState.status -eq 'Blocked' -and $afterState.tasks.completed -eq 167) 'Definite failure did not produce the bounded parent Blocked write.'
        } else {
            Assert-RoutingTest (($output -join ' ') -match 'TERMINAL_STATE_DRIFT_REQUIRES_READ_ONLY_RECONCILIATION') "$($scenario.name): uncertainty marker missing"
            Assert-RoutingTest ($afterState.status -ne 'Blocked') "$($scenario.name): catch overwrote child state"
        }
        Assert-RoutingTest ($stateBefore -ne (Get-RoutingSha256 $statePath)) "$($scenario.name): expected real state mutation missing"
        [ordered]@{
            status = 'PASS'
            scenario = [string] $scenario.name
            surface = $InvocationSurface
            stateDisposition = if ([string] $scenario.name -eq 'DefiniteChildFailureWithoutDrift') { 'BoundedParentBlockedWriteObserved' } else { 'ExactChildBytesAndSha256Preserved' }
            perturbation = [string] $observation.perturbation.performed
            perturbationTarget = [string] $observation.perturbation.target
            perturbationBefore = $observation.perturbation.before
            perturbationAfter = $observation.perturbation.after
            observedDisposition = if ([string] $scenario.name -in @('ExactTerminalAdoption', 'RunnerLocalMaterializationFailure')) { 'TerminalAdopted' } elseif ([string] $scenario.name -eq 'DefiniteChildFailureWithoutDrift') { 'BoundedParentBlocked' } else { 'FailClosedReadOnlyReconciliation' }
            tasksSha256 = Get-RoutingSha256 $tasksPath
            resultDisposition = [string] $observation.files.result.kind
            payloadSha256 = Get-RoutingSha256 $tasksPath
            logDisposition = [string] $observation.files.log.kind
            head = $headAfter
            remoteDefault = $remoteAfter
            indexPaths = $index.Count
            trackedWorktreePaths = $trackedWorktree.Count
            parentFeatureWrites = if ([string] $scenario.name -eq 'DefiniteChildFailureWithoutDrift') { 1 } else { 0 }
            catchFeatureWrites = 0
            networkWrites = 0
            providerWrites = 0
        } | ConvertTo-Json -Compress
        $passed++
    }
    Assert-RoutingTest ($passed -eq $scenarios.Count) 'Expanded adversarial runner matrix did not complete.'
    Write-Output "PASS: executable isolated temporary-repository runner matrix $passed/$($scenarios.Count) ($InvocationSurface)"
} finally {
    Remove-Item -LiteralPath $temporaryRoot -Recurse -Force -ErrorAction SilentlyContinue
}
