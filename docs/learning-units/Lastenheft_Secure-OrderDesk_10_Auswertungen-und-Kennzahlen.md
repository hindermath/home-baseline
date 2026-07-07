# Lastenheft: Secure OrderDesk 10 - Auswertungen und Kennzahlen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA, SI
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Lernende können aus den Handelsdaten von Secure Trader einfache Auswertungen und Kennzahlen ableiten
(Umsatz je Kategorie, Top-Produkte, Bestell-KPIs wie Bestellungen je Zeitraum), diese sprachneutral definieren
und ihre Aussagegrenzen sowie Datenschutzfolgen kritisch bewerten. Sie stützen alle Auswertungen auf die
Northwind-Datenbasis inkl. `ALFKI`.

**EN:** Learners can derive simple evaluations and metrics from Secure Trader's trading data (revenue per
category, top products, order KPIs such as orders per period), define them in a language-neutral way, and
critically assess their limits of interpretation and privacy consequences. They base all evaluations on the
Northwind data base incl. `ALFKI`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch | Welche Kennzahl kann leicht falsch interpretiert werden und warum? |
| SI | hoch | Welche Auswertung wäre nützlich, aber offenbart sensible Kunden- oder Betriebsdaten? |
| AE | mittel bis hoch | Welche Auswertungsberechnung muss deterministisch und über parametrisierte Queries testbar sein? |
| DV | mittel | Welche Systemgrenze oder Datenherkunftsannahme beeinflusst die Datenqualität der Auswertung? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Auswertung, Kennzahlen, relationale Datenverwaltung, Datenqualität, Datenschutz
und kundenverständliche Darstellung im Handelskontext auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects evaluation, metrics, relational data management, data quality, privacy, and
customer-understandable presentation in a trading context at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 6 („Serviceanfragen bearbeiten")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk_10_Auswertungen-und-Kennzahlen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 6 ("Serviceanfragen bearbeiten")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk_10_Auswertungen-und-Kennzahlen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, Zweckbindung, sichere Datenzugriffe, nachvollziehbare Dokumentation, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_11.
- **Mitgeltende Dokumente:** Leitlinie für sichere Programmierung, Datenschutzleitlinie, Richtlinie Testmanagement nach Bedarf.
- **Presets:** security-governance, a11y-governance.

## Aufgabenstellung / Task

**DE:** Definiere für Secure OrderDesk einfache Auswertungen und Kennzahlen aus den Handelsdaten: Umsatz je
Kategorie, Top-Produkte nach Umsatz oder Menge und Bestell-KPIs wie Bestellungen je Zeitraum oder
durchschnittlicher Bestellwert. Beschreibe je Kennzahl den Zweck, eine sprachneutrale Formel und die
Aussagegrenzen. Lege fest, welche Daten dafür genutzt werden dürfen (aggregiert, ohne unnötige personenbezogene
Kundendaten) und wie fehlende, fehlerhafte oder veraltete Werte behandelt werden. Nutze die
Northwind-Datenbasis inkl. `ALFKI`; halte die Auswertung im 1. Lehrjahr bewusst einfach.

**EN:** For Secure OrderDesk, define simple evaluations and metrics from the trading data: revenue per
category, top products by revenue or quantity, and order KPIs such as orders per period or average order value.
Describe per metric the purpose, a language-neutral formula, and the limits of interpretation. Define which
data may be used (aggregated, without unnecessary personal customer data) and how missing, faulty, or stale
values are handled. Use the Northwind data base incl. `ALFKI`; keep the evaluation deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Jede Auswertung/Kennzahl hat Zweck, sprachneutrale Formel und benannte Aussagegrenze.
- **R-02:** Umsatz je Kategorie, Top-Produkte und mindestens eine Bestell-KPI sind definiert und aus dem Northwind-Layout ableitbar.
- **R-03:** Fehlende, fehlerhafte oder veraltete Daten (z. B. Positionen ohne Preis, Rabatte, offene Zeiträume) werden sichtbar behandelt, nicht still gefüllt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als Quelle benannt.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten verwenden; die Northwind-Daten und alle Erweiterungen sind fiktiv.
- Aggregierte Kennzahlen dürfen keine Rückschlüsse auf einzelne echte Personen ermöglichen; nur benötigte Felder werden ausgewertet (Datenminimierung).
- Datenbankzugriffe für Auswertungen erfolgen ausschließlich über parametrisierte Queries; kein dynamisches SQL aus nicht vertrauenswürdigem Filter- oder Zeitraum-Input.
- Positive Aussagen zu Geschäftszahlen oder Datenqualität nur mit Nachweis treffen; Aussagegrenzen (z. B. kleine Datenmenge, Rabatteinfluss) werden mitgenannt.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren (z. B. Echtzeit-Dashboard, personenbezogene Umsatzprofile pro Kontaktperson).

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Kennzahlenformeln sind unabhängig von Zielprogrammiersprache und UI-Form (CLI, API oder GUI werden nicht festgelegt).
- Jede Sprache muss dieselben fiktiven Northwind-Testdaten gleich auswerten; gleiche Eingabe ergibt gleiche Zahl.
- Sprachspezifische Datums-, Zeit-, Zeitzonen- oder Rundungslogik wird deterministisch getestet, wenn sie die Aussage beeinflusst (z. B. Umsatz mit Rabatt, Zeitraum-Abgrenzung).
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, SQL-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` mit Kennzahlenkatalog (Umsatz je Kategorie, Top-Produkte, Bestell-KPIs) und Datenschutz-/Aussagegrenzen.
- `plan.md` mit Berechnungs-, Query-, Datenqualitäts-, Datenschutz- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Berechnungs-, Test- und Dokumentationsschritten.
- Beispielauswertung mit fiktiven, wiederholbaren Northwind-Daten (inkl. `ALFKI`) und benannten Aussagegrenzen.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Umsatz je Kategorie, Top-Produkte und mindestens eine Bestell-KPI haben Zweck, Formel und Aussagegrenze.
- [ ] Fehlende, fehlerhafte oder veraltete Werte werden sichtbar behandelt; Datenzugriffe sind parametrisiert.
- [ ] Die Northwind-Datenbasis inkl. Pflicht-Datensatz `ALFKI` ist als Quelle benannt.
- [ ] Mindestens ein deterministischer Test für eine Kennzahl ist benannt; Datenschutzrisiken sind bewertet.
- [ ] Offene Punkte sind als `Open` mit Owner oder Folgeaufgabe notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_10_Auswertungen-und-Kennzahlen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für einfache Auswertungen und Kennzahlen (Umsatz je Kategorie, Top-Produkte, Bestell-KPIs), sprachneutrale Formeln, Datenqualität, Datenschutz und Aussagegrenzen der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
