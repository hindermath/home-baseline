#!/usr/bin/env bash
# bootstrap-project.sh — Idempotenter Projekt-Bootstrap v1.1
# FR-009–016; Contract: bootstrap-project-cli.md
#
# Usage: bootstrap-project.sh <ProjectName> [TARGET_WORKSPACE] [OPTIONS]
# Options:
#   --preview            Show planned actions, write nothing
#   --force              Overwrite existing files
#   --no-agents          Skip AI agent initialization
#   --no-speckit         Skip Spec-kit installation
#   --no-governance-presets
#                       Skip Spec-kit governance preset installation
#   --no-remote          No remote repo create (local git init only)
#   --no-release-please  Skip Release Please workflow setup
#   --platform           github|gitlab
#   --gitlab-url         https://gitlab.example.com
#   --lang de|en         Primary language for templates (default: de)
#   --primary-language   Declared primary implementation language for MSL setup
# Exit codes: 0=success, 1=partial (warnings), 2=fatal

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="${SCRIPT_DIR}/templates"
SECURE_DEV_LIB="${SCRIPT_DIR}/lib/secure-development-hardening.sh"

if [ -f "$SECURE_DEV_LIB" ]; then
  # shellcheck source=/dev/null
  . "$SECURE_DEV_LIB"
fi

# ─── Argument Parsing ────────────────────────────────────────────────────────

OPT_PREVIEW=false
OPT_DRY_RUN=false
OPT_FORCE=false
OPT_NO_AGENTS=false
OPT_NO_SPECKIT=false
OPT_NO_GOVERNANCE_PRESETS=false
OPT_NO_REMOTE=false
OPT_NO_RELEASE_PLEASE=false
OPT_PLATFORM="github"
OPT_GITLAB_URL="https://gitlab.com"
OPT_GITLAB_HOSTNAME=""
OPT_LANG="de"
OPT_PRIMARY_LANGUAGE=""
PROJECT_NAME=""
TARGET_WORKSPACE=""
GITLAB_USER_LOCAL=""
PROJECT_SLUG=""
PROJECT_SLUG_CHANGED=false
SUMMARY_REPO_URL=""
SUMMARY_DISPLAY_REPO=""

normalize_name() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-\|-$//g'
}

repo_url_from_remote() {
  case "$1" in
    https://*)
      printf '%s' "${1%.git}"
      ;;
    git@*:*)
      printf '%s' "$1" | sed -E 's#^git@([^:]+):#https://\1/#; s#\.git$##'
      ;;
    ssh://git@*/*)
      printf '%s' "$1" | sed -E 's#^ssh://git@([^/]+)/#https://\1/#; s#\.git$##'
      ;;
    *)
      printf '%s' "${1%.git}"
      ;;
  esac
}

repo_name_from_url() {
  local repo_url
  repo_url="$(repo_url_from_remote "$1")"
  printf '%s' "${repo_url##*/}"
}

while [ $# -gt 0 ]; do
  case "$1" in
    --preview|--dry-run) OPT_PREVIEW=true; OPT_DRY_RUN=true ;;
    --force)      OPT_FORCE=true ;;
    --no-agents)          OPT_NO_AGENTS=true ;;
    --no-speckit)         OPT_NO_SPECKIT=true ;;
    --no-governance-presets) OPT_NO_GOVERNANCE_PRESETS=true ;;
    --no-remote)          OPT_NO_REMOTE=true ;;
    --no-release-please)  OPT_NO_RELEASE_PLEASE=true ;;
    --platform)   OPT_PLATFORM="${2:-github}"; shift ;;
    --gitlab-url) OPT_GITLAB_URL="${2:-https://gitlab.com}"; shift ;;
    --lang)       OPT_LANG="${2:-de}"; shift ;;
    --primary-language) OPT_PRIMARY_LANGUAGE="${2:-}"; shift ;;
    -h|--help) echo "USAGE: bootstrap-project.sh <ProjectName> [TARGET_WORKSPACE] [OPTIONS]" >&2; exit 0 ;;
    --)
      shift
      if [ $# -gt 0 ] && [ -z "$PROJECT_NAME" ]; then PROJECT_NAME="$1"; shift; fi
      if [ $# -gt 0 ] && [ -z "$TARGET_WORKSPACE" ]; then TARGET_WORKSPACE="$1"; shift; fi
      continue ;;
    --*) echo "ERROR: unknown option $1" >&2; exit 2 ;;
    *)
      if [ -z "$PROJECT_NAME" ]; then
        PROJECT_NAME="$1"
      elif [ -z "$TARGET_WORKSPACE" ]; then
        TARGET_WORKSPACE="$1"
      fi ;;
  esac
  shift
done

if [ -z "$PROJECT_NAME" ]; then
  echo "USAGE: bootstrap-project.sh <ProjectName> [TARGET_WORKSPACE] [OPTIONS]" >&2
  exit 2
fi

TARGET_WORKSPACE="${TARGET_WORKSPACE:-$PWD}"
TARGET_WORKSPACE="${TARGET_WORKSPACE/#\~/$HOME}"
TARGET_WORKSPACE="${TARGET_WORKSPACE%/}"
TARGET_DIR="${TARGET_WORKSPACE}/${PROJECT_NAME}"

case "$OPT_PLATFORM" in
  github|gitlab) ;;
  *)
    echo "Fehler: Ungültige Plattform '$OPT_PLATFORM'. Gültige Werte: github, gitlab." >&2
    echo "Error: Invalid platform '$OPT_PLATFORM'. Valid values: github, gitlab." >&2
    exit 2
    ;;
esac

if [ "$OPT_PLATFORM" = "gitlab" ]; then
  case "$OPT_GITLAB_URL" in
    https://*) ;;
    *)
      echo "Fehler: --gitlab-url muss mit 'https://' beginnen." >&2
      echo "Error: --gitlab-url must start with 'https://'." >&2
      exit 2
      ;;
  esac
  OPT_GITLAB_HOSTNAME="${OPT_GITLAB_URL#https://}"
  OPT_GITLAB_HOSTNAME="${OPT_GITLAB_HOSTNAME%/}"
  PROJECT_SLUG="$(normalize_name "$PROJECT_NAME")"
  if [ "$PROJECT_SLUG" != "$PROJECT_NAME" ]; then
    PROJECT_SLUG_CHANGED=true
  fi
fi

if [ "$OPT_PLATFORM" = "gitlab" ] && ! $OPT_NO_REMOTE; then
  if ! command -v glab >/dev/null 2>&1; then
    echo "Fehler: glab (GitLab CLI) ist nicht installiert." >&2
    echo "  macOS/Linux: brew install glab" >&2
    echo "  Windows:     winget install GLabCLI.GlabCLI" >&2
    echo "Error: glab (GitLab CLI) is not installed." >&2
    exit 2
  fi

  if ! GITLAB_HOST="$OPT_GITLAB_HOSTNAME" glab auth status >/dev/null 2>&1; then
    echo "Fehler: Nicht bei GitLab ($OPT_GITLAB_HOSTNAME) authentifiziert. Bitte 'glab auth login' ausführen." >&2
    echo "Error: Not authenticated with GitLab ($OPT_GITLAB_HOSTNAME). Please run 'glab auth login'." >&2
    exit 2
  fi

  GITLAB_USER_LOCAL="$(
    glab api user --hostname "$OPT_GITLAB_HOSTNAME" 2>/dev/null \
      | tr -d '\r\n' \
      | sed -n 's/.*"username":"\([^"]*\)".*/\1/p'
  )"
  if [ -z "$GITLAB_USER_LOCAL" ]; then
    echo "Fehler: Konnte GitLab-Benutzername nicht ermitteln." >&2
    echo "Error: Could not retrieve GitLab username." >&2
    exit 2
  fi
fi

# ─── Preview/Action Helpers ──────────────────────────────────────────────────

STEP=0
TOTAL_STEPS=30
SKIPPED=0
PARTIAL_FAIL=false
WORKSPACE_GITIGNORE_HEADER="# Sub-Verzeichnisse mit eigenen Git-Repositories (automatisch erkannt)"
WORKSPACE_GITIGNORE_RESULT="unchanged"
SPECIFY_AGENTS=(gemini opencode claude copilot codex)

preview_action() {
  local action="$1" target="$2" note="${3:-}"
  short_target="${target/#$HOME/~}"
  if [ -n "$note" ]; then
    printf "  %-8s %-50s (%s)\n" "$action" "$short_target" "$note"
  else
    printf "  %-8s %s\n" "$action" "$short_target"
  fi
}

step_start() {
  STEP=$((STEP + 1))
  printf "[%d/%d] -> %-44s" "$STEP" "$TOTAL_STEPS" "$1"
}

step_done() {
  local note="${1:-}"
  if [ -n "$note" ]; then
    printf " ✓  %s\n" "$note"
  else
    printf " ✓\n"
  fi
}

step_skip() {
  printf " (skip: %s)\n" "${1:-already done}"
  SKIPPED=$((SKIPPED + 1))
}

step_warn() {
  printf " WARN: %s\n" "$1"
  PARTIAL_FAIL=true
}

write_workspace_gitignore() {
  local gitignore_path="$1"
  shift

  {
    printf '%s\n' "$WORKSPACE_GITIGNORE_HEADER"
    while [ "$#" -gt 0 ]; do
      printf '%s/\n' "$1"
      shift
    done
    cat <<'EOF'

# macOS
.DS_Store
.AppleDouble
.LSOverride

# JetBrains IDEs
.idea/
*.iws
*.iml

# VS Code (lokale Einstellungen)
.vscode/c_cpp_properties.json
.vscode/settings.json

# Build-Artefakte
bin/
obj/
build/
node_modules/
EOF
  } > "$gitignore_path"
}

ensure_workspace_gitignore_entry() {
  local workspace_dir="$1"
  local project_name="$2"
  local gitignore_path="${workspace_dir}/.gitignore"
  local entry="${project_name}/"
  local tmp_file=""

  WORKSPACE_GITIGNORE_RESULT="unchanged"

  if [ -z "$project_name" ]; then
    return 1
  fi

  if [ ! -f "$gitignore_path" ]; then
    if $OPT_DRY_RUN; then
      WORKSPACE_GITIGNORE_RESULT="would-create"
      return 0
    fi
    write_workspace_gitignore "$gitignore_path" "$project_name"
    WORKSPACE_GITIGNORE_RESULT="created"
    return 0
  fi

  if grep -Fxq "$entry" "$gitignore_path"; then
    return 1
  fi

  if $OPT_DRY_RUN; then
    WORKSPACE_GITIGNORE_RESULT="would-update"
    return 0
  fi

  tmp_file="$(mktemp)"
  if grep -Fxq "$WORKSPACE_GITIGNORE_HEADER" "$gitignore_path"; then
    awk -v header="$WORKSPACE_GITIGNORE_HEADER" -v entry="$entry" '
      BEGIN {
        saw_header = 0
        in_section = 0
        inserted = 0
      }
      {
        if (!saw_header && $0 == header) {
          saw_header = 1
          in_section = 1
          print
          next
        }
        if (in_section && $0 == "") {
          print entry
          print
          inserted = 1
          in_section = 0
          next
        }
        print
      }
      END {
        if (saw_header && in_section && !inserted) {
          print entry
        }
      }
    ' "$gitignore_path" > "$tmp_file"
  else
    {
      printf '%s\n' "$WORKSPACE_GITIGNORE_HEADER"
      printf '%s\n\n' "$entry"
      cat "$gitignore_path"
    } > "$tmp_file"
  fi

  mv "$tmp_file" "$gitignore_path"
  WORKSPACE_GITIGNORE_RESULT="updated"
  return 0
}

# ─── Template Substitution ───────────────────────────────────────────────────

render_template() {
  local template="$1" output="$2"
  sed \
    -e "s|{{PROJECT_NAME}}|${PROJECT_NAME}|g" \
    -e "s|{{WORKSPACE}}|${TARGET_WORKSPACE/#$HOME/\~}|g" \
    "$template" > "$output"
}

# ─── Preview Mode ────────────────────────────────────────────────────────────

if $OPT_PREVIEW; then
  echo "[PREVIEW] Folgende Aktionen wuerden ausgefuehrt:"
  preview_action "CREATE" "${TARGET_DIR}/"
  preview_action "EXEC" "git init ${TARGET_DIR}"
  preview_action "CREATE" "${TARGET_DIR}/AGENTS.md" "aus AGENTS.md.tmpl"
  preview_action "CREATE" "${TARGET_DIR}/CLAUDE.md" "aus CLAUDE.md.tmpl"
  preview_action "CREATE" "${TARGET_DIR}/GEMINI.md" "aus GEMINI.md.tmpl"
  preview_action "CREATE" "${TARGET_DIR}/.github/copilot-instructions.md" "aus copilot-instructions.tmpl"
  preview_action "CREATE" "${TARGET_DIR}/README.md" "aus readme-template.md / README.md.tmpl"
  preview_action "COPY" "${TARGET_DIR}/constitution.md" "von ~/constitution.md"
  preview_action "CREATE" "${TARGET_DIR}/.github/workflows/homogeneity-check.yml"
  preview_action "CREATE" "${TARGET_DIR}/docs/project-statistics.md" "Statistik-Ledger (initial)"
  preview_action "PREPARE" "${TARGET_DIR}/docs/secure-development/" "bei erkannter MSL"
  preview_action "CREATE" "${TARGET_DIR}/Lastenheft_Secure-Development-Hardening.md" "bei erkannter MSL"
  preview_action "UPDATE" "${TARGET_DIR}/Lastenheft_Abarbeitungsreihenfolge.md" "Lastenheft*.md-Reihenfolge"
  preview_action "CREATE" "${TARGET_DIR}/STATS.md" "leer / empty"
  preview_action "CREATE" "${TARGET_DIR}/.gitignore" "aus gitignore-project.tmpl"
  preview_action "UPDATE" "${TARGET_WORKSPACE}/.gitignore" "Level-2-Projekt im Workspace ignorieren"
  if ! $OPT_NO_RELEASE_PLEASE; then
    if [ "$OPT_PLATFORM" = "github" ]; then
      preview_action "CREATE" "${TARGET_DIR}/release-please-config.json" "Release Please Konfiguration"
      preview_action "CREATE" "${TARGET_DIR}/.release-please-manifest.json" "Release Please Manifest"
      preview_action "CREATE" "${TARGET_DIR}/.github/workflows/release-please.yml" "Release Please Workflow"
    else
      preview_action "PRINT" "setup-gitlab-release.sh nach Projekt-CI ausfuehren" "GitLab Release-Automation"
    fi
  fi
  preview_action "COPY" "${TARGET_DIR}/scripts/" "von ~/scripts/"
  preview_action "INSTALL" "${TARGET_DIR}/.git/hooks/pre-push" "von ~/scripts/hooks/pre-push"
  preview_action "EXEC" "git commit -m 'feat: initial project bootstrap'"
  if $OPT_NO_REMOTE; then
    preview_action "SKIP" "Remote-Erstellung" "--no-remote"
  elif [ "$OPT_PLATFORM" = "github" ]; then
    preview_action "EXEC" "gh repo create (privat)" "optional"
    preview_action "EXEC" "git push" "optional"
    if ! $OPT_NO_RELEASE_PLEASE; then
      preview_action "EXEC" "gh api repos/.../actions/permissions/workflow" "GitHub Actions: PR-Erstellung erlauben"
    fi
  else
    preview_action "EXEC" "glab repo create (privat)" "optional"
    preview_action "EXEC" "git remote add origin https://HOST/USER/REPO.git" "optional"
    preview_action "EXEC" "git push" "optional"
  fi
  preview_action "EXEC" "claude /init" "optional"
  preview_action "PRINT" "Codex manuelle Anweisung" "interaktiv"
  preview_action "PRINT" "Gemini manuelle Anweisung" "interaktiv"
  preview_action "CHECK" "gh copilot --help" "optional"
  for agent in "${SPECIFY_AGENTS[@]}"; do
    preview_action "EXEC" "specify init --here --force --integration ${agent}" "optional"
  done
  if ! $OPT_NO_SPECKIT && ! $OPT_NO_GOVERNANCE_PRESETS; then
    preview_action "EXEC" "install-spec-kit-governance-presets.sh --repo ${TARGET_DIR}" "bei erkannter MSL"
  fi
  preview_action "EXEC" "check-homogeneity.sh (read-only)" "Compliance-Score"
  preview_action "EXEC" "bash scripts/init-stats.sh (Baseline)" "STATS.md"
  preview_action "UPDATE" "${HOME}/README.md" "Zeile nach <!-- workspace-table-end -->"
  echo "  [Keine Dateien wurden geschrieben]"
  exit 0
fi

# ─── Pre-flight Checks ───────────────────────────────────────────────────────

if ! command -v git >/dev/null 2>&1; then
  echo "FATAL: git not found — install with: sudo apt install git / brew install git" >&2
  exit 2
fi

if ! [ -d "$TARGET_WORKSPACE" ]; then
  echo "FATAL: target workspace does not exist: ${TARGET_WORKSPACE}" >&2
  echo "  Tipp: Erst Workspace mit bootstrap-workspace.sh anlegen." >&2
  exit 2
fi

# ─── Header ──────────────────────────────────────────────────────────────────

echo "$(printf '%s' "$(printf '=%.0s' {1..50})")"
echo "  bootstrap-project — Workspace Homogeneity Guardian"
echo "$(printf '%s' "$(printf '=%.0s' {1..50})")"
echo ""
printf "Projekt:    %s\n" "$PROJECT_NAME"
printf "Workspace:  %s\n" "${TARGET_WORKSPACE/#$HOME/\~}"
printf "Ziel:       %s\n" "${TARGET_DIR/#$HOME/\~}"
echo ""

# Check if already bootstrapped
if [ -d "$TARGET_DIR" ] && [ "$(ls -A "$TARGET_DIR" 2>/dev/null)" ]; then
  if ! $OPT_FORCE; then
    echo "WARN: ${TARGET_DIR/#$HOME/\~} already bootstrapped"
    echo "      Verwende --force um alle Schritte erneut auszufuehren."
    echo "      Fehlende Dateien werden ergaenzt."
    echo ""
  fi
fi

# ─── Step 1: Create directory ────────────────────────────────────────────────
step_start "Verzeichnis anlegen"
if [ -d "$TARGET_DIR" ]; then
  step_skip "existiert bereits"
else
  mkdir -p "$TARGET_DIR"
  step_done
fi

# ─── Step 2: git init ────────────────────────────────────────────────────────
step_start "git init"
if [ -d "${TARGET_DIR}/.git" ]; then
  step_skip ".git/ vorhanden"
else
  git init "$TARGET_DIR" >/dev/null 2>&1
  step_done
fi

# ─── Step 2b: Lokale git-Einstellungen / Local git settings ──────────────────
step_start "Lokale git-Einstellungen / Local git settings"
if [ -d "${TARGET_DIR}/.git" ]; then
  git -C "$TARGET_DIR" config --local core.autocrlf input >/dev/null 2>&1 || true
  step_done "Lokale git-Einstellungen gesetzt / Local git settings applied"
else
  step_skip "git-Repo noch nicht initialisiert / git repo not yet initialized"
fi

# ─── Step 3: AGENTS.md ───────────────────────────────────────────────────────
step_start "AGENTS.md erzeugen"
if [ -f "${TARGET_DIR}/AGENTS.md" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  if [ -f "${TEMPLATES_DIR}/AGENTS.md.tmpl" ]; then
    render_template "${TEMPLATES_DIR}/AGENTS.md.tmpl" "${TARGET_DIR}/AGENTS.md"
    step_done
  else
    step_warn "Template nicht gefunden: AGENTS.md.tmpl"
  fi
fi

# ─── Step 4: CLAUDE.md ───────────────────────────────────────────────────────
step_start "CLAUDE.md erzeugen"
if [ -f "${TARGET_DIR}/CLAUDE.md" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  if [ -f "${TEMPLATES_DIR}/CLAUDE.md.tmpl" ]; then
    render_template "${TEMPLATES_DIR}/CLAUDE.md.tmpl" "${TARGET_DIR}/CLAUDE.md"
    step_done
  else
    step_warn "Template nicht gefunden: CLAUDE.md.tmpl"
  fi
fi

# ─── Step 5: GEMINI.md ───────────────────────────────────────────────────────
step_start "GEMINI.md erzeugen"
if [ -f "${TARGET_DIR}/GEMINI.md" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  if [ -f "${TEMPLATES_DIR}/GEMINI.md.tmpl" ]; then
    render_template "${TEMPLATES_DIR}/GEMINI.md.tmpl" "${TARGET_DIR}/GEMINI.md"
    step_done
  else
    step_warn "Template nicht gefunden: GEMINI.md.tmpl"
  fi
fi

# ─── Step 6: copilot-instructions.md ─────────────────────────────────────────
step_start "copilot-instructions.md erzeugen"
copilot_dir="${TARGET_DIR}/.github"
copilot_file="${copilot_dir}/copilot-instructions.md"
if [ -f "$copilot_file" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  mkdir -p "$copilot_dir"
  if [ -f "${TEMPLATES_DIR}/copilot-instructions.tmpl" ]; then
    render_template "${TEMPLATES_DIR}/copilot-instructions.tmpl" "$copilot_file"
    step_done
  else
    step_warn "Template nicht gefunden: copilot-instructions.tmpl"
  fi
fi

# ─── Step 7: README.md erzeugen ───────────────────────────────────────────────
step_start "README.md erzeugen"
if [ -f "${TARGET_DIR}/README.md" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  readme_tmpl="${TEMPLATES_DIR}/project-readme-template.md"
  [ -f "$readme_tmpl" ] || readme_tmpl="${TEMPLATES_DIR}/readme-template.md"
  [ -f "$readme_tmpl" ] || readme_tmpl="${TEMPLATES_DIR}/README.md.tmpl"

  if [ -f "$readme_tmpl" ]; then
    render_template "$readme_tmpl" "${TARGET_DIR}/README.md"
    step_done
  else
    step_warn "Template nicht gefunden: project-readme-template.md / readme-template.md / README.md.tmpl"
  fi
fi

# ─── Step 7b: constitution.md kopieren ───────────────────────────────────────
step_start "constitution.md kopieren"
home_constitution="${HOME}/constitution.md"
if [ ! -f "$home_constitution" ]; then
  step_warn "~/constitution.md fehlt — bitte zuerst sync-constitution.sh ausfuehren"
elif [ -f "${TARGET_DIR}/constitution.md" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  cp "$home_constitution" "${TARGET_DIR}/constitution.md"
  step_done
fi

# ─── Step 7c: homogeneity-check.yml ──────────────────────────────────────────
step_start "homogeneity-check.yml erzeugen"
wf_dir="${TARGET_DIR}/.github/workflows"
wf_file="${wf_dir}/homogeneity-check.yml"
if [ -f "$wf_file" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  mkdir -p "$wf_dir"
  constitution_ver="v1.0.0"
  if [ -f "${HOME}/constitution.md" ]; then
    constitution_ver=$(head -1 "${HOME}/constitution.md" | grep -o 'v[0-9]*\.[0-9]*\.[0-9]*' || echo "v1.0.0")
  fi
  cat > "$wf_file" <<EOF
name: Homogeneity Check

on:
  push:
    branches: ["**"]
  pull_request:
    branches: [main, master]

jobs:
  homogeneity:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Install ripgrep
        run: sudo apt-get install -y ripgrep
      - name: Run homogeneity check
        run: bash scripts/check-homogeneity.sh --json --fail-fast .
        env:
          CONSTITUTION_VERSION: "${constitution_ver}"
EOF
  step_done
fi

# ─── Step 7d: docs/project-statistics.md (initial) ──────────────────────────
step_start "docs/project-statistics.md erzeugen"
stats_doc="${TARGET_DIR}/docs/project-statistics.md"
if [ -f "$stats_doc" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  mkdir -p "${TARGET_DIR}/docs"
  cat > "$stats_doc" <<STATSDOC
# Projektstatistik / Project Statistics — ${PROJECT_NAME}

> **Lebendiges Dokument / Living document** — nach jedem abgeschlossenen Feature,
> jeder Spec-Kit-Phase und auf explizite Anfrage aktualisieren.
>
> *Update after every completed feature, Spec-Kit phase, or on explicit request.*

---

## Fortschreibungsprotokoll / Update Log

Ältester Eintrag oben, neuester Eintrag unten.
*Oldest entry at top, newest entry at bottom.*

| Datum / Date | Phase / Branch | Aktivtage ges. | Zeilen ges. | Commits ges. | Hauptarbeitspakete / Main Work Packages |
|---|---|---:|---:|---:|---|
| $(date +%Y-%m-%d) | 0 — Bootstrap | 1 | — | 1 | Initialer Projekt-Bootstrap via bootstrap-project |

---

## Gesamtstand des Repositories / Repository Snapshot

Stand / As of: $(date +%Y-%m-%d) — *Erste Einträge nach dem initialen Arbeitspaket eintragen.*

| Kategorie / Category | Dateien / Files | Zeilen / Lines | Anteil / Share |
|---|---:|---:|---:|
| Produktionscode / Production code | — | — | — |
| Tests / Tests | — | — | — |
| Dokumentation / Documentation (.md) | — | — | — |
| **Gesamt / Total** | — | — | — |

---

## Gesamtstatistik / Overall Statistics

*Wird nach dem ersten dokumentierten Arbeitspaket befüllt.*
*To be filled after the first documented work package.*

| Kennzahl / Metric | Verdichteter Gesamtblick / Condensed Overview |
|---|---:|
| Artefaktbasis gesamt | — |
| Beobachtbarer Projektzeitraum | $(date +%Y-%m-%d) bis — |
| Sichtbare Git-Aktivtage | — |
| Repo-weiter Speedup gg. 80-Zeilen-Referenz | — |
| Repo-weiter Speedup gg. Thorsten-Referenz | — |
STATSDOC
  step_done
fi

# ─── Step 7e: Secure-Development-Hardening vorbereiten ──────────────────────
step_start "Secure-Development-Hardening vorbereiten"
if [ ! -f "$SECURE_DEV_LIB" ] || ! declare -F sdh_prepare_repo >/dev/null 2>&1; then
  step_warn "Secure-Development-Hardening-Hilfslogik nicht gefunden"
else
  if sdh_prepare_repo "$TARGET_DIR" "$PROJECT_NAME" "$OPT_PRIMARY_LANGUAGE" 0 0 "$SCRIPT_DIR"; then
    case "$SDH_PREPARE_RESULT" in
      prepared) step_done "$SDH_PREPARE_REASON" ;;
      skipped)  step_skip "$SDH_PREPARE_REASON" ;;
      *)        step_done "$SDH_PREPARE_RESULT $SDH_PREPARE_REASON" ;;
    esac
  else
    step_warn "$SDH_PREPARE_REASON"
  fi
fi

# ─── Step 8: STATS.md (initial) ──────────────────────────────────────────────
step_start "STATS.md (initial) erzeugen"
if [ -f "${TARGET_DIR}/STATS.md" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  printf '# STATS.md — %s\n\n## Überblick / Overview\n\nCompliance-Historie — Compliance History\n\n## Verwendung / Usage\n\nJeder `check-homogeneity.sh`-Aufruf fügt hier einen Eintrag hinzu.\n\nEach `check-homogeneity.sh` run appends an entry here.\n\n' "$PROJECT_NAME" > "${TARGET_DIR}/STATS.md"
  step_done
fi

# ─── Step 9: .gitignore ──────────────────────────────────────────────────────
step_start ".gitignore erzeugen"
if [ -f "${TARGET_DIR}/.gitignore" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  if [ -f "${TEMPLATES_DIR}/gitignore-project.tmpl" ]; then
    cp "${TEMPLATES_DIR}/gitignore-project.tmpl" "${TARGET_DIR}/.gitignore"
    step_done
  else
    step_warn "Template nicht gefunden: gitignore-project.tmpl"
  fi
fi

# ─── Step 9a: Workspace-.gitignore aktualisieren ─────────────────────────────
step_start "Workspace-.gitignore aktualisieren"
if ensure_workspace_gitignore_entry "$TARGET_WORKSPACE" "$PROJECT_NAME"; then
  case "$WORKSPACE_GITIGNORE_RESULT" in
    created)
      step_done "Workspace-.gitignore erstellt und ${PROJECT_NAME}/ eingetragen"
      ;;
    updated)
      step_done "${PROJECT_NAME}/ im Workspace ignoriert"
      ;;
    would-create)
      step_done "wuerde Workspace-.gitignore erstellen und ${PROJECT_NAME}/ eintragen"
      ;;
    would-update)
      step_done "wuerde ${PROJECT_NAME}/ im Workspace ignorieren"
      ;;
    *)
      step_done
      ;;
  esac
else
  step_skip "Eintrag vorhanden"
fi

# ─── Step 9b: Release-Automation einrichten ─────────────────────────────────
step_start "Release-Automation einrichten"
if $OPT_NO_RELEASE_PLEASE; then
  step_skip "--no-release-please"
elif [ "$OPT_PLATFORM" = "gitlab" ]; then
  step_skip "GitLab: via setup-gitlab-release.sh"
elif [ -f "${TARGET_DIR}/release-please-config.json" ] && ! $OPT_FORCE; then
  step_skip "Konfiguration existiert bereits"
else
  mkdir -p "${TARGET_DIR}/.github/workflows"
  cat > "${TARGET_DIR}/release-please-config.json" <<'RPCFG'
{
  "$schema": "https://raw.githubusercontent.com/googleapis/release-please/main/schemas/config.json",
  "release-type": "simple",
  "packages": {
    ".": {
      "changelog-sections": [
        {"type": "feat",     "section": "Features / Neue Funktionen"},
        {"type": "fix",      "section": "Bug Fixes / Fehlerbehebungen"},
        {"type": "docs",     "section": "Documentation / Dokumentation"},
        {"type": "chore",    "section": "Maintenance / Wartung", "hidden": false},
        {"type": "refactor", "section": "Refactoring", "hidden": true}
      ]
    }
  }
}
RPCFG
  printf '{\n  ".": "0.1.0"\n}\n' > "${TARGET_DIR}/.release-please-manifest.json"
  cat > "${TARGET_DIR}/.github/workflows/release-please.yml" <<'RPWF'
name: Release Please

on:
  push:
    branches: [main]

permissions:
  contents: write
  pull-requests: write

jobs:
  release-please:
    runs-on: ubuntu-latest
    steps:
      # Pinned Node.js 24-capable upstream SHA until the next tagged v4 release targets node24.
      - uses: googleapis/release-please-action@45996ed1f6d02564a971a2fa1b5860e934307cf7
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          config-file: release-please-config.json
          manifest-file: .release-please-manifest.json
RPWF
  step_done
fi

# ─── Step 10: Copy scripts/ ──────────────────────────────────────────────────
step_start "scripts/ kopieren"
if [ -d "${TARGET_DIR}/scripts" ] && ! $OPT_FORCE; then
  step_skip "scripts/ vorhanden"
else
  if [ -d "${HOME}/scripts" ]; then
    cp -r "${HOME}/scripts" "${TARGET_DIR}/scripts"
    step_done
  else
    step_warn "~/scripts/ nicht gefunden"
  fi
fi

# ─── Step 11: Install pre-push hook ──────────────────────────────────────────
step_start "pre-push Hook installieren"
hook_src="${HOME}/scripts/hooks/pre-push"
hook_dst="${TARGET_DIR}/.git/hooks/pre-push"
if [ -f "$hook_src" ]; then
  if [ -f "$hook_dst" ]; then
    src_hash=""
    dst_hash=""
    if command -v sha256sum >/dev/null 2>&1; then
      src_hash=$(sha256sum "$hook_src" | awk '{print $1}')
      dst_hash=$(sha256sum "$hook_dst" | awk '{print $1}')
    elif command -v shasum >/dev/null 2>&1; then
      src_hash=$(shasum -a 256 "$hook_src" | awk '{print $1}')
      dst_hash=$(shasum -a 256 "$hook_dst" | awk '{print $1}')
    fi
    if [ "$src_hash" = "$dst_hash" ] && ! $OPT_FORCE; then
      step_skip "Hook SHA-256 match"
    else
      mkdir -p "${TARGET_DIR}/.git/hooks"
      cp "$hook_src" "$hook_dst"
      chmod +x "$hook_dst"
      step_done "aktualisiert"
    fi
  else
    mkdir -p "${TARGET_DIR}/.git/hooks"
    cp "$hook_src" "$hook_dst"
    chmod +x "$hook_dst"
    step_done
  fi
else
  step_warn "~/scripts/hooks/pre-push nicht gefunden"
fi

# ─── Step 12: Initial git commit ─────────────────────────────────────────────
step_start "Initialer git-Commit"
if git -C "$TARGET_DIR" log --oneline 2>/dev/null | grep -q .; then
  step_skip "Commits vorhanden"
else
  git -C "$TARGET_DIR" add -A >/dev/null 2>&1
  git -C "$TARGET_DIR" commit -m "feat: initial project bootstrap — ${PROJECT_NAME}" >/dev/null 2>&1
  step_done
fi

# ─── Step 13: gh repo create ─────────────────────────────────────────────────
step_start "Repo erstellen (privat)"
if $OPT_NO_REMOTE; then
  step_skip "--no-remote"
elif git -C "$TARGET_DIR" remote get-url origin >/dev/null 2>&1; then
  remote_url="$(git -C "$TARGET_DIR" remote get-url origin 2>/dev/null || true)"
  SUMMARY_REPO_URL="$(repo_url_from_remote "$remote_url")"
  SUMMARY_DISPLAY_REPO="$(repo_name_from_url "$remote_url")"
  step_skip "Remote vorhanden"
elif [ "$OPT_PLATFORM" = "github" ] && command -v gh >/dev/null 2>&1; then
  repo_name=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  if gh repo create "$repo_name" --private --source "$TARGET_DIR" --remote origin >/dev/null 2>&1; then
    SUMMARY_REPO_URL="https://github.com/$(gh api user --jq '.login' 2>/dev/null || true)/$repo_name"
    SUMMARY_DISPLAY_REPO="$repo_name"
    step_done "$repo_name"
  else
    step_warn "gh repo create fehlgeschlagen"
  fi
elif [ "$OPT_PLATFORM" = "gitlab" ]; then
  remote_url="https://${OPT_GITLAB_HOSTNAME}/${GITLAB_USER_LOCAL}/${PROJECT_SLUG}.git"
  if GITLAB_HOST="$OPT_GITLAB_HOSTNAME" glab repo create "$PROJECT_SLUG" --private >/dev/null 2>&1; then
    if git -C "$TARGET_DIR" remote add origin "$remote_url" >/dev/null 2>&1; then
      SUMMARY_REPO_URL="${OPT_GITLAB_URL%/}/$GITLAB_USER_LOCAL/$PROJECT_SLUG"
      SUMMARY_DISPLAY_REPO="$PROJECT_SLUG"
      step_done "$PROJECT_SLUG"
    else
      step_warn "git remote add origin fehlgeschlagen / git remote add origin failed"
    fi
  else
    step_warn "glab repo create fehlgeschlagen / glab repo create failed"
  fi
else
  step_skip "gh nicht installiert"
fi

# ─── Step 14: git push ───────────────────────────────────────────────────────
step_start "git push"
if $OPT_NO_REMOTE; then
  step_skip "--no-remote"
elif ! git -C "$TARGET_DIR" remote get-url origin >/dev/null 2>&1; then
  step_skip "kein Remote konfiguriert"
else
  if git -C "$TARGET_DIR" push -u origin HEAD >/dev/null 2>&1; then
    step_done
  else
    step_warn "git push fehlgeschlagen"
  fi
fi

# ─── Step 14b: GitHub Actions Berechtigungen ────────────────────────────────
step_start "GitHub Actions Berechtigungen setzen"
if $OPT_NO_RELEASE_PLEASE || $OPT_NO_REMOTE || [ "$OPT_PLATFORM" != "github" ]; then
  step_skip "nicht anwendbar"
elif [ -z "$SUMMARY_REPO_URL" ]; then
  step_skip "kein Remote konfiguriert"
elif command -v gh >/dev/null 2>&1; then
  _rp_repo="${SUMMARY_REPO_URL#https://github.com/}"
  if gh api --method PUT "repos/${_rp_repo}/actions/permissions/workflow" \
    -f default_workflow_permissions=write \
    -F can_approve_pull_request_reviews=true >/dev/null 2>&1; then
    step_done "PR-Erstellung fuer GitHub Actions erlaubt"
  else
    step_warn "Berechtigungen nicht gesetzt — bitte manuell in Repo-Settings > Actions > General aktivieren"
  fi
else
  step_skip "gh nicht installiert"
fi

# ─── Step 15: Claude init ────────────────────────────────────────────────────
step_start "Claude init"
if $OPT_NO_AGENTS; then
  step_skip "--no-agents"
elif grep -q 'claude-init-done' "${TARGET_DIR}/CLAUDE.md" 2>/dev/null; then
  step_skip "bereits initialisiert"
elif command -v claude >/dev/null 2>&1; then
  (cd "$TARGET_DIR" && echo "/init" | claude >/dev/null 2>&1) || true
  echo "<!-- claude-init-done -->" >> "${TARGET_DIR}/CLAUDE.md"
  step_done
else
  step_warn "claude nicht installiert — bitte manuell initialisieren"
fi

# ─── Step 16: Codex (manual) ─────────────────────────────────────────────────
step_start "Codex (interaktiv)"
printf "\n"
printf "          -> Bitte manuell ausfuehren: cd %s && codex\n" "${TARGET_DIR/#$HOME/\~}"

# ─── Step 17: Gemini (manual) ────────────────────────────────────────────────
step_start "Gemini (interaktiv)"
printf "\n"
printf "          -> Bitte manuell ausfuehren: cd %s && gemini\n" "${TARGET_DIR/#$HOME/\~}"

# ─── Step 18: Copilot check ──────────────────────────────────────────────────
step_start "Copilot verfuegbar pruefen"
if command -v gh >/dev/null 2>&1 && gh extension list 2>/dev/null | grep -q copilot; then
  step_done "gh copilot verfuegbar"
else
  step_skip "gh copilot nicht installiert"
fi

# ─── Step 19: Spec-kit install ───────────────────────────────────────────────
step_start "Spec-kit installieren"
if $OPT_NO_SPECKIT; then
  step_skip "--no-speckit"
elif [ -d "${TARGET_DIR}/.specify" ] && ! $OPT_FORCE; then
  step_skip ".specify/ vorhanden"
elif command -v specify >/dev/null 2>&1; then
  for agent in "${SPECIFY_AGENTS[@]}"; do
    if ! (cd "$TARGET_DIR" && specify init --here --force --integration "$agent" >/dev/null 2>&1); then
      step_warn "specify init fehlgeschlagen fuer ${agent}"
    fi
  done
  [ -d "${TARGET_DIR}/.specify" ] && step_done || step_warn "specify init kein .specify/ erstellt"
else
  step_warn "specify nicht installiert"
  echo "          -> uv tool install specify-cli --from git+https://github.com/github/spec-kit.git"
  echo "          -> Dann je Agent: cd ${TARGET_DIR/#$HOME/\~} && specify init --here --force --integration {gemini|opencode|claude|copilot|codex}"
fi

if [ -f "${TARGET_DIR}/constitution.md" ] && [ -d "${TARGET_DIR}/.specify/memory" ]; then
  cp "${TARGET_DIR}/constitution.md" "${TARGET_DIR}/.specify/memory/constitution.md"
fi

# ─── Step 20: Governance-Presets installieren ────────────────────────────────
step_start "Governance-Presets installieren"
if $OPT_NO_SPECKIT; then
  step_skip "--no-speckit"
elif $OPT_NO_GOVERNANCE_PRESETS; then
  step_skip "--no-governance-presets"
elif [ "${SDH_PREPARE_RESULT:-}" != "prepared" ]; then
  step_skip "keine MSL-Vorbereitung"
elif [ ! -d "${TARGET_DIR}/.specify" ]; then
  step_skip "Spec Kit nicht initialisiert"
elif [ ! -f "${SCRIPT_DIR}/install-spec-kit-governance-presets.sh" ]; then
  step_warn "Preset-Installer nicht gefunden"
else
  preset_args=(--repo "$TARGET_DIR")
  $OPT_FORCE && preset_args+=(--force)
  if bash "${SCRIPT_DIR}/install-spec-kit-governance-presets.sh" "${preset_args[@]}"; then
    step_done "aus zentraler Preset-Matrix"
  else
    step_warn "Governance-Preset-Installation fehlgeschlagen"
  fi
fi

# ─── Step 21: Compliance check + STATS baseline ──────────────────────────────
step_start "Compliance-Check + STATS-Baseline"
if [ -f "${SCRIPT_DIR}/init-stats.sh" ]; then
  bash "${SCRIPT_DIR}/init-stats.sh" "$TARGET_DIR" >/dev/null 2>&1 || true
  step_done "STATS.md Baseline geschrieben"
elif [ -f "${SCRIPT_DIR}/check-homogeneity.sh" ]; then
  compliance_score=$(bash "${SCRIPT_DIR}/check-homogeneity.sh" --dry-run "$TARGET_DIR" 2>/dev/null \
    | grep 'Overall:' | grep -o '[0-9]*' | head -1 || echo "?")
  step_done "Score: ${compliance_score} %"
else
  step_skip "check-homogeneity.sh nicht gefunden"
fi

# ─── Step 22: Update ~/README.md ─────────────────────────────────────────────
step_start "~/README.md aktualisieren"
home_readme="${HOME}/README.md"
short_target="${TARGET_DIR/#$HOME/\~}"
if grep -q -- "$PROJECT_NAME" "$home_readme" 2>/dev/null; then
  step_skip "Eintrag vorhanden"
elif [ -f "$home_readme" ] && grep -q '<!-- workspace-table-end -->' "$home_readme"; then
  if [ -n "$SUMMARY_REPO_URL" ] && [ -n "$SUMMARY_DISPLAY_REPO" ]; then
    repo_cell="[$SUMMARY_DISPLAY_REPO]($SUMMARY_REPO_URL)"
  else
    repo_cell="—"
  fi
  row="| \`${short_target}/\` | ${repo_cell} | \`bootstrap-project\` |\n"
  sed -i "" "s|<!-- workspace-table-end -->|${row}<!-- workspace-table-end -->|" "$home_readme" 2>/dev/null || \
  python3 -c "
content = open('${home_readme}').read()
row = '${row}'
content = content.replace('<!-- workspace-table-end -->', row + '<!-- workspace-table-end -->')
open('${home_readme}','w').write(content)
" 2>/dev/null || step_warn "README.md Update fehlgeschlagen"
  step_done
else
  step_skip "README.md oder Marker nicht gefunden"
fi

# ─── Footer ──────────────────────────────────────────────────────────────────

echo ""
echo "$(printf '%s' "$(printf '=%.0s' {1..50})")"
if $PARTIAL_FAIL; then
  echo "  Bootstrap teilweise abgeschlossen (Warnungen vorhanden)"
else
  echo "  Bootstrap abgeschlossen ✓"
fi
if [ "$OPT_PLATFORM" = "gitlab" ] && $PROJECT_SLUG_CHANGED; then
  echo "  GitLab-Slug : $PROJECT_SLUG (normalisiert von: $PROJECT_NAME)"
fi
if [ -n "$SUMMARY_REPO_URL" ]; then
  echo "  Repo   : $SUMMARY_REPO_URL"
  echo "  Clone  : git clone ${SUMMARY_REPO_URL}.git ${TARGET_DIR}"
fi
printf "  %s/ ist bereit.\n" "${TARGET_DIR/#$HOME/\~}"
echo ""
echo "  Naechste Schritte:"
printf "  -> cd %s\n" "${TARGET_DIR/#$HOME/\~}"
echo "  -> codex   (interaktive Initialisierung)"
echo "  -> gemini  (interaktive Initialisierung)"
echo "  -> Spec-Kit ist fuer gemini, opencode, claude, copilot und codex vorbereitet"
echo "  -> specify specify \"Feature-Name\""
echo "$(printf '%s' "$(printf '=%.0s' {1..50})")"

if $PARTIAL_FAIL; then
  exit 1
fi
exit 0
