# Lastenheft: Secure OrderDesk Application Track Lernreihe

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt den AE - Anwendungsentwicklung-Track von Secure OrderDesk als Gesamtlandkarte. Es ist nicht dafür gedacht, als einzelner großer Spec-Kit-Lauf gestartet zu werden.

**EN:** This master intake describes the Application Development track of Secure OrderDesk as an overview map. It is not meant to be started as one large Spec Kit run.

## Zielgruppe / Target Group

| Merkmal / Aspect | Einordnung / Classification |
|---|---|
| Lehrjahr / Training year | ab dem 3. Lehrjahr |
| Spezialisierung / Specialization | AE - Anwendungsentwicklung |
| MSL-Sprachen | C#, Go, Java, Python, Rust, Swift |
| Referenz / Reference | C#-Referenz `SecureOrderDesk-CSharp`, Level-1 `SecureOrderDeskProjects` |
| Baseline-Bezug / Baseline | Tag `learning/year-2-complete` |
| Sprache / Language | DE-first, EN-second, CEFR B2 |
| Barrierefreiheit / Accessibility | WCAG 2.2 AA, textfreundliches Markdown |
| Stand / Date | 2026-07-07 |

## Gesamtziel / Overall Goal

**DE:** Der Application Track vertieft die sichere Feature- und Schnittstellenentwicklung der relationalen Handels-/Bestellplattform für die fiktive Handelsfirma Secure Trader. Lernende planen gut geschnittene Funktionen auf der Northwind-Bestelldomäne (Kunden, Produkte, Bestellungen, Bestellpositionen inkl. `ALFKI`), saubere Persistenz-Adapter mit parametrisierten Queries, robuste Query- und Paginierungslogik, eine wartbare Oberfläche (Viewer oder CLI), sichere Serialisierung und eine belastbare Teststrategie.

**EN:** The Application Track deepens secure feature and interface development of the relational trading/ordering platform for the fictional trading company Secure Trader. Learners plan well-scoped functions on the Northwind ordering domain (customers, products, orders, order lines incl. `ALFKI`), clean persistence adapters with parameterized queries, robust query and pagination logic, a maintainable interface (viewer or CLI), secure serialization, and a robust test strategy.

## Aufgaben-Intakes / Task Intakes

| Nr. | Datei (Glob) | Thema |
|---:|---|---|
| 01 | `Lastenheft_Secure-OrderDesk-Application-Track_01_*.md` | Track-Baseline und Feature-Zielbild |
| 02 | `Lastenheft_Secure-OrderDesk-Application-Track_02_*.md` | API-Erweiterung und Ressourcenmodell |
| 03 | `Lastenheft_Secure-OrderDesk-Application-Track_03_*.md` | Persistenz-Adapter und Repository-Muster |
| 04 | `Lastenheft_Secure-OrderDesk-Application-Track_04_*.md` | Query-, Filter- und Paginierungslogik |
| 05 | `Lastenheft_Secure-OrderDesk-Application-Track_05_*.md` | Viewer- oder Client-Oberfläche (barrierefrei) |
| 06 | `Lastenheft_Secure-OrderDesk-Application-Track_06_*.md` | Fehlerbehandlung und Validierung vertieft |
| 07 | `Lastenheft_Secure-OrderDesk-Application-Track_07_*.md` | Erweiterbarkeit und Konfigurierbarkeit |
| 08 | `Lastenheft_Secure-OrderDesk-Application-Track_08_*.md` | Sichere Serialisierung und Schnittstellenverträge |
| 09 | `Lastenheft_Secure-OrderDesk-Application-Track_09_*.md` | Teststrategie: Unit, Integration und Contract-Tests |
| 10 | `Lastenheft_Secure-OrderDesk-Application-Track_10_*.md` | Feature-Review, Trade-offs und Abschluss |

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für den gesamten Track.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track-Lernreihe.md nur als Track-Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Wähle stattdessen später im passenden AE - Anwendungsentwicklung-Repo das nächste konkrete Aufgaben-Lastenheft der Secure OrderDesk Application Track-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation. Die verbindliche Datenbasis ist die Northwind-Sample-Datenbank inklusive `ALFKI`; SQL-Zugriffe müssen parametrisiert sein.
```
