#Requires -Version 7
<#
.SYNOPSIS
    Prüft git-getrackte Dateien auf Secret-Muster.
.DESCRIPTION
    Scannt ausschließlich Dateien, die 'git ls-files' kennt (.gitignore wird respektiert).
    Kann manuell oder als Bestandteil eines CI-Checks aufgerufen werden.

    Verwendung:
        pwsh scripts/scan-agent-secrets.ps1
        pwsh scripts/scan-agent-secrets.ps1 -FailOnHigh
        pwsh scripts/scan-agent-secrets.ps1 -Verbose
.PARAMETER FailOnHigh
    Beendet das Skript mit Exit-Code 2, wenn HIGH-Befunde vorliegen (für CI / pre-push).
.PARAMETER WorkspaceRoot
    Wurzelverzeichnis des Repositories. Standard: Verzeichnis dieses Skripts/../
#>
[CmdletBinding()]
param(
    [switch] $FailOnHigh,
    [string] $WorkspaceRoot = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# --- Konfiguration / Configuration ---------------------------------------------------

$SecretNamePatterns = @(
    'auth\.json',
    '^\.env(\.[^.]+)?$',
    '.*(secret|credential|creds).*\.(json|yaml|yml|xml|ini|cfg|conf|toml)$',
    '.*id_rsa.*',
    '\.(pem|key|p12|pfx)$'
)

$AllowedSecretNamePatterns = @(
    '^\.env\.(example|sample|template|dist)$'
)

$SecretContentPatterns = @(
    'id_token\s*[:=]\s*["'']?[A-Za-z0-9._~+/=-]{8,}',
    'access_token\s*[:=]\s*["'']?[A-Za-z0-9._~+/=-]{8,}',
    'refresh_token\s*[:=]\s*["'']?[A-Za-z0-9._~+/=-]{8,}',
    'api[_-]?key\s*[:=]\s*["'']?[A-Za-z0-9._~+/=-]{8,}',
    'client[_-]?secret\s*[:=]\s*["'']?[A-Za-z0-9._~+/=-]{8,}',
    'password\s*[:=]\s*["'']?[A-Za-z0-9._~+/=-]{8,}',
    '--api-key\s+\S{8,}',
    'authorization:\s*bearer\s+[A-Za-z0-9._~+/=-]{8,}',
    'bearer\s+[A-Za-z0-9._~+/=-]{20,}',
    '(^|[^A-Za-z0-9])sk-[A-Za-z0-9]{20,}',
    'ghp_[A-Za-z0-9]{20,}',
    'github_pat_[A-Za-z0-9_]{20,}',
    'AIza[0-9A-Za-z_-]{20,}',
    'AKIA[0-9A-Z]{16}',
    '-----BEGIN (RSA|OPENSSH|EC|DSA) PRIVATE KEY-----'
)

# --- Repository-Root ermitteln -------------------------------------------------------

$root = if ($WorkspaceRoot) {
    Resolve-Path $WorkspaceRoot
} else {
    Resolve-Path (Join-Path $PSScriptRoot '..')
}
$rootPath = $root.ProviderPath

Write-Verbose "Repository-Root: $rootPath"

# --- gitleaks: aktuelle Git-Aenderungen pruefen -------------------------------------

function Invoke-GitleaksWorktreeScan {
    param([string]$RepositoryRoot)

    $gitleaks = Get-Command gitleaks -ErrorAction SilentlyContinue
    if (-not $gitleaks) {
        Write-Host 'INFO  gitleaks nicht gefunden; Regex-Fallback bleibt aktiv.' -ForegroundColor Yellow
        return $false
    }

    & git -C $RepositoryRoot rev-parse --is-inside-work-tree *> $null
    if ($LASTEXITCODE -ne 0) {
        Write-Host 'INFO  gitleaks übersprungen; WorkspaceRoot ist kein Git-Repository.' -ForegroundColor Yellow
        return $false
    }

    & gitleaks git --redact --no-banner --no-color --log-level warn --exit-code 2 --pre-commit $RepositoryRoot
    if ($LASTEXITCODE -eq 0) {
        Write-Host 'OK    gitleaks: Keine Secrets im aktuellen Git-Diff gefunden.' -ForegroundColor Green
        return $false
    }

    Write-Host 'HIGH  gitleaks: Mögliche Secrets im aktuellen Git-Diff oder Scan-Fehler.' -ForegroundColor Red
    return $true
}

$gitleaksFoundHigh = Invoke-GitleaksWorktreeScan -RepositoryRoot $rootPath

# --- Nur git-getrackte Dateien laden -------------------------------------------------

$trackedRelative = & git -C $rootPath ls-files
if (-not $trackedRelative) {
    Write-Host 'Keine git-getrackten Dateien gefunden. Scan übersprungen.' -ForegroundColor Yellow
    exit 0
}

$trackedFiles = @($trackedRelative | ForEach-Object { Join-Path $rootPath $_ })
Write-Verbose "$($trackedFiles.Count) getrackte Datei(en) werden geprüft."

# --- Scan: Dateinamen ----------------------------------------------------------------

$nameHits = $trackedFiles | Where-Object {
    $relative = [IO.Path]::GetRelativePath($rootPath, $_)
    if ($relative -like '.github/workflows/*') {
        return $false
    }
    $name = Split-Path $_ -Leaf
    if ($AllowedSecretNamePatterns | Where-Object { $name -match $_ }) {
        return $false
    }
    $SecretNamePatterns | Where-Object { $name -match $_ }
}

# --- Scan: Dateiinhalte (Select-String) ----------------------------------------------

function Get-HBSecretScanContent {
    param([Parameter(Mandatory)][string]$Path)

    $relative = [IO.Path]::GetRelativePath($rootPath, $Path).Replace('\', '/')
    $lines = @(
        Get-Content -LiteralPath $Path -ErrorAction Stop |
            Where-Object {
                $_ -notmatch '(?i)password\s*[:=]\s*(super-secret|secret-value|literal-fixture-value)' `
                    -and $_ -notmatch '(?i)bearer\s+abcdefghijk\b'
            }
    )
    switch ($relative) {
        'scripts/hooks/pre-push' {
            return @($lines | Where-Object { $_ -notmatch '^secret_content_regex=' })
        }
        'scripts/scan-agent-secrets.sh' {
            return @($lines | Where-Object { $_ -notmatch '^secret_content_regex=' })
        }
        'scripts/lib/hg-secrets.sh' {
            return @($lines | Where-Object { $_ -notmatch '^HG_SECRET_PATTERNS=' })
        }
        'scripts/lib/hg-secrets.ps1' {
            return @($lines | Where-Object { $_ -notmatch '^\$HG_SECRET_PATTERN\s*=' })
        }
        'scripts/scan-agent-secrets.ps1' {
            $filtered = [Collections.Generic.List[string]]::new()
            $insidePatterns = $false
            foreach ($line in $lines) {
                if ($line -match '^\$SecretContentPatterns\s*=\s*@\(') { $insidePatterns = $true; continue }
                if ($insidePatterns -and $line -match '^\)\s*$') { $insidePatterns = $false; continue }
                if (-not $insidePatterns) { $filtered.Add($line) }
            }
            return @($filtered)
        }
        default { return $lines }
    }
}

$contentHits = [Collections.Generic.List[string]]::new()
$scanErrors = [Collections.Generic.List[string]]::new()
foreach ($file in $trackedFiles) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { continue }
    try {
        $content = (Get-HBSecretScanContent -Path $file) -join "`n"
    } catch {
        $scanErrors.Add($file)
        continue
    }
    if ($content | Select-String -Pattern $SecretContentPatterns -Quiet) {
        $contentHits.Add($file)
    }
}

# --- Ergebnis ausgeben ---------------------------------------------------------------

$foundHigh = [bool]$gitleaksFoundHigh

if ($scanErrors.Count -gt 0) {
    $foundHigh = $true
    Write-Host 'HIGH  Getrackte Dateien konnten nicht gelesen werden:' -ForegroundColor Red
    $scanErrors | ForEach-Object { Write-Host "      $_" -ForegroundColor Red }
}

if ($nameHits) {
    $foundHigh = $true
    Write-Host 'HIGH  Secret-ähnliche Dateinamen:' -ForegroundColor Red
    $nameHits | ForEach-Object { Write-Host "      $_" -ForegroundColor Red }
}

if ($contentHits) {
    $foundHigh = $true
    Write-Host 'HIGH  Secret-Muster im Dateiinhalt:' -ForegroundColor Red
    $contentHits | ForEach-Object { Write-Host "      $_" -ForegroundColor Red }
}

if (-not $foundHigh) {
    Write-Host 'OK    Keine Secrets in git-getrackten Dateien gefunden.' -ForegroundColor Green
}

# --- Exit-Code für CI / pre-push -----------------------------------------------------

if ($FailOnHigh -and $foundHigh) {
    Write-Host ''
    Write-Host '╔══════════════════════════════════════════════════════════════╗' -ForegroundColor Red
    Write-Host '║  PUSH ABGEBROCHEN: Mögliche Secrets in getrackten Dateien!  ║' -ForegroundColor Red
    Write-Host '║  Bitte die markierten Dateien bereinigen und erneut pushen.  ║' -ForegroundColor Red
    Write-Host '╚══════════════════════════════════════════════════════════════╝' -ForegroundColor Red
    exit 2
}
