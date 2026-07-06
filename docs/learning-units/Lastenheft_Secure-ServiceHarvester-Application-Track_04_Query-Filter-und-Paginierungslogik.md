# Lastenheft: Secure ServiceHarvester Application Track 04 - Query-, Filter- und Paginierungslogik

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

**DE:** Für Listen von Maschinen und Snapshots werden sichere Query-, Filter- und Paginierungsregeln entworfen. Lernende schützen Abfragen mit Feld-Whitelists und parametrisierten Zugriffen, wählen eine begründete Paginierungsstrategie und sichern deterministische Sortierung.

**EN:** Safe query, filter, and pagination rules are designed for lists of machines and snapshots. Learners protect queries with field whitelists and parameterized access, choose a justified pagination strategy, and ensure deterministic ordering.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (Schwerpunkt) | Welche Filter- und Paginierungslogik ist sicher, deterministisch und wartbar? |
| SI | mittel | Welche Last- oder Betriebsannahme folgt aus großen Ergebnismengen? |
| DPA | mittel bis hoch | Welche Datenqualitäts- und Aussagegrenze hat ein gefiltertes Ergebnis? |
| DV | mittel | Welche Schnittstellenparameter beschreiben Filter und Seiten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die AE-Spezialisierung im 3. Lehrjahr. Sie verbindet die Realisierung sicherer Abfragefunktionalität mit der Anpassung der Datenverwaltung.

**EN:** The task supports the AE specialization in year 3. It connects realizing secure query functionality with adapting the data management.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11a („Funktionalität in Anwendungen realisieren")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Application-Track_04_Query-Filter-und-Paginierungslogik.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11a ("Funktionalität in Anwendungen realisieren")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Application-Track_04_Query-Filter-und-Paginierungslogik.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Programmierung, Eingabevalidierung, sichere Architektur, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_03, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Entwirf eine sichere Query-, Filter- und Paginierungslogik für Maschinen- und Snapshot-Listen. Berücksichtige: erlaubte Filterfelder als Whitelist, parametrisierte Abfragen gegen Injection, eine begründete Paginierungsstrategie (Offset gegenüber Cursor), deterministische Sortierung mit eindeutigem Tiebreaker, Obergrenzen für Seitengrößen und robustes Verhalten bei ungültigen Parametern. Trenne Fachlogik, Sicherheitsbezug und Nachweis.

**EN:** Design secure query, filter, and pagination logic for machine and snapshot lists. Consider: allowed filter fields as a whitelist, parameterized queries against injection, a justified pagination strategy (offset versus cursor), deterministic ordering with a unique tiebreaker, upper bounds for page sizes, and robust behavior on invalid parameters. Separate business logic, security aspect, and evidence.

## Anforderungen / Requirements

- **R-01:** Filterfelder, Sortierung und Paginierung sind klar und als Whitelist beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Die Paginierungsstrategie ist mit Trade-off (Offset gegenüber Cursor) begründet.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Der Abfragevertrag bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Filter-, Sortier- und Paginierungsparameter als nicht vertrauenswürdig behandeln und gegen eine Whitelist prüfen.
- Datenzugriffe nur parametrisiert; keine Zeichenkettenverkettung von Feldnamen oder Werten in Abfragen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Abfragevertrag (Felder, Operatoren, Seitengrenzen) bleibt für alle Zielsprachen vergleichbar.
- Sprachspezifische Query-Bibliotheken dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine Prüfung von Eingabevalidierung, Injection-Schutz und Ergebnisgrenzen.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Query-, Filter- und Paginierungslogik.
- `plan.md` mit Abfrage-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Filterfeld-Whitelist, Sortier- und Tiebreaker-Regel, Paginierungs-Trade-off, Negativtestfälle für ungültige Parameter, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Filter, Sortierung und Paginierung sind konsistent, deterministisch und begründet.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens ein Negativtestpfad für ungültige Parameter ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Application-Track_04_Query-Filter-und-Paginierungslogik.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine sichere Query-, Filter- und Paginierungslogik im Application Track der EuFPA-Lernreihe Secure ServiceHarvester Application Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
