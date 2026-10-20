<#
.SYNOPSIS
DE: Prueft GSDB-Drift und Profilbindung in isolierten Fixtures.
EN: Tests GSDB drift and profile binding in isolated fixtures.
.DESCRIPTION
DE: Fuehrt Bash zuerst und danach PowerShell aus. Negative Fixtures aendern nur
Kopien im Temp-Verzeichnis; keine Installation, kein Netzwerk, keine Home-Aenderung.
EN: Runs Bash first, then PowerShell. Negative fixtures change temporary copies
only; no installation, network access, or Home modification.
.EXAMPLE
pwsh -NoProfile -File scripts/tests/test-gsdb-consolidation.ps1
#>
[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$repo = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$temp = Join-Path ([IO.Path]::GetTempPath()) ('gsdb-regression-' + [guid]::NewGuid().ToString('N'))
$utf8 = [Text.UTF8Encoding]::new($false)
function Set-FixtureText {
    param([string]$Path, [string]$Text)
    [IO.File]::WriteAllText($Path, $Text, $utf8)
}
function Invoke-FixtureCommand {
    param([string]$Command, [string[]]$Arguments, [bool]$Success, [string]$Expected)
    $output = (& $Command @Arguments 2>&1 | Out-String)
    $code = $LASTEXITCODE
    if (($code -eq 0) -ne $Success -or ($Expected -and -not $output.Contains($Expected))) {
        throw "Unexpected ${Command} exit ${code}; expected text '${Expected}': ${output}"
    }
}
try {
    $seed = Join-Path $temp 'seed'
    New-Item -ItemType Directory -Force (Join-Path $seed 'docs'), (Join-Path $seed 'scripts') | Out-Null
    Copy-Item (Join-Path $repo 'docs/secure-development') (Join-Path $seed 'docs') -Recurse
    Copy-Item (Join-Path $repo 'scripts/config') (Join-Path $seed 'scripts') -Recurse
    Copy-Item (Join-Path $repo 'scripts/templates') (Join-Path $seed 'scripts') -Recurse
    Copy-Item (Join-Path $repo 'scripts/lib') (Join-Path $seed 'scripts') -Recurse
    foreach ($name in @('build-secure-development-docs','check-gsdb-self-assessment','install-spec-kit-governance-presets')) {
        foreach ($extension in @('sh','ps1')) { Copy-Item (Join-Path $repo "scripts/${name}.${extension}") (Join-Path $seed 'scripts') }
    }
    $shells = if ($IsWindows) { @('pwsh') } else { @('bash','pwsh') }
    foreach ($shell in $shells) {
        if (-not (Get-Command $shell -ErrorAction SilentlyContinue)) { throw "Required shell missing: ${shell}" }
        foreach ($case in @('valid','missing','duplicate-item','duplicate-id','version','baseline','profile-doc','compendium','matrix','manifest-version','priority','profile-unknown','profile-registry','manifest-crlf')) {
            $fixture = Join-Path $temp "${shell}-${case}"
            Copy-Item $seed $fixture -Recurse
            & git -C $fixture init --quiet
            if ($LASTEXITCODE -ne 0) { throw 'Fixture git init failed.' }
            $docRoot = Join-Path $fixture 'docs/secure-development'
            $manifestPath = Join-Path $docRoot 'baseline-manifest.json'
            $manifest = Get-Content $manifestPath -Raw | ConvertFrom-Json -AsHashtable
            $config = Get-Content (Join-Path $fixture 'scripts/config/spec-kit-project-statistics-governance-presets.json') -Raw | ConvertFrom-Json -AsHashtable
            $presetRoot = Join-Path $fixture '.specify/presets'
            New-Item -ItemType Directory -Force $presetRoot | Out-Null
            $installed = @{schema_version='1.0';presets=@{}}
            foreach ($entry in $config.presets) {
                $id = $entry.id
                $version = $entry.version.TrimStart('v')
                New-Item -ItemType Directory (Join-Path $presetRoot $id) | Out-Null
                Set-FixtureText (Join-Path $presetRoot "${id}/preset.yml") "preset:`n  id: `"${id}`"`n  version: `"${version}`"`n"
                $installed.presets[$id] = @{version=$version;priority=$entry.priority;enabled=$true}
            }
            $registry = @{schemaVersion=1;repositories=@(@{path=$fixture;level=2;primaryLanguage='C#';mslStatus='msl';gsdbRequired=$true;presetProfile='project-statistics-fourteen-governance-presets'})}
            $registryPath = Join-Path $fixture 'fixture-registry.json'
            Set-FixtureText $registryPath ($registry | ConvertTo-Json -Depth 8)
            switch ($case) {
                'missing' { Remove-Item (Join-Path $docRoot $manifest.relatedDocuments[0].path) }
                'duplicate-item' { $path=Join-Path $docRoot $manifest.checklists[0].path; Add-Content $path '#### CL-01-01: Duplicate fixture' }
                'duplicate-id' { $manifest.checklists[1].id = 'CL-01' }
                'version' { $manifest.checklists[0].version = '999.0.0' }
                'baseline' {
                    $path = Join-Path $docRoot $manifest.checklists[0].path
                    $source = Get-Content $path -Raw
                    $header = "**Baseline-Version / Baseline version:** $($manifest.baselineVersion)"
                    # Bind the mutation to the manifest so a later release cannot silently turn this negative case into a no-op.
                    if (-not $source.Contains($header)) { throw 'Baseline fixture header not found.' }
                    $staleVersion = if ($manifest.baselineVersion -eq '0.0.0') { '0.0.1' } else { '0.0.0' }
                    Set-FixtureText $path ($source.Replace($header, "**Baseline-Version / Baseline version:** ${staleVersion}"))
                }
                'profile-doc' { $path=Join-Path $docRoot 'mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md'; Set-FixtureText $path ((Get-Content $path -Raw).Replace('project-statistics-fourteen-governance-presets','removed-profile')) }
                'compendium' { Add-Content (Join-Path $docRoot $manifest.compendium.path) 'drift' }
                'matrix' { $installed.presets.Remove('secure-development-assurance-governance') }
                'manifest-version' { Set-FixtureText (Join-Path $presetRoot 'security-governance/preset.yml') "preset:`n  id: `"security-governance`"`n  version: `"0.0.0`"`n" }
                'manifest-crlf' { foreach ($entry in $config.presets) { $path=Join-Path $presetRoot ($entry.id + '/preset.yml'); Set-FixtureText $path ((Get-Content $path -Raw).Replace("`n","`r`n")) } }
                'priority' { $installed.presets['security-governance'].priority = 999 }
            }
            Set-FixtureText $manifestPath ($manifest | ConvertTo-Json -Depth 12)
            Set-FixtureText (Join-Path $presetRoot '.registry') ($installed | ConvertTo-Json -Depth 8)
            $isProfile = $case -in @('matrix','manifest-version','priority','profile-unknown','profile-registry','manifest-crlf')
            $script = if ($isProfile) { 'check-gsdb-self-assessment' } else { 'build-secure-development-docs' }
            $file = (Join-Path $fixture "scripts/${script}").Replace('\','/')
            if ($shell -eq 'bash') {
                $arguments = @("${file}.sh",'--check')
                if ($isProfile) { $arguments = @("${file}.sh",'--repo',$fixture,'--registry',$registryPath,'--check-only'); if ($case -eq 'profile-unknown') { $arguments += @('--preset-profile','missing-profile') } }
            } else {
                $arguments = @('-NoProfile','-File',"${file}.ps1",'-Check')
                if ($isProfile) { $arguments = @('-NoProfile','-File',"${file}.ps1",'-Repo',$fixture,'-Registry',$registryPath,'-CheckOnly'); if ($case -eq 'profile-unknown') { $arguments += @('-PresetProfile','missing-profile') } }
            }
            $before = @(Get-ChildItem $fixture -File -Recurse -Force | Sort-Object FullName | ForEach-Object { $_.FullName + ':' + (Get-FileHash $_.FullName -Algorithm SHA256).Hash }) -join "`n"
            $success = $case -in @('valid','matrix','manifest-version','priority','profile-registry','manifest-crlf')
            $expected = switch ($case) { 'valid' { 'generated documents are current' } 'profile-registry' { '14 Presets' } 'manifest-crlf' { '14 Presets' } 'matrix' { 'Matrixabweichung' } 'manifest-version' { 'Matrixabweichung' } 'priority' { 'Matrixabweichung' } default { '' } }
            Invoke-FixtureCommand $shell $arguments $success $expected
            $after = @(Get-ChildItem $fixture -File -Recurse -Force | Sort-Object FullName | ForEach-Object { $_.FullName + ':' + (Get-FileHash $_.FullName -Algorithm SHA256).Hash }) -join "`n"
            if ($before -cne $after) { throw "Read-only mutation in ${shell}/${case}" }
            Write-Output "PASS ${shell}: ${case} (read-only)"
        }
    }
} finally { if (Test-Path $temp) { Remove-Item $temp -Recurse -Force } }
