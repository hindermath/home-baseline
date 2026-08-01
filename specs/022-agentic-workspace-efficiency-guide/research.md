# Research: Agentic Workspace Efficiency Guide

## Decision 1: One canonical paired guide

**Decision**: Add one German guide and one synchronized English partner under
`docs/maintenance/`; route all four existing reader paths to anchored sections.

**Rationale**: This provides progressive disclosure without recreating the
former root README monolith or duplicating operational truth across four pages.

**Alternatives considered**: Four independent full guides were rejected due to
high semantic-drift risk. Expanding the root portals was rejected because they
are intentionally compact.

## Decision 2: Current implementation outranks old prose

**Decision**: Source precedence is wrapper help and parameter contracts,
PowerShell help, manpage, generated script reference, structured reports and
merged Feature 018-021 evidence. Historical README migration evidence may only
explain past boundaries.

**Rationale**: D4/D5 established that migrated prose is not a second canonical
operational source.

**Alternatives considered**: Treating all Markdown as equal was rejected because
it permits obsolete options and status meanings to re-enter active guidance.

## Decision 3: Machine-readable claim binding

**Decision**: Use a JSON source matrix with stable claim IDs, language scope,
reader path, category, current source path/hash, proof boundary and
re-evaluation trigger.

**Rationale**: Links alone cannot prove that every operational statement has
exactly one current primary source or that source content has not drifted.

**Alternatives considered**: A prose table was rejected because uniqueness,
hashes and negative fixtures would not be deterministic.

## Decision 4: Python standard-library validation

**Decision**: Implement the feature-local matrix validator and tests in Python
3 without dependencies.

**Rationale**: Python is already required by repository tooling, is memory-safe
under the project policy and provides portable JSON, hashing and path handling.

**Alternatives considered**: Bash/PowerShell validator pairs would expand
cross-platform script-product scope. Manual-only review cannot prove SC-002.

## Decision 5: Separate semantics from mechanics

**Decision**: Deterministic checks prove structure, hashes, links and allowed
values. Human review separately proves CEFR B2, translation equivalence,
progressive disclosure and usable text-first explanations.

**Rationale**: Neither automated checks nor prose review alone covers both
mechanical and learner-facing quality.

## Decision 6: No runtime follow-up unless evidenced

**Decision**: Create an automation follow-up only for a reproducible gap in the
current product surface. Otherwise record `NoFollowUpRequired`.

**Rationale**: D6 may document but cannot silently repair runtime behavior.

**Alternatives considered**: Pre-creating a remediation intake was rejected as
speculative and would violate the non-empty follow-up rule.
