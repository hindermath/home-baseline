# Data Model: Documentation Reality Audit

## RegistrySnapshot

- `schemaVersion`
- `capturedAt`
- `level0Commit`
- `fleetManifestPath`
- `fleetManifestSha256`
- ordered `repositories`

Each repository has `targetId`, `level`, repository-relative `homePath`,
declared remote, observed remote, default branch, current branch, exact commit,
worktree class, reachability, and audit status.

## DocumentationArea

- `areaId`: stable repository-and-family identity
- `targetId`
- `level`
- `family`
- `paths`: repository-relative evidence paths
- `decision`
- `claim`
- `evidence`
- `rationale`
- `generatedContract`
- `learnerA11yResult`
- `residualRisk`
- `reevaluationTrigger`

Accepted decisions are exactly:

`CurrentAndSupported`, `UpdateRequired`, `GeneratedDrift`,
`HistoricalEvidence`, `IntentionalDeviation`, `FollowUp`, `NotApplicable`,
`Blocked`.

## AuditFinding

- `findingId`: unique `DOC###`
- `areaId`
- `severity`: `Critical`, `High`, `Medium`, or `Low`
- `summary`
- `evidence`
- `ownerLevel`: `Level0`, `Level1`, or `Level2`
- `owner`
- `residualRisk`
- `correctionBoundary`
- `reevaluationTrigger`
- `handoff`: `D2`, `D3`, or `NonRemediation`

## Invariants

- The snapshot contains Level 0 exactly once and every manifest target exactly
  once.
- Every area references one known target and has exactly one decision.
- Positive claims require non-empty evidence.
- `UpdateRequired` and `GeneratedDrift` require exactly one finding.
- Every finding references one area, has one owner level, and one handoff.
- Level-0 findings route to D2; Level-1/2 findings route to D3 unless a
  justified non-remediation outcome is recorded.
- Publishable data contains no private absolute path.
