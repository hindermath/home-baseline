---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Secure CaseTracker Operations Track

## Spezialisierung SI - Systemintegration ab dem 3. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles

DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in den Track ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an.
:::

---

# Ziel des Tracks

- Der Operations Track betrachtet den CaseTracker als zu betreibendes System. Lernende planen Sandbox, Laufzeit, CI/CD, Secrets, Monitoring, Backup/Restore, Incident Response, Supply-Chain-Nachweise und Härtung.
- Der Track baut auf Secure CaseTracker und Secure CaseTracker v2 auf.
- Die spätere Arbeit bleibt je Sprachpfad und Aufgaben-Lastenheft getrennt.
- C#, Go, Java, Python, Rust und Swift bleiben als MSL-Pfade vorbereitet.
- Ab dem 3. Lehrjahr wird KI-gestützte Schreibarbeit in oder mit `absdd-image-sandbox` erwartet oder begründet abgegrenzt.

---

# Aufgabenfolge

- 01: Betriebszielbild und Systemgrenzen
- 02: Sandbox- und Laufzeitprofil
- 03: CI/CD-Pipeline und Release-Nachweise
- 04: Secrets, Konfiguration und Least Privilege
- 05: Logging, Monitoring und Alerting
- 06: Backup, Restore und Recovery-Übung
- 07: Incident Response und Betriebsdokumentation
- 08: Dependency-, SBOM- und Supply-Chain-Nachweise
- 09: Härtungscheck gegen Richtlinie und Presets
- 10: Abschlussreview mit Betriebsrisiken und Übergabe

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
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure CaseTracker Operations Track. Erzeuge keine Implementierung.
```
