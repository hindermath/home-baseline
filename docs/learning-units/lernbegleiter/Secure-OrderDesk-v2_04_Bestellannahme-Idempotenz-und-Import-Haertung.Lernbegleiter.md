# Lernbegleiter: Secure OrderDesk v2 04 – Bestellannahme: Idempotenz und Import-Härtung / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_04_Bestellannahme-Idempotenz-und-Import-Haertung.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Bestellungen erreichen den Secure OrderDesk auf zwei Wegen: einzeln über die API oder als **Import-Batch** (z. B. eine CSV- oder JSON-Datei mit vielen Bestellungen). Zwei Probleme entstehen dabei. Erstens: Netzwerke wiederholen Anfragen; ein Kunde klickt zweimal. Ohne Schutz entsteht eine **Doppelbuchung**. Die Lösung heißt **Idempotenz**: Ein doppelt eingereichter Auftrag verändert das Ergebnis nicht. Zweitens: Eine hochgeladene Datei ist **nicht vertrauenswürdig**. Sie kann zu groß sein, ein falsches Format haben, gefährliche Pfade enthalten oder beim Einlesen (Deserialisierung) Schaden anrichten. Die Lösung heißt **Import-Härtung**.

**EN:** Orders reach the Secure OrderDesk in two ways: individually via the API or as an **import batch** (e.g. a CSV or JSON file with many orders). Two problems arise. First: networks repeat requests; a customer clicks twice. Without protection a **double booking** occurs. The solution is **idempotency**: an order submitted twice does not change the result. Second: an uploaded file is **untrusted**. It can be too large, have a wrong format, contain dangerous paths, or cause harm during reading (deserialization). The solution is **import hardening**.

**DE:** Der feste Testanker bleibt `ALFKI`: Reicht `ALFKI` dieselbe Bestellung zweimal ein, darf am Ende nur **ein** `Order`-Kopf mit seinen Positionen stehen.

**EN:** The fixed test anchor stays `ALFKI`: if `ALFKI` submits the same order twice, only **one** `Order` header with its lines may remain in the end.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Bestellannahme / Order intake | Der Ablauf, der neue Bestellungen prüft, annimmt und speichert. |
| Idempotenz / Idempotency | Eine wiederholte Ausführung führt zum selben Ergebnis wie eine einzige. |
| Idempotenzschlüssel / Idempotency key | Eindeutige Client-/Auftrags-ID, die Wiederholungen erkennt. |
| Upsert / Upsert | Einfügen oder Aktualisieren je nach vorhandenem Schlüssel, ohne Duplikat. |
| Import-Härtung / Import hardening | Regeln, die eine nicht vertrauenswürdige Importdatei sicher machen. |
| Allowlist Dateiformat / File-format allow-list | Feste Liste erlaubter Formate (z. B. nur CSV, JSON). |
| Pfad-Kanonisierung / Path canonicalization | Auflösen und Prüfen von Pfaden gegen `../`-Ausbrüche. |
| Sichere Deserialisierung / Safe deserialization | Einlesen ohne automatische Objekt-/Codeausführung. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Idempotenzschlüssel einführen.** Jede eingereichte Bestellung trägt einen eindeutigen Schlüssel (z. B. eine Client-/Auftrags-ID). Vor dem Speichern prüfst du, ob dieser Schlüssel schon existiert. **Warum wichtig:** Ohne Schlüssel kannst du eine Wiederholung nicht von einer echten neuen Bestellung unterscheiden.

**EN:** **Step 1 – Introduce an idempotency key.** Every submitted order carries a unique key (e.g. a client/order ID). Before saving you check whether this key already exists. **Why it matters:** without a key you cannot tell a repeat from a genuinely new order.

**DE:** **Schritt 2 – Upsert statt blindem Insert.** Ist der Schlüssel neu, wird die Bestellung eingefügt; ist er bekannt, wird nichts Zusätzliches erzeugt (idempotent). So bleibt bei einer Doppeleinreichung genau ein `Order`-Kopf. **Warum wichtig:** Ein blindes `INSERT` bei jeder Anfrage erzeugt Duplikate und verfälscht Umsatzkennzahlen.

**EN:** **Step 2 – Upsert instead of blind insert.** If the key is new, the order is inserted; if it is known, nothing extra is created (idempotent). So on a double submission exactly one `Order` header remains. **Why it matters:** a blind `INSERT` on every request creates duplicates and distorts revenue metrics.

**DE:** **Schritt 3 – Importformat und Größe begrenzen.** Erlaube nur bestimmte Dateiformate (Allowlist, z. B. CSV/JSON) und setze ein Größenlimit. **Warum wichtig:** Eine riesige Datei kann den Dienst überlasten (Denial of Service); ein unerwartetes Format kann Parser täuschen.

**EN:** **Step 3 – Limit import format and size.** Allow only certain file formats (allow-list, e.g. CSV/JSON) and set a size limit. **Why it matters:** a huge file can overload the service (denial of service); an unexpected format can trick parsers.

**DE:** **Schritt 4 – Pfade prüfen und kanonisieren.** Wenn ein Import einen Dateinamen oder Pfad nennt, löse ihn auf und prüfe, dass er im erlaubten Verzeichnis bleibt. Ein `../../etc/...` (Path Traversal) wird abgelehnt. **Warum wichtig:** Sonst kann ein Angreifer Dateien außerhalb des vorgesehenen Bereichs lesen oder schreiben.

**EN:** **Step 4 – Check and canonicalize paths.** If an import names a file name or path, resolve it and check that it stays within the allowed directory. A `../../etc/...` (path traversal) is rejected. **Why it matters:** otherwise an attacker could read or write files outside the intended area.

**DE:** **Schritt 5 – Sicher deserialisieren und validieren.** Lies die Datei ohne automatische Objekt-/Codeausführung ein und validiere jede Bestellung: gültige `CustomerID` (z. B. `ALFKI`), bekannte `ProductID`, positive Menge, plausibler Rabatt. Ungültige Zeilen werden abgelehnt oder protokolliert, nicht blind gespeichert. **Warum wichtig:** Nicht vertrauenswürdige Daten dürfen nie ungeprüft in den Store.

**EN:** **Step 5 – Deserialize safely and validate.** Read the file without automatic object/code execution and validate every order: valid `CustomerID` (e.g. `ALFKI`), known `ProductID`, positive quantity, plausible discount. Invalid rows are rejected or logged, not blindly saved. **Why it matters:** untrusted data must never reach the store unchecked.

**DE:** **Typische Fehler.** Kein Idempotenzschlüssel, daher Doppelbuchungen. Alle Formate und beliebige Größen akzeptieren. Pfade ungeprüft übernehmen. Deserialisierung mit automatischer Objektbildung nutzen. Ungültige Bestellzeilen still speichern. Interne Fehlerdetails an den Einreicher zurückgeben.

**EN:** **Common mistakes.** No idempotency key, hence double bookings. Accepting all formats and any size. Taking paths unchecked. Using deserialization with automatic object creation. Silently saving invalid order rows. Returning internal error details to the submitter.

### Beispiel / Example

```text
Idempotenz:
  Bestellung fuer ALFKI, IdempotenzSchluessel = "req-2026-07-07-abc"
  1. Einreichung -> Schluessel neu -> Order-Kopf + Positionen einfuegen
  2. Einreichung (Wiederholung, gleicher Schluessel) -> bereits bekannt -> nichts Zusaetzliches
  Ergebnis: genau EIN Order-Kopf fuer ALFKI

Import-Haertung (Batch order-batch.csv):
  Format:   nur CSV/JSON erlaubt (Allowlist)   -> .exe/.zip abgelehnt
  Groesse:  max. 5 MB                            -> groesser abgelehnt
  Pfad:     kanonisieren, muss in ./import/ bleiben -> ../../ abgelehnt
  Deserial: streng, keine Objektinstanziierung aus Daten
  Validierung je Zeile:
    CustomerID bekannt? ProductID bekannt? Quantity > 0? Discount in [0..0.5]?
    negative Menge -> Zeile ablehnen + intern protokollieren (ohne Secrets)

Negativtest:
  Datei mit Zeile "ALFKI; 28; 45.60; -15; 0.05" -> muss abgelehnt werden (Menge < 0)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 8 Daten systemübergreifend bereitstellen | Primär / Primary | Die Bestellannahme importiert und stellt Bestelldaten aus verschiedenen Quellen bereit. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Import und Doppelbuchung erfordern eine bewusste Schutzbedarfs- und Risikobetrachtung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, sichere Architektur, Testbarkeit (Negativtests) und Datenschutz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (sichere Architektur/Import-Grenzen), `CL_04` (sichere Datenzugriffe), `CL_08` (Sicherheits-Code-Review) und `CL_10` (Datenschutz). Die Sicherheitsentscheidung dieser Einheit lautet: *Eine wiederholte Einreichung erzeugt keine Doppelbuchung, und jede Importdatei gilt bis zur Prüfung als nicht vertrauenswürdig.* A11Y-Aspekt: Beschreibe Import-Regeln und Validierungsschritte als nummerierte Text-Liste statt als Grafik; Fehlermeldungen für Nutzer bleiben klar und textbasiert, ohne interne Details.

**EN:** Relation to the Secure Development Guideline: secure programming, secure architecture, testability (negative tests), and privacy. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure architecture/import boundaries), `CL_04` (secure data access), `CL_08` (security code review), and `CL_10` (privacy). The security decision of this unit is: *a repeated submission creates no double booking, and every import file is treated as untrusted until checked.* Accessibility aspect: describe import rules and validation steps as a numbered text list instead of a graphic; user-facing error messages stay clear and text-based, without internal details.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Idempotenz bei der Bestellannahme? /
   **EN:** What does idempotency mean in order intake?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine wiederholte Einreichung derselben Bestellung führt zum selben Ergebnis wie eine einzige – es entsteht kein zweiter `Order`-Kopf. Ein Idempotenzschlüssel erkennt die Wiederholung.
   **EN:** A repeated submission of the same order leads to the same result as a single one – no second `Order` header is created. An idempotency key detects the repeat.

   </details>

2. **DE:** Warum ist ein blindes `INSERT` bei jeder Anfrage gefährlich? /
   **EN:** Why is a blind `INSERT` on every request dangerous?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Netzwerke wiederholen Anfragen und Nutzer klicken doppelt. Ohne Schlüssel/Upsert entstehen Duplikate, die Umsatz- und Bestellkennzahlen verfälschen und zu Doppellieferungen führen können.
   **EN:** Networks repeat requests and users double-click. Without a key/upsert, duplicates arise that distort revenue and order metrics and can lead to double deliveries.

   </details>

3. **DE:** (AE) Wie setzt man einen Idempotenzschlüssel technisch um? /
   **EN:** (AE) How do you implement an idempotency key technically?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Man speichert den eindeutigen Schlüssel (Client-/Auftrags-ID) und prüft vor dem Einfügen, ob er existiert (Upsert oder eindeutiger Index). Ist er bekannt, wird nichts Zusätzliches gespeichert.
   **EN:** You store the unique key (client/order ID) and check before insert whether it exists (upsert or unique index). If it is known, nothing extra is saved.

   </details>

4. **DE:** (SI) Warum begrenzt man Dateiformat und Dateigröße beim Import? /
   **EN:** (SI) Why limit file format and file size on import?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine riesige Datei kann den Dienst überlasten (Denial of Service), ein unerwartetes Format den Parser täuschen. Eine Allowlist und ein Größenlimit reduzieren die Angriffsfläche.
   **EN:** A huge file can overload the service (denial of service), an unexpected format can trick the parser. An allow-list and a size limit reduce the attack surface.

   </details>

5. **DE:** (DPA) Warum werden ungültige Bestellzeilen abgelehnt statt still gespeichert? /
   **EN:** (DPA) Why are invalid order rows rejected instead of silently saved?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Still gespeicherte Fehler (negative Menge, unbekannte `ProductID`) verfälschen später Auswertungen. Ablehnen mit Protokoll hält die Datenbasis konsistent und die Kennzahlen belastbar.
   **EN:** Silently saved errors (negative quantity, unknown `ProductID`) later distort analyses. Rejecting with a log keeps the data base consistent and the metrics reliable.

   </details>

6. **DE:** (DV) Was ist Path Traversal und wie verhindert die Kanonisierung ihn? /
   **EN:** (DV) What is path traversal and how does canonicalization prevent it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Path Traversal nutzt `../`, um aus dem erlaubten Verzeichnis auszubrechen. Die Kanonisierung löst den Pfad vollständig auf und lehnt ihn ab, wenn er das erlaubte Verzeichnis verlässt.
   **EN:** Path traversal uses `../` to break out of the allowed directory. Canonicalization fully resolves the path and rejects it if it leaves the allowed directory.

   </details>

7. **DE:** Warum ist sichere Deserialisierung wichtig? /
   **EN:** Why is safe deserialization important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Unsichere Deserialisierung kann aus Daten automatisch Objekte oder Code erzeugen und so Angriffe ermöglichen. Sicheres Einlesen behandelt die Datei nur als Daten und validiert jeden Wert.
   **EN:** Unsafe deserialization can automatically create objects or code from data and thus enable attacks. Safe reading treats the file only as data and validates every value.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Idempotenz und einen Idempotenzschlüssel für die Bestellannahme erklären.
- [ ] mit Upsert eine Doppelbuchung für `ALFKI` verhindern.
- [ ] Import-Härtung mit Format-Allowlist, Größenlimit und Pfadprüfung beschreiben.
- [ ] sichere Deserialisierung und Validierung nicht vertrauenswürdiger Bestelldaten erklären.
- [ ] mindestens einen Negativtest (z. B. negative Menge) benennen.

**EN:** I can …

- [ ] explain idempotency and an idempotency key for order intake.
- [ ] prevent a double booking for `ALFKI` with upsert.
- [ ] describe import hardening with format allow-list, size limit, and path check.
- [ ] explain safe deserialization and validation of untrusted order data.
- [ ] name at least one negative test (e.g. negative quantity).

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-v2_04_Bestellannahme-Idempotenz-und-Import-Haertung.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-v2_04_Bestellannahme-Idempotenz-und-Import-Haertung.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
