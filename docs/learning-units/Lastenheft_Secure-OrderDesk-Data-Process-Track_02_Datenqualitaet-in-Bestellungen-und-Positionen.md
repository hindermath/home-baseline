# Lastenheft: Secure OrderDesk Data & Process Track 02 - Datenqualität in Bestellungen und Positionen

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

**DE:** Die Datenqualität der Bestellungen (`Orders`) und Bestellpositionen (`Order Details`) wird nach klaren Dimensionen bewertet und mit Plausibilitätsregeln geprüft. Lernende messen Vollständigkeit, Aktualität, Genauigkeit, Konsistenz und Eindeutigkeit, dokumentieren Bereinigungsschritte nachvollziehbar und trennen Rohdaten von bereinigten Auswertungsdaten. Sie stützen die Prüfung auf die Northwind-Datenbasis inkl. `ALFKI`.

**EN:** The data quality of the orders (`Orders`) and order line items (`Order Details`) is assessed along clear dimensions and checked with plausibility rules. Learners measure completeness, timeliness, accuracy, consistency, and uniqueness, document cleaning steps traceably, and separate raw data from cleaned evaluation data. They base the check on the Northwind data base incl. `ALFKI`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Welche Qualitätsdimension entscheidet über die Belastbarkeit der geplanten Umsatz-Kennzahl? |
| AE | mittel | Welche Validierungs- oder Normalisierungslogik folgt aus den Plausibilitätsregeln für Positionen? |
| SI | mittel | Welche Datenbank- oder Importbedingung erzeugt Lücken, Dubletten oder verwaiste Positionen? |
| DV | mittel | Welche Schnittstelle liefert uneinheitliche oder unvollständige Bestelldaten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet kundenspezifische Prozess- und Datenanalyse der Handelsdaten, sichere Datenverarbeitung und auditfähige Dokumentation der Datenqualität.

**EN:** The task supports the DPA specialization in year 3. It connects customer-specific process and data analysis of the trading data, secure data processing, and audit-ready documentation of data quality.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_02_Datenqualitaet-in-Bestellungen-und-Positionen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_02_Datenqualitaet-in-Bestellungen-und-Positionen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Eingabevalidierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Datenschutz- und Nachweisdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine fokussierte Spezifikation zur Bewertung und Sicherung der Datenqualität in Bestellungen und Positionen. Berücksichtige: klare Qualitätsdimensionen (Vollständigkeit, Aktualität, Genauigkeit, Konsistenz, Eindeutigkeit), messbare Qualitätskennzahlen je Dimension, Plausibilitätsregeln für Felder wie `OrderDate`, `UnitPrice`, `Quantity` und `Discount` (z. B. keine negative Menge, Rabatt zwischen 0 und 1, Preis größer 0), den Umgang mit fehlenden, fehlerhaften, veralteten oder doppelten Datensätzen sowie mit verwaisten Positionen ohne gültige Bestellung oder ohne gültiges Produkt, und die nachvollziehbare Trennung von Rohdaten und bereinigten Auswertungsdaten. Jede Bereinigung muss dokumentiert und reproduzierbar sein. Nutze `ALFKI` nur als fiktiven Beispielanker.

**EN:** Develop a focused specification for assessing and securing data quality in orders and line items. Consider: clear quality dimensions (completeness, timeliness, accuracy, consistency, uniqueness), measurable quality metrics per dimension, plausibility rules for fields such as `OrderDate`, `UnitPrice`, `Quantity`, and `Discount` (e.g. no negative quantity, discount between 0 and 1, price greater than 0), the handling of missing, faulty, stale, or duplicate records and of orphan line items without a valid order or product, and the traceable separation of raw data and cleaned evaluation data. Every cleaning step must be documented and reproducible. Use `ALFKI` only as a fictional example anchor.

## Anforderungen / Requirements

- **R-01:** Die relevanten Qualitätsdimensionen sind benannt und je Dimension mit einer messbaren Kennzahl hinterlegt.
- **R-02:** Plausibilitätsregeln und der Umgang mit Fehl-, Alt-, Dubletten- und verwaisten Werten sind dokumentiert.
- **R-03:** Rohdaten bleiben unverändert; jede Bereinigung ist reproduzierbar und mit Begründung protokolliert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als Quelle benannt.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; die Northwind-Daten sind fiktiv, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Bestelldaten und Importe als nicht vertrauenswürdig behandeln und an der Vertrauensgrenze validieren.
- Positive Qualitätsaussagen nur mit Nachweis (Test, Messung, Protokoll) treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Die Qualitätsdimensionen, Kennzahlen und Plausibilitätsregeln bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Bibliotheken zur Validierung dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere Eingabevalidierung, keine Bereinigungsprotokolle und keine Datenschutzprüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Datenqualitätsbewertung von Bestellungen und Positionen.
- `plan.md` mit Qualitäts-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Regel-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Qualitätsdimensions-Tabelle mit Kennzahlen, Plausibilitätsregeln je Feld, Bereinigungsprotokoll, Roh-/Bereinigt-Trennung, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die DPA-Spezialisierung ist klar sichtbar.
- [ ] Jede Qualitätsdimension hat eine messbare Kennzahl und eine Interpretation.
- [ ] Der Umgang mit fehlenden, fehlerhaften, veralteten, doppelten und verwaisten Werten ist begründet dokumentiert.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_02_Datenqualitaet-in-Bestellungen-und-Positionen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Bewertung und Sicherung der Datenqualität in Bestellungen und Positionen der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
