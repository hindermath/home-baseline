# Lernbegleiter: Secure ServiceHarvester Data & Process Track 06 – Aussagegrenzen und Datenunsicherheit / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der ServiceHarvester sammelt Statusdaten von Maschinen in **Intervallen**. Zwischen zwei Sammelläufen
weiß der Dienst nichts. Meldet sich eine Maschine gerade nicht, altert ihr `last_contact`. Aus solchen Daten
lassen sich Kennzahlen bilden – aber jede Kennzahl hat eine **Aussagegrenze**: Sie gilt nur unter bestimmten
Bedingungen. „85 % der Maschinen laufen" ist ohne Zusatz irreführend. Ehrlich ist: „85 % der Maschinen, die
sich in den letzten 24 Stunden gemeldet haben, meldeten den Status `läuft`." Der Rest ist unbekannt, nicht
automatisch „aus".

**EN:** The ServiceHarvester collects machine status data in **intervals**. Between two collection runs the
service knows nothing. If a machine is currently silent, its `last_contact` ages. Metrics can be built from
such data – but every metric has a **limit of validity**: it only holds under certain conditions. "85 % of
machines are running" is misleading without an addition. Honest is: "85 % of the machines that reported in the
last 24 hours reported status `running`." The rest is unknown, not automatically "off".

**DE:** In dieser Einheit lernst du, **Datenunsicherheit** (Erfassungslücken, Aktualität, Stichprobenintervall,
Abdeckung) sichtbar zu machen und zu jeder Kennzahl eine ausdrückliche Aussagegrenze zu formulieren. So wird
aus einer scheinbar exakten Zahl eine ehrliche, belastbare Aussage.

**EN:** In this unit you learn to make **data uncertainty** (collection gaps, freshness, sampling interval,
coverage) visible and to formulate an explicit limit of validity for every metric. This turns a seemingly
exact number into an honest, robust statement.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Aussagegrenze / Limit of validity | Bedingung, unter der eine Kennzahl gilt; alles außerhalb ist nicht belegt. |
| Datenunsicherheit / Data uncertainty | Grad, zu dem die Daten unvollständig, veraltet oder unsicher sind. |
| Erfassungslücke / Collection gap | Zeitraum ohne Sammelergebnis, z. B. weil eine Maschine schwieg. |
| Aktualität / Freshness | Wie alt der jüngste bekannte Wert ist (z. B. Alter von `last_contact`). |
| Stichprobenintervall / Sampling interval | Abstand zwischen zwei Sammelläufen; bestimmt, was zwischendurch unsichtbar bleibt. |
| Abdeckung / Coverage | Anteil der Maschinen oder Zeitpunkte, für die überhaupt Daten vorliegen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Datenherkunft und Intervall verstehen.** Kläre, wie oft gesammelt wird und wie eine
Maschine überhaupt in die Daten kommt. Ein 15-Minuten-Intervall bedeutet: Ereignisse zwischen zwei Läufen
bleiben unsichtbar. Das ist keine Schwäche, solange man es benennt.

**EN:** **Step 1 – Understand data origin and interval.** Clarify how often collection happens and how a
machine even enters the data. A 15-minute interval means events between two runs stay invisible. That is not a
weakness as long as you name it.

**DE:** **Schritt 2 – Abdeckung und Aktualität messen.** Für jede Kennzahl: Für wie viele Maschinen liegen
Daten vor (Abdeckung)? Wie alt ist der jüngste Wert (Aktualität)? Eine Kennzahl über 40 von 100 Maschinen ist
etwas anderes als über 98 von 100. Fehlende Werte nicht stillschweigend als „normal" behandeln.

**EN:** **Step 2 – Measure coverage and freshness.** For each metric: for how many machines is there data
(coverage)? How old is the most recent value (freshness)? A metric over 40 of 100 machines differs from one
over 98 of 100. Do not silently treat missing values as "normal".

**DE:** **Schritt 3 – Unsicherheit von der Kennzahl trennen.** Schreibe die Kennzahl und ihre Unsicherheit in
getrennte Felder. Warum? Weil die Zahl und ihre Verlässlichkeit unterschiedliche Prüfungen brauchen. Eine
Kennzahl ohne Unsicherheitsangabe wirkt genauer, als sie ist.

**EN:** **Step 3 – Separate uncertainty from the metric.** Write the metric and its uncertainty in separate
fields. Why? Because the number and its reliability need different checks. A metric without an uncertainty note
looks more precise than it is.

**DE:** **Schritt 4 – Aussagegrenze ausformulieren.** Formuliere je Kennzahl einen Satz, der sagt, wofür sie
gilt und wofür nicht: „Gilt nur für Maschinen mit `last_contact` jünger als 24 h; ältere Maschinen zählen als
`unbekannt`." So kann niemand die Zahl versehentlich überdehnen.

**EN:** **Step 4 – Spell out the limit of validity.** For each metric, write a sentence saying what it holds
for and what not: "Only holds for machines with `last_contact` younger than 24 h; older machines count as
`unknown`." This prevents anyone from accidentally overstretching the number.

**DE:** **Schritt 5 – Nachweispfad angeben.** Jede Aussagegrenze braucht einen Beleg: eine Abdeckungstabelle,
eine Freshness-Verteilung oder eine Auswertung, die zeigt, wie viele Werte fehlen. Ohne Nachweis ist die
Aussagegrenze nur eine Behauptung.

**EN:** **Step 5 – State an evidence path.** Every limit of validity needs proof: a coverage table, a freshness
distribution, or an evaluation showing how many values are missing. Without evidence the limit of validity is
just a claim.

**DE:** **Typische Fehler.** „Unbekannt" mit „aus" verwechseln. Prozentzahlen ohne Nennung der Grundgesamtheit.
Alte Werte wie frische behandeln. Unsicherheit weglassen, um eine Zahl überzeugender wirken zu lassen.
Aussagegrenze nur denken, aber nicht aufschreiben.

**EN:** **Common mistakes.** Confusing "unknown" with "off". Percentages without naming the population.
Treating old values like fresh ones. Dropping uncertainty to make a number look more convincing. Only thinking
the limit of validity but not writing it down.

### Beispiel / Example

```text
Kennzahl:          Anteil laufender Maschinen
Rohwert:           85 %
Grundgesamtheit:   98 von 100 Maschinen haben Daten (Abdeckung 98 %)
Aktualitaet:       juengster last_contact-Wert im Schnitt 12 min alt; 6 Maschinen > 24 h
Stichprobenintervall: 15 min (Ereignisse dazwischen unsichtbar)
Unsicherheit:      2 Maschinen ohne Daten => Status unbekannt, nicht "aus"
Aussagegrenze:     "Gilt nur fuer 92 Maschinen mit last_contact < 24 h; 6 = unbekannt"
Nachweis:          Abdeckungs- und Freshness-Tabelle in docs (Evidenzpfad)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Belastbare kundenspezifische Kennzahlen brauchen ausdrückliche Aussagegrenzen. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Abdeckung, Zeitstempel und Lücken entstehen in der Datenhaltung des Harvesters. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: belastbare Aussagen nur mit Nachweis, nachvollziehbare
Entscheidungen und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Review), `CL_10` (Datenschutz) und `CL_12` (auditfähige Nachweise). Die Datenentscheidung dieser Einheit
lautet: *Jede Kennzahl trägt eine ausdrückliche Aussagegrenze und einen Nachweispfad; „unbekannt" wird nie
stillschweigend zu „aus".* A11Y-Aspekt: Abdeckungs- und Aktualitätsangaben müssen als klarer Text und als
Tabelle lesbar sein; Unsicherheit wird als Wort und Zahl angegeben, nicht nur als Farbe.

**EN:** Relation to the Secure Development Guideline: reliable statements only with evidence, traceable
decisions, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (review),
`CL_10` (data protection), and `CL_12` (audit-ready evidence). The data decision of this unit is: *every metric
carries an explicit limit of validity and an evidence path; "unknown" never silently becomes "off".*
Accessibility aspect: coverage and freshness must be readable as clear text and as a table; uncertainty is
given as a word and a number, not by color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine Aussagegrenze und warum gehört sie zu jeder Kennzahl? /
   **EN:** What is a limit of validity and why does it belong to every metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Aussagegrenze nennt die Bedingung, unter der eine Kennzahl gilt. Ohne sie wird die Zahl auf
   Fälle übertragen, für die sie nicht belegt ist, und führt zu falschen Entscheidungen.
   **EN:** A limit of validity names the condition under which a metric holds. Without it the number is applied
   to cases it does not cover and leads to wrong decisions.

   </details>

2. **DE:** (DPA) Warum darf „keine Daten" nicht als „Maschine aus" gezählt werden? /
   **EN:** (DPA) Why must "no data" not be counted as "machine off"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fehlende Daten bedeuten nur, dass der Dienst nichts weiß – die Maschine kann laufen, das Netz kann
   gestört sein. „Aus" wäre eine unbelegte Annahme; korrekt ist „unbekannt".
   **EN:** Missing data only means the service knows nothing – the machine may run, the network may be
   disrupted. "Off" would be an unproven assumption; correct is "unknown".

   </details>

3. **DE:** Wie beeinflusst das Stichprobenintervall, was eine Kennzahl zeigen kann? /
   **EN:** How does the sampling interval influence what a metric can show?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ereignisse zwischen zwei Sammelläufen bleiben unsichtbar. Ein größeres Intervall verdeckt mehr
   kurze Zustände; die Kennzahl kann sie nicht abbilden.
   **EN:** Events between two collection runs stay invisible. A larger interval hides more short states; the
   metric cannot represent them.

   </details>

4. **DE:** (DPA) Warum sollte Unsicherheit getrennt von der Kennzahl notiert werden? /
   **EN:** (DPA) Why should uncertainty be noted separately from the metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zahl und Verlässlichkeit brauchen verschiedene Prüfungen. Steht die Unsicherheit getrennt, bleibt
   sie sichtbar und die Kennzahl wirkt nicht genauer, als sie ist.
   **EN:** The number and its reliability need different checks. Kept separate, uncertainty stays visible and
   the metric does not look more precise than it is.

   </details>

5. **DE:** Warum braucht eine Aussagegrenze einen Nachweispfad? /
   **EN:** Why does a limit of validity need an evidence path?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Beleg ist die Grenze nur eine Behauptung. Eine Abdeckungs- oder Freshness-Tabelle zeigt, dass
   die Bedingung wirklich geprüft wurde, und macht die Aussage auditfähig.
   **EN:** Without proof the limit is just a claim. A coverage or freshness table shows the condition was really
   checked and makes the statement audit-ready.

   </details>

6. **DE:** (SI) Welche Betriebsbedingung erzeugt typische Erfassungslücken und wie erkennt man sie? /
   **EN:** (SI) Which operational condition creates typical collection gaps and how do you recognize them?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ausfälle, Wartungsfenster, Netzstörungen oder Zeitdrift führen zu fehlenden Läufen. Man erkennt sie
   an alternden `last_contact`-Werten und an Lücken in der Zeitreihe.
   **EN:** Outages, maintenance windows, network faults, or time drift cause missing runs. You recognize them
   by aging `last_contact` values and gaps in the time series.

   </details>

7. **DE:** (DV) Warum kann eine Netz- oder Verfügbarkeitslücke eine Kennzahl verzerren? /
   **EN:** (DV) Why can a network or availability gap distort a metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn ganze Segmente zeitweise nicht melden, fehlen deren Maschinen in der Grundgesamtheit. Die
   Kennzahl gilt dann nur für die erreichbaren Segmente – das gehört in die Aussagegrenze.
   **EN:** If whole segments temporarily do not report, their machines are missing from the population. The
   metric then only holds for the reachable segments – that belongs in the limit of validity.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Abdeckung, Aktualität und Stichprobenintervall einer Kennzahl benennen.
- [ ] „unbekannt" sauber von „aus" trennen.
- [ ] Datenunsicherheit getrennt von der Kennzahl dokumentieren.
- [ ] zu jeder Kennzahl eine ausdrückliche Aussagegrenze formulieren.
- [ ] je Aussagegrenze einen Nachweispfad angeben.

**EN:** I can …

- [ ] name coverage, freshness, and sampling interval of a metric.
- [ ] cleanly separate "unknown" from "off".
- [ ] document data uncertainty separately from the metric.
- [ ] formulate an explicit limit of validity for every metric.
- [ ] give an evidence path for each limit of validity.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.md`. Die
nächste Einheit `07_Anomalie-und-Lueckenerkennung` baut auf diesen Aussagegrenzen auf. Der Copy-Paste-Prompt
für einen späteren, manuell gestarteten Spec-Kit-Lauf steht im Lastenheft.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_06_Aussagegrenzen-und-Datenunsicherheit.md`. The next
unit `07_Anomalie-und-Lueckenerkennung` builds on these limits of validity. The copy-paste prompt for a later,
manually started Spec Kit run is provided in the intake.
