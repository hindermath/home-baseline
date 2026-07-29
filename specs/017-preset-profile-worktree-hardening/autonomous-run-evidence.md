# Autonomous Run Evidence: Feature 017

## Identity and Authority

| Field | Value |
|---|---|
| Feature | `017-preset-profile-worktree-hardening` |
| Accepted inputs | Binding intake, authoring receipt, active Series request/result and Series manifest |
| Delivery mode | `MergeAndSync` |
| Authority source | Current user request; narrow admin bypass only at the documented Human-Approval-only boundary |
| Evidence owner | Thorsten Hindermann |
| Run-state path | `specs/017-preset-profile-worktree-hardening/autonomous-run-state.json` |
| Run-state status | `Active` |

### Accepted Artifact Hashes

| Artifact | SHA-256 |
|---|---|
| Binding intake | `5c5d1c27d7328d4ae784bdcebdb1b7163d37443637eb10dc2d4f646a794c8f6e` |
| Authoring receipt | `66054a05ba62cb807bb70c8dc786b7d9166b56e98d4a716123edc2880f4ff81f` |
| Active Series review request | `03681686dfbdc565a0a664360e8401d5b59cc19da33c0a3ee0f6b84780ec3b3c` |
| Active Series review result | `9672fc055e26c6ca8c76492788878b334f84eae02d5ec6fa8ca0d884ab75b06c` |
| Active Series manifest | `c4e40fe218984a2897b09ae420b5a4ac85668960fcc14eb9dc41006acc547075` |

### Unchanged Baseline

The four existing maintenance suites ran before production changes. Result:
47 tests, 46 passed, 12 platform skips and one previously observed timing
flake in the Linux CLI probe. The probe expected `Unusable` but crossed its
very narrow fixture timeout and returned `TimedOut`. Feature 017 does not
reinterpret this as a new product regression; all new fleet tests run
independently from that timing boundary.

The Feature-017 red baseline then failed for the intended reasons: no
`freshnessAttempt`, no bound remote symbolic-head evidence, and Home Sync
preceding the fleet stage. After the first vertical slice, the focused
freshness, continuation, ordering, pull and unsafe-state suite passed.

## Scope and Convergence

| Gate | State | Evidence or disposition |
|---|---|---|
| Preflight | Pass | Clean synchronized `main`; intake is sole `Eligible`; Series review is `Ready` |
| Clarify | Pass | Two focused coverage passes found no material question |
| Checklists | Pass | Requirements, governance and fleet-safety checklists complete |
| Plan review | Pass | Architecture, scope, test-first slicing and delivery review complete |
| Analyze | Pass | Repeated pass: zero Critical/High, no unmapped PWH/AC or tasks |
| Implementation | Pass | Five independently tested stories implemented without target-repository delivery authority |

## Validation

| Invocation | Trigger | Mutable token/value | Explicit root | Exit | Error channel | Result and proof boundary |
|---|---|---|---|---:|---|---|
| `git status`, `fetch`, ahead/behind comparison | Autonomous preflight | N/A | repository root | 0 | clean | Branch base and synchronization proved before feature creation |
| Intake Series Bash validator | Intake eligibility | N/A | active Series | 0 | clean | Current 39-target Series and sole `Eligible` intake accepted |
| Active Series review validator | Binding review | N/A | active review | 0 | clean | Schema 1.1 result `Ready`, zero findings |
| Four maintenance unittest modules | Product and regression proof | N/A | repository root | 0 | clean | 60 tests passed; 12 Windows-only process tests skipped on macOS |
| Bash parser and Python bytecode compilation | Syntax proof | N/A | changed scripts/tests | 0 | clean | Bash and Python syntax accepted |
| PowerShell parser | Syntax proof | N/A | changed PowerShell orchestrator | 0 | clean | Zero parser findings |
| PSScriptAnalyzer 1.25.0 | Static PowerShell proof | N/A | 147 tracked files | 0 | clean | Zero errors or warnings; four generated upstream files excluded by policy |
| JSON parsing | Evidence schema proof | N/A | Feature 017 JSON artifacts | 0 | clean | Every JSON artifact accepted by `jq` |
| `git diff --check` | Text integrity | N/A | current candidate | 0 | clean | No whitespace errors |
| Isolated CheckOnly/DryRun fixtures | Safe-mode boundary | N/A | disposable local remotes and homes | 0 | clean | Bash tokens `--check-only`/`--dry-run` and PowerShell mode projection permit control/fetch evidence while clone, pull and domain mutation remain prohibited |
| Documentation Impact validator | Documentation governance | N/A | Feature 017 evidence | 0 | clean | Four decisions accepted |
| Script reference and statistics checks | Generated documentation | N/A | repository root | 0 | clean | Both generated surfaces report `CURRENT` |
| Homogeneity Check | Repository governance | N/A | repository root | 0 | clean | 30/30 checks, score 100 percent |
| Gitleaks and agent secret scan | Secret boundary | N/A | repository diff | 0 | clean | No high-severity or diff secret finding |
| `specify check` | Spec Kit installation | N/A | repository root | 0 | clean | Installed integrations accepted |

## Implementation Evidence

| Story | Result | Proof boundary |
|---|---|---|
| Fleet freshness | Pass | Level 0 plus all manifest Git targets are inventoried; every reachable existing checkout receives bounded fetch evidence before domain mutation |
| Default branch and pull | Pass | Local symbolic HEAD or remote `ls-remote --symref` evidence is bound to the tracking commit; only clean, canonical, matching-upstream, zero-ahead, behind-only targets may pull |
| Worktree lease | Pass | Atomic leases bind run, process start, repository, commit and state paths; active, PID-reused, foreign, changed or escaped cases remain untouched |
| Profiles and Registry | Pass | Current eleven-preset and synthetic twelve-preset profiles resolve without code changes; known language/MSL conflicts are reported without rewriting curated data |
| Cross-platform evidence | Pass | Bash and PowerShell use the same Python contract, status vocabulary and lease commands; native provider gates remain required before merge |

The normal comment budget remains selective. New comments explain atomic
replacement, ordering and re-inventory boundaries; they do not narrate obvious
assignments. No public API, package, dependency or target-repository behavior
outside the maintenance contract changed.

## Requirement Reconciliation

| Contract group | Requirements | Acceptance criteria | Gate mapping | Result |
|---|---|---|---|---|
| Fleet freshness and ordering | PWH-012, PWH-014, PWH-019 | AC-013, AC-016, AC-018, AC-020, AC-021, AC-026 | G001 | Pass |
| Branch and pull safety | PWH-002, PWH-003, PWH-013 | AC-001, AC-002, AC-003, AC-014, AC-015, AC-019 | G001 | Pass |
| Worktree ownership and cleanup | PWH-004, PWH-005, PWH-006, PWH-018 | AC-004, AC-005, AC-006, AC-022, AC-023 | G002 | Pass |
| Dynamic profiles and Registry | PWH-008, PWH-009, PWH-016, PWH-020 | AC-008, AC-009, AC-010, AC-024 | G004, G006 | Pass |
| Evidence and platform parity | PWH-001, PWH-007, PWH-010, PWH-011, PWH-015, PWH-017 | AC-007, AC-011, AC-012, AC-017, AC-025, AC-027 | G003, G005, G007 | Pass locally and on the exact provider-reviewed head |

All PWH-001 through PWH-020 and AC-001 through AC-027 are mapped exactly
once in the accepted spec and covered by T001 through T089. Analyze produced
no unresolved Critical/High finding. G008 remains the justified trigger-based
N/A recorded in the gate declaration.

## Governance Applicability

| Governance area | Applicability | Result, rationale and reevaluation trigger |
|---|---|---|
| Security Governance: NIST SSDF and CWE Top 25 | Applicable | Fail-closed path containment, command boundaries, sanitized network evidence, exact ownership and negative fixtures are implemented. Reevaluate if new parsers, credentials or provider writes enter scope. |
| OWASP ASVS, SBOM, VEX, SLSA, OpenSSF Scorecard and AI-SBOM | N/A | No web application, dependency, package or release artifact changed. Reevaluate on dependency, package, build provenance or release changes. |
| NIS2, CRA, EU AI Act and DORA | N/A | This local maintenance control adds no regulated service, AI system or product delivery boundary. Reevaluate if deployment or regulated operational scope changes. |
| STRIDE, CIA and CAPEC | Applicable | Spoofed ownership, tampered leases, information leakage in evidence, denial through timeouts and unsafe elevation paths are explicitly bounded and tested. |
| S-ADR, arc42, Zero Trust and SAMM | Applicable | The shared Python core is the single trust and decision boundary; default deny and continuous revalidation are documented. No new architectural decision record is needed because the accepted plan already fixes this local design. |
| BSI C3A and BSI C5 | N/A | No cloud provider, cloud autonomy, tenant, deployment topology or distributed service flow changed. Reevaluate on cloud-service scope. |
| A11Y Governance | Applicable | DE-first/EN-second, CEFR-B2, text-first status, exact next actions and non-color-dependent reports are retained. |
| Cross-Platform Governance | Applicable | Bash and PowerShell public surfaces share one semantic engine, native parser/analyzer checks and platform CI. |
| Agent Parity Governance | Applicable, unchanged | All five maintained agent surfaces were reviewed together. Shared agent policy did not change, so synchronized edits would add noise rather than guidance. |
| `.specify/templates/` | N/A | No repository-owned Spec-Kit template contract changed. Reevaluate if future generated plans/tasks must expose new maintenance fields. |

## Delivery Candidate Integrity

| Check | Result | Evidence |
|---|---|---|
| Intended paths | Pass | Feature artifacts, maintenance core/orchestrators/tests, operator docs and generated references only |
| Tracked worktree diff | Pass | `git diff --check` passed locally |
| Exact staged candidate | Pass | Reviewed feature head `7c46069b40cce595091440de18741d59ca48a3d1` |
| Status reconciliation | Pass | No unrelated paths entered PR #153 |
| Index preservation | N/A | Clean index at feature start |

## Acceptance Gate Contract

| Item | Value |
|---|---|
| Requirements artifact | `specs/017-preset-profile-worktree-hardening/autonomous-run-gate-requirements.json` |
| Requirements SHA-256 | `5ba37a51c6df7e01cd5747f18e32a7bdf90a68d54b24da72a3258e1bab7e1fad` |
| Exact-head evidence snapshot | `specs/017-preset-profile-worktree-hardening/autonomous-run-gate-evidence.json` |
| Reviewed head | `7c46069b40cce595091440de18741d59ca48a3d1` |
| Validator | Installed Bash and PowerShell autonomous gate validators |
| Validator result | Pass, 8/8 in Bash and PowerShell |

## Remote Delivery

| Item | Result | Evidence |
|---|---|---|
| Push | Pass | `017-preset-profile-worktree-hardening` pushed without target-repository writes |
| Pull request | Pass | PR #153, non-empty feature delivery |
| Required checks | Pass | 20 successful jobs across Ubuntu, macOS and Windows |
| Acceptance execution map | Pass | Requirements hash and exact-head evidence validated 8/8 |
| Actionable threads | Pass | Zero review threads and zero comments |
| Unavailable reviews | Missing | No human or bot review was submitted; never represented as Pass |
| Merge | Pass | Exact reviewed head merged as `9ae8ecbe9cd19d9f7d7cfab9ce960361082f872a` |
| Default-branch sync | Pass | Local `main == origin/main` immediately after feature merge |
| Causal closeout | Applicable | Post-merge archive and successor eligibility require this separate closeout |
| Duplicate events | N/A | No duplicate delivery event observed |

## Closeout State

| Step | State | Evidence |
|---|---|---|
| Merge or publication | Completed | PR #153 merged; narrow bypass affected only Human Approval |
| Default-branch synchronization | Completed | Feature branch removed and merged `main` synchronized |
| Manifest-declared post-merge actions | Completed | Intake archived; 38-target Series and fresh review published |
| Final validation | Completed | Exact-head, Series, Home Runtime and real fleet check-only evidence recorded |

## Resume and Follow-up

- Checkpoint commit: `9ae8ecbe9cd19d9f7d7cfab9ce960361082f872a`
- Last operation: feature merge, Home Runtime synchronization and causal Series closeout completed
- Last passing gate: PR #153 exact head passed 20 provider checks, zero actionable threads and 8/8 provider-neutral gates; Series review `6851ba2b-edbe-4348-af93-c0d48d337701` is `Ready`
- Next exact action: N/A
- Stop reason and safe boundary: N/A
- Authority revalidation required: false
- Residual risk: Real fleet check-only run
  `4b7757d6-705f-41c3-aa12-83d97fefd25c` correctly remained `PARTIAL/1`
  because Level 0 was on the closeout branch, 32 canonical repositories
  reported maintenance-package drift and clean target checkouts were behind
  their remotes. These are fleet operations outside Feature 017.
- Out-of-scope follow-up: Position 4 is `Eligible` but is not started.

## Merge and causal closeout

- PR #153 merged reviewed head
  `7c46069b40cce595091440de18741d59ca48a3d1` as merge commit
  `9ae8ecbe9cd19d9f7d7cfab9ce960361082f872a`. Twenty GitHub checks passed
  across Ubuntu, macOS and Windows, and both installed gate validators accepted
  all eight exact-head requirements. No actionable review thread existed.
- The explicitly authorized narrow admin bypass applied only to GitHub's
  remaining Human Approval rule. It did not replace a technical, security,
  platform, evidence or review-thread gate.
- `scripts/sync-home.sh --no-pull` distributed the merged runtime and created
  local Home commit `aafd293`; the following `--check-only` run was current.
- Real check-only run `4b7757d6-705f-41c3-aa12-83d97fefd25c` completed all 44
  Git-target fetch attempts plus the separate Collection inventory. Its
  mutation barrier remained fail-closed. All eleven-preset validations used
  exact remote heads and released every temporary lease and worktree.
- The run reported existing fleet state rather than changing it: the Level-0
  checkout was intentionally on the closeout branch, clean target repositories
  were behind their remotes, and all 32 canonical repositories had the
  expected post-feature maintenance-package propagation drift. Toolchain
  required findings were zero; three optional formulae remained absent.
- Series operation `eba17697-5650-4d15-88e8-769c3d392d4f` archives the
  completed Position-3 intake and publishes 38 active targets, three roots and
  45 dependencies. Fresh Series review
  `6851ba2b-edbe-4348-af93-c0d48d337701` is `Ready` and selects Position 4 as
  the sole declared `Eligible` candidate without starting it.
