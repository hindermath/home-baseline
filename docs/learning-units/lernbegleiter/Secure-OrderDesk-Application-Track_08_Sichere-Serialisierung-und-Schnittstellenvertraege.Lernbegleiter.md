# Lernbegleiter: Secure OrderDesk Application Track 08 – Sichere Serialisierung und Schnittstellenverträge / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Wenn das Secure OrderDesk Bestelldaten speichert, überträgt oder empfängt, werden Objekte in ein Format umgewandelt (**Serialisierung**, z. B. nach JSON) und später wieder eingelesen (**Deserialisierung**). Das Format und die Regeln dahinter sind ein **Schnittstellenvertrag**: eine Abmachung, wie Kunden, Produkte, Bestellungen und Positionen aussehen müssen, damit Sender und Empfänger sich verstehen. Bild dazu: ein Bestellformular. Solange beide Seiten dasselbe Formular mit denselben Feldern benutzen, klappt der Austausch. Ändert eine Seite das Formular heimlich, entstehen Missverständnisse – oder Sicherheitslücken.

**EN:** When the Secure OrderDesk stores, transmits, or receives order data, objects are converted into a format (**serialization**, e.g. to JSON) and later read back in (**deserialization**). The format and its rules are an **interface contract**: an agreement on how customers, products, orders, and order lines must look so sender and receiver understand each other. The picture: an order form. As long as both sides use the same form with the same fields, the exchange works. If one side secretly changes the form, misunderstandings – or security gaps – arise.

**DE:** Die größte Gefahr steckt in der Deserialisierung nicht vertrauenswürdiger Bestell- und Importdaten: Manche Serialisierer können beim Einlesen beliebige Typen erzeugen und dadurch Schadcode ausführen (unsichere Deserialisierung). Du lernst, ein explizites Schema als Vertrag für `Customer`, `Product`, `Order` und `OrderLine` festzulegen, die Deserialisierung zu härten (nur erlaubte Felder, Größen- und Tiefenlimits) und Versionen kompatibel weiterzuentwickeln. Als fiktiver Testanker dient das Northwind-Layout inkl. Kunde `ALFKI`; der Entwurf bleibt sprachneutral.

**EN:** The biggest danger lies in deserializing untrusted order and import data: some serializers can construct arbitrary types on read and thereby execute malicious code (insecure deserialization). You learn to define an explicit schema as a contract for `Customer`, `Product`, `Order`, and `OrderLine`, to harden deserialization (only allowed fields, size and depth limits), and to evolve versions compatibly. The Northwind layout including customer `ALFKI` serves as a fictional test anchor, but the design stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Serialisierung / Serialization | Umwandlung eines Bestellobjekts in ein Austauschformat (z. B. JSON). |
| Deserialisierung / Deserialization | Rückumwandlung eines Austauschformats in ein Bestellobjekt. |
| Schema / Schema | Formale Beschreibung erlaubter Felder, Typen und Regeln eines Vertrags. |
| Schnittstellenvertrag / Interface contract | Verbindliche Abmachung über Datenform zwischen Sender und Empfänger. |
| Abwärtskompatibilität / Backward compatibility | Neue Version versteht Daten der alten Version weiterhin. |
| Unsichere Deserialisierung / Insecure deserialization | Erzeugen beliebiger Typen aus nicht vertrauenswürdigen Daten – ein Sicherheitsrisiko. |
| Limit / Limit | Obergrenze für Größe oder Verschachtelungstiefe zum Schutz vor Missbrauch. |
| Datenminimierung / Data minimization | Nur benötigte Kundenfelder werden serialisiert und weitergegeben. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Schema als Vertrag festlegen.** Beschreibe explizit, welche Felder erlaubt sind, welchen Typ sie haben und welche Pflicht sind. Beispiel: eine `Order` hat `order_id` (Zahl), `customer_id` (Text, z. B. `ALFKI`), `order_date` (Zeitstempel) und eine Liste von `OrderLine`. Ein explizites Schema macht den Vertrag prüfbar – man kann eingehende Bestelldaten dagegen validieren.

**EN:** **Step 1 – Define the schema as contract.** Explicitly describe which fields are allowed, their type, and which are mandatory. Example: an `Order` has `order_id` (number), `customer_id` (text, e.g. `ALFKI`), `order_date` (timestamp), and a list of `OrderLine`. An explicit schema makes the contract checkable – incoming order data can be validated against it.

**DE:** **Schritt 2 – Beim Deserialisieren validieren und begrenzen.** Nimm keine Bestell- oder Importdaten ungeprüft an. Erlaube nur bekannte Felder und Typen (Whitelist), setze Größenlimits (z. B. maximale Länge, maximale Anzahl Positionen) und Tiefenlimits (gegen tief verschachtelte Strukturen, die den Speicher überlasten). Verwende einen Serialisierer, der keine beliebigen Typen aus den Daten erzeugt.

**EN:** **Step 2 – Validate and limit on deserialization.** Do not accept order or import data unchecked. Allow only known fields and types (whitelist), set size limits (e.g. maximum length, maximum number of order lines) and depth limits (against deeply nested structures that exhaust memory). Use a serializer that does not construct arbitrary types from the data.

**DE:** **Schritt 3 – Unbekannte Felder eindeutig regeln.** Lege fest, was mit zusätzlichen, unbekannten Feldern in einer Bestellnutzlast passiert: strikt ablehnen (sicherer, gut für interne Verträge) oder ignorieren (toleranter, gut für Weiterentwicklung). Beides ist erlaubt – aber die Entscheidung muss bewusst und dokumentiert sein, nicht zufällig.

**EN:** **Step 3 – Handle unknown fields explicitly.** Decide what happens with extra, unknown fields in an order payload: strictly reject (safer, good for internal contracts) or ignore (more tolerant, good for evolution). Both are allowed – but the decision must be conscious and documented, not accidental.

**DE:** **Schritt 4 – Versionen kompatibel weiterentwickeln.** Verträge ändern sich. **Abwärtskompatibel** heißt: Eine neue Version des OrderDesk versteht alte Bestelldaten weiter. Füge neue Felder optional hinzu, entferne alte nicht abrupt, und versioniere den Vertrag. So bricht eine Änderung nicht heimlich die Kommunikation mit anderen Systemen der Handelsplattform.

**EN:** **Step 4 – Evolve versions compatibly.** Contracts change. **Backward compatible** means: a new OrderDesk version still understands old order data. Add new fields as optional, do not remove old ones abruptly, and version the contract. This way a change does not silently break communication with other systems of the trading platform.

**DE:** **Schritt 5 – Mit Tests absichern.** Schreibe Kompatibilitätstests (alte Bestelldaten in neue Version einlesen) und Härtungstests (zu große Eingabe, zu tiefe Verschachtelung, unbekannter Typ → sicher abgelehnt). Positive Sicherheitsaussagen gelten nur mit solchem Nachweis.

**EN:** **Step 5 – Secure with tests.** Write compatibility tests (read old order data into the new version) and hardening tests (oversized input, too-deep nesting, unknown type → safely rejected). Positive security claims count only with such evidence.

**DE:** **Typische Fehler.** Kein explizites Schema für die Bestelldomäne. Serialisierer, der beliebige Typen erzeugt. Keine Größen- oder Tiefenlimits (z. B. Millionen Positionen). Unklarer Umgang mit unbekannten Feldern. Vertrag ohne Version brechen. Nur den guten Fall testen. Mehr Kundenfelder serialisieren als nötig.

**EN:** **Common mistakes.** No explicit schema for the ordering domain. A serializer that constructs arbitrary types. No size or depth limits (e.g. millions of order lines). Unclear handling of unknown fields. Breaking a contract without versioning. Testing only the good case. Serializing more customer fields than needed.

### Beispiel / Example

```text
Schema v1 (Vertrag, Bestelldomaene):
  Order { order_id: number*, customer_id: text*, order_date: timestamp*,
          lines: [ OrderLine ] }                          (* = Pflicht)
  OrderLine { product_id: number*, quantity: number*, unit_price: number* }
  Beispiel: Order 10643 fuer Kunde ALFKI mit 1 Position (Produkt 28, Menge 15)

Haertung beim Deserialisieren:
  - nur erlaubte Felder (Whitelist)          -> unbekanntes Feld "cmd": strikt ABGELEHNT
  - max. Feldlaenge 256 Zeichen              -> 5000-Zeichen-Feld: ABGELEHNT
  - max. 500 Positionen je Bestellung        -> 1_000_000 Positionen: ABGELEHNT
  - max. Verschachtelungstiefe 5             -> tief verschachtelte Struktur: ABGELEHNT
  - kein Typaufbau aus Daten (keine Gadget-Chain)

Version v2 (abwaertskompatibel):
  neues optionales Feld "ship_country" hinzugefuegt -> alte v1-Bestellungen weiter gueltig.

Test 1 (Kompatibilitaet): v1-Order in v2 einlesen  -> ok, ship_country leer.
Test 2 (Haertung): Nutzlast mit Feld "cmd"         -> abgelehnt, Fehlercode OD-VAL-020.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"). **LF 11a** ist primär, weil Serialisierung und Schnittstellenverträge Kernfunktionalität sind, die sicher und getestet realisiert wird; LF 5 ist berührt, weil Schema, Versionierung und Deserialisierung die Datenform der relationalen Bestelldatenverwaltung anpassen; LF 4 ist berührt, weil der Schutzbedarf der Bestell- und Kundendaten betrachtet wird.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"). **LF 11a** is primary because serialization and interface contracts are core functionality that is realized securely and tested; LF 5 is touched because schema, versioning, and deserialization adapt the data form of the relational order data management; LF 4 is touched because the protection need of the order and customer data is considered.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Serialisierung und Schnittstellenverträge der Bestelldomäne sind Kernfunktionalität, die sicher und getestet realisiert wird. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Schema, Versionierung und Deserialisierung passen die Datenform der Bestelldatenverwaltung an. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Kunden- und Bestelldaten an der Vertrauensgrenze werden auf Schutzbedarf geprüft und minimiert. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Trust Boundaries, sichere Deserialisierung ohne beliebige Typkonstruktion, Größen- und Tiefenlimits und auditfähige Tests. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Eingabevalidierung), `CL_08` (Sicherheits-Code-Review) und `CL_10` (Datenschutz). Die Sicherheitsentscheidung dieser Einheit lautet: *Ein explizites Schema ist der Vertrag der Bestelldomäne, nicht vertrauenswürdige Bestell- und Importdaten werden mit Whitelist und Limits deserialisiert, und Versionen bleiben kompatibel.* A11Y-Aspekt: Schema- und Vertragsbeschreibungen für `Customer`, `Product`, `Order` und `OrderLine` werden als klarer Text mit Feldnamen dargestellt, nicht nur als Diagramm, damit sie mit Screenreader und Braille-Zeile lesbar bleiben.

**EN:** Relation to the Secure Development Guideline: trust boundaries, secure deserialization without arbitrary type construction, size and depth limits, and audit-ready tests. Matching checklists: `CL_01` (standards applicability), `CL_02` (input validation), `CL_08` (security code review), and `CL_10` (privacy). The security decision of this unit is: *an explicit schema is the contract of the ordering domain, untrusted order and import data is deserialized with a whitelist and limits, and versions stay compatible.* Accessibility aspect: schema and contract descriptions for `Customer`, `Product`, `Order`, and `OrderLine` are presented as clear text with field names, not only as a diagram, so they remain readable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist ein Schnittstellenvertrag und wozu dient ein explizites Schema für die Bestelldomäne? /
   **EN:** What is an interface contract, and what is an explicit schema for in the ordering domain?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Vertrag legt fest, wie Kunden, Produkte, Bestellungen und Positionen aussehen müssen, damit Sender und Empfänger sich verstehen. Ein explizites Schema beschreibt erlaubte Felder, Typen und Pflichten und macht eingehende Bestelldaten prüfbar.
   **EN:** The contract defines how customers, products, orders, and order lines must look so sender and receiver understand each other. An explicit schema describes allowed fields, types, and requirements and makes incoming order data checkable.

   </details>

2. **DE:** Warum ist die Deserialisierung nicht vertrauenswürdiger Bestell- und Importdaten besonders gefährlich? /
   **EN:** Why is deserializing untrusted order and import data especially dangerous?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Manche Serialisierer können beim Einlesen beliebige Typen erzeugen. Ein Angreifer kann so über eine Bestellnutzlast Schadcode ausführen (unsichere Deserialisierung). Deshalb nur erlaubte Felder/Typen, keine Typkonstruktion aus Daten.
   **EN:** Some serializers can construct arbitrary types on read. Through an order payload an attacker can thus execute malicious code (insecure deserialization). Therefore only allowed fields/types, no type construction from data.

   </details>

3. **DE:** Wozu dienen Größen- und Tiefenlimits beim Deserialisieren einer Bestellung? /
   **EN:** What are size and depth limits for during deserialization of an order?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie schützen vor Missbrauch: Eine Bestellung mit Millionen Positionen oder eine tief verschachtelte Nutzlast kann Speicher und Rechenzeit überlasten (eine Art Denial-of-Service). Limits lehnen solche Eingaben früh und sicher ab.
   **EN:** They protect against abuse: an order with millions of lines or a deeply nested payload can exhaust memory and compute (a kind of denial of service). Limits reject such inputs early and safely.

   </details>

4. **DE:** Warum muss der Umgang mit unbekannten Feldern in einer Bestellnutzlast bewusst entschieden werden? /
   **EN:** Why must the handling of unknown fields in an order payload be decided consciously?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Striktes Ablehnen ist sicherer, Ignorieren ist toleranter für Weiterentwicklung. Beides ist möglich, aber die Wahl muss dokumentiert sein, damit sich Sender und Empfänger auf ein Verhalten verlassen können.
   **EN:** Strict rejection is safer, ignoring is more tolerant for evolution. Both are possible, but the choice must be documented so sender and receiver can rely on one behavior.

   </details>

5. **DE:** Was bedeutet Abwärtskompatibilität bei einem Bestellvertrag? /
   **EN:** What does backward compatibility mean for an order contract?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine neue Version versteht die Bestelldaten der alten Version weiter. Man fügt neue Felder optional hinzu und entfernt alte nicht abrupt, damit bestehende Systeme der Handelsplattform nicht plötzlich brechen.
   **EN:** A new version still understands old-version order data. You add new fields as optional and do not remove old ones abruptly, so existing systems of the trading platform do not suddenly break.

   </details>

6. **DE:** (AE) Wie beweist ein Härtungstest, dass die Deserialisierung von Bestelldaten sicher ist? /
   **EN:** (AE) How does a hardening test prove deserialization of order data is secure?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er schickt bewusst bösartige Bestellnutzlasten (unbekannter Typ, zu groß, zu viele Positionen, zu tief) und prüft, dass sie sicher abgelehnt werden. Erst dieser Nachweis macht die Sicherheitsaussage belastbar.
   **EN:** It deliberately sends malicious order payloads (unknown type, too big, too many lines, too deep) and checks they are safely rejected. Only this evidence makes the security claim reliable.

   </details>

7. **DE:** (DV) Warum ist der Vertrag besonders wichtig, wenn Bestelldaten eine Systemgrenze der Bestell-Pipeline überschreiten? /
   **EN:** (DV) Why is the contract especially important when order data crosses a system boundary of the ordering pipeline?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** An der Grenze treffen zwei Systeme mit eigenen Annahmen aufeinander. Ein klarer, versionierter Vertrag verhindert Missverständnisse und macht Änderungen an der Bestell-Pipeline planbar statt überraschend.
   **EN:** At the boundary two systems with their own assumptions meet. A clear, versioned contract prevents misunderstandings and makes changes to the ordering pipeline plannable instead of surprising.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] ein explizites Schema als Schnittstellenvertrag für `Customer`, `Product`, `Order` und `OrderLine` festlegen.
- [ ] die Deserialisierung mit Whitelist, Größen- und Tiefenlimits härten.
- [ ] den Umgang mit unbekannten Feldern bewusst regeln und dokumentieren.
- [ ] einen Bestellvertrag abwärtskompatibel weiterentwickeln.
- [ ] Kompatibilitäts- und Härtungstests benennen.
- [ ] nur benötigte Kundenfelder serialisieren (Datenminimierung) und nicht anwendbare Standards als `N/A` begründen.

**EN:** I can …

- [ ] define an explicit schema as an interface contract for `Customer`, `Product`, `Order`, and `OrderLine`.
- [ ] harden deserialization with whitelist, size, and depth limits.
- [ ] consciously handle and document unknown fields.
- [ ] evolve an order contract backward-compatibly.
- [ ] name compatibility and hardening tests.
- [ ] serialize only required customer fields (data minimization) and justify non-applicable standards as `N/A`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
