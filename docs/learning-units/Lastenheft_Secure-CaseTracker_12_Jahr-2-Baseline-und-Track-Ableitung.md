# Lastenheft: Secure CaseTracker 12 - Jahr-2-Baseline und Track-Ableitung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** Eigenständiger späterer Abschluss- und Vorbereitungs-Intake nach Jahr 2
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere spezialisierte Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Lernende können den abgeschlossenen Jahr-2-Stand des Secure CaseTracker als nachvollziehbare Baseline sichern und daraus spätere Jahr-3-Spezialisierungspfade für AE, SI, DPA und DV ableiten, ohne bei den Spezialisierungen wieder bei einem leeren Projekt zu starten.

**EN:** Learners can preserve the completed year-2 Secure CaseTracker state as a traceable baseline and derive later year-3 specialization paths for AE, SI, DPA, and DV without starting the specializations from an empty project again.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Primär | Welche Architektur- oder Implementierungsentscheidung aus Jahr 2 darf der Application Track nicht verlieren? |
| SI | Primär | Welche Betriebs-, Sandbox- oder CI-Annahme muss vor dem Operations Track stabil sein? |
| DPA | Primär | Welche Datenqualitäts- oder Kennzahlenannahme muss vor dem Data-&-Process-Track dokumentiert sein? |
| DV | Primär | Welche Systemgrenze, Schnittstelle oder Kommunikationsannahme muss vor dem Digital-Networking-Track dokumentiert sein? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt Projektabschluss, Versionsstand, Übergabe, Qualitätssicherung, Dokumentation und fachrichtungsspezifische Weiterentwicklung.

**EN:** The task supports project closure, version state, handover, quality assurance, documentation, and specialization-specific continuation.

**DE:** Spec-Kit-Läufe sind begleitende SDD-Aufgaben für Baseline und Ableitung. Sie ersetzen nicht das klassische Erlernen des jeweiligen Berufsbilds oder die fachliche Ausbildung im Betrieb und in der Berufsschule.

**EN:** Spec Kit runs are companion SDD tasks for baseline and derivation. They do not replace classical occupation learning or vocational training at school and in the workplace.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_12_Jahr-2-Baseline-und-Track-Ableitung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_12_Jahr-2-Baseline-und-Track-Ableitung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** auditfähige Evidenz, sichere Übergabe, MSL-Präferenz, sichere Architektur, sichere Code-Erzeugung.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Programmierung, Richtlinie Secure Development Life Cycle, Richtlinie Testmanagement, Leitlinie Sichere Entwicklungs-Sandbox.
- **Presets:** alle sechs Governance-Presets als Nachweisrahmen für den Jahr-2-Abschluss.

## Aufgabenstellung / Task

**DE:** Prüfe den abgeschlossenen Jahr-2-Stand eines Secure-CaseTracker-Sprachrepos. Dokumentiere, ob Build, Tests, Secure-Development-Basis, Presets, offene Risiken und `N/A`-Begründungen für eine spätere Spezialisierung belastbar genug sind. Bereite anschließend die Ableitung für Jahr 3 vor. Die bevorzugte Variante ist ein nachvollziehbarer Baseline-Stand mit Tag `learning/year-2-complete` und eine spätere abgeleitete Track-Kopie oder ein Track-Repo. Ein Plattform-Fork ist optional, wenn die Plattformhistorie bewusst sichtbar bleiben soll.

**EN:** Review the completed year-2 state of a Secure CaseTracker language repository. Document whether build, tests, the secure-development baseline, presets, open risks, and `N/A` rationales are strong enough for later specialization. Then prepare the year-3 derivation. The preferred variant is a traceable baseline state with the tag `learning/year-2-complete` and a later derived track copy or track repository. A platform-native fork is optional when platform history should stay visible.

## Anforderungen / Requirements

- **R-01:** Der Jahr-2-Ausgangsstand ist eindeutig über Commit und Tag `learning/year-2-complete` identifizierbar; Jahr 3 startet nicht aus einem leeren Projekt, sondern aus diesem abgeschlossenen Jahr-2-Stand.
- **R-02:** Build- und Teststatus sowie Verfügbarkeit von Secure-Development-Basis und Presets sind dokumentiert; der Jahr-2-Stand erhält eine Datei `docs/learning-units/YEAR2_BASELINE.md` mit Commit, Tag, Sprache, Build-/Teststand, offenen Risiken und Nachweisgrenzen, und ein späterer Track-Pfad erhält eine Datei `docs/learning-units/TRACK_BASELINE.md` mit Herkunftsrepo, Herkunfts-Commit, Tag, Track-Ziel und bewusst nicht übernommenen Punkten.
- **R-03:** Offene Risiken aus Jahr 2 werden in die Baseline übernommen, nicht gelöscht; `N/A`-Entscheidungen und Nachweisgrenzen sind sichtbar.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; Jahr 3 wird als begründete Ableitung geplant und pro Sprache und Fachrichtung nur der tatsächlich benötigte Track vorbereitet (keine automatische Massenanlage). Neue Fachlogik ist in diesem Schritt `N/A`, Cloud, produktiver Betrieb und Marktbereitstellung bleiben `N/A`, solange der Track ein lokales Ausbildungsprojekt ist, und nicht gewählte Track-Kombinationen werden mit kurzer Begründung als `N/A` dokumentiert.
- **R-05:** Die Baseline bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Offene Sicherheitsrisiken aus Jahr 2 werden nicht gelöscht, sondern in die Baseline übernommen.
- Positive Aussagen zu Sicherheit, Qualität oder Compliance brauchen konkrete Evidenz.
- Bekannte fehlende Tests, fehlende Audits oder fehlende Nachweise werden als `Open` dokumentiert.
- Track-Ableitungen dürfen keine Secrets, privaten Tokens oder lokalen Entwicklerpfade übernehmen.
- Die Baseline enthält keine echten Kundendaten; Beispiel- und Testdaten bleiben fiktiv.
- Datenschutzannahmen aus Jahr 2 werden auf Aktualität geprüft und bei Bedarf als Folgeaufgabe markiert.
- Nicht anwendbare Standards werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Die Baseline-Prüfung bewertet Build, Tests, Evidenz und Risiken unabhängig von der Zielprogrammiersprache.
- Jede Sprache nennt Build-/Testkommando und offene Toolchain-Fragen für den Baseline-Stand.
- Nicht gewählte Track-Kombinationen werden nicht erstellt und mit kurzer Begründung als `N/A` dokumentiert.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- Entscheidung, ob der Jahr-2-Stand baselinefähig ist.
- Tag-Plan oder vorhandener Tag `learning/year-2-complete`.
- Datei `docs/learning-units/YEAR2_BASELINE.md` im Jahr-2-Sprachrepo.
- Plan für die spätere Ableitung in AE-, SI-, DPA- oder DV-Track.
- Vorlage oder späteres Ziel für `docs/learning-units/TRACK_BASELINE.md`.
- Liste offener Punkte: fehlende Tests, offene Sicherheitsfragen oder unklare Track-Ziele als Folgeaufgaben für den ersten passenden Jahr-3-Intake; die Entscheidung für einen Plattform-Fork wird vor der Umsetzung separat bestätigt.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Der Jahr-2-Ausgangsstand ist eindeutig über Commit und Tag identifizierbar.
- [ ] Build- und Teststatus sind dokumentiert.
- [ ] Offene Risiken, `N/A`-Entscheidungen und Nachweisgrenzen sind sichtbar.
- [ ] Jahr 3 wird als Ableitung aus dem Jahr-2-Stand geplant, nicht als Neubeginn.
- [ ] Fork, Snapshot oder abgeleitetes Track-Repo sind begründet.
- [ ] Lokaler Build- und Teststand ist geprüft oder ein konkreter Blocker ist dokumentiert; Secure-Development-Basis und Governance-Presets sind verfügbar, es werden keine Secrets oder echten Daten in die Baseline übernommen, und die Baseline-Dateien sind für Lehrende und Lernende verständlich.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_12_Jahr-2-Baseline-und-Track-Ableitung.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für den Abschluss der Jahr-2-Baseline, den Tag learning/year-2-complete, die Baseline-Nachweise und die spätere Track-Ableitung für AE, SI, DPA und DV der Secure-CaseTracker-Lernreihe. Erzeuge keine neue Fachlogik und keine automatische Massenanlage von Track-Repositories.
```
