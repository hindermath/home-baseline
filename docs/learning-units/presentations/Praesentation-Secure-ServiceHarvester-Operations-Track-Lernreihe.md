---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Secure ServiceHarvester Operations Track

## Spezialisierung SI - Systemintegration ab dem 3. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in den Track ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an. Stand: 2026-07-06.
:::

---

# Ziel des Tracks

- Der Operations Track betrachtet den ServiceHarvester als plattformübergreifend zu betreibenden Sammel- und Worker-Dienst. Lernende planen Deployment, Konfiguration, Härtung, Observability, Builds, Backup, Supply-Chain und Betriebsnachweise.
- Der Track baut auf dem Baseline-Tag `learning/year-2-complete` auf.
- Die Domäne bleibt sprachneutral; die C#-Referenz `InventarWorkerService` dient nur der Anschauung.
- C#, Go, Java, Python, Rust und Swift bleiben als MSL-Pfade vorbereitet.
- Ab dem 3. Lehrjahr wird KI-gestützte Schreibarbeit in oder mit `absdd-image-sandbox` erwartet oder begründet abgegrenzt.

---

# Aufgabenfolge

- 01: Track-Baseline und Betriebszielbild
- 02: Dienst-Deployment (Windows-Service, systemd, launchd)
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
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure ServiceHarvester Operations Track. Erzeuge keine Implementierung.
```
