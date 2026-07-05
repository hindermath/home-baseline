# Lernbegleiter: Secure InventoryHub 09 – Teststrategie, Sandbox und Betriebsnachweise / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_09_Teststrategie-Sandbox-und-Betriebsnachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Behauptung wie „Das Inventar ist sicher" ist wertlos, solange sie nicht **nachgewiesen** ist.
Tests liefern diesen Nachweis. Dabei genügt es nicht, nur zu prüfen, ob die richtigen Eingaben zum richtigen
Ergebnis führen (fachliche Tests). Man braucht auch **negative Sicherheitstests**, die zeigen, dass falsche
oder bösartige Eingaben wirklich abgelehnt werden. All das geschieht am besten in einer **Sandbox** – einer
abgeschotteten, reproduzierbaren Umgebung, in der Fehler keinen Schaden anrichten. Eine **CI** (kontinuierliche
Integration) führt die Tests automatisch aus und liefert **Betriebsnachweise**.

**EN:** A claim like "the inventory is secure" is worthless as long as it is not **proven**. Tests provide this
proof. It is not enough to check only whether the correct inputs lead to the correct result (functional tests).
You also need **negative security tests** that show invalid or malicious inputs are really rejected. All this
is best done in a **sandbox** – an isolated, reproducible environment where mistakes cause no harm. A **CI**
(continuous integration) runs the tests automatically and delivers **operational evidence**.

**DE:** In dieser Einheit lernst du, fachliche und negative Sicherheitstests zu verbinden, sichere Testdaten zu
verwenden, eine Sandbox sinnvoll einzusetzen und Betriebsnachweise über CI zu erzeugen.

**EN:** In this unit you learn to combine functional and negative security tests, to use safe test data, to
apply a sandbox sensibly, and to produce operational evidence via CI.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Fachlicher Test / Functional test | Prüft, ob eine gültige Eingabe zum erwarteten Ergebnis führt. |
| Negativer Sicherheitstest / Negative security test | Prüft, ob eine ungültige oder bösartige Eingabe abgelehnt wird. |
| Testdaten / Test data | Künstliche Daten ohne echte personenbezogene Inhalte. |
| Sandbox / Sandbox | Abgeschottete, reproduzierbare Umgebung für sicheres Ausprobieren. |
| CI / CI | Kontinuierliche Integration: automatischer Build- und Testlauf. |
| Betriebsnachweis / Operational evidence | Belegter Nachweis, dass Tests und Abläufe wirklich liefen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Testmatrix aufstellen.** Ordne jeder wichtigen Funktion mindestens einen fachlichen und
einen negativen Test zu. Beispiel: Import einer gültigen Zeile (fachlich) und Import einer Zeile mit
Formel-Injection (negativ). Eine Testmatrix macht sichtbar, was geprüft ist und was nicht.

**EN:** **Step 1 – Build a test matrix.** Assign to each important function at least one functional and one
negative test. Example: importing a valid row (functional) and importing a row with formula injection
(negative). A test matrix makes visible what is checked and what is not.

**DE:** **Schritt 2 – Negative Sicherheitstests bewusst planen.** Nur Erfolgspfade zu testen beweist nicht,
dass der Schutz greift. Plane gezielt Tests, die zeigen: ungültige Statuswerte werden abgelehnt, verwaiste
Software wird erkannt, ein `auditor` kann nichts ändern, Log-Injection wird entschärft. Der Test soll das
Schlechte auslösen und beweisen, dass es abgefangen wird.

**EN:** **Step 2 – Deliberately plan negative security tests.** Testing only success paths does not prove that
the protection works. Deliberately plan tests that show: invalid status values are rejected, orphaned software
is detected, an `auditor` cannot change anything, log injection is neutralized. The test should trigger the bad
case and prove it is caught.

**DE:** **Schritt 3 – Sichere Testdaten und Sandbox nutzen.** Verwende niemals echte personenbezogene Daten in
Tests. Baue künstliche, aber realistische Testdaten. Führe die Tests in einer Sandbox aus, die reproduzierbar
ist und keine echten Systeme berührt. So bleiben Fehler folgenlos und Ergebnisse wiederholbar.

**EN:** **Step 3 – Use safe test data and a sandbox.** Never use real personal data in tests. Build artificial
but realistic test data. Run the tests in a sandbox that is reproducible and touches no real systems. This
keeps mistakes harmless and results repeatable.

**DE:** **Schritt 4 – Betriebsnachweise über CI erzeugen.** Lass die Tests automatisch bei jeder Änderung
laufen (CI). Das Ergebnis – bestanden oder nicht – ist ein Betriebsnachweis. Dokumentiere, wo dieser Nachweis
liegt. Ein Nachweis, den niemand findet, ist so gut wie keiner.

**EN:** **Step 4 – Produce operational evidence via CI.** Let the tests run automatically on every change
(CI). The result – passed or not – is operational evidence. Document where this evidence lives. Evidence no one
can find is as good as none.

**DE:** **Typische Fehler.** Nur Erfolgspfade testen. Echte personenbezogene Daten als Testdaten verwenden.
Tests direkt auf echten Systemen laufen lassen. Keine Reproduzierbarkeit. Testergebnisse nicht als Nachweis
ablegen. Negative Tests vergessen und trotzdem „sicher" behaupten.

**EN:** **Common mistakes.** Testing only success paths. Using real personal data as test data. Running tests
directly on real systems. No reproducibility. Not storing test results as evidence. Forgetting negative tests
yet still claiming "secure".

### Beispiel / Example

```text
Testmatrix (Auszug):
Funktion         | fachlicher Test               | negativer Sicherheitstest
-----------------|-------------------------------|-------------------------------------
Import CSV        | gültige Zeile -> importiert    | Zelle "=SUM(..)" -> abgelehnt
Statuswechsel     | aktiv->wartung -> ok          | ausgemustert->aktiv ohne Freigabe -> abgelehnt
Rolle auditor     | darf lesen -> ok              | versucht ändern -> verweigert
Suche             | Filter "Halle-A" -> Treffer   | Suchbegriff mit SQL -> als Daten behandelt

Testdaten:        künstlich, keine echten Personen
Sandbox:          reproduzierbar, kein Zugriff auf echte Systeme
CI:               Tests laufen bei jeder Änderung -> Ergebnis = Betriebsnachweis (Pfad dokumentiert)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 6 Serviceanfragen bearbeiten | Primär / Primary | Qualitätssicherung und nachweisbare Ergebnisse sind Teil einer verlässlichen Servicebearbeitung. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Sandbox, CI und Betriebsnachweise betreffen bereitgestellte Dienste und Umgebungen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testbarkeit, negative Sicherheitstests, sichere Testdaten und
reproduzierbare Umgebung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur-Grundlagen), `CL_07` (Testmanagement), `CL_08` (Sicherheits-Code-Review), `CL_09` (Sandbox/Betrieb)
und `CL_11` (Abschluss/Nachweise). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Sicherheitsaussage
wird durch mindestens einen negativen Test belegt, und Nachweise entstehen automatisch und reproduzierbar.*
A11Y-Aspekt: Testberichte und CI-Ergebnisse müssen als klarer Text („bestanden"/„fehlgeschlagen") lesbar sein,
nicht nur über Farbe, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: testability, negative security tests, safe test data, and
reproducible environment. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture
basics), `CL_07` (test management), `CL_08` (security code review), `CL_09` (sandbox/operations), and `CL_11`
(closure/evidence). The security decision of this unit is: *every security claim is backed by at least one
negative test, and evidence is produced automatically and reproducibly.* Accessibility aspect: test reports and
CI results must be readable as clear text ("passed"/"failed"), not by color only, so they stay usable with a
screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Worin unterscheiden sich fachliche und negative Sicherheitstests? /
   **EN:** How do functional and negative security tests differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein fachlicher Test prüft, ob gültige Eingaben zum erwarteten Ergebnis führen. Ein negativer
   Sicherheitstest prüft, ob ungültige oder bösartige Eingaben wirklich abgelehnt werden.
   **EN:** A functional test checks whether valid inputs lead to the expected result. A negative security test
   checks whether invalid or malicious inputs are really rejected.

   </details>

2. **DE:** Warum reicht es nicht, nur Erfolgspfade zu testen? /
   **EN:** Why is it not enough to test only success paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Erfolgspfade zeigen nur, dass Richtiges funktioniert. Ob der Schutz gegen Falsches greift, beweist
   erst ein negativer Test, der das Schlechte auslöst und das Abfangen belegt.
   **EN:** Success paths only show that correct cases work. Whether protection against wrong cases holds is
   proven only by a negative test that triggers the bad case and shows it is caught.

   </details>

3. **DE:** Warum dürfen Tests keine echten personenbezogenen Daten verwenden? /
   **EN:** Why must tests not use real personal data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte personenbezogene Daten in Tests sind ein Datenschutzrisiko. Künstliche, realistische Testdaten
   erfüllen denselben Zweck ohne dieses Risiko.
   **EN:** Real personal data in tests is a privacy risk. Artificial, realistic test data serves the same
   purpose without that risk.

   </details>

4. **DE:** (SI) Wozu dient eine Sandbox beim Testen? /
   **EN:** (SI) What is a sandbox for when testing?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie ist eine abgeschottete, reproduzierbare Umgebung. Fehler richten dort keinen Schaden an echten
   Systemen an, und Tests lassen sich zuverlässig wiederholen.
   **EN:** It is an isolated, reproducible environment. Mistakes cause no harm to real systems there, and tests
   can be reliably repeated.

   </details>

5. **DE:** Was ist ein Betriebsnachweis, und warum muss man seinen Ort dokumentieren? /
   **EN:** What is operational evidence, and why must its location be documented?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Betriebsnachweis belegt, dass Tests und Abläufe wirklich liefen, z. B. ein CI-Ergebnis. Nur wenn
   man weiß, wo er liegt, kann man ihn im Review oder Audit finden und nutzen.
   **EN:** Operational evidence proves that tests and processes really ran, e.g. a CI result. Only if you know
   where it lives can you find and use it in a review or audit.

   </details>

6. **DE:** Warum ist Reproduzierbarkeit von Tests wichtig? /
   **EN:** Why is test reproducibility important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur wiederholbare Tests liefern verlässliche Aussagen. Ergebnisse, die sich nicht reproduzieren
   lassen, sind kein belastbarer Nachweis und erschweren die Fehlersuche.
   **EN:** Only repeatable tests give reliable statements. Results that cannot be reproduced are no solid
   evidence and make debugging harder.

   </details>

7. **DE:** Wie hilft eine Testmatrix, Lücken sichtbar zu machen? /
   **EN:** How does a test matrix help make gaps visible?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie stellt Funktionen und Testarten gegenüber. Leere Felder zeigen sofort, wo ein fachlicher oder
   negativer Test fehlt, und machen die Abdeckung überprüfbar.
   **EN:** It maps functions against test types. Empty cells immediately show where a functional or negative
   test is missing and make coverage verifiable.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine Testmatrix mit fachlichen und negativen Tests aufstellen.
- [ ] mindestens einen negativen Sicherheitstest je Schutzmaßnahme planen.
- [ ] sichere, künstliche Testdaten verwenden.
- [ ] eine Sandbox als reproduzierbare Testumgebung erklären.
- [ ] Betriebsnachweise über CI erzeugen und ihren Ort dokumentieren.

**EN:** I can …

- [ ] build a test matrix with functional and negative tests.
- [ ] plan at least one negative security test per protection measure.
- [ ] use safe, artificial test data.
- [ ] explain a sandbox as a reproducible test environment.
- [ ] produce operational evidence via CI and document its location.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_09_Teststrategie-Sandbox-und-Betriebsnachweise.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_09_Teststrategie-Sandbox-und-Betriebsnachweise.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
