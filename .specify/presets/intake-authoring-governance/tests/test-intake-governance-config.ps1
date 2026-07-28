[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$PresetRoot = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
$Validator = Join-Path $PresetRoot 'scripts/validate-intake-governance-config.py'
$Root = Join-Path ([System.IO.Path]::GetTempPath()) ("intake-governance-" + [guid]::NewGuid())
New-Item -ItemType Directory -Path $Root | Out-Null

function Write-Fixture {
    param([string]$Name, [hashtable]$Data)
    $Path = Join-Path $Root $Name
    $Data | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $Path -Encoding utf8NoBOM
    return $Path
}

function Invoke-Fixture {
    param([string]$Path, [int]$ExpectedExit, [string]$ExpectedText)
    $Output = & python3 $Validator --config $Path --repo $Root --json 2>&1
    $Exit = $LASTEXITCODE
    if ($Exit -ne $ExpectedExit) {
        throw "Expected exit $ExpectedExit, got ${Exit}: $Output"
    }
    if (($Output -join "`n") -notmatch [regex]::Escape($ExpectedText)) {
        throw "Expected '$ExpectedText': $Output"
    }
}

try {
    New-Item -ItemType Directory -Path (Join-Path $Root 'requirements/intakes/active') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $Root 'requirements/baseline') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $Root 'requirements/intakes/series') -Force | Out-Null
    Set-Content -LiteralPath (Join-Path $Root 'Pflichtenheft.md') -Value '# Index' -Encoding utf8NoBOM
    Set-Content -LiteralPath (Join-Path $Root 'Lastenheft_Abarbeitungsreihenfolge.md') -Value '# Order' -Encoding utf8NoBOM
    Set-Content -LiteralPath (Join-Path $Root 'requirements/intakes/series/manifest.json') -Value '{}' -Encoding utf8NoBOM

    $Base = @{
        schemaVersion = '2.0'
        documentationLanguage = 'de-DE'
        artifactNaming = @{
            profile = 'de'
            canonicalIndex = 'Pflichtenheft.md'
            intakePattern = 'Lastenheft_<slug>.md'
            orderView = 'Lastenheft_Abarbeitungsreihenfolge.md'
        }
        roles = @{
            'requirements-index' = 'Pflichtenheft.md'
            'requirements-intake' = 'requirements/intakes/active'
            'intake-order' = 'Lastenheft_Abarbeitungsreihenfolge.md'
            'requirements-baseline' = 'requirements/baseline'
        }
        collections = @{
            baseline = 'requirements/baseline'
            active = 'requirements/intakes/active'
            archive = 'requirements/intakes/archive'
            backlog = 'requirements/intakes/backlog'
            history = 'requirements/intakes/history'
            seriesManifest = 'requirements/intakes/series/manifest.json'
        }
        legacyArtifactNames = @()
    }

    Invoke-Fixture (Write-Fixture 'de.json' $Base) 0 '"outcome": "Aligned"'

    $Schema1 = $Base.Clone()
    $Schema1.schemaVersion = '1.0'
    Invoke-Fixture (Write-Fixture 'schema1.json' $Schema1) 1 'MigrationRequired'

    $Ambiguous = $Base.Clone()
    $Ambiguous.documentationLanguage = 'und'
    Invoke-Fixture (Write-Fixture 'ambiguous.json' $Ambiguous) 1 'NeedsClarification'

    $BadProfile = $Base.Clone()
    $BadProfile.artifactNaming = $Base.artifactNaming.Clone()
    $BadProfile.artifactNaming.profile = 'fr'
    Invoke-Fixture (Write-Fixture 'profile.json' $BadProfile) 2 'RIG005'

    $Traversal = $Base.Clone()
    $Traversal.roles = $Base.roles.Clone()
    $Traversal.roles.'requirements-index' = '../outside.md'
    Invoke-Fixture (Write-Fixture 'traversal.json' $Traversal) 2 'RIG004'

    $Duplicate = $Base.Clone()
    $Duplicate.collections = $Base.collections.Clone()
    $Duplicate.collections.archive = $Duplicate.collections.active
    Invoke-Fixture (Write-Fixture 'duplicate.json' $Duplicate) 2 'RIG007'

    Write-Output 'PASS: requirements intake governance fixtures'
}
finally {
    Remove-Item -LiteralPath $Root -Recurse -Force -ErrorAction SilentlyContinue
}
