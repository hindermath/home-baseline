# Lastenheft: Secure OrderDesk Data & Process Track 01 - Track-Baseline und Datenzielbild

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

**DE:** Ausgehend von der Secure-OrderDesk-Basis wird ein belastbares Datenzielbild für den Data & Process Track erarbeitet. Lernende trennen die vorhandenen Handelsdaten aus der Northwind-Datenbasis (Kunden, Bestellungen, Positionen, Produkte, Kategorien) von den fachlichen Fragen, den geplanten Auswertungen, den Nicht-Zielen und dem Schutzbedarf und benennen von Anfang an die Aussagegrenzen der Daten. Der Pflicht-Datensatz `ALFKI` dient als fester Anker.

**EN:** Starting from the Secure OrderDesk base, a robust data target picture for the Data & Process Track is developed. Learners separate the existing trading data from the Northwind data base (customers, orders, line items, products, categories) from the business questions, the planned evaluations, the non-goals, and the protection need, and name the limits of validity of the data from the start. The mandatory record `ALFKI` serves as a fixed anchor.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Welche Handelsfrage soll aus den Bestelldaten beantwortet werden und welche Aussagegrenze gilt? |
| AE | mittel | Welche Datenstruktur oder Auswertungsschnittstelle folgt aus dem Datenzielbild? |
| SI | mittel | Welche Datenbank- oder Betriebsannahme beeinflusst die verfügbaren Bestelldaten? |
| DV | mittel | Welche Schnittstelle oder Systemgrenze liefert die Roh-Bestelldaten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die DPA-Spezialisierung im 3. Lehrjahr. Sie verbindet kundenspezifische Prozess- und Datenanalyse der Handelsdaten, sichere Entwicklung und auditfähige Dokumentation eines Datenzielbilds.

**EN:** The task supports the DPA specialization in year 3. It connects customer-specific process and data analysis of the trading data, secure development, and audit-ready documentation of a data target picture.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12c („Kundenspezifische Prozess- und Datenanalyse durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12c ("Kundenspezifische Prozess- und Datenanalyse durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Datenschutz- und Nachweisdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für den Data & Process Track ein fokussiertes Datenzielbild auf Basis der Secure-OrderDesk-Handelsdaten. Berücksichtige: welche Rohdaten bereits vorliegen (Northwind-Layout mit `Customers`, `Orders`, `Order Details`, `Products`, `Categories`, inkl. Feldern wie `OrderDate`, `UnitPrice`, `Quantity`, `Discount`, `CategoryID`, `CustomerID`), welche fachlichen Fragen die Daten beantworten sollen (z. B. Umsatz je Kategorie, Bestellverhalten), welche Auswertungen geplant sind (Datenqualität, Umsatz-Kennzahlen, Datenschutzsicht, Reporting), welche Nicht-Ziele gelten, welcher Schutzbedarf betroffen ist und welche Aussagegrenzen die Daten von vornherein haben. Nutze `ALFKI` nur als fiktiven Beispielanker. Halte das Datenzielbild als prüfbare Baseline für die folgenden Track-Einheiten fest.

**EN:** Develop a focused data target picture for the Data & Process Track based on the Secure OrderDesk trading data. Consider: which raw data already exists (Northwind layout with `Customers`, `Orders`, `Order Details`, `Products`, `Categories`, incl. fields such as `OrderDate`, `UnitPrice`, `Quantity`, `Discount`, `CategoryID`, `CustomerID`), which business questions the data should answer (e.g. revenue per category, ordering behavior), which evaluations are planned (data quality, revenue metrics, privacy view, reporting), which non-goals apply, which protection need is affected, and which limits of validity the data has from the start. Use `ALFKI` only as a fictional example anchor. Fix the data target picture as a testable baseline for the following track units.

## Anforderungen / Requirements

- **R-01:** Vorhandene Handelsdaten und geplante Auswertungen sind klar und getrennt beschrieben; die Northwind-Datenbasis inkl. `ALFKI` ist als Quelle benannt.
- **R-02:** Sicherheits-, Datenschutz-, Betriebs- und Datenannahmen sind getrennt dokumentiert.
- **R-03:** Mindestens zwei fachliche Handelsfragen sind mit benötigten Feldern und Aussagegrenze notiert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; die Northwind-Daten sind fiktiv, Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Bestelldaten, Importe, Konfiguration, Logs, Abhängigkeiten und Auswertungen als mögliche Vertrauensgrenzen prüfen.
- Personenbeziehbare Kundendaten (Kontaktname, Anschrift) nur so weit einbeziehen, wie eine Frage sie zwingend braucht.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag des Datenzielbilds bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, SQL-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für dieses Datenzielbild.
- `plan.md` mit Daten-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Rohdaten-Abgrenzung (Northwind-Tabellen/Felder), Fragen-Feld-Matrix, Auswertungsliste, Nicht-Ziele, Schutzbedarf, Aussagegrenzen, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die DPA-Spezialisierung und der Bezug zur Secure-OrderDesk-Basis sind klar sichtbar.
- [ ] Fachliche Frage, benötigte Daten, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens zwei fachliche Handelsfragen sind mit Aussagegrenze belegt; die Northwind-/`ALFKI`-Quelle ist als fiktiv benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein belastbares Datenzielbild des Data & Process Track der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
