# Lernbegleiter: Secure ServiceHarvester Data & Process Track 01 – Track-Baseline und Datenzielbild / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der ServiceHarvester sammelt bereits Daten: In der v2-Baseline ist er ein langlaufender Sammel-Dienst,
der regelmäßig Maschinen-Snapshots erfasst – etwa Name, Betriebssystem und Zeitpunkt des letzten Kontakts. Im
Data & Process Track geht es nicht mehr um den Dienst selbst, sondern um den **verantwortlichen Umgang mit den
gesammelten Daten**. Bevor du eine einzige Kennzahl berechnest, brauchst du ein **Datenzielbild**: Welche
Fragen sollen die Daten beantworten? Welche Felder werden dafür wirklich gebraucht? Was sagen die Daten
**nicht** aus? Im 3. Lehrjahr reicht es nicht, eine Zahl zu liefern – du musst ihre **Aussagegrenze** belegen.

**EN:** The ServiceHarvester already collects data: in the v2 baseline it is a long-running collection service
that regularly captures machine snapshots – e.g. name, operating system, and time of last contact. The Data &
Process Track is no longer about the service itself but about the **responsible handling of the collected
data**. Before you compute a single metric, you need a **data target picture**: which questions should the data
answer? Which fields are truly needed for this? What does the data **not** say? In year 3 it is not enough to
deliver a number – you must evidence its **limit of validity**.

**DE:** Du lernst, die vorhandenen Rohdaten sauber von geplanten Auswertungen zu trennen, fachliche Fragen mit
ihrem Datenbedarf zu verknüpfen und die Aussagegrenzen der Daten ehrlich festzuhalten. Das Datenzielbild wird
zur gemeinsamen Baseline für alle folgenden Track-Einheiten.

**EN:** You learn to cleanly separate the existing raw data from planned evaluations, to link business questions
to their data need, and to record the limits of validity of the data honestly. The data target picture becomes
the shared baseline for all following track units.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Rohdaten / Raw data | Die vom Dienst gesammelten Snapshots vor jeder Auswertung. |
| Datenzielbild / Data target picture | Klare Beschreibung, welche Fragen die Daten beantworten und welche Grenzen gelten. |
| Fachliche Frage / Business question | Konkrete Frage, aus der sich der Datenbedarf ableitet, nicht umgekehrt. |
| Aussagegrenze / Limit of validity | Grenze, bis zu der eine Auswertung belastbar ist; darüber hinaus ist sie Spekulation. |
| Schutzbedarf / Protection need | Einschätzung der Schutzwürdigkeit hinsichtlich Vertraulichkeit, Integrität und Verfügbarkeit. |
| Nicht-Ziel / Non-goal | Bewusst ausgeschlossener Punkt, damit Umfang und Datensammlung nicht unbemerkt wachsen. |
| Auditnachweis / Audit evidence | Belegbarer Nachweis, der eine Aussage später überprüfbar macht. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Rohdaten belegen.** Schreibe auf, welche Felder die v2-Baseline tatsächlich sammelt, zum
Beispiel Maschinenname, Betriebssystem, letzter Kontakt und Erfassungszeitpunkt. Wichtig: Baseline heißt
„belegt", nicht „vermutet". Ein Feld, das du nicht in den Daten wiederfindest, bleibt `Open` mit Folgeaktion.

**EN:** **Step 1 – Evidence the raw data.** Write down which fields the v2 baseline actually collects, for
example machine name, operating system, last contact, and capture time. Important: baseline means "evidenced",
not "assumed". A field you cannot find in the data stays `Open` with a follow-up action.

**DE:** **Schritt 2 – Frage zuerst, Auswertung danach.** Beginne mit der fachlichen Frage, nicht mit den
vorhandenen Spalten. Beispiel: „Wie viele Maschinen haben sich in den letzten 24 Stunden gemeldet?" Erst diese
Frage sagt dir, dass du den letzten Kontakt und einen Zeitbezug brauchst – und nicht jedes verfügbare Feld.

**EN:** **Step 2 – Question first, evaluation second.** Start with the business question, not with the existing
columns. Example: "How many machines reported in during the last 24 hours?" Only this question tells you that
you need the last contact and a time reference – and not every available field.

**DE:** **Schritt 3 – Auswertungen des Tracks schneiden.** Ordne die geplanten Track-Themen zu: Datenqualität
(02), Kennzahlen und Betriebsmetriken (03), Datenschutz und Datenminimierung (04), Reporting und
Aggregationsansichten (05). Jede Auswertung bekommt einen Satz Zweck und einen Bezug zu den Rohdaten. So wird
sichtbar, was schon vorhanden ist und was noch entsteht.

**EN:** **Step 3 – Cut the evaluations of the track.** Assign the planned track topics: data quality (02),
metrics and operational metrics (03), data protection and data minimization (04), reporting and aggregation
views (05). Each evaluation gets one sentence of purpose and a relation to the raw data. This makes visible
what already exists and what is still to be built.

**DE:** **Schritt 4 – Aussagegrenzen und Nicht-Ziele festhalten.** Nenne früh, was die Daten **nicht**
aussagen. Beispiel: „Der letzte Kontakt zeigt nicht, ob die Maschine gerade arbeitet, nur wann sie sich zuletzt
gemeldet hat." Nicht-Ziele wie „keine Nutzungsprofile einzelner Personen" verhindern Scope-Creep und schützen
die Datenminimierung.

**EN:** **Step 4 – Record limits of validity and non-goals.** State early what the data does **not** say.
Example: "the last contact does not show whether the machine is currently working, only when it last reported
in." Non-goals such as "no usage profiles of individual people" prevent scope creep and protect data
minimization.

**DE:** **Schritt 5 – Schutzbedarf und Annahmen trennen.** Schreibe Sicherheits-, Datenschutz-, Betriebs- und
Datenannahmen in getrennte Zeilen. Warum getrennt? Weil sie unterschiedliche Prüfungen brauchen: Sicherheit
prüft Angreifer, Datenschutz prüft personenbezogene Bezüge, Betrieb prüft Umgebung, Datenqualität prüft die
Belastbarkeit der Werte. Jede positive Aussage erhält einen Nachweispfad.

**EN:** **Step 5 – Separate protection need and assumptions.** Write security, privacy, operational, and data
assumptions in separate lines. Why separate? Because they need different checks: security considers attackers,
privacy considers personal references, operations considers the environment, data quality considers the
reliability of values. Every positive claim gets an evidence path.

**DE:** **Typische Fehler.** Rohdaten und Wunschauswertung vermischen. Mit den Spalten statt mit der Frage
beginnen. Aussagegrenzen erst am Ende „nachreichen". Nicht-Ziele weglassen. Positive Aussagen („die Daten sind
vollständig") ohne Nachweis. Standards still weglassen statt sie als `N/A` mit Begründung zu dokumentieren.

**EN:** **Common mistakes.** Mixing raw data and wished-for evaluation. Starting from the columns instead of the
question. "Adding" limits of validity only at the end. Omitting non-goals. Positive claims ("the data is
complete") without evidence. Silently dropping standards instead of documenting them as `N/A` with a
justification.

### Beispiel / Example

```text
Baseline (belegt):   v2 sammelt Snapshots je Maschine: name, os, last_contact, captured_at
Frage 1:             "Wie viele Maschinen meldeten sich in den letzten 24 h?" -> Felder: last_contact, captured_at
Frage 2:             "Wie verteilen sich die Betriebssysteme?"                 -> Felder: os
Auswertung (Track):  Datenqualitaet (02), Kennzahlen (03), Datenschutz (04), Reporting (05)
Nicht-Ziel:          Nutzungsprofile einzelner Personen, Fernsteuerung, zusaetzliche personenbezogene Felder
Aussagegrenze:       last_contact zeigt nur den letzten Meldezeitpunkt, nicht den aktuellen Arbeitszustand
Schutzbedarf:        Integritaet = hoch (falsche Snapshots -> falsche Betriebsentscheidungen)
Annahme (Daten):     os-Werte koennen uneinheitlich geschrieben sein -> Nachweis: Normalisierungstest (Einheit 02)
N/A:                 ML-Auswertung in dieser Einheit N/A (kein Trainingsziel) -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). Für das
Datenzielbild ist **LF 12c** primär, weil eine kundenspezifische Daten- und Prozessanalyse von der Fragestellung
her geplant und abgegrenzt wird; LF 5 ist berührt, weil die Rohdaten aus der vom Dienst verwalteten
Datenhaltung stammen. LF 10c (maschinelles Lernen) passt hier nicht, weil kein Modell trainiert, sondern eine
belastbare Datengrundlage geklärt wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). For
the data target picture **LF 12c** is primary, because a customer-specific data and process analysis is planned
and scoped from the question; LF 5 is touched because the raw data comes from the data storage managed by the
service. LF 10c (machine learning) does not fit here because no model is trained; instead a reliable data
foundation is clarified.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Das Datenzielbild plant und begrenzt eine kundenspezifische Datenanalyse mit Aussagegrenzen. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Die Rohdaten stammen aus der vom ServiceHarvester verwalteten Datenhaltung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, saubere Datenannahmen, Standards-Anwendbarkeit und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Bedrohungs- und
Risikoblick), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die Datenentscheidung dieser Einheit
lautet: *Es werden nur Felder ausgewertet, die eine konkrete Frage braucht, und jede Auswertung nennt ihre
Aussagegrenze.* A11Y-Aspekt: Die Fragen-Feld-Matrix und die Auswertungsliste müssen als Tabelle mit klaren
Spaltenüberschriften lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar
bleiben.

**EN:** Relation to the Secure Development Guideline: data protection, clean data assumptions, standards
applicability, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat
and risk view), `CL_10` (data protection), and `CL_12` (evidence and closure). The data decision of this unit
is: *only fields that a concrete question needs are evaluated, and every evaluation names its limit of
validity.* Accessibility aspect: the question-field matrix and the evaluation list must be readable as tables
with clear column headers, without color coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum leitet man die Auswertung aus der fachlichen Frage ab und nicht aus den vorhandenen Feldern? /
   **EN:** Why derive the evaluation from the business question and not from the existing fields?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur die Frage sagt, welche Felder wirklich nötig sind. Startet man bei den Feldern, wertet man zu
   viel aus, verletzt die Datenminimierung und verliert den Fokus.
   **EN:** Only the question says which fields are truly needed. Starting from the fields evaluates too much,
   violates data minimization, and loses focus.

   </details>

2. **DE:** Warum muss eine Baseline „belegt" und nicht nur „vermutet" sein? /
   **EN:** Why must a baseline be "evidenced" and not just "assumed"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine vermutete Baseline führt zu Auswertungen, die auf falschen Annahmen stehen. Nur belegte Rohdaten
   machen Auswertungen prüfbar; alles Unbelegte bleibt `Open` mit Folgeaktion.
   **EN:** An assumed baseline leads to evaluations built on wrong assumptions. Only evidenced raw data makes
   evaluations verifiable; anything unevidenced stays `Open` with a follow-up action.

   </details>

3. **DE:** (DPA) Was bedeutet die Aussagegrenze am Beispiel des Feldes `last_contact`? /
   **EN:** (DPA) What does the limit of validity mean using the `last_contact` field as an example?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** `last_contact` zeigt nur, wann sich eine Maschine zuletzt gemeldet hat, nicht ihren aktuellen
   Arbeitszustand. Aus „vor 2 Minuten gemeldet" darf man nicht „arbeitet gerade" ableiten. Diese Grenze gehört
   zu jeder darauf aufbauenden Kennzahl.
   **EN:** `last_contact` only shows when a machine last reported in, not its current working state. From
   "reported 2 minutes ago" you must not derive "is currently working". This limit belongs to every metric built
   on it.

   </details>

4. **DE:** (DPA) Warum ist der Schutzbedarf „Integrität" für die gesammelten Snapshots oft besonders hoch? /
   **EN:** (DPA) Why is the "integrity" protection need often especially high for the collected snapshots?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aus den Snapshots werden Betriebsentscheidungen und Kennzahlen abgeleitet. Falsche oder manipulierte
   Werte führen direkt zu falschen Entscheidungen, daher zählt die Integrität stark.
   **EN:** Operational decisions and metrics are derived from the snapshots. Wrong or manipulated values lead
   directly to wrong decisions, so integrity matters strongly.

   </details>

5. **DE:** Wozu dienen Nicht-Ziele im Datenzielbild? /
   **EN:** What is the purpose of non-goals in the data target picture?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie grenzen bewusst aus, was nicht ausgewertet wird, etwa Nutzungsprofile einzelner Personen. Sie
   verhindern Scope-Creep und schützen die Datenminimierung.
   **EN:** They deliberately exclude what is not evaluated, such as usage profiles of individual people. They
   prevent scope creep and protect data minimization.

   </details>

6. **DE:** (SI) Welche Betriebsannahme beeinflusst die Datengrundlage eines Sammel-Dienstes, und wie weist man
   sie nach? / **EN:** (SI) Which operational assumption affects the data foundation of a collection service,
   and how do you evidence it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fällt der Dienst zeitweise aus oder sammelt seltener, entstehen Lücken in den Snapshots. Nachweis:
   ein Protokoll der Sammelintervalle oder ein Test, der Lücken sichtbar macht, damit die Aussagegrenze stimmt.
   **EN:** If the service is temporarily down or collects less often, gaps appear in the snapshots. Evidence: a
   log of collection intervals or a test that surfaces gaps, so the limit of validity is correct.

   </details>

7. **DE:** (DV) Warum ist es sinnvoll, die Systemgrenze zwischen den meldenden Maschinen und der Datenhaltung im
   Zielbild zu benennen? / **EN:** (DV) Why is it useful to name the system boundary between the reporting
   machines and the data storage in the target picture?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** An dieser Grenze wechseln Daten die Vertrauenszone und müssen validiert werden. Wer sie früh benennt,
   plant Schnittstellen, Vollständigkeit und Qualitätsprüfung gezielt und erkennt, wo Lücken entstehen können.
   **EN:** At this boundary data crosses the trust zone and must be validated. Naming it early allows targeted
   planning of interfaces, completeness, and quality checks, and reveals where gaps can arise.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: eine
   ML-Auswertung ist `N/A`, weil das Zielbild kein Modelltraining vorsieht. So bleibt sichtbar, dass der
   Standard geprüft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: an ML evaluation is
   `N/A` because the target picture does not include model training. This keeps visible that the standard was
   checked.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die vorhandenen Rohdaten belegt von geplanten Auswertungen trennen.
- [ ] eine fachliche Frage mit ihrem Datenbedarf verknüpfen.
- [ ] die Aussagegrenze einer Auswertung klar formulieren.
- [ ] mindestens zwei sinnvolle Nicht-Ziele nennen.
- [ ] Sicherheits-, Datenschutz-, Betriebs- und Datenannahmen getrennt notieren.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] separate the evidenced raw data from planned evaluations.
- [ ] link a business question to its data need.
- [ ] state the limit of validity of an evaluation clearly.
- [ ] name at least two meaningful non-goals.
- [ ] note security, privacy, operational, and data assumptions separately.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_01_Track-Baseline-und-Datenzielbild.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
