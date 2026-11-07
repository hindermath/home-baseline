#!/usr/bin/env bash
# mac-test.sh - Mac Test Output Collector
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd -P)"
OUTPUT_NAME="mac-test-output.txt"
OUT="$REPO_DIR/$OUTPUT_NAME"
TEMP_OUT="$(mktemp "${TMPDIR:-/tmp}/home-baseline-mac-test.XXXXXX")"
PUBLISH_TEMP=""
cleanup() {
  rm -f -- "$TEMP_OUT"
  [ -z "$PUBLISH_TEMP" ] || rm -f -- "$PUBLISH_TEMP"
}
trap cleanup EXIT

assert_safe_clean_publication_state() {
  local tracked_mode=""
  [ ! -L "$OUT" ] || { echo "ERROR: verknüpfte Ausgabedatei wird abgelehnt: $OUT" >&2; return 1; }
  tracked_mode="$(git -C "$REPO_DIR" ls-files -s -- "$OUTPUT_NAME" | awk 'NR==1 {print $1}')"
  [ "$tracked_mode" != "120000" ] || { echo "ERROR: Git-Symlink als Ausgabe wird abgelehnt" >&2; return 1; }
  [ -z "$(git -C "$REPO_DIR" status --porcelain=v1 --untracked-files=all)" ] || {
    echo "ERROR: Repository enthält bereits Änderungen oder ungetrackte Dateien" >&2
    return 1
  }
}

assert_origin_push_matches_fetch() {
  local fetch_url push_urls
  fetch_url="$(git -C "$REPO_DIR" remote get-url origin)"
  push_urls="$(git -C "$REPO_DIR" remote get-url --push --all origin)"
  [ "$push_urls" = "$fetch_url" ] || {
    echo "ERROR: origin-Pushziel weicht vom verifizierten Fetchziel ab" >&2
    return 1
  }
}

prepare_exact_main_base() {
  [ "$(git -C "$REPO_DIR" branch --show-current)" = "main" ] || { echo "ERROR: Launcher benötigt Branch main" >&2; return 1; }
  assert_origin_push_matches_fetch
  git -C "$REPO_DIR" fetch --no-tags origin main
  local head remote_head
  head="$(git -C "$REPO_DIR" rev-parse HEAD)"
  remote_head="$(git -C "$REPO_DIR" rev-parse origin/main)"
  if [ "$head" != "$remote_head" ]; then
    git -C "$REPO_DIR" merge-base --is-ancestor "$head" "$remote_head" || {
      echo "ERROR: Lokale Ahead-/Diverged-Commits dürfen nicht nach main veröffentlicht werden" >&2
      return 1
    }
    git -C "$REPO_DIR" merge --ff-only "$remote_head"
  fi
}

assert_safe_clean_publication_state
prepare_exact_main_base
BASE_COMMIT="$(git -C "$REPO_DIR" rev-parse HEAD)"
DATE=$(date "+%Y-%m-%d %H:%M:%S")
{
  echo "Mac Test Output - ${DATE}"
  echo "macOS: $(sw_vers -productVersion)"
  echo ""
  echo "=== Homebrew ==="
  brew --version 2>&1 || echo "brew: nicht gefunden"
  echo ""
  echo "=== Homebrew Top-Level Formulae ==="
  brew leaves --installed-on-request 2>&1 || echo "brew leaves: nicht verfuegbar"
  echo ""
  echo "=== Homebrew Casks ohne xquartz ==="
  brew list --cask 2>/dev/null | grep -Fvx 'xquartz' || true
  echo ""
  echo "=== Agentic Brew Registry Vergleich ==="
  bash "$HOME/home-baseline-source/scripts/maintain-agentic-brew-apps.sh" --compare-only 2>&1
  echo ""
  echo "=== PSScriptAnalyzer ==="
  pwsh -NoProfile -File "$HOME/home-baseline-source/scripts/maintain-powershell-modules.ps1" -CompareOnly 2>&1
  pwsh -NoProfile -File "$HOME/home-baseline-source/scripts/invoke-psscriptanalyzer.ps1" 2>&1
  echo ""
  echo "=== Workspace Maintenance Check ==="
  bash "$HOME/home-baseline-source/scripts/maintain-agentic-workspace.sh" --check-only --scripts-only 2>&1 || true
  echo ""
  echo "=== VS Code / Helix ==="
  if command -v code > /dev/null 2>&1; then
    code --version 2>&1 || true
    code --list-extensions 2>&1 || true
  else
    echo "code: nicht gefunden"
  fi
  if command -v hx > /dev/null 2>&1; then
    hx --version 2>&1 || true
  else
    echo "hx: nicht gefunden"
  fi
  echo ""
  echo "=== Tools ==="
  for cmd in git gh glab rg gitleaks pwsh node npm uv python3 dotnet go java javac cargo rustc swift syft specify podman codex claude agy copilot code hx; do
    command -v "$cmd" > /dev/null 2>&1 && echo "  OK  $cmd" || echo "  --- $cmd: fehlt"
  done
  echo ""
  echo "=== sync-home ==="
  bash ~/home-baseline-source/scripts/sync-home.sh --no-pull 2>&1
  echo ""
  echo "=== check-homogeneity ==="
  bash ~/scripts/check-homogeneity.sh ~/ 2>&1
} | tee "$TEMP_OUT"
git -C "$REPO_DIR" fetch --no-tags origin main 2>&1 | cat
[ "$(git -C "$REPO_DIR" rev-parse HEAD)" = "$(git -C "$REPO_DIR" rev-parse origin/main)" ] || { echo "ERROR: origin/main hat sich während des Tests geändert; bitte erneut ausführen" >&2; exit 1; }
assert_safe_clean_publication_state
PUBLISH_TEMP="$(mktemp "$REPO_DIR/.mac-test-output.XXXXXX")"
cp -- "$TEMP_OUT" "$PUBLISH_TEMP"
chmod 0644 "$PUBLISH_TEMP"
mv -f -- "$PUBLISH_TEMP" "$OUT"
PUBLISH_TEMP=""
git -C "$REPO_DIR" add -- "$OUTPUT_NAME"
[ "$(git -C "$REPO_DIR" diff --cached --name-only)" = "$OUTPUT_NAME" ] || { echo "ERROR: unerwartete Pfade im Index" >&2; exit 1; }
[ -z "$(git -C "$REPO_DIR" diff --name-only)" ] || { echo "ERROR: nicht gestagte Änderungen erkannt" >&2; exit 1; }
[ -z "$(git -C "$REPO_DIR" ls-files --others --exclude-standard)" ] || { echo "ERROR: ungetrackte Dateien erkannt" >&2; exit 1; }
git -C "$REPO_DIR" -c core.hooksPath=/dev/null commit --only -m "test: Mac Test-Output (${DATE})" -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>" -- "$OUTPUT_NAME" 2>&1
VERIFIED_COMMIT="$(git -C "$REPO_DIR" rev-parse HEAD)"
[ "$(git -C "$REPO_DIR" rev-parse "${VERIFIED_COMMIT}^")" = "$BASE_COMMIT" ] || { echo "ERROR: unerwartete Commit-Elternbeziehung" >&2; exit 1; }
[ "$(git -C "$REPO_DIR" diff-tree --no-commit-id --name-only -r "${VERIFIED_COMMIT}^" "$VERIFIED_COMMIT")" = "$OUTPUT_NAME" ] || { echo "ERROR: Commit enthält unerwartete Pfade" >&2; exit 1; }
assert_origin_push_matches_fetch
git -C "$REPO_DIR" push --force-with-lease="refs/heads/main:$BASE_COMMIT" origin "$VERIFIED_COMMIT:refs/heads/main" 2>&1
echo "Gepusht."
