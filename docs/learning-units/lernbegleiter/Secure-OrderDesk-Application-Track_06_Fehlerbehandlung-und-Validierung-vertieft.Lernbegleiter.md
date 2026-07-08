# Lernbegleiter: Secure OrderDesk Application Track 06 – Fehlerbehandlung und Validierung vertieft / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Application-Track_06_Fehlerbehandlung-und-Validierung-vertieft.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** In den früheren Einheiten hat die Bestell-/Handelsplattform für Secure Trader bereits Eingaben geprüft.
Jetzt, im 3. Lehrjahr, vertiefst du dieses Thema auf der Northwind-Bestelldomäne (Kunden, Produkte, Bestellungen,
Bestellpositionen inkl. `ALFKI`): Nicht jeder Fehler ist gleich. Ein **Validierungsfehler** entsteht, wenn eine
Eingabe die Regeln verletzt (z. B. eine Bestellmenge ist negativ). Ein **Fachfehler** entsteht, wenn eine Eingabe
formal gültig ist, aber gegen eine Geschäftsregel verstößt (z. B. eine Bestellung für eine unbekannte Kundennummer).
Ein **technischer Fehler** entsteht, wenn etwas im System selbst versagt (z. B. die Datenbank ist nicht
erreichbar). Diese drei Fehlerarten brauchen unterschiedliche Antworten.

**EN:** In earlier units, the ordering/trading platform for Secure Trader already checked inputs. Now, in the
third year, you deepen this topic on the Northwind ordering domain (customers, products, orders, order lines
including `ALFKI`): not every error is the same. A **validation error** occurs when an input breaks the rules
(e.g. an order quantity is negative). A **domain error** occurs when an input is formally valid but violates a
business rule (e.g. an order for an unknown customer id). A **technical error** occurs when something fails in
the system itself (e.g. the database is unreachable). These three error types need different responses.

**DE:** Du lernst, ein **einheitliches Fehler-Response-Modell** mit stabilen Fehlercodes zu entwerfen, an jeder
Vertrauensgrenze zu validieren (API-Eingabe, Import, Konfiguration, SQL-Parameter) und jede Fehlerantwort so zu
gestalten, dass sie dem Endnutzer hilft, aber keine internen Details – auch kein SQL-Fragment und keine
Verbindungszeichenkette – verrät. Alle Daten bleiben fiktiv; der Entwurf bleibt sprachneutral.

**EN:** You learn to design a **uniform error response model** with stable error codes, to validate at every
trust boundary (API input, import, configuration, SQL parameters), and to shape each error response so it helps
the end user without leaking internal details – not even an SQL fragment or a connection string. All data stays
fictitious; the design stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Validierungsfehler / Validation error | Eine Eingabe verletzt eine formale Regel (Format, Pflichtfeld, Wertebereich). |
| Fachfehler / Domain error | Eine formal gültige Eingabe verstößt gegen eine Geschäftsregel der Bestelldomäne. |
| Technischer Fehler / Technical error | Ein interner Fehler wie Netzwerk, Speicher oder Datenbank versagt. |
| Fehlercode / Error code | Ein stabiler, dokumentierter Bezeichner für eine bestimmte Fehlerklasse. |
| Parametrisiertes SQL / Parameterized SQL | Datenzugriff, bei dem Eingaben als Parameter übergeben, nie in den SQL-Text eingebaut werden. |
| Fail-Safe-Default / Fail-safe default | Bei Unsicherheit fällt das System in einen sicheren, ablehnenden Zustand. |
| Vertrauensgrenze / Trust boundary | Stelle, an der Daten aus einer weniger vertrauenswürdigen Zone eintreffen. |
| Informationsabfluss / Information leak | Ungewollte Preisgabe interner Details (z. B. SQL, Stack-Trace) in einer Fehlermeldung. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Fehler klassifizieren.** Trenne zuerst Validierungs-, Fach- und technische Fehler. Warum?
Weil sie unterschiedlich behandelt werden: Ein Validierungsfehler ist die Schuld der Eingabe und wird sofort mit
klarer Meldung abgelehnt (z. B. negative Menge). Ein Fachfehler braucht eine fachliche Erklärung (z. B. Kunde
`ALFKI` existiert, aber die Produktnummer nicht). Ein technischer Fehler wird intern protokolliert und nach außen
nur allgemein gemeldet.

**EN:** **Step 1 – Classify errors.** First separate validation, domain, and technical errors. Why? Because they
are handled differently: a validation error is the input's fault and is rejected immediately with a clear message
(e.g. negative quantity). A domain error needs a functional explanation (e.g. customer `ALFKI` exists but the
product number does not). A technical error is logged internally and reported only generically to the outside.

**DE:** **Schritt 2 – Einheitliches Response-Modell festlegen.** Definiere ein festes Format für Fehlerantworten:
einen stabilen Fehlercode, eine kurze verständliche Meldung und optional ein Feld für den betroffenen Eingabeteil.
Stabile Fehlercodes sind wichtig, weil andere Systeme und Tests sich darauf verlassen – die Meldung darf sich
ändern, der Code nicht.

**EN:** **Step 2 – Define a uniform response model.** Define a fixed format for error responses: a stable error
code, a short understandable message, and optionally a field for the affected input part. Stable error codes
matter because other systems and tests rely on them – the message may change, the code must not.

**DE:** **Schritt 3 – An jeder Vertrauensgrenze validieren.** Prüfe Eingaben dort, wo sie das System betreten:
Bestell-API, Importe, Konfiguration, und besonders vor jedem Datenbankzugriff. Verlasse dich nicht darauf, dass
eine frühere Schicht schon geprüft hat (Defense in Depth). Ungültige Daten werden abgelehnt, bevor sie tiefer
wandern – und Eingaben gehen nur **parametrisiert** in SQL, nie als zusammengesetzter Text.

**EN:** **Step 3 – Validate at every trust boundary.** Check inputs where they enter the system: ordering API,
imports, configuration, and especially before every database access. Do not rely on an earlier layer having
checked already (defense in depth). Invalid data is rejected before it travels deeper – and inputs go into SQL
only **parameterized**, never as assembled text.

**DE:** **Schritt 4 – Keine internen Details preisgeben.** Eine Fehlermeldung an den Endnutzer darf keinen
Stack-Trace, kein SQL-Fragment, keine Verbindungszeichenkette und keinen internen Zustand enthalten. Die Diagnose
gehört ins interne Log mit einer Korrelations-ID, die Nutzermeldung bleibt allgemein. So hilft die Meldung, ohne
einem Angreifer nützliche Hinweise (etwa über Tabellennamen) zu geben.

**EN:** **Step 4 – Do not expose internal details.** An error message to the end user must not contain a stack
trace, an SQL fragment, a connection string, or internal state. The diagnosis belongs in the internal log with a
correlation ID; the user message stays generic. This way the message helps without giving an attacker useful
hints (such as table names).

**DE:** **Schritt 5 – Mit Negativtests nachweisen.** Für jede Fehlerklasse schreibst du mindestens einen
Negativtest: ungültige Eingabe → erwarteter Fehlercode; verletzte Geschäftsregel → erwarteter Fachfehler;
simulierter Datenbankausfall → allgemeine Meldung plus internes Log. Ein besonders wichtiger Negativtest ist der
**SQL-Injection-Test**: Eine bösartige Kundeneingabe wie `ALFKI' OR '1'='1` darf keine zusätzlichen Datensätze
liefern, weil der Zugriff parametrisiert ist.

**EN:** **Step 5 – Evidence with negative tests.** For each error class you write at least one negative test:
invalid input → expected error code; violated business rule → expected domain error; simulated database failure →
generic message plus internal log. A particularly important negative test is the **SQL injection test**: a
malicious customer input like `ALFKI' OR '1'='1` must not return extra records because the access is parameterized.

**DE:** **Typische Fehler.** Alle Fehler gleich behandeln. Fehlercodes ständig ändern, sodass Tests brechen. Nur
an einer Schicht validieren. SQL aus Eingaben zusammenbauen. Stack-Traces oder SQL an Endnutzer schicken. Nur
Erfolgsfälle testen. Nicht anwendbare Standards stillschweigend weglassen statt sie als `N/A` mit Begründung zu
dokumentieren.

**EN:** **Common mistakes.** Treating all errors the same. Constantly changing error codes so tests break.
Validating at only one layer. Assembling SQL from inputs. Sending stack traces or SQL to end users. Testing only
happy paths. Silently dropping non-applicable standards instead of documenting them as `N/A` with a justification.

### Beispiel / Example

```text
Fehlerklassen:
  VALIDATION  -> Eingabe verletzt Regel      -> HTTP 400 / Fehlercode OD-VAL-001
  DOMAIN      -> Geschäftsregel verletzt     -> HTTP 409 / Fehlercode OD-DOM-014
  TECHNICAL   -> interner Ausfall            -> HTTP 500 / Fehlercode OD-TEC-500

Antwort an Nutzer (VALIDATION):
  { "code": "OD-VAL-001", "message": "Bestellmenge muss groesser als 0 sein", "field": "quantity" }

Antwort an Nutzer (DOMAIN):
  { "code": "OD-DOM-014", "message": "Kundennummer unbekannt", "field": "customer_id" }

Antwort an Nutzer (TECHNICAL):
  { "code": "OD-TEC-500", "message": "Interner Fehler. Bitte spaeter erneut versuchen.", "ref": "corr-7c1b" }
  Internes Log:  corr-7c1b: Timeout beim Datenbank-Adapter (Detail nur intern, kein SQL an den Nutzer)

Negativtest 1: Menge = -3                       -> erwartet OD-VAL-001
Negativtest 2: Bestellung fuer unbekannten Kunden -> erwartet OD-DOM-014
Negativtest 3: Eingabe  ALFKI' OR '1'='1        -> parametrisiert, KEINE Extra-Datensaetze (SQL-Injection abgewehrt)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Fehlerbehandlung und Validierung sind Kernfunktionalität, die verlässlich und getestet realisiert wird. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Fehlermeldungen und Vertrauensgrenzen betreffen unmittelbar den Schutzbedarf der Kunden- und Bestelldaten. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Validierung vor parametrisierten SQL-Zugriffen betrifft die sichere Verwaltung der relationalen Daten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Fail-Safe-Defaults, Trust Boundaries, sichere Fehlerbehandlung
ohne Informationsabfluss, parametrisiertes SQL und auditfähige Negativtests. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_02` (Eingabevalidierung), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise
und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Fehler werden klassifiziert, Fehlerpfade
fallen sicher zurück, Zugriffe bleiben parametrisiert, und keine Nutzermeldung verrät interne Details.*
A11Y-Aspekt: Fehlermeldungen müssen als klarer Text verständlich sein und dürfen nicht allein über Farbe
signalisiert werden, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: fail-safe defaults, trust boundaries, secure error handling
without information leaks, parameterized SQL, and audit-ready negative tests. Matching checklists: `CL_01`
(standards applicability), `CL_02` (input validation), `CL_08` (security code review), and `CL_12` (evidence and
closure). The security decision of this unit is: *errors are classified, error paths fail safely, access stays
parameterized, and no user message leaks internal details.* Accessibility aspect: error messages must be
understandable as clear text and must not be signaled by color alone, so they remain usable with a screen reader
or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Worin unterscheiden sich Validierungs-, Fach- und technische Fehler? /
   **EN:** How do validation, domain, and technical errors differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Validierungsfehler verletzt eine formale Regel (z. B. negative Menge), ein Fachfehler eine
   Geschäftsregel bei formal gültiger Eingabe (z. B. unbekannte Kundennummer), ein technischer Fehler entsteht im
   System selbst. Sie brauchen unterschiedliche Antworten und unterschiedliche Nachweise.
   **EN:** A validation error breaks a formal rule (e.g. negative quantity), a domain error breaks a business rule
   with formally valid input (e.g. unknown customer id), and a technical error arises in the system itself. They
   need different responses and different evidence.

   </details>

2. **DE:** Warum müssen Fehlercodes stabil bleiben, auch wenn sich die Meldung ändert? /
   **EN:** Why must error codes stay stable even when the message changes?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Andere Systeme und Tests verlassen sich auf den Code. Ändert er sich, brechen Integrationen und
   Contract-Tests. Die Meldung ist für Menschen und darf sich verbessern, der Code ist der stabile Vertrag.
   **EN:** Other systems and tests rely on the code. If it changes, integrations and contract tests break. The
   message is for humans and may improve, the code is the stable contract.

   </details>

3. **DE:** Warum wird jede Kundeneingabe nur parametrisiert in SQL verwendet? /
   **EN:** Why is every customer input used only in a parameterized way in SQL?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Parametrisiertes SQL trennt Befehl und Daten. So kann eine Eingabe wie `ALFKI' OR '1'='1` nicht als
   Befehl wirken, sondern bleibt ein reiner Wert. Das verhindert SQL-Injection an der Vertrauensgrenze.
   **EN:** Parameterized SQL separates command and data. This way an input like `ALFKI' OR '1'='1` cannot act as a
   command but stays a plain value. That prevents SQL injection at the trust boundary.

   </details>

4. **DE:** Warum darf eine Fehlermeldung an Endnutzer keinen Stack-Trace oder kein SQL enthalten? /
   **EN:** Why must an end-user error message not contain a stack trace or SQL?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Stack-Trace oder SQL verrät interne Struktur, Tabellennamen und mögliche Schwachstellen. Das hilft
   Angreifern. Die Diagnose gehört ins interne Log mit Korrelations-ID, die Nutzermeldung bleibt allgemein.
   **EN:** A stack trace or SQL reveals internal structure, table names, and possible weaknesses. That helps
   attackers. The diagnosis belongs in the internal log with a correlation ID; the user message stays generic.

   </details>

5. **DE:** Was bedeutet Fail-Safe-Default im Fehlerpfad der Bestellplattform? /
   **EN:** What does a fail-safe default mean in the ordering platform's error path?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei Unsicherheit oder Fehler fällt das System in einen sicheren, ablehnenden Zustand statt eine
   Bestellung oder Daten durchzulassen. Sicherheit vor Bequemlichkeit: im Zweifel wird abgelehnt.
   **EN:** On uncertainty or error, the system falls into a safe, denying state instead of letting an order or data
   through. Security before convenience: when in doubt, deny.

   </details>

6. **DE:** (SI) Wie helfen Korrelations-IDs beim Datenbank-Betrieb und der Fehlersuche? /
   **EN:** (SI) How do correlation IDs help database operation and troubleshooting?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Korrelations-ID verbindet die allgemeine Nutzermeldung mit dem detaillierten internen Log-Eintrag.
   So kann der Betrieb den Fall nachvollziehen, ohne dem Nutzer interne Details oder SQL zu zeigen.
   **EN:** A correlation ID links the generic user message to the detailed internal log entry. This lets operations
   trace the case without showing internal details or SQL to the user.

   </details>

7. **DE:** (DPA) Welche Datenschutzgefahr steckt in ausführlichen Fehlermeldungen mit Kundendaten? /
   **EN:** (DPA) What privacy risk lies in verbose error messages with customer data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ausführliche Meldungen können versehentlich Kundenfelder oder personenbezogene Daten enthalten und
   diese über Logs oder Antworten verbreiten. Deshalb bleiben Nutzermeldungen datenarm und allgemein.
   **EN:** Verbose messages can accidentally contain customer fields or personal data and spread them via logs or
   responses. Therefore user messages stay data-minimal and generic.

   </details>

8. **DE:** Warum genügt ein Erfolgstest nicht, um Fehlerbehandlung nachzuweisen? /
   **EN:** Why is a success test not enough to evidence error handling?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Erfolgstest zeigt nur den guten Fall. Ob der Fehlerpfad wirklich greift, den richtigen Code liefert
   und keine Details preisgibt, beweist erst ein Negativtest pro Fehlerklasse – einschließlich SQL-Injection-Test.
   **EN:** A success test shows only the good case. Whether the error path really works, returns the correct code,
   and leaks no details is proven only by a negative test per error class – including the SQL injection test.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Validierungs-, Fach- und technische Fehler unterscheiden und benennen.
- [ ] ein einheitliches Fehler-Response-Modell mit stabilen Fehlercodes entwerfen.
- [ ] an jeder Vertrauensgrenze validieren und nur parametrisiert auf SQL zugreifen (Defense in Depth).
- [ ] Fehlermeldungen ohne interne Details (Stack-Trace, SQL) gestalten.
- [ ] pro Fehlerklasse mindestens einen Negativtest benennen, darunter einen SQL-Injection-Test.

**EN:** I can …

- [ ] distinguish and name validation, domain, and technical errors.
- [ ] design a uniform error response model with stable error codes.
- [ ] validate at every trust boundary and access SQL only parameterized (defense in depth).
- [ ] shape error messages without internal details (stack trace, SQL).
- [ ] name at least one negative test per error class, including an SQL injection test.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Application-Track_06_Fehlerbehandlung-und-Validierung-vertieft.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Application-Track_06_Fehlerbehandlung-und-Validierung-vertieft.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
