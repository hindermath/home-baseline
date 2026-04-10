#!/usr/bin/env bash
# bootstrap-project.sh — Idempotenter Projekt-Bootstrap v1.0
# FR-009–016; Contract: bootstrap-project-cli.md
#
# Usage: bootstrap-project.sh <ProjectName> [TARGET_WORKSPACE] [OPTIONS]
# Options:
#   --preview       Show planned actions, write nothing
#   --force         Overwrite existing files
#   --no-agents     Skip AI agent initialization
#   --no-speckit    Skip Spec-kit installation
#   --no-remote     No gh repo create (local git init only)
#   --lang de|en    Primary language for templates (default: de)
# Exit codes: 0=success, 1=partial (warnings), 2=fatal

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="${SCRIPT_DIR}/templates"

# ─── Argument Parsing ────────────────────────────────────────────────────────

OPT_PREVIEW=false
OPT_DRY_RUN=false
OPT_FORCE=false
OPT_NO_AGENTS=false
OPT_NO_SPECKIT=false
OPT_NO_REMOTE=false
OPT_LANG="de"
PROJECT_NAME=""
TARGET_WORKSPACE=""

while [ $# -gt 0 ]; do
  case "$1" in
    --preview|--dry-run) OPT_PREVIEW=true; OPT_DRY_RUN=true ;;
    --force)      OPT_FORCE=true ;;
    --no-agents)  OPT_NO_AGENTS=true ;;
    --no-speckit) OPT_NO_SPECKIT=true ;;
    --no-remote)  OPT_NO_REMOTE=true ;;
    --lang)       OPT_LANG="${2:-de}"; shift ;;
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

# ─── Preview/Action Helpers ──────────────────────────────────────────────────

STEP=0
TOTAL_STEPS=22
SKIPPED=0
PARTIAL_FAIL=false

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
  preview_action "CREATE" "${TARGET_DIR}/STATS.md" "leer / empty"
  preview_action "CREATE" "${TARGET_DIR}/.gitignore" "aus gitignore-project.tmpl"
  preview_action "COPY" "${TARGET_DIR}/scripts/" "von ~/scripts/"
  preview_action "INSTALL" "${TARGET_DIR}/.git/hooks/pre-push" "von ~/scripts/hooks/pre-push"
  preview_action "EXEC" "git commit -m 'feat: initial project bootstrap'"
  preview_action "EXEC" "gh repo create (privat)" "optional"
  preview_action "EXEC" "git push" "optional"
  preview_action "EXEC" "claude /init" "optional"
  preview_action "PRINT" "Codex manuelle Anweisung" "interaktiv"
  preview_action "PRINT" "Gemini manuelle Anweisung" "interaktiv"
  preview_action "CHECK" "gh copilot --help" "optional"
  preview_action "EXEC" "npx speckit init" "optional"
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

# ─── Step 7: README.md ───────────────────────────────────────────────────────
step_start "README.md erzeugen"
if [ -f "${TARGET_DIR}/README.md" ] && ! $OPT_FORCE; then
  step_skip "Datei existiert"
else
  readme_tmpl="${TEMPLATES_DIR}/readme-template.md"
  [ -f "$readme_tmpl" ] || readme_tmpl="${TEMPLATES_DIR}/README.md.tmpl"
  if [ -f "$readme_tmpl" ]; then
    render_template "$readme_tmpl" "${TARGET_DIR}/README.md"
    step_done
  else
    step_warn "Template nicht gefunden: readme-template.md / README.md.tmpl"
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
        run: bash scripts/check-homogeneity.sh --json --exit-on-fail
        env:
          CONSTITUTION_VERSION: "${constitution_ver}"
EOF
  step_done
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
step_start "gh repo create (privat)"
if $OPT_NO_REMOTE; then
  step_skip "--no-remote"
elif git -C "$TARGET_DIR" remote get-url origin >/dev/null 2>&1; then
  step_skip "Remote vorhanden"
elif command -v gh >/dev/null 2>&1; then
  repo_name=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
  if gh repo create "$repo_name" --private --source "$TARGET_DIR" --remote origin >/dev/null 2>&1; then
    step_done "$repo_name"
  else
    step_warn "gh repo create fehlgeschlagen"
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
elif command -v npx >/dev/null 2>&1; then
  (cd "$TARGET_DIR" && npx speckit init >/dev/null 2>&1) || step_warn "npx speckit init fehlgeschlagen"
  [ -d "${TARGET_DIR}/.specify" ] && step_done || step_warn "speckit init kein .specify/ erstellt"
else
  step_skip "node/npx nicht installiert"
fi

# ─── Step 20: Compliance check + STATS baseline ──────────────────────────────
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

# ─── Step 21: Update ~/README.md ─────────────────────────────────────────────
step_start "~/README.md aktualisieren"
home_readme="${HOME}/README.md"
short_target="${TARGET_DIR/#$HOME/\~}"
if grep -q "$PROJECT_NAME" "$home_readme" 2>/dev/null; then
  step_skip "Eintrag vorhanden"
elif [ -f "$home_readme" ] && grep -q '<!-- workspace-table-end -->' "$home_readme"; then
  # Determine workspace link
  ws_short="${TARGET_WORKSPACE/#$HOME/\~}"
  sed -i "" "s|<!-- workspace-table-end -->|| ${ws_short}/${PROJECT_NAME}/ | — |\n<!-- workspace-table-end -->|" "$home_readme" 2>/dev/null || \
  python3 -c "
content = open('${home_readme}').read()
row = '| \`${short_target}/\` | — |\n'
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
printf "  %s/ ist bereit.\n" "${TARGET_DIR/#$HOME/\~}"
echo ""
echo "  Naechste Schritte:"
printf "  -> cd %s\n" "${TARGET_DIR/#$HOME/\~}"
echo "  -> codex   (interaktive Initialisierung)"
echo "  -> gemini  (interaktive Initialisierung)"
echo "  -> npx speckit specify \"Feature-Name\""
echo "$(printf '%s' "$(printf '=%.0s' {1..50})")"

if $PARTIAL_FAIL; then
  exit 1
fi
exit 0
