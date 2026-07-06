# Lastenheft: Secure ServiceHarvester Data & Process Track 02 - Datenqualität im Harvester

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DPA - Daten- und Prozessanalyse
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenzprojekt / C# reference project:** `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Die Datenqualität der gesammelten Maschinen-Snapshots wird nach klaren Dimensionen bewertet und mit Plausibilitätsregeln geprüft. Lernende messen Vollständigkeit, Aktualität, Genauigkeit, Konsistenz und Eindeutigkeit, dokumentieren Bereinigungsschritte nachvollziehbar und trennen Rohdaten von bereinigten Auswertungsdaten.

**EN:** The data quality of the collected machine snapshots is assessed along clear dimensions and checked with plausibility rules. Learners measure completeness, timeliness, accuracy, consistency, and uniqueness, document cleaning steps traceably, and separate raw data from cleaned evaluation data.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Welche Qualitätsdimension entscheidet über die Belastbarkeit der geplanten Kennzahl? |
| AE | mittel | Welche Validierungs- oder Normalisierungslogik folgt aus den Plausibilitätsregeln? |
| SI | mittel | Welche Betriebsbedingung erzeugt Lücken oder veraltete Snapshots? |
| DV | mittel | Welche Schnittstelle liefert uneinheitliche oder doppelte Werte? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet kundenspezifische Prozess- und Datenanalyse, sichere Datenverarbeitung und auditfähige Dokumentation der Datenqualität.

**EN:** The task supports the DPA specialization in year 3. It connects customer-specific process and data analysis, secure data processing, and audit-ready documentation of data quality.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_02_Datenqualitaet-im-Harvester.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_02_Datenqualitaet-im-Harvester.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Eingabevalidierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Datenschutz- und Nachweisdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine fokussierte Spezifikation zur Bewertung und Sicherung der Datenqualität im ServiceHarvester. Berücksichtige: klare Qualitätsdimensionen (Vollständigkeit, Aktualität, Genauigkeit, Konsistenz, Eindeutigkeit), messbare Qualitätskennzahlen je Dimension, Plausibilitätsregeln für Felder wie Betriebssystem und letzter Kontakt, den Umgang mit fehlenden, veralteten oder doppelten Snapshots sowie die nachvollziehbare Trennung von Rohdaten und bereinigten Auswertungsdaten. Jede Bereinigung muss dokumentiert und reproduzierbar sein.

**EN:** Develop a focused specification for assessing and securing data quality in the ServiceHarvester. Consider: clear quality dimensions (completeness, timeliness, accuracy, consistency, uniqueness), measurable quality metrics per dimension, plausibility rules for fields such as operating system and last contact, the handling of missing, stale, or duplicate snapshots, and the traceable separation of raw data and cleaned evaluation data. Every cleaning step must be documented and reproducible.

## Anforderungen / Requirements

- **R-01:** Die relevanten Qualitätsdimensionen sind benannt und je Dimension mit einer messbaren Kennzahl hinterlegt.
- **R-02:** Plausibilitätsregeln und der Umgang mit Fehl-, Alt- und Dubletten-Werten sind dokumentiert.
- **R-03:** Rohdaten bleiben unverändert; jede Bereinigung ist reproduzierbar und mit Begründung protokolliert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift; die C#-Referenz `InventarWorkerService` dient nur als Orientierung.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Gesammelte Snapshots und Importe als nicht vertrauenswürdig behandeln und an der Vertrauensgrenze validieren.
- Positive Qualitätsaussagen nur mit Nachweis (Test, Messung, Protokoll) treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Die Qualitätsdimensionen, Kennzahlen und Plausibilitätsregeln bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Bibliotheken zur Validierung dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere Eingabevalidierung, keine Bereinigungsprotokolle und keine Datenschutzprüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Datenqualitätsbewertung.
- `plan.md` mit Qualitäts-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Regel-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Qualitätsdimensions-Tabelle mit Kennzahlen, Plausibilitätsregeln, Bereinigungsprotokoll, Roh-/Bereinigt-Trennung, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die DPA-Spezialisierung ist klar sichtbar.
- [ ] Jede Qualitätsdimension hat eine messbare Kennzahl und eine Interpretation.
- [ ] Der Umgang mit fehlenden, veralteten und doppelten Werten ist begründet dokumentiert.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Data-Process-Track_02_Datenqualitaet-im-Harvester.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Bewertung und Sicherung der Datenqualität im ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
