# Lastenheft: Secure OrderDesk Data & Process Track 03 - Umsatz-Kennzahlen und Betriebsmetriken

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

**DE:** Aus den bereinigten Handelsdaten werden aussagekräftige Umsatz-Kennzahlen und Betriebsmetriken abgeleitet und fachlich korrekt interpretiert. Lernende definieren jede Kennzahl mit Formel, Bezugsmenge und Aussagegrenze, unterscheiden Bestands-, Fluss- und Qualitätsmetriken und begründen, welche Geschäfts- oder Betriebsentscheidung eine Metrik stützt und welche nicht. Der Umsatz einer Position folgt der Formel `UnitPrice * Quantity * (1 - Discount)`.

**EN:** From the cleaned trading data, meaningful revenue metrics and operational metrics are derived and interpreted correctly. Learners define each metric with a formula, reference set, and limit of validity, distinguish stock, flow, and quality metrics, and justify which business or operational decision a metric supports and which it does not. The revenue of a line item follows the formula `UnitPrice * Quantity * (1 - Discount)`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Welche Bezugsmenge und Aussagegrenze gelten für diese Umsatz-Kennzahl? |
| AE | mittel | Welche Aggregations- oder Berechnungslogik folgt aus der Kennzahldefinition? |
| SI | mittel | Welche Geschäfts- oder Betriebsentscheidung wird durch die Metrik gestützt oder gefährdet? |
| DV | mittel | Welche Schnittstelle oder Zeitbasis beeinflusst die Metrik über Systemgrenzen hinweg? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet Prozessanalyse, Kennzahlendefinition, sichere Datenverarbeitung und auditfähige Interpretation von Umsatz- und Betriebsmetriken.

**EN:** The task supports the DPA specialization in year 3. It connects process analysis, metric definition, secure data processing, and audit-ready interpretation of revenue and operational metrics.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11c („Prozesse analysieren und gestalten")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_03_Umsatz-Kennzahlen-und-Betriebsmetriken.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11c ("Prozesse analysieren und gestalten")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_03_Umsatz-Kennzahlen-und-Betriebsmetriken.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Testbarkeit, Datenschutz, Nachvollziehbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Datenschutz- und Nachweisdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine fokussierte Spezifikation für aussagekräftige Umsatz-Kennzahlen und Betriebsmetriken von Secure OrderDesk. Berücksichtige: die Definition jeder Kennzahl mit Formel, Bezugsmenge (Nenner) und Aussagegrenze, den korrekten Umgang mit Rabatt in der Umsatzformel `UnitPrice * Quantity * (1 - Discount)`, die Unterscheidung von Bestandsmetriken (z. B. Anzahl aktiver Kund*innen), Flussmetriken (z. B. Bestellungen je Monat, Umsatz je Zeitraum) und Qualitätsmetriken (z. B. Anteil vollständiger Positionen), typische Kennzahlen wie Umsatz je Warenkategorie, Top-Produkte nach Umsatz oder Menge und durchschnittlicher Bestellwert, die fachliche Interpretation (welche Entscheidung stützt die Metrik?) sowie die ehrliche Trennung zwischen dem, was eine Zahl aussagt, und dem, was Betrachtende hineinlesen könnten. Nutze die Northwind-Datenbasis inkl. `ALFKI`.

**EN:** Develop a focused specification for meaningful revenue metrics and operational metrics of Secure OrderDesk. Consider: the definition of each metric with formula, reference set (denominator), and limit of validity; the correct handling of discount in the revenue formula `UnitPrice * Quantity * (1 - Discount)`; the distinction of stock metrics (e.g. number of active customers), flow metrics (e.g. orders per month, revenue per period), and quality metrics (e.g. share of complete line items); typical metrics such as revenue per category, top products by revenue or quantity, and average order value; the business interpretation (which decision does the metric support?); and the honest separation between what a number says and what viewers might read into it. Use the Northwind data base incl. `ALFKI`.

## Anforderungen / Requirements

- **R-01:** Jede Kennzahl ist mit Formel, Bezugsmenge und Aussagegrenze definiert; die Umsatzformel mit Rabatt ist ausdrücklich belegt.
- **R-02:** Bestands-, Fluss- und Qualitätsmetriken sind unterschieden und je Typ mindestens einmal belegt.
- **R-03:** Zu jeder Kennzahl ist die gestützte Geschäfts- oder Betriebsentscheidung und mindestens eine Fehlinterpretation benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als Quelle benannt.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; die Northwind-Daten sind fiktiv, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Kennzahlen dürfen keine einzelne echte Person oder Kundenfirma nachverfolgbar machen; Aggregation und Datenminimierung beachten.
- Datenzugriffe für Kennzahlen erfolgen über parametrisierte Queries; kein dynamisches SQL aus nicht vertrauenswürdigem Filter- oder Zeitraum-Input.
- Positive Aussagen zu einer Metrik nur mit nachvollziehbarer Berechnung und Bezugsmenge treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Kennzahldefinitionen, Formeln und Bezugsmengen bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Aggregations-, Rundungs- oder Statistikbibliotheken dürfen gewählt werden, müssen aber begründet werden; gleiche Eingabe ergibt gleiche Zahl.
- MSL-Status ersetzt keine korrekte Bezugsmenge, keine Zeit-/Rundungsprüfung und keine Datenschutzprüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Umsatz-Kennzahlen und Betriebsmetriken.
- `plan.md` mit Metrik-, Query-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Definitions-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Kennzahlkatalog mit Formel und Nenner, Metrik-Typ-Zuordnung, Interpretations- und Fehlinterpretationstabelle, deterministischer Beispieltest, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die DPA-Spezialisierung und der Prozessbezug sind klar sichtbar.
- [ ] Jede Kennzahl hat Formel, Bezugsmenge und Aussagegrenze; die Rabattbehandlung im Umsatz ist belegt.
- [ ] Zu jeder Kennzahl ist eine gestützte Entscheidung und eine Fehlinterpretation benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_03_Umsatz-Kennzahlen-und-Betriebsmetriken.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für aussagekräftige Umsatz-Kennzahlen und Betriebsmetriken der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
