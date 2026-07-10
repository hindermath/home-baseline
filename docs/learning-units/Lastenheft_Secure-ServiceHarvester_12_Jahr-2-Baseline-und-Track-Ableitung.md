# Lastenheft: Secure ServiceHarvester 12 - Jahr-2-Baseline und Track-Ableitung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Abschluss- und Vorbereitungs-Intake nach Jahr 2
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere spezialisierte Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Der abgeschlossene Jahr-2-Stand des Secure ServiceHarvester wird als nachvollziehbare Baseline gesichert; daraus werden spätere Jahr-3-Spezialisierungspfade für AE, SI, DPA und DV abgeleitet, ohne bei den Spezialisierungen wieder bei einem leeren Projekt zu starten.

**EN:** The completed year-2 Secure ServiceHarvester state is preserved as a traceable baseline; later year-3 specialization paths for AE, SI, DPA, and DV are derived from it without starting the specializations from an empty project again.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Architektur- oder Implementierungsentscheidung darf der Application Track nicht verlieren? |
| SI | hoch | Welche Betriebs-, Sandbox- oder CI-Annahme muss vor dem Operations Track stabil sein? |
| DPA | hoch | Welche Datenqualitäts- oder Kennzahlenannahme muss vor dem Data-&-Process-Track dokumentiert sein? |
| DV | hoch | Welche Systemgrenze, Schnittstelle oder Kommunikationsannahme muss vor dem Digital-Networking-Track dokumentiert sein? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt Projektabschluss, Versionsstand, Übergabe, Qualitätssicherung, Dokumentation und fachrichtungsspezifische Weiterentwicklung auf dem Niveau ab dem 1. Lehrjahr mit Ausblick auf Jahr 2 und Jahr 3.

**EN:** The task supports project closure, version state, handover, quality assurance, documentation, and specialization-specific continuation at first-year level with an outlook to years 2 and 3.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_12_Jahr-2-Baseline-und-Track-Ableitung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_12_Jahr-2-Baseline-und-Track-Ableitung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** auditfähige Evidenz, sichere Übergabe, MSL-Präferenz, sichere Architektur, sichere Code-Erzeugung.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie für sichere Programmierung, Richtlinie Secure Development Life Cycle, Richtlinie Testmanagement, Leitlinie Sichere Entwicklungs-Sandbox.
- **Presets:** alle sechs Governance-Presets als Nachweisrahmen für den Jahr-2-Abschluss.

## Aufgabenstellung / Task

**DE:** Prüfe den abgeschlossenen Jahr-2-Stand eines Secure-ServiceHarvester-Sprachrepos. Dokumentiere, ob Build, Tests, Secure-Development-Basis, Presets, offene Risiken und `N/A`-Begründungen für eine spätere Spezialisierung belastbar genug sind. Bereite anschließend die Ableitung für Jahr 3 vor: ein nachvollziehbarer Baseline-Stand mit Tag `learning/year-2-complete` und eine spätere abgeleitete Track-Kopie oder ein Track-Repo. Ein Plattform-Fork ist optional, wenn die Plattformhistorie bewusst sichtbar bleiben soll.

**EN:** Review the completed year-2 state of a Secure ServiceHarvester language repository. Document whether build, tests, the secure-development baseline, presets, open risks, and `N/A` rationales are strong enough for later specialization. Then prepare the year-3 derivation: a traceable baseline state with the tag `learning/year-2-complete` and a later derived track copy or track repository. A platform-native fork is optional when platform history should stay visible.

## Anforderungen / Requirements

- **R-01:** Der Jahr-2-Ausgangsstand ist eindeutig über Commit und Tag `learning/year-2-complete` identifizierbar.
- **R-02:** Build- und Teststatus sowie Verfügbarkeit von Secure-Development-Basis und Presets sind dokumentiert.
- **R-03:** Offene Risiken werden in die Baseline übernommen, nicht gelöscht; `N/A`-Entscheidungen und Nachweisgrenzen sind sichtbar.
- **R-04:** Jahr 3 wird als begründete Ableitung geplant, nicht als Neubeginn; pro Sprache und Fachrichtung nur der tatsächlich benötigte Track.
- **R-05:** Die Baseline bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Track-Ableitungen dürfen keine Secrets, privaten Tokens oder lokalen Entwicklerpfade übernehmen; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Positive Aussagen zu Sicherheit, Qualität oder Compliance brauchen konkrete Evidenz.
- Die Baseline enthält keine echten Kundendaten; Beispiel- und Testdaten bleiben fiktiv.
- Datenschutzannahmen aus Jahr 2 werden auf Aktualität geprüft und bei Bedarf als Folgeaufgabe markiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Die Baseline-Prüfung bewertet Build, Tests, Evidenz und Risiken unabhängig von der Zielprogrammiersprache.
- Jede Sprache nennt Build-/Testkommando und offene Toolchain-Fragen für den Baseline-Stand.
- Nicht gewählte Track-Kombinationen werden nicht erstellt und mit kurzer Begründung als `N/A` dokumentiert.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für Baseline-Prüfung und Track-Vorbereitung.
- `plan.md` mit Baseline-, Tag-, Ableitungs- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Prüf-, Tag- und Dokumentationsschritten.
- Datei `docs/learning-units/YEAR2_BASELINE.md` (Commit, Tag, Sprache, Build-/Teststand, offene Risiken, Nachweisgrenzen) und Vorlage oder Ziel für `docs/learning-units/TRACK_BASELINE.md`.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Der Jahr-2-Ausgangsstand ist über Commit und Tag eindeutig identifizierbar.
- [ ] Build- und Teststatus, offene Risiken, `N/A`-Entscheidungen und Nachweisgrenzen sind sichtbar.
- [ ] Jahr 3 wird als Ableitung aus dem Jahr-2-Stand geplant, nicht als Neubeginn.
- [ ] Fork, Snapshot oder abgeleitetes Track-Repo sind begründet; keine Secrets oder echten Daten übernommen.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_12_Jahr-2-Baseline-und-Track-Ableitung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für den Abschluss der Jahr-2-Baseline, den Tag learning/year-2-complete, die Baseline-Nachweise und die spätere Track-Ableitung für AE, SI, DPA und DV des Secure ServiceHarvester der EuFPA-Lernreihe. Erzeuge keine neue Fachlogik und keine automatische Massenanlage von Track-Repositories.
```
