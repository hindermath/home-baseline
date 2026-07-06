# Lastenheft: Secure ServiceHarvester Data & Process Track 04 - Datenschutz und Datenminimierung vertieft

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

**DE:** Datenschutz und Datenminimierung werden für die gesammelten und ausgewerteten Daten vertieft. Lernende prüfen jeden Datenbezug auf möglichen Personenbezug, begründen Zweckbindung, Aufbewahrung und Löschung, wählen zwischen Aggregation, Pseudonymisierung und Verzicht und dokumentieren die Datenschutzentscheidung auditfähig.

**EN:** Data protection and data minimization are deepened for the collected and evaluated data. Learners check each data reference for possible personal reference, justify purpose limitation, retention, and deletion, choose between aggregation, pseudonymization, and omission, and document the privacy decision in an audit-ready way.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Welcher Datenbezug ist personenbeziehbar und welche Minimierung ist begründet? |
| AE | mittel | Welche Speicher-, Masking- oder Löschlogik folgt aus der Datenschutzentscheidung? |
| SI | mittel | Welche Aufbewahrungs- oder Betriebsvorgabe beeinflusst die Speicherdauer? |
| DV | mittel | Welche Schnittstelle könnte personenbeziehbare Zusatzdaten einschleusen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet kundenspezifische Datenanalyse, Datenschutz, sichere Datenverwaltung und auditfähige Dokumentation der Datenschutzentscheidungen.

**EN:** The task supports the DPA specialization in year 3. It connects customer-specific data analysis, data protection, secure data management, and audit-ready documentation of privacy decisions.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, Datenminimierung, sichere Datenverwaltung, Nachvollziehbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Datenschutz- und Aufbewahrungsdokumentation, Zugangssteuerung nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine fokussierte Spezifikation zum vertieften Datenschutz und zur Datenminimierung im ServiceHarvester. Berücksichtige: die Prüfung jedes Feldes auf möglichen Personenbezug (auch indirekt, z. B. Maschinenname mit Klarnamen), die Zweckbindung je Feld, begründete Aufbewahrungs- und Löschfristen, die Wahl zwischen Aggregation, Pseudonymisierung und bewusstem Verzicht sowie die getrennte Dokumentation, warum ein Feld erhoben, wie lange es gehalten und wann es gelöscht wird. Positive Datenschutzaussagen brauchen einen Nachweis.

**EN:** Develop a focused specification for deepened data protection and data minimization in the ServiceHarvester. Consider: checking each field for possible personal reference (also indirect, e.g. a machine name containing a real name), purpose limitation per field, justified retention and deletion periods, the choice between aggregation, pseudonymization, and deliberate omission, and the separate documentation of why a field is collected, how long it is kept, and when it is deleted. Positive privacy claims need evidence.

## Anforderungen / Requirements

- **R-01:** Jedes Feld ist auf direkten und indirekten Personenbezug geprüft und eingestuft.
- **R-02:** Zweckbindung, Aufbewahrungsfrist und Löschregel sind je Feld begründet dokumentiert.
- **R-03:** Für risikobehaftete Felder ist eine Minimierungsmaßnahme (Aggregation, Pseudonymisierung, Verzicht) gewählt und begründet.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift; die C#-Referenz `InventarWorkerService` dient nur als Orientierung.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Auch indirekt personenbeziehbare Felder (Hostname, Kennung, Standort) als Datenschutzrisiko behandeln.
- Positive Aussagen zu Anonymität oder Pseudonymität nur mit nachvollziehbarem Verfahren treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Datenschutzeinstufung, Zweckbindung und Löschregeln bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Bibliotheken zur Maskierung oder Pseudonymisierung dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine Datenschutzprüfung, keine Löschumsetzung und keine Zugriffskontrolle.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für Datenschutz und Datenminimierung.
- `plan.md` mit Datenschutz-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Prüf-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Personenbezugs-Matrix je Feld, Zweckbindungs- und Aufbewahrungstabelle, Minimierungsmaßnahmen mit Begründung, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die DPA-Spezialisierung ist klar sichtbar.
- [ ] Direkter und indirekter Personenbezug ist je Feld geprüft und eingestuft.
- [ ] Zweckbindung, Aufbewahrung und Minimierung sind begründet dokumentiert.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für vertieften Datenschutz und Datenminimierung im ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
