# Research: GitLab Support for Bootstrap Scripts

**Feature**: `006-gitlab-support`  
**Date**: 2026-04-10  
**Status**: Complete — all NEEDS CLARIFICATION resolved

---

## Decision 1: `glab repo create` Command Syntax

**Decision**: Use `GITLAB_HOST` environment variable to target self-hosted instances; use `--private` flag for visibility.

**Rationale**: `glab repo create` does not accept a `--hostname` flag. The documented approach for self-hosted is either `GITLAB_HOST=example.com glab repo create <name>` or the full path form `glab repo create example.com/user/repo`. The `GITLAB_HOST` env-var approach is cleaner because the hostname does not need to be prefixed to the repo name, making the slug derivation simpler.

**Command pattern**:
```bash
# gitlab.com
glab repo create "$REPO_SLUG" --private --description "$REPO_DESC"

# Self-hosted
GITLAB_HOST="$GITLAB_HOSTNAME" glab repo create "$REPO_SLUG" --private --description "$REPO_DESC"
```

**Note**: Unlike `gh repo create`, `glab repo create` has NO `--source` or `--push` flags. The remote must be set and the push performed as separate steps.

**Alternatives considered**: Using the full-path form `glab repo create gitlab.example.com/$GITLAB_USER/$REPO_SLUG --private` — rejected because it requires knowing the username before the create call and embeds the host in the name string, reducing readability.

---

## Decision 2: `glab api user` — Retrieving GitLab Username

**Decision**: Use `glab api user --hostname "$GITLAB_HOSTNAME"` and extract `.username` from the returned JSON.

**Rationale**: `glab api` accepts `--hostname` to override the GitLab host. This is explicit and does not rely on ambient environment variable state. The API response at `/api/v4/user` returns a JSON object; `.username` is the canonical login identifier (not `.login` like GitHub's `gh api`). Current `glab` versions do not support `--jq`, so the implementation must parse the returned JSON explicitly.

**Command pattern**:
```bash
GITLAB_USER="$(
  glab api user --hostname "$GITLAB_HOSTNAME" 2>/dev/null \
    | tr -d '\r\n' \
    | sed -n 's/.*"username":"\([^"]*\)".*/\1/p'
)"
```

**For gitlab.com**: `GITLAB_HOSTNAME="gitlab.com"`, so `--hostname gitlab.com` is redundant but harmless and keeps the code uniform.

---

## Decision 3: Authentication Check (`glab auth status`)

**Decision**: Use `GITLAB_HOST="$GITLAB_HOSTNAME" glab auth status >/dev/null 2>&1` as the pre-flight auth check.

**Rationale**: `glab auth status` exits with code 1 when not authenticated (confirmed by live test: `X could not authenticate to one or more of the configured GitLab instances`). `glab auth status` does not document a `--hostname` flag; `GITLAB_HOST` env variable is the standard way to target a specific host for this command.

**Command pattern**:
```bash
if ! GITLAB_HOST="$GITLAB_HOSTNAME" glab auth status >/dev/null 2>&1; then
  echo "Fehler: Nicht bei GitLab ($GITLAB_HOSTNAME) authentifiziert. Bitte 'glab auth login' ausführen."
  echo "Error: Not authenticated with GitLab ($GITLAB_HOSTNAME). Please run 'glab auth login'."
  # bootstrap-workspace.sh/.ps1: exit 1
  # bootstrap-project.sh/.ps1: exit 2
fi
```

For workspace bootstrap this is a fatal exit code `1`; for project bootstrap this is a fatal exit code `2`.

---

## Decision 4: Remote URL Construction and Push

**Decision**: Manually construct remote URL and add as `origin`, then push.

**Rationale**: `glab repo create` does not set a remote or push. This must be done in two explicit steps, matching the GitLab flow documented in the Lastenheft (FR-04).

**Command pattern**:
```bash
REMOTE_URL="https://${GITLAB_HOSTNAME}/${GITLAB_USER}/${REPO_SLUG}.git"
git -C "$WORKSPACE_DIR" remote add origin "$REMOTE_URL"
git -C "$WORKSPACE_DIR" push -u origin HEAD
```

**Branch name**: Use `HEAD` instead of hardcoded `main` to support repositories where the default branch may differ from the git config default.

---

## Decision 5: GitLab Repository Slug Normalization

**Decision**: Reuse the existing `normalize_name()` function from `bootstrap-workspace.sh`. Apply it to the derived `REPO_NAME` to produce `REPO_SLUG`. If `REPO_SLUG != REPO_NAME`, surface the normalized slug in user-facing setup output: in the workspace preamble box and summary output for `bootstrap-workspace.*`, and in the project summary output for `bootstrap-project.*`.

**Rationale**: The existing function already produces a conservative GitLab-compatible slug: lowercase, only `[a-z0-9-]`, no leading/trailing hyphens, consecutive hyphens collapsed. GitLab also allows `_` and `.` but allowing the existing function to strip them causes no functional harm and simplifies the implementation.

**`bootstrap-project.sh` already applies a similar transformation** at step 13: `repo_name=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')`. This will be aligned to use the same normalization logic.

---

## Decision 6: `--gitlab-url` Input Validation

**Decision**: Validate `https://` prefix with a `case` statement (POSIX-compatible, bash 3+). Extract hostname by stripping `https://` and any trailing slash.

**Rationale**: `case "$GITLAB_URL" in https://*) ;;` is portable across bash 3.x+. Early exit before any glab commands prevents cryptic errors downstream.

**Command pattern**:
```bash
case "$GITLAB_URL" in
  https://*) ;;
  *)
    echo "Fehler: --gitlab-url muss mit 'https://' beginnen (z. B. https://gitlab.example.com)."
    echo "Error: --gitlab-url must start with 'https://' (e.g. https://gitlab.example.com)."
    # bootstrap-workspace.sh/.ps1: exit 1
    # bootstrap-project.sh/.ps1: exit 2
    ;;
esac
GITLAB_HOSTNAME="${GITLAB_URL#https://}"
GITLAB_HOSTNAME="${GITLAB_HOSTNAME%/}"   # strip optional trailing slash
```

For invalid GitLab URLs, workspace bootstrap exits with code `1`, while project bootstrap exits with code `2`.

---

## Decision 7: PowerShell Equivalents

**Decision**: Mirror all Bash changes in PowerShell variants with PascalCase parameter naming.

**Parameter equivalents**:
| Bash | PowerShell |
|------|-----------|
| `--platform <github\|gitlab>` | `-Platform <github\|gitlab>` |
| `--gitlab-url <URL>` | `-GitLabUrl <URL>` |

**URL validation in PowerShell**:
```powershell
if ($Platform -eq 'gitlab' -and -not $GitLabUrl.StartsWith('https://')) {
    Write-Error "Fehler: -GitLabUrl muss mit 'https://' beginnen. / Error: -GitLabUrl must start with 'https://'."
}
```

**`GITLAB_HOST` env var in PowerShell**:
```powershell
$env:GITLAB_HOST = $gitlabHostname
try { glab auth status | Out-Null } catch { ... }
$env:GITLAB_HOST = $null  # restore
```

---

## Decision 8: Existing Script Compatibility (bootstrap-project.sh)

**Decision**: Add `--platform` and `--gitlab-url` to the existing `while [ $# -gt 0 ]` argument parsing loop. Extend Step 13 with a platform branch. Step 14 (git push) is already separate and compatible with both platforms.

**Key difference from bootstrap-workspace.sh**: `bootstrap-project.sh` Step 13 uses `--source` flag in `gh repo create` to link an existing directory and set remote in one call. For GitLab, this must be split into create + remote-add + push (same as workspace script).

---

## Decision 9: Documentation Files to Update

Files requiring pitfall entry for `glab auth login` in background processes:
- `AGENTS.md`
- `CLAUDE.md` (pitfall entry only; Active Technologies already contains `glab` and should be verified, not duplicated)
- `GEMINI.md`
- `.github/copilot-instructions.md`

Files requiring `--platform` examples:
- `README.md` (Nächste Schritte / bootstrap command examples)

**Pitfall text** (bilingual, following existing pattern):
```
### macOS/Linux/Windows: `glab auth login` in background processes
`glab auth login --web` does NOT detect browser confirmation in background/async processes.
Always run `glab auth login` in an **interactive terminal window** directly.
```
