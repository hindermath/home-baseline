#!/usr/bin/env bash
# bootstrap-workspace.sh
# Richtet ein neues Projektverzeichnis als privates GitHub-Repo ein:
#   git init · .gitignore · Scripts kopieren · gh repo create · push · Hooks installieren
#
# Verwendung:
#   bash ~/scripts/bootstrap-workspace.sh <Verzeichnisname> [GitHub-Repo-Name] [Beschreibung]
#
# Beispiel:
#   bash ~/scripts/bootstrap-workspace.sh WebstormProjects webstorm-baseline "Workspace-Konfiguration für WebStorm-Projekte"
#
# Optionen:
#   --dry-run   Zeigt alle Schritte ohne Ausführung

set -euo pipefail

# --- Hilfsfunktionen -----------------------------------------------------------

usage() {
  echo "Verwendung: $(basename "$0") <Verzeichnisname> [GitHub-Repo-Name] [Beschreibung]"
  echo "            $(basename "$0") --dry-run <Verzeichnisname> ..."
  exit 1
}

log()  { echo "  $*"; }
ok()   { echo "✓ $*"; }
info() { echo "→ $*"; }

# --- Parameter parsen ----------------------------------------------------------

DRY_RUN=0
if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN=1
  shift
fi

[ "${1:-}" = "" ] && usage

WORKSPACE_NAME="$1"
REPO_NAME="${2:-$(echo "$WORKSPACE_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/projects$/-baseline/' | sed 's/ /-/g')}"
REPO_DESC="${3:-Gemeinsame Workspace-Konfiguration für $WORKSPACE_NAME}"

HOME_DIR="$(cd ~ && pwd)"
WORKSPACE_DIR="$HOME_DIR/$WORKSPACE_NAME"
SCRIPTS_SRC="$HOME_DIR/scripts"

# --- Vorabprüfungen ------------------------------------------------------------

if [ ! -d "$WORKSPACE_DIR" ]; then
  echo "Fehler: Verzeichnis '$WORKSPACE_DIR' existiert nicht." >&2
  exit 1
fi

if [ -d "$WORKSPACE_DIR/.git" ]; then
  echo "Fehler: '$WORKSPACE_DIR' ist bereits ein Git-Repository." >&2
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "Fehler: gh (GitHub CLI) ist nicht installiert." >&2
  exit 1
fi

# --- Zusammenfassung anzeigen --------------------------------------------------

echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║  bootstrap-workspace – Neue Workspace-Einrichtung               ║"
echo "╠══════════════════════════════════════════════════════════════════╣"
printf "║  Verzeichnis : %-51s║\n" "$WORKSPACE_DIR"
printf "║  GitHub-Repo : %-51s║\n" "hindermath/$REPO_NAME (privat)"
printf "║  Beschreibung: %-51s║\n" "${REPO_DESC:0:51}"
echo "╚══════════════════════════════════════════════════════════════════╝"
[ "$DRY_RUN" -eq 1 ] && echo "  [DRY RUN – keine Änderungen werden vorgenommen]"
echo ""

run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "  [dry-run] $*"
  else
    eval "$@"
  fi
}

# --- Sub-Repos ermitteln (bestehende .git-Verzeichnisse) ----------------------

info "Suche bestehende Sub-Repositories …"
SUB_REPOS=()
while IFS= read -r sub; do
  sub_name="$(basename "$(dirname "$sub")")"
  SUB_REPOS+=("$sub_name")
  log "Gefunden: $sub_name/"
done < <(find "$WORKSPACE_DIR" -maxdepth 2 -name ".git" -type d | sort)

# --- .gitignore erstellen ------------------------------------------------------

info "Erstelle .gitignore …"
GITIGNORE_PATH="$WORKSPACE_DIR/.gitignore"

if [ "$DRY_RUN" -eq 0 ]; then
  {
    echo "# Sub-Verzeichnisse mit eigenen Git-Repositories (automatisch erkannt)"
    for repo in "${SUB_REPOS[@]}"; do
      echo "$repo/"
    done
    echo ""
    cat <<'STATIC'
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
STATIC
  } > "$GITIGNORE_PATH"
  ok ".gitignore erstellt"
else
  echo "  [dry-run] .gitignore würde erstellt mit Einträgen für: ${SUB_REPOS[*]:-keine}"
fi

# --- Scripts kopieren ----------------------------------------------------------

info "Kopiere Scripts …"
run "mkdir -p '$WORKSPACE_DIR/scripts/hooks'"
run "cp '$SCRIPTS_SRC/scan-agent-secrets.sh'  '$WORKSPACE_DIR/scripts/'"
run "cp '$SCRIPTS_SRC/scan-agent-secrets.ps1'  '$WORKSPACE_DIR/scripts/'"
run "cp '$SCRIPTS_SRC/install-hooks.sh'         '$WORKSPACE_DIR/scripts/'"
run "cp '$SCRIPTS_SRC/install-hooks.ps1'         '$WORKSPACE_DIR/scripts/'"
run "cp '$SCRIPTS_SRC/hooks/pre-push'            '$WORKSPACE_DIR/scripts/hooks/'"
run "chmod +x '$WORKSPACE_DIR/scripts/'*.sh '$WORKSPACE_DIR/scripts/hooks/pre-push'"
ok "Scripts kopiert"

# --- git init + commit ---------------------------------------------------------

info "Initialisiere Git-Repository …"
run "git -C '$WORKSPACE_DIR' init"
run "git -C '$WORKSPACE_DIR' add .gitignore scripts/"
run "git -C '$WORKSPACE_DIR' commit -m 'chore: initiale Baseline-Konfiguration für $WORKSPACE_NAME

- .gitignore        – schließt Sub-Repos und Artefakte aus
- scripts/          – Secret-Scan, Hook-Installation (Bash + PowerShell)

Nach dem Clonen auf neuem Gerät:
  bash scripts/install-hooks.sh       (macOS/Linux)
  pwsh scripts/install-hooks.ps1      (Windows)

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>'"
ok "Initialer Commit erstellt"

# --- GitHub-Repo erstellen und pushen ------------------------------------------

info "Erstelle privates GitHub-Repository '$REPO_NAME' …"
run "gh repo create '$REPO_NAME' --private --description '$REPO_DESC' --source '$WORKSPACE_DIR' --remote origin --push"
ok "GitHub-Repo erstellt und gepusht"

# --- Hooks installieren --------------------------------------------------------

info "Installiere Git-Hooks …"
run "bash '$WORKSPACE_DIR/scripts/install-hooks.sh'"
ok "Hooks installiert"

# --- Fertig --------------------------------------------------------------------

echo ""
echo "╔══════════════════════════════════════════════════════════════════╗"
echo "║  Einrichtung abgeschlossen!                                      ║"
echo "╚══════════════════════════════════════════════════════════════════╝"
echo ""
echo "  Repo   : https://github.com/hindermath/$REPO_NAME"
echo "  Clone  : git clone https://github.com/hindermath/$REPO_NAME.git ~/$WORKSPACE_NAME"
echo "  Hooks  : bash scripts/install-hooks.sh  (oder pwsh scripts/install-hooks.ps1)"
echo ""
