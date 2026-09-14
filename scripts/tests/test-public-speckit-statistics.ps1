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
# Rule v2 preserves the v1 replay above and partitions every executed feature exactly once.
$v2 = Copy-Fixture $snapshot; $v2.schemaVersion=2; $v2.ruleVersion=2
$v2.repositories[0].features[0].review.executionMode='unknown'
$v2.repositories[0].features[0].review.modeReason='No affirmative historical mode evidence.'
$aggregate=@{schemaVersion=2;ruleVersion=2;collectedAt='2026-09-12T12:00:00Z';started=4;executed=3;completed=2;manual=1;serial=1;parallel=1;mixed=0;unknown=0;needsReview=0}
$extended=Get-HBStatisticsTable $v2 de $aggregate
Assert-Test ($extended.Contains('| 0 | [source](https://github.com/example/source) | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 1 |')) 'public repository has individual mode counts'
Assert-Test ($extended.Contains('| 2 | [empty](https://github.com/example/empty) | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |')) 'empty public repository retains all mode zeros'
Assert-Test ($extended.Contains('**5** | **4** | **3** | **1** | **1** | **1** | **0** | **1**')) 'public plus private arithmetic'
foreach($mode in @('manual','serial','parallel','mixed')) {
    $modeFixture=Copy-Fixture $v2
    $modeFixture.repositories[0].features[0].review.executionMode=$mode
    Assert-Rejected {Test-HBStatisticsSnapshot $modeFixture} "${mode}: affirmative proof required"
    $modeFixture.repositories[0].features[0].review.proofs[0].roles+=@('mode')
    Test-HBStatisticsSnapshot $modeFixture
    $c=Get-HBExecutionCounts @($modeFixture.repositories[0].features[0].review)
    Assert-Test (($c[3..7]|Measure-Object -Sum).Sum -eq 1) "${mode}: feature counted once"
}
$badAggregate=Copy-Fixture $aggregate;$badAggregate['repository']='private/name'
Assert-Rejected {Get-HBStatisticsTable $v2 de $badAggregate} 'private identifiers cannot cross publication boundary'
$badAggregate=Copy-Fixture $aggregate;$badAggregate.manual=99
Assert-Rejected {Assert-HBPrivateAggregate $badAggregate} 'mode aggregate inconsistency'
$badAggregate=Copy-Fixture $aggregate;$badAggregate.started='4'
Assert-Rejected {Assert-HBPrivateAggregate $badAggregate} 'aggregate disallows strings in numeric fields'
$badMode=Copy-Fixture $v2;$badMode.repositories[0].features[0].review.executionMode='UNKNOWN'
Assert-Rejected {Test-HBStatisticsSnapshot $badMode} 'mode vocabulary is case-sensitive for exact partition indexing'
Assert-Rejected {Get-HBStatisticsTable $v2} 'missing private evidence cannot become zero'
Assert-Test ($extended -ceq (Get-HBStatisticsTable (Copy-Fixture $v2) de (Copy-Fixture $aggregate))) 'v2 deterministic replay'
Assert-Test ((Get-HBStatisticsTable $v2 en $aggregate).Contains('Autonomous parallel')) 'v2 English translation'
# Version 3 fixtures exercise independently known ratios and the private boundary.
$doc = @'
<!-- project-statistics-v2:begin -->
| Textbasis / Text base | 800 lines |
| Aktivtage / Active days | 2 |
| Speedup vs. 80 lines/day | 5.0x |
| Methodik / Methodology | v2; source `aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa` |
DE: Das Fenster beginnt am 2025-09-21 und endet am 2026-09-13.
<!-- project-statistics-v2:end -->
'@
$config = '{"methodologyVersion":2,"activityWindowWeeks":52,"timeZone":"Europe/Berlin","excludedPaths":[]}'
$parsed = ConvertFrom-HBProjectStatistics $doc $config
Assert-Test ($parsed.basis.textLines -eq 800 -and (Format-HBAcceleration $parsed.basis) -ceq '5,0×') 'import known factor with German decimal'
Assert-Test ((Format-HBAcceleration $parsed.basis en) -ceq '5.0×') 'English decimal'
Assert-Rejected { ConvertFrom-HBProjectStatistics ($doc.Replace('5.0x','6.0x')) $config } 'contradictory imported factor'
Assert-Rejected { ConvertFrom-HBProjectStatistics ($doc.Replace('2025-09-21','2025-09-20')) $config } 'inconsistent source window'
Assert-Rejected { ConvertFrom-HBProjectStatistics ($doc + $doc) $config } 'duplicate statistics blocks'
Assert-Test ($null -eq (ConvertFrom-HBProjectStatistics '# unknown format' $config)) 'unknown format takes explicit fallback'
$a = [ordered]@{kind='imported';head=('a'*40);basis=$parsed.basis;asOf=$parsed.asOf;windowStart=$parsed.windowStart;sourceRevision=$parsed.sourceRevision;sources=@(
 @{key=('example/source/blob/'+('a'*40)+'/docs/project-statistics.md');content=$doc;sha256=(Get-HBTextHash $doc)},
 @{key=('example/source/blob/'+('a'*40)+'/docs/project-statistics.config.json');content=$config;sha256=(Get-HBTextHash $config)}
)}
Test-HBRepositoryAcceleration $a 'example/source'
$bad = Copy-Fixture $a; $bad.basis.textLines++
Assert-Rejected { Test-HBRepositoryAcceleration $bad 'example/source' } 'imported basis cannot override evidence'
$bad = Copy-Fixture $a; $bad.sources[0].content+='tampered'
Assert-Rejected { Test-HBRepositoryAcceleration $bad 'example/source' } 'acceleration source hash binding'
$v3 = Copy-Fixture $v2; $v3.schemaVersion=3; $v3.ruleVersion=3
$v3.repositories[0]['acceleration']=$a
$v3.repositories[1]['acceleration']=@{kind='empty';head=$null;asOf='2026-09-13';basis=(New-HBAccelerationBasis);sources=@()}
$agg3=Copy-Fixture $aggregate;$agg3.schemaVersion=3;$agg3.ruleVersion=3
$privateBasis=New-HBAccelerationBasis 3
$privateBasis.covered=2;$privateBasis.textLines=8000;$privateBasis.activeDays=10;$privateBasis.oldest='2026-08-01';$privateBasis.newest='2026-09-13'
$agg3['acceleration']=$privateBasis
$out3=Get-HBStatisticsTable $v3 de $agg3
Assert-Test ($out3.Contains('Beschleunigungsfaktor (Repo-Schätzung)') -and $out3.Contains('| 5,0× |')) 'eleventh column'
Assert-Test ($out3.Contains('**9,2× (3/5 Repos)**')) 'weighted aggregate uses underlying totals with coverage'
Assert-Test ($out3.Contains('| nicht berechenbar |')) 'empty repository retains row without invented factor'
Assert-Test ($out3.Contains('2026-08-01 bis 2026-09-13')) 'older source dates preserved'
Assert-Test ($out3 -ceq (Get-HBStatisticsTable (Copy-Fixture $v3) de (Copy-Fixture $agg3))) 'v3 offline deterministic replay'
$bad=Copy-Fixture $agg3;$bad.acceleration['privateName']='example/private'
Assert-Rejected {Assert-HBPrivateAggregate $bad} 'nested private metadata rejected'
$bad=Copy-Fixture $agg3;$bad.acceleration.activeDays='10'
Assert-Rejected {Assert-HBPrivateAggregate $bad} 'numeric strings rejected'
$bad=Copy-Fixture $agg3;$bad.acceleration.reference=125
Assert-Rejected {Assert-HBPrivateAggregate $bad} 'uniform 80 reference enforced'
$bad=Copy-Fixture $agg3;$bad.acceleration.covered=4
Assert-Rejected {Assert-HBPrivateAggregate $bad} 'coverage cannot exceed repository scope'
Assert-Rejected {Get-HBStatisticsTable $v3 de $aggregate} 'mixed private/public schema versions rejected'
$changed=Copy-Fixture $v3;$changed.repositories[0].visibility='excluded';$changed.repositories[0].features=@();$changed.repositories[0].sources=@()
Assert-Rejected {Test-HBStatisticsSnapshot $changed} 'private acceleration cannot survive visibility exclusion'
Assert-Test ((Get-HBBlobLineCount ([byte[]]@(97,13,98))) -eq 2) 'CR-only text parity'
Assert-Test ((Get-HBBlobLineCount ([byte[]]@(97,10,98))) -eq 2) 'unterminated text line parity'
Assert-Test ($null -eq (Get-HBBlobLineCount ([byte[]]@(97,0,98)))) 'binary text exclusion'
$module=Get-Module public-speckit-statistics
& $module {
 function script:Invoke-HBGitHub {
  param([string]$Endpoint)
  switch -Wildcard ($Endpoint) {
   '*/commits[?]*' { return ,@(@{sha=('b'*40);parents=@(@{});commit=@{committer=@{date='2026-09-12T23:30:00Z'}}},@{sha=('c'*40);parents=@(@{},@{});commit=@{committer=@{date='2026-09-12T12:00:00Z'}}}) }
   '*/commits/*' { return @{stats=@{total=3};files=@(@{filename='file.txt';changes=1;additions=1;deletions=0},@{filename='STATS.md';changes=2;additions=2;deletions=0})} }
   '*/git/blobs/*' { return @{encoding='base64';size=4;content='YQpiCg=='} }
   default { throw 'Unexpected fallback API request.' }
  }
 }
}
$fallback=Get-HBFallbackAcceleration 'example/source' ('a'*40) @(@{type='blob';mode='100644';path='file.txt';sha=('d'*40)},@{type='blob';mode='100644';path='STATS.md';sha=('e'*40)}) @() '2026-09-13'
Test-HBRepositoryAcceleration $fallback 'example/source'
Assert-Test ($fallback.basis.textLines -eq 2 -and $fallback.basis.activeDays -eq 1 -and $fallback.commits[0].date -eq '2026-09-13' -and $fallback.blobs.Count -eq 1) 'fallback filters merges/ledger and respects timezone'
$bad=Copy-Fixture $fallback;$bad.commits+=$bad.commits[0]
Assert-Rejected {Test-HBRepositoryAcceleration $bad 'example/source'} 'duplicate activity evidence rejected'
& $module { function script:Invoke-HBGitHub { param([string]$Endpoint); if($Endpoint -like '*/commits[?]*'){return ,@()}; throw 'Inactive repository must not fetch blobs.' } }
$inactive=Get-HBFallbackAcceleration 'example/source' ('a'*40) @() @() '2026-09-13'
Assert-Test ($inactive.basis.covered -eq 0) 'no activity is unavailable rather than 0x'
Import-Module (Join-Path $PSScriptRoot '../lib/public-speckit-statistics.psm1') -Force
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
