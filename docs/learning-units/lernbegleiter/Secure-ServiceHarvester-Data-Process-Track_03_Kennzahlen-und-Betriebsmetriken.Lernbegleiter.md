# Lernbegleiter: Secure ServiceHarvester Data & Process Track 03 – Kennzahlen und Betriebsmetriken / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_03_Kennzahlen-und-Betriebsmetriken.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Nach der Datenqualität (Einheit 02) kommen die **Kennzahlen**. Der Kunde fragt: „Wie viele Rechner
laufen bei uns?", „Wie viele melden sich nicht mehr?", „Wie viele neue Maschinen kamen diese Woche dazu?" Jede
dieser Fragen wird zu einer Metrik – aber nur, wenn du sie sauber definierst. Eine Kennzahl ohne Formel und
ohne **Bezugsmenge** (den Nenner) ist gefährlich, weil jeder sie anders versteht. Im 3. Lehrjahr geht es nicht
nur ums Rechnen, sondern um die **fachliche Interpretation**: Welche Entscheidung stützt eine Zahl wirklich –
und welche nicht?

**EN:** After data quality (unit 02) come the **metrics**. The customer asks: "how many machines are running?",
"how many no longer report in?", "how many new machines were added this week?" Each of these questions becomes a
metric – but only if you define it cleanly. A metric without a formula and without a **reference set** (the
denominator) is dangerous because everyone understands it differently. In year 3 it is not only about
calculating but about **business interpretation**: which decision does a number really support – and which
does it not?

**DE:** Du lernst, Bestands-, Fluss- und Qualitätsmetriken zu unterscheiden, jede Kennzahl mit Formel und
Nenner zu definieren und die gestützte Entscheidung von der Fehlinterpretation zu trennen.

**EN:** You learn to distinguish stock, flow, and quality metrics, to define each metric with a formula and
denominator, and to separate the supported decision from the misinterpretation.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Kennzahl / Metric | Zahl, die eine fachliche Frage beantwortet, mit klarer Formel. |
| Bezugsmenge / Reference set | Der Nenner einer Quote: worauf sich ein Anteil bezieht. |
| Bestandsmetrik / Stock metric | Zustand zu einem Zeitpunkt (z. B. Anzahl bekannter Maschinen). |
| Flussmetrik / Flow metric | Veränderung über eine Zeitspanne (z. B. neue Meldungen pro Tag). |
| Qualitätsmetrik / Quality metric | Anteil, der die Belastbarkeit der Daten misst (z. B. Anteil aktueller Snapshots). |
| Betriebsmetrik / Operational metric | Kennzahl, die den Zustand oder Prozess des Dienstbetriebs beschreibt. |
| Fehlinterpretation / Misinterpretation | Aussage, die eine Zahl scheinbar stützt, aber ihre Grenze überschreitet. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Metriktyp bestimmen.** Frage zuerst: Beschreibe ich einen Zustand (Bestand), eine
Veränderung (Fluss) oder die Datenqualität? „Anzahl bekannter Maschinen" ist Bestand. „Neue Maschinen pro Woche"
ist Fluss. „Anteil aktueller Snapshots" ist Qualität. Der Typ entscheidet über Zeitbezug und Nenner.

**EN:** **Step 1 – Determine the metric type.** Ask first: am I describing a state (stock), a change (flow), or
data quality? "Number of known machines" is stock. "New machines per week" is flow. "Share of current snapshots"
is quality. The type determines the time reference and denominator.

**DE:** **Schritt 2 – Formel und Bezugsmenge festlegen.** Schreibe jede Kennzahl als Formel mit klarem Nenner.
Beispiel: „Erreichbarkeitsquote = Maschinen mit Kontakt in den letzten 24 h / alle bekannten Maschinen." Ohne
Nenner ist ein Anteil bedeutungslos: 50 aktive Maschinen sind viel bei 60 bekannten und wenig bei 5000.

**EN:** **Step 2 – Define formula and reference set.** Write each metric as a formula with a clear denominator.
Example: "reachability rate = machines with contact in the last 24 h / all known machines." Without a
denominator a share is meaningless: 50 active machines are many out of 60 known and few out of 5000.

**DE:** **Schritt 3 – Aussagegrenze übernehmen.** Die Grenzen aus Einheit 01 und 02 gelten weiter. Eine
Erreichbarkeitsquote misst Meldungen, nicht tatsächliche Nutzung. Baut eine Metrik auf einem Feld mit 74 %
Vollständigkeit auf, gilt sie nur für diese 74 %. Übernimm die Grenze ausdrücklich in die Kennzahldefinition.

**EN:** **Step 3 – Carry over the limit of validity.** The limits from units 01 and 02 still apply. A
reachability rate measures reports, not actual usage. If a metric is built on a field with 74% completeness, it
is valid only for those 74%. Carry the limit explicitly into the metric definition.

**DE:** **Schritt 4 – Interpretation und Fehlinterpretation trennen.** Zu jeder Kennzahl notierst du: Welche
Entscheidung stützt sie (z. B. „Wartungsplanung, weil viele Maschinen veraltet gemeldet sind")? Und welche
Aussage wäre falsch (z. B. „30 % sind kaputt" – nein, sie haben sich nur nicht gemeldet)? Diese Trennung ist im
3. Lehrjahr die eigentliche Leistung.

**EN:** **Step 4 – Separate interpretation and misinterpretation.** For each metric note: which decision does it
support (e.g. "maintenance planning, because many machines report as stale")? And which statement would be wrong
(e.g. "30% are broken" – no, they simply did not report in)? This separation is the actual achievement in year
3.

**DE:** **Schritt 5 – Datenschutz und Aggregation prüfen.** Kennzahlen sollen aggregiert sein, sodass keine
einzelne Person nachverfolgbar wird. Eine Metrik „Meldungen je Administrator" kann eine Leistungsüberwachung
sein und ist ohne klaren Zweck ein Nicht-Ziel. Aggregiere auf Ebenen wie Betriebssystem oder Standort statt auf
Einzelpersonen.

**EN:** **Step 5 – Check privacy and aggregation.** Metrics should be aggregated so that no individual person
becomes traceable. A metric "reports per administrator" can be performance monitoring and, without a clear
purpose, is a non-goal. Aggregate at levels like operating system or site instead of individuals.

**DE:** **Typische Fehler.** Anteile ohne Nenner angeben. Bestand und Fluss verwechseln. Die Aussagegrenze beim
Rechnen vergessen. Aus „nicht gemeldet" auf „defekt" schließen. Metriken bilden, die einzelne Personen bewerten.
Eine Zahl präsentieren, ohne die gestützte Entscheidung zu benennen.

**EN:** **Common mistakes.** Giving shares without a denominator. Confusing stock and flow. Forgetting the limit
of validity when calculating. Concluding "broken" from "did not report". Building metrics that evaluate
individuals. Presenting a number without naming the supported decision.

### Beispiel / Example

```text
Kennzahl              Typ         Formel                                        Aussagegrenze
Bekannte Maschinen    Bestand     count(distinct machine)                       Stichtag; Dubletten gemergt (Einheit 02)
Erreichbarkeit 24 h   Qualitaet   kontakt < 24 h / alle bekannten Maschinen     misst Meldung, nicht Nutzung
Neue Maschinen/Woche  Fluss       erste Meldung in Kalenderwoche                nur Wochen mit vollstaendiger Sammlung

Interpretation:      "26 % stale -> Wartung pruefen, warum Maschinen sich nicht melden"
Fehlinterpretation:  "26 % sind defekt"  (falsch: sie haben sich nur nicht gemeldet)
Datenschutz:         Aggregation auf os/Standort, NICHT "Meldungen je Administrator"
N/A:                 Trendprognose per ML in dieser Einheit N/A -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11c**
ist primär, weil Betriebsmetriken einen Prozess – die Erreichbarkeit und Pflege der Maschinen – analysieren und
Gestaltungsentscheidungen stützen; LF 6 ist berührt, weil aus den Metriken Serviceanfragen und Wartungsaufträge
entstehen. LF 10c (maschinelles Lernen) passt hier nicht, weil definierte Kennzahlen statt trainierter Modelle
verwendet werden.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
11c** is primary because operational metrics analyze a process – the reachability and maintenance of machines –
and support design decisions; LF 6 is touched because service requests and maintenance orders arise from the
metrics. LF 10c (machine learning) does not fit here because defined metrics are used instead of trained models.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11c Prozesse analysieren und gestalten | Primär / Primary | Betriebsmetriken analysieren den Melde- und Pflegeprozess und stützen Gestaltungsentscheidungen. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Aus den Kennzahlen entstehen konkrete Serviceanfragen und Wartungsaufträge. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Nachvollziehbarkeit, Datenschutz durch Aggregation,
Testbarkeit und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review der Berechnung), `CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die
Datenentscheidung dieser Einheit lautet: *Jede Kennzahl hat Formel und Nenner, trägt ihre Aussagegrenze und ist
so aggregiert, dass keine Einzelperson nachverfolgbar wird.* A11Y-Aspekt: Der Kennzahlkatalog muss als Tabelle
mit Formel-Spalte in reinem Text lesbar sein, ohne Farbcodierung, damit er mit Screenreader oder Braille-Zeile
nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: traceability, privacy through aggregation, testability, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review of
the calculation), `CL_10` (data protection), and `CL_12` (evidence and closure). The data decision of this unit
is: *every metric has a formula and denominator, carries its limit of validity, and is aggregated so that no
individual person becomes traceable.* Accessibility aspect: the metric catalog must be readable as a table with
a formula column in plain text, without color coding, so it stays usable with a screen reader or Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine Quote ohne Bezugsmenge (Nenner) bedeutungslos? /
   **EN:** Why is a rate without a reference set (denominator) meaningless?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Erst der Nenner sagt, worauf sich ein Anteil bezieht. 50 aktive Maschinen sind viel bei 60 bekannten
   und wenig bei 5000. Ohne Nenner versteht jeder die Zahl anders.
   **EN:** Only the denominator says what a share refers to. 50 active machines are many out of 60 known and few
   out of 5000. Without a denominator everyone understands the number differently.

   </details>

2. **DE:** (DPA) Erkläre den Unterschied zwischen einer Bestands- und einer Flussmetrik am ServiceHarvester. /
   **EN:** (DPA) Explain the difference between a stock and a flow metric on the ServiceHarvester.

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Bestandsmetrik beschreibt einen Zustand zu einem Zeitpunkt, z. B. „Anzahl bekannter Maschinen
   heute". Eine Flussmetrik beschreibt eine Veränderung über eine Zeitspanne, z. B. „neue Maschinen pro Woche".
   **EN:** A stock metric describes a state at a point in time, e.g. "number of known machines today". A flow
   metric describes a change over a period, e.g. "new machines per week".

   </details>

3. **DE:** (DPA) 26 % der Maschinen gelten als „stale". Welche Interpretation ist zulässig, welche nicht? /
   **EN:** (DPA) 26% of machines are considered "stale". Which interpretation is allowed, which is not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zulässig: „26 % haben sich länger nicht gemeldet, die Wartung sollte prüfen, warum." Nicht zulässig:
   „26 % sind defekt." Die Metrik misst Meldungen, nicht den technischen Zustand.
   **EN:** Allowed: "26% have not reported in for a while; maintenance should check why." Not allowed: "26% are
   broken." The metric measures reports, not the technical state.

   </details>

4. **DE:** Warum trägt eine Kennzahl die Aussagegrenze der Daten weiter, auf denen sie beruht? /
   **EN:** Why does a metric carry over the limit of validity of the data it is based on?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Rechnung kann eine schlechte Datenbasis nicht heilen. Beruht eine Metrik auf einem Feld mit
   74 % Vollständigkeit, gilt sie nur für diese 74 %; die Grenze muss sichtbar bleiben.
   **EN:** A calculation cannot heal a poor data basis. If a metric is based on a field with 74% completeness, it
   is valid only for those 74%; the limit must stay visible.

   </details>

5. **DE:** (DPA) Warum sollten Betriebsmetriken auf Gruppen aggregiert und nicht auf Einzelpersonen bezogen
   werden? / **EN:** (DPA) Why should operational metrics be aggregated to groups and not tied to individuals?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Metriken je Einzelperson können zur verdeckten Leistungsüberwachung werden und verletzen ohne klaren
   Zweck die Datenminimierung. Aggregation auf Betriebssystem oder Standort beantwortet die Frage ohne
   Personenbezug.
   **EN:** Metrics per individual can turn into covert performance monitoring and, without a clear purpose,
   violate data minimization. Aggregating to operating system or site answers the question without personal
   reference.

   </details>

6. **DE:** (SI) Wie stützt eine Betriebsmetrik eine konkrete Betriebsentscheidung? /
   **EN:** (SI) How does an operational metric support a concrete operational decision?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Steigt der Anteil stale gemeldeter Maschinen, kann das eine Wartung oder eine Prüfung des
   Sammelintervalls auslösen. Die Metrik liefert den Anlass; die Entscheidung braucht zusätzlich die
   Aussagegrenze.
   **EN:** If the share of stale-reporting machines rises, it can trigger maintenance or a review of the
   collection interval. The metric provides the trigger; the decision additionally needs the limit of validity.

   </details>

7. **DE:** (DV) Warum kann eine unterschiedliche Zeitbasis über Systemgrenzen hinweg eine Metrik verfälschen? /
   **EN:** (DV) Why can a differing time base across system boundaries distort a metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn Maschinen ihre Zeit lokal und uneinheitlich setzen (z. B. Zeitzonen, Uhrenversatz), stimmt der
   „letzte Kontakt" nicht mit der Sammelzeit überein. Eine Erreichbarkeitsquote wird dann falsch; eine
   einheitliche Zeitbasis (z. B. UTC) ist nötig.
   **EN:** If machines set their time locally and inconsistently (e.g. time zones, clock drift), the "last
   contact" does not match the collection time. A reachability rate then becomes wrong; a uniform time base
   (e.g. UTC) is required.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Bestands-, Fluss- und Qualitätsmetriken unterscheiden.
- [ ] jede Kennzahl mit Formel und Bezugsmenge definieren.
- [ ] die Aussagegrenze in die Kennzahldefinition übernehmen.
- [ ] die gestützte Entscheidung von der Fehlinterpretation trennen.
- [ ] Kennzahlen so aggregieren, dass keine Einzelperson nachverfolgbar wird.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] distinguish stock, flow, and quality metrics.
- [ ] define each metric with a formula and reference set.
- [ ] carry the limit of validity into the metric definition.
- [ ] separate the supported decision from the misinterpretation.
- [ ] aggregate metrics so that no individual person becomes traceable.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_03_Kennzahlen-und-Betriebsmetriken.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_03_Kennzahlen-und-Betriebsmetriken.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
