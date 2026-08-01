# Implementation Plan: Level-0 Documentation Architecture

## Summary

Remediate `DIA001` by replacing the 3,683-line mixed-language root README with
compact German and English portals, routing detailed material into the existing
documentation taxonomy, preserving every active top-level section through a
machine-readable migration matrix, and hardening the durable Documentation
Impact contract. This is a documentation-only change with test-only validation.

## Technical Context

- **Runtime**: No runtime implementation change
- **Primary artifacts**: Markdown and JSON
- **Validation**: Python standard library, repository Bash/PowerShell validators,
  Markdown link checks, DocFX/Playwright/Axe where configured
- **Storage**: Git-tracked files only; no new package or dependency
- **Delivery**: `MergeAndSync`
- **Scope boundary**: Level 0 only; `DIA001`; no D6/D7 implementation

## Constitution Check

- German-first and English-second reader paths are explicit.
- CEFR B2, first-use terminology, text-first evidence, and WCAG 2.2 AA apply.
- Security claims remain bounded; no certification or runtime security claim is
  introduced.
- Source, Home Runtime, container, machine-local, and publication trust
  boundaries remain explicit.
- Shared guidance is updated across all five maintained agent surfaces.
- Documentation Impact records exactly one accepted decision.
- Generated and historical material remains under its current ownership rules.

## Project Structure

```text
README.md
README.en.md
docs/
  README.md
  README.en.md
  getting-started/
  operations/
  governance/
  reference/
  troubleshooting/
specs/021-level0-documentation-architecture/
  documentation-migration.json
  documentation-migration-report.md
  tools/validate_documentation_migration.py
  tests/test_documentation_migration.py
```

Existing directories such as `docs/learning-units/`, `docs/scripts/`,
`docs/security/`, and `docs/man/` remain authoritative and are linked from the
portals. New task-oriented pages aggregate navigation and explanation without
duplicating generated or normative source material.

## Design and Execution

1. Freeze accepted intake, review, Series, Constitution, and D4 hashes in run
   state and evidence.
2. Define the migration schema and prove a failing reference slice before
   changing existing documentation.
3. Create paired root and documentation portals.
4. Move root sections by topic while preserving commands, cautions, and links.
5. Document source/runtime ownership and the four reader paths.
6. Synchronize Documentation Impact governance and all maintained agent/template
   surfaces.
7. Populate and validate the complete section migration matrix.
8. Run semantic, accessibility, security, link, provider, and exact-head gates.
9. Merge one non-empty feature PR and use a causal closeout only for genuinely
   post-merge facts.

## Validation Strategy

- Test-first positive and negative migration fixtures.
- Exact top-level section cardinality and one-decision-per-section validation.
- Markdown target and fragment validation for delivered active paths.
- Reciprocal language links and reader-path depth checks.
- Private absolute path, unsupported decision, open `Gap`, and D6/D7 regression
  rejection.
- Existing documentation, homogeneity, PowerShell, secret, statistics, preset,
  and agent-parity gates selected by changed-path discovery.
- Provider evidence bound to the exact reviewed head.

## Documentation Impact

`UpdateRequired`. Owner: DocumentationArchitecture. Audience: learners, daily
users, maintainers/agents, reviewers. Canonical sources: root/docs portals,
documentation governance, Constitution, templates, and agent guidance.
Distribution: predominantly `sourceOnly`; affected agent guidance follows the
existing Home Runtime manifest. Re-evaluate when reader paths, language pairs,
distribution classes, or command behavior changes.

## Post-Design Constitution Check

Pass. The design preserves runtime behavior, generated and historical
boundaries, explicit authority, learner accessibility, language parity, secure
command guidance, and provider-neutral autonomous evidence.

## Complexity Tracking

No new runtime abstraction or dependency is introduced. The additional JSON
matrix and feature-local validator are justified by AC-DAS-004, AC-DAS-005,
and AC-DAS-016; prose-only review cannot prove complete migration.
