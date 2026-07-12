# Field Input Manifest: TuiVision 023

**Source repository:** `hindermath/TuiVision`
**Source main commit:** `47d64599f1e65f40aa1c830f51f7b97d85235637`
**Feature PR:** `https://github.com/hindermath/TuiVision/pull/56`
**Closeout PR:** `https://github.com/hindermath/TuiVision/pull/57`
**Retrospective PR:** `https://github.com/hindermath/TuiVision/pull/58`

| Snapshot path | Source path | Candidate use | Project-specific review required |
|---|---|---|---|
| `speckit-autonomous/SKILL.md` | `.agents/skills/speckit-autonomous/SKILL.md` | Portable autonomous command/skill | Parameterize repository gates, version tokens, delivery provider, and validation commands |
| `speckit-autonomous/agents/openai.yaml` | `.agents/skills/speckit-autonomous/agents/openai.yaml` | Agent UI metadata | Generate portable command names once per supported integration |
| `runbook.md` | `docs/spec-kit-autonomous-runbook.md` | Preset runbook source | Remove TuiVision, .NET, DocFX, and numbered-branch assumptions |
| `templates/agent-file-template.md` | `.specify/templates/agent-file-template.md` | Agent addendum source | Extract only autonomous governance; do not replace a consumer's agent template |
| `templates/tasks-template.md` | `.specify/templates/tasks-template.md` | Tasks addendum and readiness source | Preserve upstream task organization and consumer-specific validation |
| `templates/autonomous-run-evidence-template.md` | `.specify/templates/autonomous-run-evidence-template.md` | Evidence and closeout source | Generalize provider fields and mutable validation tokens |
| `retrospectives.md` | `docs/spec-kit-autonomous-retrospectives.md` | Retrospective command/template source | Remove TuiVision feature facts from the published template |
| `agent-policy.md` | Identical autonomous rule block in five TuiVision agent files | Agent addendum source | Keep permission and validation rules provider-neutral |
| `evidence/pr-evidence.md` | `specs/023-a11y-framework/pr-evidence.md` | Complete field ledger example | Remove A11Y, C#, branch-version, and repository task assumptions |
| `evidence/closeout-evidence.md` | `specs/023-a11y-framework/closeout-evidence.md` | One-commit closeout example | Generalize provider, reviewer, and merge-policy details |
| `scripts/check-homogeneity.sh` | `scripts/check-homogeneity.sh` | Fail-closed wrapper evidence | Do not publish without the complete helper set and Bash/PowerShell contract tests |
| `scripts/check-homogeneity.ps1` | `scripts/check-homogeneity.ps1` | Fail-closed wrapper evidence | Do not publish without the complete helper set and Bash/PowerShell contract tests |

These files are field-input snapshots, not the final preset. The two wrapper
scripts demonstrate a corrected failure boundary but are not autonomous preset
scripts. They remain evidence for atomic script-plus-helper deployment and
cross-shell parity requirements.
