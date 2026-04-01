# check-homogeneity.ps1 — Workspace Homogeneity Guardian Compliance Scanner v1.0 (PowerShell)
# FR-001 through FR-006, FR-016-FR-019

[CmdletBinding()]
param(
    [string]$TargetDir = $env:HOME,
    [switch]$Json,
    [switch]$DryRun,
    [string]$ApplyPatch = '',
    [switch]$NoPatch,
    [switch]$FailFast,
    [switch]$Yes
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$LibDir    = Join-Path $ScriptDir 'lib'

# Source all hg-*.ps1 libs
Get-ChildItem -Path $LibDir -Filter 'hg-*.ps1' -ErrorAction SilentlyContinue | ForEach-Object {
    . $_.FullName
}

# --json takes precedence
if ($Json) { $VerbosePreference = 'SilentlyContinue' }

$TargetDir = $TargetDir.TrimEnd([IO.Path]::DirectorySeparatorChar)
if (-not (Test-Path $TargetDir)) {
    Write-Error "FATAL: target directory not found: $TargetDir"
    exit 2
}

# Check ripgrep availability
if (-not (Get-Command rg -ErrorAction SilentlyContinue)) {
    Write-Error "FATAL: ripgrep (rg) not found"
    exit 2
}

# ─── Apply-Patch Mode ────────────────────────────────────────────────────────
if ($ApplyPatch) {
    if (-not (Test-Path $ApplyPatch)) {
        Write-Error "FATAL: patch file not found: $ApplyPatch"
        exit 2
    }
    $content = Get-Content $ApplyPatch
    Write-Host "Patch-Datei: $ApplyPatch"
    Write-Host ""
    Write-Host "Vorgeschlagene Aenderungen:"
    $content | Select-String '^\#\#|^- |^\*\*' | Select-Object -First 30 | ForEach-Object { Write-Host $_.Line }
    Write-Host ""

    $answer = if ($Yes) { 'j' } else { Read-Host "Patch anwenden? [j/N]" }
    if ($answer -match '^[jJyY]') {
        $patchCount = 0
        $targetFile = ''
        foreach ($line in $content) {
            if ($line -match '### Target: (.+)') { $targetFile = $Matches[1] }
            if ($line -match '^\+\+\+ (.+)' -and $targetFile) {
                Add-Content -Path $targetFile -Value $Matches[1]
                $patchCount++
            }
        }
        git -C $TargetDir add -A 2>$null
        git -C $TargetDir commit -m "chore: apply memory-patch -- $patchCount entries updated" 2>$null
        Write-Host "Patch angewendet: $patchCount Eintraege, git-Commit erstellt."
    } else {
        Write-Host "Patch abgebrochen."
    }
    exit 0
}

# ─── Scan State ──────────────────────────────────────────────────────────────
$Failures  = [System.Collections.Generic.List[string]]::new()
$Warnings  = [System.Collections.Generic.List[string]]::new()
$DirTotal  = @{}
$DirPass   = @{}
$ScanDirs  = [System.Collections.Generic.List[string]]::new()
$TotalChecks = 0
$TotalPass   = 0

$RequiredFiles = @('AGENTS.md','CLAUDE.md','GEMINI.md','README.md','STATS.md')

function Emit-Result {
    param([string]$Status, [string]$FilePath, [string]$Message, [string]$Dir)
    $script:TotalChecks++
    $script:DirTotal[$Dir] = ($script:DirTotal[$Dir] ?? 0) + 1

    if ($Status -eq 'PASS') {
        $script:TotalPass++
        $script:DirPass[$Dir] = ($script:DirPass[$Dir] ?? 0) + 1
        if (-not $Json -and $VerbosePreference -ne 'SilentlyContinue') {
            Write-Host ("  {0,-4} {1,-40} {2}" -f '✓', $FilePath, $Message)
        }
    } elseif ($Status -eq 'WARN') {
        $script:Warnings.Add("${FilePath}:${Message}")
        if (-not $Json) {
            Write-Host ("  {0,-4} {1,-40} WARN: {2}" -f 'WARN', $FilePath, $Message)
        }
    } elseif ($Status -eq 'FAIL') {
        $script:Failures.Add("${FilePath}:${Message}")
        if (-not $Json) {
            Write-Host ("  {0,-4} {1,-40} FAIL: {2}" -f '✗', $FilePath, $Message)
        }
        if ($FailFast) {
            Write-Error "FAIL-FAST: aborted at first FAIL"
            exit 1
        }
    }
}

# ─── Header ──────────────────────────────────────────────────────────────────
if (-not $Json) {
    Write-Host "Workspace Homogeneity Guardian — check-homogeneity v1.0"
    Write-Host "Scan-Startpunkt: $TargetDir"
    Write-Host ('=' * 54)
    Write-Host ""
}

# ─── Main Scan ───────────────────────────────────────────────────────────────
$scanResults = Invoke-HgScan -TargetDir $TargetDir
$WorkspacesCount = 0
$ProjectsCount   = 0

foreach ($entry in $scanResults) {
    $dir   = $entry.Path
    $level = $entry.Level

    $ScanDirs.Add($dir)
    $DirTotal[$dir] = 0
    $DirPass[$dir]  = 0

    if ($level -eq 1) { $WorkspacesCount++ }
    if ($level -eq 2) { $ProjectsCount++ }

    if (-not $Json) {
        Write-Host "[Level $level] ${dir}/"
    }

    # Required files
    foreach ($f in $RequiredFiles) {
        $full = Join-Path $dir $f
        if (Test-Path $full) {
            Emit-Result 'PASS' $f 'file present' $dir

            # Bilingual
            $bil = Invoke-HgCheckBilingual -FilePath $full
            if ($bil) { Emit-Result $bil.Status $f $bil.Message $dir }

            # A11Y
            Invoke-HgCheckA11y -FilePath $full | ForEach-Object {
                Emit-Result $_.Status $f $_.Message $dir
            }

            # Secrets
            Invoke-HgScanFileSecrets -FilePath $full | ForEach-Object {
                Emit-Result $_.Status $f $_.Message $dir
            }
        } else {
            Emit-Result 'FAIL' $f 'file missing' $dir
        }
    }

    # Hook check
    if ($level -ge 1) {
        $hook = Invoke-HgCheckHook -Dir $dir
        if ($hook) { Emit-Result $hook.Status '.git/hooks/pre-push' $hook.Message $dir }
    }

    if ($level -eq 0) {
        $canonicalHook = Join-Path $env:HOME 'scripts/hooks/pre-push'
        if (Test-Path $canonicalHook) {
            Emit-Result 'PASS' 'scripts/hooks/pre-push' 'canonical hook present' $dir
        } else {
            Emit-Result 'WARN' 'scripts/hooks/pre-push' 'canonical hook missing' $dir
        }
    }

    # Deps + speckit for projects
    if ($level -eq 2) {
        Invoke-HgCheckDeps -Dir $dir | ForEach-Object {
            Emit-Result $_.Status '*.csproj' $_.Message $dir
        }
        $specFile = Get-ChildItem -Path (Join-Path $dir 'specs') -Filter 'spec.md' -Recurse -Depth 3 -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($specFile) {
            $sk = Invoke-HgCheckSpeckit -SpecFile $specFile.FullName
            if ($sk) { Emit-Result $sk.Status 'specs/spec.md' $sk.Message $dir }
        }
    }

    if (-not $Json) { Write-Host "" }
}

# ─── Summary ─────────────────────────────────────────────────────────────────
$OverallScore = if ($TotalChecks -gt 0) { [int](($TotalPass * 100) / $TotalChecks) } else { 0 }

if ($Json) {
    $obj = [PSCustomObject]@{
        score               = $OverallScore
        workspaces_scanned  = $WorkspacesCount
        projects_scanned    = $ProjectsCount
        failures            = @($Failures | ForEach-Object {
            $parts = $_ -split ':', 2
            [PSCustomObject]@{ path = $parts[0]; check = $parts[1] }
        })
        warnings            = @($Warnings | ForEach-Object {
            $parts = $_ -split ':', 2
            [PSCustomObject]@{ path = $parts[0]; check = $parts[1] }
        })
        stats_updated       = if ($DryRun) { $null } else { "$env:HOME/STATS.md" }
        patch_generated     = $null
    }
    $obj | ConvertTo-Json -Compress
} else {
    Write-Host ('=' * 54)
    Write-Host "COMPLIANCE SUMMARY"
    Write-Host ""

    foreach ($d in $ScanDirs) {
        $lt = $DirTotal[$d] ?? 0
        $lp = $DirPass[$d] ?? 0
        $ls = if ($lt -gt 0) { [int](($lp * 100) / $lt) } else { 0 }
        $filled = [int]($ls * 10 / 100)
        $bar = ('█' * $filled) + ('░' * (10 - $filled))
        $shortName = $d -replace [regex]::Escape($env:HOME), '~'
        Write-Host ("{0,-30} [{1}] {2,3} %  ({3}/{4} checks)" -f $shortName, $bar, $ls, $lp, $lt)
    }

    Write-Host ""
    Write-Host ("Overall: $OverallScore %  |  Workspaces: $WorkspacesCount  |  Projects: $ProjectsCount")

    if (-not $DryRun) {
        Write-Host "STATS.md updated: $env:HOME/STATS.md"
    }

    $fc = $Failures.Count; $wc = $Warnings.Count
    Write-Host ""
    if ($fc -gt 0 -or $wc -gt 0) {
        Write-Host "Exit code: 1 ($fc FAIL, $wc WARN)"
    } else {
        Write-Host "Exit code: 0 (all checks passed)"
    }
}

# Exit code
if ($Failures.Count -gt 0 -or $Warnings.Count -gt 0) { exit 1 }
exit 0
