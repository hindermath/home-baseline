---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Secure ServiceHarvester Digital Networking Track

## Spezialisierung DV - Digitale Vernetzung ab dem 3. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in den Track ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an. Stand: 2026-07-06.
:::

---

# Ziel des Tracks

- Der Digital Networking Track betrachtet den ServiceHarvester als vernetzten, plattformübergreifenden Sammel- und Worker-Dienst. Lernende planen Systemkontext, Schnittstellen, Kommunikationsflüsse, Segmentierung, Transportsicherheit, Verfügbarkeit, verteilte Sammlung und Betriebsnachweise.
- Der Track baut auf dem Baseline-Tag `learning/year-2-complete` auf.
- Die Domäne bleibt sprachneutral; die C#-Referenz `InventarWorkerService` dient nur der Anschauung.
- C#, Go, Java, Python, Rust und Swift bleiben als MSL-Pfade vorbereitet.
- Ab dem 3. Lehrjahr wird KI-gestützte Schreibarbeit in oder mit `absdd-image-sandbox` erwartet oder begründet abgegrenzt.

---

# Aufgabenfolge

- 01: Track-Baseline und Netzzielbild
- 02: Systemkontext und Maschinen-/Netzbezüge
- 03: Schnittstellen und Kommunikationsflüsse
- 04: Segmentierung und Vertrauenszonen
- 05: Transportsicherheit und Endpunkt-Authentifizierung
- 06: Verfügbarkeit, Timeouts und Wiederholstrategien
- 07: Verteilte Sammlung und Agentenkommunikation
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
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure ServiceHarvester Digital Networking Track. Erzeuge keine Implementierung.
```
