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

.PARAMETER GitRetryAttempts
    Maximale begrenzte Versuche fuer transiente Fetch-/Fast-forward-Fehler.
    Authentifizierungs- und Repository-Zustandsfehler werden nicht wiederholt.

    Maximum bounded attempts for transient fetch and fast-forward pull
    failures. Authentication and repository-state failures are not retried.

.PARAMETER GitTimeoutSeconds
    Harte Zeitgrenze fuer einen Fetch- oder Pull-Versuch.

    Hard timeout for one fetch or pull attempt.

.PARAMETER WinGetTimeoutSeconds
    Harte Zeitgrenze fuer jeden weitergereichten WinGet-Unterprozess. Ein
    Upgrade oder Installer, der nicht sicher abgeschlossen werden kann, wird
    als DEFERRED_ADMIN_REQUIRED gemeldet.

    Hard timeout forwarded to every WinGet subprocess. An upgrade or installer
    that cannot complete safely is reported as DEFERRED_ADMIN_REQUIRED.

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
    Exitcode, sichtbarer Abschluss und JSON-Bericht werden aus derselben Run-ID
    abgeleitet. Eigene reparierte Dirty-Zwischenstaende werden nur mit exakt
    passender atomarer Resume-Evidence akzeptiert.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [switch] $CheckOnly,
    [switch] $ScriptsOnly,
    [switch] $RepairDrift,
    [switch] $IncludeOptional,
    [switch] $AllowAdminPrompts,
    [string] $ManifestPath,
    [string] $HomeDir = [Environment]::GetFolderPath('UserProfile'),
    [ValidateRange(1, 10)][int] $GitRetryAttempts = 3,
    [ValidateRange(5, 3600)][int] $GitTimeoutSeconds = 300,
    [ValidateRange(5, 86400)][int] $WinGetTimeoutSeconds = 1800
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$script:HBMaintenanceScriptPath = $PSCommandPath
$hardeningModule = Join-Path $PSScriptRoot 'lib/windows-maintenance-hardening.psm1'
if (-not (Test-Path -LiteralPath $hardeningModule -PathType Leaf)) {
    throw "Windows-Wartungsmodul fehlt / Windows maintenance module missing: ${hardeningModule}"
}
Import-Module $hardeningModule -Force

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
        [string] $HomeDir = [Environment]::GetFolderPath('UserProfile'),
        [ValidateRange(1, 10)][int] $GitRetryAttempts = 3,
        [ValidateRange(5, 3600)][int] $GitTimeoutSeconds = 300,
        [ValidateRange(5, 86400)][int] $WinGetTimeoutSeconds = 1800
    )
    $parameters = @{
        CheckOnly = $CheckOnly
        ScriptsOnly = $ScriptsOnly
        RepairDrift = $RepairDrift
        IncludeOptional = $IncludeOptional
        AllowAdminPrompts = $AllowAdminPrompts
        HomeDir = $HomeDir
        GitRetryAttempts = $GitRetryAttempts
        GitTimeoutSeconds = $GitTimeoutSeconds
        WinGetTimeoutSeconds = $WinGetTimeoutSeconds
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
$maintenanceMode = Get-HBMaintenanceMode -CheckOnly:$CheckOnly -Preview:$WhatIfPreference

$sourceRoot = (Resolve-Path -LiteralPath (Split-Path -Parent $PSScriptRoot)).Path
$presetProfileCatalog = Join-Path $sourceRoot 'scripts/config/spec-kit-preset-profiles.json'
$fleetPresetProfile = 'intake-sequencing-eleven-governance-presets'
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
    $forward.GitRetryAttempts = $GitRetryAttempts
    $forward.GitTimeoutSeconds = $GitTimeoutSeconds
    $forward.WinGetTimeoutSeconds = $WinGetTimeoutSeconds
    & $repoScript @forward
    exit $LASTEXITCODE
}
$registry = Join-Path $HomeDir '.home-baseline/level2-repository-registry.json'
$stateDir = Join-Path $HomeDir '.home-baseline'
$lockDir = Join-Path $stateDir 'locks/agentic-workspace-maintenance.lock'
$logDir = Join-Path $stateDir 'logs'
$reportDir = Join-Path $stateDir 'reports'
$resumeEvidenceFile = Join-Path $stateDir 'agentic-workspace-resume.json'
$script:Findings = 0
$script:RepairApplied = $false
$script:PreviewDrift = $false
$script:ResumeAllowedPaths = @()
$exitCode = 0
$transcriptStarted = $false
$runId = [Guid]::NewGuid().ToString()
$reportFile = Join-Path $reportDir "agentic-workspace-${runId}.json"
if (-not (Test-Path -LiteralPath $fleetEngine -PathType Leaf)) {
    throw "Fleet-Vertragskern fehlt / fleet contract engine missing: ${fleetEngine}"
}

function Write-HBEarlyFailureReport {
    param(
        [Parameter(Mandatory)][string]$Status,
        [Parameter(Mandatory)][int]$ExitCode,
        [Parameter(Mandatory)][string]$Summary,
        [Parameter(Mandatory)][string]$NextAction
    )
    New-Item -ItemType Directory -Path $reportDir -Force | Out-Null
    $payload = [ordered]@{
        schemaVersion = '1.0'
        runId = $runId
        platform = 'win32'
        mode = $maintenanceMode.FleetMode
        startedAt = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
        completedAt = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
        overallStatus = $Status
        exitCode = $ExitCode
        stages = @([ordered]@{
            stageId = 'prerequisites'
            status = if ($ExitCode -eq 2) { 'Failed' } else { 'Blocked' }
            exitCode = $ExitCode
            durationMs = 0
            summary = $Summary
            nextAction = $NextAction
        })
        targets = @()
        toolchain = @()
        findings = @([ordered]@{
            code = 'PrerequisiteUnavailable'
            severity = if ($ExitCode -eq 2) { 'Fatal' } else { 'Blocking' }
            summary = $Summary
            nextAction = $NextAction
        })
        artifacts = [ordered]@{ logPath = 'N/A'; reportPath = $reportFile }
    }
    [IO.File]::WriteAllText(
        $reportFile,
        ($payload | ConvertTo-Json -Depth 8) + "`n",
        [Text.UTF8Encoding]::new($false)
    )
}

try {
    $script:HBPythonLauncher = Resolve-HBPythonLauncher
} catch {
    $message = 'Kein validierter Python-3-Launcher / no validated Python 3 launcher.'
    $next = 'Python 3 installieren oder den defekten Store-Alias deaktivieren, dann erneut ausfuehren / install Python 3 or disable the broken Store alias, then retry'
    Write-HBEarlyFailureReport -Status FAILED -ExitCode 2 -Summary $message -NextAction $next
    Write-Host "Fehler / Error: ${message}" -ForegroundColor Red
    Write-Host "Report / Bericht: ${reportFile}"
    exit 2
}

try {
    $profileCatalogData = Get-Content -LiteralPath $presetProfileCatalog -Raw -Encoding UTF8 | ConvertFrom-Json
    $profileProperty = $profileCatalogData.profiles.PSObject.Properties[$fleetPresetProfile]
    if ($null -eq $profileProperty -or -not $profileProperty.Value.presetConfig) {
        throw "Unbekanntes Flottenprofil / unknown fleet profile: ${fleetPresetProfile}"
    }
    $fleetPresetConfig = Join-Path $sourceRoot ([string]$profileProperty.Value.presetConfig)
    $fleetPresetCount = @(
        (Get-Content -LiteralPath $fleetPresetConfig -Raw -Encoding UTF8 | ConvertFrom-Json).presets
    ).Count
    if ($fleetPresetCount -ne 11) {
        throw "Flottenprofil hat ${fleetPresetCount} statt 11 Presets / has an unexpected preset count."
    }
} catch {
    Write-HBEarlyFailureReport -Status FAILED -ExitCode 2 -Summary $_.Exception.Message `
        -NextAction 'Preset-Profilkatalog und Matrix pruefen / review profile catalog and matrix'
    Write-Host "Fehler / Error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "Report / Bericht: ${reportFile}"
    exit 2
}

function Invoke-HBPythonCommand {
    param([Parameter(Mandatory)][string[]]$Arguments)
    $commandArguments = @($script:HBPythonLauncher.PrefixArguments) + @($Arguments)
    & $script:HBPythonLauncher.FilePath @commandArguments
}

$requiredAnalyzerVersion = [Version]'1.25.0'
$analyzerAvailable = $null -ne (
    Get-Module -ListAvailable PSScriptAnalyzer |
        Where-Object { $_.Version -eq $requiredAnalyzerVersion } |
        Select-Object -First 1
)
if (-not $analyzerAvailable -and $maintenanceMode.AllowsMutation) {
    $message = "PSScriptAnalyzer ${requiredAnalyzerVersion} fehlt vor der ersten Mutation / is missing before the first mutation."
    $next = 'pwsh -NoProfile -File scripts/maintain-powershell-modules.ps1 ausfuehren / run the module maintainer, then retry'
    Write-HBEarlyFailureReport -Status BLOCKED -ExitCode 1 -Summary $message -NextAction $next
    Write-Warning $message
    Write-Host "Report / Bericht: ${reportFile}"
    exit 1
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
    Invoke-HBPythonCommand -Arguments @(
        $fleetEngine, 'stage',
        '--report', $reportFile,
        '--stage-id', $StageId,
        '--status', $Status,
        '--exit-code', [string]$ExitCode,
        '--summary', $Summary,
        '--next-action', $NextAction
    )
    if ($LASTEXITCODE -ne 0) {
        throw "Run-Bericht konnte nicht aktualisiert werden / run report update failed: ${StageId}"
    }
}

function Invoke-HBFleetContract {
    $arguments = @(
        $fleetEngine, 'fleet',
        '--manifest', $ManifestPath,
        '--home-dir', $HomeDir,
        '--mode', $maintenanceMode.FleetMode,
        '--report', $reportFile,
        '--log', $logFile,
        '--run-id', $runId
    )
    foreach ($path in $script:ResumeAllowedPaths) {
        $arguments += @('--allowed-dirty-path', $path)
    }
    Invoke-HBPythonCommand -Arguments $arguments | ForEach-Object { Write-Host $_ }
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
    # The parent preview must not implicitly add WhatIf to the nested,
    # intentionally read-only CheckOnly contract.
    & $syncScript -NoPull -CheckOnly -WhatIf:$false
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
    $isNetworkOperation = $Arguments.Count -gt 0 -and $Arguments[0] -in @('fetch', 'pull')
    if ($isNetworkOperation) {
        $gitCommand = Get-Command git -ErrorAction Stop
        $networkResult = Invoke-HBWithRetry -MaximumAttempts $GitRetryAttempts -Operation {
            Invoke-HBBoundedProcess -FilePath $gitCommand.Source `
                -Arguments (@('-C', $Repository) + $Arguments) `
                -TimeoutMilliseconds ($GitTimeoutSeconds * 1000) `
                -CommandLabel "git $($Arguments[0])"
        }
        if (-not $networkResult.Succeeded) {
            throw "git $($Arguments -join ' ') fehlgeschlagen / failed nach $($networkResult.Attempts) Versuch(en): $($networkResult.Summary)"
        }
        if ($Capture) {
            return @($networkResult.StandardOutput -split '\r?\n' | Where-Object { $_ })
        }
        if ($networkResult.StandardOutput) { Write-Host $networkResult.StandardOutput }
        if ($networkResult.StandardError) { Write-Verbose $networkResult.StandardError }
        return
    }
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

    try {
        Invoke-HBGit -Repository $Repository -Arguments @('fetch', '--prune')
    } catch {
        Write-HBWarning "${Label} Netzwerkzugriff fehlgeschlagen / network operation failed: $($_.Exception.Message)"
        $script:Findings++
        return $false
    }
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
        try {
            Invoke-HBGit -Repository $Repository -Arguments @('pull', '--ff-only')
        } catch {
            Write-HBWarning "${Label} Fast-forward fehlgeschlagen / failed: $($_.Exception.Message)"
            $script:Findings++
            return $false
        }
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
        Invoke-HBPythonCommand -Arguments @(
            $fleetEngine, 'canonical-repositories',
            '--manifest', $ManifestPath,
            '--home-dir', $HomeDir,
            '--existing-only'
        )
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

function Get-HBManagedDirtyPaths {
    $paths = [Collections.Generic.List[string]]::new()
    foreach ($repository in Get-HBManagedRepositories) {
        $repositoryRelative = [IO.Path]::GetRelativePath($HomeDir, $repository.Path).Replace('\', '/')
        $statusLines = @(& git -C $repository.Path -c core.quotePath=false status --porcelain=v1 --untracked-files=all)
        if ($LASTEXITCODE -ne 0) {
            throw "Dirty-Pfade konnten nicht gelesen werden / could not read dirty paths: $($repository.Path)"
        }
        foreach ($line in $statusLines) {
            if ([string]::IsNullOrWhiteSpace([string]$line) -or ([string]$line).Length -lt 4) { continue }
            $relative = ([string]$line).Substring(3).Trim()
            if ($relative -match ' -> ') { $relative = ($relative -split ' -> ', 2)[1] }
            $paths.Add("${repositoryRelative}/$($relative.Replace('\', '/'))")
        }
    }
    return @($paths | Sort-Object -Unique)
}

function Initialize-HBResumeState {
    if (-not (Test-Path -LiteralPath $resumeEvidenceFile -PathType Leaf)) { return }
    $evidence = Get-Content -LiteralPath $resumeEvidenceFile -Raw -Encoding UTF8 | ConvertFrom-Json
    $dirtyPaths = @(Get-HBManagedDirtyPaths)
    if ($evidence.status -eq 'Applied') {
        if ($dirtyPaths.Count -eq 0) {
            $files = @($evidence.files | ForEach-Object {
                [pscustomobject]@{
                    Path = $_.path
                    BeforeSha256 = $_.beforeSha256
                    AfterSha256 = $_.afterSha256
                }
            })
            $null = Write-HBResumeEvidence -Path $resumeEvidenceFile -RunId ([string]$evidence.runId) `
                -Phase ([string]$evidence.phase) -Files $files -Status Archived `
                -NextAction 'N/A'
            return
        }
        $validation = Test-HBResumeEvidence -Path $resumeEvidenceFile -Root $HomeDir -DirtyPaths $dirtyPaths
        if (-not $validation.Valid) {
            throw "Resume-Evidence passt nicht exakt / does not match exactly: $($validation.Reason)"
        }
        $script:ResumeAllowedPaths = @($evidence.files | ForEach-Object { [string]$_.path })
        $script:RepairApplied = $true
        Write-Host "OK: Resume-Evidence exakt validiert / exact resume evidence validated: $($validation.RunId)"
        return
    }
    if ($evidence.status -eq 'Prepared' -and $dirtyPaths.Count -gt 0) {
        throw 'Unterbrochene Reparatur ist nur teilweise belegt; manueller Review erforderlich / interrupted repair is only partially evidenced; manual review required.'
    }
}

function Get-HBPropagationPlan {
    $manifestPath = Join-Path $sourceRoot 'scripts/config/agentic-toolchain-maintenance-files.json'
    $manifest = Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8 | ConvertFrom-Json
    $changes = [Collections.Generic.List[object]]::new()
    foreach ($repository in Get-HBManagedRepositories) {
        foreach ($file in @($manifest.files)) {
            $source = Join-Path $sourceRoot ([string]$file.path)
            $target = Join-Path $repository.Path ([string]$file.path)
            $different = -not (Test-Path -LiteralPath $target -PathType Leaf)
            if (-not $different) {
                $sourceHash = Get-HBGitNormalizedHash -Repository $repository.Path -Path $source `
                    -RepositoryRelativePath ([string]$file.path)
                $targetHash = Get-HBGitNormalizedHash -Repository $repository.Path -Path $target `
                    -RepositoryRelativePath ([string]$file.path)
                $different = $sourceHash -ne $targetHash
            }
            if (-not $different) { continue }
            $changes.Add([pscustomobject]@{
                Path = [IO.Path]::GetRelativePath($HomeDir, $target).Replace('\', '/')
                BeforeSha256 = Get-HBFileSha256 -Path $target
                AfterSha256 = Get-HBFileSha256 -Path $source
            })
        }
    }
    return @($changes | Sort-Object Path)
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
            PresetProfile = $fleetPresetProfile
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
        $previewOutput = @(& $propagation -HomeDir $HomeDir -Registry $registry -DryRun 6>&1)
        $previewStatus = if ($null -eq $LASTEXITCODE) { 0 } else { $LASTEXITCODE }
        $previewOutput | ForEach-Object { Write-Host "$_" }
        if ($previewStatus -ne 0) {
            $script:Findings++
        } elseif ($previewOutput -match 'repositories\.drifted:\s+[1-9][0-9]*') {
            $script:PreviewDrift = $true
        }
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
            $plannedChanges = @(Get-HBPropagationPlan)
            if ($plannedChanges.Count -eq 0) {
                throw 'Propagation meldet Drift ohne aktionsfaehige Dateien / reported drift without actionable files.'
            }
            $null = Write-HBResumeEvidence -Path $resumeEvidenceFile -RunId $runId `
                -Phase 'propagation' -Files $plannedChanges -Status Prepared `
                -NextAction 'Propagation ausfuehren und Hashes verifizieren / execute propagation and verify hashes'
            & $propagation -HomeDir $HomeDir -Registry $registry
            if ($LASTEXITCODE -ne 0) { throw 'Propagation fehlgeschlagen / failed.' }
            foreach ($change in $plannedChanges) {
                $current = Get-HBFileSha256 -Path (Join-Path $HomeDir $change.Path)
                if ($current -ne $change.AfterSha256) {
                    throw "Propagation-Nachher-Hash stimmt nicht / after-hash mismatch: $($change.Path)"
                }
            }
            $null = Write-HBResumeEvidence -Path $resumeEvidenceFile -RunId $runId `
                -Phase 'propagation' -Files $plannedChanges -Status Applied `
                -NextAction 'Geaenderte Ziel-Repositories separat pruefen und liefern / review and deliver changed target repositories separately'
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

New-Item -ItemType Directory -Path (Split-Path -Parent $lockDir), $logDir, $reportDir `
    -Force -WhatIf:$false | Out-Null
try {
    New-Item -ItemType Directory -Path $lockDir -ErrorAction Stop -WhatIf:$false | Out-Null
} catch {
    $holder = if (Test-Path (Join-Path $lockDir 'pid')) { Get-Content (Join-Path $lockDir 'pid') -Raw } else { 'unbekannt / unknown' }
    Write-Host "Fehler / Error: Wartung laeuft bereits (PID $($holder.Trim())) / maintenance already running." -ForegroundColor Red
    exit 2
}
Set-Content -LiteralPath (Join-Path $lockDir 'pid') -Value $PID -WhatIf:$false
$logFile = Join-Path $logDir "agentic-workspace-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

try {
    # Lock, log and report are mode-independent control evidence, not a
    # previewed workspace mutation.
    Start-Transcript -Path $logFile -Append -WhatIf:$false | Out-Null
    $transcriptStarted = $true
    $env:HOME = $HomeDir
    $env:USERPROFILE = $HomeDir
    $env:HB_GIT_RETRY_ATTEMPTS = [string]$GitRetryAttempts
    $env:HB_GIT_TIMEOUT_SECONDS = [string]$GitTimeoutSeconds

    $mode = $maintenanceMode.Name
    if ($ScriptsOnly) { $mode += ', scripts-only' }
    Write-Host 'Agentic workspace maintenance'
    Write-Host "Mode / Modus: ${mode}"
    Write-Host "Level-0: ${sourceRoot}"
    Write-Host "Home: ${HomeDir}"
    Write-Host "Run-ID: ${runId}"

    try {
        Initialize-HBResumeState
    } catch {
        Write-HBEarlyFailureReport -Status BLOCKED -ExitCode 1 `
            -Summary $_.Exception.Message `
            -NextAction 'Resume-Evidence und alle Dirty-Pfade manuell pruefen / manually review resume evidence and every dirty path'
        throw
    }

    Write-HBInfo 'Level-0 aktualisieren / Update Level-0'
    $level0Passed = Test-HBRepository -Repository $sourceRoot -Label 'Level-0'

    $homeStatus = 'Skipped'
    if ($script:Findings -eq 0) {
        Write-HBInfo 'Lokale Home-Baseline synchronisieren / Synchronize local home baseline'
        $findingsBefore = $script:Findings
        $syncScript = Join-Path $sourceRoot 'scripts/sync-home.ps1'
        $homeInvocationStatus = 0
        switch ($maintenanceMode.Name) {
            'CheckOnly' {
                Test-HBHomeSync
            }
            'Preview' {
                & $syncScript -NoPull -WhatIf
                $homeInvocationStatus = if ($null -eq $LASTEXITCODE) { 0 } else { $LASTEXITCODE }
            }
            'Update' {
                & $syncScript -NoPull
                $homeInvocationStatus = if ($null -eq $LASTEXITCODE) { 0 } else { $LASTEXITCODE }
            }
        }
        if ($homeInvocationStatus -ne 0) { throw 'sync-home fehlgeschlagen / failed.' }
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
    if ($analyzerAvailable) {
        Add-HBReportStage -StageId 'prerequisites' -Status Passed -ExitCode 0 `
            -Summary "Python 3 und PSScriptAnalyzer ${requiredAnalyzerVersion} validiert / validated"
    } else {
        Add-HBReportStage -StageId 'prerequisites' -Status Blocked -ExitCode 1 `
            -Summary "PSScriptAnalyzer ${requiredAnalyzerVersion} fehlt / is missing" `
            -NextAction 'pwsh -NoProfile -File scripts/maintain-powershell-modules.ps1 ausfuehren / run the module maintainer'
        $script:Findings++
    }

    Write-HBInfo 'Level-1/Level-2 Registry pruefen / Check Level-1/Level-2 registry'
    $findingsBefore = $script:Findings
    Test-HBRegistry
    $registrySafe = $false
    if (Test-Path -LiteralPath $registry -PathType Leaf) {
        Invoke-HBPythonCommand -Arguments @(
            $fleetEngine, 'registry', '--manifest', $ManifestPath, '--registry', $registry
        ) |
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
            -Summary "Registry-Pruefung abgeschlossen / completed; source=scripts/config/spec-kit-preset-profiles.json; profile=${fleetPresetProfile}; presets=${fleetPresetCount}"
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
            } elseif ($WhatIfPreference -and $script:PreviewDrift) {
                Add-HBReportStage -StageId 'propagation' -Status Warning -ExitCode 1 `
                    -Summary 'Wartungspaket-Drift vorhergesagt / maintenance package drift predicted' `
                    -NextAction 'Mit -RepairDrift lokal reparieren / repair locally with -RepairDrift'
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
        $parameters.ProcessTimeoutSeconds = $WinGetTimeoutSeconds
        $optionalDeferred = $IncludeOptional -and -not $AllowAdminPrompts
        if ($IncludeOptional -and $AllowAdminPrompts) { $parameters.IncludeOptional = $true }
        if ($optionalDeferred) {
            Write-HBWarning 'DEFERRED_ADMIN_REQUIRED: optionale Pakete benoetigen aktuelle Admin-Prompt-Autoritaet / optional packages require current authority.'
        }
        $env:HB_ALLOW_ADMIN_PROMPTS = if ($AllowAdminPrompts) { '1' } else { '0' }
        & $maintenance @parameters
        $toolchainExit = if ($null -eq $LASTEXITCODE) { 0 } else { $LASTEXITCODE }
        if ($toolchainExit -eq 75 -or $optionalDeferred) {
            $script:Findings++
            Add-HBReportStage -StageId 'toolchain' -Status Blocked -ExitCode 1 `
                -Summary 'DEFERRED_ADMIN_REQUIRED' `
                -NextAction 'Mit aktueller Autoritaet erneut ausfuehren / rerun with current authority'
        } elseif ($toolchainExit -ne 0) {
            throw 'WinGet-Wartung fehlgeschlagen / maintenance failed.'
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
        if ($WhatIfPreference) {
            $findingsBefore = $script:Findings
            Test-HBHomeSync
            if ($script:Findings -gt $findingsBefore) {
                Add-HBReportStage -StageId 'home-sync' -Status Blocked -ExitCode 1 `
                    -Summary 'Home-Sync-Drift vorhergesagt / home sync drift predicted' `
                    -NextAction 'Echten Home-Sync nach dem Merge ausfuehren / run actual home sync after merge'
            }
        } else {
            Test-HBHomeSync
            if ((Invoke-HBPropagationCheck) -ne 0) { throw 'Abschliessende Propagationspruefung fehlgeschlagen / final propagation check failed.' }
        }
        [void](Test-HBRepository -Repository $sourceRoot -Label 'Level-0')
        foreach ($repo in Get-HBManagedRepositories) {
            [void](Test-HBRepository -Repository $repo.Path -Label "Level-$($repo.Level)" -AllowRepairDirty:$script:RepairApplied)
        }
        if ($WhatIfPreference -and $script:PreviewDrift) {
            $script:Findings++
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
    if (Test-Path -LiteralPath $reportFile -PathType Leaf) {
        try {
            $existingReport = Get-Content -LiteralPath $reportFile -Raw -Encoding UTF8 | ConvertFrom-Json
            if ($existingReport.runId -eq $runId -and $existingReport.overallStatus -ne 'BLOCKED') {
                Add-HBReportStage -StageId 'final' -Status Failed -ExitCode 2 `
                    -Summary 'Wartung fehlgeschlagen / maintenance failed' `
                    -NextAction 'Log und Bericht pruefen / review log and report'
            }
        } catch {
            $exitCode = 2
        }
    }
} finally {
    if ($transcriptStarted) { Stop-Transcript -WhatIf:$false | Out-Null }
    if (Test-Path -LiteralPath $lockDir) {
        Remove-Item -LiteralPath $lockDir -Recurse -Force -WhatIf:$false
    }
    Write-Host "Log / log: ${logFile}"
    if (Test-Path -LiteralPath $reportFile -PathType Leaf) {
        try {
            $terminalReport = Get-Content -LiteralPath $reportFile -Raw -Encoding UTF8 | ConvertFrom-Json
            if ($terminalReport.runId -ne $runId) {
                throw 'Report-Run-ID stimmt nicht mit dem aktuellen Lauf ueberein / does not match the current run.'
            }
            $exitCode = [int]$terminalReport.exitCode
            Write-Host "Status / status: $($terminalReport.overallStatus) (exit ${exitCode})"
        } catch {
            Write-Host "Fehler / Error: $($_.Exception.Message)" -ForegroundColor Red
            $exitCode = 2
        }
        Write-Host "Report / Bericht: ${reportFile}"
    }
}

exit (Get-HBCanonicalExitCode -Status $(switch ($exitCode) {
    0 { 'SUCCESS' }
    1 { 'PARTIAL' }
    2 { 'FAILED' }
    3 { 'REPAIRED' }
    default { 'FAILED' }
}))
