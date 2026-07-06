# Lernbegleiter: Secure ServiceHarvester v2 03 – Persistenzmodell und Backend-Abstraktion / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_03_Persistenzmodell-und-Backend-Abstraktion.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der ServiceHarvester speichert gesammelte Statusdaten dauerhaft; diese Speicherung heißt
**Persistenz**. Der Kunde will heute vielleicht eine leichte lokale Datenbank (SQLite), morgen einen
Server-Betrieb (PostgreSQL) und übermorgen eine dokumentenorientierte Ablage (MongoDB). Würde die Fachlogik
direkt mit einer konkreten Datenbank sprechen, müsste man sie bei jedem Wechsel umschreiben. Deshalb legt man
einen **Speichervertrag** fest – eine **Abstraktion** wie `IDbService` –, hinter der das konkrete Backend
austauschbar ist.

**EN:** The ServiceHarvester stores collected status data durably; this storage is called **persistence**. The
customer may want a light local database today (SQLite), a server setup tomorrow (PostgreSQL), and a
document-oriented store the day after (MongoDB). If the business logic talked to a concrete database directly,
it would have to be rewritten on every switch. Therefore you define a **storage contract** – an
**abstraction** like `IDbService` – behind which the concrete backend is swappable.

**DE:** In dieser Einheit planst du **Entitäten** (z. B. Maschine, Snapshot), ihre **Beziehungen**, die
**Pflichtfelder**, den Speichervertrag `IDbService` und den Backend-Wechsel **SQLite → PostgreSQL →
MongoDB**. Ein Leitgedanke ist **Datenminimierung**: nur speichern, was gebraucht wird. Ein
Sicherheitsleitgedanke ist: Datenbankabfragen immer **parametrisiert** ausführen, nie durch Zusammenbauen von
Text (Schutz vor Injection).

**EN:** In this unit you plan **entities** (e.g. machine, snapshot), their **relationships**, the **mandatory
fields**, the storage contract `IDbService`, and the backend switch **SQLite → PostgreSQL → MongoDB**. A
guiding idea is **data minimization**: store only what is needed. A security guiding idea is: always run
database queries **parameterized**, never by assembling text (protection against injection).

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Persistenz / Persistence | Dauerhafte Speicherung von Daten über die Programmlaufzeit hinaus. |
| Abstraktion / Abstraction | Stabile Schnittstelle (z. B. `IDbService`), die das konkrete Backend verbirgt. |
| Backend / Backend | Die konkrete Ablage: SQLite, PostgreSQL oder MongoDB. |
| Parametrisierte Query / Parameterized query | Abfrage mit Platzhaltern statt zusammengebautem Text; schützt vor Injection. |
| Entität / Entity | Abgegrenztes Datenobjekt mit Feldern, z. B. Maschine oder Snapshot. |
| Datenminimierung / Data minimization | Nur die Daten speichern, die für den Zweck nötig sind. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Entitäten und Felder festlegen.** Liste die Dinge, die du speicherst, und je Ding die
Felder mit Typ und Bedeutung. Markiere Pflichtfelder. **Warum wichtig:** Ein klares Modell verhindert
Wildwuchs und macht Validierung planbar. Frage bei jedem Feld: *Brauche ich es wirklich?* (Datenminimierung).

**EN:** **Step 1 – Define entities and fields.** List the things you store and, per thing, the fields with
type and meaning. Mark mandatory fields. **Why it matters:** a clear model prevents sprawl and makes
validation plannable. Ask for every field: *do I really need it?* (data minimization).

**DE:** **Schritt 2 – Speichervertrag `IDbService` entwerfen.** Beschreibe die Operationen, die die Fachlogik
braucht, unabhängig vom Backend: z. B. `Upsert(snapshot)`, `GetLatest(machine)`, `List()`. **Warum wichtig:**
Der Vertrag ist die Grenze zwischen Fachlogik und Ablage. Nur wenn die Fachlogik ausschließlich diesen
Vertrag nutzt, lässt sich das Backend wechseln.

**EN:** **Step 2 – Design the storage contract `IDbService`.** Describe the operations the business logic
needs, independent of the backend: e.g. `Upsert(snapshot)`, `GetLatest(machine)`, `List()`. **Why it
matters:** the contract is the boundary between business logic and storage. Only if the business logic uses
exclusively this contract can the backend be swapped.

**DE:** **Schritt 3 – Backends dahinter setzen.** Plane je Backend eine eigene Umsetzung des Vertrags: eine
SQLite-, eine PostgreSQL- und eine MongoDB-Variante. Die Fachlogik merkt den Unterschied nicht. **Warum
wichtig:** Getrennte Umsetzungen erlauben, mit einer leichten SQLite-Variante zu starten und später ohne
Änderung der Fachlogik auf PostgreSQL oder MongoDB zu wechseln.

**EN:** **Step 3 – Put backends behind it.** Plan a separate implementation of the contract per backend: a
SQLite, a PostgreSQL, and a MongoDB variant. The business logic does not notice the difference. **Why it
matters:** separate implementations let you start with a light SQLite variant and later switch to PostgreSQL
or MongoDB without changing the business logic.

**DE:** **Schritt 4 – Queries parametrisieren.** Baue Abfragen niemals durch Zusammensetzen von Text mit
Nutzerwerten. Nutze Platzhalter/Parameter (bei SQL) oder die sichere Abfrage-API des Backends (bei MongoDB).
**Warum wichtig:** Zusammengebauter Text erlaubt **Injection** – ein Angreifer schleust eigene Befehle ein.
Parametrisierte Abfragen trennen Befehl und Daten. Gesammelte Daten sind nicht vertrauenswürdig.

**EN:** **Step 4 – Parameterize queries.** Never build queries by assembling text with user values. Use
placeholders/parameters (for SQL) or the backend's safe query API (for MongoDB). **Why it matters:** assembled
text allows **injection** – an attacker smuggles in own commands. Parameterized queries separate command and
data. Collected data is not trustworthy.

**DE:** **Schritt 5 – Konfiguration, Secrets und Testdaten trennen.** Verbindungszeichenketten und
Zugangsdaten gehören nicht in den Quellcode, sondern in einen sicheren Speicher (z. B. Schlüsselbund).
Verwende in Beispielen nur `<PLATZHALTER-KEIN-ECHTER-WERT>` und nur synthetische Testdaten. **Warum wichtig:**
Jedes Backend hat eigene Zugangsdaten; ein Leck im Repository trifft sofort die Produktion.

**EN:** **Step 5 – Separate configuration, secrets, and test data.** Connection strings and credentials do not
belong in the source code but in a secure store (e.g. a keychain). In examples use only
`<PLATZHALTER-KEIN-ECHTER-WERT>` and only synthetic test data. **Why it matters:** every backend has its own
credentials; a leak in the repository immediately hits production.

**DE:** **Typische Fehler.** Die Fachlogik direkt mit einer konkreten Datenbank sprechen lassen. Queries aus
Text zusammenbauen. Verbindungszeichenketten im Code. Felder speichern, die nie gebraucht werden. Annehmen,
alle Backends verhielten sich exakt gleich, ohne die Unterschiede zu dokumentieren.

**EN:** **Common mistakes.** Letting the business logic talk to a concrete database directly. Assembling
queries from text. Connection strings in code. Storing fields that are never used. Assuming all backends
behave exactly the same without documenting the differences.

### Beispiel / Example

```text
Entitaet Snapshot:
  machine_id     Pflicht  eindeutige Kennung der Maschine
  os             Pflicht  Betriebssystem (Allowlist bekannter Werte)
  collected_at   Pflicht  Zeitpunkt der Sammlung
  note           optional KEIN echter Personenbezug (Datenminimierung)

Speichervertrag (Abstraktion):
  IDbService.Upsert(snapshot)       // anlegen oder aktualisieren
  IDbService.GetLatest(machine_id)  // neuesten Snapshot lesen
  IDbService.List()                 // alle Maschinen auflisten

Backends hinter demselben Vertrag:
  SqliteDbService     -> leicht, lokal, gut zum Start
  PostgresDbService   -> Serverbetrieb, mehrere Nutzer
  MongoDbService      -> dokumentenorientiert

Parametrisiert statt zusammengebaut (SQL-Beispiel):
  RICHTIG:  SELECT * FROM snapshot WHERE machine_id = ?      (Parameter)
  FALSCH:   "SELECT * FROM snapshot WHERE machine_id = " + eingabe   (Injection!)

Secrets:
  connection_string = <PLATZHALTER-KEIN-ECHTER-WERT>   (aus sicherem Speicher, NICHT im Code)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Persistenz und Backend-Abstraktion sind der Kern der datenverwaltenden Dienst-Software. |
| LF 8 Daten systemübergreifend bereitstellen | Berührt / Touched | Ein austauschbares Backend hinter einem Vertrag ist Voraussetzung für systemübergreifende Bereitstellung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, Integrität, Datenschutz durch
Datenminimierung, sichere Konfiguration und auditfähige Nachweise. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_02` (sichere Programmierung), `CL_04` (Bedrohungsmodellierung), `CL_08`
(Sicherheits-Code-Review) und `CL_10` (Datenschutz). Die Sicherheitsentscheidung dieser Einheit lautet:
*Die Fachlogik spricht nur mit dem Speichervertrag, Abfragen sind parametrisiert, und Secrets liegen nie im
Code.* A11Y-Aspekt: Datenmodell, Vertrag und Backend-Vergleich müssen als klare Tabellen und Listen lesbar
sein, damit sie mit Screenreader und Braille-Zeile verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: secure coding, integrity, privacy through data
minimization, secure configuration, and auditable evidence. Matching checklists: `CL_01` (standards
applicability), `CL_02` (secure coding), `CL_04` (threat modeling), `CL_08` (security code review), and `CL_10`
(privacy). The security decision of this unit is: *the business logic talks only to the storage contract,
queries are parameterized, and secrets are never in the code.* Accessibility aspect: data model, contract, and
backend comparison must be readable as clear tables and lists so they remain understandable with a screen
reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum spricht die Fachlogik mit einer Abstraktion wie `IDbService` statt direkt mit der Datenbank? /
   **EN:** Why does the business logic talk to an abstraction like `IDbService` instead of directly to the
   database?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Abstraktion ist die Grenze zwischen Fachlogik und Ablage. Nur wenn die Fachlogik ausschließlich
   den Vertrag nutzt, lässt sich das Backend (SQLite, PostgreSQL, MongoDB) wechseln, ohne die Fachlogik
   umzuschreiben.
   **EN:** The abstraction is the boundary between business logic and storage. Only if the business logic uses
   exclusively the contract can the backend (SQLite, PostgreSQL, MongoDB) be swapped without rewriting the
   business logic.

   </details>

2. **DE:** Was ist eine parametrisierte Query, und wovor schützt sie? /
   **EN:** What is a parameterized query, and what does it protect against?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Abfrage mit Platzhaltern, in die Werte getrennt eingesetzt werden, statt Text mit Nutzerwerten
   zusammenzubauen. Sie trennt Befehl und Daten und schützt vor Injection.
   **EN:** A query with placeholders into which values are inserted separately, instead of assembling text with
   user values. It separates command and data and protects against injection.

   </details>

3. **DE:** (AE) Wie beeinflusst das Datenmodell die spätere Umsetzung der Validierung? /
   **EN:** (AE) How does the data model influence the later implementation of validation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Pflichtfelder, Typen und Allowlists aus dem Modell werden direkt zu Validierungsregeln, bevor Daten
   in den Store gelangen. Ein klares Modell macht die Prüfung vollständig und für alle Backends gleich.
   **EN:** Mandatory fields, types, and allow-lists from the model become validation rules directly, before data
   reaches the store. A clear model makes the check complete and equal for all backends.

   </details>

4. **DE:** (DPA) Warum ist Datenminimierung beim gesammelten Snapshot wichtig? /
   **EN:** (DPA) Why is data minimization important for the collected snapshot?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur speichern, was für den Zweck nötig ist. Weniger (oft personenbezogene) Daten bedeuten weniger
   Risiko bei einem Leck, bessere Datenqualität und einfachere Einhaltung des Datenschutzes.
   **EN:** Store only what is needed for the purpose. Less (often personal) data means less risk in a leak,
   better data quality, and easier privacy compliance.

   </details>

5. **DE:** (SI) Warum gehören Verbindungszeichenketten nicht in den Quellcode? /
   **EN:** (SI) Why do connection strings not belong in the source code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie enthalten Zugangsdaten. Im Repository sind sie sofort für alle sichtbar und schwer zu
   widerrufen. Sie gehören in einen sicheren Speicher (z. B. Schlüsselbund); im Beispiel steht nur
   `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** They contain credentials. In the repository they are immediately visible to everyone and hard to
   revoke. They belong in a secure store (e.g. a keychain); the example shows only
   `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

6. **DE:** (DV) Warum muss man Unterschiede zwischen SQLite, PostgreSQL und MongoDB dokumentieren, obwohl der
   Vertrag gleich ist? / **EN:** (DV) Why document differences between SQLite, PostgreSQL, and MongoDB even
   though the contract is the same?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Vertrag ist gleich, aber Transport, Nebenläufigkeit, Datentypen und Fehlermeldungen unterscheiden
   sich. Wer die Unterschiede dokumentiert, plant Kommunikation, Timeouts und Betrieb je Backend richtig.
   **EN:** The contract is the same, but transport, concurrency, data types, and error messages differ. Whoever
   documents the differences plans communication, timeouts, and operation correctly per backend.

   </details>

7. **DE:** Warum sind klare Beziehungen zwischen Entitäten eine Frage der Integrität? /
   **EN:** Why are clear relationships between entities a matter of integrity?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Klare Beziehungen verhindern verwaiste oder widersprüchliche Daten (z. B. ein Snapshot ohne
   Maschine). So bleibt der Datenbestand in sich stimmig, unabhängig vom Backend.
   **EN:** Clear relationships prevent orphaned or contradictory data (e.g. a snapshot without a machine). This
   keeps the data set internally consistent, regardless of the backend.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Entitäten mit Feldern, Typen und Pflichtangaben beschreiben.
- [ ] einen Speichervertrag (`IDbService`) unabhängig vom Backend entwerfen.
- [ ] den Backend-Wechsel SQLite → PostgreSQL → MongoDB hinter dem Vertrag erklären.
- [ ] parametrisierte von zusammengebauten Queries unterscheiden.
- [ ] Secrets und Testdaten aus dem Code heraushalten und Datenminimierung begründen.

**EN:** I can …

- [ ] describe entities with fields, types, and mandatory markers.
- [ ] design a storage contract (`IDbService`) independent of the backend.
- [ ] explain the backend switch SQLite → PostgreSQL → MongoDB behind the contract.
- [ ] distinguish parameterized from assembled queries.
- [ ] keep secrets and test data out of the code and justify data minimization.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_03_Persistenzmodell-und-Backend-Abstraktion.md`. Der Copy-Paste-Prompt
für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_03_Persistenzmodell-und-Backend-Abstraktion.md`. The copy-paste prompt
for a later, manually started Spec Kit run is provided there.
