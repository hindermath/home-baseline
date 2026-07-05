# Lernbegleiter: Secure CaseTracker 03 – Eingabevalidierung und Trust Boundaries / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_03_Eingabevalidierung-und-Trust-Boundaries.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Programm bekommt Daten von außen: eine Person tippt etwas ein, eine Datei wird importiert,
später ruft vielleicht eine Schnittstelle die Anwendung auf. Alles, was von außen kommt, ist zunächst
**nicht vertrauenswürdig**. Die Stelle, an der nicht vertrauenswürdige Daten in einen geschützteren
Bereich übergehen, heißt **Vertrauensgrenze** (Trust Boundary). Genau dort muss geprüft werden. Viele
Sicherheitslücken entstehen, weil an dieser Grenze nichts oder zu wenig geprüft wird.

**EN:** A program receives data from outside: a person types something, a file is imported, and later an
interface may call the application. Everything that comes from outside is initially **not trustworthy**.
The place where untrusted data crosses into a more protected area is called a **trust boundary**. That is
exactly where checks must happen. Many security holes appear because nothing, or too little, is checked at
this boundary.

**DE:** In dieser Einheit lernst du, alle Eingänge des Secure CaseTracker zu benennen, für jeden Eingang
klare Validierungsregeln zu planen und Fehlermeldungen so zu gestalten, dass sie verständlich sind, aber
keine internen Details verraten.

**EN:** In this unit you learn to name all inputs of the Secure CaseTracker, to plan clear validation rules
for each input, and to design error messages that are understandable but do not reveal internal details.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Vertrauensgrenze / Trust boundary | Grenze zwischen nicht vertrauenswürdigen und geprüften Daten. |
| Validierung / Validation | Prüfung, ob eine Eingabe erlaubt, sinnvoll und sicher ist. |
| Allowlist / Allow-list | Liste erlaubter Werte; alles andere wird abgelehnt. |
| Kanonisierung / Canonicalization | Pfad oder Wert auf eine eindeutige Normalform bringen, bevor man ihn prüft. |
| Log-Injection | Angriff, bei dem manipulierte Eingaben das Protokoll verfälschen. |
| Negativtest / Negative test | Test, der prüft, dass ungültige Eingaben korrekt abgelehnt werden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Eingänge finden.** Liste jeden Weg auf, über den Daten ins System kommen: manuelle
Eingabe (Fall-ID, Status, Freitext, Datum), Dateiimport (z. B. CSV) und spätere API- oder CLI-Parameter.
Jeder Eingang ist eine Vertrauensgrenze. Was du nicht benennst, kannst du nicht schützen.

**EN:** **Step 1 – Find the inputs.** List every path through which data enters the system: manual input
(case ID, status, free text, date), file import (e.g. CSV), and later API or CLI parameters. Each input is a
trust boundary. What you do not name, you cannot protect.

**DE:** **Schritt 2 – Regeln je Eingang festlegen.** Prüfe lieber gegen eine **Allowlist** als gegen eine
Verbotsliste. Beispiele: Eine Fall-ID hat ein festes Format. Ein Status darf nur einer der erlaubten Werte
sein (`offen`, `in Arbeit`, `geschlossen`). Freitext hat eine Höchstlänge und wird gegen Steuerzeichen
geprüft. Ein Datum muss ein gültiges, plausibles Datum sein. Ein Dateipfad wird **kanonisiert** und darf
nur in ein erlaubtes Verzeichnis zeigen.

**EN:** **Step 2 – Define rules per input.** Prefer an **allow-list** over a deny-list. Examples: a case ID
has a fixed format. A status may only be one of the allowed values (`open`, `in progress`, `closed`). Free
text has a maximum length and is checked against control characters. A date must be a valid, plausible date.
A file path is **canonicalized** and may only point into an allowed directory.

**DE:** **Schritt 3 – Warum an der Grenze und in der Kernlogik prüfen?** Prüfungen in der Oberfläche sind
Komfort, kein Schutz. Sie lassen sich umgehen. Deshalb muss die eigentliche Regel dort liegen, wo die
Daten wirklich verarbeitet werden – in der Kernlogik oder serverseitig. Sonst schützt die Prüfung nur den
ehrlichen Nutzer, nicht das System.

**EN:** **Step 3 – Why check at the boundary and in the core logic?** Checks in the user interface are
convenience, not protection. They can be bypassed. Therefore the real rule must live where the data is
actually processed – in the core logic or server-side. Otherwise the check only protects the honest user, not
the system.

**DE:** **Schritt 4 – Sichere Fehlermeldungen.** Eine gute Fehlermeldung sagt, *was* falsch war, aber nicht
*wie das System innen aussieht*. Kein Stack-Trace, kein interner Pfad, keine Datenbankmeldung. Wiederhole
außerdem keine personenbezogenen Daten unnötig. Begrenze Freitext, damit niemand über eine Eingabe das
Protokoll fälschen kann (Log-Injection).

**EN:** **Step 4 – Safe error messages.** A good error message says *what* was wrong, but not *what the
system looks like inside*. No stack trace, no internal path, no database message. Also do not repeat personal
data unnecessarily. Limit free text so that no one can forge the log through an input (log injection).

**DE:** **Typische Fehler.** Nur Erfolgspfade testen. Nur in der Oberfläche prüfen. Dateipfade ohne
Kanonisierung akzeptieren (`../` erlaubt dann den Ausbruch aus dem Zielordner). Fehlermeldungen mit
internen Details. Freitext ohne Längengrenze.

**EN:** **Common mistakes.** Testing only success paths. Checking only in the UI. Accepting file paths
without canonicalization (`../` then allows escaping the target folder). Error messages with internal
details. Free text without a length limit.

### Beispiel / Example

```text
Eingabe (Status):     "GESCHLOSSEN; rm -rf /"
Regel:                Allowlist { offen, in Arbeit, geschlossen }, Vergleich ohne Sonderzeichen
Ergebnis:             ABGELEHNT
Sichere Meldung:      "Ungültiger Status. Erlaubt: offen, in Arbeit, geschlossen."
Unsichere Meldung:    "SQL error near ';': parse failed at /app/db/cases.sql:42"  (NICHT so!)

Eingabe (Dateipfad):  "../../etc/passwd"
Regel:                Pfad kanonisieren, dann prüfen: liegt er im erlaubten Import-Ordner?
Ergebnis:             ABGELEHNT (zeigt aus dem erlaubten Verzeichnis heraus)
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Vertrauensgrenzen und Eingabeprüfung sind die praktische Umsetzung einer Schutzbedarfsanalyse. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Validierung schützt die Datenverwaltung vor fehlerhaften und schädlichen Daten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Secure Coding, Trust Boundaries und sichere
Fehlerbehandlung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04`
(Bedrohungsmodellierung) und `CL_08` (Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser Einheit
lautet: *An jeder Vertrauensgrenze wird geprüft, bevor Daten verarbeitet werden.* A11Y-Aspekt:
Fehlermeldungen müssen klar, textbasiert und ohne reine Farbsignale verständlich sein, damit sie auch mit
Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure coding, trust boundaries, and safe error
handling. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat modeling), and `CL_08`
(security code review). The security decision of this unit is: *every trust boundary is checked before data is
processed.* Accessibility aspect: error messages must be clear, text-based, and understandable without
color-only signals, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was ist eine Vertrauensgrenze, und warum ist gerade sie der richtige Ort für Prüfungen? /
   **EN:** What is a trust boundary, and why is it the right place for checks?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Vertrauensgrenze ist der Übergang von nicht vertrauenswürdigen Daten in einen geschützten
   Bereich. Dort ist die Prüfung sinnvoll, weil danach die Daten als geprüft gelten und weiterverarbeitet
   werden. Prüft man erst später, sind die Daten schon in der Logik.
   **EN:** A trust boundary is the crossing from untrusted data into a protected area. Checking there makes
   sense because afterwards the data counts as validated and is processed further. Checking later means the
   data is already inside the logic.

   </details>

2. **DE:** Warum ist eine Allowlist meist sicherer als eine Verbotsliste? /
   **EN:** Why is an allow-list usually safer than a deny-list?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Allowlist erlaubt nur bekannte gute Werte; alles Unbekannte wird abgelehnt. Eine Verbotsliste
   muss jeden schlechten Fall kennen und vergisst leicht einen. Neue Angriffe umgehen Verbotslisten oft.
   **EN:** An allow-list permits only known-good values; anything unknown is rejected. A deny-list must know
   every bad case and easily misses one. New attacks often bypass deny-lists.

   </details>

3. **DE:** Warum reicht eine Prüfung nur in der Benutzeroberfläche nicht aus? /
   **EN:** Why is a check only in the user interface not enough?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Oberfläche lässt sich umgehen, z. B. über direkte API-Aufrufe, Dateiimport oder CLI. Die
   verbindliche Regel muss in der Kernlogik oder serverseitig liegen, wo die Daten wirklich verarbeitet
   werden.
   **EN:** The UI can be bypassed, e.g. via direct API calls, file import, or CLI. The binding rule must be in
   the core logic or server-side, where the data is really processed.

   </details>

4. **DE:** Welche Angabe darf eine Fehlermeldung nicht enthalten, und warum? /
   **EN:** What must an error message not contain, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine internen Details wie Stack-Traces, Dateipfade, Datenbankmeldungen oder unnötige
   personenbezogene Daten. Solche Angaben helfen Angreifern und verletzen den Datenschutz.
   **EN:** No internal details such as stack traces, file paths, database messages, or unnecessary personal
   data. Such information helps attackers and violates privacy.

   </details>

5. **DE:** Warum muss ein Dateipfad vor der Prüfung kanonisiert werden? /
   **EN:** Why must a file path be canonicalized before it is checked?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Kanonisierung kann `../` aus dem erlaubten Verzeichnis herausführen. Erst die Normalform
   zeigt den echten Zielpfad, den man dann gegen den erlaubten Ordner prüfen kann.
   **EN:** Without canonicalization, `../` can lead out of the allowed directory. Only the normal form shows
   the real target path, which can then be checked against the allowed folder.

   </details>

6. **DE:** (DPA) Wie beeinflussen ungültige Eingaben spätere Kennzahlen? /
   **EN:** (DPA) How do invalid inputs affect later metrics?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ungültige oder unplausible Daten verfälschen Durchlaufzeit, Fehlerquote und Fallzahlen. Schlechte
   Eingabequalität führt zu falschen Auswertungen und falschen Entscheidungen.
   **EN:** Invalid or implausible data distorts throughput time, error rate, and case counts. Poor input
   quality leads to wrong evaluations and wrong decisions.

   </details>

7. **DE:** Warum gehört zu jeder kritischen Eingabeart mindestens ein Negativtest? /
   **EN:** Why does every critical input type need at least one negative test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Negativtest beweist, dass ungültige Eingaben wirklich abgelehnt werden. Nur Erfolgspfade zu
   testen zeigt nicht, ob der Schutz greift.
   **EN:** A negative test proves that invalid inputs are really rejected. Testing only success paths does not
   show whether the protection works.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] alle Eingänge des Systems benennen und je Eingang eine Vertrauensgrenze zeigen.
- [ ] für jede Eingabeart mindestens eine Validierungsregel formulieren.
- [ ] erklären, warum die Regel in der Kernlogik liegen muss.
- [ ] eine sichere von einer unsicheren Fehlermeldung unterscheiden.
- [ ] je kritischer Eingabeart einen Negativtest angeben.

**EN:** I can …

- [ ] name all system inputs and show a trust boundary for each.
- [ ] state at least one validation rule per input type.
- [ ] explain why the rule must live in the core logic.
- [ ] tell a safe error message from an unsafe one.
- [ ] give a negative test for each critical input type.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_03_Eingabevalidierung-und-Trust-Boundaries.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_03_Eingabevalidierung-und-Trust-Boundaries.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
