# Lernbegleiter: Secure CaseTracker 10 – Prozessanalyse und Kennzahlen / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_10_Prozessanalyse-und-Kennzahlen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** **Kennzahlen** verdichten viele Daten zu wenigen Zahlen: Wie viele Fälle sind offen? Wie lange dauert
die Bearbeitung im Schnitt? Wie hoch ist die Fehlerquote? Solche Zahlen helfen bei Entscheidungen – aber nur,
wenn man ihre **Grenzen** kennt. Eine schön aussehende Durchschnittszahl kann in die Irre führen, wenn Daten
fehlen oder falsch sind. In dieser Einheit definierst du einfache Prozesskennzahlen für den Secure CaseTracker,
beschreibst ihre Formeln und, ganz wichtig, ihre **Aussagegrenzen**. Gleichzeitig achtest du auf Datenschutz:
Kennzahlen dürfen keine Rückschlüsse auf echte Personen erlauben und keine vertraulichen Freitext-Details
enthalten.

**EN:** **Metrics** condense a lot of data into a few numbers: how many cases are open? How long does
processing take on average? What is the error rate? Such numbers help with decisions – but only if you know
their **limits**. A nice-looking average can mislead if data is missing or wrong. In this unit you define
simple process metrics for the Secure CaseTracker, describe their formulas and, very importantly, their
**limits of interpretation**. At the same time you watch privacy: metrics must not allow conclusions about
real people and must not contain confidential free-text details.

**DE:** Alle Testdaten sind fiktiv und wiederholbar. Fehlende, fehlerhafte oder widersprüchliche Daten werden
sichtbar behandelt, nicht stillschweigend ignoriert.

**EN:** All test data is fictitious and repeatable. Missing, faulty, or contradictory data is handled visibly,
not silently ignored.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Kennzahl / Metric | Verdichteter Zahlenwert, der einen Aspekt eines Prozesses beschreibt. |
| Durchlaufzeit / Throughput time | Zeit von der Anlage bis zum Abschluss eines Falls. |
| Aussagegrenze / Limit of interpretation | Grenze dessen, was eine Kennzahl wirklich aussagt. |
| Datenqualität / Data quality | Grad, in dem Daten vollständig, korrekt und konsistent sind. |
| Aggregation | Zusammenfassen vieler Einzelwerte zu einer Summe oder einem Mittel. |
| Zweckbindung / Purpose limitation | Daten nur für den festgelegten Zweck auswerten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Kennzahlen definieren.** Lege Kennzahlen mit Zweck fest: offene Fälle, geschlossene
Fälle, durchschnittliche Durchlaufzeit, Fehlerquote, Datenqualitätsprobleme. Warum mit Zweck? Eine Kennzahl
ohne klaren Zweck wird leicht falsch verwendet oder überinterpretiert.

**EN:** **Step 1 – Define metrics.** Set metrics with a purpose: open cases, closed cases, average throughput
time, error rate, data-quality issues. Why with a purpose? A metric without a clear purpose is easily misused
or over-interpreted.

**DE:** **Schritt 2 – Formeln festlegen.** Beschreibe für jede Kennzahl eine sprachneutrale Formel, z. B.
Durchlaufzeit = `closedAt - createdAt`. Warum sprachneutral? Alle sechs Zielsprachen müssen dieselben fiktiven
Testdaten gleich auswerten; nur so sind Ergebnisse vergleichbar.

**EN:** **Step 2 – Define formulas.** Describe a language-neutral formula for each metric, e.g. throughput time
= `closedAt - createdAt`. Why language-neutral? All six target languages must evaluate the same fictitious test
data equally; only then are results comparable.

**DE:** **Schritt 3 – Datenqualität und fehlende Werte sichtbar behandeln.** Entscheide, wie fehlende,
fehlerhafte oder widersprüchliche Daten behandelt werden (z. B. ausschließen und zählen, nicht raten). Warum?
Wer fehlende Werte stillschweigend füllt, verfälscht die Kennzahl und täuscht Genauigkeit vor.

**EN:** **Step 3 – Handle data quality and missing values visibly.** Decide how missing, faulty, or
contradictory data is handled (e.g. exclude and count, do not guess). Why? Whoever silently fills missing
values distorts the metric and fakes accuracy.

**DE:** **Schritt 4 – Aussagegrenzen und Datenschutz benennen.** Jede Kennzahl bekommt eine Aussagegrenze und
einen Warnhinweis zu möglichen Fehlinterpretationen. Kennzahlen dürfen keine Rückschlüsse auf echte Personen
erlauben; aggregierte Werte enthalten keine Freitext-Details. Warum? Zahlen wirken objektiv, sind es aber
nur, wenn ihre Grenzen mitgenannt werden – und Datenschutz gilt auch für Auswertungen.

**EN:** **Step 4 – Name limits of interpretation and privacy.** Every metric gets a limit of interpretation
and a warning about possible misinterpretations. Metrics must not allow conclusions about real people;
aggregated values contain no free-text details. Why? Numbers look objective but are only so if their limits
are stated – and privacy applies to evaluations too.

**DE:** **Typische Fehler.** Durchschnitt ohne Hinweis auf Ausreißer oder fehlende Daten. Personenbezogene
Details in Kennzahlen. Fehlende Werte still füllen. Nicht-deterministische Datums-/Zeittests. Kennzahl ohne
Aussagegrenze präsentieren.

**EN:** **Common mistakes.** Average without a note on outliers or missing data. Personal details in metrics.
Silently filling missing values. Non-deterministic date/time tests. Presenting a metric without a limit of
interpretation.

### Beispiel / Example

```text
Kennzahl:          Durchschnittliche Durchlaufzeit
Formel:            Mittelwert(closedAt - createdAt) ueber geschlossene Faelle
Fiktive Daten:     3 Faelle: 2 Tage, 4 Tage, closedAt fehlt (1 Fall)
Behandlung:        Fall ohne closedAt wird ausgeschlossen UND gezaehlt (1 unvollstaendig)
Ergebnis:          Durchschnitt = 3 Tage (Basis: 2 von 3 Faellen)
Aussagegrenze:     "Nur 2 vollstaendige Faelle; kleine Datenmenge, nicht repraesentativ."
Datenschutz:       kein Name, kein Freitext -> nur Status und Zeitdifferenz.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 6 Serviceanfragen bearbeiten | Primär / Primary | Kennzahlen werten die Bearbeitung von Serviceanfragen aus und machen sie steuerbar. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Die Kennzahlen stammen aus dem verwalteten Datenmodell und dessen Qualität. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, Zweckbindung und nachvollziehbare
Dokumentation. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review) und
`CL_11` (Datenschutz/Datenqualität). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Kennzahl hat
Zweck, Formel und Aussagegrenze, und keine Auswertung erlaubt Rückschlüsse auf echte Personen.* A11Y-Aspekt:
Auswertungen werden als klarer Text mit Zahlen und ausgeschriebenen Hinweisen dargestellt, nicht nur als
Farbdiagramm, damit sie mit Screenreader und Braille-Zeile verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: privacy, purpose limitation, and traceable documentation.
Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), and `CL_11`
(privacy/data quality). The security decision of this unit is: *every metric has purpose, formula, and a limit
of interpretation, and no evaluation allows conclusions about real people.* Accessibility aspect: evaluations
are shown as clear text with numbers and written-out notes, not only as a color chart, so they remain
understandable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum braucht jede Kennzahl eine Aussagegrenze? /
   **EN:** Why does every metric need a limit of interpretation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zahlen wirken objektiv, können aber täuschen, wenn Daten fehlen oder klein sind. Die Aussagegrenze
   schützt vor Fehlinterpretationen und falschen Entscheidungen.
   **EN:** Numbers look objective but can mislead when data is missing or small. The limit of interpretation
   protects against misinterpretation and wrong decisions.

   </details>

2. **DE:** (DPA) Welche Kennzahl kann leicht falsch interpretiert werden, und warum? /
   **EN:** (DPA) Which metric can easily be misinterpreted, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die durchschnittliche Durchlaufzeit: Wenige Ausreißer oder fehlende Abschlussdaten verschieben den
   Durchschnitt stark. Ohne Hinweis auf die Datenbasis wirkt sie genauer, als sie ist.
   **EN:** The average throughput time: a few outliers or missing completion data shift the average strongly.
   Without a note on the data basis, it looks more precise than it is.

   </details>

3. **DE:** Warum dürfen fehlende Werte nicht still gefüllt werden? /
   **EN:** Why must missing values not be filled silently?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Geratene Werte verfälschen die Kennzahl und täuschen Genauigkeit vor. Fehlende Daten werden sichtbar
   behandelt, z. B. ausgeschlossen und gezählt.
   **EN:** Guessed values distort the metric and fake accuracy. Missing data is handled visibly, e.g. excluded
   and counted.

   </details>

4. **DE:** (AE) Welche Berechnung muss deterministisch testbar sein? /
   **EN:** (AE) Which calculation must be deterministically testable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Datums- und Zeitberechnungen wie die Durchlaufzeit. Mit festen, fiktiven Testdaten liefert derselbe
   Lauf immer dasselbe Ergebnis, unabhängig von Zeitzone oder Uhrzeit.
   **EN:** Date and time calculations such as throughput time. With fixed, fictitious test data, the same run
   always yields the same result, independent of time zone or clock time.

   </details>

5. **DE:** (SI) Welche Betriebsdaten wären für Kennzahlen nützlich, aber sensibel? /
   **EN:** (SI) Which operational data would be useful for metrics but sensitive?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Detaillierte Logs oder Bearbeiterzuordnungen. Sie können Kennzahlen verbessern, erlauben aber leicht
   Rückschlüsse auf Personen und werden deshalb nur aggregiert und datensparsam genutzt.
   **EN:** Detailed logs or assignee mappings. They can improve metrics but easily allow conclusions about
   people and are therefore used only aggregated and data-minimal.

   </details>

6. **DE:** Warum müssen Kennzahlen ohne Rückschluss auf echte Personen auskommen? /
   **EN:** Why must metrics work without conclusions about real people?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Datenschutz und Zweckbindung verlangen Datensparsamkeit. Für Prozesskennzahlen reichen aggregierte
   Werte; personenbezogene Details sind unnötig und riskant.
   **EN:** Privacy and purpose limitation require data minimization. Aggregated values are enough for process
   metrics; personal details are unnecessary and risky.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Prozesskennzahlen mit Zweck und Formel definieren.
- [ ] für jede Kennzahl eine Aussagegrenze benennen.
- [ ] fehlende oder fehlerhafte Daten sichtbar behandeln.
- [ ] Kennzahlen ohne Rückschluss auf echte Personen gestalten.
- [ ] eine Beispielauswertung mit fiktiven, wiederholbaren Daten erstellen.

**EN:** I can …

- [ ] define process metrics with purpose and formula.
- [ ] name a limit of interpretation for each metric.
- [ ] handle missing or faulty data visibly.
- [ ] design metrics without conclusions about real people.
- [ ] create a sample evaluation with fictitious, repeatable data.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_10_Prozessanalyse-und-Kennzahlen.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_10_Prozessanalyse-und-Kennzahlen.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
