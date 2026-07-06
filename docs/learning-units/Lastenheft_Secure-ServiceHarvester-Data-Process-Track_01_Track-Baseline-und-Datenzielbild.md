# Lastenheft: Secure ServiceHarvester Data & Process Track 01 - Track-Baseline und Datenzielbild

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

**DE:** Ausgehend von der v2-Basis des ServiceHarvester wird ein belastbares Datenzielbild für den Data & Process Track erarbeitet. Lernende trennen die gesammelten Rohdaten, die fachlichen Fragen, die geplanten Auswertungen, die Nicht-Ziele und den Schutzbedarf und benennen von Anfang an die Aussagegrenzen der Daten.

**EN:** Starting from the ServiceHarvester v2 base, a robust data target picture for the Data & Process Track is developed. Learners separate the collected raw data, the business questions, the planned evaluations, the non-goals, and the protection need, and name the limits of validity of the data from the start.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Welche Frage soll aus den Daten beantwortet werden und welche Aussagegrenze gilt? |
| AE | mittel | Welche Datenstruktur oder Auswertungsschnittstelle folgt aus dem Datenzielbild? |
| SI | mittel | Welche Betriebs- oder Toolchain-Annahme beeinflusst die Datenerhebung? |
| DV | mittel | Welche Schnittstelle oder Systemgrenze liefert die Rohdaten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet kundenspezifische Prozess- und Datenanalyse, sichere Entwicklung und auditfähige Dokumentation eines Datenzielbilds.

**EN:** The task supports the DPA specialization in year 3. It connects customer-specific process and data analysis, secure development, and audit-ready documentation of a data target picture.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Datenschutz- und Nachweisdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für den Data & Process Track ein fokussiertes Datenzielbild auf Basis der ServiceHarvester-v2-Baseline. Berücksichtige: welche Rohdaten der Dienst bereits sammelt (Maschinen-Snapshots wie Name, Betriebssystem, letzter Kontakt), welche fachlichen Fragen die Daten beantworten sollen, welche Auswertungen geplant sind (Datenqualität, Kennzahlen, Datenschutzsicht, Reporting), welche Nicht-Ziele gelten, welcher Schutzbedarf betroffen ist und welche Aussagegrenzen die Daten von vornherein haben. Halte das Datenzielbild als prüfbare Baseline für die folgenden Track-Einheiten fest.

**EN:** Develop a focused data target picture for the Data & Process Track based on the ServiceHarvester v2 baseline. Consider: which raw data the service already collects (machine snapshots such as name, operating system, last contact), which business questions the data should answer, which evaluations are planned (data quality, metrics, privacy view, reporting), which non-goals apply, which protection need is affected, and which limits of validity the data has from the start. Fix the data target picture as a testable baseline for the following track units.

## Anforderungen / Requirements

- **R-01:** Vorhandene Rohdaten und geplante Auswertungen sind klar und getrennt beschrieben.
- **R-02:** Sicherheits-, Datenschutz-, Betriebs- und Datenannahmen sind getrennt dokumentiert.
- **R-03:** Mindestens zwei fachliche Fragen sind mit benötigten Feldern und Aussagegrenze notiert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift; die C#-Referenz `InventarWorkerService` dient nur als Orientierung.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Gesammelte Snapshots, Importe, Konfiguration, Logs, Abhängigkeiten und Auswertungen als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag des Datenzielbilds bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für dieses Datenzielbild.
- `plan.md` mit Daten-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Rohdaten-Abgrenzung, Fragen-Feld-Matrix, Auswertungsliste, Nicht-Ziele, Schutzbedarf, Aussagegrenzen, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die DPA-Spezialisierung und der Bezug zur v2-Baseline sind klar sichtbar.
- [ ] Fachliche Frage, benötigte Daten, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens zwei fachliche Fragen sind mit Aussagegrenze belegt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein belastbares Datenzielbild des Data & Process Track der EuFPA-Lernreihe Secure ServiceHarvester Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
