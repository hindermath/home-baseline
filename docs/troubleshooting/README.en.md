# Audit and troubleshooting

[Deutsche Fassung](README.md)

## Before repairing anything

1. Identify repository, branch, and exact commit.
2. Inspect working tree, index, untracked paths, and worktrees read-only.
3. Resolve accepted artifact hashes and the last passing gate.
4. Evaluate report, live evidence, and exit code together.
5. Treat a stale or incomplete operation as requiring revalidation.

Do not use broad reset, clean, stash, or deletion commands. Re-inventory the
candidate set after any state change.

## Common findings

### The local branch is behind the remote

Run `fetch --prune` first. `pull --ff-only` is allowed only on a clean,
unambiguous default branch with `ahead=0`. Otherwise document the finding and
exact next action.

### An autonomous run was interrupted

Run `$speckit-autonomous-status` read-only first. The general Autonomous command
must not overwrite an existing run. Continue only through
`$speckit-autonomous-resume` with renewed authority.

### Live evidence is incomplete

For `EVENT_STREAM_DEGRADED`, verify the pre-bound final report and exit code. A
missing event is neither automatic success nor automatic failure.

### Documentation and behavior disagree

Identify the canonical source, document class, generator, and exact
implementation head. A technical validator proves structure; semantic review
checks meaning and comprehensibility.

## Evidence paths

- current project development: [project statistics](../project-statistics.md)
- script contracts: [script reference](../scripts/reference.md)
- security: [security documentation](../security/README.md)
- autonomous features: matching `specs/NNN-*/autonomous-run-evidence.md`
- historical or archived evidence: read unchanged; do not correct retroactively

**Next action:** Use evidence only for its exact accepted head. Repeat the
affected validation completely when drift exists.
