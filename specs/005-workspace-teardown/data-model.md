# Data Model: Workspace- und Projekt-Teardown

**Feature**: `005-workspace-teardown` | **Date**: 2026-04-10

---

## Entities

### TeardownContext

Runtime state assembled from CLI arguments before any action.

| Field | Type | Source | Description |
|-------|------|--------|-------------|
| `workspace_name` | string | CLI arg | Raw name as provided by user (e.g., `MyProjects`) |
| `workspace_dir` | path | derived | `~/WorkspaceName/` — absolute path |
| `normalized_name` | string | derived | kebab-case (e.g., `my-projects`) — used for `.inc` filename |
| `dry_run` | bool | `--dry-run` / `-WhatIf` | When true: display actions, no writes |
| `force` | bool | `--force` / `-Force` | Skip safety checks (uncommitted + unpushed) |
| `yes` | bool | `--yes` / `-Yes` | Skip interactive confirmation prompt |
| `backup` | bool | `--backup` / `-Backup` | Create tar.gz before destructive steps |
| `keep_remote` | bool | `--keep-remote` / `-KeepRemote` | Skip remote repo deletion |
| `recursive` | bool | `--recursive` / `-Recursive` | Process Level-2 projects before workspace teardown |
| `home_repo_available` | bool | derived | `~/` is a git repository; controls whether the artifact cleanup can be committed |

### Workspace

| Field | Type | Notes |
|-------|------|-------|
| `name` | string | Directory name under `~/` |
| `path` | path | Absolute path `~/WorkspaceName/` |
| `remote_url` | string \| null | `git remote get-url origin` output; null if no remote |
| `platform` | `github` \| `gitlab` \| `other` \| null | Detected from remote URL |
| `owner_repo` | string \| null | `owner/repo` extracted from remote URL |
| `level2_projects` | Level2Project[] | Direct child dirs with `.git/` (depth 1 only) |
| `has_uncommitted` | bool | `git status --porcelain` non-empty |
| `has_unpushed` | bool | `git log @{u}..HEAD` non-empty (when upstream exists) |

### Level2Project

| Field | Type | Notes |
|-------|------|-------|
| `name` | string | Directory name |
| `path` | path | Absolute path `~/WorkspaceName/ProjectName/` |
| `remote_url` | string \| null | Same detection as Workspace |
| `platform` | `github` \| `gitlab` \| `other` \| null | Same detection as Workspace |
| `owner_repo` | string \| null | Same extraction as Workspace |
| `has_uncommitted` | bool | Same check as Workspace |
| `has_unpushed` | bool | Same check as Workspace |

### ArtifactSet

Set of external references that must be cleaned up after workspace deletion.

| Artifact | Location | Present When | Removal |
|----------|----------|--------------|---------|
| README entry | `~/README.md` line `\| WorkspaceName \| ... \|` | Always (bootstrapped) | `grep -v` / array filter; skip silently if absent |
| .gitignore entry | `~/.gitignore` line `WorkspaceName/` | Always (bootstrapped) | `grep -v` / array filter; skip silently if absent |
| gitconfig includeIf block | `~/.gitconfig` — `[includeIf "gitdir:~/WorkspaceName/"]` + path line | When feature 003 was used | `awk` multi-line delete; skip if absent |
| .inc file | `~/.gitconfig.d/<normalized-name>.inc` | When feature 003 was used | `rm -f`; skip if absent |

**Commit scope**: Only `~/README.md` and `~/.gitignore` are git-tracked in `~/`; committed together as one atomic commit including the required `Co-authored-by` trailer. `.gitconfig` and `.inc` file are filesystem-only operations. If `home_repo_available = false`, file cleanup still occurs but the commit is skipped with warning and Exit 1.

### BackupArchive

| Field | Type | Notes |
|-------|------|-------|
| `path` | path | `~/WorkspaceName-backup-YYYY-MM-DD.tar.gz` |
| `path` (collision) | path | `~/WorkspaceName-backup-YYYY-MM-DD-1.tar.gz`, `-2`, etc. (numeric suffix) |
| `created_before` | string | "first destructive step" (Step 3 remote delete or Step 4 local delete) |

---

## State Transitions

```text
Workspace lifecycle:

  [exists] ──dry-run──→ [display only, no change]
      │
      ├──[safety fail, no --force]──→ [abort, Exit 1]
      │
      ├──[home-baseline name]──→ [abort, Exit 2]
      │
      ├──[Level-2 detected, no --recursive]──→ [abort, Exit 1]
      │
      └──[confirmed]──→ Step 1: Backup (if --backup)
                            │
                            ▼
                        Step 2: Safety Checks (skip if --force)
                            │
                            ▼
                        Step 3: Remote Delete (skip if no remote or --keep-remote)
                            │
                            ├──[fails after attempted delete]──→ [abort Steps 4+5, Exit 1]
                            │
                            ▼
                        Step 4: Local Directory Delete
                            │
                            ▼
                        Step 5: Artifact Cleanup + Commit
                            │
                            ├──[~/ not a git repo]──→ [cleanup done, commit skipped, Exit 1]
                            │
                            ▼
                        [done, Exit 0]
```

**--recursive pre-processing** (before Step 1 of workspace): For each Level-2 project, run Steps 2–4 (backup optional per-project, no artifact commit per Level-2). Then proceed to workspace Steps 1–5.

---

## Identity & Uniqueness Rules

- `workspace_name` must be an existing directory under `~/` (verified at startup)
- `workspace_name = "home-baseline"` is explicitly rejected (FR-015)
- `normalized_name` is derived deterministically from `workspace_name` — must match what was written by bootstrap-workspace (same `normalize_name()` function)
- Archive names are unique per day via collision counter; no overwrite ever occurs
