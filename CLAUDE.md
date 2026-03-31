# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the **home-baseline** repository — the top-level workspace infrastructure for `~`. It manages bootstrapping new project workspaces as private GitHub repositories and enforces security across all projects.

## Scripts

All scripts live in `~/scripts/` and come in paired Bash (`.sh`) and PowerShell Core (`.ps1`) variants for cross-platform support.

### Bootstrap a new workspace

```bash
# macOS/Linux
bash ~/scripts/bootstrap-workspace.sh <WorkspaceName> [repo-name] [description]
bash ~/scripts/bootstrap-workspace.sh --dry-run <WorkspaceName>   # preview only

# Windows (pwsh >= 7)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Name> [-RepoName <r>] [-WhatIf]
```

The script: detects existing sub-repos → adds them to `.gitignore` → copies standard scripts → `git init` + initial commit → creates private GitHub repo via `gh repo create` → pushes → installs hooks → updates `~/README.md`.

### Install Git hooks

```bash
bash ~/scripts/install-hooks.sh          # macOS/Linux
pwsh ~/scripts/install-hooks.ps1         # Windows
```

### Scan AI agent directories for secrets

```bash
bash ~/scripts/scan-agent-secrets.sh [--fail-on-high]
pwsh ~/scripts/scan-agent-secrets.ps1
```

Scans `.claude/`, `.codex/`, `.gemini/`, `.junie/`, `.opencode/` for leaked credentials. Outputs `high=N medium=M low=L total=T`. Use `--fail-on-high` as a CI gate.

## Security Architecture

The `.gitignore` uses a **whitelist model** (`/*` ignores everything; only explicitly listed files are tracked). Never add AI agent directories (`.claude/`, `.junie/`, etc.), credentials files, or dotfiles containing secrets to the tracked whitelist.

The `scripts/hooks/pre-push` hook blocks pushes if secret-like filenames or credential patterns are found in tracked files. It is installed into `.git/hooks/` by `install-hooks.sh`.

Secrets are stored in macOS Keychain, accessed via the shell helpers in `~/.zshrc` (`_keychain_secret`, `with_keychain_env`, `with_chat_ai_api_key`).

## Workspace Structure

Each sub-directory is an **independent git repository** (not a submodule). They are excluded from home-baseline tracking via `.gitignore`. Current workspaces:

| Directory | GitHub Repo |
|---|---|
| `~/RiderProjects/` | `hindermath/riderprojects-baseline` |
| `~/DataGripProjects/` | `hindermath/datagrip-baseline` |
| `~/C64Projects/` | `hindermath/c64projects-baseline` |

When adding a new workspace to `~/README.md`, insert a table row before the `<!-- workspace-table-end -->` marker.

## README Maintenance

`~/README.md` is auto-updated by `bootstrap-workspace.sh` when a new workspace is created. The workspace table uses `<!-- workspace-table-end -->` as an insertion anchor. If editing manually, preserve that marker.
