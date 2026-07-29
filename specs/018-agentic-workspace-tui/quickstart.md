# Quickstart: Validate the Agentic-Workspace-Wartungs-TUI

## Purpose

This guide proves the feature without running real fleet mutations. Use
temporary homes, fake engines and preview/check-only modes. It assumes no
prior Spec Kit knowledge.

## Prerequisites

- .NET SDK 10
- Python 3
- PowerShell 7
- Git and Bash
- Repository root as current directory

## 1. Restore the Locked Package Graph

```bash
dotnet restore \
  scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/HomeBaseline.MaintenanceTui.Tests.csproj \
  --locked-mode
```

Expected: exit `0`; neither project lock file changes.

## 2. Build and Test the TUI

```bash
dotnet build \
  scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/HomeBaseline.MaintenanceTui.Tests.csproj \
  --no-restore

dotnet test \
  scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/HomeBaseline.MaintenanceTui.Tests.csproj \
  --no-build --no-restore
```

Expected: default Dry-run, valid/invalid selections, event degradation, result
reconciliation, cache identity, fallback, cancellation and accessibility
snapshots all pass.

## 3. Run Wrapper and Engine Regressions

```bash
bash -n scripts/maintain-agentic-workspace.sh

python3 -m unittest discover \
  -s scripts/tests \
  -p 'test_*.py'

pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
```

Expected: existing Feature 015-017 tests and the new wrapper tests pass. No
target repository is committed, pushed, merged or broadly cleaned.

## 4. Exercise Safe UI Routes

Use a temporary Home directory. The commands must not modify the real Home
runtime.

```bash
temporary_home="$(mktemp -d)"

HOME="$temporary_home" \
  bash scripts/maintain-agentic-workspace.sh \
  --plain-ui \
  --home-dir "$temporary_home"
```

Select Dry-run or cancel. Expected: the displayed command is explanatory,
mutation confirmation defaults to `No`, and cancellation exits `130`.

To prove headless compatibility:

```bash
HOME="$temporary_home" \
  bash scripts/maintain-agentic-workspace.sh \
  --check-only \
  --scripts-only \
  --home-dir "$temporary_home"
```

Expected: no UI prompt; the existing check-only engine path runs.

## 5. Validate Event and Result Contracts

The .NET integration tests use a deterministic fake engine. Contract details:

- [maintenance-event-v1.schema.json](contracts/maintenance-event-v1.schema.json)
- [run-result.md](contracts/run-result.md)

Required cases include:

- clean success and success with warnings;
- `PARTIAL` with exit `1`;
- invalid JSON, sequence gap and unknown schema;
- missing or non-finalized report;
- disagreement between completion event, report and process exit;
- controlled `Ctrl+C`.

Expected: malformed event data produces `EVENT_STREAM_DEGRADED`; contradictory
completion produces `RESULT_MISMATCH`; neither causes an implicit engine retry.

## 6. Check Dependencies

```bash
dotnet list \
  scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/HomeBaseline.MaintenanceTui.csproj \
  package --include-transitive

dotnet list \
  scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/HomeBaseline.MaintenanceTui.csproj \
  package --vulnerable --include-transitive
```

Expected: Spectre.Console is exactly `0.57.2`; no known vulnerable package is
reported. The test project additionally pins Spectre.Console.Testing `0.57.2`,
Microsoft.NET.Test.Sdk `18.8.1` and MSTest `4.3.3`.

## 7. Documentation, Accessibility and Candidate Integrity

```bash
bash scripts/check-homogeneity.sh --dry-run .
bash scripts/scan-agent-secrets.sh --fail-on-high .
git diff --check
specify check
```

Review console snapshots for keyboard-only operation, `NO_COLOR`, `TERM=dumb`,
narrow/linear mode, ASCII status and German-first/English-second CEFR-B2 text.

## 8. Platform Evidence

The exact PR head must run the maintenance TUI workflow on:

- macOS;
- Ubuntu;
- Windows.

Missing platform execution is missing evidence, not a pass. Before merge,
provider-neutral gate evidence is generated temporarily and validated against
the reviewed head and gate-requirements hash.
