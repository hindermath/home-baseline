# Field Input Manifest: TuiVision 020

**Source repository:** `hindermath/TuiVision`
**Source main commit:** `26cf842118b97b133bfe99e4c82759db9c2b40f2`
**Feature PR:** `https://github.com/hindermath/TuiVision/pull/48`
**Closeout PR:** `https://github.com/hindermath/TuiVision/pull/49`
**Retrospective PR:** `https://github.com/hindermath/TuiVision/pull/50`

| Snapshot path | Source path | Candidate use | Project-specific review required |
|---|---|---|---|
| `speckit-autonomous/SKILL.md` | `.agents/skills/speckit-autonomous/SKILL.md` | Portable orchestration command/skill | Remove TuiVision versioning, validation, and branch-policy assumptions |
| `speckit-autonomous/agents/openai.yaml` | `.agents/skills/speckit-autonomous/agents/openai.yaml` | Agent UI metadata | Validate generated surfaces and portable command naming |
| `runbook.md` | `docs/spec-kit-autonomous-runbook.md` | Preset runbook source | Parameterize repository gates, closeout transport, and delivery authority |
| `templates/tasks-template.md` | `.specify/templates/tasks-template.md` | Tasks addendum and readiness-checklist source | Extract autonomous rules without replacing upstream task organization |
| `templates/autonomous-run-evidence-template.md` | `.specify/templates/autonomous-run-evidence-template.md` | Evidence and closeout template source | Generalize GitHub-specific examples and historical-source rows |
| `retrospectives.md` | `docs/spec-kit-autonomous-retrospectives.md` | Retrospective command/template source | Remove TuiVision feature facts from the published template |
| `agent-policy.md` | Identical autonomous closeout rule in five TuiVision agent files | Agent addendum source | Keep the gate invariant while making remote provider terminology portable |

These files are field-input snapshots, not the final preset. Markdown
snapshots normalize trailing whitespace only; their semantic content remains
source-equivalent. The snapshot contains no new script because Feature 020
proved a workflow invariant, not a stack-neutral deterministic detector. Any
later script requires a portable contract plus Bash and PowerShell parity.
