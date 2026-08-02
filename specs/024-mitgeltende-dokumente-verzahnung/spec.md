# Feature Specification: Mitgeltende Dokumente und Spec-Kit-Verzahnung

**Feature Branch:** `024-mitgeltende-dokumente-verzahnung`
**Created:** 2026-08-02
**Status:** Ready for Planning
**Binding Intake:** `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.md`
**Binding Review:** `specs/mitgeltende-dokumente-spec-kit-verzahnung-intake-review/intake-review-result.json`

## User Scenarios & Testing

### User Story 1 - Verbindliche Pruefbruecke verstehen (Priority: P1)

Auszubildende und Maintainer koennen von einer mitgeltenden Richtlinie zu den
betroffenen Checklisten, Presets und Nachweisen navigieren, ohne Spec-Kit-
Vorkenntnisse oder eine nur visuelle Darstellung zu benoetigen.

**Independent Test:** Jede aktive mitgeltende Dokumentfamilie besitzt eine
eindeutige Mapping-Zeile mit Richtlinien-, Checklisten-, Preset- und
Evidence-Bezug.

### User Story 2 - Profile korrekt unterscheiden (Priority: P1)

Reviewer unterscheiden das oeffentliche Acht-Preset-Standardprofil vom
verwalteten Elf-Preset-Profil mit Intake Authoring, Review und Sequencing.

**Independent Test:** Ein deterministischer Validator weist beide Profile und
alle elf installierten Presets ohne feste Obergrenze nach.

### User Story 3 - Entscheidungen nachvollziehbar belegen (Priority: P2)

Fuer jede gepruefte Flaeche werden Anwendbarkeit und Erfuellungsstand getrennt
mit Owner, Reviewer, Evidence, Restrisiko, Follow-up und Neubewertung erfasst.

**Independent Test:** Das Feature-Ledger lehnt fehlende Statusachsen oder
Evidence-Felder ab und deckt alle Mapping-Zeilen genau einmal ab.

### Edge Cases

- Ein optionales Preset ist installiert, aber fuer eine Dokumentzeile `N/A`.
- Eine erzeugte Ableitung widerspricht ihrer kanonischen Quelle.
- Ein Begriff ist technisch korrekt, aber fuer das erste Lehrjahr unerklärt.
- Eine Assurance-Frage gehoert zu Position 14 bis 17 und darf nicht vorgezogen werden.

## Requirements

### Functional Requirements

- **MDV-001:** Die vorhandene Mapping-Datei MUST die einzige kanonische Pruefbruecke bleiben.
- **MDV-002:** Alle zwoelf Checklisten und alle im Baseline-Manifest gefuehrten mitgeltenden Dokumente MUST abgedeckt sein.
- **MDV-003:** Das oeffentliche Acht-Preset-Profil und das verwaltete Elf-Preset-Profil MUST getrennt erklaert werden.
- **MDV-004:** Die drei optionalen Intake-Presets MUST mit Zweck, Reihenfolge und Nicht-Automatik dokumentiert sein.
- **MDV-005:** Anwendbarkeit MUST `Applicable`, `N/A` oder `Open` verwenden; Erfuellung MUST getrennt bewertet werden.
- **MDV-006:** Jede Review-Zeile MUST Rationale, Evidence, Owner, Reviewer, Restrisiko, Follow-up und Neubewertungs-Trigger enthalten.
- **MDV-007:** Kanonische Quellen und erzeugte Ableitungen MUST unterscheidbar bleiben.
- **MDV-008:** Die 157 stabilen Checklistenpunkte und Baseline 3.2.0 MUST unverfaelscht nachgewiesen werden.
- **MDV-009:** Deutsch steht zuerst, Englisch folgt; CEFR B2, Erstbegriffserklaerung und text-first gelten.
- **MDV-010:** Die vier IT-Ausbildungsberufe MUST ab dem ersten Lehrjahr als Zielgruppe beruecksichtigt werden.
- **MDV-011:** Findings der Assurance-Positionen 14 bis 17 MUST als Follow-up begrenzt werden.
- **MDV-012:** Produktcode, Runtime, API, Dependencies, Toolchain und Level-2-Produktnachweise MUST unveraendert bleiben.
- **MDV-013:** Ein Feature-lokaler Validator MUST Cardinality, Profile, Statusachsen und Evidence deterministisch pruefen.
- **MDV-014:** Agent-Guidance und Templates MUST unveraendert bleiben, sofern keine gemeinsame Regel geaendert wird.
- **MDV-015:** Projektstatistik und Series-Closeout MUST nach erfolgreicher Lieferung aktualisiert werden.

### Constitution Requirements

- **CR-001:** Python 3 ist die speichersichere Sprache des feature-lokalen Validators; keine neue Abhaengigkeit wird eingefuehrt.
- **CR-002:** Security Governance ist fuer NIST SSDF, CWE Top 25 und Evidence-Hygiene anwendbar. ASVS, SBOM, VEX, SLSA, OpenSSF Scorecard, AI-SBOM und Regulierung sind mangels Runtime-, Liefer- oder AI-Produktdelta `N/A`.
- **CR-003:** Architecture und iSAQB pruefen bestehende Zuordnungen. STRIDE/CIA/CAPEC, Zero Trust, Cloud, BSI C3A/C5 und neue ADRs sind mangels Architekturdelta `N/A`.
- **CR-004:** A11Y ist fuer alle geaenderten nutzerseitigen Dokumente anwendbar; WCAG 2.2 AA und text-first sind verbindlich.
- **CR-005:** Cross-Platform gilt fuer den Python-Validator; operative Bash-/PowerShell-Skripte werden nicht geaendert.
- **CR-006:** Agent Parity ist `N/A`, solange keine gemeinsame Agent-Regel geaendert wird.
- **CR-007:** Intake Authoring, Review und Sequencing sind bindende Eingabe; Autonomous steuert Lieferung; Parallel Autonomous ist wegen gemeinsamer Writer `N/A`.
- **CR-008:** Documentation Impact ist `UpdateRequired` fuer Mapping, Secure-Development-Index und Feature-Evidence; Home Sync ist nicht erforderlich.
- **CR-009:** AI dient nur als Entwicklungswerkzeug und ist kein Produktbestandteil.

## Success Criteria

- **SC-001:** 12/12 Checklisten und 15/15 mitgeltende Dokumente sind abgedeckt.
- **SC-002:** 8/8 Standard- und 3/3 optionale Intake-Presets sind korrekt getrennt.
- **SC-003:** 100 Prozent der Ledger-Zeilen besitzen beide Statusachsen und alle Pflichtfelder.
- **SC-004:** Positive und negative Validator-Fixtures bestehen deterministisch.
- **SC-005:** Null Produkt-, Runtime-, API-, Dependency-, Toolchain- oder Level-2-Aenderungen.
- **SC-006:** Alle lokalen und Provider-Gates sind gruen, null umsetzbare Review-Threads bleiben.

## Clarifications

- Keine formale Rueckfrage ist erforderlich: Profilgrenzen, Zielgruppe,
  Evidence-Schema, Follow-up-Grenze und Delivery Authority sind eindeutig.

## Assumptions

- Baseline 3.2.0 und 157 IDs bleiben der fachliche Ist-Stand.
- Eine Mapping-Aktualisierung erfordert keine neue Secure-Development-Baseline.
- Historische Evidence wird nicht redaktionell veraendert.
