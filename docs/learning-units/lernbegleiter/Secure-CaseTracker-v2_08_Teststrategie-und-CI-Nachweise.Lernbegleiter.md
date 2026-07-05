# Lernbegleiter: Secure CaseTracker v2 08 – Teststrategie und CI-Nachweise / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_08_Teststrategie-und-CI-Nachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Behauptung wie „die Software funktioniert“ oder „sie ist sicher“ ist wertlos, solange sie nicht
**belegt** ist. Tests sind dieser Beleg. Aber Tests brauchen einen Plan: eine **Teststrategie**, die
festlegt, *was* geprüft wird – fachliche Funktion, Sicherheit, Datenschutz – und *wie* die Ergebnisse als
**Nachweis** entstehen. In v2 kommt die **CI** hinzu (Continuous Integration): ein automatischer Ablauf, der
bei jeder Änderung die Tests laufen lässt und ein prüfbares Ergebnis erzeugt. So wird Qualität nicht zur
Glückssache, sondern zu einem wiederholbaren Nachweis.

**EN:** A claim like "the software works" or "it is secure" is worthless as long as it is not **proven**.
Tests are that proof. But tests need a plan: a **test strategy** that defines *what* is checked – business
function, security, privacy – and *how* the results become **evidence**. In v2 the **CI** is added
(continuous integration): an automatic process that runs the tests on every change and produces a reviewable
result. This turns quality from a matter of luck into a repeatable proof.

**DE:** In dieser Einheit planst du eine **Testmatrix** (fachliche Tests, Sicherheitstests, Datenschutztests),
**CI-Annahmen** und **Nachweispfade**, sowie Regeln für **Testdaten** – ausschließlich synthetisch, nie echt
personenbezogen.

**EN:** In this unit you plan a **test matrix** (business tests, security tests, privacy tests), **CI
assumptions**, and **evidence paths**, plus rules for **test data** – exclusively synthetic, never real
personal data.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Teststrategie / Test strategy | Plan, was, wie und mit welchem Ziel geprüft wird. |
| Negativtest / Negative test | Test, der prüft, dass ungültige Eingaben korrekt abgelehnt werden. |
| CI / Continuous Integration | Automatischer Ablauf, der bei jeder Änderung Tests ausführt. |
| Nachweispfad / Evidence path | Ort und Form, an denen ein Testergebnis prüfbar abgelegt wird. |
| Testdaten / Test data | Für Tests genutzte, hier ausschließlich synthetische Daten. |
| Reproduzierbarkeit / Reproducibility | Eigenschaft, dass ein Test überall dasselbe Ergebnis liefert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Testarten trennen.** Ordne Tests nach Ziel: fachliche Tests (macht die Funktion das
Richtige?), Sicherheitstests (werden Angriffe/ungültige Eingaben abgelehnt?), Datenschutztests (bleiben
sensible Daten geschützt?). **Warum wichtig:** Nur getrennte Ziele zeigen, ob wirklich alle Aspekte geprüft
sind und nicht nur die bequeme Funktion.

**EN:** **Step 1 – Separate test types.** Order tests by goal: business tests (does the function do the right
thing?), security tests (are attacks/invalid inputs rejected?), privacy tests (do sensitive data stay
protected?). **Why it matters:** only separate goals show whether all aspects are really checked and not just
the convenient function.

**DE:** **Schritt 2 – Testmatrix mit Positiv- und Negativtests.** Zu jeder wichtigen Regel gehört ein
Positivtest (Erlaubtes wird angenommen) und ein Negativtest (Ungültiges wird abgelehnt). **Warum wichtig:**
Nur Erfolgspfade zu testen beweist nichts über den Schutz. Der Negativtest ist der eigentliche
Sicherheitsbeweis.

**EN:** **Step 2 – Test matrix with positive and negative tests.** Every important rule needs a positive test
(allowed input is accepted) and a negative test (invalid input is rejected). **Why it matters:** testing only
success paths proves nothing about protection. The negative test is the actual security proof.

**DE:** **Schritt 3 – CI und Nachweispfade planen.** Beschreibe, wie die Tests automatisch laufen und wo das
Ergebnis prüfbar landet (z. B. ein Report im Repo). Achte auf Reproduzierbarkeit: gleiche Eingaben, gleiches
Ergebnis, unabhängig von der Maschine. **Warum wichtig:** Ein Nachweis, den man nicht wiederfinden oder
wiederholen kann, ist im Audit nutzlos.

**EN:** **Step 3 – Plan CI and evidence paths.** Describe how the tests run automatically and where the result
lands reviewably (e.g. a report in the repo). Ensure reproducibility: same inputs, same result, regardless of
the machine. **Why it matters:** evidence you cannot find again or repeat is useless in an audit.

**DE:** **Schritt 4 – Testdaten und Grenzen festlegen.** Nutze nur synthetische Testdaten, nie echte
personenbezogene. Halte die Lösung für alle sechs Sprachen vergleichbar – der Testvertrag beschreibt das
Verhalten, nicht ein sprachspezifisches Werkzeug. **Warum wichtig:** Echte Daten in Tests sind ein
Datenschutzrisiko; sprachneutrale Testziele halten die Reihe vergleichbar.

**EN:** **Step 4 – Define test data and limits.** Use only synthetic test data, never real personal data. Keep
the solution comparable across all six languages – the test contract describes behaviour, not a
language-specific tool. **Why it matters:** real data in tests is a privacy risk; language-neutral test goals
keep the series comparable.

**DE:** **Typische Fehler.** Nur Erfolgspfade testen. Sicherheit und Datenschutz gar nicht prüfen. Nachweise
nur lokal, nicht wiederholbar. Echte personenbezogene Testdaten. Tests, die auf einer Maschine laufen und auf
einer anderen nicht (keine Reproduzierbarkeit).

**EN:** **Common mistakes.** Testing only success paths. Not checking security and privacy at all. Evidence
only local, not repeatable. Real personal test data. Tests that pass on one machine and fail on another (no
reproducibility).

### Beispiel / Example

```text
Testmatrix (Auszug):

  Regel                         Positivtest                 Negativtest
  Status-Allowlist              "geschlossen" -> akzeptiert  "XXL" -> abgelehnt (400)
  Rechte (Leser darf nicht ex.) Admin -> Export ok           Leser -> Export abgelehnt
  Datenschutz (Log)             Ereignis geloggt             kein Klartextname im Log

CI-Ablauf:
  bei jeder Aenderung -> Tests laufen -> Report als Nachweis im Repo
  reproduzierbar: gleiche Eingaben -> gleiches Ergebnis, maschinenunabhaengig

Testdaten: nur synthetisch (z. B. "Fall 001", Pseudonym "usr_001"), keine echten Personen
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 6 Serviceanfragen bearbeiten | Primär / Primary | Prüfbare Tests und CI-Nachweise sichern die Servicequalität und Übergabe. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Die Tests sichern das Verhalten der datenverwaltenden Software ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testbarkeit, sichere Programmierung, Datenschutz und
auditfähige, reproduzierbare Nachweise. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(sichere Programmierung), `CL_06` (Testmanagement), `CL_08` (Sicherheits-Code-Review) und `CL_11`
(CI/Nachweise). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede positive Sicherheits- oder
Funktionsaussage braucht einen wiederholbaren Nachweis, und jede kritische Regel hat einen Negativtest.*
A11Y-Aspekt: Testberichte und CI-Ausgaben müssen als klarer Text lesbar sein; „bestanden/nicht bestanden“
darf nicht nur an Farbe hängen, damit Screenreader- und Braille-Nutzende das Ergebnis erfassen.

**EN:** Relation to the Secure Development Guideline: testability, secure coding, privacy, and auditable,
reproducible evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (secure coding),
`CL_06` (test management), `CL_08` (security code review), and `CL_11` (CI/evidence). The security decision of
this unit is: *every positive security or function claim needs a repeatable proof, and every critical rule has
a negative test.* Accessibility aspect: test reports and CI output must be readable as clear text;
"passed/failed" must not depend on color alone, so screen-reader and Braille users can grasp the result.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine Sicherheitsaussage ohne Test wertlos? /
   **EN:** Why is a security claim without a test worthless?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Beleg ist die Aussage nur eine Hoffnung. Ein Test liefert den wiederholbaren Nachweis, dass der
   Schutz tatsächlich greift, und hält im Audit stand.
   **EN:** Without proof the claim is just a hope. A test provides the repeatable evidence that the protection
   actually works and holds up in an audit.

   </details>

2. **DE:** Warum ist der Negativtest der eigentliche Sicherheitsbeweis? /
   **EN:** Why is the negative test the actual security proof?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er zeigt, dass Ungültiges wirklich abgelehnt wird. Ein Positivtest zeigt nur, dass Erlaubtes
   funktioniert, nicht dass der Schutz greift.
   **EN:** It shows that invalid input is really rejected. A positive test only shows that allowed input works,
   not that the protection holds.

   </details>

3. **DE:** (SI) Was leistet CI, und warum ist Reproduzierbarkeit dabei wichtig? /
   **EN:** (SI) What does CI provide, and why is reproducibility important there?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** CI führt bei jeder Änderung automatisch die Tests aus und erzeugt einen Nachweis. Reproduzierbarkeit
   sorgt dafür, dass das Ergebnis maschinenunabhängig gleich bleibt und damit belastbar ist.
   **EN:** CI runs the tests automatically on every change and produces evidence. Reproducibility ensures the
   result stays the same regardless of machine and is therefore reliable.

   </details>

4. **DE:** (AE) Wie sieht eine gute Testmatrix aus? /
   **EN:** (AE) What does a good test matrix look like?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zu jeder wichtigen Regel gibt es einen Positiv- und einen Negativtest, getrennt nach fachlich,
   Sicherheit und Datenschutz. So ist die Abdeckung vollständig und prüfbar.
   **EN:** For every important rule there is a positive and a negative test, separated into business, security,
   and privacy. This makes coverage complete and reviewable.

   </details>

5. **DE:** (DPA) Warum dürfen Tests keine echten personenbezogenen Daten verwenden? /
   **EN:** (DPA) Why must tests not use real personal data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte Daten in Testumgebungen erhöhen das Leck-Risiko und verletzen den Datenschutz. Synthetische
   Daten liefern denselben Testwert ohne Personenbezug.
   **EN:** Real data in test environments increases the leak risk and violates privacy. Synthetic data provides
   the same test value without a personal reference.

   </details>

6. **DE:** Warum muss ein Nachweispfad prüfbar und wiederauffindbar sein? /
   **EN:** Why must an evidence path be reviewable and findable?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Nachweis, den man nicht wiederfindet oder wiederholt, ist im Audit nutzlos. Ein fester
   Ablageort macht das Ergebnis nachvollziehbar.
   **EN:** Evidence you cannot find again or repeat is useless in an audit. A fixed storage location makes the
   result traceable.

   </details>

7. **DE:** Warum sollten Testziele sprachneutral formuliert sein? /
   **EN:** Why should test goals be formulated language-neutrally?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Reihe soll für alle sechs Sprachen vergleichbar bleiben. Ein sprachneutraler Testvertrag
   beschreibt das Verhalten, nicht ein bestimmtes Werkzeug.
   **EN:** The series must stay comparable across all six languages. A language-neutral test contract describes
   the behaviour, not a specific tool.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] fachliche, Sicherheits- und Datenschutztests unterscheiden.
- [ ] eine Testmatrix mit Positiv- und Negativtests aufstellen.
- [ ] CI-Ablauf und Nachweispfad beschreiben.
- [ ] Reproduzierbarkeit und synthetische Testdaten begründen.
- [ ] jede positive Aussage mit einem Nachweis belegen.

**EN:** I can …

- [ ] distinguish business, security, and privacy tests.
- [ ] build a test matrix with positive and negative tests.
- [ ] describe the CI process and evidence path.
- [ ] justify reproducibility and synthetic test data.
- [ ] back every positive claim with evidence.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_08_Teststrategie-und-CI-Nachweise.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_08_Teststrategie-und-CI-Nachweise.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
