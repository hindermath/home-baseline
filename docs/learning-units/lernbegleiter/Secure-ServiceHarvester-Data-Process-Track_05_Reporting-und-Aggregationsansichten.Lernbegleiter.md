# Lernbegleiter: Secure ServiceHarvester Data & Process Track 05 – Reporting und Aggregationsansichten / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_05_Reporting-und-Aggregationsansichten.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Kennzahlen aus Einheit 03 sind definiert – jetzt sollen sie **jemandem** nützen. Ein **Bericht**
(Report) beantwortet eine Frage für einen bestimmten Adressaten, damit dieser eine Entscheidung treffen kann.
Der Kunde fragt: „Wie steht es diese Woche um unseren Maschinenpark?" Die Rohdaten je Maschine helfen ihm nicht;
er braucht eine **Aggregationsansicht** – zusammengefasste Zahlen je Gruppe, etwa je Betriebssystem, Standort
oder Zeitfenster. Im 3. Lehrjahr gestaltest du diesen Auswertungsprozess bewusst: Welche Ebene beantwortet die
Frage? Welche Aussagegrenze gilt? Und wie bleibt der Bericht für alle lesbar – auch mit Screenreader oder
Braille-Zeile?

**EN:** The metrics from unit 03 are defined – now they should be **useful to someone**. A **report** answers a
question for a specific audience so that they can make a decision. The customer asks: "how is our machine fleet
doing this week?" The raw data per machine does not help them; they need an **aggregation view** – summarized
numbers per group, for example per operating system, site, or time window. In year 3 you deliberately shape this
evaluation process: which level answers the question? Which limit of validity applies? And how does the report
stay readable for everyone – including with a screen reader or Braille display?

**DE:** Du lernst, Berichte adressatengerecht zu planen, sinnvolle Aggregationsebenen zu wählen, die
Aussagegrenzen aus Einheit 06 mitzuführen und Aggregation zugleich als Datenschutz zu nutzen: Wer nur Gruppen
zeigt, macht keine Einzelperson nachverfolgbar.

**EN:** You learn to plan reports for their audience, choose sensible aggregation levels, carry the
interpretation limits from unit 06 along, and use aggregation as privacy at the same time: showing only groups
makes no individual traceable.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Bericht / Report | Aufbereitete Antwort auf eine fachliche Frage für einen bestimmten Adressaten. |
| Aggregation / Aggregation | Zusammenfassen vieler Einzelwerte zu einer Gruppenzahl (z. B. Summe, Anteil, Mittelwert). |
| Aggregationsebene / Aggregation level | Gruppierungsmerkmal, nach dem zusammengefasst wird (z. B. Betriebssystem, Standort). |
| Adressat / Audience | Person oder Rolle, für die der Bericht gedacht ist und die eine Entscheidung trifft. |
| Mindestgruppengröße / Minimum group size | Kleinste erlaubte Gruppe, damit keine Einzelperson re-identifizierbar wird. |
| Aussagegrenze / Limit of validity | Ausdrückliche Angabe, wofür eine Zahl gilt und wofür nicht. |
| Re-Identifikation / Re-identification | Rückschluss von aggregierten Zahlen auf eine einzelne Person oder Maschine. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Adressat und Entscheidung zuerst.** Bevor du eine Zahl darstellst, frage: Wer liest den
Bericht, und welche Entscheidung soll er stützen? Ein Bericht für die Wartung braucht andere Zahlen als ein
Bericht für die Geschäftsleitung. Ein Bericht ohne benannten Adressaten und ohne Entscheidung ist nur eine
Zahlensammlung.

**EN:** **Step 1 – Audience and decision first.** Before you present a number, ask: who reads the report, and
which decision should it support? A report for maintenance needs different numbers than a report for management.
A report without a named audience and without a decision is only a collection of numbers.

**DE:** **Schritt 2 – Aggregationsebene begründet wählen.** Fasse die Kennzahlen nach einem sinnvollen Merkmal
zusammen: je Betriebssystem, je Standort, je Kalenderwoche. Die Ebene muss zur Frage passen. „Wie viele Rechner
laufen je Standort?" verlangt die Ebene Standort, nicht die Ebene Einzelmaschine. Halte fest, warum du die Ebene
gewählt hast.

**EN:** **Step 2 – Choose the aggregation level with a rationale.** Summarize the metrics by a sensible
attribute: per operating system, per site, per calendar week. The level must fit the question. "How many
machines run per site?" requires the site level, not the single-machine level. Record why you chose the level.

**DE:** **Schritt 3 – Aussagegrenze in den Bericht übernehmen.** Eine aggregierte Zahl erbt die Grenzen ihrer
Rohdaten. Beruht der Bericht auf `last_contact`, gilt er nur für Maschinen, die sich gemeldet haben. Schreibe die
Grenze sichtbar in den Bericht, z. B. als Fußzeile „Gilt für 24-h-Meldefenster; 26 % ohne aktuelle Meldung nicht
enthalten". So verhinderst du, dass die schöne Zusammenfassung mehr behauptet, als die Daten hergeben.

**EN:** **Step 3 – Carry the limit of validity into the report.** An aggregated number inherits the limits of
its raw data. If the report is based on `last_contact`, it holds only for machines that reported in. Write the
limit visibly into the report, e.g. as a footer "Applies to the 24-h reporting window; 26% without a current
report not included". This prevents the neat summary from claiming more than the data supports.

**DE:** **Schritt 4 – Aggregation als Datenschutz nutzen.** Aggregation fasst zusammen und verbirgt damit
Einzelfälle – aber nur, wenn die Gruppen groß genug sind. Eine Gruppe mit nur einer Maschine ist keine
Aggregation, sondern zeigt genau diese Maschine. Lege eine **Mindestgruppengröße** fest (z. B. „Gruppen unter 5
werden zu ‚Sonstige' zusammengelegt"), damit niemand über kleine Gruppen re-identifiziert werden kann.

**EN:** **Step 4 – Use aggregation as privacy.** Aggregation summarizes and thereby hides individual cases – but
only if the groups are large enough. A group with just one machine is not aggregation; it shows exactly that
machine. Define a **minimum group size** (e.g. "groups below 5 are merged into 'other'") so that no one can be
re-identified through small groups.

**DE:** **Schritt 5 – Barrierefrei darstellen.** Ein Bericht muss für alle nutzbar sein. Verwende echte Tabellen
mit Kopfzeile statt reiner Farbbalken, gib Bedeutung nie nur über Farbe an („grün = gut" schließt Menschen aus)
und beschrifte jede Spalte. So bleibt der Bericht mit Screenreader und Braille-Zeile lesbar. Barrierefreiheit ist
hier kein Zusatz, sondern Teil der Reporting-Qualität.

**EN:** **Step 5 – Present accessibly.** A report must be usable by everyone. Use real tables with a header row
instead of color bars only, never convey meaning through color alone ("green = good" excludes people), and label
every column. This keeps the report readable with a screen reader and Braille display. Accessibility here is not
an add-on but part of reporting quality.

**DE:** **Typische Fehler.** Rohdaten je Maschine als „Bericht" ausgeben. Adressat und Entscheidung nicht
benennen. Die Aussagegrenze weglassen. Gruppen so klein wählen, dass Einzelne sichtbar werden. Bedeutung nur über
Farbe zeigen. Nicht anwendbare Standards stillschweigend weglassen statt als `N/A` mit Begründung.

**EN:** **Common mistakes.** Presenting per-machine raw data as a "report". Not naming audience and decision.
Omitting the limit of validity. Choosing groups so small that individuals become visible. Conveying meaning only
through color. Silently dropping non-applicable standards instead of documenting them as `N/A` with a rationale.

### Beispiel / Example

```text
Bericht:     "Wochenreport Maschinenpark" fuer Wartungsleitung -> Entscheidung: Wartung priorisieren

Aggregationsansicht (je Betriebssystem):
  Betriebssystem   Bekannt   Aktuell < 24 h   Stale     Anteil aktuell
  Linux            120       102              18        85 %
  Windows           64        44              20        69 %
  macOS             11         9               2        (Gruppe < min -> mit "Sonstige" zusammengelegt)
  Sonstige           7         5               2        -

Aussagegrenze:  Gilt fuer 24-h-Meldefenster; misst Meldung, nicht Nutzung (Einheit 06)
Datenschutz:    Mindestgruppengroesse 5; kleinere Gruppen -> "Sonstige"; keine Einzelmaschine ausgewiesen
A11Y:           echte Tabelle mit Kopfzeile; Status als Text, nicht nur als Farbe
N/A:            interaktives Dashboard in dieser Einheit N/A -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11c**
ist primär, weil Reporting- und Aggregationsansichten den Auswertungsprozess gestalten und ihn auf Entscheidungen
ausrichten; LF 6 ist berührt, weil aus den Berichten konkrete Serviceanfragen und Wartungsaufträge entstehen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
11c** is primary because reporting and aggregation views shape the evaluation process and orient it toward
decisions; LF 6 is touched because concrete service requests and maintenance orders arise from the reports.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11c Prozesse analysieren und gestalten | Primär / Primary | Reporting- und Aggregationsansichten gestalten den Auswertungsprozess und richten ihn auf Entscheidungen aus. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Aus den Berichten entstehen konkrete Serviceanfragen und Wartungsaufträge. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz durch Aggregation, Nachvollziehbarkeit,
Testbarkeit und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review der Aggregation), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die
Datenentscheidung dieser Einheit lautet: *Jeder Bericht nennt Adressat, Entscheidung und Aussagegrenze,
aggregiert oberhalb einer Mindestgruppengröße und macht keine Einzelperson nachverfolgbar.* A11Y-Aspekt: Berichte
sind echte Tabellen mit Kopfzeile und tragen Bedeutung nie nur über Farbe, damit sie mit Screenreader und
Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: privacy through aggregation, traceability, testability, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review of
the aggregation), `CL_10` (data protection), and `CL_12` (evidence and closure). The data decision of this unit
is: *every report names audience, decision, and limit of validity, aggregates above a minimum group size, and
makes no individual traceable.* Accessibility aspect: reports are real tables with a header row and never carry
meaning through color alone, so they stay usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum beginnt ein guter Bericht mit dem Adressaten und der Entscheidung, nicht mit der Zahl? /
   **EN:** Why does a good report start with the audience and the decision, not with the number?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Erst Adressat und Entscheidung legen fest, welche Zahlen relevant sind und wie sie dargestellt werden.
   Ohne diese Ausrichtung entsteht eine Zahlensammlung, die keine Entscheidung stützt.
   **EN:** Only the audience and the decision determine which numbers are relevant and how they are presented.
   Without this orientation you get a collection of numbers that supports no decision.

   </details>

2. **DE:** (DPA) Wie hilft eine begründete Aggregationsebene, die Kundenfrage zu beantworten? /
   **EN:** (DPA) How does a justified aggregation level help answer the customer's question?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Ebene bestimmt, wie zusammengefasst wird. „Rechner je Standort" verlangt die Ebene Standort. Eine
   passende Ebene macht die Antwort direkt lesbar; eine falsche Ebene erzeugt entweder Detailflut oder verdeckt
   die relevante Struktur.
   **EN:** The level determines how data is summarized. "Machines per site" requires the site level. A fitting
   level makes the answer directly readable; a wrong level either floods with detail or hides the relevant
   structure.

   </details>

3. **DE:** (DPA) Warum ist eine Aggregationsgruppe mit nur einer Maschine ein Datenschutzproblem? /
   **EN:** (DPA) Why is an aggregation group with only one machine a privacy problem?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Gruppe mit nur einem Element fasst nichts zusammen, sondern zeigt genau dieses Element. Damit wird
   die einzelne Maschine oder Person re-identifizierbar. Eine Mindestgruppengröße verhindert das.
   **EN:** A group with only one element summarizes nothing; it shows exactly that element. This makes the single
   machine or person re-identifiable. A minimum group size prevents that.

   </details>

4. **DE:** Warum muss die Aussagegrenze der Kennzahl auch im aggregierten Bericht stehen? /
   **EN:** Why must the metric's limit of validity also appear in the aggregated report?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine aggregierte Zahl erbt die Grenzen ihrer Rohdaten. Ohne die Grenze wirkt der Bericht belastbarer,
   als er ist. Sichtbar gemacht schützt die Grenze vor Fehlinterpretation und falschen Entscheidungen.
   **EN:** An aggregated number inherits the limits of its raw data. Without the limit the report seems more
   robust than it is. Made visible, the limit protects against misinterpretation and wrong decisions.

   </details>

5. **DE:** (SI) Welche Betriebsbedingung kann die Aktualität eines Berichts einschränken? /
   **EN:** (SI) Which operational condition can limit the freshness of a report?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Das Sammelintervall und die Berichtserzeugung. Werden Daten nur alle Stunden gesammelt oder der Bericht
   nur nachts erzeugt, ist er entsprechend alt. Diese Verzögerung gehört als Aussagegrenze in den Bericht.
   **EN:** The collection interval and the report generation. If data is collected only hourly or the report is
   built only at night, it is correspondingly old. This delay belongs in the report as a limit of validity.

   </details>

6. **DE:** (AE) Welche Abfrage- oder Gruppierungslogik folgt aus einer Aggregationsansicht je Betriebssystem? /
   **EN:** (AE) Which query or grouping logic follows from an aggregation view per operating system?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Gruppierung nach dem Feld `os` mit Zählungen und Anteilen je Gruppe, plus eine Regel, die Gruppen
   unter der Mindestgröße zusammenlegt. Die Logik bleibt sprachneutral und ist in jeder Zielsprache umsetzbar.
   **EN:** A grouping by the field `os` with counts and shares per group, plus a rule that merges groups below the
   minimum size. The logic stays language-neutral and can be implemented in every target language.

   </details>

7. **DE:** Warum darf ein Bericht Bedeutung nicht nur über Farbe transportieren? /
   **EN:** Why must a report not convey meaning through color alone?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Farbe allein ist für Screenreader, Braille-Zeilen und Menschen mit Farbsehschwäche nicht nutzbar. Steht
   die Bedeutung auch als Text (z. B. „stale") in einer Tabellenspalte, bleibt der Bericht für alle lesbar (WCAG).
   **EN:** Color alone is not usable for screen readers, Braille displays, and people with color vision
   deficiency. If the meaning is also present as text (e.g. "stale") in a table column, the report stays readable
   for everyone (WCAG).

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Bericht mit Adressat und gestützter Entscheidung planen.
- [ ] eine begründete Aggregationsebene für eine Kundenfrage wählen.
- [ ] eine Mindestgruppengröße festlegen und begründen.
- [ ] die Aussagegrenze jeder Kennzahl in den Bericht übernehmen.
- [ ] Aggregation so einsetzen, dass keine Einzelperson nachverfolgbar wird.
- [ ] Berichte als barrierefreie Tabellen ohne reine Farbcodierung gestalten.

**EN:** I can …

- [ ] plan a report with an audience and a supported decision.
- [ ] choose a justified aggregation level for a customer question.
- [ ] define and justify a minimum group size.
- [ ] carry each metric's limit of validity into the report.
- [ ] use aggregation so that no individual person becomes traceable.
- [ ] design reports as accessible tables without color-only coding.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_05_Reporting-und-Aggregationsansichten.md`. Sie baut auf
Einheit 03 (`Kennzahlen und Betriebsmetriken`) auf und übernimmt die Grenzen aus Einheit 06 (`Aussagegrenzen und
Datenunsicherheit`). Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_05_Reporting-und-Aggregationsansichten.md`. It builds on
unit 03 (`metrics and operational measurements`) and carries over the limits from unit 06 (`interpretation limits
and data uncertainty`). The copy-paste prompt for a later, manually started Spec Kit run is provided there.
