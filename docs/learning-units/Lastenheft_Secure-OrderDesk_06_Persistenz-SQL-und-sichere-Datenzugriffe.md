# Lastenheft: Secure OrderDesk 06 - Persistenz, SQL und sichere Datenzugriffe

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, DPA, SI
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Sichere relationale Persistenz über eine austauschbare Datenzugriffsschicht wird geplant, bei der jeder
Datenbankzugriff parametrisiert erfolgt und kein dynamisches SQL aus Eingaben zusammengebaut wird. Lernende
wehren SQL-Injection ab, behandeln Kunden- und Bestelleingaben als nicht vertrauenswürdig und arbeiten mit der
Northwind-Datenbasis inkl. `ALFKI`.

**EN:** Safe relational persistence via an exchangeable data access layer is planned, where every database
access is parameterized and no dynamic SQL is assembled from input. Learners defend against SQL injection,
treat customer and order input as untrusted, and work with the Northwind data base including `ALFKI`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung für die parametrisierte Datenzugriffsschicht folgt aus dieser Aufgabe? |
| SI | mittel bis hoch | Welche Datenbank-, Betriebs- oder Sandbox-Annahme (Treiber, Verbindungszeichenkette) muss dokumentiert werden? |
| DPA | hoch | Welche Kundendaten-Datenschutzfrage oder Aussagegrenze hängt an sicheren Abfragen und Filtern? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenverwaltung, relationale Persistenz, SQL-Sicherheit (parametrisierte Queries)
und Datenschutz der Kunden- und Bestelldaten auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects data management, relational persistence, SQL security (parameterized queries), and
privacy of customer and order data at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Basis"): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk_06_Persistenz-SQL-und-sichere-Datenzugriffe.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Basis"): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk_06_Persistenz-SQL-und-sichere-Datenzugriffe.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung (SQL-Sicherheit), Datenschutz, Trust Boundaries an Datenbankgrenzen, Supply Chain bei Treibern/ORM.
- **Checklisten:** CL_01, CL_05, CL_08, CL_11.
- **Mitgeltende Dokumente:** Datenschutzleitlinie, Leitlinie für sichere Programmierung, Richtlinie Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Plane eine austauschbare, relationale Datenzugriffsschicht (Repository- oder Store-Abstraktion) für
Kunden, Produkte, Bestellungen und Bestellpositionen im Northwind-Layout inkl. `ALFKI`. **Jeder Lese- und
Schreibzugriff erfolgt ausschließlich über parametrisierte Statements** (Platzhalter, gebundene Parameter);
dynamisches SQL, das Eingaben per String-Verkettung einbaut, ist verboten. Definiere sichere Abfragen für
typische Fälle wie „Bestellungen eines Kunden", „Produkte einer Kategorie" und „Umsatz je Zeitraum", eine
Fehlerbehandlung ohne interne Details und eine Prüfung, dass Filter-, Sortier- und Suchfelder aus Eingaben
nicht in rohes SQL gelangen. Behandle die Datenbankgrenze als Vertrauens- und Datenabflussstelle. Halte die
Plattform im 1. Lehrjahr bewusst einfach.

**EN:** Plan an exchangeable relational data access layer (repository or store abstraction) for customers,
products, orders, and order lines in Northwind layout including `ALFKI`. **Every read and write access uses
only parameterized statements** (placeholders, bound parameters); dynamic SQL that inserts input via string
concatenation is forbidden. Define safe queries for typical cases such as "orders of a customer", "products of
a category", and "revenue per period", error handling without internal details, and a check that filter, sort,
and search fields from input never reach raw SQL. Treat the database boundary as a trust and data-leak point.
Keep the platform deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Eine Datenzugriffs-Abstraktion trennt den fachlichen Datenvertrag (Kunden, Produkte, Bestellungen, Positionen) von der konkreten relationalen Speicherform; die Persistenzentscheidung ist begründet.
- **R-02:** Alle Datenbankzugriffe sind parametrisiert; es gibt kein dynamisches SQL aus Eingaben. Auch dynamische Teile (z. B. Sortierspalte, Filter) werden nur über eine geprüfte Allowlist, nicht durch String-Verkettung gebildet.
- **R-03:** Kunden- und Bestelleingaben gelten als nicht vertrauenswürdig und werden vor dem Zugriff validiert; Datenbankfehler geben keine internen Details (SQL-Text, Tabellennamen, Stack-Traces) an Endnutzer.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle und Testanker benannt.
- **R-05:** Der fachliche Datenvertrag und das parametrisierte Zugriffsmuster bleiben vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Nur parametrisierte Statements; kein dynamisches SQL aus nicht vertrauenswürdigem Input (SQL-Injection-Abwehr, CWE-89).
- Dynamische Query-Bausteine (Sortierung, Filterspalten, Paginierung) nur über eine feste Allowlist erlaubter Feldnamen abbilden.
- Datenbank- und Zugriffsfehler geben keine internen Details an Endnutzer aus; Details bleiben im internen Log ohne Secrets.
- Kundenbezogene Abfrageergebnisse folgen der Datenminimierung: nur benötigte Kundenfelder werden selektiert und weitergegeben; personenbezogene Testdaten bleiben fiktiv (`ALFKI`), Secrets/Verbindungszeichenketten nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Datenvertrag (Customer, Product, Order, OrderLine im Northwind-Layout inkl. `ALFKI`) bleibt für alle sechs Sprachpfade gleich.
- Jede Sprache setzt parametrisierte Zugriffe testbar um und weist SQL-Injection-Abwehr mit mindestens einem negativen Test nach.
- Sprachspezifische Hinweise (Kurzform): C# ADO.NET/EF Core mit parametrisierten Statements; Go `database/sql` mit Platzhaltern und `context`; Java JDBC/JPA mit `PreparedStatement`/Bind-Parametern; Python DB-API mit Parametern, kein String-Format; Rust `sqlx`/parametrisierte Abfragen; Swift SQLite mit gebundenen Parametern. Kein String-konkateniertes SQL in irgendeiner Sprache.
- MSL-Status ersetzt keine sichere SQL-, Datenschutz- oder Review-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Datenzugriffs-Abstraktion, parametrisiertem Query-Katalog, Fehlerbehandlung, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Persistenzentscheidung mit Begründung, parametrisierter Query-Katalog, Allowlist für dynamische Felder, positive und negative SQL-Injection-Tests (inkl. `ALFKI`-Beispiel).

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Persistenzentscheidung und Alternative sind begründet; die Datenzugriffsschicht ist als Abstraktion beschrieben.
- [ ] Jeder Datenbankzugriff ist parametrisiert; es gibt kein dynamisches SQL aus Eingaben, auch nicht bei Sortier-/Filterfeldern.
- [ ] SQL-Injection wird als Risiko behandelt und mit mindestens einem negativen Test (manipulierte Eingabe) abgedeckt.
- [ ] Datenbankfehler geben keine internen Details an Endnutzer; Kundenabfragen bleiben datensparsam.
- [ ] Die Northwind-/`ALFKI`-Quelle ist als fiktiver Testanker benannt; offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_06_Persistenz-SQL-und-sichere-Datenzugriffe.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine austauschbare relationale Datenzugriffsschicht, ausschließlich parametrisierte Queries, Abwehr von SQL-Injection, eine Allowlist für dynamische Filter-/Sortierfelder, sichere Fehlerbehandlung und SQL-Injection-Tests der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
