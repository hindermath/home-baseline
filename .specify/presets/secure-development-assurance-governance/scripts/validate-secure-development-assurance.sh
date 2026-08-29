#!/usr/bin/env bash
set -euo pipefail

die() {
  printf 'Blocked: %s\n' "$1" >&2
  exit 2
}

require_value() {
  local value="$1"
  local allowed="$2"
  case " $allowed " in
    *" $value "*) ;;
    *) die "Unzulässiger Wert '$value'." ;;
  esac
}

resolve_context() {
  local supplied="${1:-}"
  if [[ -n "$supplied" ]]; then
    printf '%s\n' "$supplied"
    return
  fi
  local latest
  latest="$(find docs/security/secure-development -mindepth 1 -maxdepth 1 -type d 2>/dev/null | LC_ALL=C sort | tail -n 1)"
  [[ -n "$latest" ]] || die 'Kein Evidence-Verzeichnis gefunden.'
  printf '%s\n' "$latest"
}

validate_gate_file() {
  local file="$1"
  local expected_gate="$2"
  [[ -f "$file" ]] || die "Evidence fehlt: $file"
  jq -e . "$file" >/dev/null || die "Ungültiges JSON: $file"
  local gate outcome
  gate="$(jq -r '.gate // empty' "$file")"
  outcome="$(jq -r '.outcome // empty' "$file")"
  [[ "$gate" == "$expected_gate" ]] || die "Gate-Drift in $file: $gate"
  require_value "$outcome" 'Ready ReadyWithAcceptedRisks NeedsRemediation Blocked'
  jq -e '.assessments | type == "array" and length > 0' "$file" >/dev/null || die "Assessments fehlen: $file"
  while IFS=$'\t' read -r applicability implementation; do
    require_value "$applicability" 'Applicable N/A Open'
    case "$implementation" in
      Fulfilled|'Partly Fulfilled'|'Not Fulfilled'|'Not Assessed') ;;
      *) die "Unzulässiger Umsetzungswert '$implementation' in $file." ;;
    esac
  done < <(jq -r '.assessments[] | [.applicability,.implementation] | @tsv' "$file")
  if [[ "$outcome" == 'Ready' ]]; then
    jq -e '[.assessments[] | select(.applicability == "Open" or (.applicability == "Applicable" and .implementation != "Fulfilled"))] | length == 0' "$file" >/dev/null ||
      die "Ready ist bei offenen oder unerfüllten Pflichtpunkten unzulässig: $file"
  fi
  jq -e '.externalComparisonBoundary == "HOSK/GWDG: ExternalComparison only; never local evidence"' "$file" >/dev/null ||
    die "Externe Vergleichsgrenze fehlt: $file"
}

validate_context() {
  local context_dir="$1"
  [[ -d "$context_dir" ]] || die "Evidence-Verzeichnis fehlt: $context_dir"
  [[ -f "$context_dir/evidence-matrix.md" ]] || die 'evidence-matrix.md fehlt.'
  validate_gate_file "$context_dir/baseline.json" baseline
  local delta_count=0 delta_file
  while IFS= read -r delta_file; do
    validate_gate_file "$delta_file" delta
    delta_count=$((delta_count + 1))
  done < <(find "$context_dir/deltas" -maxdepth 1 -type f -name '*.json' 2>/dev/null | LC_ALL=C sort)
  (( delta_count > 0 )) || die 'Mindestens eine Delta-Evidence fehlt.'
  validate_gate_file "$context_dir/closure.json" closure
  validate_gate_file "$context_dir/image-impact.json" image-impact
  jq -e '.imageChecks | has("build") and has("compose") and has("toolchain") and has("ociDigest") and has("sbom") and has("secrets") and has("mounts") and has("network") and has("ci")' "$context_dir/image-impact.json" >/dev/null ||
    die 'Image-Impact-Nachweise sind unvollständig.'
  jq -e '.humanDecisions | has("technicalValidation") and has("pilotAuthorization") and has("projectAcceptance") and has("generalRelease")' "$context_dir/closure.json" >/dev/null ||
    die 'Getrennte Entscheidungsgrenzen fehlen.'
  printf 'Aligned: %s\n' "$context_dir"
}

action="${1:-status}"
case "$action" in
  status)
    context_dir="$(resolve_context "${2:-}")"
    validate_context "$context_dir"
    ;;
  review)
    [[ $# -eq 4 ]] || die 'Syntax: review <baseline|delta|closure|image-impact> <context-id> <training|mixed|development>'
    gate="$2"
    context_id="$3"
    mode="$4"
    require_value "$gate" 'baseline delta closure image-impact'
    require_value "$mode" 'training mixed development'
    [[ "$context_id" =~ ^[a-z0-9][a-z0-9-]*$ ]] || die 'context-id ist ungültig.'
    context_dir="$(find docs/security/secure-development -mindepth 1 -maxdepth 1 -type d -name "*-$context_id" | LC_ALL=C sort | tail -n 1)"
    [[ -n "$context_dir" ]] || die "Kontext nicht gefunden: $context_id"
    case "$gate" in
      baseline|closure) gate_file="$context_dir/$gate.json" ;;
      image-impact) gate_file="$context_dir/image-impact.json" ;;
      delta) gate_file="$(find "$context_dir/deltas" -maxdepth 1 -type f -name '*.json' | LC_ALL=C sort | tail -n 1)" ;;
    esac
    validate_gate_file "$gate_file" "$gate"
    if [[ "$mode" != development ]]; then
      [[ -f "docs/runbooks/secure-development/$gate-$context_id.md" ]] ||
        die "Runbook fehlt für $mode: $gate-$context_id.md"
    fi
    printf 'Reviewed: gate=%s context=%s mode=%s\n' "$gate" "$context_id" "$mode"
    ;;
  *) die "Unbekannte Aktion: $action" ;;
esac
