# Data Model: Feature 028

## FieldValidationCase

Fields: `caseId`, `findingId`, `attempt`, `inputHash`, `expectedOutcome`,
`actualOutcome`, `taskExpected`, `taskCompleted`, `resultHash`, `decision`,
`proofBoundary`, `status`.

## ReleaseEvidence

Fields: `presetId`, `version`, `repository`, `tag`, `commit`, `zipUrl`,
`zipSha256`, `compositionResult`, `commandCount`, `skillCount`, `publishedAt`.

## ConsumerEvidence

Fields: `targetId`, `path`, `remote`, `defaultBranch`, `profile`,
`applicability`, `beforeVersion`, `afterVersion`, `pr`, `reviewedHead`,
`checks`, `threads`, `mergeCommit`, `syncState`, `exception`.

## LifecycleEvidence

Fields follow schema 2.0: `lifecycle`, `reviewedHead`, `requirementsHash`,
`providerEvidence`, `normalizedSha256`, plus `preMergeEvidenceHash` and
`mergeCommit` for PostMerge.

## SeriesCloseout

Fields: previous and next manifest hashes, archived G2 targets, restored roots,
target/root/dependency cardinalities, declared eligible target, validation,
and explicit no-start boundary.
