# Field Input Manifest: TuiVision 021

**Source repository:** `hindermath/TuiVision`
**Source main commit:** `0ed394c4b0e6a96b3eaa5b582d88b9e96401c040`
**Feature PR:** `https://github.com/hindermath/TuiVision/pull/51`
**Closeout PR:** `https://github.com/hindermath/TuiVision/pull/52`
**Retrospective PR:** `N/A`; no project-local workflow correction was justified

| Snapshot path | Source path | Candidate use | Project-specific review required |
|---|---|---|---|
| `speckit-autonomous/SKILL.md` | `.agents/skills/speckit-autonomous/SKILL.md` | Portable orchestration command/skill | Remove TuiVision versioning, validation, and branch-policy assumptions |
| `speckit-autonomous/agents/openai.yaml` | `.agents/skills/speckit-autonomous/agents/openai.yaml` | Agent UI metadata | Validate generated surfaces and portable command naming |
| `runbook.md` | `docs/spec-kit-autonomous-runbook.md` | Preset runbook source | Parameterize repository gates, closeout transport, and delivery authority |
| `templates/tasks-template.md` | `.specify/templates/tasks-template.md` | Tasks addendum and readiness-checklist source | Extract autonomous rules without replacing upstream task organization |
| `templates/autonomous-run-evidence-template.md` | `.specify/templates/autonomous-run-evidence-template.md` | Evidence and closeout template source | Generalize GitHub-specific examples and historical-source rows |
| `retrospectives.md` | `docs/spec-kit-autonomous-retrospectives.md` | Retrospective command/template source | Remove TuiVision feature facts from the published template |
| `agent-policy.md` | Identical causal-closeout rule in five TuiVision agent files | Agent addendum source | Keep the invariant while making provider terminology portable |
| `evidence/pr-evidence.md` | `specs/021-terminal-charset-hardening/pr-evidence.md` | Complete field ledger example | Remove terminal, C#, DocFX, and numbered-version assumptions |
| `evidence/closeout-evidence.md` | `specs/021-terminal-charset-hardening/closeout-evidence.md` | Causal closeout example | Generalize PR provider, review tools, and merge-policy details |

These files are field-input snapshots, not the final preset. The snapshot adds
no script: Feature 021 confirmed policy and evidence shapes but did not prove a
stack-neutral deterministic implementation with Bash/PowerShell parity.
