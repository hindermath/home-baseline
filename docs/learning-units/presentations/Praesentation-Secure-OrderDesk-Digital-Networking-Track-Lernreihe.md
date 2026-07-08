---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
Stand: 2026-07-07
-->

# Secure OrderDesk Digital Networking Track

## Spezialisierung DV - Digitale Vernetzung ab dem 3. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles · Kundenfirma Secure Trader

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in den Track ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an. Stand: 2026-07-07.
:::

---

# Ziel des Tracks

- Der Digital Networking Track betrachtet Secure OrderDesk als vernetzte Bestell-Pipeline für Secure Trader. Lernende planen Systemkontext, Schnittstellen zwischen Bestellannahme, Katalog und relationaler Ablage, Kommunikationsflüsse, Segmentierung, Transportsicherheit, Verfügbarkeit, verteilte Integration und Betriebsnachweise.
- Der Track baut auf dem Baseline-Tag `learning/year-2-complete` auf.
- Die Domäne bleibt sprachneutral; als C#-Referenz dient der OrderDesk-Referenzpfad.
- C#, Go, Java, Python, Rust und Swift bleiben als MSL-Pfade vorbereitet.
- Ab dem 3. Lehrjahr wird KI-gestützte Schreibarbeit in oder mit `absdd-image-sandbox` erwartet oder begründet abgegrenzt.

---

# Datenbasis: Northwind und ALFKI

- Verbindliche Datenbasis bleibt die klassische **Northwind-Sample-Datenbank**
- Layout und Daten inklusive Pflicht-Datensatz **`ALFKI`**
- Kunden, Produkte, Bestellungen und Bestellpositionen im Northwind-Layout
- Alle Daten sind fiktiv und werden markenneutral genutzt
- „Microsoft" wird nur als historischer Quellhinweis erwähnt

::: notes
Der Datensatz `ALFKI` ist Pflicht, damit alle Sprachpfade denselben Bezugspunkt für Schnittstellen und Netzpfade haben. Es dürfen keine echten personenbezogenen Daten oder Secrets verwendet werden.
:::

---

# Systemlandschaft Secure Trader

- **Secure OrderDesk**: die relationale Bestell-/Handelsplattform (dieser Track)
- **Secure ServiceHarvester**: sammelt System-/Bestandsdaten der PCs und Server
- **Secure CaseTracker**: Support-Plattform für Support-Cases
- Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit
- Jeder Track bleibt eigenständig bearbeitbar

::: notes
EuFPA baut für Secure Trader drei ineinandergreifende, aber je eigenständige Systeme. Der Digital Networking Track vertieft die Netz- und Pipeline-Ecke der OrderDesk-Plattform.
:::

---

# Aufgabenfolge

- 01: Track-Baseline und Netzzielbild
- 02: Systemkontext und Bestell-Pipeline-Netzbezüge
- 03: Schnittstellen und Kommunikationsflüsse
- 04: Segmentierung und Vertrauenszonen
- 05: Transportsicherheit und Endpunkt-Authentifizierung
- 06: Verfügbarkeit, Timeouts und Wiederholstrategien
- 07: Verteilte Integration und Agentenkommunikation
- 08: Betriebs- und Netznachweise
- 09: Ausfallszenarien und Resilienz
- 10: Netz-Review, Trade-offs und Abschluss

---

# Nachweise

- Kommunikationsmatrix und Schnittstellenliste
- Trust-Boundary-, Segmentierungs- und Transportsicherheitsnachweis
- Timeout-, Wiederhol- und Resilienznachweise
- Betriebs- und Netzmetriken ohne Datenschutzverletzung
- Threat Model und Restrisiken für Netzpfade
- `Applicable`, `N/A`, `Open` mit Begründung
- Public-Sandbox-Link und Sandbox-/IDE-Abgrenzung

---

# Wichtig für Lernende

- Spec-Kit strukturiert Spezifikation, Planung, Aufgaben und Review
- Spec-Kit ersetzt nicht Berufsschule, betriebliche Ausbildung oder Prüfungsvorbereitung
- Jeder Lauf wird später bewusst pro Aufgaben-Lastenheft gestartet
- Ein sauber begründetes `N/A` ist besser als ein still ausgelassener Prüfpunkt

---

# Startpunkt für später

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure OrderDesk Digital Networking Track. Die Datenbasis ist Northwind inklusive ALFKI. Erzeuge keine Implementierung.
```
