# Data Model: Level-0 Documentation Architecture

## MigrationMetadata

- `schemaVersion`
- `findingId`
- `sourcePath`
- `sourceNormalizedSha256`
- `sourceLineCount`
- `d6FindingCount`
- `d7FindingCount`

## SectionMigration

- `sectionId`: Stable identifier for one former root top-level section
- `sourceHeading`: Exact former heading
- `sourceStartLine`, `sourceEndLine`
- `decision`: `Retained`, `Moved`, `Merged`, or `Obsolete`
- `targetPath`
- `targetAnchor`
- `languagePartner`
- `linkEvidence`
- `rationale`
- `findingId`: Always `DIA001`

## ReaderPath

- `readerPathId`: `Learner`, `DailyUser`, `MaintainerAgent`, or
  `AuditTroubleshooting`
- `entryPoints`
- `prerequisites`
- `orderedSteps`
- `deepReferences`
- `safeNextAction`
- `languagePartners`

## DocumentationImpactRecord

- `decision`: `UpdateRequired`, `NoUpdateRequired`, `GeneratedUpdate`, or
  `FollowUp`
- `audiences`
- `readerPaths`
- `canonicalSource`
- `owner`
- `navigationImpact`
- `documentClass`
- `languageStrategy`
- `platformAndExampleProof`
- `distributionClass`
- `homeSyncRequired`
- `evidence`
- `reevaluationTrigger`
- Follow-up detail when `decision == FollowUp`

## LinkProof

- `sourcePath`
- `linkText`
- `targetPath`
- `fragment`
- `result`

## Invariants

1. Every original top-level section appears exactly once.
2. Every active decision has a resolvable target and language treatment.
3. Every row traces to `DIA001`.
4. All four reader paths are complete and available in German and English.
5. The four Documentation Impact decisions remain exact and exhaustive.
6. D6 and D7 finding counts remain zero.
7. No publishable evidence contains a private absolute path or secret.
