# Lernbegleiter: Secure CaseTracker 12 – Jahr-2-Baseline und Track-Ableitung / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_12_Jahr-2-Baseline-und-Track-Ableitung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Nach zwei Lehrjahren steht ein fertiger Stand des Secure CaseTracker. Damit die spätere
Spezialisierung im 3. Lehrjahr nicht wieder bei null beginnt, sicherst du diesen Stand als **Baseline** – eine
klar identifizierbare Ausgangsbasis mit einem Git-**Tag** `learning/year-2-complete`. Von dieser Baseline
leitest du später die **Tracks** für die vier Fachrichtungen ab: AE (Application), SI (Operations), DPA (Data
& Process) und DV (Digital Networking). Der Kerngedanke: Jahr 3 startet **nicht** aus einem leeren Projekt,
sondern aus einem nachvollziehbaren, dokumentierten Stand. Offene Risiken aus Jahr 2 werden nicht gelöscht,
sondern in die Baseline übernommen.

**EN:** After two training years, a finished state of the Secure CaseTracker exists. So that the later
specialization in year 3 does not start from scratch again, you preserve this state as a **baseline** – a
clearly identifiable starting point with a Git **tag** `learning/year-2-complete`. From this baseline you
later derive the **tracks** for the four specializations: AE (Application), SI (Operations), DPA (Data &
Process), and DV (Digital Networking). The core idea: year 3 does **not** start from an empty project but from
a traceable, documented state. Open risks from year 2 are not deleted but carried into the baseline.

**DE:** In dieser Einheit prüfst du, ob der Jahr-2-Stand baselinefähig ist (Build, Tests, Secure-Development,
Presets, offene Risiken), und planst die Ableitung als Kopie oder Track-Repo. Ein Plattform-Fork ist optional.

**EN:** In this unit you check whether the year-2 state is baseline-capable (build, tests, secure development,
presets, open risks), and plan the derivation as a copy or track repository. A platform-native fork is optional.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Baseline | Klar identifizierter, dokumentierter Ausgangsstand für spätere Arbeit. |
| Git-Tag | Fester Name für einen bestimmten Commit, z. B. `learning/year-2-complete`. |
| Track | Fachrichtungsspezifischer Weiterentwicklungspfad (AE, SI, DPA, DV). |
| Ableitung / Derivation | Neuer Stand, der aus einer Baseline entsteht, nicht aus dem Nichts. |
| Nachweisgrenze / Evidence limit | Grenze dessen, was durch Nachweise wirklich belegt ist. |
| Fork | Kopie eines Repos auf der Plattform, mit sichtbarer Historie. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Baselinefähigkeit prüfen.** Prüfe, ob Build und Tests laufen, ob Secure-Development-Basis
und Presets vorhanden sind und ob offene Risiken sowie `N/A`-Begründungen dokumentiert sind. Warum? Eine
Baseline soll belastbar sein; ein unsicherer Stand vererbt seine Probleme an alle vier Tracks.

**EN:** **Step 1 – Check baseline capability.** Check whether build and tests run, whether the
secure-development baseline and presets exist, and whether open risks and `N/A` rationales are documented. Why?
A baseline should be reliable; an unsafe state passes its problems to all four tracks.

**DE:** **Schritt 2 – Stand eindeutig markieren.** Setze oder plane den Tag `learning/year-2-complete` und
notiere den zugehörigen Commit. Warum ein Tag? Ein Tag macht den genauen Ausgangsstand eindeutig auffindbar;
ohne ihn weiß niemand später, welcher Stand die Grundlage war.

**EN:** **Step 2 – Mark the state uniquely.** Set or plan the tag `learning/year-2-complete` and note the
associated commit. Why a tag? A tag makes the exact starting state uniquely findable; without it, nobody knows
later which state was the basis.

**DE:** **Schritt 3 – Baseline-Nachweise schreiben.** Lege `docs/learning-units/YEAR2_BASELINE.md` an: Commit,
Tag, Sprache, Build-/Teststand, offene Risiken und Nachweisgrenzen. Offene Sicherheitsrisiken werden
übernommen, nicht gelöscht. Positive Aussagen brauchen konkrete Evidenz. Warum? Nur eine ehrliche, prüfbare
Baseline ist für Lehrende und Lernende brauchbar.

**EN:** **Step 3 – Write baseline evidence.** Create `docs/learning-units/YEAR2_BASELINE.md`: commit, tag,
language, build/test state, open risks, and evidence limits. Open security risks are carried over, not
deleted. Positive statements need concrete evidence. Why? Only an honest, verifiable baseline is usable for
teachers and learners.

**DE:** **Schritt 4 – Track-Ableitung planen.** Plane pro Sprache und Fachrichtung nur den tatsächlich
benötigten Track; keine automatische Massenanlage aller Kombinationen. Ein Track erhält
`docs/learning-units/TRACK_BASELINE.md` mit Herkunftsrepo, Herkunfts-Commit, Tag, Track-Ziel und bewusst nicht
übernommenen Punkten. Keine Secrets, Tokens oder lokalen Entwicklerpfade übernehmen. Warum? Fokussierte,
begründete Ableitung spart Aufwand und verhindert unnötige, ungepflegte Repos.

**EN:** **Step 4 – Plan track derivation.** Per language and specialization, plan only the actually needed
track; no automatic mass creation of all combinations. A track gets `docs/learning-units/TRACK_BASELINE.md`
with source repo, source commit, tag, track goal, and deliberately not-carried-over points. Carry over no
secrets, tokens, or local developer paths. Why? Focused, justified derivation saves effort and prevents
unnecessary, unmaintained repos.

**DE:** **Typische Fehler.** Offene Risiken beim Übergang löschen. Positive Aussagen ohne Evidenz. Jahr 3 aus
leerem Projekt starten. Alle Track-Kombinationen automatisch anlegen. Secrets oder lokale Pfade in die Baseline
übernehmen. Fork ohne Begründung nutzen.

**EN:** **Common mistakes.** Deleting open risks at the transition. Positive statements without evidence.
Starting year 3 from an empty project. Auto-creating all track combinations. Carrying secrets or local paths
into the baseline. Using a fork without justification.

### Beispiel / Example

```text
Baseline-Pruefung:  Build OK | Tests: 42 passed, 2 Open | Secure-Dev vorhanden | 8 Presets vorhanden
Tag:                learning/year-2-complete  @ commit a8b6fc1
YEAR2_BASELINE.md:  Sprache=Rust, Build=OK, Test=OK(2 Open), Risiko="SBOM-Tooling offen", Nachweisgrenze notiert
Track-Auswahl:      nur DPA-Track fuer Rust vorbereitet (tatsaechlich benoetigt), andere = N/A + Grund
TRACK_BASELINE.md:  Herkunft=casetracker-rust @ a8b6fc1, Tag=year-2-complete, Ziel=DPA, nicht uebernommen: lokale Pfade
Fork:               optional -> nur wenn Plattformhistorie bewusst sichtbar bleiben soll (separat bestaetigt)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Der gesicherte Datenverwaltungsstand ist die Grundlage der weiteren Entwicklung in Jahr 3. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Der Übergang bereitet die spätere fachrichtungsspezifische Servicearbeit vor. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: auditfähige Evidenz, sichere Übergabe, MSL-Präferenz, sichere
Architektur und sichere Code-Erzeugung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05`
(Abhängigkeiten), `CL_08` (Sicherheits-Code-Review), `CL_09` (Testmanagement), `CL_10` (Kompetenz/Nachweis)
und `CL_12` (sichere Umgebung). Die Sicherheitsentscheidung dieser Einheit lautet: *Offene Risiken werden in
die Baseline übernommen, nicht gelöscht, und Jahr 3 startet als begründete Ableitung mit Evidenz.* A11Y-Aspekt:
Die Baseline-Dateien `YEAR2_BASELINE.md` und `TRACK_BASELINE.md` sind klarer, gut strukturierter Text ohne
reine Farbsignale, damit sie für Lehrende und Lernende auch mit Screenreader und Braille-Zeile verständlich
bleiben.

**EN:** Relation to the Secure Development Guideline: audit-ready evidence, safe handover, MSL preference,
secure architecture, and secure code generation. Matching checklists: `CL_01` (standards applicability),
`CL_05` (dependencies), `CL_08` (security code review), `CL_09` (test management), `CL_10`
(competence/evidence), and `CL_12` (secure environment). The security decision of this unit is: *open risks
are carried into the baseline, not deleted, and year 3 starts as a justified derivation with evidence.*
Accessibility aspect: the baseline files `YEAR2_BASELINE.md` and `TRACK_BASELINE.md` are clear, well-structured
text without color-only signals, so they remain understandable for teachers and learners with a screen reader
and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum startet Jahr 3 nicht aus einem leeren Projekt? /
   **EN:** Why does year 3 not start from an empty project?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein leeres Projekt würde bereits erarbeitete Sicherheit, Tests und Modellentscheidungen verlieren.
   Die Ableitung aus einer dokumentierten Baseline erhält diesen Wert und spart Zeit.
   **EN:** An empty project would lose already-built security, tests, and model decisions. Deriving from a
   documented baseline preserves this value and saves time.

   </details>

2. **DE:** Warum wird der Jahr-2-Stand mit einem Tag markiert? /
   **EN:** Why is the year-2 state marked with a tag?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Tag `learning/year-2-complete` macht den genauen Ausgangs-Commit eindeutig auffindbar. So ist
   klar, welcher Stand die Grundlage jeder Track-Ableitung ist.
   **EN:** The tag `learning/year-2-complete` makes the exact starting commit uniquely findable. It is then
   clear which state is the basis of each track derivation.

   </details>

3. **DE:** (AE) Welche Architektur- oder Implementierungsentscheidung darf der Application Track nicht verlieren? /
   **EN:** (AE) Which architecture or implementation decision must the Application Track not lose?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zentrale Domänen- und Sicherheitsregeln, z. B. Zustandslogik und Autorisierung in der Kernlogik.
   Diese Entscheidungen tragen die spätere Anwendung und dürfen nicht verloren gehen.
   **EN:** Central domain and security rules, e.g. state logic and authorization in the core logic. These
   decisions carry the later application and must not be lost.

   </details>

4. **DE:** (SI) Welche Betriebs-, Sandbox- oder CI-Annahme muss vor dem Operations Track stabil sein? /
   **EN:** (SI) Which operations, sandbox, or CI assumption must be stable before the Operations Track?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Reproduzierbare Build- und Testkommandos sowie klare Sandbox- und Toolchain-Annahmen. Ohne stabile
   Betriebsbasis kann der Operations Track nicht verlässlich aufsetzen.
   **EN:** Reproducible build and test commands as well as clear sandbox and toolchain assumptions. Without a
   stable operations basis, the Operations Track cannot build reliably.

   </details>

5. **DE:** (DPA) Welche Datenqualitäts- oder Kennzahlenannahme muss vor dem Data-&-Process-Track dokumentiert sein? /
   **EN:** (DPA) Which data-quality or metrics assumption must be documented before the Data & Process Track?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wie fehlende Werte behandelt werden und welche Aussagegrenzen die Kennzahlen haben. Nur so bauen
   spätere Auswertungen auf einer nachvollziehbaren Datenbasis auf.
   **EN:** How missing values are handled and which limits of interpretation the metrics have. Only then do
   later evaluations build on a traceable data basis.

   </details>

6. **DE:** Warum werden offene Sicherheitsrisiken aus Jahr 2 in die Baseline übernommen statt gelöscht? /
   **EN:** Why are open security risks from year 2 carried into the baseline instead of deleted?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Gelöschte Risiken verschwinden aus dem Blick, bestehen aber weiter. Übernommene Risiken bleiben
   sichtbar und können im passenden Jahr-3-Intake bearbeitet werden.
   **EN:** Deleted risks disappear from view but still exist. Carried-over risks stay visible and can be
   addressed in the appropriate year-3 intake.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] prüfen, ob ein Jahr-2-Stand baselinefähig ist (Build, Tests, Secure-Development, Presets, Risiken).
- [ ] den Stand mit Tag `learning/year-2-complete` und Commit eindeutig markieren.
- [ ] eine `YEAR2_BASELINE.md` mit Nachweisen und Nachweisgrenzen schreiben.
- [ ] eine fokussierte Track-Ableitung statt automatischer Massenanlage planen.
- [ ] begründen, warum offene Risiken übernommen und nicht gelöscht werden.

**EN:** I can …

- [ ] check whether a year-2 state is baseline-capable (build, tests, secure development, presets, risks).
- [ ] mark the state uniquely with the tag `learning/year-2-complete` and commit.
- [ ] write a `YEAR2_BASELINE.md` with evidence and evidence limits.
- [ ] plan a focused track derivation instead of automatic mass creation.
- [ ] justify why open risks are carried over and not deleted.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_12_Jahr-2-Baseline-und-Track-Ableitung.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_12_Jahr-2-Baseline-und-Track-Ableitung.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
