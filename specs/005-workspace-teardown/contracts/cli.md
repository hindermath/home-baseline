# CLI Contract: teardown-workspace

**Feature**: `005-workspace-teardown` | **Date**: 2026-04-10

---

## Command Signatures

### Bash

```text
teardown-workspace.sh <WorkspaceName> [OPTIONS]

OPTIONS:
  --backup        Create ~/WorkspaceName-backup-YYYY-MM-DD.tar.gz before deletion
  --keep-remote   Skip remote repo deletion
  --recursive     Process Level-2 projects before workspace teardown
  --force         Skip safety checks (uncommitted changes + unpushed commits)
  --yes           Skip interactive confirmation prompt
  --dry-run       Display all planned actions without executing any
  --help          Show usage
```

### PowerShell

```text
teardown-workspace.ps1 -WorkspaceName <string> [OPTIONS]

OPTIONS:
  -Backup         Create ~/WorkspaceName-backup-YYYY-MM-DD.tar.gz before deletion
  -KeepRemote     Skip remote repo deletion
  -Recursive      Process Level-2 projects before workspace teardown
  -Force          Skip safety checks (uncommitted changes + unpushed commits)
  -Yes            Skip interactive confirmation prompt
  -WhatIf         Display all planned actions without executing any (standard PS)
```

### bootstrap-workspace alias (FR-014)

```text
# Bash — delegates to teardown-workspace.sh
bootstrap-workspace.sh --teardown <WorkspaceName> [OPTIONS]

# PowerShell — delegates to teardown-workspace.ps1
bootstrap-workspace.ps1 -Teardown -WorkspaceName <Name> [OPTIONS]
```

All OPTIONS from teardown-workspace are passed through unchanged.

---

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Success — all planned actions completed or were intentionally skipped by user choice (e.g., `--keep-remote`) |
| 1 | Warning / partial / abort — a required step was skipped with warning or the run aborted safely (e.g., `tar` unavailable, GitLab remote skipped because `glab` is missing, remote deletion failed without `--keep-remote`, artifact commit skipped because `~/` is not a git repo, safety check failed without `--force`) |
| 2 | Usage error — `home-baseline` protected name, workspace directory not found, `--dry-run` on non-existent workspace |

---

## Output Contract

### Preamble Box (before confirmation)

```text
╔══════════════════════════════════════════════════════════════════╗
║  teardown-workspace — Workspace-Entfernung / Workspace Removal  ║
╠══════════════════════════════════════════════════════════════════╣
║  Workspace:   MyProjects                                        ║
║  Pfad / Path: /Users/username/MyProjects/                       ║
╠══════════════════════════════════════════════════════════════════╣
║  Geplante Aktionen / Planned actions:                           ║
║    1. [BACKUP]  ~/MyProjects-backup-2026-04-10.tar.gz           ║
║    2. Sicherheitsprüfung / Safety check                         ║
║    3. Remote-Repo löschen / Delete remote repo (GitHub)         ║
║    4. Verzeichnis löschen / Delete directory                    ║
║    5. Artefakte bereinigen / Clean up artifacts:                ║
║       - ~/README.md (Tabelleneintrag / table row)               ║
║       - ~/.gitignore (Eintrag / entry)                          ║
║       - ~/.gitconfig (includeIf-Block / includeIf block)        ║
║       - ~/.gitconfig.d/my-projects.inc                          ║
╚══════════════════════════════════════════════════════════════════╝
```

For `--recursive`, Level-2 project actions appear before Step 1.

### Confirmation Prompt

```text
Fortfahren? / Proceed? [y/N]:
```

Only a `y` (case-insensitive) proceeds. Default is N (abort). Skipped with `--yes` / `-Yes`.

### Completion Report

Bilingual report after all actions:

```text
╔══════════════════════════════════════════════════════════════════╗
║  Teardown abgeschlossen / Teardown complete                     ║
╠══════════════════════════════════════════════════════════════════╣
║  ✓ Backup erstellt / Backup created                             ║
║  ✓ Remote-Repo gelöscht / Remote repo deleted                   ║
║  ✓ Verzeichnis gelöscht / Directory deleted                     ║
║  ✓ README.md bereinigt / README.md cleaned up                   ║
║  ✓ .gitignore bereinigt / .gitignore cleaned up                 ║
║  ✓ .gitconfig bereinigt / .gitconfig cleaned up                 ║
║  ✓ Artefakte committed / Artifacts committed                    ║
║  → Übersprungen / Skipped: .gitconfig.d (nicht vorhanden)       ║
╚══════════════════════════════════════════════════════════════════╝
```

Each action shows ✓ (done), → (skipped), or ✗ (failed with warning).

### --dry-run Output

All actions listed with `[DRY-RUN]` prefix; no files modified. Box shown with `[DRY-RUN]` header. Exit 0.

---

## Behavioral Invariants

1. `--dry-run` NEVER writes to the filesystem and NEVER creates the artifact commit (SC-001)
2. Without `--force`, uncommitted changes OR unpushed commits cause Exit 1 before any action (FR-002, SC-004)
3. Remote deletion failure blocks local deletion and artifact cleanup unless the remote step was explicitly skipped with `--keep-remote` (FR-004)
4. Backup (if requested) always precedes any destructive step (FR-004 Step 1)
5. Artifact cleanup runs as a single atomic commit over tracked files only (`~/README.md`, `~/.gitignore`) and the commit message includes the required `Co-authored-by` trailer; if `~/` is not a git repo, cleanup still runs but the commit is skipped with Exit 1 (FR-006 clarification)
6. `home-baseline` as WorkspaceName always exits 2, regardless of other flags (FR-015)
7. `--force` propagates to all Level-2 projects in `--recursive` mode (FR-010 clarification)
8. Confirmation prompt covers all planned actions (Level-2 + workspace) in one prompt (FR-011 clarification)
