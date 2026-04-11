# Implementation Plan: Workspace- und Projekt-Teardown / Workspace and Project Teardown

**Branch**: `005-workspace-teardown` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `specs/005-workspace-teardown/spec.md`

---

## Summary

Implements two new paired scripts (`teardown-workspace.sh` + `teardown-workspace.ps1`) that safely remove a workspace — after backup, remote-repo deletion, local directory removal, and artifact cleanup (`~/README.md`, `~/.gitignore`, `~/.gitconfig` includeIf block, `~/.gitconfig.d/<name>.inc`) — in a single atomic flow. Also adds a `--teardown` / `-Teardown` convenience alias to the existing bootstrap scripts.

---

## Technical Context

**Language/Version**: Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows)
**Primary Dependencies**: `gh` CLI (required), `glab` CLI (optional for GitLab), `tar` (assumed present), `git` ≥ 2.13
**Storage**: File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc`, `~/README.md`, `~/.gitignore`
**Testing**: Manual verification with `--dry-run` / `-WhatIf` first, then real-run spot check plus regression check on an unrelated workspace / existing bootstrap flow (Principle V, SC-006)
**Target Platform**: macOS/Linux (Bash) + Windows (PowerShell 7+)
**Project Type**: CLI scripts (paired Bash + PowerShell, home-baseline pattern)
**Performance Goals**: `--dry-run` < 2 s without filesystem writes (SC-001); full teardown < 30 s excluding backup of large repos (SC-002); Bash/PowerShell parity on actions + exit codes (SC-005)
**Constraints**: Cross-platform parity (Principle II); Manual-first (Principle V); bilingual output (FR-016); no regressions to other workspaces, existing scripts, or git operations (SC-006)
**Scale/Scope**: Single-developer CLI tool; no concurrency requirements

---

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Status | Notes |
|-----------|--------|-------|
| I. Security-First | ✅ PASS | Teardown removes includeIf blocks and .inc files — reduces attack surface. No new credential exposure. Pre-push hook already covers `~/.gitconfig.d/`. The `--backup` archive lands in `~/` outside git tracking. `home-baseline` is explicitly protected from self-deletion. |
| II. Cross-Platform Parity | ✅ PASS | FR-001 mandates both `.sh` + `.ps1`. Both committed together. |
| III. Bootstrap Automation | ✅ PASS | FR-014 adds `--teardown` alias to existing bootstrap scripts — extends, not bypasses, the bootstrap flow. |
| IV. Workspace Isolation | ✅ PASS | Teardown removes each Level-2 repo independently (`--recursive`). No submodule usage introduced. |
| V. Manual-First Verification | ✅ PASS | FR-012 requires `--dry-run` / `-WhatIf`. Interactive confirmation prompt (FR-011). |

**Gate result**: All principles pass. No complexity violations.

---

## Project Structure

### Documentation (this feature)

```text
specs/005-workspace-teardown/
├── plan.md              # This file (/speckit.plan output)
├── research.md          # Phase 0 output
├── data-model.md        # Phase 1 output
├── quickstart.md        # Phase 1 output
├── contracts/
│   └── cli.md           # Phase 1 output — CLI interface contract
└── tasks.md             # Phase 2 output (/speckit.tasks — NOT created here)
```

### Source Code (repository root)

```text
scripts/
├── teardown-workspace.sh         (NEW — Bash implementation)
├── teardown-workspace.ps1        (NEW — PowerShell implementation)
├── bootstrap-workspace.sh        (MODIFY — add --teardown alias)
└── bootstrap-workspace.ps1       (MODIFY — add -Teardown alias)
```

No new library files — helper functions are self-contained within each script (same pattern as bootstrap-workspace).

**Structure Decision**: Scripts-only, no src/ directory. Follows the existing flat `scripts/` layout of this repo. The four script changes (2 new, 2 modified) are the complete scope of source changes.

---

## Complexity Tracking

> No constitution violations — table not required.

---

## Phase 0: Research

All NEEDS CLARIFICATION items resolved. Research captured in [`research.md`](research.md).

Key decisions:
- **R-001**: `[includeIf]` block removal via `awk` (Bash) / array-filter (PowerShell) — see research.md
- **R-002**: Remote URL parsing + `gh repo delete` for GitHub
- **R-003**: Remote URL parsing + `glab repo delete` for GitLab (optional)
- **R-004**: `sed -i` / PowerShell `-replace` for README + .gitignore line removal
- **R-005**: Safety checks via `git status --porcelain` + `git log @{u}..HEAD`
- **R-006**: Backup archive collision avoidance via incrementing numeric suffix
- **R-007**: Automatic artifact commit carries the required `Co-authored-by` trailer; if `~/` is not a git repo, skip commit with warning + Exit 1

---

## Phase 1: Design

### Implementation Order (P1 → P4)

Follows User Story priority from spec:

**Step 1 — Core teardown skeleton (P1)**
- Arg parsing (`--dry-run`, `--force`, `--yes`, `--keep-remote`, `--backup`, `--recursive`)
- `home-baseline` protection (FR-015, Exit 2)
- Workspace existence check (Exit 2)
- Safety checks: uncommitted changes + unpushed commits (FR-002)
- Level-2 detection + abort without `--recursive` (FR-003)
- Preamble box + consolidated confirmation (FR-011)
- `--dry-run` / `-WhatIf` invariants across the full runtime flow: show backup, safety, remote, local, artifact, and commit actions, but perform none of them (no archive creation, no remote delete, no directory delete, no artifact file edits, no artifact commit) (FR-012, SC-001)
- Runtime order fixed by design: Backup → Checks → Remote → Local → Artifacts (FR-004)
- Local directory removal (FR-004 Step 4)
- Artifact cleanup: README.md + .gitignore + .gitconfig block + .inc file (FR-006, FR-007, FR-008)
- Feature 003 soft-dependency handling: if `~/.gitconfig.d/` or the matching `.inc` file is absent, skip that cleanup path without error; `.gitconfig` block removal remains best-effort and independent
- Atomic commit of tracked artifact changes with Constitution trailer; if `~/` is not a git repo, warn + skip commit + Exit 1 (FR-006)
- Bilingual completion report (FR-013)
- All output bilingual (FR-016)

**Step 2 — Backup + remote deletion (P2)**
- `--backup`: create `tar.gz` before any destructive step (FR-009)
- Collision-safe archive naming with numeric suffix `-1`, `-2`, ... (edge case: same-day reruns)
- Remote URL detection (GitHub vs. GitLab, FR-005)
- No configured remote: skip remote step, continue teardown
- `gh repo delete` for GitHub
- `glab repo delete` for GitLab (optional, warn if `glab` absent)
- `--keep-remote` skip (FR-005)
- Remote deletion failure without `--keep-remote`: warn + abort before local deletion and artifact cleanup (FR-004 gate)

**Step 3 — Recursive Level-2 teardown (P3)**
- `--recursive` flag: enumerate Level-2 dirs (Tiefe 1 only)
- For each Level-2: safety checks → remote delete → local delete
- `--force` propagates to all Level-2 (clarified FR-010)
- Single consolidated preamble covers all Level-2 + Workspace actions (clarified FR-011)
- Level-2 projects never trigger their own artifact cleanup commit; the artifact commit runs once for the workspace only

**Step 4 — bootstrap-workspace alias (P4)**
- `bootstrap-workspace.sh`: detect `--teardown` as first arg, exec `teardown-workspace.sh` with remaining args
- `bootstrap-workspace.ps1`: detect `-Teardown` switch, exec `teardown-workspace.ps1` with remaining params

### PowerShell Mirror

Every Bash implementation step has a direct PowerShell mirror (`teardown-workspace.ps1`). The new teardown pair must be committed in the same commit (Principle II), and the bootstrap alias updates must be committed together as the corresponding second pair. PowerShell uses:
- `[CmdletBinding(SupportsShouldProcess)]` for `-WhatIf` support
- `-Force`, `-KeepRemote`, `-Backup`, `-Recursive`, `-Yes` parameters
- `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` for home dir
- The same normalization logic as the existing bootstrap pair: Bash reuses `normalize_name()` from `bootstrap-workspace.sh`; PowerShell mirrors `ConvertTo-NormalizedName()` from `bootstrap-workspace.ps1` to avoid `.inc` filename drift

### Artifact Commit Message

```text
chore: teardown <WorkspaceName> — Artefakte bereinigt / artifacts cleaned up

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```
All changed tracked files (`~/README.md`, `~/.gitignore`) staged and committed in one operation (FR-006 clarification). `.gitconfig` and `.gitconfig.d/*.inc` are filesystem-only cleanup operations and are never part of the git commit.

### Verification Notes

- First-pass verification is always `--dry-run` / `-WhatIf`; this must list every runtime step without writing anything.
- Live verification must confirm the workspace teardown itself and one regression check on an unrelated workspace or on `bootstrap-workspace` to cover SC-006.
- Feature-003 cleanup verification must include the fallback case where `~/.gitconfig.d/` is absent; the run must continue without error.

### Exit Code Table

| Condition | Exit Code |
|-----------|-----------|
| Success (all steps complete) | 0 |
| Warning / partial completion (e.g., `tar` unavailable, GitLab remote skipped because `glab` is absent, artifact commit skipped because `~/` is not a git repo) | 1 |
| Abort before destructive completion (e.g., safety check failed, remote deletion failed without `--keep-remote`) | 1 |
| Usage error / home-baseline protection / workspace not found | 2 |

See `contracts/cli.md` for the full interface contract.
