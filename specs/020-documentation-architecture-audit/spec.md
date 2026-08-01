# Feature Specification: Documentation Information Architecture Audit

**Feature Branch:** `020-documentation-architecture-audit`  
**Created:** 2026-08-01  
**Status:** Ready for Planning  
**Binding Intake:** `Lastenheft_Dokumentations-Informationsarchitektur-und-Lernpfad-Audit.md`  
**Binding Intake Review:** `specs/documentation-architecture-intakes/reviews/d4/intake-review-result.json`

## User Scenarios & Testing

### User Story 1 - Find the right documentation path (Priority: P1)

As a learner, daily user, maintainer, or reviewer, I can identify the shortest
safe path from the Level-0 entry points to the information needed for my role.

**Why this priority:** Documentation is useful only when its intended audience
can find the authoritative information without prior Spec Kit knowledge.

**Independent Test:** Derive the complete Git-tracked documentation inventory
and trace each of the four reader roles from an entry page to detailed guidance
and reference material.

**Acceptance Scenarios:**

1. **Given** the current Level-0 documentation, **When** a reader path is
   assessed, **Then** its entry point, prerequisites, next action, authoritative
   source, depth transitions, and blockers are recorded in text.
2. **Given** a missing, circular, or contradictory path, **When** it is found,
   **Then** it receives a stable finding and a bounded successor handoff rather
   than an audit-time repair.

### User Story 2 - Distinguish source, runtime copy, and local state (Priority: P1)

As a workspace user or AI-agent maintainer, I can distinguish the versioned
Level-0 source, the manifest-managed Home Runtime, and machine-local state, and
I know where a change belongs and which synchronization or remote authority it
requires.

**Why this priority:** Confusing these locations can lose local state, publish
private data, or produce changes that cannot be reviewed or reproduced.

**Independent Test:** Classify every current path resolved from Git, the Home
Sync manifest, source resolvers, and operating guidance as `homeRuntime`,
`sourceOnly`, or `machineLocal`, with owner and authority evidence.

**Acceptance Scenarios:**

1. **Given** an artifact in one of the three classes, **When** its lifecycle is
   reviewed, **Then** the canonical edit location, synchronization need,
   commit/push boundary, benefit, and safe next action are explicit.
2. **Given** a direct Home Runtime edit or local Home commit, **When** it is
   assessed, **Then** it is not represented as a canonical Level-0 source
   change or as remote delivery authority.

### User Story 3 - Verify maintenance documentation against delivered behavior (Priority: P1)

As an operator or auditor, I can see whether README, manpage, architecture,
accessibility, security, script reference, and Feature contracts describe the
same maintenance behavior delivered by Features 015 through 019.

**Why this priority:** A green implementation is unsafe to operate when active
documentation gives conflicting instructions about preview, results,
interruption, fallback, remote freshness, or cleanup.

**Independent Test:** Build a cross-document consistency matrix for every
accepted maintenance contract and bind each decision to the exact merged
feature evidence and current documentation.

**Acceptance Scenarios:**

1. **Given** one maintenance contract, **When** all active surfaces are
   compared, **Then** their claims and proof boundaries are consistent or a
   stable finding names the contradiction.
2. **Given** an implementation detail that is not promised to users, **When**
   the matrix is reviewed, **Then** the audit does not invent a documentation
   obligation without a learner, operator, maintainer, or assurance need.

### User Story 4 - Prepare evidence-based remediation (Priority: P2)

As the owner of D5, D6, or D7, I receive a complete, deduplicated handoff for
each confirmed documentation finding without receiving speculative work.

**Why this priority:** The following runs must be shaped by actual audit
findings, not by assumptions made before the inventory exists.

**Independent Test:** Trace every finding to exactly one successor owner and
verify that zero-finding successor scopes remain unstarted.

**Acceptance Scenarios:**

1. **Given** a confirmed finding, **When** the audit closes, **Then** it has a
   stable `DIA###` identifier, severity, owner, evidence, residual risk,
   target, and re-evaluation trigger.
2. **Given** no confirmed D5 remediation need, **When** Feature 020 closes,
   **Then** D5 is not started and no empty remediation intake or PR is created.

### Edge Cases

- A file is Git-tracked but generated, historical, archived, or external and
  must not be reviewed as current normative guidance.
- A generated document has no reproducible renderer or differs from its source.
- A bilingual document is long but remains clearer together, or a short
  document is difficult to navigate because its languages are interleaved.
- A Markdown link works locally but its target is historical, private, or not
  reachable from the intended entry point.
- Current prose embeds a time-bound fleet or preset count as though it were a
  permanent technical maximum.
- A Feature-015-to-019 contract is correct in code but absent, stale, or
  contradictory in one active documentation surface.
- A machine-local path, credential, personal datum, cache, or private agent log
  appears during inventory and must not enter publishable evidence.
- A deterministic validator passes syntax while a semantic contradiction
  remains.

## Requirements

### Functional Requirements

- **DIA-001:** The audit MUST derive a complete documentation inventory from
  the Git index and MUST NOT use a manually maintained count as lasting truth.
- **DIA-002:** Every file or named document family MUST receive exactly one
  artifact class and one primary decision.
- **DIA-003:** Every active unit MUST record audience, reader path, assumed
  knowledge, and appropriate depth.
- **DIA-004:** The root README MUST be assessed for mixed roles, navigation
  load, duplication, and appropriate extraction targets.
- **DIA-005:** The audit MUST define a target architecture for `README.md`, a
  possible `README.en.md`, and the documentation portal without moving files.
- **DIA-006:** Duplicate normative claims MUST be assigned to one canonical
  source and explicitly named derivatives.
- **DIA-007:** Language splitting MUST be recommended only from the accepted
  usability and maintainability criteria.
- **DIA-008:** Every proposed language companion MUST define synchronization,
  parity, and reciprocal-navigation rules.
- **DIA-009:** Command and code examples MUST be assessed for context,
  platform, prerequisites, security boundaries, and safe verification.
- **DIA-010:** User-facing material MUST be assessed for German first, English
  second, CEFR B2, and first-use explanations of technical terms.
- **DIA-011:** Each applicable document family MUST be assessed against WCAG
  2.2 AA and text-first alternatives.
- **DIA-012:** Generated documents MUST be mapped to their canonical source and
  renderer; generated outputs MUST NOT be repaired manually.
- **DIA-013:** Historical evidence MUST NOT be editorially modernized.
- **DIA-014:** The decisions `UpdateRequired`, `NoUpdateRequired`,
  `GeneratedUpdate`, and `FollowUp` MUST remain the Documentation Impact model.
- **DIA-015:** The audit MUST decide whether Documentation Impact evidence needs
  additional reader-path, navigation, language, source, or example-proof data.
- **DIA-016:** The semantic audit MUST explicitly record the proof boundary of
  every deterministic validator.
- **DIA-017:** A preset follow-up MUST require a reproducible,
  project-independent defect; otherwise the result is `NoPromotion`.
- **DIA-018:** The audit MUST NOT change professional documentation, runtime,
  maintenance scripts, presets, workflows, or fleet repositories.
- **DIA-019:** Evidence from Features 015 through 019 and their closeouts MUST
  be bound without replacing current Git-derived documentation truth.
- **DIA-020:** A consistency matrix MUST cover README, manpage, architecture,
  accessibility, security, script reference, and Feature contracts.
- **DIA-021:** The matrix MUST assess Enhanced, Plain, and Headless selection;
  no-argument/TTY behavior; safe preview; default `DryRun`; default-No
  confirmation; and unchanged explicit Headless parameters.
- **DIA-022:** The matrix MUST assess additive JSONL live evidence,
  `EVENT_STREAM_DEGRADED`, fallback before engine start, exactly-once `Ctrl+C`,
  and report plus process exit code as canonical completion truth.
- **DIA-023:** Remote freshness, safe pull classification, bounded network
  evidence, worktree leases, cleanup boundaries, and dynamic preset profiles
  MUST be assessed without fixed permanent fleet or preset counts.
- **DIA-024:** A separate matrix MUST classify current source-derived paths as
  `homeRuntime`, `sourceOnly`, or `machineLocal`.
- **DIA-025:** All four reader paths MUST clearly distinguish the versioned
  source from the derived Home Runtime and machine-local state.
- **DIA-026:** The audit MUST record Home Runtime contents, purpose, benefits,
  and non-goals, including that the whole home directory is not the runtime.
- **DIA-027:** Every artifact class MUST record edit location, synchronization
  need, commit/remote authority, and safe next action.
- **DIA-028:** Direct Home Runtime edits MUST NOT be treated as canonical source
  changes or replacements for reviewed source delivery.
- **DIA-029:** Local Home commits MUST be distinguished as audit and recovery
  evidence without Level-0 remote authority.
- **DIA-030:** Host sync, source resolution, and read-only container reference
  MUST be assessed as separate operational boundaries.
- **DIA-031:** Contradictions about working directory, read source, sync trigger,
  force use, or publication location MUST receive stable findings and one D5 or
  D6 handoff.

### Evidence and Decision Requirements

- Every unit MUST use one artifact class: `ActiveSemantic`, `Generated`,
  `Historical`, `Archived`, `ExternalReference`, `AgentSurface`, or
  `IntakeEvidence`.
- Every unit MUST use one primary decision: `KeepAsIs`, `Restructure`,
  `SplitByTopic`, `SplitByLanguage`, `MergeDuplicate`,
  `GeneratedFromSource`, `ArchiveOnly`, or `FollowUp`.
- Every decision MUST include audience, rationale, canonical source, owner,
  current or target path, risk, evidence, and re-evaluation trigger.
- Every confirmed finding MUST use a stable `DIA###` identifier and exactly one
  D5, D6, D7, or justified non-remediation disposition.
- Positive claims MUST cite exact repository evidence. Exclusions MUST be
  reproducible and MUST NOT silently reduce the inventory.

### Constitution and Governance Requirements

- **CR-001:** The primary implementation language for any deterministic audit
  helper is Python 3, which is on the Constitution's memory-safe allow-list.
  The feature otherwise changes no product implementation language.
- **CR-002:** Security Governance applies to evidence hygiene, path handling,
  secret scanning, NIST SSDF, and CWE Top 25 review. OWASP ASVS, SBOM, VEX,
  SLSA, OpenSSF Scorecard, AI-SBOM, CRA, NIS2, EU AI Act, and DORA are `N/A`
  because the audit changes no released runtime, web/API boundary, dependency,
  supply-chain artifact, or AI product component; any changed trigger MUST be
  re-evaluated before implementation.
- **CR-003:** Architecture and iSAQB Governance apply to documentation of the
  existing source/runtime/local-state boundary. STRIDE/CIA/CAPEC, S-ADR,
  arc42 runtime changes, Zero Trust, SAMM, BSI C3A, and BSI C5 product evidence
  are `N/A` because no architecture, cloud service, provider dependency,
  deployment topology, or distributed flow changes.
- **CR-004:** A11Y Governance applies to all reports and matrices. Dependencies,
  status, decisions, and reader paths MUST remain understandable without color,
  diagrams, or visual-only cues and MUST meet the repository's learner policy.
- **CR-005:** Cross-Platform Governance applies only to deterministic audit
  tooling. Any helper MUST be platform-neutral or have equivalent Bash and
  PowerShell validation entry points; no operational script-shaped product tool
  may be added.
- **CR-006:** Agent Parity Governance is `N/A` unless the audit finds and a
  successor accepts a shared-guidance change. Feature 020 MUST NOT repair agent
  surfaces.
- **CR-007:** Intake Authoring, Intake Review, and Intake Sequencing evidence is
  binding input. Autonomous Run governs state and delivery. Parallel Autonomous
  is `N/A` because this audit is serialized and uses shared evidence writers.
- **CR-008:** Documentation Impact is `NoUpdateRequired` for active professional
  documentation during implementation; the audit creates feature evidence only.
  Confirmed documentation changes are deferred to D5, D6, or D7.
- **CR-009:** Project statistics MUST be updated after the audit delivery.
  Shared guidance and `.specify/templates/` remain unchanged unless a separate
  accepted successor authorizes them.
- **CR-010:** AI is a development and audit aid only and is absent from released
  or operated software; AI-SBOM remains `N/A`.

### Key Entities

- **Documentation Unit:** One tracked file or named family with one class and
  one primary decision.
- **Reader Path:** Ordered, text-first route from entry point through guidance
  to detailed reference for one audience.
- **Source/Runtime Record:** One path or family classified as `homeRuntime`,
  `sourceOnly`, or `machineLocal`, with ownership and authority boundaries.
- **Contract Matrix Row:** One behavior from Features 015 through 019 compared
  across all active documentation surfaces.
- **Audit Finding:** Stable `DIA###` discrepancy with severity, evidence,
  owner, residual risk, successor, and re-evaluation trigger.

## Success Criteria

### Measurable Outcomes

- **AC-DIA-001:** 100% of Git-tracked documentation surfaces are inventoried or
  have a reproducible exclusion rationale.
- **AC-DIA-002:** 100% of reviewed units have exactly one class and one primary
  decision.
- **AC-DIA-003:** All four reader paths are completely assessed.
- **AC-DIA-004:** The root README has a traceable target and migration matrix
  without premature file movement.
- **AC-DIA-005:** Every language-splitting recommendation names criteria,
  companion, synchronization, and navigation.
- **AC-DIA-006:** Active, generated, historical, and archived material follows
  its distinct review boundary.
- **AC-DIA-007:** 100% of positive claims cite concrete evidence.
- **AC-DIA-008:** No Critical or High ambiguity remains for D5.
- **AC-DIA-009:** D1-D3 evidence is unchanged and not reinterpreted.
- **AC-DIA-010:** No professional documentation, runtime, script, preset,
  workflow, dependency, API, or fleet repository is changed.
- **AC-DIA-011:** Preset follow-up is reproducibly proven or `NoPromotion`.
- **AC-DIA-012:** D5 is not started automatically.
- **AC-DIA-013:** Feature and closeout evidence 015 through 019 is completely
  mapped without rewriting historical evidence.
- **AC-DIA-014:** Active maintenance surfaces have no unresolved Critical or
  High contradiction.
- **AC-DIA-015:** Selection, preview, confirmation, live evidence, completion,
  interruption, and fallback each have a decision and proof boundary.
- **AC-DIA-016:** Remote freshness, pull classes, network attempts, worktree
  leases, and cleanup are consistently assessed.
- **AC-DIA-017:** Fleet and preset counts are dynamic or explicitly time-bound.
- **AC-DIA-018:** `homeRuntime`, `sourceOnly`, and `machineLocal` are completely
  and consistently assigned from current sources.
- **AC-DIA-019:** All four readers can distinguish source, runtime copy, local
  state, and authority.
- **AC-DIA-020:** Home Runtime content and benefits are proven without treating
  all of the home directory as runtime or as a remote checkout.
- **AC-DIA-021:** Every artifact class has an edit location, sync need,
  commit/push boundary, and safe next action.
- **AC-DIA-022:** Source resolver, host sync, and container reference have no
  unresolved Critical or High ambiguity.
- **SC-023:** Feature 020 is delivered through one non-empty Level-0 PR,
  exact-head gates pass, local `main` equals `origin/main`, and no successor
  feature starts as part of this run.

## Assumptions

- The current Git index at audit start is the inventory boundary.
- Historical evidence and prior D1-D3 findings remain immutable inputs.
- Existing repository-native renderers and validators define mechanical proof;
  semantic review remains necessary.
- `origin` and the permanent Level-0 checkout retain their documented roles.
- `MergeAndSync` authorizes only Feature-020 delivery in Home Baseline.
- A D5 run requires a confirmed, non-empty D5-owned remediation set and fresh
  user authority already supplied by the enclosing serial-run request.

## Out of Scope

Documentation remediation, file splitting or movement, product/runtime/API
changes, dependency or package changes, workflow changes, preset
productization, fleet repository writes, historical rewriting, D5 execution,
D6 execution, and D7 execution.
