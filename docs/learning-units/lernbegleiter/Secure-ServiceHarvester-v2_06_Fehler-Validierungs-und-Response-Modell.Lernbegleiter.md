# Lernbegleiter: Secure ServiceHarvester v2 06 – Fehler-, Validierungs- und Response-Modell / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_06_Fehler-Validierungs-und-Response-Modell.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure ServiceHarvester bekommt Daten aus zwei Richtungen: Der **Harvester** importiert
Maschinen-Snapshots, und die **kleine API** nimmt Anfragen entgegen. Beide Wege können Ungültiges liefern.
In dieser Einheit baust du ein einziges, durchdachtes **Fehler- und Response-Modell**, das an beiden Stellen
gleich funktioniert. Es trennt sauber zwischen **Validierungsregeln** (ist die Eingabe erlaubt?),
**fachlichen Fehlern** (eine Geschäftsregel ist verletzt, z. B. „ein unbekannter Maschinenname kann nicht
aktualisiert werden") und **technischen Fehlern** (etwas Unerwartetes im Dienst). Zu jeder Fehlerart gehört
eine passende, **sichere Rückmeldung**.

**EN:** The Secure ServiceHarvester receives data from two directions: the **harvester** imports machine
snapshots, and the **small API** accepts requests. Both paths can deliver invalid data. In this unit you
build a single, well-considered **error and response model** that behaves the same in both places. It
separates cleanly between **validation rules** (is the input allowed?), **business errors** (a business rule
is violated, e.g. "an unknown machine name cannot be updated"), and **technical errors** (something
unexpected in the service). Each error kind gets a matching **safe response**.

**DE:** Weil ein Dienst dauerhaft läuft, darf ein einzelner fehlerhafter Import den Dienst nicht zum Absturz
bringen. Du legst deshalb eine **Fehlertabelle** an, planst **Negativtests** und definierst
**Logging-Grenzen**, damit Fehler nachvollziehbar bleiben, ohne Interna oder personenbezogene Daten zu
protokollieren.

**EN:** Because a service runs continuously, a single faulty import must not crash the service. You therefore
create an **error table**, plan **negative tests**, and define **logging limits**, so that errors stay
traceable without logging internals or personal data.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Validierung / Validation | Prüfung, ob eine Eingabe erlaubt, sinnvoll und sicher ist. |
| Fachlicher Fehler / Business error | Verletzung einer Geschäftsregel trotz technisch gültiger Eingabe. |
| Technischer Fehler / Technical error | Unerwarteter Fehler im Dienst, z. B. nicht erreichbare Ablage. |
| Sichere Meldung / Safe message | Rückmeldung, die den Grund nennt, aber keine Interna preisgibt. |
| Gemeinsamer Vertrag / Shared contract | Ein Fehler- und Response-Modell, das für Import und API gleich gilt. |
| Negativtest / Negative test | Test, der prüft, dass ungültige Eingaben korrekt abgelehnt werden. |
| Fail-safe / Fail-safe | Grundsatz: im Fehlerfall in den sicheren Zustand fallen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ebenen trennen.** Ordne jeden möglichen Fehler einer Ebene zu: Validierung (Format,
Allowlist, Länge), fachlicher Fehler (Regelverstoß), technischer Fehler (unerwartet). **Warum wichtig:** Nur
getrennte Ebenen erlauben passende Reaktionen. Ein Formatfehler beim Import ist Schuld der Eingabe; ein
technischer Fehler ist Schuld des Dienstes – die Rückmeldung ist jeweils anders.

**EN:** **Step 1 – Separate the levels.** Assign every possible error to a level: validation (format,
allow-list, length), business error (rule violation), technical error (unexpected). **Why it matters:** only
separate levels allow matching reactions. A format error on import is the input's fault; a technical error is
the service's fault – the response differs in each case.

**DE:** **Schritt 2 – Einen gemeinsamen Vertrag definieren.** Import und API sollen dieselbe Fehlerlogik
nutzen. **Warum wichtig:** Zwei getrennte Modelle driften auseinander; ein gemeinsamer Vertrag hält das
Verhalten vorhersehbar und macht Prüfung und Wartung einfacher.

**EN:** **Step 2 – Define a shared contract.** Import and API should use the same error logic. **Why it
matters:** two separate models drift apart; a shared contract keeps behaviour predictable and makes review and
maintenance easier.

**DE:** **Schritt 3 – Fehlertabelle aufstellen.** Schreibe je Fehler: Auslöser, Ebene, Statuscode/Signal,
sichere Meldung, ob protokolliert wird. **Warum wichtig:** Die Tabelle macht das Verhalten vollständig und
prüfbar. Was nicht in der Tabelle steht, wird leicht vergessen.

**EN:** **Step 3 – Build the error table.** Write per error: trigger, level, status code/signal, safe message,
whether it is logged. **Why it matters:** the table makes the behaviour complete and reviewable. What is not
in the table is easily forgotten.

**DE:** **Schritt 4 – Sichere Meldungen formulieren.** Die Meldung sagt *was* falsch war und *wie man es
korrigiert*, aber nie interne Details (Stack-Trace, Pfad, Ablage-Meldung). **Warum wichtig:** Interna helfen
Angreifern und verwirren Nutzende. Fail-safe bedeutet: Bei Unsicherheit den Import überspringen und melden
statt riskant weiterzuschreiben.

**EN:** **Step 4 – Formulate safe messages.** The message says *what* was wrong and *how to correct it*, but
never internal details (stack trace, path, storage message). **Why it matters:** internals help attackers and
confuse users. Fail-safe means: when in doubt, skip the import and report rather than write on riskily.

**DE:** **Schritt 5 – Negativtests und Logging-Grenzen planen.** Zu jeder kritischen Regel gehört ein
Negativtest, der beweist, dass Ungültiges abgelehnt wird. Beim Logging gilt: genug für die Fehlersuche, aber
keine personenbezogenen Daten und keine ungefilterten Eingaben, die das Protokoll fälschen könnten
(Log-Injection). **Warum wichtig:** Nur Erfolgspfade zu testen zeigt nicht, ob der Schutz greift.

**EN:** **Step 5 – Plan negative tests and logging limits.** Every critical rule needs a negative test that
proves invalid input is rejected. For logging: enough for debugging, but no personal data and no unfiltered
inputs that could forge the log (log injection). **Why it matters:** testing only success paths does not show
whether the protection works.

**DE:** **Typische Fehler.** Validierung und fachliche Regeln vermischen. Getrennte Fehlermodelle für Import
und API pflegen. Technische Fehler roh an Nutzende durchreichen. Nur Erfolgspfade testen. Alles ins Log
schreiben, auch personenbezogene Daten. Bei einem fehlerhaften Import den ganzen Dienst abstürzen lassen.

**EN:** **Common mistakes.** Mixing validation and business rules. Keeping separate error models for import
and API. Passing technical errors raw to users. Testing only success paths. Logging everything, including
personal data. Letting one faulty import crash the whole service.

### Beispiel / Example

```text
Fehlertabelle (Auszug, gilt fuer Import und API):

  Ausloeser                       Ebene        Signal  Sichere Meldung                          Log?
  os nicht in Allowlist           Validierung  400     "Ungueltiges Feld os. Erlaubt: ..."      ja (ohne Wert)
  Maschinenname unbekannt         fachlich     404     "Maschine nicht bekannt."                ja
  Ablage nicht erreichbar         technisch    503     "Vorgang derzeit nicht moeglich."        ja (Fehlercode)

NICHT so (unsichere technische Meldung):
  "SqlException: connect to /var/data/harvest.db failed (pid 4711)"  -> verraet Interna

Negativtest: importiere snapshot mit os="???" -> erwarte Ablehnung 400, kein Schreiben
Logging-Grenze: kein Klartext-Hostname mit Person, keine ganze Eingabe, nur Ereignis + Code
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 5 Software zur Verwaltung von Daten anpassen | Primär / Primary | Das Fehler-, Validierungs- und Response-Modell steuert das Verhalten der datenverwaltenden Dienst-Software. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Sichere Fehlerbehandlung und Logging-Grenzen setzen den Schutzbedarf der importierten Daten praktisch um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, sichere Fehlerbehandlung,
Fail-safe-Defaults und Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_03` (sichere
Architektur), `CL_05` (Zugangssteuerung/Autorisierung – Fehler dürfen keine Rechte umgehen) und `CL_08`
(Sicherheits-Code-Review). Die Sicherheitsentscheidung dieser Einheit lautet: *Import und API teilen einen
Fehler-Vertrag, im Fehlerfall fällt der Dienst in den sicheren Zustand und gibt keine Interna preis.*
A11Y-Aspekt: Fehlermeldungen müssen klar, textbasiert und ohne reine Farbsignale sein; ein Fehler darf nicht
nur durch ein rotes Feld, sondern muss durch verständlichen Text erkennbar sein, damit Screenreader und
Braille-Zeile ihn wiedergeben.

**EN:** Relation to the Secure Development Guideline: secure coding, safe error handling, fail-safe defaults,
and testability. Matching checklists: `CL_01` (standards applicability), `CL_03` (secure architecture),
`CL_05` (access control / authorization – errors must not bypass rights), and `CL_08` (security code review).
The security decision of this unit is: *import and API share one error contract, on error the service falls
into the safe state and reveals no internals.* Accessibility aspect: error messages must be clear, text-based,
and free of color-only signals; an error must not be shown only by a red field but by understandable text, so
a screen reader and Braille display can convey it.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Worin unterscheiden sich Validierungsfehler, fachliche Fehler und technische Fehler? /
   **EN:** How do validation errors, business errors, and technical errors differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Validierungsfehler betreffen Format und Erlaubtheit der Eingabe, fachliche Fehler verletzen eine
   Geschäftsregel trotz gültiger Eingabe, technische Fehler sind unerwartete Probleme im Dienst. Jede Ebene
   braucht eine eigene Reaktion.
   **EN:** Validation errors concern format and permissibility of the input, business errors violate a
   business rule despite valid input, technical errors are unexpected problems in the service. Each level
   needs its own reaction.

   </details>

2. **DE:** Warum sollen Harvester-Import und API dasselbe Fehler- und Response-Modell nutzen? /
   **EN:** Why should harvester import and API use the same error and response model?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein gemeinsamer Vertrag verhindert, dass beide Wege auseinanderdriften und sich unterschiedlich
   verhalten. Das Verhalten bleibt vorhersehbar, und Prüfung sowie Wartung werden einfacher.
   **EN:** A shared contract prevents both paths from drifting apart and behaving differently. Behaviour stays
   predictable, and review and maintenance become easier.

   </details>

3. **DE:** Warum darf eine technische Fehlermeldung keine Interna enthalten? /
   **EN:** Why must a technical error message contain no internals?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Stack-Traces, Pfade oder Ablage-Meldungen helfen Angreifern und verwirren Nutzende. Nach außen
   genügt eine sichere Meldung; Details gehören nur ins interne, geschützte Log.
   **EN:** Stack traces, paths, or storage messages help attackers and confuse users. Outward a safe message
   is enough; details belong only in the internal, protected log.

   </details>

4. **DE:** (AE) Warum gehört zu jeder kritischen Regel ein Negativtest? /
   **EN:** (AE) Why does every critical rule need a negative test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Negativtest beweist, dass Ungültiges wirklich abgelehnt wird. Nur Erfolgspfade zu testen zeigt
   nicht, ob der Schutz greift.
   **EN:** A negative test proves that invalid input is really rejected. Testing only success paths does not
   show whether the protection works.

   </details>

5. **DE:** Was bedeutet Fail-safe für einen dauerhaft laufenden Dienst? /
   **EN:** What does fail-safe mean for a continuously running service?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei einem fehlerhaften Import fällt der Dienst in den sicheren Zustand: den Datensatz überspringen
   und melden, statt riskant weiterzuschreiben oder abzustürzen. So bleibt der Dienst verfügbar.
   **EN:** On a faulty import the service falls into the safe state: skip the record and report rather than
   write on riskily or crash. This keeps the service available.

   </details>

6. **DE:** (SI) Welche Logging-Grenze schützt Datenschutz und verhindert Log-Injection? /
   **EN:** (SI) Which logging limit protects privacy and prevents log injection?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine personenbezogenen Klartextdaten und keine ungefilterten Eingaben ins Log. Nur Ereignis und
   Fehlercode; Freitext begrenzen und bereinigen, damit niemand das Protokoll fälscht.
   **EN:** No personal plain-text data and no unfiltered inputs in the log. Only event and error code; limit
   and sanitize free text so no one forges the log.

   </details>

7. **DE:** (DPA) Wie beeinflusst schlechte Fehlerbehandlung beim Import die Datenqualität der Snapshots? /
   **EN:** (DPA) How does poor error handling on import affect the data quality of the snapshots?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Werden ungültige Snapshots nicht abgelehnt, gelangen falsche Statusdaten in die Ablage und
   verfälschen Betriebsentscheidungen und Auswertungen. Saubere Ablehnung sichert die Datenqualität.
   **EN:** If invalid snapshots are not rejected, wrong status data enters the storage and distorts operational
   decisions and analyses. Clean rejection secures data quality.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. So bleibt sichtbar, dass
   der Standard geprüft und bewusst als nicht anwendbar eingestuft wurde.
   **EN:** As `N/A` with a short technical justification, not by silent omission. This keeps visible that the
   standard was checked and deliberately classified as not applicable.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Validierungs-, fachliche und technische Fehler klar unterscheiden.
- [ ] ein gemeinsames Fehlermodell für Harvester-Import und API begründen.
- [ ] eine Fehlertabelle mit Auslöser, Ebene, Signal, Meldung und Log-Entscheidung aufstellen.
- [ ] eine sichere von einer unsicheren Fehlermeldung unterscheiden.
- [ ] zu jeder kritischen Regel einen Negativtest angeben.
- [ ] Logging-Grenzen für Datenschutz und gegen Log-Injection begründen.

**EN:** I can …

- [ ] clearly distinguish validation, business, and technical errors.
- [ ] justify a shared error model for harvester import and API.
- [ ] build an error table with trigger, level, signal, message, and log decision.
- [ ] tell a safe error message from an unsafe one.
- [ ] give a negative test for each critical rule.
- [ ] justify logging limits for privacy and against log injection.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_06_Fehler-Validierungs-und-Response-Modell.md`. Der Copy-Paste-Prompt
für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_06_Fehler-Validierungs-und-Response-Modell.md`. The copy-paste prompt
for a later, manually started Spec Kit run is provided there.
