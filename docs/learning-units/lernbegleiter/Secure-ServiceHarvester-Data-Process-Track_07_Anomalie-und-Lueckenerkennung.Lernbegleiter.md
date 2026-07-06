# Lernbegleiter: Secure ServiceHarvester Data & Process Track 07 – Anomalie- und Lückenerkennung / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In den gesammelten Statusdaten stecken zwei sehr unterschiedliche Auffälligkeiten. Eine **Anomalie**
ist ein Wert, der nicht zum normalen Muster passt: ein `last_contact` in der Zukunft, ein plötzlicher Wechsel
des Betriebssystems, eine Maschine, die nach langer Aktivität verstummt. Eine **Lücke** ist dagegen ein
fehlender Sammellauf – es gibt gar keinen Wert. Beides muss getrennt behandelt werden, denn eine Lücke ist
keine Anomalie und darf nicht als solche gezählt werden. Bevor du auffällige Werte meldest, brauchst du eine
**Baseline**: eine Beschreibung dessen, was normal ist.

**EN:** The collected status data contains two very different irregularities. An **anomaly** is a value that
does not fit the normal pattern: a `last_contact` in the future, a sudden operating-system change, a machine
that goes silent after long activity. A **gap**, in contrast, is a missing collection run – there is no value
at all. Both must be handled separately, because a gap is not an anomaly and must not be counted as one. Before
you report unusual values, you need a **baseline**: a description of what is normal.

**DE:** In dieser Einheit lernst du, echte Anomalien von Datenartefakten und von Lücken zu unterscheiden,
zwischen einfachen Schwellenwertregeln und Werkzeugen des maschinellen Lernens zu wählen und Falsch-Positive
gegen Falsch-Negative abzuwägen. Wichtig: Eine Anomalie aus nicht vertrauenswürdigen Daten löst nie ungeprüft
eine Aktion aus.

**EN:** In this unit you learn to distinguish real anomalies from data artifacts and from gaps, to choose
between simple threshold rules and machine-learning tools, and to weigh false positives against false
negatives. Important: an anomaly derived from untrusted data never triggers an action unchecked.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Baseline / Baseline | Beschreibung des normalen Musters, an dem Auffälligkeiten gemessen werden. |
| Anomalie / Anomaly | Wert, der klar vom normalen Muster abweicht. |
| Lücke / Gap | Fehlender Sammellauf – es gibt keinen Wert, nicht nur einen ungewöhnlichen. |
| Schwellenwert / Threshold | Einfache Grenze; darüber oder darunter gilt ein Wert als auffällig. |
| ML-Werkzeug / ML tool | Verfahren, das Muster aus Daten lernt, statt fester Grenzen. |
| Falsch-Positiv / False positive | Fehlalarm: gemeldet, obwohl nichts los ist. |
| Falsch-Negativ / False negative | Übersehen: nicht gemeldet, obwohl etwas los war. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Baseline festlegen.** Beschreibe das normale Muster: übliches Melde-Intervall, erwartete
Betriebssysteme, typische Aktivitätszeiten. Ohne Baseline kannst du „auffällig" nicht definieren.

**EN:** **Step 1 – Define the baseline.** Describe the normal pattern: usual reporting interval, expected
operating systems, typical activity times. Without a baseline you cannot define "unusual".

**DE:** **Schritt 2 – Anomalie, Artefakt und Lücke trennen.** Ein `last_contact` in der Zukunft ist oft ein
**Datenartefakt** (Zeitdrift), keine echte Anomalie. Eine verstummte Maschine ist eine echte Anomalie. Ein
fehlender Lauf ist eine Lücke. Ordne jeden Fund einer der drei Kategorien zu, bevor du meldest.

**EN:** **Step 2 – Separate anomaly, artifact, and gap.** A `last_contact` in the future is often a **data
artifact** (time drift), not a real anomaly. A silent machine is a real anomaly. A missing run is a gap. Assign
each finding to one of the three categories before reporting.

**DE:** **Schritt 3 – Verfahren wählen: Schwellenwert oder ML.** Für klare Fälle reicht ein Schwellenwert
(„`last_contact` älter als 24 h → auffällig"). Für komplexe Muster kann ein ML-Werkzeug helfen. Beginne
einfach: ein nachvollziehbarer Schwellenwert ist besser als ein undurchschaubares Modell, das niemand prüfen
kann.

**EN:** **Step 3 – Choose the method: threshold or ML.** For clear cases a threshold is enough ("`last_contact`
older than 24 h → unusual"). For complex patterns an ML tool can help. Start simple: a traceable threshold is
better than an opaque model that nobody can check.

**DE:** **Schritt 4 – Falsch-Positive gegen Falsch-Negative abwägen.** Ein zu empfindlicher Detektor meldet
ständig Fehlalarme (Falsch-Positive) und wird ignoriert. Ein zu grober übersieht echte Fälle
(Falsch-Negative). Lege bewusst fest, welche Richtung teurer ist, und begründe die Wahl.

**EN:** **Step 4 – Weigh false positives against false negatives.** An over-sensitive detector constantly
raises false alarms (false positives) and gets ignored. A too coarse one misses real cases (false negatives).
Deliberately decide which direction is more costly and justify the choice.

**DE:** **Schritt 5 – Alarm belegen, nicht blind handeln.** Jeder Alarm braucht einen Nachweis: welcher Wert,
welche Regel, welche Baseline. Da die Daten als nicht vertrauenswürdig gelten, folgt aus einem Alarm zuerst
eine Prüfung, nicht sofort eine automatische Aktion.

**EN:** **Step 5 – Evidence the alert, do not act blindly.** Every alert needs proof: which value, which rule,
which baseline. Because the data is treated as untrusted, an alert first triggers a check, not an immediate
automatic action.

**DE:** **Typische Fehler.** Lücken als Anomalien zählen. Datenartefakte für echte Ereignisse halten. Sofort
ein ML-Modell nehmen, das niemand erklären kann. Empfindlichkeit ohne Begründung wählen. Aus einem Alarm ohne
Prüfung eine Aktion machen.

**EN:** **Common mistakes.** Counting gaps as anomalies. Mistaking data artifacts for real events. Immediately
using an ML model nobody can explain. Choosing sensitivity without justification. Turning an alert into an
action without a check.

### Beispiel / Example

```text
Baseline:          Meldeintervall ~15 min; erwartete OS-Werte {Linux, Windows, macOS}
Fund A:            last_contact in der Zukunft  -> Kategorie: Datenartefakt (Zeitdrift)
Fund B:            Maschine seit 5 Tagen still  -> Kategorie: echte Anomalie (verstummt)
Fund C:            kein Sammellauf 02:00-03:00  -> Kategorie: Luecke (fehlender Lauf)
Regel B:           Schwellenwert last_contact > 24 h => auffaellig
Abwaegung:         lieber Falsch-Positiv als uebersehene Ausfaelle (Betrieb teuer)
Alarm-Nachweis:    Wert + Regel + Baseline dokumentiert; Aktion erst nach Pruefung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10c Werkzeuge des maschinellen Lernens einsetzen | Primär / Primary | Anomalieerkennung ist ein klassischer Einsatzfall für ML- und Schwellenwert-Werkzeuge. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Baseline und Zeitreihen entstehen in der angepassten Datenhaltung des Harvesters. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: nicht vertrauenswürdige Daten prüfen, belastbare Aussagen nur
mit Nachweis, auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04`
(Eingabevalidierung), `CL_08` (Review), `CL_10` (Datenschutz) und `CL_12` (Nachweise). Die Datenentscheidung
dieser Einheit lautet: *Anomalien aus nicht vertrauenswürdigen Daten lösen zuerst eine Prüfung aus, nie
ungeprüft eine automatische Aktion.* A11Y-Aspekt: Alarme und Kategorien (Anomalie/Artefakt/Lücke) müssen als
klarer Text und Tabelle lesbar sein; Schweregrad wird als Wort angegeben, nicht nur als Farbe.

**EN:** Relation to the Secure Development Guideline: check untrusted data, reliable statements only with
evidence, audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (input
validation), `CL_08` (review), `CL_10` (data protection), and `CL_12` (evidence). The data decision of this
unit is: *anomalies from untrusted data first trigger a check, never an unchecked automatic action.*
Accessibility aspect: alerts and categories (anomaly/artifact/gap) must be readable as clear text and a table;
severity is given as a word, not by color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DPA) Worin unterscheiden sich eine Anomalie und eine Lücke? /
   **EN:** (DPA) How do an anomaly and a gap differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Anomalie ist ein vorhandener, aber ungewöhnlicher Wert. Eine Lücke ist ein fehlender Wert – gar
   kein Sammelergebnis. Eine Lücke darf nicht als Anomalie gezählt werden.
   **EN:** An anomaly is an existing but unusual value. A gap is a missing value – no collection result at all.
   A gap must not be counted as an anomaly.

   </details>

2. **DE:** Wozu braucht man eine Baseline, bevor man Auffälligkeiten meldet? /
   **EN:** Why do you need a baseline before reporting irregularities?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne ein beschriebenes normales Muster ist „auffällig" nicht definiert. Die Baseline liefert den
   Maßstab, gegen den ein Wert als Anomalie gilt.
   **EN:** Without a described normal pattern "unusual" is undefined. The baseline provides the yardstick
   against which a value counts as an anomaly.

   </details>

3. **DE:** (DPA) Warum ist ein `last_contact` in der Zukunft oft ein Artefakt statt einer Anomalie? /
   **EN:** (DPA) Why is a `last_contact` in the future often an artifact rather than an anomaly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Zeitstempel in der Zukunft entsteht meist durch Zeitdrift oder falsche Uhr, nicht durch ein
   echtes Ereignis. Als Artefakt erkannt, wird er korrigiert statt als Vorfall gemeldet.
   **EN:** A future timestamp usually comes from time drift or a wrong clock, not a real event. Recognized as an
   artifact, it is corrected instead of reported as an incident.

   </details>

4. **DE:** Wann ist ein einfacher Schwellenwert einem ML-Werkzeug vorzuziehen? /
   **EN:** When is a simple threshold preferable to an ML tool?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn der Fall klar ist und die Regel nachvollziehbar bleibt. Ein prüfbarer Schwellenwert ist besser
   als ein undurchschaubares Modell, das niemand erklären oder auditieren kann.
   **EN:** When the case is clear and the rule stays traceable. A checkable threshold beats an opaque model
   nobody can explain or audit.

   </details>

5. **DE:** (DPA) Was bedeuten Falsch-Positive und Falsch-Negative, und warum muss man abwägen? /
   **EN:** (DPA) What do false positives and false negatives mean, and why must you weigh them?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Falsch-Positiv ist ein Fehlalarm, Falsch-Negativ ist ein übersehener Fall. Beides hat Kosten; man
   entscheidet bewusst, welche Richtung teurer ist, und begründet die Empfindlichkeit.
   **EN:** A false positive is a false alarm, a false negative a missed case. Both have costs; you deliberately
   decide which direction is costlier and justify the sensitivity.

   </details>

6. **DE:** Warum darf ein Alarm aus nicht vertrauenswürdigen Daten keine sofortige Aktion auslösen? /
   **EN:** Why must an alert from untrusted data not trigger an immediate action?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Daten können falsch oder manipuliert sein. Eine automatische Aktion auf einen Fehlalarm richtet
   Schaden an; deshalb steht zwischen Alarm und Aktion eine Prüfung.
   **EN:** The data may be wrong or manipulated. An automatic action on a false alarm causes harm; therefore a
   check sits between alert and action.

   </details>

7. **DE:** (DV) Warum kann eine Segment- oder Netzstörung wie eine Häufung von Anomalien aussehen? /
   **EN:** (DV) Why can a segment or network fault look like a cluster of anomalies?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fällt ein Segment aus, verstummen viele Maschinen gleichzeitig. Das wirkt wie viele Anomalien, ist
   aber eine gemeinsame Lücke mit einer Ursache – das gehört als Ursache in die Meldung.
   **EN:** If a segment fails, many machines go silent at once. This looks like many anomalies but is a shared
   gap with one cause – that belongs in the report as the cause.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Baseline für normales Verhalten beschreiben.
- [ ] Anomalie, Datenartefakt und Lücke sauber trennen.
- [ ] begründet zwischen Schwellenwert und ML-Werkzeug wählen.
- [ ] Falsch-Positive und Falsch-Negative bewusst abwägen.
- [ ] einen Alarm belegen und eine Prüfung vor die Aktion setzen.

**EN:** I can …

- [ ] describe a baseline for normal behavior.
- [ ] cleanly separate anomaly, data artifact, and gap.
- [ ] choose between threshold and ML tool with justification.
- [ ] deliberately weigh false positives and false negatives.
- [ ] evidence an alert and put a check before the action.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.md`. Diese Einheit baut
auf den Aussagegrenzen aus `06` auf; die Ergebnisse fließen in das Prozessfeedback in `08` ein. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht im Lastenheft.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_07_Anomalie-und-Lueckenerkennung.md`. This unit builds
on the limits of validity from `06`; the results feed into the process feedback in `08`. The copy-paste prompt
for a later, manually started Spec Kit run is provided in the intake.
