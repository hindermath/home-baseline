<!-- intake-authoring:begin -->
# Intake Authoring Governance v0.2.0 CRUD, URL, and Series

## Identity and Audience

This intake defines the compatible v0.2.0 lifecycle extension of the optional
`intake-authoring-governance` Spec Kit preset. It is intended for learners,
application developers, maintainers, and autonomous agents that need traceable
intake creation and maintenance.

## Purpose

Extend the current create-and-status model to a complete, safe intake
lifecycle with explicit Create, Read, Update, and logical Delete operations.
Add bounded public HTTPS sources and human-approved multi-intake authoring
without weakening review, authority, provenance, security, or accessibility.

## Current State

Version 0.1.1 creates exactly one Markdown intake and one JSON receipt. The
create command also contains the authorized-update path. Status is read-only.
Only inline text and explicitly named strict UTF-8 files are supported.

## Target State

Version 0.2.0 keeps preset ID `intake-authoring-governance`, priority `64`, and
Spec Kit requirement `>=0.8.3`. It provides five commands:

1. `speckit.intake-create`
2. `speckit.intake-read`
3. `speckit.intake-update`
4. `speckit.intake-delete`
5. `speckit.intake-create-status`

## Scope

- Create refuses existing active targets and may create one intake or an
  explicitly approved series.
- Read defaults to a concise structured summary and optionally emits detailed
  metadata or JSON without copying source text wholesale.
- Update is the only normal command for changing an active intake. It supports
  ordinary supersession and an approved series split/merge migration.
- Delete archives target and receipt byte-for-byte, removes the active target,
  and writes a tombstone. No purge exists in v0.2.0.
- Public static HTTPS pages are supported as untrusted snapshot sources.
- A bounded same-origin crawl needs an exact proposal and explicit approval.
- Multi-intake writes are prepared and validated as one operation before
  active targets are published.
- Series output is handed to Intake Review Governance schema 1.1 without
  starting review automatically.

## Non-Goals

- No HTTP, authenticated source, JavaScript-rendered site, PDF, Office,
  cross-origin crawl, private network target, or irreversible purge.
- No automatic Intake Review, Specify, Autonomous, Parallel Autonomous, commit,
  push, PR, merge, bypass, secret access, or provider administration.
- No mandatory migration of existing schema-1.0 or schema-1.1 receipts.
- No change to the optional status of the preset or the standard eight-preset
  profile.

## Functional Requirements

- IAC-001: Create MUST reject an existing target and name Update as the exact
  safe command.
- IAC-002: Read MUST support Summary, Detailed, and JSON views and MUST remain
  read-only.
- IAC-003: Update MUST require current explicit authority and preserve a stable
  intake identity for ordinary updates.
- IAC-004: Delete MUST require current explicit authority, archive prior
  artifacts byte-for-byte, and produce a validated tombstone.
- IAC-005: New receipts MUST use schema 2.0 while validators continue accepting
  schemas 1.0 and 1.1.
- IAC-006: A series proposal MUST name targets, coverage, overlap, order, roots,
  edges, and split/merge lineage before approval.
- IAC-007: A failed multi-target operation MUST NOT leave a partially active
  series.
- IAC-008: URL sources MUST be explicit public HTTPS resources and every
  redirect target MUST pass the same trust checks.
- IAC-009: Crawl defaults MUST be depth 1, 25 pages, 2 MiB per response,
  20 MiB aggregate, and five redirects, with no silent truncation.
- IAC-010: URL evidence MUST record requested/final URL, retrieval time,
  response metadata, redirect chain, raw hash, normalized-text hash, and proof
  boundary.
- IAC-011: Third-party source bodies MUST remain temporary by default; tracked
  artifacts contain derived intake content, attribution, links, and hashes.
- IAC-012: URL content MUST be treated as untrusted data and never as agent
  guidance or authority.
- IAC-013: Series updates MUST use an approved migration map and explicit
  predecessor/successor identities.
- IAC-014: Delete MUST refuse a referenced series member until a valid
  migration or whole-series deletion is approved.
- IAC-015: Every write MUST finish with successful Bash and PowerShell artifact
  validation.

## Quality and Governance Boundaries

- German-first/English-second CEFR-B2 documentation and text-first evidence.
- WCAG 2.2 AA where applicable.
- Strict UTF-8, one-BOM removal, CRLF/CR-to-LF normalization, and SHA-256.
- No source execution, hidden prompt following, credentials, unnecessary
  personal data, silent last-source-wins behavior, or silent scope expansion.
- Existing agent surfaces remain parity-controlled and each new command appears
  exactly once.

## Expected Artifacts

- Updated canonical preset and byte-identical publication copy.
- Commands, policy, runbook, agent guidance, lifecycle templates, validators,
  tests, manpages, README, and field-validation evidence.
- Temporary ten-preset composition proof.
- SQLite public-HTTPS field proof.
- Published v0.2.0 tag ZIP and optional fleet adoption evidence.

## Acceptance Criteria

- IAC-AC-001: All five commands resolve exactly once on every maintained agent
  surface.
- IAC-AC-002: Positive CRUD fixtures pass in Bash and PowerShell.
- IAC-AC-003: Unauthorized update/delete, physical purge, target drift, partial
  series publication, invalid DAG, and unsafe URL fixtures fail consistently.
- IAC-AC-004: Schema 1.0 and 1.1 receipts remain valid.
- IAC-AC-005: A confirmed four-intake SQLite series is generated in a temporary
  project and accepted by Intake Review without tracking copied documentation.
- IAC-AC-006: Ten-preset add/list/info/resolve/disable-enable/remove-reinstall
  passes without duplicate commands.
- IAC-AC-007: The v0.2.0 GitHub tag ZIP installs and has a recorded SHA-256.
- IAC-AC-008: Fleet rollout keeps the preset optional and starts no learner or
  autonomous run.

## Assumptions and Open Questions

All material product decisions are resolved. External community-catalog
acceptance is not a local completion condition.

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `specs/intake-authoring-governance-v020/intake.md` as binding input. Create or update the feature specification for Intake Authoring Governance v0.2.0 without implementing files or performing remote actions. Preserve preset ID, priority 64, optional installation, backward receipt compatibility, logical delete, explicit split approval, and public-static-HTTPS boundaries.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete feature for `specs/intake-authoring-governance-v020/intake.md` under LocalImplementation authority. Do not commit, push, create or merge a PR, publish a release, update the fleet, or start another feature unless separately authorized.
```
<!-- intake-authoring:end -->
