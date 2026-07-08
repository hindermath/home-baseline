# Lernbegleiter: Secure OrderDesk Data & Process Track 08 – Prozessfeedback und Verbesserung / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Data-Process-Track_08_Prozessfeedback-und-Verbesserung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Kennzahlen und erkannte Auffälligkeiten aus den Secure-OrderDesk-Handelsdaten sind kein Selbstzweck.
Ihr Wert entsteht erst, wenn daraus konkrete **Verbesserungen** für den Bestell- und Datenerfassungsprozess der
Handelsplattform werden (z. B. „viele Bestellungen ohne Versanddatum → Erfassungsprozess prüfen"). Der Weg von
der Zahl zur Maßnahme braucht eine geprüfte **Ursache**, eine vorab formulierte **Wirkungshypothese** („wenn wir
X ändern, erwarten wir Y"), eine benannte **Verantwortlichkeit** und eine **Follow-up-Regel**. Feedback muss zum
Prozess zurückfließen, sonst bleibt es ein Bericht ohne Folgen (Regelkreis).

**EN:** Metrics and detected anomalies from the Secure OrderDesk trading data are not an end in themselves. Their
value arises only when they turn into concrete **improvements** for the ordering and data-capture process of the
trading platform (e.g., "many orders without a shipping date → check the capture process"). The path from number
to measure needs a checked **cause**, a pre-formulated **effect hypothesis** ("if we change X, we expect Y"), a
named **responsibility**, and a **follow-up rule**. Feedback must flow back into the process, otherwise it stays a
report without consequences (feedback loop).

**DE:** In dieser Einheit lernst du, aus Datenergebnissen der Northwind-Basis (inkl. `ALFKI`) priorisierte
Maßnahmen zu machen, Wirkungshypothesen und Verantwortlichkeiten festzulegen und einen ehrlichen Feedback- und
Follow-up-Kreis zu gestalten – auch für Maßnahmen, die nicht gewirkt haben. Typische Handelsthemen sind
unvollständige Bestellpositionen, Rabatt-Ausreißer und Lücken in der Datenqualität.

**EN:** In this unit you learn to turn data results from the Northwind base (incl. `ALFKI`) into prioritized
measures, to set effect hypotheses and responsibilities, and to design an honest feedback and follow-up loop –
also for measures that did not work. Typical trading topics are incomplete order line items, discount outliers,
and gaps in data quality.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Prozessfeedback / Process feedback | Rückfluss der Datenerkenntnisse in den laufenden Bestell- und Handelsprozess. |
| Verbesserungsvorschlag / Improvement proposal | Konkrete, begründete Änderung, die eine Kennzahl oder Datenqualität gezielt verbessern soll. |
| Wirkung/Aufwand / Effect and effort | Abwägung, wie viel Nutzen eine Maßnahme bringt im Verhältnis zu den nötigen Ressourcen. |
| Priorisierung / Prioritization | Reihenfolge der Maßnahmen nach erwarteter Wirkung und Aufwand. |
| Scheinkausalität / Spurious causality | Vermuteter Ursache-Wirkung-Zusammenhang, den die Daten nicht belegen. |
| Umsetzbarkeit / Feasibility | Ob eine Maßnahme mit den vorhandenen Mitteln und Rechten realistisch machbar ist. |
| Aussagegrenze / Limit of validity | Grenze, bis zu der eine Kennzahl oder Wirkungsmessung belastbar ist. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Von der Zahl zur geprüften Ursache.** Bevor du einen Vorschlag machst, prüfe die
wahrscheinliche Ursache (Aufbau aus Einheit 06 Aussagegrenzen und 07 Anomalien). Viele Bestellungen ohne
Versanddatum können an einem stornierten Auftrag, an einer Erfassungslücke im Bestellprozess oder an einem
Importfehler liegen – jede Ursache erfordert eine andere Maßnahme.

**EN:** **Step 1 – From number to checked cause.** Before you make a proposal, check the likely cause (building on
unit 06 limits of validity and 07 anomalies). Many orders without a shipping date may be due to a cancelled
order, a capture gap in the ordering process, or an import error – each cause requires a different measure.

**DE:** **Schritt 2 – Wirkungshypothese vorab formulieren.** Schreibe vor der Umsetzung auf, was du erwartest:
„Wenn wir im Bestellformular das Versanddatum als Pflichtfeld führen, erwarten wir einen Anteil vollständiger
Positionen über 98 %." So lässt sich später fair prüfen, ob der Vorschlag gewirkt hat.

**EN:** **Step 2 – Formulate the effect hypothesis in advance.** Before implementing, write down what you expect:
"If we make the shipping date a mandatory field in the order form, we expect a share of complete line items above
98 %." This allows a fair later check of whether the proposal worked.

**DE:** **Schritt 3 – Wirkung und Aufwand abwägen, priorisieren und Verantwortung zuweisen.** Nicht alles
gleichzeitig. Ordne Vorschläge nach erwarteter Wirkung und Aufwand und prüfe die Umsetzbarkeit. Jeder Vorschlag
braucht eine verantwortliche Rolle und einen Zeitrahmen – ohne Verantwortliche/n passiert nichts.

**EN:** **Step 3 – Weigh effect and effort, prioritize, and assign responsibility.** Not everything at once. Order
proposals by expected effect and effort and check their feasibility. Each proposal needs a responsible role and a
timeframe – without an owner nothing happens.

**DE:** **Schritt 4 – Follow-up mit passender Aussagegrenze.** Lege fest, wann du die Wirkung misst, mit welcher
Kennzahl und welcher Aussagegrenze aus Einheit 06. Auch die Wirkungsmessung beruht auf lückenhaften Handelsdaten;
ohne Aussagegrenze deutest du eine zufällige Schwankung als Erfolg (Scheinkausalität).

**EN:** **Step 4 – Follow-up with a matching limit of validity.** Define when you measure the effect, with which
metric and which limit of validity from unit 06. The effect measurement also rests on incomplete trading data;
without a limit of validity you read a random fluctuation as success (spurious causality).

**DE:** **Schritt 5 – Ehrliches Feedback zurückspielen.** Auch ein Vorschlag, der **nicht** gewirkt hat, ist ein
wertvolles Ergebnis: Er schließt eine Ursache aus. Verzerre die Auswertung nicht, um den eigenen Vorschlag gut
aussehen zu lassen. Ehrliches Feedback verbessert den Bestellprozess dauerhaft.

**EN:** **Step 5 – Play honest feedback back.** A proposal that did **not** work is also a valuable result: it
rules out a cause. Do not distort the evaluation to make your own proposal look good. Honest feedback improves the
ordering process durably.

**DE:** **Typische Fehler.** Vorschlag ohne geprüfte Ursache. Keine Wirkungshypothese, daher keine faire
Bewertung. Scheinkausalität statt geprüftem Zusammenhang. Keine Verantwortliche/n. Kein Follow-up-Termin.
Follow-up ohne Aussagegrenze. Das eigene Ergebnis schönen.

**EN:** **Common mistakes.** A proposal without a checked cause. No effect hypothesis, so no fair assessment.
Spurious causality instead of a checked relation. No owner. No follow-up date. Follow-up without a limit of
validity. Prettifying one's own result.

### Beispiel / Example

```text
Vorschlag          Datenbeleg                              Wirkung  Aufwand  Prioritaet
Versanddatum        21 % der Bestellungen ohne ShippedDate  hoch     mittel   hoch
  als Pflichtfeld
Rabatt-Regel        Discount > 0.50 bei 4 Positionen        mittel   niedrig  mittel
  begrenzen
Import-Pruefung     3 % Positionen ohne gueltige ProductID  hoch     hoch     mittel
  fuer ProductID
Kunden-Stammdaten   ALFKI vollstaendig, andere lueckenhaft  niedrig  mittel   niedrig
  vervollstaendigen

Wirkungshypothese: Versanddatum-Pflichtfeld -> Anteil vollstaendiger Positionen > 98 %
Verantwortung:     Rolle "Bestellprozess/Erfassung", Umsetzung bis 2026-08
Follow-up:         Messung 2026-09, Aussagegrenze aus Einheit 06 beachten
Ergebnis-Regel:    auch Nicht-Wirkung wird ehrlich dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt
„Secure OrderDesk Professional Tracks"). **LF 11c** ist primär, weil aus Datenerkenntnissen des Handels gezielt
Verbesserungen für den Bestellprozess abgeleitet und der Prozess gestaltet wird; **LF 6** ist berührt, weil
Verbesserungen direkt auf die Bearbeitung von Kunden- und Serviceanfragen zurückwirken.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section
"Secure OrderDesk Professional Tracks"). **LF 11c** is primary because concrete improvements for the ordering
process are derived from trading data insights and the process is shaped; **LF 6** is touched because improvements
feed directly back into handling customer and service requests.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11c Prozesse analysieren und gestalten | Primär / Primary | Aus Handelsdaten begründete Verbesserungen abzuleiten und den Bestellprozess gezielt zu gestalten ist der Kern. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Verbesserungen wirken direkt auf die Bearbeitung von Kunden- und Serviceanfragen zurück. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: belastbare Aussagen nur mit Nachweis, nachvollziehbare
Entscheidungen und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Review),
`CL_10` (Datenschutz), `CL_11` (Betriebs-/Qualitätsnachweis) und `CL_12` (auditfähige Nachweise). Die
Datenentscheidung dieser Einheit lautet: *Jeder Verbesserungsvorschlag hat eine geprüfte Ursache, eine vorab
formulierte Wirkungshypothese und einen Follow-up-Termin; keine Scheinkausalität ohne Datenbeleg.* Datenzugriffe
auf die Northwind-Basis inkl. `ALFKI` erfolgen über parametrisierte Queries; nur benötigte Felder werden
ausgewertet (Datenminimierung). A11Y-Aspekt: Vorschlags- und Maßnahmenlisten müssen als klare Tabelle mit
Datenbeleg, Verantwortlichkeit und Termin lesbar sein; Priorität wird als Wort (hoch/mittel/niedrig), nicht nur
als Farbe angegeben.

**EN:** Relation to the Secure Development Guideline: reliable statements only with evidence, traceable decisions,
and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (review), `CL_10` (data
protection), `CL_11` (operations/quality evidence), and `CL_12` (audit-ready evidence). The data decision of this
unit is: *every improvement proposal has a checked cause, a pre-formulated effect hypothesis, and a follow-up
date; no spurious causality without data evidence.* Data access to the Northwind base incl. `ALFKI` uses
parameterized queries; only needed fields are evaluated (data minimization). Accessibility aspect: proposal and
measure lists must be readable as a clear table with data evidence, owner, and date; priority is given as a word
(high/medium/low), not by color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DPA) Warum muss vor dem Verbesserungsvorschlag die Ursache geprüft werden? /
   **EN:** (DPA) Why must the cause be checked before the improvement proposal?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Vorschlag gegen die falsche Ursache wirkt nicht und kostet trotzdem Aufwand. Viele Bestellungen
   ohne Versanddatum durch Stornos brauchen eine andere Maßnahme als eine echte Erfassungslücke. Erst die
   geprüfte Ursache macht den Vorschlag sinnvoll.
   **EN:** A proposal against the wrong cause does not work and still costs effort. Many orders without a shipping
   date due to cancellations need a different measure than a real capture gap. Only the checked cause makes the
   proposal sensible.

   </details>

2. **DE:** Wozu dient eine vorab formulierte Wirkungshypothese? /
   **EN:** What is a pre-formulated effect hypothesis for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie legt fest, was man erwartet, und macht die spätere Bewertung fair. Ohne sie kann man das
   Ergebnis nachträglich passend deuten.
   **EN:** It defines what one expects and makes the later assessment fair. Without it, one can interpret the
   result to fit afterwards.

   </details>

3. **DE:** (DPA) Was ist Scheinkausalität und wie vermeidest du sie beim Bestellprozess? /
   **EN:** (DPA) What is spurious causality and how do you avoid it in the ordering process?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Scheinkausalität ist ein vermuteter Ursache-Wirkung-Zusammenhang, den die Daten nicht belegen. Ein
   gleichzeitiger Umsatzanstieg und ein neues Formular heißt nicht, dass das Formular den Umsatz gebracht hat.
   Man vermeidet sie durch eine geprüfte Ursache, eine Wirkungshypothese und eine Aussagegrenze.
   **EN:** Spurious causality is a suspected cause-effect relation that the data do not prove. A simultaneous
   revenue rise and a new form does not mean the form caused the revenue. You avoid it with a checked cause, an
   effect hypothesis, and a limit of validity.

   </details>

4. **DE:** (DPA) Warum ist ein Vorschlag, der nicht gewirkt hat, trotzdem wertvoll? /
   **EN:** (DPA) Why is a proposal that did not work still valuable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er schließt eine Ursache aus und verhindert, dass man denselben Weg noch einmal geht. Ehrliches
   „hat nicht gewirkt" ist echtes Wissen über den Bestellprozess.
   **EN:** It rules out a cause and prevents repeating the same path. An honest "did not work" is real knowledge
   about the ordering process.

   </details>

5. **DE:** (DPA) Warum gehört die Aussagegrenze aus Einheit 06 auch zur Follow-up-Messung? /
   **EN:** (DPA) Why does the limit of validity from unit 06 also belong to the follow-up measurement?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Auch die Wirkungsmessung beruht auf lückenhaften Handelsdaten. Ohne Aussagegrenze deutet man eine
   zufällige Schwankung als Erfolg oder Misserfolg des Vorschlags.
   **EN:** The effect measurement also rests on incomplete trading data. Without a limit of validity, one reads a
   random fluctuation as success or failure of the proposal.

   </details>

6. **DE:** Wie hilft die Abwägung von Wirkung und Aufwand bei der Priorisierung? /
   **EN:** How does weighing effect and effort help with prioritization?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie lenkt die begrenzten Ressourcen auf die Vorschläge mit dem besten Verhältnis von Nutzen zu
   Aufwand, statt alles gleichzeitig und halb zu tun. Ein hoher Aufwand bei geringer Wirkung rutscht nach unten.
   **EN:** It directs limited resources to the proposals with the best benefit-to-effort ratio, instead of doing
   everything at once and half-heartedly. High effort with low effect moves down the list.

   </details>

7. **DE:** (DV) Warum sichert eine Import-Prüfung für `ProductID` die Datenqualität der Bestellpositionen? /
   **EN:** (DV) Why does an import check for `ProductID` secure the data quality of the order line items?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Positionen ohne gültige `ProductID` lassen sich keinem Produkt zuordnen und verfälschen Umsatz- und
   Mengenauswertungen. Eine Import-Prüfung schließt die wiederkehrende Datenlücke direkt an der Schnittstelle.
   **EN:** Line items without a valid `ProductID` cannot be assigned to a product and distort revenue and quantity
   evaluations. An import check closes the recurring data gap directly at the interface.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Kennzahl über die geprüfte Ursache mit einem begründeten Verbesserungsvorschlag verbinden.
- [ ] eine Wirkungshypothese vorab formulieren.
- [ ] Vorschläge nach Wirkung und Aufwand abwägen und priorisieren.
- [ ] Scheinkausalität von einem datenbelegten Zusammenhang unterscheiden.
- [ ] Verantwortlichkeit und Follow-up-Termin mit Aussagegrenze festlegen.
- [ ] nicht anwendbare Vorschläge als `N/A` mit kurzer Begründung dokumentieren.

**EN:** I can …

- [ ] connect a metric via the checked cause to a justified improvement proposal.
- [ ] formulate an effect hypothesis in advance.
- [ ] weigh proposals by effect and effort and prioritize them.
- [ ] distinguish spurious causality from a data-supported relation.
- [ ] set responsibility and a follow-up date with a limit of validity.
- [ ] document non-applicable proposals as `N/A` with a short justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Data-Process-Track_08_Prozessfeedback-und-Verbesserung.md`. Diese Einheit nutzt die
Aussagegrenzen aus `06` und die Erkennung aus `07`; die Nachweise werden in `09` getestet. Der Copy-Paste-Prompt
für einen späteren, manuell gestarteten Spec-Kit-Lauf steht im Lastenheft.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Data-Process-Track_08_Prozessfeedback-und-Verbesserung.md`. This unit uses the
limits of validity from `06` and the detection from `07`; the evidence is tested in `09`. The copy-paste prompt
for a later, manually started Spec Kit run is provided in the intake.
