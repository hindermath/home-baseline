# Field Input Manifest: TuiVision 018

**Source repository:** `hindermath/TuiVision`  
**Source main commit:** `945d8eb`  
**Feature PR:** `https://github.com/hindermath/TuiVision/pull/42`  
**Closeout PR:** `https://github.com/hindermath/TuiVision/pull/43`  
**Retrospective PR:** `https://github.com/hindermath/TuiVision/pull/44`

| Snapshot path | Source path | Candidate use | Project-specific review required |
|---|---|---|---|
| `speckit-autonomous/SKILL.md` | `.agents/skills/speckit-autonomous/SKILL.md` | Portable orchestration command/skill | Remove TuiVision-specific validation and versioning assumptions |
| `speckit-autonomous/agents/openai.yaml` | `.agents/skills/speckit-autonomous/agents/openai.yaml` | Agent UI metadata | Validate generated surfaces and command naming |
| `runbook.md` | `docs/spec-kit-autonomous-runbook.md` | Preset runbook source | Parameterize repository policies and delivery authority |
| `templates/autonomous-run-evidence-template.md` | `.specify/templates/autonomous-run-evidence-template.md` | Evidence template | Generalize historical-source and governance rows |
| `retrospectives.md` | `docs/spec-kit-autonomous-retrospectives.md` | Retrospective model and candidate template | Keep feature facts out of the published template |

These files are field-input snapshots, not the final preset. Later workitems may
supersede them. Promotion requires a field-validation decision and a portable
test that does not depend on the TuiVision repository.
