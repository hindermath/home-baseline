# Lastenheft: Secure OrderDesk Application Track 03 - Persistenz-Adapter und Repository-Muster

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader (fiktive Handelsfirma / fictional trading company)
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE (Schwerpunkt)
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Der Zugriff auf die relationale Bestelldatenbank wird über ein Repository-Muster mit Port und Adapter entkoppelt. Lernende entwerfen austauschbare Persistenz-Adapter für Kunden, Produkte, Bestellungen und Positionen, halten den Fachkern technikfrei, nutzen ausschließlich parametrisierte Queries und begründen die Grenze mit Testbarkeit und Trade-offs.

**EN:** Access to the relational ordering database is decoupled via a repository pattern with port and adapter. Learners design replaceable persistence adapters for customers, products, orders, and order lines, keep the business core free of technology, use parameterized queries only, and justify the boundary with testability and trade-offs.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (Schwerpunkt) | Welche Port-/Adapter-Grenze macht den Fachkern austauschbar und testbar? |
| SI | mittel | Welche Betriebs- oder Backend-Annahme (Datei, DB) muss dokumentiert werden? |
| DPA | mittel | Welche Datenintegritäts- oder Konsistenzregel (Fremdschlüssel, `ALFKI`) gehört in den Adapter? |
| DV | mittel | Welche Systemgrenze entsteht zwischen Kern und Persistenz-Backend? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die AE-Spezialisierung im 3. Lehrjahr. Sie verbindet die Realisierung wartbarer Funktionalität mit der Anpassung der Datenverwaltung der Bestellplattform über austauschbare Adapter.

**EN:** The task supports the AE specialization in year 3. It connects realizing maintainable functionality with adapting the data management of the ordering platform through replaceable adapters.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"): Der Application Track trägt **LF 10a, LF 11a, LF 12a** (berührt LF 4, LF 5). Für diese Einheit ist **LF 11a („Funktionalität in Anwendungen realisieren")** primär; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"): the Application Track carries **LF 10a, LF 11a, LF 12a** (touches LF 4, LF 5). For this unit **LF 11a ("Funktionalität in Anwendungen realisieren")** is primary; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, Separation of Concerns, sichere Programmierung, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement und Architekturdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Entwirf einen Persistenz-Zugriff nach dem Repository-Muster für die Bestelldomäne. Berücksichtige: einen Persistenz-Port (abstrakte Schnittstelle) im Fachkern für Kunden, Produkte, Bestellungen und Positionen, mindestens zwei denkbare Adapter (z. B. Datei und relationale Datenbank), klare Transaktions- und Fehlergrenzen (Master-Detail zwischen `Order` und `OrderLine`), ausschließlich parametrisierte Datenzugriffe gegen SQL-Injection und einen In-Memory-Fake mit `ALFKI` für Tests. Begründe die Abhängigkeitsrichtung und die Grenze mit Trade-offs.

**EN:** Design persistence access following the repository pattern for the ordering domain. Consider: a persistence port (abstract interface) in the business core for customers, products, orders, and order lines, at least two conceivable adapters (e.g. file and relational database), clear transaction and error boundaries (master-detail between `Order` and `OrderLine`), parameterized data access only against SQL injection, and an in-memory fake with `ALFKI` for tests. Justify the dependency direction and the boundary with trade-offs.

## Anforderungen / Requirements

- **R-01:** Port und Adapter sind klar getrennt und die Abhängigkeitsrichtung ist beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Ein In-Memory-Fake oder gleichwertiger Testadapter mit `ALFKI` ist als Testpfad benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle benannt.
- **R-05:** Der Repository-Vertrag bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; `ALFKI` und alle Erweiterungen sind fiktiv.
- Datenzugriffe nur parametrisiert; kein dynamisches SQL aus nicht vertrauenswürdigem Input (SQL-Injection-Abwehr, CWE-89).
- Verbindungszeichenketten und Zugangsdaten nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`, nie im Quellcode oder in Git-getrackten Dateien.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Repository-Port bleibt für alle Zielsprachen als vergleichbarer Vertrag beschreibbar.
- Sprachspezifische Persistenz-Bibliotheken dürfen gewählt werden, müssen aber begründet werden; parametrisierte Zugriffe sind Pflicht (C# ADO.NET/EF Core, Go `database/sql`, Java JDBC `PreparedStatement`, Python DB-API, Rust `sqlx`, Swift SQLite mit gebundenen Parametern).
- MSL-Status ersetzt keine Prüfung von Datenzugriff, Transaktionsgrenzen, Fehlerbehandlung und Secrets.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für den Persistenz-Adapter und das Repository-Muster.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Port-/Adapter-Skizze, Abhängigkeitsregel, Transaktions-/Fehlergrenzen, parametrisiertes Zugriffsmuster, Testadapter-Beschreibung mit `ALFKI`, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Der Fachkern hängt nur vom Port ab, nicht vom konkreten Adapter.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Ein Testadapter (z. B. In-Memory-Fake mit `ALFKI`) ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für einen austauschbaren Persistenz-Adapter nach dem Repository-Muster mit ausschließlich parametrisierten Queries auf der Northwind-Bestelldomäne (Kundenfirma Secure Trader, inkl. ALFKI) im Application Track der EuFPA-Lernreihe Secure OrderDesk Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
