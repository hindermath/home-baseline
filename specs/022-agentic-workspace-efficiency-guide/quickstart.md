# Quickstart: Validate Agentic Workspace Efficiency Guide

## Prerequisites

- Run from repository root on the feature branch.
- Use Python 3, Bash and PowerShell 7.
- Do not run a real mutating maintenance operation for this documentation
  feature.

## 1. Validate the source matrix

```bash
python3 specs/022-agentic-workspace-efficiency-guide/tests/test_efficiency_guide.py
python3 specs/022-agentic-workspace-efficiency-guide/tools/validate_efficiency_guide.py \
  --repo . \
  --matrix docs/maintenance/agentic-workspace-efficiency-source-matrix.json
```

Expected result: both commands exit `0` and report all four reader paths and
all source claims as valid.

## 2. Validate current public command evidence

```bash
bash scripts/maintain-agentic-workspace.sh --help
bash scripts/maintain-agentic-workspace.sh --check-only
```

```powershell
Get-Help ./scripts/maintain-agentic-workspace.ps1 -Full
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
```

Use the platform-native command. A check-only result may report drift with exit
`1`; that is valid evidence when the report names the blocker and next action.
Do not convert such a result into a pass.

## 3. Run repository documentation gates

```bash
git diff --check
lychee --offline --include-fragments \
  --exclude-path docs/learning-units/dist \
  --exclude-path scripts/templates/project-readme-template.md \
  --exclude-path scripts/templates/secure-development-compendium-header.md \
  './**/*.md'
bash scripts/check-homogeneity.sh .
bash scripts/scan-agent-secrets.sh --fail-on-high .
bash scripts/render-project-statistics.sh --repo . --check-only
specify check
```

```powershell
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
pwsh -NoProfile -File scripts/render-project-statistics.ps1 -Repo . -CheckOnly
```

If `lychee` is not installed locally, record that boundary and require the
repository's `Local Markdown Links and Anchors` provider job on the exact PR
head. The source-matrix test and validator remain explicit local exact-head
gates; this feature does not change a workflow to add a feature-specific job.

## 4. Review semantic and scope evidence

- Compare paired DE/EN sections for equal operational meaning.
- Review CEFR B2, first-use terms and text-first state descriptions.
- Compare changed paths with the no-runtime contract.
- Record commands, exitcodes, skipped triggers and residual risk in
  `pr-evidence.md`.
