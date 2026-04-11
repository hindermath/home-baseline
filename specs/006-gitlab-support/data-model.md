# Data Model: GitLab Support for Bootstrap Scripts

**Feature**: `006-gitlab-support`  
**Date**: 2026-04-10

---

## Entities

### Platform

Represents the chosen remote hosting service for a bootstrap operation.

| Attribute | Type | Values | Default |
|-----------|------|--------|---------|
| `name` | string (enum) | `github`, `gitlab` | `github` |

**Constraints**:
- Any value other than `github` or `gitlab` → `bootstrap-workspace.sh/.ps1` exits with code 1, `bootstrap-project.sh/.ps1` exits with code 2 (bilingual error)
- Set via `--platform` (Bash) / `-Platform` (PowerShell)

---

### GitLab Instance URL

The base URL identifying the GitLab instance to use.

| Attribute | Type | Constraint | Default |
|-----------|------|-----------|---------|
| `url` | string | Must start with `https://` | `https://gitlab.com` |
| `hostname` | string (derived) | `url` with `https://` prefix and trailing `/` stripped | `gitlab.com` |

**Constraints**:
- Only evaluated when `Platform = gitlab`
- Validated at parse time: must start with `https://`; invalid → `bootstrap-workspace.sh/.ps1` exits with code 1, `bootstrap-project.sh/.ps1` exits with code 2
- `hostname` is derived: `GITLAB_HOSTNAME="${GITLAB_URL#https://}"`, then trailing slash stripped

---

### GitLab Repository Slug

The normalized name used as the GitLab repository identifier.

| Attribute | Type | Constraint |
|-----------|------|-----------|
| `original_name` | string | Raw workspace/project name as provided by the user |
| `slug` | string | `normalize_name(original_name)`: lowercase, `[a-z0-9-]` only, no leading/trailing hyphens |
| `was_normalized` | boolean | `true` if `slug != original_name` (lowercased) |

**Normalization rules** (applied by existing `normalize_name()` function):
1. Lowercase all characters
2. Replace any character not in `[a-z0-9]` with `-`
3. Collapse consecutive hyphens to one
4. Strip leading and trailing hyphens

**Display rule**: If `was_normalized = true`, the resulting slug MUST be surfaced in user-facing setup output: in the workspace preamble box and summary output for `bootstrap-workspace.*`, and in the project summary output for `bootstrap-project.*`.

---

### GitLab Username

The authenticated user's login identifier, retrieved at runtime.

| Attribute | Type | Source |
|-----------|------|--------|
| `username` | string | `glab api user --hostname <hostname>` + JSON parse of `.username` |

**Constraints**:
- Retrieved only when `Platform = gitlab`
- If retrieval fails (empty result or non-zero exit) → `bootstrap-workspace.sh/.ps1` exits with code 1, `bootstrap-project.sh/.ps1` exits with code 2

---

### Remote URL

The constructed Git remote URL for the new repository.

| Attribute | Type | Pattern |
|-----------|------|---------|
| `url` | string | `https://<hostname>/<username>/<slug>.git` |

**Examples**:
- GitLab SaaS: `https://gitlab.com/hindermath/myworkspace-baseline.git`
- Self-hosted: `https://gitlab.example.com/hindermath/myworkspace-baseline.git`
- GitHub (unchanged): `https://github.com/hindermath/myworkspace-baseline.git`

---

### Repository

The private remote repository created on the chosen platform.

| Attribute | Type | Value |
|-----------|------|-------|
| `name` | string | Repository slug (GitLab) or REPO_NAME (GitHub, existing behavior) |
| `visibility` | string | Always `private` |
| `description` | string | `REPO_DESC` |
| `platform` | Platform | Chosen platform |
| `remote_url` | Remote URL | Constructed based on platform and instance |

---

## State Transitions (Bootstrap Flow)

```text
[IDLE]
  │
  ├─ validate parameters (platform, gitlab-url) → error if invalid
  ├─ check CLI tool installed (gh or glab) → error if missing
  ├─ check CLI tool authenticated → error if not authenticated
  ├─ retrieve username (GitLab: glab api user; GitHub: gh api user)
  │
  ▼
[PRE-FLIGHT PASSED]
  │
  ├─ git init + initial commit (platform-independent)
  │
  ▼
[REPO CREATION]
  ├─ GitHub: gh repo create ... --source ... --remote origin --push (atomic)
  ├─ GitLab: glab repo create $SLUG --private
  │          git remote add origin $REMOTE_URL
  │          git push -u origin HEAD
  │
  ▼
[POST-SETUP]
  ├─ install hooks (platform-independent)
  ├─ update ~/README.md (platform-aware URL)
  ├─ git scope isolation (platform-independent)
  │
  ▼
[COMPLETE]
  └─ summary output (platform-aware URLs)
```

**Error state**: Workspace fatal validation/auth/API failures exit with code 1; project fatal validation/auth/API failures exit with code 2. No retry. The user is prompted to re-run after correcting the issue.

---

## Parameter Relationships

```text
--platform github  →  requires: gh installed + authenticated
                   →  uses: gh repo create (existing behavior)
                   →  README URL: https://github.com/$GH_USER/$REPO_NAME

--platform gitlab  →  requires: glab installed + authenticated
                   →  validates: --gitlab-url starts with https://
                   →  derives: GITLAB_HOSTNAME from GITLAB_URL
                   →  retrieves: GITLAB_USER via glab api
                   →  normalizes: REPO_SLUG from REPO_NAME
                   →  uses: glab repo create + git remote add + git push
                   →  README URL: $GITLAB_URL/$GITLAB_USER/$REPO_SLUG
```
