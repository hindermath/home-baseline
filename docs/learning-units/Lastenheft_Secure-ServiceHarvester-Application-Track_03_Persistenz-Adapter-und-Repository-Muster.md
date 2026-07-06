# Lastenheft: Secure ServiceHarvester Application Track 03 - Persistenz-Adapter und Repository-Muster

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** AE - Anwendungsentwicklung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenzprojekt / C# reference project:** `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Der Zugriff auf gespeicherte Statusdaten wird über ein Repository-Muster mit Port und Adapter entkoppelt. Lernende entwerfen austauschbare Persistenz-Adapter, halten den Fachkern technikfrei und begründen die Grenze mit Testbarkeit und Trade-offs.

**EN:** Access to stored status data is decoupled via a repository pattern with port and adapter. Learners design replaceable persistence adapters, keep the business core free of technology, and justify the boundary with testability and trade-offs.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (Schwerpunkt) | Welche Port-/Adapter-Grenze macht den Fachkern austauschbar und testbar? |
| SI | mittel | Welche Betriebs- oder Backend-Annahme (Datei, DB) muss dokumentiert werden? |
| DPA | mittel | Welche Datenintegritäts- oder Konsistenzregel gehört in den Adapter? |
| DV | mittel | Welche Systemgrenze entsteht zwischen Kern und Persistenz-Backend? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die AE-Spezialisierung im 3. Lehrjahr. Sie verbindet die Realisierung wartbarer Funktionalität mit der Anpassung der Datenverwaltung über austauschbare Adapter.

**EN:** The task supports the AE specialization in year 3. It connects realizing maintainable functionality with adapting the data management through replaceable adapters.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11a („Funktionalität in Anwendungen realisieren")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11a ("Funktionalität in Anwendungen realisieren")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, Separation of Concerns, sichere Programmierung, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement und Architekturdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Entwirf einen Persistenz-Zugriff nach dem Repository-Muster. Berücksichtige: einen Persistenz-Port (abstrakte Schnittstelle) im Fachkern, mindestens zwei denkbare Adapter (z. B. Datei und Datenbank), klare Transaktions- und Fehlergrenzen, parametrisierte Datenzugriffe gegen Injection und einen In-Memory-Fake für Tests. Begründe die Abhängigkeitsrichtung und die Grenze mit Trade-offs.

**EN:** Design persistence access following the repository pattern. Consider: a persistence port (abstract interface) in the business core, at least two conceivable adapters (e.g. file and database), clear transaction and error boundaries, parameterized data access against injection, and an in-memory fake for tests. Justify the dependency direction and the boundary with trade-offs.

## Anforderungen / Requirements

- **R-01:** Port und Adapter sind klar getrennt und die Abhängigkeitsrichtung ist beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Ein In-Memory-Fake oder gleichwertiger Testadapter ist als Testpfad benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Der Repository-Vertrag bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Datenzugriffe nur parametrisiert; kein dynamisches SQL aus nicht vertrauenswürdigem Input.
- Verbindungszeichenketten und Zugangsdaten nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`, nie im Quellcode oder in Git-getrackten Dateien.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Repository-Port bleibt für alle Zielsprachen als vergleichbarer Vertrag beschreibbar.
- Sprachspezifische Persistenz-Bibliotheken dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine Prüfung von Datenzugriff, Transaktionsgrenzen, Fehlerbehandlung und Secrets.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für den Persistenz-Adapter und das Repository-Muster.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Port-/Adapter-Skizze, Abhängigkeitsregel, Transaktions-/Fehlergrenzen, Testadapter-Beschreibung, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Der Fachkern hängt nur vom Port ab, nicht vom konkreten Adapter.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Ein Testadapter (z. B. In-Memory-Fake) ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Application-Track_03_Persistenz-Adapter-und-Repository-Muster.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für einen austauschbaren Persistenz-Adapter nach dem Repository-Muster im Application Track der EuFPA-Lernreihe Secure ServiceHarvester Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
