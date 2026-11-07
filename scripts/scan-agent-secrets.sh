#!/usr/bin/env bash

set -euo pipefail

fail_on_high=0
workspace_root="."

while [ "$#" -gt 0 ]; do
  case "$1" in
    --fail-on-high)
      fail_on_high=1
      ;;
    -h|--help)
      echo "Usage: $0 [--fail-on-high] [workspace-root]"
      exit 0
      ;;
    *)
      workspace_root="$1"
      ;;
  esac
  shift
done

if ! command -v rg >/dev/null 2>&1; then
  echo "error: rg is required" >&2
  exit 1
fi

if ! command -v find >/dev/null 2>&1; then
  echo "error: find is required" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "error: python3 is required for the tracked-file fallback" >&2
  exit 1
fi

workspace_root="$(cd "$workspace_root" && pwd)"

gitleaks_high=0
high_count=0
medium_count=0
low_count=0
repository_fallback_high=0

print_result() {
  local risk="$1"
  local path="$2"
  local reason="$3"
  printf '%-6s | %s | %s\n' "$risk" "$path" "$reason"
}

run_gitleaks_worktree_scan() {
  if ! command -v gitleaks >/dev/null 2>&1; then
    echo "INFO   | gitleaks | not installed; regex fallback remains active"
    return 0
  fi

  if ! git -C "$workspace_root" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "INFO   | gitleaks | skipped; workspace root is not a git repository"
    return 0
  fi

  set +e
  gitleaks git --redact --no-banner --no-color --log-level warn --exit-code 2 --pre-commit "$workspace_root"
  local status=$?
  set -e

  if [ "$status" -eq 0 ]; then
    echo "OK     | gitleaks | no secrets in current git diff"
  else
    gitleaks_high=1
    print_result "high" "gitleaks" "possible secret in current git diff or gitleaks scan error"
  fi
}

agent_dir_patterns=(
  '.agents'
  '.claude'
  '.codex'
  '.gemini'
  '.junie'
  '.opencode'
)

run_gitleaks_worktree_scan

run_tracked_repository_fallback() {
  python3 - "$workspace_root" <<'PY'
# HB_SECRET_PATTERN_DEFINITIONS_START
import os
import pathlib
import re
import subprocess
import sys

root = pathlib.Path(sys.argv[1])
listed = subprocess.run(
    ["git", "-C", os.fspath(root), "ls-files", "-z"],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    check=False,
)
if listed.returncode != 0:
    print("HIGH   | tracked files | git ls-files failed", file=sys.stderr)
    raise SystemExit(2)

name_patterns = (
    re.compile(r"(^|/)(auth\.json|\.env(?:\..*)?|[^/]*id_rsa[^/]*|[^/]*\.(?:pem|key|p12|pfx))$", re.I),
)
allowed_names = re.compile(r"(^|/)\.env\.(?:example|sample|template|dist)$", re.I)
content_patterns = (
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
# HB_SECRET_PATTERN_DEFINITIONS_END

def filtered_lines(relative: str, text: str):
    lines = text.splitlines()
    if relative == "scripts/scan-agent-secrets.sh":
        inside = False
        kept = []
        for line in lines:
            if line.strip() == "# HB_SECRET_PATTERN_DEFINITIONS_START":
                inside = True
                continue
            if line.strip() == "# HB_SECRET_PATTERN_DEFINITIONS_END":
                inside = False
                continue
            if not inside:
                kept.append(line)
        lines = kept
    elif relative == "scripts/scan-agent-secrets.ps1":
        inside = False
        kept = []
        for line in lines:
            if re.match(r"^\$SecretContentPatterns\s*=\s*@\(", line):
                inside = True
                continue
            if inside and re.match(r"^\)\s*$", line):
                inside = False
                continue
            if not inside:
                kept.append(line)
        lines = kept
    elif relative in {"scripts/hooks/pre-push", "scripts/lib/hg-secrets.sh"}:
        lines = [line for line in lines if not re.match(r"^(secret_content_regex|HG_SECRET_PATTERNS)=", line)]
    elif relative == "scripts/lib/hg-secrets.ps1":
        lines = [line for line in lines if not re.match(r"^\$HG_SECRET_PATTERN\s*=", line)]
    if relative.startswith("tests/") or "/tests/" in relative or "/fixtures/" in relative:
        lines = [
            line for line in lines
            if not re.search(r"password\s*[:=]\s*(?:super-secret|secret-value|literal-fixture-value)", line, re.I)
            and not re.search(r"bearer\s+abcdefghijk\b", line, re.I)
        ]
    return lines

hits = set()
errors = set()
for raw in listed.stdout.split(b"\0"):
    if not raw:
        continue
    relative = os.fsdecode(raw)
    if relative.startswith(".github/workflows/"):
        name_allowed = True
    else:
        name_allowed = False
    if not name_allowed and not allowed_names.search(relative) and any(pattern.search(relative) for pattern in name_patterns):
        hits.add(relative)
    path = root / relative
    try:
        content = path.read_bytes()
    except OSError:
        errors.add(relative)
        continue
    if b"\0" in content:
        continue
    text = content.decode("utf-8", errors="replace")
    if any(pattern.search(line) for line in filtered_lines(relative, text) for pattern in content_patterns):
        hits.add(relative)

for relative in sorted(errors):
    print(f"HIGH   | {relative} | tracked file could not be read")
for relative in sorted(hits):
    print(f"HIGH   | {relative} | possible secret in tracked file")
raise SystemExit(2 if errors or hits else 0)
PY
}

set +e
run_tracked_repository_fallback
tracked_status=$?
set -e
if [ "$tracked_status" -ne 0 ]; then
  repository_fallback_high=1
fi

declare -a agent_dirs=()
while IFS= read -r dir; do
  agent_dirs+=("$dir")
done < <(
  find "$workspace_root" \
    \( -path '*/.git' -o -path '*/bin' -o -path '*/obj' -o -path '*/node_modules' -o -path '*/_site' -o -path '*/TestResults' \) -prune -o \
    \( -name '.agents' -o -name '.claude' -o -name '.codex' -o -name '.gemini' -o -name '.junie' -o -name '.opencode' -o -path '*/.github/agents' -o -path '*/.github/prompts' \) \
    -type d -print | sort
)

if [ "${#agent_dirs[@]}" -eq 0 ]; then
  echo "No agent directories found under $workspace_root"
  echo
  total_high=$((gitleaks_high + repository_fallback_high))
  echo "Summary: high=$total_high medium=0 low=0 total_agent_dirs=0 gitleaks_high=$gitleaks_high tracked_fallback_high=$repository_fallback_high"
  if [ "$fail_on_high" -eq 1 ] && [ "$total_high" -gt 0 ]; then
    exit 2
  fi
  exit 0
fi

secret_name_regex='(^|/)(auth\.json|\.env(\..*)?|[^/]*(secret|credential|creds)[^/]*|[^/]*id_rsa[^/]*|[^/]*\.(pem|key|p12|pfx))$'
secret_content_regex='(id_token|access_token|refresh_token|api[_-]?key|client[_-]?secret|password|authorization:|bearer|sk-[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|AIza[0-9A-Za-z_-]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN (RSA|OPENSSH|EC|DSA) PRIVATE KEY-----)'

join_reasons() {
  local first=1
  local reason
  for reason in "$@"; do
    if [ -n "$reason" ]; then
      if [ "$first" -eq 1 ]; then
        printf '%s' "$reason"
        first=0
      else
        printf '; %s' "$reason"
      fi
    fi
  done
}

for dir in "${agent_dirs[@]}"; do
  rel_dir="${dir#$workspace_root/}"
  [ "$rel_dir" = "$dir" ] && rel_dir="."

  files=()
  while IFS= read -r line; do
    rel_file="${line#$dir/}"
    if [ "${dir##*/}" = ".agents" ]; then
      case "$rel_file" in
        skills/*) continue ;;
      esac
    fi
    case "$rel_file" in
      */.agents/*|*/.claude/*|*/.codex/*|*/.gemini/*|*/.junie/*|*/.opencode/*|*/.github/agents/*|*/.github/prompts/*)
        continue
        ;;
    esac
    files+=("$line")
  done < <(find "$dir" -type f | sort)

  if [ "${#files[@]}" -eq 0 ]; then
    low_count=$((low_count + 1))
    print_result "low" "$rel_dir" "empty agent directory"
    continue
  fi

  has_high=0
  has_medium=0
  declare -a reasons=()

  high_name_hits=()
  while IFS= read -r line; do
    high_name_hits+=("$line")
  done < <(printf '%s\n' "${files[@]}" | sed "s#^$workspace_root/##" | rg -i "$secret_name_regex" || true)
  if [ "${#high_name_hits[@]}" -gt 0 ]; then
    has_high=1
    reasons+=("secret-like file present ($(basename "${high_name_hits[0]}"))")
  fi

  high_content_hits=()
  while IFS= read -r line; do
    rel_file="${line#$dir/}"
    if [ "${dir##*/}" = ".agents" ]; then
      case "$rel_file" in
        skills/*) continue ;;
      esac
    fi
    case "$rel_file" in
      */.agents/*|*/.claude/*|*/.codex/*|*/.gemini/*|*/.junie/*|*/.opencode/*|*/.github/agents/*|*/.github/prompts/*)
        continue
        ;;
    esac
    high_content_hits+=("$line")
  done < <(rg -I -l -i "$secret_content_regex" "$dir" || true)
  if [ "${#high_content_hits[@]}" -gt 0 ]; then
    has_high=1
    reasons+=("secret field or token pattern present ($(basename "${high_content_hits[0]}"))")
  fi

  settings_hits=()
  while IFS= read -r line; do
    settings_hits+=("$line")
  done < <(printf '%s\n' "${files[@]}" | sed "s#^$workspace_root/##" | rg '/settings\.local\.json$' || true)
  if [ "${#settings_hits[@]}" -gt 0 ]; then
    has_medium=1
    reasons+=("local agent permissions/config ($(basename "${settings_hits[0]}"))")
  fi

  memory_hits=()
  while IFS= read -r line; do
    memory_hits+=("$line")
  done < <(printf '%s\n' "${files[@]}" | sed "s#^$workspace_root/##" | rg '(/memory/|/sessions/|/shell_snapshots/|history\.jsonl$|\.log$|state_[0-9]+\.sqlite(-shm|-wal)?$)' || true)
  if [ "${#memory_hits[@]}" -gt 0 ]; then
    has_medium=1
    reasons+=("agent memory, logs, or state data present ($(basename "${memory_hits[0]}"))")
  fi

  if [ "$has_high" -eq 1 ]; then
    high_count=$((high_count + 1))
    print_result "high" "$rel_dir" "$(join_reasons "${reasons[@]}")"
  elif [ "$has_medium" -eq 1 ]; then
    medium_count=$((medium_count + 1))
    print_result "medium" "$rel_dir" "$(join_reasons "${reasons[@]}")"
  else
    low_count=$((low_count + 1))
    print_result "low" "$rel_dir" "prompt, command, or template files only"
  fi
done

echo
total_high=$((high_count + gitleaks_high + repository_fallback_high))
echo "Summary: high=$total_high medium=$medium_count low=$low_count total_agent_dirs=${#agent_dirs[@]} gitleaks_high=$gitleaks_high tracked_fallback_high=$repository_fallback_high"

if [ "$fail_on_high" -eq 1 ] && [ "$total_high" -gt 0 ]; then
  exit 2
fi
