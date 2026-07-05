# Lernbegleiter: Secure InventoryHub 02 – Asset-/Software-Datenmodell und Status / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_02_Asset-Software-Datenmodell-und-Status.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Inventar ist nur so gut wie sein Datenmodell. Wenn nicht klar ist, welche Felder ein Asset hat,
welche Software zu welchem Gerät gehört und welche Statuswerte erlaubt sind, entsteht schnell ein
Datenchaos. Ein sauberes Datenmodell legt fest, welche Objekte es gibt, wie sie zusammenhängen und welche
Zustände (Status) sie durchlaufen dürfen. Datenqualitätsregeln sorgen dafür, dass keine widersprüchlichen
oder unvollständigen Einträge entstehen.

**EN:** An inventory is only as good as its data model. If it is unclear which fields an asset has, which
software belongs to which device, and which status values are allowed, data chaos quickly appears. A clean
data model defines which objects exist, how they relate, and which states (status) they may go through. Data
quality rules ensure that no contradictory or incomplete entries appear.

**DE:** In dieser Einheit lernst du, Assets, Softwarestände, Versionen und Verantwortliche zu modellieren,
erlaubte Statuswerte und Statusübergänge festzulegen und Datenqualitätsregeln zu formulieren.

**EN:** In this unit you learn to model assets, software versions, releases, and owners, to define allowed
status values and status transitions, and to formulate data quality rules.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Datenmodell / Data model | Beschreibung der Objekte, ihrer Felder und ihrer Beziehungen. |
| Beziehung / Relationship | Verbindung zwischen Objekten, z. B. „Software läuft auf Asset". |
| Statuswert / Status value | Erlaubter Zustand eines Objekts, z. B. `aktiv`, `wartung`, `ausgemustert`. |
| Statusübergang / Status transition | Erlaubter Wechsel von einem Zustand in einen anderen. |
| Pflichtfeld / Mandatory field | Feld, das nicht leer bleiben darf, damit der Datensatz gültig ist. |
| Datenqualitätsregel / Data quality rule | Regel, die widersprüchliche oder unvollständige Daten verhindert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Objekte und Felder bestimmen.** Lege für jedes Objekt die Felder fest. Ein Asset hat
z. B. `id`, `typ`, `standort`, `owner`. Eine Software hat `id`, `name`, `version`, `asset-ref`. Wähle für
jedes Feld einen klaren Datentyp und entscheide, ob es ein Pflichtfeld ist. Ein fehlendes Pflichtfeld macht
den Datensatz ungültig.

**EN:** **Step 1 – Determine objects and fields.** Define the fields for each object. An asset has, e.g.,
`id`, `type`, `location`, `owner`. A software has `id`, `name`, `version`, `asset-ref`. Choose a clear data
type for each field and decide whether it is a mandatory field. A missing mandatory field makes the record
invalid.

**DE:** **Schritt 2 – Beziehungen klären.** Software läuft auf einem Asset. Ein Asset hat einen
Verantwortlichen. Solche Beziehungen musst du eindeutig festlegen, sonst weiß niemand, welche Software zu
welchem Gerät gehört. Nutze Verweise (Referenzen) statt Daten doppelt zu speichern.

**EN:** **Step 2 – Clarify relationships.** Software runs on an asset. An asset has an owner. You must define
such relationships unambiguously, otherwise no one knows which software belongs to which device. Use
references instead of storing data twice.

**DE:** **Schritt 3 – Statuswerte und Übergänge festlegen.** Bestimme die erlaubten Zustände, z. B. `aktiv`,
`wartung`, `ausgemustert`. Danach legst du fest, welche Übergänge erlaubt sind. Warum? Ein Gerät sollte nicht
direkt von `ausgemustert` zurück auf `aktiv` springen, ohne dass jemand das bewusst freigibt. Eine
Statusmaschine mit klaren Übergängen verhindert unlogische Zustände.

**EN:** **Step 3 – Define status values and transitions.** Determine the allowed states, e.g. `active`,
`maintenance`, `retired`. Then define which transitions are allowed. Why? A device should not jump directly
from `retired` back to `active` without someone consciously approving it. A state machine with clear
transitions prevents illogical states.

**DE:** **Schritt 4 – Datenqualitätsregeln formulieren.** Beispiele: Jede Software muss auf ein existierendes
Asset zeigen. Eine Version darf nicht leer sein. Ein Standort muss aus einer erlaubten Liste stammen. Solche
Regeln schützen die **Integrität** der Daten und damit alle späteren Auswertungen und Entscheidungen.

**EN:** **Step 4 – Formulate data quality rules.** Examples: every software must point to an existing asset. A
version must not be empty. A location must come from an allowed list. Such rules protect the **integrity** of
the data and thus all later evaluations and decisions.

**DE:** **Typische Fehler.** Felder ohne Datentyp oder Pflichtangabe. Beziehungen nur im Kopf statt im Modell.
Beliebige Statuswerte ohne Übergangsregeln. Keine Regel gegen verwaiste Software (Software ohne gültiges
Asset). Daten doppelt speichern und dadurch inkonsistent werden lassen.

**EN:** **Common mistakes.** Fields without a data type or mandatory flag. Relationships only in your head
instead of in the model. Arbitrary status values without transition rules. No rule against orphaned software
(software without a valid asset). Storing data twice and letting it become inconsistent.

### Beispiel / Example

```text
Objekt Asset:     { id: "AST-001", typ: "Laptop", standort: "Halle-A", owner: "team-ops", status: "aktiv" }
Objekt Software:  { id: "SW-014", name: "OpenSSL", version: "3.0.13", asset_ref: "AST-001" }

Statuswerte:      aktiv, wartung, ausgemustert
Erlaubte Übergänge:
  aktiv      -> wartung        (ok)
  wartung    -> aktiv          (ok)
  aktiv      -> ausgemustert   (ok)
  ausgemustert -> aktiv        (NUR mit expliziter Freigabe -> sonst abgelehnt)

Datenqualitätsregel: asset_ref MUSS auf ein existierendes Asset zeigen  -> sonst UNGÜLTIG
Datenqualitätsregel: version darf nicht leer sein                        -> sonst UNGÜLTIG
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Das fachliche Datenmodell ist die Grundlage jeder Datenverwaltung. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Datenqualitätsregeln schützen die Integrität und damit den Schutzbedarf der Daten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, Bedrohungsmodellierung und
Sicherheits-Code-Review. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(Architektur-Grundlagen), `CL_04` (Bedrohungsmodellierung) und `CL_08` (Sicherheits-Code-Review). Die
Sicherheitsentscheidung dieser Einheit lautet: *Ungültige oder widersprüchliche Zustände werden durch das
Datenmodell verhindert, nicht erst nachträglich korrigiert.* A11Y-Aspekt: Statuswerte und Regeln müssen als
Text benannt werden, nicht nur über Farben oder Symbole, damit sie mit Screenreader oder Braille-Zeile
verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: secure architecture, threat modeling, and security code
review. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture basics), `CL_04` (threat
modeling), and `CL_08` (security code review). The security decision of this unit is: *invalid or
contradictory states are prevented by the data model, not corrected afterwards.* Accessibility aspect: status
values and rules must be named as text, not only through colors or symbols, so they stay understandable with a
screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Wozu dient ein Datenmodell in einem Inventarsystem? /
   **EN:** What is the purpose of a data model in an inventory system?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es legt fest, welche Objekte es gibt, welche Felder sie haben und wie sie zusammenhängen. So bleiben
   die Daten strukturiert, vergleichbar und auswertbar.
   **EN:** It defines which objects exist, which fields they have, and how they relate. This keeps the data
   structured, comparable, and evaluable.

   </details>

2. **DE:** Warum sind Pflichtfelder wichtig? /
   **EN:** Why are mandatory fields important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie verhindern unvollständige Datensätze. Ohne die wichtigsten Felder (z. B. Kennung oder Version)
   ist ein Eintrag nicht identifizierbar oder auswertbar.
   **EN:** They prevent incomplete records. Without the key fields (e.g. identifier or version) an entry is
   not identifiable or evaluable.

   </details>

3. **DE:** Warum sollten Statusübergänge eingeschränkt werden? /
   **EN:** Why should status transitions be restricted?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Uneingeschränkte Übergänge erlauben unlogische Zustände, z. B. ein ausgemustertes Gerät ohne
   Freigabe wieder aktiv. Klare Übergänge machen den Lebenszyklus nachvollziehbar und sicher.
   **EN:** Unrestricted transitions allow illogical states, e.g. a retired device becoming active again
   without approval. Clear transitions make the lifecycle traceable and safe.

   </details>

4. **DE:** Was ist eine verwaiste Software, und wie verhindert man sie? /
   **EN:** What is orphaned software, and how do you prevent it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Verwaiste Software zeigt auf kein gültiges Asset. Eine Datenqualitätsregel, die jeden `asset-ref`
   gegen existierende Assets prüft, verhindert das.
   **EN:** Orphaned software points to no valid asset. A data quality rule that checks every `asset-ref`
   against existing assets prevents it.

   </details>

5. **DE:** Warum ist es besser, Beziehungen über Verweise als über doppelte Daten abzubilden? /
   **EN:** Why is it better to model relationships with references than with duplicated data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Doppelte Daten geraten mit der Zeit auseinander und werden inkonsistent. Ein Verweis auf eine
   eindeutige Kennung hält die Information an einer Stelle und bleibt konsistent.
   **EN:** Duplicated data drifts apart over time and becomes inconsistent. A reference to a unique identifier
   keeps the information in one place and stays consistent.

   </details>

6. **DE:** (DPA) Wie hängt Datenqualität mit der Aussagekraft späterer Kennzahlen zusammen? /
   **EN:** (DPA) How does data quality relate to the meaningfulness of later metrics?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kennzahlen sind nur so gut wie die zugrunde liegenden Daten. Unvollständige oder falsche Felder
   verfälschen z. B. Patchquoten oder Bestandszahlen und führen zu falschen Entscheidungen.
   **EN:** Metrics are only as good as the underlying data. Incomplete or wrong fields distort, e.g., patch
   rates or asset counts and lead to wrong decisions.

   </details>

7. **DE:** Warum ist ein sauberes Datenmodell auch eine Sicherheitsmaßnahme? /
   **EN:** Why is a clean data model also a security measure?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es schützt die Integrität der Daten: unmögliche Zustände und widersprüchliche Einträge werden schon
   im Modell verhindert, nicht erst nachträglich entdeckt. Das reduziert Fehler- und Manipulationsspielraum.
   **EN:** It protects data integrity: impossible states and contradictory entries are prevented already in the
   model, not discovered afterwards. This reduces room for errors and manipulation.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] für Asset und Software je die wichtigsten Felder und Datentypen angeben.
- [ ] Pflichtfelder von optionalen Feldern unterscheiden.
- [ ] eine Beziehung zwischen zwei Objekten über einen Verweis beschreiben.
- [ ] erlaubte Statuswerte und Statusübergänge festlegen.
- [ ] mindestens zwei Datenqualitätsregeln formulieren.

**EN:** I can …

- [ ] name the key fields and data types for asset and software.
- [ ] tell mandatory fields from optional ones.
- [ ] describe a relationship between two objects via a reference.
- [ ] define allowed status values and status transitions.
- [ ] formulate at least two data quality rules.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_02_Asset-Software-Datenmodell-und-Status.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_02_Asset-Software-Datenmodell-und-Status.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
