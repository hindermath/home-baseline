# Implementation Plan: Git-Konfiguration Scope-Isolierung / Git Configuration Scope Isolation

**Branch**: `003-git-config-scope` | **Date**: 2026-04-09 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/003-git-config-scope/spec.md`

## Summary

Introduces workspace-scoped git configuration isolation using git's `includeIf "gitdir:..."` mechanism. A new user-owned directory `~/.gitconfig.d/` holds per-workspace `.inc` configuration fragments; `~/.gitconfig` retains only global defaults and `includeIf` pointers. Five existing scripts are extended (`bootstrap-workspace`, `bootstrap-project`, `sync-home`, `check-homogeneity`, `pre-push` hook); `teardown-workspace` is out of scope (separate feature). Every script change ships as paired Bash + PowerShell variants per Constitution Principle II.

---

## Technical Context

**Language/Version**: Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows)
**Primary Dependencies**: git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency)
**Storage**: File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments)
**Testing**: Manual verification per Constitution Principle V — `--dry-run` / `-WhatIf` modes required
**Target Platform**: macOS (Darwin), Linux, Windows (Git for Windows / MSYS2)
**Project Type**: Infrastructure scripts (CLI tools — paired .sh / .ps1)
**Performance Goals**: N/A — file-system operations only
**Constraints**: No new package dependencies; whitelist `.gitignore` model; `~/.gitconfig.d/` MUST remain untracked (verify after implementation: `git -C ~/home-baseline-tmp ls-files ~/.gitconfig.d/` MUST return empty output); all script changes MUST ship as Bash + PowerShell pairs
**Scale/Scope**: Single developer workstation; up to ~10 workspace directories

---

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-checked after Phase 1 design.*

| Principle | Status | Notes |
|---|---|---|
| I. Security-First | ✅ PASS | FR-011 extends pre-push hook to scan `~/.gitconfig.d/`; `~/.gitconfig.d/` stays untracked; PR MUST cite Principle I for hook change; scanner run required |
| II. Cross-Platform Parity | ✅ PASS | All 5 modified scripts have existing `.sh` + `.ps1` pairs; both variants MUST be updated in same commit; pre-push hook is Bash-only (git hook — acceptable exception) |
| III. Bootstrap Automation | ✅ N/A | No new workspace bootstrap sequence created |
| IV. Workspace Isolation | ✅ PASS | `~/.gitconfig.d/` excluded from whitelist; no submodules introduced |
| V. Manual-First Verification | ✅ PASS | `--dry-run` / `-WhatIf` modes available in all affected scripts |

**No violations. No Complexity Tracking entries required.**

**Post-design re-check**: Constitution Check passes after Phase 1 design. Forward-slash normalization (FR-012, R-004) is correctly implemented in both Bash and PowerShell. Pre-push hook extension (R-005) follows Principle I exactly. *Reviewed by: feature author, 2026-04-09.*

---

## Project Structure

### Documentation (this feature)

```text
specs/003-git-config-scope/
├── plan.md              ← This file
├── spec.md              ← Feature specification
├── research.md          ← Phase 0 research findings (9 decisions)
├── data-model.md        ← Phase 1 file entity model
├── quickstart.md        ← Phase 1 developer guide
├── contracts/
│   └── script-contracts.md  ← Phase 1 CLI interface contracts
└── tasks.md             ← Phase 2 output (/speckit.tasks — not yet created)
```

### Source Code (repository root)

```text
scripts/
├── bootstrap-workspace.sh    ← MODIFY: add includeIf + .inc + git config --local
├── bootstrap-workspace.ps1   ← MODIFY: same (paired)
├── bootstrap-project.sh      ← MODIFY: bilingual output only (FR-006 already met)
├── bootstrap-project.ps1     ← MODIFY: bilingual output only (paired)
├── sync-home.sh              ← MODIFY: add ~/.gitconfig.d/ bootstrap logic
├── sync-home.ps1             ← MODIFY: same (paired)
├── check-homogeneity.sh      ← MODIFY: add GIT-SCOPE-001/002 WARN checks
├── check-homogeneity.ps1     ← MODIFY: same (paired)
└── hooks/
    └── pre-push              ← MODIFY: add ~/.gitconfig.d/ credential scan (Bash only)

.gitconfig                    ← MODIFY: add [includeIf] for home-baseline-tmp; keep only global defaults
README.md                     ← MODIFY: add scope isolation section (FR-010)
```

**Out of scope**:
```text
scripts/teardown-workspace.sh    ← NOT YET CREATED — separate feature (Lastenheft_Workspace_Teardown.md)
scripts/teardown-workspace.ps1   ← same
```

---

## Implementation Phases

### Phase 1A — Core: `~/.gitconfig` Template + `sync-home`

**Implements**: FR-001, FR-002, FR-003, FR-007

**Files**:
- `.gitconfig` — strip to global defaults + add `[includeIf]` for home-baseline-tmp
- `scripts/sync-home.sh` — add `~/.gitconfig.d/` bootstrap block after file-copy step
- `scripts/sync-home.ps1` — same

**Key implementation details**:
1. `.gitconfig` template gets one `[includeIf "gitdir:~/home-baseline-tmp/"]` block pointing to `~/.gitconfig.d/home-baseline.inc`
2. `sync-home` checks `~/.gitconfig.d/` at destination after copying `.gitconfig`:
   - If absent: `mkdir -p ~/.gitconfig.d/ && write placeholder home-baseline.inc` (placeholder content: see R-006 in research.md)
   - If present: skip with bilingual info message
3. All new user-facing messages bilingual DE/EN (NFR-001)

**Verification**:
- `bash scripts/sync-home.sh --dry-run` on a system without `~/.gitconfig.d/` (covers SC-002 partial, SC-003 creation path)
- Second run: confirm no changes to existing `~/.gitconfig.d/` content (covers SC-003 idempotency path)

---

### Phase 1B — Core: `bootstrap-workspace`

**Implements**: FR-004, FR-005, FR-012

**Files**:
- `scripts/bootstrap-workspace.sh`
- `scripts/bootstrap-workspace.ps1`

**Key implementation details**:
1. Normalize workspace name (R-003): `normalize_name()` function in Bash, `ConvertTo-NormalizedName` in PS1
2. `git config --local core.autocrlf input` (macOS/Linux) / `true` (Windows) in new workspace repo
3. If `~/.gitconfig.d/` exists:
   - Check for existing `[includeIf]` entry (idempotency check — R-002)
   - If absent: append block using forward-slash path (R-004 / FR-012)
   - Create `~/.gitconfig.d/<normalized>.inc` placeholder if not present
4. If `~/.gitconfig.d/` absent: skip with bilingual info message (no error)
5. All output bilingual DE/EN (NFR-001)
6. On Windows PowerShell: use `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` for home path resolution — see Dependencies & Risks (Windows HOME path)

**Verification**: `bash scripts/bootstrap-workspace.sh --dry-run TestWorkspace`; run twice to verify idempotency (covers SC-002)

---

### Phase 1C — Security: `pre-push` hook

**Implements**: FR-011, SC-008, NFR-001 (bilingual error output)

**Files**:
- `scripts/hooks/pre-push` (Bash only — git hooks are shell scripts on all platforms; Git for Windows ships with sh.exe)

**Key implementation details** (from R-005):
```bash
# After existing tracked-file scan
gitconfig_d="${HOME}/.gitconfig.d"
if [ -d "$gitconfig_d" ]; then
  while IFS= read -r f; do
    inc_hits+=("$f")
  done < <(grep -rEl --include='*.inc' "$secret_content_regex" "$gitconfig_d" 2>/dev/null || true)
  if [ "${#inc_hits[@]}" -gt 0 ]; then
    found_high=1
    echo "  HIGH: Secret-Muster in ~/.gitconfig.d/ gefunden / Secret patterns found in ~/.gitconfig.d/:" >&2
    printf '       %s\n' "${inc_hits[@]}" >&2
  fi
fi
```

**Verification**:
- `bash scripts/scan-agent-secrets.sh --fail-on-high` MUST be run and output included in PR
- Manual test: place credential-pattern string in a `.inc` file; verify push is blocked; remove file; verify push proceeds

**⚠️ Principle I — MANDATORY**: PR description MUST state "This change extends secret scanning per Constitution Principle I" and include scanner output.

---

### Phase 1D — Observability: `check-homogeneity`

**Implements**: FR-009, SC-005

**Files**:
- `scripts/check-homogeneity.sh`
- `scripts/check-homogeneity.ps1`

**Key implementation details** (from R-007, contracts/script-contracts.md):
1. Add new check module as `scripts/lib/hg-git-scope.sh` (aligned with existing `lib/hg-*.sh` pattern — see R-007):
   - `GIT-SCOPE-001`: `~/.gitconfig.d/` exists → WARN if absent
   - `GIT-SCOPE-002`: `[includeIf]` for home-baseline-tmp in `~/.gitconfig` → WARN if absent
2. WARN severity: does NOT increment fail counter; does NOT affect exit code
3. JSON output support (`--json` flag) for machine-readable results
4. All messages bilingual DE/EN (NFR-001)

**Verification**:
- Remove `~/.gitconfig.d/`; run `bash scripts/check-homogeneity.sh`; confirm WARN is emitted and exit code is 0 (covers SC-005)
- Run `bash scripts/check-homogeneity.sh --json`; confirm JSON output contains `"status": "WARN"` for `GIT-SCOPE-001`

---

### Phase 1E — Documentation: `README.md` + `bootstrap-project` bilingual

**Implements**: FR-010, NFR-001 (for bootstrap-project output)
*Note: FR-006 (bootstrap-project local git config) is already implemented — only bilingual output (NFR-001) is new. See R-009.*

**Files**:
- `README.md` — add `## Git Scope-Isolierung / Git Scope Isolation` section
- `scripts/bootstrap-project.sh` — add bilingual output for existing local-config step
- `scripts/bootstrap-project.ps1` — same

**README section content**:
- Explains `includeIf` mechanism (what it does, why)
- Lists which settings are global vs. workspace-specific
- Shows how to add workspace-specific overrides (example: different email per workspace)
- References `~/.gitconfig.d/` directory and `.inc` file format
- **Insertion position**: Insert after the `## Workspace-Einrichtung / Workspace Setup` section (before `## Verzeichnisstruktur / Directory Structure` or equivalent). Must be added to the 2-level TOC under `##` headings.

**Verification**:
- Review `README.md` in rendered Markdown: confirm new section is present, TOC entry added, bilingual heading format `## Git Scope-Isolierung / Git Scope Isolation`, all code blocks have language tags
- Run `bash scripts/bootstrap-project.sh --dry-run TestProject`; confirm bilingual output for local-config step
- SC-006 / SC-007 regression: run `git status`, `git add`, `git commit --dry-run` in a Level 2 project directory after feature deployment; confirm all operations succeed normally

---

## Complexity Tracking

No Constitution violations — no entries required.

---

## Dependencies & Risks

| Item | Type | Notes |
|---|---|---|
| FR-008 `teardown-workspace` | **Out of scope** | Separate feature; orphaned `includeIf` entries harmless but must be documented — user mitigation: `quickstart.md` contains manual cleanup instructions |
| git ≥ 2.13 | Assumption | Verified in research; `includeIf` is stable since 2.13 (2016). Scripts do NOT check the git version at runtime — the assumption is that git < 2.13 is not present on supported platforms (git 2.13 shipped 2017). If `includeIf` is silently ignored by an older git, workspace-specific config is simply not applied (non-fatal). |
| `~/.gitconfig` write permissions | Risk (low) | Scripts fail with clear error if file is read-only; no special handling needed |
| Windows HOME path | Risk (low) | `$env:HOME` may be empty — use `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })` per CLAUDE.md |
| Duplicate `includeIf` entries (existing installs) | Risk (low) | Idempotency check handles this for new bootstrap runs; existing duplicates harmless |
