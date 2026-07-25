# Lastenheft: Secure InventoryHub Lernreihe

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt die gesamte Lernreihe als Gesamtlandkarte. Es ist nicht dafür gedacht, als ein einzelner großer Spec-Kit-Lauf gestartet zu werden.

**EN:** This master intake describes the complete learning series as an overview map. It is not meant to be started as one large Spec Kit run.

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab dem 2. Lehrjahr |
| Fachrichtung AE | hoch |
| Fachrichtung SI | hoch |
| Fachrichtung DPA | mittel bis hoch |
| Fachrichtung DV | mittel bis hoch |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |
| Sprache / Language | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |

**DE:** Die Spec-Kit-Läufe der Reihe sind begleitende SDD-Aufgaben. Sie ersetzen nicht Berufsschule, betriebliche Ausbildung, Ausbilderentscheidungen oder Prüfungsvorbereitung.

**EN:** The Spec Kit runs in this series are companion SDD tasks. They do not replace vocational school, workplace training, trainer decisions, or exam preparation.

## Gesamtziel / Overall Goal

**DE:** EuFPA benötigt einen Secure InventoryHub, um Geräte, Software, Versionen, Verantwortliche, Wartungsstatus, Schnittstellenbezüge und einfache Risikoansichten nachvollziehbar zu verwalten.

**EN:** EuFPA needs a Secure InventoryHub to manage devices, software, versions, owners, maintenance status, interface references, and simple risk views in a traceable way.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei | Thema |
|---:|---|---|
| 01 | [`Lastenheft_Secure-InventoryHub_01_Kundenauftrag-Scope-und-Inventarobjekte.md`](Lastenheft_Secure-InventoryHub_01_Kundenauftrag-Scope-und-Inventarobjekte.md) | Kundenauftrag, Scope und Inventarobjekte |
| 02 | [`Lastenheft_Secure-InventoryHub_02_Asset-Software-Datenmodell-und-Status.md`](Lastenheft_Secure-InventoryHub_02_Asset-Software-Datenmodell-und-Status.md) | Asset- und Software-Datenmodell und Status |
| 03 | [`Lastenheft_Secure-InventoryHub_03_Verantwortlichkeiten-und-Rollen.md`](Lastenheft_Secure-InventoryHub_03_Verantwortlichkeiten-und-Rollen.md) | Verantwortlichkeiten und Rollen |
| 04 | [`Lastenheft_Secure-InventoryHub_04_Suche-Filter-und-Datenqualitaet.md`](Lastenheft_Secure-InventoryHub_04_Suche-Filter-und-Datenqualitaet.md) | Suche, Filter und Datenqualität |
| 05 | [`Lastenheft_Secure-InventoryHub_05_Import-Export-und-Datenbereinigung.md`](Lastenheft_Secure-InventoryHub_05_Import-Export-und-Datenbereinigung.md) | Import, Export und Datenbereinigung |
| 06 | [`Lastenheft_Secure-InventoryHub_06_Audit-Logging-und-Datenschutz.md`](Lastenheft_Secure-InventoryHub_06_Audit-Logging-und-Datenschutz.md) | Audit-Logging und Datenschutz |
| 07 | [`Lastenheft_Secure-InventoryHub_07_Patch-Wartungs-und-Risikoansicht.md`](Lastenheft_Secure-InventoryHub_07_Patch-Wartungs-und-Risikoansicht.md) | Patch-, Wartungs- und Risikoansicht |
| 08 | [`Lastenheft_Secure-InventoryHub_08_Supply-Chain-SBOM-und-Dependency-Bezug.md`](Lastenheft_Secure-InventoryHub_08_Supply-Chain-SBOM-und-Dependency-Bezug.md) | Supply Chain, SBOM und Dependency-Bezug |
| 09 | [`Lastenheft_Secure-InventoryHub_09_Teststrategie-Sandbox-und-Betriebsnachweise.md`](Lastenheft_Secure-InventoryHub_09_Teststrategie-Sandbox-und-Betriebsnachweise.md) | Teststrategie, Sandbox und Betriebsnachweise |
| 10 | [`Lastenheft_Secure-InventoryHub_10_Review-Kennzahlen-und-Abschlussbewertung.md`](Lastenheft_Secure-InventoryHub_10_Review-Kennzahlen-und-Abschlussbewertung.md) | Review, Kennzahlen und Abschlussbewertung |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für die gesamte Reihe.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-InventoryHub-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Lege auch noch keinen Level-1-/Level-2-Arbeitsraum an. Wähle stattdessen später in einem vorbereiteten Sprach-Repo das nächste konkrete Aufgaben-Lastenheft der Secure InventoryHub-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation.
```
