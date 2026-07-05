# Lernbegleiter: Secure CaseTracker 07 – Testbarkeit und Qualität / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_07_Testbarkeit-und-Qualitaet.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Tests sind kein lästiges Anhängsel, sondern **Beweise**. Sie zeigen, dass das Programm tut, was es
soll – und dass es gefährliche Eingaben zuverlässig ablehnt. In dieser Einheit planst du den Testumfang für
den Secure CaseTracker. Wichtig ist die Unterscheidung: **fachliche Tests** (Fall anlegen, ändern,
schließen), **negative Sicherheitstests** (verbotene Aktion, ungültige Eingabe, manipulierter Pfad),
**Datenschutztests** (keine unnötigen personenbezogenen Daten, Log-Regeln) und spätere **CI-/Sandbox-
Nachweise**. Genauso wichtig: offene Testlücken werden **transparent** dokumentiert und nicht versteckt.

**EN:** Tests are not an annoying add-on but **evidence**. They show that the program does what it should – and
that it reliably rejects dangerous inputs. In this unit you plan the test scope for the Secure CaseTracker.
The key distinction: **functional tests** (create, update, close a case), **negative security tests**
(forbidden action, invalid input, manipulated path), **privacy tests** (no unnecessary personal data, log
rules), and later **CI/sandbox evidence**. Equally important: open test gaps are documented **transparently**
and not hidden.

**DE:** Alle Testdaten sind fiktiv und enthalten keine echten personenbezogenen Daten. Jede
sicherheitsrelevante Regel bekommt mindestens einen negativen Test.

**EN:** All test data is fictitious and contains no real personal data. Every security-relevant rule gets at
least one negative test.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Fachlicher Test / Functional test | Prüft, ob eine gewünschte Funktion korrekt arbeitet. |
| Negativtest / Negative test | Prüft, ob ungültige oder verbotene Fälle korrekt abgelehnt werden. |
| Datenschutztest / Privacy test | Prüft Datenminimierung und Logging-Regeln. |
| Fehlpfad / Error path | Ablauf, bei dem etwas absichtlich schiefgeht und geprüft wird. |
| CI-Nachweis / CI evidence | Automatischer Testlauf, der Ergebnisse reproduzierbar belegt. |
| Testlücke / Test gap | Bekannter, dokumentierter Bereich ohne (ausreichende) Tests. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Testarten trennen.** Benenne getrennt fachliche Tests, Sicherheitstests und
Datenschutztests. Warum trennen? Jede Art prüft ein anderes Risiko; wer nur Erfolgspfade testet, übersieht
gerade die gefährlichen Fälle.

**EN:** **Step 1 – Separate test types.** Name functional tests, security tests, and privacy tests separately.
Why separate? Each type checks a different risk; whoever tests only success paths misses exactly the dangerous
cases.

**DE:** **Schritt 2 – Fehlpfade und Negativtests planen.** Jede sicherheitsrelevante Regel braucht mindestens
einen negativen Test: verbotene Aktion je Rolle, ungültige Eingabe, manipulierter Pfad, ungültige Importdatei.
Warum? Ein Negativtest beweist, dass der Schutz wirklich greift, nicht nur der Erfolgsfall.

**EN:** **Step 2 – Plan error paths and negative tests.** Every security-relevant rule needs at least one
negative test: forbidden action per role, invalid input, manipulated path, invalid import file. Why? A
negative test proves the protection really works, not just the success case.

**DE:** **Schritt 3 – Testdaten datenschutzfreundlich wählen.** Nutze fiktive, wiederholbare Testdaten. Keine
echten Namen, keine Secrets, keine unnötigen personenbezogenen Daten in Tests oder Testberichten. Warum? Auch
Testdaten und Berichte können Datenschutz verletzen, wenn echte Daten hineingeraten.

**EN:** **Step 3 – Choose privacy-friendly test data.** Use fictitious, repeatable test data. No real names, no
secrets, no unnecessary personal data in tests or test reports. Why? Test data and reports can also violate
privacy if real data slips in.

**DE:** **Schritt 4 – Testlücken sichtbar machen.** Wenn eine Testart oder Coverage-Schwelle noch nicht möglich
ist (z. B. weil keine Implementierung existiert), dokumentiere sie als `Open` oder `N/A` mit Grund und späterem
Re-Evaluierungszeitpunkt. Warum? Versteckte Lücken täuschen Sicherheit vor; offene Lücken lassen sich planen
und schließen.

**EN:** **Step 4 – Make test gaps visible.** If a test type or coverage threshold is not yet possible (e.g.
because no implementation exists), document it as `Open` or `N/A` with a reason and a later re-evaluation
point. Why? Hidden gaps fake security; open gaps can be planned and closed.

**DE:** **Typische Fehler.** Nur Erfolgspfade testen. Sicherheitsregeln ohne Negativtest lassen. Secrets oder
echte Daten in Testdaten. Testlücken verschweigen. Testkommandos je Sprache nicht dokumentieren.

**EN:** **Common mistakes.** Testing only success paths. Leaving security rules without a negative test.
Secrets or real data in test data. Hiding test gaps. Not documenting the test command per language.

### Beispiel / Example

```text
Fachlicher Test:     Fall anlegen -> Status ist "new", createdAt gesetzt.
Sicherheits-Negativ: learner versucht Export -> ABGELEHNT (Autorisierung greift).
Sicherheits-Negativ: Import mit Pfad "../../etc/passwd" -> ABGELEHNT (Pfadgrenze greift).
Datenschutztest:     Audit-Log enthaelt kein Token, keinen vollstaendigen Freitext.
Testkommando:        C#: dotnet test | Go: go test ./... | Rust: cargo test | Python: pytest
Testluecke (Open):   Coverage-Schwelle N/A -> noch keine Implementierung, Re-Eval nach Einheit 06.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Testbarkeit sichert die Qualität der Datenverwaltungs-Software ab. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Tests decken die typischen Serviceabläufe (anlegen, ändern, schließen) ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testmanagement, Sicherheits-Code-Review und nachvollziehbare
Evidenz. Passende Checklisten: `CL_08` (Sicherheits-Code-Review), `CL_09` (Testmanagement) und `CL_10`
(Kompetenz-/Qualitätsnachweis). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede sicherheitsrelevante
Regel hat mindestens einen Negativtest, und offene Lücken werden ehrlich dokumentiert.* A11Y-Aspekt:
Testberichte sind textbasiert und ohne reine Farbsignale (nicht nur „grün/rot"), damit Ergebnisse mit
Screenreader und Braille-Zeile verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: test management, security code review, and traceable
evidence. Matching checklists: `CL_08` (security code review), `CL_09` (test management), and `CL_10`
(competence/quality evidence). The security decision of this unit is: *every security-relevant rule has at
least one negative test, and open gaps are documented honestly.* Accessibility aspect: test reports are
text-based and without color-only signals (not just "green/red"), so results remain understandable with a
screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum reicht es nicht, nur Erfolgspfade zu testen? /
   **EN:** Why is it not enough to test only success paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sicherheitslücken zeigen sich meist im Fehlerfall. Nur Negativtests beweisen, dass ungültige oder
   verbotene Eingaben wirklich abgelehnt werden.
   **EN:** Security holes usually show up in the error case. Only negative tests prove that invalid or
   forbidden inputs are really rejected.

   </details>

2. **DE:** (AE) Welcher Fehlerfall muss unbedingt automatisiert getestet werden? /
   **EN:** (AE) Which error case must absolutely be tested automatically?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jeder sicherheitsrelevante Fall, z. B. verbotene Aktion je Rolle, ungültiger Zustandswechsel oder
   manipulierter Pfad. Diese Fälle sind das Kernrisiko und dürfen nicht nur manuell geprüft werden.
   **EN:** Every security-relevant case, e.g. forbidden action per role, invalid state transition, or
   manipulated path. These cases are the core risk and must not be checked only manually.

   </details>

3. **DE:** (SI) Wie wird ein Testlauf in der Sandbox oder CI reproduzierbar? /
   **EN:** (SI) How is a test run reproducible in the sandbox or CI?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Durch dokumentierte Testkommandos je Sprache und feste, fiktive Testdaten. So liefert derselbe Lauf
   auf einem anderen Rechner dasselbe Ergebnis.
   **EN:** Through documented test commands per language and fixed, fictitious test data. The same run then
   yields the same result on another machine.

   </details>

4. **DE:** (DPA) Welche Testdaten sind realistisch, aber datenschutzfreundlich? /
   **EN:** (DPA) Which test data is realistic but privacy-friendly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fiktive, wiederholbare Daten, die die Struktur echter Fälle nachbilden, aber keine echten Namen,
   Kontaktdaten oder Secrets enthalten.
   **EN:** Fictitious, repeatable data that mirrors the structure of real cases but contains no real names,
   contact data, or secrets.

   </details>

5. **DE:** Warum werden offene Testlücken dokumentiert statt verschwiegen? /
   **EN:** Why are open test gaps documented rather than hidden?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Versteckte Lücken täuschen falsche Sicherheit vor. Offene, begründete Lücken lassen sich planen,
   priorisieren und später schließen.
   **EN:** Hidden gaps fake a false sense of security. Open, justified gaps can be planned, prioritized, and
   closed later.

   </details>

6. **DE:** Warum sind Coverage-Schwellen `N/A`, solange keine Implementierung existiert? /
   **EN:** Why are coverage thresholds `N/A` as long as no implementation exists?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Code gibt es nichts zu messen. Die Testarten werden trotzdem geplant, und die Schwelle wird zum
   späteren Re-Evaluierungszeitpunkt gesetzt.
   **EN:** Without code there is nothing to measure. The test types are still planned, and the threshold is set
   at the later re-evaluation point.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] fachliche Tests, Sicherheitstests und Datenschutztests getrennt planen.
- [ ] für jede sicherheitsrelevante Regel mindestens einen Negativtest angeben.
- [ ] fiktive, datenschutzfreundliche Testdaten wählen.
- [ ] Testkommandos je Zielsprache benennen.
- [ ] offene Testlücken als `Open` oder `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] plan functional, security, and privacy tests separately.
- [ ] give at least one negative test for each security-relevant rule.
- [ ] choose fictitious, privacy-friendly test data.
- [ ] name the test command per target language.
- [ ] document open test gaps as `Open` or `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_07_Testbarkeit-und-Qualitaet.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_07_Testbarkeit-und-Qualitaet.md`. The copy-paste prompt for a later, manually
started Spec Kit run is provided there.
