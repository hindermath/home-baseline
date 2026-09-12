# Public evidence only. Collection never executes code from inspected repositories.
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Get-HBTextHash {
    param([string]$Text)
    [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($Text))).ToLowerInvariant()
}

function ConvertTo-HBJson {
    param([object]$Value)
    (ConvertTo-Json -InputObject $Value -Depth 100).Replace("`r`n", "`n") + "`n"
}

function Read-HBJson {
    param([string]$Path)
    ConvertFrom-HBJson ([IO.File]::ReadAllText($Path))
}

function ConvertFrom-HBJsonElement {
    param([System.Text.Json.JsonElement]$Element)
    switch ($Element.ValueKind.ToString()) {
        'Object' {
            $value = [ordered]@{}
            foreach ($property in $Element.EnumerateObject()) {
                if ($value.Contains($property.Name)) { throw 'Duplicate JSON property.' }
                $value[$property.Name] = ConvertFrom-HBJsonElement $property.Value
            }
            return $value
        }
        'Array' {
            $items = @($Element.EnumerateArray() | ForEach-Object { ConvertFrom-HBJsonElement $_ })
            return ,$items
        }
        'String' { return $Element.GetString() }
        'Number' { return $Element.GetInt64() }
        'True' { return $true }
        'False' { return $false }
        'Null' { return $null }
        default { throw 'Unsupported JSON value.' }
    }
}

function ConvertFrom-HBJson {
    param([string]$Text)
    # PowerShell versions differ in automatic ISO-date conversion. Preserve JSON strings
    # exactly, so a Linux runner and a local Windows replay hash the same evidence.
    $document = [System.Text.Json.JsonDocument]::Parse($Text)
    try { ConvertFrom-HBJsonElement $document.RootElement } finally { $document.Dispose() }
}

function Invoke-HBGitHub {
    param([string]$Endpoint)
    for ($attempt = 1; $attempt -le 3; $attempt++) {
        try { return Invoke-HBGitHubRead $Endpoint }
        catch { if ($attempt -eq 3) { throw }; Start-Sleep -Seconds $attempt }
    }
}

function Invoke-HBGitHubRead {
    param([string]$Endpoint)
    if ($Endpoint -notmatch '^repos/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+(/|$)' -and
        $Endpoint -notmatch '^(user/repos|installation/repositories)\?[^\s]+$') {
        throw 'Invalid GitHub endpoint.'
    }
    $info = [Diagnostics.ProcessStartInfo]::new('gh')
    $info.UseShellExecute = $false
    $info.RedirectStandardOutput = $true
    $info.RedirectStandardError = $true
    $info.StandardOutputEncoding = [Text.UTF8Encoding]::new($false, $true)
    foreach ($argument in @('api', '--hostname', 'github.com', '--method', 'GET', $Endpoint)) {
        $info.ArgumentList.Add($argument)
    }
    $process = [Diagnostics.Process]::Start($info)
    $stdout = $process.StandardOutput.ReadToEndAsync()
    $stderr = $process.StandardError.ReadToEndAsync()
    if (-not $process.WaitForExit(90000)) {
        $process.Kill($true)
        throw 'GitHub request timed out; previous publication retained.'
    }
    $body = $stdout.GetAwaiter().GetResult()
    $null = $stderr.GetAwaiter().GetResult()
    $code = $process.ExitCode
    $process.Dispose()
    # Do not forward provider stderr: it can contain machine-specific authentication details.
    if ($code -ne 0) { throw "GitHub request failed: ${Endpoint}. Previous publication retained." }
    if ($body.Length -gt 20000000) { throw 'GitHub response exceeds the evidence limit.' }
    ConvertFrom-HBJson $body
}

function Assert-HBRegistry {
    param([System.Collections.IDictionary]$Registry)
    if ($Registry.schemaVersion -notin @(1, 2) -or $Registry.ruleVersion -ne $Registry.schemaVersion) { throw 'Unsupported registry/rule version.' }
    $names = @{}
    foreach ($repo in $Registry.repositories) {
        if ($repo.name -notmatch '^[A-Za-z0-9][A-Za-z0-9_.-]*/[A-Za-z0-9][A-Za-z0-9_.-]*$' -or $repo.level -notin @(0, 2)) {
            throw 'Invalid registered repository or level.'
        }
        if ($names.ContainsKey($repo.name)) { throw 'Duplicate repository.' }
        $names[$repo.name] = $true
        $features = @{}
        foreach ($review in $repo.reviews) {
            if ($review.feature -notmatch '^specs/[0-9]{3,}-[A-Za-z0-9_-]+$') { throw 'Invalid feature path.' }
            if ($features.ContainsKey($review.feature)) { throw 'Duplicate feature review.' }
            $features[$review.feature] = $true
            if ($review.executed -isnot [bool] -or $review.completed -isnot [bool] -or
                ($review.completed -and -not $review.executed)) { throw 'Invalid status ordering.' }
            if ([string]::IsNullOrWhiteSpace($review.reason) -or $review.reviewedBy -ne 'hindermath-maintained-evidence-register') {
                throw 'A reviewed decision and reason are required.'
            }
            $roles = @($review.proofs | ForEach-Object { $_.roles } | ForEach-Object { $_ })
            if ($Registry.ruleVersion -eq 2) { Assert-HBExecutionMode $review }
            foreach ($required in @('started') + $(if ($review.executed) { 'executed' }) + $(if ($review.completed) { 'completed' })) {
                if ($required -notin $roles) { throw "Missing ${required} evidence." }
            }
            foreach ($proof in $review.proofs) {
                if ($proof.kind -notin @('file', 'pullRequest') -or $proof.sha256 -notmatch '^[a-f0-9]{64}$') {
                    throw 'Invalid proof kind/hash.'
                }
                if ($proof.kind -eq 'file' -and ($proof.ref -notmatch '^[a-f0-9]{40}$' -or
                    $proof.path -notmatch '^specs/[A-Za-z0-9_./-]+$' -or $proof.path.Contains('..'))) {
                    throw 'File evidence must be pinned to a commit and a safe specs path.'
                }
                if ($proof.kind -eq 'pullRequest' -and ($proof.number -isnot [long] -and $proof.number -isnot [int])) {
                    throw 'Invalid pull request number.'
                }
            }
        }
    }
    if (@($Registry.repositories | Where-Object { $_.level -eq 0 }).Count -ne 1) { throw 'Exactly one Level-0 source is required.' }
}

function Get-HBProofKey {
    param([string]$Repository, [System.Collections.IDictionary]$Proof)
    if ($Proof.kind -eq 'file') { return "$Repository/blob/$($Proof.ref)/$($Proof.path)" }
    "$Repository/pull/$($Proof.number)"
}

function Get-HBSource {
    param([string]$Repository, [System.Collections.IDictionary]$Proof)
    $key = Get-HBProofKey $Repository $Proof
    if ($Proof.kind -eq 'file') {
        $encoded = (($Proof.path.Split('/') | ForEach-Object { [Uri]::EscapeDataString($_) }) -join '/')
        $response = Invoke-HBGitHub "repos/$Repository/contents/${encoded}?ref=$($Proof.ref)"
        if ($response.type -ne 'file' -or $response.encoding -ne 'base64' -or $response.size -gt 1000000) {
            throw "Unsupported or oversized evidence: $key"
        }
        $content = [Text.UTF8Encoding]::new($false, $true).GetString([Convert]::FromBase64String($response.content))
    } else {
        $response = Invoke-HBGitHub "repos/$Repository/pulls/$($Proof.number)"
        # Freeze only evidence-bearing fields. Counters, labels and API access timestamps are not evidence.
        $content = ConvertTo-HBJson ([ordered]@{
            number = $response.number; title = $response.title; body = $response.body
            mergedAt = $response.merged_at; mergeCommit = $response.merge_commit_sha
            head = $response.head.sha; url = $response.html_url
        })
    }
    [ordered]@{ key = $key; kind = $Proof.kind; sha256 = Get-HBTextHash $content; content = $content }
}

function Get-HBRepositoryMetadata {
    param([string]$Name)
    $meta = Invoke-HBGitHub "repos/$Name"
    if ($meta.full_name -ine $Name) { throw 'Repository identity changed; review the registry.' }
    $meta
}

function Get-HBFeatureTree {
    param([string]$Name, [string]$Commit)
    if ($Commit -notmatch '^[a-f0-9]{40}$') { throw 'Invalid discovery commit.' }
    $tree = Invoke-HBGitHub "repos/$Name/git/trees/${Commit}?recursive=1"
    if ($tree.truncated) { throw "Truncated tree: $Name" }
    $blobs = @{}
    foreach ($item in $tree.tree) { if ($item.type -eq 'blob') { $blobs[$item.path] = $item.sha } }
    $result = @()
    foreach ($item in $tree.tree) {
        if ($item.type -ne 'blob' -or $item.path -cnotmatch '^specs/[0-9]{3,}-[A-Za-z0-9_-]+/spec\.md$') { continue }
        $directory = $item.path.Substring(0, $item.path.Length - 8)
        $evidence = [ordered]@{}
        foreach ($file in @('spec.md', 'tasks.md', 'autonomous-run-state.json')) {
            if ($blobs.ContainsKey("$directory/$file")) { $evidence[$file] = $blobs["$directory/$file"] }
        }
        $result += [ordered]@{ path = $item.path; sha = $item.sha; evidenceBlobs = $evidence }
    }
    $result
}

function Get-HBStatisticsSnapshot {
    param([System.Collections.IDictionary]$Registry, [System.Collections.IDictionary]$Previous = @{})
    Assert-HBRegistry $Registry
    $cache = @{}
    if ($Previous.Count -gt 0) {
        Test-HBStatisticsSnapshot $Previous
        foreach ($entry in $Previous.repositories) {
            foreach ($source in $entry.sources) { $cache[$source.key] = $source }
        }
    }
    $repos = [Collections.Generic.List[object]]::new()
    foreach ($repo in $Registry.repositories) {
        Write-Host "Public evidence / Öffentliche Nachweise: $($repo.name)"
        $meta = Get-HBRepositoryMetadata $repo.name
        if ($meta.visibility -ne 'public' -or $meta.private) {
            $repos.Add([ordered]@{ name = $repo.name; level = $repo.level; visibility = 'excluded'; features = @(); sources = @(); discovery = @() })
            continue
        }
        $branch = [Uri]::EscapeDataString($meta.default_branch)
        $head = (Invoke-HBGitHub "repos/$($repo.name)/commits/$branch").sha
        $found = @{}
        $discovery = [Collections.Generic.List[object]]::new()
        foreach ($item in (Get-HBFeatureTree $repo.name $head)) {
            $feature = $item.path.Substring(0, $item.path.Length - 8)
            $found[$feature] = $head
            $discovery.Add([ordered]@{ feature = $feature; specBlob = $item.sha; evidenceBlobs = $item.evidenceBlobs; commit = $head; pullRequest = $null })
        }
        # A feature may have started before its first merge. Inspect open same-repository PRs;
        # fork PRs are deliberately excluded because they do not establish this owner's run.
        $page = 1
        do {
            $pulls = Invoke-HBGitHub "repos/$($repo.name)/pulls?state=open&per_page=100&page=$page"
            foreach ($pr in $pulls) {
                if ($null -eq $pr.head.repo -or $pr.head.repo.full_name -ine $repo.name) { continue }
                foreach ($item in (Get-HBFeatureTree $repo.name $pr.head.sha)) {
                    $feature = $item.path.Substring(0, $item.path.Length - 8)
                    if (-not $found.ContainsKey($feature)) {
                        $found[$feature] = $pr.head.sha
                        $discovery.Add([ordered]@{ feature = $feature; specBlob = $item.sha; evidenceBlobs = $item.evidenceBlobs; commit = $pr.head.sha; pullRequest = $pr.number })
                    }
                }
            }
            $page++
        } while ($pulls.Count -eq 100)
        $sources = @{}
        $features = [Collections.Generic.List[object]]::new()
        # Accepted historical features remain countable even if their directory was archived later.
        $allFeatures = @(@($found.Keys) + @($repo.reviews | ForEach-Object { $_.feature }) | Sort-Object -Unique -CaseSensitive)
        foreach ($feature in $allFeatures) {
            $reviews = @($repo.reviews | Where-Object { $_.feature -ceq $feature })
            if ($reviews.Count -eq 1) {
                $review = $reviews[0]
                foreach ($proof in $review.proofs) {
                    $key = Get-HBProofKey $repo.name $proof
                    if (-not $sources.ContainsKey($key)) {
                        # Commit-pinned files are immutable; replay already hash-checked public
                        # evidence. PR bodies are mutable and must always be re-observed.
                        if ($proof.kind -eq 'file' -and $cache.ContainsKey($key) -and $cache[$key].sha256 -ceq $proof.sha256) {
                            $sources[$key] = $cache[$key]
                        } else { $sources[$key] = Get-HBSource $repo.name $proof }
                    }
                    if ($sources[$key].sha256 -cne $proof.sha256) { throw "Evidence changed; review required: $key" }
                }
                $changes = @()
                $current = @($discovery | Where-Object { $_.feature -ceq $feature })
                if ($current.Count -eq 1) {
                    foreach ($proof in $review.proofs) {
                        if ($proof.kind -ne 'file' -or -not $proof.path.StartsWith($feature + '/')) { continue }
                        $file = $proof.path.Substring($feature.Length + 1)
                        if ($file -notin @('spec.md', 'tasks.md', 'autonomous-run-state.json')) { continue }
                        $content = $sources[(Get-HBProofKey $repo.name $proof)].content
                        $bytes = [Text.Encoding]::UTF8.GetBytes($content)
                        # Git blob SHA-1 is only an object identity comparison, not a security signature.
                        $prefix = [Text.Encoding]::UTF8.GetBytes("blob $($bytes.Length)`0")
                        $blob = [Convert]::ToHexString([Security.Cryptography.SHA1]::HashData([byte[]]($prefix + $bytes))).ToLowerInvariant()
                        if ($current[0].evidenceBlobs[$file] -cne $blob) { $changes += $file }
                    }
                }
                $features.Add([ordered]@{ feature = $feature; decision = 'reviewed'; review = $review; changedEvidence = $changes })
            } else {
                $proof = @{ kind = 'file'; ref = $found[$feature]; path = "$feature/spec.md" }
                $source = Get-HBSource $repo.name $proof
                $sources[$source.key] = $source
                # Discovery is not a semantic start approval: templates can exist in numbered folders.
                $features.Add([ordered]@{ feature = $feature; decision = 'needsReview'; source = $source.key })
            }
        }
        $again = Get-HBRepositoryMetadata $repo.name
        if ($again.private -or $again.visibility -ne 'public') { throw 'Visibility changed during collection; discard candidate.' }
        $repos.Add([ordered]@{
            name = $repo.name; level = $repo.level; visibility = 'public'
            defaultBranch = $meta.default_branch; head = $head
            features = @($features.ToArray()); sources = @($sources.Values | Sort-Object -Property { $_['key'] } -CaseSensitive)
            discovery = @($discovery.ToArray() | Sort-Object -Property { $_['feature'] } -CaseSensitive)
        })
    }
    [ordered]@{
        schemaVersion = $Registry.schemaVersion; ruleVersion = $Registry.ruleVersion
        collectedAt = [DateTimeOffset]::UtcNow.ToString('yyyy-MM-ddTHH:mm:ssZ')
        registrySha256 = Get-HBTextHash (ConvertTo-HBJson $Registry)
        repositories = @($repos.ToArray())
    }
}

function Test-HBStatisticsSnapshot {
    param([System.Collections.IDictionary]$Snapshot)
    if ($Snapshot.schemaVersion -notin @(1, 2) -or $Snapshot.ruleVersion -ne $Snapshot.schemaVersion -or
        $Snapshot.registrySha256 -notmatch '^[a-f0-9]{64}$') { throw 'Unsupported snapshot.' }
    $null = [DateTimeOffset]::ParseExact($Snapshot.collectedAt, 'yyyy-MM-ddTHH:mm:ssZ', [Globalization.CultureInfo]::InvariantCulture)
    $names = @{}
    foreach ($repo in $Snapshot.repositories) {
        if ($names.ContainsKey($repo.name)) { throw 'Duplicate snapshot repository.' }
        $names[$repo.name] = $true
        Assert-HBRegistry @{ schemaVersion = $Snapshot.schemaVersion; ruleVersion = $Snapshot.ruleVersion; repositories = @(
            @{ name = $repo.name; level = 0; reviews = @($repo.features | Where-Object { $_.decision -eq 'reviewed' } | ForEach-Object { $_.review }) }
        ) }
        if ($repo.level -notin @(0, 2) -or $repo.visibility -notin @('public', 'excluded')) { throw 'Invalid snapshot scope.' }
        if ($repo.visibility -eq 'excluded' -and ($repo.features.Count -gt 0 -or $repo.sources.Count -gt 0)) { throw 'Excluded repository contains evidence.' }
        $sources = @{}
        foreach ($source in $repo.sources) {
            if ($sources.ContainsKey($source.key) -or $source.sha256 -cne (Get-HBTextHash $source.content)) { throw 'Duplicate/corrupt source.' }
            if (-not $source.key.StartsWith($repo.name + '/', [StringComparison]::Ordinal)) { throw 'Foreign source.' }
            $sources[$source.key] = $source
        }
        $features = @{}
        $runIds = @{}
        foreach ($feature in $repo.features) {
            if ($feature.feature -notmatch '^specs/[0-9]{3,}-[A-Za-z0-9_-]+$') { throw 'Invalid candidate feature path.' }
            if ($features.ContainsKey($feature.feature)) { throw 'Duplicate snapshot feature.' }
            $features[$feature.feature] = $true
            if ($feature.decision -eq 'needsReview') {
                if (-not $sources.ContainsKey($feature.source)) { throw 'Missing candidate source.' }
                continue
            }
            if ($feature.decision -ne 'reviewed' -or $feature.review.feature -cne $feature.feature) { throw 'Unknown or mismatched decision.' }
            foreach ($proof in $feature.review.proofs) {
                $key = Get-HBProofKey $repo.name $proof
                if (-not $sources.ContainsKey($key) -or $sources[$key].sha256 -cne $proof.sha256) { throw 'Missing/changed reviewed proof.' }
                if ($proof.kind -eq 'pullRequest') {
                    $pr = ConvertFrom-HBJson $sources[$key].content
                    if ($null -eq $pr.mergedAt -or $pr.head -notmatch '^[a-f0-9]{40}$') { throw 'Invalid reviewed delivery PR.' }
                }
                if ($proof.kind -eq 'file' -and $proof.path.EndsWith('/autonomous-run-state.json')) {
                    $state = ConvertFrom-HBJson $sources[$key].content
                    if ($state.status -notin @('Completed', 'Active', 'Blocked', 'Failed', 'Interrupted', 'PausedByUser', 'Stopped')) {
                        throw 'Unknown autonomous status; rule review required.'
                    }
                    $parsedId = [guid]::Empty
                    if (-not [guid]::TryParseExact($state.runId, 'D', [ref]$parsedId) -or $parsedId -eq [guid]::Empty) { throw 'Invalid run identity.' }
                    if ($runIds.ContainsKey($state.runId) -and $runIds[$state.runId] -cne $feature.feature) { throw 'Run ID reused by another feature.' }
                    $runIds[$state.runId] = $feature.feature
                    if ('completed' -in $proof.roles -and $state.status -ne 'Completed') { throw 'Nonterminal state cannot prove completion.' }
                }
            }
        }
    }
    if (@($Snapshot.repositories | Where-Object { $_.level -eq 0 }).Count -ne 1) { throw 'Missing/duplicate Level 0.' }
}

function Assert-HBStatisticsRegistryBinding {
    param([System.Collections.IDictionary]$Snapshot, [System.Collections.IDictionary]$Registry)
    Assert-HBRegistry $Registry
    if ($Snapshot.registrySha256 -cne (Get-HBTextHash (ConvertTo-HBJson $Registry)) -or
        $Snapshot.repositories.Count -ne $Registry.repositories.Count) { throw 'Registry/snapshot binding mismatch.' }
    for ($index = 0; $index -lt $Registry.repositories.Count; $index++) {
        $expected = $Registry.repositories[$index]; $actual = $Snapshot.repositories[$index]
        if ($actual.name -cne $expected.name -or $actual.level -ne $expected.level) { throw 'Repository scope/order mismatch.' }
        if ($actual.visibility -eq 'excluded') { continue }
        $reviews = @($actual.features | Where-Object { $_.decision -eq 'reviewed' } | ForEach-Object { $_.review })
        if ((ConvertTo-HBJson $reviews) -cne (ConvertTo-HBJson @($expected.reviews))) {
            throw 'Snapshot classifications differ from the reviewed register.'
        }
    }
}

function Get-HBStatisticsFingerprint {
    param([System.Collections.IDictionary]$Snapshot)
    # Main advances for unrelated work and for this publication itself. Those heads and the
    # observation clock must not create an endless chain of monthly/self-referential PRs.
    $stable = [ordered]@{ ruleVersion = $Snapshot.ruleVersion; registrySha256 = $Snapshot.registrySha256; repositories = @() }
    foreach ($repo in $Snapshot.repositories) {
        $observed = @($repo.discovery | ForEach-Object {
            [ordered]@{ feature = $_.feature; specBlob = $_.specBlob; evidenceBlobs = $(if ($_.Contains('evidenceBlobs')) { $_.evidenceBlobs } else { @{} }) }
        })
        $stable.repositories += [ordered]@{ name = $repo.name; level = $repo.level; visibility = $repo.visibility; features = $repo.features; sources = $repo.sources; observed = $observed }
    }
    Get-HBTextHash (ConvertTo-HBJson $stable)
}

function Get-HBStatisticsTable {
    param([System.Collections.IDictionary]$Snapshot, [ValidateSet('de', 'en')][string]$Language = 'de', [System.Collections.IDictionary]$PrivateAggregate)
    Test-HBStatisticsSnapshot $Snapshot
    if ($Snapshot.ruleVersion -eq 2) { return Get-HBExtendedStatisticsTable $Snapshot $Language $PrivateAggregate }
    $rows = [Collections.Generic.List[string]]::new()
    $method = 'https://github.com/hindermath/home-baseline/blob/main/docs/spec-kit-runs/README.md'
    if ($Language -eq 'de') {
        $rows.Add("Datenstand: $($Snapshot.collectedAt) · [Methodik und Einzelbelege]($method)")
        $rows.Add('')
        $rows.Add('| Level | Öffentliches GitHub-Repository | Gestartet | Ausgeführt | Abschluss belegt |')
    } else {
        $rows.Add("Data as of: $($Snapshot.collectedAt) · [Method and individual evidence]($method)")
        $rows.Add('')
        $rows.Add('| Level | Public GitHub repository | Started | Executed | Completion evidenced |')
    }
    $rows.Add('|---|---|---:|---:|---:|')
    $totals = @(0, 0, 0); $level2 = @(0, 0, 0)
    foreach ($repo in $Snapshot.repositories) {
        if ($repo.visibility -ne 'public') { continue }
        $accepted = @($repo.features | Where-Object { $_.decision -eq 'reviewed' })
        $counts = @($accepted.Count, @($accepted | Where-Object { $_.review.executed }).Count, @($accepted | Where-Object { $_.review.completed }).Count)
        $display = $repo.name.Split('/')[1]
        $rows.Add("| $($repo.level) | [$display](https://github.com/$($repo.name)) | $($counts[0]) | $($counts[1]) | $($counts[2]) |")
        for ($i = 0; $i -lt 3; $i++) { $totals[$i] += $counts[$i]; if ($repo.level -eq 2) { $level2[$i] += $counts[$i] } }
    }
    $label2 = if ($Language -eq 'de') { 'Level 2 gesamt' } else { 'Level 2 total' }
    $labelAll = if ($Language -eq 'de') { 'Level 0 + Level 2 insgesamt' } else { 'Level 0 + Level 2 total' }
    $rows.Add("| | **$label2** | **$($level2[0])** | **$($level2[1])** | **$($level2[2])** |")
    $rows.Add("| | **$labelAll** | **$($totals[0])** | **$($totals[1])** | **$($totals[2])** |")
    ($rows -join "`n") + "`n"
}

function Set-HBStatisticsBlock {
    param([string]$Text, [string]$Block)
    $begin = '<!-- public-speckit-runs:begin -->'; $end = '<!-- public-speckit-runs:end -->'
    if ([regex]::Matches($Text, [regex]::Escape($begin)).Count -ne 1 -or
        [regex]::Matches($Text, [regex]::Escape($end)).Count -ne 1) { throw 'Exactly one statistics marker pair is required.' }
    $start = $Text.IndexOf($begin, [StringComparison]::Ordinal)
    $finish = $Text.IndexOf($end, [StringComparison]::Ordinal)
    if ($finish -le $start) { throw 'Reversed statistics markers.' }
    $Text.Substring(0, $start) + $begin + "`n" + $Block.TrimEnd("`r", "`n") + "`n" + $Text.Substring($finish)
}

function Get-HBStatisticsReviewReport {
    param([System.Collections.IDictionary]$Snapshot)
    $lines = @('# Prüfbedarf / Review queue', '', 'Nicht geprüfte Kandidaten sind in keiner Zahl enthalten. / Unreviewed candidates are excluded from all counts.', '')
    foreach ($repo in $Snapshot.repositories) {
        foreach ($feature in $repo.features) {
            if ($feature.decision -eq 'needsReview') { $lines += "- [ ] $($repo.name): $($feature.feature) — https://github.com/$($feature.source)" }
            elseif (-not $feature.review.completed) { $lines += "- Abschluss nicht belegt / Completion not evidenced: $($repo.name) $($feature.feature) — $($feature.review.reason)" }
            if ($feature.Contains('changedEvidence') -and $feature.changedEvidence.Count -gt 0) {
                $lines += "- [ ] Geänderte Nachweise prüfen / Review changed evidence: $($repo.name) $($feature.feature): $($feature.changedEvidence -join ', '). Existing counts retain their pinned reviewed basis."
            }
        }
    }
    ($lines -join "`n") + "`n"
}

function Assert-HBExecutionMode {
    param([System.Collections.IDictionary]$Review)
    $modes = @('manual', 'serial', 'parallel', 'mixed', 'unknown')
    if ($Review.executionMode -cnotin $modes -or [string]::IsNullOrWhiteSpace($Review.modeReason)) { throw 'Execution mode and reason required.' }
    if (-not $Review.executed -and $Review.executionMode -ne 'unknown') { throw 'Unexecuted feature cannot have an execution mode.' }
    # Absence of orchestration files is never affirmative evidence of manual execution.
    if ($Review.executionMode -ne 'unknown' -and @($Review.proofs | Where-Object { 'mode' -in $_.roles }).Count -eq 0) {
        throw 'Classified execution mode requires pinned affirmative evidence.'
    }
}

function Assert-HBPrivateAggregate {
    param([System.Collections.IDictionary]$Aggregate)
    # This allowlist is the private/public boundary. Never forward source metadata or free text.
    $keys = @('schemaVersion', 'ruleVersion', 'collectedAt', 'started', 'executed', 'completed', 'manual', 'serial', 'parallel', 'mixed', 'unknown', 'needsReview')
    if ($null -eq $Aggregate -or $Aggregate.Count -ne $keys.Count) { throw 'A complete sanitized private aggregate is required.' }
    foreach ($key in $Aggregate.Keys) { if ($key -cnotin $keys) { throw 'Private aggregate contains prohibited fields.' } }
    if ($Aggregate.schemaVersion -ne 2 -or $Aggregate.ruleVersion -ne 2) { throw 'Unsupported private aggregate version.' }
    $null = [DateTimeOffset]::ParseExact($Aggregate.collectedAt, 'yyyy-MM-ddTHH:mm:ssZ', [Globalization.CultureInfo]::InvariantCulture)
    foreach ($key in $keys | Where-Object { $_ -notin @('schemaVersion', 'ruleVersion', 'collectedAt') }) {
        if (($Aggregate[$key] -isnot [int] -and $Aggregate[$key] -isnot [long]) -or $Aggregate[$key] -lt 0 -or $Aggregate[$key] -gt 10000000) {
            throw 'Aggregate values must be bounded nonnegative integers.'
        }
    }
    if ($Aggregate.completed -gt $Aggregate.executed -or $Aggregate.executed -gt $Aggregate.started -or
        ($Aggregate.manual + $Aggregate.serial + $Aggregate.parallel + $Aggregate.mixed + $Aggregate.unknown) -ne $Aggregate.executed) {
        throw 'Private aggregate status/mode totals disagree.'
    }
}

function Get-HBExecutionCounts {
    param([object[]]$Reviews)
    $counts = @(0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L)
    $modes = @('manual', 'serial', 'parallel', 'mixed', 'unknown')
    foreach ($review in $Reviews) {
        Assert-HBExecutionMode $review
        $counts[0]++
        if ($review.completed) { $counts[2]++ }
        if ($review.executed) { $counts[1]++; $counts[3 + [array]::IndexOf($modes, $review.executionMode)]++ }
    }
    return ,$counts
}

function Get-HBExtendedStatisticsTable {
    param([System.Collections.IDictionary]$Snapshot, [string]$Language, [System.Collections.IDictionary]$PrivateAggregate)
    Assert-HBPrivateAggregate $PrivateAggregate
    $rows = [Collections.Generic.List[string]]::new()
    $method = 'https://github.com/hindermath/home-baseline/blob/main/docs/spec-kit-runs/README.md'
    $de = $Language -eq 'de'
    $rows.Add($(if ($de) { "Datenstand öffentlich: $($Snapshot.collectedAt); privat: $($PrivateAggregate.collectedAt) · [Methodik und Beleggrenzen]($method)" }
        else { "Public data as of: $($Snapshot.collectedAt); private: $($PrivateAggregate.collectedAt) · [Method and evidence boundaries]($method)" }))
    $rows.Add('')
    $rows.Add($(if ($de) { '| Level | Öffentliches GitHub-Repository / Gruppe | Gestartet | Ausgeführt | Abschluss belegt | Manuell | Autonom seriell | Autonom parallel | Gemischt | Nicht eindeutig belegt |' }
        else { '| Level | Public GitHub repository / group | Started | Executed | Completion evidenced | Manual | Autonomous serial | Autonomous parallel | Mixed | Not clearly evidenced |' }))
    $rows.Add('|---|---|---:|---:|---:|---:|---:|---:|---:|---:|')
    $totals = @(0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L); $level2 = $totals.Clone()
    foreach ($repo in $Snapshot.repositories) {
        if ($repo.visibility -ne 'public') { continue }
        $counts = Get-HBExecutionCounts @($repo.features | Where-Object { $_.decision -eq 'reviewed' } | ForEach-Object { $_.review })
        $rows.Add("| $($repo.level) | [$($repo.name.Split('/')[1])](https://github.com/$($repo.name)) | $($counts -join ' | ') |")
        for ($i = 0; $i -lt 8; $i++) { $totals[$i] += $counts[$i]; if ($repo.level -eq 2) { $level2[$i] += $counts[$i] } }
    }
    $privateCounts = @('started', 'executed', 'completed', 'manual', 'serial', 'parallel', 'mixed', 'unknown') | ForEach-Object { $PrivateAggregate[$_] }
    $all = $totals.Clone(); for ($i = 0; $i -lt 8; $i++) { $all[$i] += $privateCounts[$i] }
    $labels = if ($de) { @('Öffentliche Level-2-Repositories gesamt', 'Öffentliche Level-0-/2-Repositories gesamt', 'Private GitHub-Repositories gesamt', 'Alle erfassten Repositories gesamt') }
        else { @('Public level-2 repositories total', 'Public level-0/2 repositories total', 'Private GitHub repositories total', 'All included repositories total') }
    $values = @($level2, $totals, $privateCounts, $all)
    for ($i = 0; $i -lt 4; $i++) { $rows.Add("| | **$($labels[$i])** | $(($values[$i] | ForEach-Object { "**$_**" }) -join ' | ') |") }
    $rows.Add('')
    $rows.Add($(if ($de) { "Ausführungsarten teilen ausschließlich Ausgeführt auf. Private ungeprüfte Kandidaten: $($PrivateAggregate.needsReview); nicht mitgezählt." }
        else { "Execution modes partition Executed only. Unreviewed private candidates: $($PrivateAggregate.needsReview); excluded from counts." }))
    ($rows -join "`n") + "`n"
}

Export-ModuleMember -Function *-HB*
