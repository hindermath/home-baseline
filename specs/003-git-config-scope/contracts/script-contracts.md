# Script Interface Contracts: Git Configuration Scope Isolation

**Feature**: `003-git-config-scope` | **Date**: 2026-04-09

> CLI contracts for all scripts modified by this feature. Each contract documents
> the expected interface, new behaviour additions, and exit codes.
> PowerShell equivalents mirror all behaviour with platform-appropriate syntax.

---

## bootstrap-workspace.sh / .ps1

### New behaviour added by this feature

**Trigger**: After workspace git repository is initialised.

**Step added**: Git Scope Isolation Setup

```text
PRE-CONDITION : Workspace git repo exists at ~/WorkspaceName/
NEW STEP      : If ~/.gitconfig.d/ exists:
                  1. Normalize WorkspaceName → normalized_name (lowercase, hyphens)
                  2. Check if [includeIf "gitdir:~/WorkspaceName/"] already in ~/.gitconfig
                  3. If NOT present: append block to ~/.gitconfig
                  4. Create ~/.gitconfig.d/<normalized_name>.inc (empty placeholder)
                     if it does not exist
                  5. Apply workspace-specific git settings via git config --local
                     in the workspace repo (core.autocrlf per platform)
                If ~/.gitconfig.d/ does NOT exist: skip silently (no error)
POST-CONDITION: ~/.gitconfig has idempotent includeIf entry; local .git/config has
                platform-specific settings; bilingual success message printed
```

**Output (success)**:
```text
→ Git Scope-Isolierung / Git Scope Isolation:
  ✓ includeIf für WorkspaceName / includeIf for WorkspaceName eingetragen
  ✓ ~/.gitconfig.d/workspacename.inc erstellt / created
```

**Output (skipped — directory missing)**:
```text
→ Git Scope-Isolierung / Git Scope Isolation:
  → ~/.gitconfig.d/ nicht vorhanden — Scope-Isolierung übersprungen / not found — skipping scope isolation
```

**Exit codes**: Inherited from parent script (0 = success, 1 = error)

---

## sync-home.sh / .ps1

### New behaviour added by this feature

**New section**: `~/.gitconfig.d/` bootstrapping

```text
PRE-CONDITION : sync-home copies ~/.gitconfig from repo
NEW STEP      : Check if ~/.gitconfig.d/ exists at destination (~/)
                  If NOT exists:
                    Create ~/.gitconfig.d/
                    Write home-baseline.inc placeholder file
                    Print bilingual info message
                  If EXISTS:
                    No action (preserve-only)
                    Print bilingual skip message
POST-CONDITION: ~/.gitconfig.d/ exists; pre-existing content untouched
```

**Output (created)**:
```text
  ✓ ~/.gitconfig.d/ erstellt mit home-baseline.inc / created with home-baseline.inc
```

**Output (skipped)**:
```text
  → ~/.gitconfig.d/ bereits vorhanden — Inhalt wird nicht überschrieben / already exists — content preserved
```

**Exit codes**: 0 = success, 1 = error (inherited)

---

## check-homogeneity.sh / .ps1

### New check added by this feature

**Check ID**: `GIT-SCOPE-001` and `GIT-SCOPE-002`

**Severity**: WARN (non-fatal — compliance score NOT reduced)

```text
GIT-SCOPE-001:
  Check  : ~/.gitconfig.d/ exists
  PASS   : Directory present
  WARN   : Directory absent → "~/.gitconfig.d/ fehlt — Scope-Isolierung nicht konfiguriert / missing — scope isolation not configured"

GIT-SCOPE-002 (runs only if GIT-SCOPE-001 passes):
  Check  : ~/.gitconfig contains [includeIf "gitdir:~/home-baseline-tmp/"]
  PASS   : Entry present
  WARN   : Entry absent → "includeIf für home-baseline-tmp nicht gefunden / not found for home-baseline-tmp"
```

**JSON output** (when `--json` flag):
```json
{
  "check": "GIT-SCOPE-001",
  "status": "WARN",
  "message": "~/.gitconfig.d/ fehlt — Scope-Isolierung nicht konfiguriert / missing — scope isolation not configured"
}
```

**Exit code impact**: WARN does NOT change exit code from 0 to 1 (unlike FAIL checks).

---

## scripts/hooks/pre-push

### New scan block added by this feature

**Trigger**: Any git push from any workspace with this hook installed.

**New scan target**: `~/.gitconfig.d/` (in addition to existing tracked-file scan)

```text
EXISTING SCAN : git ls-files → tracked files → content + name regex scan
NEW SCAN BLOCK: If ~/.gitconfig.d/ exists:
                  Scan all *.inc files with existing secret_content_regex
                  If matches found: set found_high=1, print filenames to stderr
POST-CONDITION: Push blocked (exit 2) if any HIGH findings in either scan
```

**New output (on finding)**:
```text
  HIGH: Secret-Muster in ~/.gitconfig.d/ gefunden:
       /Users/user/.gitconfig.d/my-projects.inc
```

**No change to exit codes**: exit 0 (clean), exit 2 (secrets found) — same as before.

**Security note**: This change MUST reference Constitution Principle I in the PR. Scanner output confirming no regressions MUST be included.

---

## `.gitconfig` Template (tracked file)

### Changes to the tracked `~/.gitconfig`

The tracked `.gitconfig` in the repository root is updated to:
1. Remove any workspace-specific settings from global scope
2. Add the canonical `[includeIf]` block for `home-baseline-tmp`

**Before** (conceptual):
```ini
[user]
  name  = Thorsten Hindermann
  email = thorsten@example.com
[init]
  defaultBranch = main
[core]
  autocrlf = input
[pull]
  rebase = true
```

**After** (with scope isolation):
```ini
[user]
  name  = Thorsten Hindermann
  email = thorsten@example.com
[init]
  defaultBranch = main
[core]
  autocrlf = input
[pull]
  rebase = true

[includeIf "gitdir:~/home-baseline-tmp/"]
  path = ~/.gitconfig.d/home-baseline.inc
```

---

## Teardown Contract (OUT OF SCOPE — documented for reference)

`teardown-workspace.sh / .ps1` will need to implement:

```text
WHEN teardown-workspace runs for WorkspaceName:
  1. Remove [includeIf "gitdir:~/WorkspaceName/"] block from ~/.gitconfig (all occurrences)
  2. Remove ~/.gitconfig.d/<normalized-name>.inc if it exists
  3. Print bilingual confirmation
```

This contract is informational only — implementation is in feature `teardown-workspace`.
