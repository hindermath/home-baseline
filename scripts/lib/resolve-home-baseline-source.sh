#!/usr/bin/env bash

_is_hb_source_repository() {
  local candidate="$1"
  local remote
  [ -e "$candidate/.git" ] && [ -f "$candidate/scripts/sync-home.sh" ] || return 1
  remote="$(git -C "$candidate" remote get-url origin 2>/dev/null)" || return 1
  [[ "$remote" =~ hindermath/home-baseline(\.git)?$ ]]
}

resolve_hb_source_repository() {
  local start_path="${1:-${BASH_SOURCE[0]}}"
  local allow_legacy="${2:-0}"
  local candidate state_path configured

  candidate="$(cd -- "$(dirname -- "$start_path")" 2>/dev/null && pwd -P)" || return 2
  while [ "$candidate" != "/" ]; do
    if _is_hb_source_repository "$candidate"; then
      printf '%s\n' "$candidate"
      return 0
    fi
    candidate="$(dirname -- "$candidate")"
  done

  if [ -n "${HOME_BASELINE_SOURCE:-}" ] &&
     _is_hb_source_repository "$HOME_BASELINE_SOURCE"; then
    (cd -- "$HOME_BASELINE_SOURCE" && pwd -P)
    return 0
  fi

  state_path="${HOME}/.home-baseline/source-repository.json"
  if [ -f "$state_path" ] && command -v jq >/dev/null 2>&1; then
    configured="$(jq -er '.sourcePath | select(type == "string" and length > 0)' "$state_path" 2>/dev/null || true)"
    if [ -n "$configured" ] && _is_hb_source_repository "$configured"; then
      (cd -- "$configured" && pwd -P)
      return 0
    fi
  fi

  if _is_hb_source_repository "${HOME}/home-baseline-source"; then
    (cd -- "${HOME}/home-baseline-source" && pwd -P)
    return 0
  fi
  if [ "$allow_legacy" -eq 1 ] &&
     _is_hb_source_repository "${HOME}/home-baseline-tmp"; then
    printf '%s\n' 'WARN: ~/home-baseline-tmp is deprecated; migrate to ~/home-baseline-source.' >&2
    (cd -- "${HOME}/home-baseline-tmp" && pwd -P)
    return 0
  fi
  printf '%s\n' 'Level-0 source checkout not found. Set HOME_BASELINE_SOURCE or run migrate-level0-source-checkout.' >&2
  return 2
}
