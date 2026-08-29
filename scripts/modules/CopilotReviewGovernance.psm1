Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$script:CRGTargetSlugs = @(
    'hindermath/home-baseline',
    'hindermath/agent-operations-cockpit',
    'hindermath/TuiVision',
    'hindermath/TinyPl0',
    'hindermath/TinyCalc',
    'hindermath/InventarWorkerService',
    'hindermath/cc65',
    'hindermath/tvision'
)
$script:CRGApiVersion = '2026-03-10'
$script:CRGRepositoryRoot = [IO.Path]::GetFullPath((Join-Path $PSScriptRoot '../..'))
$script:CRGContractRoot = Join-Path $script:CRGRepositoryRoot 'specs/031-github-copilot-review-governance/contracts'
$script:CRGOperationContracts = @{
    AccountSetting = @{ Methods = @('BrowserManual'); Scopes = @('PersonalCopilotSettings:write'); Identity = 'Account' }
    EffortLevel = @{ Methods = @('BrowserManual'); Scopes = @('RepositoryCopilotSettings:write'); Identity = 'Repository' }
    RulesetCreate = @{ Methods = @('POST'); Scopes = @('Administration:write'); Identity = 'Repository' }
    RulesetUpdate = @{ Methods = @('PUT'); Scopes = @('Administration:write'); Identity = 'Ruleset' }
    RulesetDisable = @{ Methods = @('PUT'); Scopes = @('Administration:write'); Identity = 'Ruleset' }
    PRLifecycleAcceptance = @{ Methods = @('POST', 'PUT', 'GitPush'); Scopes = @('PullRequests:write', 'Contents:write'); Identity = 'PullRequest' }
    ManualReviewAcceptance = @{ Methods = @('POST'); Scopes = @('PullRequests:write'); Identity = 'PullRequest' }
    Delivery = @{ Methods = @('GitPush', 'GitHubMerge'); Scopes = @('Contents:write', 'PullRequests:write'); Identity = 'PullRequest' }
    Rollback = @{ Methods = @(); Scopes = @(); Identity = 'SourceOperation' }
}

function Assert-HBCondition {
    param([Parameter(Mandatory)][bool] $Condition, [Parameter(Mandatory)][string] $Message)
    if (-not $Condition) { throw $Message }
}

function ConvertTo-HBOrderedValue {
    param([Parameter(Mandatory)] $Value)

    if ($Value -is [Collections.IDictionary]) {
        $ordered = [ordered]@{}
        foreach ($key in @($Value.Keys | Sort-Object)) {
            $ordered[[string] $key] = ConvertTo-HBOrderedValue $Value[$key]
        }
        return $ordered
    }
    if ($Value -is [pscustomobject]) {
        $table = @{}
        foreach ($property in $Value.PSObject.Properties) { $table[$property.Name] = $property.Value }
        return ConvertTo-HBOrderedValue $table
    }
    if ($Value -is [object[]]) {
        $array = [object[]]::new($Value.Count)
        for ($index = 0; $index -lt $Value.Count; $index++) {
            $array[$index] = ConvertTo-HBOrderedValue $Value[$index]
        }
        Write-Output -NoEnumerate -InputObject $array
        return
    }
    return $Value
}

function ConvertTo-HBCanonicalJson {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] $Value,
        [string[]] $ExcludeProperties = @()
    )

    $copy = ConvertTo-HBOrderedValue $Value
    if ($copy -is [Collections.IDictionary]) {
        foreach ($property in $ExcludeProperties) { [void] $copy.Remove($property) }
    }
    return ($copy | ConvertTo-Json -Depth 40 -Compress) + "`n"
}

function Get-HBSha256 {
    [CmdletBinding(DefaultParameterSetName = 'Text')]
    param(
        [Parameter(Mandatory, ParameterSetName = 'Text')][string] $Text,
        [Parameter(Mandatory, ParameterSetName = 'Bytes')][byte[]] $Bytes
    )

    $inputBytes = if ($PSCmdlet.ParameterSetName -eq 'Bytes') { $Bytes } else { [Text.UTF8Encoding]::new($false).GetBytes($Text) }
    return [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($inputBytes)).ToLowerInvariant()
}

function Read-HBJsonFile {
    param([Parameter(Mandatory)][string] $Path)

    Assert-HBCondition (Test-Path -LiteralPath $Path -PathType Leaf) "JSON-Datei fehlt / JSON file missing: $Path"
    try { return Get-Content -LiteralPath $Path -Raw -Encoding utf8 | ConvertFrom-Json -AsHashtable -DateKind String }
    catch { throw "Ungueltiges JSON / Invalid JSON in ${Path}: $($_.Exception.Message)" }
}

function Assert-HBJsonSchema {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)] $Value,
        [Parameter(Mandatory)][string] $SchemaName
    )

    $schemaPath = Join-Path $script:CRGContractRoot "$SchemaName.schema.json"
    Assert-HBCondition (Test-Path -LiteralPath $schemaPath -PathType Leaf) "Schema fehlt / Schema missing: $SchemaName"
    $json = ConvertTo-HBCanonicalJson $Value
    try {
        $valid = Test-Json -Json $json -SchemaFile $schemaPath -ErrorAction Stop
    } catch {
        throw "JSON-Schema '$SchemaName' wurde verletzt / was violated: $($_.Exception.Message)"
    }
    Assert-HBCondition $valid "JSON-Schema '$SchemaName' wurde verletzt / was violated."
    return $true
}

function Get-HBObjectSha256 {
    param(
        [Parameter(Mandatory)] $Value,
        [string[]] $ExcludeProperties = @()
    )
    return Get-HBSha256 -Text (ConvertTo-HBCanonicalJson $Value -ExcludeProperties $ExcludeProperties)
}

function New-HBDeterministicGuid {
    param([Parameter(Mandatory)][string] $Seed)
    $bytes = [Security.Cryptography.SHA256]::HashData([Text.UTF8Encoding]::new($false).GetBytes($Seed))
    $guidBytes = [byte[]]::new(16)
    [Array]::Copy($bytes, $guidBytes, 16)
    return [guid]::new($guidBytes).ToString()
}

function ConvertTo-HBDateTimeOffset {
    param([Parameter(Mandatory)] $Value)
    if ($Value -is [DateTimeOffset]) { return $Value }
    if ($Value -is [DateTime]) { return [DateTimeOffset]::new($Value.ToUniversalTime()) }
    return [DateTimeOffset]::Parse([string] $Value, [Globalization.CultureInfo]::InvariantCulture)
}

function Write-HBJsonFile {
    param([Parameter(Mandatory)][string] $Path, [Parameter(Mandatory)] $Value)
    $fullPath = [IO.Path]::GetFullPath($Path)
    [void](New-Item -ItemType Directory -Path (Split-Path -Parent $fullPath) -Force)
    [IO.File]::WriteAllText($fullPath, (ConvertTo-HBCanonicalJson $Value), [Text.UTF8Encoding]::new($false))
}

function Resolve-HBSafePath {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $Root,
        [Parameter(Mandatory)][string] $Path,
        [switch] $AllowMissingLeaf
    )

    Assert-HBCondition (-not [IO.Path]::IsPathRooted($Path)) 'Absolute Pfade sind nicht erlaubt / Absolute paths are not allowed.'
    Assert-HBCondition (@($Path -split '[\\/]' | Where-Object { $_ -eq '..' }).Count -eq 0) 'Pfadtraversal ist nicht erlaubt / Path traversal is not allowed.'
    $rootFull = [IO.Path]::GetFullPath($Root).TrimEnd([IO.Path]::DirectorySeparatorChar) + [IO.Path]::DirectorySeparatorChar
    $full = [IO.Path]::GetFullPath((Join-Path $Root $Path))
    Assert-HBCondition $full.StartsWith($rootFull, [StringComparison]::Ordinal) 'Pfad verlaesst den Evidence-Root / Path escapes evidence root.'
    $probe = if (Test-Path -LiteralPath $full) { $full } else { Split-Path -Parent $full }
    while (-not (Test-Path -LiteralPath $probe) -and $probe.StartsWith($rootFull, [StringComparison]::Ordinal)) {
        $probe = Split-Path -Parent $probe
    }
    $cursor = Get-Item -LiteralPath $probe -Force
    while ($null -ne $cursor -and $cursor.FullName.StartsWith($rootFull, [StringComparison]::Ordinal)) {
        Assert-HBCondition (-not ($cursor.Attributes -band [IO.FileAttributes]::ReparsePoint)) 'Symlinks oder Reparse Points sind nicht erlaubt / Symlinks or reparse points are not allowed.'
        $cursor = if ($cursor -is [IO.FileInfo]) { $cursor.Directory } else { $cursor.Parent }
    }
    if (-not $AllowMissingLeaf) { Assert-HBCondition (Test-Path -LiteralPath $full -PathType Leaf) "Datei fehlt / File missing: $Path" }
    return $full
}

function Test-HBExactSet {
    param([object[]] $Actual, [object[]] $Expected)
    return @($Actual).Count -eq @($Expected).Count -and @(Compare-Object @($Actual) @($Expected) -SyncWindow 0).Count -eq 0
}

function Read-HBDesiredState {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string] $Path)

    $data = Read-HBJsonFile $Path
    [void](Assert-HBJsonSchema $data 'desired-state')
    Assert-HBCondition ([string] $data.schemaVersion -eq '1.0') 'Desired State schemaVersion muss 1.0 sein.'
    Assert-HBCondition ([guid]::Parse([string] $data.contractId) -ne [guid]::Empty) 'contractId muss eine UUID ungleich null sein.'
    Assert-HBCondition ([string] $data.owner -eq 'hindermath') 'Desired State owner muss hindermath sein.'
    Assert-HBCondition ([string] $data.generatedFromSpec -eq 'specs/031-github-copilot-review-governance/spec.md') 'generatedFromSpec stimmt nicht.'
    Assert-HBCondition (@($data.targets).Count -eq 8) 'Desired State muss exakt acht Ziele enthalten.'
    for ($index = 0; $index -lt 8; $index++) {
        $target = $data.targets[$index]
        Assert-HBCondition (Test-HBExactSet @($target.Keys | Sort-Object) @('defaultBranch', 'position', 'slug')) 'Target Selector muss exakt position, slug und defaultBranch enthalten.'
        Assert-HBCondition ([int] $target.position -eq ($index + 1)) 'Targetposition ist nicht fortlaufend.'
        Assert-HBCondition ([string] $target.slug -ceq $script:CRGTargetSlugs[$index]) 'Targetslug weicht vom closed-world Vertrag ab.'
        $expectedBranch = if ($index -ge 6) { 'master' } else { 'main' }
        Assert-HBCondition ([string] $target.defaultBranch -eq $expectedBranch) 'Default Branch weicht vom Vertrag ab.'
    }
    $settings = $data.desiredSettings
    Assert-HBCondition ([string] $settings.personalAccountAutomation -eq 'Disabled') 'Accountautomation muss Disabled sein.'
    Assert-HBCondition ([string] $settings.reviewEffort -eq 'Lite') 'Review effort muss Lite sein.'
    Assert-HBCondition (-not [bool] $settings.automaticReview.reviewDraftPullRequests -and -not [bool] $settings.automaticReview.reviewOnPush) 'Draft- und Push-Automatik muessen false sein.'
    Assert-HBCondition ([bool] $settings.automaticReview.readyOpenOrFirstDraftToReadyOnly) 'Nur Ready-open oder erster Draft-to-Ready ist erlaubt.'
    $hash = Get-HBSha256 -Text (ConvertTo-HBCanonicalJson $data -ExcludeProperties @('contractSha256'))
    Assert-HBCondition ([string] $data.contractSha256 -eq $hash) 'Desired State contractSha256 stimmt nicht.'
    return $data
}

function Test-HBInventory {
    [CmdletBinding()]
    param([Parameter(Mandatory)][hashtable] $Inventory)

    [void](Assert-HBJsonSchema $Inventory 'inventory')
    Assert-HBCondition ([string] $Inventory.apiVersion -eq $script:CRGApiVersion) "Inventory API version must be $($script:CRGApiVersion)."
    $now = [DateTimeOffset]::UtcNow
    $observedAt = ConvertTo-HBDateTimeOffset $Inventory.observedAt
    $expiresAt = ConvertTo-HBDateTimeOffset $Inventory.expiresAt
    Assert-HBCondition ($observedAt -le $now -and $expiresAt -gt $now -and $expiresAt -gt $observedAt) 'Inventory freshness window is invalid or expired.'
    $snapshotHash = Get-HBObjectSha256 $Inventory @('snapshotSha256')
    Assert-HBCondition ([string] $Inventory.snapshotSha256 -eq $snapshotHash) 'Inventory snapshotSha256 mismatch.'
    $repositoryIds = @($Inventory.repositories | ForEach-Object { [long] $_.repositoryId })
    Assert-HBCondition ($repositoryIds.Count -eq @($repositoryIds | Sort-Object -Unique).Count) 'Doppelte Repository-ID.'
    $rulesetIds = @($Inventory.rulesets | ForEach-Object { "$(($_.repositoryId)):$($_.rulesetId)" })
    Assert-HBCondition ($rulesetIds.Count -eq @($rulesetIds | Sort-Object -Unique).Count) 'Doppelte Ruleset-ID.'
    foreach ($ruleset in @($Inventory.rulesets)) {
        Assert-HBCondition ([string] $ruleset.sourceType -in @('Repository', 'Organization', 'Enterprise')) 'Unbekannter Ruleset sourceType.'
        Assert-HBCondition ($repositoryIds -contains [long] $ruleset.repositoryId) 'Ruleset references an unknown repositoryId.'
    }
    foreach ($browser in @($Inventory.browserEvidence)) {
        if ($browser.Contains('repositoryId')) {
            Assert-HBCondition ($repositoryIds -contains [long] $browser.repositoryId) 'Browser evidence references an unknown repositoryId.'
        }
    }
    return $true
}

function Get-HBGitHubReadRequestDefinitions {
    [CmdletBinding()]
    param(
        [string] $RepositorySlug = '',
        [long] $RulesetId = 0
    )

    $requests = [Collections.Generic.List[object]]::new()
    $requests.Add(@('api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)", '/user/repos?affiliation=owner&visibility=all&sort=full_name&direction=asc&per_page=100', '--paginate'))
    if ($RepositorySlug) {
        Assert-HBCondition ($RepositorySlug -match '^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$') 'Repository-Slug ist ungueltig.'
        $requests.Add(@('api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)", "repos/$RepositorySlug"))
        $requests.Add(@('api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)", "repos/$RepositorySlug/rulesets?includes_parents=false&per_page=100", '--paginate'))
        if ($RulesetId -gt 0) {
            $requests.Add(@('api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)", "repos/$RepositorySlug/rulesets/$RulesetId"))
        }
    }
    return $requests.ToArray()
}

function Invoke-HBGitHubJsonRead {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string[]] $Arguments,
        [string] $Executable = 'gh'
    )

    Assert-HBCondition ($Arguments.Count -ge 6 -and $Arguments[0] -eq 'api') 'GitHub read arguments are incomplete.'
    Assert-HBCondition (@($Arguments | Where-Object { $_ -eq '--method' }).Count -eq 1) 'GitHub read must declare exactly one method.'
    $methodIndex = [Array]::IndexOf($Arguments, '--method')
    Assert-HBCondition ($methodIndex -ge 0 -and $Arguments[$methodIndex + 1] -eq 'GET') 'GitHub inventory permits GET only.'
    Assert-HBCondition (@($Arguments | Where-Object { $_ -eq "X-GitHub-Api-Version: $($script:CRGApiVersion)" }).Count -eq 1) 'GitHub API version header is missing or duplicated.'

    $endpoint = @($Arguments | Where-Object { $_ -match '^/?(user|users|repos)/' }) | Select-Object -Last 1
    Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($endpoint)) 'GitHub read endpoint is missing.'
    $output = [Collections.Generic.List[string]]::new()
    $exitCode = 1
    for ($attempt = 1; $attempt -le 3; $attempt++) {
        $output.Clear()
        & $Executable @Arguments 2>&1 | ForEach-Object { $output.Add([string] $_) }
        $exitCode = $LASTEXITCODE
        if ($exitCode -eq 0) {
            break
        }
        if ($attempt -lt 3) {
            # A bounded retry is safe here because the contract above proves GET-only access.
            Start-Sleep -Milliseconds (250 * $attempt)
        }
    }
    if ($exitCode -ne 0) {
        throw "GitHub read failed for ${endpoint} after 3 bounded GET attempts with exit code ${exitCode}."
    }
    try {
        $data = ($output -join "`n") | ConvertFrom-Json -AsHashtable -NoEnumerate -DateKind String
    } catch {
        throw "GitHub read returned invalid JSON for ${endpoint}."
    }
    return [ordered]@{ endpoint = [string] $endpoint; data = $data }
}

function Invoke-HBGitHubJsonWrite {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string[]] $Arguments,
        [Parameter(Mandatory)][string] $InputPath,
        [string] $Executable = 'gh'
    )

    Assert-HBCondition ($Arguments.Count -ge 10 -and $Arguments[0] -eq 'api') 'GitHub write arguments are incomplete.'
    Assert-HBCondition (@($Arguments | Where-Object { $_ -eq '--method' }).Count -eq 1) 'GitHub write must declare exactly one method.'
    $methodIndex = [Array]::IndexOf($Arguments, '--method')
    $method = if ($methodIndex -ge 0) { [string] $Arguments[$methodIndex + 1] } else { '' }
    Assert-HBCondition ($method -in @('POST', 'PUT')) 'GitHub ruleset writes permit POST or PUT only.'
    Assert-HBCondition (@($Arguments | Where-Object { $_ -eq '--hostname' }).Count -eq 1) 'GitHub write must bind exactly one host.'
    $hostIndex = [Array]::IndexOf($Arguments, '--hostname')
    Assert-HBCondition ($hostIndex -ge 0 -and [string] $Arguments[$hostIndex + 1] -eq 'github.com') 'GitHub write host must be github.com.'
    Assert-HBCondition (@($Arguments | Where-Object { $_ -eq "X-GitHub-Api-Version: $($script:CRGApiVersion)" }).Count -eq 1) 'GitHub API version header is missing or duplicated.'
    Assert-HBCondition (@($Arguments | Where-Object { $_ -in @('--paginate', '--slurp') }).Count -eq 0) 'GitHub writes cannot paginate or slurp.'
    Assert-HBCondition (@($Arguments | Where-Object { $_ -eq '--input' }).Count -eq 1) 'GitHub write must bind exactly one JSON input file.'
    $inputIndex = [Array]::IndexOf($Arguments, '--input')
    Assert-HBCondition ($inputIndex -ge 0 -and [IO.Path]::GetFullPath([string] $Arguments[$inputIndex + 1]) -eq [IO.Path]::GetFullPath($InputPath)) 'GitHub write input path mismatch.'
    Assert-HBCondition (Test-Path -LiteralPath $InputPath -PathType Leaf) 'GitHub write input file is missing.'
    $endpoint = @($Arguments | Where-Object { $_ -match '^repos/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+/rulesets(?:/[0-9]+)?$' })
    Assert-HBCondition ($endpoint.Count -eq 1) 'GitHub write endpoint is missing or outside repository rulesets.'
    if ($method -eq 'POST') {
        Assert-HBCondition ([string] $endpoint[0] -notmatch '/[0-9]+$') 'Ruleset POST must target the collection endpoint.'
    } else {
        Assert-HBCondition ([string] $endpoint[0] -match '/[0-9]+$') 'Ruleset PUT must target one exact ruleset ID.'
    }

    # Writes are deliberately attempted exactly once. A non-zero result is
    # reconciled by a subsequent GET; it is never retried blindly.
    $output = [Collections.Generic.List[string]]::new()
    & $Executable @Arguments 2>&1 | ForEach-Object { $output.Add([string] $_) }
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        return [ordered]@{ succeeded = $false; method = $method; endpoint = [string] $endpoint[0]; exitCode = $exitCode; attempts = 1 }
    }
    try {
        $data = ($output -join "`n") | ConvertFrom-Json -AsHashtable -NoEnumerate -DateKind String
    } catch {
        return [ordered]@{ succeeded = $false; method = $method; endpoint = [string] $endpoint[0]; exitCode = 0; attempts = 1 }
    }
    return [ordered]@{ succeeded = $true; method = $method; endpoint = [string] $endpoint[0]; exitCode = 0; attempts = 1; data = $data }
}

function ConvertTo-HBLiveRulesetRecord {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][hashtable] $Detail,
        [Parameter(Mandatory)][long] $RepositoryId
    )

    Assert-HBCondition ([long] $Detail.id -gt 0) 'Live ruleset detail has no valid ID.'
    $ruleItems = @($Detail.rules)
    $copilotRules = @($ruleItems | Where-Object { [string] $_.type -eq 'copilot_code_review' })
    $record = [ordered]@{
        repositoryId = $RepositoryId
        rulesetId = [long] $Detail.id
        name = [string] $Detail.name
        sourceType = [string] $Detail.source_type
        target = [string] $Detail.target
        enforcement = [string] $Detail.enforcement
        conditionsSha256 = Get-HBObjectSha256 $Detail.conditions
        rulesSha256 = Get-HBObjectSha256 $ruleItems
        containsCopilotCodeReview = $copilotRules.Count -gt 0
        mixedPurpose = $copilotRules.Count -gt 1 -or @($ruleItems | Where-Object { [string] $_.type -ne 'copilot_code_review' }).Count -gt 0
    }
    if ($copilotRules.Count -eq 1) {
        $record.reviewDraftPullRequests = [bool] $copilotRules[0].parameters.review_draft_pull_requests
        $record.reviewOnPush = [bool] $copilotRules[0].parameters.review_on_push
    }
    $record.stateSha256 = Get-HBObjectSha256 $record
    return $record
}

function Invoke-HBGitHubPagedRead {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string[]] $Arguments)

    Assert-HBCondition ($Arguments -contains '--paginate' -and $Arguments -contains '--slurp') 'Paged GitHub read requires --paginate and --slurp.'
    $response = Invoke-HBGitHubJsonRead $Arguments
    $pages = @($response.data)
    Assert-HBCondition ($pages.Count -ge 1) "GitHub pagination returned no page envelope for $($response.endpoint)."
    $items = [Collections.Generic.List[object]]::new()
    foreach ($page in $pages) {
        Assert-HBCondition ($page -is [object[]]) "GitHub pagination page is not an array for $($response.endpoint)."
        foreach ($item in @($page)) { $items.Add($item) }
    }
    return [ordered]@{ endpoint = $response.endpoint; pages = $pages.Count; items = $items.ToArray() }
}

function ConvertTo-HBLiveBrowserEvidence {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][hashtable] $BrowserContainer,
        [Parameter(Mandatory)][hashtable[]] $Repositories
    )

    Assert-HBCondition (@($BrowserContainer.records).Count -ge 10) 'Live browser evidence requires account automation, eight effort records and manual-review availability.'
    foreach ($record in @($BrowserContainer.records)) { [void](Test-HBBrowserEvidenceBoundary $record) }
    $account = @($BrowserContainer.records | Where-Object {
        [string] $_.surface -eq 'PersonalAccountAutomation' -and [string] $_.accountOwner -ceq 'hindermath'
    })
    Assert-HBCondition ($account.Count -eq 1) 'Live browser evidence requires exactly one hindermath account-automation record.'

    $targetRepositories = @($Repositories | Where-Object { $script:CRGTargetSlugs -ccontains [string] $_.slug })
    Assert-HBCondition ($targetRepositories.Count -eq 8) 'Live inventory does not contain the exact eight target repositories.'
    $effort = @($BrowserContainer.records | Where-Object { [string] $_.surface -eq 'RepositoryEffort' })
    Assert-HBCondition ($effort.Count -eq 8) 'Live browser evidence requires exactly eight repository-effort records.'
    $expectedIds = @($targetRepositories | ForEach-Object { [long] $_.repositoryId } | Sort-Object)
    $actualIds = @($effort | ForEach-Object { [long] $_.repositoryId } | Sort-Object)
    Assert-HBCondition (Test-HBExactSet $actualIds $expectedIds) 'Browser effort identities do not equal the exact live target repository IDs.'
    $manual = @($BrowserContainer.records | Where-Object { [string] $_.surface -eq 'ManualReviewAvailability' })
    Assert-HBCondition ($manual.Count -ge 1) 'Manual-review availability browser evidence is missing.'

    $records = [Collections.Generic.List[object]]::new()
    foreach ($source in @($BrowserContainer.records)) {
        $record = [ordered]@{
            surface = [string] $source.surface
            observedState = [string] $source.observedState
            observedAt = [string] $source.observedAt
            reviewedAt = [string] $source.reviewedAt
            operatorRole = [string] $source.operatorRole
            reviewerRole = [string] $source.reviewerRole
            uiPathClass = [string] $source.uiPathClass
            evidenceSha256 = [string] $source.evidenceSha256
        }
        if ($source.Contains('repositoryId')) { $record.repositoryId = [long] $source.repositoryId }
        $records.Add($record)
    }
    return [ordered]@{
        personalAccountAutomation = [ordered]@{
            state = [string] $account[0].observedState
            evidenceMode = 'BrowserManual'
            observedAt = [string] $account[0].observedAt
            evidenceSha256 = [string] $account[0].evidenceSha256
        }
        records = $records.ToArray()
    }
}

function New-HBUnknownUsage {
    param(
        [Parameter(Mandatory)][string] $Unit,
        [Parameter(Mandatory)][string] $Source,
        [Parameter(Mandatory)][DateTimeOffset] $ObservedAt
    )
    $periodStart = [DateTimeOffset]::new($ObservedAt.Year, $ObservedAt.Month, 1, 0, 0, 0, [TimeSpan]::Zero)
    return [ordered]@{
        status = 'Unknown'
        unit = $Unit
        periodStart = $periodStart.ToString('o')
        periodEnd = $periodStart.AddMonths(1).ToString('o')
        source = $Source
        observedAt = $ObservedAt.ToString('o')
    }
}

function Invoke-HBLiveGitHubInventory {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $BrowserEvidencePath,
        [Parameter(Mandatory)][string] $OutputPath
    )

    $browserContainer = Read-HBJsonFile $BrowserEvidencePath
    $repositoryRequest = @(
        'api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)",
        '/user/repos?affiliation=owner&visibility=all&sort=full_name&direction=asc&per_page=100',
        '--paginate', '--slurp'
    )
    $repositoryPages = Invoke-HBGitHubPagedRead $repositoryRequest
    $repositories = [Collections.Generic.List[object]]::new()
    $rulesets = [Collections.Generic.List[object]]::new()
    $rulesetListPages = 0
    $rulesetDetailsRead = 0

    foreach ($summary in @($repositoryPages.items | Sort-Object { [string] $_.full_name })) {
        $slug = [string] $summary.full_name
        Assert-HBCondition ($slug -match '^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$') 'Live repository slug is invalid.'
        $metadata = (Invoke-HBGitHubJsonRead @(
            'api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)", "repos/$slug"
        )).data
        Assert-HBCondition ([long] $metadata.id -eq [long] $summary.id -and [string] $metadata.full_name -ceq $slug) "Live repository summary/detail identity drift: $slug"
        Assert-HBCondition ([string] $metadata.owner.login -ceq 'hindermath') "Live repository is not owned by hindermath: $slug"
        Assert-HBCondition ([string] $metadata.visibility -in @('public', 'private', 'internal')) "Live repository visibility is unsupported: $slug"
        $repositories.Add([ordered]@{
            repositoryId = [long] $metadata.id
            slug = $slug
            visibility = [string] $metadata.visibility
            defaultBranch = [string] $metadata.default_branch
            ownedByAccount = $true
        })

        $list = Invoke-HBGitHubPagedRead @(
            'api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)",
            "repos/$slug/rulesets?includes_parents=false&per_page=100", '--paginate', '--slurp'
        )
        $rulesetListPages += [int] $list.pages
        foreach ($rulesetSummary in @($list.items | Sort-Object { [long] $_.id })) {
            $rulesetId = [long] $rulesetSummary.id
            Assert-HBCondition ($rulesetId -gt 0) "Live ruleset ID is invalid for $slug."
            $detail = (Invoke-HBGitHubJsonRead @(
                'api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)", "repos/$slug/rulesets/$rulesetId"
            )).data
            Assert-HBCondition ([long] $detail.id -eq $rulesetId) "Live ruleset list/detail identity drift: ${slug}:${rulesetId}"
            $rulesetDetailsRead++
            $rulesets.Add((ConvertTo-HBLiveRulesetRecord $detail ([long] $metadata.id)))
        }
    }

    Assert-HBCondition ($rulesetDetailsRead -eq $rulesets.Count) 'Live ruleset page/detail count mismatch.'
    $repositoryArray = $repositories.ToArray()
    $browser = ConvertTo-HBLiveBrowserEvidence $browserContainer $repositoryArray
    $now = [DateTimeOffset]::UtcNow
    $billingSource = 'GitHub billing API unavailable to the current least-privilege credential'
    try {
        [void](Invoke-HBGitHubJsonRead @(
            'api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)",
            '/users/hindermath/settings/billing/ai_credit/usage'
        ))
        $billingSource = 'GitHub billing API response requires a separately reviewed field mapping'
    } catch {
        $billingSource = 'GitHub billing API unavailable to the current least-privilege credential'
    }
    $inventory = [ordered]@{
        schemaVersion = '1.0'
        snapshotId = [guid]::NewGuid().ToString()
        runId = '1b7788fb-81f3-4d76-8006-885d834dd454'
        observedAt = $now.ToString('o')
        expiresAt = $now.AddMinutes(15).ToString('o')
        apiVersion = $script:CRGApiVersion
        complete = $true
        sourceFresh = $true
        pagination = [ordered]@{
            repositoriesPages = [int] $repositoryPages.pages
            rulesetListPages = $rulesetListPages
            rulesetDetailsRead = $rulesetDetailsRead
            truncated = $false
        }
        billingUsage = [ordered]@{
            billingOwnerType = 'Unknown'
            aiCredits = New-HBUnknownUsage 'credits' $billingSource $now
            actionsMinutes = New-HBUnknownUsage 'minutes' $billingSource $now
        }
        personalAccountAutomation = $browser.personalAccountAutomation
        repositories = $repositoryArray
        rulesets = $rulesets.ToArray()
        browserEvidence = $browser.records
        reviewTriggers = [ordered]@{ automatic = 0; manual = 0; unknown = 0; observedAt = $now.ToString('o') }
        redactionFindings = 0
        snapshotSha256 = '0' * 64
    }
    $inventory.snapshotSha256 = Get-HBObjectSha256 $inventory @('snapshotSha256')
    [void](Test-HBInventory $inventory)
    Write-HBJsonFile $OutputPath $inventory
    $browserEvidenceSha256 = Get-HBSha256 -Bytes ([IO.File]::ReadAllBytes([IO.Path]::GetFullPath($BrowserEvidencePath)))
    return [ordered]@{
        status = 'Materialized'
        source = 'GitHubLiveReadOnly'
        inventoryPath = [IO.Path]::GetFullPath($OutputPath)
        inventorySha256 = [string] $inventory.snapshotSha256
        browserEvidenceSha256 = $browserEvidenceSha256
        repositories = $repositoryArray.Count
        rulesets = $rulesets.Count
        rulesetDetailsRead = $rulesetDetailsRead
        providerWrites = 0
        writes = 0
    }
}

function Test-HBBrowserEvidenceBoundary {
    [CmdletBinding()]
    param([Parameter(Mandatory)][hashtable] $Record)
    Assert-HBCondition ([string] $Record.evidenceMode -eq 'BrowserManual') 'Browserbeleg darf nicht durch API-Evidence ersetzt werden.'
    Assert-HBCondition ([string] $Record.surface -in @('PersonalAccountAutomation', 'RepositoryEffort', 'ManualReviewAvailability')) 'Unbekannte Browserflaeche.'
    Assert-HBCondition ([string] $Record.uiPathClass -notmatch '(?i)css|xpath|dom') 'DOM-Scraping ist keine zulaessige Evidence.'
    [void](Protect-HBRedactedValue $Record)
    return $true
}

function Read-HBInventory {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string] $Path)
    $data = Read-HBJsonFile $Path
    [void](Test-HBInventory $data)
    return $data
}

function New-HBMutationPlan {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][hashtable] $DesiredState,
        [Parameter(Mandatory)][hashtable] $Inventory,
        [string] $RunId = '1b7788fb-81f3-4d76-8006-885d834dd454'
    )

    [void](Test-HBInventory $Inventory)
    [void](Assert-HBJsonSchema $DesiredState 'desired-state')
    Assert-HBCondition ([guid]::Parse($RunId) -ne [guid]::Empty) 'RunId must be a non-zero UUID.'
    $actions = [Collections.Generic.List[object]]::new()

    function Add-PlanAction {
        param(
            [string] $Key, [string] $OperationClass, [string] $Action,
            [bool] $WriteIntent, [string] $AllowedMethod,
            [string] $BeforeSha256, [string] $DesiredSha256,
            [string] $RollbackSha256, [string] $PayloadPath,
            [string] $Rationale, [long] $RepositoryId = 0,
            [long] $RulesetId = 0, [switch] $Account
        )
        $item = [ordered]@{
            actionId = New-HBDeterministicGuid "$RunId|action|$Key"
            idempotencyId = "crg:$RunId`:$Key"
            operationClass = $OperationClass
            action = $Action
            writeIntent = $WriteIntent
            allowedMethod = $AllowedMethod
            beforeSha256 = $BeforeSha256
            desiredSha256 = $DesiredSha256
            rollbackSha256 = $RollbackSha256
            payloadPath = $PayloadPath
            rationale = $Rationale
        }
        if ($Account) { $item.accountOwner = 'hindermath' }
        else { $item.repositoryId = $RepositoryId }
        if ($RulesetId -gt 0) { $item.rulesetId = $RulesetId }
        $actions.Add($item)
    }

    $accountBefore = Get-HBObjectSha256 $Inventory.personalAccountAutomation
    $accountDesired = Get-HBObjectSha256 ([ordered]@{ accountOwner = 'hindermath'; state = 'Disabled' })
    $accountConverged = [string] $Inventory.personalAccountAutomation.state -eq 'Disabled'
    Add-PlanAction -Key 'account:hindermath' -OperationClass AccountSetting `
        -Action $(if ($accountConverged) { 'NoOp' } else { 'Update' }) `
        -WriteIntent:(-not $accountConverged) -AllowedMethod $(if ($accountConverged) { 'None' } else { 'BrowserManual' }) `
        -BeforeSha256 $accountBefore -DesiredSha256 $accountDesired -RollbackSha256 $accountBefore `
        -PayloadPath 'payloads/account-setting.json' -Rationale $(if ($accountConverged) { 'AlreadyConverged' } else { 'PersonalAccountAutomationDrift' }) -Account

    foreach ($target in @($DesiredState.targets)) {
        $repository = @($Inventory.repositories | Where-Object { [string] $_.slug -ceq [string] $target.slug })
        if ($repository.Count -ne 1 -or [string] $repository[0].defaultBranch -cne [string] $target.defaultBranch) {
            $blockedHash = Get-HBObjectSha256 ([ordered]@{ slug = [string] $target.slug; reason = 'IdentityDrift' })
            Add-PlanAction -Key "ruleset:$($target.slug)" -OperationClass RulesetUpdate -Action Blocked -WriteIntent:$false -AllowedMethod None `
                -BeforeSha256 $blockedHash -DesiredSha256 $blockedHash -RollbackSha256 $blockedHash -PayloadPath "payloads/ruleset-$($target.position).json" `
                -Rationale 'RepositoryIdentityMismatchOrDefaultBranchDrift' -RepositoryId 1 -RulesetId 1
            continue
        }
        $repo = $repository[0]
        $effort = @($Inventory.browserEvidence | Where-Object { [string] $_.surface -eq 'RepositoryEffort' -and [long] $_.repositoryId -eq [long] $repo.repositoryId })
        $effortBefore = Get-HBObjectSha256 $(if ($effort.Count -eq 1) { $effort[0] } else { [ordered]@{ repositoryId = [long] $repo.repositoryId; observedState = 'Unknown' } })
        $effortDesired = Get-HBObjectSha256 ([ordered]@{ repositoryId = [long] $repo.repositoryId; observedState = 'Lite' })
        $effortConverged = $effort.Count -eq 1 -and [string] $effort[0].observedState -eq 'Lite'
        Add-PlanAction -Key "effort:$($repo.repositoryId)" -OperationClass EffortLevel `
            -Action $(if ($effortConverged) { 'NoOp' } elseif ($effort.Count -eq 1) { 'Update' } else { 'Blocked' }) `
            -WriteIntent:($effort.Count -eq 1 -and -not $effortConverged) `
            -AllowedMethod $(if ($effortConverged -or $effort.Count -ne 1) { 'None' } else { 'BrowserManual' }) `
            -BeforeSha256 $effortBefore -DesiredSha256 $effortDesired -RollbackSha256 $effortBefore `
            -PayloadPath "payloads/effort-$($target.position).json" -Rationale $(if ($effortConverged) { 'AlreadyConverged' } elseif ($effort.Count -eq 1) { 'RepositoryEffortDrift' } else { 'RepositoryEffortEvidenceMissing' }) `
            -RepositoryId ([long] $repo.repositoryId)

        $matching = @($Inventory.rulesets | Where-Object { [long] $_.repositoryId -eq [long] $repo.repositoryId -and [bool] $_.containsCopilotCodeReview })
        if ($matching.Count -eq 0) {
            $before = Get-HBObjectSha256 ([ordered]@{ repositoryId = [long] $repo.repositoryId; missing = $true })
            $desired = Get-HBObjectSha256 ([ordered]@{ repositoryId = [long] $repo.repositoryId; enforcement = 'active'; reviewDraftPullRequests = $false; reviewOnPush = $false })
            Add-PlanAction -Key "ruleset:$($repo.repositoryId):create" -OperationClass RulesetCreate -Action Create -WriteIntent:$true -AllowedMethod POST `
                -BeforeSha256 $before -DesiredSha256 $desired -RollbackSha256 $before -PayloadPath "payloads/ruleset-$($target.position).json" `
                -Rationale 'DedicatedTargetRulesetMissing' -RepositoryId ([long] $repo.repositoryId)
            continue
        }
        $ruleset = $matching[0]
        $before = [string] $ruleset.stateSha256
        $desired = Get-HBObjectSha256 ([ordered]@{ repositoryId = [long] $repo.repositoryId; rulesetId = [long] $ruleset.rulesetId; enforcement = 'active'; reviewDraftPullRequests = $false; reviewOnPush = $false })
        $safe = $matching.Count -eq 1 -and -not [bool] $ruleset.mixedPurpose -and [string] $ruleset.sourceType -eq 'Repository'
        $converged = $safe -and [string] $ruleset.enforcement -eq 'active' -and -not [bool] $ruleset.reviewDraftPullRequests -and -not [bool] $ruleset.reviewOnPush
        Add-PlanAction -Key "ruleset:$($repo.repositoryId):$($ruleset.rulesetId)" -OperationClass RulesetUpdate `
            -Action $(if (-not $safe) { 'Blocked' } elseif ($converged) { 'NoOp' } else { 'Update' }) `
            -WriteIntent:($safe -and -not $converged) -AllowedMethod $(if ($safe -and -not $converged) { 'PUT' } else { 'None' }) `
            -BeforeSha256 $before -DesiredSha256 $desired -RollbackSha256 $before -PayloadPath "payloads/ruleset-$($target.position).json" `
            -Rationale $(if (-not $safe) { 'MixedPurposeInheritedOrDuplicateRuleset' } elseif ($converged) { 'AlreadyConverged' } else { 'TargetRulesetSettingsDrift' }) `
            -RepositoryId ([long] $repo.repositoryId) -RulesetId ([long] $ruleset.rulesetId)
    }

    $targetSlugs = @($DesiredState.targets | ForEach-Object { [string] $_.slug })
    foreach ($ruleset in @($Inventory.rulesets | Where-Object { [bool] $_.containsCopilotCodeReview -and [string] $_.enforcement -eq 'active' })) {
        $repo = @($Inventory.repositories | Where-Object { [long] $_.repositoryId -eq [long] $ruleset.repositoryId })
        if ($repo.Count -ne 1 -or $targetSlugs -contains [string] $repo[0].slug) { continue }
        $safe = [string] $ruleset.sourceType -eq 'Repository' -and -not [bool] $ruleset.mixedPurpose
        $before = [string] $ruleset.stateSha256
        $desired = Get-HBObjectSha256 ([ordered]@{ repositoryId = [long] $repo[0].repositoryId; rulesetId = [long] $ruleset.rulesetId; enforcement = 'disabled' })
        Add-PlanAction -Key "non-target:$($repo[0].repositoryId):$($ruleset.rulesetId)" -OperationClass RulesetDisable `
            -Action $(if ($safe) { 'Disable' } else { 'Blocked' }) -WriteIntent:$safe -AllowedMethod $(if ($safe) { 'PUT' } else { 'None' }) `
            -BeforeSha256 $before -DesiredSha256 $desired -RollbackSha256 $before -PayloadPath "payloads/non-target-$($ruleset.rulesetId).json" `
            -Rationale $(if ($safe) { 'DedicatedNonTargetCopilotRuleset' } else { 'UnsafeNonTargetRuleset' }) `
            -RepositoryId ([long] $repo[0].repositoryId) -RulesetId ([long] $ruleset.rulesetId)
    }

    $createdAt = [DateTimeOffset]::UtcNow
    $plan = [ordered]@{
        schemaVersion = '1.0'
        planId = New-HBDeterministicGuid "$RunId|$($DesiredState.contractSha256)|$($Inventory.snapshotSha256)"
        runId = $RunId
        desiredStateSha256 = [string] $DesiredState.contractSha256
        inventorySha256 = [string] $Inventory.snapshotSha256
        apiVersion = $script:CRGApiVersion
        createdAt = $createdAt.ToString('o')
        expiresAt = $createdAt.AddMinutes(15).ToString('o')
        actions = @($actions)
        planSha256 = ('0' * 64)
    }
    $plan.planSha256 = Get-HBObjectSha256 $plan @('planSha256')
    [void](Assert-HBJsonSchema $plan 'mutation-plan')
    return $plan
}

function Test-HBExternalWriteGate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][hashtable] $Gate,
        [string] $ExpectedOperationClass = '',
        [hashtable] $Plan = $null,
        [hashtable] $Authority = $null,
        [hashtable] $Inventory = $null
    )

    [void](Assert-HBJsonSchema $Gate 'external-write-gate')
    $operation = [string] $Gate.operationClass
    Assert-HBCondition $script:CRGOperationContracts.ContainsKey($operation) 'Unbekannte External-Write-Gate-Klasse.'
    if ($ExpectedOperationClass) { Assert-HBCondition ($operation -eq $ExpectedOperationClass) 'OperationClass stimmt nicht.' }
    Assert-HBCondition ([string] $Gate.status -eq 'Authorized') 'Gate ist nicht Authorized.'
    Assert-HBCondition ([bool] $Gate.singleUse) 'Gate muss singleUse sein.'
    $now = [DateTimeOffset]::UtcNow
    $notBefore = if ($Gate.notBefore -is [DateTime]) { [DateTimeOffset] $Gate.notBefore } elseif ($Gate.notBefore -is [DateTimeOffset]) { $Gate.notBefore } else { [DateTimeOffset]::Parse([string] $Gate.notBefore, [Globalization.CultureInfo]::InvariantCulture) }
    $expiresAt = if ($Gate.expiresAt -is [DateTime]) { [DateTimeOffset] $Gate.expiresAt } elseif ($Gate.expiresAt -is [DateTimeOffset]) { $Gate.expiresAt } else { [DateTimeOffset]::Parse([string] $Gate.expiresAt, [Globalization.CultureInfo]::InvariantCulture) }
    Assert-HBCondition ($notBefore -le $now -and $expiresAt -gt $now) 'Gate ist nicht aktuell.'
    $contract = $script:CRGOperationContracts[$operation]
    if ($operation -ne 'Rollback') {
        Assert-HBCondition (Test-HBExactSet @($Gate.allowedMethods) @($contract.Methods)) 'Gate-Methoden sind nicht minimal/exakt.'
        Assert-HBCondition (Test-HBExactSet @($Gate.minimumPermissionScopes) @($contract.Scopes)) 'Gate-Scopes sind nicht minimal/exakt.'
    }
    if ($operation -eq 'AccountSetting' -or ($operation -eq 'Rollback' -and [string] $Gate.rollbackSourceOperationClass -eq 'AccountSetting')) {
        Assert-HBCondition ([string] $Gate.accountOwner -ceq 'hindermath') 'Account-Gate muss accountOwner=hindermath binden.'
        Assert-HBCondition (@($Gate.repositoryIds).Count -eq 0 -and @($Gate.rulesetIds).Count -eq 0 -and @($Gate.pullRequestIds).Count -eq 0) 'Account-Gate darf keine Repository-, Ruleset- oder PR-IDs enthalten.'
        if ($null -ne $Authority) { Assert-HBCondition ([string] $Authority.accountOwner -ceq [string] $Gate.accountOwner) 'Authority-/Gate-accountOwner mismatch.' }
        if ($null -ne $Plan) {
            $accountActions = @($Plan.actions | Where-Object { [string] $_.operationClass -eq 'AccountSetting' })
            Assert-HBCondition ($accountActions.Count -eq 1 -and [string] $accountActions[0].accountOwner -ceq [string] $Gate.accountOwner) 'Plan-/Gate-accountOwner mismatch.'
        }
    } else {
        Assert-HBCondition (-not $Gate.ContainsKey('accountOwner')) 'Nicht-accountbezogenes Gate darf accountOwner nicht enthalten.'
    }
    if ($operation -eq 'Delivery') {
        Assert-HBCondition (@($Gate.rulesetIds).Count -eq 0) 'Delivery darf keine Ruleset-IDs enthalten.'
        Assert-HBCondition (@($Gate.allowedMethods | Where-Object { $_ -in @('POST', 'PUT', 'BrowserManual') }).Count -eq 0) 'Delivery darf keine Provider-Settings-Methode enthalten.'
    }
    if ($null -ne $Plan) {
        [void](Assert-HBJsonSchema $Plan 'mutation-plan')
        Assert-HBCondition ([string] $Plan.planSha256 -eq (Get-HBObjectSha256 $Plan @('planSha256'))) 'Plan hash mismatch.'
        Assert-HBCondition ([string] $Gate.runId -eq [string] $Plan.runId) 'Gate/Plan run identity mismatch.'
        Assert-HBCondition ([string] $Gate.planSha256 -eq [string] $Plan.planSha256) 'Gate/Plan hash mismatch.'
        Assert-HBCondition ([string] $Gate.snapshotSha256 -eq [string] $Plan.inventorySha256) 'Gate snapshot does not bind the plan inventory.'
        $selected = @($Plan.actions | Where-Object { @($Gate.allowedActionIds) -contains [string] $_.actionId })
        Assert-HBCondition ($selected.Count -eq @($Gate.allowedActionIds).Count) 'Gate contains unknown or duplicate action IDs.'
        if ($operation -ne 'Rollback') {
            Assert-HBCondition (@($selected | Where-Object { [string] $_.operationClass -ne $operation }).Count -eq 0) 'Gate action class mismatch.'
        }
        $selectedRepositories = @($selected | Where-Object { $_.ContainsKey('repositoryId') } | ForEach-Object { [long] $_.repositoryId } | Sort-Object -Unique)
        $selectedRulesets = @($selected | Where-Object { $_.ContainsKey('rulesetId') } | ForEach-Object { [long] $_.rulesetId } | Sort-Object -Unique)
        if ($operation -ne 'Rollback') {
            Assert-HBCondition (Test-HBExactSet @($Gate.repositoryIds | Sort-Object) $selectedRepositories) 'Gate repository identity set does not match the plan.'
            Assert-HBCondition (Test-HBExactSet @($Gate.rulesetIds | Sort-Object) $selectedRulesets) 'Gate ruleset identity set does not match the plan.'
        }
        foreach ($action in $selected) {
            $key = [string] $action.actionId
            Assert-HBCondition ($Gate.beforeStateHashes.ContainsKey($key) -and [string] $Gate.beforeStateHashes[$key] -eq [string] $action.beforeSha256) 'Gate before-state binding mismatch.'
            Assert-HBCondition ($Gate.desiredStateHashes.ContainsKey($key) -and [string] $Gate.desiredStateHashes[$key] -eq [string] $action.desiredSha256) 'Gate desired-state binding mismatch.'
            Assert-HBCondition ($Gate.rollbackHashes.ContainsKey($key) -and [string] $Gate.rollbackHashes[$key] -eq [string] $action.rollbackSha256) 'Gate rollback binding mismatch.'
        }
        Assert-HBCondition (Test-HBExactSet @($Gate.beforeStateHashes.Keys | Sort-Object) @($Gate.allowedActionIds | Sort-Object)) 'Gate before-state map is not closed-world.'
        Assert-HBCondition (Test-HBExactSet @($Gate.desiredStateHashes.Keys | Sort-Object) @($Gate.allowedActionIds | Sort-Object)) 'Gate desired-state map is not closed-world.'
        Assert-HBCondition (Test-HBExactSet @($Gate.rollbackHashes.Keys | Sort-Object) @($Gate.allowedActionIds | Sort-Object)) 'Gate rollback map is not closed-world.'
    }
    if ($null -ne $Inventory) {
        [void](Test-HBInventory $Inventory)
        Assert-HBCondition ([string] $Gate.snapshotSha256 -eq [string] $Inventory.snapshotSha256) 'Gate inventory snapshot mismatch.'
        $age = ([DateTimeOffset]::UtcNow - (ConvertTo-HBDateTimeOffset $Inventory.observedAt)).TotalSeconds
        Assert-HBCondition ($age -ge 0 -and $age -le [int] $Gate.maximumSnapshotAgeSeconds) 'Gate snapshot is stale.'
    }
    if ($null -ne $Authority) {
        Assert-HBCondition ([string] $Authority.authorityRecordId -eq [string] $Gate.authorityRecordId) 'Authority record identity mismatch.'
        Assert-HBCondition ([string] $Gate.authoritySha256 -eq (Get-HBObjectSha256 $Authority)) 'Authority record hash mismatch.'
    }
    return $true
}

function Read-HBExternalWriteContext {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $EvidenceRoot,
        [Parameter(Mandatory)][hashtable] $Gate,
        [Parameter(Mandatory)][hashtable] $Plan,
        [Parameter(Mandatory)][hashtable] $Inventory
    )

    Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($EvidenceRoot)) 'AUTORITAET_BLOCKIERT: EvidenceRoot is required.'
    $paths = [ordered]@{
        authority = 'operational/live-read/authority.json'
        inventory = 'operational/live-read/inventory.json'
        plan = 'operational/live-read/mutation-plan.json'
        changeReview = 'operational/live-read/change-set-review.json'
        acceptance = 'operational/gate-evidence/acceptance.json'
        security = 'operational/gate-evidence/security.json'
        review = 'operational/gate-evidence/review.json'
        technical = 'operational/gate-evidence/technical.json'
    }
    $records = [ordered]@{}
    foreach ($name in $paths.Keys) {
        $resolved = Resolve-HBSafePath $EvidenceRoot $paths[$name]
        $records[$name] = Read-HBJsonFile $resolved
    }

    $authorityKeys = @('accountOwner', 'allowedMethods', 'authorityRecordId', 'expiresAt', 'issuedAt', 'minimumPermissionScopes', 'operationClasses', 'operatorIdentity', 'reviewerIdentity', 'schemaVersion', 'status')
    Assert-HBCondition (Test-HBExactSet @($records.authority.Keys | Sort-Object) $authorityKeys) 'AUTORITAET_BLOCKIERT: Authority schema is incomplete or contains unknown fields.'
    Assert-HBCondition ([string] $records.authority.schemaVersion -eq '1.0' -and [string] $records.authority.status -eq 'Authorized') 'AUTORITAET_BLOCKIERT: Authority is not current and Authorized.'
    Assert-HBCondition ([string] $records.authority.accountOwner -ceq 'hindermath') 'AUTORITAET_BLOCKIERT: Authority account identity mismatch.'
    Assert-HBCondition ([string] $records.authority.operatorIdentity -match '^operator:[A-Za-z0-9._-]+$' -and [string] $records.authority.reviewerIdentity -match '^reviewer:[A-Za-z0-9._-]+$') 'AUTORITAET_BLOCKIERT: Authority operator/reviewer identity is invalid.'
    $now = [DateTimeOffset]::UtcNow
    $issuedAt = ConvertTo-HBDateTimeOffset $records.authority.issuedAt
    $authorityExpires = ConvertTo-HBDateTimeOffset $records.authority.expiresAt
    Assert-HBCondition ($issuedAt -le $now -and $authorityExpires -gt $now) 'AUTORITAET_BLOCKIERT: Authority freshness window is invalid.'
    Assert-HBCondition (@($records.authority.operationClasses) -contains [string] $Gate.operationClass) 'AUTORITAET_BLOCKIERT: Authority operation scope mismatch.'
    Assert-HBCondition (Test-HBExactSet @($records.authority.allowedMethods) @($Gate.allowedMethods)) 'AUTORITAET_BLOCKIERT: Authority method scope mismatch.'
    Assert-HBCondition (Test-HBExactSet @($records.authority.minimumPermissionScopes) @($Gate.minimumPermissionScopes)) 'AUTORITAET_BLOCKIERT: Authority permission scope mismatch.'
    Assert-HBCondition ([string] $Gate.authorityRecordId -eq [string] $records.authority.authorityRecordId) 'AUTORITAET_BLOCKIERT: Authority record identity mismatch.'
    Assert-HBCondition ([string] $Gate.authoritySha256 -eq (Get-HBObjectSha256 $records.authority)) 'AUTORITAET_BLOCKIERT: Authority record hash mismatch.'

    [void](Test-HBInventory $records.inventory)
    [void](Assert-HBJsonSchema $records.plan 'mutation-plan')
    Assert-HBCondition ([string] $records.plan.planSha256 -eq (Get-HBObjectSha256 $records.plan @('planSha256'))) 'AUTORITAET_BLOCKIERT: Evidence plan hash mismatch.'
    Assert-HBCondition ((Get-HBObjectSha256 $records.inventory) -eq (Get-HBObjectSha256 $Inventory)) 'AUTORITAET_BLOCKIERT: InventoryPath is not the current EvidenceRoot inventory.'
    Assert-HBCondition ((Get-HBObjectSha256 $records.plan) -eq (Get-HBObjectSha256 $Plan)) 'AUTORITAET_BLOCKIERT: PlanPath is not the current EvidenceRoot plan.'

    $reviewKeys = @(
        'accountOwner', 'actionSummary', 'apiBoundary', 'authorityRecordId',
        'browserBoundary', 'desiredStateSha256', 'evidence', 'expiresAt',
        'externalWriteGateStatus', 'historicalDeviationReview',
        'inventorySha256', 'operatorIdentity', 'planSha256', 'reviewedAt',
        'reviewerIdentity', 'rollbackReview', 'schemaVersion', 'status', 'writes'
    )
    Assert-HBCondition (Test-HBExactSet @($records.changeReview.Keys | Sort-Object) $reviewKeys) 'AUTORITAET_BLOCKIERT: Change-set review schema is incomplete or contains unknown fields.'
    Assert-HBCondition ([string] $records.changeReview.schemaVersion -eq '1.0' -and [string] $records.changeReview.status -eq 'Accepted') 'AUTORITAET_BLOCKIERT: Change-set review is not Accepted.'
    Assert-HBCondition ([string] $records.changeReview.accountOwner -ceq [string] $records.authority.accountOwner -and [string] $records.changeReview.authorityRecordId -eq [string] $records.authority.authorityRecordId) 'AUTORITAET_BLOCKIERT: Review authority identity mismatch.'
    Assert-HBCondition ([string] $records.changeReview.inventorySha256 -eq [string] $Inventory.snapshotSha256 -and [string] $records.changeReview.planSha256 -eq [string] $Plan.planSha256 -and [string] $records.changeReview.desiredStateSha256 -eq [string] $Plan.desiredStateSha256) 'AUTORITAET_BLOCKIERT: Review inventory/plan/desired graph mismatch.'
    Assert-HBCondition ([string] $records.changeReview.operatorIdentity -eq [string] $records.authority.operatorIdentity -and [string] $records.changeReview.reviewerIdentity -eq [string] $records.authority.reviewerIdentity) 'AUTORITAET_BLOCKIERT: Review operator/reviewer identity mismatch.'
    Assert-HBCondition ((ConvertTo-HBDateTimeOffset $records.changeReview.reviewedAt) -le $now -and (ConvertTo-HBDateTimeOffset $records.changeReview.expiresAt) -gt $now) 'AUTORITAET_BLOCKIERT: Change-set review freshness window is invalid.'
    Assert-HBCondition ([string] $records.changeReview.externalWriteGateStatus -eq 'NotAuthorized' -and [int] $records.changeReview.writes -eq 0) 'AUTORITAET_BLOCKIERT: Change-set review must grant no external write authority.'

    $planActions = @($Plan.actions)
    $writeActions = @($planActions | Where-Object { [bool] $_.writeIntent })
    $actionSummary = $records.changeReview.actionSummary
    $actionSummaryKeys = @('accountSettingActions', 'effortLevelActions', 'rulesetCreateActions', 'rulesetDisableActions', 'rulesetUpdateActions', 'totalActions', 'totalWrites')
    Assert-HBCondition (Test-HBExactSet @($actionSummary.Keys | Sort-Object) $actionSummaryKeys) 'AUTORITAET_BLOCKIERT: Change-set action summary schema mismatch.'
    foreach ($operationClass in @('AccountSetting', 'EffortLevel', 'RulesetCreate', 'RulesetUpdate', 'RulesetDisable')) {
        $field = $operationClass.Substring(0, 1).ToLowerInvariant() + $operationClass.Substring(1) + 'Actions'
        Assert-HBCondition ([int] $actionSummary[$field] -eq @($planActions | Where-Object { [string] $_.operationClass -eq $operationClass }).Count) "AUTORITAET_BLOCKIERT: Change-set action count mismatch for $operationClass."
    }
    Assert-HBCondition ([int] $actionSummary.totalActions -eq $planActions.Count -and [int] $actionSummary.totalWrites -eq $writeActions.Count) 'AUTORITAET_BLOCKIERT: Change-set total action/write count mismatch.'

    $browserBoundary = $records.changeReview.browserBoundary
    Assert-HBCondition (Test-HBExactSet @($browserBoundary.Keys | Sort-Object) @('evidenceMode', 'records', 'writes')) 'AUTORITAET_BLOCKIERT: Browser boundary schema mismatch.'
    Assert-HBCondition ([string] $browserBoundary.evidenceMode -eq 'BrowserManual' -and [int] $browserBoundary.records -eq @($Inventory.browserEvidence).Count -and [int] $browserBoundary.writes -eq 0) 'AUTORITAET_BLOCKIERT: Browser boundary semantics mismatch.'

    $apiBoundary = $records.changeReview.apiBoundary
    Assert-HBCondition (Test-HBExactSet @($apiBoundary.Keys | Sort-Object) @('apiVersion', 'host', 'method', 'repositories', 'rulesets', 'writes')) 'AUTORITAET_BLOCKIERT: API boundary schema mismatch.'
    Assert-HBCondition ([string] $apiBoundary.host -eq 'github.com' -and [string] $apiBoundary.apiVersion -eq [string] $Plan.apiVersion -and [string] $apiBoundary.method -eq 'GET' -and [int] $apiBoundary.repositories -eq @($Inventory.repositories).Count -and [int] $apiBoundary.rulesets -eq @($Inventory.rulesets).Count -and [int] $apiBoundary.writes -eq 0) 'AUTORITAET_BLOCKIERT: API boundary semantics mismatch.'

    $targetRepositoryIds = @($planActions | Where-Object { [string] $_.operationClass -eq 'EffortLevel' } | ForEach-Object { [long] $_.repositoryId } | Sort-Object)
    $activeCopilotRulesets = @($Inventory.rulesets | Where-Object { [bool] $_.containsCopilotCodeReview -and [string] $_.enforcement -eq 'active' })
    $historical = $records.changeReview.historicalDeviationReview
    $historicalKeys = @('activeCopilotRulesets', 'dedicatedNonTargetActiveRulesets', 'mixedOrInheritedRulesets', 'status', 'targetExistingRulesets', 'targetMissingRulesets')
    Assert-HBCondition (Test-HBExactSet @($historical.Keys | Sort-Object) $historicalKeys) 'AUTORITAET_BLOCKIERT: Historical deviation review schema mismatch.'
    Assert-HBCondition ([string] $historical.status -eq 'Accepted') 'AUTORITAET_BLOCKIERT: Historical deviation review is not Accepted.'
    Assert-HBCondition ([int] $historical.activeCopilotRulesets -eq $activeCopilotRulesets.Count) 'AUTORITAET_BLOCKIERT: Active Copilot ruleset count mismatch.'
    Assert-HBCondition ([int] $historical.targetExistingRulesets -eq @($activeCopilotRulesets | Where-Object { $targetRepositoryIds -contains [long] $_.repositoryId }).Count) 'AUTORITAET_BLOCKIERT: Existing target ruleset count mismatch.'
    Assert-HBCondition ([int] $historical.targetMissingRulesets -eq @($planActions | Where-Object { [string] $_.operationClass -eq 'RulesetCreate' -and [bool] $_.writeIntent }).Count) 'AUTORITAET_BLOCKIERT: Missing target ruleset count mismatch.'
    Assert-HBCondition ([int] $historical.dedicatedNonTargetActiveRulesets -eq @($planActions | Where-Object { [string] $_.operationClass -eq 'RulesetDisable' -and [bool] $_.writeIntent }).Count) 'AUTORITAET_BLOCKIERT: Non-target ruleset count mismatch.'
    Assert-HBCondition ([int] $historical.mixedOrInheritedRulesets -eq @($activeCopilotRulesets | Where-Object { [bool] $_.mixedPurpose -or [string] $_.sourceType -ne 'Repository' }).Count) 'AUTORITAET_BLOCKIERT: Mixed/inherited ruleset count mismatch.'

    $rollback = $records.changeReview.rollbackReview
    Assert-HBCondition (Test-HBExactSet @($rollback.Keys | Sort-Object) @('boundRollbackHashes', 'createRollbackDisposition', 'deleteActions', 'status')) 'AUTORITAET_BLOCKIERT: Rollback review schema mismatch.'
    Assert-HBCondition ([string] $rollback.status -eq 'Accepted' -and [int] $rollback.boundRollbackHashes -eq $writeActions.Count -and [int] $rollback.deleteActions -eq @($planActions | Where-Object { [string] $_.action -eq 'Delete' }).Count -and [string] $rollback.createRollbackDisposition -eq 'DisableNotDelete') 'AUTORITAET_BLOCKIERT: Rollback review semantics mismatch.'

    $evidenceHashes = [ordered]@{
        acceptance = 'acceptanceEvidenceSha256'
        security = 'securityEvidenceSha256'
        review = 'reviewEvidenceSha256'
        technical = 'technicalGateEvidenceSha256'
    }
    foreach ($name in $evidenceHashes.Keys) {
        $record = $records[$name]
        $expectedClass = (Get-Culture).TextInfo.ToTitleCase($name)
        $evidenceKeys = @('evidenceClass', 'expiresAt', 'inventorySha256', 'observedAt', 'operatorIdentity', 'planSha256', 'reviewerIdentity', 'runId', 'schemaVersion', 'status', 'writes')
        Assert-HBCondition (Test-HBExactSet @($record.Keys | Sort-Object) $evidenceKeys) "AUTORITAET_BLOCKIERT: $expectedClass evidence schema is incomplete or contains unknown fields."
        Assert-HBCondition ([string] $record.schemaVersion -eq '1.0' -and [string] $record.evidenceClass -eq $expectedClass -and [string] $record.status -eq 'Passed' -and [int] $record.writes -eq 0) "AUTORITAET_BLOCKIERT: $expectedClass evidence semantics are invalid."
        Assert-HBCondition ([string] $record.runId -eq [string] $Plan.runId -and [string] $record.inventorySha256 -eq [string] $Inventory.snapshotSha256 -and [string] $record.planSha256 -eq [string] $Plan.planSha256) "AUTORITAET_BLOCKIERT: $expectedClass evidence graph mismatch."
        Assert-HBCondition ([string] $record.operatorIdentity -eq [string] $records.authority.operatorIdentity -and [string] $record.reviewerIdentity -eq [string] $records.authority.reviewerIdentity) "AUTORITAET_BLOCKIERT: $expectedClass evidence identity mismatch."
        Assert-HBCondition ((ConvertTo-HBDateTimeOffset $record.observedAt) -le $now -and (ConvertTo-HBDateTimeOffset $record.expiresAt) -gt $now) "AUTORITAET_BLOCKIERT: $expectedClass evidence is stale."
        $relative = $paths[$name]
        Assert-HBCondition ($records.changeReview.evidence.ContainsKey($name)) "AUTORITAET_BLOCKIERT: Review lacks $name evidence reference."
        Assert-HBCondition ([string] $records.changeReview.evidence[$name].path -eq $relative) "AUTORITAET_BLOCKIERT: Review $name evidence path mismatch."
        $actualHash = Get-HBSha256 -Bytes ([IO.File]::ReadAllBytes((Resolve-HBSafePath $EvidenceRoot $relative)))
        Assert-HBCondition ([string] $records.changeReview.evidence[$name].sha256 -eq $actualHash) "AUTORITAET_BLOCKIERT: Review $name evidence hash mismatch."
        Assert-HBCondition ([string] $Gate[$evidenceHashes[$name]] -eq $actualHash) "AUTORITAET_BLOCKIERT: Gate $name evidence hash mismatch."
    }
    return $records
}

function New-HBRulesetOperation {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][ValidateSet('RulesetCreate', 'RulesetUpdate', 'RulesetDisable')][string] $OperationClass,
        [Parameter(Mandatory)][string] $RepositorySlug,
        [long] $RepositoryId,
        [long] $RulesetId,
        [Parameter(Mandatory)][string] $PayloadPath,
        [Parameter(Mandatory)][string] $BeforeSha256,
        [Parameter(Mandatory)][string] $IdempotencyId
    )

    Assert-HBCondition ($RepositorySlug -match '^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$') 'Repository-Slug ist ungueltig.'
    Assert-HBCondition ($RepositoryId -gt 0) 'Repository-ID fehlt.'
    Assert-HBCondition ($BeforeSha256 -match '^[0-9a-f]{64}$') 'Before-Hash ist ungueltig.'
    Assert-HBCondition (-not [IO.Path]::IsPathRooted($PayloadPath) -and $PayloadPath -notmatch '(^|[\\/])\.\.([\\/]|$)') 'Payload-Pfad ist unsicher.'
    if ($OperationClass -ne 'RulesetCreate') { Assert-HBCondition ($RulesetId -gt 0) 'Exakte Ruleset-ID fehlt.' }
    $method = if ($OperationClass -eq 'RulesetCreate') { 'POST' } else { 'PUT' }
    $endpoint = if ($OperationClass -eq 'RulesetCreate') { "repos/$RepositorySlug/rulesets" } else { "repos/$RepositorySlug/rulesets/$RulesetId" }
    return [ordered]@{
        operationClass = $OperationClass
        repositoryId = $RepositoryId
        rulesetId = if ($RulesetId -gt 0) { $RulesetId } else { $null }
        method = $method
        arguments = @('api', '--method', $method, $endpoint, '--input', $PayloadPath)
        beforeSha256 = $BeforeSha256
        idempotencyId = $IdempotencyId
        blindWriteRetries = 0
        reconciliation = 'ReadExactIdentityBeforeRetry'
    }
}

function Test-HBAccountPreWriteRecordSet {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][hashtable] $Authority,
        [Parameter(Mandatory)][hashtable] $PlanAction,
        [Parameter(Mandatory)][hashtable] $Gate,
        [Parameter(Mandatory)][hashtable] $ResultEnvelope,
        [Parameter(Mandatory)][hashtable] $Rollback
    )
    $resultKeys = @('accountOwner', 'actionId', 'gateSha256', 'planSha256', 'schemaVersion', 'status', 'writes')
    Assert-HBCondition (Test-HBExactSet @($ResultEnvelope.Keys | Sort-Object) $resultKeys) 'AUTORITAET_BLOCKIERT: Account NotInvoked result envelope schema mismatch.'
    [void](Assert-HBJsonSchema $Rollback 'rollback')
    $owners = @($Authority.accountOwner, $PlanAction.accountOwner, $Gate.accountOwner, $ResultEnvelope.accountOwner, $Rollback.accountOwner)
    Assert-HBCondition ($owners.Count -eq 5 -and @($owners | Where-Object { [string] $_ -cne 'hindermath' }).Count -eq 0) 'AUTORITAET_BLOCKIERT: Accountidentitaet stimmt vor dem Write nicht exakt ueberein.'
    Assert-HBCondition ([string] $ResultEnvelope.status -eq 'NotInvoked') 'AUTORITAET_BLOCKIERT: Result-Envelope muss vor dem Write NotInvoked sein.'
    Assert-HBCondition ([int] $ResultEnvelope.writes -eq 0) 'AUTORITAET_BLOCKIERT: NotInvoked result envelope must have writes=0.'
    Assert-HBCondition ([string] $ResultEnvelope.actionId -eq [string] $PlanAction.actionId -and [string] $Rollback.sourceActionId -eq [string] $PlanAction.actionId) 'AUTORITAET_BLOCKIERT: Account action identity mismatch.'
    Assert-HBCondition ([string] $ResultEnvelope.planSha256 -eq [string] $Gate.planSha256 -and [string] $ResultEnvelope.gateSha256 -eq (Get-HBObjectSha256 $Gate)) 'AUTORITAET_BLOCKIERT: Account result plan/gate hash mismatch.'
    Assert-HBCondition ([string] $Rollback.runId -eq [string] $Gate.runId -and [string] $Rollback.sourceOperationClass -eq 'AccountSetting' -and [string] $Rollback.targetKind -eq 'Account') 'AUTORITAET_BLOCKIERT: Account rollback identity mismatch.'
    Assert-HBCondition ([string] $Rollback.beforeSha256 -eq [string] $PlanAction.beforeSha256 -and [string] $Rollback.failedAfterSha256 -eq [string] $PlanAction.desiredSha256 -and [string] $Rollback.rollbackDesiredSha256 -eq [string] $PlanAction.rollbackSha256) 'AUTORITAET_BLOCKIERT: Account rollback hashes mismatch.'
    Assert-HBCondition (@($Gate.repositoryIds).Count -eq 0 -and @($Gate.rulesetIds).Count -eq 0 -and @($Gate.pullRequestIds).Count -eq 0) 'AUTORITAET_BLOCKIERT: Account-Gate enthaelt fremde IDs.'
    return $true
}

function Test-HBRollbackContract {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][hashtable] $Rollback,
        [Parameter(Mandatory)][string] $CurrentStateSha256
    )
    [void](Assert-HBJsonSchema $Rollback 'rollback')
    Assert-HBCondition ([string] $Rollback.rollbackSha256 -eq (Get-HBObjectSha256 $Rollback @('rollbackSha256'))) 'Rollback hash mismatch.'
    Assert-HBCondition ([string] $Rollback.failedAfterSha256 -eq $CurrentStateSha256) 'Rollback blockiert wegen After-State-Drift.'
    Assert-HBCondition ([string] $Rollback.sourceOperationClass -in @('AccountSetting', 'EffortLevel', 'RulesetCreate', 'RulesetUpdate', 'RulesetDisable', 'PRLifecycleAcceptance', 'ManualReviewAcceptance', 'Delivery')) 'Rollback-Quellklasse ist ungueltig.'
    if ([string] $Rollback.sourceOperationClass -eq 'AccountSetting') {
        Assert-HBCondition ([string] $Rollback.accountOwner -ceq 'hindermath') 'Account-Rollback muss hindermath binden.'
    } else {
        Assert-HBCondition ($Rollback.repositoryId -gt 0) 'Repository-Rollback benoetigt eine exakte Repository-ID.'
    }
    return $true
}

function Compare-HBReviewGateMap {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][hashtable] $Before,
        [Parameter(Mandatory)][hashtable] $After
    )
    foreach ($name in @('humanApproval', 'statusChecks', 'security', 'branchProtection')) {
        Assert-HBCondition ([bool] $Before[$name] -eq [bool] $After[$name]) "Bestehendes Review-Gate wurde veraendert: $name"
    }
    Assert-HBCondition (-not [bool] $After.copilotRequiredAlone) 'Copilot darf nie allein Required sein.'
    return [ordered]@{ status = 'Preserved'; copilotAdvisoryOnly = $true }
}

function Protect-HBRedactedValue {
    [CmdletBinding()]
    param([Parameter(Mandatory)] $Value)

    $text = ConvertTo-HBCanonicalJson $Value
    $patterns = @(
        '(?i)authorization\s*[:=]', '(?i)cookie\s*[:=]', 'gh[pousr]_[A-Za-z0-9_]+',
        'sk-[A-Za-z0-9_-]+', '(?i)(token|secret|password)\s*[:=]\s*[^,}\s]+',
        '/Users/[^/\s]+/', '[A-Za-z]:\\Users\\[^\\\s]+\\',
        '(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b', '(?i)<html'
    )
    foreach ($pattern in $patterns) { Assert-HBCondition ($text -notmatch $pattern) 'Sensitive content must be redacted before hashing or publication.' }
    return $Value
}

function Publish-HBEvidence {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $EvidenceRoot,
        [Parameter(Mandatory)][string] $RelativePath,
        [Parameter(Mandatory)] $Value
    )

    [void](Protect-HBRedactedValue $Value)
    [void](New-Item -ItemType Directory -Path $EvidenceRoot -Force)
    $target = Resolve-HBSafePath $EvidenceRoot $RelativePath -AllowMissingLeaf
    [void](New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force)
    $temporary = "$target.tmp.$PID"
    try {
        [IO.File]::WriteAllText($temporary, (ConvertTo-HBCanonicalJson $Value), [Text.UTF8Encoding]::new($false))
        if (-not $IsWindows) { [IO.File]::SetUnixFileMode($temporary, [IO.UnixFileMode]::UserRead -bor [IO.UnixFileMode]::UserWrite) }
        Move-Item -LiteralPath $temporary -Destination $target -Force
    } finally { Remove-Item -LiteralPath $temporary -Force -ErrorAction SilentlyContinue }
    return [ordered]@{ path = $RelativePath.Replace('\\', '/'); sha256 = Get-HBSha256 -Bytes ([IO.File]::ReadAllBytes($target)); classification = 'MachineLocalRestricted' }
}

function Get-HBPrLifecycleDecision {
    [CmdletBinding()]
    param([Parameter(Mandatory)][object[]] $Events)
    $qualified = $false
    $automatic = 0
    foreach ($lifecycleEvent in $Events) {
        switch ([string] $lifecycleEvent.type) {
            'OpenedReady' { if (-not $qualified) { $qualified = $true; $automatic++ } }
            'DraftToReady' { if (-not $qualified) { $qualified = $true; $automatic++ } }
            'Draft' { }
            'Push' { }
            'ReadyAgain' { }
            default { throw "Unknown PR lifecycle event: $($lifecycleEvent.type)" }
        }
    }
    return [ordered]@{ automaticReviews = $automatic; draftReviews = 0; pushRereviews = 0; effort = 'Lite' }
}

function Get-HBUsageReport {
    [CmdletBinding()]
    param([Parameter(Mandatory)][hashtable] $Inventory)
    [void](Test-HBInventory $Inventory)
    return [ordered]@{
        aiCredits = $Inventory.billingUsage.aiCredits
        actionsMinutes = $Inventory.billingUsage.actionsMinutes
        reviewTriggers = [ordered]@{ automatic = [int] $Inventory.reviewTriggers.automatic; manual = [int] $Inventory.reviewTriggers.manual; unknown = [int] $Inventory.reviewTriggers.unknown }
        workflowPath = 'dynamic/agents/copilot-pull-request-reviewer'
        fixedPriceClaims = $false
    }
}

function Format-HBLinearDecision {
    [CmdletBinding()]
    param([Parameter(Mandatory)] $Decision)
    return "Repository: $($Decision.slug) -> Default Branch: $($Decision.defaultBranch) -> Zustand / State: $($Decision.state) -> geplante Aktion / planned action: $($Decision.action) -> Ergebnis / result: $($Decision.result) -> Blocker: $($Decision.blocker) -> naechste sichere Aktion / next safe action: $($Decision.nextSafeAction)"
}

function Read-HBFakeProvider {
    param([Parameter(Mandatory)][string] $Path)
    $provider = Read-HBJsonFile $Path
    $expected = @('actionStateHashes', 'ambiguousActionIds', 'beforeStates', 'consumedGateIds', 'idempotencyIds', 'inventory', 'provider', 'schemaVersion', 'toctouActionIds', 'transactions', 'transientReadFailures')
    Assert-HBCondition (Test-HBExactSet @($provider.Keys | Sort-Object) $expected) 'Fake provider has missing or unknown fields.'
    Assert-HBCondition ([string] $provider.schemaVersion -eq '1.0' -and [string] $provider.provider -eq 'FakeProvider') 'Only the bounded FakeProvider transaction engine is accepted.'
    [void](Test-HBInventory $provider.inventory)
    return $provider
}

function Copy-HBValue {
    param([Parameter(Mandatory)] $Value)
    return (ConvertTo-HBCanonicalJson $Value) | ConvertFrom-Json -AsHashtable -DateKind String
}

function Set-HBFakeInventoryActionState {
    param(
        [Parameter(Mandatory)][hashtable] $Provider,
        [Parameter(Mandatory)][hashtable] $Action
    )

    $actionId = [string] $Action.actionId
    switch ([string] $Action.operationClass) {
        'AccountSetting' {
            $Provider.beforeStates[$actionId] = [ordered]@{ kind = 'AccountSetting'; value = Copy-HBValue $Provider.inventory.personalAccountAutomation }
            $Provider.inventory.personalAccountAutomation.state = 'Disabled'
        }
        'EffortLevel' {
            $matchingIndexes = @(0..($Provider.inventory.browserEvidence.Count - 1) | Where-Object {
                [string] $Provider.inventory.browserEvidence[$_].surface -eq 'RepositoryEffort' -and [long] $Provider.inventory.browserEvidence[$_].repositoryId -eq [long] $Action.repositoryId
            })
            Assert-HBCondition ($matchingIndexes.Count -eq 1) 'Drift: exact RepositoryEffort record is missing.'
            $index = [int] $matchingIndexes[0]
            $Provider.beforeStates[$actionId] = [ordered]@{ kind = 'EffortLevel'; index = $index; value = Copy-HBValue $Provider.inventory.browserEvidence[$index] }
            $Provider.inventory.browserEvidence[$index].observedState = 'Lite'
        }
        'RulesetCreate' {
            $maximum = @($Provider.inventory.rulesets | ForEach-Object { [long] $_.rulesetId } | Measure-Object -Maximum).Maximum
            $createdRulesetId = if ($null -eq $maximum) { 1 } else { [long] $maximum + 1 }
            $Provider.beforeStates[$actionId] = [ordered]@{ kind = 'RulesetCreate'; createdRulesetId = $createdRulesetId }
            $Provider.inventory.rulesets += [ordered]@{
                repositoryId = [long] $Action.repositoryId
                rulesetId = $createdRulesetId
                name = 'Copilot Lite'
                sourceType = 'Repository'
                target = 'branch'
                enforcement = 'active'
                conditionsSha256 = [string] $Action.desiredSha256
                rulesSha256 = [string] $Action.desiredSha256
                containsCopilotCodeReview = $true
                mixedPurpose = $false
                reviewDraftPullRequests = $false
                reviewOnPush = $false
                stateSha256 = [string] $Action.desiredSha256
            }
            return $createdRulesetId
        }
        { $_ -in @('RulesetUpdate', 'RulesetDisable') } {
            $matchingIndexes = @(0..($Provider.inventory.rulesets.Count - 1) | Where-Object {
                [long] $Provider.inventory.rulesets[$_].repositoryId -eq [long] $Action.repositoryId -and [long] $Provider.inventory.rulesets[$_].rulesetId -eq [long] $Action.rulesetId
            })
            Assert-HBCondition ($matchingIndexes.Count -eq 1) 'Drift: exact Ruleset record is missing.'
            $index = [int] $matchingIndexes[0]
            $Provider.beforeStates[$actionId] = [ordered]@{ kind = [string] $Action.operationClass; index = $index; value = Copy-HBValue $Provider.inventory.rulesets[$index] }
            if ([string] $Action.operationClass -eq 'RulesetDisable') {
                $Provider.inventory.rulesets[$index].enforcement = 'disabled'
            } else {
                $Provider.inventory.rulesets[$index].enforcement = 'active'
                $Provider.inventory.rulesets[$index].reviewDraftPullRequests = $false
                $Provider.inventory.rulesets[$index].reviewOnPush = $false
            }
            $Provider.inventory.rulesets[$index].stateSha256 = [string] $Action.desiredSha256
        }
        default { throw "Unsupported bounded FakeProvider operation: $($Action.operationClass)" }
    }
    return 0
}

function Restore-HBFakeInventoryActionState {
    param(
        [Parameter(Mandatory)][hashtable] $Provider,
        [Parameter(Mandatory)][hashtable] $Rollback
    )
    $actionId = [string] $Rollback.sourceActionId
    Assert-HBCondition ($Provider.beforeStates.ContainsKey($actionId)) 'Drift: bound before state is missing for rollback.'
    $before = $Provider.beforeStates[$actionId]
    switch ([string] $before.kind) {
        'AccountSetting' { $Provider.inventory.personalAccountAutomation = Copy-HBValue $before.value }
        'EffortLevel' { $Provider.inventory.browserEvidence[[int] $before.index] = Copy-HBValue $before.value }
        'RulesetUpdate' { $Provider.inventory.rulesets[[int] $before.index] = Copy-HBValue $before.value }
        'RulesetDisable' { $Provider.inventory.rulesets[[int] $before.index] = Copy-HBValue $before.value }
        'RulesetCreate' {
            $created = @($Provider.inventory.rulesets | Where-Object { [long] $_.rulesetId -eq [long] $before.createdRulesetId -and [long] $_.repositoryId -eq [long] $Rollback.repositoryId })
            Assert-HBCondition ($created.Count -eq 1) 'Drift: created ruleset identity is missing for rollback.'
            $created[0].enforcement = 'disabled'
            $created[0].stateSha256 = [string] $Rollback.rollbackDesiredSha256
        }
        default { throw 'Drift: unsupported bound before-state kind.' }
    }
}

function Update-HBInventoryEnvelope {
    param([Parameter(Mandatory)][hashtable] $Inventory)
    $now = [DateTimeOffset]::UtcNow
    $Inventory.observedAt = $now.ToString('o')
    $Inventory.expiresAt = $now.AddMinutes(15).ToString('o')
    $Inventory.apiVersion = $script:CRGApiVersion
    $Inventory.snapshotId = [guid]::NewGuid().ToString()
    $Inventory.sourceFresh = $true
    $Inventory.complete = $true
    $Inventory.snapshotSha256 = '0' * 64
    $Inventory.snapshotSha256 = Get-HBObjectSha256 $Inventory @('snapshotSha256')
    return $Inventory
}

function Invoke-HBFakeInventory {
    param(
        [Parameter(Mandatory)][string] $ProviderPath,
        [Parameter(Mandatory)][string] $InventoryOutputPath
    )
    $provider = Read-HBFakeProvider $ProviderPath
    $definitions = Get-HBGitHubReadRequestDefinitions
    foreach ($repository in @($provider.inventory.repositories)) {
        $ruleset = @($provider.inventory.rulesets | Where-Object { [long] $_.repositoryId -eq [long] $repository.repositoryId }) | Select-Object -First 1
        $rulesetId = if ($null -eq $ruleset) { 0 } else { [long] $ruleset.rulesetId }
        $definitions += @(Get-HBGitHubReadRequestDefinitions -RepositorySlug ([string] $repository.slug) -RulesetId $rulesetId)
    }
    $provider.transactions += [ordered]@{
        kind = 'InventoryRead'
        observedAt = [DateTimeOffset]::UtcNow.ToString('o')
        requestCount = @($definitions).Count
        apiVersion = $script:CRGApiVersion
        writes = 0
    }
    $provider.inventory = Update-HBInventoryEnvelope $provider.inventory
    Write-HBJsonFile $ProviderPath $provider
    Write-HBJsonFile $InventoryOutputPath $provider.inventory
    [void](Test-HBInventory $provider.inventory)
    return [ordered]@{
        status = 'Materialized'
        source = 'FakeProviderClosedReadDefinitions'
        requests = @($definitions).Count
        inventoryPath = [IO.Path]::GetFullPath($InventoryOutputPath)
        inventorySha256 = [string] $provider.inventory.snapshotSha256
        writes = 0
    }
}

function Publish-HBFakeActionEvidence {
    param(
        [Parameter(Mandatory)][string] $EvidenceRoot,
        [Parameter(Mandatory)][hashtable] $Record
    )
    return Publish-HBEvidence $EvidenceRoot "transactions/$($Record.actionId).json" $Record
}

function Get-HBLiveRulesetDetail {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $RepositorySlug,
        [Parameter(Mandatory)][long] $RepositoryId,
        [Parameter(Mandatory)][long] $RulesetId
    )

    $detail = (Invoke-HBGitHubJsonRead @(
        'api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)",
        "repos/$RepositorySlug/rulesets/$RulesetId"
    )).data
    Assert-HBCondition ([long] $detail.id -eq $RulesetId) "Live ruleset identity drift: ${RepositorySlug}:${RulesetId}"
    return [ordered]@{ detail = $detail; record = ConvertTo-HBLiveRulesetRecord $detail $RepositoryId }
}

function Get-HBLiveCopilotRulesets {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $RepositorySlug,
        [Parameter(Mandatory)][long] $RepositoryId
    )

    $list = Invoke-HBGitHubPagedRead @(
        'api', '--method', 'GET', '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)",
        "repos/$RepositorySlug/rulesets?includes_parents=false&per_page=100", '--paginate', '--slurp'
    )
    $copilotMatches = [Collections.Generic.List[object]]::new()
    foreach ($summary in @($list.items)) {
        $current = Get-HBLiveRulesetDetail $RepositorySlug $RepositoryId ([long] $summary.id)
        if ([bool] $current.record.containsCopilotCodeReview) { $copilotMatches.Add($current) }
    }
    return $copilotMatches.ToArray()
}

function New-HBLiveRulesetPayload {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][ValidateSet('RulesetCreate', 'RulesetUpdate', 'RulesetDisable')][string] $OperationClass,
        [hashtable] $CurrentDetail = $null,
        [string] $DefaultBranch = ''
    )

    if ($OperationClass -eq 'RulesetCreate') {
        Assert-HBCondition ($DefaultBranch -match '^[A-Za-z0-9._/-]+$') 'Create requires a valid default branch.'
        return [ordered]@{
            name = 'Automatic Copilot code review'
            target = 'branch'
            enforcement = 'active'
            bypass_actors = @()
            conditions = [ordered]@{ ref_name = [ordered]@{ include = @("refs/heads/$DefaultBranch"); exclude = @() } }
            rules = @([ordered]@{
                type = 'copilot_code_review'
                parameters = [ordered]@{ review_on_push = $false; review_draft_pull_requests = $false }
            })
        }
    }

    Assert-HBCondition ($null -ne $CurrentDetail) "$OperationClass requires current ruleset detail."
    $rules = @($CurrentDetail.rules | ForEach-Object { Copy-HBValue -Value $_ })
    $copilot = @($rules | Where-Object { [string] $_.type -eq 'copilot_code_review' })
    Assert-HBCondition ($copilot.Count -eq 1 -and @($rules | Where-Object { [string] $_.type -ne 'copilot_code_review' }).Count -eq 0) 'Live ruleset write requires one dedicated Copilot rule.'
    if ($OperationClass -eq 'RulesetUpdate') {
        $copilot[0].parameters.review_on_push = $false
        $copilot[0].parameters.review_draft_pull_requests = $false
    }
    return [ordered]@{
        name = [string] $CurrentDetail.name
        target = [string] $CurrentDetail.target
        enforcement = if ($OperationClass -eq 'RulesetDisable') { 'disabled' } else { 'active' }
        bypass_actors = @($CurrentDetail.bypass_actors | ForEach-Object { Copy-HBValue -Value $_ })
        conditions = Copy-HBValue -Value $CurrentDetail.conditions
        rules = $rules
    }
}

function Test-HBLiveRulesetDesiredState {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][ValidateSet('RulesetCreate', 'RulesetUpdate', 'RulesetDisable')][string] $OperationClass,
        [Parameter(Mandatory)][hashtable] $Record
    )

    Assert-HBCondition ([string] $Record.sourceType -eq 'Repository' -and [string] $Record.target -eq 'branch') 'Live ruleset after-state identity is unsafe.'
    Assert-HBCondition ([bool] $Record.containsCopilotCodeReview -and -not [bool] $Record.mixedPurpose) 'Live ruleset after-state is not a dedicated Copilot rule.'
    if ($OperationClass -eq 'RulesetDisable') {
        Assert-HBCondition ([string] $Record.enforcement -eq 'disabled') 'Live ruleset was not disabled.'
    } else {
        Assert-HBCondition ([string] $Record.enforcement -eq 'active' -and -not [bool] $Record.reviewDraftPullRequests -and -not [bool] $Record.reviewOnPush) 'Live target ruleset did not converge.'
    }
    return $true
}

function Invoke-HBLiveApply {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][hashtable] $Plan,
        [Parameter(Mandatory)][hashtable] $Gate,
        [Parameter(Mandatory)][string] $AuthorizationPath,
        [Parameter(Mandatory)][string] $EvidenceRoot,
        [Parameter(Mandatory)][string] $ResultPath,
        [Parameter(Mandatory)][string] $BrowserEvidencePath
    )

    $operationClass = [string] $Gate.operationClass
    Assert-HBCondition ($operationClass -in @('RulesetCreate', 'RulesetUpdate', 'RulesetDisable')) 'Live Apply supports only the approved repository-ruleset operation classes.'
    [void](Assert-HBJsonSchema $Plan 'mutation-plan')
    Assert-HBCondition ([string] $Plan.planSha256 -eq (Get-HBObjectSha256 $Plan @('planSha256'))) 'Plan hash mismatch.'
    $inventoryPath = Resolve-HBSafePath $EvidenceRoot 'operational/live-read/inventory.json'
    $inventory = Read-HBInventory $inventoryPath
    $context = Read-HBExternalWriteContext $EvidenceRoot $Gate $Plan $inventory
    [void](Test-HBExternalWriteGate $Gate $operationClass $Plan $context.authority $inventory)
    $selected = @($Plan.actions | Where-Object { @($Gate.allowedActionIds) -contains [string] $_.actionId })
    Assert-HBCondition ($selected.Count -gt 0 -and @($selected | Where-Object { -not [bool] $_.writeIntent -or [string] $_.action -eq 'Blocked' }).Count -eq 0) 'Live Apply requires only write-intent, non-Blocked actions.'
    $gateSha256 = Get-HBObjectSha256 $Gate
    $started = [DateTimeOffset]::UtcNow
    $results = [Collections.Generic.List[object]]::new()
    $writeAttempted = $false
    $completed = $false
    try {
        foreach ($action in $selected) {
            $actionStarted = [DateTimeOffset]::UtcNow
            $repository = @($inventory.repositories | Where-Object { [long] $_.repositoryId -eq [long] $action.repositoryId })
            Assert-HBCondition ($repository.Count -eq 1 -and [string] $repository[0].slug -match '^hindermath/[A-Za-z0-9_.-]+$') 'Live Apply repository identity mismatch.'
            $slug = [string] $repository[0].slug
            $current = $null
            if ($operationClass -eq 'RulesetCreate') {
                $currentCopilot = @(Get-HBLiveCopilotRulesets $slug ([long] $action.repositoryId))
                Assert-HBCondition ($currentCopilot.Count -eq 0) 'Drift: target repository no longer has a missing Copilot ruleset.'
                $currentHash = Get-HBObjectSha256 ([ordered]@{ repositoryId = [long] $action.repositoryId; missing = $true })
                $payload = New-HBLiveRulesetPayload $operationClass -DefaultBranch ([string] $repository[0].defaultBranch)
                $endpoint = "repos/$slug/rulesets"
            } else {
                $current = Get-HBLiveRulesetDetail $slug ([long] $action.repositoryId) ([long] $action.rulesetId)
                $currentHash = [string] $current.record.stateSha256
                $payload = New-HBLiveRulesetPayload $operationClass -CurrentDetail $current.detail
                $endpoint = "repos/$slug/rulesets/$([long] $action.rulesetId)"
            }
            Assert-HBCondition ($currentHash -eq [string] $action.beforeSha256) 'Drift: action beforeSha256 no longer matches the live provider.'

            # Re-read the complete authority/evidence/inventory/plan tuple at
            # the last possible point before this single write attempt.
            $writeInventory = Read-HBInventory $inventoryPath
            [void](Read-HBExternalWriteContext $EvidenceRoot $Gate $Plan $writeInventory)
            [void](Test-HBExternalWriteGate $Gate $operationClass $Plan $context.authority $writeInventory)
            $temporaryInput = [IO.Path]::GetTempFileName()
            try {
                Write-HBJsonFile $temporaryInput $payload
                $writeAttempted = $true
                $writeResult = Invoke-HBGitHubJsonWrite -Arguments @(
                    'api', '--hostname', 'github.com', '--method', [string] $action.allowedMethod,
                    '-H', "X-GitHub-Api-Version: $($script:CRGApiVersion)", $endpoint,
                    '--input', $temporaryInput
                ) -InputPath $temporaryInput
            } finally {
                Remove-Item -LiteralPath $temporaryInput -Force -ErrorAction SilentlyContinue
            }

            $rulesetId = if ($operationClass -eq 'RulesetCreate') {
                if ($writeResult.succeeded) { [long] $writeResult.data.id } else { 0 }
            } else { [long] $action.rulesetId }
            if ($operationClass -eq 'RulesetCreate' -and $rulesetId -le 0) {
                $reconciled = @(Get-HBLiveCopilotRulesets $slug ([long] $action.repositoryId) | Where-Object {
                    [void](Test-HBLiveRulesetDesiredState $operationClass $_.record)
                    return $true
                })
                Assert-HBCondition ($reconciled.Count -eq 1) 'Ambiguous create could not be reconciled to one exact ruleset.'
                $rulesetId = [long] $reconciled[0].record.rulesetId
            }
            $after = Get-HBLiveRulesetDetail $slug ([long] $action.repositoryId) $rulesetId
            [void](Test-HBLiveRulesetDesiredState $operationClass $after.record)
            $outcome = if ([bool] $writeResult.succeeded) { 'Applied' } else { 'Reconciled' }
            $statusClass = if ([bool] $writeResult.succeeded) { 'Success' } else { 'Ambiguous' }
            $evidenceRecord = [ordered]@{
                actionId = [string] $action.actionId
                operationClass = $operationClass
                repositoryId = [long] $action.repositoryId
                rulesetId = $rulesetId
                beforeSha256 = [string] $action.beforeSha256
                desiredSha256 = [string] $action.desiredSha256
                observedAfterSha256 = [string] $after.record.stateSha256
                method = [string] $action.allowedMethod
                writeAttempts = 1
                blindWriteRetries = 0
                providerStatusClass = $statusClass
                outcome = $outcome
                writes = 1
            }
            $published = Publish-HBEvidence $EvidenceRoot "operational/transactions/provider-$($action.actionId).json" $evidenceRecord
            $result = [ordered]@{
                actionId = [string] $action.actionId
                operationClass = $operationClass
                repositoryId = [long] $action.repositoryId
                rulesetId = $rulesetId
                argumentForm = 'DirectArgumentArray'
                startedAt = $actionStarted.ToString('o')
                finishedAt = [DateTimeOffset]::UtcNow.ToString('o')
                providerStatusClass = $statusClass
                preflightSha256 = [string] $action.beforeSha256
                afterStateSha256 = [string] $action.desiredSha256
                writes = 1
                outcome = $outcome
                evidencePath = [string] $published.path
                evidenceSha256 = [string] $published.sha256
            }
            if ($operationClass -eq 'RulesetCreate') { $result.rulesetIdSource = 'ProviderResponseAndPostInventoryExactMatch' }
            $results.Add($result)
        }

        $afterInventoryPath = Resolve-HBSafePath $EvidenceRoot 'operational/provider-convergence/after-inventory.json' -AllowMissingLeaf
        [void](Invoke-HBLiveGitHubInventory $BrowserEvidencePath $afterInventoryPath)
        $afterInventory = Read-HBInventory $afterInventoryPath
        $desired = Read-HBDesiredState (Join-Path $script:CRGRepositoryRoot 'scripts/config/copilot-review-governance-desired-state.json')
        $secondPlan = New-HBMutationPlan $desired $afterInventory ([string] $Plan.runId)
        $secondSelected = @($secondPlan.actions | Where-Object { [string] $_.operationClass -eq $operationClass -and [bool] $_.writeIntent })
        Assert-HBCondition ($secondSelected.Count -eq 0) 'Drift: second live Preview still contains a write for the applied operation class.'
        foreach ($result in $results) { $result.postInventorySha256 = [string] $afterInventory.snapshotSha256 }
        $envelope = [ordered]@{
            schemaVersion = '1.0'
            resultId = [guid]::NewGuid().ToString()
            runId = [string] $Plan.runId
            planSha256 = [string] $Plan.planSha256
            gateSha256 = $gateSha256
            startedAt = $started.ToString('o')
            finishedAt = [DateTimeOffset]::UtcNow.ToString('o')
            results = @($results)
            totalWrites = $results.Count
            idempotentSecondPass = [ordered]@{ validatedAt = [DateTimeOffset]::UtcNow.ToString('o'); writes = 0; driftCount = 0; inventorySha256 = [string] $afterInventory.snapshotSha256 }
            resultSha256 = '0' * 64
        }
        $envelope.resultSha256 = Get-HBObjectSha256 $envelope @('resultSha256')
        [void](Assert-HBJsonSchema $envelope 'mutation-result')
        Write-HBJsonFile $ResultPath $envelope
        $completed = $true
        return $envelope
    } finally {
        $persistedGate = Read-HBJsonFile $AuthorizationPath
        if ([string] $persistedGate.gateId -eq [string] $Gate.gateId) {
            $persistedGate.status = if ($completed -or $writeAttempted) { 'Consumed' } else { 'Revoked' }
            Write-HBJsonFile $AuthorizationPath $persistedGate
        }
    }
}

function Invoke-HBFakeApply {
    param(
        [Parameter(Mandatory)][hashtable] $Plan,
        [Parameter(Mandatory)][hashtable] $Gate,
        [Parameter(Mandatory)][string] $ProviderPath,
        [Parameter(Mandatory)][string] $EvidenceRoot,
        [Parameter(Mandatory)][string] $ResultPath
    )
    [void](Assert-HBJsonSchema $Plan 'mutation-plan')
    Assert-HBCondition ([string] $Plan.planSha256 -eq (Get-HBObjectSha256 $Plan @('planSha256'))) 'Plan hash mismatch.'
    $provider = Read-HBFakeProvider $ProviderPath
    $contextInventory = Read-HBInventory (Resolve-HBSafePath $EvidenceRoot 'operational/live-read/inventory.json')
    [void](Read-HBExternalWriteContext $EvidenceRoot $Gate $Plan $contextInventory)
    $selected = @($Plan.actions | Where-Object { @($Gate.allowedActionIds) -contains [string] $_.actionId })
    $idempotentReplay = $selected.Count -gt 0 -and @($selected | Where-Object { @($provider.idempotencyIds) -notcontains [string] $_.idempotencyId }).Count -eq 0
    [void](Test-HBExternalWriteGate $Gate ([string] $Gate.operationClass) $Plan (Read-HBJsonFile (Resolve-HBSafePath $EvidenceRoot 'operational/live-read/authority.json')) $(if ($idempotentReplay) { $null } else { $provider.inventory }))
    Assert-HBCondition (@($provider.consumedGateIds) -notcontains [string] $Gate.gateId) 'External-Write-Gate is already consumed.'
    Assert-HBCondition (@($selected | Where-Object { [string] $_.action -eq 'Blocked' }).Count -eq 0) 'Blocked plan actions cannot be authorized.'
    $started = [DateTimeOffset]::UtcNow
    $results = [Collections.Generic.List[object]]::new()
    $totalWrites = 0
    foreach ($action in $selected) {
        $actionId = [string] $action.actionId
        $retries = 0
        while ([int] $provider.transientReadFailures -gt 0 -and $retries -lt 3) {
            $provider.transientReadFailures = [int] $provider.transientReadFailures - 1
            $retries++
            $provider.transactions += [ordered]@{ kind = 'Read'; actionId = $actionId; outcome = 'Transient'; retry = $retries; writes = 0 }
        }
        Assert-HBCondition ([int] $provider.transientReadFailures -eq 0) 'Fake provider read retry budget exhausted.'
        $provider.transactions += [ordered]@{ kind = 'Read'; actionId = $actionId; outcome = 'Current'; writes = 0 }
        $currentHash = if ($provider.actionStateHashes.ContainsKey($actionId)) { [string] $provider.actionStateHashes[$actionId] } else { [string] $action.beforeSha256 }
        if (@($provider.toctouActionIds) -contains $actionId) {
            $provider.transactions += [ordered]@{ kind = 'TOCTOU'; actionId = $actionId; outcome = 'Blocked'; beforeSha256 = $currentHash; writes = 0 }
            Write-HBJsonFile $ProviderPath $provider
            throw 'Drift: fake provider TOCTOU binding changed before the write.'
        }
        Assert-HBCondition ($currentHash -eq [string] $action.beforeSha256 -or @($provider.idempotencyIds) -contains [string] $action.idempotencyId) 'Drift: action beforeSha256 no longer matches.'
        $actionStarted = [DateTimeOffset]::UtcNow
        $writes = 0
        $createdRulesetId = 0
        $outcome = 'NoOp'
        $statusClass = 'NotInvoked'
        if ([bool] $action.writeIntent -and @($provider.idempotencyIds) -notcontains [string] $action.idempotencyId) {
            # Re-read and re-hash the complete authority/evidence/inventory/plan tuple at the last possible point.
            $writeInventory = Read-HBInventory (Resolve-HBSafePath $EvidenceRoot 'operational/live-read/inventory.json')
            [void](Read-HBExternalWriteContext $EvidenceRoot $Gate $Plan $writeInventory)
            $writes = 1
            $totalWrites++
            $provider.actionStateHashes[$actionId] = [string] $action.desiredSha256
            $provider.idempotencyIds += [string] $action.idempotencyId
            $provider.transactions += [ordered]@{ kind = 'Write'; actionId = $actionId; method = [string] $action.allowedMethod; writes = 1; blindWriteRetries = 0 }
            $createdRulesetId = Set-HBFakeInventoryActionState $provider $action
            $statusClass = if (@($provider.ambiguousActionIds) -contains $actionId) { 'Ambiguous' } else { 'Success' }
            if ($statusClass -eq 'Ambiguous') {
                $provider.transactions += [ordered]@{ kind = 'Read'; actionId = $actionId; outcome = 'Reconciled'; observedSha256 = [string] $action.desiredSha256; writes = 0 }
                $outcome = 'Reconciled'
            } else { $outcome = 'Applied' }
        }
        $evidenceRecord = [ordered]@{
            actionId = $actionId
            operationClass = [string] $action.operationClass
            beforeSha256 = [string] $action.beforeSha256
            desiredSha256 = [string] $action.desiredSha256
            retries = $retries
            writes = $writes
            outcome = $outcome
        }
        $published = Publish-HBFakeActionEvidence $EvidenceRoot $evidenceRecord
        $result = [ordered]@{
            actionId = $actionId
            operationClass = [string] $action.operationClass
            argumentForm = if ([string] $action.allowedMethod -eq 'BrowserManual') { 'BrowserManualChecklist' } else { 'DirectArgumentArray' }
            startedAt = $actionStarted.ToString('o')
            finishedAt = [DateTimeOffset]::UtcNow.ToString('o')
            providerStatusClass = $statusClass
            preflightSha256 = [string] $action.beforeSha256
            afterStateSha256 = if ($writes -eq 1) { [string] $action.desiredSha256 } else { $currentHash }
            writes = $writes
            outcome = $outcome
            evidencePath = [string] $published.path
            evidenceSha256 = [string] $published.sha256
        }
        if ($action.ContainsKey('accountOwner')) { $result.accountOwner = [string] $action.accountOwner }
        else { $result.repositoryId = [long] $action.repositoryId }
        if ($action.ContainsKey('rulesetId')) {
            $result.rulesetId = [long] $action.rulesetId
            $result.postInventorySha256 = [string] $provider.inventory.snapshotSha256
        } elseif ($createdRulesetId -gt 0) {
            $result.rulesetId = $createdRulesetId
            $result.rulesetIdSource = 'ProviderResponseAndPostInventoryExactMatch'
            $result.postInventorySha256 = [string] $provider.inventory.snapshotSha256
        }
        $results.Add($result)
    }
    $provider.consumedGateIds += [string] $Gate.gateId
    $provider.inventory = Update-HBInventoryEnvelope $provider.inventory
    foreach ($result in $results) {
        if ($result.Contains('postInventorySha256')) {
            $result.postInventorySha256 = [string] $provider.inventory.snapshotSha256
        }
    }
    $provider.transactions += [ordered]@{ kind = 'Apply'; gateId = [string] $Gate.gateId; writes = $totalWrites; idempotent = ($totalWrites -eq 0) }
    $afterInventoryPath = Resolve-HBSafePath $EvidenceRoot 'operational/provider-convergence/after-inventory.json' -AllowMissingLeaf
    Write-HBJsonFile $afterInventoryPath $provider.inventory
    $desired = Read-HBDesiredState (Join-Path $script:CRGRepositoryRoot 'scripts/config/copilot-review-governance-desired-state.json')
    $secondPlan = New-HBMutationPlan $desired $provider.inventory ([string] $Plan.runId)
    $secondSelected = @($secondPlan.actions | Where-Object { [string] $_.operationClass -eq [string] $Gate.operationClass -and [bool] $_.writeIntent })
    Assert-HBCondition ($secondSelected.Count -eq 0) 'Drift: real second Preview still contains a write for the applied operation class.'
    $provider.transactions += [ordered]@{ kind = 'SecondPreview'; operationClass = [string] $Gate.operationClass; writes = 0; driftCount = 0; planSha256 = [string] $secondPlan.planSha256 }
    $provider.transactions += [ordered]@{ kind = 'SecondApply'; operationClass = [string] $Gate.operationClass; writes = 0; driftCount = 0 }
    Write-HBJsonFile $ProviderPath $provider
    $envelope = [ordered]@{
        schemaVersion = '1.0'
        resultId = [guid]::NewGuid().ToString()
        runId = [string] $Plan.runId
        planSha256 = [string] $Plan.planSha256
        gateSha256 = Get-HBObjectSha256 $Gate
        startedAt = $started.ToString('o')
        finishedAt = [DateTimeOffset]::UtcNow.ToString('o')
        results = @($results)
        totalWrites = $totalWrites
        idempotentSecondPass = [ordered]@{ validatedAt = [DateTimeOffset]::UtcNow.ToString('o'); writes = 0; driftCount = 0; inventorySha256 = [string] $provider.inventory.snapshotSha256 }
        resultSha256 = '0' * 64
    }
    $envelope.resultSha256 = Get-HBObjectSha256 $envelope @('resultSha256')
    [void](Assert-HBJsonSchema $envelope 'mutation-result')
    Write-HBJsonFile $ResultPath $envelope
    return $envelope
}

function Invoke-HBFakeRollback {
    param(
        [Parameter(Mandatory)][hashtable] $Rollback,
        [Parameter(Mandatory)][hashtable] $Gate,
        [Parameter(Mandatory)][string] $ProviderPath,
        [Parameter(Mandatory)][string] $EvidenceRoot,
        [Parameter(Mandatory)][string] $ResultPath
    )
    $provider = Read-HBFakeProvider $ProviderPath
    [void](Test-HBRollbackContract $Rollback ([string] $(if ($provider.actionStateHashes.ContainsKey([string] $Rollback.sourceActionId)) { $provider.actionStateHashes[[string] $Rollback.sourceActionId] } else { $Rollback.failedAfterSha256 })))
    [void](Test-HBExternalWriteGate $Gate 'Rollback')
    Assert-HBCondition ([string] $Gate.runId -eq [string] $Rollback.runId) 'Rollback gate run identity mismatch.'
    Assert-HBCondition ([string] $Gate.snapshotSha256 -eq [string] $Rollback.afterInventorySha256) 'Rollback gate snapshot mismatch.'
    Assert-HBCondition (@($Gate.allowedActionIds) -contains [string] $Rollback.sourceActionId) 'Rollback gate does not authorize the exact source action.'
    Assert-HBCondition ([string] $Gate.rollbackHashes[[string] $Rollback.sourceActionId] -eq [string] $Rollback.rollbackDesiredSha256) 'Rollback desired-state hash is not gate-bound.'
    Assert-HBCondition (@($provider.consumedGateIds) -notcontains [string] $Gate.gateId) 'Rollback gate is already consumed.'
    $started = [DateTimeOffset]::UtcNow
    $provider.transactions += [ordered]@{ kind = 'Read'; actionId = [string] $Rollback.sourceActionId; outcome = 'Current'; writes = 0 }
    $currentInventory = Read-HBInventory (Resolve-HBSafePath $EvidenceRoot 'operational/live-read/inventory.json')
    $currentPlan = Read-HBJsonFile (Resolve-HBSafePath $EvidenceRoot 'operational/live-read/mutation-plan.json')
    [void](Read-HBExternalWriteContext $EvidenceRoot $Gate $currentPlan $currentInventory)
    Assert-HBCondition ((Get-HBObjectSha256 $provider.inventory) -eq (Get-HBObjectSha256 $currentInventory)) 'Drift: rollback current Inventory changed immediately before write.'
    $provider.actionStateHashes[[string] $Rollback.sourceActionId] = [string] $Rollback.rollbackDesiredSha256
    Restore-HBFakeInventoryActionState $provider $Rollback
    $provider.consumedGateIds += [string] $Gate.gateId
    $provider.inventory = Update-HBInventoryEnvelope $provider.inventory
    $provider.transactions += [ordered]@{ kind = 'Write'; actionId = [string] $Rollback.sourceActionId; method = [string] $Gate.allowedMethods[0]; writes = 1; blindWriteRetries = 0 }
    $provider.transactions += [ordered]@{ kind = 'Rollback'; actionId = [string] $Rollback.sourceActionId; writes = 1; blindWriteRetries = 0 }
    $evidenceRecord = [ordered]@{
        actionId = [string] $Rollback.sourceActionId
        operationClass = 'Rollback'
        failedAfterSha256 = [string] $Rollback.failedAfterSha256
        rollbackDesiredSha256 = [string] $Rollback.rollbackDesiredSha256
        writes = 1
        outcome = 'RolledBack'
    }
    $published = Publish-HBFakeActionEvidence $EvidenceRoot $evidenceRecord
    Write-HBJsonFile $ProviderPath $provider
    $actionResult = [ordered]@{
        actionId = [string] $Rollback.sourceActionId
        operationClass = 'Rollback'
        argumentForm = if ([string] $Gate.allowedMethods[0] -eq 'BrowserManual') { 'BrowserManualChecklist' } else { 'DirectArgumentArray' }
        startedAt = $started.ToString('o')
        finishedAt = [DateTimeOffset]::UtcNow.ToString('o')
        providerStatusClass = 'Success'
        preflightSha256 = [string] $Rollback.failedAfterSha256
        afterStateSha256 = [string] $Rollback.rollbackDesiredSha256
        writes = 1
        outcome = 'RolledBack'
        evidencePath = [string] $published.path
        evidenceSha256 = [string] $published.sha256
    }
    if ($Rollback.ContainsKey('accountOwner')) { $actionResult.accountOwner = [string] $Rollback.accountOwner }
    else { $actionResult.repositoryId = [long] $Rollback.repositoryId }
    if ($Rollback.ContainsKey('rulesetId')) { $actionResult.rulesetId = [long] $Rollback.rulesetId; $actionResult.postInventorySha256 = [string] $provider.inventory.snapshotSha256 }
    $envelope = [ordered]@{
        schemaVersion = '1.0'
        resultId = [guid]::NewGuid().ToString()
        runId = [string] $Rollback.runId
        planSha256 = [string] $Gate.planSha256
        gateSha256 = Get-HBObjectSha256 $Gate
        startedAt = $started.ToString('o')
        finishedAt = [DateTimeOffset]::UtcNow.ToString('o')
        results = @($actionResult)
        totalWrites = 1
        idempotentSecondPass = [ordered]@{ validatedAt = [DateTimeOffset]::UtcNow.ToString('o'); writes = 0; driftCount = 0; inventorySha256 = [string] $provider.inventory.snapshotSha256 }
        resultSha256 = '0' * 64
    }
    $envelope.resultSha256 = Get-HBObjectSha256 $envelope @('resultSha256')
    [void](Assert-HBJsonSchema $envelope 'mutation-result')
    Write-HBJsonFile (Resolve-HBSafePath $EvidenceRoot 'operational/provider-convergence/after-inventory.json' -AllowMissingLeaf) $provider.inventory
    Write-HBJsonFile $ResultPath $envelope
    return $envelope
}

function Test-HBAfterState {
    param([Parameter(Mandatory)][hashtable] $DesiredState, [Parameter(Mandatory)][hashtable] $Inventory)
    [void](Test-HBInventory $Inventory)
    Assert-HBCondition ([string] $Inventory.personalAccountAutomation.state -eq 'Disabled') 'After-state account automation is not Disabled.'
    $targetIds = [Collections.Generic.HashSet[long]]::new()
    foreach ($target in @($DesiredState.targets)) {
        $repository = @($Inventory.repositories | Where-Object { [string] $_.slug -ceq [string] $target.slug -and [string] $_.defaultBranch -ceq [string] $target.defaultBranch })
        Assert-HBCondition ($repository.Count -eq 1) "After-state repository identity mismatch: $($target.slug)"
        $repoId = [long] $repository[0].repositoryId
        [void] $targetIds.Add($repoId)
        $effort = @($Inventory.browserEvidence | Where-Object { [string] $_.surface -eq 'RepositoryEffort' -and [long] $_.repositoryId -eq $repoId -and [string] $_.observedState -eq 'Lite' })
        Assert-HBCondition ($effort.Count -eq 1) "After-state Lite evidence missing: $($target.slug)"
        $ruleset = @($Inventory.rulesets | Where-Object { [long] $_.repositoryId -eq $repoId -and [bool] $_.containsCopilotCodeReview })
        Assert-HBCondition ($ruleset.Count -eq 1) "After-state requires exactly one Copilot ruleset: $($target.slug)"
        Assert-HBCondition ([string] $ruleset[0].sourceType -eq 'Repository' -and -not [bool] $ruleset[0].mixedPurpose) 'After-state review gate isolation was not preserved.'
        Assert-HBCondition ([string] $ruleset[0].enforcement -eq 'active' -and -not [bool] $ruleset[0].reviewDraftPullRequests -and -not [bool] $ruleset[0].reviewOnPush) 'After-state automatic review settings drifted.'
    }
    $nonTarget = @($Inventory.rulesets | Where-Object { -not $targetIds.Contains([long] $_.repositoryId) -and [bool] $_.containsCopilotCodeReview -and [string] $_.enforcement -eq 'active' })
    Assert-HBCondition ($nonTarget.Count -eq 0) 'After-state has an active non-target Copilot ruleset.'
    return [ordered]@{ status = 'Valid'; targetCount = 8; driftCount = 0; gateInvariants = 'PreservedByDedicatedRulesetOnly'; writes = 0 }
}

function Invoke-HBCopilotReviewGovernance {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string] $Action,
        [string] $DesiredStatePath = '',
        [string] $InventoryPath = '',
        [string] $OutputPath = '',
        [string] $BrowserEvidencePath = '',
        [string] $AuthorizationPath = '',
        [string] $PlanPath = '',
        [string] $RollbackPlanPath = '',
        [string] $ResultPath = '',
        [string] $FakeProviderPath = '',
        [string] $EvidenceRoot = '',
        [string] $OperationClass = '',
        [switch] $ReadOnly,
        [switch] $DryRun
    )

    switch ($Action) {
        'ValidateDesiredState' {
            $desired = Read-HBDesiredState $DesiredStatePath
            return [ordered]@{ status = 'Valid'; targetCount = @($desired.targets).Count; contractSha256 = [string] $desired.contractSha256; writes = 0 }
        }
        'Validate' {
            $desired = Read-HBDesiredState $DesiredStatePath
            $inventory = Read-HBInventory $InventoryPath
            $plan = New-HBMutationPlan $desired $inventory
            return [ordered]@{ status = if (@($plan.actions | Where-Object { $_.action -eq 'Blocked' }).Count) { 'Blocked' } else { 'Valid' }; planSha256 = $plan.planSha256; writes = 0 }
        }
        'Preview' {
            $desired = Read-HBDesiredState $DesiredStatePath
            $inventory = Read-HBInventory $InventoryPath
            $plan = New-HBMutationPlan $desired $inventory
            if ($OutputPath) {
                Write-HBJsonFile $OutputPath $plan
            }
            return $plan
        }
        'ValidateInventory' { [void](Read-HBInventory $InventoryPath); return [ordered]@{ status = 'Valid'; writes = 0 } }
        'Inventory' {
            Assert-HBCondition ($ReadOnly -or $DryRun) 'Inventory requires -ReadOnly or -DryRun in this interface.'
            $inventoryOutput = if ($OutputPath) { $OutputPath } elseif ($InventoryPath) { $InventoryPath } else { throw 'Inventory requires -OutputPath or -InventoryPath.' }
            if (-not [string]::IsNullOrWhiteSpace($FakeProviderPath)) {
                return Invoke-HBFakeInventory $FakeProviderPath $inventoryOutput
            }
            Assert-HBCondition ($ReadOnly) 'Live inventory requires explicit -ReadOnly.'
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($BrowserEvidencePath)) 'Live inventory requires BrowserEvidencePath.'
            return Invoke-HBLiveGitHubInventory $BrowserEvidencePath $inventoryOutput
        }
        'ValidateBrowserEvidence' {
            $browser = Read-HBJsonFile $BrowserEvidencePath
            Assert-HBCondition (@($browser.records).Count -ge 1) 'Browser evidence records are missing.'
            foreach ($record in @($browser.records)) {
                Assert-HBCondition ([string] $record.evidenceMode -eq 'BrowserManual') 'Browser evidence must remain BrowserManual.'
                [void](Protect-HBRedactedValue $record)
            }
            return [ordered]@{ status = 'Valid'; records = @($browser.records).Count; writes = 0 }
        }
        'ValidateExternalWriteGate' {
            try {
                Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($EvidenceRoot)) 'AUTORITAET_BLOCKIERT: EvidenceRoot is required.'
                Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($InventoryPath) -or (Test-Path -LiteralPath (Join-Path $EvidenceRoot 'operational/live-read/inventory.json') -PathType Leaf)) 'AUTORITAET_BLOCKIERT: Current Inventory is required.'
                $gate = Read-HBJsonFile $AuthorizationPath
                [void](Assert-HBJsonSchema $gate 'external-write-gate')
                Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($PlanPath)) 'AUTORITAET_BLOCKIERT: Mutation Plan is required.'
                $plan = Read-HBJsonFile $PlanPath
                $effectiveInventoryPath = if ($InventoryPath) { $InventoryPath } else { Join-Path $EvidenceRoot 'operational/live-read/inventory.json' }
                $inventory = Read-HBInventory $effectiveInventoryPath
                $context = Read-HBExternalWriteContext $EvidenceRoot $gate $plan $inventory
                [void](Test-HBExternalWriteGate $gate $OperationClass $plan $context.authority $inventory)
                if ([string] $gate.operationClass -eq 'AccountSetting') {
                    Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($ResultPath)) 'AUTORITAET_BLOCKIERT: AccountSetting ResultPath is required.'
                    Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($RollbackPlanPath)) 'AUTORITAET_BLOCKIERT: AccountSetting RollbackPlanPath is required.'
                    $accountActions = @($plan.actions | Where-Object { [string] $_.operationClass -eq 'AccountSetting' -and @($gate.allowedActionIds) -contains [string] $_.actionId })
                    Assert-HBCondition ($accountActions.Count -eq 1) 'AUTORITAET_BLOCKIERT: Exactly one AccountSetting action must be gate-bound.'
                    [void](Test-HBAccountPreWriteRecordSet $context.authority $accountActions[0] $gate (Read-HBJsonFile $ResultPath) (Read-HBJsonFile $RollbackPlanPath))
                }
            } catch {
                if ($OperationClass -eq 'AccountSetting' -and $_.Exception.Message -notmatch '^AUTORITAET_BLOCKIERT:') {
                    throw "AUTORITAET_BLOCKIERT: $($_.Exception.Message)"
                }
                throw
            }
            return [ordered]@{ status = 'Authorized'; operationClass = [string] $gate.operationClass; accountIdentityEquality = if ([string] $gate.operationClass -eq 'AccountSetting') { 'Passed' } else { 'NotApplicable' }; writes = 0 }
        }
        'Apply' {
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($AuthorizationPath)) 'External-Write-Gate fehlt / External write gate is missing.'
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($PlanPath)) 'Mutation plan is missing.'
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($EvidenceRoot)) 'Apply requires an EvidenceRoot.'
            $gate = Read-HBJsonFile $AuthorizationPath
            $plan = Read-HBJsonFile $PlanPath
            if (-not [string]::IsNullOrWhiteSpace($FakeProviderPath)) {
                Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($ResultPath)) 'FakeProvider Apply requires ResultPath.'
                return Invoke-HBFakeApply $plan $gate $FakeProviderPath $EvidenceRoot $ResultPath
            }
            Assert-HBCondition (-not $DryRun) 'Live Apply cannot run with -DryRun or -WhatIf.'
            $effectiveResultPath = if ($ResultPath) { $ResultPath } else {
                $fileName = switch ([string] $gate.operationClass) {
                    'RulesetCreate' { 'ruleset-create.json' }
                    'RulesetUpdate' { 'ruleset-update.json' }
                    'RulesetDisable' { 'ruleset-disable.json' }
                    default { throw 'Live Apply requires ResultPath for this operation class.' }
                }
                Resolve-HBSafePath $EvidenceRoot "operational/provider-results/$fileName" -AllowMissingLeaf
            }
            $effectiveBrowserEvidencePath = if ($BrowserEvidencePath) { $BrowserEvidencePath } else { Resolve-HBSafePath $EvidenceRoot 'browser-manual/before.json' }
            return Invoke-HBLiveApply $plan $gate $AuthorizationPath $EvidenceRoot $effectiveResultPath $effectiveBrowserEvidencePath
        }
        'Rollback' {
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($AuthorizationPath)) 'External-Write-Gate fehlt / External write gate is missing.'
            $effectiveRollbackPath = if ($RollbackPlanPath) { $RollbackPlanPath } else { $PlanPath }
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($effectiveRollbackPath)) 'Rollback plan is missing.'
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($ResultPath)) 'ResultPath is required.'
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($FakeProviderPath)) 'Rollback requires the explicit bounded FakeProviderPath; no live provider fallback exists.'
            Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($EvidenceRoot)) 'Rollback requires an EvidenceRoot.'
            return Invoke-HBFakeRollback (Read-HBJsonFile $effectiveRollbackPath) (Read-HBJsonFile $AuthorizationPath) $FakeProviderPath $EvidenceRoot $ResultPath
        }
        'ValidateAfterState' {
            $effectiveInventoryPath = $InventoryPath
            if ([string]::IsNullOrWhiteSpace($effectiveInventoryPath)) {
                Assert-HBCondition (-not [string]::IsNullOrWhiteSpace($EvidenceRoot)) 'ValidateAfterState requires InventoryPath or EvidenceRoot.'
                $effectiveInventoryPath = Join-Path $EvidenceRoot 'operational/provider-convergence/after-inventory.json'
            }
            return Test-HBAfterState (Read-HBDesiredState $DesiredStatePath) (Read-HBInventory $effectiveInventoryPath)
        }
        'ValidateUsage' { return Get-HBUsageReport (Read-HBInventory $InventoryPath) }
        default { throw "Unbekannte Aktion / Unknown action: $Action" }
    }
}

Export-ModuleMember -Function @(
    'ConvertTo-HBCanonicalJson', 'Get-HBSha256', 'Resolve-HBSafePath',
    'Read-HBDesiredState', 'Read-HBInventory', 'Test-HBInventory',
    'Get-HBGitHubReadRequestDefinitions', 'Test-HBBrowserEvidenceBoundary',
    'New-HBMutationPlan', 'Test-HBExternalWriteGate', 'Protect-HBRedactedValue',
    'New-HBRulesetOperation', 'Test-HBAccountPreWriteRecordSet',
    'Test-HBRollbackContract', 'Compare-HBReviewGateMap',
    'Publish-HBEvidence', 'Get-HBPrLifecycleDecision', 'Get-HBUsageReport',
    'Format-HBLinearDecision', 'Invoke-HBCopilotReviewGovernance'
)
