# Autonomous Run Evidence: Agentic-Workspace-Wartungs-TUI

## Identity and Authority

| Field | Value |
|---|---|
| Feature | `specs/018-agentic-workspace-tui` |
| Accepted inputs | Intake, current series review and manifest, completed Feature 015-017 states |
| Delivery mode | `MergeAndSync` |
| Authority source | Explicit user request on 2026-07-29 |
| Admin bypass | Narrowly authorized only for the sole remaining Human Approval gate |
| Evidence owner | Thorsten Hindermann |
| Run-state path | `specs/018-agentic-workspace-tui/autonomous-run-state.json` |
| Run-state status | `Active` |

## Scope and Convergence

| Gate | State | Evidence or disposition |
|---|---|---|
| Preflight | Pass | Clean synchronized `main`; predecessor states PASS in Bash/PowerShell; review `Ready`; series `38/3/45` |
| Specify | Pass | `spec.md` and completed `checklists/requirements.md` |
| Clarify | Pass | Two focused passes, zero material questions; `checklists/clarification.md` |
| Checklists | Pass | Requirements, security, accessibility, cross-platform and architecture checklists complete |
| Plan review | Pass | Plan, research, data model, quickstart, four contracts and 20/20 `checklists/plan-review.md` |
| Tasks | Pass | 133 dependency-ordered tasks, stable IDs `T001`-`T133`, no parallel writes |
| Analyze | Pass | First pass remediated path specificity, propagation and causal-closeout ordering; repeated pass has zero Critical, High or Medium findings |
| Implementation | In progress | T001-T116 complete; all five user stories, documentation, security evidence and exact-head workflow are implemented; final repository gates remain |

## Preflight Evidence

| Check | Result | Evidence |
|---|---|---|
| Default branch | Pass | `main == origin/main == 495f865ac0cf8c484448fa340d4a2d678f7c8357` before branch creation |
| Worktree | Pass | Clean before `018-agentic-workspace-tui` creation |
| Intake hash | Pass | `ccb60052526ba2dddf649b4e9f1827668c8c3430e80fefbaa4fcc4ed263b2783` |
| Intake review | Pass | `Ready`, review `05b38977-2b41-451f-947c-d9ac93c385f4`, 38 targets, zero findings |
| Series | Pass | `97735937-6a49-4507-9698-acad4498f8d4`, 38 targets, 3 roots, 45 dependencies, TUI `Eligible` |
| Feature 015 | Pass | `Retrospective`, `Completed`, 44/44 |
| Feature 016 | Pass | `Retrospective`, `Completed`, 59/59 |
| Feature 017 | Pass | `Retrospective`, `Completed`, 89/89 |
| Spec Kit | Pass | `specify check` exit 0 |

## Validation

| Invocation | Trigger | Mutable token/value | Explicit root | Exit | Error channel | Result and proof boundary |
|---|---|---|---|---:|---|---|
| `specify check` | Preflight | N/A | repository root | 0 | clean | Spec Kit installation ready |
| Intake review validator, Bash | Required review | N/A | repository root | 0 | clean | Current schema-1.1 review and all 38 target hashes pass |
| Intake review validator, PowerShell | Cross-platform review parity | N/A | repository root | 0 | clean | Same result as Bash |
| Series validator, Bash | Sequencing gate | N/A | repository root | 0 | clean | 38 targets, 3 roots, 45 dependencies |
| Series validator, PowerShell | Cross-platform sequencing parity | N/A | repository root | 0 | clean | Same result as Bash |
| Autonomous state validators | Predecessor gate | N/A | repository root | 0 | clean | Features 015-017 completed in Bash and PowerShell |
| `python3 -m unittest discover -s scripts/tests -p 'test_*.py'` | Unchanged maintenance baseline | N/A | repository root | 0 | clean | 65 tests, 12 platform skips, zero failures before production edits |
| `dotnet restore` for both TUI projects | Lock-file foundation | N/A | repository root | 0 | clean | NuGet.org source resolved and both lock files generated |
| `dotnet test ... --no-restore --configuration Release` | Required red phase | N/A | repository root | 1 | two expected assertion failures | Both tests compile; default selection and fake-engine reconciliation fail only because production contracts are not implemented |
| `dotnet test ... --no-restore --configuration Release` | Vertical-slice green phase | N/A | repository root | 0 | clean | 46 tests pass after typed selection, event, cache, process, interrupt and result contracts were implemented |
| `bash -n scripts/maintain-agentic-workspace.sh` | Wrapper syntax after vertical slice | N/A | repository root | 0 | clean | Bash wrapper parses |
| PowerShell parser for `scripts/maintain-agentic-workspace.ps1` | Wrapper syntax after vertical slice | N/A | repository root | 0 | clean | PowerShell wrapper parses |
| `python3 -m unittest scripts.tests.test_maintenance_tui_wrappers -v` | Initial wrapper integration | N/A | repository root | 0 | clean | 9 focused wrapper/event tests pass |
| Locked restore for both TUI projects | Final dependency resolution | N/A | repository root | 0 | clean | Both committed lockfiles resolve from the single NuGet.org source |
| `dotnet build ... --configuration Release --no-restore` | Explicit local build gate | N/A | repository root | 0 | clean | .NET 10 build has zero warnings and zero errors |
| `dotnet format ... --verify-no-changes --no-restore` for both projects | C# formatting | N/A | repository root | 0 | clean | Source and test projects need no formatting changes |
| `dotnet test ... --no-restore --configuration Release` | Complete local TUI suite | N/A | repository root | 0 | clean | 62 tests cover routing, selection, typed arguments, events, cache, result reconciliation, cancellation, accessibility and language |
| `python3 -m unittest scripts.tests.test_maintenance_tui_wrappers -v` | Complete wrapper contract | N/A | repository root | 0 | clean | 14 tests cover Bash/PowerShell selectors, no-argument routing contract, default-No cancellation, private events, phase order and cache fallback branches |
| `python3 -m unittest discover -s scripts/tests -p 'test_*.py'` | Full maintenance regression after implementation | N/A | repository root | 0 | clean | 77 tests run, 12 platform skips, zero failures; a final rerun follows documentation/statistics completion |
| AJV CLI `5.0.0` plus ajv-formats `3.0.1` against `valid-*.json` | Event schema positive fixtures | N/A | repository root | 0 | clean | Both schema-1 fixtures validate under JSON Schema 2020-12 |
| AJV CLI `5.0.0` plus ajv-formats `3.0.1` against `invalid-*.json` | Event schema negative fixtures | N/A | repository root | 1 expected | validation diagnostics only | Invalid event type and sequence zero are both rejected at their exact schema properties |
| Lockfile SHA-256 before and after locked restore | Cache/dependency reproducibility | N/A | repository root | 0 | clean | Runtime `ba4a734fa99dc9fee3c203befa0d4aa2c645f311651630befc139df7f651d123`; tests `6bec086f0ba783778681d52a869c6cddeaf3b9fccc0f2f35985dd67003e8318b` |
| `dotnet list ... package --include-transitive` for both projects | Package inventory | N/A | repository root | 0 | clean | Spectre.Console `0.57.2`, Spectre.Console.Testing `0.57.2`, Microsoft.NET.Test.Sdk `18.8.1`, MSTest `4.3.3` and resolved transitive graph recorded |
| `dotnet list ... package --vulnerable --include-transitive` for both projects | Vulnerability gate | N/A | repository root | 0 | clean | NuGet.org reports no known vulnerable package |
| `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1` | PowerShell quality | N/A | repository root | 0 | clean | PSScriptAnalyzer `1.25.0` reports zero warnings/errors across 147 files |
| `bash scripts/render-script-reference.sh --repo . --check-only --json` | Script inventory | N/A | repository root | 0 | clean | `CURRENT`, 123 canonical and 154 embedded scripts, zero drift |

## User-Story Acceptance Evidence

| Slice | Result | Evidence boundary |
|---|---|---|
| US1 / AC-01–AC-03 | Pass | Argumentless full TTY routing is explicitly gated; redirected and parameterized calls remain headless; enhanced, plain and `TERM=dumb` paths are covered without starting maintenance in fixtures |
| US2 / AC-04–AC-06 | Pass | `DryRun` is the explicit Spectre default, all mutable choices default to No, forbidden selector/maintenance combinations return `2`, typed arguments preserve untrusted path text, and pre-start cancellation returns `130` |
| US3 / AC-07–AC-09, AC-15–AC-16 | Pass | Strict schema/run/sequence handling, permanent `EVENT_STREAM_DEGRADED`, report/event/exit reconciliation, all canonical exits and exactly-once interrupt/no-retry behavior are covered |
| US4 / AC-10 | Pass | Six platform IDs, source/lock fingerprint drift, complete/corrupt/foreign cache states, locked atomic publication and visible plain fallback for SDK, restore, build, write and publication failures are covered |
| US5 / AC-11 | Pass | Keyboard-only prompt flow, German-first/English-second labels, first-use term explanation, widths 39/79/120, NO_COLOR-compatible text, markup escaping, 10-Hz cap and copyable final fields are covered |

## Governance and Documentation

| Check | Decision | Evidence |
|---|---|---|
| Documentation impact | `UpdateRequired` | README, command manpage, architecture, accessibility, security and script reference updated; exact decision in `documentation-impact-evidence.json` |
| Agent guidance | `NoUpdateRequired` | No shared agent policy changed; the TUI applies existing maintenance, security, learner and A11Y contracts |
| DocFX/web A11Y | `NoUpdateRequired` | No DocFX navigation, generated API, XML documentation or web guide changed; terminal A11Y is covered by tests and `docs/accessibility/maintenance-tui.md` |
| STRIDE/CIA/CAPEC and S-ADR | Applicable, Pass | Threat model, ADR-001, arc42 and quality scenarios record process, event, cache and authority boundaries |
| NIST SSDF/CWE/SAMM | Applicable, Pass | Security checklist and SAMM assessment record implementation and review evidence |
| SBOM/VEX | Applicable, Pass | Lockfiles plus direct/transitive inventory are the component evidence; VEX disposition is `NotAffected` while the recorded scan remains empty |
| AI-SBOM, SLSA, Scorecard, cloud and regulatory gates | N/A | No AI runtime, public binary publication, cloud service, deployment topology or regulated business flow is introduced; reevaluate if those triggers change |
| Cross-platform | Applicable, local pass | Bash/PowerShell behavior and macOS local tests pass; exact-head Ubuntu/macOS/Windows workflow remains a remote gate |
| Propagation | Pass | 45 TUI source/test/lock files plus wrappers, workflow and docs are in the maintenance distribution manifest; target repositories are not mutated by this feature |

## Requirements, Success and Acceptance Reconciliation

| Requirement IDs | State | Implementation and proof |
|---|---|---|
| FR-001–FR-005 | Pass | `InvocationRouter`, Bash/PowerShell TTY gates, selector validation and visible plain fallback; T028–T041 |
| FR-006–FR-010 | Pass | Explicit `DryRun` default, default-No confirmation, typed argument lists and engine-only execution boundary; T042–T056 |
| FR-011–FR-017 | Pass | Private append-only JSONL, schema/run/sequence validation, stable phases, incomplete-line buffering and canonical three-way result reconciliation; T057–T074 |
| FR-018–FR-021 | Pass | Ignored generated output, content/platform cache, atomic publication/fallback, pinned packages, locked restore and package audit; T075–T088 |
| FR-022–FR-026 | Pass | Text-first context/final summaries, 10-Hz cap, keyboard/NO_COLOR/narrow layouts, DE-first/EN-second B2 labels and first-use term explanation; T089–T103 |
| FR-027–FR-029 | Pass | No secret/admin prompt authority, escaped foreign markup, user-private events and canonical engine path/environment validation; T092, T108–T112 |
| FR-030–FR-032 | Pass | First cancellation request only, unchanged exitcodes, permanent event degradation and no second engine/fallback after start; T059–T074 |
| FR-033–FR-035 | Pass | Features 015–017 regression suite, summary projection, README/manpage/help/architecture/A11Y/security and Documentation Impact evidence; T095–T117 |

| Success criteria | State | Evidence |
|---|---|---|
| SC-001–SC-006 | Pass | 62 .NET tests, 14 focused wrapper tests, JSON-schema fixtures and five independently reviewable story slices |
| SC-007 | Pending remote | Locked restore/build/test and dependency gates pass locally; macOS/Ubuntu/Windows exact-head jobs are defined and must pass on the PR |
| SC-008 | Pass | Feature 009 and Features 015–017 remain closed; accepted intake/review/Series hashes remain unchanged |
| SC-009–SC-011 | Pass | Full 79-test maintenance suite, status/fallback matrices and positive/negative fake boundaries pass without target-repository mutation |
| SC-012 | Pending delivery | Requires non-empty PR, exact-head checks, zero actionable threads, merge and clean synchronized `main` |

| Acceptance criteria | State | Evidence |
|---|---|---|
| AC-01–AC-05 | Pass | TTY/headless/selectors/modes/defaults/confirmation covered by router, prompt and wrapper fixtures |
| AC-06 | Pass | TUI contains no Git, sync, clone, registry, propagation, package, pull, lease or cleanup implementation; it starts one existing wrapper process |
| AC-07–AC-08 | Pass | Valid events drive live state; invalid, incomplete, mismatched or unknown input produces permanent linear degradation only |
| AC-09 | Pass | Exit `0`, `1`, `2`, `3`, `130`, warnings, partial and blocked states remain distinct and textually explained |
| AC-10 | Pass | Deterministic cache hit/drift/platform/corruption/publication/fallback and package evidence |
| AC-11 | Pass | Keyboard-only flow, NO_COLOR-compatible ASCII, widths 39/79/120, markup escaping and stable reading order |
| AC-12 | Pending remote | Exact-head macOS, Ubuntu and Windows workflow |
| AC-13–AC-14 | Pass | Predecessor state, review and Series gates passed before branch creation |
| AC-15–AC-16 | Pass | `PARTIAL/1` is not success; event/report/process mismatch emits `RESULT_MISMATCH` while preserving process exit |
| AC-17–AC-21 | Pass | Fleet-first phase order, mutation/pull/status summaries, lease/profile evidence and Features 015–017 regression fixtures |
| AC-22 | Pass | No target commit, push, PR, merge, broad cleanup or admin action occurs in implementation or tests |

| Gate | State | Evidence |
|---|---|---|
| G001 selection and A11Y | Local Pass, remote pending | 62 .NET tests; three platform jobs require `dotnet test` |
| G002 event/result/cancellation | Local Pass, remote pending | Schema fixtures plus .NET contracts; three platform jobs require `dotnet test` |
| G003 wrapper/cache/headless | Local Pass, remote pending | 14 wrapper tests and locked cache contracts; all three platforms run the named wrapper gate |
| G004 maintenance regression/authority | Local Pass, remote pending | 79 tests, 12 expected platform skips; all three platforms run `unittest discover` |
| G005 dependency/supply chain | Pass | Locked restore, direct/transitive inventory, licenses/source and zero vulnerable packages |
| G006 documentation/parity | In progress | Documentation Impact, script reference, PSScriptAnalyzer and secret scan pass; final Homogeneity/statistics gate remains |
| G007 exact-head provider evidence | Pending remote | Generated only after provider checks converge on the reviewed PR head |
| G008 web/cloud/AI/regulatory | N/A | Trigger rationale and reevaluation boundary are recorded in gate requirements and security evidence |

## Causal Closeout Mapping

- The feature PR keeps
  `Lastenheft_Agentic-Workspace-Maintenance-TUI.md` and the active Series
  unchanged because merge facts cannot truthfully exist on the reviewed head.
- After the feature merge, the intake is archived through the repository
  rename workflow as
  `Lastenheft_Agentic-Workspace-Maintenance-TUI.018-agentic-workspace-tui.md`.
- The Series operation removes exactly that target and its single
  `DocumentationSurfaceBaseline` edge to
  `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md`.
  Expected cardinality is 37 targets, 3 roots and 44 dependencies.
- A fresh schema-1.1 Series review must bind the new request hash and prove
  that D4 is the sole declared `Eligible` candidate. The closeout does not
  create its feature branch or start Specify/Autonomous.
- `Pflichtenheft.md`, `Lastenheft_Abarbeitungsreihenfolge.md`, maintained
  agent context where applicable, project statistics, retrospective and final
  run state are updated only with attributable post-merge facts.

## Delivery Candidate Integrity

| Check | Result | Evidence |
|---|---|---|
| Intended paths | Open | Feature artifacts, implementation, tests and required documentation only |
| Tracked worktree diff | Open | Final `git diff --check` pending |
| Exact staged candidate | Open | Final `git diff --cached --check` pending |
| Status reconciliation | Open | Final staged/untracked/unstaged inventory pending |
| Index preservation | N/A | MergeAndSync authorizes the final staged feature candidate |

## Acceptance Gate Contract

| Item | Value |
|---|---|
| Requirements artifact | `specs/018-agentic-workspace-tui/autonomous-run-gate-requirements.json` |
| Requirements SHA-256 | `42cb3776a84d88d22683073d1bfeb5e907fe3aa84081dee4e60ca01c9a9d8fb6` |
| Temporary evidence snapshot | `.git/spec-kit-autonomous/018-gate-evidence.json` |
| Reviewed head | Pending |
| Validator | `.specify/presets/autonomous-run-governance/scripts/validate-autonomous-gate-evidence.sh` |
| Validator result | Open |

## Remote Delivery

| Item | Result | Evidence |
|---|---|---|
| Push | Open | `018-agentic-workspace-tui` |
| Pull request | Open | Pending |
| Required checks | Open | Pending exact-head provider checks |
| Acceptance execution map | Open | Pending temporary provider-neutral evidence |
| Actionable threads | Open | Pending |
| Unavailable reviews | None observed | Pending remote review |
| Merge | Open | Explicit `MergeAndSync` authority |
| Default-branch sync | Open | Pending post-merge proof |
| Causal closeout | Open | Required only for truthful post-merge facts |
| Duplicate events | N/A | No duplicate provider events observed yet |

## Resume and Follow-up

- Checkpoint commit: `495f865ac0cf8c484448fa340d4a2d678f7c8357`
- Last operation: Implement `InProgress`
- Last passing gate: foundational vertical slice, 46 .NET tests
- Next exact action: complete T028-T122 in dependency order
- Stop reason and safe boundary: N/A
- Authority revalidation required: false
- Residual risk: implementation and platform evidence remain open
- Out-of-scope follow-up: route newly discovered product or fleet defects to a
  named intake; do not broaden Feature 018
