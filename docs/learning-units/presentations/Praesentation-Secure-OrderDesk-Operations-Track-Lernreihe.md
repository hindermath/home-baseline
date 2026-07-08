---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
Stand: 2026-07-07
-->

# Secure OrderDesk Operations Track

## Spezialisierung SI - Systemintegration ab dem 3. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles · Kundenfirma Secure Trader

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in den Track ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an. Stand: 2026-07-07.
:::

---

# Ziel des Tracks

- Der Operations Track betrachtet Secure OrderDesk als relationale Bestell-/Handelsplattform, die plattformübergreifend betrieben wird. Lernende planen Datenbank-Betrieb, Deployment, Konfiguration, Härtung, Observability, Builds, Backup, Supply-Chain und Betriebsnachweise.
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
- „Microsoft“ wird nur als historischer Quellhinweis erwähnt

::: notes
Der Datensatz `ALFKI` ist Pflicht, damit Betrieb, Backup und Wiederherstellung über alle Sprachpfade denselben Bezugspunkt haben. Es dürfen keine echten personenbezogenen Daten oder Secrets verwendet werden.
:::

---

# Systemlandschaft Secure Trader

- **Secure OrderDesk**: die relationale Bestell-/Handelsplattform (dieser Track)
- **Secure ServiceHarvester**: sammelt System-/Bestandsdaten der PCs und Server
- **Secure CaseTracker**: Support-Plattform für Support-Cases
- Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit
- Jeder Track bleibt eigenständig betreibbar

::: notes
EuFPA baut für Secure Trader drei ineinandergreifende, aber je eigenständige Systeme. Der Operations Track vertieft den Betrieb der OrderDesk-Plattform.
:::

---

# Aufgabenfolge

- 01: Track-Baseline und Betriebszielbild
- 02: Datenbank-Deployment (Windows-Service, systemd, launchd)
- 03: Konfiguration, Secrets und sichere Defaults
- 04: Härtung und Angriffsflächen-Reduktion
- 05: Observability: Logging, Health und Metriken
- 06: CI/CD-Pipeline und reproduzierbare Builds
- 07: Backup, Recovery und Datenmigration
- 08: Supply Chain, SBOM und Dependency-Audit
- 09: Sandbox, Isolation und Betriebsnachweise
- 10: Betriebs-Review, Runbook und Abschluss

---

# Nachweise

- Richtlinie Sichere Entwicklung
- 12 Einzel-Checklisten und Checklistensammelband
- mitgeltende Dokumente
- sechs Governance-Presets
- `Applicable`, `N/A`, `Open` mit Begründung
- Public-Sandbox-Link und Sandbox-/IDE-Abgrenzung
- Abweichungen von Sandbox-Nutzung als Risiko oder `N/A`

---

# Startpunkt für später

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure OrderDesk Operations Track. Die Datenbasis ist Northwind inklusive ALFKI. Erzeuge keine Implementierung.
```
