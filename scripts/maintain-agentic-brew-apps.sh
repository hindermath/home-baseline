#!/usr/bin/env bash
# Maintain Homebrew packages for agentic development on macOS/Linux.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
REGISTRY="$REPO_ROOT/scripts/config/brew-apps-registry.json"
DRY_RUN=0
COMPARE_ONLY=0
SKIP_UPGRADE=0
INCLUDE_OPTIONAL=0

usage() {
  cat <<'USAGE'
Usage: maintain-agentic-brew-apps.sh [OPTIONS]

Options:
  --dry-run             Show package-manager actions without executing them
  --compare-only        Only compare installed packages with the registry
  --registry PATH       Use an alternative registry JSON
  --skip-upgrade        Skip brew/apt update+upgrade
  --include-optional    Also install optional registry entries
  -h, --help            Show this help
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      ;;
    --compare-only)
      COMPARE_ONLY=1
      ;;
    --registry)
      if [ "$#" -lt 2 ] || [ -z "${2:-}" ]; then
        echo "Fehler: --registry benoetigt einen Pfad." >&2
        usage >&2
        exit 1
      fi
      REGISTRY="${2:-}"
      shift
      ;;
    --skip-upgrade)
      SKIP_UPGRADE=1
      ;;
    --include-optional)
      INCLUDE_OPTIONAL=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Fehler: Unbekannte Option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

if [ ! -f "$REGISTRY" ]; then
  echo "Fehler: Registry nicht gefunden: $REGISTRY" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "Fehler: python3 wird fuer die JSON-Registry benoetigt." >&2
  exit 1
fi

OS_NAME="$(uname -s)"

log() { printf '%s\n' "$*"; }
run_cmd() {
  if [ "$DRY_RUN" -eq 1 ]; then
    printf 'DRY-RUN:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

registry_items() {
  local section="$1"
  local scope="${2:-all}"
  python3 - "$REGISTRY" "$section" "$scope" <<'PY'
import json
import sys

registry_path, section, scope = sys.argv[1:4]
with open(registry_path, encoding="utf-8") as handle:
    data = json.load(handle)

if section == "aptFallback":
    items = data.get("aptFallback", {}).get("packages", [])
    key = "name"
else:
    items = data.get(section, [])
    key = "name"

for item in items:
    if scope != "all" and item.get("scope", "required") != scope:
        continue
    value = item.get(key)
    if value:
        print(value)
PY
}

registry_excluded_casks() {
  printf '%s\n' "xquartz"
  python3 - "$REGISTRY" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as handle:
    data = json.load(handle)
for item in data.get("policy", {}).get("excludedCasks", []):
    name = item.get("name")
    if name:
        print(name)
PY
}

installed_formulae() {
  brew leaves --installed-on-request 2>/dev/null | sort -u
}

installed_casks() {
  brew list --cask 2>/dev/null | sort -u
}

print_missing() {
  local label="$1"
  local installed_file="$2"
  local registry_file="$3"
  local output
  output="$(comm -13 "$installed_file" "$registry_file" || true)"
  if [ -n "$output" ]; then
    log "$label"
    printf '%s\n' "$output" | sed 's/^/  - /'
  else
    log "$label: none"
  fi
}

compare_brew_registry() {
  local tmp_dir installed_f registry_f installed_c registry_c excluded_c
  tmp_dir="$(mktemp -d)"
  installed_f="$tmp_dir/installed-formulae"
  registry_f="$tmp_dir/registry-formulae"
  installed_c="$tmp_dir/installed-casks"
  registry_c="$tmp_dir/registry-casks"
  excluded_c="$tmp_dir/excluded-casks"

  installed_formulae > "$installed_f"
  registry_items formulae all | sort -u > "$registry_f"
  print_missing "missing_on_machine.formulae" "$installed_f" "$registry_f"
  print_missing "missing_from_registry.formulae" "$registry_f" "$installed_f"

  if [ "$OS_NAME" = "Darwin" ]; then
    installed_casks > "$installed_c"
    registry_items casks all | sort -u > "$registry_c"
    registry_excluded_casks | sort -u > "$excluded_c"
    if [ -s "$excluded_c" ]; then
      grep -Fvx -f "$excluded_c" "$installed_c" > "$installed_c.filtered" || true
      mv "$installed_c.filtered" "$installed_c"
    fi
    print_missing "missing_on_machine.casks" "$installed_c" "$registry_c"
    print_missing "missing_from_registry.casks" "$registry_c" "$installed_c"
  else
    log "casks: skipped on non-macOS"
  fi

  rm -rf "$tmp_dir"
}

install_brew_items() {
  local scope formula cask
  scope="required"
  [ "$INCLUDE_OPTIONAL" -eq 1 ] && scope="all"

  while IFS= read -r formula; do
    [ -z "$formula" ] && continue
    if brew list --formula --versions "$formula" >/dev/null 2>&1; then
      log "OK formula: $formula"
    else
      log "INSTALL formula: $formula"
      run_cmd brew install "$formula"
    fi
  done < <(registry_items formulae "$scope")

  if [ "$OS_NAME" = "Darwin" ]; then
    while IFS= read -r cask; do
      [ -z "$cask" ] && continue
      if brew list --cask --versions "$cask" >/dev/null 2>&1; then
        log "OK cask: $cask"
      else
        log "INSTALL cask: $cask"
        run_cmd brew install --cask "$cask"
      fi
    done < <(registry_items casks "$scope")
  fi
}

run_apt_fallback() {
  if [ "$OS_NAME" != "Linux" ] || ! command -v apt >/dev/null 2>&1; then
    echo "Fehler: Homebrew fehlt und apt-Fallback ist auf diesem System nicht verfuegbar." >&2
    exit 1
  fi

  if [ "$COMPARE_ONLY" -eq 1 ]; then
    log "apt fallback packages:"
    registry_items aptFallback all | sed 's/^/  - /'
    return 0
  fi

  if [ "$SKIP_UPGRADE" -eq 0 ]; then
    run_cmd sudo apt update
    run_cmd sudo apt upgrade
  fi

  local scope pkg
  scope="required"
  [ "$INCLUDE_OPTIONAL" -eq 1 ] && scope="all"
  while IFS= read -r pkg; do
    [ -z "$pkg" ] && continue
    if dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q 'install ok installed'; then
      log "OK apt: $pkg"
    else
      log "INSTALL apt: $pkg"
      run_cmd sudo apt install -y "$pkg"
    fi
  done < <(registry_items aptFallback "$scope")
}

log "Agentic Homebrew registry maintenance"
log "Registry: $REGISTRY"
log "OS: $OS_NAME"

if command -v brew >/dev/null 2>&1; then
  if [ "$COMPARE_ONLY" -eq 0 ] && [ "$SKIP_UPGRADE" -eq 0 ]; then
    run_cmd brew update
    run_cmd brew upgrade
  fi

  if [ "$COMPARE_ONLY" -eq 0 ]; then
    install_brew_items
  fi

  compare_brew_registry
else
  run_apt_fallback
fi
