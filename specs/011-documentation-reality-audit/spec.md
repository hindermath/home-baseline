# Feature Specification: Registered Documentation Reality Audit

**Feature Branch:** `011-documentation-reality-audit`
**Created:** 2026-07-26
**Status:** Ready for Planning
**Binding Intake:** `Lastenheft_Registrierte-Level-0-1-2-Dokumentations-Wirklichkeitsabgleich-Audit.md`
**Binding Intake Review:** `specs/active-lastenheft-normalization/intake-review-result.json`

## User Scenarios & Testing

### User Story 1 - Understand the complete documentation inventory (Priority: P1)

As a learner, maintainer, or reviewer, I can see which documentation surfaces
exist in Level 0 and every currently registered Level-1 and Level-2 repository,
what each surface claims, and which current repository evidence supports it.

**Why this priority:** A complete inventory is required before inconsistencies
or ownership can be assessed without omissions.

**Independent Test:** Use a fixed registry snapshot and confirm that every
registered repository and every reachable documentation family has exactly one
inventory outcome with concrete evidence or an explicit blocking reason.

**Acceptance Scenarios:**

1. **Given** a reachable registered repository, **When** its documentation is
   audited, **Then** every relevant surface is listed with role, source,
   derivation status, owner, and evidence.
2. **Given** an unreachable or unsafe repository, **When** the fleet is
   inventoried, **Then** it is recorded as blocked with the exact reason and
   re-evaluation trigger rather than silently omitted.

### User Story 2 - Distinguish truth, drift, and intentional history (Priority: P1)

As a documentation owner, I can distinguish current and supported statements
from stale, contradictory, generated, historical, or intentionally different
material without changing the audited repositories.

**Why this priority:** Remediation planning requires evidence-based decisions,
not equal-looking files or assumptions based on filenames.

**Independent Test:** Review representative normative, generated, historical,
and repository-specific documents and prove that every reviewed unit receives
exactly one accepted decision and every finding receives one owner and handoff.

**Acceptance Scenarios:**

1. **Given** a claim that conflicts with current repository evidence, **When**
   the audit classifies it, **Then** it receives a stable `DOC###` finding,
   severity, owner, evidence, remediation boundary, and re-evaluation trigger.
2. **Given** historical or intentionally project-specific material, **When**
   it is reviewed, **Then** it remains distinguishable from current normative
   guidance and is not treated as drift solely because it differs.

### User Story 3 - Prepare bounded downstream remediation (Priority: P2)

As the owner of D2 and D3, I receive a complete, level-specific handoff that
separates central Level-0 remediation from repository-specific Level-1/2 work.

**Why this priority:** The audit is useful only when later work can consume its
findings without reinterpreting ownership or silently expanding scope.

**Independent Test:** Trace every `DOC###` row to exactly one Level-0 D2
handoff, Level-1/2 D3 handoff, or justified non-remediation disposition.

**Acceptance Scenarios:**

1. **Given** a confirmed finding, **When** the audit closes, **Then** its level,
   owner, target flow, and successor boundary are unambiguous.
2. **Given** the completed D1 evidence, **When** the run finishes, **Then** no
   documentation or product correction has been performed and D2 has not
   started automatically.

### Edge Cases

- A registry entry exists but its local checkout, remote, or default branch
  cannot be safely established.
- A Level-1 workspace owns documentation while containing multiple Level-2
  repositories with separate owners.
- A generated document differs from its source or cannot be reproduced.
- Two documents make conflicting normative claims without a declared owner.
- A historical document is still linked from current learner guidance.
- A repository contains private absolute paths, credentials, personal data, or
  machine-local state that must not enter publishable evidence.
- Native-platform documentation cannot be verified on the current machine.
- A repository was added to or removed from the registry after the audit
  snapshot was taken.

## Requirements

### Functional Requirements

- **FR-001:** The audit MUST freeze and record the current Level-0/1/2 registry
  snapshot, including exact repository and commit identity.
- **FR-002:** Every registered repository MUST be recorded as reviewed,
  explicitly blocked, or not applicable; none may be silently omitted.
- **FR-003:** The audit MUST inventory current guidance, specifications,
  architecture, security, accessibility, generated documentation, examples,
  learner material, statistics, and agent-facing documentation where present.
- **FR-004:** Every reviewed unit MUST receive exactly one primary decision:
  `CurrentAndSupported`, `UpdateRequired`, `GeneratedDrift`,
  `HistoricalEvidence`, `IntentionalDeviation`, `FollowUp`,
  `NotApplicable`, or `Blocked`.
- **FR-005:** Every positive statement MUST cite concrete evidence belonging to
  the exact assessed repository state.
- **FR-006:** Every confirmed discrepancy MUST receive a stable `DOC###`
  identifier, severity, owner, evidence, residual risk, correction boundary,
  and re-evaluation trigger.
- **FR-007:** Normative sources, derived copies, generated outputs, historical
  evidence, and repository-specific deviations MUST remain distinguishable.
- **FR-008:** Generated documentation MUST name its canonical source,
  generation contract, and reproducibility result.
- **FR-009:** Learner-facing content MUST be assessed for German-first and
  English-second delivery, CEFR-B2 readability, first-use terminology,
  text-first explanations, and absence of assumed Spec-Kit experience.
- **FR-010:** Applicable WCAG 2.2 AA requirements MUST be assessed for
  Markdown, HTML, command help, and templates.
- **FR-011:** Publishable evidence MUST exclude secrets, unnecessary personal
  data, private absolute paths, and machine-local state.
- **FR-012:** The audit MUST assess whether existing governance and gates are
  sufficient; it MUST NOT presume or create a new preset without reproducible
  portable evidence.
- **FR-013:** The run MUST remain read-only for fleet documentation, product
  code, scripts, workflows, presets, and remotes. Only Level-0 feature
  artifacts, deterministic audit tooling, audit evidence, archival/order
  markers, statistics, and delivery evidence may change.
- **FR-014:** Every finding MUST be assigned exactly once to central Level-0
  remediation in D2, repository-specific Level-1/2 remediation in D3, or a
  justified non-remediation outcome.

### Constitution and Governance Requirements

- **CR-001:** The current project Constitution and all installed governance
  presets apply to the audit evidence and any deterministic audit tooling.
- **CR-002:** Repository-specific Level-2 environment, runtime, platform,
  Memory-Safe-Language, security, accessibility, and statistics contracts MUST
  be read from the relevant repository rather than inferred centrally.
- **CR-003:** Security Governance applies to evidence hygiene, secret scanning,
  NIST SSDF and CWE Top 25 applicability. OWASP ASVS, SBOM, VEX, SLSA, AI-SBOM,
  supply-chain release evidence, and regulatory screening are `N/A` unless the
  actual audit tooling changes their trigger conditions.
- **CR-004:** Architecture, iSAQB, STRIDE/CIA/CAPEC, Zero Trust, cloud
  autonomy, BSI C3A, and BSI C5 are `N/A` for product architecture because the
  audit changes no runtime boundary, deployment topology, or cloud service.
- **CR-005:** A11Y Governance applies to all feature evidence and reports.
  Dependencies, decisions, blockers, and handoffs MUST have complete textual
  representations.
- **CR-006:** Cross-Platform Governance applies only if deterministic
  script-shaped audit tooling is created or changed; then Bash and PowerShell,
  safe preview behavior, bilingual help, and required documentation MUST remain
  equivalent.
- **CR-007:** Agent Parity Governance applies only if shared agent guidance
  changes. All maintained surfaces MUST be reviewed together and intentional
  differences documented.
- **CR-008:** AI is used only as a development and audit aid, not as a released
  runtime component; AI-SBOM is therefore `N/A`.
- **CR-009:** Project statistics MUST be updated at feature completion. Shared
  guidance changes are conditional on an evidenced audit finding.

### Key Entities

- **Registry Snapshot:** Exact Level-0/1/2 target set and repository identities
  assessed by the audit.
- **Documentation Unit:** One reviewable file, generated surface, or named
  documentation flow with one primary decision.
- **Claim Evidence:** A documented statement and the exact current evidence
  that supports or contradicts it.
- **Audit Finding:** Stable `DOC###` discrepancy with severity, owner, boundary,
  residual risk, and successor disposition.
- **Handoff:** Exclusive mapping of a finding to D2, D3, or a justified
  non-remediation outcome.

## Success Criteria

### Measurable Outcomes

- **SC-001:** Level 0 and 100% of repositories in the frozen Level-1/2 registry
  snapshot have a reviewed, blocked, or not-applicable outcome.
- **SC-002:** 100% of reachable documentation units have exactly one accepted
  primary decision and no duplicate inventory identity.
- **SC-003:** 100% of positive claims cite evidence from the exact assessed
  repository state.
- **SC-004:** 100% of findings have a unique `DOC###` ID, severity, owner,
  evidence, residual risk, correction boundary, and re-evaluation trigger.
- **SC-005:** 100% of findings have exactly one D2, D3, or justified
  non-remediation disposition.
- **SC-006:** Generated-document checks distinguish reproducible output,
  generated drift, and unavailable generation proof without guessing.
- **SC-007:** No Critical or High ambiguity remains in the remediation handoff.
- **SC-008:** The final diff contains no fleet documentation, product,
  dependency, runtime, API, preset, workflow, or remote mutation.
- **SC-009:** D1 is merged through one non-empty Level-0 PR, local `main`
  equals `origin/main`, and D2 has not been started.

## Assumptions

- `origin` is the canonical remote name unless a registered repository
  explicitly documents another contract.
- The registry snapshot at audit start defines cardinality; later registry
  changes trigger re-evaluation rather than silent scope changes.
- Existing repository-native validators are preferred over inferred checks.
- Unavailable native-platform proof is recorded as blocked or follow-up, never
  as pass.
- MergeAndSync authority applies to the Level-0 D1 feature delivery only. It
  does not authorize writes to audited Level-1/2 repositories.
- The current active Series review is the unique binding intake review.

## Out of Scope

Documentation remediation, product or API changes, package updates, preset
productization, workflow changes outside deterministic audit proof, historical
content deletion, D2 execution, and D3 execution.
