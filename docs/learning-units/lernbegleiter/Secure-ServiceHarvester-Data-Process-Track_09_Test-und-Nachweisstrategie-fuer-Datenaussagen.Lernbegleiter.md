# Lernbegleiter: Secure ServiceHarvester Data & Process Track 09 – Test- und Nachweisstrategie für Datenaussagen / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Du hast Kennzahlen (Einheit 03), Berichte (Einheit 05) und Aussagegrenzen (Einheit 06) erarbeitet. Aber
woher weißt du, dass eine Kennzahl **wirklich** das berechnet, was sie behauptet? Dafür brauchst du eine **Test-
und Nachweisstrategie**. Der Kern ist ein wichtiger Unterschied: Ein **Code-Test** prüft, ob eine Funktion
technisch korrekt rechnet. Ein **Nachweis einer Datenaussage** prüft, ob die Kennzahl die fachlich zugesicherte
Aussage trifft – auch bei Lücken, leeren Daten und Ausreißern. Beides gehört zusammen, ist aber nicht dasselbe.

**EN:** You have created metrics (unit 03), reports (unit 05), and interpretation limits (unit 06). But how do
you know that a metric **really** computes what it claims? For that you need a **test and evidence strategy**.
The core is an important distinction: a **code test** checks whether a function computes technically correctly. An
**evidence of a data claim** checks whether the metric makes its promised business statement – even with gaps,
empty data, and outliers. Both belong together but are not the same.

**DE:** In dieser Einheit lernst du, synthetische Testdaten ohne echte personenbezogene Inhalte zu wählen, ein
**Golden Dataset** mit bekanntem Sollergebnis anzulegen, Kantenfälle (leer, Lücke, Ausreißer) abzudecken und
alles reproduzierbar zu machen. Die C#-Referenz `InventarWorkerService` dient nur als Vergleich; die Lösung bleibt
sprachneutral.

**EN:** In this unit you learn to choose synthetic test data without real personal content, to build a **golden
dataset** with a known target result, to cover edge cases (empty, gap, outlier), and to make everything
reproducible. The C# reference `InventarWorkerService` serves only for comparison; the solution stays
language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Code-Test / Code test | Prüfung, ob eine Funktion technisch das erwartete Ergebnis liefert. |
| Nachweis einer Datenaussage / Evidence of a data claim | Beleg, dass eine Kennzahl die zugesicherte fachliche Aussage trifft. |
| Synthetische Testdaten / Synthetic test data | Erfundene Daten ohne echten Personenbezug, zum Testen erzeugt. |
| Golden Dataset / Golden dataset | Fester Datensatz mit vorher bekanntem, richtigem Sollergebnis. |
| Kantenfall / Edge case | Grenzsituation wie leerer Datensatz, Erfassungslücke oder Ausreißer. |
| Reproduzierbarkeit / Reproducibility | Gleiche Eingabe und Parameter ergeben immer dasselbe Ergebnis. |
| Fixture / Fixture | Fest vorbereiteter Testdatenstand, der einen Test wiederholbar macht. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Code-Test und Datenaussage trennen.** Schreibe zuerst auf, was du prüfen willst: die
**Rechnung** (technisch korrekt) oder die **Aussage** (fachlich gültig). Beispiel: Ein Test kann bestätigen, dass
die Erreichbarkeitsquote 85 % ergibt. Ob „85 % erreichbar" die richtige fachliche Aussage ist, hängt zusätzlich
von der Aussagegrenze aus Einheit 06 ab. Trenne beide Prüfungen bewusst.

**EN:** **Step 1 – Separate code test and data claim.** First write down what you want to check: the
**calculation** (technically correct) or the **claim** (business-valid). Example: a test can confirm the
reachability rate is 85%. Whether "85% reachable" is the correct business statement additionally depends on the
limit of validity from unit 06. Deliberately separate both checks.

**DE:** **Schritt 2 – Synthetische Testdaten wählen.** Verwende erfundene Daten ohne echten Personenbezug.
Maschinennamen wie `host-a`, `host-b` genügen; niemals echte Namen, IPs oder Secrets. Secrets stehen in Beispielen
nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`. So testest du realitätsnah, ohne Datenschutzrisiken zu schaffen.

**EN:** **Step 2 – Choose synthetic test data.** Use invented data without real personal reference. Machine names
like `host-a`, `host-b` suffice; never real names, IPs, or secrets. In examples, secrets appear only as
`<PLATZHALTER-KEIN-ECHTER-WERT>`. This way you test realistically without creating privacy risks.

**DE:** **Schritt 3 – Golden Dataset mit Sollergebnis anlegen.** Erstelle einen festen, überschaubaren Datensatz
und rechne das richtige Ergebnis **von Hand** aus. Dieses bekannte Sollergebnis ist der Maßstab: Weicht die
Berechnung ab, ist entweder der Code oder deine Erwartung falsch – beides muss geklärt werden. Das Golden Dataset
bleibt unverändert, damit der Vergleich stabil ist.

**EN:** **Step 3 – Build a golden dataset with a target result.** Create a fixed, manageable dataset and compute
the correct result **by hand**. This known target result is the yardstick: if the calculation deviates, either the
code or your expectation is wrong – both must be clarified. The golden dataset stays unchanged so the comparison
is stable.

**DE:** **Schritt 4 – Kantenfälle abdecken.** Die interessanten Fehler stecken an den Rändern. Prüfe mindestens:
den **leeren** Datensatz (keine Maschine gemeldet – was ergibt eine Quote mit Nenner null?), die **Lücke** (eine
Maschine meldet sich zeitweise nicht) und den **Ausreißer** (ein unrealistischer Wert). Lege je Kantenfall fest,
was das erwartete, sichere Verhalten ist.

**EN:** **Step 4 – Cover edge cases.** The interesting bugs live at the edges. Check at least: the **empty**
dataset (no machine reported – what does a rate with denominator zero yield?), the **gap** (a machine temporarily
does not report), and the **outlier** (an unrealistic value). For each edge case, define the expected, safe
behavior.

**DE:** **Schritt 5 – Reproduzierbarkeit sichern.** Ein Nachweis zählt nur, wenn er wiederholbar ist. Halte den
Datenstand fest (z. B. eine Fixture-Datei), fixiere Parameter wie das Zeitfenster und dokumentiere, wie das
Ergebnis erzeugt und geprüft wird. Zufall, aktuelle Systemzeit oder wechselnde Daten machen einen Nachweis
wertlos. Feste Eingabe plus feste Parameter ergeben immer dasselbe Ergebnis.

**EN:** **Step 5 – Ensure reproducibility.** Evidence only counts if it is repeatable. Fix the data state (e.g. a
fixture file), pin parameters such as the time window, and document how the result is produced and checked.
Randomness, the current system time, or changing data make evidence worthless. Fixed input plus fixed parameters
always yield the same result.

**DE:** **Typische Fehler.** Nur den Code testen und die fachliche Aussage vergessen. Echte Daten als Testdaten
verwenden. Kein Golden Dataset, also kein Maßstab. Den leeren Fall und die Division durch null übersehen.
Nachweise mit der aktuellen Uhrzeit erzeugen, sodass sie sich nicht wiederholen lassen. Nicht anwendbare Standards
still weglassen statt als `N/A` mit Begründung.

**EN:** **Common mistakes.** Testing only the code and forgetting the business claim. Using real data as test
data. No golden dataset, so no yardstick. Overlooking the empty case and division by zero. Producing evidence with
the current time so it cannot be repeated. Silently dropping non-applicable standards instead of documenting them
as `N/A` with a rationale.

### Beispiel / Example

```text
Golden Dataset (fest, synthetisch):
  host       os        last_contact (rel. zum Stichtag)
  host-a     Linux     -2 h
  host-b     Linux     -30 h
  host-c     Windows   -1 h
  host-d     Windows   (nie gemeldet)

Sollergebnis (von Hand): Erreichbarkeit 24 h = 2 / 4 = 50 %
Code-Test:               Funktion liefert 50 %  -> bestanden
Datenaussage-Nachweis:   "50 % erreichbar" gilt nur fuer 24-h-Fenster (Einheit 06)

Kantenfaelle:
  leer:      0 Maschinen  -> Quote nicht 0/0, sondern definiert "n/a, keine Daten"
  Luecke:    host-b faellt raus -> als stale gezaehlt, nicht als defekt
  Ausreisser:last_contact in der Zukunft -> als ungueltig verworfen + geloggt

Reproduzierbar: feste Fixture, fixer Stichtag; kein Zufall, keine echte Systemzeit
Secret in Beispielen nur als <PLATZHALTER-KEIN-ECHTER-WERT>
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 12c**
ist primär, weil der Nachweis, dass eine kundenspezifische Datenanalyse korrekt und reproduzierbar ist, Kern der
Prozess- und Datenanalyse ist; LF 5 ist berührt, weil die Testdaten in der angepassten Datenhaltung liegen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
12c** is primary because evidencing that a customer-specific data analysis is correct and reproducible is the core
of process and data analysis; LF 5 is touched because the test data lives in the adapted data storage.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 12c Kundenspezifische Prozess- und Datenanalyse durchführen | Primär / Primary | Der reproduzierbare Nachweis, dass eine Datenanalyse korrekt ist, gehört zum Kern von LF 12c. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Golden Dataset und Fixtures liegen in der angepassten Datenhaltung des Harvesters. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testbarkeit, reproduzierbare Evidenz, Datenschutz und sichere
Programmierung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Testmanagement/Verifikation),
`CL_08` (Sicherheits-Code-Review der Berechnung) und `CL_12` (Nachweise und Abschluss). Die Datenentscheidung
dieser Einheit lautet: *Testdaten sind synthetisch, ein Golden Dataset liefert das Sollergebnis, Kantenfälle sind
abgedeckt, und jeder Nachweis ist reproduzierbar.* A11Y-Aspekt: Golden-Dataset- und Kantenfalltabellen müssen als
reiner Text mit Kopfzeile lesbar sein, ohne Farbcodierung, damit sie mit Screenreader oder Braille-Zeile nutzbar
bleiben.

**EN:** Relation to the Secure Development Guideline: testability, reproducible evidence, privacy, and secure
programming. Matching checklists: `CL_01` (standards applicability), `CL_04` (test management/verification),
`CL_08` (security code review of the calculation), and `CL_12` (evidence and closure). The data decision of this
unit is: *test data is synthetic, a golden dataset provides the target result, edge cases are covered, and every
piece of evidence is reproducible.* Accessibility aspect: golden-dataset and edge-case tables must be readable as
plain text with a header row, without color coding, so they stay usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet einen Code-Test vom Nachweis einer Datenaussage? /
   **EN:** What distinguishes a code test from evidencing a data claim?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Code-Test prüft, ob die Funktion technisch korrekt rechnet. Der Nachweis einer Datenaussage prüft,
   ob die Kennzahl die fachlich zugesicherte Aussage trifft, inklusive Aussagegrenze. Eine korrekte Rechnung kann
   trotzdem eine falsche Aussage stützen.
   **EN:** The code test checks whether the function computes technically correctly. Evidencing a data claim checks
   whether the metric makes its promised business statement, including the limit of validity. A correct
   calculation can still support a wrong statement.

   </details>

2. **DE:** (DPA) Wozu dient ein Golden Dataset und warum bleibt es unverändert? /
   **EN:** (DPA) What is a golden dataset for, and why does it stay unchanged?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es liefert ein vorher bekanntes, von Hand berechnetes Sollergebnis als Maßstab. Bleibt es unverändert,
   ist der Vergleich stabil: Weicht die Berechnung ab, liegt der Fehler klar im Code oder in der Erwartung.
   **EN:** It provides a previously known, hand-computed target result as a yardstick. If it stays unchanged, the
   comparison is stable: if the calculation deviates, the fault clearly lies in the code or in the expectation.

   </details>

3. **DE:** (DPA) Welche drei Kantenfälle solltest du für eine Kennzahl mindestens prüfen? /
   **EN:** (DPA) Which three edge cases should you check at minimum for a metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Den leeren Datensatz (Nenner null, Division vermeiden), die Erfassungslücke (Maschine meldet zeitweise
   nicht) und den Ausreißer (unrealistischer Wert). Für jeden Fall wird das erwartete, sichere Verhalten
   festgelegt.
   **EN:** The empty dataset (denominator zero, avoid division), the collection gap (machine temporarily does not
   report), and the outlier (unrealistic value). For each case the expected, safe behavior is defined.

   </details>

4. **DE:** Warum dürfen für die Tests keine echten personenbezogenen Daten verwendet werden? /
   **EN:** Why must no real personal data be used for the tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte Daten in Tests oder Fixtures schaffen ein Datenschutzrisiko und können in Repositories oder Logs
   landen. Synthetische Daten ohne Personenbezug testen genauso gut, ohne dieses Risiko; Secrets stehen nur als
   `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** Real data in tests or fixtures creates a privacy risk and can end up in repositories or logs. Synthetic
   data without personal reference tests just as well without that risk; secrets appear only as
   `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

5. **DE:** Warum ist ein Nachweis wertlos, wenn er nicht reproduzierbar ist? /
   **EN:** Why is evidence worthless if it is not reproducible?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur ein wiederholbares Ergebnis lässt sich prüfen. Hängt es von Zufall oder der aktuellen Systemzeit ab,
   kann niemand es nachvollziehen oder gegenprüfen. Feste Eingabe und feste Parameter machen es belastbar.
   **EN:** Only a repeatable result can be checked. If it depends on randomness or the current system time, no one
   can retrace or verify it. Fixed input and fixed parameters make it dependable.

   </details>

6. **DE:** (AE) Wie schreibt man einen reproduzierbaren Test für eine Aggregationskennzahl? /
   **EN:** (AE) How do you write a reproducible test for an aggregation metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Man verwendet eine feste Fixture mit bekanntem Sollergebnis, fixiert Parameter wie das Zeitfenster und
   vermeidet echte Systemzeit oder Zufall. Der Test vergleicht das berechnete Ergebnis mit dem Sollwert; die Logik
   bleibt sprachneutral.
   **EN:** You use a fixed fixture with a known target result, pin parameters like the time window, and avoid real
   system time or randomness. The test compares the computed result with the target; the logic stays
   language-neutral.

   </details>

7. **DE:** (SI) Wie stellt man eine reproduzierbare Testumgebung ohne echte Daten bereit? /
   **EN:** (SI) How do you provide a reproducible test environment without real data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit versionierten Fixture-Dateien, festen Parametern und einer isolierten Umgebung (z. B. Sandbox), in
   der keine echten Produktionsdaten liegen. So läuft der Test überall gleich und gefährdet keine echten Daten.
   **EN:** With versioned fixture files, fixed parameters, and an isolated environment (e.g. sandbox) that holds no
   real production data. This way the test runs the same everywhere and endangers no real data.

   </details>

8. **DE:** Wie dokumentierst du einen Teststandard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a testing standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: Last-/Performance-
   tests sind `N/A`, weil hier die fachliche Korrektheit und nicht der Durchsatz geprüft wird. So bleibt sichtbar,
   dass der Standard geprüft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: load/performance tests
   are `N/A` because here business correctness rather than throughput is checked. This keeps visible that the
   standard was considered.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen Code-Test vom Nachweis einer Datenaussage unterscheiden.
- [ ] synthetische Testdaten ohne echten Personenbezug wählen.
- [ ] ein Golden Dataset mit von Hand berechnetem Sollergebnis anlegen.
- [ ] die Kantenfälle leer, Lücke und Ausreißer abdecken.
- [ ] einen Nachweis reproduzierbar erzeugen und prüfen.
- [ ] nicht anwendbare Teststandards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] distinguish a code test from evidencing a data claim.
- [ ] choose synthetic test data without real personal reference.
- [ ] build a golden dataset with a hand-computed target result.
- [ ] cover the edge cases empty, gap, and outlier.
- [ ] produce and check evidence reproducibly.
- [ ] document non-applicable testing standards as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.md`. Sie
übernimmt die Aussagegrenzen aus Einheit 06 und liefert die Nachweise für das Abschluss-Review in Einheit 10. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Data-Process-Track_09_Test-und-Nachweisstrategie-fuer-Datenaussagen.md`. It
carries over the interpretation limits from unit 06 and provides the evidence for the closing review in unit 10.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
