# Feature Specification: Git-Konfiguration Scope-Isolierung / Git Configuration Scope Isolation

**Feature Branch**: `003-git-config-scope`
**Created**: 2026-04-08
**Status**: Draft
**Input**: Lastenheft_Git_Config_Scope.md

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Per-Workspace Git Identity (Priority: P1)

A developer maintains multiple workspaces with different identities (e.g., personal projects vs. work projects). Currently, a single global `~/.gitconfig` applies the same email address and settings to every repository on the system, causing commits to appear under the wrong identity in the wrong context.

The developer needs a way to define workspace-specific git settings (email address, signing key, aliases) that apply only within a designated directory tree and have no effect on other repositories.

**Why this priority**: Identity leakage is a compliance and professional risk. It is the root motivation for the entire feature and unblocks all other workspace-specific customisations.

**Independent Test**: Create a `.inc` file in `~/.gitconfig.d/` with a different `user.email`. Verify via `git config --show-origin user.email` that the override is active inside the target workspace directory and absent outside it.

**Acceptance Scenarios**:

1. **Given** a `.inc` file with `user.email = work@example.com` scoped to `~/home-baseline-tmp/`, **When** `git config user.email` is queried inside `~/home-baseline-tmp/`, **Then** the result is `work@example.com`.
2. **Given** the same `.inc` file, **When** `git config user.email` is queried inside `~/MyProjects/` (no matching scope), **Then** the result is the global default, not `work@example.com`.
3. **Given** a Level 2 project at `~/MyProjects/my-app/`, **When** `git status` and `git add src/` are run, **Then** all internal subdirectories (`src/`, `tests/`, `bin/`, etc.) are accessible and tracked normally — scope isolation never restricts project-internal folder structures.

---

### User Story 2 — New Workspace Gets Local Git Settings (Priority: P2)

When a developer bootstraps a new workspace with `bootstrap-workspace`, the workspace repository should receive its own git configuration entries locally, without writing workspace-specific values into the global git config.

**Why this priority**: Every new workspace created after this feature ships must be configured correctly from the start. Getting this right at bootstrap time prevents manual remediation later.

**Independent Test**: Run `bootstrap-workspace` for a test workspace. Run `git -C <workspace> config --local --list` and confirm workspace-specific settings appear in the local config. Confirm the corresponding `includeIf` entry is present in `~/.gitconfig`.

**Acceptance Scenarios**:

1. **Given** `~/.gitconfig.d/` exists, **When** `bootstrap-workspace` runs for a new workspace, **Then** an `includeIf` block for that workspace is appended to `~/.gitconfig` pointing to `~/.gitconfig.d/<workspacename>.inc`.
2. **Given** a newly bootstrapped workspace, **When** `git -C $WORKSPACE config --local --list` is run, **Then** workspace-specific settings (e.g., `core.autocrlf`) appear in the local config.
3. **Given** `~/.gitconfig.d/` does not exist, **When** `bootstrap-workspace` runs, **Then** no `includeIf` entry is added to `~/.gitconfig` and no error is raised.
4. **Given** `bootstrap-workspace` has already been run for a workspace, **When** it is run again for the same workspace, **Then** no duplicate `includeIf` entry is added to `~/.gitconfig`.

---

### User Story 3 — sync-home Preserves User Customisations (Priority: P2)

A developer has customised `~/.gitconfig.d/` with workspace-specific overrides. When `sync-home` is run to update the home baseline, these customisations must be preserved and never overwritten.

**Why this priority**: If `sync-home` silently deleted user customisations, users would lose workspace-specific identities on every sync — a data-loss scenario with no warning.

**Independent Test**: Add a custom `.inc` file to `~/.gitconfig.d/`. Run `sync-home`. Verify the custom file is still present and unchanged. Run `sync-home` a second time; verify no duplicate files are created.

**Acceptance Scenarios**:

1. **Given** `~/.gitconfig.d/` exists with custom `.inc` files, **When** `sync-home` runs, **Then** `~/.gitconfig.d/` and all its contents are unchanged.
2. **Given** `~/.gitconfig.d/` does not yet exist, **When** `sync-home` runs for the first time, **Then** `~/.gitconfig.d/` is created and a `home-baseline.inc` placeholder is added.
3. **Given** `sync-home` has already run once, **When** it runs again, **Then** no duplicate files are created and no existing files are modified.

---

### User Story 4 — Workspace Teardown Cleans Up Git Config (Priority: P3)

When a developer tears down a workspace using `teardown-workspace`, all associated git configuration entries — the `includeIf` block in `~/.gitconfig` and the `.inc` file in `~/.gitconfig.d/` — are removed automatically, leaving no orphaned configuration.

**Why this priority**: Orphaned entries pointing to deleted directories create noise and potential confusion. Automated cleanup keeps the system in a consistent, auditable state.

**Independent Test**: Bootstrap a workspace (creates `includeIf` + `.inc`). Run `teardown-workspace`. Verify neither the `includeIf` block nor the `.inc` file exist afterwards.

**Acceptance Scenarios**:

1. **Given** a workspace with a corresponding `includeIf` entry and `.inc` file, **When** `teardown-workspace` runs, **Then** both the `includeIf` block and the `.inc` file are removed.
2. **Given** no `.inc` file exists for the workspace, **When** `teardown-workspace` runs, **Then** it completes without error.
3. **Given** duplicate `includeIf` entries for the same workspace were added manually, **When** `teardown-workspace` runs, **Then** all matching entries are removed.

---

### User Story 5 — Homogeneity Check Warns on Missing Scope Isolation (Priority: P4)

A developer runs `check-homogeneity` to verify their workspace setup. If scope isolation is not yet configured (no `includeIf` entry for the target workspace), the check emits a warning — without failing the overall compliance score.

**Why this priority**: A warning (not a hard failure) preserves backwards compatibility while surfacing the gap to users who have not yet set up scope isolation.

**Independent Test**: Remove the `includeIf` entry for the target workspace from `~/.gitconfig`. Run `check-homogeneity` in dry-run mode. Verify a warning is emitted in the output.

**Acceptance Scenarios**:

1. **Given** no `includeIf` entry exists for the target workspace, **When** `check-homogeneity` runs, **Then** a warning (not a fatal error) is printed and the compliance score is not reduced.
2. **Given** `~/.gitconfig.d/` does not exist, **When** `check-homogeneity` runs, **Then** a warning is printed for the missing directory.
3. **Given** both `~/.gitconfig.d/` and the `includeIf` entry are present, **When** `check-homogeneity` runs, **Then** no warning is emitted for scope isolation.

---

### Edge Cases

- What happens when `~/MyProjects/` is itself a git repository (Level 1) and contains Level 2 project sub-repos? The `includeIf` with trailing slash must apply to both the Level 1 `.git` and all Level 2 `.git` directories without restricting subdirectory structures within those projects.
- How does the system handle `.inc` files that contain credential-like patterns? The pre-push hook must scan `~/.gitconfig.d/` and block pushes if tokens or credentials are detected.
- What if a user manually added duplicate `includeIf` entries for the same workspace? `teardown-workspace` must remove all matching entries, not just the first occurrence.
- What if `bootstrap-workspace` is run on Windows where path separators differ? The `includeIf` path must use forward slashes, as required by git on all platforms.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The tracked `~/.gitconfig` MUST contain only the following global settings: `user.name`, `user.email`, `init.defaultBranch`, `core.autocrlf`, and `pull.rebase`. All other settings MUST be moved to scoped include files.
- **FR-002**: A directory `~/.gitconfig.d/` MUST be established as the designated location for scoped git configuration include files (`.inc`). Users MAY add their own `.inc` files for custom workspaces.
- **FR-003**: `~/.gitconfig` MUST contain an `includeIf` block scoping `~/.gitconfig.d/home-baseline.inc` to the `~/home-baseline-tmp/` directory tree only.
- **FR-004**: `bootstrap-workspace` MUST apply workspace-specific git settings using a local (repository-level) git configuration call in the newly created workspace repository.
- **FR-005**: `bootstrap-workspace` MUST append an `includeIf` block for the new workspace to `~/.gitconfig`, provided `~/.gitconfig.d/` already exists. If `~/.gitconfig.d/` does not exist, the step is skipped without error. This operation MUST be idempotent — if a matching `includeIf` entry for the workspace already exists, no duplicate is added. The `.inc` filename MUST be derived from the workspace name by converting to lowercase and replacing spaces and special characters with hyphens (e.g., workspace `My Projects` → `my-projects.inc`).
- **FR-006**: `bootstrap-project` MUST apply project-specific git settings using a local (repository-level) git configuration call in the newly created project repository. It MUST NOT modify `~/.gitconfig` or `~/.gitconfig.d/`.
- **FR-007**: `sync-home` MUST create `~/.gitconfig.d/` with an initial `home-baseline.inc` placeholder if the directory does not exist. It MUST NOT overwrite or modify `~/.gitconfig.d/` or any of its files if the directory already exists.
- **FR-008**: `teardown-workspace` MUST remove the corresponding `includeIf` block from `~/.gitconfig` and the corresponding `.inc` file from `~/.gitconfig.d/` when a workspace is torn down. All occurrences of matching entries MUST be removed.
- **FR-009**: `check-homogeneity` MUST emit a non-fatal warning if `~/.gitconfig.d/` does not exist or if no `includeIf` entry for the target workspace is present in `~/.gitconfig`. The overall compliance score MUST NOT be reduced by this warning.
- **FR-010**: `README.md` MUST include a section explaining the scope isolation mechanism, which settings remain global, how to define workspace-specific overrides, and a concrete example such as using different email addresses per workspace.
- **FR-011**: The pre-push hook MUST scan `~/.gitconfig.d/` for credential-like patterns (tokens, passwords, private keys) and block the push if any are detected. This extends the existing hook coverage to include the new directory.
- **FR-012**: All `includeIf` path values written to `~/.gitconfig` MUST use forward slashes (`/`) as the path separator, regardless of the host platform (including Windows). This is required by git's `includeIf` specification on all platforms.

### Key Entities

- **Global Git Config (`~/.gitconfig`)**: The user-level git configuration file containing only safe global defaults and `includeIf` blocks after this feature. Managed and deployed by `sync-home`.
- **Scoped Include Directory (`~/.gitconfig.d/`)**: A user-owned directory holding workspace-specific `.inc` config fragments. Never overwritten by `sync-home`. Not tracked in the repository.
- **Include File (`.inc`)**: A git config fragment activated for a specific workspace via `includeIf`. Filename is derived from the workspace name normalized to lowercase with hyphens (e.g., `my-projects.inc`). Must not contain credentials or tokens.
- **Workspace (Level 1)**: A top-level git repository directory (e.g., `~/home-baseline-tmp/`, `~/MyProjects/`). An `includeIf` block with trailing slash covers the workspace itself and all nested project repos.
- **Project (Level 2)**: A git repository nested inside a workspace (e.g., `~/MyProjects/my-app/`). Inherits the workspace's `includeIf` scope automatically. Internal subdirectory structures are entirely unaffected by scope isolation.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A setting defined only in `~/.gitconfig.d/home-baseline.inc` is active inside `~/home-baseline-tmp/` and absent in any other workspace directory — verifiable via `git config --show-origin` with no additional configuration steps.
- **SC-002**: After `bootstrap-workspace` completes, workspace-specific git settings are present exclusively in the workspace's local repository config — the global `~/.gitconfig` contains no workspace-specific values.
- **SC-003**: After `sync-home` runs on a system with an existing `~/.gitconfig.d/`, all pre-existing custom files remain byte-for-byte identical — 0 files overwritten or deleted.
- **SC-004**: After `teardown-workspace` completes, no `includeIf` entries or `.inc` files referencing the removed workspace remain — the count of matching entries in `~/.gitconfig` is zero.
- **SC-005**: `check-homogeneity` emits at least one identifiable warning on a system where scope isolation has not been configured, without affecting the pass/fail compliance score.
- **SC-006**: All git operations (status, add, commit, push) in Level 2 project repositories with complex subdirectory hierarchies (C#, Java, Flutter, Python) succeed without error after the feature is deployed — 100% of affected subdirectory operations pass.
- **SC-007**: All existing git operations across all repositories on the system continue to work correctly after the feature is deployed — no regressions in any repository not targeted by an `includeIf` scope.
- **SC-008**: A push that includes a `.inc` file containing a credential-like pattern in `~/.gitconfig.d/` is blocked by the pre-push hook — the push is rejected and a descriptive error message is displayed.

---

## Non-Functional Requirements

- **NFR-001**: All new user-facing output produced by modified or new scripts (`bootstrap-workspace`, `bootstrap-project`, `sync-home`, `teardown-workspace`, `check-homogeneity`) MUST be bilingual (German / English). Each message MUST include both languages, either on the same line (e.g., `Einstellung gesetzt / Setting applied`) or as paired lines.

---

## Clarifications

### Session 2026-04-08

- Q: Should the pre-push hook scanning `~/.gitconfig.d/` for credentials be a Functional Requirement (not just an assumption)? → A: Yes — added as FR-011.
- Q: Should `bootstrap-workspace` be idempotent when adding `includeIf` entries (no duplicates on repeated runs)? → A: Yes — idempotent, skip if entry already exists (FR-005 updated).
- Q: Should bilingual script output (DE/EN) be added as an explicit Non-Functional Requirement? → A: Yes — added as NFR-001.
- Q: How should workspace names be normalized for `.inc` filenames (special characters, spaces)? → A: Lowercase, spaces/special chars → hyphens (e.g., `my-projects.inc`) — FR-005 updated.
- Q: Should forward-slash normalization of `includeIf` paths on Windows be an explicit Functional Requirement? → A: Yes — added as FR-012.

---

## Assumptions

- Git ≥ 2.13 is installed on all target platforms (macOS, Linux, Windows) — required for `includeIf` support.
- The `includeIf "gitdir:..."` mechanism with a trailing slash correctly covers both the Level 1 workspace `.git` and all Level 2 project `.git` directories inside it, as per the git-config specification.
- `~/.gitconfig.d/` is intentionally excluded from the `home-baseline-tmp` tracked file whitelist and is never committed to the repository.
- `.inc` files must not contain credentials, tokens, or sensitive values (enforced by FR-011).
- `teardown-workspace` (specified in `Lastenheft_Workspace_Teardown.md`) is implemented before or in parallel — FR-008 depends on it.
- Automatic migration of existing workspaces to the `includeIf` model is out of scope. Documentation guidance is sufficient.
- Git credential helpers, GPG/SSH signing key configuration, and `.gitattributes` scope management are out of scope for this feature.
- The feature is platform-agnostic — no platform-specific workarounds are required for `includeIf` on macOS, Linux, or Windows.
