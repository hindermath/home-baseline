# Autonomous Run Governance v0.2.1 Package Validation

## Package

| Field | Value |
|---|---|
| Canonical scaffold | `specs/spec-kit-presets/autonomous-run-governance/` |
| Publication copy | `specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/` |
| Version | `0.2.1` |
| Priority | `70` |
| Minimum Spec Kit | `0.8.3` |
| Field source | TuiVision Feature 028 real resume, PR `#79`, merge `28f23cc10a400e7450131da387421cb92b9e4ce7` |

## Patch Contract

Version 0.2.1 keeps the v0.2.0 lifecycle and permission model unchanged. It
adds one resume-time mandatory-rule delta audit: current correctness, security,
permission, and evidence-integrity rules are compared with accepted Plan,
Tasks, and checklists after preset or governance drift. Applicable missing rules
receive a minimal in-place amendment and an Analyze rerun. Accepted scope and
efficiency-only guidance remain stable.

## Validation Ledger

| Check | Status | Evidence |
|---|---|---|
| Canonical/publication parity | Pass | Recursive diff is empty after synchronization |
| Manifest and YAML parse | Pass | `preset.yml` resolves v0.2.1; central JSON has seven entries and priority `70` |
| Development install | Pass | Spec Kit 0.12.11 reports v0.2.1, priority `70`, and 18 contributions |
| Seven-preset composition | Pass | Six standard presets remain unchanged at priorities 10-60; optional preset resolves at 70 |
| Command/skill uniqueness | Pass | Five Codex skills, five Claude skills, five Antigravity skills, and five Copilot legacy agent/prompt command pairs; no duplicate command name per surface |
| Copilot skills-mode generation | Open | Spec Kit 0.12.11 generates bundled Copilot skills but does not materialize custom preset commands in `.github/skills/`; legacy agents/prompts remain the validated TuiVision path. Re-evaluate when the CLI supports preset commands in Copilot skills mode. |
| Mandatory resume delta | Pass | Older-task fixture yields `AmendAffectedArtifactsAndAnalyze` for one applicable mandatory rule |
| Efficiency-only resume delta | Pass | Same fixture yields `RetrospectiveOnly`; accepted artifacts remain unchanged |
| Stop/resume state validators | Pass | Bash and PowerShell accept the real 028 state at 130/146 tasks |
| Gate-evidence validators | Pass | Bash and PowerShell accept all nine exact-head rows and reject a tampered head with exit 1 |
| Disable/enable/remove/reinstall | Pass | Preset lifecycle operations preserve v0.2.1 and priority `70` without duplicate registrations |
| Repository checks | Pass | `git diff --check`; Homogeneity 28/28; secret scan high=0; PSScriptAnalyzer 1.25.0 checks 57 files with zero Error/Warning findings |
| Home Baseline PR | Pass | PR [#67](https://github.com/hindermath/home-baseline/pull/67), merge `37a3e6e17d1532987c07eaaf55dde5479bb8c29a` |
| Public preset PR | Pass | PR [#6](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/6), merge `ac59d8ac31bad3893454a6ac41dcbe5c42c1819b` |
| Tag and release | Pass | [`v0.2.1`](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/releases/tag/v0.2.1); exact tag ZIP SHA-256 `799cc189e10893c2fd7106b6f6532fc02a1fc10a65d66b95139465f2acb6cf75` |
| TuiVision adoption | Pass | PR [#81](https://github.com/hindermath/TuiVision/pull/81), merge `a09b741712d35e2faa7f7de35301143515b9ea39`; exact tag ZIP installed, seven presets resolved, and five autonomous commands unique on every maintained surface |

## Boundaries

- No new remote, merge, bypass, cancellation, or provider authority.
- No automatic wholesale regeneration of accepted Spec Kit phases.
- No TuiVision-specific marker, test, versioning, or Wave-order rule.
- No community-catalog update is published for this patch; learnings remain
  bundled until the agreed pre-Wave-5 submission point.
