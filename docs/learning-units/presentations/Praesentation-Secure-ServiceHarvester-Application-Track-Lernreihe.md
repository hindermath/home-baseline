---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Secure ServiceHarvester Application Track

## Spezialisierung AE - Anwendungsentwicklung ab dem 3. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in den Track ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an. Der Dienst ist ein plattformübergreifender Sammel- und Worker-Dienst, sprachneutral, mit der C#-Referenz InventarWorkerService.
:::

---

# Ziel des Tracks

- Der Application Track vertieft die sichere Feature- und Schnittstellenentwicklung des Sammel- und Worker-Dienstes. Lernende planen Funktionen, Persistenz-Adapter, Query-Logik, eine wartbare Oberfläche, sichere Serialisierung und Tests.
- Der Track baut auf Secure ServiceHarvester und Secure ServiceHarvester v2 auf und startet aus dem Tag `learning/year-2-complete`.
- Die spätere Arbeit bleibt je Sprachpfad und Aufgaben-Lastenheft getrennt.
- C#, Go, Java, Python, Rust und Swift bleiben als MSL-Pfade vorbereitet.

---

# Aufgabenfolge

- 01: Track-Baseline und Feature-Zielbild
- 02: API-Erweiterung und Ressourcenmodell
- 03: Persistenz-Adapter und Repository-Muster
- 04: Query-, Filter- und Paginierungslogik
- 05: Viewer- oder Client-Oberfläche
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
- sechs Governance-Presets
- `Applicable`, `N/A`, `Open` mit Begründung

---

# Startpunkt für später

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure ServiceHarvester Application Track. Erzeuge keine Implementierung.
```
