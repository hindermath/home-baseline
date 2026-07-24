#!/usr/bin/env bash
# Orchestrate repository and agentic toolchain maintenance on macOS/Linux.
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
SOURCE_ROOT="$(cd -- "${SCRIPT_DIR}/.." && pwd -P)"
HOME_DIR="${HOME}"
ORIGINAL_ARGS=("$@")
REGISTRY=""
PRESET_PROFILE_CATALOG="${SOURCE_ROOT}/scripts/config/spec-kit-preset-profiles.json"
FLEET_ENGINE="${SOURCE_ROOT}/scripts/lib/agentic_workspace_fleet.py"
FLEET_MANIFEST="${SOURCE_ROOT}/scripts/config/agentic-workspace-fleet.json"

CHECK_ONLY=0
DRY_RUN=0
SCRIPTS_ONLY=0
REPAIR_DRIFT=0
INCLUDE_OPTIONAL=0
ALLOW_ADMIN_PROMPTS=0
FINDINGS=0
REPAIR_APPLIED=0
LOCK_DIR=""
LOG_FILE=""
REPORT_FILE=""
RUN_ID=""
PRESET_WORKTREE_REPO=""
PRESET_WORKTREE_PATH=""
PRESET_WORKTREE_ROOT=""
PRESET_VALIDATION_TARGET=""
PRESET_VALIDATION_ISOLATED=0

usage() {
  cat <<'USAGE'
Verwendung / Usage: maintain-agentic-workspace.sh [OPTIONEN]

Ohne Optionen wird die vollstaendige Wartung ausgefuehrt: Repositories werden
per Fast-forward aktualisiert, die lokale Home-Baseline wird synchronisiert,
das Wartungspaket wird geprueft und die Maschinen-Toolchain wird aktualisiert.

Without options, full maintenance is performed: repositories are fast-forwarded,
the local home baseline is synchronized, the maintenance package is checked,
and the machine toolchain is updated.

  --check-only       Nur pruefen und fetchen; keine Pulls oder Paketupdates
                     Check and fetch only; no pulls or package updates
  --dry-run          Schreibende Schritte als Vorschau ausgeben
                     Preview mutating steps
  --scripts-only     Nur Repositories, Home-Sync, Registry und Propagation
                     Repositories, home sync, registry, and propagation only
  --repair-drift     Wartungspaket-Drift lokal reparieren; nie committen/pushen
                     Repair maintenance-package drift locally; never commit/push
  --include-optional Auch optionale Maschinenpakete installieren
                     Install optional machine packages too
  --allow-admin-prompts
                     Administratorabfragen nur fuer diesen Lauf erlauben
                     Allow administrator prompts for this run only
  --manifest PFAD    Alternatives Desired-State-Manifest
                     Alternative desired-state manifest
  --home-dir PFAD    Alternatives Home-Verzeichnis (Tests/zweites Profil)
                     Alternative home directory (tests/second profile)
  -h, --help         Diese Hilfe anzeigen / Show this help

Exit-Codes: 0 = aktuell/erfolgreich, 1 = Drift gefunden, 2 = Betriebsfehler,
3 = Drift repariert; lokale Repo-Aenderungen muessen geprueft und separat
committet/gepusht werden.
USAGE
}

die() {
  printf 'Fehler / Error: %s\n' "$*" >&2
  exit 2
}

info() { printf '\n==> %s\n' "$*"; }
ok() { printf 'OK: %s\n' "$*"; }
warn() { printf 'WARN: %s\n' "$*" >&2; }

run_home_sync_check() {
  local status=0
  set +e
  HOME="$HOME_DIR" bash "${SOURCE_ROOT}/scripts/sync-home.sh" --check-only --no-pull
  status=$?
  set -e
  case "$status" in
    0) ok "Lokale Home-Baseline ist manifestkonform / local home baseline matches manifest" ;;
    1)
      warn "Lokale Home-Baseline hat Drift oder Konflikte / local home baseline has drift or conflicts"
      FINDINGS=$((FINDINGS + 1))
      ;;
    *) die "sync-home Check fehlgeschlagen / check failed" ;;
  esac
}

cleanup() {
  local status=$?
  cleanup_preset_validation_target
  if [ -n "$LOCK_DIR" ] && [ -d "$LOCK_DIR" ]; then
    rm -rf -- "$LOCK_DIR"
  fi
  if [ -n "$LOG_FILE" ]; then
    printf '\nLog / log: %s\n' "$LOG_FILE"
  fi
  return "$status"
}

cleanup_preset_validation_target() {
  if [ -n "$PRESET_WORKTREE_PATH" ] && [ -n "$PRESET_WORKTREE_REPO" ]; then
    git -C "$PRESET_WORKTREE_REPO" worktree remove --force "$PRESET_WORKTREE_PATH" >/dev/null 2>&1 || true
  fi
  if [ -n "$PRESET_WORKTREE_ROOT" ] && [ -d "$PRESET_WORKTREE_ROOT" ]; then
    rm -rf -- "$PRESET_WORKTREE_ROOT"
  fi
  PRESET_WORKTREE_REPO=""
  PRESET_WORKTREE_PATH=""
  PRESET_WORKTREE_ROOT=""
  PRESET_VALIDATION_TARGET=""
  PRESET_VALIDATION_ISOLATED=0
}

while [ $# -gt 0 ]; do
  case "${1:-}" in
    --check-only) CHECK_ONLY=1 ;;
    --dry-run) DRY_RUN=1 ;;
    --scripts-only) SCRIPTS_ONLY=1 ;;
    --repair-drift) REPAIR_DRIFT=1 ;;
    --include-optional) INCLUDE_OPTIONAL=1 ;;
    --allow-admin-prompts) ALLOW_ADMIN_PROMPTS=1 ;;
    --manifest)
      [ $# -ge 2 ] || die "--manifest benoetigt einen Pfad / requires a path"
      FLEET_MANIFEST="$2"
      shift
      ;;
    --home-dir)
      [ $# -ge 2 ] || die "--home-dir benoetigt einen Pfad / requires a path"
      HOME_DIR="$2"
      shift
      ;;
    -h|--help) usage; exit 0 ;;
    --) shift; break ;;
    --*) die "Unbekannte Option / unknown option: $1" ;;
    *) die "Unerwartetes Argument / unexpected argument: $1" ;;
  esac
  shift
done

if [ "$CHECK_ONLY" -eq 1 ] && [ "$DRY_RUN" -eq 1 ]; then
  die "--check-only und / and --dry-run sind nicht kombinierbar / cannot be combined"
fi
if [ "$REPAIR_DRIFT" -eq 1 ] && { [ "$CHECK_ONLY" -eq 1 ] || [ "$DRY_RUN" -eq 1 ]; }; then
  die "--repair-drift ist nur im echten Lauf erlaubt / is only allowed in an actual run"
fi
if [ "$INCLUDE_OPTIONAL" -eq 1 ] && [ "$SCRIPTS_ONLY" -eq 1 ]; then
  die "--include-optional passt nicht zu / cannot be combined with --scripts-only"
fi

for tool in git python3 tee; do
  command -v "$tool" >/dev/null 2>&1 || die "$tool ist erforderlich / is required"
done
[ -f "$FLEET_ENGINE" ] || die "Fleet-Vertragskern fehlt / fleet contract engine missing: $FLEET_ENGINE"

case "$(uname -s)" in
  Darwin|Linux) ;;
  *) die "Dieses Skript unterstuetzt macOS/Linux; unter Windows .ps1 verwenden / use .ps1 on Windows" ;;
esac

mkdir -p -- "$HOME_DIR"
HOME_DIR="$(cd -- "$HOME_DIR" && pwd -P)"
REGISTRY="${HOME_DIR}/.home-baseline/level2-repository-registry.json"

# A stale copy in ~/scripts must delegate before it updates that directory.
if [ "$SCRIPT_DIR" = "${HOME_DIR}/scripts" ]; then
  # shellcheck source=scripts/lib/resolve-home-baseline-source.sh
  source "${SCRIPT_DIR}/lib/resolve-home-baseline-source.sh"
  source_repository="$(resolve_hb_source_repository "${BASH_SOURCE[0]}" 1)"
  repo_script="${source_repository}/scripts/maintain-agentic-workspace.sh"
  [ -f "$repo_script" ] || die "Kanonisches Wartungsskript fehlt / canonical maintenance script missing"
  exec bash "$repo_script" "${ORIGINAL_ARGS[@]}"
fi

STATE_DIR="${HOME_DIR}/.home-baseline"
LOCK_DIR="${STATE_DIR}/locks/agentic-workspace-maintenance.lock"
LOG_DIR="${STATE_DIR}/logs"
REPORT_DIR="${STATE_DIR}/reports"
mkdir -p -- "$(dirname -- "$LOCK_DIR")" "$LOG_DIR" "$REPORT_DIR"
if ! mkdir -- "$LOCK_DIR" 2>/dev/null; then
  holder="$(cat "$LOCK_DIR/pid" 2>/dev/null || printf 'unbekannt / unknown')"
  die "Wartung laeuft bereits (PID ${holder}) / maintenance already running"
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap cleanup EXIT INT TERM

LOG_FILE="${LOG_DIR}/agentic-workspace-$(date +%Y%m%d-%H%M%S).log"
RUN_ID="$(python3 -c 'import uuid; print(uuid.uuid4())')"
REPORT_FILE="${REPORT_DIR}/agentic-workspace-${RUN_ID}.json"
exec > >(tee -a "$LOG_FILE") 2>&1

mode="update"
[ "$CHECK_ONLY" -eq 1 ] && mode="check-only"
[ "$DRY_RUN" -eq 1 ] && mode="dry-run"
[ "$SCRIPTS_ONLY" -eq 1 ] && mode="${mode}, scripts-only"
printf 'Agentic workspace maintenance\n'
printf 'Mode / Modus: %s\n' "$mode"
printf 'Level-0: %s\n' "$SOURCE_ROOT"
printf 'Home: %s\n' "$HOME_DIR"
printf 'Run-ID: %s\n' "$RUN_ID"

record_stage() {
  local stage_id="$1" status="$2" exit_code="$3" summary="$4" next_action="${5:-N/A}"
  [ -f "$REPORT_FILE" ] || return 0
  python3 "$FLEET_ENGINE" stage \
    --report "$REPORT_FILE" \
    --stage-id "$stage_id" \
    --status "$status" \
    --exit-code "$exit_code" \
    --summary "$summary" \
    --next-action "$next_action"
}

run_fleet_contract() {
  local fleet_mode="update" status=0
  [ "$CHECK_ONLY" -eq 1 ] && fleet_mode="check-only"
  [ "$DRY_RUN" -eq 1 ] && fleet_mode="dry-run"
  python3 "$FLEET_ENGINE" fleet \
    --manifest "$FLEET_MANIFEST" \
    --home-dir "$HOME_DIR" \
    --mode "$fleet_mode" \
    --report "$REPORT_FILE" \
    --log "$LOG_FILE" \
    --run-id "$RUN_ID" || status=$?
  return "$status"
}

git_counts() {
  local repo="$1" upstream="$2"
  git -C "$repo" rev-list --left-right --count "HEAD...${upstream}"
}

check_repository() {
  local repo="$1" label="$2" allow_repair_dirty="${3:-0}"
  local branch upstream counts ahead behind

  [ -d "$repo/.git" ] || {
    warn "$label ist kein Git-Repository / is not a Git repository: $repo"
    FINDINGS=$((FINDINGS + 1))
    return 1
  }

  branch="$(git -C "$repo" symbolic-ref --quiet --short HEAD || true)"
  if [ -z "$branch" ]; then
    warn "$label hat einen detached HEAD / has a detached HEAD: $repo"
    FINDINGS=$((FINDINGS + 1))
    return 1
  fi
  upstream="$(git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null || true)"
  if [ -z "$upstream" ]; then
    warn "$label hat keinen Upstream / has no upstream: $repo ($branch)"
    FINDINGS=$((FINDINGS + 1))
    return 1
  fi

  if [ -n "$(git -C "$repo" status --porcelain=v1 --untracked-files=all)" ] && [ "$allow_repair_dirty" -ne 1 ]; then
    warn "$label ist nicht sauber / is dirty: $repo"
    FINDINGS=$((FINDINGS + 1))
    return 1
  fi

  git -C "$repo" fetch --prune
  counts="$(git_counts "$repo" "$upstream")"
  read -r ahead behind <<< "$counts"

  if [ "$ahead" -gt 0 ]; then
    warn "$label ist ${ahead} Commit(s) voraus; kein automatischer Push / is ahead; no automatic push: $repo"
    FINDINGS=$((FINDINGS + 1))
    return 1
  fi
  if [ "$behind" -gt 0 ]; then
    if [ "$CHECK_ONLY" -eq 1 ]; then
      warn "$label ist ${behind} Commit(s) zurueck / is behind: $repo"
      FINDINGS=$((FINDINGS + 1))
      return 1
    elif [ "$DRY_RUN" -eq 1 ]; then
      printf '[DRY-RUN] git -C %q pull --ff-only\n' "$repo"
      return 0
    fi
    git -C "$repo" pull --ff-only
  fi

  counts="$(git_counts "$repo" "$upstream")"
  read -r ahead behind <<< "$counts"
  if [ "$ahead" -ne 0 ] || [ "$behind" -ne 0 ]; then
    warn "$label ist nach der Wartung nicht synchron / is not synchronized: $repo (${ahead}/${behind})"
    FINDINGS=$((FINDINGS + 1))
    return 1
  fi
  ok "$label: $repo ($branch, 0/0)"
}

discover_repositories() {
  python3 - "$HOME_DIR" "$REGISTRY" "$SOURCE_ROOT" <<'PY'
import json
import pathlib
import sys

home = pathlib.Path(sys.argv[1]).resolve()
registry = pathlib.Path(sys.argv[2])
source = pathlib.Path(sys.argv[3]).resolve()

def is_repo(path):
    return (path / ".git").exists() and (
        (path / "AGENTS.md").is_file() or (path / "CLAUDE.md").is_file()
    )

repos = {}
for path in home.iterdir():
    if not path.is_dir() or path.resolve() == source or not is_repo(path):
        continue
    repos[path.resolve()] = 1
    for child in path.iterdir():
        if child.is_dir() and is_repo(child):
            repos[child.resolve()] = 2

if registry.is_file():
    data = json.loads(registry.read_text(encoding="utf-8"))
    entries = data.get("repositories", []) if isinstance(data, dict) else data
    for entry in entries:
        if not isinstance(entry, dict) or entry.get("level") not in (1, 2):
            continue
        raw = entry.get("path")
        if not isinstance(raw, str) or not raw:
            continue
        path = (home / raw).resolve()
        try:
            path.relative_to(home)
        except ValueError:
            continue
        if path != source and is_repo(path) and path not in repos:
            repos[path] = int(entry["level"])

for path, level in sorted(repos.items(), key=lambda item: (item[1], str(item[0]).lower())):
    print(f"{level}\t{path}")
PY
}

ensure_registry() {
  local register_script="${SOURCE_ROOT}/scripts/register-level2-repository.sh"
  local level repo preview_output registry_drift=0
  [ -f "$register_script" ] || die "Registry-Skript fehlt / missing: $register_script"

  while IFS=$'\t' read -r level repo; do
    [ -n "$repo" ] || continue
    [ "$level" = "1" ] || continue
    if [ "$CHECK_ONLY" -eq 1 ] || [ "$DRY_RUN" -eq 1 ]; then
      preview_output="$(HOME="$HOME_DIR" bash "$register_script" --repo "$repo" --level 1 --registry "$REGISTRY" --source maintenance-discovery --dry-run)"
      printf '%s\n' "$preview_output"
      [[ "$preview_output" =~ \[dry-run\][[:space:]]+(added|updated): ]] && registry_drift=1
      preview_output="$(HOME="$HOME_DIR" bash "$register_script" --scan-root "$repo" --level 2 --registry "$REGISTRY" --source maintenance-discovery --dry-run)"
      printf '%s\n' "$preview_output"
      [[ "$preview_output" =~ \[dry-run\][[:space:]]+(added|updated): ]] && registry_drift=1
    else
      HOME="$HOME_DIR" bash "$register_script" --repo "$repo" --level 1 --registry "$REGISTRY" --source maintenance-discovery
      HOME="$HOME_DIR" bash "$register_script" --scan-root "$repo" --level 2 --registry "$REGISTRY" --source maintenance-discovery
    fi
  done < <(discover_repositories)

  if [ ! -f "$REGISTRY" ]; then
    warn "Registry fehlt und keine Level-1-Wurzel wurde eingetragen / registry is missing and no Level-1 root was registered"
    FINDINGS=$((FINDINGS + 1))
    return 1
  fi
  if [ "$registry_drift" -eq 1 ]; then
    warn "Registry-Drift gefunden / registry drift found"
    FINDINGS=$((FINDINGS + 1))
    return 1
  fi
}

run_propagation_check() {
  local propagation="${SOURCE_ROOT}/scripts/propagate-agentic-toolchain-maintenance.sh"
  HOME="$HOME_DIR" bash "$propagation" --home-dir "$HOME_DIR" --registry "$REGISTRY" --check-only
}

handle_propagation() {
  local propagation="${SOURCE_ROOT}/scripts/propagate-agentic-toolchain-maintenance.sh"
  local status=0
  [ -f "$propagation" ] || die "Propagationsskript fehlt / missing: $propagation"

  if [ "$DRY_RUN" -eq 1 ]; then
    HOME="$HOME_DIR" bash "$propagation" --home-dir "$HOME_DIR" --registry "$REGISTRY" --dry-run || status=$?
    [ "$status" -eq 0 ] || FINDINGS=$((FINDINGS + 1))
    return
  fi

  run_propagation_check || status=$?
  case "$status" in
    0) ok "Wartungspaket ist homogen / maintenance package is homogeneous" ;;
    1)
      if [ "$CHECK_ONLY" -eq 1 ] || [ "$REPAIR_DRIFT" -ne 1 ]; then
        warn "Wartungspaket-Drift gefunden; fuer Reparatur --repair-drift verwenden / use --repair-drift to repair"
        FINDINGS=$((FINDINGS + 1))
        return
      fi
      HOME="$HOME_DIR" bash "$propagation" --home-dir "$HOME_DIR" --registry "$REGISTRY" --dry-run
      HOME="$HOME_DIR" bash "$propagation" --home-dir "$HOME_DIR" --registry "$REGISTRY"
      run_propagation_check
      REPAIR_APPLIED=1
      ;;
    *) die "Propagation konnte nicht sicher geprueft werden / could not be checked safely" ;;
  esac
}

preset_config_for_profile() {
  python3 - "$PRESET_PROFILE_CATALOG" "$SOURCE_ROOT" "$1" <<'PY'
import json
import pathlib
import sys

catalog_path = pathlib.Path(sys.argv[1])
source_root = pathlib.Path(sys.argv[2]).resolve()
profile_name = sys.argv[3]
catalog = json.loads(catalog_path.read_text(encoding="utf-8"))
profiles = catalog.get("profiles", {})
if profile_name not in profiles:
    raise SystemExit(f"Unbekanntes Preset-Profil / unknown preset profile: {profile_name}")
relative = profiles[profile_name].get("presetConfig")
if relative is None:
    raise SystemExit(1)
config = (source_root / relative).resolve()
try:
    config.relative_to(source_root)
except ValueError as exc:
    raise SystemExit(f"Preset-Konfiguration liegt ausserhalb der Quelle: {config}") from exc
print(config)
PY
}

discover_preset_targets() {
  python3 - "$HOME_DIR" "$REGISTRY" "$SOURCE_ROOT" <<'PY'
import json
import pathlib
import sys

home = pathlib.Path(sys.argv[1]).resolve()
registry_path = pathlib.Path(sys.argv[2])
source = pathlib.Path(sys.argv[3]).resolve()
data = json.loads(registry_path.read_text(encoding="utf-8"))
default_profile = data.get("defaultPresetProfile", "standard-eight-governance-presets")
print(f"0\t{source}\t{default_profile}")
for entry in data.get("repositories", []):
    raw = entry.get("path")
    profile = entry.get("presetProfile", default_profile)
    if not isinstance(raw, str) or not raw or not isinstance(profile, str) or not profile:
        raise SystemExit("Invalid repository preset-profile entry")
    path = (home / raw).resolve()
    try:
        path.relative_to(home)
    except ValueError as exc:
        raise SystemExit(f"Repository outside home: {path}") from exc
    if not (path / ".git").exists():
        raise SystemExit(f"Registered Git repository missing: {path}")
    print(f"{entry.get('level', '?')}\t{path}\t{profile}")
PY
}

resolve_default_remote_ref() {
  local repo="$1"
  local ref candidates=()

  ref="$(git -C "$repo" symbolic-ref --quiet refs/remotes/origin/HEAD 2>/dev/null || true)"
  if [ -n "$ref" ]; then
    git -C "$repo" show-ref --verify --quiet "$ref" || return 1
    printf '%s\n' "$ref"
    return 0
  fi

  for ref in refs/remotes/origin/main refs/remotes/origin/master; do
    if git -C "$repo" show-ref --verify --quiet "$ref"; then
      candidates+=("$ref")
    fi
  done
  [ "${#candidates[@]}" -eq 1 ] || return 1
  printf '%s\n' "${candidates[0]}"
}

prepare_preset_validation_target() {
  local repo="$1"
  local default_ref current_commit default_commit

  cleanup_preset_validation_target
  PRESET_VALIDATION_TARGET="$repo"

  # Level-0 validates the executing source checkout so pending source changes
  # remain visible. Registered repositories are checked against origin/HEAD.
  if [ "$repo" = "$SOURCE_ROOT" ]; then
    [ -d "$repo/.specify" ]
    return
  fi

  default_ref="$(resolve_default_remote_ref "$repo")" || {
    warn "Kanonischer origin-Default-Branch ist nicht eindeutig / canonical origin default branch is ambiguous: $repo"
    return 1
  }
  current_commit="$(git -C "$repo" rev-parse HEAD 2>/dev/null || true)"
  default_commit="$(git -C "$repo" rev-parse "$default_ref" 2>/dev/null || true)"

  if [ -d "$repo/.specify" ] && [ -n "$current_commit" ] && [ "$current_commit" = "$default_commit" ]; then
    return
  fi
  if ! git -C "$repo" cat-file -e "${default_ref}:.specify/presets/.registry" 2>/dev/null; then
    warn "Spec Kit ist auch auf ${default_ref} nicht initialisiert / is not initialized on the canonical default ref: $repo"
    return 1
  fi

  mkdir -p "${HOME_DIR}/.home-baseline"
  PRESET_WORKTREE_ROOT="$(mktemp -d "${HOME_DIR}/.home-baseline/preset-validation.XXXXXX")"
  PRESET_WORKTREE_PATH="${PRESET_WORKTREE_ROOT}/worktree"
  PRESET_WORKTREE_REPO="$repo"
  if ! git -C "$repo" worktree add --detach "$PRESET_WORKTREE_PATH" "$default_ref" >/dev/null; then
    cleanup_preset_validation_target
    warn "Temporärer Preset-Prüf-Worktree konnte nicht erstellt werden / temporary preset validation worktree failed: $repo"
    return 1
  fi
  PRESET_VALIDATION_TARGET="$PRESET_WORKTREE_PATH"
  PRESET_VALIDATION_ISOLATED=1
  info "Preset-Profil wird isoliert auf ${default_ref} geprüft / validating preset profile on canonical ref"
}

handle_preset_profiles() {
  local installer="${SOURCE_ROOT}/scripts/install-spec-kit-governance-presets.sh"
  local level repo profile config status target isolated
  [ -f "$installer" ] || die "Preset-Installer fehlt / missing: $installer"
  [ -f "$PRESET_PROFILE_CATALOG" ] || die "Preset-Profilkatalog fehlt / missing: $PRESET_PROFILE_CATALOG"

  while IFS=$'\t' read -r level repo profile; do
    [ -n "$repo" ] || continue
    if [ "$profile" = "none" ]; then
      continue
    fi
    config="$(preset_config_for_profile "$profile")"
    [ -f "$config" ] || die "Preset-Matrix fehlt / missing: $config"
    info "Preset-Profil Level-${level}: ${repo} -> ${profile}"
    if ! prepare_preset_validation_target "$repo"; then
      FINDINGS=$((FINDINGS + 1))
      cleanup_preset_validation_target
      continue
    fi
    target="$PRESET_VALIDATION_TARGET"
    isolated="$PRESET_VALIDATION_ISOLATED"

    if [ "$DRY_RUN" -eq 1 ]; then
      HOME="$HOME_DIR" bash "$installer" --repo "$target" --preset-config "$config" --dry-run
      cleanup_preset_validation_target
      continue
    fi

    status=0
    HOME="$HOME_DIR" bash "$installer" --repo "$target" --preset-config "$config" --check-only || status=$?
    cleanup_preset_validation_target
    if [ "$status" -eq 0 ]; then
      continue
    fi
    if [ "$isolated" -eq 1 ]; then
      warn "Preset-Profil-Drift auf dem kanonischen Default-Branch erfordert einen eigenen Branch/PR / requires a dedicated branch/PR: $repo"
      FINDINGS=$((FINDINGS + 1))
      continue
    fi
    if [ "$CHECK_ONLY" -eq 1 ] || [ "$REPAIR_DRIFT" -ne 1 ]; then
      warn "Preset-Profil-Drift gefunden / preset profile drift found: $repo"
      FINDINGS=$((FINDINGS + 1))
      continue
    fi
    HOME="$HOME_DIR" bash "$installer" --repo "$repo" --preset-config "$config" --force
    REPAIR_APPLIED=1
  done < <(discover_preset_targets)
}

info "Level-0 aktualisieren / Update Level-0"
level0_result="Passed"
check_repository "$SOURCE_ROOT" "Level-0" || level0_result="Blocked"

home_result="Skipped"
if [ "$FINDINGS" -eq 0 ]; then
  info "Lokale Home-Baseline synchronisieren / Synchronize local home baseline"
  findings_before="$FINDINGS"
  if [ "$CHECK_ONLY" -eq 1 ]; then
    run_home_sync_check
  elif [ "$DRY_RUN" -eq 1 ]; then
    HOME="$HOME_DIR" bash "${SOURCE_ROOT}/scripts/sync-home.sh" --dry-run --no-pull
  else
    HOME="$HOME_DIR" bash "${SOURCE_ROOT}/scripts/sync-home.sh" --no-pull
  fi
  if [ "$FINDINGS" -gt "$findings_before" ]; then
    home_result="Blocked"
  else
    home_result="Passed"
  fi
fi

info "Soll-Flotte pruefen und sicher warten / Check and safely maintain desired fleet"
fleet_status=0
run_fleet_contract || fleet_status=$?
case "$fleet_status" in
  0) ;;
  1) FINDINGS=$((FINDINGS + 1)) ;;
  *) record_stage "fleet" "Failed" 2 "Fleet-Vertrag fehlgeschlagen / fleet contract failed" \
       "Manifest und Log pruefen / review manifest and log"; exit 2 ;;
esac
record_stage "level0" "$level0_result" "$([ "$level0_result" = "Passed" ] && printf 0 || printf 1)" \
  "Level-0-Pruefung / Level-0 check" "Branch und Upstream pruefen / review branch and upstream"
record_stage "home-sync" "$home_result" "$([ "$home_result" = "Blocked" ] && printf 1 || printf 0)" \
  "Home-Sync / home sync" "$([ "$home_result" = "Skipped" ] && printf 'Nach Level-0-Freigabe erneut ausfuehren / rerun after Level-0 passes' || printf 'N/A')"

info "Level-1/Level-2 Registry pruefen / Check Level-1/Level-2 registry"
findings_before="$FINDINGS"
ensure_registry || true
registry_safe=0
registry_status=2
if [ -f "$REGISTRY" ]; then
  registry_status=0
  python3 "$FLEET_ENGINE" registry --manifest "$FLEET_MANIFEST" --registry "$REGISTRY" || registry_status=$?
  [ "$registry_status" -eq 0 ] && registry_safe=1
  [ "$registry_status" -eq 0 ] || FINDINGS=$((FINDINGS + 1))
fi
if [ "$FINDINGS" -gt "$findings_before" ] || [ "$registry_safe" -ne 1 ]; then
  record_stage "registry" "Blocked" 1 "Registry-Pruefung mit Befund / registry check has findings" \
    "Registry-Befund beheben / resolve registry finding"
else
  record_stage "registry" "Passed" 0 "Registry-Pruefung abgeschlossen / registry check completed"
fi

if { [ "$FINDINGS" -eq 0 ] || [ "$CHECK_ONLY" -eq 1 ]; } && [ "$registry_safe" -eq 1 ]; then
  info "Kanonisches Wartungspaket pruefen / Check canonical maintenance package"
  findings_before="$FINDINGS"
  handle_propagation
  if [ "$FINDINGS" -gt "$findings_before" ]; then
    record_stage "propagation" "Blocked" 1 "Wartungspaket-Drift / maintenance package drift" \
      "Drift separat pruefen / review drift separately"
  else
    record_stage "propagation" "Passed" 0 "Wartungspaket geprueft / maintenance package checked"
  fi
else
  record_stage "propagation" "Skipped" 0 "Propagation wegen Vorbedingung uebersprungen / skipped by prerequisite" \
    "Blockierende Vorbedingung beheben / resolve blocking prerequisite"
fi

if { [ "$FINDINGS" -eq 0 ] || [ "$CHECK_ONLY" -eq 1 ]; } && [ "$registry_safe" -eq 1 ]; then
  info "Registry-gesteuerte Preset-Profile pruefen / Check registry-controlled preset profiles"
  findings_before="$FINDINGS"
  handle_preset_profiles
  if [ "$FINDINGS" -gt "$findings_before" ]; then
    record_stage "preset-profiles" "Blocked" 1 "Preset-Profil-Befund / preset profile finding" \
      "Preset-Drift separat beheben / resolve preset drift separately"
  else
    record_stage "preset-profiles" "Passed" 0 "Preset-Profile geprueft / preset profiles checked"
  fi
else
  record_stage "preset-profiles" "Skipped" 0 "Preset-Pruefung wegen Vorbedingung uebersprungen / skipped by prerequisite" \
    "Blockierende Vorbedingung beheben / resolve blocking prerequisite"
fi

if { [ "$FINDINGS" -eq 0 ] || [ "$CHECK_ONLY" -eq 1 ]; } && [ "$SCRIPTS_ONLY" -eq 0 ]; then
  info "Maschinen-Toolchain pflegen / Maintain machine toolchain"
  maintenance=(bash "${SOURCE_ROOT}/scripts/maintain-agentic-brew-apps.sh")
  if [ "$CHECK_ONLY" -eq 1 ]; then
    maintenance+=(--compare-only)
  elif [ "$DRY_RUN" -eq 1 ]; then
    maintenance+=(--dry-run)
  fi
  optional_deferred=0
  if [ "$INCLUDE_OPTIONAL" -eq 1 ]; then
    if [ "$ALLOW_ADMIN_PROMPTS" -eq 1 ]; then
      maintenance+=(--include-optional)
    else
      optional_deferred=1
      warn "DEFERRED_ADMIN_REQUIRED: optionale Pakete benoetigen aktuelle Admin-Prompt-Autoritaet"
      warn "DEFERRED_ADMIN_REQUIRED: optional packages require current admin-prompt authority"
    fi
  fi
  if [ "$(uname -s)" = "Linux" ] && [ "$ALLOW_ADMIN_PROMPTS" -ne 1 ] && [ "$CHECK_ONLY" -eq 0 ] && [ "$DRY_RUN" -eq 0 ]; then
    warn "DEFERRED_ADMIN_REQUIRED: Linux-Toolchain benoetigt ausdrueckliche --allow-admin-prompts-Autoritaet"
    warn "DEFERRED_ADMIN_REQUIRED: Linux toolchain requires explicit --allow-admin-prompts authority"
    record_stage "toolchain" "Warning" 0 "DEFERRED_ADMIN_REQUIRED" \
      "Mit aktueller Autoritaet erneut ausfuehren / rerun with current authority"
  else
    "${maintenance[@]}"
    if [ "$optional_deferred" -eq 1 ]; then
      record_stage "toolchain" "Warning" 0 "DEFERRED_ADMIN_REQUIRED" \
        "Mit aktueller Autoritaet erneut ausfuehren / rerun with current authority"
    else
      record_stage "toolchain" "Passed" 0 "Toolchain-Wartung abgeschlossen / toolchain maintenance completed"
    fi
  fi
else
  record_stage "toolchain" "Skipped" 0 "Toolchain durch Modus oder Vorbedingung uebersprungen / skipped by mode or prerequisite"
fi

if [ "$FINDINGS" -eq 0 ]; then
  info "Abschlusspruefung / Final verification"
  run_home_sync_check
  run_propagation_check
  check_repository "$SOURCE_ROOT" "Level-0" || true
  while IFS=$'\t' read -r level repo; do
    [ -n "$repo" ] || continue
    check_repository "$repo" "Level-${level}" "$REPAIR_APPLIED" || true
  done < <(discover_repositories)
fi

if [ "$FINDINGS" -gt 0 ]; then
  record_stage "final" "Blocked" 1 "Wartung mit offenen Befunden / maintenance has open findings" \
    "Befunde im Bericht beheben / resolve report findings"
  warn "Wartung mit ${FINDINGS} offenem Befund beendet / maintenance ended with open finding(s)"
  printf 'Report / Bericht: %s\n' "$REPORT_FILE"
  exit 1
fi
if [ "$REPAIR_APPLIED" -eq 1 ]; then
  record_stage "final" "Warning" 3 "Drift lokal repariert / drift repaired locally" \
    "Aenderungen separat pruefen / review changes separately"
  warn "Drift wurde lokal repariert. Betroffene Repositories separat pruefen, committen und pushen."
  warn "Drift was repaired locally. Review, commit, and push affected repositories separately."
  exit 3
fi

record_stage "final" "Passed" 0 "Wartung abgeschlossen / maintenance completed"
ok "Wartung abgeschlossen / maintenance completed"
printf 'Report / Bericht: %s\n' "$REPORT_FILE"
