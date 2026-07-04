---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Secure CaseTracker v2

## Service Edition ab dem 2. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles

Fachinformatiker*innen ab dem 2. Lehrjahr · DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in die Lernreihe ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an.
:::

---

# Warum diese Reihe?

- EuFPA möchte den bisherigen Secure CaseTracker zu einer Service Edition ausbauen. Die Reihe vertieft Architektur, Persistenz, API-/Service-Grenzen, Autorisierung, Audit-Logging, Tests, CI, Sandbox, Betrieb und MSL-Vergleich.
- Die Reihe vertieft sichere Entwicklung nach der Richtlinie und den Checklisten.
- Die späteren Umsetzungen bleiben sprachneutral vergleichbar.
- C#, Go, Java, Python, Rust und Swift werden als MSL-Pfade vorbereitet.
- `absdd-image-sandbox` ist die öffentliche Sandbox-Referenz, im 2. Lehrjahr aber noch kein harter Pflichtlauf.

---

# Fachrichtungsbezug

| Fachrichtung | Fokus |
|---|---|
| AE | Architektur, Service-Vertrag, Persistenz, Validierung, Autorisierung und Tests. |
| SI | Sandbox, CI, Konfiguration, Betriebsannahmen, Secrets, Toolchain- und Nachweispfade. |
| DPA | Datenmodell, Datenschutz, Auditdaten, Prozesskennzahlen und Aussagegrenzen. |
| DV | Systemgrenzen, Schnittstellen, Kommunikationsflüsse, Segmentierung und Verfügbarkeit. |

---

# Aufgabenfolge

- 01: Architekturzielbild und Systemgrenzen
- 02: Persistenzmodell und Migrationen
- 03: API- und Service-Vertrag
- 04: Fehler-, Validierungs- und Response-Modell
- 05: Rollen- und Autorisierungsmatrix
- 06: Audit-Logging und Datenschutz
- 07: Import- und Export-Härtung
- 08: Teststrategie und CI-Nachweise
- 09: Sandbox- und Betriebsnachweise
- 10: MSL-Vergleich und Abschlussreview

---

# Nachweise

- Richtlinie Sichere Entwicklung
- 12 Einzel-Checklisten und Checklistensammelband
- mitgeltende Dokumente
- sechs Governance-Presets
- `Applicable`, `N/A`, `Open` mit Begründung
- Sandbox-Entscheidung: `Applicable`, `N/A` oder `Open`
- IDE-Arbeit außerhalb der Sandbox bleibt zulässig

---

# Startpunkt für später

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-v2_01_Architekturzielbild-und-Systemgrenzen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure CaseTracker v2. Erzeuge keine Implementierung.
```

::: notes
Der Prompt ist ein Beispiel für den ersten späteren Einzel-Lauf. Lehrende oder Lernende starten diesen Lauf bewusst manuell im passenden Sprach-Repo.
:::
