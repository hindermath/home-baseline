# Implementation Plan: Agentic-Workspace-Wartungs-TUI

**Branch**: `018-agentic-workspace-tui` | **Date**: 2026-07-29 |
**Spec**: [spec.md](spec.md)
**Input**: `Lastenheft_Agentic-Workspace-Maintenance-TUI.md`
**Delivery Mode**: `MergeAndSync`

## Summary

Feature 018 adds a safe interactive terminal interface in front of
`maintain-agentic-workspace.*` while preserving Bash and PowerShell as the
only maintenance engines. The normal interface is a .NET 10 console
application using Spectre.Console. A line-oriented fallback remains available
when terminal capabilities, SDK, restore, build or cache do not support the
enhanced interface.

The implementation is test-first and contract-led. It introduces an additive
JSONL event stream, reconciles that stream with the atomic final report and
process exit code, uses a content-addressed user cache, and proves that all
Feature 015-017 safety and target-repository authority boundaries remain
unchanged.

## Technical Context

**Language/Version**: C# 14 on .NET 10 for the TUI; existing Bash 3.2+,
PowerShell 7 and Python 3 for wrapper and engine integration
**Primary Dependencies**: Spectre.Console `0.57.2`,
Spectre.Console.Testing `0.57.2`, Microsoft.NET.Test.Sdk `18.8.1`,
MSTest.TestFramework/TestAdapter `4.3.3`
**Storage**: User-private JSONL events, existing atomic JSON reports/logs and
content-addressed local UI builds; no database
**Testing**: MSTest console/unit/integration tests, existing Python unittest
fixtures, Bash syntax/fixtures, PSScriptAnalyzer and platform workflows
**Target Platform**: macOS arm64/x64, Linux arm64/x64 and Windows arm64/x64;
exact CI proof on macOS, Ubuntu and Windows
**Project Type**: Internal terminal application plus paired wrapper extensions
**Performance Goals**: Dashboard refresh at most 10 times/second; no invented
percentage; bounded process and cache startup; no duplicate engine run
**Constraints**: Offline-safe fallback, no generated binaries in Git, locked
restore, no engine logic in C#, no target-repository publication authority
**Scale/Scope**: One interactive run, eight stable maintenance phases, current
44-target fleet evidence, dynamic preset count, bounded event stream

## Constitution Check

*Gate status before research: PASS. Re-checked after design: PASS.*

| Principle or preset | Decision | Planned evidence |
|---|---|---|
| Level-0 environment | Applicable | Repository scripts are the product; existing script/manual-test conventions remain binding |
| Memory-safe language | Pass | C#/.NET is on the MSL allow-list; Bash/PowerShell/Python changes are limited integration work |
| Secure code generation | Applicable | Typed `ProcessStartInfo.ArgumentList`, strict JSON, markup escaping, quoted shell arguments, no dynamic evaluation |
| Secure architecture | Applicable | Explicit wrapper/TUI/engine/event/report/cache trust boundaries; fail-safe defaults and least privilege |
| NIST SSDF / CWE Top 25 | Applicable | Security checklist, negative fixtures and review evidence |
| STRIDE / CIA / CAPEC | Applicable | Update scoped threat model and security quality scenarios |
| S-ADR / arc42 | Applicable | Add one TUI boundary ADR and update arc42 cross-cutting concepts |
| Dependency audit / SBOM / VEX | Applicable | Locked package graph, transitive/vulnerability commands, CycloneDX-compatible package inventory and VEX disposition |
| ASVS | N/A | No web application or authentication surface; re-evaluate if a web/API surface enters scope |
| AI-SBOM | N/A | AI is development tooling only, absent from the delivered runtime |
| SLSA / OpenSSF Scorecard | N/A | No public binary or package release; re-evaluate for distributable release artifacts |
| NIS2 / CRA / EU AI Act / DORA | N/A | Internal local helper, no regulated service or market release |
| Zero Trust / BSI C3A / BSI C5 | N/A | No identity, cloud, managed-service or provider deployment boundary |
| OWASP SAMM | Applicable | Feature evidence and review gates document the verification practice |
| A11Y / WCAG 2.2 AA | Applicable | Keyboard, NO_COLOR, TERM=dumb, narrow/linear output and screenreader-oriented snapshots |
| Bilingual learner delivery | Applicable | User-facing text is German first, English second, CEFR B2, terms explained at first use |
| Cross-platform parity | Applicable | Paired selector/event parameters, Bash/Pwsh help, manpage and three-OS matrix |
| Agent parity | NoUpdateRequired by default | No durable agent rule changes; re-evaluate only if implementation discovers one |
| Intake Authoring/Review/Sequencing | Evidence-only | Accepted hashes remain bound to run state; no preset implementation changes |
| Parallel Autonomous | N/A | One serialized feature run |
| Statistics | UpdateRequired | Update config/ledger through the canonical renderer after implementation |
| Documentation Impact | UpdateRequired | Sources: wrappers, project README/architecture, main README and manpage; owner: Level-0 maintainers |

No credentials, private agent state, logs, caches, generated binaries or
machine-local reports are planned for tracking.

## Architecture and Runtime Decisions

### Building Blocks

1. **Wrapper routing** in `maintain-agentic-workspace.sh/.ps1` detects explicit
   UI selectors, TTY/capability state and existing maintenance arguments.
2. **Bootstrap/cache adapter** resolves the normalized platform, computes the
   source fingerprint, finds or atomically publishes a framework-dependent
   build, and selects enhanced or plain presentation.
3. **TUI application** owns prompts, summaries, event presentation, process
   startup and result reconciliation. It owns no maintenance operation.
4. **Plain assistant** implements the same selection and confirmation contract
   with line-oriented ASCII prompts and emits the same typed argument vector.
5. **Maintenance engines** remain the Bash/PowerShell wrappers and existing
   Python fleet core.
6. **Event adapter** appends schema-1 records and never replaces the existing
   atomic report or log.

### Runtime Sequence

1. Parse UI selectors before normal engine initialization.
2. Preserve existing headless routing for non-interactive or parameterized
   calls.
3. Resolve enhanced TUI or plain fallback before any engine process starts.
4. Collect and validate exactly one selection.
5. Display equivalent command; require default-No confirmation for mutation.
6. Start the platform wrapper once in internal headless mode with an
   event-stream path.
7. Read complete JSONL records, degrade presentation on event errors, and keep
   linear logs available.
8. Reconcile final event, atomic report and process exit; propagate the
   canonical exit code.

### Trust Boundaries

- Untrusted terminal strings and repository paths cross a markup boundary and
  are escaped before rendering.
- TUI selection crosses into a process argument boundary as an argument list,
  never executable shell text.
- Events are untrusted advisory live data; the atomic report and process result
  are independently validated.
- Cache data is trusted only after exact fingerprint/platform match and
  complete atomic publication.
- User confirmation authorizes only one local engine invocation, not target
  publication, cleanup, provider access or elevation.

## Implementation Phases

### Phase 1 - Contract and Vertical Slice

- Add contracts and JSON schema before production code.
- Add the .NET project, locked restore and a failing test for the default
  Dry-run selection, typed process arguments and one successful fake-engine
  result.
- Implement the minimum vertical slice from interactive selection through
  event reading and terminal result.
- Record package license/source/vulnerability evidence before broad UI work.

### Phase 2 - Selection, Accessibility and Presentation

- Implement mode combinations, default-No mutation confirmation and
  explanatory command rendering.
- Add markup escaping, keyboard-only flow, NO_COLOR, narrow/linear layouts and
  stable status text.
- Add console snapshots for all statuses and fallback modes.

### Phase 3 - Event and Result Contract

- Add `--event-stream` / `-EventStream` as internal additive parameters.
- Emit stable run/phase/finding/completion events from existing engine phases.
- Parse complete records, detect sequence/schema failures, degrade to logs and
  reconcile final report/process result.
- Cover `SUCCESS_WITH_WARNINGS`, `PARTIAL/1`, `BLOCKED`, `2`, `3`, `130`,
  `DEFERRED_ADMIN_REQUIRED` and `RESULT_MISMATCH`.

### Phase 4 - Bootstrap, Cache and Plain Fallback

- Compute source fingerprint from tracked TUI source, project/lock files and
  wrapper UI version.
- Normalize OS/architecture and use atomic temporary-to-final cache publish.
- Implement SDK/restore/build/cache failure fallback before engine start.
- Keep a line-oriented assistant with equivalent combination and confirmation
  decisions.

### Phase 5 - Wrapper and Predecessor Regression

- Add paired Bash/PowerShell selectors and help.
- Preserve no-argument headless behavior outside full TTY and every existing
  option path.
- Extend Python fixtures for routing, fallback, event parameters and no remote
  target actions.
- Run all Feature 015-017 regression suites unchanged.

### Phase 6 - Documentation, Security and Delivery Evidence

- Update README, `docs/man/maintain-agentic-workspace.1.md`,
  `docs/scripts/reference.md` and a focused architecture/testing guide.
- Update threat model, S-ADR, arc42, dependency audit, supply-chain/VEX,
  security checklist, quality scenarios and A11Y evidence.
- Record `NoUpdateRequired` for shared agent guidance unless a durable rule
  actually changed.
- Render project statistics and complete autonomous evidence.

### Phase 7 - Exact Candidate and MergeAndSync

- Run local targeted and full validation.
- Push and run macOS, Ubuntu and Windows workflows against the exact PR head.
- Map command and platform tokens into temporary provider-neutral gate
  evidence and validate it in Bash and PowerShell.
- Resolve actionable threads; use the authorized narrow bypass only when
  Human Approval is the sole remaining gate.
- Merge, delete the feature branch, synchronize local `main`, archive the
  intake and update the series only through a causal closeout if post-merge
  facts require it.

## Project Structure

### Feature Documentation

```text
specs/018-agentic-workspace-tui/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── autonomous-run-state.json
├── autonomous-run-evidence.md
├── autonomous-run-gate-requirements.json
├── contracts/
│   ├── cli-selection.md
│   ├── maintenance-event-v1.schema.json
│   ├── run-result.md
│   └── cache-fallback.md
├── checklists/
└── tasks.md
```

### Product and Test Code

```text
scripts/
├── maintain-agentic-workspace.sh
├── maintain-agentic-workspace.ps1
├── lib/
│   ├── agentic_workspace_fleet.py
│   └── maintenance-tui/
│       ├── NuGet.config
│       ├── src/HomeBaseline.MaintenanceTui/
│       │   ├── HomeBaseline.MaintenanceTui.csproj
│       │   ├── Program.cs
│       │   ├── Application/
│       │   ├── Contracts/
│       │   ├── Infrastructure/
│       │   └── Presentation/
│       └── tests/HomeBaseline.MaintenanceTui.Tests/
│           ├── HomeBaseline.MaintenanceTui.Tests.csproj
│           ├── Console/
│           ├── Contracts/
│           └── Integration/
└── tests/
    ├── test_maintenance_tui_wrappers.py
    ├── test_agentic_workspace_maintenance.py
    ├── test_linux_maintenance_hardening.py
    ├── test_windows_maintenance_hardening.py
    └── test_maintenance_contracts.py

docs/
├── architecture/maintenance-tui.md
├── accessibility/maintenance-tui.md
├── man/maintain-agentic-workspace.1.md
├── scripts/reference.md
└── security/...

.github/workflows/maintenance-tui.yml
```

**Structure Decision**: The helper remains below `scripts/lib` because it is an
internal presentation adapter for the repository's script product. A separate
solution root or distributable application would imply unsupported release
scope.

## Test and Gate Matrix

| Gate | Local command | Remote proof |
|---|---|---|
| Locked restore | `dotnet restore ... --locked-mode` | macOS/Ubuntu/Windows |
| Build | `dotnet build ... --no-restore` | macOS/Ubuntu/Windows |
| TUI tests | `dotnet test ... --no-restore` | macOS/Ubuntu/Windows |
| Wrapper/engine regressions | `python3 -m unittest discover -s scripts/tests -p 'test_*.py'` | macOS/Ubuntu/Windows where supported |
| Bash syntax | `bash -n scripts/maintain-agentic-workspace.sh` | Ubuntu/macOS |
| PowerShell | `invoke-psscriptanalyzer.ps1` | Windows/macOS/Ubuntu |
| Dependency inventory | `dotnet list ... package --include-transitive` | Exact PR head |
| Vulnerabilities | `dotnet list ... package --vulnerable --include-transitive` | Exact PR head |
| Documentation/A11Y | Homogeneity plus focused text/snapshot checks | All three platforms |
| Candidate integrity | diff, staged inventory, secret scan | Exact reviewed head |

## Complexity Tracking

No constitution violation requires an exception. The additional .NET project
is the accepted cross-platform presentation boundary and does not replace the
script product or create a new public application.
