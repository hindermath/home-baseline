# Lastenheft: Secure OrderDesk Data & Process Track 08 - Prozessfeedback und Verbesserung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader (fiktive Handelsfirma / fictional trading company)
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA (Schwerpunkt)
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Erkenntnisse aus den Secure-OrderDesk-Handelsdaten werden in konkrete Verbesserungsmaßnahmen für den Bestell- und Datenerfassungsprozess übersetzt. Lernende bilden einen Regelkreis mit vorab formulierter Wirkungshypothese, benannter Verantwortlichkeit und Follow-up und lassen das Feedback ehrlich zum Prozess zurückfließen (z. B. „viele Bestellungen ohne Versanddatum → Erfassungsprozess prüfen").

**EN:** Insights from the Secure OrderDesk trading data are translated into concrete improvement measures for the ordering and data-capture process. Learners build a feedback loop with a pre-formulated effect hypothesis, a named responsibility, and follow-up, and let the feedback flow back into the process honestly (e.g., "many orders without a shipping date → check the capture process").

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel | Welche Codeänderung folgt aus einer Verbesserungsmaßnahme und wie wird sie getestet? |
| SI | mittel bis hoch | Welche Betriebs- oder Konfigurationsmaßnahme verbessert die Datenqualität der Bestellerfassung? |
| DPA | hoch | Wie wird aus einer Kennzahl über die geprüfte Ursache eine wirksame Maßnahme? |
| DV | mittel | Welche Schnittstellen- oder Importmaßnahme schließt eine wiederkehrende Datenlücke? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet Prozessanalyse der Handelsdomäne, sichere Entwicklung und wirksame Verbesserung mit auditfähiger Dokumentation und baut auf der v2-Baseline (Jahr 2) auf.

**EN:** The task supports the DPA specialization in year 3. It connects process analysis of the trading domain, secure development, and effective improvement with audit-ready documentation, building on the v2 baseline (year 2).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"): Der Data & Process Track trägt **LF 10c, LF 11c, LF 12c** (berührt LF 5, LF 6). Für diese Einheit ist **LF 11c („Prozesse analysieren und gestalten")** primär; berührt LF 6 („Serviceanfragen bearbeiten"). Begründung: Aus Datenerkenntnissen einen Bestellprozess gezielt zu gestalten ist der Kern von LF 11c; Verbesserungen wirken auf die Bearbeitung von Kunden- und Serviceanfragen (LF 6) zurück. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_08_Prozessfeedback-und-Verbesserung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"): the Data & Process Track carries **LF 10c, LF 11c, LF 12c** (touches LF 5, LF 6). For this unit **LF 11c ("Prozesse analysieren und gestalten")** is primary; touched LF 6 ("Serviceanfragen bearbeiten"). Rationale: shaping an ordering process deliberately from data insights is the core of LF 11c; improvements feed back into handling customer and service requests (LF 6). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_08_Prozessfeedback-und-Verbesserung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für das Prozessfeedback im Handelskontext eine fokussierte Spezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: Prüfe zuerst die wahrscheinliche Ursache (Aufbau aus Einheit 06 und 07), formuliere vor der Umsetzung eine Wirkungshypothese („wenn wir X ändern, erwarten wir Y"), priorisiere Maßnahmen nach Wirkung und Aufwand, weise Verantwortlichkeit zu und lege einen Follow-up-Termin mit passender Aussagegrenze fest. Auch eine Maßnahme, die nicht gewirkt hat, wird ehrlich dokumentiert. Stütze die Auswertung auf die Northwind-Datenbasis inkl. `ALFKI`; die Lösung bleibt sprachneutral.

**EN:** Prepare a focused specification for process feedback in the trading context for the DPA - Data and Process Analysis specialization. Consider: first check the likely cause (building on units 06 and 07), formulate an effect hypothesis before implementation ("if we change X, we expect Y"), prioritize measures by effect and effort, assign responsibility, and set a follow-up date with a matching limit of validity. A measure that did not work is also documented honestly. Base the evaluation on the Northwind data base incl. `ALFKI`; the solution stays language-neutral.

## Anforderungen / Requirements

- **R-01:** Der Weg von Kennzahl über geprüfte Ursache zur Maßnahme ist klar beschrieben.
- **R-02:** Je Maßnahme sind Wirkungshypothese, Verantwortlichkeit und Follow-up-Termin getrennt dokumentiert.
- **R-03:** Test-, Review- oder Evidenzpfade für die Wirkungsmessung sind benannt; die Northwind-Datenbasis inkl. `ALFKI` ist als Quelle benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten verwenden; die Northwind-Daten inkl. `ALFKI` und alle Erweiterungen sind fiktiv; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Eingaben, Bestellungen, Konfiguration, Logs, Abhängigkeiten und Auswertungen als mögliche Vertrauensgrenzen prüfen; nur benötigte Felder auswerten (Datenminimierung).
- Positive Wirkungsaussagen nur mit Nachweis treffen; Follow-up-Ergebnisse nicht schönen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag zu Maßnahmen, Wirkungshypothese und Follow-up bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Werkzeuge zur Auswertung dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, SQL-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Analyse-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Maßnahmentabelle mit Wirkungshypothese, Verantwortlichkeit, Priorität und Follow-up-Termin, Regelkreis-Skizze, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DPA ist klar sichtbar.
- [ ] Jede Maßnahme trägt eine vorab formulierte Wirkungshypothese und einen Follow-up-Termin.
- [ ] Verantwortlichkeit und geprüfte Ursache sind je Maßnahme benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_08_Prozessfeedback-und-Verbesserung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für das Prozessfeedback und die Verbesserung der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) im Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
