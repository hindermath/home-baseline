# Research: Intake Sequencing Governance

## Decision 1: Separate preset at priority 66

Sequencing is distinct from authoring at 64 and review at 65. A separate preset
keeps lifecycle and ordering optional and prevents either earlier preset from
silently gaining execution authority.

## Decision 2: Typed DAG plus visible order

A typed directed acyclic graph expresses hard dependencies and supporting
baselines. The visible order remains a learner-friendly delivery recommendation.
Types that only serialize delivery do not masquerade as functional gates.

## Decision 3: Agent semantics, deterministic validation

Commands guide intent and authority. Bash and PowerShell scripts validate
persisted paths, hashes, graph shape, lifecycle, and receipts. Scripts do not
generate or interpret product requirements.

## Decision 4: Archive and tombstone deletion

Logical deletion preserves auditability and does not remove intake documents.
Physical purge remains outside v0.1.0.

## Decision 5: Existing series as Legacy Adoption proof

The current 13-target, 6-root, 15-edge Home Baseline series is a sufficiently
complex real field fixture. It remains read-only and is not migrated merely to
manufacture new evidence.
