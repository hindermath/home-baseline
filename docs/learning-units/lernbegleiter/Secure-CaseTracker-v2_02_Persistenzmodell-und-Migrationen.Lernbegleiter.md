# Lernbegleiter: Secure CaseTracker v2 02 – Persistenzmodell und Migrationen / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_02_Persistenzmodell-und-Migrationen.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Daten müssen gespeichert werden, damit sie nach dem Schließen des Programms noch da sind. Diese
dauerhafte Speicherung heißt **Persistenz**. Aber Software ändert sich: Ein Feld kommt hinzu, ein Status
wird umbenannt, eine Regel wird strenger. Damit alte gespeicherte Daten weiter passen, braucht man
**Migrationen** – geplante, nachvollziehbare Schritte, die den Datenbestand von einer Version in die
nächste überführen. Ohne Plan gehen bei Änderungen Daten verloren oder werden falsch interpretiert.

**EN:** Data must be stored so it is still there after the program closes. This durable storage is called
**persistence**. But software changes: a field is added, a status is renamed, a rule becomes stricter. So
that old stored data still fits, you need **migrations** – planned, traceable steps that move the data set
from one version to the next. Without a plan, changes lose data or interpret it wrongly.

**DE:** In dieser Einheit planst du **Entitäten** (die Dinge, die du speicherst, z. B. Fall, Notiz, Status),
ihre **Beziehungen**, die **Pflichtfelder**, die **Migrationsregeln** und ein **Rollback** (das
kontrollierte Zurücknehmen einer Änderung). Ein Leitgedanke ist **Datenminimierung**: nur speichern, was
wirklich gebraucht wird.

**EN:** In this unit you plan **entities** (the things you store, e.g. case, note, status), their
**relationships**, the **mandatory fields**, the **migration rules**, and a **rollback** (the controlled
undoing of a change). A guiding idea is **data minimization**: store only what is really needed.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Persistenz / Persistence | Dauerhafte Speicherung von Daten über die Programmlaufzeit hinaus. |
| Entität / Entity | Abgegrenztes Datenobjekt mit Feldern, z. B. ein Fall oder eine Notiz. |
| Migration / Migration | Geplanter Schritt, der Daten von einer Version in die nächste überführt. |
| Rollback / Rollback | Kontrolliertes Zurücknehmen einer Änderung in einen sicheren Zustand. |
| Datenminimierung / Data minimization | Nur die Daten speichern, die für den Zweck nötig sind. |
| Integrität / Integrity | Eigenschaft, dass Daten unverfälscht und in sich stimmig bleiben. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Entitäten und Felder festlegen.** Liste die Dinge, die du speicherst, und je Ding die
Felder mit Typ und Bedeutung. Markiere Pflichtfelder. **Warum wichtig:** Ein klares Modell verhindert
Wildwuchs und macht Validierung planbar. Frage bei jedem Feld: *Brauche ich es wirklich?* (Datenminimierung).

**EN:** **Step 1 – Define entities and fields.** List the things you store and, per thing, the fields with
type and meaning. Mark mandatory fields. **Why it matters:** a clear model prevents sprawl and makes
validation plannable. Ask for every field: *do I really need it?* (data minimization).

**DE:** **Schritt 2 – Beziehungen ordnen.** Beschreibe, wie Entitäten zusammenhängen: Ein Fall *hat* mehrere
Notizen; ein Fall *hat genau einen* Status. **Warum wichtig:** Klare Beziehungen verhindern verwaiste Daten
(eine Notiz ohne Fall) und sind die Grundlage für Integrität.

**EN:** **Step 2 – Order the relationships.** Describe how entities relate: a case *has* several notes; a case
*has exactly one* status. **Why it matters:** clear relationships prevent orphaned data (a note without a
case) and are the basis for integrity.

**DE:** **Schritt 3 – Migrationen planen.** Für jede geplante Änderung schreibst du auf: *Von* welcher
Version *zu* welcher, *welche* Felder betroffen sind, *wie* Altdaten behandelt werden (Standardwert,
Umrechnung, Löschung). **Warum wichtig:** Eine Migration ist ein Vertrag mit den vorhandenen Daten. Ohne ihn
brechen alte Datensätze oder die Bedeutung eines Feldes verschiebt sich still.

**EN:** **Step 3 – Plan migrations.** For every planned change you write down: *from* which version *to*
which, *which* fields are affected, *how* old data is handled (default value, conversion, deletion). **Why it
matters:** a migration is a contract with the existing data. Without it, old records break or the meaning of
a field shifts silently.

**DE:** **Schritt 4 – Rollback und Testdaten mitdenken.** Plane, wie du eine fehlerhafte Migration
zurücknimmst, ohne Daten zu verlieren (z. B. Sicherung vorher). Nutze nur **synthetische Testdaten**, keine
echten personenbezogenen Daten. **Warum wichtig:** Migrationen laufen auf echten Beständen; ein Fehler ohne
Rollback ist teuer.

**EN:** **Step 4 – Consider rollback and test data.** Plan how you undo a faulty migration without losing
data (e.g. a backup beforehand). Use only **synthetic test data**, no real personal data. **Why it matters:**
migrations run on real data sets; a mistake without rollback is expensive.

**DE:** **Typische Fehler.** Felder speichern, die nie gebraucht werden. Migrationen nur „im Kopf“ haben
statt aufgeschrieben. Kein Rollback planen. Echte personenbezogene Testdaten verwenden. Bedeutung eines
Statuswerts ändern, ohne Altdaten umzurechnen.

**EN:** **Common mistakes.** Storing fields that are never used. Having migrations only "in your head"
instead of written down. Planning no rollback. Using real personal test data. Changing the meaning of a
status value without converting old data.

### Beispiel / Example

```text
Entitaet Fall (case):
  id            Pflicht  eindeutige Kennung
  status        Pflicht  Allowlist { offen, in Arbeit, geschlossen }
  angelegt_am   Pflicht  Datum
  bearbeiter    optional Pseudonym, KEIN echter Name (Datenminimierung)

Beziehung: Fall 1 --- n Notiz   (eine Notiz gehoert immer zu genau einem Fall)

Migration v1 -> v2: Status "erledigt" wird zu "geschlossen"
  Betroffen:   Feld status
  Altdaten:    alle "erledigt" -> "geschlossen" umrechnen
  Rollback:    Sicherung vor der Migration; bei Fehler zuruecksetzen
  Testdaten:   nur synthetische Faelle, keine echten Personen
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Persistenz und Migrationen sind der Kern der datenverwaltenden Software. |
| LF 8 Daten systemübergreifend bereitstellen | Berührt / Touched | Ein stabiles Datenmodell ist Voraussetzung für spätere systemübergreifende Bereitstellung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, Integrität, Datenschutz durch
Datenminimierung und auditfähige Nachweise. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02`
(sichere Programmierung), `CL_04` (Bedrohungsmodellierung), `CL_08` (Sicherheits-Code-Review) und `CL_10`
(Datenschutz). Die Sicherheitsentscheidung dieser Einheit lautet: *Speichere so wenig personenbezogene Daten
wie möglich, und verändere Daten nur über nachvollziehbare Migrationen.* A11Y-Aspekt: Das Datenmodell und
die Migrationsschritte müssen als klare Tabellen und Listen lesbar sein, damit sie auch mit Screenreader und
Braille-Zeile verständlich bleiben.

**EN:** Relation to the Secure Development Guideline: secure coding, integrity, privacy through data
minimization, and auditable evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (secure
coding), `CL_04` (threat modeling), `CL_08` (security code review), and `CL_10` (privacy). The security
decision of this unit is: *store as little personal data as possible, and change data only through traceable
migrations.* Accessibility aspect: the data model and migration steps must be readable as clear tables and
lists so they remain understandable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist eine geplante Migration besser als eine spontane Änderung am Datenbestand? /
   **EN:** Why is a planned migration better than a spontaneous change to the data set?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine geplante Migration ist ein aufgeschriebener Vertrag mit den vorhandenen Daten: Sie beschreibt
   Ausgangs- und Zielversion, betroffene Felder und die Behandlung von Altdaten. Spontane Änderungen brechen
   alte Datensätze oder verschieben still die Bedeutung.
   **EN:** A planned migration is a written contract with the existing data: it describes source and target
   version, affected fields, and the handling of old data. Spontaneous changes break old records or silently
   shift meaning.

   </details>

2. **DE:** Was bedeutet Datenminimierung, und warum ist sie hier wichtig? /
   **EN:** What does data minimization mean, and why is it important here?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur speichern, was für den Zweck nötig ist. Weniger personenbezogene Daten bedeuten weniger Risiko
   bei einem Leck und einfachere Einhaltung des Datenschutzes.
   **EN:** Store only what is needed for the purpose. Less personal data means less risk in a leak and easier
   privacy compliance.

   </details>

3. **DE:** (AE) Wie beeinflusst das Datenmodell die spätere Implementierung der Validierung? /
   **EN:** (AE) How does the data model influence the later implementation of validation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Pflichtfelder, Typen und Allowlists aus dem Modell werden direkt zu Validierungsregeln in der
   Kernlogik. Ein klares Modell macht die Prüfung vollständig und planbar.
   **EN:** Mandatory fields, types, and allow-lists from the model become validation rules directly in the core
   logic. A clear model makes the check complete and plannable.

   </details>

4. **DE:** (DPA) Warum dürfen für Migrationstests keine echten personenbezogenen Daten benutzt werden? /
   **EN:** (DPA) Why must no real personal data be used for migration tests?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte Daten in Test- oder Übungsumgebungen erhöhen das Leck-Risiko und verletzen den Datenschutz.
   Synthetische Daten liefern denselben Testwert ohne Personenbezug.
   **EN:** Real data in test or practice environments increases the leak risk and violates privacy. Synthetic
   data provides the same test value without a personal reference.

   </details>

5. **DE:** (SI) Welche Betriebsannahme braucht ein sicheres Rollback? /
   **EN:** (SI) Which operational assumption does a safe rollback need?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Sicherung des Datenbestands vor der Migration und ein klarer Rückweg. Nur so kann man eine
   fehlerhafte Migration ohne Datenverlust zurücknehmen.
   **EN:** A backup of the data set before the migration and a clear return path. Only then can a faulty
   migration be undone without data loss.

   </details>

6. **DE:** Warum sind klare Beziehungen zwischen Entitäten eine Frage der Integrität? /
   **EN:** Why are clear relationships between entities a matter of integrity?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Klare Beziehungen verhindern verwaiste oder widersprüchliche Daten (z. B. eine Notiz ohne Fall). So
   bleibt der Datenbestand in sich stimmig.
   **EN:** Clear relationships prevent orphaned or contradictory data (e.g. a note without a case). This keeps
   the data set internally consistent.

   </details>

7. **DE:** Warum sollte jede geplante Änderung als `Applicable`, `N/A` oder `Open` mit Begründung dokumentiert
   werden? /
   **EN:** Why should every planned change be documented as `Applicable`, `N/A`, or `Open` with a rationale?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** So bleibt die Bewertung auditfähig und nachvollziehbar. Offene Punkte werden nicht vergessen,
   sondern mit Folgeaktion sichtbar gehalten.
   **EN:** This keeps the assessment auditable and traceable. Open points are not forgotten but kept visible
   with a follow-up action.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Entitäten mit Feldern, Typen und Pflichtangaben beschreiben.
- [ ] Beziehungen zwischen Entitäten korrekt benennen.
- [ ] eine Migration mit Ausgangs-, Zielversion und Altdatenbehandlung planen.
- [ ] ein Rollback und synthetische Testdaten mitdenken.
- [ ] Datenminimierung an jedem Feld begründen.

**EN:** I can …

- [ ] describe entities with fields, types, and mandatory markers.
- [ ] correctly name relationships between entities.
- [ ] plan a migration with source version, target version, and old-data handling.
- [ ] consider a rollback and synthetic test data.
- [ ] justify data minimization for each field.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_02_Persistenzmodell-und-Migrationen.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_02_Persistenzmodell-und-Migrationen.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
