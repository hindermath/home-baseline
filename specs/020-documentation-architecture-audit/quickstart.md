# Quickstart: Validate the Documentation Architecture Audit

## Prerequisites

- clean Feature-020 branch;
- Python 3;
- PowerShell 7 for cross-validator parity;
- current D4 Intake Review and active Series evidence.

## 1. Validate accepted governance inputs

```bash
bash .specify/presets/intake-review-governance/scripts/validate-intake-review-result.sh \
  --result specs/documentation-architecture-intakes/reviews/d4/intake-review-result.json \
  --repo .
bash .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-manifest.sh \
  --file requirements/intakes/series/home-baseline-delivery/manifest.json \
  --repo .
```

Run the matching PowerShell validators with `pwsh -NoProfile -File` and the
same repository root.

## 2. Run the contract tests

```bash
python3 -m unittest discover \
  -s specs/020-documentation-architecture-audit/tests \
  -p 'test_*.py' -v
```

Expected result: every positive and negative fixture passes.

## 3. Rebuild and validate the audit

```bash
python3 specs/020-documentation-architecture-audit/tools/collect_documentation_architecture.py \
  --repo . \
  --commit 4c19093692542ff5001819f9ba2d17a1a1a5d4d7 \
  --decisions specs/020-documentation-architecture-audit/audit-decisions.json \
  --output specs/020-documentation-architecture-audit/documentation-inventory.json

python3 specs/020-documentation-architecture-audit/tools/validate_documentation_architecture.py \
  --repo . \
  --audit specs/020-documentation-architecture-audit/documentation-architecture-audit.json
```

Expected result: the inventory is deterministic and the validator reports the
exact unit, reader-path, contract, source/runtime, finding, and governance
counts.

## 4. Run repository gates

```bash
git diff --check
specify check
bash scripts/check-homogeneity.sh --dry-run --no-patch .
bash scripts/scan-agent-secrets.sh --fail-on-high .
bash scripts/render-project-statistics.sh --repo . --check-only
```

PSScriptAnalyzer and provider-specific macOS, Ubuntu, and Windows jobs remain
required before merge. DocFX/browser A11Y is conditional and is not triggered
when only feature-local Markdown/JSON evidence changes.

## 5. Confirm scope

The final diff may contain Feature-020 artifacts, deterministic audit-only
proof, statistics, archive/order evidence, and delivery evidence. It must not
contain active documentation remediation, runtime, maintenance script, preset,
workflow, dependency, package, or fleet changes.
