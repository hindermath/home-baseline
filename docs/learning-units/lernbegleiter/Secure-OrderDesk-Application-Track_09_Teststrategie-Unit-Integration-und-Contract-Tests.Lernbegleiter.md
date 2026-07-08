# Lernbegleiter: Secure OrderDesk Application Track 09 – Teststrategie: Unit, Integration und Contract-Tests / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Tests beweisen, dass das Secure OrderDesk das tut, was es soll – und das nicht tut, was es nicht soll. Damit Tests nützlich und bezahlbar bleiben, ordnet man sie in einer **Testpyramide**: unten viele schnelle **Unit-Tests** (prüfen einzelne Bausteine isoliert, z. B. eine Regel für `CustomerID`), in der Mitte weniger **Integrationstests** (prüfen das Zusammenspiel mehrerer Bausteine, z. B. Dienst plus Persistenz-Adapter über der Northwind-Bestelldomäne), und darüber gezielte **Contract-Tests** (prüfen, dass die Schnittstellenverträge der Bestell-Pipeline eingehalten werden). Bild dazu: eine Pyramide steht stabil, weil unten die breite, günstige Basis liegt und oben nur wenige, teurere Steine.

**EN:** Tests prove that the Secure OrderDesk does what it should – and does not do what it should not. For tests to stay useful and affordable, you arrange them in a **test pyramid**: at the bottom many fast **unit tests** (check individual building blocks in isolation, e.g. a rule for `CustomerID`), in the middle fewer **integration tests** (check the interplay of several blocks, e.g. service plus persistence adapter over the Northwind ordering domain), and above them targeted **contract tests** (check that the interface contracts of the order pipeline are honored). The picture: a pyramid stands stable because the broad, cheap base is at the bottom and only few, more expensive stones are at the top.

**DE:** Wichtig im 3. Lehrjahr: Du planst **Negativ- und Sicherheitstests** bewusst mit ein – besonders **SQL-Injection-Negativtests** gegen die Northwind-Datenzugriffe (Kunden `Customers`, Bestellungen `Orders`, Positionen `Order Details`, Produkte `Products`, verankert am fiktiven Kunden `ALFKI`). Du nutzt nur synthetische Testdaten und sorgst dafür, dass Tests **reproduzierbar** in CI und Sandbox laufen. Die Teststrategie bleibt sprachneutral über C#, Go, Java, Python, Rust und Swift.

**EN:** Important in the third year: you deliberately include **negative and security tests** – especially **SQL injection negative tests** against the Northwind data access (customers `Customers`, orders `Orders`, lines `Order Details`, products `Products`, anchored to the fictional customer `ALFKI`). You use only synthetic test data and ensure tests run **reproducibly** in CI and sandbox. The test strategy stays language-neutral across C#, Go, Java, Python, Rust, and Swift.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Unit-Test / Unit test | Prüft einen einzelnen Baustein isoliert, schnell und ohne echte Datenbank. |
| Integrationstest / Integration test | Prüft das Zusammenspiel mehrerer Bausteine, z. B. Dienst plus Persistenz-Adapter über `Orders`. |
| Contract-Test / Contract test | Prüft, dass ein Schnittstellenvertrag eingehalten und nicht unbemerkt gebrochen wird. |
| Testpyramide / Test pyramid | Verteilung: viele Unit-, weniger Integrations-, wenige End-to-End-/Contract-Tests. |
| Negativtest / Negative test | Prüft, dass ungültige Eingaben oder Fehlerfälle sicher behandelt werden. |
| SQL-Injection-Negativtest / SQL injection negative test | Prüft, dass eine bösartige SQL-Nutzlast im Filter parametrisiert und nicht ausgeführt wird. |
| Synthetische Testdaten / Synthetic test data | Erfundene, datenschutzkonforme Daten ohne echten Personenbezug (z. B. `ALFKI`). |
| Reproduzierbarkeit / Reproducibility | Ein Test liefert bei jedem Lauf unter gleichen Bedingungen dasselbe Ergebnis. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Testarten und Zweck trennen.** Ordne jeder Testart ihren Zweck zu. Unit-Tests prüfen Logik in Isolation (z. B. die Regel „`CustomerID` darf nicht leer sein" oder „`Quantity` größer null"). Integrationstests prüfen das Zusammenspiel (z. B. Bestelldienst plus In-Memory-Persistenz über `Orders` und `Order Details`). Contract-Tests prüfen, dass ein Vertrag (Schema, Fehlercodes) genau eingehalten wird. Diese Trennung verhindert, dass ein langsamer Test die Arbeit eines schnellen erledigt.

**EN:** **Step 1 – Separate test types and purpose.** Assign each test type its purpose. Unit tests check logic in isolation (e.g. the rule "`CustomerID` must not be empty" or "`Quantity` greater than zero"). Integration tests check the interplay (e.g. order service plus in-memory persistence over `Orders` and `Order Details`). Contract tests check that a contract (schema, error codes) is honored exactly. This separation prevents a slow test from doing a fast test's job.

**DE:** **Schritt 2 – Die Pyramide richtig gewichten.** Baue viele schnelle Unit-Tests, weniger Integrationstests und nur so viele Contract-/End-to-End-Tests wie nötig. Warum? Langsame, breite Tests sind teuer und brüchig. Eine breite Unit-Basis fängt die meisten Fehler früh und günstig ab.

**EN:** **Step 2 – Weight the pyramid correctly.** Build many fast unit tests, fewer integration tests, and only as many contract/end-to-end tests as needed. Why? Slow, broad tests are expensive and brittle. A broad unit base catches most errors early and cheaply.

**DE:** **Schritt 3 – Negativ- und Sicherheitstests bewusst einplanen.** Ein Test, der nur den guten Fall zeigt, beweist wenig über Sicherheit. Plane für jede wichtige Regel auch den Fehlerfall: ungültige Eingabe → richtiger Fehlercode; fehlende Berechtigung → Zugriff verweigert; **SQL-Injection-Nutzlast im Filter (z. B. `ALFKI' OR '1'='1`) → parametrisiert und sicher abgelehnt**. Diese Tests sind der eigentliche Sicherheitsnachweis für die Bestelldatenzugriffe.

**EN:** **Step 3 – Deliberately plan negative and security tests.** A test showing only the good case proves little about security. For each important rule, plan the failure case too: invalid input → correct error code; missing permission → access denied; **SQL injection payload in the filter (e.g. `ALFKI' OR '1'='1`) → parameterized and safely rejected**. These tests are the actual security evidence for the order data access.

**DE:** **Schritt 4 – Contract-Tests gegen Vertragsbruch.** Ein Contract-Test prüft, dass sich der Vertrag der Bestell-Schnittstelle – Schema, stabile Fehlercodes, erwartete Felder (`OrderID`, `CustomerID`, `OrderDate`) – nicht unbemerkt ändert. Ändert jemand versehentlich einen Fehlercode oder ein Pflichtfeld, schlägt der Contract-Test fehl, bevor andere Systeme brechen.

**EN:** **Step 4 – Contract tests against contract breaks.** A contract test checks that the order interface contract – schema, stable error codes, expected fields (`OrderID`, `CustomerID`, `OrderDate`) – does not change unnoticed. If someone accidentally changes an error code or a mandatory field, the contract test fails before other systems break.

**DE:** **Schritt 5 – Reproduzierbar und datenschutzkonform.** Tests dürfen nicht mal grün, mal rot sein (keine „flaky tests"). Vermeide Abhängigkeit von Uhrzeit, Zufall oder Netzwerk oder steuere sie kontrolliert. Nutze nur synthetische Testdaten – niemals echte personenbezogene Kundendaten; der Anker `ALFKI` ist fiktiv (Northwind). Die Tests laufen in CI und in der Sandbox gleich.

**EN:** **Step 5 – Reproducible and privacy-compliant.** Tests must not be sometimes green, sometimes red (no "flaky tests"). Avoid dependence on clock, randomness, or network, or control it deliberately. Use only synthetic test data – never real personal customer data; the anchor `ALFKI` is fictional (Northwind). The tests run the same in CI and in the sandbox.

**DE:** **Typische Fehler.** Nur End-to-End-Tests (langsam, brüchig). Keine Negativtests. Keinen SQL-Injection-Negativtest gegen die Filter. Contract-Tests weglassen und Verträge unbemerkt brechen. Echte personenbezogene Testdaten. Flaky Tests durch Zeit oder Zufall. Testabdeckung als reine Zahl statt sinnvoller Fälle jagen.

**EN:** **Common mistakes.** Only end-to-end tests (slow, brittle). No negative tests. No SQL injection negative test against the filters. Omitting contract tests and breaking contracts unnoticed. Real personal test data. Flaky tests due to time or randomness. Chasing test coverage as a mere number instead of meaningful cases.

### Beispiel / Example

```text
Testpyramide (Secure OrderDesk):
  Unit (viele):        Validierungsregel "CustomerID nicht leer"  -> positiv + negativ
                       Regel "Quantity > 0 in Order Details"      -> gueltig/ungueltig
  Integration (mittel): Bestelldienst + In-Memory-Persistenz      -> Orders speichern/laden korrekt
                        Fehlerpfad: Persistenz simuliert Ausfall  -> OD-TEC-500
  Contract (wenige):   Schema-Vertrag v2 stabil (Pflichtfelder OrderID/CustomerID, Fehlercodes)

Negativ-/Sicherheitstests:
  - leere Eingabe                  -> OD-VAL-001
  - fehlende Berechtigung          -> Zugriff verweigert
  - Filter "ALFKI' OR '1'='1"      -> parametrisiert, kein Datenleck (SQL-Injection-Negativtest)
  - Sortierfeld "DROP TABLE Orders" -> abgelehnt (nicht auf Whitelist)

Reproduzierbarkeit: feste Testdaten (Customers ALFKI/ANATR/AROUT, Orders synthetisch),
                    Uhrzeit injiziert, kein Netzwerk, gleiche Ergebnisse in CI und Sandbox.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"). Für die Teststrategie ist **LF 11a** primär, weil eine belastbare Teststrategie Teil der zuverlässigen Realisierung von Anwendungsfunktionalität ist; LF 4 ist berührt, weil Negativ- und Sicherheitstests den Schutzbedarf belegen, und LF 5, weil die getesteten Zugriffe die relationale Bestelldatenverwaltung betreffen.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"). For the test strategy **LF 11a** is primary, because a robust test strategy is part of reliably realizing application functionality; LF 4 is touched, because negative and security tests evidence the protection need, and LF 5, because the tested access concerns the relational order data management.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Eine belastbare Teststrategie ist Teil der zuverlässigen Realisierung von Anwendungsfunktionalität. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Negativ-, Sicherheits- und SQL-Injection-Tests belegen den Schutz sicherheitsrelevanter Bestellfunktionen. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Integrations- und Contract-Tests prüfen die angepasste relationale Bestelldatenverwaltung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testbarkeit, Negativ- und Sicherheitstests, parametrisiertes SQL, reproduzierbare Nachweise und Datenschutz durch synthetische Testdaten. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Eingabevalidierung), `CL_08` (Sicherheits-Code-Review), `CL_11` (reproduzierbare Umgebung/Nachweise) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Sicherheit wird nicht behauptet, sondern mit Negativ-, SQL-Injection- und Contract-Tests belegt, und Tests laufen reproduzierbar mit synthetischen Daten.* A11Y-Aspekt: Testpläne, Testfall-Matrix und Ergebnisse werden als klarer, strukturierter Text mit Fallnamen dargestellt und nicht allein über Farbe signalisiert, damit sie mit Screenreader und Braille-Zeile nachvollziehbar sind.

**EN:** Relation to the Secure Development Guideline: testability, negative and security tests, parameterized SQL, reproducible evidence, and privacy through synthetic test data. Matching checklists: `CL_01` (standards applicability), `CL_02` (input validation), `CL_08` (security code review), `CL_11` (reproducible environment/evidence), and `CL_12` (evidence and closure). The security decision of this unit is: *security is not claimed but evidenced with negative, SQL injection, and contract tests, and tests run reproducibly with synthetic data.* Accessibility aspect: test plans, test-case matrix, and results are presented as clear, structured text with case names and not signaled by color alone, so they can be followed with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum baut man viele Unit-Tests und nur wenige End-to-End-Tests? /
   **EN:** Why do you build many unit tests and only few end-to-end tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Unit-Tests sind schnell, günstig und stabil und fangen die meisten Fehler früh ab. End-to-End-Tests sind langsam und brüchig; man nutzt nur so viele wie nötig. Das ergibt die stabile Testpyramide.
   **EN:** Unit tests are fast, cheap, and stable and catch most errors early. End-to-end tests are slow and brittle; you use only as many as needed. This yields the stable test pyramid.

   </details>

2. **DE:** (AE) Was prüft ein Integrationstest über `Orders`, das ein Unit-Test nicht zeigt? /
   **EN:** (AE) What does an integration test over `Orders` check that a unit test does not show?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Das Zusammenspiel mehrerer Bausteine, z. B. Bestelldienst plus Persistenz-Adapter. Fehler an der Schnittstelle zwischen Dienst und Datenzugriff zeigen sich erst hier, nicht im isolierten Unit-Test.
   **EN:** The interplay of several building blocks, e.g. order service plus persistence adapter. Errors at the seam between service and data access appear only here, not in the isolated unit test.

   </details>

3. **DE:** (DV) Wozu dient ein Contract-Test an der Bestell-Schnittstelle? /
   **EN:** (DV) What is a contract test at the order interface for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er sichert, dass ein Schnittstellenvertrag – Schema, Pflichtfelder wie `OrderID`, stabile Fehlercodes – nicht unbemerkt gebrochen wird. Er schlägt fehl, bevor abhängige Systeme durch die Änderung brechen.
   **EN:** It ensures an interface contract – schema, mandatory fields like `OrderID`, stable error codes – is not broken unnoticed. It fails before dependent systems break from the change.

   </details>

4. **DE:** Warum ist ein SQL-Injection-Negativtest der eigentliche Sicherheitsnachweis für den Datenzugriff? /
   **EN:** Why is an SQL injection negative test the actual security evidence for data access?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Erfolgstest zeigt nur den guten Fall. Erst ein Negativtest mit bösartiger Nutzlast (z. B. `ALFKI' OR '1'='1`) beweist, dass der Filter parametrisiert ist und kein Datenleck entsteht – das ist der Kern der SQL-Sicherheit.
   **EN:** A success test shows only the good case. Only a negative test with a malicious payload (e.g. `ALFKI' OR '1'='1`) proves that the filter is parameterized and no data leak arises – that is the core of SQL security.

   </details>

5. **DE:** (DPA) Warum verwendest du in Tests nur synthetische Daten wie `ALFKI`? /
   **EN:** (DPA) Why do you use only synthetic data like `ALFKI` in tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte personenbezogene Kundendaten in Tests verletzen den Datenschutz und können ungewollt kopiert oder geloggt werden. Synthetische Northwind-Daten sind sicher und trotzdem realistisch genug.
   **EN:** Real personal customer data in tests violates privacy and can be copied or logged unintentionally. Synthetic Northwind data is safe and still realistic enough.

   </details>

6. **DE:** Was macht einen Test „flaky" und warum ist das schlimm? /
   **EN:** What makes a test "flaky" and why is that bad?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein flaky Test ist mal grün, mal rot ohne Codeänderung, oft durch Zeit, Zufall oder Netzwerk. Er zerstört Vertrauen in die Tests. Abhilfe: solche Abhängigkeiten kontrolliert injizieren oder vermeiden.
   **EN:** A flaky test is sometimes green, sometimes red without code changes, often due to time, randomness, or network. It destroys trust in the tests. Remedy: inject or avoid such dependencies in a controlled way.

   </details>

7. **DE:** (SI) Warum sollen Tests in CI und Sandbox gleich laufen, auch gegen die Datenbank? /
   **EN:** (SI) Why should tests run the same in CI and sandbox, also against the database?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Gleiche Ergebnisse überall machen Nachweise vertrauenswürdig und reproduzierbar. Läuft ein Datenbanktest nur lokal, aber nicht in CI, ist der Nachweis wertlos und Fehler im Datenzugriff bleiben unentdeckt.
   **EN:** The same results everywhere make evidence trustworthy and reproducible. If a database test runs only locally but not in CI, the evidence is worthless and data-access errors stay hidden.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Unit-, Integrations- und Contract-Tests nach Zweck unterscheiden.
- [ ] eine Testpyramide für die Bestelldomäne sinnvoll gewichten.
- [ ] Negativ- und Sicherheitstests inklusive SQL-Injection-Negativtest bewusst einplanen.
- [ ] Contract-Tests gegen unbemerkten Vertragsbruch der Bestell-Schnittstelle benennen.
- [ ] Tests reproduzierbar und mit synthetischen `ALFKI`-Daten gestalten.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] distinguish unit, integration, and contract tests by purpose.
- [ ] weight a test pyramid for the ordering domain sensibly.
- [ ] deliberately plan negative and security tests including an SQL injection negative test.
- [ ] name contract tests against unnoticed contract breaks of the order interface.
- [ ] design tests reproducibly and with synthetic `ALFKI` data.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Application-Track_09_Teststrategie-Unit-Integration-und-Contract-Tests.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
