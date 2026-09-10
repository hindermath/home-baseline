#!/usr/bin/env bash
# Public Spec Kit statistics; canonical implementation uses PowerShell 7.
set -euo pipefail
script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
args=(-NoProfile -File "$script_dir/update-public-speckit-statistics.ps1")
while [ "$#" -gt 0 ]; do
  case "$1" in
    --action) args+=(-Action "${2:?--action requires Collect, Validate or Render}"); shift ;;
    --repo) args+=(-Repo "${2:?--repo requires a path}"); shift ;;
    --check-only) args+=(-CheckOnly) ;;
    --dry-run) args+=(-WhatIf) ;;
    --help|-h)
      printf '%s\n' 'Usage / Verwendung: update-public-speckit-statistics.sh [--action Collect|Validate|Render] [--repo PATH] [--check-only|--dry-run]' 'Collect reads public GitHub via gh; Validate/Render replay offline. Exit: 0 success, 1 drift, 2 error.'
      exit 0 ;;
    *) printf 'Unknown argument / Unbekanntes Argument: %s\n' "$1" >&2; exit 2 ;;
  esac
  shift
done
exec pwsh "${args[@]}"
