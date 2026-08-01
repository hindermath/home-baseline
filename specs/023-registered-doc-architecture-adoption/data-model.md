# Data Model: Registered Documentation Architecture Adoption

## FleetAdoptionMatrix

- `schemaVersion`: exact supported schema
- `feature`: `023-registered-doc-architecture-adoption`
- `sourceManifest`: path and normalized SHA-256
- `sourceRegistry`: non-publishable local path class plus normalized hash
- `preflightRunId`: run identifier from the check-only barrier
- `level0Head`: exact preflight commit
- `propagationTargetSetBefore`: normalized hash
- `feature022Claims`: exactly 17 accepted claim identifiers and source hash
- `targets`: one `FleetTargetDecision` per active manifest target
- `documentationImpact`: Level-0 feature record

## FleetTargetDecision

- `targetId`: unique manifest identity
- `kind`: `git-repository` or `collection`
- `level`: `1`, `2`, or `N/A` for a collection
- `maintenanceClass`
- `repositoryPathClass`: repository-relative to the fleet home, never a private
  absolute path in publishable evidence
- `remoteIdentity`: public remote URL or `N/A`
- `defaultBranch`: declared branch or `N/A`
- `observedBranch`
- `observedHead`
- `fetchResult`
- `worktreeClass`
- `inventorySummary`
- `readerPaths`
- `canonicalSources`
- `languageStrategy`
- `generatedAndHistoricalBoundary`
- `claimAssessments`: 17 `ClaimAssessment` records
- `decision`: exactly one `Adopted`, `AlreadyAligned`, `NotApplicable`, or
  `Blocked`
- `rationale`
- `documentationImpact`: one `DocumentationImpactRecord`
- `validation`
- `delivery`: optional `TargetDelivery`
- `residualRisk`
- `nextAction`
- `reevaluationTrigger`

## ClaimAssessment

- `claimId`: one accepted `AEC###` identifier
- `applicability`: `Applicable`, `AlreadyCovered`, or `N/A`
- `targetEvidence`
- `targetTerminology`
- `proofBoundary`

`Blocked` is a target decision, not a claim applicability value. A blocked target
may have only preflight-safe claim observations and cannot claim adoption.

## DocumentationImpactRecord

- `decision`: `UpdateRequired`, `NoUpdateRequired`, `GeneratedUpdate`, or
  `FollowUp`
- `source`
- `owner`
- `audiences`
- `readerPaths`
- `targetPaths`
- `navigationImpact`
- `documentClass`
- `languageStrategy`
- `languagePartners`
- `platformAndExampleProof`
- `distributionClass`
- `homeSyncRequired`
- `evidence`
- `residualRisk`
- `reevaluationTrigger`
- `dueDate`, `followUpOwner`, `scopeRationale`: required only for `FollowUp`

## TargetDelivery

- `branch`
- `commit`
- `pullRequest`
- `reviewedHead`
- `requiredGates`
- `providerEvidence`
- `actionableThreads`
- `mergeCommit`
- `finalDefaultBranchHead`
- `synchronized`

This entity is forbidden for `AlreadyAligned`, `NotApplicable`, and `Blocked`.

## Invariants

1. Every active manifest target occurs exactly once.
2. Every target has exactly one final decision.
3. Every Git target records one completed fetch attempt before the first target
   content mutation.
4. Every non-blocked Git target has exactly 17 claim assessments.
5. `Adopted` requires `UpdateRequired` or `GeneratedUpdate` and a non-empty
   `TargetDelivery`.
6. `AlreadyAligned` and `NotApplicable` require `NoUpdateRequired` and forbid a
   branch or pull request.
7. `Blocked` forbids target file changes and requires reason plus next action.
8. Repository paths in publishable evidence are path classes, not personal
   absolute paths.
9. The propagation target-set hash is unchanged at completion.
10. A changed target head invalidates its earlier exact-head evidence.
