#!/usr/bin/env bash
set -euo pipefail

script_dir="$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)"
entry="$script_dir/manage-copilot-review-governance.ps1"

show_help() {
  printf '%s\n' 'GitHub Copilot Review Governance / GitHub-Copilot-Review-Governance'
  printf '%s\n' 'Usage: manage-copilot-review-governance.sh --action ACTION [OPTIONS]'
  printf '%s\n' 'Safe start: --action preview --dry-run --desired-state FILE --inventory FILE --output FILE'
  printf '%s\n' 'Live inventory: --action inventory --read-only --browser-evidence FILE --output FILE (GET only).'
  printf '%s\n' 'Live ruleset mutation: --action apply --plan FILE --authorization FILE --evidence-root DIR (fresh exact gate required).'
  printf '%s\n' 'Fake-provider and rollback: --fake-provider FILE --result FILE.'
  printf '%s\n' 'Sicherer Einstieg: Preview und Validierung schreiben nie zum Provider.'
  printf '%s\n' 'See: docs/man/manage-copilot-review-governance.1.md'
}

if ! command -v pwsh >/dev/null 2>&1; then
  printf '%s\n' 'BLOCKIERT / BLOCKED: PowerShell 7 (pwsh) is required.' >&2
  exit 3
fi

ps_args=(-NoLogo -NoProfile -File "$entry")
while (($# > 0)); do
  case "$1" in
    -h|--help)
      show_help
      exit 0
      ;;
    --action)
      (($# >= 2)) || { printf '%s\n' 'BLOCKIERT / BLOCKED: --action requires a value.' >&2; exit 2; }
      case "$2" in
        validate-desired-state) value='ValidateDesiredState' ;;
        validate) value='Validate' ;;
        preview) value='Preview' ;;
        inventory) value='Inventory' ;;
        validate-inventory) value='ValidateInventory' ;;
        validate-browser-evidence) value='ValidateBrowserEvidence' ;;
        validate-external-write-gate) value='ValidateExternalWriteGate' ;;
        apply) value='Apply' ;;
        validate-after-state) value='ValidateAfterState' ;;
        rollback) value='Rollback' ;;
        validate-usage) value='ValidateUsage' ;;
        *) printf '%s\n' "BLOCKIERT / BLOCKED: unknown action: $2" >&2; exit 2 ;;
      esac
      ps_args+=(-Action "$value")
      shift 2
      ;;
    --desired-state) ps_args+=(-DesiredStatePath "$2"); shift 2 ;;
    --inventory) ps_args+=(-InventoryPath "$2"); shift 2 ;;
    --output) ps_args+=(-OutputPath "$2"); shift 2 ;;
    --browser-evidence) ps_args+=(-BrowserEvidencePath "$2"); shift 2 ;;
    --authorization) ps_args+=(-AuthorizationPath "$2"); shift 2 ;;
    --plan) ps_args+=(-PlanPath "$2"); shift 2 ;;
    --rollback-plan) ps_args+=(-RollbackPlanPath "$2"); shift 2 ;;
    --result) ps_args+=(-ResultPath "$2"); shift 2 ;;
    --fake-provider) ps_args+=(-FakeProviderPath "$2"); shift 2 ;;
    --evidence-root) ps_args+=(-EvidenceRoot "$2"); shift 2 ;;
    --operation-class) ps_args+=(-OperationClass "$2"); shift 2 ;;
    --output-format) ps_args+=(-OutputFormat "$2"); shift 2 ;;
    --dry-run) ps_args+=(-DryRun); shift ;;
    --read-only) ps_args+=(-ReadOnly); shift ;;
    -WhatIf|--what-if) ps_args+=(-WhatIf); shift ;;
    --) shift; break ;;
    *) printf '%s\n' "BLOCKIERT / BLOCKED: unknown option: $1" >&2; exit 2 ;;
  esac
done

(($# == 0)) || { printf '%s\n' 'BLOCKIERT / BLOCKED: positional arguments are not supported.' >&2; exit 2; }
exec pwsh "${ps_args[@]}"
