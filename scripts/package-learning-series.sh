#!/usr/bin/env bash
# package-learning-series.sh — erzeugt ein git-freies Lernreihen-ZIP
set -euo pipefail

SOURCE_DIR=""
SERIES_NAME=""
OUTPUT_DIR=""
PACKAGE_PREFIX=""
START_GUIDE="docs/learning-units/GIT-START-FUER-LERNENDE.md"
DRY_RUN=0

usage() {
  cat <<'USAGE'
Usage: package-learning-series.sh --source-dir DIR [options]

Erzeugt ein Lernreihen-ZIP ohne .git-Verzeichnisse, ohne Remote-Konfigurationen
und ohne lokale Build-/IDE-Artefakte.

Options:
  --source-dir DIR       Level-1-Quellordner der Lernreihe
  --series-name NAME     Anzeigename fuer Manifest und Paketname
  --output-dir DIR       Zielordner fuer ZIP und SHA256
  --package-prefix NAME  Dateiname-Prefix; Standard aus --series-name
  --start-guide PATH     Startanleitung relativ zu --source-dir oder absolut
  --dry-run              Vorschau ohne ZIP-Erzeugung
  -h, --help             Hilfe anzeigen
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --source-dir)
      [ "$#" -ge 2 ] || { echo "ERROR: --source-dir braucht einen Wert" >&2; exit 1; }
      SOURCE_DIR="$2"
      shift 2
      ;;
    --series-name)
      [ "$#" -ge 2 ] || { echo "ERROR: --series-name braucht einen Wert" >&2; exit 1; }
      SERIES_NAME="$2"
      shift 2
      ;;
    --output-dir)
      [ "$#" -ge 2 ] || { echo "ERROR: --output-dir braucht einen Wert" >&2; exit 1; }
      OUTPUT_DIR="$2"
      shift 2
      ;;
    --package-prefix)
      [ "$#" -ge 2 ] || { echo "ERROR: --package-prefix braucht einen Wert" >&2; exit 1; }
      PACKAGE_PREFIX="$2"
      shift 2
      ;;
    --start-guide)
      [ "$#" -ge 2 ] || { echo "ERROR: --start-guide braucht einen Wert" >&2; exit 1; }
      START_GUIDE="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "ERROR: unbekannte Option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

require_tool() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "ERROR: benoetigtes Werkzeug fehlt: $1" >&2
    exit 1
  }
}

sanitize_name() {
  printf '%s' "$1" | tr '[:upper:] ' '[:lower:]-' | tr -cd '[:alnum:]-_'
}

[ -n "$SOURCE_DIR" ] || { echo "ERROR: --source-dir ist erforderlich" >&2; usage >&2; exit 1; }

require_tool git
require_tool rsync
require_tool zip
require_tool shasum

SOURCE_DIR="$(cd "$SOURCE_DIR" && pwd)"
[ -d "$SOURCE_DIR" ] || { echo "ERROR: Quelle nicht gefunden: $SOURCE_DIR" >&2; exit 1; }

ROOT_NAME="$(basename "$SOURCE_DIR")"
[ -n "$SERIES_NAME" ] || SERIES_NAME="$ROOT_NAME"
[ -n "$PACKAGE_PREFIX" ] || PACKAGE_PREFIX="$(sanitize_name "$SERIES_NAME")"
[ -n "$PACKAGE_PREFIX" ] || PACKAGE_PREFIX="$(sanitize_name "$ROOT_NAME")"
[ -n "$OUTPUT_DIR" ] || OUTPUT_DIR="${SOURCE_DIR}/docs/learning-units/dist"

if [[ "$START_GUIDE" = /* ]]; then
  START_GUIDE_PATH="$START_GUIDE"
else
  START_GUIDE_PATH="${SOURCE_DIR}/${START_GUIDE}"
fi

short_sha="$(git -C "$SOURCE_DIR" rev-parse --short HEAD 2>/dev/null || printf 'nogit')"
stamp="$(date -u '+%Y%m%dT%H%M%SZ')"
package_name="${PACKAGE_PREFIX}-learning-package-${stamp}-${short_sha}"
zip_path="${OUTPUT_DIR}/${package_name}.zip"
sha_path="${zip_path}.sha256"

excludes=(
  --exclude='.git/'
  --exclude='docs/learning-units/dist/'
  --exclude='.DS_Store'
  --exclude='__MACOSX/'
  --exclude='bin/'
  --exclude='obj/'
  --exclude='build/'
  --exclude='node_modules/'
  --exclude='.vs/'
  --exclude='.idea/'
  --exclude='settings.local.json'
  --exclude='.vscode/settings.json'
  --exclude='.vscode/c_cpp_properties.json'
)

if [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry-run: Lernreihen-Paket"
  echo "Reihe:  ${SERIES_NAME}"
  echo "Quelle: ${SOURCE_DIR}"
  echo "Ziel:   ${zip_path}"
  echo "Guide:  ${START_GUIDE_PATH}"
  echo "Ausgeschlossen: .git, dist, Build-, IDE- und lokale Settings-Artefakte"
  rsync -an --delete "${excludes[@]}" "${SOURCE_DIR}/" "/tmp/${package_name}/${ROOT_NAME}/" | sed -n '1,80p'
  exit 0
fi

mkdir -p "$OUTPUT_DIR"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
package_root="${tmp_dir}/${ROOT_NAME}"
mkdir -p "$package_root"

rsync -a --delete "${excludes[@]}" "${SOURCE_DIR}/" "${package_root}/"
if [ -f "$START_GUIDE_PATH" ]; then
  cp "$START_GUIDE_PATH" "${package_root}/$(basename "$START_GUIDE_PATH")"
fi

manifest="${package_root}/PACKAGING-MANIFEST.txt"
{
  echo "${SERIES_NAME} learning package"
  echo "Generated UTC: ${stamp}"
  echo "Source directory: ${ROOT_NAME}"
  echo "Git data included: no (.git directories excluded)"
  echo "Original remotes included: no"
  echo
  echo "Repository states without remote URLs:"
  for repo in "$SOURCE_DIR" "$SOURCE_DIR"/*; do
    [ -d "$repo/.git" ] || continue
    name="$(basename "$repo")"
    branch="$(git -C "$repo" branch --show-current 2>/dev/null || printf 'unknown')"
    commit="$(git -C "$repo" rev-parse --short HEAD 2>/dev/null || printf 'unknown')"
    dirty="no"
    if [ -n "$(git -C "$repo" status --short 2>/dev/null)" ]; then
      dirty="yes"
    fi
    echo "- ${name}: branch=${branch}, commit=${commit}, dirty=${dirty}"
  done
  echo
  if [ -f "$START_GUIDE_PATH" ]; then
    echo "Start here after extracting: $(basename "$START_GUIDE_PATH")"
  else
    echo "Start guide: not included"
  fi
} > "$manifest"

rm -f "$zip_path" "$sha_path"
(
  cd "$tmp_dir"
  zip -qr "$zip_path" "$ROOT_NAME"
)
shasum -a 256 "$zip_path" > "$sha_path"

echo "ZIP erzeugt: ${zip_path}"
echo "SHA256:      ${sha_path}"
