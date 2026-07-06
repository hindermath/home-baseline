# Lastenheft: Secure ServiceHarvester Data & Process Track 09 - Test- und Nachweisstrategie für Datenaussagen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DPA - Daten- und Prozessanalyse
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Referenzprojekt / Reference project:** C#-Referenz `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Für Datenaussagen des ServiceHarvester wird eine Test- und Nachweisstrategie entworfen: synthetische Testdaten ohne echte personenbezogene Inhalte, ein bekanntes Vergleichsergebnis (Golden Dataset), Kantenfälle (leer, Lücke, Ausreißer) und reproduzierbare Nachweise, dass eine Kennzahl das berechnet, was sie behauptet. Lernende trennen das Testen von Code vom Nachweis einer Datenaussage.

**EN:** A test and evidence strategy is designed for the ServiceHarvester data claims: synthetic test data without real personal content, a known reference result (golden dataset), edge cases (empty, gap, outlier), and reproducible evidence that a metric computes what it claims. Learners separate testing code from evidencing a data claim.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel bis hoch | Wie schreibt man einen reproduzierbaren Test für eine Aggregationskennzahl? |
| SI | mittel | Wie stellt man eine reproduzierbare Testumgebung ohne echte Daten bereit? |
| DPA | hoch | Womit weist man nach, dass eine Kennzahl das berechnet, was sie behauptet? |
| DV | mittel | Wie testet man Kennzahlen über Schnittstellen- oder Zeitgrenzen hinweg? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung im 3. Lehrjahr. Sie verbindet Verifikation von Datenanalysen, sichere Entwicklung und reproduzierbare Nachweise mit auditfähiger Dokumentation und baut auf der v2-Baseline (Jahr 2) auf.

**EN:** The task supports third-year specialization. It connects verification of data analyses, secure development, and reproducible evidence with audit-ready documentation, building on the v2 baseline (year 2).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Begründung: Der Nachweis, dass eine kundenspezifische Datenanalyse korrekt und reproduzierbar ist, ist Bestandteil von LF 12c; die Testdaten liegen in der angepassten Datenhaltung (LF 5). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Rationale: evidencing that a customer-specific data analysis is correct and reproducible is part of LF 12c; the test data lives in the adapted data storage (LF 5). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für Datenaussagen eine fokussierte Test- und Nachweisspezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: Wähle synthetische Testdaten ohne echte personenbezogene Inhalte, definiere ein Golden Dataset mit bekanntem Sollergebnis, decke Kantenfälle (leerer Datensatz, Erfassungslücke, Ausreißer) ab und halte fest, wie das Ergebnis reproduzierbar erzeugt und geprüft wird. Trenne ausdrücklich den Test der Berechnung vom Nachweis, dass die Kennzahl die zugesicherte Aussage trifft (Bezug zu den Aussagegrenzen aus Einheit 06). Nutze die C#-Referenz `InventarWorkerService` nur als Vergleich; die Lösung bleibt sprachneutral.

**EN:** Prepare a focused test and evidence specification for data claims for the DPA - Data and Process Analysis specialization. Consider: choose synthetic test data without real personal content, define a golden dataset with a known target result, cover edge cases (empty dataset, collection gap, outlier), and record how the result is produced and checked reproducibly. Explicitly separate testing the computation from evidencing that the metric makes its promised statement (relating to the interpretation limits from unit 06). Use the C# reference `InventarWorkerService` only for comparison; the solution stays language-neutral.

## Anforderungen / Requirements

- **R-01:** Testdatenherkunft, Golden Dataset und abgedeckte Kantenfälle sind klar beschrieben.
- **R-02:** Reproduzierbarkeit (fester Datenstand, feste Parameter, wiederholbares Ergebnis) ist getrennt dokumentiert.
- **R-03:** Der Unterschied zwischen Code-Test und Nachweis einer Datenaussage ist ausdrücklich benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Nur synthetische Testdaten, keine echten personenbezogenen Daten; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Testdaten, Konfiguration, Fixtures, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Korrektheits- oder Reproduzierbarkeitsaussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag zu Testfällen, Golden Dataset und Nachweisregeln bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Test-Frameworks dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Test-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Test-, Review- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Testdatenbeschreibung, Golden-Dataset-Tabelle mit Sollergebnis, Kantenfallliste, Reproduzierbarkeitsnotiz, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DPA ist klar sichtbar.
- [ ] Testdaten sind synthetisch und ohne echte personenbezogene Inhalte.
- [ ] Code-Test und Nachweis einer Datenaussage sind getrennt sichtbar und reproduzierbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Test- und Nachweisstrategie für Datenaussagen der EuFPA-Lernreihe Secure ServiceHarvester Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
