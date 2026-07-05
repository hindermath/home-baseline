# Lernbegleiter: Secure CaseTracker Data & Process Track 08 – Testdaten, Reproduzierbarkeit und Review-Nachweise / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Data-Process-Track_08_Testdaten-Reproduzierbarkeit-und-Review-Nachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Wer eine Kennzahl-Auswertung baut, muss beweisen können, dass sie stimmt. Dafür braucht man
**Testdaten**: kleine, bekannte Datensätze, bei denen man das richtige Ergebnis von Hand kennt. Ergibt die
Auswertung genau dieses erwartete Ergebnis, ist sie ein Stück weit abgesichert. Wichtig ist außerdem
**Reproduzierbarkeit**: Gleiche Testdaten müssen jedes Mal dasselbe Ergebnis liefern – auch bei Zufall (fester
Startwert, „Seed"). Und ein **Review-Nachweis** hält fest, wer wann was mit welchem Ergebnis geprüft hat.

**EN:** Anyone building a metrics evaluation must be able to prove that it is correct. For that you need **test
data**: small, known datasets where you know the right result by hand. If the evaluation produces exactly this
expected result, it is secured to some degree. Also important is **reproducibility**: the same test data must
yield the same result every time – even with randomness (a fixed start value, a "seed"). And a **review
record** captures who checked what, when, and with which outcome.

**DE:** In dieser Einheit lernst du, aussagekräftige Testdaten zu planen, Auswertungen reproduzierbar zu
machen, Datenqualität mit Testfällen zu prüfen und Review-Ergebnisse als Nachweis zu dokumentieren.

**EN:** In this unit you learn to plan meaningful test data, to make evaluations reproducible, to check data
quality with test cases, and to document review results as evidence.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Testdaten / Test data | Kleine, bekannte Daten mit im Voraus bekanntem Sollergebnis. |
| Erwartungswert / Expected value | Das von Hand berechnete, korrekte Ergebnis eines Testfalls. |
| Reproduzierbarkeit / Reproducibility | Gleiche Eingaben ergeben zuverlässig das gleiche Ergebnis. |
| Seed / Seed | Fester Startwert für Zufall, der Wiederholbarkeit sichert. |
| Negativtest / Negative test | Test, der prüft, dass fehlerhafte Daten korrekt abgelehnt werden. |
| Review-Nachweis / Review record | Dokumentation, wer wann was mit welchem Ergebnis geprüft hat. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Testdaten mit bekanntem Ergebnis planen.** Baue kleine Datensätze, bei denen du das
Resultat selbst ausrechnen kannst. Beispiel: fünf Fälle mit bekannten Durchlaufzeiten – dann kennst du Median
und Mittelwert vorher. Ergibt die Auswertung etwas anderes, ist ein Fehler in der Auswertung, nicht in den
Daten. Verwende **keine echten personenbezogenen Daten**, sondern synthetische.

**EN:** **Step 1 – Plan test data with a known result.** Build small datasets where you can compute the result
yourself. Example: five cases with known throughput times – then you know median and mean in advance. If the
evaluation yields something else, the error is in the evaluation, not in the data. Use **no real personal
data**, only synthetic data.

**DE:** **Schritt 2 – Grenz- und Negativfälle abdecken.** Teste nicht nur den Normalfall. Nimm leere Mengen (0
Fälle), genau einen Fall, gleiche Werte, und bewusst fehlerhafte Daten (Ende vor Start). Ein guter Testsatz
zeigt, dass die Auswertung Grenzfälle sauber behandelt und fehlerhafte Daten korrekt ablehnt.

**EN:** **Step 2 – Cover edge and negative cases.** Do not test only the normal case. Take empty sets (0
cases), exactly one case, equal values, and deliberately faulty data (end before start). A good test set shows
that the evaluation handles edge cases cleanly and rejects faulty data correctly.

**DE:** **Schritt 3 – Reproduzierbarkeit sichern.** Wenn Zufall im Spiel ist (z. B. Stichproben), setze einen
festen Seed, damit der Lauf wiederholbar ist. Dokumentiere Datenstand, Definition und Umgebung. Ohne
Reproduzierbarkeit kann niemand einen Fehler nachstellen oder ein Ergebnis bestätigen.

**EN:** **Step 3 – Ensure reproducibility.** When randomness is involved (e.g. sampling), set a fixed seed so
the run is repeatable. Document data snapshot, definition, and environment. Without reproducibility, nobody
can reproduce a bug or confirm a result.

**DE:** **Schritt 4 – Review dokumentieren.** Ein Review ist erst ein Nachweis, wenn er festgehalten ist: Wer
hat geprüft? Wann? Welche Testfälle liefen? Was war das Ergebnis, welche Punkte blieben offen? Ein Review „im
Kopf" ist für ein Audit wertlos. Halte offene Punkte als `Open` mit Folgeaktion fest.

**EN:** **Step 4 – Document the review.** A review becomes evidence only when it is recorded: who reviewed?
When? Which test cases ran? What was the result, which points stayed open? A review "in one's head" is
worthless for an audit. Record open points as `Open` with a follow-up action.

**DE:** **Typische Fehler.** Nur den Normalfall testen. Echte personenbezogene Daten als Testdaten nutzen.
Zufall ohne Seed. Ergebnis nicht mit Erwartungswert vergleichen. Review nicht dokumentieren.

**EN:** **Common mistakes.** Testing only the normal case. Using real personal data as test data. Randomness
without a seed. Not comparing the result to the expected value. Not documenting the review.

### Beispiel / Example

```text
Testfall T1 (normal): Durchlaufzeiten [4, 6, 8, 10, 40] Tage
Erwartung:            Median = 8, Mittelwert = 13.6  (von Hand berechnet)
Auswertung liefert:   Median = 8, Mittelwert = 13.6  -> BESTANDEN

Testfall T2 (leer):   0 Faelle -> Erwartung: "keine Aussage" statt Absturz
Testfall T3 (negativ): Fall mit Ende < Start -> Erwartung: ABGELEHNT/markiert
Reproduzierbarkeit:   Stichprobe mit Seed=42 -> gleiche Auswahl bei jedem Lauf
Review-Nachweis:      geprueft von R. Beispiel, 2025-07-05, T1-T3 bestanden, 1 Open
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10c Werkzeuge des maschinellen Lernens einsetzen | Primär / Primary | Reproduzierbare Testdaten, feste Seeds und geprüfte Erwartungswerte sind Kern datengetriebener und ML-naher Arbeit. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Testdaten und Qualitätsprüfungen setzen an den Feldern und Regeln der Datenverwaltung an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testbarkeit, Reproduzierbarkeit, keine echten
personenbezogenen Daten in Tests, auditfähige Evidenz. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_02` (Datenmodell/Design), `CL_04` (Risikoblick), `CL_08` (Review) und `CL_11`
(Betriebs-/Qualitätsnachweis). Die Datenentscheidung dieser Einheit lautet: *Jede Auswertung wird gegen
bekannte Erwartungswerte getestet und reproduzierbar nachgewiesen.* A11Y-Aspekt: Testberichte und
Review-Nachweise müssen als klare Textstruktur lesbar sein, bestanden/nicht bestanden mit Wort, nicht nur mit
Farbe.

**EN:** Relation to the Secure Development Guideline: testability, reproducibility, no real personal data in
tests, audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (data
model/design), `CL_04` (risk view), `CL_08` (review), and `CL_11` (operations/quality evidence). The data
decision of this unit is: *every evaluation is tested against known expected values and evidenced
reproducibly.* Accessibility aspect: test reports and review records must be readable as a clear text
structure, passed/failed by word, not color alone.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** (DPA) Warum plant man Testdaten mit einem im Voraus bekannten Ergebnis? /
   **EN:** (DPA) Why plan test data with a result known in advance?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur so kann man prüfen, ob die Auswertung richtig rechnet. Weicht das Ergebnis vom bekannten
   Erwartungswert ab, liegt der Fehler in der Auswertung, nicht in den Daten.
   **EN:** Only this way can one check whether the evaluation computes correctly. If the result deviates from
   the known expected value, the error is in the evaluation, not in the data.

   </details>

2. **DE:** Warum darf man keine echten personenbezogenen Daten als Testdaten nutzen? /
   **EN:** Why must no real personal data be used as test data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Testdaten werden oft geteilt, kopiert und gespeichert. Echte personenbezogene Daten würden dabei den
   Datenschutz verletzen. Synthetische Daten vermeiden dieses Risiko.
   **EN:** Test data is often shared, copied, and stored. Real personal data would violate privacy in the
   process. Synthetic data avoids this risk.

   </details>

3. **DE:** (DPA) Wozu dient ein fester Seed bei Zufall? /
   **EN:** (DPA) What is a fixed seed for with randomness?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er macht eine zufallsbasierte Auswertung (z. B. Stichprobe) wiederholbar: gleicher Seed ergibt
   dieselbe Auswahl. Ohne Seed ist das Ergebnis nicht reproduzierbar.
   **EN:** It makes a randomness-based evaluation (e.g. a sample) repeatable: the same seed yields the same
   selection. Without a seed the result is not reproducible.

   </details>

4. **DE:** Warum reicht es nicht, nur den Normalfall zu testen? /
   **EN:** Why is it not enough to test only the normal case?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Grenz- und Fehlerfälle (leere Menge, ein Fall, Ende vor Start) sind häufige Fehlerquellen. Nur der
   Normalfall zeigt nicht, ob die Auswertung robust ist.
   **EN:** Edge and error cases (empty set, one case, end before start) are common sources of bugs. Only the
   normal case does not show whether the evaluation is robust.

   </details>

5. **DE:** Warum ist ein Review erst mit Dokumentation ein Nachweis? /
   **EN:** Why is a review only evidence with documentation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Review „im Kopf" lässt sich nicht prüfen. Erst wer/wann/was/Ergebnis schriftlich festhält, macht
   das Review für ein Audit belastbar.
   **EN:** A review "in one's head" cannot be checked. Only recording who/when/what/result in writing makes the
   review reliable for an audit.

   </details>

6. **DE:** (DPA) Wie hängt Reproduzierbarkeit mit dem Report aus Einheit 06 zusammen? /
   **EN:** (DPA) How is reproducibility connected to the report from unit 06?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein reproduzierbarer Report braucht reproduzierbare Auswertungen. Testdaten mit Seed und
   Erwartungswerten sind der Beweis, dass gleiche Eingaben gleiche Ergebnisse liefern.
   **EN:** A reproducible report needs reproducible evaluations. Test data with a seed and expected values is
   the proof that the same inputs yield the same results.

   </details>

7. **DE:** Was macht man mit einem offenen Punkt aus dem Review? /
   **EN:** What do you do with an open point from the review?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Man hält ihn als `Open` mit Folgeaktion und Verantwortlichem fest. So geht der Punkt nicht verloren
   und ist im nächsten Durchlauf nachverfolgbar.
   **EN:** Record it as `Open` with a follow-up action and an owner. This way the point is not lost and is
   traceable in the next round.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] synthetische Testdaten mit bekanntem Erwartungswert planen.
- [ ] Grenz- und Negativfälle abdecken.
- [ ] Auswertungen mit Seed und Datenstand reproduzierbar machen.
- [ ] Ergebnisse gegen Erwartungswerte prüfen.
- [ ] Review-Ergebnisse und offene Punkte als Nachweis dokumentieren.

**EN:** I can …

- [ ] plan synthetic test data with a known expected value.
- [ ] cover edge and negative cases.
- [ ] make evaluations reproducible with a seed and data snapshot.
- [ ] check results against expected values.
- [ ] document review results and open points as evidence.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Data-Process-Track_08_Testdaten-Reproduzierbarkeit-und-Review-Nachweise.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Data-Process-Track_08_Testdaten-Reproduzierbarkeit-und-Review-Nachweise.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
