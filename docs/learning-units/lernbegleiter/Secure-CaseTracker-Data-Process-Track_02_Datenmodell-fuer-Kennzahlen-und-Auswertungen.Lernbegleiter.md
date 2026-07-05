# Lernbegleiter: Secure CaseTracker Data & Process Track 02 – Datenmodell für Kennzahlen und Auswertungen / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Data-Process-Track_02_Datenmodell-fuer-Kennzahlen-und-Auswertungen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Kennzahl ist keine einzelne Zahl, sondern das Ergebnis einer klaren Rechenregel auf gut
geordneten Daten. Damit „durchschnittliche Durchlaufzeit" oder „Fehlerquote" überhaupt eindeutig sind,
braucht man ein **Datenmodell für Auswertungen**: Welche Felder gibt es, welchen Zeitbezug haben sie, wie
werden sie gruppiert und aggregiert? Ohne dieses Modell rechnen zwei Personen dieselbe Kennzahl
unterschiedlich aus – und keine Zahl ist mehr vergleichbar.

**EN:** A metric is not a single number but the result of a clear calculation rule on well-ordered data. For
"average throughput time" or "error rate" to be unambiguous at all, you need a **data model for
evaluations**: which fields exist, what time reference they have, how they are grouped and aggregated.
Without this model, two people compute the same metric differently – and no number is comparable anymore.

**DE:** In dieser Einheit lernst du, ein Kennzahlenmodell mit klaren Definitionen, Zeitbezug, Filtern,
Aggregationen und Verantwortlichkeiten zu entwerfen, sodass jede Kennzahl reproduzierbar und prüfbar ist.

**EN:** In this unit you learn to design a metrics model with clear definitions, time reference, filters,
aggregations, and responsibilities, so that every metric is reproducible and reviewable.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Kennzahl / Metric | Ein Wert mit fester Definition, z. B. „Median der Durchlaufzeit geschlossener Fälle". |
| Aggregation / Aggregation | Zusammenfassen vieler Werte zu einem (Summe, Mittelwert, Median, Anzahl). |
| Zeitbezug / Time reference | Regel, welchem Zeitraum ein Fall zugeordnet wird (Eröffnung, Abschluss, Stichtag). |
| Filter / Filter | Bedingung, die festlegt, welche Datensätze in die Kennzahl eingehen. |
| Dimension / Dimension | Merkmal, nach dem gruppiert wird (Status, Monat, Kategorie). |
| Kennzahldefinition / Metric definition | Verbindliche, schriftliche Rechenregel einer Kennzahl. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Jede Kennzahl exakt definieren.** Schreibe für jede Kennzahl eine eindeutige Regel:
Zähler, Nenner, Einheit, Filter, Zeitbezug. „Fehlerquote = Anzahl fehlerhaft geschlossener Fälle / Anzahl
geschlossener Fälle im Monat X, in Prozent." Eine Kennzahl ohne schriftliche Definition ist beliebig.

**EN:** **Step 1 – Define every metric exactly.** For each metric write an unambiguous rule: numerator,
denominator, unit, filter, time reference. "Error rate = number of faulty closed cases / number of closed
cases in month X, in percent." A metric without a written definition is arbitrary.

**DE:** **Schritt 2 – Zeitbezug festlegen.** Entscheide, welchem Zeitraum ein Fall zählt. Zählt ein im Januar
eröffneter, im März geschlossener Fall zum Januar oder zum März? Beide Antworten sind möglich, aber du musst
dich für **eine** entscheiden und sie dokumentieren. Ein wechselnder Zeitbezug macht Trends unbrauchbar.

**EN:** **Step 2 – Set the time reference.** Decide which period a case counts for. Does a case opened in
January and closed in March count for January or March? Both answers are possible, but you must choose **one**
and document it. A shifting time reference makes trends useless.

**DE:** **Schritt 3 – Aggregation bewusst wählen.** Mittelwert und Median sagen Unterschiedliches. Ein
einzelner sehr langer Fall zieht den Mittelwert nach oben, den Median kaum. Für Durchlaufzeiten ist der
Median oft ehrlicher. Wähle die Aggregation passend zur Frage und begründe die Wahl.

**EN:** **Step 3 – Choose aggregation deliberately.** Mean and median say different things. A single very long
case pulls the mean up, the median barely. For throughput times the median is often more honest. Choose the
aggregation to fit the question and justify the choice.

**DE:** **Schritt 4 – Filter und Dimensionen trennen.** Ein Filter entscheidet, *ob* ein Datensatz zählt
(z. B. nur geschlossene Fälle). Eine Dimension entscheidet, *wie gruppiert* wird (z. B. je Monat). Vermischt
man beides, entstehen doppelte oder fehlende Zählungen. Halte auch fest, **wer** eine Kennzahldefinition
ändern darf – sonst driften Definitionen unbemerkt.

**EN:** **Step 4 – Separate filters and dimensions.** A filter decides *whether* a record counts (e.g. only
closed cases). A dimension decides *how to group* (e.g. per month). Mixing both creates double or missing
counts. Also record **who** may change a metric definition – otherwise definitions drift unnoticed.

**DE:** **Typische Fehler.** Kennzahlen ohne schriftliche Definition. Zeitbezug je Auswertung wechseln.
Mittelwert bei stark schiefer Verteilung. Filter und Dimension vermischen. Keine Verantwortlichkeit für
Definitionsänderungen.

**EN:** **Common mistakes.** Metrics without a written definition. Switching the time reference per
evaluation. Using the mean on a strongly skewed distribution. Mixing filter and dimension. No responsibility
for definition changes.

### Beispiel / Example

```text
Kennzahl:       Median-Durchlaufzeit geschlossener Faelle je Abschlussmonat
Zaehler-Basis:  geschlossene Faelle (Filter: Status = geschlossen)
Zeitbezug:      Fall zaehlt zum Monat des Abschlussdatums
Aggregation:    Median (robust gegen einzelne Ausreisser)
Dimension:      Abschlussmonat (2025-01, 2025-02, ...)
Einheit:        Tage
Verantwortung:  Definition aenderbar nur durch Datenverantwortliche/n, Aenderung dokumentiert
Gegenbeispiel:  Mittelwert statt Median -> ein 400-Tage-Fall verzerrt den Wert stark
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11c Prozesse analysieren und gestalten | Primär / Primary | Ein Kennzahlenmodell legt fest, wie ein Prozess messbar analysiert und verglichen wird. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Das Auswertungsmodell baut auf den Feldern und Strukturen der Datenverwaltung auf. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: reproduzierbare Datenverarbeitung, klare Trennung von
Definition und Ergebnis, auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit),
`CL_02` (Datenmodell/Design), `CL_04` (Risikoblick), `CL_08` (Review) und `CL_10` (Datenschutz). Die
Datenentscheidung dieser Einheit lautet: *Jede Kennzahl hat eine schriftliche, versionierte Definition mit
festem Zeitbezug.* A11Y-Aspekt: Kennzahldefinitionen und Aggregationen müssen textbasiert und in klaren
Tabellen dargestellt werden, damit sie ohne Diagramm-Farben verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: reproducible data processing, clear separation of
definition and result, audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02`
(data model/design), `CL_04` (risk view), `CL_08` (review), and `CL_10` (data protection). The data decision
of this unit is: *every metric has a written, versioned definition with a fixed time reference.* Accessibility
aspect: metric definitions and aggregations must be presented text-based and in clear tables, so they stay
understandable without chart colors.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum braucht jede Kennzahl eine schriftliche Definition? /
   **EN:** Why does every metric need a written definition?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Definition rechnen verschiedene Personen dieselbe Kennzahl unterschiedlich. Erst die
   schriftliche Regel macht die Zahl eindeutig, vergleichbar und prüfbar.
   **EN:** Without a definition, different people compute the same metric differently. Only the written rule
   makes the number unambiguous, comparable, and reviewable.

   </details>

2. **DE:** (DPA) Warum ist der feste Zeitbezug für Trends entscheidend? /
   **EN:** (DPA) Why is a fixed time reference decisive for trends?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wechselt der Zeitbezug, werden Fälle mal dem Eröffnungs-, mal dem Abschlussmonat zugerechnet.
   Trends über die Monate sind dann nicht mehr vergleichbar und täuschen Entwicklungen vor.
   **EN:** If the time reference shifts, cases are attributed sometimes to the opening, sometimes to the
   closing month. Trends across months are then no longer comparable and fake developments.

   </details>

3. **DE:** (DPA) Wann ist der Median ehrlicher als der Mittelwert? /
   **EN:** (DPA) When is the median more honest than the mean?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei schiefen Verteilungen mit einzelnen sehr großen Werten. Ein extrem langer Fall zieht den
   Mittelwert stark, den Median kaum; der Median beschreibt die typische Dauer besser.
   **EN:** With skewed distributions that have single very large values. An extremely long case pulls the mean
   strongly, the median barely; the median describes the typical duration better.

   </details>

4. **DE:** Worin unterscheiden sich Filter und Dimension? /
   **EN:** How do filter and dimension differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Filter entscheidet, ob ein Datensatz zählt; eine Dimension entscheidet, wie gruppiert wird.
   Vermischt man sie, entstehen doppelte oder fehlende Zählungen.
   **EN:** A filter decides whether a record counts; a dimension decides how to group. Mixing them creates
   double or missing counts.

   </details>

5. **DE:** Warum muss geregelt sein, wer eine Kennzahldefinition ändern darf? /
   **EN:** Why must it be regulated who may change a metric definition?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sonst driften Definitionen unbemerkt, und alte und neue Werte sind nicht mehr vergleichbar. Eine
   klare Verantwortlichkeit macht Änderungen nachvollziehbar und auditfähig.
   **EN:** Otherwise definitions drift unnoticed, and old and new values are no longer comparable. A clear
   responsibility makes changes traceable and audit-ready.

   </details>

6. **DE:** (DPA) Wie kann eine falsche Aggregation eine Entscheidung in die Irre führen? /
   **EN:** (DPA) How can a wrong aggregation mislead a decision?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein zu hoher Mittelwert kann eine Prozessverschlechterung vortäuschen, obwohl nur ein Ausreißer die
   Zahl treibt. Die Entscheidung würde dann auf einer scheinbaren, nicht echten Verschlechterung beruhen.
   **EN:** An inflated mean can feign a process degradation although only one outlier drives the number. The
   decision would then rest on an apparent, not a real, degradation.

   </details>

7. **DE:** Warum gehören Einheit und Filter fest zur Kennzahldefinition? /
   **EN:** Why do unit and filter firmly belong to the metric definition?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Einheit ist unklar, ob Tage, Stunden oder Prozent gemeint sind; ohne Filter ist unklar, welche
   Datensätze zählen. Beides zusammen macht die Kennzahl erst eindeutig reproduzierbar.
   **EN:** Without a unit it is unclear whether days, hours, or percent are meant; without a filter it is
   unclear which records count. Both together first make the metric unambiguously reproducible.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Kennzahl mit Zähler, Nenner, Einheit, Filter und Zeitbezug definieren.
- [ ] einen festen Zeitbezug wählen und begründen.
- [ ] Mittelwert und Median passend zur Frage einsetzen.
- [ ] Filter und Dimension sauber trennen.
- [ ] Verantwortlichkeit für Definitionsänderungen festlegen.

**EN:** I can …

- [ ] define a metric with numerator, denominator, unit, filter, and time reference.
- [ ] choose and justify a fixed time reference.
- [ ] use mean and median to fit the question.
- [ ] separate filter and dimension cleanly.
- [ ] set responsibility for definition changes.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Data-Process-Track_02_Datenmodell-fuer-Kennzahlen-und-Auswertungen.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Data-Process-Track_02_Datenmodell-fuer-Kennzahlen-und-Auswertungen.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
