# Field Input Manifest: TuiVision 019

**Source repository:** `hindermath/TuiVision`
**Source main commit:** `c7964ab88b73184347d30e34813fcb6680d2307a`
**Feature PR:** `https://github.com/hindermath/TuiVision/pull/45`
**Closeout PR:** `https://github.com/hindermath/TuiVision/pull/46`
**Retrospective PR:** `https://github.com/hindermath/TuiVision/pull/47`

| Snapshot path | Source path | Candidate use | Project-specific review required |
|---|---|---|---|
| `speckit-autonomous/SKILL.md` | `.agents/skills/speckit-autonomous/SKILL.md` | Portable orchestration command/skill | Remove TuiVision-specific validation and versioning assumptions |
| `speckit-autonomous/agents/openai.yaml` | `.agents/skills/speckit-autonomous/agents/openai.yaml` | Agent UI metadata | Validate generated surfaces and command naming |
| `runbook.md` | `docs/spec-kit-autonomous-runbook.md` | Preset runbook source | Parameterize repository policies and delivery authority |
| `templates/tasks-template.md` | `.specify/templates/tasks-template.md` | Task-shaping addendum source | Extract only autonomous rules; preserve upstream task organization |
| `templates/autonomous-run-evidence-template.md` | `.specify/templates/autonomous-run-evidence-template.md` | Evidence template | Generalize historical-source and governance rows |
| `retrospectives.md` | `docs/spec-kit-autonomous-retrospectives.md` | Retrospective model and candidate template | Keep TuiVision feature facts out of the published template |
| `agent-policy.md` | Identical `Autonomous Red-Proof Completeness` block in five TuiVision agent files | Agent addendum source | Generalize CLR wording to artifact/runtime identity where appropriate |

These files are field-input snapshots, not the final preset. Markdown snapshots
normalize trailing whitespace only so the package branch passes its diff gate;
all semantic lines, YAML, and UI metadata remain source-equivalent. Later
workitems may supersede them. Promotion requires a portable test that does not
depend on TuiVision, .NET, GitHub permissions, or numbered branch versioning.
