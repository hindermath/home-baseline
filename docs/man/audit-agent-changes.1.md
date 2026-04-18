# audit-agent-changes(1)

## NAME

`audit-agent-changes` - snapshot local agent-managed files and correlate later changes with recent agent logs

## SYNOPSIS

```text
bash scripts/audit-agent-changes.sh snapshot [--home DIR] [--state-dir DIR]
bash scripts/audit-agent-changes.sh report [--home DIR] [--state-dir DIR] [--window-hours N] [--json] [--refresh-baseline]

pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action snapshot [-HomeDir DIR] [-StateDir DIR]
pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action report [-HomeDir DIR] [-StateDir DIR] [-WindowHours N] [-Json] [-RefreshBaseline]
```

## DESCRIPTION

The command provides a lightweight local audit layer for agent-related file changes.

It is meant for cases where files below `~/.agents/`, `.claude/commands/`,
`.gemini/commands/`, `.github/agents/`, `.github/prompts/`, or selected local
agent config files change and you want future changes to be easier to attribute.

The workflow has two steps:

1. `snapshot` records the current baseline into a local audit state directory.
2. `report` compares the current state with that baseline, stores a JSON report,
   and searches recent Codex, Claude, Copilot, and Continue logs for path-based
   hints.

This is **heuristic correlation**, not a cryptographic proof of authorship.
If no app log references the changed paths or terms, the report will say so.

## DEFAULT STATE LOCATION

The default local state directory is:

```text
~/.home-baseline/agent-audit/
```

It contains:

- `baseline.json`
- `snapshots/snapshot-YYYYMMDD-HHMMSS.json`
- `reports/report-YYYYMMDD-HHMMSS.json`
- `reports/latest-report.json`

These files are local machine state and are not intended to be committed.

## OPTIONS

### Bash

- `snapshot`: create or replace the active baseline
- `report`: compare current state with the baseline
- `--home DIR`: inspect a different home directory
- `--state-dir DIR`: use a different audit state directory
- `--window-hours N`: correlation window around changed file timestamps
- `--json`: print the full report JSON
- `--refresh-baseline`: after report creation, accept the current state as the new baseline

### PowerShell

- `-Action snapshot|report`: choose baseline creation or comparison
- `-HomeDir`: inspect a different home directory
- `-StateDir`: use a different audit state directory
- `-WindowHours`: correlation window in hours
- `-Json`: print the full report JSON
- `-RefreshBaseline`: accept the current state as the new baseline after the report

## EXAMPLES

```bash
# Initial baseline for the current machine
bash ~/home-baseline-tmp/scripts/audit-agent-changes.sh snapshot
```

```bash
# Compare current state and keep the old baseline
bash ~/home-baseline-tmp/scripts/audit-agent-changes.sh report
```

```bash
# Compare current state and accept the current files as the new baseline
bash ~/home-baseline-tmp/scripts/audit-agent-changes.sh report --refresh-baseline
```

```powershell
pwsh -NoProfile ~/home-baseline-tmp/scripts/audit-agent-changes.ps1 -Action snapshot
pwsh -NoProfile ~/home-baseline-tmp/scripts/audit-agent-changes.ps1 -Action report -RefreshBaseline
```

## FILES

- `scripts/audit-agent-changes.sh`
- `scripts/audit-agent-changes.ps1`
- `docs/man/audit-agent-changes.1.md`
