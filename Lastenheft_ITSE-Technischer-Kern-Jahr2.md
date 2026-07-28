<!-- intake-authoring:begin -->
# Lastenheft: ITSE-Technischer Kern Jahr 2

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 29, nach Position 28
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** ITSE- und FI-Lernende, Lehrende, Ausbildende und Maintainer ab
dem zweiten Ausbildungsjahr
**Vorausgesetztes Wissen:** abgeschlossener Jahr-1-Retrofit; C#-Grundlagen und
keine vorausgesetzte Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake erstellt den ITSE-Pfad für LF6 bis LF9. Er nutzt die vorhandenen
FI-Reihen als technische Basis und ergänzt nur die berufsspezifische
ITSE-Perspektive.

*This intake builds the ITSE year-2 core by reusing the existing FI learning
series and adding only occupation-specific ITSE applications.*

## 2. Lernfelder und FI-Vergleich / Learning Fields And FI Comparison

- LF6 Serviceanfragen bearbeiten;
- LF7 cyber-physische Systeme ergänzen;
- LF8 Daten systemübergreifend bereitstellen;
- LF9 Netzwerke und Dienste bereitstellen.

FI/AE trägt Software- und Schnittstellenarbeit bei, FI/SI Betrieb und Dienste,
FI/DPA Datenqualität und FI/DV cyber-physische Vernetzung. FI/SI und FI/DV sind
Schwerpunkte, aber nicht die einzigen Vergleichspfade.

## 3. Anforderungen / Requirements

- **IY2-001:** LF6 bis LF9 werden vollständig und spiralcurricular auf Jahr 1
  aufbauend abgedeckt.
- **IY2-002:** Jede Einheit dokumentiert die Wiederverwendung aus allen vier
  FI-Fachrichtungen.
- **IY2-003:** Operations- und Digital-Networking-Tracks werden als primäre
  technische Quellen genutzt.
- **IY2-004:** Application- sowie Data-&-Process-Kompetenzen werden für
  Software, Schnittstellen, Datenqualität und Auswertung berücksichtigt.
- **IY2-005:** LF7 führt die ITSE-Randbedingungen zu Energie und elektrischer
  Sicherheit fort, ohne unbeaufsichtigte Praxis anzuleiten.
- **IY2-006:** C#-Aufgaben betreffen Diagnose, Inventarisierung,
  Konfigurationsprüfung, Simulation, Datenerfassung oder automatisierte Tests.
- **IY2-007:** Jede C#-Aufgabe verlangt eine begrenzte Eigenimplementierung,
  Positiv-/Negativtests und Fehlerreflexion.
- **IY2-008:** Netz-, Dienst- und Datenpfade besitzen Sicherheits-,
  Datenschutz- und Ausfallgrenzen.
- **IY2-009:** Agentenbeitrag und Lernendenentscheidung bleiben getrennt
  nachvollziehbar.
- **IY2-010:** Aufgaben, Lernbegleiter, Unterrichtsleitfaden, Mapping und
  Bewertungsraster werden als ein Dokumentpaket gepflegt.
- **IY2-011:** Gemeinsame FI-Inhalte werden verlinkt oder wiederverwendet,
  nicht kopiert.
- **IY2-012:** Deutsch zuerst, Englisch danach, CEFR B2 und WCAG 2.2 AA
  gelten für alle neuen Inhalte.
- **IY2-013:** Produktcode und Level-1-/Level-2-Repositories bleiben
  unverändert.
- **IY2-014:** Position 30 wird nicht automatisch gestartet.

## 4. Ergebnisartefakte / Expected Artifacts

- technischer ITSE-Jahr-2-Pfad;
- LF6–LF9-Kompetenz- und Aufgabenmatrix;
- FI-Wiederverwendungsnachweis;
- C#-Diagnose- und Testvertrag;
- Sicherheits-, Simulations- und Praxisgrenzen;
- vollständiges Dokumentpaket und Übergabe an Position 30.

## 5. Akzeptanzkriterien / Acceptance Criteria

- **AC-IY2-001:** LF6 bis LF9 besitzen vollständige Aufgaben-, Evidence- und
  Bewertungsnachweise.
- **AC-IY2-002:** Alle vier FI-Fachrichtungen sind pro Lernfeld nachvollziehbar
  bewertet.
- **AC-IY2-003:** Keine kanonische FI-Kompetenz wurde unnötig dupliziert.
- **AC-IY2-004:** C#-Aufgaben enthalten eigene Implementierung und Tests.
- **AC-IY2-005:** Elektrische Praxis- und Agentengrenzen sind eindeutig.
- **AC-IY2-006:** Produktcode und Flottenrepositories sind unverändert.
- **AC-IY2-007:** Position 30 wurde nicht gestartet.

## 6. Nicht-Ziele / Non-Goals

- Keine Jahr-3-Professional-Reihe.
- Keine autonome Hardwaresteuerung.
- Keine Produktimplementierung oder Lernendenlösung.
- Kein Rollout.

<!-- intake-authoring:prompts -->
## 7. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_ITSE-Technischer-Kern-Jahr2.md` as position 29. Verify LF6-LF9 coverage, all-four-FI comparison, SI/DV emphasis without AE/DPA omission, reuse instead of duplication, C# implementation and test proof, electrical-safety and agent boundaries, complete document package, accessibility, and no rollout.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_ITSE-Technischer-Kern-Jahr2.md` as the binding intake for position 29. Create a feature specification for the LF6-LF9 ITSE path, all-four-FI reuse matrix, SI/DV focus, C# diagnostic and test work, evidence, safety and simulation boundaries, and complete learning document package. Preserve IY2-001 through IY2-014 and AC-IY2-001 through AC-IY2-007. Do not change product code, roll out to repositories, or start position 30.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_ITSE-Technischer-Kern-Jahr2.md` with deliveryAuthority=MergeAndSync after position 28 is complete. Implement only accepted Level-0 year-2 materials, mappings, evidence, statistics, order/archive updates, and one non-empty PR. Reuse FI sources without duplication, return to clean synchronized main, and do not start position 30.
```

<!-- intake-authoring:end -->
