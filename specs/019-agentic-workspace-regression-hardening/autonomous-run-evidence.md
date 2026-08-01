# Autonomous Run Evidence: Feature 019

## Run identity

- Run ID: `392d1393-b069-4ec4-8c57-3c555695e354`
- Branch: `019-agentic-workspace-regression-hardening`
- Delivery mode: `MergeAndSync`
- Binding intake hash: `b78cc1951eb34a9a52e3e6479a4b9f264c38d4eed393155f78ccb7031fadde2b`
- Intake review: `1600a6c8-a818-4f02-8eda-1600b98b0f36`, `Ready`
- Starting commit: `2b1e51fb1a80f1d43a7be8b2d1ed52926df3bed8`

## Preflight

| Check | Result | Evidence |
|---|---|---|
| Repository and branch | Pass | Clean synchronized `main` before creating the exact Feature-019 branch |
| Existing autonomous runs | Pass | Features 009 and 011-018 are `Retrospective`, `Completed`, `nextExactAction: N/A` |
| Spec Kit | Pass | `specify check` completed successfully |
| Preset matrix | Pass | Eleven installed presets; Autonomous Run Governance v0.3.3 at priority 70 |
| Series status | Pass | Active, 38 targets, 3 roots, 45 dependencies; R-TUI is the only eligible target |
| D4 sequencing | Pass | Binding `R-TUI -> D4` edge exists; D4 remains blocked |
| Intake review | Pass | Current target hash and review result are valid in Bash and PowerShell |
| Run-state validators | Pass | Bash and PowerShell accept schema 1.1 at stage Clarify |

## Implementation evidence

Entries are added only after the corresponding acceptance condition is met.

| Evidence ID | Scope | Command or review | Result | Proof boundary |
|---|---|---|---|---|
| EV-RED-001 | Bash event emission | Focused `unittest` cases in `test_maintenance_tui_wrappers.py` | Expected failure | Existing Bash helper appends an extra brace; no valid event is persisted |
| EV-RED-002 | Deterministic report fallback | Filtered Release `dotnet test` for `DeterministicFinalReportIsLoadedWithoutCompletionEvent` | Expected failure | Existing runner returns `null` although the finalized run-owned report exists |
| EV-RED-003 | Bash 3.2 delegation | Focused `/bin/bash` Home Runtime delegation fixture | Expected failure | Zero-argument call fails at `ORIGINAL_ARGS[@]`; one and many arguments reach exactly one fake engine |
| EV-GREEN-001 | Wrapper, events and delegation | `python3 -m unittest scripts.tests.test_maintenance_tui_wrappers` | Pass, 18/18 | Real Bash helper plus Python writer, Bash-3.2 delegation and paired wrapper contract |
| EV-GREEN-002 | TUI report and result contract | Release `dotnet test` for the complete TUI test project | Pass, 68/68 | Deterministic report fallback, negative ownership/finalization fixtures, mismatch and cancellation |
| EV-GREEN-003 | Documentation and A11Y review | Semantic review of README, manpage, architecture, security and accessibility surfaces | Pass | Public CLI unchanged; report/delegation claims synchronized; text-first behavior unchanged |
| EV-GREEN-004 | Full maintenance regression | `python3 -m unittest discover -s scripts/tests -p 'test_*.py'` | Pass, 89; skipped 12 | Complete local Python maintenance suite; skips are native-platform fixtures |
| EV-GREEN-005 | PowerShell static analysis | `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1` | Pass, 147 files | No Error or Warning finding |
| EV-GREEN-006 | Secret boundary | `bash scripts/scan-agent-secrets.sh --fail-on-high .` | Pass | Gitleaks found no secret in the current Git diff |
| EV-GREEN-007 | Formatting and diff | `dotnet format ... --verify-no-changes --no-restore`; `git diff --check` | Pass | Changed C#, Markdown, Bash and tests are format/whitespace clean |
| EV-GREEN-008 | Dependency vulnerability | `dotnet list ... package --vulnerable --include-transitive` | Pass | No vulnerable package; no project, lock or dependency file changed |
| EV-GREEN-009 | Spec Kit | `specify check` | Pass | Installed integration is ready |
| EV-GREEN-010 | Project statistics | `render-project-statistics.sh` plus `--check-only` | Updated and Current | Profile 2 is bound to implementation checkpoint `2c481460914e` |
| EV-GREEN-011 | Repository homogeneity | `check-homogeneity.sh --dry-run --no-patch .` | Pass, 30/30 | Feature repository is locally homogeneous; no agent-parity drift |
| EV-BOUNDARY-001 | Fleet homogeneity | `bash scripts/check-homogeneity.sh` | Existing fleet findings | Full 36-checkout inventory completed; Feature-019 local statistics/hook drift is handled here, unrelated repository findings remain outside this feature |
| EV-NA-001 | DocFX and web A11Y | Trigger review | Not triggered | No XML/API, generated navigation or web-guide structure changed |

## Governance applicability

| Area | Applicability | Rationale | Re-evaluation trigger |
|---|---|---|---|
| Security / NIST SSDF / CWE / SAMM | Applicable | Event, path, process and run-correlation integrity are changed and verified | Scope complete |
| Architecture / STRIDE / CIA / CAPEC | Applicable | Existing trust boundaries are repaired without redesign | Scope complete |
| S-ADR / arc42 | NoUpdateRequired / Updated | No new ADR; existing arc42 cross-cutting boundary is clarified | Re-evaluate on architectural redesign |
| A11Y / WCAG 2.2 AA | Applicable | Degradation and results are learner-facing terminal text | Scope complete |
| Cross-platform | Applicable | Bash 3.2, current Bash and PowerShell behavior are acceptance surfaces | Scope complete |
| Agent parity | NoUpdateRequired | Existing guidance already requires preview, cross-platform, secure code, A11Y and documentation impact | Re-evaluate if a durable shared rule changes |
| ASVS | N/A | No web application, authentication or session surface | Re-evaluate if a web/API surface enters scope |
| SBOM / VEX / SLSA / OpenSSF | N/A | Locked package graph and distributed artifacts are unchanged | Re-evaluate on package, dependency or release change |
| AI-SBOM | N/A | No AI model or AI runtime is delivered | Re-evaluate if an AI runtime enters scope |
| NIS2 / CRA / EU AI Act / DORA | N/A | No regulated service or market-delivered product boundary changes | Re-evaluate on regulated or public delivery |
| Zero Trust / BSI C3A / BSI C5 | N/A | No identity, cloud or managed-provider boundary changes | Re-evaluate on cloud/provider scope |

## Documentation Impact

Status: `UpdateRequired`. The canonical public sources and security evidence
were synchronized; script catalog, A11Y guide, shared agent guidance and
DocFX/web output are `NoUpdateRequired`. Structured evidence is in
`documentation-impact-evidence.json`.

## Delivery evidence

- Feature PR: `hindermath/home-baseline#192`
- Published head: pending final delivery-evidence commit
- Pre-push secret gate: Pass

Exact-head provider evidence, review convergence, merge and synchronization are
recorded only after they exist. D4 is not started by this run.
