# Lernbegleiter: Secure CaseTracker Application Track 06 – Persistenz, Migrationen und Datenintegrität / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_06_Persistenz-Migrationen-und-Datenintegritaet.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Daten müssen dauerhaft gespeichert werden – das nennt man **Persistenz**. Ändert sich das Datenmodell
(neues Feld, neue Regel), braucht man eine **Migration**: einen geplanten Umbau der gespeicherten Daten, ohne
sie zu verlieren oder zu verfälschen. Und über all dem steht die **Datenintegrität**: Die gespeicherten Daten
müssen jederzeit widerspruchsfrei und regelkonform sein. Bild dazu: ein Umzug eines vollen Aktenschranks. Man
kann nicht einfach die Schubladen austauschen; man muss planen, wie jede Akte sicher an ihren neuen Platz
kommt – und man braucht einen Plan, falls der Umzug schiefgeht (**Rollback**).

**EN:** Data must be stored permanently – this is called **persistence**. When the data model changes (new
field, new rule), you need a **migration**: a planned rebuild of the stored data without losing or corrupting
it. Above all this stands **data integrity**: the stored data must be consistent and rule-conforming at all
times. The picture: moving a full filing cabinet. You cannot just swap the drawers; you must plan how each
file gets safely to its new place – and you need a plan if the move goes wrong (**rollback**).

**DE:** Du lernst, Migrationen sicher und wiederholbar zu planen, Integritätsregeln festzulegen und
Testdaten so zu gestalten, dass keine echten personenbezogenen Daten verwendet werden.

**EN:** You learn to plan migrations safely and repeatably, to define integrity rules, and to design test data
so that no real personal data is used.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Persistenz / Persistence | Dauerhaftes Speichern von Daten über die Programmlaufzeit hinaus. |
| Migration / Migration | Geplante, versionierte Änderung des Datenmodells und der Bestandsdaten. |
| Datenintegrität / Data integrity | Zustand, in dem Daten widerspruchsfrei und regelkonform sind. |
| Constraint / Constraint | Regel in der Speicherung, die ungültige Daten von vornherein verhindert. |
| Rollback / Rollback | Geplantes Zurücksetzen auf einen sicheren Vorzustand bei Fehler. |
| Idempotenz / Idempotence | Eigenschaft, dass wiederholtes Ausführen dasselbe sichere Ergebnis liefert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Datenmodell und Integritätsregeln festlegen.** Bestimme Felder, Typen, Pflichtangaben
und **Constraints** (z. B. Status nur aus erlaubter Liste, eindeutige Fall-ID). Warum Constraints in der
Speicherung? Sie verhindern ungültige Daten auch dann, wenn die Anwendungslogik einmal versagt – eine zweite
Schutzschicht (Defense in Depth).

**EN:** **Step 1 – Define the data model and integrity rules.** Determine fields, types, mandatory entries,
and **constraints** (e.g. status only from an allowed list, unique case ID). Why constraints in storage? They
prevent invalid data even if the application logic fails once – a second protective layer (defense in depth).

**DE:** **Schritt 2 – Migration versioniert und wiederholbar planen.** Jede Migration bekommt eine Version und
läuft in einer festen Reihenfolge. Sie sollte **idempotent** sein: Ein zweiter Lauf darf keinen Schaden
anrichten. So bleibt der Zustand nachvollziehbar und reproduzierbar.

**EN:** **Step 2 – Plan the migration versioned and repeatable.** Every migration gets a version and runs in a
fixed order. It should be **idempotent**: a second run must cause no harm. This keeps the state traceable and
reproducible.

**DE:** **Schritt 3 – Rollback-Annahmen dokumentieren.** Plane vorher, was passiert, wenn eine Migration
scheitert: Zurücksetzen auf den Vorzustand, aus einem Backup, oder Vorwärtsreparatur. Ohne dokumentierte
Rollback-Annahme ist ein Fehler mitten in der Migration ein Datenverlustrisiko.

**EN:** **Step 3 – Document rollback assumptions.** Plan in advance what happens if a migration fails: revert
to the previous state, restore from a backup, or forward-fix. Without a documented rollback assumption, an
error mid-migration is a data-loss risk.

**DE:** **Schritt 4 – Integritätstests und sichere Testdaten.** Schreibe Tests, die prüfen, dass Constraints
greifen und dass die Migration Bestandsdaten korrekt überführt. Verwende ausschließlich synthetische
Testdaten, keine echten personenbezogenen Daten.

**EN:** **Step 4 – Integrity tests and safe test data.** Write tests that check constraints hold and that the
migration transforms existing data correctly. Use only synthetic test data, no real personal data.

**DE:** **Typische Fehler.** Migration ohne Version und Reihenfolge. Kein Rollback-Plan. Constraints nur in
der Anwendung, nicht in der Speicherung. Migration nicht idempotent, sodass ein zweiter Lauf Daten doppelt
anlegt. Echte personenbezogene Testdaten. Keine Integritätstests.

**EN:** **Common mistakes.** Migration without version and order. No rollback plan. Constraints only in the
application, not in storage. Migration not idempotent, so a second run duplicates data. Real personal test
data. No integrity tests.

### Beispiel / Example

```text
Migration v3: Feld "priority" hinzufügen, Standardwert "normal", Constraint erlaubte Werte.

Ablaufplan (idempotent):
  1. Prüfen, ob Spalte "priority" existiert -> falls ja, nichts tun (zweiter Lauf sicher).
  2. Spalte anlegen, Standard "normal" setzen.
  3. Constraint: priority IN (niedrig, normal, hoch).
  4. Integritätstest: Datensatz mit priority="dringend" -> ABGELEHNT.

Rollback-Annahme: Bei Fehler in Schritt 2/3 -> Spalte entfernen, Vorzustand
   aus Backup wiederherstellen. Kein Teilzustand bleibt bestehen.

Testdaten: synthetische Fälle (Fall-0001 ... Fall-0100), keine echten Personendaten.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11a Funktionalität in Anwendungen realisieren | Primär / Primary | Sichere Persistenz und Migrationen sind Kernfunktionalität, die verlässlich und getestet realisiert wird. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Datenmodell, Constraints und Migration sind unmittelbar das Anpassen der Datenverwaltung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenintegrität, Defense in Depth und Datenschutz durch
synthetische Testdaten. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review) und `CL_10` (Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser
Einheit lautet: *Constraints und Migrationen sichern die Daten in einer zweiten Schicht, und ein Rollback ist
vorab geplant.* A11Y-Aspekt: Migrations- und Rollback-Pläne werden als nummerierte Textschritte dargestellt,
nicht nur als Diagramm, damit sie mit Screenreader und Braille-Zeile Schritt für Schritt nachvollziehbar sind.

**EN:** Relation to the Secure Development Guideline: data integrity, defense in depth, and privacy through
synthetic test data. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review),
and `CL_10` (secure development environment). The security decision of this unit is: *constraints and
migrations protect the data in a second layer, and a rollback is planned in advance.* Accessibility aspect:
migration and rollback plans are presented as numbered text steps, not only as a diagram, so they can be
followed step by step with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum gehören Constraints in die Speicherung und nicht nur in die Anwendung? /
   **EN:** Why do constraints belong in storage and not only in the application?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie bilden eine zweite Schutzschicht (Defense in Depth). Versagt die Anwendungslogik oder greift ein
   Zugriff daran vorbei, verhindert die Speicherung trotzdem ungültige Daten.
   **EN:** They form a second protective layer (defense in depth). If the application logic fails or an access
   bypasses it, storage still prevents invalid data.

   </details>

2. **DE:** Warum sollte eine Migration idempotent sein? /
   **EN:** Why should a migration be idempotent?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein zweiter Lauf (nach Abbruch oder Neustart) darf keinen Schaden anrichten, z. B. keine doppelten
   Daten. Idempotenz macht Migrationen sicher wiederholbar.
   **EN:** A second run (after an abort or restart) must cause no harm, e.g. no duplicated data. Idempotence
   makes migrations safely repeatable.

   </details>

3. **DE:** Warum ist ein dokumentierter Rollback-Plan wichtig? /
   **EN:** Why is a documented rollback plan important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Scheitert eine Migration mittendrin, drohen Teilzustände und Datenverlust. Ein Rollback-Plan legt
   vorher fest, wie ein sicherer Vorzustand wiederhergestellt wird.
   **EN:** If a migration fails midway, partial states and data loss threaten. A rollback plan defines in
   advance how a safe previous state is restored.

   </details>

4. **DE:** Warum verwendest du nur synthetische Testdaten? /
   **EN:** Why do you use only synthetic test data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Echte personenbezogene Daten in Tests verletzen den Datenschutz und können ungewollt kopiert oder
   geloggt werden. Synthetische Daten sind sicher und trotzdem realistisch genug.
   **EN:** Real personal data in tests violates privacy and can be copied or logged unintentionally. Synthetic
   data is safe and still realistic enough.

   </details>

5. **DE:** Was beweist ein Integritätstest, den ein reiner Erfolgstest nicht zeigt? /
   **EN:** What does an integrity test prove that a plain success test does not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er beweist, dass Constraints ungültige Daten wirklich ablehnen und die Migration Bestandsdaten
   korrekt überführt. Ein Erfolgstest zeigt nur den einfachen guten Fall.
   **EN:** It proves that constraints really reject invalid data and the migration transforms existing data
   correctly. A success test shows only the simple good case.

   </details>

6. **DE:** Wie hängt diese Einheit mit dem Anpassen der Datenverwaltung (LF 5) zusammen? /
   **EN:** How does this unit relate to adapting the data management (LF 5)?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Datenmodell, Constraints und Migration sind konkrete Anpassungen der Datenverwaltungs-Software mit
   dem Ziel, Daten sicher und integer zu halten.
   **EN:** Data model, constraints, and migration are concrete adaptations of the data-management software with
   the goal of keeping data safe and consistent.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] ein Datenmodell mit Integritätsregeln und Constraints festlegen.
- [ ] eine Migration versioniert, geordnet und idempotent planen.
- [ ] eine Rollback-Annahme dokumentieren.
- [ ] Integritätstests und synthetische Testdaten benennen.
- [ ] erklären, warum Constraints eine zweite Schutzschicht bilden.

**EN:** I can …

- [ ] define a data model with integrity rules and constraints.
- [ ] plan a migration versioned, ordered, and idempotent.
- [ ] document a rollback assumption.
- [ ] name integrity tests and synthetic test data.
- [ ] explain why constraints form a second protective layer.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_06_Persistenz-Migrationen-und-Datenintegritaet.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_06_Persistenz-Migrationen-und-Datenintegritaet.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
