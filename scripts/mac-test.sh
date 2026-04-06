#!/usr/bin/env bash
# mac-test.sh — Sammelt System-Info und Testergebnisse auf macOS
# Ausgabe wird nach ~/home-baseline-tmp/mac-test-output.txt geschrieben
# und automatisch committet + gepusht.
#
# Verwendung: bash ~/home-baseline-tmp/scripts/mac-test.sh

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUTPUT_FILE="${REPO_DIR}/mac-test-output.txt"

echo "╔══════════════════════════════════════════════════╗"
echo "║  mac-test — System & Compliance Check            ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "→ Ausgabe wird gespeichert in: ${OUTPUT_FILE}"
echo ""

{
  echo "╔══════════════════════════════════════════════════╗"
  echo "║  mac-test — System & Compliance Check            ║"
  echo "╚══════════════════════════════════════════════════╝"
  echo "Datum / Date: $(date)"
  echo ""

  echo "━━━ System-Info ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "OS:        $(sw_vers -productName) $(sw_vers -productVersion) ($(sw_vers -buildVersion))"
  echo "Arch:      $(uname -m)"
  echo "Shell:     ${SHELL}"
  echo "bash:      $(bash --version | head -1)"
  echo "zsh:       $(zsh --version 2>/dev/null || echo 'n/a')"
  echo ""

  echo "━━━ Tools ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  for tool in git gh brew rg pwsh node npm uv specify; do
    if command -v "$tool" &>/dev/null; then
      version=$("$tool" --version 2>/dev/null | head -1 || echo '(version unbekannt)')
      echo "  ✓ ${tool}: ${version}"
    else
      echo "  ✗ ${tool}: nicht installiert"
    fi
  done
  echo ""

  echo "━━━ Homebrew-Pakete ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  brew list --versions git gh ripgrep 2>/dev/null || echo "(brew nicht verfügbar)"
  echo ""

  echo "━━━ Compliance-Check ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  bash "${REPO_DIR}/scripts/check-homogeneity.sh" "${HOME}" 2>&1 || true
  echo ""

} | tee "${OUTPUT_FILE}"

# Committen und pushen
echo "→ Committen und pushen..."
cd "${REPO_DIR}"
git add mac-test-output.txt
git commit -m "chore: mac-test Ergebnisse hinzugefuegt ($(date '+%Y-%m-%d'))

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
git push

echo ""
echo "✓ Ergebnisse gepusht — Copilot kann sie jetzt auf Windows lesen."
