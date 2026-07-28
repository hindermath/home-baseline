# Implementation Plan: Requirements Intake Consolidation Governance

## Strategy

1. Freeze intake, review, preset, pilot, and remote provenance.
2. Add failing schema-2.0 fixtures before validator changes.
3. Implement the common contract in Authoring and consume it from Review and
   Sequencing without copying policy.
4. Synchronize canonical scaffolds and publication copies.
5. Publish three releases and validate tag ZIPs.
6. Migrate seven pilots through separate PRs.
7. Distribute version-only updates to the remaining fleet.
8. Submit catalog updates serially and perform a causal closeout.

## Technical Context

The implementation uses existing Bash, PowerShell 7, JSON, Markdown, and the
repository's current Python helper pattern. No new dependency is introduced.
Normalized hashing removes one UTF-8 BOM and normalizes line endings only.

## Serialization

Preset source, publication copy, installed surfaces, feature evidence, fleet
profiles, and statistics each have one writer. Pilot repositories are separate
delivery units, but their remote closeouts remain serial because fleet and
catalog evidence is shared.

## Validation

Tests cover German, English, bilingual and explicit profiles; 1.0-to-2.0
migration; no-rename compatibility; atomic references; LF/CRLF/BOM; invalid
language; mixed names; duplicate indexes; authority; collisions; stale
references; multiple eligibility; rollback and repair. Both shells must return
equivalent stable classes. PSScriptAnalyzer, Homogeneity, secret, agent parity,
eleven-preset composition, exact-head provider evidence, and repository-native
gates remain mandatory.

## Documentation Impact

Decision: `UpdateRequired`. Preset README/runbook/manpages, shared agent
guidance, field summaries, release notes, pilot evidence, feature artifacts,
active order, and statistics change together. Product documentation changes
only where a pilot needs a generated requirements index or order view.

## Closeout

Post-merge facts use one evidence-only causal closeout if needed. The intake is
archived and the six previous roots are restored only after every controlled
delivery condition is true. Windows hardening is not started.
