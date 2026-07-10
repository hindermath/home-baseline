#!/usr/bin/env bash
# sync-home.sh — Synchronisiert ~/home-baseline-tmp nach ~/
# Verwendung: bash ~/scripts/sync-home.sh [--pull] [--commit] [--dry-run]
#
# --pull     : git pull in home-baseline-tmp vor dem Sync (Standard: ja)
# --commit   : git commit in ~/ nach dem Sync (Standard: ja)
# --dry-run  : Nur anzeigen, was gemacht würde
# --no-pull  : Kein git pull (nur kopieren)
# --no-commit: Kein automatischer Commit in ~/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Repo-Klon: ein Verzeichnis über scripts/
REPO_DIR="$(dirname "$SCRIPT_DIR")"
HOME_DIR="${HOME}"

# Falls aus ~/scripts/ aufgerufen (REPO_DIR == HOME_DIR), automatisch home-baseline-tmp nutzen
if [ "$REPO_DIR" = "$HOME_DIR" ]; then
  REPO_DIR="${HOME_DIR}/home-baseline-tmp"
  if [ ! -d "$REPO_DIR" ]; then
    echo "Fehler: ~/home-baseline-tmp nicht gefunden." >&2
    echo "Bitte zuerst den persoenlichen Fork gemaess docs/learning-units/START-HERE-FUER-LERNENDE.md nach ~/home-baseline-tmp klonen." >&2
    exit 1
  fi
fi

if [ "$SCRIPT_DIR" = "${HOME_DIR}/scripts" ] && [ -f "${REPO_DIR}/scripts/sync-home.sh" ]; then
  exec bash "${REPO_DIR}/scripts/sync-home.sh" "$@"
fi

OPT_PULL=true
OPT_COMMIT=true
OPT_DRY_RUN=false

while [ $# -gt 0 ]; do
  case "$1" in
    --pull)      OPT_PULL=true ;;
    --no-pull)   OPT_PULL=false ;;
    --commit)    OPT_COMMIT=true ;;
    --no-commit) OPT_COMMIT=false ;;
    --dry-run)   OPT_DRY_RUN=true; OPT_PULL=false; OPT_COMMIT=false ;;
    *) echo "Unbekannte Option: $1" >&2; exit 2 ;;
  esac
  shift
done

echo "╔══════════════════════════════════════════════════╗"
echo "║  sync-home — Home-Baseline Sync                  ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "  Quelle : ${REPO_DIR}"
echo "  Ziel   : ${HOME_DIR}"
echo "  Pull   : ${OPT_PULL}"
echo "  Commit : ${OPT_COMMIT}"
echo "  Dry-run: ${OPT_DRY_RUN}"
echo ""

# ── 1. git pull ──────────────────────────────────────────────────────────────
if $OPT_PULL; then
  echo "→ git pull in ${REPO_DIR}..."
  git -C "${REPO_DIR}" pull --ff-only
  echo ""
fi

# ── 2. Dateien kopieren ──────────────────────────────────────────────────────
sync_file() {
  local src="${REPO_DIR}/${1}"
  local dst="${HOME_DIR}/${1}"
  [ -f "$src" ] || return 0
  if $OPT_DRY_RUN; then
    echo "  [dry-run] cp ${1}"
  else
    mkdir -p "$(dirname "$dst")"
    cp "$src" "$dst"
    echo "  ✓ ${1}"
  fi
}

sync_dir() {
  local src="${REPO_DIR}/${1}"
  local dst="${HOME_DIR}/${1}"
  [ -d "$src" ] || return 0
  if $OPT_DRY_RUN; then
    echo "  [dry-run] cp -r ${1}/"
  else
    mkdir -p "$dst"
    cp -r "${src}/." "${dst}/"
    find "$dst" -name '.DS_Store' -type f -delete
    echo "  ✓ ${1}/"
  fi
}

ensure_gitconfig_baseline() {
  if $OPT_DRY_RUN; then
    echo "  [dry-run] ~/.gitconfig Baseline-Einstellungen prüfen / check baseline settings"
    return
  fi

  touch "${HOME_DIR}/.gitconfig"
  if grep -qF 'WICHTIG / IMPORTANT: Name und E-Mail MÜSSEN geändert werden!' "${HOME_DIR}/.gitconfig" 2>/dev/null; then
    tmp_gitconfig="$(mktemp)"
    cat > "$tmp_gitconfig" <<'EOF'
; ============================================================
; Lokale Git-Konfiguration / Local git configuration
;
; user.name und user.email werden lokal durch setup-git-identity.*
; gepflegt. sync-home.* überschreibt diese Identität nicht.
;
; user.name and user.email are maintained locally by
; setup-git-identity.*. sync-home.* does not overwrite them.
; ============================================================
EOF
    awk '
      BEGIN { skip = 0; done = 0 }
      /^; ============================================================$/ && done == 0 { skip = 1; next }
      skip == 1 && /^; ============================================================$/ { skip = 0; done = 1; next }
      skip == 0 { print }
    ' "${HOME_DIR}/.gitconfig" >> "$tmp_gitconfig"
    mv "$tmp_gitconfig" "${HOME_DIR}/.gitconfig"
  fi

  git config --global init.defaultBranch main
  git config --global core.autocrlf input
  git config --global pull.rebase true

  if ! grep -qF 'gitdir:~/home-baseline-tmp/' "${HOME_DIR}/.gitconfig" 2>/dev/null; then
    printf '\n[includeIf "gitdir:~/home-baseline-tmp/"]\n\tpath = ~/.gitconfig.d/home-baseline.inc\n' >> "${HOME_DIR}/.gitconfig"
  fi

  echo "  ✓ ~/.gitconfig Baseline-Einstellungen geprüft / baseline settings checked"
}

echo "→ Dateien synchronisieren..."

# Root-Dateien
for f in AGENTS.md CLAUDE.md GEMINI.md README.md STATS.md CHANGELOG.md constitution.md \
          .gitignore LICENSE; do
  sync_file "$f"
done

# Lastenheft (glob-Muster)
for f in "${REPO_DIR}"/Lastenheft*.md; do
  [ -f "$f" ] && sync_file "$(basename "$f")"
done

# Verzeichnisse
sync_dir "scripts"
sync_dir "docs"
sync_dir ".github"
sync_dir "specs"
sync_dir ".specify"

echo ""

# ── 3. ~/.gitconfig.d/ Bootstrap ─────────────────────────────────────────────
gitconfig_d="${HOME}/.gitconfig.d"
placeholder="${gitconfig_d}/home-baseline.inc"
if $OPT_DRY_RUN; then
  if [ -d "$gitconfig_d" ]; then
    echo "  [dry-run] ~/.gitconfig.d/ bereits vorhanden — Inhalt wird nicht überschrieben / already exists — content preserved"
  else
    echo "  [dry-run] ~/.gitconfig.d/ würde erstellt mit home-baseline.inc / would be created with home-baseline.inc"
  fi
elif [ -d "$gitconfig_d" ]; then
  echo "  → ~/.gitconfig.d/ bereits vorhanden — Inhalt wird nicht überschrieben / already exists — content preserved"
else
  mkdir -p "$gitconfig_d"
  printf '# home-baseline workspace git configuration\n# Hier workspace-spezifische git-Einstellungen eintragen:\n# [user]\n#   email = work@example.com\n' > "$placeholder"
  echo "  ✓ ~/.gitconfig.d/ erstellt mit home-baseline.inc / created with home-baseline.inc"
fi

ensure_gitconfig_baseline

echo ""

# ── 4. Globale Git-Identität reparieren ──────────────────────────────────────
identity_script="${HOME_DIR}/scripts/setup-git-identity.sh"
if $OPT_DRY_RUN; then
  echo "  [dry-run] bash ~/scripts/setup-git-identity.sh --auto"
elif [ -f "$identity_script" ]; then
  echo "→ Git-Identität in ~/.gitconfig prüfen und reparieren..."
  bash "$identity_script" --auto
  echo ""
else
  echo "Warnung: ~/scripts/setup-git-identity.sh nicht gefunden — Git-Identität nicht geprüft." >&2
  echo "Warning: ~/scripts/setup-git-identity.sh not found — git identity not checked." >&2
  echo ""
fi

# ── 5. git commit in ~/ ──────────────────────────────────────────────────────
if $OPT_COMMIT; then
  cd "${HOME_DIR}"

  # Falls ~/ noch kein Git-Repo ist, automatisch initialisieren
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "→ ~/ ist noch kein Git-Repository — initialisiere..."
    git init
    if [ -f "${HOME_DIR}/scripts/install-hooks.sh" ]; then
      bash "${HOME_DIR}/scripts/install-hooks.sh"
    fi
    echo "  ✓ Git-Repository und Hooks initialisiert."
    echo ""
  fi

  if [ -z "$(git status --short)" ]; then
    echo "→ Keine Änderungen in ~/ — kein Commit nötig."
  else
    git add -A
    REMOTE_SHA=$(git -C "${REPO_DIR}" rev-parse --short HEAD 2>/dev/null || echo "unbekannt")
    git commit -m "chore: sync mit home-baseline @ ${REMOTE_SHA}

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
    echo "→ Commit in ~/ erstellt."
  fi
fi

echo ""
echo "✓ sync-home abgeschlossen."
