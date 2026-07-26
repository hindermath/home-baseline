# Data Model: Feature 013

## Repository Outcome

`RepositoryId`, `Level`, `Path`, `Remote`, `DefaultBranch`, `BaselineHead`,
`Freshness`, `Decision`, `ChangedPaths`, `Validation`, `PrNumber`,
`ReviewedHead`, `MergeCommit`, `FinalHead`, `ResidualRisk`, `NextAction`.

Decision is exactly one of `UpdateRequired`, `NoUpdateRequired`,
`GeneratedUpdate`, or `FollowUp`.

## Finding Disposition

`FindingId`, `RepositoryId`, `OriginalClaim`, `PostPropagationResult`,
`Decision`, `Evidence`, `Owner`, `ResidualRisk`, `ReevaluationTrigger`.

The finding set is exactly `DOC001` through `DOC015`.
