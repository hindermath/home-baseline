# Fleet Safety Requirements Checklist: Feature 017

**Purpose**: Test the completeness, clarity and consistency of the fleet,
branch, worktree and cleanup requirements before planning.
**Created**: 2026-07-29
**Feature**: [spec.md](../spec.md)

## Freshness and Inventory

- [x] Is the complete target population quantified and are Git and Collection
  roles distinguished? [Completeness, Spec FR-012]
- [x] Is the allowed evidence before the barrier distinguished from forbidden
  domain mutation? [Clarity, User Story 1]
- [x] Does one failed target leave later read-only inventory required while
  preserving the final fail-closed result? [Consistency, Spec SC-006/SC-007]
- [x] Are attempts, duration, final status and next action required for silent,
  timed-out and retried network operations? [Coverage, Spec FR-019]

## Branch and Pull Classification

- [x] Is the resolution order for local and remote symbolic HEAD evidence
  unambiguous? [Clarity, Spec FR-003]
- [x] Are all necessary conditions for a safe fast-forward pull stated
  conjunctively? [Completeness, Spec FR-013]
- [x] Are Dirty, Ahead, Diverged, Detached, Non-Default, missing-upstream and
  ambiguous states each covered? [Edge Cases, User Story 2]
- [x] Is guessing any conventional branch name prohibited? [Safety, Spec FR-004]

## Worktree and Cleanup Ownership

- [x] Are lease identity, ownership, path containment and lifecycle data
  complete? [Completeness, Spec FR-005]
- [x] Are normal completion, hard abort, active process, PID reuse, foreign
  ownership and tampering all defined? [Coverage, Spec FR-006/FR-007]
- [x] Is stale cleanup authority invalidated after every relevant state
  transition? [Consistency, Spec FR-018]
- [x] Are reset, stash, broad clean and recursive deletion explicitly excluded?
  [Scope, Spec FR-018]

## Profile and Registry

- [x] Is current profile cardinality evidence rather than a permanent limit?
  [Clarity, Spec FR-016]
- [x] Are both contradictory and accepted MSL examples defined without silent
  repair? [Coverage, User Story 4]
- [x] Are target-repository remote writes excluded from maintenance authority?
  [Safety, Spec FR-020]

## Result

The requirements cover primary, alternate, failure, recovery and
non-functional fleet scenarios without unresolved conflicts.
