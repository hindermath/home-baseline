# Contract: Fleet Evidence and Delivery

## Serial Delivery Set

The accepted delivery set contains exactly seven repositories in this order:

| Order | Repository | Planned feature branch |
|---:|---|---|
| 1 | Home Baseline | existing `032-linked-intake-evidence` |
| 2 | Agent Operations Cockpit | `003-linked-intake-evidence` |
| 3 | TinyPl0 | `006-linked-intake-evidence` |
| 4 | TinyCalc | `004-linked-intake-evidence` |
| 5 | InventarWorkerService | `003-linked-intake-evidence` |
| 6 | TuiVision | `047-linked-intake-evidence` |
| 7 | `absdd-image-sandbox` | `004-linked-intake-evidence`, only after its base gate |

Branch numbers are planning projections derived from current local histories.
They are revalidated against fresh remote and local feature state before branch
creation. A collision or newly reserved number returns to plan review rather
than silently changing the traceability identifier.

## Base Preflight

Before the first mutation in a repository, record:

- registered repository identity and expected origin;
- fresh remote default branch and exact base SHA;
- clean worktree or an explicit stop for unrelated changes;
- required local/central programme gates;
- active intake/review/sequencing hashes;
- no unexpected product/runtime/package scope;
- renderer owner, output owner, documentation class, and statistics baseline.

The preflight never discards, stashes, rebases, resets, or overwrites user work
without separate authority.

For `absdd-image-sandbox`, the current clean
`003-secure-development-container-hardening` branch and its two-commit lead
over cached `origin/main` are preserved. The base gate is unsatisfied until
Feature 003 has a terminal delivery decision and the checkout can start this
feature from a clean, freshly synchronized default branch. No work is stacked
on, rebased from, or cherry-picked implicitly from the observed branch.

## Per-Repository Evidence Record

Each repository records one hash-bound evidence bundle containing:

| Field | Requirement |
|---|---|
| Repository/base | identity, default branch, base SHA, feature branch, head SHA |
| Canonical inputs | manifest/evidence paths and lowercase SHA-256 values |
| Generated outputs | owned paths, candidate/final SHA-256, write count |
| Tests | exact commands, platform/runner, exit codes, log/payload hashes |
| Security | `Applicable`, `N/A` rationale, or `Open` owner/follow-up/trigger |
| Architecture/iSAQB | data-flow decision and quality scenarios |
| Accessibility | text-first and linearization review evidence |
| Cross-platform | native macOS/Linux/Windows decisions where applicable |
| Agent parity | all maintained surfaces updated together or justified `N/A` |
| Dependencies | diff-based zero dependency/package/lockfile proof |
| Product scope | diff-based zero runtime/API/business/image/Compose expansion proof |
| Documentation | exactly one impact decision and affected reader paths |
| Statistics | local ledger source change plus deterministic renderer result |
| Distribution | local class and sync decision; Home-only runtime sync when applicable |
| PR lifecycle | PR, review threads, gate results, merge SHA, default verification |
| Rollback | repository-local revert/regeneration procedure and evidence location |

Evidence contains repository-relative paths only. Credentials, local agent
state, browser/session data, absolute home paths, and private logs are excluded.

## Gate Semantics

- `Applicable` requires complete current evidence before the repository can
  advance.
- `N/A` requires a specific rationale and a re-evaluation trigger when scope
  could make it applicable.
- Temporary `Open` requires an owner, follow-up action, due/revisit point, risk,
  and trigger; it blocks merge when the governing preset defines a hard gate.
- Partial, stale, differently based, or syntactic-only proof is never reported
  as completed platform or delivery evidence.
- A gate pass is bound to the tested head. A changed head invalidates it unless
  the gate explicitly proves the change is outside its scope.

## PR, Review, and Merge Boundary

Each repository has one focused PR. Before merge:

1. local check/write/check and idempotence evidence is complete;
2. repository-native tests and required platform proofs pass;
3. documentation impact, statistics, security, architecture, A11Y, and agent
   parity decisions are recorded;
4. all review conversations are resolved by code/evidence or an accepted
   documented decision;
5. required status checks and branch protections pass on the current head;
6. the diff contains no product/runtime/API/dependency expansion.

After merge, verify the remote default branch contains the merge result, rerun
the safe/check gate at the merged SHA where the repository requires it, and
confirm generated views remain current. Only then may delivery advance to the
next repository.

## Administrative Bypass

Administrative bypass is not general merge authority. It may be considered
only when every technical, security, review, evidence, and required status
gate has passed and the sole remaining failure is a verified branch-protection
mechanism that refuses an otherwise compliant merge. The decision must record
the exact refusal, current head, actor, reason, scope, time, and post-merge
verification. It must be the narrowest available action.

Bypass is forbidden for failing tests, missing review, unresolved findings,
stale platform proof, absent evidence, scope drift, sandbox base ambiguity, or
delivery-order convenience.

## Rollback and Recovery

Rollback is repository-local and preserves history:

- stop the serial campaign at the failing repository;
- revert the feature merge or offending commit through the repository's normal
  reviewed workflow;
- restore canonical renderer/manifests, regenerate owned outputs, and prove
  check-mode currency and idempotence;
- update evidence and statistics to describe the rollback truthfully;
- for Home Baseline runtime distribution, run the approved check/apply/check
  Home Sync rollback only after the source rollback merges;
- never reset, rebase, or force-update another repository as fleet rollback.

The sandbox's pre-existing Feature 003 commits are outside this feature's
rollback scope.

## Evidence Lifecycle

Evidence progresses through `Draft`, `Current`, `Superseded`, and `Archived`.
Any source, renderer, feature mapping, tested head, platform command, decision,
or output-hash change supersedes the affected record. Superseded evidence is
retained for audit but cannot satisfy a gate. Repository closeout archives the
final current bundle and links it from the feature and statistics ledger.
