# Lernbegleiter: Secure CaseTracker v2 04 – Fehler-, Validierungs- und Response-Modell / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_04_Fehler-Validierungs-und-Response-Modell.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Software macht nicht nur das Richtige, wenn alles stimmt – sie muss auch das Falsche sauber abfangen.
In der Basis-Reihe hast du Eingaben an Vertrauensgrenzen geprüft. In v2 baust du daraus ein durchdachtes
**Modell**: Es trennt sauber zwischen **Validierungsregeln** (ist die Eingabe erlaubt?), **fachlichen
Fehlern** (die Regel des Geschäfts ist verletzt, z. B. „geschlossener Fall kann nicht bearbeitet werden“) und
**technischen Fehlern** (etwas Unerwartetes im System). Für jede Art gibt es eine passende, **sichere
Rückmeldung** (Response). Wer diese Ebenen vermischt, verrät entweder zu viel oder verwirrt die Nutzenden.

**EN:** Software does not only do the right thing when everything is correct – it must also catch the wrong
thing cleanly. In the base series you checked inputs at trust boundaries. In v2 you turn this into a
well-considered **model**: it separates cleanly between **validation rules** (is the input allowed?),
**business errors** (a business rule is violated, e.g. "a closed case cannot be edited"), and **technical
errors** (something unexpected in the system). For each kind there is a matching **safe response**. Whoever
mixes these levels either reveals too much or confuses the users.

**DE:** In dieser Einheit legst du eine **Fehlertabelle** an, planst **Negativtests** (Tests, die beweisen,
dass Ungültiges abgelehnt wird) und definierst **Logging-Grenzen** – damit Fehler nachvollziehbar sind, ohne
personenbezogene Daten oder Interna zu protokollieren.

**EN:** In this unit you create an **error table**, plan **negative tests** (tests that prove invalid input is
rejected), and define **logging limits** – so that errors are traceable without logging personal data or
internals.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Validierung / Validation | Prüfung, ob eine Eingabe erlaubt, sinnvoll und sicher ist. |
| Fachlicher Fehler / Business error | Verletzung einer Geschäftsregel trotz technisch gültiger Eingabe. |
| Technischer Fehler / Technical error | Unerwarteter Systemfehler, z. B. fehlende Datei oder Verbindung. |
| Sichere Meldung / Safe message | Rückmeldung, die den Grund nennt, aber keine Interna preisgibt. |
| Negativtest / Negative test | Test, der prüft, dass ungültige Eingaben korrekt abgelehnt werden. |
| Fail-safe / Fail-safe | Grundsatz: im Fehlerfall in den sicheren Zustand fallen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ebenen trennen.** Ordne jeden möglichen Fehler einer Ebene zu: Validierung (Format,
Allowlist, Länge), fachlicher Fehler (Regelverstoß), technischer Fehler (unerwartet). **Warum wichtig:** Nur
getrennte Ebenen erlauben passende Reaktionen. Ein Formatfehler ist Schuld der Eingabe; ein technischer
Fehler ist Schuld des Systems – die Rückmeldung ist jeweils anders.

**EN:** **Step 1 – Separate the levels.** Assign every possible error to a level: validation (format,
allow-list, length), business error (rule violation), technical error (unexpected). **Why it matters:** only
separate levels allow matching reactions. A format error is the input's fault; a technical error is the
system's fault – the response differs in each case.

**DE:** **Schritt 2 – Fehlertabelle aufstellen.** Schreibe je Fehler: Auslöser, Ebene, Statuscode/Signal,
sichere Meldung, ob protokolliert wird. **Warum wichtig:** Die Tabelle macht das Verhalten vollständig und
prüfbar. Was nicht in der Tabelle steht, wird leicht vergessen.

**EN:** **Step 2 – Build the error table.** Write per error: trigger, level, status code/signal, safe message,
whether it is logged. **Why it matters:** the table makes the behaviour complete and reviewable. What is not
in the table is easily forgotten.

**DE:** **Schritt 3 – Sichere Meldungen formulieren.** Die Meldung sagt *was* falsch war und *wie man es
korrigiert*, aber nie interne Details (Stack-Trace, Pfad, DB-Meldung). **Warum wichtig:** Interna helfen
Angreifern und verwirren Nutzende. Fail-safe bedeutet: Bei Unsicherheit lieber ablehnen als riskant
weitermachen.

**EN:** **Step 3 – Formulate safe messages.** The message says *what* was wrong and *how to correct it*, but
never internal details (stack trace, path, DB message). **Why it matters:** internals help attackers and
confuse users. Fail-safe means: when in doubt, rather reject than continue riskily.

**DE:** **Schritt 4 – Negativtests und Logging-Grenzen planen.** Zu jeder kritischen Regel gehört ein
Negativtest, der beweist, dass Ungültiges abgelehnt wird. Beim Logging gilt: genug für die Fehlersuche, aber
keine personenbezogenen Daten und keine Eingaben, die das Protokoll fälschen könnten (Log-Injection).
**Warum wichtig:** Nur Erfolgspfade zu testen zeigt nicht, ob der Schutz greift.

**EN:** **Step 4 – Plan negative tests and logging limits.** Every critical rule needs a negative test that
proves invalid input is rejected. For logging: enough for debugging, but no personal data and no inputs that
could forge the log (log injection). **Why it matters:** testing only success paths does not show whether the
protection works.

**DE:** **Typische Fehler.** Validierung und fachliche Regeln vermischen. Technische Fehler roh an Nutzende
durchreichen. Nur Erfolgspfade testen. Alles ins Log schreiben, auch personenbezogene Daten. Im Fehlerfall
weiterarbeiten statt sicher abzubrechen.

**EN:** **Common mistakes.** Mixing validation and business rules. Passing technical errors raw to users.
Testing only success paths. Logging everything, including personal data. Continuing on error instead of
stopping safely.

### Beispiel / Example

```text
Fehlertabelle (Auszug):

  Ausloeser                     Ebene        Signal  Sichere Meldung                         Log?
  status nicht in Allowlist     Validierung  400     "Ungueltiger Status. Erlaubt: ..."      ja (ohne Wert)
  Fall bereits geschlossen      fachlich     409     "Geschlossener Fall ist nicht editierbar." ja
  Persistenz nicht erreichbar   technisch    500     "Vorgang derzeit nicht moeglich."       ja (Fehlercode)

NICHT so (unsichere technische Meldung):
  "IOException: /var/data/cases.db locked (pid 4711)"   -> verraet Interna

Negativtest: sende status="XXL" -> erwarte Ablehnung 400, keine Speicherung
Logging-Grenze: kein Klartext-Name, keine ganze Eingabe, nur Ereignis + Code
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Fehler-, Validierungs- und Response-Modell steuern das Verhalten der datenverwaltenden Software. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Sichere Fehlerbehandlung und Logging-Grenzen setzen den Schutzbedarf praktisch um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, sichere Fehlerbehandlung,
Fail-safe-Defaults und Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (sichere
Architektur), `CL_05` (Zugangssteuerung/Autorisierung – Fehler dürfen keine Rechte umgehen) und `CL_08`
(Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser Einheit lautet: *Im Fehlerfall in den sicheren
Zustand fallen und keine Interna preisgeben.* A11Y-Aspekt: Fehlermeldungen müssen klar, textbasiert und ohne
reine Farbsignale sein; ein Fehler darf nicht nur durch ein rotes Feld, sondern muss durch verständlichen
Text erkennbar sein, damit Screenreader und Braille-Zeile ihn wiedergeben.

**EN:** Relation to the Secure Development Guideline: secure coding, safe error handling, fail-safe defaults,
and testability. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure architecture),
`CL_05` (access control / authorization – errors must not bypass rights), and `CL_08` (security code review).
The security decision of this unit is: *on error, fall into the safe state and reveal no internals.*
Accessibility aspect: error messages must be clear, text-based, and free of color-only signals; an error must
not be shown only by a red field but by understandable text, so a screen reader and Braille display can
convey it.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Worin unterscheiden sich Validierungsfehler, fachliche Fehler und technische Fehler? /
   **EN:** How do validation errors, business errors, and technical errors differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Validierungsfehler betreffen Format/Erlaubtheit der Eingabe, fachliche Fehler verletzen eine
   Geschäftsregel trotz gültiger Eingabe, technische Fehler sind unerwartete Systemprobleme. Jede Ebene braucht
   eine eigene Reaktion.
   **EN:** Validation errors concern format/permissibility of the input, business errors violate a business
   rule despite valid input, technical errors are unexpected system problems. Each level needs its own
   reaction.

   </details>

2. **DE:** Warum darf eine technische Fehlermeldung keine Interna enthalten? /
   **EN:** Why must a technical error message contain no internals?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stack-Traces, Pfade oder DB-Meldungen helfen Angreifern und verwirren Nutzende. Nach außen genügt
   eine sichere Meldung; Details gehören nur ins interne, geschützte Log.
   **EN:** Stack traces, paths, or DB messages help attackers and confuse users. Outward a safe message is
   enough; details belong only in the internal, protected log.

   </details>

3. **DE:** (AE) Warum gehört zu jeder kritischen Regel ein Negativtest? /
   **EN:** (AE) Why does every critical rule need a negative test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Negativtest beweist, dass Ungültiges wirklich abgelehnt wird. Nur Erfolgspfade zu testen zeigt
   nicht, ob der Schutz greift.
   **EN:** A negative test proves that invalid input is really rejected. Testing only success paths does not
   show whether the protection works.

   </details>

4. **DE:** Was bedeutet Fail-safe im Fehlerfall? /
   **EN:** What does fail-safe mean in the case of error?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei Unsicherheit fällt das System in den sicheren Zustand: lieber ablehnen und abbrechen als riskant
   weiterarbeiten. So entsteht kein unsicherer Zwischenzustand.
   **EN:** When in doubt, the system falls into the safe state: rather reject and stop than continue riskily.
   This avoids an unsafe intermediate state.

   </details>

5. **DE:** (SI) Welche Logging-Grenze schützt Datenschutz und verhindert Log-Injection? /
   **EN:** (SI) Which logging limit protects privacy and prevents log injection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine personenbezogenen Klartextdaten und keine ungefilterten Eingaben ins Log. Nur Ereignis und
   Fehlercode; Freitext begrenzen und bereinigen, damit niemand das Protokoll fälscht.
   **EN:** No personal plain-text data and no unfiltered inputs in the log. Only event and error code; limit and
   sanitize free text so no one forges the log.

   </details>

6. **DE:** (DPA) Wie beeinflusst schlechte Fehlerbehandlung die Datenqualität und spätere Auswertungen? /
   **EN:** (DPA) How does poor error handling affect data quality and later analyses?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Werden ungültige Eingaben nicht abgelehnt, gelangen falsche Daten in den Bestand und verfälschen
   Kennzahlen. Saubere Ablehnung sichert die Datenqualität.
   **EN:** If invalid inputs are not rejected, wrong data enters the store and distorts metrics. Clean rejection
   secures data quality.

   </details>

7. **DE:** Warum ist eine Fehlertabelle nützlicher als verstreute Prüfungen im Code? /
   **EN:** Why is an error table more useful than scattered checks in the code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Tabelle macht alle Fehlerfälle, Meldungen und Log-Entscheidungen an einer Stelle vollständig und
   prüfbar. Verstreute Prüfungen werden leicht widersprüchlich oder unvollständig.
   **EN:** The table makes all error cases, messages, and log decisions complete and reviewable in one place.
   Scattered checks easily become inconsistent or incomplete.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Validierungs-, fachliche und technische Fehler klar unterscheiden.
- [ ] eine Fehlertabelle mit Auslöser, Ebene, Signal, Meldung und Log-Entscheidung aufstellen.
- [ ] eine sichere von einer unsicheren Fehlermeldung unterscheiden.
- [ ] zu jeder kritischen Regel einen Negativtest angeben.
- [ ] Logging-Grenzen für Datenschutz und gegen Log-Injection begründen.

**EN:** I can …

- [ ] clearly distinguish validation, business, and technical errors.
- [ ] build an error table with trigger, level, signal, message, and log decision.
- [ ] tell a safe error message from an unsafe one.
- [ ] give a negative test for each critical rule.
- [ ] justify logging limits for privacy and against log injection.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_04_Fehler-Validierungs-und-Response-Modell.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_04_Fehler-Validierungs-und-Response-Modell.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
