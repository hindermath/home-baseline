#!/usr/bin/env bash
# propagate-learning-series.sh
# Propagiert Lernreihen-Material aus Level-0 (~/home-baseline-tmp/docs/learning-units)
# in die zugehoerigen Level-1- und Level-2-Repos einer Lernreihe.
#
# Propagates learning-series material from Level-0 into the matching Level-1 and
# Level-2 repositories of a learning series.
#
# Kernprinzipien / Core principles:
#   - Registry-gesteuerte Repo-Erkennung ueber ~/.home-baseline/level2-repository-registry.json;
#     Filter per Serien-Praefix (Standard: SecureCaseTracker). Keine hartcodierten Repo-Pfade.
#   - Serien-gebundene Quell-Auswahl: nur Dateien der gewaehlten Serie werden kopiert;
#     andere Reihen (z. B. Secure InventoryHub) bleiben unberuehrt.
#   - Level-2 haelt Root-Intakes UND docs/learning-units/ synchron; Level-1 nur docs/learning-units/.
#   - Idempotent: Kopie ueberschreibt inhaltsgleich, nur echte Aenderungen erzeugen Git-Commits.
#   - Nicht destruktiv: es werden keine Zieldateien geloescht.
#   - Dry-Run: --dry-run zeigt alle geplanten Aenderungen ohne zu schreiben.
#
# Verwendung / Usage:
#   bash ~/scripts/propagate-learning-series.sh --dry-run
#   bash ~/scripts/propagate-learning-series.sh
#   bash ~/scripts/propagate-learning-series.sh --no-push
#   bash ~/scripts/propagate-learning-series.sh --series SecureCaseTracker --home-dir ~
#
# Sichere-Entwicklung-Kurzregeln (Bash): Variablen gequotet, `--` End-of-Options,
# kein `eval` auf nicht vertrauenswuerdigem Input, `set -euo pipefail`.

set -euo pipefail

# --- Konfiguration / Configuration --------------------------------------------

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LEVEL0_DIR="$(cd -- "${SCRIPT_DIR}/.." && pwd)"
SRC_UNITS="${LEVEL0_DIR}/docs/learning-units"

HOME_DIR="$(cd -- ~ && pwd)"
SERIES="SecureCaseTracker"        # Registry-/Verzeichnis-Token (ohne Bindestrich)
FILE_SERIES=""                    # Datei-Praefix (mit Bindestrich); leer => aus SERIES ableiten
REGISTRY="${HOME_DIR}/.home-baseline/level2-repository-registry.json"

DRY_RUN=0
NO_PUSH=0
VERBOSE=0
REPOS_CHANGED=0
REPOS_TOTAL=0
FILES_CHANGED=0

# --- Parameter / Arguments ----------------------------------------------------

while [ $# -gt 0 ]; do
  case "${1:-}" in
    --dry-run)   DRY_RUN=1 ;;
    --no-push)   NO_PUSH=1 ;;
    --verbose|-v) VERBOSE=1 ;;
    --series)    SERIES="${2:?--series benoetigt einen Wert}"; shift ;;
    --file-prefix) FILE_SERIES="${2:?--file-prefix benoetigt einen Wert}"; shift ;;
    --home-dir)  HOME_DIR="$(cd -- "${2:?--home-dir benoetigt einen Wert}" && pwd)"; shift ;;
    --registry)  REGISTRY="${2:?--registry benoetigt einen Wert}"; shift ;;
    --help|-h)
      cat <<USAGE
Verwendung / Usage: $(basename -- "$0") [OPTIONEN]

  --dry-run        Vorschau ohne Schreiben / Preview without writing
  --no-push        Committen ohne Push / Commit without pushing
  --series NAME    Serien-Praefix (Standard: SecureCaseTracker)
  --home-dir DIR   Basisverzeichnis fuer Repos (Standard: ~)
  --registry PFAD  Registry-Datei (Standard: ~/.home-baseline/level2-repository-registry.json)
  --verbose,-v     Ausfuehrliche Ausgabe / Verbose output

Quelle / Source: ${SRC_UNITS}
USAGE
      exit 0
      ;;
    --) shift; break ;;
    --*) echo "Fehler / Error: Unbekannte Option / Unknown option: $1" >&2; exit 2 ;;
    *)  echo "Fehler / Error: Unerwartetes Argument / Unexpected argument: $1" >&2; exit 2 ;;
  esac
  shift
done

# Datei-Praefix aus SERIES ableiten, falls nicht gesetzt (SecureX -> Secure-X).
# Repos heissen z. B. "SecureCaseTracker", die Dateien "Secure-CaseTracker".
if [ -z "$FILE_SERIES" ]; then
  case "$SERIES" in
    Secure-*) FILE_SERIES="$SERIES" ;;
    Secure?*) FILE_SERIES="Secure-${SERIES#Secure}" ;;
    *)        FILE_SERIES="$SERIES" ;;
  esac
fi

# --- Vorabpruefungen / Prerequisite checks ------------------------------------

if [ ! -d "$SRC_UNITS" ]; then
  echo "Fehler / Error: Quelle nicht gefunden / source not found: $SRC_UNITS" >&2
  exit 1
fi
if [ ! -f "$REGISTRY" ]; then
  echo "Fehler / Error: Registry nicht gefunden / registry not found: $REGISTRY" >&2
  exit 1
fi
for tool in python3 git; do
  command -v "$tool" >/dev/null 2>&1 || { echo "Fehler / Error: $tool erforderlich / required." >&2; exit 1; }
done

# --- Ausgabe-Hilfen / Output helpers ------------------------------------------

info() { echo "→ $*"; }
ok()   { echo "✓ $*"; }
warn() { echo "⚠ $*"; }
plan() { if [ "$DRY_RUN" -eq 1 ]; then echo "  [DRY-RUN] $*"; else echo "  [OK] $*"; fi; }

# --- Quell-Dateimengen der Serie / Series source file sets --------------------
# Gibt relative Pfade (unter docs/learning-units) der zur Serie gehoerenden
# Dateien aus. InventoryHub bzw. andere Reihen sind ausgeschlossen, weil das
# Praefixmuster strikt an ${SERIES} bindet.

series_unit_files() {
  # Ausgeschlossen: dist/, presentations/ (unveraenderte Paketierungs-/Folienpfade)
  # Eingeschlossen: das gemeinsame Secure-Trader-Universum (Systemlandschaft) und
  # der geteilte Datensatz-Baum datasets/** (Generator + CSVs + schema.sql), damit
  # das Lernwerkzeug in jedem Level-1/Level-2-Repo lauffaehig vorliegt.
  # datasets/* + datasets/*/* deckt den zweistufigen datasets-Baum ab
  # (bash-3-kompatibel, ohne globstar).
  ( cd -- "$SRC_UNITS" && {
      shopt -s nullglob
      local f
      for f in Lastenheft_"${FILE_SERIES}"*.md "${FILE_SERIES}"*.md \
               Rahmenlehrplan-Lernfeld-Mapping.md \
               IT-Berufe-"${FILE_SERIES}"-Mapping.md \
               Secure-Trader-*.md \
               lernbegleiter/"${FILE_SERIES}"*.Lernbegleiter.md \
               templates/*.md \
               datasets/* datasets/*/*; do
        [ -f "$f" ] && printf '%s\n' "$f"
      done
    } )
}

# Nur die Root-Intakes (fuer Level-2 zusaetzlich in die Repo-Wurzel gespiegelt)
series_root_intakes() {
  ( cd -- "$SRC_UNITS" && {
      shopt -s nullglob
      local f
      for f in Lastenheft_"${FILE_SERIES}"*.md; do
        [ -f "$f" ] && printf '%s\n' "$f"
      done
    } )
}

# --- Registry-Erkennung / Registry discovery ----------------------------------
# Gibt Zeilen "LEVEL<TAB>ABS_PFAD" fuer Repos aus, deren Pfad den Serien-Namen
# enthaelt. Level-1 zuerst, dann Level-2.

discover_repos() {
  python3 - "$REGISTRY" "$SERIES" "$HOME_DIR" <<'PYEOF'
import json, sys, os
reg, series, home = sys.argv[1], sys.argv[2], sys.argv[3]
data = json.load(open(reg, encoding="utf-8"))
repos = data.get("repositories", []) if isinstance(data, dict) else data
rows = []
for e in repos:
    if not isinstance(e, dict):
        continue
    path = e.get("path", "")
    if series.lower() not in path.lower():
        continue
    level = e.get("level", 0)
    abspath = path if os.path.isabs(path) else os.path.join(home, path)
    rows.append((int(level), abspath))
rows.sort(key=lambda r: (r[0], r[1]))
for level, abspath in rows:
    print(f"{level}\t{abspath}")
PYEOF
}

# --- Datei-Kopie / File copy --------------------------------------------------
# copy_one <rel-src-unter-SRC_UNITS> <ziel-basisdir>
# Legt Zielunterordner an, kopiert nur bei Inhaltsunterschied.

copy_one() {
  local rel="$1" destbase="$2"
  local src="${SRC_UNITS}/${rel}"
  local dst="${destbase}/${rel}"
  if [ -f "$dst" ] && cmp -s -- "$src" "$dst"; then
    return 1  # unveraendert
  fi
  if [ "$DRY_RUN" -eq 0 ]; then
    mkdir -p -- "$(dirname -- "$dst")"
    cp -- "$src" "$dst"
  fi
  return 0    # geaendert
}

# --- Ein Repo verarbeiten / Process one repository ----------------------------

process_repo() {
  local level="$1" repo="$2"
  REPOS_TOTAL=$((REPOS_TOTAL + 1))
  local name; name="$(basename -- "$repo")"

  if [ ! -d "$repo/.git" ]; then
    warn "Uebersprungen (kein Git-Repo) / skipped (not a git repo): $repo"
    return
  fi

  # Auf main bringen; leere/unborn Klone hydrieren.
  if ! git -C "$repo" rev-parse --verify HEAD >/dev/null 2>&1; then
    info "Hydriere leeren Klon / hydrating empty clone: $name"
    if [ "$DRY_RUN" -eq 0 ]; then
      git -C "$repo" fetch --quiet origin || { warn "fetch fehlgeschlagen: $name"; return; }
      git -C "$repo" checkout -B main origin/main --quiet || { warn "checkout main fehlgeschlagen: $name"; return; }
    fi
  fi

  # Sauberkeit pruefen (nur ausserhalb Dry-Run relevant fuer Commit).
  if [ -n "$(git -C "$repo" status --porcelain 2>/dev/null)" ]; then
    warn "Uebersprungen (nicht sauberer Arbeitsbaum) / skipped (dirty tree): $name"
    return
  fi
  # Sicherstellen, dass wir auf main sind.
  local cur; cur="$(git -C "$repo" branch --show-current 2>/dev/null || true)"
  if [ "$cur" != "main" ] && [ "$DRY_RUN" -eq 0 ]; then
    git -C "$repo" checkout main --quiet 2>/dev/null || warn "konnte nicht auf main wechseln: $name"
  fi

  info "Repo (Level ${level}): ${name}"
  local changed=0 rel

  # 1) docs/learning-units/ synchronisieren (alle Ebenen)
  while IFS= read -r rel; do
    if copy_one "$rel" "${repo}/docs/learning-units"; then
      changed=$((changed + 1)); FILES_CHANGED=$((FILES_CHANGED + 1))
      [ "$VERBOSE" -eq 1 ] && plan "docs/learning-units/${rel}"
    fi
  done < <(series_unit_files)

  # 2) Root-Intakes (nur Level-2)
  if [ "$level" = "2" ]; then
    while IFS= read -r rel; do
      if copy_one "$rel" "$repo"; then
        changed=$((changed + 1)); FILES_CHANGED=$((FILES_CHANGED + 1))
        [ "$VERBOSE" -eq 1 ] && plan "(root) ${rel}"
      fi
    done < <(series_root_intakes)
  fi

  if [ "$changed" -eq 0 ]; then
    ok "${name}: bereits aktuell / already up to date"
    return
  fi

  plan "${name}: ${changed} Datei(en) geaendert / file(s) changed"

  if [ "$DRY_RUN" -eq 1 ]; then
    return
  fi

  # Commit + Push
  git -C "$repo" add -A -- docs/learning-units >/dev/null 2>&1 || true
  [ "$level" = "2" ] && git -C "$repo" add -A -- 'Lastenheft_'"${FILE_SERIES}"'*.md' >/dev/null 2>&1 || true

  if git -C "$repo" diff --cached --quiet; then
    ok "${name}: keine Git-Aenderung nach Add / no staged change"
    return
  fi

  git -C "$repo" commit -q -m "docs(learning-units): Lernbegleiter, LF-Zuordnung und Konsistenz-Sweep uebernehmen

Uebernimmt das revidierte ${SERIES}-Lernmaterial aus Level-0 (home-baseline):
Lernbegleiter, Rahmenlehrplan-Lernfeld-Zuordnung, Lernbegleiter-Vorlage und die
aktualisierten Lastenhefte/Uebersichten (konkrete Lernfelder, vereinheitlichte
Stand-Daten, Querverweise). DE-first/EN-second, CEFR B2, WCAG 2.2 AA.

Co-Authored-By: Claude Opus 4.8 <noreply@anthropic.com>"
  REPOS_CHANGED=$((REPOS_CHANGED + 1))
  ok "${name}: committet / committed"

  if [ "$NO_PUSH" -eq 1 ]; then
    info "${name}: Push uebersprungen (--no-push)"
  else
    if git -C "$repo" push --quiet origin main 2>/dev/null; then
      ok "${name}: gepusht / pushed"
    else
      warn "${name}: Push fehlgeschlagen / push failed"
    fi
  fi
}

# --- Hauptlauf / Main run -----------------------------------------------------

echo "Lernreihen-Propagation / Learning-series propagation"
echo "Serie / Series:   ${SERIES}"
echo "Quelle / Source:  ${SRC_UNITS}"
echo "Registry:         ${REGISTRY}"
[ "$DRY_RUN" -eq 1 ] && echo "Modus / Mode:     DRY-RUN (keine Aenderungen / no changes)"
echo

file_count="$(series_unit_files | wc -l | tr -d ' ')"
lb_count="$(series_unit_files | grep -c '^lernbegleiter/' || true)"
info "Quell-Dateien der Serie / series source files: ${file_count} (davon Lernbegleiter / of which companions: ${lb_count})"
echo

found=0
while IFS=$'\t' read -r level repo; do
  [ -z "${level:-}" ] && continue
  found=$((found + 1))
  process_repo "$level" "$repo"
  echo
done < <(discover_repos)

if [ "$found" -eq 0 ]; then
  warn "Keine Repos fuer Serie '${SERIES}' in der Registry gefunden."
  exit 1
fi

echo "---------------------------------------------"
echo "Repos gesamt / total:      ${REPOS_TOTAL}"
echo "Repos geaendert / changed: ${REPOS_CHANGED}"
echo "Dateien geaendert / files: ${FILES_CHANGED}"
[ "$DRY_RUN" -eq 1 ] && echo "(DRY-RUN: nichts geschrieben / nothing written)"
ok "Fertig / Done."
