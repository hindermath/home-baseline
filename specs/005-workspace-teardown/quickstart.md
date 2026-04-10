# Quickstart: teardown-workspace

**Feature**: `005-workspace-teardown` | **Date**: 2026-04-10

---

## Most Common Uses

### Preview (always start here)

```bash
# Bash — show all planned actions without executing
bash ~/scripts/teardown-workspace.sh --dry-run MyProjects

# PowerShell
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName MyProjects -WhatIf
```

### Standard Teardown

```bash
# Bash — interactive confirmation required
bash ~/scripts/teardown-workspace.sh MyProjects

# PowerShell
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName MyProjects
```

### With Backup

```bash
# Creates ~/MyProjects-backup-2026-04-10.tar.gz before deletion
# If the file already exists, the script uses -1, -2, ... suffixes
bash ~/scripts/teardown-workspace.sh MyProjects --backup
```

### Keep Remote Repo

```bash
# Delete local directory only; GitHub/GitLab repo stays
bash ~/scripts/teardown-workspace.sh MyProjects --keep-remote
```

### Workspace with Level-2 Projects

```bash
# Without --recursive: aborts and lists Level-2 projects
bash ~/scripts/teardown-workspace.sh MyProjects

# With --recursive: removes all Level-2 repos, then workspace
bash ~/scripts/teardown-workspace.sh MyProjects --recursive
```

### Non-interactive (CI / scripted)

```bash
bash ~/scripts/teardown-workspace.sh MyProjects --yes --backup
```

### Via bootstrap-workspace alias

```bash
# Identical to calling teardown-workspace.sh directly
bash ~/scripts/bootstrap-workspace.sh --teardown MyProjects --dry-run
```

---

## Step-by-Step: What Happens

1. **Preamble box** displayed — all planned actions listed
2. **Confirmation prompt** — type `y` to proceed (or pass `--yes`)
3. **Backup** (if `--backup`) — `~/MyProjects-backup-YYYY-MM-DD.tar.gz` created
4. **Safety checks** (skip with `--force`) — abort if uncommitted changes or unpushed commits exist
5. **Remote deletion** — GitHub via `gh`, GitLab via `glab` (skip with `--keep-remote`; no configured remote is skipped; a failed delete aborts before local deletion)
6. **Local deletion** — `rm -rf ~/MyProjects/`
7. **Artifact cleanup** — remove `~/README.md` row, `~/.gitignore` entry, `~/.gitconfig` includeIf block, `~/.gitconfig.d/<name>.inc`
8. **Atomic commit** — all tracked artifact changes committed in `~/` with `Co-authored-by`; if `~/` is not a git repo, this step is skipped with warning and Exit 1
9. **Completion report** — bilingual summary of all actions taken/skipped

---

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Full success |
| 1 | Warning, partial completion, or safe abort (e.g., `tar` missing, remote delete failed, artifact commit skipped because `~/` is not a git repo) |
| 2 | Usage error (protected name, workspace not found) |

---

## Protected Names

`home-baseline` cannot be torn down (FR-015). This exits 2 immediately regardless of flags.
