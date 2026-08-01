# Autonomous Run Evidence: Feature 020

## Run Identity

- Run: `f190dc20-00ac-48a9-90a6-33977d817af5`
- Branch: `020-documentation-architecture-audit`
- Delivery: `MergeAndSync`
- Binding intake: `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md`
- Intake Review: `3041d8d8-57dc-4c4c-a052-7277bb0cfbe2`, `Ready`
- Series: `97735937-6a49-4507-9698-acad4498f8d4`, `37/3/44`, D4 sole preferred `Eligible`

## Phase Ledger

| Phase | Result | Evidence |
|---|---|---|
| Preflight | Pass | Clean synchronized `main`, PR #193 merged, no active run state |
| Specify | Pass | Scope and DIA/AC identifiers preserved; requirements checklist complete |
| Clarify | Pass | No material planning ambiguity |
| Plan | Pass | Research, data model, contract, quickstart, and plan review complete |
| Tasks | Pass | 130 serialized tasks with conditional D5 handling |
| Analyze | Pass | 0 Critical, 0 High, 0 unresolved Medium after I1/G1/G2/G3 remediation |
| Implement | Pass | 2,624-unit frozen-tree inventory, four reader paths, 23 contracts, three source/runtime classes, one D5 finding |
| Validate | Pending | Local and provider exact-head gates |
| Deliver | Pending | Non-empty PR, review convergence, merge, main sync |
| Retrospective | Pending | Promotion decision after field evidence |

## Accepted Pre-Implementation Evidence

- Base tree: `4c19093692542ff5001819f9ba2d17a1a1a5d4d7`
- Feature directory: `specs/020-documentation-architecture-audit`
- D4 Authoring Receipt: Bash and PowerShell `PASS`
- D4 Intake Review: Bash and PowerShell `PASS`, `Ready`
- Series manifest and receipt: Bash and PowerShell `PASS`, `37/3/44`
- Preferred candidate: exactly D4, role `Primary`, status `Eligible`
- Clarification: no material question remained after focused and repeated passes
- Inventory boundary: frozen Git tree; Feature-020 evidence cannot enter or
  mutate its own assessed path set

## Test-First Proof

- Red baseline: the 17-fixture contract suite failed with
  `FileNotFoundError` because
  `tools/collect_documentation_architecture.py` did not yet exist.
- Green baseline: all 17 positive and negative fixtures pass after the
  collector and fail-closed validator were implemented.
- Provider discovery: `scripts/tests/test_feature_020_documentation_architecture.py`
  executes the feature suite and validates the accepted aggregate through the
  repository's existing `unittest discover` jobs.
- Normalization boundary: UTF-8, optional UTF-8 BOM, LF, and CRLF normalize to
  one hash. Unknown binary or undecodable candidate surfaces block collection.
- Explicit exclusion: `windows-test-output.txt` is bound by raw SHA-256 as
  generated UTF-16 test evidence and remains outside active semantic review.

## Audit Result

- Documentation units: `2624`
- Excluded generated evidence surfaces: `1`
- Reader paths: `4` (`2 Pass`, `2 Gap`)
- Maintenance contracts: `23`, each with seven reviewed surfaces
- Distribution classes: `homeRuntime 240`, `sourceOnly 2138`,
  `machineLocal 246`
- Findings: `DIA001` (`Medium`, owner `DocumentationArchitecture`, successor
  `D5`)
- D5/D6/D7 finding cardinality: `1/0/0`
- Aggregate status: `ReadyWithFindings`
- Determinism: a second collector run produced byte-identical inventory and
  aggregate files.
- Validator: `PASS: 2624 units, 4 reader paths, 23 contracts, 3
  source/runtime classes, 1 findings`

DIA001 is limited to the 3,683-line bilingual root README, which combines four
reader roles and several topic families. No evidence justifies a D6 or D7
remediation intake. Feature 020 does not start any successor run.

## Scope Boundary

Feature 020 may change only its feature artifacts, deterministic audit-only
proof, final statistics, archive/order evidence, and delivery evidence. Active
professional documentation, runtime, maintenance scripts, workflows, presets,
dependencies, packages, and fleet repositories remain unchanged.

The test-only provider bridge is catalogued through the existing
`scripts/tests/*` rule. This triggered a deterministic `GeneratedUpdate` for
`docs/scripts/reference.md` and `docs/scripts/embedded-scripts.md`; their
canonical catalog and renderer remain unchanged.

## Local Validation Ledger

| Command or gate | Result | Proof boundary |
|---|---|---|
| Feature contract suite | Pass, 17 tests | Positive and required negative fixtures |
| Provider discovery bridge | Pass, 2 tests | Feature suite plus accepted aggregate |
| Full aggregate validator | Pass | 2,624 units, 4 paths, 23 contracts, 3 classes, 1 finding |
| Deterministic second collection | Pass | Inventory and aggregate byte-identical |
| Authoring receipt, Bash/PowerShell | Pass / Pass | Current D4 authoring provenance |
| Intake Review, Bash/PowerShell | Pass / Pass | Current D4 `Ready` review |
| Series manifest and receipt, Bash/PowerShell | Pass / Pass | `37/3/44`, D4 eligible |
| Autonomous state schema, Bash/PowerShell | Pass / Pass | Updated again after task/hash reconciliation |
| `specify check` | Pass | Installed integrations ready |
| `git diff --check` | Pass | No whitespace error |
| Lychee offline with fragments | Pass | 3,568 links, zero errors before generated-reference refresh |
| Script-reference renderer/test | Pass | `124` canonical and `157` embedded scripts |
| PSScriptAnalyzer 1.25.0 | Pass | 147 repository-owned files, zero warnings/errors |
| Gitleaks/agent secret scan | Pass | Zero High findings; known local agent metadata only |
| DocFX and browser A11Y | Not triggered | No API, navigation, website, or learner-guide content changed |
| Product build/test | Not triggered | No product runtime or buildable project changed |

The first Homogeneity preview reported only expected generated-reference drift.
After rendering, the remaining Statistics Profile 2 drift is intentionally
resolved in the serialized statistics phase before final Homogeneity proof.
