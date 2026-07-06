# Lastenheft: Secure ServiceHarvester v2 03 - Persistenzmodell und Backend-Abstraktion

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Eine Speicher-Abstraktion (z. B. `IDbService`), der Backend-Wechsel SQLite → PostgreSQL → MongoDB hinter einer stabilen Schnittstelle, parametrisierte Queries, Pflichtfelder und Datenminimierung werden geplant. Lernende trennen den fachlichen Speichervertrag von der konkreten Ablage.

**EN:** A storage abstraction (e.g. `IDbService`), the backend switch SQLite → PostgreSQL → MongoDB behind a stable interface, parameterized queries, mandatory fields, and data minimization are planned. Learners separate the storage contract from the concrete backend.

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
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure ServiceHarvester v2"): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 8 („Daten systemübergreifend bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-v2_03_Persistenzmodell-und-Backend-Abstraktion.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure ServiceHarvester v2"): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 8 ("Daten systemübergreifend bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-v2_03_Persistenzmodell-und-Backend-Abstraktion.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_08, CL_10.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für ein persistentes Datenmodell mit austauschbarem Backend eine fokussierte Spezifikation. Berücksichtige: eine stabile Speicher-Abstraktion (z. B. `IDbService`), der Wechsel SQLite → PostgreSQL → MongoDB ohne Änderung der Fachlogik, parametrisierte Queries gegen Injection, Pflichtfelder, Datenminimierung und Testdatenregeln werden geplant.

**EN:** Prepare a focused specification for a persistent data model with a swappable backend. Consider: a stable storage abstraction (e.g. `IDbService`), the switch SQLite → PostgreSQL → MongoDB without changing the business logic, parameterized queries against injection, mandatory fields, data minimization, and test-data rules. Keep the later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang und der Speichervertrag sind klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Eingaben, Queries, Konfiguration, Verbindungszeichenketten, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Speicher-Abstraktion (`IDbService`), Backend-Vergleich SQLite/PostgreSQL/MongoDB, Query-Parametrisierung, Datenmodell, Datenschutzbegründung.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Die Abstraktion trennt Fachlogik und Backend so, dass ein Backend-Wechsel möglich ist.
- [ ] Parametrisierte Queries sind als Test- oder Reviewpfad benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-v2_03_Persistenzmodell-und-Backend-Abstraktion.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein persistentes Datenmodell mit austauschbarem Backend (SQLite, PostgreSQL, MongoDB) hinter einer stabilen Abstraktion der EuFPA-Lernreihe Secure ServiceHarvester v2. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
