<!-- intake-authoring:begin -->
# Lastenheft: ITSE-Lernreihen-Gap-Audit

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 26, nach Position 25
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** IT-System-Elektroniker*innen, Fachinformatiker*innen, Lehrende,
Ausbildende, Maintainer und Reviewer ab dem ersten Ausbildungsjahr
**Vorausgesetztes Wissen:** keine Spec-Kit-Erfahrung; technische Fachbegriffe
werden beim ersten Auftreten erklärt

## 1. Zweck / Purpose

Dieser Lauf prüft ohne fachliche Korrekturen, wie vollständig und konsistent
IT-System-Elektroniker*innen (ITSE) bislang in den Lernreihen berücksichtigt
werden. Er vergleicht die vorhandenen ITSE-Pfade vorrangig mit den vier
Fachinformatiker-Fachrichtungen und ergänzend mit KITSM und KDM.

*This read-only audit compares the existing ITSE learning paths primarily with
all four IT-specialist tracks and secondarily with the commercial IT
occupations.*

## 2. Verbindliche Quellen / Binding Sources

- KMK-Rahmenlehrplan für Fachinformatiker*innen und
  IT-System-Elektroniker*innen, Beschluss vom 13.12.2019;
- IT-System-Elektroniker-Ausbildungsverordnung vom 28.02.2020;
- Ausbildungsrahmenplan und Prüfungsbereiche der ITSE-Ausbildung;
- BIBB-Umsetzungshilfe für IT-System-Elektroniker*innen;
- vorhandener Lernreihen-Blueprint, Register, Lernfeld-Mapping und
  Secure-Trader-Berufsmappings.

Amtliche Quellen haben bei Widersprüchen Vorrang. Das Audit ersetzt weder
Ausbildungsordnung, Berufsschule, betriebliche Ausbildung noch
Prüfungsvorbereitung.

## 3. Vergleichsmodell / Comparison Model

Das Audit prüft ITSE gegen:

- FI/AE für Software, Schnittstellen und automatisierte Tests;
- FI/SI für Installation, Dienste, Betrieb und Fehleranalyse;
- FI/DPA für Datenqualität, Auswertung und Aussagegrenzen;
- FI/DV für cyber-physische Systeme und Vernetzung;
- KITSM und KDM für Kundenauftrag, Beschaffung, Wirtschaftlichkeit und
  Übergabe.

Gemeinsame Kompetenzen werden als Wiederverwendungskandidaten erfasst.
Berufsspezifische ITSE-Anforderungen werden getrennt ausgewiesen.

## 4. Anforderungen / Requirements

- **IGA-001:** Das Audit inventarisiert alle ITSE-relevanten Aufgaben,
  Lernbegleiter, Unterrichtsleitfäden, Mappings, Reihenwurzeln und Rollouts.
- **IGA-002:** LF1 bis LF12 und alle ITSE-Prüfungsbereiche werden vollständig
  gegen die amtlichen Quellen geprüft.
- **IGA-003:** Die Jahreszuordnung LF1–LF5, LF6–LF9 und LF10–LF12 wird
  ausdrücklich geprüft.
- **IGA-004:** Jede gemeinsame FI-/ITSE-Kompetenz erhält mindestens eine
  belegte kanonische Lernquelle oder ein Finding.
- **IGA-005:** Der Vergleich umfasst alle vier FI-Fachrichtungen und darf nicht
  auf FI/SI und FI/DV verkürzt werden.
- **IGA-006:** LF11 wird besonders gegen die SI-/DV-Kompetenzen zu Betrieb und
  Sicherheit vernetzter Systeme geprüft.
- **IGA-007:** Energieversorgung, elektrische Betriebssicherheit und
  Instandhaltung werden als ITSE-spezifische Kompetenzbereiche bewertet.
- **IGA-008:** Reine Rollenhinweise ohne Aufgabe, Eigenleistung, Evidence und
  Bewertung gelten nicht als vollständige Integration.
- **IGA-009:** Agentische Unterstützung, Simulation, beaufsichtigte Praxis und
  betriebliche Evidence werden getrennt bewertet.
- **IGA-010:** Simulierte oder agentisch erzeugte Werte dürfen nicht als reale
  Mess- oder Freigabenachweise gelten.
- **IGA-011:** Sprache, Ersterklärung, CEFR B2, textorientierte Zugänglichkeit
  und WCAG 2.2 AA werden geprüft.
- **IGA-012:** Das Audit ändert keine Lernmaterialien, Produktdateien oder
  Flottenrepositories.
- **IGA-013:** Findings erhalten stabile IDs, Schweregrad, Evidence, Owner,
  betroffene Reihen und Re-Evaluation-Trigger.
- **IGA-014:** Position 27 wird nicht automatisch gestartet.

## 5. Ergebnisartefakte / Expected Artifacts

- vollständiges ITSE-Artefaktinventar;
- LF1–LF12- und Prüfungsbereichsmatrix;
- FI-/ITSE-Wiederverwendungs- und Abgrenzungsmatrix;
- KDM-/KITSM-Ergänzungsmatrix;
- Gap-, Duplikations- und Widerspruchsliste;
- Agenten-, Simulations- und Praxisgrenzen;
- priorisierte Handoffs für Position 27.

## 6. Akzeptanzkriterien / Acceptance Criteria

- **AC-IGA-001:** Jede ITSE-Kompetenz ist einer amtlichen Quelle und mindestens
  einem vorhandenen Artefakt oder Finding zugeordnet.
- **AC-IGA-002:** Alle vier FI-Fachrichtungen sind einzeln im Vergleich
  nachgewiesen.
- **AC-IGA-003:** Gemeinsame und ITSE-spezifische Kompetenzen sind eindeutig
  getrennt.
- **AC-IGA-004:** Es verbleibt keine unbemerkte Jahres-, Rollen- oder
  Evidence-Mehrdeutigkeit.
- **AC-IGA-005:** Das Audit enthält keine Lernmaterial- oder
  Produktcodeänderung.
- **AC-IGA-006:** Alle Critical-/High-Befunde besitzen einen expliziten
  Blocker- oder Follow-up-Pfad.
- **AC-IGA-007:** Position 27 wurde nicht gestartet.

## 7. Nicht-Ziele / Non-Goals

- Keine Erstellung oder Korrektur von Lernmaterialien.
- Keine Durchführung elektrischer Arbeiten oder Messungen.
- Keine Prüfungsgarantie oder Elektrofachkraftqualifikation.
- Kein neues Repository, Produktfeature oder Preset.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_ITSE-Lernreihen-Gap-Audit.md` as position 26. Verify binding official ITSE sources, complete LF1-LF12 and examination-area coverage, comparison with all four FI tracks, secondary KDM/KITSM comparison, year allocation, agent/simulation/supervised-practice boundaries, evidence rules, accessibility, read-only scope, and no automatic position-27 start.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_ITSE-Lernreihen-Gap-Audit.md` as the binding intake for position 26. Create a read-only audit specification covering the complete ITSE inventory, official curriculum and regulation, all four FI comparisons, secondary commercial comparison, LF1-LF12, examination areas, evidence and safety boundaries, findings, and position-27 handoff. Preserve IGA-001 through IGA-014 and AC-IGA-001 through AC-IGA-007. Do not change learning materials, product code, fleet repositories, or start position 27.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_ITSE-Lernreihen-Gap-Audit.md` with deliveryAuthority=MergeAndSync after position 25 is complete. Perform only the read-only audit, feature evidence, statistics, archive/order updates, and one non-empty delivery PR. Return to clean synchronized main and do not remediate findings or start position 27.
```

<!-- intake-authoring:end -->
