<#
.SYNOPSIS
Prueft veroeffentlichte Preset-Pakete in temporaeren Projekten.
Tests published preset packages in temporary projects.
.DESCRIPTION
Laedt ausschliesslich die hashgebundenen GitHub-Archive der Quellenliste,
prueft Profile 8 bis 13 und die Assurance-Vertraege. Bestehende Installationen
werden weder gelesen noch veraendert. Temporaere Projekte werden entfernt.
Downloads only hash-bound GitHub archives, tests profiles 8 through 13 and
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
    $packages = @{}
    if (@($lock.presets).Count -ne 13) { throw 'Expected exactly 13 source bindings.' }
    foreach ($preset in $lock.presets) {
        if ($preset.id -notmatch '^[a-z0-9]+(-[a-z0-9]+)*$' -or $packages.ContainsKey($preset.id)) { throw 'Invalid or duplicate preset ID.' }
        if ($preset.tag -notmatch '^v\d+\.\d+\.\d+$' -or $preset.commit -notmatch '^[a-f0-9]{40}$' -or $preset.archiveSha256 -notmatch '^[a-f0-9]{64}$') { throw 'Invalid source binding.' }
        $expectedRepository = 'https://github.com/hindermath/spec-kit-preset-' + $preset.id
        if ($preset.repository -cne $expectedRepository -or $preset.archiveUrl -cne "$expectedRepository/archive/refs/tags/$($preset.tag).zip") { throw 'Unexpected package source.' }
        $zip = Join-Path $temporaryRoot ($preset.id + '.zip')
        Invoke-WebRequest -Uri $preset.archiveUrl -OutFile $zip
        if ((Get-FileHash $zip).Hash.ToLowerInvariant() -cne $preset.archiveSha256) { throw "Archive drift: $($preset.id)" }
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
        Write-Output "PASS profile $($presetProfile.Name): $($registry.presets.Count) presets"
    }
    Set-Location $temporaryRoot
    $assuranceRoot = $packages['secure-development-assurance-governance'].root
    foreach ($test in @('test-secure-development-assurance.ps1','test-installed-surfaces.ps1')) {
        $output = Invoke-PresetTestCommand pwsh @('-NoProfile','-File',(Join-Path $assuranceRoot "tests/$test"))
        Write-Output $output
    }
    Write-Output 'PASS: 13 verified packages; profiles 8-13; assurance parity and generated commands.'
} finally {
    Set-Location $originalLocation
    if (Test-Path -LiteralPath $temporaryRoot) { Remove-Item -LiteralPath $temporaryRoot -Recurse -Force }
}
