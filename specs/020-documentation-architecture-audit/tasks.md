# Tasks: Documentation Information Architecture Audit

**Input:** `specs/020-documentation-architecture-audit/`  
**Execution:** Serialized because inventory, decisions, aggregate audit,
evidence, state, statistics, and Series files are shared writers.

## Phase 1: Evidence Foundation

- [X] T001 Confirm clean Feature-020 branch and accepted commit in `autonomous-run-evidence.md`
- [X] T002 Revalidate D4 intake authoring receipt in Bash and PowerShell and record it in `autonomous-run-evidence.md`
- [X] T003 Revalidate D4 Intake Review in Bash and PowerShell and record it in `autonomous-run-evidence.md`
- [X] T004 Revalidate Series manifest and receipt in Bash and PowerShell and record 37/3/44 in `autonomous-run-evidence.md`
- [X] T005 Confirm D4 is the sole preferred `Eligible` candidate in `autonomous-run-evidence.md`
- [X] T006 Bind spec, plan, research, data-model, contract, quickstart, and gate hashes in `autonomous-run-state.json`
- [X] T007 Validate `autonomous-run-state.json` in Bash and PowerShell
- [X] T008 Create the accepted audit source skeleton in `audit-decisions.json`
- [X] T009 Create the accepted aggregate skeleton in `documentation-architecture-audit.json`
- [X] T010 Record the exact Git index and accepted-input provenance in `autonomous-run-evidence.md`

## Phase 2: Test-First Audit Contract

- [X] T011 Add minimal positive fixture coverage in `tests/test_documentation_architecture.py`
- [X] T012 Add missing-inventory-path negative coverage in `tests/test_documentation_architecture.py`
- [X] T013 Add duplicate-inventory-path negative coverage in `tests/test_documentation_architecture.py`
- [X] T014 Add stale-hash negative coverage in `tests/test_documentation_architecture.py`
- [X] T015 Add unknown-artifact-class negative coverage in `tests/test_documentation_architecture.py`
- [X] T016 Add unknown-primary-decision negative coverage in `tests/test_documentation_architecture.py`
- [X] T017 Add positive-claim-without-evidence negative coverage in `tests/test_documentation_architecture.py`
- [X] T018 Add incomplete-reader-path negative coverage in `tests/test_documentation_architecture.py`
- [X] T019 Add missing-maintenance-contract negative coverage in `tests/test_documentation_architecture.py`
- [X] T020 Add incomplete-source-runtime-class negative coverage in `tests/test_documentation_architecture.py`
- [X] T021 Add `Gap`-without-finding negative coverage in `tests/test_documentation_architecture.py`
- [X] T022 Add finding-without-owner-or-successor negative coverage in `tests/test_documentation_architecture.py`
- [X] T023 Add accepted-row-with-open-gap negative coverage in `tests/test_documentation_architecture.py`
- [X] T024 Add private-absolute-path and secret negative coverage in `tests/test_documentation_architecture.py`
- [X] T025 Add LF, CRLF, and UTF-8-BOM normalization coverage in `tests/test_documentation_architecture.py`
- [X] T026 Record the expected red baseline for T011-T025 in `autonomous-run-evidence.md`
- [X] T027 Implement the fail-closed data contract in `tools/validate_documentation_architecture.py`
- [X] T028 Prove the minimal positive and all negative fixtures green in `autonomous-run-evidence.md`

## Phase 3: User Story 1 - Complete Documentation Inventory

**Goal:** Every current Git-tracked documentation unit has one stable identity,
class, decision, audience, owner, and evidence.

**Independent test:** Rebuild from `git ls-files -z` and compare exact path and
hash cardinality.

- [X] T029 [US1] Implement NUL-safe Git inventory in `tools/collect_documentation_architecture.py`
- [X] T030 [US1] Implement strict UTF-8/BOM/line-ending normalization in `tools/collect_documentation_architecture.py`
- [X] T031 [US1] Implement deterministic documentation-surface selection in `tools/collect_documentation_architecture.py`
- [X] T032 [US1] Implement path-family classification in `tools/collect_documentation_architecture.py`
- [X] T033 [US1] Implement generated, historical, archived, agent, and intake default classifications in `tools/collect_documentation_architecture.py`
- [X] T034 [US1] Implement semantic-decision binding without guessing in `tools/collect_documentation_architecture.py`
- [X] T035 [US1] Prove the vertical reference slice in `audit-decisions.json`
- [X] T036 [US1] Generate the reference-slice inventory in `documentation-inventory.json`
- [X] T037 [US1] Validate the reference slice with `tools/validate_documentation_architecture.py`
- [X] T038 [US1] Inventory root entry and governance documents in `audit-decisions.json`
- [X] T039 [US1] Inventory `docs/` families in `audit-decisions.json`
- [X] T040 [US1] Inventory Spec Kit templates, presets, skills, commands, specs, and receipts in `audit-decisions.json`
- [X] T041 [US1] Inventory script help and manpage families in `audit-decisions.json`
- [X] T042 [US1] Inventory learner, secure-development, generated, historical, and archived families in `audit-decisions.json`
- [X] T043 [US1] Generate the full deterministic `documentation-inventory.json`
- [X] T044 [US1] Reconcile every inventory path to one decision in `documentation-architecture-audit.json`
- [X] T045 [US1] Record exact inventory and family counts in `documentation-audit-report.md`

## Phase 4: User Story 2 - Reader Paths and Source/Runtime Boundary

**Goal:** Readers can distinguish entry routes, source, Home Runtime, local
state, edit location, synchronization, and authority.

**Independent test:** Validate all four reader paths and all three
source/runtime classes with no unowned or private path.

- [X] T046 [US2] Assess the learner and newcomer path in `documentation-architecture-audit.json`
- [X] T047 [US2] Assess the daily-user path in `documentation-architecture-audit.json`
- [X] T048 [US2] Assess the maintainer and AI-agent path in `documentation-architecture-audit.json`
- [X] T049 [US2] Assess the audit and troubleshooting path in `documentation-architecture-audit.json`
- [X] T050 [US2] Assess progressive disclosure and entry-page depth in `documentation-architecture-audit.json`
- [X] T051 [US2] Assess README target architecture without moving files in `documentation-architecture-audit.json`
- [X] T052 [US2] Assess topic-split and language-split criteria in `documentation-architecture-audit.json`
- [X] T053 [US2] Resolve current `homeRuntime` paths from `scripts/config/home-sync-manifest.json` into `documentation-architecture-audit.json`
- [X] T054 [US2] Resolve current `sourceOnly` paths from `scripts/config/home-sync-manifest.json` into `documentation-architecture-audit.json`
- [X] T055 [US2] Model safe logical `machineLocal` records without private paths in `documentation-architecture-audit.json`
- [X] T056 [US2] Record canonical edit location and sync need for every source/runtime record in `documentation-architecture-audit.json`
- [X] T057 [US2] Record commit, push, force, host, and container boundaries in `documentation-architecture-audit.json`
- [X] T058 [US2] Record Home Runtime purpose, benefits, and non-goals in `documentation-architecture-audit.json`
- [X] T059 [US2] Validate all reader-path and source/runtime invariants
- [X] T060 [US2] Summarize reader and source/runtime results in `documentation-audit-report.md`

## Phase 5: User Story 3 - Delivered Maintenance Contract Consistency

**Goal:** Active documentation consistently represents Features 015 through
019 and their proof boundaries.

**Independent test:** Validate every required contract row and every active
surface reference with no accepted open `Gap`.

- [X] T061 [US3] Bind Feature-015 Windows preview, result, and resume contracts in `documentation-architecture-audit.json`
- [X] T062 [US3] Bind Feature-016 Linux input, aggregation, platform, and exact-head contracts in `documentation-architecture-audit.json`
- [X] T063 [US3] Bind Feature-017 remote-freshness, pull, network, lease, cleanup, and dynamic-profile contracts in `documentation-architecture-audit.json`
- [X] T064 [US3] Bind Feature-018 Enhanced, Plain, Headless, DryRun, confirmation, fallback, and interruption contracts in `documentation-architecture-audit.json`
- [X] T065 [US3] Bind Feature-019 JSONL continuity, prebound report, early finalization, reconciliation, and Bash-3.2 delegation contracts in `documentation-architecture-audit.json`
- [X] T066 [US3] Review root README evidence for every maintenance contract in `documentation-architecture-audit.json`
- [X] T067 [US3] Review manpage evidence for every maintenance contract in `documentation-architecture-audit.json`
- [X] T068 [US3] Review architecture and ADR evidence for every maintenance contract in `documentation-architecture-audit.json`
- [X] T069 [US3] Review A11Y and security evidence for every maintenance contract in `documentation-architecture-audit.json`
- [X] T070 [US3] Review script-reference and Feature-contract evidence in `documentation-architecture-audit.json`
- [X] T071 [US3] Distinguish user contract from implementation-only detail in `documentation-architecture-audit.json`
- [X] T072 [US3] Validate all maintenance-contract dimensions and finding references
- [X] T073 [US3] Confirm Feature-015-to-019 historical evidence remains unchanged
- [X] T074 [US3] Summarize maintenance consistency and proof limits in `documentation-audit-report.md`

## Phase 6: User Story 4 - Findings and Bounded Successors

**Goal:** Only reproducible gaps become findings, each with one owner and
successor; speculative or empty work is not created.

**Independent test:** Validate every `DIA###` row and successor cardinality.

- [X] T075 [US4] Deduplicate all candidate discrepancies in `documentation-architecture-audit.json`
- [X] T076 [US4] Assign stable `DIA###` IDs only to reproducible gaps in `documentation-architecture-audit.json`
- [X] T077 [US4] Record severity, evidence, owner, residual risk, and trigger for every finding
- [X] T078 [US4] Route information-architecture remediation exclusively to D5
- [X] T079 [US4] Route operational-efficiency guidance exclusively to D6
- [X] T080 [US4] Route fleet adoption exclusively to D7
- [X] T081 [US4] Record justified `NonRemediation` outcomes
- [X] T082 [US4] Validate no finding has a missing or duplicate successor
- [X] T083 [US4] Decide whether D5 has a non-empty accepted remediation set
- [X] T084 [US4] Record the successor decision without starting D5 in `documentation-audit-report.md`

## Phase 7: Governance and Local Validation

- [X] T085 Complete every checkpoint and result in `checklists/audit-governance.md`
- [X] T086 Record NIST SSDF and CWE Top 25 evidence in `documentation-architecture-audit.json`
- [X] T087 Record ASVS, supply-chain, AI-SBOM, and regulatory `N/A` decisions with triggers
- [X] T088 Record architecture, iSAQB, STRIDE/CIA/CAPEC, Zero Trust, SAMM, BSI C3A/C5 `N/A` decisions with triggers
- [X] T089 Record A11Y, learner, text-first, language, and CEFR-B2 review evidence
- [X] T090 Record cross-platform audit-proof and product-script `N/A` boundaries
- [X] T091 Record all maintained agent surfaces as reviewed and unchanged or as findings
- [X] T092 Record `.specify/templates/` as reviewed and unchanged or as a finding
- [X] T093 Add `scripts/tests/test_feature_020_documentation_architecture.py` as a test-only provider-discovery bridge and run the full Feature-020 `unittest` suite
- [X] T094 Rebuild `documentation-inventory.json` and prove deterministic equality
- [X] T095 Validate the accepted aggregate with `tools/validate_documentation_architecture.py`
- [X] T096 Run D4 Authoring, Review, Series, and autonomous-state validators in Bash and PowerShell
- [X] T097 Run `git diff --check` and `specify check`
- [ ] T098 Run Homogeneity and local Markdown link checks
- [X] T099 Run PSScriptAnalyzer and secret scan
- [X] T100 Confirm DocFX/browser A11Y remains untriggered or run it if scope changed
- [X] T101 Confirm no active documentation, runtime, script, workflow, preset, dependency, package, or fleet path changed
- [X] T102 Reconcile task, evidence, audit, and accepted-artifact hashes in `autonomous-run-state.json`

## Phase 8: Statistics and MergeAndSync Delivery

- [X] T103 Commit the stable feature candidate before statistics rendering
- [X] T104 Add the Feature-020 source-ledger entry to `docs/project-statistics.md`
- [X] T105 Add the Feature-020 phase input to `docs/project-statistics.config.json`
- [ ] T106 Commit the statistics source inputs
- [ ] T107 Render and verify the deterministic statistics block in `docs/project-statistics.md`
- [ ] T108 Commit the generated statistics block without other file changes
- [ ] T109 Validate and stage only the intended exact feature candidate
- [ ] T110 Push `020-documentation-architecture-audit` and create one non-empty PR
- [ ] T111 Converge all mandatory provider checks on the exact head
- [ ] T112 Inspect Copilot, Claude, and GraphQL review state and resolve every actionable thread
- [ ] T113 Re-run affected gates after every review correction
- [ ] T114 Generate temporary exact-head gate evidence for every Applicable gate
- [ ] T115 Validate temporary gate evidence in Bash and PowerShell
- [ ] T116 Confirm all technical gates green and zero actionable review threads
- [ ] T117 Use narrow Admin Bypass only if Human Approval is the sole remaining rule
- [ ] T118 Merge with a merge commit and delete the remote feature branch
- [ ] T119 Switch to `main`, fetch/prune, fast-forward pull, and prove clean `(0 0)`
- [ ] T120 Confirm no D5, D6, or D7 run was started by Feature 020

## Phase 9: Causal Closeout and Retrospective

- [ ] T121 Create a non-empty Feature-020 closeout branch only because merge facts cannot exist on the reviewed head
- [ ] T122 Archive the D4 intake through the repository archive workflow
- [ ] T123 Remove D4 from the active Series and preserve exact history and receipt lineage
- [ ] T124 Bind actual PR, reviewed head, merge commit, and audit cardinalities into successor evidence
- [ ] T125 Update D5 only when T083 proved a non-empty D5-owned finding set; otherwise record it as not eligible
- [ ] T126 Re-review affected successor and Series evidence in Bash and PowerShell
- [ ] T127 Complete `retrospective.md` with `NoPromotion` unless a provider-neutral preset defect is reproduced
- [ ] T128 Finalize all 130 tasks and `autonomous-run-state.json` as `Retrospective` and `Completed`
- [ ] T129 Deliver and merge the non-empty closeout PR under the same exact-head rules
- [ ] T130 Prove final local `main == origin/main`, clean worktree, current Series, and exact next eligible candidate

## Dependencies and Coverage

- T001-T010 block all audit implementation.
- T011-T028 establish the test-first contract.
- T029-T045 cover US1, DIA-001 through DIA-018, and AC-DIA-001 through AC-DIA-012.
- T046-T060 cover US2, DIA-024 through DIA-030, and AC-DIA-018 through AC-DIA-022.
- T061-T074 cover US3, DIA-019 through DIA-023, and AC-DIA-013 through AC-DIA-017.
- T075-T084 cover US4, DIA-031, bounded handoffs, and conditional D5.
- T085-T102 cover governance and complete local validation.
- T103-T120 cover MergeAndSync delivery.
- T121-T130 cover causal archival, Series advancement, retrospective, and final synchronization.

No task is marked parallel because the slices share accepted ledgers, audit
output, run state, statistics, or Series evidence.
