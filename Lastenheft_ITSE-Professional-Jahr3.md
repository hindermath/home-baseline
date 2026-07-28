<!-- intake-authoring:begin -->
# Lastenheft: ITSE Professional Jahr 3

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 30, nach Position 29
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** ITSE-Lernende, FI-Vergleichsgruppen, Lehrende, Ausbildende und
Maintainer ab dem dritten Ausbildungsjahr
**Vorausgesetztes Wissen:** abgeschlossener technischer Jahr-2-Kern; keine
Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake erstellt die eigenständige ITSE-Professional-Reihe für LF10,
LF11 und LF12. Gemeinsame Kompetenzen mit FI/SI und FI/DV werden
wiederverwendet; Energieversorgung und Instandhaltung bleiben ITSE-spezifisch.

*This intake creates the ITSE year-3 professional series while reusing shared
FI/SI and FI/DV competencies and preserving ITSE-specific energy and
maintenance responsibilities.*

## 2. Acht Einheiten / Eight Units

1. Kundenauftrag und Systemaufnahme;
2. Energiebedarf und technische Dokumentation;
3. Energieversorgung und Schutzkonzept;
4. USV, Redundanz und elektromagnetische Verträglichkeit;
5. Betrieb und Sicherheit vernetzter Systeme;
6. C#-gestützte Diagnose und Protokollauswertung;
7. Instandhaltung und kontrollierte Fehlerbehebung;
8. Übergabe, Unterweisung und Abschlussreflexion.

Eine unterbrechungsfreie Stromversorgung (USV) hält ein IT-System bei einem
kurzen Stromausfall begrenzt in Betrieb. Elektromagnetische Verträglichkeit
(EMV) beschreibt, dass Geräte sich nicht unzulässig elektromagnetisch stören.

## 3. Anforderungen / Requirements

- **IP3-001:** Die acht Einheiten decken LF10, LF11 und LF12 vollständig ab.
- **IP3-002:** LF11 wird gegen die gemeinsamen Kompetenzen von FI/SI und FI/DV
  geprüft und kanonisch wiederverwendet.
- **IP3-003:** FI/AE und FI/DPA werden bei Diagnosewerkzeugen,
  Schnittstellen, Datenqualität und Auswertung berücksichtigt.
- **IP3-004:** LF10 enthält Anforderungsanalyse, Energiebedarf,
  Dimensionierungsplanung, Schutzkonzept, USV, Redundanz, EMV und
  Dokumentation.
- **IP3-005:** LF12 enthält Planung, Kalkulation, Qualitätssicherung,
  Instandhaltung, Fehleranalyse, Kundenübergabe und Reflexion.
- **IP3-006:** C#-Arbeit dient Diagnose, Protokollauswertung,
  Inventarisierung, Simulation oder Testautomatisierung.
- **IP3-007:** KI-Agenten führen keine Schalt-, Mess-, Speise- oder
  Freigabehandlung an elektrischen Anlagen aus.
- **IP3-008:** Reale Labor- oder Betriebsnachweise benötigen
  `SupervisedLab` oder `TrainingCompany` und menschliche Freigabe.
- **IP3-009:** Simulierte Messdaten sind dauerhaft als Simulation markiert.
- **IP3-010:** Jede Einheit besitzt Aufgaben-Lastenheft, Lernbegleiter,
  Kompetenzmapping, Evidence, Bewertungsraster und nächsten Schritt.
- **IP3-011:** Ein Unterrichtsleitfaden erklärt Aufsicht, Ausstattung,
  Gefährdungsgrenzen und Alternativen bei fehlender Laborumgebung.
- **IP3-012:** Die Reihe enthält keine Prüfungsgarantie oder Behauptung einer
  Elektrofachkraftqualifikation.
- **IP3-013:** Deutsch zuerst, Englisch danach, CEFR B2, Ersterklärung und
  WCAG 2.2 AA gelten.
- **IP3-014:** Produktcode und Flottenrepositories bleiben unverändert.
- **IP3-015:** Position 31 wird nicht automatisch gestartet.

## 4. Ergebnisartefakte / Expected Artifacts

- ITSE-Professional-Reihenwurzel;
- acht Aufgaben-Lastenhefte und acht Lernbegleiter;
- Unterrichtsleitfaden;
- LF10–LF12- und FI-Abgrenzungsmatrix;
- C#-Diagnose- und Simulationsprofil;
- Sicherheits-, Evidence- und Bewertungsvertrag;
- Abschluss- und Übergabenachweis.

## 5. Akzeptanzkriterien / Acceptance Criteria

- **AC-IP3-001:** LF10 bis LF12 sind ohne Kompetenzlücke abgedeckt.
- **AC-IP3-002:** Gemeinsame FI/SI-/FI/DV-Kompetenzen sind nicht dupliziert.
- **AC-IP3-003:** Alle acht Aufgaben und Lernbegleiter stimmen paarweise
  überein.
- **AC-IP3-004:** Reale, simulierte und agentisch unterstützte Evidence ist
  eindeutig getrennt.
- **AC-IP3-005:** C#-Diagnoseaufgaben enthalten Tests und Aussagegrenzen.
- **AC-IP3-006:** Sicherheits-, Sprach- und Accessibility-Gates bestehen.
- **AC-IP3-007:** Position 31 wurde nicht gestartet.

## 6. Nicht-Ziele / Non-Goals

- Keine autonome Hardware- oder Energieanlagensteuerung.
- Keine unbeaufsichtigte Elektroarbeit.
- Keine Referenzlösung für Lernendenaufgaben.
- Keine Produkt- oder Flottenänderung.

<!-- intake-authoring:prompts -->
## 7. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_ITSE-Professional-Jahr3.md` as position 30. Verify exact eight-unit scope, complete LF10-LF12 coverage, FI/SI and FI/DV reuse, AE/DPA contributions, ITSE-specific energy and maintenance work, C# diagnosis, execution contexts, electrical safety, full document package, accessibility, and no rollout.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_ITSE-Professional-Jahr3.md` as the binding intake for position 30. Create a feature specification for the eight-unit ITSE professional series, LF10-LF12 coverage, FI reuse and differentiation, C# diagnostic proof, supervised-practice boundaries, complete document package, evidence, assessment, and teaching guidance. Preserve IP3-001 through IP3-015 and AC-IP3-001 through AC-IP3-007. Do not modify product code, roll out to repositories, or start position 31.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_ITSE-Professional-Jahr3.md` with deliveryAuthority=MergeAndSync after position 29 is complete. Implement only accepted Level-0 ITSE year-3 materials, mappings, evidence, statistics, archive/order updates, and one non-empty PR. Preserve FI canonical content, return to clean synchronized main, and do not start position 31.
```

<!-- intake-authoring:end -->
