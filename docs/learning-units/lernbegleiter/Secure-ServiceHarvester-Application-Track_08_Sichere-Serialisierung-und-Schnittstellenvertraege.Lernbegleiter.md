# Lernbegleiter: Secure ServiceHarvester Application Track 08 – Sichere Serialisierung und Schnittstellenverträge / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Wenn der Secure ServiceHarvester Daten speichert, überträgt oder empfängt, werden Objekte in ein Format
umgewandelt (**Serialisierung**, z. B. nach JSON) und später wieder eingelesen (**Deserialisierung**). Das
Format und die Regeln dahinter sind ein **Schnittstellenvertrag**: eine Abmachung, wie Daten aussehen müssen,
damit Sender und Empfänger sich verstehen. Bild dazu: ein Formular. Solange beide Seiten dasselbe Formular mit
denselben Feldern benutzen, klappt der Austausch. Ändert eine Seite das Formular heimlich, entstehen
Missverständnisse – oder Sicherheitslücken.

**EN:** When the Secure ServiceHarvester stores, transmits, or receives data, objects are converted into a
format (**serialization**, e.g. to JSON) and later read back in (**deserialization**). The format and its
rules are an **interface contract**: an agreement on how data must look so sender and receiver understand each
other. The picture: a form. As long as both sides use the same form with the same fields, the exchange works.
If one side secretly changes the form, misunderstandings – or security gaps – arise.

**DE:** Die größte Gefahr steckt in der Deserialisierung nicht vertrauenswürdiger Daten: Manche Serialisierer
können beim Einlesen beliebige Typen erzeugen und dadurch Schadcode ausführen (unsichere Deserialisierung). Du
lernst, ein explizites Schema als Vertrag festzulegen, die Deserialisierung zu härten (nur erlaubte Felder,
Größen- und Tiefenlimits) und Versionen kompatibel weiterzuentwickeln. Als C#-Referenz dient
`InventarWorkerService`; der Entwurf bleibt sprachneutral.

**EN:** The biggest danger lies in deserializing untrusted data: some serializers can construct arbitrary types
on read and thereby execute malicious code (insecure deserialization). You learn to define an explicit schema
as a contract, to harden deserialization (only allowed fields, size and depth limits), and to evolve versions
compatibly. `InventarWorkerService` serves as a C# reference, but the design stays language-neutral.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Serialisierung / Serialization | Umwandlung eines Objekts in ein Austauschformat (z. B. JSON). |
| Deserialisierung / Deserialization | Rückumwandlung eines Austauschformats in ein Objekt. |
| Schema / Schema | Formale Beschreibung erlaubter Felder, Typen und Regeln eines Vertrags. |
| Schnittstellenvertrag / Interface contract | Verbindliche Abmachung über Datenform zwischen Sender und Empfänger. |
| Abwärtskompatibilität / Backward compatibility | Neue Version versteht Daten der alten Version weiterhin. |
| Unsichere Deserialisierung / Insecure deserialization | Erzeugen beliebiger Typen aus nicht vertrauenswürdigen Daten – ein Sicherheitsrisiko. |
| Limit / Limit | Obergrenze für Größe oder Verschachtelungstiefe zum Schutz vor Missbrauch. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Schema als Vertrag festlegen.** Beschreibe explizit, welche Felder erlaubt sind, welchen
Typ sie haben und welche Pflicht sind. Beispiel: ein Snapshot hat `machine_id` (Text), `os` (Text),
`collected_at` (Zeitstempel). Ein explizites Schema macht den Vertrag prüfbar – man kann eingehende Daten
dagegen validieren.

**EN:** **Step 1 – Define the schema as contract.** Explicitly describe which fields are allowed, their type,
and which are mandatory. Example: a snapshot has `machine_id` (text), `os` (text), `collected_at` (timestamp).
An explicit schema makes the contract checkable – incoming data can be validated against it.

**DE:** **Schritt 2 – Beim Deserialisieren validieren und begrenzen.** Nimm keine Daten ungeprüft an. Erlaube
nur bekannte Felder und Typen (Whitelist), setze Größenlimits (z. B. maximale Länge) und Tiefenlimits (gegen
tief verschachtelte Strukturen, die den Speicher überlasten). Verwende einen Serialisierer, der keine
beliebigen Typen aus den Daten erzeugt.

**EN:** **Step 2 – Validate and limit on deserialization.** Do not accept data unchecked. Allow only known
fields and types (whitelist), set size limits (e.g. maximum length) and depth limits (against deeply nested
structures that exhaust memory). Use a serializer that does not construct arbitrary types from the data.

**DE:** **Schritt 3 – Unbekannte Felder eindeutig regeln.** Lege fest, was mit zusätzlichen, unbekannten
Feldern passiert: strikt ablehnen (sicherer, gut für interne Verträge) oder ignorieren (toleranter, gut für
Weiterentwicklung). Beides ist erlaubt – aber die Entscheidung muss bewusst und dokumentiert sein, nicht
zufällig.

**EN:** **Step 3 – Handle unknown fields explicitly.** Decide what happens with extra, unknown fields: strictly
reject (safer, good for internal contracts) or ignore (more tolerant, good for evolution). Both are allowed –
but the decision must be conscious and documented, not accidental.

**DE:** **Schritt 4 – Versionen kompatibel weiterentwickeln.** Verträge ändern sich. **Abwärtskompatibel**
heißt: Eine neue Dienstversion versteht alte Daten weiter. Füge neue Felder optional hinzu, entferne alte nicht
abrupt, und versioniere den Vertrag. So bricht eine Änderung nicht heimlich die Kommunikation mit anderen
Systemen.

**EN:** **Step 4 – Evolve versions compatibly.** Contracts change. **Backward compatible** means: a new service
version still understands old data. Add new fields as optional, do not remove old ones abruptly, and version
the contract. This way a change does not silently break communication with other systems.

**DE:** **Schritt 5 – Mit Tests absichern.** Schreibe Kompatibilitätstests (alte Daten in neue Version einlesen)
und Härtungstests (zu große Eingabe, zu tiefe Verschachtelung, unbekannter Typ → sicher abgelehnt).
Positive Sicherheitsaussagen gelten nur mit solchem Nachweis.

**EN:** **Step 5 – Secure with tests.** Write compatibility tests (read old data into the new version) and
hardening tests (oversized input, too-deep nesting, unknown type → safely rejected). Positive security claims
count only with such evidence.

**DE:** **Typische Fehler.** Kein explizites Schema. Serialisierer, der beliebige Typen erzeugt. Keine Größen-
oder Tiefenlimits. Unklarer Umgang mit unbekannten Feldern. Vertrag ohne Version brechen. Nur den guten Fall
testen.

**EN:** **Common mistakes.** No explicit schema. A serializer that constructs arbitrary types. No size or depth
limits. Unclear handling of unknown fields. Breaking a contract without versioning. Testing only the good case.

### Beispiel / Example

```text
Schema v1 (Vertrag):
  Snapshot { machine_id: text*, os: text*, collected_at: timestamp* }   (* = Pflicht)

Härtung beim Deserialisieren:
  - nur erlaubte Felder (Whitelist)          -> unbekanntes Feld "cmd": strikt ABGELEHNT
  - max. Feldlänge 256 Zeichen               -> 5000-Zeichen-Feld: ABGELEHNT
  - max. Verschachtelungstiefe 5             -> tief verschachtelte Struktur: ABGELEHNT
  - kein Typaufbau aus Daten (keine Gadget-Chain)

Version v2 (abwärtskompatibel):
  neues optionales Feld "labels" hinzugefügt  -> alte v1-Daten weiterhin gültig.

Test 1 (Kompatibilität): v1-Snapshot in v2 einlesen  -> ok, labels leer.
Test 2 (Härtung): Nutzlast mit Feld "cmd"            -> abgelehnt, Fehlercode HV-VAL-020.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Serialisierung und Schnittstellenverträge sind Kernfunktionalität, die sicher und getestet realisiert wird. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Schema, Versionierung und Deserialisierung passen die Datenform der Datenverwaltung an. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Trust Boundaries, sichere Deserialisierung ohne beliebige
Typkonstruktion, Größen- und Tiefenlimits und auditfähige Tests. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_02` (Eingabevalidierung), `CL_08` (Sicherheits-Code-Review) und `CL_10`
(Datenschutz). Die Sicherheitsentscheidung dieser Einheit lautet: *Ein explizites Schema ist der Vertrag,
nicht vertrauenswürdige Daten werden mit Whitelist und Limits deserialisiert, und Versionen bleiben
kompatibel.* A11Y-Aspekt: Schema- und Vertragsbeschreibungen werden als klarer Text mit Feldnamen dargestellt,
nicht nur als Diagramm, damit sie mit Screenreader und Braille-Zeile lesbar bleiben.

**EN:** Relation to the Secure Development Guideline: trust boundaries, secure deserialization without arbitrary
type construction, size and depth limits, and audit-ready tests. Matching checklists: `CL_01` (standards
applicability), `CL_02` (input validation), `CL_08` (security code review), and `CL_10` (privacy). The security
decision of this unit is: *an explicit schema is the contract, untrusted data is deserialized with a whitelist
and limits, and versions stay compatible.* Accessibility aspect: schema and contract descriptions are presented
as clear text with field names, not only as a diagram, so they remain readable with a screen reader and Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist ein Schnittstellenvertrag und wozu dient ein explizites Schema? /
   **EN:** What is an interface contract, and what is an explicit schema for?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Vertrag legt fest, wie Daten aussehen müssen, damit Sender und Empfänger sich verstehen. Ein
   explizites Schema beschreibt erlaubte Felder, Typen und Pflichten und macht eingehende Daten prüfbar.
   **EN:** The contract defines how data must look so sender and receiver understand each other. An explicit
   schema describes allowed fields, types, and requirements and makes incoming data checkable.

   </details>

2. **DE:** Warum ist die Deserialisierung nicht vertrauenswürdiger Daten besonders gefährlich? /
   **EN:** Why is deserializing untrusted data especially dangerous?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Manche Serialisierer können beim Einlesen beliebige Typen erzeugen. Ein Angreifer kann so Schadcode
   ausführen (unsichere Deserialisierung). Deshalb nur erlaubte Felder/Typen, keine Typkonstruktion aus Daten.
   **EN:** Some serializers can construct arbitrary types on read. An attacker can thus execute malicious code
   (insecure deserialization). Therefore only allowed fields/types, no type construction from data.

   </details>

3. **DE:** Wozu dienen Größen- und Tiefenlimits beim Deserialisieren? /
   **EN:** What are size and depth limits for during deserialization?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie schützen vor Missbrauch: Eine riesige oder tief verschachtelte Nutzlast kann Speicher und Rechen-
   zeit überlasten (eine Art Denial-of-Service). Limits lehnen solche Eingaben früh und sicher ab.
   **EN:** They protect against abuse: a huge or deeply nested payload can exhaust memory and compute (a kind of
   denial of service). Limits reject such inputs early and safely.

   </details>

4. **DE:** Warum muss der Umgang mit unbekannten Feldern bewusst entschieden werden? /
   **EN:** Why must the handling of unknown fields be decided consciously?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Striktes Ablehnen ist sicherer, Ignorieren ist toleranter für Weiterentwicklung. Beides ist möglich,
   aber die Wahl muss dokumentiert sein, damit sich Sender und Empfänger auf ein Verhalten verlassen können.
   **EN:** Strict rejection is safer, ignoring is more tolerant for evolution. Both are possible, but the choice
   must be documented so sender and receiver can rely on one behavior.

   </details>

5. **DE:** Was bedeutet Abwärtskompatibilität bei einem Vertrag? /
   **EN:** What does backward compatibility mean for a contract?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine neue Version versteht die Daten der alten Version weiter. Man fügt neue Felder optional hinzu
   und entfernt alte nicht abrupt, damit bestehende Systeme nicht plötzlich brechen.
   **EN:** A new version still understands old-version data. You add new fields as optional and do not remove old
   ones abruptly, so existing systems do not suddenly break.

   </details>

6. **DE:** (AE) Wie beweist ein Härtungstest, dass die Deserialisierung sicher ist? /
   **EN:** (AE) How does a hardening test prove deserialization is secure?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er schickt bewusst bösartige Eingaben (unbekannter Typ, zu groß, zu tief) und prüft, dass sie sicher
   abgelehnt werden. Erst dieser Nachweis macht die Sicherheitsaussage belastbar.
   **EN:** It deliberately sends malicious inputs (unknown type, too big, too deep) and checks they are safely
   rejected. Only this evidence makes the security claim reliable.

   </details>

7. **DE:** (DV) Warum ist der Vertrag besonders wichtig, wenn Daten eine Systemgrenze überschreiten? /
   **EN:** (DV) Why is the contract especially important when data crosses a system boundary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** An der Grenze treffen zwei Systeme mit eigenen Annahmen aufeinander. Ein klarer, versionierter Vertrag
   verhindert Missverständnisse und macht Änderungen planbar statt überraschend.
   **EN:** At the boundary two systems with their own assumptions meet. A clear, versioned contract prevents
   misunderstandings and makes changes plannable instead of surprising.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] ein explizites Schema als Schnittstellenvertrag festlegen.
- [ ] die Deserialisierung mit Whitelist, Größen- und Tiefenlimits härten.
- [ ] den Umgang mit unbekannten Feldern bewusst regeln und dokumentieren.
- [ ] einen Vertrag abwärtskompatibel weiterentwickeln.
- [ ] Kompatibilitäts- und Härtungstests benennen.

**EN:** I can …

- [ ] define an explicit schema as an interface contract.
- [ ] harden deserialization with whitelist, size, and depth limits.
- [ ] consciously handle and document unknown fields.
- [ ] evolve a contract backward-compatibly.
- [ ] name compatibility and hardening tests.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Application-Track_08_Sichere-Serialisierung-und-Schnittstellenvertraege.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
