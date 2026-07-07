# Lernbegleiter: Secure OrderDesk v2 05 – API- und Service-Vertrag und OpenAPI / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_05_API-und-Service-Vertrag-und-OpenAPI.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Andere Programme sprechen mit dem Secure OrderDesk über seine **API**. Damit dieser Zugang nachvollziehbar und prüfbar ist, beschreibst du ihn als **Vertrag**: Welche **Operationen** gibt es (Bestellung anlegen, Bestellungen eines Kunden lesen, Produkte einer Kategorie lesen, Umsatz je Zeitraum), welche **Eingaben** und **Ausgaben** haben sie, wie werden Eingaben **validiert**, und was passiert im **Fehlerfall**? Diesen Vertrag hältst du zusätzlich maschinenlesbar als **OpenAPI/Swagger** fest. So wissen Aufrufer genau, was erlaubt ist, ohne den Code zu kennen.

**EN:** Other programs talk to the Secure OrderDesk through its **API**. To make this access traceable and verifiable, you describe it as a **contract**: which **operations** exist (create order, read a customer's orders, read products of a category, revenue per period), what **inputs** and **outputs** they have, how inputs are **validated**, and what happens on **error**. You additionally record this contract machine-readably as **OpenAPI/Swagger**. This way callers know exactly what is allowed without knowing the code.

**DE:** Ein besonderer Punkt ist die **sichere Fehlerbehandlung**: Eine Fehlermeldung an den Aufrufer darf **niemals** interne Details verraten – kein Stack-Trace, kein Pfad, kein SQL-Text, keine Verbindungszeichenkette. Kundenbezogene Antworten (z. B. für `ALFKI`) folgen der **Datenminimierung**.

**EN:** A special point is **safe error handling**: an error message to the caller must **never** reveal internal details – no stack trace, no path, no SQL text, no connection string. Customer-related responses (e.g. for `ALFKI`) follow **data minimization**.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Service-Vertrag / Service contract | Verbindliche Beschreibung von Operationen, Eingaben, Ausgaben und Fehlern. |
| API-Operation / API operation | Eine einzelne aufrufbare Funktion der Schnittstelle. |
| OpenAPI / Swagger | Maschinenlesbares Format zur Beschreibung einer HTTP-API. |
| Validierung / Validation | Prüfen von Eingaben gegen erlaubte Werte an der Vertrauensgrenze. |
| Fehlervertrag / Error contract | Vereinbarte, sichere Fehlerantworten ohne interne Details. |
| Statuscode / Status code | Standardisierte Antwortkennung (z. B. 200, 400, 404, 500). |
| Datenminimierung / Data minimization | Nur die wirklich nötigen (Kunden-)Felder in der Antwort. |
| ASVS / ASVS | OWASP-Verifikationsstandard für Web-/API-Sicherheit (Level nennen). |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Operationen benennen.** Liste die wenigen klaren Operationen: `Bestellung anlegen`, `Bestellungen eines Kunden lesen`, `Produkte einer Kategorie lesen`, `Umsatz je Zeitraum`. **Warum wichtig:** Eine kleine, klare Operationsmenge ist leichter abzusichern als viele unklare Endpunkte (Angriffsfläche reduzieren).

**EN:** **Step 1 – Name the operations.** List the few clear operations: `create order`, `read a customer's orders`, `read products of a category`, `revenue per period`. **Why it matters:** a small, clear set of operations is easier to secure than many unclear endpoints (reduce attack surface).

**DE:** **Schritt 2 – Eingaben und Ausgaben festlegen.** Beschreibe je Operation genau, welche Felder hineingehen (z. B. `CustomerID`, `ProductID`, `Quantity`, Zeitraum) und was herauskommt (z. B. Bestell-ID, Positionsliste, Summe). **Warum wichtig:** Klare Ein-/Ausgaben erlauben Validierung und Tests und verhindern, dass zu viel zurückgegeben wird.

**EN:** **Step 2 – Define inputs and outputs.** Describe per operation exactly which fields go in (e.g. `CustomerID`, `ProductID`, `Quantity`, period) and what comes out (e.g. order ID, line list, total). **Why it matters:** clear inputs/outputs allow validation and tests and prevent returning too much.

**DE:** **Schritt 3 – Eingaben validieren.** An der API-Grenze gilt jede Eingabe als nicht vertrauenswürdig: Pflichtfelder da? `CustomerID`/`ProductID` bekannt? Menge positiv? Zeitraum plausibel? Ungültige Eingaben führen zu einer klaren Ablehnung (z. B. Statuscode 400), nicht zu einem Absturz. **Warum wichtig:** Validierung an der Grenze ist die erste Verteidigungslinie und schützt auch die Datenbank dahinter.

**EN:** **Step 3 – Validate inputs.** At the API boundary every input is untrusted: mandatory fields present? `CustomerID`/`ProductID` known? Quantity positive? Period plausible? Invalid input leads to a clear rejection (e.g. status code 400), not a crash. **Why it matters:** validation at the boundary is the first line of defense and also protects the database behind it.

**DE:** **Schritt 4 – Sicheren Fehlervertrag definieren.** Lege fest, welche Statuscodes und Meldungen der Aufrufer bekommt (z. B. 400 „ungültige Eingabe", 404 „nicht gefunden", 500 „interner Fehler"). Die Meldung bleibt neutral; Details wandern nur ins interne Log (ohne Secrets). **Warum wichtig:** Verräterische Fehler (Stack-Trace, SQL-Text) helfen Angreifern und leaken interne Struktur.

**EN:** **Step 4 – Define a safe error contract.** Define which status codes and messages the caller receives (e.g. 400 "invalid input", 404 "not found", 500 "internal error"). The message stays neutral; details go only into the internal log (without secrets). **Why it matters:** telling errors (stack trace, SQL text) help attackers and leak internal structure.

**DE:** **Schritt 5 – Vertrag als OpenAPI/Swagger skizzieren.** Beschreibe die Operationen maschinenlesbar: Pfade, Methoden, Parameter, Antwortschemata, Statuscodes. Ein `ALFKI`-Beispiel macht den Vertrag greifbar. **Warum wichtig:** Eine OpenAPI-Beschreibung ist ein prüfbarer, sprachneutraler Nachweis, den alle sechs Sprachpfade teilen.

**EN:** **Step 5 – Sketch the contract as OpenAPI/Swagger.** Describe the operations machine-readably: paths, methods, parameters, response schemas, status codes. An `ALFKI` example makes the contract tangible. **Why it matters:** an OpenAPI description is a verifiable, language-neutral piece of evidence shared by all six language paths.

**DE:** **Typische Fehler.** Viele unklare Endpunkte statt weniger klarer Operationen. Eingaben nicht validieren und auf die Datenbank vertrauen. Interne Fehlerdetails an den Aufrufer geben. Zu viele Kundenfelder zurückliefern. Den ASVS-Level nicht benennen (oder N/A ohne Begründung lassen).

**EN:** **Common mistakes.** Many unclear endpoints instead of few clear operations. Not validating input and trusting the database. Returning internal error details to the caller. Returning too many customer fields. Not naming the ASVS level (or leaving N/A without rationale).

### Beispiel / Example

```text
API-Vertrag (Auszug):

  POST /orders                      -> Bestellung anlegen
    Eingabe:  { customerId, lines:[{ productId, quantity, discount }], idempotencyKey }
    Ausgabe:  201 { orderId }
    Fehler:   400 ungueltige Eingabe | 409 bereits vorhanden (Idempotenz)

  GET /customers/{id}/orders        -> Bestellungen eines Kunden lesen
    Beispiel: GET /customers/ALFKI/orders
    Ausgabe:  200 [ { orderId, orderDate, freight } ]   (datensparsam)
    Fehler:   404 Kunde nicht gefunden

  GET /categories/{id}/products     -> Produkte einer Kategorie lesen
  GET /revenue?from=...&to=...      -> Umsatz je Zeitraum

Sicherer Fehlervertrag (an den Aufrufer):
  400 { "error": "invalid input" }        (KEIN Stack-Trace)
  404 { "error": "not found" }            (KEIN SQL-Text, KEIN Pfad)
  500 { "error": "internal error" }       Details nur im internen Log (ohne Secrets)

OpenAPI/Swagger: Pfade + Methoden + Parameter + Antwortschema + Statuscodes maschinenlesbar
ASVS: Level 1 als Startziel benennen; nicht zutreffende Anforderungen als N/A mit Begruendung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 8 Daten systemübergreifend bereitstellen | Primär / Primary | Der API- und Service-Vertrag stellt Bestell- und Katalogdaten systemübergreifend bereit. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Jede API-Operation ist eine Serviceanfrage mit Eingabe, Ausgabe und Fehlerfall. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, sichere Architektur, Testbarkeit und Datenschutz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (sichere Architektur/API-Grenze), `CL_05` (Eingabevalidierung/Fehlerbehandlung), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise/N/A-Begründung). Da es sich um eine API handelt, ist `OWASP ASVS` anwendbar – benenne den Level (z. B. Level 1 als Start) und den Verifikationsumfang. Die Sicherheitsentscheidung dieser Einheit lautet: *Jede Eingabe wird an der API-Grenze validiert, und kein Fehler verrät interne Details.* A11Y-Aspekt: Beschreibe Operationen, Statuscodes und Fehlermeldungen als Text-Tabelle; nutze klare Statuswörter statt farbiger Symbole, damit Screenreader und Braille-Zeile den Vertrag erfassen.

**EN:** Relation to the Secure Development Guideline: secure programming, secure architecture, testability, and privacy. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure architecture/API boundary), `CL_05` (input validation/error handling), `CL_08` (security code review), and `CL_12` (evidence / N/A rationale). As this is an API, `OWASP ASVS` applies – name the level (e.g. Level 1 as a start) and the verification scope. The security decision of this unit is: *every input is validated at the API boundary, and no error reveals internal details.* Accessibility aspect: describe operations, status codes, and error messages as a text table; use clear status words instead of colored symbols so a screen reader and Braille display can grasp the contract.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum beschreibt man die API als Vertrag statt nur zu programmieren? /
   **EN:** Why describe the API as a contract instead of just coding it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Vertrag legt Operationen, Eingaben, Ausgaben und Fehler verbindlich fest. Aufrufer wissen, was erlaubt ist, ohne den Code zu kennen; der Vertrag ist prüfbar und für alle sechs Sprachen gleich.
   **EN:** A contract fixes operations, inputs, outputs, and errors bindingly. Callers know what is allowed without knowing the code; the contract is verifiable and the same for all six languages.

   </details>

2. **DE:** Warum darf ein Fehler keinen Stack-Trace oder SQL-Text an den Aufrufer geben? /
   **EN:** Why must an error not give a stack trace or SQL text to the caller?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Solche Details verraten interne Struktur und helfen Angreifern. Der Aufrufer bekommt nur eine neutrale Meldung mit Statuscode; Details bleiben im internen Log ohne Secrets.
   **EN:** Such details reveal internal structure and help attackers. The caller only gets a neutral message with a status code; details stay in the internal log without secrets.

   </details>

3. **DE:** (AE) Warum validiert man Eingaben an der API-Grenze und nicht erst in der Datenbank? /
   **EN:** (AE) Why validate inputs at the API boundary and not only in the database?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die API-Grenze ist die erste Vertrauensgrenze. Frühe Validierung lehnt ungültige Eingaben klar ab (z. B. 400), schützt die Datenbank dahinter und vermeidet Abstürze und Datenmüll.
   **EN:** The API boundary is the first trust boundary. Early validation clearly rejects invalid input (e.g. 400), protects the database behind it, and avoids crashes and garbage data.

   </details>

4. **DE:** (SI) Wofür ist eine OpenAPI/Swagger-Beschreibung im Betrieb nützlich? /
   **EN:** (SI) What is an OpenAPI/Swagger description useful for in operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie ist maschinenlesbar und dient als prüfbarer Nachweis, für Client-Generierung, Tests und Dokumentation. Betrieb und Integration wissen genau, welche Operationen und Statuscodes es gibt.
   **EN:** It is machine-readable and serves as verifiable evidence, for client generation, tests, and documentation. Operations and integration know exactly which operations and status codes exist.

   </details>

5. **DE:** (DPA) Was bedeutet Datenminimierung in einer API-Antwort für `ALFKI`? /
   **EN:** (DPA) What does data minimization mean in an API response for `ALFKI`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Antwort enthält nur die wirklich nötigen Kundenfelder (z. B. Bestell-ID, Datum, Fracht), keine überflüssigen personenbezogenen Daten. Weniger zurückgegebene Daten bedeuten weniger Risiko.
   **EN:** The response contains only the truly needed customer fields (e.g. order ID, date, freight), no superfluous personal data. Less returned data means less risk.

   </details>

6. **DE:** (DV) Warum ist die Netzwerkgrenze der API besonders schützenswert? /
   **EN:** (DV) Why is the API's network boundary especially worth protecting?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Dort betritt externer Verkehr das System. Validierung, klare Statuscodes und ein sicherer Fehlervertrag verhindern, dass Angriffe oder Datenabfluss über die Netzwerkgrenze gelingen.
   **EN:** External traffic enters the system there. Validation, clear status codes, and a safe error contract prevent attacks or data leakage from succeeding across the network boundary.

   </details>

7. **DE:** Warum benennt man den ASVS-Level explizit? /
   **EN:** Why name the ASVS level explicitly?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** ASVS ist für Web-/API-Dienste anwendbar. Ein benannter Level (z. B. Level 1) macht den Verifikationsumfang klar und prüfbar; nicht zutreffende Anforderungen werden als N/A mit Begründung dokumentiert.
   **EN:** ASVS applies to web/API services. A named level (e.g. Level 1) makes the verification scope clear and verifiable; non-applicable requirements are documented as N/A with a rationale.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die wenigen klaren API-Operationen des OrderDesk benennen.
- [ ] Eingaben und Ausgaben je Operation beschreiben und an der Grenze validieren.
- [ ] einen sicheren Fehlervertrag mit Statuscodes ohne interne Details definieren.
- [ ] den Vertrag als OpenAPI/Swagger mit `ALFKI`-Beispiel skizzieren.
- [ ] den anwendbaren ASVS-Level benennen und N/A-Punkte begründen.

**EN:** I can …

- [ ] name the few clear API operations of the OrderDesk.
- [ ] describe inputs and outputs per operation and validate them at the boundary.
- [ ] define a safe error contract with status codes and no internal details.
- [ ] sketch the contract as OpenAPI/Swagger with an `ALFKI` example.
- [ ] name the applicable ASVS level and justify N/A points.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-v2_05_API-und-Service-Vertrag-und-OpenAPI.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-v2_05_API-und-Service-Vertrag-und-OpenAPI.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
