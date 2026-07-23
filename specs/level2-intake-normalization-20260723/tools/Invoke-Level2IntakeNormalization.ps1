<#
.SYNOPSIS
Normalisiert explizit manifestierte Level-2-Lastenhefte fuer Intake Authoring.

.DESCRIPTION
DE: Liest ein repository-relatives Zielmanifest, adoptiert genau die dort
genannten bestehenden Lastenhefte als LegacyAdoption und erzeugt die
repository-eigene Authoring-/Review-Policy, ein Lastenheft-Profil sowie
hashgebundene Receipts. Das Skript startet keinen Spec-Kit-Lauf und fuehrt
keine Git- oder Remote-Schreibaktion aus.

EN: Reads a repository-relative target manifest, adopts exactly the listed
existing requirements documents as LegacyAdoption, and creates repository
authoring/review policies, a requirements profile, and hash-bound receipts.
It starts no Spec Kit run and performs no Git or remote write action.

.PARAMETER Repository
Repository root containing the explicitly approved targets.

.PARAMETER Manifest
Repository-relative JSON manifest with a targets array. Each target needs path
and profile properties.

.PARAMETER IncludeLearningProfile
Adds the repository-owned learning-series authoring profile.

.PARAMETER NonMslCc65
Uses the cc65-specific non-MSL secure-coding boundary in the normal profile.

.EXAMPLE
pwsh -NoProfile -File Invoke-Level2IntakeNormalization.ps1 `
  -Repository ~/RiderProjects/TinyCalc `
  -Manifest specs/intake-normalization-20260723/target-manifest.json
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$Repository,

    [Parameter(Mandatory)]
    [string]$Manifest,

    [switch]$IncludeLearningProfile,

    [switch]$NonMslCc65
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-L2NormalizedHash {
    param([Parameter(Mandatory)][string]$Text)

    $normalized = $Text.Replace("`r`n", "`n").Replace("`r", "`n")
    if ($normalized.Length -gt 0 -and $normalized[0] -eq [char]0xFEFF) {
        $normalized = $normalized.Substring(1)
    }

    $bytes = [Text.Encoding]::UTF8.GetBytes($normalized)
    return [Convert]::ToHexString(
        [Security.Cryptography.SHA256]::HashData($bytes)
    ).ToLowerInvariant()
}

function Get-L2ReceiptSlug {
    param([Parameter(Mandatory)][string]$Path)

    $slug = [IO.Path]::GetFileNameWithoutExtension($Path) -replace '^Lastenheft_', ''
    $slug = $slug.ToLowerInvariant().
        Replace('ä', 'ae').
        Replace('ö', 'oe').
        Replace('ü', 'ue').
        Replace('ß', 'ss')
    return (($slug -replace '[^a-z0-9]+', '-').Trim('-'))
}

function Write-L2Utf8Json {
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
if (-not $manifestData.targets -or @($manifestData.targets).Count -eq 0) {
    throw 'Target manifest must contain at least one target.'
}

$policyPath = Join-Path $repo '.specify/intake-authoring-policy.json'
$reviewPolicyPath = Join-Path $repo '.specify/intake-review-policy.json'
$profilePath = Join-Path $repo '.specify/templates/intake-authoring-level2-lastenheft-profile.md'
$learningProfilePath = Join-Path $repo '.specify/templates/intake-authoring-learning-series-profile.md'
$receiptDirectory = Join-Path $repo 'specs/intake-authoring-receipts'

New-Item -ItemType Directory -Force -Path @(
    (Split-Path $policyPath),
    (Split-Path $profilePath),
    $receiptDirectory
) | Out-Null

$profiles = [ordered]@{
    'level2-lastenheft' = '.specify/templates/intake-authoring-level2-lastenheft-profile.md'
    'generic-markdown' = '.specify/presets/intake-authoring-governance/templates/project-profile-template.md'
}
if ($IncludeLearningProfile) {
    $profiles['level2-learning-series'] =
        '.specify/templates/intake-authoring-learning-series-profile.md'
}

$policy = [ordered]@{
    schemaVersion = '1.0'
    enabled = $true
    defaultTargetDirectory = '.'
    receiptDirectory = 'specs/intake-authoring-receipts'
    defaultProfile = 'level2-lastenheft'
    profiles = $profiles
    languagePolicy = 'GermanFirstEnglishSecond'
    defaultDeliveryAuthority = 'LocalImplementation'
    maximumQuestionsPerPass = 5
    allowExternalSources = $true
    allowOverwrite = $false
    nextAction = 'speckit.intake-review'
}
Write-L2Utf8Json -Value $policy -Path $policyPath

$reviewProfiles = @('level2-lastenheft', 'generic-markdown')
if ($IncludeLearningProfile) {
    $reviewProfiles = @('level2-lastenheft', 'level2-learning-series', 'generic-markdown')
}
$reviewPolicy = [ordered]@{
    schemaVersion = '1.0'
    required = $true
    acceptedStatuses = @('Ready', 'ReadyWithAcceptedRisks')
    resultPath = 'specs/intake-normalization-20260723/intake-review-result.json'
    profiles = $reviewProfiles
    requireHumanRiskAcceptance = $true
}
Write-L2Utf8Json -Value $reviewPolicy -Path $reviewPolicyPath

$languageBoundary = if ($NonMslCc65) {
    'The primary cc65 C89 and 6502 assembly stack is intentionally non-MSL. ' +
    'Preserve its documented justification and require bounds checks, safe string APIs, ' +
    'explicit input validation, and target-specific proof without treating MSL status as fulfilled.'
}
else {
    'Apply the repository C#/.NET secure-coding profile, including validated inputs, ' +
    'parameterized persistence access, safe serialization, output encoding, and dependency evidence.'
}
$authoringProfile = @"
# Level-2 Lastenheft Authoring Profile

## Identity

- Profile ID: ``level2-lastenheft``
- Applies when: An active Level-2 requirements document is prepared for one later Spec Kit feature.
- Target path rule: Preserve the repository-owned ``Lastenheft_*.md`` path and processing order.
- Language rule: German first and English second, CEFR B2.

## Required Sections

Preserve purpose, current and target state, scope, non-goals, atomic
requirements, quality and governance boundaries, dependencies, risks,
expected artifacts, evidence, measurable acceptance, assumptions, and
ordering. Every active intake ends with exactly one copy-ready Specify prompt
and one copy-ready Autonomous prompt. Creating or reviewing an intake starts
no feature.

## Naming And Ordering

Preserve stable filenames, predecessor gates, and archived feature suffixes.
Ordering conflicts are material and must not be guessed.

## Quality Gates

$languageBoundary

Apply repository security, privacy, architecture, A11Y, agent-parity,
cross-platform, statistics, and evidence rules. Use text-first WCAG 2.2 AA
where applicable. The Autonomous prompt defaults to ``LocalImplementation``
and grants no remote, bypass, secret, provider, or follow-up-feature authority.
"@
$authoringProfile | Set-Content -LiteralPath $profilePath -Encoding utf8NoBOM

if ($IncludeLearningProfile) {
    @'
# Level-2 Learning-Series Intake Authoring Profile

## Identity

- Profile ID: `level2-learning-series`
- Applies when: One explicitly runnable learning unit is prepared for a later manual Spec Kit run.
- Target path rule: Preserve the registered series name and unit path.
- Language rule: German first and English second, CEFR B2.

## Required Sections

Preserve learning goal, audience, prior knowledge, professional-role and
learning-field relation, scenario, learner tasks, evidence, reflection,
security/privacy/A11Y applicability, trainer boundary, predecessor gates, and
links to the matching study companion and series map.

## Naming And Ordering

Never turn a whole-series or track map into one feature. Preserve unit order,
year gates, and manual learner-run authorization.

## Quality Gates

Do not require a GitHub account unless the chosen path needs it. Preserve the
Secure Trader Container-First gate before any agent invocation. Spec Kit
supports but does not replace vocational school, workplace training,
curriculum, trainer decisions, or exam preparation. Prompts default to
`LocalImplementation` and prohibit an automatic next unit.
'@ | Set-Content -LiteralPath $learningProfilePath -Encoding utf8NoBOM
}

foreach ($entry in @($manifestData.targets)) {
    $relative = [string]$entry.path
    $targetProfile = [string]$entry.profile
    $provenance = if ($entry.PSObject.Properties.Name -contains 'provenance') {
        [string]$entry.provenance
    }
    else {
        'LegacyAdoption'
    }
    if ($provenance -notin @('LegacyAdoption', 'New')) {
        throw "Unsupported provenance '$provenance' for '$relative'."
    }
    if ($targetProfile -notin $profiles.Keys) {
        throw "Unknown profile '$targetProfile' for '$relative'."
    }
    if ([IO.Path]::IsPathRooted($relative) -or $relative.Contains('..')) {
        throw "Unsafe target path: $relative"
    }

    $path = Join-Path $repo $relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Target does not exist: $relative"
    }
    $before = [IO.File]::ReadAllText(
        $path,
        [Text.UTF8Encoding]::new($false, $true)
    )
    if ($before.Contains('<!-- intake-authoring:begin -->')) {
        throw "Target is already Creator-managed: $relative"
    }

    $priorHash = Get-L2NormalizedHash -Text $before
    $blob = 'N/A'
    if ($provenance -eq 'LegacyAdoption') {
        $blob = (& git -C $repo rev-parse "HEAD:$relative").Trim()
        if ($LASTEXITCODE -ne 0 -or $blob -notmatch '^[0-9a-f]{40,64}$') {
            throw "Cannot resolve prior Git blob for '$relative'."
        }
    }

    $body = $before.Replace("`r`n", "`n").Replace("`r", "`n").TrimEnd("`n")
    $body = [regex]::Replace(
        $body,
        '(?m)^(\s*)(?:/|\$)speckit-specify(?=\s|$)',
        '$1Ersetzter Alt-Prompt: speckit-specify'
    )
    $body = [regex]::Replace(
        $body,
        '(?m)^(\s*)(?:/|\$)speckit-autonomous(?=\s|$)',
        '$1Ersetzter Alt-Prompt: speckit-autonomous'
    )

    $prompt = @"

<!-- intake-authoring:prompts -->
## Kopierbare Spec-Kit-Prompts / Copy-Ready Spec Kit Prompts

Die folgenden Alternativen starten keinen Lauf automatisch. Der autonome
Prompt ist auf ``LocalImplementation`` begrenzt und erteilt keine Remote-,
PR-, Merge-, Bypass-, Secret- oder Provider-Berechtigung.

*The alternatives below do not start a run automatically. The autonomous
prompt is limited to ``LocalImplementation`` and grants no remote,
pull-request, merge, bypass, secret, or provider authority.*

### Specify

<!-- spec-kit-command-id: speckit.specify -->
``````text
`$speckit-specify Use $relative as the binding intake. Preserve its scope, non-goals, ordering, governance, evidence, and acceptance criteria. Create or update only the matching feature specification. Do not implement, commit, push, create a pull request, merge, or start another feature.
``````

### Autonomous

<!-- spec-kit-command-id: speckit.autonomous -->
``````text
`$speckit-autonomous Execute one complete autonomous Spec Kit run using $relative as the binding intake. Delivery mode: LocalImplementation. Preserve all scope, ordering, security, accessibility, evidence, and acceptance boundaries. Do not push, create or merge a pull request, use bypass authority, expose secrets, or start a follow-up feature.
``````
"@
    $after = "<!-- intake-authoring:begin -->`n" +
        $body +
        $prompt +
        "`n<!-- intake-authoring:end -->`n"
    [IO.File]::WriteAllText(
        $path,
        $after,
        [Text.UTF8Encoding]::new($false)
    )

    $targetHash = Get-L2NormalizedHash -Text $after
    $sourceList = [Collections.Generic.List[object]]::new()
    if ($provenance -eq 'LegacyAdoption') {
        $sourceList.Add([ordered]@{
            order = 1
            kind = 'Pasted'
            label = 'Legacy target before Intake Creator adoption'
            location = 'SnapshotOnly'
            path = 'N/A'
            normalizedSha256 = $priorHash
            gitBlob = $blob
        })
    }
    else {
        $sourcePaths = @($entry.sourcePaths)
        if ($sourcePaths.Count -eq 0) {
            throw "New target '$relative' requires sourcePaths."
        }
        for ($sourceIndex = 0; $sourceIndex -lt $sourcePaths.Count; $sourceIndex++) {
            $sourceRelative = [string]$sourcePaths[$sourceIndex]
            if ([IO.Path]::IsPathRooted($sourceRelative) -or
                $sourceRelative.Contains('..') -or
                $sourceRelative -eq $relative) {
                throw "Unsafe source path '$sourceRelative' for '$relative'."
            }
            $sourcePath = Join-Path $repo $sourceRelative
            $sourceText = [IO.File]::ReadAllText(
                $sourcePath,
                [Text.UTF8Encoding]::new($false, $true)
            )
            $sourceBlob = (& git -C $repo rev-parse "HEAD:$sourceRelative" 2>$null)
            $sourceBlobValue = if ($LASTEXITCODE -eq 0) {
                $sourceBlob.Trim()
            }
            else {
                'N/A'
            }
            $sourceList.Add([ordered]@{
                order = $sourceIndex + 1
                kind = 'File'
                label = [IO.Path]::GetFileName($sourceRelative)
                location = 'Repository'
                path = $sourceRelative
                normalizedSha256 = Get-L2NormalizedHash -Text $sourceText
                gitBlob = $sourceBlobValue
            })
        }
    }

    $receipt = [ordered]@{
        schemaVersion = '1.1'
        receiptId = [guid]::NewGuid().ToString()
        generator = [ordered]@{
            preset = 'intake-authoring-governance'
            version = '0.1.1'
        }
        createdAt = [DateTime]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ')
        status = 'ReadyForReview'
        target = [ordered]@{
            path = $relative
            normalizedSha256 = $targetHash
        }
        sources = @($sourceList)
        profile = $targetProfile
        languagePolicy = 'GermanFirstEnglishSecond'
        decisions = @(
            [ordered]@{
                id = 'IAD001'
                status = 'Answered'
                question = 'Welcher Zielpfad bleibt verbindlich?'
                answer = $relative
                evidence = 'Die aktive Repository-Abarbeitungsreihenfolge benennt diesen Pfad.'
            },
            [ordered]@{
                id = 'IAD002'
                status = 'Answered'
                question = if ($provenance -eq 'LegacyAdoption') {
                    'Darf der bestehende Alt-Intake aktualisiert werden?'
                }
                else {
                    'Darf aus den benannten Quellen ein neuer Intake entstehen?'
                }
                answer = if ($provenance -eq 'LegacyAdoption') {
                    'Ja, als diff-arme LegacyAdoption.'
                }
                else {
                    'Ja, als neuer scope-begrenzter Intake.'
                }
                evidence = if ($provenance -eq 'LegacyAdoption') {
                    'Der aktuelle Nutzerauftrag autorisiert Creator-Normalisierung und Review der aktiven Level-2-Intakes.'
                }
                else {
                    'Die bestehende Abarbeitungsreihenfolge benennt den offenen Teil bereits; der aktuelle Nutzerauftrag autorisiert die konsistente Intake-Erstellung.'
                }
            },
            [ordered]@{
                id = 'IAD003'
                status = 'Answered'
                question = 'Welcher fachliche Umfang bleibt erhalten?'
                answer = 'Der bestehende fachliche Scope bleibt unveraendert; ergaenzt werden nur Creator-Vertrag und nachgewiesene Konsistenzkorrekturen.'
                evidence = 'Genehmigter scope-neutraler Flottenplan.'
            },
            [ordered]@{
                id = 'IAD004'
                status = 'Answered'
                question = 'Welche Delivery Authority gilt fuer spaetere autonome Laeufe?'
                answer = 'LocalImplementation.'
                evidence = 'Dieser Authoring-Lauf erteilt keine Remote-Autoritaet.'
            }
        )
        openDecisionIds = @()
        questionCount = 0
        agentSurface = [ordered]@{
            specifyCanonicalId = 'speckit.specify'
            specifyInvocation = '$speckit-specify'
            autonomousCanonicalId = 'speckit.autonomous'
            autonomousInvocation = '$speckit-autonomous'
        }
        deliveryAuthority = 'LocalImplementation'
        authorityEvidence = 'Default: Dieser Authoring-Lauf erteilt keine Remote-Schreib- oder Lieferautoritaet fuer spaetere Feature-Laeufe.'
        promptState = 'Enabled'
        nextAction = "`$speckit-intake-review $relative"
        provenanceMode = $provenance
        supersedes = [ordered]@{
            receiptPath = 'N/A'
            targetNormalizedSha256 = 'N/A'
        }
        legacyAdoption = if ($provenance -eq 'LegacyAdoption') {
            [ordered]@{
                evidenceType = 'GitBlob'
                priorTargetNormalizedSha256 = $priorHash
                priorGitBlob = $blob
            }
        }
        else {
            [ordered]@{
                evidenceType = 'N/A'
                priorTargetNormalizedSha256 = 'N/A'
                priorGitBlob = 'N/A'
            }
        }
        updateAuthorized = ($provenance -eq 'LegacyAdoption')
        updateAuthorityEvidence = if ($provenance -eq 'LegacyAdoption') {
            'Aktueller Nutzerauftrag: Creator-Normalisierung und Review der aktiven C#-Level-2- und cc65-Intakes.'
        }
        else {
            'N/A'
        }
    }
    $receiptPath = Join-Path $receiptDirectory (
        (Get-L2ReceiptSlug -Path $relative) + '.json'
    )
    Write-L2Utf8Json -Value $receipt -Path $receiptPath
}

Write-Output "Normalized $(@($manifestData.targets).Count) target(s) in $repo."
