# Data Model

## DeliverySetResult

- schemaVersion
- repositoryRoot identity
- trackedPaths
- intendedUntrackedPaths
- unrelatedUntrackedPaths
- ignoredPaths
- classifications and stable error code
- index/worktree before/after evidence

## PhaseResult

- schemaVersion `1.0`
- phaseId and attemptId
- outcome: `Completed`, `Blocked`, or `Failed`
- expectedTasks and completedTasks
- blockedReason
- gatesSatisfied
- payloadPath and payloadSha256
- normalizedSha256 bound by run state

Completion requires matching phase identity, exit zero, `Completed`, equal
non-negative task counts, true gates, valid payload hash, and valid document
hash.

## GateEvidenceSnapshot

- schemaVersion `2.0`
- snapshotType: `PreMerge` or `PostMerge`
- snapshotId and capturedAt UTC
- requirementsSha256 and reviewedHead
- entries with exactly one Primary per gate
- provider reference
- PostMerge only: acceptedPreMergeSha256 and mergeCommit
- changedPaths: empty for PostMerge

## Relationships

`PostMerge` binds exactly one accepted `PreMerge` snapshot. A phase binds one
structured result. A run state binds normalized hashes but does not infer
authority from any successful validator.
