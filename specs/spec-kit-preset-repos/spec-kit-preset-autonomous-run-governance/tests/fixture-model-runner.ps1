#Requires -Version 7.0
[CmdletBinding()]
param(
    [string] $OutputFile = '',
    [string] $LogFile = '',
    [string] $PhaseId = 'fixture',
    [string] $Content = 'fixture',
    [ValidateSet(
        'ExactTerminalAdoption',
        'ResultIdentityMismatch',
        'DefiniteChildFailureWithoutDrift',
        'CatchTimeChildDrift',
        'GitRefDrift',
        'RunnerLocalMaterializationFailure',
        'TasksBytesCorruption',
        'TasksHashCorruption',
        'ResultBytesCorruption',
        'ResultHashCorruption',
        'PayloadPathCorruption',
        'PayloadBytesCorruption',
        'PayloadHashCorruption',
        'LogPathCorruption',
        'LogBytesCorruption',
        'LogHashCorruption',
        'TrackedWorktreeDirty',
        'IndexDirty'
    )]
    [string] $Scenario = 'ExactTerminalAdoption'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-FixtureSha256 {
    param([Parameter(Mandatory)][string] $Path)
    return [Convert]::ToHexString(
        [Security.Cryptography.SHA256]::HashData([IO.File]::ReadAllBytes($Path))
    ).ToLowerInvariant()
}

function Write-FixtureJson {
    param([Parameter(Mandatory)][string] $Path, [Parameter(Mandatory)] $Value)
    $Value | ConvertTo-Json -Depth 30 | Set-Content -LiteralPath $Path -Encoding utf8NoBOM
}

function Get-FixtureFileRecord {
    param([Parameter(Mandatory)][string] $Path)
    if (Test-Path -LiteralPath $Path -PathType Container) {
        return [ordered]@{ kind = 'Directory'; sha256 = 'N/A'; bytesBase64 = 'N/A' }
    }
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return [ordered]@{ kind = 'Absent'; sha256 = 'N/A'; bytesBase64 = 'N/A' }
    }
    $bytes = [IO.File]::ReadAllBytes($Path)
    return [ordered]@{ kind = 'File'; sha256 = Get-FixtureSha256 $Path; bytesBase64 = [Convert]::ToBase64String($bytes) }
}

function Get-FixtureTextRecord {
    param([Parameter(Mandatory)][string] $Text)
    $bytes = [Text.UTF8Encoding]::new($false).GetBytes($Text)
    return [ordered]@{
        kind = 'Text'
        sha256 = [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($bytes)).ToLowerInvariant()
        bytesBase64 = [Convert]::ToBase64String($bytes)
    }
}

function Write-FixtureObservation {
    param(
        [Parameter(Mandatory)][string] $Repository,
        [Parameter(Mandatory)][string] $StatePath,
        [Parameter(Mandatory)][string] $TasksPath,
        [Parameter(Mandatory)][string] $OutputFile,
        [Parameter(Mandatory)][string] $LogFile,
        [Parameter(Mandatory)][string] $Scenario,
        [bool] $LogExpected,
        [Parameter(Mandatory)] $Perturbation
    )
    $observationPath = Join-Path (Split-Path -Parent $OutputFile) "$PhaseId.child-observation.json"
    $head = (& git -C $Repository rev-parse HEAD).Trim()
    $remote = (& git -C $Repository rev-parse refs/remotes/origin/main).Trim()
    $index = @(& git -C $Repository diff --cached --name-only)
    $worktree = @(& git -C $Repository status --porcelain=v1 --untracked-files=no)
    $expectedLog = "fixture scenario=$Scenario content=$Content`n"
    Write-FixtureJson $observationPath ([ordered]@{
        schemaVersion = '1.0'
        scenario = $Scenario
        perturbation = $Perturbation
        files = [ordered]@{
            state = Get-FixtureFileRecord $StatePath
            tasks = Get-FixtureFileRecord $TasksPath
            result = Get-FixtureFileRecord $OutputFile
            payload = Get-FixtureFileRecord $TasksPath
            log = if (Test-Path -LiteralPath $LogFile) { Get-FixtureFileRecord $LogFile } elseif ($LogExpected) {
                $bytes = [Text.UTF8Encoding]::new($false).GetBytes($expectedLog)
                [ordered]@{ kind = 'File'; sha256 = [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($bytes)).ToLowerInvariant(); bytesBase64 = [Convert]::ToBase64String($bytes) }
            } else { [ordered]@{ kind = 'Absent'; sha256 = 'N/A'; bytesBase64 = 'N/A' } }
        }
        refs = [ordered]@{ head = $head; remoteDefault = $remote }
        index = @($index)
        trackedWorktree = @($worktree)
    })
}

# A preflight invocation intentionally has no output path and performs no mutation.
if ([string]::IsNullOrWhiteSpace($OutputFile)) { exit 0 }

$repositoryDirectory = [IO.DirectoryInfo]::new((Split-Path -Parent $OutputFile))
while ($null -ne $repositoryDirectory -and
    -not (Test-Path -LiteralPath (Join-Path $repositoryDirectory.FullName '.git'))) {
    $repositoryDirectory = $repositoryDirectory.Parent
}
if ($null -eq $repositoryDirectory) { throw 'Fixture repository root not found' }
$repository = $repositoryDirectory.FullName
$statePath = Join-Path $repository 'specs/999-routing-fixture/autonomous-run-state.json'
$tasksPath = Join-Path $repository 'specs/999-routing-fixture/tasks.md'
$featureDirectory = Split-Path -Parent $statePath

if ($Scenario -eq 'DefiniteChildFailureWithoutDrift') {
    $none = [ordered]@{ performed = 'ProcessExit17'; target = 'process'; before = Get-FixtureTextRecord 'Running'; after = Get-FixtureTextRecord 'Exit17' }
    Write-FixtureObservation $repository $statePath $tasksPath $OutputFile $LogFile $Scenario $false $none
    exit 17
}
if ($Scenario -eq 'CatchTimeChildDrift') {
    $driftBefore = Get-FixtureFileRecord $statePath
    $drift = Get-Content -LiteralPath $statePath -Raw -Encoding utf8 | ConvertFrom-Json -AsHashtable
    $drift.lastOperation.summary = 'Child drift persisted before a definite process failure.'
    $drift.updatedAt = [DateTime]::UtcNow.ToString('o')
    Write-FixtureJson $statePath $drift
    $driftRecord = [ordered]@{ performed = 'StateBytesChangedBeforeExit19'; target = 'state'; before = $driftBefore; after = Get-FixtureFileRecord $statePath }
    Write-FixtureObservation $repository $statePath $tasksPath $OutputFile $LogFile $Scenario $false $driftRecord
    exit 19
}

$tasks = 1..168 | ForEach-Object { '- [x] T{0:D3} Fixture task' -f $_ }
$tasks | Set-Content -LiteralPath $tasksPath -Encoding utf8NoBOM
$tasksHash = Get-FixtureSha256 $tasksPath
$payloadPath = 'specs/999-routing-fixture/tasks.md'
$result = [ordered]@{
    schemaVersion = '1.0'
    phaseId = $PhaseId
    attemptId = [guid]::NewGuid().ToString()
    outcome = 'Completed'
    expectedTasks = 168
    completedTasks = 168
    blockedReason = ''
    gatesSatisfied = $true
    payloadPath = $payloadPath
    payloadSha256 = $tasksHash
}
Write-FixtureJson $OutputFile $result
$resultHash = Get-FixtureSha256 $OutputFile

$state = Get-Content -LiteralPath $statePath -Raw -Encoding utf8 | ConvertFrom-Json -AsHashtable
$state.status = 'Completed'
$state.authorityRevalidationRequired = $false
$state.stage = 'Retrospective'
$state.tasks.sha256 = $tasksHash
$state.tasks.completed = 168
$state.nextExactAction = 'N/A'
$state.lastOperation = [ordered]@{
    kind = 'ModelRoutingPhase:implement-closeout'
    state = 'Completed'
    summary = 'Fixture terminal closeout completed.'
}
$state.closeout = [ordered]@{
    mergeOrPublication = 'Completed'
    defaultBranchSync = 'Completed'
    postMergeActions = 'Completed'
    finalValidation = 'Completed'
}
$state.updatedAt = [DateTime]::UtcNow.ToString('o')
$phase = @($state.routing.phases | Where-Object { [string] $_.phaseId -eq $PhaseId })[0]
$phase.status = 'Completed'
$phase.exitCode = 0
$phase.preflight = 'Completed'
$phase.resultPath = [IO.Path]::GetRelativePath($repository, $OutputFile).Replace('\\', '/')
$phase.resultSha256 = $resultHash
$phase.updatedAt = $state.updatedAt
Write-FixtureJson $statePath $state

$perturbation = [ordered]@{
    performed = 'None'
    target = 'N/A'
    before = Get-FixtureTextRecord 'No perturbation'
    after = Get-FixtureTextRecord 'No perturbation'
}
$payloadOtherPath = Join-Path $featureDirectory 'payload-other.md'
switch ($Scenario) {
    'ResultIdentityMismatch' {
        $perturbation.performed = 'StateRunIdIdentityCorruption'
        $perturbation.target = 'state'
        $perturbation.before = Get-FixtureFileRecord $statePath
        $state.runId = [guid]::NewGuid().ToString()
        Write-FixtureJson $statePath $state
        $perturbation.after = Get-FixtureFileRecord $statePath
    }
    'TasksBytesCorruption' {
        $perturbation.performed = 'TasksBytesChangedWithoutHashUpdate'
        $perturbation.target = 'tasks'
        $perturbation.before = Get-FixtureFileRecord $tasksPath
        Add-Content -LiteralPath $tasksPath -Value '# adversarial tasks bytes' -Encoding utf8NoBOM
        $perturbation.after = Get-FixtureFileRecord $tasksPath
    }
    'TasksHashCorruption' {
        $perturbation.performed = 'StateTasksHashChangedWithoutBytesUpdate'
        $perturbation.target = 'state.tasks.sha256'
        $perturbation.before = Get-FixtureFileRecord $statePath
        $state.tasks.sha256 = 'b' * 64
        Write-FixtureJson $statePath $state
        $perturbation.after = Get-FixtureFileRecord $statePath
    }
    'ResultBytesCorruption' {
        $perturbation.performed = 'ResultBytesChangedWithoutStateHashUpdate'
        $perturbation.target = 'result'
        $perturbation.before = Get-FixtureFileRecord $OutputFile
        $result.attemptId = [guid]::NewGuid().ToString()
        Write-FixtureJson $OutputFile $result
        $perturbation.after = Get-FixtureFileRecord $OutputFile
    }
    'ResultHashCorruption' {
        $perturbation.performed = 'StateResultHashChangedWithoutBytesUpdate'
        $perturbation.target = 'state.routing.resultSha256'
        $perturbation.before = Get-FixtureFileRecord $statePath
        $phase.resultSha256 = 'b' * 64
        Write-FixtureJson $statePath $state
        $perturbation.after = Get-FixtureFileRecord $statePath
    }
    'PayloadPathCorruption' {
        $perturbation.performed = 'ResultPayloadPathChangedToDifferentContainedFile'
        $perturbation.target = 'result.payloadPath'
        $perturbation.before = Get-FixtureFileRecord $OutputFile
        Copy-Item -LiteralPath $tasksPath -Destination $payloadOtherPath
        $result.payloadPath = 'specs/999-routing-fixture/payload-other.md'
        Write-FixtureJson $OutputFile $result
        $phase.resultSha256 = Get-FixtureSha256 $OutputFile
        Write-FixtureJson $statePath $state
        $perturbation.after = Get-FixtureFileRecord $OutputFile
    }
    'PayloadBytesCorruption' {
        $perturbation.performed = 'PayloadBytesChangedWithTasksHashButWithoutPayloadHashUpdate'
        $perturbation.target = 'payload/tasks'
        $perturbation.before = Get-FixtureFileRecord $tasksPath
        Add-Content -LiteralPath $tasksPath -Value '# adversarial payload bytes' -Encoding utf8NoBOM
        $state.tasks.sha256 = Get-FixtureSha256 $tasksPath
        Write-FixtureJson $statePath $state
        $perturbation.after = Get-FixtureFileRecord $tasksPath
    }
    'PayloadHashCorruption' {
        $perturbation.performed = 'ResultPayloadHashChangedWithoutPayloadBytesUpdate'
        $perturbation.target = 'result.payloadSha256'
        $perturbation.before = Get-FixtureFileRecord $OutputFile
        $result.payloadSha256 = 'b' * 64
        Write-FixtureJson $OutputFile $result
        $phase.resultSha256 = Get-FixtureSha256 $OutputFile
        Write-FixtureJson $statePath $state
        $perturbation.after = Get-FixtureFileRecord $OutputFile
    }
}

& git -C $repository add -- $statePath $tasksPath
if ($LASTEXITCODE -ne 0) { throw 'Fixture could not stage terminal State and Tasks.' }
& git -C $repository commit --quiet -m 'test: terminal fixture transition'
if ($LASTEXITCODE -ne 0) { throw 'Fixture could not commit terminal State and Tasks.' }
$head = (& git -C $repository rev-parse HEAD).Trim()
if ($Scenario -ne 'GitRefDrift') {
    & git -C $repository update-ref refs/remotes/origin/main $head
    if ($LASTEXITCODE -ne 0) { throw 'Fixture could not advance the remote default tracking ref.' }
} else {
    $remote = (& git -C $repository rev-parse refs/remotes/origin/main).Trim()
    $perturbation = [ordered]@{
        performed = 'RemoteDefaultRefNotAdvancedToTerminalHead'
        target = 'refs/remotes/origin/main'
        before = Get-FixtureTextRecord "head=$head remote=$head"
        after = Get-FixtureTextRecord "head=$head remote=$remote"
    }
}
if ($Scenario -eq 'RunnerLocalMaterializationFailure') {
    [void](New-Item -ItemType Directory -Path $LogFile -Force)
    $perturbation = [ordered]@{ performed = 'LogMaterializationPathIsDirectory'; target = 'log'; before = [ordered]@{ kind = 'Absent'; sha256 = 'N/A'; bytesBase64 = 'N/A' }; after = Get-FixtureFileRecord $LogFile }
}
if ($Scenario -in @('LogPathCorruption', 'LogBytesCorruption', 'LogHashCorruption')) {
    $perturbationName = switch ($Scenario) {
        'LogPathCorruption' { 'LogPathReplacedByReadOnlySymlink' }
        'LogBytesCorruption' { 'LogBytesPreMaterializedReadOnly' }
        default { 'LogHashPreMaterializedReadOnly' }
    }
    $perturbation = [ordered]@{ performed = $perturbationName; target = 'log'; before = [ordered]@{ kind = 'Absent'; sha256 = 'N/A'; bytesBase64 = 'N/A' }; after = $null }
    if ($Scenario -eq 'LogPathCorruption') {
        $target = Join-Path (Split-Path -Parent $LogFile) 'outside-log-target.txt'
        Set-Content -LiteralPath $target -Value 'adversarial log path' -Encoding utf8NoBOM
        & chmod 444 $target
        [void](New-Item -ItemType SymbolicLink -Path $LogFile -Target $target)
    } else {
        $content = if ($Scenario -eq 'LogBytesCorruption') { 'adversarial log bytes' } else { 'adversarial log hash' }
        Set-Content -LiteralPath $LogFile -Value $content -Encoding utf8NoBOM
        & chmod 444 $LogFile
    }
    $perturbation.after = Get-FixtureFileRecord $LogFile
}
if ($Scenario -eq 'TrackedWorktreeDirty') {
    $sentinelPath = Join-Path $featureDirectory 'tracked-sentinel.txt'
    $perturbation = [ordered]@{ performed = 'TrackedWorktreeFileChanged'; target = 'tracked-worktree'; before = Get-FixtureFileRecord $sentinelPath; after = $null }
    Add-Content -LiteralPath $sentinelPath -Value 'post-commit tracked drift' -Encoding utf8NoBOM
    $perturbation.after = Get-FixtureFileRecord $sentinelPath
}
if ($Scenario -eq 'IndexDirty') {
    $indexPath = Join-Path $featureDirectory 'staged-drift.txt'
    $perturbation = [ordered]@{ performed = 'IndexPathStaged'; target = 'index'; before = [ordered]@{ kind = 'Absent'; sha256 = 'N/A'; bytesBase64 = 'N/A' }; after = $null }
    Set-Content -LiteralPath $indexPath -Value 'staged adversarial drift' -Encoding utf8NoBOM
    & git -C $repository add -- $indexPath
    if ($LASTEXITCODE -ne 0) { throw 'Fixture could not stage adversarial index drift.' }
    $perturbation.after = Get-FixtureFileRecord $indexPath
}
Write-FixtureObservation $repository $statePath $tasksPath $OutputFile $LogFile $Scenario ($Scenario -ne 'RunnerLocalMaterializationFailure') $perturbation
Write-Output "fixture scenario=$Scenario content=$Content"
exit 0
