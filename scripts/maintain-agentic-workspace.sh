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
PREVIEW_DRIFT=0
OPERATIONAL_FAILURE=0
LOCK_DIR=""
LOG_FILE=""
REPORT_FILE=""
TOOLCHAIN_RESULT_FILE=""
RUN_ID=""
CURRENT_STAGE="startup"
FINALIZED=0
PRESET_WORKTREE_REPO=""
PRESET_WORKTREE_PATH=""
PRESET_WORKTREE_ROOT=""
PRESET_WORKTREE_LEASE=""
PRESET_VALIDATION_TARGET=""
PRESET_VALIDATION_ISOLATED=0
LEASE_RECOVERY_READY=1

usage() {
  cat <<'USAGE'
Verwendung / Usage: maintain-agentic-workspace.sh [OPTIONEN]

Ohne Optionen wird die vollstaendige Wartung ausgefuehrt: Die
Remote-Freshness-Barriere schliesst zuerst alle Fetch-Versuche ab. Nur sichere
Behind-only-Repositories werden per Fast-forward aktualisiert. Danach werden
Home-Baseline, Wartungspaket, Preset-Profile und Maschinen-Toolchain gepflegt.

Without options, the Remote Freshness Barrier first completes every fetch
attempt. Only safe behind-only repositories are fast-forwarded. Home baseline,
maintenance package, preset profiles, and machine toolchain follow afterward.

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

release_resources() {
  cleanup_preset_validation_target || true
  if [ -n "$LOCK_DIR" ] && [ -d "$LOCK_DIR" ]; then
    rm -rf -- "$LOCK_DIR"
  fi
  if [ -n "$LOG_FILE" ]; then
    printf '\nLog / log: %s\n' "$LOG_FILE"
  fi
}

cleanup_preset_validation_target() {
  local status=0
  if [ -n "$PRESET_WORKTREE_LEASE" ]; then
    python3 "$FLEET_ENGINE" lease-release \
      --state-root "$STATE_DIR" \
      --lease "$PRESET_WORKTREE_LEASE" \
      --run-id "$RUN_ID" || status=$?
    if [ "$status" -ne 0 ]; then
      warn "Preset-Worktree bleibt wegen mehrdeutiger Lease-Evidence erhalten / retained because lease evidence is ambiguous"
    fi
  fi
  PRESET_WORKTREE_REPO=""
  PRESET_WORKTREE_PATH=""
  PRESET_WORKTREE_ROOT=""
  PRESET_WORKTREE_LEASE=""
  PRESET_VALIDATION_TARGET=""
  PRESET_VALIDATION_ISOLATED=0
  return "$status"
}

finalize_run() {
  local status="$1" exit_code="$2" summary="$3" next_action="$4"
  local signal_name="${5:-N/A}"
  [ "$FINALIZED" -eq 0 ] || return 0
  FINALIZED=1
  if [ -f "$REPORT_FILE" ]; then
    python3 "$FLEET_ENGINE" finalize \
      --report "$REPORT_FILE" \
      --stage-id "$CURRENT_STAGE" \
      --status "$status" \
      --exit-code "$exit_code" \
      --signal "$signal_name" \
      --summary "$summary" \
      --next-action "$next_action" || true
  fi
  printf 'ABSCHLUSS / FINAL\t%s\t%s\t%s\t%s\n' \
    "$status" "$CURRENT_STAGE" "$exit_code" "$next_action"
}

handle_exit() {
  local exit_code=$?
  trap - EXIT INT TERM
  if [ "$FINALIZED" -eq 0 ]; then
    if [ "$exit_code" -eq 0 ]; then
      finalize_run Passed 0 \
        "Wartung abgeschlossen / maintenance completed" "N/A"
    else
      finalize_run Failed "$exit_code" \
        "Ungefangener Stufenfehler / unhandled stage failure" \
        "Letzte Stufe und Log prüfen / review last stage and log."
    fi
  fi
  release_resources
  exit "$exit_code"
}

handle_signal() {
  local signal_name="$1" exit_code="$2"
  trap - EXIT INT TERM
  finalize_run Interrupted "$exit_code" \
    "Signalabbruch / INTERRUPTED by signal" \
    "Lauf ab letzter Stufe erneut starten / rerun from the last stage." \
    "$signal_name"
  release_resources
  exit "$exit_code"
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
PRESET_WORKTREE_LEASE_DIR="${STATE_DIR}/preset-validation-leases"
PRESET_WORKTREE_STATE_DIR="${STATE_DIR}/preset-validation-worktrees"
LOCK_DIR="${STATE_DIR}/locks/agentic-workspace-maintenance.lock"
LOG_DIR="${STATE_DIR}/logs"
REPORT_DIR="${STATE_DIR}/reports"
mkdir -p -- "$(dirname -- "$LOCK_DIR")" "$LOG_DIR" "$REPORT_DIR"
if ! mkdir -- "$LOCK_DIR" 2>/dev/null; then
  holder="$(cat "$LOCK_DIR/pid" 2>/dev/null || printf 'unbekannt / unknown')"
  die "Wartung laeuft bereits (PID ${holder}) / maintenance already running"
fi
printf '%s\n' "$$" > "$LOCK_DIR/pid"
trap handle_exit EXIT
trap 'handle_signal INT 130' INT
trap 'handle_signal TERM 143' TERM

LOG_FILE="${LOG_DIR}/agentic-workspace-$(date +%Y%m%d-%H%M%S).log"
RUN_ID="$(python3 -c 'import uuid; print(uuid.uuid4())')"
REPORT_FILE="${REPORT_DIR}/agentic-workspace-${RUN_ID}.json"
TOOLCHAIN_RESULT_FILE="${REPORT_DIR}/agentic-toolchain-${RUN_ID}.json"
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
  local toolchain_results="${6:-}"
  local -a arguments
  [ -f "$REPORT_FILE" ] || return 0
  arguments=(
    python3 "$FLEET_ENGINE" stage
    --report "$REPORT_FILE" \
    --stage-id "$stage_id" \
    --status "$status" \
    --exit-code "$exit_code" \
    --summary "$summary" \
    --next-action "$next_action"
  )
  [ -n "$toolchain_results" ] && arguments+=(--toolchain-results "$toolchain_results")
  "${arguments[@]}"
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
    --run-id "$RUN_ID" \
    --level0-dir "$SOURCE_ROOT" || status=$?
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
  python3 "$FLEET_ENGINE" canonical-repositories \
    --manifest "$FLEET_MANIFEST" \
    --home-dir "$HOME_DIR" \
    --existing-only
}

ensure_registry() {
  local register_script="${SOURCE_ROOT}/scripts/register-level2-repository.sh"
  local level repo preview_output registry_drift=0
  [ -f "$register_script" ] || die "Registry-Skript fehlt / missing: $register_script"

  while IFS=$'\t' read -r level repo; do
    [ -n "$repo" ] || continue
    if [ "$CHECK_ONLY" -eq 1 ] || [ "$DRY_RUN" -eq 1 ]; then
      preview_output="$(HOME="$HOME_DIR" bash "$register_script" --repo "$repo" --level "$level" --registry "$REGISTRY" --source maintenance-discovery --dry-run)"
      printf '%s\n' "$preview_output"
      [[ "$preview_output" =~ \[dry-run\][[:space:]]+(added|updated): ]] && registry_drift=1
    else
      HOME="$HOME_DIR" bash "$register_script" --repo "$repo" --level "$level" --registry "$REGISTRY" --source maintenance-discovery
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
  local status=0 preview_output=""
  [ -f "$propagation" ] || die "Propagationsskript fehlt / missing: $propagation"

  if [ "$DRY_RUN" -eq 1 ]; then
    preview_output="$(HOME="$HOME_DIR" bash "$propagation" --home-dir "$HOME_DIR" --registry "$REGISTRY" --dry-run)" || status=$?
    printf '%s\n' "$preview_output"
    if [ "$status" -ne 0 ]; then
      FINDINGS=$((FINDINGS + 1))
    elif grep -Eq 'repositories\.drifted:[[:space:]]+[1-9][0-9]*' <<< "$preview_output"; then
      PREVIEW_DRIFT=1
    fi
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
  python3 "$FLEET_ENGINE" profile \
    --catalog "$PRESET_PROFILE_CATALOG" \
    --source-root "$SOURCE_ROOT" \
    --profile "$1" \
    --field path
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
  python3 "$FLEET_ENGINE" default-ref --repository "$repo"
}

prepare_preset_validation_target() {
  local repo="$1"
  local default_ref current_commit default_commit lease_id

  cleanup_preset_validation_target || return 1
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

  lease_id="$(python3 -c 'import uuid; print(uuid.uuid4())')"
  PRESET_WORKTREE_ROOT="${PRESET_WORKTREE_STATE_DIR}/${lease_id}"
  PRESET_WORKTREE_PATH="${PRESET_WORKTREE_ROOT}/worktree"
  PRESET_WORKTREE_LEASE="${PRESET_WORKTREE_LEASE_DIR}/${lease_id}.json"
  PRESET_WORKTREE_REPO="$repo"
  if ! python3 "$FLEET_ENGINE" lease-create \
      --state-root "$STATE_DIR" \
      --lease "$PRESET_WORKTREE_LEASE" \
      --run-id "$RUN_ID" \
      --owner-pid "$$" \
      --repository "$repo" \
      --remote-ref "$default_ref" \
      --commit "$default_commit" \
      --worktree "$PRESET_WORKTREE_PATH"; then
    cleanup_preset_validation_target || true
    warn "Preset-Worktree-Lease konnte nicht erstellt werden / could not create lease: $repo"
    return 1
  fi
  if ! git -C "$repo" worktree add --detach "$PRESET_WORKTREE_PATH" "$default_ref" >/dev/null; then
    cleanup_preset_validation_target || true
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

CURRENT_STAGE="fleet"
info "Verwaiste eigene Preset-Worktrees prüfen / Check owned orphaned preset worktrees"
if ! python3 "$FLEET_ENGINE" lease-recover \
    --state-root "$STATE_DIR" \
    --lease-dir "$PRESET_WORKTREE_LEASE_DIR"; then
  LEASE_RECOVERY_READY=0
  FINDINGS=$((FINDINGS + 1))
  warn "Mehrdeutige Lease-Evidence blockiert mutierende Folgephasen / ambiguous lease evidence blocks later mutations"
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
fleet_ready="$(
  python3 - "$REPORT_FILE" <<'PY'
import json
import sys
report = json.load(open(sys.argv[1], encoding="utf-8"))
print("1" if report.get("mutationBarrier", {}).get("fleetReady") is True else "0")
PY
)"
level0_result="$(
  python3 - "$REPORT_FILE" <<'PY'
import json
import sys
report = json.load(open(sys.argv[1], encoding="utf-8"))
row = next((item for item in report.get("targets", []) if item.get("targetId") == "level0"), {})
print("Passed" if row.get("result") == "Pass" else "Blocked")
PY
)"

home_result="Skipped"
if { [ "$fleet_ready" -eq 1 ] && [ "$LEASE_RECOVERY_READY" -eq 1 ]; } || [ "$CHECK_ONLY" -eq 1 ]; then
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
record_stage "level0" "$level0_result" "$([ "$level0_result" = "Passed" ] && printf 0 || printf 1)" \
  "Level-0-Pruefung / Level-0 check" "Branch und Upstream pruefen / review branch and upstream"
record_stage "home-sync" "$home_result" "$([ "$home_result" = "Blocked" ] && printf 1 || printf 0)" \
  "Home-Sync / home sync" "$([ "$home_result" = "Skipped" ] && printf 'Nach Level-0-Freigabe erneut ausfuehren / rerun after Level-0 passes' || printf 'N/A')"

CURRENT_STAGE="registry"
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

if { { [ "$fleet_ready" -eq 1 ] && [ "$LEASE_RECOVERY_READY" -eq 1 ]; } || [ "$CHECK_ONLY" -eq 1 ]; } \
    && { [ "$FINDINGS" -eq 0 ] || [ "$CHECK_ONLY" -eq 1 ]; } \
    && [ "$registry_safe" -eq 1 ] \
    && [ "$LEASE_RECOVERY_READY" -eq 1 ]; then
  CURRENT_STAGE="propagation"
  info "Kanonisches Wartungspaket pruefen / Check canonical maintenance package"
  findings_before="$FINDINGS"
  handle_propagation
  if [ "$FINDINGS" -gt "$findings_before" ]; then
    record_stage "propagation" "Blocked" 1 "Wartungspaket-Drift / maintenance package drift" \
      "Drift separat pruefen / review drift separately"
  elif [ "$DRY_RUN" -eq 1 ] && [ "$PREVIEW_DRIFT" -eq 1 ]; then
    record_stage "propagation" "Warning" 1 "Wartungspaket-Drift vorhergesagt / maintenance package drift predicted" \
      "Mit --repair-drift lokal reparieren / repair locally with --repair-drift"
  else
    record_stage "propagation" "Passed" 0 "Wartungspaket geprueft / maintenance package checked"
  fi
else
  record_stage "propagation" "Skipped" 0 "Propagation wegen Vorbedingung uebersprungen / skipped by prerequisite" \
    "Blockierende Vorbedingung beheben / resolve blocking prerequisite"
fi

if { { [ "$fleet_ready" -eq 1 ] && [ "$LEASE_RECOVERY_READY" -eq 1 ]; } || [ "$CHECK_ONLY" -eq 1 ]; } \
    && { [ "$FINDINGS" -eq 0 ] || [ "$CHECK_ONLY" -eq 1 ]; } \
    && [ "$registry_safe" -eq 1 ] \
    && [ "$LEASE_RECOVERY_READY" -eq 1 ]; then
  CURRENT_STAGE="preset-profiles"
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

if { { [ "$fleet_ready" -eq 1 ] && [ "$LEASE_RECOVERY_READY" -eq 1 ]; } || [ "$CHECK_ONLY" -eq 1 ]; } \
    && { [ "$FINDINGS" -eq 0 ] || [ "$CHECK_ONLY" -eq 1 ]; } \
    && [ "$SCRIPTS_ONLY" -eq 0 ]; then
  CURRENT_STAGE="toolchain"
  info "Maschinen-Toolchain pflegen / Maintain machine toolchain"
  maintenance=(
    bash "${SOURCE_ROOT}/scripts/maintain-agentic-brew-apps.sh"
    --result-file "$TOOLCHAIN_RESULT_FILE"
  )
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
  deferred_linux=0
  if [ "$(uname -s)" = "Linux" ] && [ "$ALLOW_ADMIN_PROMPTS" -ne 1 ] \
      && [ "$CHECK_ONLY" -eq 0 ] && [ "$DRY_RUN" -eq 0 ]; then
    deferred_linux=1
    maintenance+=(--compare-only)
  elif [ "$ALLOW_ADMIN_PROMPTS" -eq 1 ]; then
    maintenance+=(--allow-admin-prompts)
  fi
  toolchain_status=0
  "${maintenance[@]}" || toolchain_status=$?
  if [ "$toolchain_status" -eq 0 ] && [ "$optional_deferred" -eq 0 ]; then
    record_stage "toolchain" "Passed" 0 \
      "Toolchain-Wartung abgeschlossen / toolchain maintenance completed" \
      "N/A" "$TOOLCHAIN_RESULT_FILE"
  elif [ "$toolchain_status" -ge 2 ]; then
    OPERATIONAL_FAILURE=1
    record_stage "toolchain" "Failed" 2 \
      "Toolchain-Vertrag fehlgeschlagen / toolchain contract failed" \
      "Toolchain-Log und Registry prüfen / review toolchain log and registry." \
      "$([ -f "$TOOLCHAIN_RESULT_FILE" ] && printf '%s' "$TOOLCHAIN_RESULT_FILE" || true)"
  elif [ "$deferred_linux" -eq 1 ] || [ "$optional_deferred" -eq 1 ]; then
    warn "DEFERRED_ADMIN_REQUIRED: Linux-Toolchain-Drift wurde nur geprüft."
    warn "DEFERRED_ADMIN_REQUIRED: Linux toolchain drift was compared only."
    FINDINGS=$((FINDINGS + 1))
    record_stage "toolchain" "DeferredAdminRequired" 1 "DEFERRED_ADMIN_REQUIRED" \
      "Mit aktueller Autoritaet erneut ausfuehren / rerun with current authority" \
      "$TOOLCHAIN_RESULT_FILE"
  elif [ "$toolchain_status" -eq 1 ]; then
    FINDINGS=$((FINDINGS + 1))
    record_stage "toolchain" "Blocked" 1 \
      "Required-Toolchain-Drift bleibt offen / required toolchain drift remains" \
      "Toolchain-Befunde beheben / resolve toolchain findings." \
      "$TOOLCHAIN_RESULT_FILE"
  fi
else
  record_stage "toolchain" "Skipped" 0 "Toolchain durch Modus oder Vorbedingung uebersprungen / skipped by mode or prerequisite"
fi

if [ "$FINDINGS" -eq 0 ]; then
  CURRENT_STAGE="verification"
  info "Abschlusspruefung / Final verification"
  if [ "$DRY_RUN" -eq 1 ]; then
    findings_before="$FINDINGS"
    run_home_sync_check || true
    if [ "$FINDINGS" -gt "$findings_before" ]; then
      record_stage "home-sync" "Blocked" 1 "Home-Sync-Drift vorhergesagt / home sync drift predicted" \
        "Echten Home-Sync nach dem Merge ausfuehren / run actual home sync after merge"
    fi
  else
    run_home_sync_check
    run_propagation_check
  fi
  check_repository "$SOURCE_ROOT" "Level-0" || true
  while IFS=$'\t' read -r level repo; do
    [ -n "$repo" ] || continue
    check_repository "$repo" "Level-${level}" "$REPAIR_APPLIED" || true
  done < <(discover_repositories)
  if [ "$DRY_RUN" -eq 1 ] && [ "$PREVIEW_DRIFT" -eq 1 ]; then
    FINDINGS=$((FINDINGS + 1))
  fi
fi

CURRENT_STAGE="final"
if [ "$OPERATIONAL_FAILURE" -gt 0 ]; then
  finalize_run Failed 2 \
    "Wartung mit Betriebsfehler beendet / maintenance ended with an operational failure" \
    "Letzte Stufe und Log prüfen / review last stage and log."
  warn "Wartung mit Betriebsfehler beendet / maintenance ended with an operational failure"
  printf 'Report / Bericht: %s\n' "$REPORT_FILE"
  exit 2
fi
if [ "$FINDINGS" -gt 0 ]; then
  finalize_run Blocked 1 \
    "Wartung mit offenen Befunden / maintenance has open findings" \
    "Befunde im Bericht beheben / resolve report findings"
  warn "Wartung mit ${FINDINGS} offenem Befund beendet / maintenance ended with open finding(s)"
  printf 'Report / Bericht: %s\n' "$REPORT_FILE"
  exit 1
fi
if [ "$REPAIR_APPLIED" -eq 1 ]; then
  finalize_run Warning 3 \
    "Drift lokal repariert / drift repaired locally" \
    "Aenderungen separat pruefen / review changes separately"
  warn "Drift wurde lokal repariert. Betroffene Repositories separat pruefen, committen und pushen."
  warn "Drift was repaired locally. Review, commit, and push affected repositories separately."
  exit 3
fi

finalize_run Passed 0 "Wartung abgeschlossen / maintenance completed" "N/A"
ok "Wartung abgeschlossen / maintenance completed"
printf 'Report / Bericht: %s\n' "$REPORT_FILE"
