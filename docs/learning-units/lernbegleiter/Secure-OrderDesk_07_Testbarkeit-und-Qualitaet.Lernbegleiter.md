# Lernbegleiter: Secure OrderDesk 07 – Testbarkeit und Qualität / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_07_Testbarkeit-und-Qualitaet.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Tests sind kein lästiges Anhängsel, sondern **Beweise**. Sie zeigen, dass die Bestell-/Handelsplattform
Secure OrderDesk tut, was sie soll – und dass sie fehlerhafte oder manipulierte Bestell- und Kundeneingaben
zuverlässig ablehnt. In dieser Einheit planst du den Testumfang für Secure OrderDesk. Wichtig ist die
Unterscheidung: **fachliche Tests** (Kunde anlegen, gültige Bestellung mit Positionen speichern, einfache
Auswertung berechnen), **negative Sicherheitstests** (negative Menge, überhöhter Rabatt, SQL-Injektionsversuch
im Eingabefeld, manipulierter Import- oder Dateipfad), **Datenschutztests** (keine unnötigen personenbezogenen
Kundendaten, Log-Regeln) und – weil die Plattform **relational** ist – **datenbankspezifische Tests** für
parametrisierte Datenzugriffe und referentielle Integrität. Genauso wichtig: offene Testlücken werden
**transparent** dokumentiert und nicht versteckt.

**EN:** Tests are not an annoying add-on but **evidence**. They show that the Secure OrderDesk ordering/trading
platform does what it should – and that it reliably rejects faulty or manipulated order and customer input. In
this unit you plan the test scope for Secure OrderDesk. The key distinction: **functional tests** (create a
customer, store a valid order with lines, compute a simple report), **negative security tests** (negative
quantity, excessive discount, SQL injection attempt in an input field, manipulated import or file path),
**privacy tests** (no unnecessary personal customer data, log rules), and – because the platform is
**relational** – **database-specific tests** for parameterized data access and referential integrity. Equally
important: open test gaps are documented **transparently** and not hidden.

**DE:** Alle Testdaten sind fiktiv (Northwind-Layout inkl. `ALFKI`) und enthalten keine echten personenbezogenen
Daten und keine echten Secrets. Jede sicherheitsrelevante Regel bekommt mindestens einen negativen Test.

**EN:** All test data is fictitious (Northwind layout incl. `ALFKI`) and contains no real personal data and no
real secrets. Every security-relevant rule gets at least one negative test.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Fachlicher Test / Functional test | Prüft, ob eine gewünschte Funktion der Plattform korrekt arbeitet. |
| Negativtest / Negative test | Prüft, ob ungültige oder verbotene Fälle korrekt abgelehnt werden. |
| SQL-Injection / SQL injection | Angriff, der über Eingaben fremdes SQL einschleust; wird durch parametrisierte Queries verhindert. |
| Parametrisierte Query / Parameterized query | Datenzugriff, bei dem Werte getrennt vom SQL-Text übergeben werden. |
| Referentielle Integrität / Referential integrity | Regel, dass Fremdschlüssel (z. B. Bestellung -> Kunde) gültig bleiben. |
| Datenschutztest / Privacy test | Prüft Datenminimierung und Logging-Regeln für Kundendaten. |
| Testlücke / Test gap | Bekannter, dokumentierter Bereich ohne (ausreichende) Tests. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Testarten trennen.** Benenne getrennt fachliche Tests, Sicherheitstests,
Datenschutztests und datenbankspezifische Tests. Warum trennen? Jede Art prüft ein anderes Risiko; wer nur
Erfolgspfade testet, übersieht gerade die gefährlichen Fälle.

**EN:** **Step 1 – Separate test types.** Name functional tests, security tests, privacy tests, and
database-specific tests separately. Why separate? Each type checks a different risk; whoever tests only success
paths misses exactly the dangerous cases.

**DE:** **Schritt 2 – Fehlpfade und Negativtests planen.** Jede sicherheitsrelevante Regel braucht mindestens
einen negativen Test: negative Bestellmenge, Rabatt über 100 %, unbekannte `CustomerID`, ein
SQL-Injektionsversuch wie `'; DROP TABLE Orders;--` im Eingabefeld, ein manipulierter Import- oder Dateipfad.
Bestell- und Kundeneingaben gelten als nicht vertrauenswürdig und werden an der Vertrauensgrenze geprüft.
Warum? Ein Negativtest beweist, dass der Schutz wirklich greift, nicht nur der Erfolgsfall.

**EN:** **Step 2 – Plan error paths and negative tests.** Every security-relevant rule needs at least one
negative test: negative order quantity, discount above 100%, unknown `CustomerID`, a SQL injection attempt like
`'; DROP TABLE Orders;--` in an input field, a manipulated import or file path. Order and customer input is
treated as untrusted and validated at the trust boundary. Why? A negative test proves the protection really
works, not just the success case.

**DE:** **Schritt 3 – Datenbankverhalten testen.** Eine relationale Plattform ist mehr als eine Rechenfunktion.
Plane deshalb einen Test für parametrisierte Datenzugriffe (wird der Wert getrennt vom SQL-Text übergeben?) und
einen Test für referentielle Integrität (lehnt die Ablage eine Bestellung ohne gültigen Kunden ab?). Warum?
Genau diese Fragen unterscheiden eine sichere relationale Ablage von einfacher String-Verkettung und sind sonst
leicht zu übersehen.

**EN:** **Step 3 – Test database behavior.** A relational platform is more than a compute function. Therefore
plan a test for parameterized data access (is the value passed separately from the SQL text?) and a test for
referential integrity (does the store reject an order without a valid customer?). Why? These questions are
exactly what distinguishes a secure relational store from plain string concatenation and are otherwise easy to
overlook.

**DE:** **Schritt 4 – Testdaten datenschutzfreundlich wählen.** Nutze fiktive, wiederholbare Testdaten aus dem
Northwind-Layout, etwa `ALFKI` (Alfreds Futterkiste). Keine echten Kunden- oder Personennamen, keine Secrets,
keine unnötigen personenbezogenen Daten in Tests oder Testberichten. Secrets erscheinen nur als Platzhalter
`<PLATZHALTER-KEIN-ECHTER-WERT>`. Warum? Auch Testdaten und Berichte können Datenschutz verletzen, wenn echte
Daten hineingeraten.

**EN:** **Step 4 – Choose privacy-friendly test data.** Use fictitious, repeatable test data from the Northwind
layout, e.g. `ALFKI` (Alfreds Futterkiste). No real customer or personal names, no secrets, no unnecessary
personal data in tests or test reports. Secrets appear only as the placeholder
`<PLATZHALTER-KEIN-ECHTER-WERT>`. Why? Test data and reports can also violate privacy if real data slips in.

**DE:** **Schritt 5 – Testlücken sichtbar machen.** Wenn eine Testart oder Coverage-Schwelle noch nicht möglich
ist (z. B. weil keine Implementierung existiert), dokumentiere sie als `Open` oder `N/A` mit Grund und späterem
Re-Evaluierungszeitpunkt. Warum? Versteckte Lücken täuschen Sicherheit vor; offene Lücken lassen sich planen
und schließen.

**EN:** **Step 5 – Make test gaps visible.** If a test type or coverage threshold is not yet possible (e.g.
because no implementation exists), document it as `Open` or `N/A` with a reason and a later re-evaluation point.
Why? Hidden gaps fake security; open gaps can be planned and closed.

**DE:** **Typische Fehler.** Nur Erfolgspfade testen. Sicherheitsregeln ohne Negativtest lassen.
SQL-Injektionsschutz und parametrisierten Zugriff nicht prüfen. Referentielle Integrität vergessen. Secrets oder
echte Kundendaten in Testdaten. Testlücken verschweigen. Testkommandos je Sprache nicht dokumentieren.

**EN:** **Common mistakes.** Testing only success paths. Leaving security rules without a negative test. Not
checking SQL injection protection and parameterized access. Forgetting referential integrity. Secrets or real
customer data in test data. Hiding test gaps. Not documenting the test command per language.

### Beispiel / Example

```text
Fachlicher Test:     Bestellung fuer ALFKI speichern -> Order{customer=ALFKI} + OrderLine{qty,price} gueltig.
Sicherheits-Negativ: Menge = -3 (ungueltig)                  -> ABGELEHNT (Validierung greift).
Sicherheits-Negativ: Eingabe "'; DROP TABLE Orders;--"       -> ABGELEHNT/entschaerft (parametrisiert, kein SQL).
Datenbank-Test:      parametrisierte Query -> Wert getrennt vom SQL-Text uebergeben.
Datenbank-Test:      referentielle Integritaet -> Bestellung ohne gueltigen Kunden wird abgelehnt.
Datenschutztest:     Betriebs-/Audit-Log enthaelt kein Secret, keine vollstaendige Kundenanschrift.
Testkommando:        C#: dotnet test | Go: go test ./... | Java: mvn test | Python: pytest
                     Rust: cargo test | Swift: swift test
Testluecke (Open):   Coverage-Schwelle N/A -> noch keine Implementierung, Re-Eval nach Einheit 06.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Testbarkeit sichert die Qualität der datenverwaltenden Handelssoftware ab. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Tests decken die typischen Handelsabläufe (Kunde, Bestellung, Auswertung) ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Testmanagement, Sicherheits-Code-Review und nachvollziehbare
Evidenz. Passende Checklisten: `CL_08` (Sicherheits-Code-Review), `CL_09` (Testmanagement) und `CL_10`
(Kompetenz-/Qualitätsnachweis). Die Sicherheitsentscheidung dieser Einheit lautet: *Jede sicherheitsrelevante
Regel hat mindestens einen Negativtest, parametrisierter Zugriff und referentielle Integrität sind geprüft, und
offene Lücken werden ehrlich dokumentiert.* A11Y-Aspekt: Testberichte sind textbasiert und ohne reine
Farbsignale (nicht nur „grün/rot"), damit Ergebnisse mit Screenreader und Braille-Zeile verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: test management, security code review, and traceable
evidence. Matching checklists: `CL_08` (security code review), `CL_09` (test management), and `CL_10`
(competence/quality evidence). The security decision of this unit is: *every security-relevant rule has at
least one negative test, parameterized access and referential integrity are checked, and open gaps are
documented honestly.* Accessibility aspect: test reports are text-based and without color-only signals (not
just "green/red"), so results remain understandable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum reicht es nicht, nur Erfolgspfade zu testen? /
   **EN:** Why is it not enough to test only success paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sicherheitslücken zeigen sich meist im Fehlerfall. Nur Negativtests beweisen, dass ungültige oder
   manipulierte Bestell- und Kundeneingaben wirklich abgelehnt werden.
   **EN:** Security holes usually show up in the error case. Only negative tests prove that invalid or
   manipulated order and customer input is really rejected.

   </details>

2. **DE:** (AE) Welcher Fehlerfall der Bestellverarbeitung muss unbedingt automatisiert getestet werden? /
   **EN:** (AE) Which order-processing error case must absolutely be tested automatically?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jeder sicherheitsrelevante Fall, z. B. negative Menge, überhöhter Rabatt oder ein
   SQL-Injektionsversuch in einem Eingabefeld. Diese Fälle sind das Kernrisiko und dürfen nicht nur manuell
   geprüft werden.
   **EN:** Every security-relevant case, e.g. negative quantity, excessive discount, or a SQL injection attempt
   in an input field. These cases are the core risk and must not be checked only manually.

   </details>

3. **DE:** (SI) Wie wird ein Testlauf gegen die relationale Ablage in Sandbox oder CI reproduzierbar? /
   **EN:** (SI) How is a test run against the relational store reproducible in the sandbox or CI?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Durch dokumentierte Testkommandos je Sprache und feste, fiktive Testdaten (Northwind inkl. `ALFKI`).
   So liefert derselbe Lauf auf einem anderen Rechner dasselbe Ergebnis.
   **EN:** Through documented test commands per language and fixed, fictitious test data (Northwind incl.
   `ALFKI`). The same run then yields the same result on another machine.

   </details>

4. **DE:** (DPA) Welche Kunden- und Bestelltestdaten sind realistisch, aber datenschutzfreundlich? /
   **EN:** (DPA) Which customer and order test data is realistic but privacy-friendly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Fiktive, wiederholbare Daten im Northwind-Layout, die die Struktur echter Bestellungen nachbilden,
   aber keine echten Namen, Anschriften oder Secrets enthalten.
   **EN:** Fictitious, repeatable data in Northwind layout that mirrors the structure of real orders but
   contains no real names, addresses, or secrets.

   </details>

5. **DE:** (DV) Warum braucht die Systemgrenze zwischen Bestelleingabe und Datenbank einen eigenen Negativtest? /
   **EN:** (DV) Why does the system boundary between order input and database need its own negative test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** An dieser Grenze wechseln Daten die Vertrauenszone. Ein Negativtest zeigt, dass die Plattform
   fehlerhafte oder manipulierte Eingaben ablehnt und über parametrisierte Zugriffe kein fremdes SQL ausführt.
   **EN:** At this boundary data crosses the trust zone. A negative test shows that the platform rejects faulty
   or manipulated input and, via parameterized access, does not run foreign SQL.

   </details>

6. **DE:** Warum braucht eine relationale Plattform zusätzlich Tests für parametrisierten Zugriff und
   referentielle Integrität? / **EN:** Why does a relational platform additionally need tests for parameterized
   access and referential integrity?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Parametrisierter Zugriff beweist den Schutz vor SQL-Injection; referentielle Integrität beweist, dass
   Fremdschlüssel (z. B. Bestellung -> Kunde) gültig bleiben. Beide Fragen hat eine reine Rechenfunktion nicht.
   **EN:** Parameterized access proves protection against SQL injection; referential integrity proves that
   foreign keys (e.g. order -> customer) stay valid. A pure compute function does not have these questions.

   </details>

7. **DE:** Warum werden offene Testlücken dokumentiert statt verschwiegen? /
   **EN:** Why are open test gaps documented rather than hidden?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Versteckte Lücken täuschen falsche Sicherheit vor. Offene, begründete Lücken lassen sich planen,
   priorisieren und später schließen.
   **EN:** Hidden gaps fake a false sense of security. Open, justified gaps can be planned, prioritized, and
   closed later.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] fachliche Tests, Sicherheitstests, Datenschutztests und datenbankspezifische Tests getrennt planen.
- [ ] für jede sicherheitsrelevante Regel mindestens einen Negativtest angeben, inkl. SQL-Injektionsschutz.
- [ ] parametrisierten Datenzugriff und referentielle Integrität durch je einen Test abdecken.
- [ ] fiktive, datenschutzfreundliche Testdaten im Northwind-Layout (inkl. `ALFKI`) wählen.
- [ ] offene Testlücken als `Open` oder `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] plan functional, security, privacy, and database-specific tests separately.
- [ ] give at least one negative test for each security-relevant rule, incl. SQL injection protection.
- [ ] cover parameterized data access and referential integrity with one test each.
- [ ] choose fictitious, privacy-friendly test data in Northwind layout (incl. `ALFKI`).
- [ ] document open test gaps as `Open` or `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_07_Testbarkeit-und-Qualitaet.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_07_Testbarkeit-und-Qualitaet.md`. The copy-paste prompt for a later, manually
started Spec Kit run is provided there.
