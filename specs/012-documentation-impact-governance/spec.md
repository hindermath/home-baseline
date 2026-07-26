# Feature Specification: Documentation Impact Governance

**Feature Branch**: `012-documentation-impact-governance`
**Created**: 2026-07-26
**Status**: Accepted
**Binding Intake**: `Lastenheft_Level-0-Dokumentations-Konsistenz-Remediation-und-Flotten-Governance.md`

## User Scenarios & Testing

### User Story 1 - Auswirkung eindeutig entscheiden (Priority: P1)

Maintainer und Lernende können für jede Änderung genau eine
Dokumentationsentscheidung treffen: `UpdateRequired`, `NoUpdateRequired`,
`GeneratedUpdate` oder `FollowUp`.

**Independent Test**: Ein gültiges Evidence-Dokument besteht; fehlende,
doppelte oder unbekannte Entscheidungen werden abgelehnt.

### User Story 2 - Quelle und Verantwortung finden (Priority: P2)

Eine bilinguale, textorientierte Matrix erklärt Quelle, Owner,
Aktualisierungsauslöser, Ableitung, Validator und Wiedervorlage je
Dokumentfamilie.

**Independent Test**: Eine Person ohne Spec-Kit-Vorkenntnisse kann für jede
aufgeführte Familie Quelle und Prüfweg bestimmen.

### User Story 3 - Audit-Findings korrekt weitergeben (Priority: P3)

Alle 15 D1-Findings besitzen genau einen D3-Handoff. Es wird kein zentraler
Level-0-Remediation-Bedarf erfunden.

**Independent Test**: Die Disposition enthält genau `DOC001` bis `DOC015`,
jeweils mit Owner, Evidence-Hash und Re-Evaluation-Trigger.

## Requirements

### Functional Requirements

- **FR-001**: Die beiden Constitution-Dateien MÜSSEN denselben normativen
  Documentation-Impact-Vertrag enthalten.
- **FR-002**: Spec, Plan, Tasks, Checklist und PR-Evidence MÜSSEN genau eine
  der vier Entscheidungen verlangen.
- **FR-003**: Alle fünf gepflegten Agentenflächen MÜSSEN denselben operativen
  Hinweis enthalten.
- **FR-004**: Die zentrale Referenz MUSS Level 0, 1 und 2 sowie Source of
  Truth, Ownership, Trigger, Ableitung, Validator und Wiedervorlage erklären.
- **FR-005**: Ein deterministischer Bash-/PowerShell-Vertrag MUSS ungültige
  Evidence ablehnen und gültige Evidence akzeptieren.
- **FR-006**: Generierte Dokumente DÜRFEN nur über kanonische Quellen und
  dokumentierte Renderer geändert werden.
- **FR-007**: `FollowUp` MUSS Owner, Risiko, Frist, Wiedervorlage und
  Scope-Begründung besitzen.
- **FR-008**: Sicherheits-, Bedienungs- oder Breaking-Change-Dokumentation
  DARF nicht ohne ausdrückliche Risikofreigabe verschoben werden.
- **FR-009**: Alle D1-Findings MÜSSEN genau einmal dispositioniert werden.
- **FR-010**: D2 DARF keinen Level-1-/Level-2-Arbeitsbaum verändern.
- **FR-011**: D3 DARF nur die gemergte D2-Baseline und explizite Handoffs
  übernehmen.
- **FR-012**: User-facing content MUST be DE-first/EN-second, CEFR B2,
  text-first, first-use explanatory and WCAG 2.2 AA where applicable.
- **FR-013**: Runtime, API, package, dependency and product behavior MUST
  remain unchanged.
- **FR-014**: Statistics and delivery evidence MUST be updated.
- **FR-015**: A portable preset follow-up MUST require a reproducible
  provider-neutral defect; otherwise the result is `NoPromotion`.

### Constitution Requirements

- **CR-001**: NIST SSDF and CWE Top 25 apply to evidence integrity and
  validation; no runtime security surface changes.
- **CR-002**: ASVS, SBOM, VEX, SLSA, AI-SBOM, CAPEC, Zero Trust, SAMM, BSI
  C3A/C5, NIS2, CRA, EU AI Act and DORA are `N/A`; re-evaluate on matching
  runtime, release, cloud, AI-product or regulatory scope.
- **CR-003**: All eleven installed presets are reviewed; Intake Authoring,
  Review, Sequencing, Autonomous, A11Y and Agent Parity are applicable.
- **CR-004**: PowerShell 7 is the typed validator implementation; Bash is its
  portable wrapper. PowerShell is memory-safe.

## Success Criteria

- **SC-001**: Exactly four decision values are accepted.
- **SC-002**: Positive evidence passes in Bash and PowerShell with the same
  result; every negative fixture fails in both.
- **SC-003**: Exactly 15 D1 findings are handed to D3 and zero to D2
  remediation.
- **SC-004**: Constitution, three workflow templates, checklist, PR template,
  central reference and five agent surfaces are synchronized.
- **SC-005**: All repository mandatory gates pass on the reviewed head.
- **SC-006**: D2 closes on synchronized `main` without starting D3.

## Assumptions

- Feature 011 and PRs #126/#127 are the accepted D1 evidence.
- D1 found no central Level-0 documentation defect.
- The reusable validator checks structure and deterministic boundaries, not
  semantic truth.
