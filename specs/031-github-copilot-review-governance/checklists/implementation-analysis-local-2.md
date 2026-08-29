# Local Implementation Analysis Receipt 2

## Review identity

- Feature: `specs/031-github-copilot-review-governance`
- Routed phase: `analyze-local-2`
- Reviewed boundary: post-remediation T001-T122; T123-T168 remain outside this phase
- Review time: `2026-08-29T04:38:49Z`
- Outcome: `Blocked`
- Gate result: `false`
- Optional hooks: skipped as instructed
- Persistent writes by this review: this receipt and the runner-owned `analyze-local-2.result.json` only
- Prohibited actions observed: no current-repository stage/commit/push/PR/merge/ref write, no live GitHub/provider read or write, no account/ruleset/billing/subscription mutation, no Home sync, no intake-series mutation, and no Position-7 start

## Exact artifact and state metrics

| Metric | Result | Disposition |
|---|---:|---|
| Task rows | 168, unique and sequential T001-T168 | Structurally consistent |
| Checked task rows | 122, exactly T001-T122 | Structurally consistent |
| Open task rows | 46, exactly T123-T168 | Structurally consistent; T123 was not marked |
| Tasks SHA-256 | `48020705c184dca7c56b1d5c2be84cd666718e53f17fcf4f9b98952d1d465bb1` | Equals State |
| State task counters | 122/168 | Equals Tasks |
| Run state | `Implement`, `Active`; `analyze-local-2=Running` | Validator exit 0; no State edit by review |
| CRG / CR / AC-CRG / SC IDs | 18 / 10 / 10 / 12 | Structurally traced; behavioral closure blocked below |
| Task metadata fields | 168/168 each for Trace, Gate/Authority, Evidence, Owner/Reviewer and Verify | Structural traceability only |
| Constitution copies | byte-identical, v1.21.0 | Pass |
| Scope-contract records | 10/10 `ScopeContract/Open`, Primary command false, provider writes 0 | Truthfully open |
| Supplemental records | 10/10 `Supplemental/Open`, Primary command false, provider/network/ref writes 0 | Truthfully open |
| Runner maintained-tree parity | 3/3 byte-identical for runner, fixture, direct test, Bash wrapper and man page | Source parity passes |
| Direct / Bash runner output | 6/6 and 6/6, exit 0 | Output is not sufficient proof; IAL-001 remains |
| G4 test dispatch | 71 class labels, only 30 dispatch signatures | Class-specific contract is violated; IAL-002 remains |
| Targeted G4 transaction labels | 15/15, exit 0 | Contradicted by direct provider-state inspection; IAL-002 remains |
| T134 exact CLI | exit 1 | Critical accepted-command failure; IAL-004 remains |
| T150 derived-after-state + preview | exit 0 + 0; 17 actions, 0 writes, 0 blocked | This bounded shape passes |
| Missing/unknown Inventory/Gate probes | exits 2/2 for all four | Closed-world shape rejection repaired |
| Arbitrary authority/evidence hashes with empty EvidenceRoot and no InventoryPath | exit 0 | Critical semantic gate failure; IAL-003 remains |
| Current branch / HEAD | `031-github-copilot-review-governance` / `d160b4815eade6cdbf6788a63233158582611d70` | Unchanged by review |
| Index paths | 0 | No staged absorption |
| Original `analyze.result.json` raw SHA-256 | `456540b39968fdf1ea5a317715ffea43743c03a6fde75170077123ad667234a3` | Unchanged |
| Blocked `analyze-local` result raw SHA-256 | `aaf91d707db4f03b9b2fe43b06114e843959bb927df1c5a8cbeba218e0763aae` | Reviewed |
| Remediation result raw SHA-256 | `593b26cc83025ac0e0d175979ab86c49f0357adba185025cfd250a0b5772aed1` | Envelope valid; substantive claims contradicted below |

## Findings

### IAL-001 — Critical — Runner PASS output still claims assertions that the tests do not perform

- Locations:
  - `.specify/presets/autonomous-run-governance/tests/test-model-routing.ps1:126-157`
  - identical direct-test copies in both maintained preset trees
  - runtime Local receipts `operational/runner-adoption/green-direct.json`, `green-wrapper.json` and `reconciliation.json`
- Independent evidence:
  - Both surfaces create six isolated temporary Git repositories, pass six distinct `-Scenario` values and invoke the actual parent runner. That part is repaired.
  - The test inspects the index, selected status/counters, terminal refs and terminal result/payload hashes. It never reads or hashes the log file, never asserts the tracked-worktree output directly, and does not compare exact child State/Tasks/result/payload/log bytes for every failure/drift case.
  - Nevertheless every row prints `state/tasks/result/payload/ref/index/worktree/log assertions executed`, and both Local receipts set `stateTasksResultPayloadRefIndexWorktreeLogAssertions=true`.
- Impact: the executable proof and persisted Local evidence overstate the tested byte boundary. This is a false evidence claim under the explicit phase gate.
- Owner / reviewer: Test Owner and Script Owner / Autonomous and Cross-Platform Reviewers.
- Disposition: unresolved. Add observable byte/hash assertions for each required target and each scenario, including log materialization/failure and exact drift preservation, then regenerate only truthful receipts.

### IAL-002 — Critical — G4 classes remain aliases and the FakeProvider does not implement the claimed observable state transitions

- Locations:
  - `scripts/tests/test_copilot_review_governance.py:394-600`
  - `scripts/modules/CopilotReviewGovernance.psm1:650-900`
  - `.github/workflows/copilot-review-governance-native-proof.yml:1-45`
  - runtime Local receipts `operational/quality/full-tests.json` and `operational/transactions/*.json`
- Independent evidence:
  - Static dispatch inspection found 71 labels but only 30 dispatch signatures. Six inventory classes share one operation; five PR/manual/advisory classes share one operation; four transaction/security classes share generic Apply; 13 aggregator/supplemental labels share one writer; `RedactionNegativeTests` submits only a benign `{status=Open}` value; `EvidencePublisherTests` performs a generic transaction; A11Y documentation merely checks file existence; workflow validation does not exercise the exact T116 event/hash/artifact contract.
  - A targeted 15-label transaction run exits 0, but direct FakeProvider inspection shows an ambiguous write returns `Reconciled` with transaction kinds only `Write, Apply` and no reconciliation read.
  - A `RulesetUpdate` result reports success while the provider Inventory retains `reviewOnPush=true`; an `AccountSetting` result reports success while Inventory remains `Enabled`. Update/disable/account/effort rollback and convergence are therefore not observable provider-state operations.
  - `idempotentSecondPass` is populated as zero writes/drift in the first result without executing that second pass inside the product operation.
- Impact: T012-T122 behavioral evidence, including T048, T059-T069, T116, T118 and cross-functional Local receipts, is false or incomplete even though labels print PASS.
- Owner / reviewer: Test Harness Owner, Product Core Owner and CI Owner / Security, Architecture, Acceptance, A11Y and Cross-Platform Reviewers.
- Disposition: unresolved. Give every claimed class class-specific positive/negative input and assertions; implement and journal real read/reconcile/state transitions for all FakeProvider operation classes; reject aliases as evidence.

### IAL-003 — Critical — Closed-world shapes are repaired, but authority, evidence, freshness and TOCTOU semantics still fail open

- Locations:
  - `scripts/manage-copilot-review-governance.ps1:68-151`
  - `scripts/modules/CopilotReviewGovernance.psm1:93-110, 394-475, 963-968`
  - `specs/031-github-copilot-review-governance/contracts/external-write-gate.schema.json`
- Independent evidence:
  - Schema-incomplete and unknown-field Inventory and ExternalWriteGate records are now rejected by the real entry with exit 2.
  - The public entry has no Authority record parameter. `ValidateExternalWriteGate` always calls `Test-HBExternalWriteGate` with `$Authority=$null`.
  - `EvidenceRoot` is unused by gate validation. Acceptance, security, review and technical evidence SHA fields are checked only as 64 lowercase hex characters; no referenced evidence is resolved or hashed.
  - A complete RulesetUpdate gate containing arbitrary `aaaa...` authority/evidence hashes passes with exit 0 against an empty EvidenceRoot and with no InventoryPath. Thus current authority identity/hash, live snapshot freshness and the final TOCTOU binding are not required by the accepted CLI shape.
- Impact: unverified authority and evidence can cross the external-write boundary. Shape closure alone does not satisfy CRG-015/016, Security-First or Zero Trust.
- Owner / reviewer: Transaction Owner and Provider Authority Owner / Security Reviewer.
- Disposition: unresolved. Bind a real current Authority record, all required evidence files/hashes, current Inventory and plan freshness in the public validator; re-read the complete tuple immediately before each write.

### IAL-004 — Critical — The exact accepted T134 command and provider-convergence transaction remain unimplementable

- Locations:
  - `scripts/manage-copilot-review-governance.ps1:119-131`
  - `scripts/modules/CopilotReviewGovernance.psm1:963-986`
  - `specs/031-github-copilot-review-governance/tasks.md:245-261`
  - `specs/031-github-copilot-review-governance/quickstart.md`
- Independent evidence:
  - With complete temporary AccountSetting plan, gate, schema-valid NotInvoked mutation-result envelope, schema-valid account rollback and EvidenceRoot, the exact T134 shape exits 1: `The property 'actions' cannot be found on this object.`
  - Cause: the entry replaces `PlanPath` with `RollbackPlanPath` whenever the latter is supplied, then validates the rollback record as a mutation plan. `ResultPath` and the five-record equality are not consumed by `ValidateExternalWriteGate`; `Test-HBAccountPreWriteRecordSet` is never called by that path.
  - The exact T150 derived-after-state shape passes locally with a manually supplied converged Inventory and emits 17 NoOps. It does not repair the preceding transaction gap: FakeProvider Apply does not materialize the corresponding account/ruleset Inventory state, so its own output cannot produce that converged after-state.
  - API version `2026-03-10`, complete 17-action converged plan and derived T150 path are individually correct.
- Impact: Phase 11 cannot satisfy its first exact gate command or derive truthful convergence from the product transaction. Implementation/task repair is required before T123 can release provider work.
- Owner / reviewer: Provider Adapter Owner, Transaction Owner and Documentation Owner / Security, Architecture/iSAQB and Operations Reviewers.
- Disposition: unresolved. Preserve PlanPath separately, consume ResultPath/RollbackPlanPath/Authority/evidence for exact five-record equality, and make Apply/Rollback update and serialize the real bounded provider Inventory model.

### IAL-005 — High — Terminal adoption implementation is materially stronger, but its accepted executable proof remains incomplete

- Locations:
  - `.specify/presets/autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1:399-560, 741-813`
  - all three maintained trees
  - `.specify/presets/autonomous-run-governance/tests/test-model-routing.ps1:126-157`
- Independent evidence:
  - Source inspection confirms exact feature-local State/Tasks/result paths, installed State validator, Completed preflight, catalog/profile identity, ancestor reparse checks, committed State/Tasks blobs, clean index/tracked worktree, local/remote refs at HEAD, ancestry and two full adoption calls with post-call State/ref/evidence comparisons.
  - All maintained copies are byte-identical.
  - The six-case harness does not independently observe every byte/hash/log/worktree invariant it claims, so zero stale parent/catch writes and complete second-tuple behavior are not fully proven under the adversarial phase contract; see IAL-001.
- Impact: the implementation inspection is favorable, but the mandatory executable gate remains incomplete and its receipts cannot support adoption.
- Owner / reviewer: Script Owner / Autonomous, Security and Cross-Platform Reviewers.
- Disposition: unresolved High until IAL-001 is repaired and independently rerun.

### IAL-006 — Medium — Readiness and cross-functional documentation still promote contradicted Local claims

- Locations:
  - `specs/031-github-copilot-review-governance/checklists/autonomous-readiness.md:19-43`
  - `specs/031-github-copilot-review-governance/checklists/security.md`
  - `specs/031-github-copilot-review-governance/checklists/architecture.md`
  - `specs/031-github-copilot-review-governance/checklists/script-parity.md`
  - `docs/security/zero-trust-applicability.md:46-53`
  - `docs/security/security-checklist.md:122-130`
  - `specs/031-github-copilot-review-governance/checklists/implementation-remediation-1.md`
- Independent evidence:
  - Primary/live/native/provider/delivery gates correctly remain Open, and the 10 ScopeContract plus 10 Supplemental records are not promoted.
  - Local readiness nevertheless marks executable positive/negative slices, all IAL repairs, security gate/TOCTOU/rollback, path/reparse publication and runner parity Fulfilled. Those assertions are contradicted by IAL-001 through IAL-004.
  - Security text says every transaction verifies authority, freshness, hash, scope and time although the exact gate path accepts nonexistent authority/evidence and omits Inventory.
- Impact: the reader path cannot support a release decision and the remediation receipt is not truthful Local evidence.
- Owner / reviewer: Feature Owner, Documentation Owner and Security Owner / Autonomous Governance and Security Reviewers.
- Disposition: unresolved. Downgrade contradicted Local claims and regenerate them only after behavioral repair.

## Cross-functional dispositions

| Area | Disposition | Evidence |
|---|---|---|
| CRG/CR/AC-CRG/SC traceability | Structurally complete; behavior Blocked | 18/10/10/12 IDs and 168 task metadata rows; IAL-001..004 prevent closure |
| Security and privacy | Blocked | arbitrary unverified authority/evidence passes; RedactionNegative is not negative; IAL-002/003 |
| Architecture and iSAQB | Blocked | FakeProvider result and Inventory state diverge; exact T134 is broken; IAL-002/004 |
| Accessibility | Local linear output passes; overall release Blocked | targeted 5/5 exits 0, but class-specific A11Y evidence is aliased; native Linux/Windows remains Open |
| Documentation Impact | Validator passes; semantic disposition Blocked | `UpdateRequired` is current, but Local readiness/security claims are false; IAL-006 |
| Script and agent parity | Source parity passes; behavioral runner proof Blocked | 3/3 bytes equal; IAL-001/005 |
| Supply chain | Local disposition retained with risk; native/delivery Open | no new package, secret scan high=0; workflow uses mutable action tags and has not produced native evidence |
| Static analysis | Pass | repository analyzer 173 files and direct changed-surface analyzer: 0 findings |
| Regression | Existing suites pass; feature behavioral regression Blocked | 40/40, 88/88, 3/3 pass; G4 label matrix is aliased |
| Live/provider/native/delivery truth | Correctly Open | no Primary command, provider call, native CI proof or delivery was executed |

## Commands and exit codes

| Command / probe | Exit | Interpretation |
|---|---:|---|
| `.specify/scripts/bash/check-prerequisites.sh --json --require-tasks --include-tasks` | 0 | Executed exactly once; feature and tasks resolved |
| direct PowerShell runner matrix | 0 | Six real isolated scenarios, but false/incomplete byte/log assertion claim |
| Bash-wrapper runner matrix | 0 | Same six real scenarios through one-process wrapper; same proof gap |
| targeted 15-class FakeProvider/security matrix | 0 | Labels pass; direct state inspection contradicts reconciliation/convergence claims |
| direct missing/unknown Inventory and Gate submissions | 2 each | Closed-world shape rejection passes |
| complete Gate with arbitrary authority/evidence hashes, empty EvidenceRoot, no InventoryPath | 0 | Unexpected acceptance; IAL-003 |
| exact accepted T134 CLI with complete temporary records | 1 | `RollbackPlanPath` substituted for mutation plan; IAL-004 |
| exact T150 derived after-state / idempotency preview | 0 / 0 | 8 targets valid; 17 NoOps, zero writes/blockers |
| direct ambiguous FakeProvider Apply inspection | 0 | `Reconciled` but journal is only `Write,Apply`; no reconciliation Read |
| direct RulesetUpdate / AccountSetting Apply inspection | 0 / 0 | Inventory remains `reviewOnPush=true` / `Enabled` |
| installed autonomous State validator | 0 | Active Implement, 122/168 |
| A11Y and script-parity selected classes | 0 | 5/5 labels; no native proof |
| repository PSScriptAnalyzer | 0 | 173 tracked files, no Error/Warning |
| direct changed PowerShell-surface analyzer | 0 | 0 findings |
| secret scan | 0 | high=0, gitleaks high=0 |
| Documentation Impact validator and fixtures | 0 | current evidence, 10/10 fixtures |
| CI-budget / Stage-B / agent-surface regressions | 0 / 0 / 0 | 40/40, 88/88, 3/3 |
| script-reference check/tests | 0 | current; fixture renderer test passes |
| `git diff --check` and cached diff check | 0 | no whitespace error |
| three-tree `cmp` matrix | 0 for every pair | runner/fixture/test/wrapper/man source parity |

All adversarial fixtures and Git commits were confined to automatically removed temporary directories. No command used a live provider or network inventory. The current repository HEAD remained `d160b4815eade6cdbf6788a63233158582611d70`, the index remained empty, State/Tasks remained 122/168 with the accepted Tasks hash, the intake series remained G4 `Primary/Eligible` with Position 7 `Blocked`, and no Home or delivery operation ran.

## Gate conclusion and next action

Passing requires zero Critical, High or unresolved Medium findings and no false evidence claim, test alias, missing negative case, task repair or implementation repair. The independent result is four unresolved Critical findings, one unresolved High finding and one unresolved Medium finding. T123 must remain open.

Exact next action: route a second separately authorized repository-local remediation for IAL-001 through IAL-006. Repair the tests, public authority/evidence contract, T134 parameter flow, FakeProvider state/reconciliation/rollback behavior and contradicted Local documentation; then rerun a fresh independent analysis. Provider, native, Primary, delivery, Home, intake-series and Position-7 gates remain closed.
