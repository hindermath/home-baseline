# Lernbegleiter: Secure CaseTracker Application Track 07 – Testpyramide und Negativtests / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_07_Testpyramide-und-Negativtests.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Tests beweisen, dass Software tut, was sie soll – und dass sie ungültige Fälle sicher abweist. Die
**Testpyramide** ordnet Tests nach Anzahl und Reichweite: viele schnelle **Unit-Tests** unten, weniger
**Integrationstests** in der Mitte, wenige langsame **End-to-End-Tests** oben. Dazu kommen gezielte
**Security-Tests** und vor allem **Negativtests**, die prüfen, dass falsche Eingaben, fehlende Rechte und
Grenzfälle korrekt scheitern. Bild dazu: die Qualitätskontrolle in einer Fabrik. Viele kleine, schnelle
Prüfungen an jedem Teil, einige Prüfungen an zusammengesetzten Baugruppen, wenige teure Endprüfungen am
Gesamtprodukt – und bewusste Tests mit fehlerhaftem Material.

**EN:** Tests prove that software does what it should – and that it safely rejects invalid cases. The **test
pyramid** orders tests by count and reach: many fast **unit tests** at the bottom, fewer **integration tests**
in the middle, few slow **end-to-end tests** at the top. Added to this are targeted **security tests** and
especially **negative tests**, which check that wrong inputs, missing rights, and edge cases fail correctly.
The picture: quality control in a factory. Many small fast checks on each part, some checks on assembled
groups, few expensive final checks on the whole product – and deliberate tests with faulty material.

**DE:** Du lernst, eine ausgewogene Testmatrix zu planen, Negativtests bewusst zu setzen und mit
CI-Nachweisen zu belegen, statt Abdeckung nur zu behaupten.

**EN:** You learn to plan a balanced test matrix, to set negative tests deliberately, and to back them with CI
evidence instead of merely claiming coverage.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Testpyramide / Test pyramid | Verteilung: viele Unit-, weniger Integrations-, wenige End-to-End-Tests. |
| Unit-Test / Unit test | Schneller Test einer einzelnen kleinen Einheit in Isolation. |
| Integrationstest / Integration test | Test des Zusammenspiels mehrerer Teile, z. B. Logik plus Speicherung. |
| End-to-End-Test / End-to-end test | Test des Gesamtwegs aus Sicht des Nutzers oder Aufrufers. |
| Negativtest / Negative test | Test, der prüft, dass ungültige Fälle korrekt abgewiesen werden. |
| CI-Nachweis / CI evidence | Automatisch erzeugtes, prüfbares Ergebnis der Testläufe. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Pyramide bewusst schneiden.** Lege fest, was als Unit-, Integrations- oder
End-to-End-Test geprüft wird. Warum die Pyramidenform? Unit-Tests sind schnell und stabil; zu viele
End-to-End-Tests machen die Prüfung langsam und brüchig. Die Basis trägt die Sicherheit.

**EN:** **Step 1 – Cut the pyramid deliberately.** Define what is checked as a unit, integration, or
end-to-end test. Why the pyramid shape? Unit tests are fast and stable; too many end-to-end tests make the
suite slow and brittle. The base carries the safety.

**DE:** **Schritt 2 – Negativtests zu jeder Regel.** Zu jeder Validierungs- und Autorisierungsregel gehört ein
Test, der den *verbotenen* Fall prüft: ungültiger Status, fehlendes Recht, zu langer Freitext, `../` im Pfad.
Ohne Negativtest weiß niemand, ob der Schutz wirklich greift.

**EN:** **Step 2 – Negative tests for every rule.** Every validation and authorization rule needs a test that
checks the *forbidden* case: invalid status, missing right, over-long free text, `../` in the path. Without a
negative test, nobody knows whether the protection really works.

**DE:** **Schritt 3 – Security-Tests einplanen.** Prüfe gezielt sicherheitsrelevante Wege: Autorisierung an der
Grenze, sichere Fehlermeldungen ohne Interna, Pfadkanonisierung, Injection-resistente Verarbeitung. Diese
Tests gehören fest in die Matrix, nicht als „später vielleicht".

**EN:** **Step 3 – Plan security tests.** Deliberately check security-relevant paths: authorization at the
boundary, safe error messages without internals, path canonicalization, injection-resistant processing. These
tests belong firmly in the matrix, not as a "maybe later".

**DE:** **Schritt 4 – Abdeckung mit CI-Nachweis belegen.** Aussagen wie „gut getestet" sind ohne Beleg wertlos.
Lasse Tests in der CI laufen und dokumentiere das Ergebnis (bestanden/gefallen, welche Bereiche). Eine
Abdeckungszahl ist ein Hinweis, kein Beweis für gute Tests – wichtiger ist, *was* geprüft wird.

**EN:** **Step 4 – Back coverage with CI evidence.** Claims like "well tested" are worthless without proof. Run
tests in CI and document the result (pass/fail, which areas). A coverage number is a hint, not proof of good
tests – more important is *what* is checked.

**DE:** **Typische Fehler.** Nur Erfolgspfade testen. Alles über langsame End-to-End-Tests prüfen.
Negativtests weglassen. Security-Wege ungetestet lassen. Abdeckung behaupten statt mit CI-Nachweis belegen.
Tests, die von Zufall oder Reihenfolge abhängen (flaky).

**EN:** **Common mistakes.** Testing only success paths. Checking everything through slow end-to-end tests.
Omitting negative tests. Leaving security paths untested. Claiming coverage instead of proving it with CI
evidence. Tests that depend on chance or order (flaky).

### Beispiel / Example

```text
Testmatrix (Auszug)
Ebene        | Beispieltest                                   | Art
Unit         | Statusregel: "erledigt?" abgelehnt             | Negativ
Unit         | Fall-ID-Format korrekt akzeptiert              | Positiv
Integration  | Speichern + Constraint verhindert Duplikat     | Negativ
Security     | Rolle ohne Recht ruft "löschen" -> 403         | Negativ
Security     | Fehlermeldung enthält keinen Stack-Trace       | Negativ
End-to-End   | Fall anlegen, ändern, schließen (Happy Path)   | Positiv

CI-Nachweis: Lauf #128 -> 42 bestanden, 0 gefallen; Security-Block vollständig grün.
   -> Beleg im Reviewpfad, nicht nur die Behauptung "gut getestet".
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Nachweisbare Tests sind Teil der Qualitätssicherung, mit der Funktionalität verlässlich realisiert wird. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Integritäts- und Negativtests sichern die angepasste Datenverwaltung gegen fehlerhafte Daten ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testbarkeit, Security-Tests und auditfähige Nachweise.
Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review) und `CL_10`
(Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Schutzregel hat einen
Negativtest, und Abdeckung wird mit CI-Nachweis belegt.* A11Y-Aspekt: Testberichte und Ergebnisse werden
textbasiert dargestellt (bestanden/gefallen als Wort, nicht nur als grüner oder roter Punkt), damit sie mit
Screenreader und Braille-Zeile eindeutig lesbar sind.

**EN:** Relation to the Secure Development Guideline: testability, security tests, and audit-ready evidence.
Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), and `CL_10` (secure
development environment). The security decision of this unit is: *every protection rule has a negative test, and
coverage is proven with CI evidence.* Accessibility aspect: test reports and results are presented in text
(pass/fail as a word, not only as a green or red dot) so they are unambiguously readable with a screen reader
and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum stehen viele Unit-Tests unten und wenige End-to-End-Tests oben? /
   **EN:** Why are there many unit tests at the bottom and few end-to-end tests at the top?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Unit-Tests sind schnell und stabil und tragen die meiste Sicherheit günstig. End-to-End-Tests sind
   langsam und brüchig; zu viele davon verlangsamen und destabilisieren die Prüfung.
   **EN:** Unit tests are fast and stable and carry most of the safety cheaply. End-to-end tests are slow and
   brittle; too many of them slow down and destabilize the suite.

   </details>

2. **DE:** Warum gehört zu jeder Schutzregel ein Negativtest? /
   **EN:** Why does every protection rule need a negative test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur ein Negativtest zeigt, dass der verbotene Fall wirklich scheitert. Erfolgspfade beweisen nicht,
   dass der Schutz greift.
   **EN:** Only a negative test shows that the forbidden case really fails. Success paths do not prove the
   protection works.

   </details>

3. **DE:** Warum ist eine hohe Abdeckungszahl allein kein Beweis für gute Tests? /
   **EN:** Why is a high coverage number alone not proof of good tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Abdeckung misst, welcher Code ausgeführt wurde, nicht ob sinnvoll geprüft wurde. Man kann viel Code
   durchlaufen, ohne wichtige Grenz- und Negativfälle zu prüfen.
   **EN:** Coverage measures which code ran, not whether it was checked meaningfully. You can run much code
   without checking important edge and negative cases.

   </details>

4. **DE:** Warum gehören Security-Tests fest in die Matrix und nicht in ein „später"? /
   **EN:** Why do security tests belong firmly in the matrix and not in a "later"?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sicherheitswege sind besonders schadensträchtig. Ohne feste Tests bleibt unklar, ob Autorisierung,
   sichere Meldungen und Eingabeprüfung wirklich funktionieren.
   **EN:** Security paths carry particularly high damage potential. Without fixed tests it stays unclear whether
   authorization, safe messages, and input checks really work.

   </details>

5. **DE:** Was ist ein „flaky" Test und warum ist er ein Problem? /
   **EN:** What is a "flaky" test and why is it a problem?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Test, der mal besteht und mal fällt, ohne dass sich der Code ändert. Er zerstört das Vertrauen
   in die Testergebnisse und verdeckt echte Fehler.
   **EN:** A test that sometimes passes and sometimes fails without the code changing. It destroys trust in the
   results and hides real failures.

   </details>

6. **DE:** Wie belegst du gegenüber einem Prüfer, dass die Tests wirklich liefen? /
   **EN:** How do you prove to a reviewer that the tests really ran?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Durch einen CI-Nachweis mit Lauf-Nummer, Ergebnis (bestanden/gefallen) und geprüften Bereichen im
   Reviewpfad – prüfbare Evidenz statt einer Behauptung.
   **EN:** Through CI evidence with a run number, result (pass/fail), and checked areas in the review path –
   verifiable evidence instead of a claim.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] eine ausgewogene Testpyramide planen und begründen.
- [ ] zu jeder Schutzregel einen Negativtest angeben.
- [ ] Security-Tests fest in die Testmatrix aufnehmen.
- [ ] Abdeckung mit CI-Nachweis statt Behauptung belegen.
- [ ] flaky Tests als Problem erkennen und benennen.

**EN:** I can …

- [ ] plan and justify a balanced test pyramid.
- [ ] give a negative test for every protection rule.
- [ ] include security tests firmly in the test matrix.
- [ ] prove coverage with CI evidence instead of a claim.
- [ ] recognize and name flaky tests as a problem.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_07_Testpyramide-und-Negativtests.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_07_Testpyramide-und-Negativtests.md`. The copy-paste prompt
for a later, manually started Spec Kit run is provided there.
