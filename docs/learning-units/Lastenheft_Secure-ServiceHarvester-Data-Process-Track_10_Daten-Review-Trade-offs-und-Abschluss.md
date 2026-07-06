# Lastenheft: Secure ServiceHarvester Data & Process Track 10 - Daten-Review, Trade-offs und Abschluss

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

**DE:** Datenqualität, Kennzahlen, Aussagegrenzen, Anomalien, Prozessfeedback und Nachweise des gesamten Data & Process Track werden in einem Abschluss-Review zusammengeführt. Lernende benennen die zentralen Trade-offs (z. B. Aktualität gegen Last, Präzision gegen Trefferquote, Datenminimierung gegen Aussagekraft), dokumentieren Restrisiken und geben eine begründete Handlungsempfehlung.

**EN:** Data quality, metrics, interpretation limits, anomalies, process feedback, and evidence of the entire Data & Process Track are brought together in a closing review. Learners name the central trade-offs (e.g., freshness versus load, precision versus recall, data minimization versus expressiveness), document residual risks, and give a justified recommendation for action.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel | Welche Trade-off-Entscheidung schlägt sich später im Code oder Datenmodell nieder? |
| SI | mittel bis hoch | Welcher Betriebs-Trade-off (Last, Intervall, Speicher) ist zu benennen? |
| DPA | hoch | Welche Trade-offs, Restrisiken und Handlungsempfehlungen ergeben sich aus dem Track? |
| DV | mittel | Welcher Schnittstellen- oder Verfügbarkeits-Trade-off bleibt offen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung im 3. Lehrjahr. Sie verbindet Abschlussbewertung, sichere Entwicklung und begründete Handlungsempfehlung mit auditfähiger Dokumentation und schließt den auf der v2-Baseline (Jahr 2) aufbauenden Track ab.

**EN:** The task supports third-year specialization. It connects closing assessment, secure development, and a justified recommendation for action with audit-ready documentation and closes the track built on the v2 baseline (year 2).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 6 („Serviceanfragen bearbeiten"). Begründung: Das Abschluss-Review führt die kundenspezifische Prozess- und Datenanalyse mit Empfehlung zusammen (LF 12c) und wirkt auf die Serviceanfragenbearbeitung (LF 6) zurück. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_10_Daten-Review-Trade-offs-und-Abschluss.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 6 ("Serviceanfragen bearbeiten"). Rationale: the closing review brings together the customer-specific process and data analysis with a recommendation (LF 12c) and feeds back into service-request handling (LF 6). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_10_Daten-Review-Trade-offs-und-Abschluss.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08, CL_10, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für das daten- und prozessorientierte Abschluss-Review eine fokussierte Spezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: Fasse die Ergebnisse der Einheiten 06 bis 09 zusammen, benenne die zentralen Trade-offs mit Begründung, dokumentiere Restrisiken mit Eintritts- und Wirkungseinschätzung und leite eine priorisierte, begründete Handlungsempfehlung ab. Jede positive Aussage zu Qualität, Sicherheit oder Aussagekraft braucht einen Nachweispfad. Nutze die C#-Referenz `InventarWorkerService` nur als Vergleich; die Lösung bleibt sprachneutral.

**EN:** Prepare a focused specification for the data- and process-oriented closing review for the DPA - Data and Process Analysis specialization. Consider: summarize the results of units 06 to 09, name the central trade-offs with justification, document residual risks with an occurrence and impact estimate, and derive a prioritized, justified recommendation for action. Every positive claim about quality, security, or expressiveness needs an evidence path. Use the C# reference `InventarWorkerService` only for comparison; the solution stays language-neutral.

## Anforderungen / Requirements

- **R-01:** Das Abschlussbild aus Datenqualität, Kennzahlen, Aussagegrenzen, Anomalien und Feedback ist klar zusammengeführt.
- **R-02:** Trade-offs, Restrisiken und Handlungsempfehlung sind getrennt und begründet dokumentiert.
- **R-03:** Test-, Review- oder Evidenzpfade für jede zentrale Aussage sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Eingaben, Dateien, Konfiguration, Logs, Abhängigkeiten und Auswertungen als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag zu Abschlussbericht, Trade-offs und Handlungsempfehlung bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Werkzeuge zur Auswertung oder Darstellung dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Analyse-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Abschlussbericht, Trade-off-Tabelle, Restrisikoliste mit Eintritt/Wirkung, priorisierte Handlungsempfehlung, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DPA ist klar sichtbar.
- [ ] Trade-offs, Restrisiken und Handlungsempfehlung sind getrennt und begründet sichtbar.
- [ ] Jede zentrale Aussage trägt einen Nachweispfad.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Data-Process-Track_10_Daten-Review-Trade-offs-und-Abschluss.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für das Daten-Review, die Trade-offs und den Abschluss der EuFPA-Lernreihe Secure ServiceHarvester Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
