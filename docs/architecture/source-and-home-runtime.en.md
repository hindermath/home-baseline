# Level 0 source and Home Runtime

[Deutsche Fassung](source-and-home-runtime.md)

## Terms

The **Level 0 source** is the permanent versioned
`~/home-baseline-source` checkout. Canonical changes, commits, pull requests,
and pushes originate there.

The **Home Runtime** is a manifest-controlled selection of operational files
under `~/`. The term does not describe the complete home directory. The runtime
provides stable invocation paths, but it is not a second source.

**Machine-local state** includes private evidence, caches, settings, and ledgers
that are neither published nor overwritten from source.

## Distribution classes

| Class | Canonical edit location | Sync | Remote boundary |
|---|---|---|---|
| `homeRuntime` | Level 0 source | after delivery through `sync-home.*` | never push the runtime copy directly |
| `sourceOnly` | Level 0 source | none | read directly from the checkout |
| `machineLocal` | local machine | none | no implicit publication |

Current membership is defined by
[`scripts/config/home-sync-manifest.json`](../../scripts/config/home-sync-manifest.json).
Documentation does not duplicate a manually maintained total.

## Directed synchronization path

1. Change and validate in Level 0.
2. Commit, review, and merge under repository rules.
3. Inspect `sync-home.*` with `--check-only` or `-CheckOnly` first.
4. Synchronize only manifest-bound runtime files.
5. Preserve machine-local files and private state.

Source-only changes require no Home sync. Runtime changes are not repaired first
under `~/`, where a later sync could overwrite them or retain an unpublished
divergence.

## Host and container

Normal writing Home sync runs only on the host. An ABS-DD sandbox reads the
mounted Level 0 reference and does not write the host runtime. For an explicitly
requested runtime copy inside the container, it may use
`sync-home.* --runtime-only` or `-RuntimeOnly`. This mode distributes only
`homeRuntime`, performs no pull or commit, and changes neither Git configuration
nor Git identity. Local conflicts stop the run before the first write. Agentic
work on Secure Trader systems runs in the approved sandbox; general read-only
analysis may run outside it.

## Maintainers and AI agents

Before a change:

1. Determine the target path and distribution class.
2. Verify the canonical source and owner.
3. Select the Documentation Impact decision.
4. Consider the language partner, navigation, platform, and accessibility.
5. Plan Home sync only for `homeRuntime` and only after canonical delivery.

Commit, push, merge, force, or administrative authority is never inferred from
a local path, runtime copy, or general autonomy.

The
[maintainer and agent path](../maintenance/agentic-workspace-efficiency-guide.en.md#maintainer-und-ki-agenten-maintainers-and-ai-agents)
adds authority modes, serialization boundaries, and a reusable agent prompt.

## Benefits and non-goals

The separation provides a clean publication history, stable operational entry
points, bounded distribution, protection of local data, and reproducible
updates. It is not a second repository, a backup of every home file, or
authority to delete local changes broadly.
