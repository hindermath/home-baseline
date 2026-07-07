# Lastenheft: Secure OrderDesk v2 03 - Relationales Persistenzmodell und Backend-Abstraktion

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Eine relationale Speicher-Abstraktion (z. B. `IOrderStore`/`IDbService`), der Backend-Wechsel SQLite → PostgreSQL → SQL Server hinter einer stabilen Schnittstelle, ausschließlich parametrisierte Queries, Pflichtfelder und Datenminimierung werden geplant. Lernende trennen den fachlichen Speichervertrag für Kunden, Produkte, Bestellungen und Positionen von der konkreten relationalen Ablage. Die Northwind-Basis inkl. `ALFKI` ist Test- und Nachweisanker.

**EN:** A relational storage abstraction (e.g. `IOrderStore`/`IDbService`), the backend switch SQLite → PostgreSQL → SQL Server behind a stable interface, exclusively parameterized queries, mandatory fields, and data minimization are planned. Learners separate the storage contract for customers, products, orders, and order lines from the concrete relational backend. The Northwind base incl. `ALFKI` is the test and evidence anchor.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel bis hoch | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Projektplanung, sichere Entwicklung, Qualitätssicherung, Betrieb und dokumentierte Bewertung auf dem Niveau ab dem 2. Lehrjahr.

**EN:** The task connects customer task, project planning, secure development, quality assurance, operation, and documented assessment at second-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk v2"): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 8 („Daten systemübergreifend bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-v2_03_Relationales-Persistenzmodell-und-Backend-Abstraktion.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk v2"): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 8 ("Daten systemübergreifend bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-v2_03_Relationales-Persistenzmodell-und-Backend-Abstraktion.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für ein relationales Persistenzmodell mit austauschbarem Backend eine fokussierte Spezifikation. Berücksichtige: eine stabile Speicher-Abstraktion (z. B. `IOrderStore`), das Northwind-Kernlayout (`Customers`, `Products`, `Categories`, `Orders`, `Order Details`) mit Primär- und Fremdschlüsseln, der Wechsel SQLite → PostgreSQL → SQL Server ohne Änderung der Fachlogik, **ausschließlich parametrisierte Queries** gegen SQL-Injection (CWE-89), eine Allowlist für dynamische Filter-/Sortierfelder, Pflichtfelder, Datenminimierung und Testdatenregeln werden geplant. `ALFKI` bleibt als Beispiel- und Testanker aktiv.

**EN:** Prepare a focused specification for a relational persistence model with a swappable backend. Consider: a stable storage abstraction (e.g. `IOrderStore`), the Northwind core layout (`Customers`, `Products`, `Categories`, `Orders`, `Order Details`) with primary and foreign keys, the switch SQLite → PostgreSQL → SQL Server without changing the business logic, **exclusively parameterized queries** against SQL injection (CWE-89), an allow-list for dynamic filter/sort fields, mandatory fields, data minimization, and test-data rules. `ALFKI` stays active as example and test anchor. Keep the later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang und der Speichervertrag (Kunden, Produkte, Bestellungen, Positionen) sind klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; `ALFKI` und alle Erweiterungen sind fiktiv.
- Nur parametrisierte Statements; kein dynamisches SQL aus nicht vertrauenswürdigem Input; Eingaben, Queries, Konfiguration, Verbindungszeichenketten, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen; Datenbankfehler geben keine internen Details (SQL-Text, Tabellennamen, Stack-Traces) an Endnutzer.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden (C# ADO.NET/EF Core, Go `database/sql`, Java JDBC/JPA, Python DB-API, Rust `sqlx`, Swift SQLite – jeweils mit gebundenen Parametern).
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Speicher-Abstraktion (`IOrderStore`), Backend-Vergleich SQLite/PostgreSQL/SQL Server, parametrisierter Query-Katalog, Allowlist für dynamische Felder, positive und negative SQL-Injection-Tests (inkl. `ALFKI`-Beispiel), Datenschutzbegründung.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Die Abstraktion trennt Fachlogik und Backend so, dass ein Backend-Wechsel (SQLite/PostgreSQL/SQL Server) möglich ist.
- [ ] Parametrisierte Queries und mindestens ein negativer SQL-Injection-Test sind als Test- oder Reviewpfad benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-v2_03_Relationales-Persistenzmodell-und-Backend-Abstraktion.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein relationales Persistenzmodell mit austauschbarem Backend (SQLite, PostgreSQL, SQL Server) hinter einer stabilen Abstraktion, ausschließlich parametrisierten Queries und SQL-Injection-Tests der EuFPA-Lernreihe Secure OrderDesk v2 (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
