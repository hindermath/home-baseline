# Autonomous Run Governance v0.2.2 Package Validation

## Package

| Field | Value |
|---|---|
| Canonical scaffold | `specs/spec-kit-presets/autonomous-run-governance/` |
| Publication copy | `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/` |
| Version | `0.2.2` |
| Priority | `70` |
| Minimum Spec Kit | `0.8.3` |
| Field source | TuiVision Feature 029, PR `#84`, merge `e825b7d333667d7bd08e239c22e352f9460f24e1` |

## Patch Contract

Version 0.2.2 preserves the v0.2.1 lifecycle, permission, resume-delta, and
exact-head validator contracts. The package README becomes a bilingual CEFR-B2
operating and learning guide with complete examples and explicit safety
boundaries. A bounded correctness clarification prevents the human-readable
`Deliver` skill heading from being persisted as a machine-state stage; remote
closeout uses `Publish`, `Review`, or `MergeAndSync`.

## Validation Ledger

| Check | Status | Evidence |
|---|---|---|
| Canonical/publication parity | Pass | Recursive diff is empty after synchronization |
| Manifest and YAML parse | Pass | Both manifests resolve v0.2.2; central JSON has seven entries and priority `70` |
| Markdown structure | Pass | Heading order, fenced languages, text-first tables, and `git diff --check` are clean |
| Learner path | Pass | Installation, first local run, status, stop, resume, delivery modes, evidence, retrospective, and troubleshooting are complete |
| State vocabulary | Pass | Both validators reject `Deliver`; `Publish`, `Review`, and `MergeAndSync` fixtures pass |
| Development install | Pass | Spec Kit 0.12.11 reports v0.2.2, priority `70`, and 18 contributions |
| Seven-preset composition | Pass | Standard priorities 10-60 remain unchanged; optional preset resolves at 70 |
| Command/skill uniqueness | Pass | Five autonomous Codex skills occur exactly once after install and reinstall |
| Stop/resume validators | Pass | Bash and PowerShell accept all three canonical remote closeout stage fixtures |
| Gate-evidence validators | Pass | Bash and PowerShell accept all ten real Feature-029 exact-head rows |
| Disable/enable/remove/reinstall | Pass | Lifecycle operations preserve v0.2.2 priority `70` without duplicate skills |
| Repository checks | Pass | Diff and canonical parity clean; homogeneity 100; secrets high=0; PSScriptAnalyzer 1.25.0 reports zero Error/Warning findings |
| Home Baseline PR | Pending | Non-empty documentation package PR |
| Public preset PR | Pending | Publication-copy update only |
| Tag and release | Pending | `v0.2.2` plus exact GitHub ZIP checksum |
| TuiVision adoption | Pending | Exact tag ZIP, seven-preset resolve, and unique autonomous skills |

## Boundaries

- No script behavior, lifecycle, or permission expansion.
- No project-specific .NET, source-comparison, versioning, or merge rule.
- Example remote authority remains illustrative and explicitly non-default.
- No community-catalog issue update is published for this documentation patch.
- Feature 030 is prepared for readiness only and is not started by this package.
