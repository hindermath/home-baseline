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
| Four maintenance unittest modules | Product and regression proof | N/A | repository root | 0 | clean | 59 tests passed; 12 Windows-only process tests skipped on macOS |
| Bash parser and Python bytecode compilation | Syntax proof | N/A | changed scripts/tests | 0 | clean | Bash and Python syntax accepted |
| PowerShell parser | Syntax proof | N/A | changed PowerShell orchestrator | 0 | clean | Zero parser findings |
| PSScriptAnalyzer 1.25.0 | Static PowerShell proof | N/A | 147 tracked files | 0 | clean | Zero errors or warnings; four generated upstream files excluded by policy |
| JSON parsing | Evidence schema proof | N/A | Feature 017 JSON artifacts | 0 | clean | Every JSON artifact accepted by `jq` |
| `git diff --check` | Text integrity | N/A | current candidate | 0 | clean | No whitespace errors |

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
| Exact staged candidate | Open | `git diff --cached --check` before commit |
| Status reconciliation | Open | No unrelated paths accepted |
| Index preservation | N/A | Clean index at feature start |

## Acceptance Gate Contract

| Item | Value |
|---|---|
| Requirements artifact | `specs/017-preset-profile-worktree-hardening/autonomous-run-gate-requirements.json` |
| Requirements SHA-256 | Pending until the gate declaration is finalized |
| Temporary evidence snapshot | Provider-neutral exact-head artifact; not committed before merge |
| Reviewed head | Pending |
| Validator | Installed Bash and PowerShell autonomous gate validators |
| Validator result | Open |

## Remote Delivery

| Item | Result | Evidence |
|---|---|---|
| Push | Open | Feature branch only |
| Pull request | Open | Non-empty PR required |
| Required checks | Open | Exact provider state pending |
| Acceptance execution map | Open | Requirements hash and exact-head evidence pending |
| Actionable threads | Open | Provider review pending |
| Unavailable reviews | None known | Must be recorded as missing, never Pass |
| Merge | Open | `MergeAndSync` authority |
| Default-branch sync | Open | Clean `HEAD == origin/main` required |
| Causal closeout | Open | Use only if post-merge Series facts cannot truthfully exist on reviewed head |
| Duplicate events | N/A | No duplicate delivery event observed |

## Closeout State

| Step | State | Evidence |
|---|---|---|
| Merge or publication | Pending | Feature PR not created |
| Default-branch synchronization | Pending | Feature branch active |
| Manifest-declared post-merge actions | Pending | Intake archive and successor Series disposition after merge |
| Final validation | Pending | Full acceptance pending |

## Resume and Follow-up

- Checkpoint commit: `b1e0110864cd7a6aa75c7cf42e7eec70bfe942c9`
- Last operation: local implementation and four-suite regression completed
- Last passing gate: 59 tests passed, 12 platform skips; parser, analyzer, JSON and diff checks passed
- Next exact action: complete isolated mode, homogeneity, secret, statistics and archive validation
- Stop reason and safe boundary: N/A
- Authority revalidation required: false
- Residual risk: Native provider validation and exact-head review remain pending.
- Out-of-scope follow-up: Position 4 remains blocked and is not started.
