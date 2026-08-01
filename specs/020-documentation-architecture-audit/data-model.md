# Data Model: Documentation Information Architecture Audit

## AuditMetadata

- `schemaVersion`
- `auditId`
- `capturedAt`
- `repositoryCommit`
- `inventorySource`: `GitIndex`
- accepted intake, review, Series, and Constitution paths with normalized hashes
- ordered evidence paths

## DocumentationUnit

- `unitId`: stable identity derived from repository-relative path
- `path`
- `normalizedSha256`
- `family`
- `artifactClass`
- `decision`
- `audiences`
- `readerPaths`
- `canonicalSource`
- `owner`
- `rationale`
- `evidence`
- `risk`
- `reevaluationTrigger`

Artifact classes are exactly `ActiveSemantic`, `Generated`, `Historical`,
`Archived`, `ExternalReference`, `AgentSurface`, and `IntakeEvidence`.

Decisions are exactly `KeepAsIs`, `Restructure`, `SplitByTopic`,
`SplitByLanguage`, `MergeDuplicate`, `GeneratedFromSource`, `ArchiveOnly`, and
`FollowUp`.

## ReaderPath

- `readerPathId`: `Learner`, `DailyUser`, `MaintainerAgent`, or `AuditTroubleshooting`
- `entryPoints`
- `prerequisites`
- ordered `steps`
- `deepReferences`
- `safeNextAction`
- `status`: `Pass`, `Gap`, or `N/A`
- `evidence`
- optional `findingId`

## MaintenanceContract

- `contractId`
- `sourceFeature`: `015` through `019`
- `topic`
- expected behavior and proof boundary
- README, manpage, architecture, A11Y, security, script-reference, and Feature evidence
- dimension decisions: `Pass`, `IntentionalBoundary`, `Gap`, or `N/A`
- optional `findingId`

## SourceRuntimeRecord

- `recordId`
- `artifactClass`: `homeRuntime`, `sourceOnly`, or `machineLocal`
- resolved repository-relative source paths or safe logical local identity
- `owner`
- `canonicalEditLocation`
- `syncRequired`
- `commitAuthority`
- `remoteAuthority`
- `benefit`
- `proofBoundary`
- `safeNextAction`
- `status`: `Pass`, `Gap`, or `N/A`
- optional `findingId`

## AuditFinding

- `findingId`: unique `DIA###`
- `severity`: `Critical`, `High`, `Medium`, or `Low`
- `summary`
- `evidence`
- `owner`
- `residualRisk`
- `successor`: `D5`, `D6`, `D7`, or `NonRemediation`
- `targetBoundary`
- `reevaluationTrigger`
- `status`: `Open` or `AcceptedRisk`

## GovernanceCheckpoint

- `preset`
- `checkpoint`
- `applicability`: `Applicable`, `N/A`, or `Open`
- `result`
- `rationale`
- `evidence`
- `owner`
- `reviewer`
- `reviewDate`
- `residualRisk`
- `followUp`
- `reevaluationTrigger`

## Invariants

- Every Git-derived documentation path appears exactly once.
- Every unit has exactly one accepted class and decision.
- Every positive decision cites current evidence.
- All four reader paths exist exactly once.
- Every required maintenance contract exists exactly once.
- The source/runtime matrix contains all three classes and all manifest-derived
  `homeRuntime` and `sourceOnly` paths; machine-local records use no private
  absolute path.
- Every `Gap` references one known finding. Accepted rows contain no open gap.
- Every finding has one owner and one successor.
- Publishable evidence contains no credential or private absolute path.
