# Lastenheft: Secure OrderDesk v2 Lernreihe

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt die gesamte Lernreihe als Gesamtlandkarte. Es ist nicht dafür gedacht, als ein einzelner großer Spec-Kit-Lauf gestartet zu werden. Die Übersicht der Reihe steht in [`Secure-OrderDesk-v2-Lernreihe.md`](Secure-OrderDesk-v2-Lernreihe.md).

**EN:** This master intake describes the complete learning series as an overview map. It is not meant to be started as one large Spec Kit run. The series overview lives in [`Secure-OrderDesk-v2-Lernreihe.md`](Secure-OrderDesk-v2-Lernreihe.md).

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

**DE:** EuFPA möchte den bisherigen Secure OrderDesk für die fiktive Handelsfirma Secure Trader von einem einfachen Bestell-Programm zu einer sauber geschnittenen, relationalen Handelsplattform ausbauen. Die Reihe vertieft Architektur und Systemgrenzen, plattformübergreifendes Hosting und Lebenszyklus, relationales Persistenzmodell und Backend-Abstraktion, Bestellannahme mit Idempotenz und Import-Härtung, API-/Service-Vertrag, Fehler- und Response-Modell, Autorisierung und Audit-Logging, Betrieb und Monitoring, sichere Konfiguration sowie MSL-Vergleich. Die verbindliche Northwind-Datenbasis inklusive Pflicht-Datensatz `ALFKI` bleibt gültig und wird technisch tiefer und mit parametrisierten SQL-Zugriffen umgesetzt.

**EN:** EuFPA wants to extend the existing Secure OrderDesk for the fictional trading company Secure Trader from a simple ordering program into a cleanly separated, relational trading platform. The series deepens architecture and system boundaries, cross-platform hosting and lifecycle, the relational persistence model and backend abstraction, order intake with idempotency and import hardening, the API/service contract, the error and response model, authorization and audit logging, operation and monitoring, secure configuration, and MSL comparison. The binding Northwind data base including the mandatory record `ALFKI` stays valid and is implemented at greater technical depth with parameterized SQL access.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei | Thema |
|---:|---|---|
| 01 | [`Lastenheft_Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.md`](Lastenheft_Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.md) | Architekturzielbild und Systemgrenzen |
| 02 | [`Lastenheft_Secure-OrderDesk-v2_02_Plattformuebergreifendes-Hosting-und-Lebenszyklus.md`](Lastenheft_Secure-OrderDesk-v2_02_Plattformuebergreifendes-Hosting-und-Lebenszyklus.md) | Plattformübergreifendes Hosting und Lebenszyklus |
| 03 | [`Lastenheft_Secure-OrderDesk-v2_03_Relationales-Persistenzmodell-und-Backend-Abstraktion.md`](Lastenheft_Secure-OrderDesk-v2_03_Relationales-Persistenzmodell-und-Backend-Abstraktion.md) | Relationales Persistenzmodell und Backend-Abstraktion |
| 04 | [`Lastenheft_Secure-OrderDesk-v2_04_Bestellannahme-Idempotenz-und-Import-Haertung.md`](Lastenheft_Secure-OrderDesk-v2_04_Bestellannahme-Idempotenz-und-Import-Haertung.md) | Bestellannahme: Idempotenz und Import-Härtung |
| 05 | [`Lastenheft_Secure-OrderDesk-v2_05_API-und-Service-Vertrag-und-OpenAPI.md`](Lastenheft_Secure-OrderDesk-v2_05_API-und-Service-Vertrag-und-OpenAPI.md) | API- und Service-Vertrag und OpenAPI |
| 06 | [`Lastenheft_Secure-OrderDesk-v2_06_Fehler-Validierungs-und-Response-Modell.md`](Lastenheft_Secure-OrderDesk-v2_06_Fehler-Validierungs-und-Response-Modell.md) | Fehler-, Validierungs- und Response-Modell |
| 07 | [`Lastenheft_Secure-OrderDesk-v2_07_Rollen-Autorisierung-und-Audit-Logging.md`](Lastenheft_Secure-OrderDesk-v2_07_Rollen-Autorisierung-und-Audit-Logging.md) | Rollen-, Autorisierung und Audit-Logging |
| 08 | [`Lastenheft_Secure-OrderDesk-v2_08_Betrieb-Logging-Health-und-Monitoring.md`](Lastenheft_Secure-OrderDesk-v2_08_Betrieb-Logging-Health-und-Monitoring.md) | Betrieb, Logging, Health und Monitoring |
| 09 | [`Lastenheft_Secure-OrderDesk-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md`](Lastenheft_Secure-OrderDesk-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md) | Sichere Konfiguration, Secrets und Betriebsnachweise |
| 10 | [`Lastenheft_Secure-OrderDesk-v2_10_MSL-Vergleich-und-Abschlussreview.md`](Lastenheft_Secure-OrderDesk-v2_10_MSL-Vergleich-und-Abschlussreview.md) | MSL-Vergleich und Abschlussreview |

## Datenbasis / Data Base

**DE:** Verbindliche Datenquelle bleibt die klassische Northwind-Sample-Datenbank mit Layout und Daten, inklusive Pflicht-Datensatz `ALFKI`. Alle Daten sind fiktiv und werden markenneutral und rein didaktisch genutzt. „Microsoft“ wird nur als historischer Quellhinweis auf den Ursprung der Northwind-Beispieldatenbank erwähnt. SQL-Zugriffe müssen parametrisiert sein; es werden keine echten Secrets und keine echten personenbezogenen Daten verwendet.

**EN:** The binding data source stays the classic Northwind sample database with layout and data, including the mandatory record `ALFKI`. All data is fictional and used brand-neutrally and purely for teaching. "Microsoft" is mentioned only as a historical source note for the origin of the Northwind sample database. SQL access must be parameterized; no real secrets and no real personal data are used.

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für die gesamte Reihe.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-v2-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Lege auch noch keinen Level-1-/Level-2-Arbeitsraum an. Wähle stattdessen später in einem vorbereiteten Sprach-Repo das nächste konkrete Aufgaben-Lastenheft der Secure OrderDesk v2-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation. Die verbindliche Datenbasis ist die Northwind-Sample-Datenbank inklusive `ALFKI`; SQL-Zugriffe müssen parametrisiert sein.
```
