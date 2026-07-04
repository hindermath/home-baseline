# Lastenheft: Secure CaseTracker v2 Lernreihe

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

**DE:** EuFPA möchte den bisherigen Secure CaseTracker zu einer Service Edition ausbauen. Die Reihe vertieft Architektur, Persistenz, API-/Service-Grenzen, Autorisierung, Audit-Logging, Tests, CI, Sandbox, Betrieb, Schnittstellenbetrachtung und MSL-Vergleich.

**EN:** EuFPA wants to extend the existing Secure CaseTracker into a service edition. The series deepens architecture, persistence, API/service boundaries, authorization, audit logging, tests, CI, sandbox, operation, interface review, and MSL comparison.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei | Thema |
|---:|---|---|
| 01 | [`Lastenheft_Secure-CaseTracker-v2_01_Architekturzielbild-und-Systemgrenzen.md`](Lastenheft_Secure-CaseTracker-v2_01_Architekturzielbild-und-Systemgrenzen.md) | Architekturzielbild und Systemgrenzen |
| 02 | [`Lastenheft_Secure-CaseTracker-v2_02_Persistenzmodell-und-Migrationen.md`](Lastenheft_Secure-CaseTracker-v2_02_Persistenzmodell-und-Migrationen.md) | Persistenzmodell und Migrationen |
| 03 | [`Lastenheft_Secure-CaseTracker-v2_03_API-und-Service-Vertrag.md`](Lastenheft_Secure-CaseTracker-v2_03_API-und-Service-Vertrag.md) | API- und Service-Vertrag |
| 04 | [`Lastenheft_Secure-CaseTracker-v2_04_Fehler-Validierungs-und-Response-Modell.md`](Lastenheft_Secure-CaseTracker-v2_04_Fehler-Validierungs-und-Response-Modell.md) | Fehler-, Validierungs- und Response-Modell |
| 05 | [`Lastenheft_Secure-CaseTracker-v2_05_Rollen-und-Autorisierungsmatrix.md`](Lastenheft_Secure-CaseTracker-v2_05_Rollen-und-Autorisierungsmatrix.md) | Rollen- und Autorisierungsmatrix |
| 06 | [`Lastenheft_Secure-CaseTracker-v2_06_Audit-Logging-und-Datenschutz.md`](Lastenheft_Secure-CaseTracker-v2_06_Audit-Logging-und-Datenschutz.md) | Audit-Logging und Datenschutz |
| 07 | [`Lastenheft_Secure-CaseTracker-v2_07_Import-und-Export-Haertung.md`](Lastenheft_Secure-CaseTracker-v2_07_Import-und-Export-Haertung.md) | Import- und Export-Härtung |
| 08 | [`Lastenheft_Secure-CaseTracker-v2_08_Teststrategie-und-CI-Nachweise.md`](Lastenheft_Secure-CaseTracker-v2_08_Teststrategie-und-CI-Nachweise.md) | Teststrategie und CI-Nachweise |
| 09 | [`Lastenheft_Secure-CaseTracker-v2_09_Sandbox-und-Betriebsnachweise.md`](Lastenheft_Secure-CaseTracker-v2_09_Sandbox-und-Betriebsnachweise.md) | Sandbox- und Betriebsnachweise |
| 10 | [`Lastenheft_Secure-CaseTracker-v2_10_MSL-Vergleich-und-Abschlussreview.md`](Lastenheft_Secure-CaseTracker-v2_10_MSL-Vergleich-und-Abschlussreview.md) | MSL-Vergleich und Abschlussreview |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für die gesamte Reihe.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-v2-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Lege auch noch keinen Level-1-/Level-2-Arbeitsraum an. Wähle stattdessen später in einem vorbereiteten Sprach-Repo das nächste konkrete Aufgaben-Lastenheft der Secure CaseTracker v2-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation.
```
