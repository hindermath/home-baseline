# Lastenheft: Secure OrderDesk Data & Process Track 06 - Aussagegrenzen und Datenunsicherheit

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

**DE:** Aussagegrenzen und Datenunsicherheit der Bestell- und Handelsdaten von Secure Trader werden ehrlich benannt: unvollständige Bestellungen, Aktualität (Freshness) des betrachteten Datenstands, offene oder nicht versendete Bestellungen, Rabatt- und Preiseinflüsse sowie die Abdeckung (Coverage) je Kunde, Produkt oder Zeitraum fließen in jede Kennzahlaussage ein. Lernende trennen, was die Northwind-Datenbasis inkl. `ALFKI` wirklich zeigt, von dem, was man nur vermutet.

**EN:** The interpretation limits and data uncertainty of Secure Trader's order and trading data are named honestly: incomplete orders, freshness of the considered data state, open or unshipped orders, discount and price effects, and coverage per customer, product, or period are considered for every metric claim. Learners separate what the Northwind data base incl. `ALFKI` really shows from what is only assumed.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel | Welche Feld- oder Modellentscheidung macht Unsicherheit in Bestellungen und Positionen im Code sichtbar? |
| SI | mittel bis hoch | Welche Betriebs- oder Datenstandbedingung erzeugt veraltete oder unvollständige Auswertungsdaten? |
| DPA | hoch | Welche Aussagegrenze und welche Datenunsicherheit sind für diese Umsatz- oder Bestell-Kennzahl relevant? |
| DV | mittel | Welche Schnittstellen- oder Datenherkunftslücke verzerrt die ausgewerteten Bestelldaten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet daten- und prozessorientierte Analyse der Handelsdomäne, sichere Entwicklung und ehrliche Interpretation mit auditfähiger Dokumentation und baut auf der v2-Baseline (Jahr 2) auf.

**EN:** The task supports the DPA specialization in year 3. It connects data- and process-oriented analysis of the trading domain, secure development, and honest interpretation with audit-ready documentation, building on the v2 baseline (year 2).

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"): Der Data & Process Track trägt **LF 10c, LF 11c, LF 12c** (berührt LF 5, LF 6). Für diese Einheit ist **LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")** primär; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Begründung: Aussagegrenzen sind der Kern einer belastbaren kundenspezifischen Datenanalyse; die relationale Datenhaltung von Secure OrderDesk (LF 5) liefert Aktualität und Lücken. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"): the Data & Process Track carries **LF 10c, LF 11c, LF 12c** (touches LF 5, LF 6). For this unit **LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")** is primary; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Rationale: interpretation limits are the core of a robust customer-specific data analysis; the relational data storage of Secure OrderDesk (LF 5) provides freshness and gaps. Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Aussagegrenzen der Secure-OrderDesk-Handelsdaten eine fokussierte Spezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: Auswertungen beruhen auf einem bestimmten Datenstand; offene oder nicht versendete Bestellungen sind noch nicht abgeschlossen; Positionen ohne Preis, Rabatte und Zeitraumgrenzen verändern das Ergebnis; nicht jeder Kunde und nicht jedes Produkt kommt im Zeitraum vor. Beschreibe je Kennzahl (z. B. Umsatz je Kategorie, Top-Produkte, Bestellungen je Zeitraum), welche Abdeckung, welche Aktualität und welche Unsicherheit gelten, und formuliere für jede Aussage eine ausdrückliche Aussagegrenze („Diese Zahl gilt nur für abgeschlossene Bestellungen im Zeitraum Q1; offene Bestellungen zählen als unbekannt"). Stütze alle Auswertungen auf die Northwind-Datenbasis inkl. `ALFKI`; die Lösung bleibt sprachneutral.

**EN:** Prepare a focused specification for the interpretation limits of the Secure OrderDesk trading data for the DPA - Data and Process Analysis specialization. Consider: evaluations rest on a specific data state; open or unshipped orders are not yet complete; line items without a price, discounts, and period boundaries change the result; not every customer and not every product appears in the period. Describe per metric (e.g. revenue per category, top products, orders per period) which coverage, freshness, and uncertainty apply, and formulate an explicit limit of validity for each claim ("This number only holds for completed orders in period Q1; open orders count as unknown"). Base all evaluations on the Northwind data base incl. `ALFKI`; the solution stays language-neutral.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang der betrachteten Kennzahlen und ihrer Aussagegrenzen ist klar beschrieben.
- **R-02:** Datenunsicherheit (unvollständige Bestellungen, Aktualität, Rabatt-/Preiseinfluss, Abdeckung) ist je Kennzahl getrennt dokumentiert.
- **R-03:** Zu jeder Kennzahl gehört eine explizit formulierte Aussagegrenze und ein Nachweispfad; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten verwenden; die Northwind-Daten inkl. `ALFKI` und alle Erweiterungen sind fiktiv; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Aggregierte Kennzahlen dürfen keine Rückschlüsse auf einzelne echte Personen ermöglichen; nur benötigte Felder werden ausgewertet (Datenminimierung).
- Datenbankzugriffe für Auswertungen erfolgen ausschließlich über parametrisierte Queries; kein dynamisches SQL aus nicht vertrauenswürdigem Filter- oder Zeitraum-Input.
- Positive Sicherheits-, Qualitäts- oder Aussagegrenzen-Behauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag zu Kennzahlen und Aussagegrenzen bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks für Zeit-, Datums- und Aggregationslogik dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, SQL-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

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
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Aussagegrenzen und Datenunsicherheit der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) im Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
