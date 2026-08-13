# home-baseline

[Deutsche Fassung](README.md)

`home-baseline` is the versioned Level 0 source for a secure, cross-platform,
AI-agent-assisted development workspace. It manages shared scripts, governance,
Spec Kit presets, documentation rules, and learning material. No prior Spec Kit
experience is required to start here.

## Start safely

Use the permanent `~/home-baseline-source` checkout for changes, commits, pull
requests, and pushes. The home directory `~/` contains only the selected
**Home Runtime**, meaning operational copies and machine-local state. It is not
a second Level 0 source.

Preview a writing maintenance run first:

```bash
# macOS or Linux: inspect and preview planned changes
bash scripts/maintain-agentic-workspace.sh --dry-run
```

```powershell
# Windows with PowerShell 7: inspect and preview planned changes
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
```

The preview may perform safe remote reads, but it does not modify working files.
Review the text-oriented result and its exact next action before authorizing a
real run.

## Choose your reader path

| You want to ... | Entry | Next action |
|---|---|---|
| learn or get started | [Learning path](docs/learning-units/START-HERE-FUER-LERNENDE.md) | choose occupation, training year, and first unit |
| maintain the workspace day to day | [Maintenance](docs/maintenance/README.en.md) | select the platform and run a preview |
| work as a maintainer or AI agent | [Source and Home Runtime](docs/architecture/source-and-home-runtime.en.md) | identify the canonical edit location and sync need |
| audit or troubleshoot | [Audit and troubleshooting](docs/troubleshooting/README.en.md) | identify the head, evidence, and proof boundary |

The detailed
[efficiency guide](docs/maintenance/agentic-workspace-efficiency-guide.en.md)
connects these four reader paths with safe commands, evidence, and clear stop
boundaries.

## Local model routing for AI agents

**Model routing** maps a stable work role such as `frontier-reasoning` or
`fast-mechanical` to a model that the locally installed agent harness actually
provides. Spec Kit artefacts therefore name roles, not short-lived model IDs.

The optional `model-routing-governance` preset at priority `61` discovers local
harness capabilities, for example through Codex or Antigravity. It publishes no
model inventory and handles no credentials. The concrete choice remains in a
`machineLocal` configuration on each computer. Unknown or ambiguous mappings
are blocked and never guessed.

```bash
# Read only: inspect harness capabilities and the local binding
bash scripts/resolve-model-routing.sh -Action Status -Harness Codex \
  -RoutingRoot .specify/presets
```

```powershell
# Explicit local refresh; no repository file is changed
pwsh -NoProfile -File scripts/resolve-model-routing.ps1 `
  -Action Refresh -Harness Codex -RoutingRoot .specify/presets
```

The one-command maintenance run performs only the read-only status check after
toolchain maintenance. Refresh requires current local authority. Autonomous
presets may change models only at validated phase boundaries in a new process.
This grants neither delivery nor provider authority.

The new storage stage follows: `Safe` inventories and reclaims verified
Level-2 build outputs and selected caches; pressure mode applies below 15
percent free space. `Deep` requires a separate confirmation for an update run,
while `scripts-only` selects `None`. Curated non-MSL adapters preserve the
justifications and build evidence of `cc65` and `tvision`; container volumes
always remain untouched. See the
[maintenance portal](docs/maintenance/README.en.md#storage-cleanup).

The complete [documentation portal](docs/README.en.md) organizes every topic
and canonical source. The [script reference](docs/scripts/reference.md) lists
available commands, platforms, and safe inspection modes.

## Prerequisites

- Git and a personal or institutional Git repository;
- PowerShell 7 on Windows and Bash on macOS/Linux;
- `gh` for GitHub or `glab` for GitLab only when you use that platform;
- Python 3 and `pwsh` for the complete governance checks;
- an approved sandbox for agentic work on Secure Trader systems.

Detailed installation guidance is available in
[Getting started](docs/getting-started.en.md). GitHub is one supported profile,
not a universal learner prerequisite.

## Security and accessibility boundaries

- `Programmierung #include<everyone>` applies to documentation, CLI, and UI.
- User-facing content follows German first, English second, CEFR B2, and
  applicable WCAG 2.2 AA criteria.
- Secrets, production data, and personal absolute paths do not belong in commits
  or publishable evidence.
- Agentic work on Secure Trader systems runs container-first in an approved
  sandbox.
- Maintenance scripts do not commit, push, or merge in target repositories.
- Remote or administrative authority requires an explicit current grant.

See the [security documentation](docs/security/README.md),
[maintenance TUI accessibility](docs/accessibility/maintenance-tui.md), and
[documentation governance](docs/documentation-governance.md).

## Source, runtime, and local state

Three distribution classes prevent confusion between source, operational copy,
and private machine data:

- `homeRuntime`: changed canonically in Level 0 and then synchronized to `~/`
  through the manifest;
- `sourceOnly`: read directly from `~/home-baseline-source` and requires no Home
  sync;
- `machineLocal`: remains on the machine and receives no implicit remote
  authority.

The complete owner, sync-trigger, and container model is documented in
[Source and Home Runtime](docs/architecture/source-and-home-runtime.en.md).
Concrete runtime membership is derived from
[`scripts/config/home-sync-manifest.json`](scripts/config/home-sync-manifest.json).

## Contributing changes

1. Read `AGENTS.md` and the Constitution.
2. Work on a current `codex/` or numbered feature branch.
3. Use the affected script's safe inspection mode before making changes.
4. Record exactly one Documentation Impact decision.
5. Run affected tests, links, language-partner, accessibility, and security checks.
6. Open a pull request against the canonical default branch.

More detail is available in the
[maintainer and agent path](docs/architecture/source-and-home-runtime.en.md#maintainers-and-ai-agents)
and the [repository guidelines](AGENTS.md).
