# Lastenheft: Secure OrderDesk Data & Process Track 04 - Datenschutz und Datenminimierung vertieft

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DPA - Daten- und Prozessanalyse
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Datenschutz und Datenminimierung werden für die ausgewerteten Kunden- und Bestelldaten vertieft. Lernende prüfen jeden Datenbezug auf möglichen Personenbezug (z. B. `ContactName`, Anschrift, `City`, `Country`), begründen Zweckbindung, Aufbewahrung und Löschung, wählen zwischen Aggregation, Pseudonymisierung und Verzicht und dokumentieren die Datenschutzentscheidung auditfähig. Der Datensatz `ALFKI` (Kontakt Maria Anders, Berlin) dient als fiktiver Beispielanker.

**EN:** Data protection and data minimization are deepened for the evaluated customer and order data. Learners check each data reference for possible personal reference (e.g. `ContactName`, address, `City`, `Country`), justify purpose limitation, retention, and deletion, choose between aggregation, pseudonymization, and omission, and document the privacy decision in an audit-ready way. The record `ALFKI` (contact Maria Anders, Berlin) serves as a fictional example anchor.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Welcher Datenbezug ist personenbeziehbar und welche Minimierung ist begründet? |
| AE | mittel | Welche Speicher-, Masking- oder Löschlogik folgt aus der Datenschutzentscheidung? |
| SI | mittel | Welche Aufbewahrungs- oder Betriebsvorgabe beeinflusst die Speicherdauer der Bestelldaten? |
| DV | mittel | Welche Schnittstelle könnte personenbeziehbare Zusatzdaten einschleusen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet kundenspezifische Datenanalyse, Datenschutz, sichere Datenverwaltung und auditfähige Dokumentation der Datenschutzentscheidungen im Handelskontext.

**EN:** The task supports the DPA specialization in year 3. It connects customer-specific data analysis, data protection, secure data management, and audit-ready documentation of privacy decisions in a trading context.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, Datenminimierung, sichere Datenverwaltung, Nachvollziehbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Datenschutz- und Aufbewahrungsdokumentation, Zugangssteuerung nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine fokussierte Spezifikation zum vertieften Datenschutz und zur Datenminimierung in den Auswertungen von Secure OrderDesk. Berücksichtige: die Prüfung jedes Feldes auf möglichen Personenbezug (auch indirekt, z. B. `ContactName` in Verbindung mit `City` und Bestellhistorie), die Zweckbindung je Feld, begründete Aufbewahrungs- und Löschfristen, die Wahl zwischen Aggregation, Pseudonymisierung (z. B. Auswertung über `CustomerID` statt `ContactName`) und bewusstem Verzicht sowie die getrennte Dokumentation, warum ein Feld erhoben, wie lange es gehalten und wann es gelöscht wird. Achte auf Re-Identifikationsrisiken bei kleinen Gruppen (z. B. nur eine Kundenfirma je Stadt). Positive Datenschutzaussagen brauchen einen Nachweis. Nutze `ALFKI` nur als fiktiven Beispielanker.

**EN:** Develop a focused specification for deepened data protection and data minimization in the evaluations of Secure OrderDesk. Consider: checking each field for possible personal reference (also indirect, e.g. `ContactName` combined with `City` and order history), purpose limitation per field, justified retention and deletion periods, the choice between aggregation, pseudonymization (e.g. evaluation via `CustomerID` instead of `ContactName`), and deliberate omission, and the separate documentation of why a field is collected, how long it is kept, and when it is deleted. Watch for re-identification risks in small groups (e.g. only one customer company per city). Positive privacy claims need evidence. Use `ALFKI` only as a fictional example anchor.

## Anforderungen / Requirements

- **R-01:** Jedes Feld ist auf direkten und indirekten Personenbezug geprüft und eingestuft.
- **R-02:** Zweckbindung, Aufbewahrungsfrist und Löschregel sind je Feld begründet dokumentiert.
- **R-03:** Für risikobehaftete Felder ist eine Minimierungsmaßnahme (Aggregation, Pseudonymisierung, Verzicht) gewählt und begründet; Re-Identifikation über kleine Gruppen ist bewertet.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle benannt.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; die Northwind-Daten sind fiktiv, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Auch indirekt personenbeziehbare Felder (Kontaktname, Anschrift, Stadt in Kombination mit Bestellverhalten) als Datenschutzrisiko behandeln.
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
- Erwartete Evidenz: Personenbezugs-Matrix je Feld, Zweckbindungs- und Aufbewahrungstabelle, Minimierungsmaßnahmen mit Begründung, Re-Identifikations-Notiz, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die DPA-Spezialisierung ist klar sichtbar.
- [ ] Direkter und indirekter Personenbezug ist je Feld geprüft und eingestuft.
- [ ] Zweckbindung, Aufbewahrung und Minimierung sind begründet dokumentiert; Re-Identifikation über kleine Gruppen ist bewertet.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_04_Datenschutz-und-Datenminimierung-vertieft.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für vertieften Datenschutz und Datenminimierung in den Auswertungen der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
