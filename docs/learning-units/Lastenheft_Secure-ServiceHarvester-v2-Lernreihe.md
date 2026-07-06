# Lastenheft: Secure ServiceHarvester v2 Lernreihe

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt die gesamte Lernreihe als Gesamtlandkarte. Es ist nicht dafür gedacht, als ein einzelner großer Spec-Kit-Lauf gestartet zu werden. Die Übersicht der Reihe steht in [`Secure-ServiceHarvester-v2-Lernreihe.md`](Secure-ServiceHarvester-v2-Lernreihe.md).

**EN:** This master intake describes the complete learning series as an overview map. It is not meant to be started as one large Spec Kit run. The series overview lives in [`Secure-ServiceHarvester-v2-Lernreihe.md`](Secure-ServiceHarvester-v2-Lernreihe.md).

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

**DE:** EuFPA möchte den bisherigen Secure ServiceHarvester zu einer sauber geschnittenen Dienst-Edition ausbauen. Die Reihe vertieft Architektur, plattformübergreifendes Dienst-Hosting, Persistenz- und Backend-Abstraktion, Harvester-Härtung, API-/Service-Vertrag, Fehler- und Response-Modell, Autorisierung und Audit-Logging, Betrieb und Monitoring, sichere Konfiguration sowie MSL-Vergleich. Als C#-Referenz dient `InventarWorkerService`.

**EN:** EuFPA wants to extend the existing Secure ServiceHarvester into a cleanly separated service edition. The series deepens architecture, cross-platform service hosting, persistence and backend abstraction, harvester hardening, the API/service contract, the error and response model, authorization and audit logging, operation and monitoring, secure configuration, and MSL comparison. The C# reference is `InventarWorkerService`.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei | Thema |
|---:|---|---|
| 01 | [`Lastenheft_Secure-ServiceHarvester-v2_01_Architekturzielbild-und-Systemgrenzen.md`](Lastenheft_Secure-ServiceHarvester-v2_01_Architekturzielbild-und-Systemgrenzen.md) | Architekturzielbild und Systemgrenzen |
| 02 | [`Lastenheft_Secure-ServiceHarvester-v2_02_Plattformuebergreifendes-Dienst-Hosting-und-Lebenszyklus.md`](Lastenheft_Secure-ServiceHarvester-v2_02_Plattformuebergreifendes-Dienst-Hosting-und-Lebenszyklus.md) | Plattformübergreifendes Dienst-Hosting und Lebenszyklus |
| 03 | [`Lastenheft_Secure-ServiceHarvester-v2_03_Persistenzmodell-und-Backend-Abstraktion.md`](Lastenheft_Secure-ServiceHarvester-v2_03_Persistenzmodell-und-Backend-Abstraktion.md) | Persistenzmodell und Backend-Abstraktion |
| 04 | [`Lastenheft_Secure-ServiceHarvester-v2_04_Harvester-Zeitplanung-Idempotenz-und-Import-Haertung.md`](Lastenheft_Secure-ServiceHarvester-v2_04_Harvester-Zeitplanung-Idempotenz-und-Import-Haertung.md) | Harvester: Zeitplanung, Idempotenz und Import-Härtung |
| 05 | [`Lastenheft_Secure-ServiceHarvester-v2_05_API-und-Service-Vertrag-und-OpenAPI.md`](Lastenheft_Secure-ServiceHarvester-v2_05_API-und-Service-Vertrag-und-OpenAPI.md) | API- und Service-Vertrag und OpenAPI |
| 06 | [`Lastenheft_Secure-ServiceHarvester-v2_06_Fehler-Validierungs-und-Response-Modell.md`](Lastenheft_Secure-ServiceHarvester-v2_06_Fehler-Validierungs-und-Response-Modell.md) | Fehler-, Validierungs- und Response-Modell |
| 07 | [`Lastenheft_Secure-ServiceHarvester-v2_07_Rollen-Autorisierung-und-Audit-Logging.md`](Lastenheft_Secure-ServiceHarvester-v2_07_Rollen-Autorisierung-und-Audit-Logging.md) | Rollen-, Autorisierung und Audit-Logging |
| 08 | [`Lastenheft_Secure-ServiceHarvester-v2_08_Betrieb-Logging-Health-und-Monitoring.md`](Lastenheft_Secure-ServiceHarvester-v2_08_Betrieb-Logging-Health-und-Monitoring.md) | Betrieb, Logging, Health und Monitoring |
| 09 | [`Lastenheft_Secure-ServiceHarvester-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md`](Lastenheft_Secure-ServiceHarvester-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md) | Sichere Konfiguration, Secrets und Betriebsnachweise |
| 10 | [`Lastenheft_Secure-ServiceHarvester-v2_10_MSL-Vergleich-und-Abschlussreview.md`](Lastenheft_Secure-ServiceHarvester-v2_10_MSL-Vergleich-und-Abschlussreview.md) | MSL-Vergleich und Abschlussreview |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für die gesamte Reihe.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-v2-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Lege auch noch keinen Level-1-/Level-2-Arbeitsraum an. Wähle stattdessen später in einem vorbereiteten Sprach-Repo das nächste konkrete Aufgaben-Lastenheft der Secure ServiceHarvester v2-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation.
```
