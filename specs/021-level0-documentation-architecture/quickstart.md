# Quickstart: Validate Level-0 Documentation Architecture

## Prerequisites

- Run from the repository root.
- Use Python 3, Bash, and PowerShell 7.
- Keep the accepted D4 and D5 evidence unchanged.

## 1. Validate the migration contract

```bash
python3 specs/021-level0-documentation-architecture/tests/test_documentation_migration.py
python3 specs/021-level0-documentation-architecture/tools/validate_documentation_migration.py \
  --repo . \
  --migration specs/021-level0-documentation-architecture/documentation-migration.json
```

## 2. Validate autonomous state

```bash
bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-run-state.sh \
  specs/021-level0-documentation-architecture/autonomous-run-state.json
pwsh -NoProfile -File .specify/presets/autonomous-run-governance/scripts/validate-autonomous-run-state.ps1 \
  -StatePath specs/021-level0-documentation-architecture/autonomous-run-state.json
```

## 3. Run repository gates

```bash
git diff --check
bash scripts/check-homogeneity.sh
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
bash scripts/scan-agent-secrets.sh --fail-on-high .
specify check
```

Run every additional documentation, link, DocFX, browser/A11Y, statistics,
preset, and agent-parity validator discovered for the changed paths. Record
semantic language and learner reviews separately from deterministic results.

## 4. Confirm scope

```bash
git diff --name-only origin/main...HEAD
git diff --stat origin/main...HEAD
```

The delivery diff must contain no runtime, API, dependency, package, fleet,
D6, or D7 implementation change.
