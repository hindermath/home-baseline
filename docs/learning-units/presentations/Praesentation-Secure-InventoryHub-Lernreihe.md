---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
-->

# Secure InventoryHub

## Inventar, Betrieb und Nachweise ab dem 2. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles

Fachinformatiker*innen ab dem 2. Lehrjahr · DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in die Lernreihe ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an.
:::

---

# Warum diese Reihe?

- EuFPA benötigt einen Secure InventoryHub, um Geräte, Software, Versionen, Verantwortliche, Wartungsstatus und einfache Risikoansichten nachvollziehbar zu verwalten.
- Die Reihe vertieft sichere Entwicklung nach der Richtlinie und den Checklisten.
- Die späteren Umsetzungen bleiben sprachneutral vergleichbar.
- C#, Go, Java, Python, Rust und Swift werden als MSL-Pfade vorbereitet.

---

# Fachrichtungsbezug

| Fachrichtung | Fokus |
|---|---|
| AE | Datenmodell, Rollen, Suche, Import/Export, Tests und sichere Schnittstellen. |
| SI | Inventar, Betrieb, Patchstand, Wartung, Toolchain, SBOM und Betriebsnachweise. |
| DPA | Datenqualität, Kennzahlen, Aussagegrenzen, Datenschutz und Risikoansichten. |
| DV | Netzbezug von Assets, Schnittstellen, Kommunikationsflüsse, Segmentierung und Verfügbarkeitsannahmen. |

---

# Aufgabenfolge

- 01: Kundenauftrag, Scope und Inventarobjekte
- 02: Asset- und Software-Datenmodell und Status
- 03: Verantwortlichkeiten und Rollen
- 04: Suche, Filter und Datenqualität
- 05: Import, Export und Datenbereinigung
- 06: Audit-Logging und Datenschutz
- 07: Patch-, Wartungs- und Risikoansicht
- 08: Supply Chain, SBOM und Dependency-Bezug
- 09: Teststrategie, Sandbox und Betriebsnachweise
- 10: Review, Kennzahlen und Abschlussbewertung

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
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-InventoryHub_01_Kundenauftrag-Scope-und-Inventarobjekte.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure InventoryHub. Erzeuge keine Implementierung.
```

::: notes
Der Prompt ist ein Beispiel für den ersten späteren Einzel-Lauf. Lehrende oder Lernende starten diesen Lauf bewusst manuell im passenden Sprach-Repo.
:::
