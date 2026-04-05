# Copilot Instructions – home-baseline

This is the top-level workspace bootstrap for `~/`.
It tracks only safe infrastructure files via a whitelist `.gitignore` and distributes reusable scripts to child workspaces.

## Repository Purpose

`home-baseline` manages workspace initialisation: it provides scripts that turn a plain directory into a private GitHub repo with `.gitignore`, standard scripts, and a `pre-push` secret-scanning hook installed. It does **not** contain application source code.

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
3. `git init` + initial commit
4. `gh repo create` (private) + push
5. `bash scripts/install-hooks.sh` — copies `scripts/hooks/pre-push` → `.git/hooks/pre-push`
6. Append a row to `~/README.md` workspace table and commit/push `home-baseline`

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

<!-- EN: copilot-instructions.md placeholder
[DE-Zusammenfassung: copilot-instructions.md enthält Anweisungen für GitHub Copilot im home-baseline Repository.]
-->
