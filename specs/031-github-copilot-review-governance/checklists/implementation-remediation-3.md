# Implementation Remediation 3: IAL3-001 through IAL3-003

**Phase ID**: `implement-local-remediation-3`  
**Execution date**: `2026-08-29`  
**Scope**: Third bounded repository-local remediation only  
**Local disposition**: Completed; independent `analyze-local-4` remains pending  
**Next exact action**: Fresh independently routed `analyze-local-4`  
**Tasks boundary**: Exactly T001-T122 checked and T123-T168 open; T123 was not executed or marked.  
**Tasks SHA-256**: `48020705c184dca7c56b1d5c2be84cd666718e53f17fcf4f9b98952d1d465bb1`  
**State boundary**: `Implement/Active`, 122/168; State and Tasks were not edited by this phase.  
**Optional hooks**: Skipped as instructed.

## Repaired findings

| Finding | Repository-local repair | Decisive local evidence | Result |
|---|---|---|---|
| IAL3-001 | Removed label interpolation from G4 contract identity. Every label now persists a semantic contract ID derived from canonical fixture/input bytes or case descriptor, the invoked product operation and the exact observed assertion IDs. Labels with identical execution semantics are aggregates of one contract. | Two full executions each report `selected=71 independent=29 aggregates=42 passed=71 failed=0`; an independent analyzer recomputed all 71 IDs and the 29/42 grouping. Contract-set SHA-256: `06c41bb94aa72893b20f2c39a183ca26365b00df3b1a3eb5f1ee0863ec10a9bf`. | Repaired locally |
| IAL3-002 | Expanded the isolated actual-parent-runner matrix from six to 18 scenarios and hardened `TerminalAwareRunnerAdoption` to bind the complete second TOCTOU tuple, including Tasks, result, payload, log, index and tracked-worktree observations. Each adversarial scenario emits its perturbation, target, before/after bytes and hashes, observed disposition and preservation accounting. | Direct PowerShell and Bash-wrapper matrices each passed 18/18 twice. Analyzer-style checks independently found all 18 required scenarios and all 12 added corruption/cleanliness perturbations; every added case failed closed with zero stale Parent/Catch feature writes and exact child-byte/Git-state preservation. | Repaired locally |
| IAL3-003 | Replaced stale `final-local-macos.json` with an explicitly superseded `Open` Local-historical record. It withdraws all repaired-finding claims, links the blocked `analyze-local-2` and `analyze-local-3` receipts, identifies this receipt and names fresh `analyze-local-4` as the next gate. | The record has `repairedFindingClaim=false`, `superseded=true`, and separately false Primary, native, live, provider and delivery evidence flags. Current reader surfaces no longer treat its former `Fulfilled` value as a gate. | Repaired locally |

## Honest G4 decomposition

The 71 task-facing labels remain available for stable task commands, but labels
are not counted as independent evidence. The runtime result at
`operational/quality/full-tests.json` contains, for every label:

- `semanticContractId` recomputable from the canonical semantic descriptor;
- `fixtureInputSha256` for the concrete input or canonical case descriptor;
- `invokedOperation` for the product command or module operation; and
- `observedAssertionIds` for the exact observations made.

Two complete executions produced the same 71-label result and the same semantic
contract set: 29 unique executed contracts and 42 aggregate labels. An
independent recomputation verified each per-label SHA-256 and reconstructed the
same groups. Aggregate labels are described only as aggregates and grant no
additional independent evidence.

Direct real product probes remain distinct only where their semantic inputs,
operations or observations differ. The executed probes covered secret/PII
rejection, accessibility semantics, the parsed workflow contract, provider
state transitions, reconciliation, idempotent second pass, rollback, retries,
TOCTOU, AccountSetting and the exact T134/T150 paths.

## Terminal-aware runner matrix

All maintained runner, fixture, test, wrapper and man/help surfaces are
byte-identical across the installed preset, source preset and preset-repository
trees. Both the direct PowerShell surface and the Bash wrapper invoked the
actual parent runner twice in isolated, automatically removed Git repositories.

The 18 scenarios are:

1. `ExactTerminalAdoption`
2. `ResultIdentityMismatch`
3. `DefiniteChildFailureWithoutDrift`
4. `CatchTimeChildDrift`
5. `GitRefDrift`
6. `RunnerLocalMaterializationFailure`
7. `TasksBytesCorruption`
8. `TasksHashCorruption`
9. `ResultBytesCorruption`
10. `ResultHashCorruption`
11. `PayloadPathCorruption`
12. `PayloadBytesCorruption`
13. `PayloadHashCorruption`
14. `LogPathCorruption`
15. `LogBytesCorruption`
16. `LogHashCorruption`
17. `TrackedWorktreeDirty`
18. `IndexDirty`

The 12 added adversarial scenarios independently perturb every required
terminal invariant after child production and before parent adoption. Every
case reached `FailClosedReadOnlyReconciliation`, preserved the child's exact
State, Tasks, result, payload and log disposition plus Git refs/index/worktree,
and reported `parentFeatureWrites=0` and `catchFeatureWrites=0`. The normal
definite-child-failure baseline retains its intentional bounded Parent
`Blocked` write and is not misreported as a stale-write adversarial case.

Runner-local log materialization remains non-blocking only when the bound log
cannot be created. A pre-existing wrong log path, bytes or hash is now part of
the adoption tuple and fails closed. The second TOCTOU comparison binds State
identity, Tasks bytes/hash, result path/bytes/hash, payload path/bytes/hash, log
path/kind/bytes/hash, refs, index and tracked-worktree cleanliness.

## T134, T150 and behavioral regression evidence

- The exact T134 public command accepted the complete five-record equality
  only when current Authority, AccountSetting plan, Gate, NotInvoked Result and
  bounded Rollback agreed. Across the T134 and TOCTOU probes, independent
  corruptions covered Authority, Inventory, Plan, Gate, Result, Rollback,
  Change-Set-Review, Acceptance, Security, Review and Technical evidence, plus
  the foreign-identity negative. Every corruption returned Exit 3,
  `Blocked,writes=0`; no FakeProvider write occurred.
- The exact T150 path consumed only the Inventory produced by bounded Apply.
  It observed Account Disabled, eight Lite targets, eight active target
  Copilot rulesets, zero active non-target Copilot rulesets and a second real
  Preview of 17 `NoOp` actions with zero writes.
- FakeProvider lifecycle transitions for Ruleset Create, Update and Disable,
  AccountSetting, retry, reconciliation, idempotency and rollback remained
  executable and passed. T134, T150 and the independently passing Security,
  Architecture, accessibility and workflow behavior did not regress.

## Complete local gates

| Gate | Direct observation |
|---|---|
| Full G4 grouping, execution 1 | Exit 0; 71 selected, 29 independent semantic contracts, 42 aggregates, 71 passed, 0 failed |
| Full G4 grouping, execution 2 | Exit 0; identical counts and contract-set hash |
| Independent semantic analyzer | Recomputed 71/29/42 and every per-label semantic contract ID |
| Direct product probes | Exit 0; exact T134/T150, secret/PII, A11Y, workflow, state, reconciliation, rollback and TOCTOU observations passed |
| Direct runner matrix, executions 1 and 2 | Exit 0 each; 18/18 scenarios each |
| Bash-wrapper runner matrix, executions 1 and 2 | Exit 0 each; 18/18 scenarios each |
| Runner-output analyzer | Four 18-record outputs contained the exact required scenario set; all 12 added perturbations failed closed and preserved child/Git state |
| Documentation Impact | `UpdateRequired`; current validator and 10/10 deterministic fixtures pass |
| Generated script reference | Check-only renderer and PowerShell reference tests pass |
| Security/static analysis | Secret scan high=0 and gitleaks high=0; PSScriptAnalyzer 1.25.0 analyzed 173 files with 0 Error/Warning |
| Architecture / A11Y / workflow | Local semantic probes and workflow YAML parsing pass; native execution remains Open |
| Syntax/schema | Bash syntax, PowerShell parser, Python compile, feature/runtime JSON schemas and workflow YAML parsing pass |
| Existing regressions | CI budget 40/40, Stage B 88/88, agent surfaces 3/3 |
| Three-tree parity | Runner, fixture, direct test, Bash wrapper and man/help hashes are identical in all maintained trees |
| State validators | Bash and PowerShell validators pass at `Implement/Active`, 122/168 |
| Tasks invariant | 168 sequential rows; exactly T001-T122 checked, T123-T168 open; accepted hash unchanged |
| Git checks | `git diff --check` passes; current-repository index remains unchanged and empty |

## Evidence role and authority boundary

This receipt and the corrected runtime records are repository-local evidence
only. They are not Primary, native Linux/Windows, live GitHub, provider,
delivery, merge or Home-distribution evidence. All ten ScopeContract records
and all ten Supplemental records remain `Open`; no Primary command was
executed. Independent `analyze-local-4` is still required and this phase does
not satisfy or mark T123.

Mutation accounting for the current repository and external systems:

- stage, commit, push, PR, merge, ref write and Admin-Bypass: `0`;
- live GitHub/provider endpoint calls and account, ruleset, billing or
  subscription mutations: `0`;
- Home sync, intake-series mutation and Position-7 start: `0`;
- optional hook execution: `0`.

Temporary Git mutations occurred only in isolated runner fixtures and were
automatically removed. Bounded product writes occurred only in temporary
FakeProvider evidence roots. All pre-existing authorized and unrelated changes
were preserved.

## Documentation Impact

Decision: `UpdateRequired`.

- Canonical sources and owners: terminal-adoption runner/help/man surfaces —
  Runner Governance Owner; G4 harness/runtime grouping — Test Harness Owner;
  Local readiness and remediation evidence — Remediation Evidence Owner.
- Updated reader paths: operator-facing bilingual runner comment help and
  text-first manpage; autonomous reviewers use `autonomous-readiness.md`, this
  receipt and the corrected Local runtime records.
- Document classes: executable help/man documentation and active Local evidence;
  superseded receipt is explicitly historical and `Open`.
- Audience and accessibility: operators, maintainers, autonomous/security/
  architecture/A11Y reviewers; linear text, explicit counts and non-color status
  remain usable with keyboard, screenreader, Braille and text-browser workflows.
- Distribution: repository source and runtime-local evidence only. Home sync is
  neither required nor authorized for this phase.
- Re-evaluation: fresh `analyze-local-4`, any semantic-contract or runner tuple
  drift, or any later native/live/provider/delivery evidence.

## Gate conclusion and next action

The three authorized findings have complete repository-local task and gate
evidence and all required regressions pass. This bounded remediation phase is
therefore locally complete. It does not assert that the independent analyze
gate has passed.

Exact next action: fresh independently routed `analyze-local-4`. The outer
runner owns phase and State reconciliation.
