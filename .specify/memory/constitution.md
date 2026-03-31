<!--
SYNC IMPACT REPORT
==================
Version change: (none) → 1.0.0  (initial ratification from template)
Principles added:
  I.   Security-First
  II.  Cross-Platform Parity
  III. Bootstrap Automation
  IV.  Workspace Isolation
  V.   Manual-First Verification
Sections added:
  - Script & Code Conventions
  - Commit & Pull Request Standards
  - Governance
Templates reviewed:
  ✅ .specify/templates/plan-template.md  — Constitution Check section is generic, no update needed
  ✅ .specify/templates/spec-template.md  — generic template, no principle-driven changes required
  ✅ .specify/templates/tasks-template.md — generic template, no principle-driven changes required
  ✅ README.md                            — already reflects all principles; no update required
  ✅ AGENTS.md                            — already reflects all principles; no update required
  ✅ CLAUDE.md                            — already reflects all principles; no update required
  ✅ GEMINI.md                            — already reflects all principles; no update required
Deferred items:
  None — all placeholders resolved.
-->

# home-baseline Constitution

## Core Principles

### I. Security-First (NON-NEGOTIABLE)

Every file tracked in any workspace repository MUST be safe to publish.
The `.gitignore` in every workspace uses a **whitelist model**: everything is
excluded by default (`/*`, `/.*`), and only explicitly listed safe entries are
allowed.

Non-negotiable rules:
- AI agent state directories (`.claude/`, `.codex/`, `.gemini/`, `.junie/`,
  `.opencode/`) MUST never be tracked in any Git repository.
- Credential files (`.env*`, `*.key`, `*.pem`, `*secret*`, `.aws/`, `.ssh/`,
  `.kube/`, `.docker/`, `.gnupg/`) MUST never be tracked.
- Every workspace MUST have a `pre-push` hook installed that blocks pushes
  containing secret-like filenames or credential patterns (tokens matching
  `ghp_*`, `sk-*`, `AKIA*`, `AIza*`, PEM private-key headers).
- `scripts/scan-agent-secrets.sh --fail-on-high` MUST be run before pushing
  any change that touches hook or scanner logic.

**Rationale**: Accidental secret exposure in a private repo is a critical security
incident. Automated prevention at push time is the last reliable gate.

### II. Cross-Platform Parity

Every critical script MUST exist in two variants:
- Bash (`.sh`) for macOS/Linux
- PowerShell Core 7+ (`.ps1`) for Windows

Both variants MUST provide identical functionality and produce equivalent output.
A new script is not considered complete until both variants exist, pass manual
verification, and are committed together in the same commit.

**Rationale**: The workspace is used on macOS (Mac Mini M4 Pro, MacBook Air M2)
and may be used on Windows. Bash-only or PowerShell-only scripts create a
second-class experience on one platform.

### III. Bootstrap Automation

New workspaces MUST be created exclusively via the bootstrap scripts:
- `bash ~/scripts/bootstrap-workspace.sh <WorkspaceName>` (macOS/Linux)
- `pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Name>` (Windows)

Manual `git init` + `gh repo create` outside the bootstrap flow is prohibited
for new workspaces. The bootstrap script is the single authoritative source of
the correct workspace setup sequence.

`~/README.md` MUST be updated (automatically or manually) whenever a new
workspace is added. The workspace table anchor `<!-- workspace-table-end -->`
MUST be preserved.

**Rationale**: Consistency across all workspaces — same `.gitignore` whitelist,
same scripts, same hooks — can only be guaranteed by a single automated flow.

### IV. Workspace Isolation

Each workspace directory under `~/` is an **independent Git repository**.
Git submodules MUST NOT be used. Sub-repositories inside a workspace are
detected by the bootstrap script and excluded via `.gitignore` entries.

Rules:
- The `home-baseline` repo tracks only root-level infrastructure files
  (scripts, `.gitignore`, `README.md`, AI agent guidance files).
- Changes to `home-baseline` scripts do NOT auto-propagate to child workspaces;
  workspaces sync manually by re-running the relevant script or copying updates.
- Each workspace owns its own `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and
  `.github/copilot-instructions.md`.

**Rationale**: Submodules create fragile cross-repo coupling. Independent repos
give each workspace its own clean history and deployment lifecycle.

### V. Manual-First Verification

There is no automated CI/CD pipeline for `home-baseline` scripts. Verification
is manual and MUST follow the safe-mode-first rule:

- Bootstrap changes: always test with `--dry-run` (Bash) / `-WhatIf` (PowerShell)
  before running for real.
- Hook changes: reinstall with `bash scripts/install-hooks.sh` after every edit
  under `scripts/hooks/`, then verify behaviour manually.
- Scanner changes: run `bash scripts/scan-agent-secrets.sh --fail-on-high .`
  and confirm expected exit codes before committing.

Automated test tooling MUST NOT be added to this repository unless a formal
decision is made and documented in this constitution (Governance section).

**Rationale**: The scripts are low-churn infrastructure. The overhead of a test
framework would exceed the benefit for the current scope.

## Script & Code Conventions

Coding style rules that apply to all scripts in this repository:

- **Bash shebang & safety flags**: `#!/usr/bin/env bash` + `set -euo pipefail`
- **PowerShell header**: `#Requires -Version 7` + `Set-StrictMode -Version Latest`
  \+ `$ErrorActionPreference = 'Stop'`
- **Indentation**: 2 spaces in Bash, 4 spaces in PowerShell
- **Filenames**: kebab-case (e.g., `bootstrap-workspace.sh`)
- **PowerShell parameters**: PascalCase (e.g., `-WorkspaceName`, `-WhatIf`)
- **Bash variables**: lowercase_underscore (e.g., `repo_name`)
- **User-facing messages**: German primary (`Fehler:`, `Verzeichnis nicht gefunden`);
  English is acceptable in code comments
- **Visual output**: box-drawing characters (╔, ║, ╚, ✓, →) for structured console blocks

## Commit & Pull Request Standards

- **Commit message format**: Conventional Commits — `chore:`, `docs:`, `feat:`, `fix:`
  followed by a short imperative subject line
- **Co-authored-by trailer**: Every commit MUST include:
  ```
  Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
  ```
- **PR description MUST include**:
  - Which scripts or docs are affected
  - Manual verification commands run (with `--dry-run` / `-WhatIf` output)
  - Sample console output when user-visible output changes
  - Explicit security risk statement for any change touching hook or scanner logic

## Governance

This constitution supersedes all other practices documented in AGENTS.md,
CLAUDE.md, GEMINI.md, and `.github/copilot-instructions.md` where they conflict.
Those files provide runtime guidance for AI agents; this constitution defines
non-negotiable structural rules.

**Amendment procedure**:
1. Propose the change in a PR; describe the principle being added, changed, or removed.
2. Update `LAST_AMENDED_DATE` to the PR merge date.
3. Increment `CONSTITUTION_VERSION` following semantic versioning:
   - MAJOR: backward-incompatible principle removal or redefinition
   - MINOR: new principle or section added / materially expanded guidance
   - PATCH: clarifications, wording fixes, non-semantic refinements
4. Propagate any principle changes to dependent templates
   (`.specify/templates/plan-template.md`, `spec-template.md`, `tasks-template.md`)
   and AI agent guidance files, committing all changes atomically.
5. All PRs and AI-assisted sessions MUST verify compliance with the current
   version of this constitution before committing code or scripts.

**Version policy**: Constitution version is independent of any software release
version. It tracks the governance document's own evolution.

**Compliance review**: Any change to `scripts/hooks/pre-push` or
`scripts/scan-agent-secrets.*` MUST explicitly state in the PR which security
rule (Principle I) it affects and include scanner output confirming no regressions.

**Runtime guidance**: Use `AGENTS.md` / `CLAUDE.md` / `GEMINI.md` for
per-agent operational guidance. This constitution is the authoritative policy
layer above all agent-specific files.

**Version**: 1.0.0 | **Ratified**: 2026-03-31 | **Last Amended**: 2026-03-31
