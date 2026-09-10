#Requires -Version 7
<#
.SYNOPSIS
Prüft öffentliche Laufstatistik mit isolierten Fixtures. / Tests public run statistics with isolated fixtures.
.DESCRIPTION
Offline tests verify evidence integrity, counting, discovery and privacy boundaries.
Keine Netzwerkzugriffe und keine Änderungen am Repository. / No network or repository writes.
.EXAMPLE
pwsh -NoProfile -File scripts/tests/test-public-speckit-statistics.ps1
#>
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module (Join-Path $PSScriptRoot '../lib/public-speckit-statistics.psm1') -Force
$script:Passed = 0
function Assert-Test {
    param([bool]$Condition, [string]$Name)
    if (-not $Condition) { throw "FAIL: $Name" }
    $script:Passed++
    Write-Host "PASS: $Name"
}
function Assert-Rejected {
    param([scriptblock]$Action, [string]$Name)
    $rejected = $false
    try { & $Action } catch { $rejected = $true }
    Assert-Test $rejected $Name
}
function Copy-Fixture {
    param([object]$Value)
    ConvertFrom-HBJson (ConvertTo-HBJson $Value)
}
$content = '{"status":"Completed","runId":"11111111-1111-4111-8111-111111111111"}'
$proof = @{kind='file';ref=('a'*40);path='specs/001-example/autonomous-run-state.json';sha256=(Get-HBTextHash $content);roles=@('started','executed','completed')}
$review = @{feature='specs/001-example';executed=$true;completed=$true;reviewedBy='hindermath-maintained-evidence-register';reason='Reviewed fixture';proofs=@($proof)}
$registry = @{schemaVersion=1;ruleVersion=1;repositories=@(@{name='example/source';level=0;reviews=@($review)},@{name='example/empty';level=2;reviews=@()})}
$source = @{key=(Get-HBProofKey 'example/source' $proof);kind='file';sha256=$proof.sha256;content=$content}
$snapshot = @{schemaVersion=1;ruleVersion=1;registrySha256=('b'*64);collectedAt='2026-09-10T12:00:00Z';repositories=@(
 @{name='example/source';level=0;visibility='public';head=('a'*40);discovery=@();features=@(@{feature=$review.feature;decision='reviewed';review=$review});sources=@($source)},
 @{name='example/empty';level=2;visibility='public';head=('c'*40);discovery=@();features=@();sources=@()}
)}
Assert-HBRegistry $registry
$table = Get-HBStatisticsTable $snapshot
Assert-Test ($table.Contains('| 0 | [source](https://github.com/example/source) | 1 | 1 | 1 |')) 'reviewed count'
Assert-Test ($table.Contains('| 2 | [empty](https://github.com/example/empty) | 0 | 0 | 0 |')) 'zero row'
Assert-Test ($table.Contains('**Level 0 + Level 2 insgesamt** | **1** | **1** | **1**')) 'totals'
Assert-Test ($table -ceq (Get-HBStatisticsTable (Copy-Fixture $snapshot))) 'deterministic replay'
Assert-Test ((Get-HBStatisticsTable $snapshot en).Contains('Completion evidenced')) 'English layout'
$changed = Copy-Fixture $snapshot; $changed.collectedAt='2026-10-01T08:17:00Z'; $changed.repositories[0].head='d'*40
Assert-Test ((Get-HBStatisticsFingerprint $snapshot) -ceq (Get-HBStatisticsFingerprint $changed)) 'no clock/head-only publication churn'
$changed.repositories[0].sources[0].content='tampered'
Assert-Rejected { Test-HBStatisticsSnapshot $changed } 'reject source tampering'
$changed = Copy-Fixture $snapshot; $changed.repositories += $changed.repositories[0]
Assert-Rejected { Test-HBStatisticsSnapshot $changed } 'duplicate repository'
$changed = Copy-Fixture $snapshot; $changed.repositories[0].features += $changed.repositories[0].features[0]
Assert-Rejected { Test-HBStatisticsSnapshot $changed } 'resume/duplicate feature cannot inflate count'
$changed = Copy-Fixture $snapshot; $changed.repositories[0].features[0].review.executed=$false
Assert-Rejected { Test-HBStatisticsSnapshot $changed } 'completion requires execution'
$changed = Copy-Fixture $snapshot; $changed.repositories[0].visibility='excluded'
Assert-Rejected { Test-HBStatisticsSnapshot $changed } 'private evidence cannot enter snapshot'
$changed = Copy-Fixture $snapshot; $changed.repositories[1].visibility='excluded'
Assert-Test (-not (Get-HBStatisticsTable $changed).Contains('[empty]')) 'exclude private zero row'
$changed = Copy-Fixture $snapshot; $changed.repositories[0].features[0].decision='invented'
Assert-Rejected { Test-HBStatisticsSnapshot $changed } 'unknown decision'
$changed = Copy-Fixture $snapshot
$changed.repositories[0].features=@(@{feature='specs/001-example';decision='needsReview';source=$source.key})
Assert-Test ((Get-HBStatisticsTable $changed).Contains('| 0 | [source](https://github.com/example/source) | 0 | 0 | 0 |')) 'unreviewed candidate never counted'
Assert-Test ((Get-HBStatisticsReviewReport $changed).Contains('- [ ] example/source')) 'review queue visible'
$changed = Copy-Fixture $snapshot
$unknown = $content.Replace('Completed', 'UnknownFutureState')
$changed.repositories[0].sources[0].content = $unknown
$changed.repositories[0].sources[0].sha256 = Get-HBTextHash $unknown
$changed.repositories[0].features[0].review.proofs[0].sha256 = Get-HBTextHash $unknown
Assert-Rejected { Test-HBStatisticsSnapshot $changed } 'unknown autonomous status even with valid hashes'
$changed = Copy-Fixture $snapshot
$duplicate = Copy-Fixture $changed.repositories[0].features[0]
$duplicate.feature = 'specs/002-copy'; $duplicate.review.feature = $duplicate.feature
$duplicate.review.proofs[0].path = 'specs/002-copy/autonomous-run-state.json'
$duplicateSource = Copy-Fixture $source
$duplicateSource.key = Get-HBProofKey 'example/source' $duplicate.review.proofs[0]
$changed.repositories[0].features += $duplicate; $changed.repositories[0].sources += $duplicateSource
Assert-Rejected { Test-HBStatisticsSnapshot $changed } 'same run ID across features is rejected'
$changed = Copy-Fixture $snapshot
$changed.registrySha256 = Get-HBTextHash (ConvertTo-HBJson $registry)
Assert-HBStatisticsRegistryBinding $changed $registry
$changed.repositories[0].features[0].review.reason = 'Unreviewed alternative'
Assert-Rejected { Assert-HBStatisticsRegistryBinding $changed $registry } 'snapshot cannot override reviewed classifications'
$begin='<!-- public-speckit-runs:begin -->';$end='<!-- public-speckit-runs:end -->'
$original="MOTD untouched`r`n$begin`nold`n$end`r`nFooter untouched"
$updated=Set-HBStatisticsBlock $original $table
Assert-Test ($updated.StartsWith("MOTD untouched`r`n") -and $updated.EndsWith("`r`nFooter untouched")) 'preserve surrounding bytes'
Assert-Test ($updated -ceq (Set-HBStatisticsBlock $updated $table)) 'idempotent replacement'
Assert-Rejected { Set-HBStatisticsBlock "$begin$original" $table } 'duplicate markers'
Assert-Rejected { Set-HBStatisticsBlock 'no markers' $table } 'missing markers'
Assert-Rejected { Set-HBStatisticsBlock "$end$begin" $table } 'reversed markers'
# Provider boundary tests use the module's API seam, never live credentials or network.
$module=Get-Module public-speckit-statistics
& $module {
    function script:Invoke-HBGitHub {
        param([string]$Endpoint)
        if ($Endpoint -eq 'repos/example/source') { return @{full_name='example/source';visibility='private';private=$true} }
        throw 'Privacy violation: requested content after private metadata.'
    }
}
$private=Get-HBStatisticsSnapshot @{schemaVersion=1;ruleVersion=1;repositories=@($registry.repositories[0])}
Assert-Test ($private.repositories[0].sources.Count -eq 0 -and $private.repositories[0].visibility -eq 'excluded') 'private metadata short-circuits all content requests'
& $module { function script:Invoke-HBGitHub { param([string]$Endpoint); throw "Simulated rate limit: $Endpoint" } }
Assert-Rejected { Get-HBStatisticsSnapshot $registry } 'API failure never returns zero statistics'
& $module {
    function script:Invoke-HBGitHub {
        param([string]$Endpoint)
        switch -Wildcard ($Endpoint) {
            'repos/example/source' { return @{full_name='example/source';visibility='public';private=$false;default_branch='main'} }
            '*/commits/main' { return @{sha=('a'*40)} }
            '*/git/trees/*' { return @{truncated=$false;tree=@(
                @{type='blob';path='specs/001-new/spec.md';sha=('b'*40)},
                @{type='blob';path='tests/specs/002-fixture/spec.md';sha=('c'*40)},
                @{type='blob';path='.specify/templates/spec.md';sha=('d'*40)}
            )} }
            '*/pulls?*' { return ,@() }
            '*/contents/*' { return @{type='file';encoding='base64';size=16;content=[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('# New feature'))} }
            default { throw "Unexpected request: $Endpoint" }
        }
    }
}
$newRegistry=@{schemaVersion=1;ruleVersion=1;repositories=@(@{name='example/source';level=0;reviews=@()})}
$discovered=Get-HBStatisticsSnapshot $newRegistry
Test-HBStatisticsSnapshot $discovered
Assert-Test ($discovered.repositories[0].features.Count -eq 1) 'discover real spec and exclude templates/fixtures'
Assert-Test ($discovered.repositories[0].features[0].decision -eq 'needsReview') 'new feature requires semantic decision'
Assert-Test ((Get-HBStatisticsFingerprint $discovered) -ceq (Get-HBStatisticsFingerprint (Get-HBStatisticsSnapshot $newRegistry $discovered))) 'repeat public collection is stable with no open PRs'
& $module {
    function script:Invoke-HBGitHub {
        param([string]$Endpoint)
        if ($Endpoint -like '*/git/trees/*') { return @{truncated=$true;tree=@()} }
        throw 'Unexpected fixture request.'
    }
}
Assert-Rejected { Get-HBFeatureTree 'example/source' ('a'*40) } 'truncated tree cannot produce partial count'
Import-Module (Join-Path $PSScriptRoot '../lib/public-speckit-statistics.psm1') -Force
Write-Host "PASS: $script:Passed public statistics assertions."
