# Specification Analysis Report: Resume Revalidation 2026-09-08

**Phase:** `analyze`  
**Feature:** `specs/032-linked-intake-evidence`  
**Result:** `Blocked`  
**Scope:** Bounded semantic revalidation only; no implementation, provider
action, Git write, Home sync, task-checkbox change, or run-state mutation.  
**Freshness:** This report supersedes the historical Analyze decision only as a
new review payload. It does not edit or replace `checklists/analysis.md`.

## Findings

| ID | Category | Severity | Location(s) | Summary | Minimal remedy |
|---|---|---:|---|---|---|
| C1 | Constitution alignment | CRITICAL | `.specify/memory/constitution.md:1035`, `.specify/memory/constitution.md:1110-1116`, `.specify/memory/constitution.md:1126`; `constitution.md` matching lines; `scripts/config/spec-kit-governance-presets.json:48-52` | Both constitution copies declare `autonomous-run-governance` v0.3.4 while the executable central eight-preset matrix, installed preset, source index, and current shared guidance declare v0.4.1. The constitution says it MUST mirror the central matrix, so the accepted plan cannot claim a current constitution pass. | Under separate constitution/preset-maintenance authority, synchronize both constitution copies and every mandatory mirrored guidance/template surface to the already canonical v0.4.1 matrix; then re-run only the affected readiness and Analyze checks. Do not alter Feature 032 scope. |
| I1 | Execution-order inconsistency | HIGH | `tasks.md:163-166`, `181-183`, `195-197`, `209-211`, `226-228`, `240-242`, `259-261`; `plan.md:188-191`, `389-403`; `contracts/fleet-evidence-and-delivery.md:70-96` | Every Linux/Windows task calls its result `exact-head` evidence before the repository's feature candidate is committed. A commit SHA at that point identifies the pre-change head, not the uncommitted candidate being tested. The later commit therefore makes the native proof stale by construction. | Preserve task IDs and repository order, but move each candidate freeze/commit before its native proof: candidate task depends on local gates, native proof depends on the frozen commit, and push/review depends on the proof. Any candidate change invalidates and repeats the native proof. |
| I2 | Serial branch identity drift | HIGH | `plan.md:323-337`; `contracts/fleet-evidence-and-delivery.md:5-18`; `tasks.md:33`, `174-182`, `189-196`, `203-210` | The planned identities now collide with locally present feature identities: AOC `003` already names `003-authoring-contract`; TinyPl0 `006` already names `006-embeddable-vm-nuget`; TinyCalc `004` and `005` already exist. Subsequent tasks still hard-code the stale names, so T007 alone cannot make later instructions executable. Local inspection suggests next numbers `004`, `007`, and `006`, respectively, but this is not remote freshness proof. | Let parent-owned fresh local/remote inspection complete T007, then minimally update the plan table, fleet contract, and all corresponding branch tokens in tasks before any target write. Retain Home `032`, Inventar `003`, TuiVision `047`, and sandbox `004` only if the same fresh check confirms them. |
| G1 | Mandatory preset delta | MEDIUM | `spec.md:245`; `plan.md:197-204`; `tasks.md:31`; `.specify/presets/secure-development-assurance-governance/preset.yml:4-9`; `specs/spec-kit-presets/README.md:20-45` | `specify preset list` currently reports 13 enabled presets, including the preserved Assurance v0.1.2 installation at priority 15, while Feature 032 explicitly dispositions only the standard eight plus the managed twelve-profile additions. T005 says “active twelve” and does not explicitly classify the installed thirteenth preset. Current source pin v0.1.3 does not silently upgrade the preserved v0.1.2 installation. | Extend only T005's inventory/disposition evidence to name Assurance v0.1.2 and decide `Applicable`, justified `N/A`, or blocking `Open`. For this renderer feature, `N/A` is supportable if no formal `docs/security/secure-development/<context>` baseline/delta/closure/image-impact record changes; retain the human-decision boundary and re-evaluate if that scope changes. Do not install or upgrade a preset in this phase. |

No duplication, unresolved placeholder, missing mandatory identifier, guessed
feature proof, or unmapped task was found beyond the issues above.

## Coverage Summary

| Requirement key | Has task? | Task IDs / families | Notes |
|---|---:|---|---|
| `LAF-001`–`LAF-035` | Yes | T013–T168 | 35/35 identifiers are covered. |
| `CR-001`–`CR-014` | Yes | T003–T168 | 14/14 identifiers are covered; C1 prevents a current constitution pass. |
| `SC-001`–`SC-010` | Yes | T153–T168 | 10/10 buildable success criteria are covered. |
| `AC-LAF-001`–`AC-LAF-014` | Yes | T013–T168 | 14/14 gate identifiers are covered. |
| `CHK001`–`CHK044` | Yes | T024–T025, T153–T157 | 44/44 checklist identifiers remain traced; unchecked boxes still denote future implementation evidence. |

Mandatory requirement and gate coverage remains `73/73` (100%). Coverage does
not cure contradictory execution order or stale branch identity.

## Constitution Alignment Issues

- C1 is a direct conflict with the constitution's own central-matrix mirror
  requirement and is therefore Critical under `/speckit.analyze` severity
  rules.
- The current Project Environment Registry rows still cover all six Level-2
  targets, and the accepted MSL, secure-coding, A11Y, documentation-impact,
  statistics, and serial-delivery requirements remain semantically covered.
- Current governance requires a minimal mandatory-rule delta reconciliation
  after preset drift. G1 is the only additional installed-preset applicability
  gap found for this feature; no automatic rollout or source upgrade is implied.

## Current Preset and Source Inventory

- `specify preset list` reports 13 enabled presets: the standard eight, Model
  Routing, Intake Authoring, Intake Review, Intake Sequencing, and Secure
  Development Assurance v0.1.2.
- `bash scripts/install-spec-kit-governance-presets.sh --check-only` recognizes
  the central eight and reports the five additional installed IDs; this is an
  inventory fact, not permission to remove or update them.
- The retired duplicate scaffold locations under `specs/spec-kit-presets/` and
  `specs/spec-kit-preset-repos/` now contain source indexes only. Historical
  references remain audit evidence. The 13 standalone published repositories
  are the product sources; `.specify/presets/` is the installed project copy.
- The source lock and optional thirteen-preset profile now pin Assurance
  v0.1.3. Source cleanup explicitly preserves existing installations, so the
  local v0.1.2 copy is neither silently invalid nor silently upgradeable.
- The relevant installed v0.1.2 delta requires scalar, nonblank
  `acceptedRisks.id` values and preserves all human authorization boundaries.
  Feature 032 has no accepted-risk claim and may not infer one.

## Run-State and Historical Analyze Audit

| Check | Result | Evidence |
|---|---:|---|
| Accepted artifacts | `8/8 MATCH` | Every current raw SHA-256 equals the run-state binding. |
| Tasks binding | `MATCH` | Current `tasks.md` SHA-256 is `95cfca00a6b4db21b88392d6158d2a682fb41dcea5d42a57f7b56491101bdf09`. |
| Run-state validator | `PASS` | Run `c53e4b5b-74fa-4ff9-ac5e-ce51850a5321`, stage `Analyze`, status `Active`, tasks `3/169`. |
| Task inventory | `PASS` | 169 unique contiguous IDs, T001–T169; exactly three existing checkboxes remain checked. |
| Historical Analyze result bytes | `MATCH` | Result SHA-256 remains `d912027ae00b3b4bb39452a9a70198085466b87b9472061ea91e01a87ff36f7e`. |
| Historical Analyze payload | `STALE` | Recorded payload SHA-256 `06befba5...` differs from current `checklists/analysis.md` SHA-256 `01de0e98...`; the installed phase-result validator exits 3 with `AEI107`. |

The old Analyze decision is not reused. This fresh report does not mark T001 or
any later implementation task again and does not edit the parent-owned state.

## Sandbox Terminal and Feasibility Boundary

- `absdd-image-sandbox` is locally clean on `main` at
  `d3731df24649cf189e3d97412c9285d3170c082a`, equal to cached `origin/main`.
- Feature 003's run state is terminal `Completed`, tasks `85/85`, with all four
  closeout fields complete. Its preserved checkpoint
  `d1c713246c4e5306d41d39bec82a13ef9cfbcaa8` is an ancestor of current `main`.
- The time-bounded single-person feasibility decision records learner testing
  as `NotPerformed`; `GATE-LEARNER-01` is `N/A` only for that source-only study
  through 2026-12-31. Forty-nine Human-only gaps and pilot, project, and general
  release decisions remain separate. None is reported here as performed or
  approved.
- This condition permits Feature 032 to treat Feature 003 as terminal for its
  later read-only base gate. It does not waive T139/T140 fresh remote/default
  checks, authorize image/runtime changes, or supply learner proof.

## Unmapped Tasks

None. All 169 tasks map to a requirement, story, governance gate, evidence
lifecycle step, or bounded delivery/closeout obligation.

## Metrics

- Functional and constitution-derived requirements plus buildable success
  criteria: 59
- Acceptance gates: 14
- Mandatory requirement/gate identifiers: 73
- Covered mandatory identifiers: 73 (100%)
- Tasks: 169
- Unmapped tasks: 0
- Critical findings: 1
- High findings: 2
- Medium findings: 1 (unaccepted)
- Low findings: 0
- Ambiguity findings: 0
- Duplication findings: 0

## Gate Decision and Next Actions

`Blocked`. Analyze cannot report `Completed` while C1, I1, I2, and G1 remain.
The minimum convergence path is:

1. correct the constitution mirror drift under separate current authority;
2. freeze/commit each repository candidate before its exact-head native proof;
3. refresh and replace only the colliding branch identities after parent-owned
   remote queries;
4. explicitly disposition the preserved Assurance v0.1.2 installation in
   T005 evidence without installing or upgrading it; and
5. rerun the affected readiness checks and `/speckit.analyze`.

No implementation, provider action, Git write, Home sync, other-repository
mutation, task-checkbox update, or autonomous run-state edit is authorized by
this report.

## Documentation Impact

`UpdateRequired`: this allowed feature-local review report is the canonical
payload for the resumed Analyze attempt. Owner: Feature 032 Analyze Reviewer.
Audience: parent orchestrator, feature owner, and later implementer. Reader
path: resume audit → this report → exact finding locations. Document class:
active semantic evidence; German context with English technical report. It is
`sourceOnly`, requires no Home sync, and must be re-evaluated after any listed
remedy, preset/constitution drift, branch-identity refresh, or sandbox-base
change.
