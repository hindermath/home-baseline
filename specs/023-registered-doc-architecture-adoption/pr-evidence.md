# PR Evidence: Feature 023 Registered Documentation Architecture Adoption

## Run Identity

| Field | Value |
|---|---|
| Run ID | `6c1dce79-aaa0-4011-a752-b5899faa5426` |
| Feature | `023-registered-doc-architecture-adoption` |
| Delivery authority | `MergeAndSync` |
| Binding intake | `Lastenheft_Registrierte-Level-1-2-Dokumentationsarchitektur-Adoption.md` |
| Initial Level-0 head | `ee46c47728dc5263a37b0889b8bb41e723b274bf` |

## Scope Contract

- Documentation architecture and evidence only.
- No product, API, runtime, dependency, package, workflow, toolchain or
  deployment change.
- No technical propagation-target expansion or automatic drift repair.
- No target branch or PR without an evidence-backed non-empty change.
- No successor intake starts automatically.

## Accepted Governance Evidence

| Evidence | Result |
|---|---|
| D7 authoring receipt | PASS in Bash and PowerShell; `ReadyForReview` |
| D7 individual review | PASS in Bash and PowerShell; `Ready` |
| Active Series review | PASS in Bash and PowerShell; `Ready` |
| Series manifest and receipt | PASS in Bash and PowerShell; 34 targets, 3 roots, 40 dependencies |
| Preferred candidate | D7 only |
| Feature-022 predecessor | PR #199, reviewed head `746a1afe18ee1ee9716907c94222915ed9003865`, merge `b018ef78233260659c596b29d4ffb8f018afd61c` |

## Remote Freshness Preflight

| Field | Result |
|---|---|
| Command | `bash scripts/maintain-agentic-workspace.sh --check-only` |
| Run ID | `6616ea06-725a-4211-b458-b5a7d1030a87` |
| Inventory | Level 0 plus 44 active Level-1/2 Git targets and 1 collection target |
| Fetch barrier | Completed for the full declared Git inventory before target content mutation |
| Current targets | 44 of 45 Git repositories including Level 0 |
| Blocked target | `agent-operations-cockpit`: non-default branch and local managed-file change |
| Collection | Inventoried separately; no Git mutation |
| Operational result | Exit 2 at propagation after complete fetch inventory |
| Propagation boundary | 32 repositories show 864 actionable maintenance-package differences; executable drift is outside Feature 023 and remains unchanged |
| Home Runtime observation | One source-updated README is local runtime drift; D7 grants no Home-sync mutation |

The report and log remain machine-local. Publishable evidence records only the
run identity, result classes and repository IDs.

## Phase Evidence

| Phase | Result | Boundary |
|---|---|---|
| Specify | Complete | DFA-001..DFA-028 and AC-DFA-001..AC-DFA-018 mapped |
| Clarify pass 1 | Converged | No planning-critical ambiguity |
| Clarify pass 2 | Converged | Live preflight findings fit accepted blocked/out-of-scope decisions |
| Requirements checklist | 24/24 | Pass |
| Fleet contract checklist | 33/33 | Pass |
| Plan | Complete | Central evidence, repository-owned changes, serial delivery |
| Plan review pass 1 | 24/24 | Pass |
| Plan review pass 2 | Converged | No new remediation |
| Tasks | Complete | 112 unique dependency-ordered tasks; 45 target-specific inventory tasks |
| Analyze pass 1 | Converged | 28 DFA and 18 AC-DFA requirements mapped; no Critical/High or unowned Medium finding |
| Analyze pass 2 | Converged | 112 unique task definitions, 45 active-target tasks, 17 source claims and zero incomplete checklists |
| Implement | Complete | 45-target matrix and validator pass; 32 approved target adoptions merged and synchronized after the TinyCalc reference slice |

## Documentation Impact

| Surface | Decision | Owner | Distribution | Home sync | Evidence | Re-evaluation trigger |
|---|---|---|---|---:|---|---|
| Feature-023 fleet evidence | `UpdateRequired` | Level-0 Documentation Maintainer | `sourceOnly` | No | matrix, validator, tests and PR evidence | manifest or D6 claim changes |
| Target repositories | `UpdateRequired` for 32, `FollowUp` for 1 blocked target, `NoUpdateRequired` for 12 inapplicable targets | Repository Maintainer | `sourceOnly` | No | matrix, local gates and target PRs | target documentation architecture changes |
| Shared agent guidance | `NoUpdateRequired` | Level-0 Agent Governance | existing contract | No | maintained surfaces remain semantically aligned | normative agent rule changes |
| Project statistics | `GeneratedUpdate` after completion | Level-0 Statistics Maintainer | `sourceOnly` | No | renderer | completed feature delivery |

## Governance And Standards

| Checkpoint | Applicability | Rationale | Re-evaluation trigger |
|---|---|---|---|
| NIST SSDF / CWE Top 25 | Applicable | Secure process, path and test-tool review | executable or security scope changes |
| A11Y / WCAG 2.2 AA | Applicable | Learner- and user-facing documentation may change | no user-facing target change remains |
| Cross-platform / Agent parity | Applicable | Target-native validation and maintained agent surfaces | target contracts change |
| ASVS / STRIDE / CAPEC / Zero Trust | `N/A` | No web/API/auth or trust-boundary change | such a surface enters scope |
| SBOM / VEX / SLSA / OpenSSF / AI-SBOM | `N/A` | No dependency, release artifact or AI runtime | supply-chain or AI runtime scope changes |
| S-ADR / arc42 / SAMM / BSI C3A / BSI C5 | `N/A` | No product architecture, cloud or provider change | architecture or provider scope changes |
| NIS2 / CRA / EU AI Act / DORA | `N/A` | No regulated runtime or product change | regulated product scope changes |
| Parallel autonomous execution | `N/A` | Shared writers and target deliveries are serialized | ownership becomes fully independent |

## Target Decision Summary

| Decision | Count | Boundary |
|---|---:|---|
| `Adopted` | 32 | Portable governance and target-local Documentation Impact evidence |
| `Blocked` | 1 | `agent-operations-cockpit`; user-owned dirty non-default worktree remains untouched |
| `NotApplicable` | 12 | 11 standalone preset repositories and 1 non-Git collection target |
| `AlreadyAligned` | 0 | No canonical repository already contained the complete portable D6 contract |

TinyCalc PR #46 supplied the first merged vertical proof. TinyCalc PR #47 then
carried the causal documentation-only follow-up discovered by later fleet
reviews. Together with the other 31 final target PRs, all 32 adopted target
heads are merged and their local default branches are clean and synchronized.

The final exact-head provider split is six fully green target runs and 26
GitHub payment or spending-limit rejections before the first job step. Copilot
returned six substantive exact-head reviews and 26 exact-head unavailability
messages for the same provider boundary. Unavailable reviews remain missing,
not approvals. All 32 PRs had zero actionable threads, all local target gates
passed, and the explicitly authorized narrow admin bypass was used only within
that recorded boundary.

## Validation Log

| Command or review | Scope | Result | Proof boundary |
|---|---|---|---|
| Intake and Series validators, Bash and PowerShell | D7 and active Series | PASS | Accepted governance identity |
| `specify check` | Tool availability | PASS | CLI readiness only |
| `git diff --check` | Planning artifacts | PASS | Whitespace only |
| Documentation Impact validator and fixtures, Bash and PowerShell | 32 changed targets | PASS | Target-local evidence contract |
| Statistics renderer/check and Homogeneity dry run | 32 changed targets | PASS | Deterministic generated ledger and repository guidance |
| TinyCalc PR #46 | Reference target exact head | 25 PASS, 1 planned skip, 0 open threads; merged as `ad75dbce852f6bf6d5cec5a1c8063afc60afaf14` | First vertical delivery proof |
| Target exact-head gate evidence, Bash and PowerShell | 32 final target heads | PASS; 32 primary rows, no stale head | Temporary provider-neutral evidence, not committed to a target branch |
| Final target reviews | 32 final target heads | 6 substantive reviews, 26 provider-unavailable responses, 0 actionable threads | Missing reviews are recorded as missing and never reclassified as approval |
| Target PR delivery | 32 adopted targets plus TinyCalc reference PR | 33 non-empty PRs merged; 32 final default branches clean and `(0,0)` | Target-local delivery only; blocked and inapplicable targets received no PR |
| Propagation target-set hash | Before and after target delivery | PASS; `eef16047e705b4795e193677b2ef48824c6a2fe46697c21e1afcca29ec97230c` unchanged | No maintenance-package propagation was performed |

## Follow-up Boundaries

| Follow-up | Owner | Risk | Due or re-evaluation trigger | Evidence and scope reason |
|---|---|---|---|---|
| The shared statistics renderer omits a zero-value partial first month from the monthly table although the 52-week observation window can start in that month. | Level-0 Statistics Maintainer | Low; readers may initially expect a row for the partial month. | Before the next renderer feature or when the monthly table contract changes. | Reproduced by Copilot in TinyCalc, DataGrip, TinyPl0 and SecureOrderDesk Java. Fixing paired Bash/PowerShell executable renderers is outside D7's documentation-only target scope. |

## Delivery And Closeout

Target implementation, exact-head validation, reviews, merges and local target
synchronization are complete. The Level-0 feature PR, Series closeout and
retrospective remain pending.
