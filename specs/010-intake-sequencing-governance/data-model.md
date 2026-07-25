# Data Model: Intake Sequencing Governance

## Series Manifest

- `schemaVersion`
- `documentType: IntakeSeriesManifest`
- `seriesId`, `title`, `policy`, `status`
- `orderedTargets[]`: path, role, normalized hash, lifecycle status
- `roots[]`
- `dependencies[]`: from, to, kind, binding
- `evidencePaths[]`

## Series Receipt

- `schemaVersion`, `documentType: IntakeSeriesReceipt`
- `receiptId`, `seriesId`, generator, timestamp
- operation ID/type and authority evidence
- manifest path and normalized hash
- previous receipt and manifest hashes
- validation status and next action

## Operation Journal

Prepared file inventory, proposal hash, authority, validation results,
publication result, and recovery boundary for an atomic write.

## Tombstone

Series identity, deletion authority, archive paths and hashes, deleted-at time,
reason, and proof that intake documents were not removed.

## Status Rules

Series: `Draft`, `NeedsClarification`, `Ready`, `Active`, `Completed`, `Deleted`.
Targets: `Pending`, `Blocked`, `Eligible`, `Active`, `Completed`, `Withdrawn`.
Unknown values fail closed.
