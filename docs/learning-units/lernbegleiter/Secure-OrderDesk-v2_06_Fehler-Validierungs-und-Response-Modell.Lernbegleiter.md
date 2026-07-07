# Lernbegleiter: Secure OrderDesk v2 06 – Fehler-, Validierungs- und Response-Modell / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_06_Fehler-Validierungs-und-Response-Modell.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure OrderDesk bekommt Daten aus zwei Richtungen: Die **Bestellannahme** nimmt Bestellungen,
Kunden- und Positionsdaten auf, und der **Service-Vertrag** beantwortet Anfragen (z. B. „Bestellungen von
`ALFKI`"). Beide Wege können Ungültiges liefern. In dieser Einheit baust du ein einziges, durchdachtes
**Fehler- und Response-Modell**, das an beiden Stellen gleich funktioniert. Es trennt sauber zwischen
**Validierungsregeln** (ist die Eingabe erlaubt?), **fachlichen Fehlern** (eine Geschäftsregel ist verletzt,
z. B. „ein unbekannter Kunde kann keine Bestellung anlegen" oder „Menge muss größer als null sein") und
**technischen Fehlern** (etwas Unerwartetes, z. B. die Datenbank ist nicht erreichbar). Zu jeder Fehlerart
gehört eine passende, **sichere Rückmeldung**.

**EN:** The Secure OrderDesk receives data from two directions: **order intake** accepts orders, customer, and
line data, and the **service contract** answers requests (e.g. "orders of `ALFKI`"). Both paths can deliver
invalid data. In this unit you build a single, well-considered **error and response model** that behaves the
same in both places. It separates cleanly between **validation rules** (is the input allowed?), **business
errors** (a business rule is violated, e.g. "an unknown customer cannot place an order" or "quantity must be
greater than zero"), and **technical errors** (something unexpected, e.g. the database is unreachable). Each
error kind gets a matching **safe response**.

**DE:** Weil die Rückmeldung nach außen geht, darf sie weder interne Details (SQL-Text, Stack-Trace,
Tabellennamen) noch personenbezogene Kundendaten preisgeben. Du legst deshalb eine **Fehlertabelle** an,
planst **Negativtests** und definierst **Logging-Grenzen**, damit Fehler nachvollziehbar bleiben, ohne Interna
oder Kundendaten zu protokollieren. `ALFKI` dient als fester, fiktiver Beispiel- und Testanker.

**EN:** Because the response goes outward, it must reveal neither internal details (SQL text, stack trace,
table names) nor personal customer data. You therefore create an **error table**, plan **negative tests**, and
define **logging limits**, so that errors stay traceable without logging internals or customer data. `ALFKI`
serves as a fixed, fictional example and test anchor.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Validierung / Validation | Prüfung, ob eine Eingabe (Kunde, Produkt, Menge) erlaubt, sinnvoll und sicher ist. |
| Fachlicher Fehler / Business error | Verletzung einer Geschäftsregel trotz technisch gültiger Eingabe. |
| Technischer Fehler / Technical error | Unerwarteter Fehler im System, z. B. nicht erreichbare Datenbank. |
| Sichere Meldung / Safe message | Rückmeldung, die den Grund nennt, aber keine Interna und keine Kundendaten preisgibt. |
| Gemeinsamer Vertrag / Shared contract | Ein Fehler- und Response-Modell, das für Bestellannahme und Service-Vertrag gleich gilt. |
| Negativtest / Negative test | Test, der prüft, dass ungültige Eingaben korrekt abgelehnt werden. |
| Fail-safe / Fail-safe | Grundsatz: im Fehlerfall in den sicheren Zustand fallen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ebenen trennen.** Ordne jeden möglichen Fehler einer Ebene zu: Validierung (Format,
Allowlist, Länge), fachlicher Fehler (Regelverstoß), technischer Fehler (unerwartet). **Warum wichtig:** Nur
getrennte Ebenen erlauben passende Reaktionen. Eine fehlende Kundennummer ist Schuld der Eingabe; eine nicht
erreichbare Datenbank ist Schuld des Systems – die Rückmeldung ist jeweils anders.

**EN:** **Step 1 – Separate the levels.** Assign every possible error to a level: validation (format,
allow-list, length), business error (rule violation), technical error (unexpected). **Why it matters:** only
separate levels allow matching reactions. A missing customer ID is the input's fault; an unreachable database
is the system's fault – the response differs in each case.

**DE:** **Schritt 2 – Einen gemeinsamen Vertrag definieren.** Bestellannahme und Service-Vertrag sollen
dieselbe Fehlerlogik nutzen. **Warum wichtig:** Zwei getrennte Modelle driften auseinander; ein gemeinsamer
Vertrag hält das Verhalten vorhersehbar und macht Prüfung und Wartung einfacher.

**EN:** **Step 2 – Define a shared contract.** Order intake and service contract should use the same error
logic. **Why it matters:** two separate models drift apart; a shared contract keeps behaviour predictable and
makes review and maintenance easier.

**DE:** **Schritt 3 – Fehlertabelle aufstellen.** Schreibe je Fehler: Auslöser, Ebene, Statuscode/Signal,
sichere Meldung, ob protokolliert wird. **Warum wichtig:** Die Tabelle macht das Verhalten vollständig und
prüfbar. Was nicht in der Tabelle steht, wird leicht vergessen.

**EN:** **Step 3 – Build the error table.** Write per error: trigger, level, status code/signal, safe message,
whether it is logged. **Why it matters:** the table makes the behaviour complete and reviewable. What is not in
the table is easily forgotten.

**DE:** **Schritt 4 – Sichere Meldungen formulieren.** Die Meldung sagt *was* falsch war und *wie man es
korrigiert*, aber nie interne Details oder Kundendaten. „Kunde nicht bekannt" ist sicher; die volle Adresse
von Maria Anders in der Meldung wäre ein Datenschutzverstoß. **Warum wichtig:** Interna helfen Angreifern,
Kundendaten verletzen den Datenschutz. Fail-safe bedeutet: Bei Unsicherheit die Bestellung ablehnen und melden
statt riskant weiterzuschreiben.

**EN:** **Step 4 – Formulate safe messages.** The message says *what* was wrong and *how to correct it*, but
never internal details or customer data. "Customer not known" is safe; putting Maria Anders' full address into
the message would be a privacy violation. **Why it matters:** internals help attackers, customer data violates
privacy. Fail-safe means: when in doubt, reject the order and report rather than write on riskily.

**DE:** **Schritt 5 – Negativtests und Logging-Grenzen planen.** Zu jeder kritischen Regel gehört ein
Negativtest, der beweist, dass Ungültiges abgelehnt wird (z. B. Bestellung mit Menge 0 oder unbekanntem
Kunden). Beim Logging gilt: genug für die Fehlersuche, aber keine personenbezogenen Kundendaten und keine
ungefilterten Eingaben, die das Protokoll fälschen könnten (Log-Injection). **Warum wichtig:** Nur Erfolgspfade
zu testen zeigt nicht, ob der Schutz greift.

**EN:** **Step 5 – Plan negative tests and logging limits.** Every critical rule needs a negative test that
proves invalid input is rejected (e.g. an order with quantity 0 or an unknown customer). For logging: enough
for debugging, but no personal customer data and no unfiltered inputs that could forge the log (log injection).
**Why it matters:** testing only success paths does not show whether the protection works.

**DE:** **Typische Fehler.** Validierung und fachliche Regeln vermischen. Getrennte Fehlermodelle für
Bestellannahme und Service pflegen. Technische Fehler roh an Nutzende durchreichen. Nur Erfolgspfade testen.
Kundendaten oder Secrets ins Log schreiben. Bei einem fehlerhaften Feld die ganze Anfrage abstürzen lassen.

**EN:** **Common mistakes.** Mixing validation and business rules. Keeping separate error models for order
intake and service. Passing technical errors raw to users. Testing only success paths. Logging customer data or
secrets. Letting one faulty field crash the whole request.

### Beispiel / Example

```text
Fehlertabelle (Auszug, gilt fuer Bestellannahme und Service-Vertrag):

  Ausloeser                       Ebene        Signal  Sichere Meldung                          Log?
  Menge <= 0                      Validierung  400     "Menge muss groesser als 0 sein."        ja (ohne Wert)
  CustomerID unbekannt            fachlich     404     "Kunde nicht bekannt."                   ja (nur ID-Hash)
  Datenbank nicht erreichbar      technisch    503     "Vorgang derzeit nicht moeglich."        ja (Fehlercode)

NICHT so (unsichere technische Meldung):
  "SqlException: SELECT * FROM Orders WHERE CustomerID='ALFKI' failed (host db-01)"  -> verraet Interna

Negativtest: Bestellung fuer ALFKI mit Quantity=0 -> erwarte Ablehnung 400, kein Schreiben
Logging-Grenze: kein Klartext-Kundenname/Adresse, keine ganze Eingabe, nur Ereignis + Code
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Das Fehler-, Validierungs- und Response-Modell steuert das Verhalten der datenverwaltenden Bestell-Software. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Sichere Fehlerbehandlung und Logging-Grenzen setzen den Schutzbedarf der Kunden- und Bestelldaten praktisch um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, sichere Fehlerbehandlung,
Fail-safe-Defaults und Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (sichere
Architektur), `CL_05` (Zugangssteuerung/Autorisierung – Fehler dürfen keine Rechte umgehen) und `CL_08`
(Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser Einheit lautet: *Bestellannahme und Service
teilen einen Fehler-Vertrag, im Fehlerfall fällt der Dienst in den sicheren Zustand und gibt weder Interna noch
Kundendaten preis.* A11Y-Aspekt: Fehlermeldungen müssen klar, textbasiert und ohne reine Farbsignale sein; ein
Fehler darf nicht nur durch ein rotes Feld, sondern muss durch verständlichen Text erkennbar sein, damit
Screenreader und Braille-Zeile ihn wiedergeben.

**EN:** Relation to the Secure Development Guideline: secure coding, safe error handling, fail-safe defaults,
and testability. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure architecture), `CL_05`
(access control / authorization – errors must not bypass rights), and `CL_08` (security code review). The
security decision of this unit is: *order intake and service share one error contract, on error the service
falls into the safe state and reveals neither internals nor customer data.* Accessibility aspect: error
messages must be clear, text-based, and free of color-only signals; an error must not be shown only by a red
field but by understandable text, so a screen reader and Braille display can convey it.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Worin unterscheiden sich Validierungsfehler, fachliche Fehler und technische Fehler? /
   **EN:** How do validation errors, business errors, and technical errors differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Validierungsfehler betreffen Format und Erlaubtheit der Eingabe, fachliche Fehler verletzen eine
   Geschäftsregel trotz gültiger Eingabe (z. B. unbekannter Kunde), technische Fehler sind unerwartete Probleme
   im System. Jede Ebene braucht eine eigene Reaktion.
   **EN:** Validation errors concern format and permissibility of the input, business errors violate a business
   rule despite valid input (e.g. unknown customer), technical errors are unexpected problems in the system.
   Each level needs its own reaction.

   </details>

2. **DE:** Warum sollen Bestellannahme und Service-Vertrag dasselbe Fehler- und Response-Modell nutzen? /
   **EN:** Why should order intake and the service contract use the same error and response model?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein gemeinsamer Vertrag verhindert, dass beide Wege auseinanderdriften und sich unterschiedlich
   verhalten. Das Verhalten bleibt vorhersehbar, und Prüfung sowie Wartung werden einfacher.
   **EN:** A shared contract prevents both paths from drifting apart and behaving differently. Behaviour stays
   predictable, and review and maintenance become easier.

   </details>

3. **DE:** Warum darf eine Fehlermeldung weder Interna noch Kundendaten enthalten? /
   **EN:** Why must an error message contain neither internals nor customer data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stack-Traces oder SQL-Text helfen Angreifern; Kundendaten wie Name oder Adresse verletzen den
   Datenschutz. Nach außen genügt eine sichere Meldung; Details gehören nur ins interne, geschützte Log.
   **EN:** Stack traces or SQL text help attackers; customer data such as name or address violate privacy.
   Outward a safe message is enough; details belong only in the internal, protected log.

   </details>

4. **DE:** (AE) Warum gehört zu jeder kritischen Regel ein Negativtest? /
   **EN:** (AE) Why does every critical rule need a negative test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Negativtest beweist, dass Ungültiges wirklich abgelehnt wird, z. B. eine Bestellung mit Menge 0
   für `ALFKI`. Nur Erfolgspfade zu testen zeigt nicht, ob der Schutz greift.
   **EN:** A negative test proves that invalid input is really rejected, e.g. an order with quantity 0 for
   `ALFKI`. Testing only success paths does not show whether the protection works.

   </details>

5. **DE:** Was bedeutet Fail-safe bei der Bestellannahme? /
   **EN:** What does fail-safe mean in order intake?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei einer fehlerhaften Bestellung fällt der Dienst in den sicheren Zustand: die Bestellung ablehnen
   und melden, statt riskant unvollständige Daten zu schreiben. So bleiben die Bestelldaten konsistent.
   **EN:** On a faulty order the service falls into the safe state: reject the order and report rather than
   riskily write incomplete data. This keeps the order data consistent.

   </details>

6. **DE:** (DPA) Wie beeinflusst schlechte Fehlerbehandlung die Datenqualität der Bestelldaten? /
   **EN:** (DPA) How does poor error handling affect the data quality of the order data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Werden ungültige Bestellungen nicht abgelehnt, gelangen falsche Mengen, Preise oder Kundenbezüge in
   die Datenbank und verfälschen Umsatz- und Betriebsauswertungen. Saubere Ablehnung sichert die Datenqualität.
   **EN:** If invalid orders are not rejected, wrong quantities, prices, or customer references enter the
   database and distort revenue and operational analyses. Clean rejection secures data quality.

   </details>

7. **DE:** Welche Logging-Grenze schützt Datenschutz und verhindert Log-Injection? /
   **EN:** Which logging limit protects privacy and prevents log injection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine personenbezogenen Kundendaten und keine ungefilterten Eingaben ins Log. Nur Ereignis und
   Fehlercode; Freitext begrenzen und bereinigen, damit niemand das Protokoll fälscht.
   **EN:** No personal customer data and no unfiltered inputs in the log. Only event and error code; limit and
   sanitize free text so no one forges the log.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. So bleibt sichtbar, dass
   der Standard geprüft und bewusst als nicht anwendbar eingestuft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. This keeps visible that the
   standard was checked and deliberately classified as not applicable.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Validierungs-, fachliche und technische Fehler klar unterscheiden.
- [ ] ein gemeinsames Fehlermodell für Bestellannahme und Service-Vertrag begründen.
- [ ] eine Fehlertabelle mit Auslöser, Ebene, Signal, Meldung und Log-Entscheidung aufstellen.
- [ ] eine sichere von einer unsicheren Fehlermeldung unterscheiden (keine Interna, keine Kundendaten).
- [ ] zu jeder kritischen Regel einen Negativtest angeben.
- [ ] Logging-Grenzen für Datenschutz und gegen Log-Injection begründen.

**EN:** I can …

- [ ] clearly distinguish validation, business, and technical errors.
- [ ] justify a shared error model for order intake and the service contract.
- [ ] build an error table with trigger, level, signal, message, and log decision.
- [ ] tell a safe error message from an unsafe one (no internals, no customer data).
- [ ] give a negative test for each critical rule.
- [ ] justify logging limits for privacy and against log injection.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-v2_06_Fehler-Validierungs-und-Response-Modell.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-v2_06_Fehler-Validierungs-und-Response-Modell.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
