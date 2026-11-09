#Requires -Version 7
<#
.SYNOPSIS
    Prüft git-getrackte Dateien auf Secret-Muster.
.DESCRIPTION
    Scannt ausschließlich Dateien, die 'git ls-files' kennt (.gitignore wird respektiert).
    Verweigert Links, Reparse Points, Spezialdateien und getrackte Dateien über 8 MiB.
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
$PythonCommand = Get-Command python3 -ErrorAction Stop
$SafeTrackedScanProgram = @'
import json, os, pathlib, re, stat, subprocess, sys
root = pathlib.Path(sys.argv[1]).resolve(strict=True)
limit = 8 * 1024 * 1024
patterns = (
    re.compile(r"(?:id_token|access_token|refresh_token|api[_-]?key|client[_-]?secret|password)\s*[:=]\s*[\"']?[A-Za-z0-9._~+/=-]{8,}", re.I),
    re.compile(r"--api-key\s+\S{8,}", re.I),
    re.compile(r"authorization:\s*bearer\s+[A-Za-z0-9._~+/=-]{8,}", re.I),
    re.compile(r"bearer\s+[A-Za-z0-9._~+/=-]{20,}", re.I),
    re.compile(r"(?:^|[^A-Za-z0-9])sk-[A-Za-z0-9]{20,}"),
    re.compile(r"ghp_[A-Za-z0-9]{20,}"),
    re.compile(r"github_pat_[A-Za-z0-9_]{20,}"),
    re.compile(r"AIza[0-9A-Za-z_-]{20,}"),
    re.compile(r"AKIA[0-9A-Z]{16}"),
    re.compile(r"-----BEGIN (?:RSA|OPENSSH|EC|DSA) PRIVATE KEY-----"),
)

def read_safe(relative_text):
    relative = pathlib.PurePath(relative_text)
    parts = relative.parts
    if not parts or relative.is_absolute() or ".." in parts:
        raise OSError("unsafe tracked path")
    flags = os.O_RDONLY | getattr(os, "O_NOFOLLOW", 0) | getattr(os, "O_BINARY", 0)
    if os.name != "nt":
        directory_flags = flags | getattr(os, "O_DIRECTORY", 0)
        parent = os.open(root, directory_flags)
        try:
            for component in parts[:-1]:
                child = os.open(component, directory_flags, dir_fd=parent)
                os.close(parent)
                parent = child
            metadata = os.stat(parts[-1], dir_fd=parent, follow_symlinks=False)
            if not stat.S_ISREG(metadata.st_mode):
                raise OSError("tracked path is not a regular file")
            descriptor = os.open(parts[-1], flags, dir_fd=parent)
        finally:
            os.close(parent)
    else:
        candidate = root / relative
        current = root
        for component in parts:
            current /= component
            metadata = os.lstat(current)
            if stat.S_ISLNK(metadata.st_mode) or (
                getattr(metadata, "st_file_attributes", 0)
                & getattr(stat, "FILE_ATTRIBUTE_REPARSE_POINT", 0)
            ):
                raise OSError("tracked path contains a link or reparse point")
        if not stat.S_ISREG(metadata.st_mode):
            raise OSError("tracked path is not a regular file")
        descriptor = os.open(candidate, flags)
    try:
        opened = os.fstat(descriptor)
        if not stat.S_ISREG(opened.st_mode):
            raise OSError("opened tracked path is not a regular file")
        if (opened.st_dev, opened.st_ino) != (metadata.st_dev, metadata.st_ino):
            raise OSError("tracked path changed during validation")
        if opened.st_size > limit:
            raise OSError("tracked file exceeds scan byte limit")
        chunks = []
        remaining = limit + 1
        while remaining > 0:
            chunk = os.read(descriptor, min(65536, remaining))
            if not chunk:
                break
            chunks.append(chunk)
            remaining -= len(chunk)
        content = b"".join(chunks)
        if len(content) > limit:
            raise OSError("tracked file exceeds scan byte limit")
        return content
    finally:
        os.close(descriptor)

def filtered_lines(relative, text):
    lines = text.splitlines()
    if relative == "scripts/scan-agent-secrets.sh":
        inside = False
        kept = []
        for line in lines:
            if line.strip() == "# HB_SECRET_PATTERN_DEFINITIONS_START": inside = True; continue
            if line.strip() == "# HB_SECRET_PATTERN_DEFINITIONS_END": inside = False; continue
            if not inside: kept.append(line)
        return kept
    if relative == "scripts/scan-agent-secrets.ps1":
        inside_patterns = False
        inside_safe_program = False
        kept = []
        for line in lines:
            if re.match(r"^\$SecretContentPatterns\s*=\s*@\(", line):
                inside_patterns = True; continue
            if line.startswith("$SafeTrackedScanProgram = @'"):
                inside_safe_program = True; continue
            if inside_patterns and re.match(r"^\)\s*$", line):
                inside_patterns = False; continue
            if inside_safe_program and line == "'@":
                inside_safe_program = False; continue
            if not inside_patterns and not inside_safe_program: kept.append(line)
        return kept
    if relative in {"scripts/hooks/pre-push", "scripts/lib/hg-secrets.sh"}:
        return [line for line in lines if not re.match(r"^(secret_content_regex|HG_SECRET_PATTERNS)=", line)]
    if relative == "scripts/lib/hg-secrets.ps1":
        return [line for line in lines if not re.match(r"^\$HG_SECRET_PATTERN\s*=", line)]
    # DE: Nur diese bekannten synthetischen Negativtestwerte ausblenden; weitere Treffer bleiben sichtbar.
    # EN: Mask only these known synthetic negative-test values; additional matches remain visible.
    if relative == ".specify/presets/intake-authoring-governance/tests/test-intake-authoring-validator.ps1":
        lines = [line.replace("github_" + "pat_ABCDEFGHIJKLMNOPQRSTUVWXYZ123456", "fixture-value") for line in lines]
    if relative == ".specify/presets/model-routing-governance/tests/test-adapter-transports.mjs":
        lines = [line.replace("OPENCODE_SERVER_" + "PASSWORD: '" + "fixture-secret'", "OPENCODE_SERVER_PASSWORD: ''") for line in lines]
    if relative.startswith("tests/") or "/tests/" in relative or "/fixtures/" in relative:
        return [line for line in lines if not re.search(r"password\s*[:=]\s*(?:super-secret|secret-value|literal-fixture-value)|bearer\s+abcdefghijk\b", line, re.I)]
    return lines

listed = subprocess.run(["git", "-C", os.fspath(root), "ls-files", "-z"], stdout=subprocess.PIPE, check=False)
if listed.returncode:
    raise SystemExit(2)
for raw in listed.stdout.split(b"\0"):
    if not raw: continue
    relative = os.fsdecode(raw)
    try:
        content = read_safe(relative)
    except OSError:
        print(json.dumps({"kind":"error","path":relative}, ensure_ascii=False))
        continue
    if b"\0" in content: continue
    text = content.decode("utf-8", errors="replace")
    if any(pattern.search(line) for line in filtered_lines(relative, text) for pattern in patterns):
        print(json.dumps({"kind":"hit","path":relative}, ensure_ascii=False))
'@

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

$contentHits = [Collections.Generic.List[string]]::new()
$scanErrors = [Collections.Generic.List[string]]::new()
$scanOutput = @(& $PythonCommand.Source -c $SafeTrackedScanProgram $rootPath 2>$null)
if ($LASTEXITCODE -ne 0) {
    $scanErrors.Add($rootPath)
} else {
    foreach ($line in $scanOutput) {
        try {
            $result = $line | ConvertFrom-Json -ErrorAction Stop
            $absolute = Join-Path $rootPath ([string]$result.path)
            if ($result.kind -eq 'error') { $scanErrors.Add($absolute) }
            elseif ($result.kind -eq 'hit') { $contentHits.Add($absolute) }
        } catch {
            $scanErrors.Add($rootPath)
        }
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
