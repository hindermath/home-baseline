# Field Input Manifest: TuiVision 022

**Source repository:** `hindermath/TuiVision`
**Source main commit:** `3329e59f222e05141f464f75a6fcf2c01ad83448`
**Feature PR:** `https://github.com/hindermath/TuiVision/pull/53`
**Closeout PR:** `https://github.com/hindermath/TuiVision/pull/54`
**Retrospective PR:** `https://github.com/hindermath/TuiVision/pull/55`

| Snapshot path | Source path | Candidate use | Project-specific review required |
|---|---|---|---|
| `speckit-autonomous/SKILL.md` | `.agents/skills/speckit-autonomous/SKILL.md` | Portable orchestration command/skill | Remove TuiVision versioning, validation, and branch-policy assumptions |
| `speckit-autonomous/agents/openai.yaml` | `.agents/skills/speckit-autonomous/agents/openai.yaml` | Agent UI metadata | Validate generated surfaces and portable command naming |
| `runbook.md` | `docs/spec-kit-autonomous-runbook.md` | Preset runbook source | Parameterize repository gates, duplicate-run classification, closeout transport, and delivery authority |
| `templates/tasks-template.md` | `.specify/templates/tasks-template.md` | Tasks addendum and readiness-checklist source | Extract autonomous rules without replacing upstream task organization |
| `templates/autonomous-run-evidence-template.md` | `.specify/templates/autonomous-run-evidence-template.md` | Evidence and closeout template source | Generalize provider-specific examples and external terminal-fact verification |
| `retrospectives.md` | `docs/spec-kit-autonomous-retrospectives.md` | Retrospective command/template source | Remove TuiVision feature facts from the published template |
| `agent-policy.md` | Identical autonomous closeout/duplicate-run block in five TuiVision agent files | Agent addendum source | Preserve permission boundaries and provider neutrality |
| `evidence/pr-evidence.md` | `specs/022-wave4-visual-component-porting/pr-evidence.md` | Complete field ledger example | Remove terminal, C#, DocFX, numbered-version, and TuiVision task assumptions |
| `evidence/closeout-evidence.md` | `specs/022-wave4-visual-component-porting/closeout-evidence.md` | One-commit non-self-referential closeout example | Generalize PR provider, review tools, and merge-policy details |

These files are field-input snapshots, not the final preset. The snapshot adds
no script because argv handling and duplicate-run correlation do not yet have a
second portable field result with Bash/PowerShell parity.
