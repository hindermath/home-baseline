---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
Stand: 2026-07-07
-->

# Secure OrderDesk Data & Process Track

## Spezialisierung DPA - Daten- und Prozessanalyse ab dem 3. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles · Kundenfirma Secure Trader

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in den Track ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an. Die Plattform ist eine relationale Bestell-/Handelsplattform für Secure Trader auf der Northwind-Datenbasis, sprachneutral, mit dem C#-Referenzpfad OrderDesk.
:::

---

# Ziel des Tracks

- Der Data & Process Track vertieft den verantwortlichen Umgang mit den Bestell- und Handelsdaten von Secure Trader. Lernende planen Datenqualität in Bestellungen und Positionen, Umsatz-Kennzahlen, Reporting, Datenschutz, Anomalieerkennung und die ehrliche Benennung von Aussagegrenzen.
- Der Track baut auf Secure OrderDesk und Secure OrderDesk v2 auf und startet aus dem Tag `learning/year-2-complete`.
- Die spätere Arbeit bleibt je Sprachpfad und Aufgaben-Lastenheft getrennt.
- C#, Go, Java, Python, Rust und Swift bleiben als MSL-Pfade vorbereitet.

---

# Datenbasis: Northwind und ALFKI

- Verbindliche Datenbasis bleibt die klassische **Northwind-Sample-Datenbank**
- Layout und Daten inklusive Pflicht-Datensatz **`ALFKI`**
- Kunden, Produkte, Bestellungen und Bestellpositionen im Northwind-Layout
- Alle Daten sind fiktiv und werden markenneutral genutzt
- „Microsoft“ wird nur als historischer Quellhinweis erwähnt

::: notes
Der Datensatz `ALFKI` ist Pflicht, damit alle Sprachpfade dieselbe Datenbasis für Kennzahlen und Auswertungen haben. Es dürfen keine echten personenbezogenen Daten oder Secrets verwendet werden.
:::

---

# Systemlandschaft Secure Trader

- **Secure OrderDesk**: die relationale Bestell-/Handelsplattform (dieser Track)
- **Secure ServiceHarvester**: sammelt System-/Bestandsdaten der PCs und Server
- **Secure CaseTracker**: Support-Plattform für Support-Cases
- Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit
- Jeder Track bleibt eigenständig bearbeitbar

::: notes
EuFPA baut für Secure Trader drei ineinandergreifende, aber je eigenständige Systeme. Der Data & Process Track vertieft die Auswertungs-Ecke der OrderDesk-Plattform.
:::

---

# Aufgabenfolge

- 01: Track-Baseline und Datenzielbild
- 02: Datenqualität in Bestellungen und Positionen
- 03: Umsatz-Kennzahlen und Betriebsmetriken
- 04: Datenschutz und Datenminimierung vertieft
- 05: Reporting und Aggregationsansichten (barrierefrei)
- 06: Aussagegrenzen und Datenunsicherheit
- 07: Anomalie- und Lückenerkennung
- 08: Prozessfeedback und Verbesserung
- 09: Test- und Nachweisstrategie für Datenaussagen
- 10: Daten-Review, Trade-offs und Abschluss

---

# Nachweise

- Richtlinie Sichere Entwicklung
- 12 Einzel-Checklisten und Checklistensammelband
- mitgeltende Dokumente
- sechs Governance-Presets
- `Applicable`, `N/A`, `Open` mit Begründung

---

# Startpunkt für später

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure OrderDesk Data & Process Track. Die Datenbasis ist Northwind inklusive ALFKI. Erzeuge keine Implementierung.
```
