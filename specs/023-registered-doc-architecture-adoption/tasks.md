# Tasks: Registered Documentation Architecture Adoption

**Input**: Accepted Feature-023 specification and planning artifacts
**Scope**: D7 documentation adoption and evidence only
**Execution**: Sequential because all target reviews write the shared matrix

## Phase 1: Preflight And Accepted Artifacts

- [X] T001 Prove clean synchronized Level-0 `main` after Feature 022 closeout.
- [X] T002 Validate D7 authoring, individual review and active Series evidence with Bash.
- [X] T003 Validate D7 authoring, individual review and active Series evidence with PowerShell.
- [X] T004 Complete the full check-only Remote Freshness fetch inventory and record Run ID/result boundaries in `pr-evidence.md`.
- [X] T005 Create branch `023-registered-doc-architecture-adoption` and align `.specify/feature.json`.
- [X] T006 Complete `spec.md` with DFA/AC traceability and hard scope boundaries.
- [X] T007 Complete focused clarification pass 1 with no material planning ambiguity.
- [X] T008 Complete clarification pass 2 against live preflight findings.
- [X] T009 Complete `checklists/requirements.md`.
- [X] T010 Complete `checklists/fleet-adoption-contract.md`.
- [X] T011 Complete `research.md` with fleet, decision and delivery choices.
- [X] T012 Complete `data-model.md` with matrix invariants.
- [X] T013 Complete `contracts/fleet-adoption-acceptance.md`.
- [X] T014 Complete `quickstart.md` with local and target validation paths.
- [X] T015 Complete `plan.md` with governance and standards applicability.
- [X] T016 Complete plan-review pass 1 in `checklists/plan-review.md`.
- [X] T017 Complete plan-review pass 2 with no remaining remediation.
- [X] T018 Create reviewed `autonomous-run-gate-requirements.json`.
- [X] T019 Create `pr-evidence.md` and valid schema-1.1 `autonomous-run-state.json` before implementation edits.

## Phase 2: One Inventory Decision Per Manifest Target

- [X] T020 Inventory `c64-projects` and draft its 17-claim assessments in the shared matrix.
- [X] T021 Inventory `cc65`, preserve its non-MSL/upstream boundaries, and draft its assessments.
- [X] T022 Inventory `datagrip-projects` and draft its assessments.
- [X] T023 Inventory `inventar-db` and draft its assessments.
- [X] T024 Inventory `rider-projects` and draft its assessments.
- [X] T025 Record `agent-operations-cockpit` as blocked or revalidated without touching user-owned changes.
- [X] T026 Inventory `inventar-worker-service` and draft its assessments.
- [X] T027 Inventory `tiny-calc` and draft its assessments.
- [X] T028 Inventory `tiny-pl0` and draft its assessments.
- [X] T029 Inventory `tui-vision` and preserve its C#/DocFX-specific contracts.
- [X] T030 Inventory `secure-orderdesk-projects` and preserve learning-series ownership.
- [X] T031 Inventory `secure-orderdesk-csharp` and draft its assessments.
- [X] T032 Inventory `secure-orderdesk-go` and draft its assessments.
- [X] T033 Inventory `secure-orderdesk-java` and draft its assessments.
- [X] T034 Inventory `secure-orderdesk-python` and draft its assessments.
- [X] T035 Inventory `secure-orderdesk-rust` and draft its assessments.
- [X] T036 Inventory `secure-orderdesk-swift` and draft its assessments.
- [X] T037 Inventory `secure-service-harvester-projects` and preserve learning-series ownership.
- [X] T038 Inventory `secure-service-harvester-csharp` and draft its assessments.
- [X] T039 Inventory `secure-service-harvester-go` and draft its assessments.
- [X] T040 Inventory `secure-service-harvester-java` and draft its assessments.
- [X] T041 Inventory `secure-service-harvester-python` and draft its assessments.
- [X] T042 Inventory `secure-service-harvester-rust` and draft its assessments.
- [X] T043 Inventory `secure-service-harvester-swift` and draft its assessments.
- [X] T044 Inventory `container-images` and preserve container collection ownership.
- [X] T045 Inventory `absdd-image-sandbox` and preserve sandbox/secure-development boundaries.
- [X] T046 Inventory `secure-casetracker-baseline` and preserve learning-series ownership.
- [X] T047 Inventory `secure-casetracker-csharp` and draft its assessments.
- [X] T048 Inventory `secure-casetracker-go` and draft its assessments.
- [X] T049 Inventory `secure-casetracker-java` and draft its assessments.
- [X] T050 Inventory `secure-casetracker-python` and draft its assessments.
- [X] T051 Inventory `secure-casetracker-rust` and draft its assessments.
- [X] T052 Inventory `secure-casetracker-swift` and draft its assessments.
- [X] T053 Inventory collection target `spec-kit-preset-projects` without Git mutation.
- [X] T054 Inventory `preset-security` and preserve public preset packaging boundaries.
- [X] T055 Inventory `preset-architecture` and draft its assessments.
- [X] T056 Inventory `preset-isaqb` and draft its assessments.
- [X] T057 Inventory `preset-a11y` and draft its assessments.
- [X] T058 Inventory `preset-cross-platform` and draft its assessments.
- [X] T059 Inventory `preset-agent-parity` and draft its assessments.
- [X] T060 Inventory `preset-intake-authoring` and draft its assessments.
- [X] T061 Inventory `preset-intake-review` and draft its assessments.
- [X] T062 Inventory `preset-intake-sequencing` and draft its assessments.
- [X] T063 Inventory `preset-autonomous` and draft its assessments.
- [X] T064 Inventory `preset-parallel-autonomous` and draft its assessments.

## Phase 3: Test-First Matrix Proof

- [X] T065 Add positive and negative fleet-matrix fixtures in `tests/test_fleet_adoption.py` before implementing the validator.
- [X] T066 Run the fixture suite and record the expected failing implementation boundary.
- [X] T067 Implement `tools/validate_fleet_adoption.py` using only the Python standard library.
- [X] T068 Prove one vertical `AlreadyAligned` target slice and all negative rejection classes.
- [X] T069 Assemble `fleet-adoption-matrix.json` for all current targets from the completed inventories.
- [X] T070 Complete exactly 17 claim assessments for every non-blocked Git target.
- [X] T071 Assign exactly one final target decision and rationale to every target.
- [X] T072 Complete repository-specific Documentation Impact records and follow-up fields.
- [X] T073 Run the production validator and fixture suite against the full matrix.
- [X] T074 Reconcile matrix cardinalities, decision totals and blocked boundaries in `pr-evidence.md`.

## Phase 4: Conditional Target Adoption And Delivery

- [X] T075 Identify the exact non-empty changed-target set; record zero-change evidence if empty.
- [X] T076 Apply only approved portable documentation changes serially in eligible target repositories.
- [X] T077 Run each changed target's native documentation, A11Y, security, homogeneity and agent-parity gates.
- [X] T078 Revalidate staged paths and exact target heads before commit and push.
- [X] T079 Commit, push and create one non-empty PR per changed target under current authority.
- [X] T080 Converge provider checks, Copilot/reviewer results and actionable threads per target.
- [X] T081 Validate exact-head gate evidence and merge each eligible target under repository policy.
- [X] T082 Return every changed target to a clean synchronized default branch.
- [X] T083 Prove that aligned, inapplicable and blocked targets received no feature-created PR.
- [X] T084 Revalidate blocked targets remained byte-for-byte untouched by Feature 023.

## Phase 5: Governance And Cross-Cutting Validation

- [X] T085 Complete learner, language, CEFR B2, terminology, text-first and WCAG review.
- [X] T086 Complete shared agent-surface parity review for Level 0 and changed targets.
- [X] T087 Record all eleven preset applicability decisions and versions.
- [X] T088 Record NIST SSDF/CWE and all trigger-based security/supply-chain/regulatory decisions.
- [X] T089 Record architecture, iSAQB, STRIDE/CAPEC, Zero Trust, SAMM, BSI C3A/C5 decisions.
- [X] T090 Prove the technical propagation target set hash is unchanged.
- [X] T091 Prove the final changed-path set contains no product, runtime, workflow, package, dependency or toolchain changes.
- [X] T092 Re-run the full matrix test and validator after all conditional target work.
- [X] T093 Update run state to `Validate` with synchronized task and accepted-artifact hashes.

## Phase 6: Level-0 Validation

- [X] T094 Run `git diff --check` and staged inventory reconciliation.
- [X] T095 Run local Markdown link and language-partner validation.
- [X] T096 Run learning-package and generated secure-development-document checks.
- [X] T097 Run PSScriptAnalyzer discovery and repository PowerShell quality gates.
- [X] T098 Run the Level-0 secret scan and confirm no private paths or logs are tracked.
- [X] T099 Run Homogeneity and Documentation Impact validators.
- [X] T100 Run `specify check` and Spec-Kit artifact integrity checks.
- [X] T101 Render and verify `docs/project-statistics.md` from its canonical configuration.
- [X] T102 Re-run matrix, scope and whitespace validation after statistics rendering.

## Phase 7: Feature Delivery

- [X] T103 Stage only intended Feature-023 and generated statistics paths and validate the exact candidate.
- [X] T104 Commit Feature 023 on the numbered branch.
- [X] T105 Push the feature branch and create a non-empty PR from `pr-evidence.md`.
- [X] T106 Converge all provider checks and classify duplicate workflow noise without cancellation.
- [X] T107 Obtain exact-head Copilot/reviewer evidence and resolve every actionable thread.
- [X] T108 Generate temporary provider-neutral exact-head gate evidence and validate it in Bash and PowerShell.
- [X] T109 Merge the feature PR, using the narrow admin bypass only for the sole remaining Human Approval gate.
- [X] T110 Switch to `main`, fetch/prune, fast-forward pull and prove clean `HEAD == origin/main`.

## Phase 8: Causal Closeout And Retrospective

- [ ] T111 Archive D7, update the active Series and create a non-empty evidence-only closeout PR only if post-merge facts require it.
- [ ] T112 Complete retrospective, terminal schema-1.1 state, final fleet/Series validation and confirm that no successor intake starts.

## Dependencies

- T001-T019 precede every implementation task.
- T020-T064 complete before T069 and before any target mutation.
- T065-T068 establish test-first proof before the full matrix is accepted.
- T069-T075 precede conditional target changes.
- T076-T084 are conditional but must record an explicit zero-change outcome when no target is adopted.
- T085-T102 precede the Feature-023 delivery candidate.
- T103-T110 are serialized remote delivery.
- T111-T112 run only after the feature merge and default-branch synchronization.

No task is parallel-marked because the shared matrix, evidence, target delivery
ledger, statistics, run state and Series closeout each have one writer.
