# Implementation Plan: Wartungs-TUI- und Wrapper-Regressionshaertung

**Branch**: `019-agentic-workspace-regression-hardening` | **Date**: 2026-08-01  
**Spec**: [spec.md](spec.md)  
**Input**: `Lastenheft_Agentic-Workspace-Wartungs-TUI-und-Wrapper-Regressionshaertung.md`  
**Delivery Mode**: `MergeAndSync`

## Summary

Feature 019 repairs three regressions at the existing wrapper, event and TUI
boundaries. Bash must emit valid gap-free event records, the macOS Home Runtime
must delegate an argumentless invocation under Bash 3.2, and the TUI must find
the deterministic run report even when the advisory completion event is absent.

The work is test-first and deliberately narrow. Existing CLI options, event
schema 1, report schema, maintenance phases, safety barriers, dependencies and
target-repository authority remain unchanged.

## Technical Context

**Languages**: C# 14/.NET 10, Bash 3.2+, PowerShell 7, Python 3  
**Dependencies**: Existing locked Feature-018 package graph; no additions or updates  
**Storage**: Existing user-private JSONL event stream and atomic JSON run report  
**Testing**: MSTest, Python `unittest`, Bash syntax, PSScriptAnalyzer and existing CI workflows  
**Platforms**: macOS, Ubuntu and Windows; `/bin/bash` on macOS is the Bash-3.2 proof surface  
**Constraints**: No schema, CLI, package, target-repository or maintenance-phase expansion  
**Scope**: Three causal defects plus documentation, evidence and regression gates

## Constitution Check

*Gate before research: PASS. Gate after design: PASS.*

| Governance area | Decision | Planned evidence |
|---|---|---|
| Secure code generation | Applicable | Quoted argument forwarding, strict JSON objects, run-ID/path validation and negative fixtures |
| Secure architecture | Applicable | Wrapper, event, report and process boundaries remain separate and fail closed |
| NIST SSDF / CWE Top 25 | Applicable | Regression tests, security checklist and review evidence |
| STRIDE / CIA / CAPEC | Applicable | Integrity and spoofing checks for event/report/run-ID boundaries |
| S-ADR / arc42 | NoUpdateRequired | No architecture decision changes; the Feature-018 boundary remains authoritative |
| ASVS / cloud / Zero Trust / BSI C3A / BSI C5 | N/A | No web, identity, cloud, provider or deployment boundary changes |
| SBOM / VEX / SLSA / OpenSSF / AI-SBOM | N/A | No dependency, package, model or release-artifact change; re-evaluate on scope drift |
| NIS2 / CRA / EU AI Act / DORA | N/A | Internal local maintenance helper; no regulated or market-delivered product change |
| A11Y / WCAG 2.2 AA | Applicable | Text-first degradation and result messages remain understandable without color or layout |
| Cross-platform | Applicable | Bash 3.2, current Bash and PowerShell behavior plus three operating-system gates |
| Agent parity | NoUpdateRequired | No durable shared agent rule is introduced |
| Documentation impact | UpdateRequired | TUI architecture/testing and user-facing maintenance documentation are checked and synchronized |
| Statistics | GeneratedUpdate | Canonical statistics renderer updates the ledger after implementation |
| Sequencing | Applicable | R-TUI remains the only eligible intake; D4 stays blocked until causal closeout |

## Causal Findings and Decisions

### R01 - Bash details default expression

The Bash event helper's inline default expression can append a stray closing
brace when a details argument is supplied. The writer rejects the resulting
JSON, while the sequence counter has already advanced. The repair separates
argument selection from JSON validation and advances the sequence only for an
event that was successfully persisted.

### R02 - Empty Bash array expansion

The Home Runtime delegates through an array created from `"$@"`. Expanding the
empty array under macOS system Bash 3.2 with nounset can fail. The repair uses
an explicit zero-argument branch and preserves quoted array forwarding for one
or more arguments. It still uses one `exec` and one canonical engine process.

### R03 - Report discovery without completion event

The report has an existing deterministic path derived from Home directory and
run ID, but the TUI currently learns it only from `run-completed`. The process
invocation contract will carry the expected report path explicitly. The runner
prefers a valid completion-event path when present and otherwise validates the
expected path. It never scans directories or guesses a foreign report.

### R04 - Existing contracts remain authoritative

The event reader may degrade presentation without changing the engine. The
atomic report and process exit code remain canonical, and an optional matching
completion event is corroborating evidence. `RESULT_MISMATCH` remains reserved
for actual contradictions, not missing advisory data.

## Architecture Boundaries

1. **Bash wrapper** owns safe delegation and event emission, not UI result
   interpretation.
2. **Python event writer** remains the schema validator and atomic append
   boundary.
3. **Process invocation** carries executable arguments, run ID, event path and
   deterministic report path as typed values.
4. **Process runner** reads complete events, validates the owned report path and
   returns raw evidence.
5. **Result reconciler** compares process, report and optional completion event
   without inventing success.
6. **Presentation** renders status, reason and next action from the reconciled
   model; event degradation stays separately visible.

## Implementation Phases

### Phase 1 - Evidence and Failing Proofs

- Create autonomous evidence and gate requirements before product edits.
- Add focused failing tests for valid/gap-free Bash events, report fallback and
  zero/one/many-argument Home Runtime delegation.
- Prove each failure against the unmodified implementation and record the
  causal boundary rather than broad snapshots.

### Phase 2 - Event Emission Repair

- Correct Bash details selection without weakening Python JSON validation.
- Couple sequence advancement to successful event persistence.
- Preserve warning-only presentation degradation when an event truly cannot
  be written.

### Phase 3 - Report Reconciliation Repair

- Extend the internal typed invocation with the expected report path.
- Validate run ownership and finalization before accepting that report.
- Preserve completion-event path verification and all genuine mismatch cases.

### Phase 4 - Bash 3.2 Delegation Repair

- Handle zero arguments explicitly and retain quoted array forwarding
  otherwise.
- Prove no re-evaluation of whitespace, empty strings, wildcards or shell
  metacharacters.
- Keep exactly one `exec` transition to the Level-0 source.

### Phase 5 - Regression, Documentation and Governance

- Run targeted .NET and Python/Bash tests, then full wrapper and Feature-015-018
  regression suites.
- Review README, manpage, script reference, TUI architecture, accessibility and
  security documents; update only affected claims.
- Record Documentation Impact, governance applicability and generated project
  statistics.

### Phase 6 - Exact-Head Delivery

- Run local gates and push the exact candidate.
- Require macOS, Ubuntu and Windows evidence plus all mandatory checks.
- Resolve actionable review threads. Use the authorized narrow bypass only if
  Human Approval is the sole remaining rule after all technical gates pass.
- Merge, synchronize local `main`, then perform the separate causal Series/D4
  closeout. Do not start D4 in this feature run.

## Project Structure

```text
specs/019-agentic-workspace-regression-hardening/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── tasks.md
├── autonomous-run-state.json
├── autonomous-run-evidence.md
├── autonomous-run-gate-requirements.json
├── contracts/
└── checklists/

scripts/
├── maintain-agentic-workspace.sh
├── tests/test_maintenance_tui_wrappers.py
└── lib/maintenance-tui/
    ├── src/HomeBaseline.MaintenanceTui/Infrastructure/
    └── tests/HomeBaseline.MaintenanceTui.Tests/
```

## Validation Matrix

| Scope | Required proof |
|---|---|
| Bash event emission | Real wrapper/helper path emits valid JSON, contiguous sequence and one completion |
| Report fallback | Valid report plus exit 0 and missing completion event is success with separately visible degradation |
| Mismatch safety | Foreign, unfinished, missing or contradictory reports remain fail-closed |
| Home delegation | `/bin/bash` zero, one and many arguments preserve exact boundaries and one engine process |
| Cross-platform | Existing PowerShell behavior and macOS/Ubuntu/Windows workflows remain green |
| Compatibility | Feature 015-018 maintenance and TUI regression suites pass |
| Documentation | German-first/English-second CEFR-B2, WCAG 2.2 AA, manpage/reference parity |
| Delivery | Exact-head gate evidence, secret scan, homogeneity and zero actionable review threads |

## Complexity Tracking

No constitution deviation or new abstraction beyond extending the existing
typed process-invocation record is required. A directory scan, schema version,
new package, retry engine or parallel result source would add unjustified
complexity and is explicitly rejected.

