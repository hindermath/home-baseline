# Lernbegleiter: Secure OrderDesk Application Track 02 – API-Erweiterung und Ressourcenmodell / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Secure-OrderDesk-Plattform hat schon eine API. In dieser Einheit erweiterst du sie um Ressourcen für die Bestelldomäne: Kunden, Produkte, Bestellungen und Bestellpositionen im Northwind-Layout inkl. `ALFKI`. Eine gute API ist mehr als „ein paar neue Endpunkte": Sie hat ein sauberes **Ressourcenmodell**, sinnvolle Pfade und HTTP-Methoden, konsistente Statuscodes und bleibt **rückwärtskompatibel**, damit bestehende Clients nicht brechen. An der API-Grenze treffen fremde Eingaben auf dein System – deshalb ist sie zugleich eine Vertrauensgrenze.

**EN:** The Secure OrderDesk platform already has an API. In this unit you extend it with resources for the ordering domain: customers, products, orders, and order lines in Northwind layout incl. `ALFKI`. A good API is more than "a few new endpoints": it has a clean **resource model**, meaningful paths and HTTP methods, consistent status codes, and stays **backward compatible** so existing clients do not break. At the API boundary, foreign input meets your system – so it is also a trust boundary.

**DE:** Du lernst, Ressourcen und ihre Beziehungen (z. B. eine Bestellung mit ihren Positionen) als Vertrag zu entwerfen, passende Statuscodes zu wählen, Idempotenz lesender Aufrufe zu verstehen und eine Versionierungsstrategie mit Trade-off zu begründen.

**EN:** You learn to design resources and their relationships (e.g. an order with its lines) as a contract, choose suitable status codes, understand idempotency of read calls, and justify a versioning strategy with a trade-off.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Ressourcenmodell / Resource model | Struktur der API-Objekte (Kunde, Produkt, Bestellung, Position) und ihrer Beziehungen. |
| Endpunkt / Endpoint | Adressierbarer Pfad plus HTTP-Methode, z. B. `GET /orders/{id}`. |
| Statuscode / Status code | Standardisierte Antwortkennung (z. B. 200, 201, 400, 404), die das Ergebnis beschreibt. |
| Idempotenz / Idempotency | Eigenschaft, dass ein wiederholter Aufruf denselben Zustand ergibt wie ein einzelner. |
| Rückwärtskompatibilität / Backward compatibility | Alte Clients funktionieren nach der Erweiterung unverändert weiter. |
| Versionierung / Versioning | Bewusste Verwaltung von Vertragsänderungen (z. B. `/v1`, `/v2`). |
| Vertrauensgrenze / Trust boundary | Punkt, an dem nicht vertrauenswürdige Eingaben validiert werden müssen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ressourcen benennen.** Modelliere die Kernobjekte als Ressourcen: `customers`, `products`, `orders`, und die Positionen als untergeordnete Ressource `orders/{id}/lines`. Halte die Master-Detail-Beziehung zwischen Bestellung und Position sichtbar.

**EN:** **Step 1 – Name resources.** Model the core objects as resources: `customers`, `products`, `orders`, and the lines as a sub-resource `orders/{id}/lines`. Keep the master-detail relationship between order and line visible.

**DE:** **Schritt 2 – Pfade und Methoden wählen.** Nutze klare Pfade und passende Methoden: `GET /orders/{id}` liest eine Bestellung, `GET /customers/{id}/orders` listet Bestellungen eines Kunden. Lesende Aufrufe (`GET`) sind idempotent und dürfen keine Daten ändern.

**EN:** **Step 2 – Choose paths and methods.** Use clear paths and suitable methods: `GET /orders/{id}` reads one order, `GET /customers/{id}/orders` lists a customer's orders. Read calls (`GET`) are idempotent and must not change data.

**DE:** **Schritt 3 – Statuscodes festlegen.** Ordne jedem Fall einen konsistenten Statuscode zu: 200 (gefunden), 404 (nicht gefunden, z. B. unbekannte `OrderID`), 400 (ungültige Eingabe). Eine Statuscode-Matrix macht das Verhalten prüfbar.

**EN:** **Step 3 – Define status codes.** Assign a consistent status code to each case: 200 (found), 404 (not found, e.g. unknown `OrderID`), 400 (invalid input). A status code matrix makes the behavior verifiable.

**DE:** **Schritt 4 – Eingaben an der Grenze validieren.** Behandle alle Parameter (IDs, Filter) als nicht vertrauenswürdig. Nachgelagerte Datenzugriffe bleiben parametrisiert; kein Feldname oder Wert wird per String-Verkettung in SQL gebaut. Fehlerantworten geben keine internen Details preis.

**EN:** **Step 4 – Validate input at the boundary.** Treat all parameters (IDs, filters) as untrusted. Downstream data access stays parameterized; no field name or value is built into SQL by string concatenation. Error responses reveal no internal details.

**DE:** **Schritt 5 – Rückwärtskompatibilität und Versionierung begründen.** Neue Felder sollten additiv sein; bestehende Felder nicht entfernen oder umdeuten. Entscheide mit Trade-off zwischen URI-Versionierung (`/v2`) und Header-Versionierung und dokumentiere die Wahl als ADR-Kandidat.

**EN:** **Step 5 – Justify backward compatibility and versioning.** New fields should be additive; do not remove or repurpose existing fields. Decide with a trade-off between URI versioning (`/v2`) and header versioning and document the choice as an ADR candidate.

**DE:** **Typische Fehler.** Verben in Pfade schreiben (`/getOrder`) statt Ressourcen. Statuscodes uneinheitlich vergeben. Breaking Changes ohne Versionierung. Interne Fehlerdetails in Antworten. Eingaben ungeprüft an die Persistenz weiterreichen.

**EN:** **Common mistakes.** Putting verbs in paths (`/getOrder`) instead of resources. Assigning status codes inconsistently. Breaking changes without versioning. Internal error details in responses. Passing input unchecked to persistence.

### Beispiel / Example

```text
Ressource       Methode  Pfad                          Erfolg  Fehler
Bestellung      GET      /orders/{id}                  200     404 (unbekannte OrderID)
Bestellpos.     GET      /orders/{id}/lines            200     404 (Bestellung fehlt)
Kundenauftraege GET      /customers/{id}/orders        200     404 (unbekannter Kunde)
Produkte        GET      /products?categoryId=1        200     400 (ungueltiger Filter)

Beispiel:  GET /customers/ALFKI/orders  -> 200, Liste der Bestellungen von Alfreds Futterkiste (fiktiv)
Regel:     neue Felder additiv; alte Felder bleiben -> Rueckwaertskompatibilitaet
Sicherheit: alle Parameter validiert; Persistenz parametrisiert; keine internen Details in 4xx/5xx
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"). Für die API-Erweiterung ist **LF 11a** primär, weil konkrete Funktionalität über Schnittstellen realisiert wird; LF 5 ist berührt, weil die Datenverwaltung der Bestelldomäne über die API sichtbar und anpassbar wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"). For the API extension **LF 11a** is primary, because concrete functionality is realized through interfaces; LF 5 is touched, because the data management of the ordering domain becomes visible and adaptable through the API.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Die API-Erweiterung realisiert Bestell-Funktionalität über einen sauberen Schnittstellenvertrag. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Das Ressourcenmodell bildet die relationale Bestelldatenverwaltung ab. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Eingabevalidierung und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (Eingabevalidierung), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit lautet: *Die API-Grenze ist eine Vertrauensgrenze – jede Eingabe wird validiert, jede Fehlerantwort bleibt frei von internen Details, und jeder Datenzugriff bleibt parametrisiert.* A11Y-Aspekt: Endpunkt-, Statuscode- und Kompatibilitätstabellen müssen als klarer Text lesbar sein, ohne reine Farbmarkierung.

**EN:** Relation to the Secure Development Guideline: secure architecture, input validation, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_03` (input validation), `CL_08` (security code review), and `CL_12` (evidence and closure). The security decision of this unit is: *the API boundary is a trust boundary – every input is validated, every error response stays free of internal details, and every data access stays parameterized.* Accessibility aspect: endpoint, status code, and compatibility tables must be readable as clear text, without color-only marking.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gehören Verben nicht in Ressourcenpfade? /
   **EN:** Why do verbs not belong in resource paths?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die HTTP-Methode drückt die Aktion aus (`GET`, `POST`); der Pfad benennt die Ressource. `/getOrder` vermischt beides und macht den Vertrag inkonsistent. `GET /orders/{id}` ist klar und einheitlich.
   **EN:** The HTTP method expresses the action (`GET`, `POST`); the path names the resource. `/getOrder` mixes both and makes the contract inconsistent. `GET /orders/{id}` is clear and uniform.

   </details>

2. **DE:** (AE) Was bedeutet Idempotenz bei einem lesenden Aufruf? /
   **EN:** (AE) What does idempotency mean for a read call?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein `GET` liefert bei Wiederholung dasselbe Ergebnis und ändert keinen Zustand. Das macht Aufrufe sicher wiederholbar, etwa bei Netzfehlern, ohne unbeabsichtigte Nebenwirkungen.
   **EN:** A `GET` returns the same result when repeated and changes no state. This makes calls safely repeatable, e.g. on network errors, without unintended side effects.

   </details>

3. **DE:** (AE) Wie wählst du zwischen URI- und Header-Versionierung? /
   **EN:** (AE) How do you choose between URI and header versioning?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit Trade-off: URI-Versionierung (`/v2`) ist sichtbar und leicht testbar, verschmutzt aber die Pfade; Header-Versionierung hält Pfade sauber, ist aber weniger sichtbar. Die Wahl wird begründet und als ADR-Kandidat notiert.
   **EN:** With a trade-off: URI versioning (`/v2`) is visible and easy to test but clutters paths; header versioning keeps paths clean but is less visible. The choice is justified and noted as an ADR candidate.

   </details>

4. **DE:** Warum ist die API-Grenze eine Vertrauensgrenze? /
   **EN:** Why is the API boundary a trust boundary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Dort treffen fremde, potenziell bösartige Eingaben auf das System. Ohne Validierung könnten ungültige oder gefährliche Werte (z. B. für SQL-Injection) weiterwandern. Deshalb wird jede Eingabe geprüft und der Datenzugriff bleibt parametrisiert.
   **EN:** That is where foreign, potentially malicious input meets the system. Without validation, invalid or dangerous values (e.g. for SQL injection) could propagate. Therefore every input is checked and data access stays parameterized.

   </details>

5. **DE:** (DPA) Welche Aussagegrenze hat ein API-Feld wie `Freight` oder `Discount`? /
   **EN:** (DPA) What is the significance limit of an API field like `Freight` or `Discount`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es zeigt nur den gespeicherten fiktiven Wert, keine echte Zahlung. Nutzende dürfen daraus keine realen Geschäftszahlen ableiten; die Aussagegrenze (fiktive Northwind-Daten) muss sichtbar bleiben.
   **EN:** It shows only the stored fictional value, not a real payment. Users must not derive real business figures from it; the significance limit (fictional Northwind data) must stay visible.

   </details>

6. **DE:** (DV) Warum sollten neue Felder additiv sein? /
   **EN:** (DV) Why should new fields be additive?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Additive Felder brechen keine bestehenden Clients, weil alte Aufrufe die neuen Felder einfach ignorieren können. Das Entfernen oder Umdeuten von Feldern wäre ein Breaking Change und bräuchte eine neue Version.
   **EN:** Additive fields break no existing clients, because old calls can simply ignore the new fields. Removing or repurposing fields would be a breaking change and would need a new version.

   </details>

7. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung. Beispiel: Authentifizierungs-Flows sind hier `N/A`, wenn die Einheit nur lesende Ressourcen betrachtet – die Prüfung bleibt aber sichtbar dokumentiert.
   **EN:** As `N/A` with a short technical justification. Example: authentication flows are `N/A` here if the unit only considers read resources – but the check stays visibly documented.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die Kernobjekte als Ressourcen mit Beziehungen modellieren.
- [ ] passende Pfade, Methoden und Statuscodes wählen und in einer Matrix belegen.
- [ ] Idempotenz lesender Aufrufe erklären.
- [ ] Eingaben an der API-Grenze validieren und Persistenz parametrisiert halten.
- [ ] Rückwärtskompatibilität und Versionierung mit Trade-off begründen.
- [ ] nicht anwendbare Standards als `N/A` mit Begründung dokumentieren.

**EN:** I can …

- [ ] model the core objects as resources with relationships.
- [ ] choose suitable paths, methods, and status codes and evidence them in a matrix.
- [ ] explain idempotency of read calls.
- [ ] validate input at the API boundary and keep persistence parameterized.
- [ ] justify backward compatibility and versioning with a trade-off.
- [ ] document non-applicable standards as `N/A` with a justification.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Application-Track_02_API-Erweiterung-und-Ressourcenmodell.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
