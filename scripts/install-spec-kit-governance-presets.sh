#!/usr/bin/env bash
# install-spec-kit-governance-presets.sh
# Install the centrally configured GitHub Spec Kit governance presets.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_CONFIG="${SCRIPT_DIR}/config/spec-kit-governance-presets.json"
LEGACY_CONFIG="${SCRIPT_DIR}/config/spec-kit-autonomous-governance-presets.json"

OPT_CONFIG="$DEFAULT_CONFIG"
OPT_DRY_RUN=false
OPT_FORCE=false
OPT_REPOS=()

usage() {
  cat <<'EOF'
install-spec-kit-governance-presets.sh — Spec-Kit-Governance-Presets installieren

Usage:
  bash scripts/install-spec-kit-governance-presets.sh [options]

Options:
  --repo PATH             Target repository; repeatable. Default: current directory.
  --preset-config PATH    Preset matrix JSON. Default: scripts/config/spec-kit-governance-presets.json.
  --force                 Remove existing presets first, then install configured versions.
  --dry-run               Show actions only.
  -h, --help              Show this help.
EOF
}

die() {
  printf 'Fehler: %s\n' "$*" >&2
  exit 1
}

normalize_path() {
  local path="$1"
  case "$path" in
    ~/*) printf '%s/%s\n' "$HOME" "${path#~/}" ;;
    *) printf '%s\n' "$path" ;;
  esac
}

read_preset_matrix() {
  local config="$1"
  if command -v python3 >/dev/null 2>&1; then
    python3 - "$config" <<'PY'
import json
import sys

path = sys.argv[1]
with open(path, "r", encoding="utf-8") as handle:
    data = json.load(handle)

for item in data.get("presets", []):
    print("\t".join([
        str(item["id"]),
        str(item["version"]),
        str(item["priority"]),
        str(item["archiveUrl"]),
    ]))
PY
    return 0
  fi

  die "python3 nicht gefunden; JSON-Preset-Matrix kann nicht gelesen werden"
}

validate_preset_matrix() {
  local config="$1"
  python3 - "$config" <<'PY'
import json
import sys

path = sys.argv[1]
with open(path, "r", encoding="utf-8") as handle:
    data = json.load(handle)

if data.get("schemaVersion") != 1:
    raise SystemExit(f"unsupported schemaVersion in {path}")

presets = data.get("presets")
if not isinstance(presets, list) or not presets:
    raise SystemExit(f"presets must be a non-empty list in {path}")

required = {"id", "version", "priority", "repository", "archiveUrl"}
ids = set()
priorities = set()
for index, preset in enumerate(presets):
    if not isinstance(preset, dict):
        raise SystemExit(f"preset {index} must be an object in {path}")
    missing = required.difference(preset)
    if missing:
        raise SystemExit(f"preset {index} missing {sorted(missing)} in {path}")
    if preset["id"] in ids:
        raise SystemExit(f"duplicate preset id {preset['id']} in {path}")
    if preset["priority"] in priorities:
        raise SystemExit(f"duplicate priority {preset['priority']} in {path}")
    ids.add(preset["id"])
    priorities.add(preset["priority"])
PY
}

validate_legacy_matrix_parity() {
  [ "$OPT_CONFIG" = "$DEFAULT_CONFIG" ] || return 0
  [ -f "$LEGACY_CONFIG" ] || return 0

  python3 - "$DEFAULT_CONFIG" "$LEGACY_CONFIG" <<'PY'
import json
import sys

with open(sys.argv[1], "r", encoding="utf-8") as handle:
    canonical = json.load(handle).get("presets", [])
with open(sys.argv[2], "r", encoding="utf-8") as handle:
    legacy = json.load(handle).get("presets", [])

if canonical != legacy:
    raise SystemExit(
        "deprecated autonomous preset matrix differs from the canonical matrix"
    )
PY
}

normalize_preset_markdown() {
  local repo="$1"
  local status

  [ -d "$repo/.specify/presets" ] || return 1

  if $OPT_DRY_RUN; then
    printf '  [dry-run] Markdown-Whitespace in .specify/presets normalisieren\n'
    return 1
  fi

  if python3 - "$repo/.specify/presets" <<'PY'
from pathlib import Path
import sys

root = Path(sys.argv[1])
changed = False

for path in root.rglob("*.md"):
    if ".cache" in path.parts:
        continue
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines(keepends=True)
    normalized = "".join(
        line.rstrip(" \t\r\n") + (line[len(line.rstrip("\r\n")):] if line.endswith(("\n", "\r")) else "")
        for line in lines
    )
    if not lines:
        normalized = text.rstrip(" \t")
    elif not text.endswith(("\n", "\r")):
        normalized = normalized.rstrip(" \t")
    if normalized != text:
        path.write_text(normalized, encoding="utf-8")
        changed = True

sys.exit(10 if changed else 0)
PY
  then
    return 1
  else
    status=$?
    if [ "$status" = "10" ]; then
      printf '  normalisiert: Markdown-Whitespace in .specify/presets\n'
      return 0
    fi
    die "Markdown-Whitespace-Normalisierung fehlgeschlagen: $repo"
  fi
}

preset_is_installed() {
  local repo="$1"
  local preset_id="$2"
  local list_output
  list_output="$(cd "$repo" && specify preset list 2>/dev/null || true)"
  [[ "$list_output" == *"(${preset_id})"* ]]
}

install_for_repo() {
  local repo="$1"
  local changed=0
  local id version priority archive_url

  git -C "$repo" rev-parse --git-dir >/dev/null 2>&1 ||
    die "kein Git-Repository: $repo"
  [ -d "$repo/.specify" ] || die "Spec Kit ist nicht initialisiert: $repo"

  printf '## %s\n' "$repo"

  while IFS="$(printf '\t')" read -r id version priority archive_url; do
    [ -n "$id" ] || continue

    if $OPT_FORCE && preset_is_installed "$repo" "$id"; then
      if $OPT_DRY_RUN; then
        printf '  [dry-run] specify preset remove %s\n' "$id"
      else
        (cd "$repo" && specify preset remove "$id")
      fi
      changed=1
    elif preset_is_installed "$repo" "$id"; then
      printf '  vorhanden: %s\n' "$id"
      continue
    fi

    if $OPT_DRY_RUN; then
      printf '  [dry-run] specify preset add --from %s --priority %s  # %s %s\n' "$archive_url" "$priority" "$id" "$version"
    else
      (cd "$repo" && specify preset add --from "$archive_url" --priority "$priority")
    fi
    changed=1
  done < <(read_preset_matrix "$OPT_CONFIG")

  if normalize_preset_markdown "$repo"; then
    changed=1
  fi

  if [ "$changed" = "0" ]; then
    printf '  unveraendert: alle konfigurierten Presets vorhanden\n'
  fi
}

while [ $# -gt 0 ]; do
  case "$1" in
    --repo)
      [ $# -ge 2 ] || die "--repo braucht einen Pfad"
      OPT_REPOS+=("$(normalize_path "$2")")
      shift 2
      ;;
    --preset-config)
      [ $# -ge 2 ] || die "--preset-config braucht einen Pfad"
      OPT_CONFIG="$(normalize_path "$2")"
      shift 2
      ;;
    --force)
      OPT_FORCE=true
      shift
      ;;
    --dry-run)
      OPT_DRY_RUN=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unbekannte Option: $1"
      ;;
  esac
done

command -v specify >/dev/null 2>&1 || die "specify CLI nicht gefunden"
[ -f "$OPT_CONFIG" ] || die "Preset-Konfiguration nicht gefunden: $OPT_CONFIG"
validate_preset_matrix "$OPT_CONFIG"
validate_legacy_matrix_parity

if [ "${#OPT_REPOS[@]}" -eq 0 ]; then
  OPT_REPOS+=("$PWD")
fi

for repo in "${OPT_REPOS[@]}"; do
  install_for_repo "$repo"
done
