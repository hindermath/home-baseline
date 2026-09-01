# Contract: Renderer Validation and Publication

## Modes and Exit Behavior

Every repository renderer exposes a non-writing validation path and a bounded
write path in its established CLI style.

| Result | Check mode | Write mode |
|---|---:|---:|
| Inputs valid, outputs current | exit `0`, zero writes | exit `0`, zero writes |
| Inputs valid, outputs stale | non-zero, zero writes | exit `0` after atomic publication and verification |
| Invalid/unsafe/ambiguous input | non-zero, zero writes | non-zero, zero writes |
| Publication or post-write verification failure | not applicable | non-zero, rollback to the complete pre-run output set |

Dry-run/`-WhatIf` is a check-class operation and must not create temporary
artifacts inside tracked paths. Diagnostics identify the stable error code,
repository-relative subject, and safe remediation without leaking absolute
workspace roots.

## Required Validation Order

1. Read bytes and reject invalid UTF-8 or NUL.
2. Parse and validate the supported manifest schema and required fields.
3. Validate every declared path lexically: non-empty, relative, no `..`, no
   absolute or drive/UNC form, and no option-like path component.
4. Resolve each path beneath the repository root and reject symlink escapes.
5. Require every intake, evidence, feature, and declared generated parent to
   have the expected file-system type.
6. Validate entry uniqueness, dependency endpoints, edge values, display
   positions, backlog separation, and feature-proof cardinality.
7. Build all output candidates in memory or outside tracked paths.
8. Compare all candidates with existing outputs.
9. In write mode only, recheck source hashes and target containment, publish
   the complete output set atomically, and verify final hashes.

No renderer executes manifest content, interpolates it into a shell command,
or performs network access.

## Stable Diagnostic Families

| Code | Meaning |
|---|---|
| `LIE001` | Invalid UTF-8 or embedded NUL |
| `LIE002` | Unsupported or malformed manifest schema |
| `LIE003` | Absolute, traversal, drive/UNC, or option-like path |
| `LIE004` | Missing target or wrong file-system type |
| `LIE005` | Repository-containment or symlink escape |
| `LIE006` | Duplicate entry, position, or contradictory canonical identity |
| `LIE007` | Unknown endpoint or invalid dependency tuple |
| `LIE008` | Ambiguous or invalid feature evidence |
| `LIE009` | Generated output is stale in check mode |
| `LIE010` | Publication or post-write verification failed |
| `LIE011` | Root/series views disagree semantically |
| `LIE012` | Cross-implementation parity mismatch |

Repositories may retain an established prefix, but tests must map it
one-to-one to these semantic families.

## Multi-Output Atomicity

When a renderer owns both root and series views, both candidates are validated
before either is replaced. Publication uses same-filesystem temporary files
and atomic replacement where the platform permits it. The renderer retains
the previous complete set until all replacements verify. On any failure, it
restores the previous complete set and reports `LIE010`.

Signals and ordinary errors clean up only renderer-owned temporary files.
No broad recursive deletion, unresolved glob, repository reset, or unrelated
file cleanup is permitted.

## Parity

Home Baseline and Agent Operations Cockpit use one fixture corpus for Bash and
PowerShell. Both implementations must agree on:

- row fields and order;
- resolved relative link strings;
- feature states and ambiguity behavior;
- dependency order, `kind`, and `binding`;
- diagnostic family and success/failure exit class;
- output line-ending policy and zero-write count.

Platform-specific path separators may appear only in internal diagnostics
where unavoidable; generated Markdown always uses `/`.

## Required Fixtures

Positive fixtures cover a root row, multiple incoming edges, completed entries
with and without feature proof, explicit stable display position, non-ASCII
filenames, and two generated views. Negative fixtures cover invalid encoding,
NUL, absolute paths, `..`, leading options, missing files, wrong types, symlink
escape, unknown dependency endpoint, duplicate identity, multiple feature
candidates, and simulated publication failure.

The TuiVision exact fixture is mandatory in addition to the generic corpus.

## Evidence

Each proof captures exact commit, command, platform/runner, exit code, input or
payload SHA-256, decision SHA-256, and write count. A second unchanged
write-mode invocation must leave `git diff --exit-code` clean. Syntax-only,
emulated, stale-head, or manually edited output is labelled partial and cannot
satisfy the native platform gate.
