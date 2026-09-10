#Requires -Version 7
<#
.SYNOPSIS
Erhebt und rendert öffentliche Spec-Kit-Laufzahlen. / Collects and renders public Spec Kit run counts.
.DESCRIPTION
Collect reads public GitHub evidence using gh. Validate and Render replay the versioned
snapshot without network access. Only marked README blocks and report files are generated.
Collect liest öffentliche GitHub-Belege; Validate/Render arbeiten offline. Kein Commit, Push oder Merge.
.PARAMETER Action
Collect, Validate or Render. / Erheben, prüfen oder erzeugen.
.PARAMETER Repo
Level-0 checkout; defaults to the shared source resolver. / Gemeinsame Level-0-Quellauflösung.
.PARAMETER CheckOnly
Read-only validation/drift check. / Schreibfreie Validierung/Driftprüfung.
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
    [switch]$CheckOnly
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
Import-Module (Join-Path $PSScriptRoot 'lib/public-speckit-statistics.psm1') -Force
try {
    if (-not $PSBoundParameters.ContainsKey('Repo')) {
        . (Join-Path $PSScriptRoot 'lib/resolve-home-baseline-source.ps1')
        $Repo = Resolve-HBSourceRepository -StartPath $PSScriptRoot
    }
    $root = [IO.Path]::GetFullPath($Repo)
    $data = Join-Path $root 'docs/spec-kit-runs'
    $registry = Read-HBJson (Join-Path $data 'registry.json')
    Assert-HBRegistry $registry
    $snapshotPath = Join-Path $data 'snapshot.json'
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
            [IO.File]::WriteAllText($snapshotPath, (ConvertTo-HBJson $snapshot), [Text.UTF8Encoding]::new($false))
        }
        Write-Host 'COLLECTED: candidate validated; run Render next.'
        exit 0
    }
    $snapshot = Read-HBJson $snapshotPath
    Test-HBStatisticsSnapshot $snapshot
    Assert-HBStatisticsRegistryBinding $snapshot $registry
    if ($Action -eq 'Validate') { Write-Host 'PASS: public snapshot and register.'; exit 0 }
    $de = Get-HBStatisticsTable $snapshot de; $en = Get-HBStatisticsTable $snapshot en
    $outputs = [ordered]@{}
    # Compute every result before writing any file, so malformed markers cannot cause a partial render.
    foreach ($pair in @(@('README.md', $de), @('README.en.md', $en))) {
        $path = Join-Path $root $pair[0]
        $outputs[$path] = Set-HBStatisticsBlock ([IO.File]::ReadAllText($path)) $pair[1]
    }
    $outputs[(Join-Path $data 'table.md')] = $de
    $outputs[(Join-Path $data 'table.en.md')] = $en
    $outputs[(Join-Path $data 'review-queue.md')] = Get-HBStatisticsReviewReport $snapshot
    $outputs[(Join-Path $data 'publication.json')] = ConvertTo-HBJson ([ordered]@{
        schemaVersion = 1; collectedAt = $snapshot.collectedAt
        snapshotSha256 = Get-HBTextHash (ConvertTo-HBJson $snapshot)
        tableSha256 = Get-HBTextHash $de; tableEnSha256 = Get-HBTextHash $en
    })
    $drift = $false
    foreach ($path in $outputs.Keys) {
        if ((Test-Path -LiteralPath $path) -and [IO.File]::ReadAllText($path) -ceq $outputs[$path]) { continue }
        $drift = $true
        if ($CheckOnly) { Write-Host "DRIFT: $([IO.Path]::GetRelativePath($root, $path))" }
        elseif ($PSCmdlet.ShouldProcess($path, 'Render public statistics')) { [IO.File]::WriteAllText($path, $outputs[$path], [Text.UTF8Encoding]::new($false)) }
    }
    if ($CheckOnly -and $drift) { exit 1 }
    Write-Host 'PASS: public statistics rendering.'
} catch {
    Write-Error $_.Exception.Message -ErrorAction Continue
    exit 2
}
