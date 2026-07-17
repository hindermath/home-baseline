---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
Stand: 2026-07-07
-->

# Secure OrderDesk Application Track

## Spezialisierung AE - Anwendungsentwicklung ab dem 3. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles · Kundenfirma Secure Trader

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in den Track ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an. Die Plattform ist eine relationale Bestell-/Handelsplattform für Secure Trader auf der Northwind-Datenbasis, sprachneutral, mit dem C#-Referenzpfad OrderDesk.
:::

---

# Ziel des Tracks

- Der Application Track vertieft die sichere Feature- und Schnittstellenentwicklung der Bestell-/Handelsplattform für Secure Trader. Lernende planen Funktionen auf der Northwind-Bestelldomäne, Persistenz-Adapter mit parametrisierten Queries, Query-Logik, eine wartbare Oberfläche, sichere Serialisierung und Tests.
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
Der Datensatz `ALFKI` ist Pflicht, damit alle Sprachpfade denselben Bezugspunkt für Features und Tests haben. Es dürfen keine echten personenbezogenen Daten oder Secrets verwendet werden.
:::

---

# Systemlandschaft Secure Trader

- **Secure OrderDesk**: die relationale Bestell-/Handelsplattform (dieser Track)
- **Secure ServiceHarvester**: sammelt System-/Bestandsdaten der PCs und Server
- **Secure CaseTracker**: Support-Plattform für Support-Cases
- Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit
- Jeder Track bleibt eigenständig bearbeitbar

::: notes
EuFPA baut für Secure Trader drei ineinandergreifende, aber je eigenständige Systeme. Der Application Track vertieft die Feature-Ecke der OrderDesk-Plattform.
:::

---

# Aufgabenfolge

- 01: Track-Baseline und Feature-Zielbild
- 02: API-Erweiterung und Ressourcenmodell
- 03: Persistenz-Adapter und Repository-Muster
- 04: Query-, Filter- und Paginierungslogik
- 05: Viewer- oder Client-Oberfläche (barrierefrei)
- 06: Fehlerbehandlung und Validierung vertieft
- 07: Erweiterbarkeit und Konfigurierbarkeit
- 08: Sichere Serialisierung und Schnittstellenverträge
- 09: Teststrategie: Unit, Integration und Contract-Tests
- 10: Feature-Review, Trade-offs und Abschluss

---

# Nachweise

- Richtlinie Sichere Entwicklung
- 12 Einzel-Checklisten und Checklistensammelband
- mitgeltende Dokumente
- sieben Governance-Presets
- `Applicable`, `N/A`, `Open` mit Begründung

---

# Startpunkt für später

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure OrderDesk Application Track. Die Datenbasis ist Northwind inklusive ALFKI. Erzeuge keine Implementierung.
```
