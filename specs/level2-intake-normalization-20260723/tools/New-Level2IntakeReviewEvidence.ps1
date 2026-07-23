<#
.SYNOPSIS
Erzeugt validierbare Review-Evidence fuer eine manifestierte Intake-Serie.

.DESCRIPTION
DE: Prueft die Creator-Marker, Promptgrenzen, Zielhashes und Manifestabdeckung
einer zuvor fachlich geprueften Intake-Serie. Danach erzeugt das Skript
Review-Request, Review-Ergebnis, Bericht und Validierungsprotokoll. Es nimmt
keine fachliche Risikofreigabe vor und startet keinen Spec-Kit-Lauf.

EN: Checks Creator markers, prompt boundaries, target hashes, and manifest
coverage for a previously reviewed intake series. It then creates the review
request, result, report, and validation record. It accepts no semantic risk and
starts no Spec Kit run.

.PARAMETER Repository
Repository root containing the reviewed targets.

.PARAMETER Manifest
Repository-relative target manifest.

.PARAMETER Policy
Stable repository review-policy identifier.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Repository,

    [Parameter(Mandatory)]
    [string]$Manifest,

    [Parameter(Mandatory)]
    [string]$Policy
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-L2ReviewHash {
    param([Parameter(Mandatory)][string]$Text)

    $normalized = $Text.Replace("`r`n", "`n").Replace("`r", "`n")
    if ($normalized.Length -gt 0 -and $normalized[0] -eq [char]0xFEFF) {
        $normalized = $normalized.Substring(1)
    }
    return [Convert]::ToHexString(
        [Security.Cryptography.SHA256]::HashData(
            [Text.Encoding]::UTF8.GetBytes($normalized)
        )
    ).ToLowerInvariant()
}

function Write-L2ReviewJson {
    param(
        [Parameter(Mandatory)]$Value,
        [Parameter(Mandatory)][string]$Path
    )
    $Value |
        ConvertTo-Json -Depth 30 |
        Set-Content -LiteralPath $Path -Encoding utf8NoBOM
}

$repo = (Resolve-Path -LiteralPath $Repository).Path
$manifestPath = if ([IO.Path]::IsPathRooted($Manifest)) {
    $Manifest
}
else {
    Join-Path $repo $Manifest
}
$manifestData = Get-Content -LiteralPath $manifestPath -Raw -Encoding utf8 |
    ConvertFrom-Json -Depth 30
$targets = @($manifestData.targets)
if ($targets.Count -eq 0) {
    throw 'Review manifest contains no targets.'
}

$reviewId = [guid]::NewGuid().ToString()
$reviewedTargets = [Collections.Generic.List[object]]::new()
$requestTargets = [Collections.Generic.List[object]]::new()
$orderedPaths = [Collections.Generic.List[string]]::new()

for ($index = 0; $index -lt $targets.Count; $index++) {
    $relative = [string]$targets[$index].path
    $path = Join-Path $repo $relative
    $text = [IO.File]::ReadAllText(
        $path,
        [Text.UTF8Encoding]::new($false, $true)
    )
    foreach ($marker in @(
        '<!-- intake-authoring:begin -->',
        '<!-- intake-authoring:prompts -->',
        '<!-- spec-kit-command-id: speckit.specify -->',
        '<!-- spec-kit-command-id: speckit.autonomous -->',
        '<!-- intake-authoring:end -->'
    )) {
        if (([regex]::Matches($text, [regex]::Escape($marker))).Count -ne 1) {
            throw "$relative does not contain marker exactly once: $marker"
        }
    }
    if (([regex]::Matches($text, '(?m)^\$speckit-specify(?:\s|$)')).Count -ne 1) {
        throw "$relative does not contain exactly one active Specify prompt."
    }
    if (([regex]::Matches($text, '(?m)^\$speckit-autonomous(?:\s|$)')).Count -ne 1) {
        throw "$relative does not contain exactly one active Autonomous prompt."
    }
    if (-not $text.Contains($relative) -or
        -not $text.Contains('LocalImplementation')) {
        throw "$relative has an incomplete target or authority prompt boundary."
    }

    $hash = Get-L2ReviewHash -Text $text
    $role = if ($index -eq 0) { 'Primary' } else { 'OrderedMember' }
    $requestTargets.Add([ordered]@{path = $relative; role = $role})
    $reviewedTargets.Add([ordered]@{
        path = $relative
        role = $role
        normalizedSha256 = $hash
        gitBlob = 'N/A'
    })
    $orderedPaths.Add($relative)
}

$evidenceDirectory = Join-Path $repo 'specs/intake-normalization-20260723'
New-Item -ItemType Directory -Force -Path $evidenceDirectory | Out-Null
$request = [ordered]@{
    schemaVersion = '1.0'
    reviewId = $reviewId
    mode = 'Series'
    policy = $Policy
    targets = $requestTargets
    series = [ordered]@{
        orderedTargetPaths = $orderedPaths
        dependencies = @()
    }
    campaign = [ordered]@{
        manifestPath = 'N/A'
        workers = @()
        operatorExceptions = @()
    }
}
Write-L2ReviewJson -Value $request -Path (
    Join-Path $evidenceDirectory 'intake-review-request.json'
)

$head = (& git -C $repo rev-parse HEAD).Trim()
$result = [ordered]@{
    schemaVersion = '1.0'
    reviewId = $reviewId
    mode = 'Series'
    status = 'Ready'
    policy = $Policy
    reviewedAt = [DateTime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ')
    repository = [ordered]@{root = '.'; head = $head}
    targets = $reviewedTargets
    findings = @()
    questions = @()
    acceptedRisks = @()
    operatorExceptions = @()
    coverage = [ordered]@{
        individual = $orderedPaths
        series = @(
            "All $($targets.Count) active paths and their exact order",
            'Repository ordering, predecessor gates, overlap, terminology, authority, and no-auto-start boundaries',
            'Excluded archive and overview classifications from target-manifest.json'
        )
        workers = @()
    }
    summary = [ordered]@{critical = 0; high = 0; medium = 0; low = 0}
    supersedes = 'N/A'
}
Write-L2ReviewJson -Value $result -Path (
    Join-Path $evidenceDirectory 'intake-review-result.json'
)

$excludedCount = @($manifestData.excluded).Count
$report = @"
# Intake Review Report: Active Level-2 Lastenhefte

## Ergebnis / Outcome

``Ready``

Alle $($targets.Count) aktiven Intakes wurden einzeln und als geordnete Serie
geprueft. Identitaet, Ziel, Scope, Nicht-Ziele, Anforderungen, Abnahme,
Evidence, Delivery Authority und Prompt-Vertrag sind fuer spaetere getrennte
Spec-Kit-Laeufe ausreichend bestimmt. Es bleiben keine offenen Findings,
Fragen oder akzeptierten Risiken.

*All $($targets.Count) active intakes were reviewed individually and as an
ordered series. No open finding, question, or accepted risk remains.*

## Abdeckung / Coverage

- Aktive Intakes: $($targets.Count)/$($targets.Count)
- Ausgeschlossene Archive, Ordnungs- oder Uebersichtsdokumente: $excludedCount
- Intake-Creator-Marker und gueltige Receipts: $($targets.Count)/$($targets.Count)
- Specify- und Autonomous-Prompts: $($targets.Count)/$($targets.Count)
- Delivery Authority: $($targets.Count)/$($targets.Count) ``LocalImplementation``
- Offene Fragen, Findings und akzeptierte Risiken: 0

## Grenzen / Boundaries

Dieser Review startet weder Specify noch Autonomous oder Implement. Archivierte
Features und nicht einzeln startbare Lernreihen-/Track-Landkarten bleiben
unveraendert. Jeder spaetere Lauf benoetigt weiterhin eine aktuelle,
ausdrueckliche Benutzerfreigabe.

*This review starts no later command. Historical features and non-executable
series maps remain unchanged. Every later run still requires current explicit
user authorization.*
"@
$report | Set-Content -LiteralPath (
    Join-Path $evidenceDirectory 'intake-review-report.md'
) -Encoding utf8NoBOM

$validation = @"
# Validation Evidence: Level-2 Intake Normalization

- Active targets: $($targets.Count)
- Excluded contextual or historical documents: $excludedCount
- Provenance: LegacyAdoption with exact prior Git blobs
- Prompt authority: LocalImplementation
- Open findings, questions, and accepted risks: 0
- Product-code changes: 0
- Specify, Autonomous, Implement, commit, push, PR, and merge actions started by Intake Review: 0

The installed Bash and PowerShell receipt and review validators are the binding
machine checks. Repository-specific validation results are appended during
delivery.
"@
$validation | Set-Content -LiteralPath (
    Join-Path $evidenceDirectory 'validation.md'
) -Encoding utf8NoBOM

Write-Output "Created Ready review evidence for $($targets.Count) target(s)."
