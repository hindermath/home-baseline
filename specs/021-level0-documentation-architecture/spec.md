# Feature Specification: Level-0 Documentation Architecture

**Feature Branch**: `021-level0-documentation-architecture`
**Created**: 2026-08-01
**Status**: Ready for implementation
**Binding Intake**: `Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.md`
**Finding**: `DIA001`

## User Scenarios & Testing

### User Story 1 - Start with the right reader path (Priority: P1)

As a learner or first-time user, I can identify the repository purpose, safe
first action, prerequisites, and the reader path that matches my task without
prior Spec Kit knowledge.

**Independent Test**: Open the German or English root entry, select any of the
four reader paths, and reach its first actionable page within two navigation
steps.

**Acceptance Scenarios**:

1. **Given** a German-speaking learner, **When** `README.md` is opened, **Then**
   the learner sees the learner path, required tools, security boundary, and a
   precise next action.
2. **Given** an English-speaking reader, **When** `README.en.md` is opened,
   **Then** the same information and destinations are available in English.
3. **Given** any reader role, **When** the documentation portal is followed,
   **Then** the matching path is reachable without relying on color or diagrams.

### User Story 2 - Operate and maintain safely (Priority: P1)

As a daily user or maintainer, I can distinguish the versioned Level-0 source,
the selected Home Runtime, source-only documents, and machine-local state before
I run maintenance or edit files.

**Independent Test**: For one representative artifact in each distribution
class, identify its owner, canonical edit location, synchronization need, and
remote authority boundary from either language path.

**Acceptance Scenarios**:

1. **Given** a runtime script under `~/`, **When** its documentation is read,
   **Then** the canonical source and safe synchronization flow are explicit.
2. **Given** a source-only document, **When** it changes, **Then** the guidance
   states that no Home sync is required.
3. **Given** machine-local state, **When** publication is considered, **Then**
   the documentation denies implicit commit, push, or merge authority.

### User Story 3 - Preserve and govern documentation (Priority: P1)

As a maintainer or AI agent, I can migrate and evolve documentation without
losing active content, duplicating normative rules, or allowing language paths
to drift.

**Independent Test**: Validate the section migration matrix, language partners,
internal links, Documentation Impact fields, and synchronized governance
surfaces against the delivered repository.

**Acceptance Scenarios**:

1. **Given** every former root README section, **When** the migration matrix is
   validated, **Then** exactly one retained, moved, merged, or obsolete decision
   with a target and proof exists.
2. **Given** a relevant future change, **When** Documentation Impact is recorded,
   **Then** exactly one approved decision and all required architecture fields
   are present.
3. **Given** a large paired document, **When** either language changes, **Then**
   the language partner is updated or the change remains visibly incomplete.

### User Story 4 - Audit and troubleshoot from stable evidence (Priority: P2)

As a reviewer, I can locate generated, historical, audit, and troubleshooting
evidence while understanding its source, freshness, and proof boundary.

**Independent Test**: Navigate from the audit reader path to current statistics,
script references, security/A11Y evidence, and historical feature evidence.

### Edge Cases

- A former README anchor cannot be preserved exactly after language splitting.
- A section duplicates a newer normative source.
- A generated document appears editable but has a canonical source and renderer.
- A language partner is intentionally absent for a short bilingual document.
- A private absolute path appears in local evidence.
- A moved section contains platform-specific commands or side effects.
- A historical evidence file contains terminology that is now obsolete.

## Requirements

### Functional Requirements

- **FR-001**: The implementation MUST remediate only accepted finding `DIA001`.
- **FR-002**: `README.md` MUST be a compact German entry page.
- **FR-003**: `README.en.md` MUST provide equivalent English information.
- **FR-004**: The two root entry pages MUST link to each other descriptively.
- **FR-005**: `docs/README.md` and `docs/README.en.md` MUST serve as central
  documentation portals.
- **FR-006**: Both portals MUST expose learner, daily-user, maintainer/agent,
  and audit/troubleshooting paths.
- **FR-007**: Each reader path MUST identify prerequisites, ordered steps,
  deeper references, and one safe next action.
- **FR-008**: Existing meaningful documentation directories MUST remain the
  canonical topic structure.
- **FR-009**: Every former root README section MUST receive exactly one migration
  decision: `Retained`, `Moved`, `Merged`, or `Obsolete`.
- **FR-010**: Each migration row MUST name its target, language partner, link
  proof, and `DIA001` trace.
- **FR-011**: Active content MUST NOT disappear without an explicit `Obsolete`
  rationale and reviewer evidence.
- **FR-012**: Normative duplicates MUST resolve to one canonical source with
  links from explanatory surfaces.
- **FR-013**: Level-0 source, Home Runtime, `homeRuntime`, `sourceOnly`, and
  `machineLocal` MUST be defined in German and English.
- **FR-014**: Source/runtime documentation MUST state owner, edit location,
  synchronization trigger, publication boundary, and container boundary.
- **FR-015**: Concrete runtime inventories MUST be derived from or linked to the
  current manifest rather than maintained as static totals.
- **FR-016**: Documentation Impact MUST remain exactly one of
  `UpdateRequired`, `NoUpdateRequired`, `GeneratedUpdate`, or `FollowUp`.
- **FR-017**: Documentation Impact evidence MUST add audience, reader path,
  canonical source, navigation effect, document class, language strategy,
  platform/example proof, distribution class, sync need, and reevaluation.
- **FR-018**: Constitution, documentation governance, Spec Kit templates, PR
  surfaces, and all maintained agent surfaces MUST carry the same normative core.
- **FR-019**: Generated documentation MUST change only through its canonical
  source and renderer.
- **FR-020**: Historical and archived evidence MUST remain byte-identical.
- **FR-021**: New or changed command guidance MUST state platform,
  prerequisites, side effects, and safe preview mode.
- **FR-022**: User-facing content MUST follow German-first/English-second,
  CEFR-B2, first-use terminology, and applicable WCAG 2.2 AA.
- **FR-023**: Semantic review and deterministic validation MUST be separate
  evidence entries.
- **FR-024**: Unresolved documentation debt MUST use `FollowUp` with owner,
  risk, due date, review trigger, evidence, and scope reason.
- **FR-025**: Internal and relevant historical deep links MUST be validated or
  mapped to a documented replacement.
- **FR-026**: No runtime, API, dependency, maintenance behavior, fleet, D6, or
  D7 change is permitted.
- **FR-027**: A preset follow-up MUST be created only for a reproducible,
  provider-neutral defect.
- **FR-028**: The final evidence MUST preserve D6 and D7 finding counts at zero.

### Governance Applicability

- **Security Governance**: Applicable to secret scanning, safe command guidance,
  and trust-boundary documentation. Product threat-model, SBOM, VEX, SLSA,
  Scorecard, AI-SBOM, and regulatory evidence are `N/A` because executable,
  dependency, deployment, and regulated processing scope do not change.
- **Architecture Governance**: Applicable to source/runtime and ownership
  boundaries. Runtime STRIDE/CIA/CAPEC, S-ADR, arc42 product security, Zero
  Trust, SAMM, BSI C3A, and BSI C5 are `N/A` absent a runtime or cloud change.
- **iSAQB Architecture Governance**: Applicable to understandable architecture
  navigation and explicit decisions; runtime architecture conformance is `N/A`.
- **A11Y Governance**: Applicable to text-first navigation, language paths,
  headings, links, terminology, and WCAG 2.2 AA review.
- **Cross-Platform Governance**: Applicable to platform-labelled commands and
  link validation; script behavior change is `N/A`.
- **Agent Parity Governance**: Applicable to all five maintained agent surfaces
  and affected `.specify/templates/`.
- **Autonomous Run Governance**: Applicable to evidence, state, exact-head gates,
  authorized MergeAndSync, and causal closeout.
- **Intake Authoring, Review, and Sequencing**: Applicable to accepted intake,
  current review, Series eligibility, and post-merge successor state.

## Success Criteria

- **SC-001**: Both root pages are concise and expose equivalent information.
- **SC-002**: All four reader paths are reachable in at most two links.
- **SC-003**: Every former top-level README section has exactly one valid
  migration row and no active content is unaccounted for.
- **SC-004**: All delivered internal Markdown links resolve.
- **SC-005**: A learner can correctly classify source, runtime, source-only,
  and machine-local examples using only the delivered documentation.
- **SC-006**: A maintainer can determine edit location, sync need, and delivery
  authority for a documentation change.
- **SC-007**: Normative surfaces contain the same four decision terms and the
  same required evidence fields.
- **SC-008**: German and English paths pass semantic parity review.
- **SC-009**: Deterministic validation covers positive delivery plus missing
  section, duplicate decision, broken link, missing language partner, invalid
  decision, private path, and D6/D7 regression cases.
- **SC-010**: The final diff contains no runtime, API, dependency, or product
  behavior change.
- **SC-011**: All required local and provider gates pass for the exact reviewed
  head, with zero actionable review threads.
- **SC-012**: Feature 021 ends on clean synchronized `main`; D6 and D7 are not
  started within the feature.

## Clarifications

No formal clarification is required. The binding D4 finding, target
architecture, language strategy, migration contract, and no-runtime boundary
are sufficient for planning and acceptance.

## Assumptions

- Existing topic directories remain authoritative.
- Historical anchors may use documented replacements when exact preservation is
  impossible.
- The current Home sync manifest is the source of distribution truth.
- Documentation-only changes still run every validator that reads changed paths.

## Out of Scope

- Product, script, API, dependency, package, and fleet changes.
- Editing archived D1-D4 evidence.
- A universal maximum Markdown file length.
- Automatic execution of D6 or D7.
