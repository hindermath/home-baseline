# Feature Specification: Parallel Autonomous Run Governance

**Feature Branch**: `007-parallel-autonomous-run-governance`
**Created**: 2026-07-18
**Status**: Approved for implementation

## Goal

Create an experimental Spec Kit preset that coordinates several existing
`autonomous-run-governance` runs without weakening their lifecycle, evidence,
or permission boundaries.

## User Scenarios

1. Run one language-neutral assignment in several isolated repositories.
2. Run independent features concurrently without sharing branches or worktrees.
3. Produce alternative solutions and require an explicit human selection before
   consolidation.
4. Execute a dependency-ordered agent pipeline with immutable, hashed handoffs.
5. Stop, inspect, and resume a campaign without guessing whether child work
   completed.

## Functional Requirements

- **FR-001**: The preset MUST use immutable UUID campaign and worker run IDs.
- **FR-002**: Every worker MUST have an isolated branch and Git worktree.
- **FR-003**: Concurrency MUST be limited to a declared value from 1 through 3.
- **FR-004**: The campaign MUST support `ReplicatedTargets`,
  `IndependentFeatures`, `AlternativeSolutions`, and `Pipeline`.
- **FR-005**: Pipeline dependencies MUST form a directed acyclic graph.
- **FR-006**: A worker MUST retain the existing autonomous-run state contract;
  campaign state MUST reference rather than duplicate it.
- **FR-007**: Runner commands MUST execute as executable plus argument array,
  without shell evaluation.
- **FR-008**: Ordinary worker failure MUST not cancel unrelated running work.
- **FR-009**: Failed pipeline dependencies MUST block their descendants.
- **FR-010**: Campaign-integrity, security, permission, or evidence failures
  MUST stop new scheduling.
- **FR-011**: Stop MUST be cooperative. Unexpected process loss MUST require
  revalidation before retry.
- **FR-012**: Alternative solutions MUST require a named human selection.
- **FR-013**: Merge-and-sync delivery MUST enforce an all-ready barrier before
  the first merge and MUST stop after the first merge failure.
- **FR-014**: Handoffs MUST identify producer, consumer, path, and SHA-256.
- **FR-015**: Installation MUST grant no execution or remote authority.
- **FR-016**: Bash and PowerShell entry points MUST expose equivalent behavior.
- **FR-017**: A sequential worker MAY inherit the validated exact head of one
  direct dependency in the same repository without sharing its worktree.
- **FR-018**: Reviewed campaign-specific operator instructions MUST be routed
  visibly to every worker without weakening undeclared authority boundaries.

## Success Criteria

- **SC-001**: Deterministic fixtures pass for all four topologies.
- **SC-002**: The scheduler never observes more than three active workers.
- **SC-003**: Duplicate IDs, branch collisions, cycles, dirty repositories, and
  malformed result contracts fail before unsafe continuation.
- **SC-004**: Alternative consolidation cannot proceed without explicit
  selection.
- **SC-005**: A 13-worker local agent smoke set completes natively on the
  authorized development Mac without remote writes.
- **SC-006**: Secure CaseTracker Units 00 through 03 complete in all six MSL
  repositories with no more than three workers active, using the same
  explicitly authorized native development override.

## Boundaries

- The v0.1.0-v0.1.2 development line is experimental and opt-in; v0.2.0 is
  promoted only after field closeout.
- No model name is prescribed.
- Provider-specific merge behavior is supplied through a local runner profile.
- Following successful field validation, v0.2.0 is the eighth preset in the
  workspace standard matrix with priority `80`.
- The repository owner's 2026-07-18 instruction explicitly overrides
  Container-First only for the native macOS development smoke set and the
  Secure CaseTracker field campaign for this preset. The override is not a
  reusable exception and expires when the field findings are captured.
- The repository owner's 2026-07-18 instruction also permits the development
  field campaign to classify only GitHub Actions jobs rejected before their
  first step with the known account-payment or spending-limit annotation as an
  external provider `N/A`. Local and agent-side gates remain required. Any
  technical CI failure, review finding, or different unavailable check remains
  blocking.
- Container-First remains binding for normal Secure Trader work and for any
  later production, learner, or routine campaign.
