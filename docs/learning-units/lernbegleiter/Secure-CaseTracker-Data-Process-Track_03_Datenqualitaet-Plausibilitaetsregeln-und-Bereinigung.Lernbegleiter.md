# Lernbegleiter: Secure CaseTracker Data & Process Track 03 – Datenqualität, Plausibilitätsregeln und Bereinigung / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Data-Process-Track_03_Datenqualitaet-Plausibilitaetsregeln-und-Bereinigung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Kennzahlen sind nur so gut wie die Daten, auf denen sie beruhen. „Garbage in, garbage out": Wenn ein
Abschlussdatum vor dem Eröffnungsdatum liegt, ein Status falsch geschrieben ist oder ein Fall doppelt
vorkommt, wird jede Auswertung falsch. **Datenqualität** heißt, solche Probleme mit klaren
**Plausibilitätsregeln** früh zu erkennen und dann kontrolliert zu **bereinigen** – ohne die
Nachvollziehbarkeit zu verlieren. Bereinigen bedeutet nicht heimlich ändern, sondern jede Korrektur
dokumentieren.

**EN:** Metrics are only as good as the data they rest on. "Garbage in, garbage out": if a closing date is
before the opening date, a status is misspelled, or a case appears twice, every evaluation becomes wrong.
**Data quality** means detecting such problems early with clear **plausibility rules** and then cleaning them
in a controlled way – without losing traceability. Cleaning does not mean changing secretly, but documenting
every correction.

**DE:** In dieser Einheit lernst du, Qualitätskriterien festzulegen, Plausibilitätsregeln zu schreiben,
Dubletten zu erkennen und Bereinigungen so zu gestalten, dass sie prüfbar und wiederholbar bleiben.

**EN:** In this unit you learn to set quality criteria, write plausibility rules, detect duplicates, and
design cleaning so it stays reviewable and repeatable.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Datenqualität / Data quality | Eignung der Daten für ihren Zweck: vollständig, korrekt, konsistent, aktuell. |
| Plausibilitätsregel / Plausibility rule | Prüfregel, die einen Wert auf Sinnhaftigkeit testet (z. B. Ende ≥ Start). |
| Dublette / Duplicate | Ein Datensatz, der denselben Sachverhalt mehrfach abbildet. |
| Bereinigung / Cleaning | Kontrollierte, dokumentierte Korrektur oder Markierung fehlerhafter Daten. |
| Ausschluss / Exclusion | Ein Datensatz wird bewusst nicht ausgewertet, mit Begründung. |
| Nachvollziehbarkeit / Traceability | Jede Änderung ist mit Grund und Zeitpunkt festgehalten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Qualitätskriterien benennen.** Lege fest, was „gut genug" heißt: Vollständigkeit
(Pflichtfelder befüllt), Korrektheit (Werte aus erlaubtem Bereich), Konsistenz (Felder widersprechen sich
nicht), Aktualität. Ohne Kriterien gibt es keine messbare Qualität.

**EN:** **Step 1 – Name quality criteria.** Define what "good enough" means: completeness (mandatory fields
filled), correctness (values within an allowed range), consistency (fields do not contradict), timeliness.
Without criteria there is no measurable quality.

**DE:** **Schritt 2 – Plausibilitätsregeln schreiben.** Jede Regel ist eine klare Bedingung mit erwartetem
Verhalten: „Abschlussdatum ≥ Eröffnungsdatum", „Status ∈ {offen, in Arbeit, geschlossen}", „Durchlaufzeit ≤
365 Tage, sonst Warnung". Regeln sollen zeigen, *welcher* Datensatz *warum* auffällt.

**EN:** **Step 2 – Write plausibility rules.** Each rule is a clear condition with expected behavior: "closing
date ≥ opening date", "status ∈ {open, in progress, closed}", "throughput time ≤ 365 days, otherwise
warning". Rules should show *which* record stands out *why*.

**DE:** **Schritt 3 – Dubletten erkennen.** Definiere, was ein Fall eindeutig macht (z. B. Fall-ID). Zwei
Datensätze mit gleicher Fall-ID sind eine Dublette und dürfen nicht doppelt gezählt werden. Prüfe auch
„weiche" Dubletten, die sich nur in Schreibweise oder Groß-/Kleinschreibung unterscheiden.

**EN:** **Step 3 – Detect duplicates.** Define what makes a case unique (e.g. case ID). Two records with the
same case ID are a duplicate and must not be counted twice. Also check "soft" duplicates that differ only in
spelling or capitalization.

**DE:** **Schritt 4 – Kontrolliert bereinigen und dokumentieren.** Entscheide je Fehler: korrigieren,
markieren oder ausschließen. Wichtig: **Rohdaten nie stillschweigend überschreiben.** Halte fest, was
geändert wurde, warum und wann. So bleibt die Kennzahl reproduzierbar, und ein Audit kann jede Korrektur
prüfen. Ein Ausschluss ohne Begründung ist ein Datenfehler, kein Fix.

**EN:** **Step 4 – Clean in a controlled way and document.** Decide per error: correct, flag, or exclude.
Important: **never overwrite raw data silently.** Record what was changed, why, and when. This keeps the
metric reproducible, and an audit can check every correction. An exclusion without a reason is a data defect,
not a fix.

**DE:** **Typische Fehler.** Fehler still korrigieren ohne Protokoll. Alle Auffälligkeiten löschen statt
prüfen. Dubletten übersehen (Doppelzählung). Ausreißer entfernen, um ein schöneres Ergebnis zu bekommen.
Bereinigung nicht wiederholbar machen.

**EN:** **Common mistakes.** Silently correcting errors without a log. Deleting all anomalies instead of
checking. Overlooking duplicates (double counting). Removing outliers to get a nicer result. Making the
cleaning non-repeatable.

### Beispiel / Example

```text
Regel R1:   Abschlussdatum >= Eroeffnungsdatum
Datensatz:  Fall C-0421  Start 2025-03-10  Ende 2025-03-02  -> VERLETZT
Aktion:     markieren als "Datumsfehler", NICHT stillschweigend tauschen
Protokoll:  {fall: C-0421, regel: R1, aktion: markiert, grund: Ende<Start, datum: 2025-07-05}

Regel R2:   Fall-ID eindeutig
Datensatz:  C-0500 kommt zweimal vor -> DUBLETTE
Aktion:     zweiten Datensatz ausschliessen, Begruendung dokumentieren
Ergebnis:   Fallzahl 1000 -> 999; Aenderung im Bereinigungsprotokoll nachvollziehbar
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10c Werkzeuge des maschinellen Lernens einsetzen | Primär / Primary | Datenqualität, Plausibilitätsprüfung und Bereinigung sind die Datenvorbereitung, ohne die Auswertungs- und ML-Werkzeuge falsche Ergebnisse liefern. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Plausibilitätsregeln und Dublettenprüfung setzen an den Feldern der Datenverwaltung an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Eingabe- und Datenprüfung, sichere und nachvollziehbare
Datenverarbeitung, auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Datenmodell/Design), `CL_04` (Risikoblick), `CL_08` (Review) und `CL_10` (Datenschutz). Die
Datenentscheidung dieser Einheit lautet: *Rohdaten bleiben unverändert; jede Bereinigung wird als
nachvollziehbarer Schritt dokumentiert.* A11Y-Aspekt: Fehlerhinweise und Bereinigungsprotokolle müssen
textbasiert, klar benannt und ohne reine Farbsignale verständlich sein.

**EN:** Relation to the Secure Development Guideline: input and data validation, secure and traceable data
processing, audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (data
model/design), `CL_04` (risk view), `CL_08` (review), and `CL_10` (data protection). The data decision of
this unit is: *raw data stays unchanged; every cleaning step is documented traceably.* Accessibility aspect:
error hints and cleaning logs must be text-based, clearly named, and understandable without color-only
signals.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DPA) Was bedeutet „garbage in, garbage out" für Kennzahlen? /
   **EN:** (DPA) What does "garbage in, garbage out" mean for metrics?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine korrekte Rechnung auf fehlerhaften Daten liefert trotzdem ein falsches Ergebnis. Ohne
   geprüfte Datenqualität sind Kennzahlen wertlos, egal wie sauber die Formel ist.
   **EN:** A correct calculation on faulty data still yields a wrong result. Without checked data quality,
   metrics are worthless, no matter how clean the formula is.

   </details>

2. **DE:** Warum darf man Rohdaten nicht stillschweigend überschreiben? /
   **EN:** Why must raw data not be overwritten silently?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sonst ist keine Auswertung mehr reproduzierbar und keine Korrektur prüfbar. Nur unveränderte
   Rohdaten plus dokumentierte Bereinigung erlauben ein Audit.
   **EN:** Otherwise no evaluation is reproducible and no correction is verifiable. Only unchanged raw data
   plus documented cleaning allows an audit.

   </details>

3. **DE:** Nenne eine Plausibilitätsregel für Falldaten und ihr erwartetes Verhalten. /
   **EN:** Name a plausibility rule for case data and its expected behavior.

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** „Abschlussdatum ≥ Eröffnungsdatum." Verletzt ein Datensatz die Regel, wird er als Datumsfehler
   markiert und nicht ungeprüft ausgewertet.
   **EN:** "Closing date ≥ opening date." If a record violates the rule, it is flagged as a date error and not
   evaluated unchecked.

   </details>

4. **DE:** (DPA) Wie verfälscht eine übersehene Dublette eine Fallzahl? /
   **EN:** (DPA) How does an overlooked duplicate distort a case count?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Fall wird doppelt gezählt, die Fallzahl ist zu hoch. Kennzahlen wie Auslastung oder Fehlerquote
   verschieben sich, obwohl die reale Lage unverändert ist.
   **EN:** The case is counted twice, the count is too high. Metrics like workload or error rate shift,
   although the real situation is unchanged.

   </details>

5. **DE:** Wann ist ein Ausschluss eines Datensatzes zulässig? /
   **EN:** When is excluding a record acceptable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur mit dokumentierter, sachlicher Begründung (z. B. bestätigte Dublette). Ein Ausschluss ohne
   Begründung ist ein Datenfehler und verfälscht das Ergebnis.
   **EN:** Only with a documented, objective reason (e.g. a confirmed duplicate). An exclusion without a reason
   is a data defect and distorts the result.

   </details>

6. **DE:** (DPA) Warum ist das Entfernen von Ausreißern „für ein schöneres Ergebnis" gefährlich? /
   **EN:** (DPA) Why is removing outliers "for a nicer result" dangerous?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ausreißer können echte, wichtige Fälle sein. Werden sie ohne fachlichen Grund entfernt, wird die
   Realität geschönt und die Entscheidung beruht auf manipulierten Daten.
   **EN:** Outliers can be real, important cases. Removed without a technical reason, reality is prettified and
   the decision rests on manipulated data.

   </details>

7. **DE:** Warum muss eine Bereinigung wiederholbar sein? /
   **EN:** Why must cleaning be repeatable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur wiederholbare Bereinigung liefert bei gleichen Rohdaten dasselbe Ergebnis. Das ist die
   Grundlage für Reproduzierbarkeit, Review und Audit.
   **EN:** Only repeatable cleaning yields the same result from the same raw data. This is the basis for
   reproducibility, review, and audit.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Qualitätskriterien für Falldaten benennen.
- [ ] Plausibilitätsregeln mit erwartetem Verhalten schreiben.
- [ ] harte und weiche Dubletten erkennen.
- [ ] eine Bereinigung dokumentiert und wiederholbar gestalten.
- [ ] einen begründeten Ausschluss von einem stillen Datenverlust unterscheiden.

**EN:** I can …

- [ ] name quality criteria for case data.
- [ ] write plausibility rules with expected behavior.
- [ ] detect hard and soft duplicates.
- [ ] make cleaning documented and repeatable.
- [ ] tell a justified exclusion from silent data loss.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Data-Process-Track_03_Datenqualitaet-Plausibilitaetsregeln-und-Bereinigung.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Data-Process-Track_03_Datenqualitaet-Plausibilitaetsregeln-und-Bereinigung.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
