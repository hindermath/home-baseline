# Data Model: Git Configuration Scope Isolation

**Feature**: `003-git-config-scope` | **Date**: 2026-04-09

> This feature operates on the file system, not a database. The "data model" describes
> the file entities, their schemas, validation rules, and lifecycle transitions.

---

## Entities

### 1. Global Git Config (`~/.gitconfig`)

| Attribute | Value |
|---|---|
| Location | `~/.gitconfig` |
| Format | Git INI format |
| Owner | `sync-home` (writes tracked content), user (writes include blocks) |
| Tracked | Yes — whitelisted in home-baseline |

**Allowed global keys after this feature**:

```ini
[user]
  name  = <full name>
  email = <global default email>

[init]
  defaultBranch = main

[core]
  autocrlf = input   # or true on Windows

[pull]
  rebase = true

[includeIf "gitdir:~/home-baseline-tmp/"]
  path = ~/.gitconfig.d/home-baseline.inc

[includeIf "gitdir:~/<WorkspaceName>/"]
  path = ~/.gitconfig.d/<normalized-name>.inc
# ... one block per workspace, appended by bootstrap-workspace
```

**Validation rules**:
- MUST NOT contain workspace-specific `[user]`, `[core]`, or `[alias]` sections outside `includeIf` blocks
- Each `[includeIf]` value MUST end with `/` (trailing slash required for directory-tree match)
- All path separators in `includeIf` values MUST be forward slashes (`/`) on all platforms
- No duplicate `[includeIf]` blocks for the same workspace path

**State transitions**:
```
Initial (global only)
  → bootstrap-workspace adds [includeIf] block  → Active (scoped)
  → teardown-workspace removes [includeIf] block → Active (scoped, minus removed)
```

---

### 2. Scoped Include Directory (`~/.gitconfig.d/`)

| Attribute | Value |
|---|---|
| Location | `~/.gitconfig.d/` |
| Format | Directory containing `.inc` files |
| Owner | User (content), `sync-home` (creates if missing) |
| Tracked | NO — excluded from home-baseline whitelist |

**Lifecycle**:
- Created by `sync-home` on first run if absent (with `home-baseline.inc` placeholder)
- Never modified or overwritten by `sync-home` if already present
- Added to: `bootstrap-workspace` adds per-workspace `.inc` file
- Scanned by: `pre-push` hook for credential patterns

---

### 3. Include File (`.inc`)

| Attribute | Value |
|---|---|
| Location | `~/.gitconfig.d/<normalized-workspace-name>.inc` |
| Format | Git INI format (subset) |
| Owner | User |
| Tracked | NO |

**Filename normalization rule** (from FR-005):
```
Input workspace name → lowercase → [^a-z0-9] replaced with - → deduplicate - → trim leading/trailing -
Examples:
  "home-baseline-tmp"  → home-baseline-tmp.inc
  "My Projects"        → my-projects.inc
  "WebStorm_2025"      → webstorm-2025.inc
```

**Allowed content** (examples only — user-defined):
```ini
[user]
  email = workspace-specific@example.com

[core]
  sshCommand = ssh -i ~/.ssh/workspace_key
```

**Forbidden content**:
- Credential values matching secret_content_regex (enforced by pre-push hook / FR-011)
- Absolute paths that reference non-existent resources (warning only)

**State transitions**:
```
Non-existent
  → bootstrap-workspace creates empty .inc   → Exists (empty/placeholder)
  → user edits                               → Exists (configured)
  → teardown-workspace removes               → Non-existent
```

---

### 4. Workspace Local Config (`.git/config` inside workspace)

| Attribute | Value |
|---|---|
| Location | `~/WorkspaceName/.git/config` |
| Format | Git INI format |
| Owner | `bootstrap-workspace` (initial), user |
| Tracked | NO (inside workspace repo, not home-baseline) |

**Settings written by `bootstrap-workspace`** (FR-004):

| Platform | Key | Value |
|---|---|---|
| Windows | `core.autocrlf` | `true` |
| macOS/Linux | `core.autocrlf` | `input` |

**Validation**: MUST NOT contain global identity settings (`user.name`, `user.email`) — these belong in `~/.gitconfig.d/`.

---

## Entity Relationships

```text
~/.gitconfig
    │
    ├── [global settings]  user.name, user.email, init.defaultBranch, ...
    │
    └── [includeIf "gitdir:~/WorkspaceName/"]
            │
            └── ~/.gitconfig.d/
                    │
                    ├── home-baseline.inc   ← scoped to ~/home-baseline-tmp/
                    ├── my-projects.inc     ← scoped to ~/MyProjects/
                    └── ...                 ← one per workspace
```

```text
~/WorkspaceName/                          ← Level 1 Workspace
    ├── .git/config                       ← local overrides (bootstrap-workspace)
    └── my-app/                           ← Level 2 Project
            ├── .git/config               ← local overrides (bootstrap-project)
            ├── src/                      ← unaffected by includeIf
            └── tests/                    ← unaffected by includeIf
```

---

## Normalization Function Reference

Both implementations MUST produce identical output for identical input:

| Input | Normalized Output | File |
|---|---|---|
| `home-baseline-tmp` | `home-baseline-tmp` | `home-baseline-tmp.inc` |
| `My Projects` | `my-projects` | `my-projects.inc` |
| `WebStorm_2025` | `webstorm-2025` | `webstorm-2025.inc` |
| `  Foo  Bar  ` | `foo--bar` → `foo-bar` | `foo-bar.inc` |
| `123 Numbers!` | `123-numbers` | `123-numbers.inc` |
