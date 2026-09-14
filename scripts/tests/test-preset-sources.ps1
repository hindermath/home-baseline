<#
.SYNOPSIS
Prueft veroeffentlichte Preset-Pakete in temporaeren Projekten.
Tests published preset packages in temporary projects.
.DESCRIPTION
Laedt ausschliesslich die hashgebundenen GitHub-Archive der Quellenliste,
prueft Tag/Commit-Bindung, Profile 8 bis 14 und die Assurance-Vertraege. Bestehende Installationen
werden weder gelesen noch veraendert. Temporaere Projekte werden entfernt.
Downloads only hash-bound GitHub archives, verifies tag/commit bindings, tests profiles 8 through 14 and
assurance contracts, and removes temporary projects without touching installations.
.EXAMPLE
pwsh -NoProfile -File scripts/tests/test-preset-sources.ps1
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$temporaryRoot = Join-Path ([IO.Path]::GetTempPath()) ('preset-source-test-' + [guid]::NewGuid().ToString('N'))
$originalLocation = Get-Location

function Invoke-PresetTestCommand {
    param([string]$Command, [string[]]$Arguments)
    $output = & $Command @Arguments 2>&1
    if ($LASTEXITCODE -ne 0) { throw "$Command failed: $($output -join "`n")" }
    return $output
}

try {
    $null = New-Item -ItemType Directory -Path $temporaryRoot
    $lock = Get-Content (Join-Path $repo 'docs/maintenance/preset-source-lock.json') -Raw | ConvertFrom-Json
    $profiles = Get-Content (Join-Path $repo 'scripts/config/spec-kit-preset-profiles.json') -Raw | ConvertFrom-Json
    if ($profiles.defaultProfile -cne 'standard-eight-governance-presets') { throw 'Statistics pilot must not change the default profile.' }
    $assuranceMatrix = Get-Content (Join-Path $repo $profiles.profiles.'secure-development-assurance-thirteen-governance-presets'.presetConfig) -Raw | ConvertFrom-Json
    $statisticsMatrix = Get-Content (Join-Path $repo $profiles.profiles.'project-statistics-fourteen-governance-presets'.presetConfig) -Raw | ConvertFrom-Json
    # DE: Der Pilot darf nur additiv sein; alle 13 bestehenden Eintraege bleiben gleich.
    # EN: The pilot is additive only; preserve all thirteen existing entries exactly.
    if (@($assuranceMatrix.presets).Count -ne 13 -or @($statisticsMatrix.presets).Count -ne 14 -or
        (ConvertTo-Json -InputObject @($statisticsMatrix.presets[0..12]) -Depth 10 -Compress) -cne
        (ConvertTo-Json -InputObject @($assuranceMatrix.presets) -Depth 10 -Compress)) { throw 'Statistics profile changed the thirteen-preset base.' }
    $statisticsPreset = $statisticsMatrix.presets[13]
    if ($statisticsPreset.id -cne 'project-statistics-governance' -or $statisticsPreset.version -cne 'v0.1.0' -or $statisticsPreset.priority -ne 90) { throw 'Unexpected statistics pilot version or priority.' }
    $packages = @{}
    if (@($lock.presets).Count -ne 14) { throw 'Expected exactly 14 source bindings, including the optional statistics pilot.' }
    foreach ($preset in $lock.presets) {
        if ($preset.id -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$' -or $packages.ContainsKey($preset.id)) { throw 'Invalid or duplicate preset ID.' }
        if ($preset.tag -notmatch '^v\d+\.\d+\.\d+$' -or $preset.commit -notmatch '^[a-f0-9]{40}$' -or $preset.archiveSha256 -notmatch '^[a-f0-9]{64}$') { throw 'Invalid source binding.' }
        $expectedRepository = 'https://github.com/hindermath/spec-kit-preset-' + $preset.id
        if ($preset.repository -cne $expectedRepository -or $preset.archiveUrl -cne "$expectedRepository/archive/refs/tags/$($preset.tag).zip") { throw 'Unexpected package source.' }
        $tagRef = "refs/tags/$($preset.tag)"
        $remoteRefs = @(Invoke-PresetTestCommand git @('ls-remote','--exit-code',$preset.repository,$tagRef,"$tagRef^{}"))
        $tagTargets = @{}
        foreach ($line in $remoteRefs) {
            $parts = $line.ToString() -split '\s+', 2
            if ($parts.Count -ne 2 -or $parts[0] -notmatch '^[a-f0-9]{40}$') { throw 'Invalid remote tag response.' }
            $tagTargets[$parts[1]] = $parts[0]
        }
        $tagCommit = if ($tagTargets.ContainsKey("$tagRef^{}")) { $tagTargets["$tagRef^{}"] } else { $tagTargets[$tagRef] }
        if ($tagCommit -cne $preset.commit) { throw "Tag/commit drift: $($preset.id)" }
        $zip = Join-Path $temporaryRoot ($preset.id + '.zip')
        Invoke-WebRequest -Uri $preset.archiveUrl -OutFile $zip
        if ((Get-FileHash $zip -Algorithm SHA256).Hash.ToLowerInvariant() -cne $preset.archiveSha256) { throw "Archive drift: $($preset.id)" }
        # DE: Erst nach Hashpruefung entpacken und Paketcode ausfuehren.
        # EN: Extract and execute package code only after verifying its hash.
        $destination = Join-Path $temporaryRoot $preset.id
        Expand-Archive -LiteralPath $zip -DestinationPath $destination
        $roots = @(Get-ChildItem -LiteralPath $destination -Directory)
        if ($roots.Count -ne 1) { throw 'Expected a single package root.' }
        $packages[$preset.id] = @{root=$roots[0].FullName; binding=$preset}
    }
    foreach ($presetProfile in $profiles.profiles.PSObject.Properties) {
        if (-not $presetProfile.Value.presetConfig) { continue }
        $matrix = Get-Content (Join-Path $repo $presetProfile.Value.presetConfig) -Raw | ConvertFrom-Json
        $project = Join-Path $temporaryRoot $presetProfile.Name
        $null = New-Item -ItemType Directory -Path (Join-Path $project '.specify'), (Join-Path $project '.agents/skills') -Force
        Set-Location $project
        $null = Invoke-PresetTestCommand git @('init','--quiet')
        foreach ($preset in $matrix.presets) {
            $package = $packages[$preset.id]
            if (-not $package -or $preset.version -cne $package.binding.tag -or $preset.archiveUrl -cne $package.binding.archiveUrl) { throw "Profile source drift: $($preset.id)" }
            $null = Invoke-PresetTestCommand specify @('preset','add','--dev',$package.root,'--priority',[string]$preset.priority)
        }
        $registry = Get-Content '.specify/presets/.registry' -Raw | ConvertFrom-Json -AsHashtable
        if ($registry.presets.Count -ne @($matrix.presets).Count) { throw 'Installed profile count mismatch.' }
        foreach ($preset in $matrix.presets) {
            $installed = $registry.presets[$preset.id]
            if ($installed.version -cne $preset.version.TrimStart('v') -or $installed.priority -ne $preset.priority -or -not $installed.enabled) { throw "Installed profile mismatch: $($preset.id)" }
            $null = Invoke-PresetTestCommand specify @('preset','info',$preset.id)
        }
        $null = Invoke-PresetTestCommand specify @('preset','list')
        $null = Invoke-PresetTestCommand specify @('preset','resolve','constitution-template')
        if ($registry.presets.ContainsKey('secure-development-assurance-governance')) {
            $null = Invoke-PresetTestCommand specify @('preset','resolve','secure-development-evidence-contract')
        }
        if ($registry.presets.ContainsKey('project-statistics-governance')) {
            $null = Invoke-PresetTestCommand specify @('preset','resolve','project-statistics-contract')
        }
        $matrixPath = Join-Path $repo $presetProfile.Value.presetConfig
        $bashArgs = @((Join-Path $repo 'scripts/install-spec-kit-governance-presets.sh'),'--repo',$project,'--preset-config',$matrixPath,'--check-only')
        $pwshArgs = @('-NoProfile','-File',(Join-Path $repo 'scripts/install-spec-kit-governance-presets.ps1'),'-Repo',$project,'-PresetConfig',$matrixPath,'-CheckOnly')
        if ($IsWindows) {
            $null = Invoke-PresetTestCommand pwsh $pwshArgs
            $null = Invoke-PresetTestCommand bash $bashArgs
        } else {
            $null = Invoke-PresetTestCommand bash $bashArgs
            $null = Invoke-PresetTestCommand pwsh $pwshArgs
        }
        Write-Output "PASS profile $($presetProfile.Name): $($registry.presets.Count) presets"
    }
    Set-Location $temporaryRoot
    $assuranceRoot = $packages['secure-development-assurance-governance'].root
    foreach ($test in @('test-secure-development-assurance.ps1','test-installed-surfaces.ps1')) {
        $output = Invoke-PresetTestCommand pwsh @('-NoProfile','-File',(Join-Path $assuranceRoot "tests/$test"))
        Write-Output $output
    }
    $statisticsRoot = $packages['project-statistics-governance'].root
    $output = Invoke-PresetTestCommand pwsh @('-NoProfile','-File',(Join-Path $statisticsRoot 'tests/test-installed-preset.ps1'),'-Package',$statisticsRoot)
    Write-Output $output
    Write-Output 'PASS: 14 verified packages; profiles 8-14; assurance and statistics generated commands.'
} finally {
    Set-Location $originalLocation
    if (Test-Path -LiteralPath $temporaryRoot) { Remove-Item -LiteralPath $temporaryRoot -Recurse -Force }
}
