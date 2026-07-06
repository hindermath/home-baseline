# Lernbegleiter: Secure ServiceHarvester Application Track 09 – Teststrategie: Unit, Integration und Contract-Tests / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Tests beweisen, dass der Secure ServiceHarvester das tut, was er soll – und das nicht tut, was er nicht
soll. Damit Tests nützlich und bezahlbar bleiben, ordnet man sie in einer **Testpyramide**: unten viele
schnelle **Unit-Tests** (prüfen einzelne Bausteine isoliert), in der Mitte weniger **Integrationstests**
(prüfen das Zusammenspiel mehrerer Bausteine, z. B. mit einem Persistenz-Adapter) und darüber gezielte
**Contract-Tests** (prüfen, dass die Schnittstellenverträge eingehalten werden). Bild dazu: eine Pyramide steht
stabil, weil unten die breite, günstige Basis liegt und oben nur wenige, teurere Steine.

**EN:** Tests prove that the Secure ServiceHarvester does what it should – and does not do what it should not.
For tests to stay useful and affordable, you arrange them in a **test pyramid**: at the bottom many fast **unit
tests** (check individual building blocks in isolation), in the middle fewer **integration tests** (check the
interplay of several blocks, e.g. with a persistence adapter), and above them targeted **contract tests**
(check that interface contracts are honored). The picture: a pyramid stands stable because the broad, cheap
base is at the bottom and only few, more expensive stones are at the top.

**DE:** Wichtig im 3. Lehrjahr: Du planst **Negativ- und Sicherheitstests** bewusst mit ein, nutzt nur
synthetische Testdaten und sorgst dafür, dass Tests **reproduzierbar** in CI und Sandbox laufen. Als
C#-Referenz dient `InventarWorkerService`; die Teststrategie bleibt sprachneutral.

**EN:** Important in the third year: you deliberately include **negative and security tests**, use only
synthetic test data, and ensure tests run **reproducibly** in CI and sandbox. `InventarWorkerService` serves as
a C# reference, but the test strategy stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Unit-Test / Unit test | Prüft einen einzelnen Baustein isoliert, schnell und ohne echte Infrastruktur. |
| Integrationstest / Integration test | Prüft das Zusammenspiel mehrerer Bausteine, z. B. mit einem Adapter. |
| Contract-Test / Contract test | Prüft, dass ein Schnittstellenvertrag eingehalten und nicht unbemerkt gebrochen wird. |
| Testpyramide / Test pyramid | Verteilung: viele Unit-, weniger Integrations-, wenige End-to-End-/Contract-Tests. |
| Negativtest / Negative test | Prüft, dass ungültige Eingaben oder Fehlerfälle sicher behandelt werden. |
| Synthetische Testdaten / Synthetic test data | Erfundene, datenschutzkonforme Daten ohne echten Personenbezug. |
| Reproduzierbarkeit / Reproducibility | Ein Test liefert bei jedem Lauf unter gleichen Bedingungen dasselbe Ergebnis. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Testarten und Zweck trennen.** Ordne jeder Testart ihren Zweck zu. Unit-Tests prüfen
Logik in Isolation (z. B. eine Validierungsregel). Integrationstests prüfen das Zusammenspiel (z. B. Dienst
plus In-Memory-Persistenz). Contract-Tests prüfen, dass ein Vertrag (Schema, Fehlercodes) genau eingehalten
wird. Diese Trennung verhindert, dass ein langsamer Test die Arbeit eines schnellen erledigt.

**EN:** **Step 1 – Separate test types and purpose.** Assign each test type its purpose. Unit tests check logic
in isolation (e.g. a validation rule). Integration tests check the interplay (e.g. service plus in-memory
persistence). Contract tests check that a contract (schema, error codes) is honored exactly. This separation
prevents a slow test from doing a fast test's job.

**DE:** **Schritt 2 – Die Pyramide richtig gewichten.** Baue viele schnelle Unit-Tests, weniger
Integrationstests und nur so viele Contract-/End-to-End-Tests wie nötig. Warum? Langsame, breite Tests sind
teuer und brüchig. Eine breite Unit-Basis fängt die meisten Fehler früh und günstig ab.

**EN:** **Step 2 – Weight the pyramid correctly.** Build many fast unit tests, fewer integration tests, and only
as many contract/end-to-end tests as needed. Why? Slow, broad tests are expensive and brittle. A broad unit
base catches most errors early and cheaply.

**DE:** **Schritt 3 – Negativ- und Sicherheitstests bewusst einplanen.** Ein Test, der nur den guten Fall zeigt,
beweist wenig über Sicherheit. Plane für jede wichtige Regel auch den Fehlerfall: ungültige Eingabe → richtiger
Fehlercode; fehlende Berechtigung → Zugriff verweigert; bösartige Nutzlast → sicher abgelehnt. Diese Tests sind
der eigentliche Sicherheitsnachweis.

**EN:** **Step 3 – Deliberately plan negative and security tests.** A test showing only the good case proves
little about security. For each important rule, plan the failure case too: invalid input → correct error code;
missing permission → access denied; malicious payload → safely rejected. These tests are the actual security
evidence.

**DE:** **Schritt 4 – Contract-Tests gegen Vertragsbruch.** Ein Contract-Test prüft, dass sich der Vertrag –
Schema, stabile Fehlercodes, erwartete Felder – nicht unbemerkt ändert. Ändert jemand versehentlich einen
Fehlercode oder ein Pflichtfeld, schlägt der Contract-Test fehl, bevor andere Systeme brechen.

**EN:** **Step 4 – Contract tests against contract breaks.** A contract test checks that the contract – schema,
stable error codes, expected fields – does not change unnoticed. If someone accidentally changes an error code
or a mandatory field, the contract test fails before other systems break.

**DE:** **Schritt 5 – Reproduzierbar und datenschutzkonform.** Tests dürfen nicht mal grün, mal rot sein
(keine „flaky tests"). Vermeide Abhängigkeit von Uhrzeit, Zufall oder Netzwerk oder steuere sie kontrolliert.
Nutze nur synthetische Testdaten – niemals echte personenbezogene Daten. Die Tests laufen in CI und in der
Sandbox gleich.

**EN:** **Step 5 – Reproducible and privacy-compliant.** Tests must not be sometimes green, sometimes red (no
"flaky tests"). Avoid dependence on clock, randomness, or network, or control it deliberately. Use only
synthetic test data – never real personal data. The tests run the same in CI and in the sandbox.

**DE:** **Typische Fehler.** Nur End-to-End-Tests (langsam, brüchig). Keine Negativtests. Contract-Tests
weglassen und Verträge unbemerkt brechen. Echte personenbezogene Testdaten. Flaky Tests durch Zeit oder
Zufall. Testabdeckung als reine Zahl statt sinnvoller Fälle jagen.

**EN:** **Common mistakes.** Only end-to-end tests (slow, brittle). No negative tests. Omitting contract tests
and breaking contracts unnoticed. Real personal test data. Flaky tests due to time or randomness. Chasing test
coverage as a mere number instead of meaningful cases.

### Beispiel / Example

```text
Testpyramide (Secure ServiceHarvester):
  Unit (viele):        Validierungsregel "Maschinenname nicht leer" -> positiv + negativ
                       Zustandslogik Snapshot -> gültiger/ungültiger Übergang
  Integration (mittel): Dienst + In-Memory-Persistenz -> speichern/laden korrekt
                        Fehlerpfad: Persistenz simuliert Ausfall -> HV-TEC-500
  Contract (wenige):   Schema-Vertrag v2 stabil (Pflichtfelder, Fehlercodes unverändert)

Negativ-/Sicherheitstests:
  - leere Eingabe            -> HV-VAL-001
  - fehlende Berechtigung    -> Zugriff verweigert
  - Nutzlast mit Feld "cmd"  -> abgelehnt (Deserialisierungs-Härtung)

Reproduzierbarkeit: feste Testdaten (Maschine-0001..0100, synthetisch), Uhrzeit injiziert, kein Netzwerk.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Eine belastbare Teststrategie ist Teil der zuverlässigen Realisierung von Anwendungsfunktionalität. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Negativ- und Sicherheitstests belegen den Schutz sicherheitsrelevanter Funktionen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testbarkeit, Negativ- und Sicherheitstests, reproduzierbare
Nachweise und Datenschutz durch synthetische Testdaten. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_02` (Eingabevalidierung), `CL_08` (Sicherheits-Code-Review) und `CL_11`
(reproduzierbare Umgebung/Nachweise). Die Sicherheitsentscheidung dieser Einheit lautet: *Sicherheit wird nicht
behauptet, sondern mit Negativ- und Contract-Tests belegt, und Tests laufen reproduzierbar mit synthetischen
Daten.* A11Y-Aspekt: Testpläne und Ergebnisse werden als klarer, strukturierter Text mit Fallnamen dargestellt,
damit sie mit Screenreader und Braille-Zeile nachvollziehbar sind.

**EN:** Relation to the Secure Development Guideline: testability, negative and security tests, reproducible
evidence, and privacy through synthetic test data. Matching checklists: `CL_01` (standards applicability),
`CL_02` (input validation), `CL_08` (security code review), and `CL_11` (reproducible environment/evidence). The
security decision of this unit is: *security is not claimed but evidenced with negative and contract tests, and
tests run reproducibly with synthetic data.* Accessibility aspect: test plans and results are presented as
clear, structured text with case names so they can be followed with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum baut man viele Unit-Tests und nur wenige End-to-End-Tests? /
   **EN:** Why do you build many unit tests and only few end-to-end tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Unit-Tests sind schnell, günstig und stabil und fangen die meisten Fehler früh ab. End-to-End-Tests
   sind langsam und brüchig; man nutzt nur so viele wie nötig. Das ergibt die stabile Testpyramide.
   **EN:** Unit tests are fast, cheap, and stable and catch most errors early. End-to-end tests are slow and
   brittle; you use only as many as needed. This yields the stable test pyramid.

   </details>

2. **DE:** Was prüft ein Integrationstest, das ein Unit-Test nicht zeigt? /
   **EN:** What does an integration test check that a unit test does not show?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Das Zusammenspiel mehrerer Bausteine, z. B. Dienst plus Persistenz-Adapter. Fehler an der
   Schnittstelle zwischen Bausteinen zeigen sich erst hier, nicht im isolierten Unit-Test.
   **EN:** The interplay of several building blocks, e.g. service plus persistence adapter. Errors at the seam
   between blocks appear only here, not in the isolated unit test.

   </details>

3. **DE:** Wozu dient ein Contract-Test? /
   **EN:** What is a contract test for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er sichert, dass ein Schnittstellenvertrag – Schema, Pflichtfelder, stabile Fehlercodes – nicht
   unbemerkt gebrochen wird. Er schlägt fehl, bevor abhängige Systeme durch die Änderung brechen.
   **EN:** It ensures an interface contract – schema, mandatory fields, stable error codes – is not broken
   unnoticed. It fails before dependent systems break from the change.

   </details>

4. **DE:** Warum sind Negativtests der eigentliche Sicherheitsnachweis? /
   **EN:** Why are negative tests the actual security evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Erfolgstest zeigt nur den guten Fall. Erst ein Negativtest beweist, dass ungültige oder bösartige
   Eingaben wirklich abgelehnt werden und Fehlerpfade greifen – das ist der Kern der Sicherheit.
   **EN:** A success test shows only the good case. Only a negative test proves that invalid or malicious inputs
   are really rejected and error paths work – that is the core of security.

   </details>

5. **DE:** Warum verwendest du in Tests nur synthetische Daten? /
   **EN:** Why do you use only synthetic data in tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte personenbezogene Daten in Tests verletzen den Datenschutz und können ungewollt kopiert oder
   geloggt werden. Synthetische Daten sind sicher und trotzdem realistisch genug.
   **EN:** Real personal data in tests violates privacy and can be copied or logged unintentionally. Synthetic
   data is safe and still realistic enough.

   </details>

6. **DE:** Was macht einen Test „flaky" und warum ist das schlimm? /
   **EN:** What makes a test "flaky" and why is that bad?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein flaky Test ist mal grün, mal rot ohne Codeänderung, oft durch Zeit, Zufall oder Netzwerk. Er
   zerstört Vertrauen in die Tests. Abhilfe: solche Abhängigkeiten kontrolliert injizieren oder vermeiden.
   **EN:** A flaky test is sometimes green, sometimes red without code changes, often due to time, randomness, or
   network. It destroys trust in the tests. Remedy: inject or avoid such dependencies in a controlled way.

   </details>

7. **DE:** (SI) Warum sollen Tests in CI und Sandbox gleich laufen? /
   **EN:** (SI) Why should tests run the same in CI and sandbox?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Gleiche Ergebnisse überall machen Nachweise vertrauenswürdig und reproduzierbar. Läuft ein Test nur
   lokal, aber nicht in CI, ist der Nachweis wertlos und Fehler bleiben unentdeckt.
   **EN:** The same results everywhere make evidence trustworthy and reproducible. If a test runs only locally
   but not in CI, the evidence is worthless and errors stay hidden.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Unit-, Integrations- und Contract-Tests nach Zweck unterscheiden.
- [ ] eine Testpyramide sinnvoll gewichten.
- [ ] Negativ- und Sicherheitstests bewusst einplanen.
- [ ] Contract-Tests gegen unbemerkten Vertragsbruch benennen.
- [ ] Tests reproduzierbar und mit synthetischen Daten gestalten.

**EN:** I can …

- [ ] distinguish unit, integration, and contract tests by purpose.
- [ ] weight a test pyramid sensibly.
- [ ] deliberately plan negative and security tests.
- [ ] name contract tests against unnoticed contract breaks.
- [ ] design tests reproducibly and with synthetic data.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
