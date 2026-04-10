# Implementation Plan: GitLab Support for Bootstrap Scripts

**Branch**: `006-gitlab-support` | **Date**: 2026-04-10 | **Spec**: [spec.md](spec.md)  
**Input**: Feature specification from `/specs/006-gitlab-support/spec.md`

---

## Summary

Extend `bootstrap-workspace.sh/.ps1` and `bootstrap-project.sh/.ps1` to accept an optional `--platform <github|gitlab>` parameter. When `gitlab` is selected, the scripts use `glab` (GitLab CLI) instead of `gh` (GitHub CLI) to create a private repository, set the `origin` remote, and push the initial commit. Default behavior (GitHub) is preserved unconditionally. Self-hosted GitLab is supported via `--gitlab-url`. All new output is bilingual (DE/EN). Both Bash and PowerShell variants are updated in parity.

---

## Technical Context

**Language/Version**: Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows)  
**Primary Dependencies**: `glab` ≥ 1.40 (new) · `gh` ≥ 2.30 (existing) · `git` ≥ 2.30 (existing)  
**Storage**: N/A — file modifications to existing scripts and `~/README.md`  
**Testing**: Manual verification via `--dry-run` (Bash) / `-WhatIf` and `-Preview` (PowerShell) per Constitution Principle V  
**Target Platform**: macOS, Linux, Windows  
**Project Type**: CLI scripts (infrastructure tooling)  
**Performance Goals**: Bootstrap completes in ≤60 seconds on stable connection (SC-001)  
**Constraints**: No automated test framework (Constitution V); Bash 3.x+ compatibility required  
**Scale/Scope**: 4 script files modified · 5 documentation files updated · 0 new files created in `scripts/`

---

## Constitution Check

*GATE: Must pass before implementation. All principles evaluated.*

| Principle | Status | Evidence |
|-----------|--------|---------|
| I. Security-First | ✅ PASS | No credentials in code; auth delegated to `glab auth login`; `https://` validation enforced on `--gitlab-url`; pre-push hook unchanged; no new tracked paths |
| II. Cross-Platform Parity | ✅ REQUIRED | All 4 scripts updated in `.sh`/`.ps1` pairs; committed together |
| III. Bootstrap Automation | ✅ PASS | Feature IS bootstrap automation; extends existing flow |
| IV. Workspace Isolation | ✅ PASS | No new tracked categories; `AGENTS.md`, `CLAUDE.md`, etc. already tracked |
| V. Manual-First Verification | ✅ REQUIRED | All changes verified with `--dry-run` / `-WhatIf` before live execution |

**Script & Code Conventions** (checked):
- Bash: `#!/usr/bin/env bash` + `set -euo pipefail` ✅ (preserved)
- PowerShell: `#Requires -Version 7` + `Set-StrictMode -Version Latest` + `$ErrorActionPreference = 'Stop'` ✅ (preserved)
- Indentation: 2 spaces (Bash), 4 spaces (PowerShell) ✅
- User-facing messages: German primary, English secondary ✅
- Visual output: box-drawing characters for preamble ✅

**No gate violations.** No Complexity Tracking entry required.

---

## Project Structure

### Documentation (this feature)

```text
specs/006-gitlab-support/
├── plan.md                               ← This file
├── research.md                           ← Phase 0 output (glab command decisions)
├── data-model.md                         ← Phase 1 output (entities + state transitions)
├── quickstart.md                         ← Phase 1 output (usage guide)
├── contracts/
│   ├── bootstrap-workspace-cli.md        ← Phase 1 output (updated CLI contract)
│   └── bootstrap-project-cli.md          ← Phase 1 output (updated CLI contract)
├── checklists/
│   └── requirements.md                   ← Spec quality checklist (all pass)
└── tasks.md                              ← Phase 2 output (/speckit.tasks command)
```

### Source Code Changes (repository root)

```text
scripts/
├── bootstrap-workspace.sh    ← MODIFY: add --platform, --gitlab-url, GitLab path
├── bootstrap-workspace.ps1   ← MODIFY: add -Platform, -GitLabUrl, GitLab path
├── bootstrap-project.sh      ← MODIFY: add --platform, --gitlab-url, Step 13 platform branch
└── bootstrap-project.ps1     ← MODIFY: add -Platform, -GitLabUrl, Step 13 platform branch

AGENTS.md                     ← MODIFY: add glab auth login pitfall entry
CLAUDE.md                     ← MODIFY: add glab auth login pitfall entry
GEMINI.md                     ← MODIFY: add glab auth login pitfall entry
.github/copilot-instructions.md  ← MODIFY: add glab auth login pitfall entry
README.md                     ← MODIFY: add --platform examples in Nächste Schritte section
```

---

## Implementation Design

### 1. Parameter Parsing — `bootstrap-workspace.sh`

Convert the current positional-only parsing to a loop that handles both named flags and positional arguments:

```bash
DRY_RUN=0
PLATFORM="github"
GITLAB_URL="https://gitlab.com"
WORKSPACE_NAME=""
REPO_NAME=""
REPO_DESC=""

while [ $# -gt 0 ]; do
  case "${1:-}" in
    --dry-run)     DRY_RUN=1 ;;
    --platform)    PLATFORM="${2:-}"; shift ;;
    --gitlab-url)  GITLAB_URL="${2:-}"; shift ;;
    --help|-h)     usage ;;
    --*)
      echo "Fehler: Unbekannte Option: $1 / Error: Unknown option: $1" >&2; exit 1 ;;
    *)
      if   [ -z "$WORKSPACE_NAME" ]; then WORKSPACE_NAME="$1"
      elif [ -z "$REPO_NAME"      ]; then REPO_NAME="$1"
      elif [ -z "$REPO_DESC"      ]; then REPO_DESC="$1"
      fi ;;
  esac
  shift
done
```

### 2. Platform Validation — `bootstrap-workspace.sh`

Immediately after parsing, validate platform and `--gitlab-url`:

```bash
case "$PLATFORM" in
  github|gitlab) ;;
  *)
    echo "Fehler: Ungültige Plattform '$PLATFORM'. Gültige Werte: github, gitlab." >&2
    echo "Error: Invalid platform '$PLATFORM'. Valid values: github, gitlab." >&2
    exit 1 ;;
esac

if [ "$PLATFORM" = "gitlab" ]; then
  case "$GITLAB_URL" in
    https://*) ;;
    *)
      echo "Fehler: --gitlab-url muss mit 'https://' beginnen." >&2
      echo "Error: --gitlab-url must start with 'https://'." >&2
      exit 1 ;;
  esac
  GITLAB_HOSTNAME="${GITLAB_URL#https://}"
  GITLAB_HOSTNAME="${GITLAB_HOSTNAME%/}"
fi
```

### 3. Tool + Auth Pre-flight — `bootstrap-workspace.sh`

Replace the current unconditional `gh` check with a platform-conditional block:

```bash
# Platform-specific tool checks
if [ "$PLATFORM" = "github" ]; then
  if ! command -v gh >/dev/null 2>&1; then
    echo "Fehler: gh (GitHub CLI) ist nicht installiert." >&2; exit 1
  fi
  GH_USER=$(gh api user --jq '.login' 2>/dev/null || true)
  if [ -z "$GH_USER" ]; then
    echo "Fehler: Nicht bei GitHub authentifiziert. Bitte 'gh auth login' ausführen." >&2; exit 1
  fi

elif [ "$PLATFORM" = "gitlab" ]; then
  if ! command -v glab >/dev/null 2>&1; then
    echo "Fehler: glab (GitLab CLI) ist nicht installiert." >&2
    echo "  macOS/Linux: brew install glab" >&2
    echo "  Windows:     winget install GLabCLI.GlabCLI" >&2
    echo "Error: glab (GitLab CLI) is not installed." >&2
    exit 1
  fi
  if ! GITLAB_HOST="$GITLAB_HOSTNAME" glab auth status >/dev/null 2>&1; then
    echo "Fehler: Nicht bei GitLab ($GITLAB_HOSTNAME) authentifiziert. Bitte 'glab auth login' ausführen." >&2
    echo "Error: Not authenticated with GitLab ($GITLAB_HOSTNAME). Please run 'glab auth login'." >&2
    exit 1
  fi
  GITLAB_USER=$(glab api user --hostname "$GITLAB_HOSTNAME" --jq '.username' 2>/dev/null || true)
  if [ -z "$GITLAB_USER" ]; then
    echo "Fehler: Konnte GitLab-Benutzername nicht ermitteln." >&2
    echo "Error: Could not retrieve GitLab username." >&2
    exit 1
  fi
fi
```

### 4. Repo Name + Slug Derivation — `bootstrap-workspace.sh`

After auth checks, derive `REPO_NAME` as before (only for GitHub). For GitLab, additionally normalize to a slug:

```bash
if [ -z "$REPO_NAME" ]; then
  REPO_NAME="$(echo "$WORKSPACE_NAME" | tr '[:upper:]' '[:lower:]' \
    | sed 's/projects$/-baseline/' | sed 's/ /-/g')"
fi
if [ -z "$REPO_DESC" ]; then
  REPO_DESC="Gemeinsame Workspace-Konfiguration für $WORKSPACE_NAME"
fi

# GitLab: normalize repo name to valid slug
if [ "$PLATFORM" = "gitlab" ]; then
  REPO_SLUG=$(normalize_name "$REPO_NAME")
  SLUG_CHANGED=0
  [ "$REPO_SLUG" != "$REPO_NAME" ] && SLUG_CHANGED=1
else
  REPO_SLUG="$REPO_NAME"
  SLUG_CHANGED=0
fi
```

### 5. Preamble Box — `bootstrap-workspace.sh`

Add a `Plattform` line and, when slug was normalized, a `GitLab-Slug` line:

```bash
# In the preamble printf block:
if [ "$PLATFORM" = "github" ]; then
  printf "║  Plattform   : %-51s║\n" "GitHub (privat)"
else
  printf "║  Plattform   : %-51s║\n" "GitLab — $GITLAB_URL (privat)"
  if [ "$SLUG_CHANGED" -eq 1 ]; then
    printf "║  GitLab-Slug : %-51s║\n" "$REPO_SLUG (normalisiert von: $REPO_NAME)"
  fi
fi
```

### 6. Remote Repo Creation — `bootstrap-workspace.sh`

Replace the single `gh repo create` call with a platform branch:

```bash
if [ "$PLATFORM" = "github" ]; then
  info "Erstelle privates GitHub-Repository '$REPO_NAME' …"
  run "gh repo create '$REPO_NAME' --private --description '$REPO_DESC' \
    --source '$WORKSPACE_DIR' --remote origin --push"
  ok "GitHub-Repo erstellt und gepusht"

elif [ "$PLATFORM" = "gitlab" ]; then
  REMOTE_URL="https://${GITLAB_HOSTNAME}/${GITLAB_USER}/${REPO_SLUG}.git"
  info "Erstelle privates GitLab-Repository '$REPO_SLUG' …"
  run "GITLAB_HOST='$GITLAB_HOSTNAME' glab repo create '$REPO_SLUG' \
    --private --description '$REPO_DESC'"
  ok "GitLab-Repo erstellt"
  run "git -C '$WORKSPACE_DIR' remote add origin '$REMOTE_URL'"
  run "git -C '$WORKSPACE_DIR' push -u origin HEAD"
  ok "Remote gesetzt und gepusht"
fi
```

### 7. README.md Row + Summary Output — `bootstrap-workspace.sh`

Make the row URL and summary URLs platform-aware:

```bash
# README row
if [ "$PLATFORM" = "github" ]; then
  REPO_URL="https://github.com/$GH_USER/$REPO_NAME"
  REMOTE_USER="$GH_USER"
  DISPLAY_REPO="$REPO_NAME"
else
  REPO_URL="$GITLAB_URL/$GITLAB_USER/$REPO_SLUG"
  REMOTE_USER="$GITLAB_USER"
  DISPLAY_REPO="$REPO_SLUG"
fi
NEW_ROW="| \`~/$WORKSPACE_NAME/\` | [$DISPLAY_REPO]($REPO_URL) | \`bootstrap-workspace\` |"

# Summary
echo "  Repo   : $REPO_URL"
echo "  Clone  : git clone ${REPO_URL}.git ~/$WORKSPACE_NAME"
```

### 8. `bootstrap-project.sh` — Parameter Parsing, Preview, and Step 13 Platform Branch

Extend the current argument parsing to add GitLab options and defaults, and add a local slug helper before the preview/action helpers:

```bash
OPT_PLATFORM="github"
OPT_GITLAB_URL="https://gitlab.com"
OPT_GITLAB_HOSTNAME=""

normalize_name() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-\|-$//g'
}

while [ $# -gt 0 ]; do
  case "$1" in
    --preview|--dry-run) OPT_PREVIEW=true; OPT_DRY_RUN=true ;;
    --force)      OPT_FORCE=true ;;
    --no-agents)  OPT_NO_AGENTS=true ;;
    --no-speckit) OPT_NO_SPECKIT=true ;;
    --no-remote)  OPT_NO_REMOTE=true ;;
    --platform)   OPT_PLATFORM="${2:-github}"; shift ;;
    --gitlab-url) OPT_GITLAB_URL="${2:-https://gitlab.com}"; shift ;;
    --lang)       OPT_LANG="${2:-de}"; shift ;;
    --*) echo "ERROR: unknown option $1" >&2; exit 2 ;;
    *)
      if [ -z "$PROJECT_NAME" ]; then
        PROJECT_NAME="$1"
      elif [ -z "$TARGET_WORKSPACE" ]; then
        TARGET_WORKSPACE="$1"
      fi ;;
  esac
  shift
done

case "$OPT_PLATFORM" in
  github|gitlab) ;;
  *)
    echo "Fehler: Ungültige Plattform '$OPT_PLATFORM'. Gültige Werte: github, gitlab." >&2
    echo "Error: Invalid platform '$OPT_PLATFORM'. Valid values: github, gitlab." >&2
    exit 2 ;;
esac

if [ "$OPT_PLATFORM" = "gitlab" ]; then
  case "$OPT_GITLAB_URL" in
    https://*) ;;
    *)
      echo "Fehler: --gitlab-url muss mit 'https://' beginnen." >&2
      echo "Error: --gitlab-url must start with 'https://'." >&2
      exit 2 ;;
  esac
  OPT_GITLAB_HOSTNAME="${OPT_GITLAB_URL#https://}"
  OPT_GITLAB_HOSTNAME="${OPT_GITLAB_HOSTNAME%/}"
fi
```

Update the preview block so the remote creation lines reflect the selected platform:

```bash
if $OPT_NO_REMOTE; then
  preview_action "SKIP" "Remote-Erstellung" "--no-remote"
elif [ "$OPT_PLATFORM" = "github" ]; then
  preview_action "EXEC" "gh repo create (privat)" "optional"
  preview_action "EXEC" "git push" "optional"
else
  preview_action "EXEC" "glab repo create (privat)" "optional"
  preview_action "EXEC" "git remote add origin https://HOST/USER/REPO.git" "optional"
  preview_action "EXEC" "git push" "optional"
fi
```

The existing Step 13 code uses `gh repo create --private --source --remote origin`. Replace it with a platform branch:

```bash
step_start "Repo erstellen (privat)"
if $OPT_NO_REMOTE; then
  step_skip "--no-remote"
elif git -C "$TARGET_DIR" remote get-url origin >/dev/null 2>&1; then
  step_skip "Remote vorhanden"
elif [ "$OPT_PLATFORM" = "github" ]; then
  if command -v gh >/dev/null 2>&1; then
    repo_name=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
    if gh repo create "$repo_name" --private --source "$TARGET_DIR" --remote origin >/dev/null 2>&1; then
      step_done "$repo_name"
    else
      step_warn "gh repo create fehlgeschlagen"
    fi
  else
    step_skip "gh nicht installiert"
  fi
elif [ "$OPT_PLATFORM" = "gitlab" ]; then
  if ! command -v glab >/dev/null 2>&1; then
    step_warn "glab nicht installiert / glab not installed (brew install glab / winget install GLabCLI.GlabCLI)"
  elif ! GITLAB_HOST="$OPT_GITLAB_HOSTNAME" glab auth status >/dev/null 2>&1; then
    step_warn "Nicht bei GitLab authentifiziert. Bitte 'glab auth login' ausführen. / Not authenticated with GitLab. Please run 'glab auth login'."
  else
    GITLAB_USER_LOCAL=$(glab api user --hostname "$OPT_GITLAB_HOSTNAME" --jq '.username' 2>/dev/null || true)
    repo_slug=$(normalize_name "$PROJECT_NAME")
    REMOTE_URL="https://${OPT_GITLAB_HOSTNAME}/${GITLAB_USER_LOCAL}/${repo_slug}.git"
    if GITLAB_HOST="$OPT_GITLAB_HOSTNAME" \
        glab repo create "$repo_slug" --private >/dev/null 2>&1; then
      git -C "$TARGET_DIR" remote add origin "$REMOTE_URL" >/dev/null 2>&1
      step_done "$repo_slug"
    else
      step_warn "glab repo create fehlgeschlagen / glab repo create failed"
    fi
  fi
fi
```

Step 14 (git push) is already a separate step and requires no structural change — it checks for remote existence and pushes, which works for both platforms.

Add GitLab-aware project output polish after remote creation:
- when the normalized GitLab slug differs from `PROJECT_NAME`, show the resulting slug in the project summary output
- make the final project summary platform-aware so the reported repository URL and clone/push guidance use GitHub or GitLab consistently
- keep `~/README.md` updates platform-aware for GitLab and self-hosted GitLab URLs
- note explicitly that `bootstrap-project.*` does not use the workspace-style preamble box; its slug disclosure requirement is satisfied via the final project summary output

### 9. `bootstrap-workspace.ps1` Parameter Block

Add `-Platform` and `-GitLabUrl` to the `param()` block:

```powershell
param(
    [Parameter(Mandatory)][string] $WorkspaceName,
    [string] $RepoName      = '',
    [string] $Description   = '',
    [string] $Platform      = 'github',
    [string] $GitLabUrl     = 'https://gitlab.com'
)
```

**Validation**:
```powershell
if ($Platform -notin @('github', 'gitlab')) {
    Write-Error "Fehler: Ungültige Plattform '$Platform'. Gültige Werte: github, gitlab.`nError: Invalid platform '$Platform'. Valid values: github, gitlab."
}

if ($Platform -eq 'gitlab') {
    if (-not $GitLabUrl.StartsWith('https://')) {
        Write-Error "Fehler: -GitLabUrl muss mit 'https://' beginnen.`nError: -GitLabUrl must start with 'https://'."
    }
    $gitlabHostname = ($GitLabUrl -replace '^https://', '').TrimEnd('/')
}
```

**glab checks** (parallel to Bash § 3):
```powershell
if ($Platform -eq 'gitlab') {
    if (-not (Get-Command glab -ErrorAction SilentlyContinue)) {
        Write-Error "Fehler: glab (GitLab CLI) ist nicht installiert.`n  macOS/Linux: brew install glab`n  Windows: winget install GLabCLI.GlabCLI`nError: glab (GitLab CLI) is not installed."
    }
    $env:GITLAB_HOST = $gitlabHostname
    try { glab auth status 2>&1 | Out-Null } catch {
        $env:GITLAB_HOST = $null
        Write-Error "Fehler: Nicht bei GitLab ($gitlabHostname) authentifiziert. Bitte 'glab auth login' ausführen.`nError: Not authenticated. Please run 'glab auth login'."
    }
    $env:GITLAB_HOST = $null
    $gitlabUser = (glab api user --hostname $gitlabHostname --jq '.username' 2>$null).Trim()
    if (-not $gitlabUser) { Write-Error "Fehler: GitLab-Benutzername konnte nicht ermittelt werden." }
}
```

**Slug normalization** (PowerShell equivalent of `normalize_name()`):
```powershell
function ConvertTo-GitLabSlug([string]$Name) {
    $Name.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-|-$', ''
}
```

Note: `ConvertTo-NormalizedName` already exists in `bootstrap-workspace.ps1` and implements the same logic — reuse it for GitLab slugs.

### 10. Documentation Updates

**Files to update with `glab auth login` pitfall** (same text pattern as existing `gh auth login` entry):

```markdown
### macOS/Linux/Windows: glab auth login in Hintergrundprozessen / glab auth login in background processes
`glab auth login --web` does NOT detect browser confirmation in background/async processes.
Always run `glab auth login` in an **interactive terminal window** directly.
```

Add to: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`

**`CLAUDE.md` Active Technologies** — verify existing entry, do not duplicate it:
`glab` ≥ 1.40 is already present under `## Active Technologies` for `(006-gitlab-support)`.

**`README.md`** — update the concrete examples under `### Nächste Schritte / Next steps`:
- `**1 — Workspace anlegen / Create a workspace**`
- `**2 — Projekt anlegen / Create a project**`
- the two explanatory blockquotes that currently mention `gh repo create`

```bash
bash ~/scripts/bootstrap-workspace.sh MyWorkspace --platform gitlab
bash ~/scripts/bootstrap-workspace.sh MyWorkspace --platform gitlab --gitlab-url https://gitlab.example.com
bash ~/scripts/bootstrap-project.sh MyProject ~/MyWorkspace --preview --platform gitlab
```

---

## Implementation Sequence

The following order minimises merge conflicts and ensures each change is independently reviewable:

```text
Task 1   bootstrap-workspace.sh — parameter parsing + validation
Task 2   bootstrap-workspace.sh — pre-flight checks (glab install + auth)
Task 3   bootstrap-workspace.sh — repo creation + remote + push (GitLab path)
Task 4   bootstrap-workspace.sh — preamble + summary output + README row
Task 5   bootstrap-workspace.ps1 — full equivalent of Tasks 1–4, including explicit bilingual platform validation
Task 6   bootstrap-project.sh — slug helper + parameter parsing + preview updates + Step 13 platform branch
Task 7   bootstrap-project.ps1 — full equivalent of Task 6, including `-Preview` parity
Task 8   Documentation files (AGENTS.md, CLAUDE.md, GEMINI.md, copilot-instructions.md, README.md `Nächste Schritte / Next steps`)
Task 9   Manual dry-run/preview verification (workspace + project, Bash + PowerShell)
```

**Critical path**: Tasks 1 → 2 → 3 → 4 (sequential, same file).  
Task 5 is independent of Task 6.  
Task 8 is independent of all script tasks.

---

## Verification Plan

Before every commit, run dry-run to check planned output:

```bash
# AC-01 — GitLab dry-run shows correct actions
bash scripts/bootstrap-workspace.sh --dry-run TestWS --platform gitlab

# AC-03 — GitHub default unaffected (regression)
bash scripts/bootstrap-workspace.sh --dry-run TestWS

# AC-04 — Invalid platform exits 1
bash scripts/bootstrap-workspace.sh --dry-run TestWS --platform invalid
echo "exit: $?"

# AC-05 — glab not installed error
# Simulate by masking PATH so `glab` is not resolvable for the current shell/session
# AC-05b — unauthenticated glab error
# Simulate with `glab auth logout` (or host-specific logout) before rerunning the command

# AC-07 / SC-006 — PowerShell workspace equivalent
pwsh scripts/bootstrap-workspace.ps1 -WorkspaceName TestWS -Platform gitlab -WhatIf

# AC-08 / SC-005 — README row + summary output use GitLab URL
# Verify the dry-run output and post-bootstrap README row point to GitLab, not GitHub
bash scripts/bootstrap-workspace.sh --dry-run TestWS --platform gitlab

# AC-09 / SC-007 — Self-hosted URL in all output
bash scripts/bootstrap-workspace.sh --dry-run TestWS --platform gitlab \
  --gitlab-url https://gitlab.example.com

# AC-10 — bootstrap-project Bash preview
bash scripts/bootstrap-project.sh TestProject . --preview --platform gitlab

# AC-10b — bootstrap-project invalid platform exits 2
bash scripts/bootstrap-project.sh TestProject . --preview --platform invalid
echo "exit: $?"

# AC-10c — bootstrap-project invalid GitLab URL exits 2
bash scripts/bootstrap-project.sh TestProject . --preview --platform gitlab --gitlab-url http://gitlab.example.com
echo "exit: $?"

# SC-006 — bootstrap-project PowerShell preview parity
pwsh scripts/bootstrap-project.ps1 -ProjectName TestProject -TargetWorkspace . -Preview -Platform gitlab

# AC-10d — bootstrap-project PowerShell invalid platform
pwsh scripts/bootstrap-project.ps1 -ProjectName TestProject -TargetWorkspace . -Preview -Platform invalid

# AC-10e — bootstrap-project PowerShell invalid GitLab URL
pwsh scripts/bootstrap-project.ps1 -ProjectName TestProject -TargetWorkspace . -Preview -Platform gitlab -GitLabUrl http://gitlab.example.com

# SC-001 — workspace GitLab live bootstrap completes within 60 seconds
# Measure wall-clock time during a real authenticated GitLab workspace bootstrap
time bash scripts/bootstrap-workspace.sh TestWS --platform gitlab
```

Live tests (AC-02, AC-06, AC-08, AC-09, AC-10) require real `glab` authentication and are run after dry-run/preview validation.
