# Data Model

## IntakeGovernanceConfig 2.0

Contains `schemaVersion`, BCP-47 `documentationLanguage`,
`artifactNaming.profile`, resolved role paths, collection paths, bounded legacy
aliases, and no authoritative manual counts.

## MigrationJournal

Contains operation ID, authority, state, timestamps, source/target hashes,
planned/completed moves, updated references, validations, and rollback or
`NeedsRepair`.

## AlignmentResult

Contains one accepted outcome, resolved language/source, role paths, computed
counts, canonical index count, active series, eligible candidate, findings, and
exact next action.

## Invariants

One canonical index; one current manifest entry and hash per active intake;
exactly one eligible candidate when provable; repository-relative paths;
eligibility never grants delivery authority.
