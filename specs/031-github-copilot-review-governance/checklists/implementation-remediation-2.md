# Implementation Remediation 2: IAL-001 through IAL-006

**Phase ID**: `implement-local-remediation-2`  
**Scope**: Second bounded repository-local remediation only  
**Disposition**: Superseded and blocked by the independent `analyze-local-3` review  
**Next exact action**: Historical only; use `implementation-remediation-3.md`.  
**Tasks boundary**: T001-T122 checked; T123-T168 open; T123 was not executed.  
**Tasks SHA-256**: `48020705c184dca7c56b1d5c2be84cd666718e53f17fcf4f9b98952d1d465bb1`

## Repaired findings

> Correction dated 2026-08-29: `implementation-analysis-local-3.md` found that
> label-derived G4 uniqueness, the non-adversarial six-case runner proof, and
> the stale `final-local-macos.json` receipt remained open. The corresponding
> IAL-001, IAL-002, IAL-005 and IAL-006 closure statements below are withdrawn.
> Other directly executed T134/T150/FakeProvider observations remain historical
> regression evidence only. This superseded receipt grants no gate.

| Finding | Repository-local repair and directly observed evidence | Result |
|---|---|---|
| IAL-001 | Historical six-case observation; independently shown incomplete for adversarial terminal invariants by `implementation-analysis-local-3.md`. | Withdrawn |
| IAL-002 | Historical 71-label run; the reported 58/13 decomposition was label-derived rather than semantic execution grouping. | Withdrawn |
| IAL-003 | `ValidateExternalWriteGate` derives the current Authority, Inventory, Mutation Plan, Change-Set-Review and Acceptance/Security/Review/Technical evidence records from fixed safe paths below EvidenceRoot. It validates complete field sets, semantics, operator/reviewer/account identity, scopes, time windows, snapshot/plan/desired graph and every referenced raw file hash. Empty/missing roots, missing inventory, null authority and arbitrary hashes fail closed. An eight-component validate-then-mutate matrix observes Exit 3, `Blocked,writes=0` and zero FakeProvider writes for every tuple component. Apply and Rollback re-read and re-hash the tuple immediately before their bounded writes. | Repaired locally |
| IAL-004 | The entry preserves `PlanPath` and passes `RollbackPlanPath` separately. The exact T134 command consumes current Authority, AccountSetting plan action, Gate, NotInvoked Result and bounded Rollback plus the complete evidence graph. The complete set returns Exit 0/Authorized/AccountIdentityEquality Passed; authority, plan, gate, result, rollback and foreign-ID mismatches each return Exit 3/Blocked/writes=0. Apply serializes its mutated Inventory to `operational/provider-convergence/after-inventory.json`; the exact T150 validation reads that Apply-produced file and the second real Preview emits 17 zero-write actions. | Repaired locally |
| IAL-005 | Historical source strengthening; the six-case proof did not perturb every terminal invariant. | Withdrawn |
| IAL-006 | Historical documentation correction was incomplete because `final-local-macos.json` still claimed the first remediation findings repaired and `Fulfilled`. | Withdrawn |

## Decisive executable observations

| Probe | Direct observation |
|---|---|
| Full G4 execution 1 | Exit 0; `selected=71 independent=58 aggregates=13 passed=71 failed=0 liveProviderWrites=0 networkWrites=0` |
| Full G4 execution 2 | Exit 0 with the same counts and disposition |
| Final 13-case state/security transaction matrix | Exit 0; 13 independent cases passed, including T134, T150, TOCTOU, retry, reconciliation, idempotency and all bounded state transitions |
| Direct runner matrix, executions 1 and 2 | Exit 0 each; six scenario-specific byte/hash/log/ref/index/worktree records passed |
| Bash-wrapper runner matrix, executions 1 and 2 | Exit 0 each; same six observations through the one-process Bash surface |
| Exact T134 positive | Exit 0; Authorized, `accountIdentityEquality=Passed`, writes 0 |
| Exact T134 mismatch matrix | Six semantic mismatch classes; each Exit 3, Blocked, writes 0 |
| Exact T150 from Apply output | Account Disabled, eight targets, eight Lite records, eight active target rulesets, zero active non-target rulesets; second Preview 17 actions and zero writes |
| Eight-component gate TOCTOU matrix | Authority, Inventory, Plan, Change-Set-Review, Acceptance, Security, Review and Technical; eight Blocked results and total writes 0 |
| Ambiguous write | Write followed by observable reconciliation Read; no blind write retry; `Reconciled` only after desired state was observed |
| Idempotent second pass | Real second Preview and Apply journal records, writes 0, drift 0 |
| Rollback | Current Read, bounded Write and exact Account/Ruleset before-state restoration observed; after Inventory serialized |

## Cross-functional gates

| Gate | Result |
|---|---|
| Security and privacy | Local Pass: exact evidence graph and TOCTOU matrix; actual secret/PII rejection; secret scan high=0 and gitleaks high=0 |
| Architecture / iSAQB | Local Pass: context, interfaces, building blocks, runtime, provider/deployment boundary, quality, risks, trade-offs and technical debt present; FakeProvider result and Inventory converge |
| Accessibility | Local Pass: ordered bilingual linear output and keyboard, screenreader, Braille and text-browser semantics inspected |
| T116 workflow | Definition Pass: exact PR types, feature-branch push, Ubuntu/Windows, contents:read, payload/decision hashes, artifacts, zero writes and no secrets; native execution remains Open |
| Documentation Impact | `UpdateRequired`; validator current and 10/10 fixtures pass |
| Source parity | Six maintained runner/fixture/test/wrapper/man surfaces byte-identical across all three trees |
| PowerShell analysis | Repository PSScriptAnalyzer: 173 tracked files, 0 Error/Warning; direct changed/untracked surfaces: 0 findings |
| Syntax and schemas | Bash syntax, PowerShell parsers, workflow YAML, contract and fixture JSON parsers pass |
| Existing regressions | CI budget 40/40, Stage B 88/88, agent surfaces 3/3 |
| State validators | Bash and PowerShell validators pass at Implement/Active, 122/168 |
| Git checks | `git diff --check`, cached diff check and empty-index assertion pass |

## Boundary and mutation accounting

- Current-repository stage, commit, push, PR, merge and ref writes: `0`.
- Live GitHub/provider endpoint calls and account/ruleset/billing/subscription mutations: `0`.
- Home sync, intake-series mutation, Position-7 start/preparation and optional hook execution: `0`.
- Admin-Bypass use: `0`.
- Temporary Git commits, refs, index and worktree mutations occurred only inside automatically removed isolated runner fixtures.
- Bounded product writes occurred only inside explicit temporary FakeProvider files.
- The current repository index is empty.
- State remains `Implement/Active`, 122/168. Tasks remain exactly T001-T122 checked and T123-T168 open with the unchanged hash above.

## Open gates and next action

This receipt is Local remediation evidence only. All ten ScopeContract records
and all ten Supplemental records remain `Open`; Primary commands remain
unexecuted. Native Linux/Windows, live provider, provider convergence,
delivery, merge, Home distribution, intake-series continuation and Position 7
remain outside authority and are not promoted.

This receipt is superseded. The current next action is defined only by
`implementation-remediation-3.md`: fresh independent `analyze-local-4`.
