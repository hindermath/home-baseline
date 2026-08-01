# PR Evidence: Feature 022 Agentic Workspace Efficiency Guide

## Run Identity

| Field | Value |
|---|---|
| Run ID | `1436162a-18c5-4e46-9f54-3ceeb2bf1660` |
| Branch | `022-agentic-workspace-efficiency-guide` |
| Delivery | `MergeAndSync` |
| Baseline | `7c438bf332626c48eb87b9139f863dc2e8e861c7` |
| Binding intake hash | `0c0c75222f9305fddaba8dd7d3f693c906f363c12c8c7c426ea094ff605ff5c1` |
| Intake Review | `89bbb2fa-8b91-41b4-a1f6-887436d6ee37`, `Ready` |
| Active Series Review | `8ea4fe3c-73c2-43d1-89a7-4823d4dc048e`, `Ready`, `35/3/42` |

## Scope Contract

- Documentation and feature-local test evidence only.
- No maintenance, TUI, registry, preset, dependency, package, workflow or
  fleet behavior change.
- D7 remains outside implementation and is not started by Feature 022.
- Published evidence contains no machine-local logs, credentials or private
  absolute paths.

## Phase Evidence

| Phase | Result | Evidence |
|---|---|---|
| Preflight | Pass | Clean synchronized `main`, terminal Feature 021, valid D6 receipt/review and Series |
| Specify | Pass | 31 functional requirements, 10 measurable outcomes, no clarification marker |
| Clarify pass 1 | Converged | No material question affecting plan or validation |
| Clarify pass 2 | Converged | No new ambiguity after requirement-quality review |
| Checklists | Pass | Requirements 18/18, documentation contract 31/31 |
| Plan review | Pass | 13/13 after local/provider exact-head boundary remediation |
| Analyze pass 1 | Remediated | Invalid nonexistent local link-check command replaced by exact Lychee command |
| Analyze pass 2 | Pass | 41 FR/SC keys covered; 84 mapped tasks; zero Critical/High/Medium findings |

## Source Inventory

Source precedence: public wrapper/help and runtime contracts first, current
manpage and generated script reference second, merged feature evidence third.
The former monolithic README is historical migration evidence and never current
operating authority.

| Source | Normalized SHA-256 | Role and proof boundary |
|---|---|---|
| `scripts/maintain-agentic-workspace.sh` | `9310dfe38a14bb9cf4b198c8cd91dc20cafdc139160d197fb388b8e203671234` | macOS/Linux public options and headless/TUI routing |
| `scripts/maintain-agentic-workspace.ps1` | `46e08341089b8c75a564450467368c9d165f95a0ec2e6ccc79077d71f40e2be3` | Windows parameters, report and status implementation |
| `docs/man/maintain-agentic-workspace.1.md` | `a567cffb94eabed9674539f2fd4772170ba7a458dab8cca1bdb655e18cde4ebd` | canonical bilingual operating contract and exitcodes |
| `docs/scripts/reference.md` | `8f5c79b84a519ca517ce44ac49fff304fafe1a5f1ba8b47f16f0e6a3955ab81f` | generated script inventory; not manually edited |
| `scripts/config/home-sync-manifest.json` | `1b373763c15a6d2567e1621abf1394793fa7feda939e00d8b794efd3bfd643a1` | actual Home Runtime membership |
| `scripts/config/agentic-workspace-fleet.json` | `31c9dec982e6fb49dc44a5b1c3a98adb78f34b6e34eda221f5591a8c7e850cf9` | declared fleet, preset-repository and collection classes |
| `docs/architecture/source-and-home-runtime.md` | `b6b753c53dd9e0a9d8433fdc3faac671f3c0f00cbe87c0a8a0cfcfcd7a316a87` | German source/distribution ownership |
| `docs/architecture/source-and-home-runtime.en.md` | `ca2c9d7fef559d02cb7bb54d071f18122dd8241e0efbd888e21425754fc8fcbe` | English source/distribution ownership |
| `MaintenanceStatusView.cs` | `cfefe2c5cfcab139c8d691beafe5b7aa33b342ad380b73482a6441ea32f1a045` | `EVENT_STREAM_DEGRADED` and text-first final view |
| `InterruptController.cs` | `f4510e9135bcb071a1d0f1485e969ef19002c5b54e66a021ff73855ba5de1d33` | exactly-once interrupt request |
| `RunResultReconciler.cs` | `7ca5553250a9ffb7d3ad9fdae8f38037c9328ffe13a4b1409b3a20d6620a728e` | report, event and process-exit reconciliation |

PowerShell-only timeout parameters remain explicitly platform-specific. Shared
semantics are documented together; spelling is never forced into false textual
symmetry.

### Public Surface Inventory

| Class | Bound surface | Review result | Proof boundary |
|---|---|---|---|
| UI selection | `--tui`/`-Tui`, `--plain-ui`/`-PlainUi`, `--no-tui`/`-NoTui` | Pass | Mutually exclusive; fallback only before engine start |
| Inspection and preview | `--check-only`/`-CheckOnly`, `--dry-run`/`-WhatIf` | Pass | Check-only may fetch; neither mode mutates working files |
| Domain selection | `--scripts-only`/`-ScriptsOnly`, `--repair-drift`/`-RepairDrift`, `--include-optional`/`-IncludeOptional` | Pass | Repair is local only; options retain compatibility rules |
| Authority | `--allow-admin-prompts`/`-AllowAdminPrompts` | Pass | Current process only; no UAC, repository, test or review bypass |
| Test profiles | `--manifest`/`-ManifestPath`, `--home-dir`/`-HomeDir` | Pass | Alternative paths do not grant publication authority |
| Windows bounds | `-GitRetryAttempts`, `-GitTimeoutSeconds`, `-WinGetTimeoutSeconds` | Pass | Deliberate platform-specific controls, not false spelling parity |
| Exit contract | `0`, `1`, `2`, `3`, `130`, Linux `143` | Pass | Finalized report and process exit must agree |
| Worktree states | Clean, Dirty, Ahead, Behind, Diverged, Detached, Non-Default | Pass | Only clean canonical purely-behind repositories may pull |
| Runtime statuses | `EVENT_STREAM_DEGRADED`, `DEFERRED_ADMIN_REQUIRED`, `RESULT_MISMATCH` | Pass | Each status remains text-visible and fail-closed |

### Independent Reader-Path Reviews

| Reader path | Entry and independent question | Result |
|---|---|---|
| First safe run | Can a first-year learner choose platform, check, preview, interpret all exits and name the next action without Spec Kit knowledge? | Pass; glossary, commands, side effects and checklist are complete |
| Regular operation | Can a daily user classify every required Git state and reconcile Run ID, report, JSONL and exit? | Pass; all seven classes and both degraded states are text-visible |
| Maintainer and AI agent | Can a maintainer derive edit location, distribution, authority, serialization, handoff and remote stop boundary? | Pass; source classes, modes and reusable prompt are explicit |
| Audit and troubleshooting | Can a reviewer diagnose interrupted and degraded runs without assuming success? | Pass; diagnostic order, lease, signal, report and revalidation boundaries are explicit |

The DE/EN pair has the same four stable anchors, decision tables, example
families and safety outcomes. Wording is idiomatic rather than line-for-line;
no material semantic difference was found.

### Accessibility And Comprehension Review

- German precedes the linked English partner; both use CEFR-B2 sentences and
  define agentic work, Evidence, Level 0, Home Runtime, Remote Freshness,
  working tree, preview, Run ID, JSONL and Authority at first use.
- Every state and decision is available as text. Tables use explicit headers;
  code examples identify Bash or PowerShell; no color, diagram, screenshot or
  pointer action carries unique meaning.
- Keyboard-only and text-browser use need only normal links and copyable code.
  Screen readers and Braille displays receive the same order, status names,
  exit values, proof boundaries and next actions as visual readers.
- Stable explicit anchors avoid language-dependent generated heading IDs. Link
  text names the destination and purpose instead of using ambiguous "here".
  Four additional invisible heading-slug aliases preserve compatibility with
  the older Feature-021 link validator without changing visible navigation.
- The guide grants no remote, administrator, provider or secret authority and
  does not expose private paths or machine-local evidence.

### Shared Guidance Review

`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, both Copilot instruction files and
`.specify/templates/` were reviewed together. Feature 022 explains existing
rules without changing a normative agent or template contract, so the decision
is `NoUpdateRequired`. A later rule change on authority, distribution,
interruption or documentation impact triggers renewed parity review.

## Documentation Impact

| Family | Decision | Owner | Canonical source | Distribution | Home sync | Evidence | Re-evaluation trigger |
|---|---|---|---|---|---|---|---|
| D6 operating guide | `UpdateRequired` | Level-0 Documentation Maintainer | paired guide and source matrix | `sourceOnly` | No | 17 source-bound claims | maintenance surface or source hierarchy changes |
| Root/docs portals | `UpdateRequired` | Level-0 Documentation Maintainer | portal navigation | `sourceOnly` | No | DE/EN guide links added | reader paths change |
| Getting started | `UpdateRequired` | Level-0 Documentation Maintainer | paired getting-started pages | `sourceOnly` | No | first-safe-run anchor linked | safe first-run flow changes |
| Source/runtime architecture | `UpdateRequired` | Level-0 Documentation Maintainer | paired architecture pages | `sourceOnly` | No | maintainer-agent anchor linked | distribution model changes |
| Troubleshooting | `UpdateRequired` | Level-0 Documentation Maintainer | paired troubleshooting pages | `sourceOnly` | No | audit anchor linked | report, interruption or fallback contract changes |
| Manpage and public script reference | `NoUpdateRequired` | Script Maintainer | scripts and catalog renderer | mixed | No | Reviewed; public contract and canonical script set unchanged | public script surface changes |
| Embedded-script inventory | `GeneratedUpdate` | Script Maintainer | Git index and script-reference renderer | `sourceOnly` | No | Two Feature-022 Python paths rendered | embedded script set changes |
| Agent guidance and Spec-Kit templates | `NoUpdateRequired` | Governance Maintainer | Constitution and preset sources | `homeRuntime` if changed | No | Five surfaces and templates reviewed; no shared rule changed | shared normative rule changes |
| Project statistics | `GeneratedUpdate` | Repository Maintainer | config and Git history | `sourceOnly` | No | Pending renderer | feature delivery completes |

## Governance Matrix

| Preset | Version | Checkpoint | Applicability | Rationale | Evidence/Result | Re-evaluation trigger |
|---|---:|---|---|---|---|---|
| Security Governance | 0.6.1 | Safe commands, secrets, admin, sandbox, provider | Applicable | User-facing operational guidance can create unsafe actions if wrong | Pending semantic and source review | command or security boundary changes |
| Architecture Governance | 0.5.1 | Information architecture | Applicable | Four reader paths and source hierarchy change | Plan and source matrix | reader structure changes |
| iSAQB Architecture Governance | 0.2.1 | Documentation views and quality goals | Applicable | Traceability and progressive disclosure are quality goals | Plan/research | architecture scope changes |
| A11Y Governance | 0.4.2 | DE/EN, CEFR B2, WCAG 2.2 AA, text-first | Applicable | All product changes are learner-facing documentation | Pending review | audience or format changes |
| Cross-Platform Governance | 0.2.1 | macOS/Linux/Windows examples | Applicable | Commands differ by platform | Pending source matrix | platform surface changes |
| Agent Parity Governance | 0.4.1 | Five maintained surfaces | Applicable review | Update only on shared-rule change | Pending no-change review | normative agent rule changes |
| Intake Authoring Governance | 0.3.0 | Accepted receipt | Applicable | D6 was updated in place | Bash/PowerShell Pass | intake changes |
| Intake Review Governance | 0.2.0 | Current single review | Applicable | Project policy requires a current review | Bash/PowerShell Pass | intake hash changes |
| Intake Sequencing Governance | 0.2.2 | Eligible candidate and dependencies | Applicable | D6 must be serially eligible | Bash/PowerShell 35/3/42 Pass | Series changes |
| Autonomous Run Governance | 0.3.3 | Authority, state, exact-head closeout | Applicable | Full MergeAndSync run | Active | delivery state changes |
| Parallel Autonomous Governance | 0.2.4 | Campaign orchestration | N/A | Single serial feature | N/A | multiple independent runs are authorized |

## Standards And Assurance Decisions

| Checkpoint | Applicability | Rationale | Re-evaluation trigger |
|---|---|---|---|
| NIST SSDF, CWE Top 25 | Applicable | Secure documentation and Python test-tool review | executable or threat scope changes |
| OWASP ASVS | N/A | No web, API, HTTP, auth or service change | such a surface enters scope |
| SBOM, VEX, SLSA, OpenSSF Scorecard | N/A | No dependency or distributable software change | package or release scope changes |
| AI-SBOM | N/A | AI is a development tool, not released runtime | model, service or dataset enters product |
| STRIDE, CIA, CAPEC, Zero Trust | N/A | No trust boundary, runtime or distributed flow changes | architecture boundary changes |
| S-ADR, arc42 security concepts, SAMM | N/A | No security-significant architecture decision | architecture decision appears |
| BSI C3A, BSI C5 | N/A | No cloud service or provider-dependent deployment | cloud selection or operation enters scope |
| NIS2, CRA, EU AI Act, DORA | N/A | Documentation-only private workspace feature | regulated product or customer scope changes |

## Validation Log

| Command or review | Scope | Result | Proof boundary |
|---|---|---|---|
| `specify check` | Installed integrations | Pass | Tool availability only |
| Authoring receipt validators, Bash/PowerShell | D6 receipt | Pass | Current target and source hashes |
| Intake Review validators, Bash/PowerShell | D6 review | Pass | One Ready target |
| Series manifest/receipt validators, Bash/PowerShell | Active Series | Pass | 35 targets, 3 roots, 42 dependencies |
| Series Intake Review validators, Bash/PowerShell | Active Series review | Pass | Ready, 35 targets |
| `test_efficiency_guide.py` before validator | Test-first reference slice | Expected fail | `FileNotFoundError` for intentionally absent validator only |
| `test_efficiency_guide.py` after validator | Positive and six isolated negative fixtures | Pass | Schema/path/hash semantics; not learner comprehension |
| Production source-matrix validator | Four reader paths and 17 claims | Pass | Current staged paths and normalized source hashes |
| Script-reference renderer | Canonical reference and embedded-script inventory | Pass; generated inventory adds exactly two Feature-022 paths | Public script reference unchanged |
| Lychee `--offline --include-fragments` | 3,558 Markdown targets, 1,962 unique links | Pass; zero errors | Repository-local links and fragments only |
| Learning-package self-test | Minimal deterministic package | Pass | Package structure and exclusions, not D6 prose meaning |
| Secure-development document build `--check` | Generated secure-development family | Pass; current | Unchanged generated family |
| Documentation Impact Bash fixtures | Ten positive/negative cases | Pass | Bash contract; provider PowerShell counterpart remains required |
| PSScriptAnalyzer 1.25.0 | 147 repository-owned files, four generated exclusions | Pass; zero warnings/errors | No PowerShell product change |
| Secret scan with Gitleaks | Current Git diff and agent directories | Pass; zero high findings | Existing local medium/low configuration classes are not published changes |
| `specify check` | Installed Spec Kit integrations | Pass | Tool availability only |
| Changed-path scope assertion | 32 candidate paths | Pass | No executable maintenance, dependency, preset, registry, workflow or fleet change |
| `git diff --check` | Staged candidate | Pass | Whitespace and conflict-marker boundary only |
| Homogeneity | Level 0 | Pass; 30/30 | Includes generated statistics and embedded-script inventory |
| Project-statistics renderer | Profile 2 at checkpoint `c9cf11e` | Pass; `CURRENT` after render | Git-history-derived metrics, not elapsed work time |
| Requirements/task closure | 31 FR, 10 SC, 84 ordered tasks and three complete checklists | Pass | Six delivery/closeout tasks remain operational until remote completion |
| Feature-021 migration validator | 12 fixtures, 16 sections, four reader paths and 17 linked files | Pass after compatibility-alias remediation | Older validator derives heading slugs; Lychee validates explicit IDs |

## Local Implementation Acceptance

- Four reader paths, two language partners, four stable anchors and 17 current
  source claims are complete.
- All documented options, required status classes and exit values are covered
  by current primary sources with proof and re-evaluation boundaries.
- No active `[NEEDS CLARIFICATION]`, TODO or TBD marker remains in accepted
  feature artifacts.
- Product scope contains documentation, generated inventory/statistics and
  feature-local tests only. Runtime, dependency, preset, registry, workflow and
  fleet files are unchanged.
- Conditional DocFX/browser and supply-chain runtime gates remain `N/A` because
  their declared triggers did not occur. Existing provider workflows remain
  mandatory at the exact pushed head.

The first provider run exposed one actionable compatibility issue: Lychee
accepted the explicit stable IDs while the Feature-021 migration validator
recognized generated heading slugs only. The paired guide now carries both ID
forms at each of the four sections. Both validators pass locally; no validator
or workflow behavior was changed.

## Residual Risks And Follow-Ups

Decision: `NoFollowUpRequired`. The implementation review found no
non-documentation automation defect. Residual risk is limited to future drift
when a public option, report schema, UI status, distribution class or autonomous
authority contract changes; every such trigger is recorded in the source
matrix and requires guide revalidation.
