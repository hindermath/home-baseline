# Copilot Instructions – home-baseline

This is the top-level workspace bootstrap for `~/`.
It tracks only safe infrastructure files via a whitelist `.gitignore` and distributes reusable scripts to child workspaces.

## Repository Purpose

`home-baseline` manages workspace initialisation: it provides scripts that turn a plain directory into a private GitHub or GitLab repo with `.gitignore`, standard scripts, and a `pre-push` secret-scanning hook installed. It does **not** contain application source code.

## Working Directory

**IMPORTANT:** Always work in `~/home-baseline-tmp` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
cd ~/home-baseline-tmp   # ← start Copilot CLI here
gh copilot
# → make changes, commit, push

# After push: sync to ~/
bash ~/scripts/sync-home.sh --no-pull   # macOS/Linux
pwsh ~/scripts/sync-home.ps1 -NoPull   # Windows
```

| Directory | Git-Remote | Purpose |
|---|---|---|
| `~/home-baseline-tmp` | ✅ `origin` → GitHub | Development, commits, push |
| `~/` | ❌ no remote | Local copy for scripts & hooks |

## Validation Commands

There is no build step. Validate changes by running scripts directly.

```bash
# Bash (macOS / Linux)
bash scripts/bootstrap-workspace.sh --dry-run FlutterProjects   # preview, no writes
bash scripts/install-hooks.sh
bash scripts/scan-agent-secrets.sh --fail-on-high .

# PowerShell 7+ (Windows)
pwsh scripts/bootstrap-workspace.ps1 -WorkspaceName FlutterProjects -WhatIf
pwsh scripts/install-hooks.ps1 -Verbose
pwsh scripts/scan-agent-secrets.ps1 -FailOnHigh
```

Always use `--dry-run` / `-WhatIf` before changing bootstrap logic. Reinstall hooks after editing anything under `scripts/hooks/`.

### Cross-platform test output (macOS / Linux / Windows)

When terminal output cannot be copy-pasted between machines, use the matching platform test script:

```bash
# On the Mac — collects info, commits and pushes results automatically:
bash ~/home-baseline-tmp/scripts/mac-test.sh

# On Linux / WSL:
bash ~/home-baseline-tmp/scripts/linux-test.sh
```
```powershell
# On Windows:
pwsh ~/home-baseline-tmp/scripts/windows-test.ps1
```

Results land in `mac-test-output.txt`, `linux-test-output.txt`, or `windows-test-output.txt` in the repo. Read from Windows:
```powershell
git -C "$HOME\home-baseline-tmp" pull
Get-Content "$HOME\home-baseline-tmp\windows-test-output.txt"  # oder mac-test-output.txt, linux-test-output.txt
```

## OS-Detection — Script Selection

At the start of each session, detect the OS and call the matching script variant:

| OS | Shell | Extension | Detection |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Rule:** On Windows always call `pwsh scripts/xyz.ps1`. On macOS/Linux always call `bash scripts/xyz.sh`. Both variants are functionally equivalent — never mix them. Validate changes by running the variant that matches the current OS.

## Architecture

### Bootstrap flow (`bootstrap-workspace.sh` / `.ps1`)

1. Detect existing sub-repos (`.git/` directories) inside the target directory → add them to `.gitignore`
2. Copy `scripts/` (secret scanner, hook installer, `pre-push` hook) into workspace
3. `git init` + initial commit + apply local git settings (`git config --local`)
4. `gh repo create` or `glab repo create` (private) + push
5. `bash scripts/install-hooks.sh` — copies `scripts/hooks/pre-push` → `.git/hooks/pre-push`
6. If `~/.gitconfig.d/` exists: append `[includeIf "gitdir:~/WorkspaceName/"]` block to `~/.gitconfig` pointing to `~/.gitconfig.d/<workspacename>.inc` (idempotent — no duplicate if already present)
7. Append a row to `~/README.md` workspace table and commit/push `home-baseline`

**`bootstrap-project` vs. `bootstrap-workspace` git config scope**: `bootstrap-project` applies settings only via `git config --local` inside the new project repo — it MUST NOT and does not touch `~/.gitconfig` or `~/.gitconfig.d/`. Only `bootstrap-workspace` writes `includeIf` blocks.

### Teardown flow (`teardown-workspace.sh` / `.ps1`)

Reverses the bootstrap in a safe, ordered sequence:
1. Create backup archive (if `--backup` / `-Backup`)
2. Safety checks — abort on uncommitted changes or unpushed commits (unless `--force`)
3. Delete remote repo via `gh repo delete` or `glab repo delete` (auto-detected from remote URL); skip if `--keep-remote`
4. Delete local workspace directory
5. Clean up artifacts: remove row from `~/README.md`, entry from `~/.gitignore`, `[includeIf]` block from `~/.gitconfig`, and `~/.gitconfig.d/<name>.inc`
6. Atomic commit of all artifact changes in `~/`

Alias: `bootstrap-workspace.sh --teardown <WorkspaceName>` delegates to `teardown-workspace.sh`.
The workspace name `home-baseline` is explicitly protected (exit 2).

### Secret-scanning infrastructure

- **`scripts/hooks/pre-push`** — runs on every `git push`; scans only git-tracked files (`.gitignore` respected); blocks push with exit 2 on HIGH findings (secret-like filenames or content patterns).
- **`scripts/scan-agent-secrets.sh` / `.ps1`** — manual scanner targeting AI-agent directories (`.claude/`, `.codex/`, `.gemini/`, `.junie/`, `.opencode/`); accepts `--fail-on-high` / `-FailOnHigh` for CI use; requires `rg` (ripgrep).

### `.gitignore` whitelist pattern

The root `.gitignore` denies everything (`/*` and `/.*`) then explicitly allows safe entries only:
```
!.gitignore
!.gitconfig
!scripts/
!README.md
```
Credential directories (`.aws/`, `.ssh/`, `.kube/`, `.docker/`, `.gnupg/`) and agent state (`.claude/`, `.codex/`, `.gemini/`, `.junie/`) are never tracked.

### Child workspace inheritance

Each bootstrapped workspace (e.g. `~/MyProjects/`, `~/WorkProjects/`) is an independent Git repo. It inherits a copy of `scripts/` and the `pre-push` hook but has its own `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, and `.github/copilot-instructions.md`. Changes to home-baseline do **not** auto-propagate; workspaces must manually sync.

## Code Conventions

### Shell scripts
- Bash: `#!/usr/bin/env bash` + `set -euo pipefail`
- PowerShell: `#Requires -Version 7` + `Set-StrictMode -Version Latest` + `$ErrorActionPreference = 'Stop'`
- Indentation: 2 spaces (Bash), 4 spaces (PowerShell)
- Filenames: kebab-case (`bootstrap-workspace.sh`)
- PowerShell parameters: PascalCase (`-WorkspaceName`, `-WhatIf`)
- Bash variables: lowercase_underscore

### User-facing messages
German primary (`Fehler:`, `Verzeichnis nicht gefunden`), English acceptable in code comments. Box-drawing characters (╔, ║, ╚, ✓, →) used for visual output blocks.

### Commits
Follow Conventional Commits: `chore:`, `docs:`, `feat:`, `fix:`. Subjects are short and imperative (example from history: `feat: bootstrap-workspace aktualisiert ~/README.md automatisch`). Always include the trailer:
```
Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>
```

### Pull requests
Include: affected scripts/docs, manual verification commands run (`--dry-run` output), and sample console output when user-visible output changes. For any change touching secret-scan or hook logic, explicitly state the risk and include scanner output.

## Security Rules

- Never commit tokens, `.env` files, or local agent state (`.claude/`, `.codex/`, `.gemini/`).
- Run `bash scripts/scan-agent-secrets.sh --fail-on-high .` before pushing any change that touches hook or scanner logic.
- The pre-push hook detects patterns like `ghp_*`, `sk-*`, `AKIA*`, `AIza*`, PEM private key headers, and secret-named files (`.env*`, `*secret*`, `*.key`, `*.pem`).

## Repository Status

- **Visibility**: public template repository (GitHub "Use this template" enabled)
- **License**: MIT
- **Branch protection**: `main` requires PR review; `enforce_admins: false` (owner can push directly)
- **CI**: green on `ubuntu-22.04`, `macos-14`, `windows-2022` via `.github/workflows/homogeneity-check.yml`
- **Compliance score**: 100 % (25/25 checks) as of last verified installation

## Known Pitfalls & Technical Decisions

### Windows: `$env:HOME` is an empty string, not `$null`
PowerShell 7's `??` null-coalescing operator does **not** catch an empty string.
Always use: `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`

### `Copy-Item` directory behaviour
When the destination already exists, `Copy-Item src dst -Recurse` copies `src` **into** `dst` (creates `dst/src/`).
Use `Copy-Item src/* dst/ -Recurse -Force` to copy contents, not the container.
Bash equivalent: `cp -r src/. dst/` instead of `cp -r src dst`.

### CI: scanner must run from the parent of `$GITHUB_WORKSPACE`
`check-homogeneity.sh/ps1` expects `TARGET_DIR` to be a relative or absolute path it can enter.
If called with just `$(basename "$GITHUB_WORKSPACE")` while `CWD` is the repo root, all files appear missing.
Correct approach:
```bash
PARENT="$(dirname "$GITHUB_WORKSPACE")"; REPO="$(basename "$GITHUB_WORKSPACE")"
cd "$PARENT" && bash "${REPO}/scripts/check-homogeneity.sh" "${REPO}"
```
PowerShell equivalent: `Set-Location (Split-Path $env:GITHUB_WORKSPACE -Parent)` then `& "${repo}/scripts/check-homogeneity.ps1" -TargetDir $repo`.

### Bash array `${#array[@]+...}` not supported on Ubuntu 22.04
`${#FAILURES[@]+"${#FAILURES[@]}"}` causes a `bad substitution` error on older bash.
Use the Bash-3-safe for-loop: `count=0; for _ in "${arr[@]+"${arr[@]}"}"; do count=$((count+1)); done`

### `hg-a11y`: fenced code block false positives
`# comment` lines inside ` ``` ` blocks were parsed as h1 headings → false `heading-gap-h1-to-h3`.
Fix: track an `$inFencedBlock` toggle on lines matching ` ``` `.

### `hg-a11y`: non-descriptive link false positives
`[hier](...)` and `[here](...)` inside backtick spans (documentation examples) triggered the link check.
Fix: strip inline code spans (`'`[^`]+`'`) from each line before pattern-matching links.

### `.gitignore` whitelist and `LICENSE`
The whitelist `.gitignore` (`/*` blocks everything) silently ignores `git add LICENSE`.
Always add `!LICENSE` to the allowlist; use `git add -f LICENSE` if needed retroactively.

### `bootstrap-workspace`: dynamic GitHub username
Both scripts previously had `hindermath` hardcoded. Fixed to detect current user:
- Bash: `GH_USER=$(gh api user --jq '.login')`
- PowerShell: `$ghUser = (gh api user --jq '.login')`

### Branch protection on GitHub Free
The `restrictions` field (who can push directly) requires a paid plan.
On a free personal account only `required_pull_request_reviews` is effective.
Set `enforce_admins: false` to allow the owner to bypass the PR requirement.

### ANSI false positive in `check-homogeneity`
The scanner itself contains `\033[` literals in comments → self-triggers the ANSI check.
Exclude via: `--glob '!check-homogeneity.*'` (rg) / `Where-Object { $_.Name -notmatch '^check-homogeneity\.(ps1|sh)$' }` (PS).

### `<!-- workspace-table-end -->` anchor must not be removed
`bootstrap-workspace.sh/ps1` and `bootstrap-project.sh/ps1` use this comment as an insertion anchor in `README.md`. Removing it breaks automated workspace-table updates.

### Duplicate heading anchors in GitHub Markdown
When the same heading text appears more than once, GitHub appends `-1`, `-2` etc. to the anchor.
TOC links for second/third occurrences must include this suffix (e.g. `#macos--linux-1`).
Avoid duplicates by making heading text unique where possible.

### Bilingual heading requirement (WCAG 2.4.6)
All headings **must** follow the `DE / EN` pattern. German-only headings break bilingual consistency and violate WCAG 2.4.6.
Exception: tool names / proper nouns (e.g. `### Homogeneity Guardian`, `### Compliance-Check`).

### Code fence language tags (WCAG 4.1.1)
Every code block **must** have a language specifier. Use `text` for ASCII art, dialog examples, and directory trees.
Bare ` ``` ` without a language violates WCAG 4.1.1 (Parsing).

### WCAG 2.2 Level AA — README compliance
The README follows WCAG 2.2 Level AA. See `## Barrierefreiheit / Accessibility (A11Y)` for the full criteria table.
Only known gap: WCAG 3.1.2 (`lang` attributes) — GitHub strips HTML attributes, cannot be implemented.

### README TOC structure
The TOC is 2-level: `##` headings as top-level items, `###` headings as nested items (2-space indent).
`####` headings are excluded from the TOC (too granular, too many platform-specific duplicates).

### CHANGELOG.md
`CHANGELOG.md` documents versions v0.1.0–v0.3.0 following Keep a Changelog format.
Must be listed in `.gitignore` whitelist as `!CHANGELOG.md`.

### ASCII box-drawing table alignment
All rows in a `text` code block table must have identical character width. A single trailing space before the closing `│` makes a row 1 char too long and breaks the visual frame.
Verify with: `$line.Length` (PowerShell) — all frame characters count as 1 char regardless of UTF-8 byte width.

### `specify init` — Spec-Kit directory setup
Never copy from `~/home-baseline-tmp/` manually. The correct command is:
`specify init --here --ai {agent}` — `--ai-skill` is required **only for Codex** (installs `.agents/skills/`).

### Workspace name starts with `-` (e.g. `-h`, `-t`)
Bash option parsing interprets `-h` as a flag, causing scripts to show help or hang waiting for stdin.
Use the `--` end-of-options sentinel: `teardown-workspace.sh -- -h`. Applies to all scripts accepting positional workspace/project names (`bootstrap-project.sh`, `bootstrap-workspace.sh`, `init-stats.sh`, `migrate-workspace.sh`, `teardown-workspace.sh`).

### Lastenheft rename on feature completion
When a feature's implementation is fully merged, rename the corresponding `Lastenheft_*.md` using:
```bash
bash scripts/rename-lastenheft.sh <LH-file> <branch-name>   # macOS/Linux
pwsh scripts/rename-lastenheft.ps1 -File <LH-file> -BranchName <branch-name>   # Windows
```
This stamps the branch name onto the filename (e.g. `Lastenheft_Foo.003-feature.md`) to mark it as archived.
The rename task is now included as the last step of every feature's Polish phase in `tasks.md` (constitution v1.1.1).
Missing this step was the root cause of 003, 005, and 006 Lastenhefte remaining unrenamed.

### Windows: `gh auth login` in background/async processes
`gh auth login --web` does NOT detect browser confirmation when run in a background or async process (e.g. Copilot CLI async shell). The browser callback never arrives.
Always run `gh auth login` in an **interactive terminal window** directly.

### macOS / Linux / Windows: `glab auth login` in background/async processes
`glab auth login --web` does NOT detect browser confirmation when run in a background or async process. The browser callback never arrives.
Always run `glab auth login` in an **interactive terminal window** directly.

### Windows: `gh` keyring becomes invalid
Symptom: `Failed to log in to github.com account (keyring)` from `gh auth status`.
Fix: `gh auth logout -h github.com -u hindermath` then `gh auth login --web -p ssh` in a real terminal.

### Windows: `ssh-agent` service disabled by default
The Windows OpenSSH Agent service is `Disabled` and requires admin rights to enable.
Use HTTPS + `gh auth setup-git` for git push instead of SSH on Windows.
After `gh auth login`, run `gh auth setup-git` once to configure git credential helper.

### Linux: `git pull` divergent branches
On Linux, `git pull` without config fails with "Need to specify how to reconcile divergent branches".
Fix once: `git config --global pull.rebase true`
Or per-call: `git pull --rebase`

### Linux: SSH for GitHub push
`gh auth setup-git` may not work if credential cache has stale entries.
Reliable fix: generate SSH key, add to GitHub, set remote to SSH:
```bash
ssh-keygen -t ed25519 -C "linux-home-baseline" -f ~/.ssh/id_ed25519 -N ""
gh ssh-key add ~/.ssh/id_ed25519.pub --title "linux-home-baseline"
git remote set-url origin git@github.com:hindermath/home-baseline.git
ssh -T git@github.com   # test
```

### Test scripts: `git pull --rebase --autostash` before push
The `*-test.sh/ps1` scripts write the output file **before** pushing. Without `--autostash`, `git pull --rebase` fails with "unstaged changes".
All test scripts use: `git pull --rebase --autostash origin main`

### Windows: `-NoProfile` for `pwsh` subprocesses
When calling `pwsh -File script.ps1` as a subprocess, PowerShell loads the user profile.
If the profile contains Oh-My-Posh or cursor-positioning code, it throws:
`Exception setting "CursorPosition": "Das Handle ist ungültig."`
Fix: always add `-NoProfile` to subprocess calls in `windows-test.ps1`.

<!-- EN: copilot-instructions.md placeholder
[DE-Zusammenfassung: copilot-instructions.md enthält Anweisungen für GitHub Copilot im home-baseline Repository.]
-->

## Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/`, remote repo, `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (new), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)

## Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf`, `~/.gitconfig.d/`, bootstrap-workspace, sync-home, check-homogeneity, pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab auto-detected), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`; `--` end-of-options für Workspace-Namen mit `-`-Präfix
- 006-gitlab-support: GitLab-CLI-Support für `bootstrap-workspace.*` und `bootstrap-project.*`, `--platform gitlab`, Self-hosted `--gitlab-url`, bilinguale Fehlerpfade
