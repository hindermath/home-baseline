#!/usr/bin/env bash
# check-homogeneity.sh — Workspace Homogeneity Guardian Compliance Scanner v1.0
# FR-001 through FR-006, FR-016-FR-019; Contracts: check-homogeneity-cli.md
#
# Usage: check-homogeneity.sh [OPTIONS] [TARGET_DIR]
# Options:
#   --verbose       Show all checked files (including PASS)
#   --json          Machine-readable JSON output (takes precedence over --verbose)
#   --dry-run       No writes (no STATS.md, no memory-patch.md)
#   --apply-patch   <path>  Apply memory-patch.md and commit
#   --no-patch      Do not generate memory-patch.md
#   --fail-fast     Abort on first FAIL
#   --yes           Non-interactive confirmation (for --apply-patch)
# Exit codes: 0=all pass, 1=fail/warn, 2=fatal error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="${SCRIPT_DIR}/lib"

# Source all hg-*.sh libs
for _lib in "${LIB_DIR}"/hg-*.sh; do
  [ -f "$_lib" ] && . "$_lib"
done

# ─── Argument Parsing ────────────────────────────────────────────────────────

OPT_VERBOSE=false
OPT_JSON=false
OPT_DRY_RUN=false
OPT_APPLY_PATCH=""
OPT_NO_PATCH=false
OPT_FAIL_FAST=false
OPT_YES=false
TARGET_DIR="${HOME}"

while [ $# -gt 0 ]; do
  case "$1" in
    --verbose)    OPT_VERBOSE=true ;;
    --json)       OPT_JSON=true ;;
    --dry-run)    OPT_DRY_RUN=true ;;
    --apply-patch)
      if [ -n "${2:-}" ]; then OPT_APPLY_PATCH="$2"; shift; fi ;;
    --no-patch)   OPT_NO_PATCH=true ;;
    --fail-fast)  OPT_FAIL_FAST=true ;;
    --yes)        OPT_YES=true ;;
    --*) echo "ERROR: unknown option $1" >&2; exit 2 ;;
    *) TARGET_DIR="$1" ;;
  esac
  shift
done

# --json takes precedence over --verbose
$OPT_JSON && OPT_VERBOSE=false

# Expand tilde
TARGET_DIR="${TARGET_DIR/#\~/$HOME}"
TARGET_DIR="${TARGET_DIR%/}"

# ─── Prerequisites Check ─────────────────────────────────────────────────────

if ! command -v rg >/dev/null 2>&1; then
  echo "FATAL: ripgrep (rg) not found — install with: brew install ripgrep / apt install ripgrep" >&2
  exit 2
fi

# ─── Apply-Patch Mode ────────────────────────────────────────────────────────

if [ -n "$OPT_APPLY_PATCH" ]; then
  patch_file="${OPT_APPLY_PATCH/#\~/$HOME}"
  if ! [ -f "$patch_file" ]; then
    echo "FATAL: patch file not found: ${patch_file}" >&2
    exit 2
  fi

  echo "Patch-Datei: ${patch_file}"
  echo ""
  echo "Vorgeschlagene Aenderungen:"
  grep '^##\|^- \|^\*\*' "$patch_file" | head -30
  echo ""

  if $OPT_YES; then
    answer="j"
  else
    printf "Patch anwenden? [j/N] "
    read -r answer
  fi

  if echo "$answer" | grep -qiE '^[jy]'; then
    patch_count=0
    target_file=""
    while IFS= read -r pline; do
      case "$pline" in
        "### Target: "*)
          target_file="${pline#### Target: }"
          target_file="${target_file/#\~/$HOME}" ;;
        "+++ "*)
          content_to_append="${pline#+++ }"
          if [ -n "$target_file" ]; then
            printf '%s\n' "$content_to_append" >> "$target_file"
            patch_count=$((patch_count + 1))
          fi ;;
      esac
    done < "$patch_file"
    git -C "$TARGET_DIR" add -A 2>/dev/null || true
    git -C "$TARGET_DIR" commit -m "chore: apply memory-patch -- ${patch_count} entries updated" 2>/dev/null || true
    echo "Patch angewendet: ${patch_count} Eintraege, git-Commit erstellt."
  else
    echo "Patch abgebrochen."
  fi
  exit 0
fi

# ─── Scan State (Bash 3.x-compatible, no associative arrays) ─────────────────

# Parallel arrays: index-matched
SCAN_DIRS=()        # dir paths
SCAN_TOTALS=()      # total checks per dir
SCAN_PASSES=()      # passed checks per dir

FAILURES=()
WARNINGS=()
TOTAL_CHECKS=0
TOTAL_PASS=0
CURRENT_DIR_IDX=-1

# ─── Directory index lookup ───────────────────────────────────────────────────

get_dir_idx() {
  local search="$1"
  local i=0
  for d in "${SCAN_DIRS[@]+"${SCAN_DIRS[@]}"}"; do
    [ "$d" = "$search" ] && echo "$i" && return
    i=$((i + 1))
  done
  echo "-1"
}

# ─── Check Helpers ───────────────────────────────────────────────────────────

emit_result() {
  local status="$1" filepath="$2" message="$3" dir="$4"
  local idx
  idx=$(get_dir_idx "$dir")
  TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
  SCAN_TOTALS[$idx]=$(( ${SCAN_TOTALS[$idx]:-0} + 1 ))

  if [ "$status" = "PASS" ]; then
    TOTAL_PASS=$((TOTAL_PASS + 1))
    SCAN_PASSES[$idx]=$(( ${SCAN_PASSES[$idx]:-0} + 1 ))
    if ! $OPT_JSON && $OPT_VERBOSE; then
      printf "  %-4s %-40s %s\n" "✓" "$filepath" "$message"
    fi
  elif [ "$status" = "WARN" ]; then
    WARNINGS+=("${filepath}:${message}")
    if ! $OPT_JSON; then
      printf "  %-4s %-40s %s\n" "WARN" "$filepath" "WARN: ${message}"
    fi
  elif [ "$status" = "FAIL" ]; then
    FAILURES+=("${filepath}:${message}")
    if ! $OPT_JSON; then
      printf "  %-4s %-40s %s\n" "✗" "$filepath" "FAIL: ${message}"
    fi
    if $OPT_FAIL_FAST; then
      echo "" >&2
      echo "FAIL-FAST: aborted at first FAIL" >&2
      exit 1
    fi
  fi
}

check_file_presence() {
  local dir="$1" file="$2"
  local full="${dir}/${file}"
  if [ -f "$full" ]; then
    emit_result "PASS" "$file" "file present" "$dir"
  else
    emit_result "FAIL" "$file" "file missing" "$dir"
  fi
}

check_markdown_file() {
  local dir="$1" file="$2"
  local full="${dir}/${file}"
  [ -f "$full" ] || return 0

  # Bilingual check
  local bil_result
  bil_result=$(hg_check_bilingual "$full" 2>/dev/null || true)
  if [ -n "$bil_result" ]; then
    local b_status b_msg
    b_status="${bil_result%%|*}"
    b_msg="${bil_result##*|}"
    emit_result "$b_status" "$file" "$b_msg" "$dir"
  fi

  # A11Y checks
  while IFS= read -r a11y_line; do
    [ -z "$a11y_line" ] && continue
    local a_status a_msg
    a_status="${a11y_line%%|*}"
    a_msg="${a11y_line##*|}"
    emit_result "$a_status" "$file" "$a_msg" "$dir"
  done < <(hg_check_a11y "$full" 2>/dev/null || true)

  # Secrets check
  while IFS= read -r sec_line; do
    [ -z "$sec_line" ] && continue
    local s_status s_rest s_msg
    s_status="${sec_line%%|*}"
    s_rest="${sec_line#*|}"
    s_msg="${s_rest##*|}"
    emit_result "$s_status" "$file" "$s_msg" "$dir"
  done < <(hg_scan_file_secrets "$full" 2>/dev/null || true)
}

# ─── Header ──────────────────────────────────────────────────────────────────

if ! $OPT_JSON; then
  echo "Workspace Homogeneity Guardian — check-homogeneity v1.0"
  echo "Scan-Startpunkt: ${TARGET_DIR}"
  printf '%.0s=' {1..54}; echo
  echo ""
fi

# ─── Main Scan ───────────────────────────────────────────────────────────────

REQUIRED_FILES="AGENTS.md CLAUDE.md GEMINI.md README.md STATS.md"

while IFS='|' read -r level dir _type; do
  SCAN_DIRS+=("$dir")
  SCAN_TOTALS+=(0)
  SCAN_PASSES+=(0)
  local_idx=$(( ${#SCAN_DIRS[@]} - 1 ))

  if ! $OPT_JSON; then
    echo "[Level ${level}] ${dir}/"
  fi

  # Required files
  for req_file in $REQUIRED_FILES; do
    check_file_presence "$dir" "$req_file"
    check_markdown_file "$dir" "$req_file"
  done

  # Hook check (Level 1+2 have .git/)
  if [ "$level" -ge 1 ]; then
    hook_result=$(hg_check_hook "$dir" 2>/dev/null || true)
    if [ -n "$hook_result" ]; then
      h_status="${hook_result%%|*}"
      h_msg="${hook_result##*|}"
      emit_result "$h_status" ".git/hooks/pre-push" "$h_msg" "$dir"
    fi
  fi

  # Level 0: canonical hook presence
  if [ "$level" -eq 0 ]; then
    if [ -f "${HOME}/scripts/hooks/pre-push" ]; then
      emit_result "PASS" "scripts/hooks/pre-push" "canonical hook present" "$dir"
    else
      emit_result "WARN" "scripts/hooks/pre-push" "canonical hook missing" "$dir"
    fi
  fi

  # Deps + speckit for projects (Level 2)
  if [ "$level" -eq 2 ]; then
    while IFS= read -r dep_line; do
      [ -z "$dep_line" ] && continue
      d_status="${dep_line%%|*}"
      d_rest="${dep_line#*|}"
      d_msg="${d_rest##*|}"
      emit_result "$d_status" "*.csproj" "$d_msg" "$dir"
    done < <(hg_check_deps "$dir" 2>/dev/null || true)

    spec_file=$(find "${dir}/specs" -name "spec.md" -maxdepth 3 2>/dev/null | head -1 || true)
    if [ -n "$spec_file" ]; then
      sk_line=$(hg_check_speckit "$spec_file" 2>/dev/null || true)
      if [ -n "$sk_line" ]; then
        sk_status="${sk_line%%|*}"
        sk_msg="${sk_line##*|}"
        emit_result "$sk_status" "specs/spec.md" "$sk_msg" "$dir"
      fi
    fi
  fi

  if ! $OPT_JSON; then echo ""; fi

done < <(hg_scan "$TARGET_DIR")

# ─── Summary ─────────────────────────────────────────────────────────────────

OVERALL_SCORE=0
[ "$TOTAL_CHECKS" -gt 0 ] && OVERALL_SCORE=$(( (TOTAL_PASS * 100) / TOTAL_CHECKS ))

WORKSPACES_COUNT=0
PROJECTS_COUNT=0
while IFS='|' read -r level _dir _type; do
  [ "$level" -eq 1 ] && WORKSPACES_COUNT=$((WORKSPACES_COUNT + 1))
  [ "$level" -eq 2 ] && PROJECTS_COUNT=$((PROJECTS_COUNT + 1))
done < <(hg_scan "$TARGET_DIR")

if $OPT_JSON; then
  # JSON output
  fail_json="["
  first_f=true
  for f in "${FAILURES[@]+"${FAILURES[@]}"}"; do
    $first_f || fail_json+=","
    fp="${f%%:*}"
    chk="${f#*:}"
    fail_json+="{\"path\":\"${fp}\",\"check\":\"${chk}\"}"
    first_f=false
  done
  fail_json+="]"

  warn_json="["
  first_w=true
  for w in "${WARNINGS[@]+"${WARNINGS[@]}"}"; do
    $first_w || warn_json+=","
    wp="${w%%:*}"
    wchk="${w#*:}"
    warn_json+="{\"path\":\"${wp}\",\"check\":\"${wchk}\"}"
    first_w=false
  done
  warn_json+="]"

  stats_val="null"
  ! $OPT_DRY_RUN && stats_val="\"${HOME}/STATS.md\""

  printf '{"score":%d,"workspaces_scanned":%d,"projects_scanned":%d,"failures":%s,"warnings":%s,"stats_updated":%s,"patch_generated":null}\n' \
    "$OVERALL_SCORE" "$WORKSPACES_COUNT" "$PROJECTS_COUNT" \
    "$fail_json" "$warn_json" "$stats_val"
else
  printf '%.0s=' {1..54}; echo
  echo "COMPLIANCE SUMMARY"
  echo ""

  i=0
  for d in "${SCAN_DIRS[@]+"${SCAN_DIRS[@]}"}"; do
    lt=${SCAN_TOTALS[$i]:-0}
    lp=${SCAN_PASSES[$i]:-0}
    ls_score=0
    [ "$lt" -gt 0 ] && ls_score=$(( (lp * 100) / lt ))
    bar_filled=$(( ls_score * 10 / 100 ))
    bar_empty=$(( 10 - bar_filled ))
    bar=""
    j=0
    while [ $j -lt $bar_filled ]; do bar="${bar}█"; j=$((j+1)); done
    j=0
    while [ $j -lt $bar_empty ]; do bar="${bar}░"; j=$((j+1)); done
    short_name="${d/#$HOME/~}"
    printf "%-30s [%s] %3d %%  (%d/%d checks)\n" \
      "$short_name" "$bar" "$ls_score" "$lp" "$lt"
    i=$((i + 1))
  done

  echo ""
  printf "Overall: %d %%  |  Workspaces: %d  |  Projects: %d\n" \
    "$OVERALL_SCORE" "$WORKSPACES_COUNT" "$PROJECTS_COUNT"

  FAIL_COUNT=${#FAILURES[@]+"${#FAILURES[@]}"}
  WARN_COUNT=${#WARNINGS[@]+"${#WARNINGS[@]}"}
  # Bash 3 safe empty array check
  FAIL_COUNT=0; for _ in "${FAILURES[@]+"${FAILURES[@]}"}"; do FAIL_COUNT=$((FAIL_COUNT+1)); done
  WARN_COUNT=0; for _ in "${WARNINGS[@]+"${WARNINGS[@]}"}"; do WARN_COUNT=$((WARN_COUNT+1)); done

  if ! $OPT_DRY_RUN; then
    echo "STATS.md updated: ${HOME}/STATS.md"
  fi

  echo ""
  if [ "$FAIL_COUNT" -gt 0 ] || [ "$WARN_COUNT" -gt 0 ]; then
    printf "Exit code: 1 (%d FAIL, %d WARN)\n" "$FAIL_COUNT" "$WARN_COUNT"
  else
    printf "Exit code: 0 (all checks passed)\n"
  fi
fi

# ─── Post-scan writes ─────────────────────────────────────────────────────────

if ! $OPT_DRY_RUN; then
  if [ -f "${LIB_DIR}/hg-stats.sh" ]; then
    . "${LIB_DIR}/hg-stats.sh"
    hg_write_stats "${HOME}/STATS.md" "$OVERALL_SCORE" "${SCAN_DIRS[@]+"${SCAN_DIRS[@]}"}" 2>/dev/null || true
  fi

  if ! $OPT_NO_PATCH; then
    if [ -f "${LIB_DIR}/hg-patch.sh" ]; then
      . "${LIB_DIR}/hg-patch.sh"
      hg_generate_patch "${HOME}/STATS.md" "${FAILURES[@]+"${FAILURES[@]}"}" 2>/dev/null || true
    fi
  fi
fi

# ─── Exit Code ───────────────────────────────────────────────────────────────

_fail_cnt=0; for _ in "${FAILURES[@]+"${FAILURES[@]}"}"; do _fail_cnt=$((_fail_cnt+1)); done
_warn_cnt=0; for _ in "${WARNINGS[@]+"${WARNINGS[@]}"}"; do _warn_cnt=$((_warn_cnt+1)); done

if [ "$_fail_cnt" -gt 0 ] || [ "$_warn_cnt" -gt 0 ]; then
  exit 1
fi
exit 0
