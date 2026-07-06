# Lastenheft: Secure ServiceHarvester Data & Process Track 06 - Aussagegrenzen und Datenunsicherheit

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

**DE:** Aussagegrenzen und Datenunsicherheit der vom ServiceHarvester gesammelten Statusdaten werden ehrlich benannt: Erfassungslücken, Aktualität (Freshness), Stichprobenintervall und Abdeckung (Coverage) fließen in jede Kennzahlaussage ein. Lernende trennen, was die Daten wirklich zeigen, von dem, was man nur vermutet.

**EN:** The interpretation limits and data uncertainty of the status data collected by the ServiceHarvester are named honestly: collection gaps, freshness, sampling interval, and coverage are considered for every metric claim. Learners separate what the data really shows from what is only assumed.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel | Welche Feld- oder Modellentscheidung macht Unsicherheit im Code sichtbar? |
| SI | mittel bis hoch | Welche Betriebs- oder Sammelbedingung erzeugt Erfassungslücken? |
| DPA | hoch | Welche Aussagegrenze und welche Datenunsicherheit sind für diese Kennzahl relevant? |
| DV | mittel | Welche Kommunikations- oder Verfügbarkeitslücke verzerrt die gesammelten Daten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung im 3. Lehrjahr. Sie verbindet daten- und prozessorientierte Analyse, sichere Entwicklung und ehrliche Interpretation mit auditfähiger Dokumentation und baut auf der v2-Baseline (Jahr 2) auf.

**EN:** The task supports third-year specialization. It connects data- and process-oriented analysis, secure development, and honest interpretation with audit-ready documentation, building on the v2 baseline (year 2).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Begründung: Aussagegrenzen sind der Kern einer belastbaren kundenspezifischen Datenanalyse; die Datenhaltung des Harvesters (LF 5) liefert Aktualität und Lücken. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Rationale: interpretation limits are the core of a robust customer-specific data analysis; the harvester's data storage (LF 5) provides freshness and gaps. Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Aussagegrenzen der ServiceHarvester-Daten eine fokussierte Spezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: Aus einem Intervall-Sammler entstehen zwangsläufig Erfassungslücken; `last_contact` altert; nicht jede Maschine meldet sich zuverlässig. Beschreibe je Kennzahl, welche Abdeckung, welche Aktualität und welche Unsicherheit gelten und formuliere für jede Aussage eine ausdrückliche Aussagegrenze („Diese Zahl gilt nur für Maschinen, die sich innerhalb von 24 h gemeldet haben"). Nutze die C#-Referenz `InventarWorkerService` nur als Vergleich; die Lösung bleibt sprachneutral.

**EN:** Prepare a focused specification for the interpretation limits of the ServiceHarvester data for the DPA - Data and Process Analysis specialization. Consider: an interval collector inevitably produces collection gaps; `last_contact` ages; not every machine reports reliably. Describe per metric which coverage, freshness, and uncertainty apply, and formulate an explicit limit of validity for each claim ("This number only holds for machines that reported within 24 h"). Use the C# reference `InventarWorkerService` only for comparison; the solution stays language-neutral.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang der betrachteten Kennzahlen und ihrer Aussagegrenzen ist klar beschrieben.
- **R-02:** Datenunsicherheit (Lücken, Aktualität, Intervall, Abdeckung) ist je Kennzahl getrennt dokumentiert.
- **R-03:** Zu jeder Kennzahl gehört eine explizit formulierte Aussagegrenze und ein Nachweispfad.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Gesammelte Statusdaten, Zeitstempel, Importe, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Aussagegrenzen-Behauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag zu Kennzahlen und Aussagegrenzen bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks für Zeit-, Datums- und Aggregationslogik dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Analyse-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Kennzahl-/Aussagegrenzen-Tabelle, Abdeckungs- und Aktualitätsangaben, Unsicherheits-Notiz je Kennzahl, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DPA ist klar sichtbar.
- [ ] Jede Kennzahl trägt eine ausdrückliche Aussagegrenze mit Nachweispfad.
- [ ] Datenunsicherheit ist getrennt von der Kennzahl selbst dokumentiert.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Aussagegrenzen und Datenunsicherheit der EuFPA-Lernreihe Secure ServiceHarvester Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
