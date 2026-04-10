# Feature Specification: GitLab Support for Bootstrap Scripts

**Feature Branch**: `006-gitlab-support`  
**Created**: 2026-04-10  
**Status**: Draft  
**Input**: User description: "Erstelle die Spezifikation aus dem Lastenheft @Lastenheft_GitLab_Support.md"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Bootstrap a New Workspace on GitLab (Priority: P1)

A developer wants to create a new workspace and host it on GitLab instead of the default GitHub. They run the bootstrap-workspace script with an explicit `--platform gitlab` flag and receive a new private GitLab repository, fully configured with remote and initial push.

**Why this priority**: This is the core feature. Without it, the entire GitLab support story has no value. All other stories build on the ability to successfully create a GitLab-backed workspace.

**Independent Test**: Can be fully tested by running `bootstrap-workspace.sh --dry-run TestWS --platform gitlab` and verifying that all planned GitLab actions are displayed correctly, then running without `--dry-run` to verify actual repo creation.

**Acceptance Scenarios**:

1. **Given** a user has `glab` installed and is authenticated, **When** they run `bootstrap-workspace.sh MyWorkspace --platform gitlab`, **Then** a private GitLab repository is created, the remote is set to the correct GitLab URL, and an initial push is performed successfully.
2. **Given** a user runs with `--dry-run --platform gitlab`, **When** the script executes, **Then** all planned GitLab actions are displayed without any actual changes being made.
3. **Given** a user provides no `--platform` argument, **When** the script runs, **Then** it behaves identically to the current behavior (GitHub default), with no regressions.

---

### User Story 2 - Bootstrap a New Project on GitLab (Priority: P2)

A developer wants to bootstrap an individual project (not a full workspace) and target GitLab as the remote platform. They run `bootstrap-project.sh` with `--platform gitlab` and receive a configured private GitLab repository.

**Why this priority**: Project bootstrapping is a common workflow alongside workspace bootstrapping. Parity between both scripts is an explicit requirement.

**Independent Test**: Can be fully tested by running `bootstrap-project.sh --dry-run MyProject --platform gitlab` and verifying the dry-run output reflects GitLab-specific actions.

**Acceptance Scenarios**:

1. **Given** `glab` is installed and authenticated, **When** `bootstrap-project.sh MyProject --platform gitlab` is run, **Then** a private GitLab project repository is created with correct remote and initial push.
2. **Given** the `--no-remote` flag is combined with `--platform gitlab`, **When** the script runs, **Then** no remote repository is created and no push occurs — the `--no-remote` behavior remains unchanged.

---

### User Story 3 - Use Self-Hosted GitLab Instance (Priority: P3)

A developer works in an enterprise environment with a self-hosted GitLab instance. They pass `--gitlab-url https://gitlab.example.com` to target their corporate instance instead of `gitlab.com`.

**Why this priority**: Self-hosted GitLab is an important enterprise use case, but secondary to the core `gitlab.com` flow. It depends on P1 being implemented first.

**Independent Test**: Can be tested with `--dry-run --platform gitlab --gitlab-url https://gitlab.example.com` to verify the custom hostname appears in all planned actions and output.

**Acceptance Scenarios**:

1. **Given** `--platform gitlab --gitlab-url https://gitlab.example.com` is passed, **When** the script runs, **Then** the remote URL uses `https://gitlab.example.com` and the GitLab CLI is invoked with the correct hostname flag.
2. **Given** `--gitlab-url` is provided without `--platform gitlab`, **When** the script runs, **Then** the GitLab URL parameter is ignored and the script proceeds with the GitHub default.

---

### User Story 4 - Guided Error Handling for Missing or Unauthenticated glab (Priority: P2)

A developer attempts to bootstrap a GitLab workspace but has not installed `glab` or has not authenticated. The script detects this and provides a clear, actionable bilingual error message.

**Why this priority**: Without this, users face cryptic errors. Clear guidance reduces friction and enables self-service resolution without consulting external documentation.

**Independent Test**: Can be tested by temporarily removing `glab` from PATH or logging out and running the bootstrap with `--platform gitlab`.

**Acceptance Scenarios**:

1. **Given** `glab` is not installed, **When** `--platform gitlab` is used, **Then** the script exits with code 1 and displays a bilingual error with platform-specific installation instructions.
2. **Given** `glab` is installed but not authenticated, **When** `--platform gitlab` is used, **Then** the script exits with code 1 and displays a bilingual error instructing the user to run `glab auth login`.

---

### Edge Cases

- What happens when `--platform invalid` is passed? → `bootstrap-workspace.sh/.ps1` must exit with code 1, and `bootstrap-project.sh/.ps1` must exit with code 2; both must display a bilingual error listing valid values (`github`, `gitlab`).
- What happens if the GitLab API call to retrieve the username fails? → `bootstrap-workspace.sh/.ps1` must exit with code 1, and `bootstrap-project.sh/.ps1` must exit with code 2; both must display a descriptive bilingual error.
- What happens if a GitLab repository with the same name already exists? → The script propagates the error from the GitLab CLI to the user with context.
- What happens when the workspace name contains spaces or special characters? → The script normalizes the name to a valid GitLab slug (spaces → hyphens, lowercase) and notifies the user of the resulting repo name in preamble and summary.
- What happens if `--gitlab-url` does not start with `https://`? → `bootstrap-workspace.sh/.ps1` must exit with code 1, and `bootstrap-project.sh/.ps1` must exit with code 2; both must fail immediately and display a bilingual error requiring the `https://` prefix.
- What happens if `--gitlab-url` points to an unreachable host? → The script fails gracefully with a clear error surfaced to the user (after passing the `https://` prefix check). No retry is attempted; the user is prompted to re-run.
- What happens if `glab repo create` or `git push` fails due to a transient network error? → No retry — the script fails immediately, surfaces the glab/git error output, and hints the user to re-run the script.
- What happens when `--dry-run` is combined with `--platform gitlab`? → All planned actions are shown without execution, including GitLab-specific commands.
- How does the `~/README.md` table entry behave for a GitLab workspace? → The link uses the GitLab URL pattern (`https://gitlab.com/USER/REPO` or the custom URL).

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Both `bootstrap-workspace.sh/.ps1` and `bootstrap-project.sh/.ps1` MUST accept an optional `--platform <github|gitlab>` (Bash) / `-Platform <github|gitlab>` (PowerShell) parameter, defaulting to `github`.
- **FR-002**: Both scripts MUST accept an optional `--gitlab-url <URL>` (Bash) / `-GitLabUrl <URL>` (PowerShell) parameter for self-hosted GitLab instances, defaulting to `https://gitlab.com`. This parameter is only evaluated when `--platform gitlab` is active.
- **FR-003**: When `--platform github` or no platform is specified, the scripts MUST behave identically to their current behavior — zero regressions.
- **FR-004**: When `--platform gitlab` is selected, the scripts MUST verify that the GitLab CLI is installed; if absent, `bootstrap-workspace.sh/.ps1` MUST exit with code 1 and `bootstrap-project.sh/.ps1` MUST exit with code 2, with bilingual installation guidance for macOS/Linux and Windows.
- **FR-005**: When `--platform gitlab` is selected, the scripts MUST verify that the GitLab CLI is authenticated; if not, `bootstrap-workspace.sh/.ps1` MUST exit with code 1 and `bootstrap-project.sh/.ps1` MUST exit with code 2, with a bilingual authentication instruction.
- **FR-006**: When `--platform gitlab` is selected, the scripts MUST retrieve the authenticated GitLab username, derive a valid GitLab repository slug from the workspace or project name (spaces → hyphens, lowercase, invalid characters stripped), and create a private repository using that slug. If the name was modified, the resulting slug MUST be displayed in the user-facing setup output: in the workspace preamble and summary output for `bootstrap-workspace.*`, and in the project summary output for `bootstrap-project.*`.
- **FR-007**: When `--platform gitlab` is selected, the scripts MUST set the `origin` remote to the correct GitLab URL and push the initial commit.
- **FR-008**: When `--gitlab-url` is provided, the scripts MUST validate that the value starts with `https://`; if not, `bootstrap-workspace.sh/.ps1` MUST exit with code 1 and `bootstrap-project.sh/.ps1` MUST exit with code 2, with a bilingual error before any further processing. When valid, use the custom hostname in all GitLab CLI invocations and construct the remote URL from that base.
- **FR-009**: The preamble output box MUST display the selected platform (e.g., `GitHub (privat)` or `GitLab — https://gitlab.com (privat)`).
- **FR-010**: The auto-inserted `~/README.md` workspace table entry MUST link to the correct platform URL (GitHub or GitLab, default or custom).
- **FR-011**: The summary output at script completion MUST display the platform-correct repository URL and clone command.
- **FR-012**: Dry-run mode MUST display all planned GitLab actions without executing them, consistent with existing GitHub dry-run behavior.
- **FR-013**: An invalid `--platform` value MUST cause `bootstrap-workspace.sh/.ps1` to exit with code 1 and `bootstrap-project.sh/.ps1` to exit with code 2, with a bilingual error listing the valid values.
- **FR-014**: All new user-facing messages (errors, status lines, summaries) MUST be bilingual: German first, then English (CEFR B2 level).
- **FR-015**: The `--no-remote` flag in `bootstrap-project.sh/.ps1` MUST remain fully functional regardless of the `--platform` setting.

### Key Entities

- **Platform**: The chosen remote hosting service (`github` or `gitlab`); determines which CLI tool is used and how remote URLs are constructed.
- **GitLab Instance URL**: The base URL for the GitLab instance (default `https://gitlab.com`; configurable for self-hosted); used in remote URL construction and CLI invocations.
- **GitLab Username**: Retrieved at runtime via the GitLab CLI API; used to construct repository URLs.
- **Repository**: The private remote repository created on the chosen platform; named after the workspace or project.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A developer can bootstrap a GitLab-backed workspace from a single command in under 60 seconds on a stable connection, matching the speed of the existing GitHub path.
- **SC-002**: All existing bootstrap calls without `--platform` continue to produce identical results — zero regressions verifiable by running existing acceptance tests.
- **SC-003**: A developer who lacks the GitLab CLI or has not authenticated receives all information needed to resolve the issue without consulting external documentation, as verified by the presence of installation commands and auth instructions in the error output.
- **SC-004**: Dry-run mode for GitLab displays 100% of planned actions (username retrieval, repo creation, remote setup, push) without executing any of them.
- **SC-005**: The `~/README.md` workspace table entry for a GitLab-backed workspace contains a valid, clickable link to the GitLab repository — verifiable by visual inspection after bootstrap.
- **SC-006**: Bash and PowerShell variants produce functionally equivalent outcomes on all supported platforms (macOS, Linux, Windows) — verifiable via manual `--dry-run`, `-WhatIf`, and `-Preview` checks using the documented validation commands.
- **SC-007**: A self-hosted GitLab bootstrap with `--gitlab-url` produces remote URLs using the custom base URL in all output (preamble, summary, README entry, CLI invocations).

## Clarifications

### Session 2026-04-10

- Q: When a workspace/project name contains characters invalid for GitLab repo names (e.g., spaces), should the script normalize the name or fail? → A: Normalize and notify — convert to a valid GitLab slug (spaces → hyphens, lowercase) and display the resulting repo name in preamble and summary output.
- Q: Should `--gitlab-url` be validated at input parsing time? → A: Validate the `https://` prefix at input parsing time — `bootstrap-workspace.sh/.ps1` exits with code 1 and `bootstrap-project.sh/.ps1` exits with code 2 if the value does not start with `https://`, and both display a bilingual error before any further processing.
- Q: Should the script retry on transient network failures (glab repo create / git push)? → A: No retry — fail immediately, surface the error from glab/git, and hint the user to re-run the script.

## Assumptions

- Users targeting GitLab have or can install the GitLab CLI (version ≥ 1.40) via `brew` (macOS/Linux) or `winget` (Windows).
- `gitlab.com` SaaS is the primary target; self-hosted GitLab instances expose the standard GitLab API (`/api/v4/user` returning a `username` field).
- Self-hosted GitLab instances use HTTPS — SSH remote URL variants are out of scope for this feature.
- GitHub Enterprise Server (GHES) remains out of scope; only `github.com` is supported for the GitHub path.
- Bitbucket, Gitea, Forgejo, and other platforms are out of scope.
- CI/CD pipeline configuration for GitLab is a separate subsequent feature and not addressed here.
- Migration of existing workspaces from GitHub to GitLab is a separate subsequent feature and not addressed here.
- OAuth flows and Personal Access Token management are delegated entirely to `glab auth login` — no custom auth code is introduced.
- The existing `bootstrap-workspace.sh/.ps1` and `bootstrap-project.sh/.ps1` scripts implement a working GitHub flow; this feature extends that flow without replacing it.
- Agent instruction files (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`) and `README.md` require updates to document the new `--platform` parameter and add a pitfall entry for `glab auth login` in background processes.
