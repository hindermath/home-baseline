#Requires -Version 7
<#
.SYNOPSIS
Erhebt und rendert öffentliche Spec-Kit-Laufzahlen. / Collects and renders public Spec Kit run counts.
.DESCRIPTION
Collect reads public GitHub evidence using gh. Validate and Render replay the versioned
snapshot without network access. Only marked README blocks and report files are generated.
Collect liest öffentliche GitHub-Belege; Validate/Render arbeiten offline. Kein Commit, Push oder Merge.
Rule version 2 also validates the sanitized private aggregate and partitions executed runs by mode.
Regelversion 2 prüft zusätzlich freigegebene private Summen und die Ausführungsarten je Repository.
Version 3 adds source-bound repository acceleration estimates against 80 text lines/workday.
Version 3 ergänzt quellgebundene Repo-Schätzungen gegenüber 80 Textzeilen/Arbeitstag.
.PARAMETER Action
Collect, Validate or Render. / Erheben, prüfen oder erzeugen.
.PARAMETER Repo
Level-0 checkout; defaults to the shared source resolver. / Gemeinsame Level-0-Quellauflösung.
.PARAMETER CheckOnly
Read-only validation/drift check. / Schreibfreie Validierung/Driftprüfung.
.PARAMETER TableFormat
AccessibleHtml (default) or historical Markdown replay. / Barrierearmes HTML oder historisches Markdown.
.PARAMETER WhatIf
Preview without writes. Collect still reads GitHub. / Vorschau ohne Schreiben.
.EXAMPLE
bash scripts/update-public-speckit-statistics.sh --action collect --dry-run
.EXAMPLE
pwsh -NoProfile -File scripts/update-public-speckit-statistics.ps1 -Action Render -CheckOnly
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    [ValidateSet('Collect', 'Validate', 'Render')][string]$Action = 'Validate',
    [string]$Repo,
    [ValidateSet('Markdown', 'AccessibleHtml')][string]$TableFormat = 'AccessibleHtml',
    [switch]$CheckOnly
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module (Join-Path $PSScriptRoot 'lib/public-speckit-statistics.psm1') -Force
Import-Module (Join-Path $PSScriptRoot 'lib/managed-file-hardening.psm1') -Force
try {
    if (-not $PSBoundParameters.ContainsKey('Repo')) {
        . (Join-Path $PSScriptRoot 'lib/resolve-home-baseline-source.ps1')
        $Repo = Resolve-HBSourceRepository -StartPath $PSScriptRoot
    }
    $root = [IO.Path]::GetFullPath($Repo)
    $data = Join-Path $root 'docs/spec-kit-runs'
    $registryRelative = 'docs/spec-kit-runs/registry.json'
    $snapshotRelative = 'docs/spec-kit-runs/snapshot.json'
    $registryPath = Get-HBManagedPath -Root $root -RelativePath $registryRelative
    $snapshotPath = Get-HBManagedPath -Root $root -RelativePath $snapshotRelative
    $registry = Read-HBJson $registryPath
    Assert-HBRegistry $registry
    if ($Action -eq 'Collect') {
        $previous = if (Test-Path -LiteralPath $snapshotPath) { Read-HBJson $snapshotPath } else { @{} }
        $snapshot = Get-HBStatisticsSnapshot $registry $previous
        Test-HBStatisticsSnapshot $snapshot
        Assert-HBStatisticsRegistryBinding $snapshot $registry
        if (Test-Path -LiteralPath $snapshotPath) {
            $old = Read-HBJson $snapshotPath
            Test-HBStatisticsSnapshot $old
            if ((Get-HBStatisticsFingerprint $old) -ceq (Get-HBStatisticsFingerprint $snapshot)) {
                Write-Host 'CURRENT: unchanged evidence; original data date retained.'
                exit 0
            }
        }
        if ($CheckOnly) { Write-Host 'DRIFT: new evidence available.'; exit 1 }
        if ($PSCmdlet.ShouldProcess($snapshotPath, 'Write public evidence snapshot')) {
            Write-HBManagedTextAtomic -Root $root -RelativePath $snapshotRelative -Content (ConvertTo-HBJson $snapshot)
        }
        Write-Host 'COLLECTED: candidate validated; run Render next.'
        exit 0
    }
    $snapshot = Read-HBJson $snapshotPath
    Test-HBStatisticsSnapshot $snapshot
    Assert-HBStatisticsRegistryBinding $snapshot $registry
    $aggregate = if ($snapshot.ruleVersion -ge 2) {
        $aggregatePath = Get-HBManagedPath -Root $root -RelativePath 'docs/spec-kit-runs/private-aggregate.json'
        Read-HBJson $aggregatePath
    } else { $null }
    if ($snapshot.ruleVersion -ge 2) { Assert-HBPrivateAggregate $aggregate }
    if ($Action -eq 'Validate') { Write-Host 'PASS: public snapshot, register and applicable private aggregate.'; exit 0 }
    $de = Get-HBStatisticsTable $snapshot de $aggregate -TableFormat $TableFormat
    $en = Get-HBStatisticsTable $snapshot en $aggregate -TableFormat $TableFormat
    $outputs = [ordered]@{}
    $managedOutputs = @(
        'README.md',
        'README.en.md',
        'docs/spec-kit-runs/table.md',
        'docs/spec-kit-runs/table.en.md',
        'docs/spec-kit-runs/review-queue.md',
        'docs/spec-kit-runs/publication.json'
    )
    foreach ($relativeOutput in $managedOutputs) {
        $null = Get-HBManagedPath -Root $root -RelativePath $relativeOutput
    }
    # Compute every result before writing any file, so malformed markers cannot cause a partial render.
    foreach ($pair in @(@('README.md', $de), @('README.en.md', $en))) {
        $path = Join-Path $root $pair[0]
        $relativePath = [IO.Path]::GetRelativePath($root, $path).Replace('\', '/')
        $outputs[$path] = Set-HBStatisticsBlock (Read-HBManagedText -Root $root -RelativePath $relativePath) $pair[1]
    }
    $outputs[(Join-Path $data 'table.md')] = $de
    $outputs[(Join-Path $data 'table.en.md')] = $en
    $outputs[(Join-Path $data 'review-queue.md')] = Get-HBStatisticsReviewReport $snapshot
    $publication = [ordered]@{
        schemaVersion = $snapshot.schemaVersion; collectedAt = $snapshot.collectedAt
        snapshotSha256 = Get-HBTextHash (ConvertTo-HBJson $snapshot)
        tableSha256 = Get-HBTextHash $de; tableEnSha256 = Get-HBTextHash $en
    }
    if ($TableFormat -eq 'AccessibleHtml') { $publication['tableFormat'] = 'accessible-html-v1' }
    $outputs[(Join-Path $data 'publication.json')] = ConvertTo-HBJson $publication
    $drift = $false
    $contentByRelativePath = [ordered]@{}
    foreach ($path in $outputs.Keys) {
        $relativePath = [IO.Path]::GetRelativePath($root, $path).Replace('\', '/')
        $contentByRelativePath[$relativePath] = $outputs[$path]
        if ((Test-Path -LiteralPath $path) -and (Read-HBManagedText -Root $root -RelativePath $relativePath) -ceq $outputs[$path]) { continue }
        $drift = $true
        if ($CheckOnly) { Write-Host "DRIFT: $([IO.Path]::GetRelativePath($root, $path))" }
    }
    if ($CheckOnly -and $drift) { exit 1 }
    if ($drift -and -not $CheckOnly -and $PSCmdlet.ShouldProcess($root, 'Render public statistics output set')) {
        Write-HBManagedTextSetAtomic -Root $root -ContentByRelativePath $contentByRelativePath
    }
    Write-Host 'PASS: public statistics rendering.'
} catch {
    Write-Error $_.Exception.Message -ErrorAction Continue
    exit 2
}
