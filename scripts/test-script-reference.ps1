#Requires -Version 7
<#
.SYNOPSIS
Runs deterministic checks for the generated script reference.

.EXAMPLE
pwsh -NoProfile -File scripts/test-script-reference.ps1
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
$renderer = Join-Path $PSScriptRoot 'render-script-reference.ps1'
$g4Harness = Join-Path $repo 'scripts/tests/test_copilot_review_governance.py'
$g4Evidence = Join-Path $repo '.specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1/operational/quality/full-tests.json'

function Get-OptionalFileHash {
    param([Parameter(Mandatory)][string] $Path)

    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        return 'Absent'
    }
    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToLowerInvariant()
}

$evidenceBeforeHelp = Get-OptionalFileHash -Path $g4Evidence
foreach ($helpArgument in @('-h', '--help')) {
    $helpOutput = @(& python3 $g4Harness $helpArgument 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "G4 harness $helpArgument must exit 0."
    }
    $helpText = $helpOutput -join "`n"
    foreach ($requiredText in @('Usage:', 'zero or more', 'Available exact FILTER labels:', 'unique semantic contracts', 'AGGREGATE', 'not hard-coded')) {
        if (-not $helpText.Contains($requiredText, [StringComparison]::Ordinal)) {
            throw "G4 harness $helpArgument omitted required help text: $requiredText"
        }
    }
}
$evidenceAfterHelp = Get-OptionalFileHash -Path $g4Evidence
if ($evidenceBeforeHelp -ne $evidenceAfterHelp) {
    throw 'G4 harness help mutated canonical full-test evidence.'
}

$unknownOutput = @(& python3 $g4Harness 'DefinitelyUnknownDeterministicFilter' 2>&1)
if ($LASTEXITCODE -ne 2) {
    throw 'G4 harness unknown-filter contract must exit 2.'
}
if (-not (($unknownOutput -join "`n").Contains('Unknown deterministic class filter(s): DefinitelyUnknownDeterministicFilter', [StringComparison]::Ordinal))) {
    throw 'G4 harness unknown-filter diagnostic drifted.'
}

& $renderer -Repo $repo
if ($LASTEXITCODE -ne 0) { throw 'Initial script reference render failed.' }
$first = Get-FileHash (Join-Path $repo 'docs/scripts/reference.md') -Algorithm SHA256
$embeddedFirst = Get-FileHash (Join-Path $repo 'docs/scripts/embedded-scripts.md') -Algorithm SHA256
& $renderer -Repo $repo -CheckOnly
if ($LASTEXITCODE -ne 0) { throw 'Generated script reference is not current.' }
$second = Get-FileHash (Join-Path $repo 'docs/scripts/reference.md') -Algorithm SHA256
$embeddedSecond = Get-FileHash (Join-Path $repo 'docs/scripts/embedded-scripts.md') -Algorithm SHA256
if ($first.Hash -ne $second.Hash -or $embeddedFirst.Hash -ne $embeddedSecond.Hash) {
    throw 'Repeated rendering changed generated documentation.'
}
Write-Host 'Script reference tests passed.'
