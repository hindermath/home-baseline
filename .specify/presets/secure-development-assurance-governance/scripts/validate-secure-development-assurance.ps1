<#
.SYNOPSIS
Validiert Secure-Development-Evidence.

.DESCRIPTION
Prüft die Gates baseline, delta, closure und image-impact. Technische
Validierung, Pilotfreigabe, Projektabnahme und allgemeine Freigabe bleiben
getrennt. Status ist read-only; Review validiert nur vorhandene Evidence.

.PARAMETER Action
Status oder Review.

.PARAMETER EvidenceDirectory
Explizites Evidence-Verzeichnis für Status.

.PARAMETER Gate
Baseline, Delta, Closure oder Image-Impact.

.PARAMETER ContextId
Kleine Buchstaben, Zahlen und Bindestriche.

.PARAMETER Mode
Training, Mixed oder Development.

.EXAMPLE
pwsh -NoProfile -File validate-secure-development-assurance.ps1 -Action Status -EvidenceDirectory docs/security/secure-development/2026-08-29-example

.EXAMPLE
pwsh -NoProfile -File validate-secure-development-assurance.ps1 -Action Review -Gate baseline -ContextId example -Mode training
#>
[CmdletBinding()]
param(
    [ValidateSet('Status', 'Review')]
    [string]$Action = 'Status',
    [string]$EvidenceDirectory,
    [ValidateSet('baseline', 'delta', 'closure', 'image-impact')]
    [string]$Gate,
    [string]$ContextId,
    [ValidateSet('training', 'mixed', 'development')]
    [string]$Mode
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Stop-SDAValidation {
    param([Parameter(Mandatory)][string]$Message)
    throw "Blocked: ${Message}"
}

function Test-SDAAllowedValue {
    param(
        [Parameter(Mandatory)][string]$Value,
        [Parameter(Mandatory)][string[]]$Allowed
    )
    if ($Value -notin $Allowed) {
        Stop-SDAValidation "Unzulässiger Wert '${Value}'."
    }
}

function Test-SDAGateFile {
    param(
        [Parameter(Mandatory)][string]$Path,
        [Parameter(Mandatory)][string]$ExpectedGate
    )
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        Stop-SDAValidation "Evidence fehlt: ${Path}"
    }
    $document = Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json -Depth 100
    if ($document.gate -ne $ExpectedGate) {
        Stop-SDAValidation "Gate-Drift in ${Path}: $($document.gate)"
    }
    Test-SDAAllowedValue -Value $document.outcome -Allowed @('Ready', 'ReadyWithAcceptedRisks', 'NeedsRemediation', 'Blocked')
    if (@($document.assessments).Count -eq 0) {
        Stop-SDAValidation "Assessments fehlen: ${Path}"
    }
    foreach ($assessment in $document.assessments) {
        Test-SDAAllowedValue -Value $assessment.applicability -Allowed @('Applicable', 'N/A', 'Open')
        Test-SDAAllowedValue -Value $assessment.implementation -Allowed @('Fulfilled', 'Partly Fulfilled', 'Not Fulfilled', 'Not Assessed')
    }
    if ($document.outcome -eq 'Ready') {
        $blockedItems = @($document.assessments | Where-Object {
            $_.applicability -eq 'Open' -or
            ($_.applicability -eq 'Applicable' -and $_.implementation -ne 'Fulfilled')
        })
        if ($blockedItems.Count -gt 0) {
            Stop-SDAValidation "Ready ist bei offenen oder unerfüllten Pflichtpunkten unzulässig: ${Path}"
        }
    }
    if ($document.externalComparisonBoundary -ne 'HOSK/GWDG: ExternalComparison only; never local evidence') {
        Stop-SDAValidation "Externe Vergleichsgrenze fehlt: ${Path}"
    }
}

function Test-SDAContext {
    param([Parameter(Mandatory)][string]$Path)
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        Stop-SDAValidation "Evidence-Verzeichnis fehlt: ${Path}"
    }
    if (-not (Test-Path -LiteralPath (Join-Path $Path 'evidence-matrix.md') -PathType Leaf)) {
        Stop-SDAValidation 'evidence-matrix.md fehlt.'
    }
    Test-SDAGateFile -Path (Join-Path $Path 'baseline.json') -ExpectedGate baseline
    $deltaFiles = @(Get-ChildItem -LiteralPath (Join-Path $Path 'deltas') -Filter '*.json' -File | Sort-Object Name)
    if ($deltaFiles.Count -eq 0) {
        Stop-SDAValidation 'Mindestens eine Delta-Evidence fehlt.'
    }
    foreach ($deltaFile in $deltaFiles) {
        Test-SDAGateFile -Path $deltaFile.FullName -ExpectedGate delta
    }
    Test-SDAGateFile -Path (Join-Path $Path 'closure.json') -ExpectedGate closure
    Test-SDAGateFile -Path (Join-Path $Path 'image-impact.json') -ExpectedGate image-impact
    $image = Get-Content -LiteralPath (Join-Path $Path 'image-impact.json') -Raw | ConvertFrom-Json -Depth 100
    foreach ($key in @('build', 'compose', 'toolchain', 'ociDigest', 'sbom', 'secrets', 'mounts', 'network', 'ci')) {
        if (-not $image.imageChecks.PSObject.Properties[$key]) {
            Stop-SDAValidation "Image-Impact-Nachweis fehlt: ${key}"
        }
    }
    $closure = Get-Content -LiteralPath (Join-Path $Path 'closure.json') -Raw | ConvertFrom-Json -Depth 100
    foreach ($key in @('technicalValidation', 'pilotAuthorization', 'projectAcceptance', 'generalRelease')) {
        if (-not $closure.humanDecisions.PSObject.Properties[$key]) {
            Stop-SDAValidation "Entscheidungsgrenze fehlt: ${key}"
        }
    }
    "Aligned: ${Path}"
}

if ($Action -eq 'Status') {
    if (-not $EvidenceDirectory) {
        $EvidenceDirectory = Get-ChildItem -LiteralPath 'docs/security/secure-development' -Directory |
            Sort-Object Name |
            Select-Object -Last 1 -ExpandProperty FullName
    }
    if (-not $EvidenceDirectory) {
        Stop-SDAValidation 'Kein Evidence-Verzeichnis gefunden.'
    }
    Test-SDAContext -Path $EvidenceDirectory
    exit 0
}

if (-not $Gate -or -not $ContextId -or -not $Mode) {
    Stop-SDAValidation 'Review benötigt Gate, ContextId und Mode.'
}
if ($ContextId -notmatch '^[a-z0-9][a-z0-9-]*$') {
    Stop-SDAValidation 'ContextId ist ungültig.'
}
$contextDirectory = Get-ChildItem -LiteralPath 'docs/security/secure-development' -Directory -Filter "*-${ContextId}" |
    Sort-Object Name |
    Select-Object -Last 1 -ExpandProperty FullName
if (-not $contextDirectory) {
    Stop-SDAValidation "Kontext nicht gefunden: ${ContextId}"
}
switch ($Gate) {
    'baseline' { $gateFile = Join-Path $contextDirectory 'baseline.json' }
    'closure' { $gateFile = Join-Path $contextDirectory 'closure.json' }
    'image-impact' { $gateFile = Join-Path $contextDirectory 'image-impact.json' }
    'delta' {
        $gateFile = Get-ChildItem -LiteralPath (Join-Path $contextDirectory 'deltas') -Filter '*.json' -File |
            Sort-Object Name |
            Select-Object -Last 1 -ExpandProperty FullName
    }
}
Test-SDAGateFile -Path $gateFile -ExpectedGate $Gate
if ($Mode -ne 'development') {
    $runbook = "docs/runbooks/secure-development/${Gate}-${ContextId}.md"
    if (-not (Test-Path -LiteralPath $runbook -PathType Leaf)) {
        Stop-SDAValidation "Runbook fehlt für ${Mode}: ${runbook}"
    }
}
"Reviewed: gate=${Gate} context=${ContextId} mode=${Mode}"
