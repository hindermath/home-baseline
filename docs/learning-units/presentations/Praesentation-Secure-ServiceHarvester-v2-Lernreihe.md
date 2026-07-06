---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Secure ServiceHarvester v2

## Service Edition ab dem 2. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles

Fachinformatiker*innen ab dem 2. Lehrjahr · DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in die Lernreihe ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an.
:::

---

# Warum diese Reihe?

- EuFPA möchte den bisherigen Secure ServiceHarvester zu einer sauber geschnittenen Dienst-Edition ausbauen. Die Reihe vertieft Architektur, Dienst-Hosting, Persistenz, Harvester-Härtung, API-/Service-Vertrag, Autorisierung, Audit-Logging, Betrieb, Konfiguration und MSL-Vergleich.
- Die Reihe vertieft sichere Entwicklung nach der Richtlinie und den Checklisten.
- Die späteren Umsetzungen bleiben sprachneutral vergleichbar; als C#-Referenz dient `InventarWorkerService`.
- C#, Go, Java, Python, Rust und Swift werden als MSL-Pfade vorbereitet.
- `absdd-image-sandbox` ist die öffentliche Sandbox-Referenz, im 2. Lehrjahr aber noch kein harter Pflichtlauf.

---

# Fachrichtungsbezug

| Fachrichtung | Fokus |
|---|---|
| AE | Architektur, Backend-Abstraktion, Service-Vertrag, Validierung und Tests. |
| SI | Dienst-Hosting, Konfiguration, Secrets, Logging, Health, Monitoring und Nachweispfade. |
| DPA | Datenqualität im Harvester, Kennzahlen, Datenschutz und Aussagegrenzen. |
| DV | Systemgrenzen, Schnittstellen, Kommunikationsflüsse und Verfügbarkeit. |

---

# Aufgabenfolge

- 01: Architekturzielbild und Systemgrenzen
- 02: Plattformübergreifendes Dienst-Hosting und Lebenszyklus
- 03: Persistenzmodell und Backend-Abstraktion
- 04: Harvester: Zeitplanung, Idempotenz und Import-Härtung
- 05: API- und Service-Vertrag und OpenAPI
- 06: Fehler-, Validierungs- und Response-Modell
- 07: Rollen-, Autorisierung und Audit-Logging
- 08: Betrieb, Logging, Health und Monitoring
- 09: Sichere Konfiguration, Secrets und Betriebsnachweise
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
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-v2_01_Architekturzielbild-und-Systemgrenzen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure ServiceHarvester v2. Erzeuge keine Implementierung.
```

::: notes
Der Prompt ist ein Beispiel für den ersten späteren Einzel-Lauf. Lehrende oder Lernende starten diesen Lauf bewusst manuell im passenden Sprach-Repo.
:::
