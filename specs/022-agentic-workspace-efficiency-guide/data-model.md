# Data Model: Agentic Workspace Efficiency Guide

## SourceMatrix

- `schemaVersion`: exact supported schema version
- `feature`: `022-agentic-workspace-efficiency-guide`
- `generatedFromHead`: source baseline commit
- `readerPaths`: exactly four `ReaderPath` records
- `claims`: non-empty unique `OperationalClaim` records
- `documentationImpact`: `DocumentationImpactRecord`

## ReaderPath

- `id`: `FirstSafeRun`, `RegularOperation`, `MaintainerAgent`, or
  `AuditTroubleshooting`
- `germanEntry`
- `englishEntry`
- `guideAnchor`
- `safeNextAction`

Each ID occurs exactly once. Both entries resolve to Git-tracked Markdown and
the guide anchor exists in both language partners.

## OperationalClaim

- `id`: stable `AEC###` identifier
- `category`: `Option`, `Status`, `ExitCode`, `Evidence`, `SafetyBoundary`,
  `Distribution`, `Recovery`, `Platform`, or `NextAction`
- `readerPaths`: one or more ReaderPath IDs
- `languages`: exactly `de` and `en`
- `statement`: concise bilingual-neutral claim identity
- `sourcePath`: repository-relative current source
- `sourceNormalizedSha256`: normalized source hash
- `sourceLocator`: heading, option token, field or stable symbol
- `sourceState`: `Current` or `HistoricalBoundary`
- `proofBoundary`
- `reevaluationTrigger`

## DocumentationImpactRecord

- `decision`: exactly `UpdateRequired`
- `owner`
- `audiences`
- `readerPaths`
- `canonicalSources`
- `navigationImpact`
- `documentClass`
- `languageStrategy`
- `languagePartners`
- `platformAndExampleProof`
- `distributionClass`: `sourceOnly`
- `homeSyncRequired`: `false`
- `evidence`
- `reevaluationTrigger`

## Validation States

- `Valid`: all schema, path, hash, cardinality and language constraints pass
- `Invalid`: one or more deterministic constraints fail

There is no partial success. Human semantic review is recorded separately and
cannot be inferred from `Valid`.

## Invariants

1. Every claim ID is unique and maps to exactly one primary source row.
2. Every source path is repository-relative, Git-tracked and within the repo.
3. Normalized SHA-256 uses UTF-8 text, strips one BOM and normalizes CRLF/CR to
   LF before hashing.
4. Every reader path and both language partners are present exactly once.
5. `HistoricalBoundary` cannot be used as current operating authority.
6. Every claim has a proof boundary and re-evaluation trigger.
7. Documentation Impact is complete and declares no Home sync.
8. No private absolute path, credential or machine-local evidence is stored.
