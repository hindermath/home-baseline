# Lernbegleiter: Secure CaseTracker Application Track 05 – Validierung, Fehlerbehandlung und Response-Modell / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Application-Track_05_Validierung-Fehlerbehandlung-und-Response-Modell.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Wenn eine Anwendung Eingaben verarbeitet, gibt es drei Ausgänge: Es klappt, die Eingabe ist ungültig,
oder etwas Technisches geht schief. Diese Fälle müssen sauber getrennt und einheitlich beantwortet werden. In
dieser Einheit entwirfst du das **Response-Modell**: eine feste Form für Erfolg, für **fachliche Fehler**
(z. B. „Status unbekannt") und für **technische Fehler** (z. B. „Datenbank nicht erreichbar"). Wichtig sind
außerdem klare **Validierungsregeln** und **Logging-Grenzen**, damit keine sensiblen Daten ins Protokoll
gelangen. Bild dazu: ein Formularschalter im Amt. Es gibt eine klare Rückmeldung, was fehlt, aber die
internen Abläufe hinter dem Schalter bleiben verborgen.

**EN:** When an application processes input, there are three outcomes: it works, the input is invalid, or
something technical fails. These cases must be cleanly separated and answered uniformly. In this unit you
design the **response model**: a fixed shape for success, for **business errors** (e.g. "unknown status"), and
for **technical errors** (e.g. "database unreachable"). Also important are clear **validation rules** and
**logging boundaries** so that no sensitive data reaches the log. The picture: a counter in a public office.
There is clear feedback about what is missing, but the internal processes behind the counter stay hidden.

**DE:** Diese Einheit vertieft die Basis-Idee aus Einheit 03 der Basis-Reihe (Eingabevalidierung) und hebt
sie auf ein professionelles, einheitliches Antwortmodell.

**EN:** This unit deepens the base idea from unit 03 of the base series (input validation) and lifts it to a
professional, uniform response model.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Validierung / Validation | Prüfung, ob eine Eingabe erlaubt, sinnvoll und sicher ist. |
| Fachlicher Fehler / Business error | Erwartbarer Fehler aus der Fachregel, z. B. unbekannter Status. |
| Technischer Fehler / Technical error | Unerwarteter Systemfehler, z. B. Speicher oder Netz. |
| Response-Modell / Response model | Einheitliche Form für Erfolg und Fehler nach außen. |
| Logging-Grenze / Logging boundary | Regel, welche Daten protokolliert werden dürfen und welche nicht. |
| Negativtest / Negative test | Test, der prüft, dass ungültige Eingaben korrekt abgelehnt werden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Drei Ausgänge trennen.** Lege fest: Erfolg, fachlicher Fehler, technischer Fehler.
Warum? Vermischt man sie, weiß der Nutzer nicht, ob er selbst etwas korrigieren kann oder ob das System
gestört ist – und Angreifer lesen aus Mischmeldungen interne Details.

**EN:** **Step 1 – Separate three outcomes.** Define: success, business error, technical error. Why? If mixed,
the user does not know whether they can fix something themselves or the system is faulty – and attackers read
internal details from mixed messages.

**DE:** **Schritt 2 – Validierungsregeln je Eingabe.** Nutze Allowlists, Längengrenzen, Formatprüfungen und
Kanonisierung von Pfaden. Prüfe an der Vertrauensgrenze *und* in der Kernlogik, weil Oberflächenprüfungen
umgehbar sind.

**EN:** **Step 2 – Validation rules per input.** Use allow-lists, length limits, format checks, and
canonicalization of paths. Check at the trust boundary *and* in the core logic, because UI checks can be
bypassed.

**DE:** **Schritt 3 – Einheitliches Response-Modell.** Definiere eine feste Struktur: Erfolg mit Ergebnis;
Fehler mit stabilem Code, kurzer nutzerlesbarer Meldung und ohne Interna. Ein fachlicher Fehler nennt die
Regel („Status muss offen, in Arbeit oder geschlossen sein"); ein technischer Fehler bleibt allgemein
(„Vorübergehender Fehler, bitte später erneut versuchen").

**EN:** **Step 3 – Uniform response model.** Define a fixed structure: success with a result; error with a
stable code, a short user-readable message, and no internals. A business error names the rule ("status must be
open, in progress, or closed"); a technical error stays general ("temporary error, please try again later").

**DE:** **Schritt 4 – Logging-Grenzen setzen.** Protokolliere, *dass* ein Fehler passierte, aber keine
Passwörter, keine vollständigen personenbezogenen Daten und keine Roh-Eingaben, die das Log fälschen könnten
(Log-Injection). Kürze und maskiere sensible Felder.

**EN:** **Step 4 – Set logging boundaries.** Log *that* an error happened, but no passwords, no full personal
data, and no raw inputs that could forge the log (log injection). Truncate and mask sensitive fields.

**DE:** **Typische Fehler.** Fachliche und technische Fehler vermischen. Stack-Traces an Nutzer geben. Nur
Erfolgspfade testen. Sensible Daten ins Log schreiben. Fehlercodes je Release ändern. Freitext ohne
Längengrenze annehmen.

**EN:** **Common mistakes.** Mixing business and technical errors. Returning stack traces to users. Testing
only success paths. Writing sensitive data to the log. Changing error codes per release. Accepting free text
without a length limit.

### Beispiel / Example

```text
Eingabe: { status: "erledigt?" , notiz: <5000 Zeichen> }

Validierung:
  status  -> Allowlist { offen, in Arbeit, geschlossen }  -> FEHLT -> fachlicher Fehler
  notiz   -> max. 2000 Zeichen                             -> zu lang -> fachlicher Fehler

Response (fachlicher Fehler):
  { ok: false, code: "VALIDATION_FAILED",
    message: "Status ungültig; Notiz max. 2000 Zeichen." }

Technischer Fehler (z. B. Speicher weg):
  { ok: false, code: "TEMPORARY_ERROR",
    message: "Vorübergehender Fehler. Bitte später erneut versuchen." }   (keine Interna)

Log (maskiert): "VALIDATION_FAILED für Fall 4711; Feld status; Länge notiz=5000"
   -> keine Roh-Notiz, keine personenbezogenen Inhalte im Klartext.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10a Benutzerschnittstellen gestalten und entwickeln | Primär / Primary | Validierungsrückmeldungen und das Response-Modell prägen unmittelbar die verständliche, sichere Benutzerschnittstelle. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Sichere Fehlerbehandlung und Logging-Grenzen sind Schutzmaßnahmen gegen Informationslecks. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Eingabevalidierung, sichere Fehlerbehandlung und Schutz vor
Informationslecks im Log. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08`
(Sicherheits-Code-Review) und `CL_10` (Sichere Entwicklungsumgebung). Die Sicherheitsentscheidung dieser
Einheit lautet: *Fehler werden getrennt, einheitlich und ohne interne Details beantwortet.* A11Y-Aspekt:
Fehlermeldungen müssen klar, textbasiert und mit dem betroffenen Feld verknüpft sein; sie dürfen nicht allein
über Farbe (rotes Feld) transportiert werden, damit sie mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: input validation, safe error handling, and protection
against information leaks in the log. Matching checklists: `CL_01` (standards applicability), `CL_08` (security
code review), and `CL_10` (secure development environment). The security decision of this unit is: *errors are
answered separately, uniformly, and without internal details.* Accessibility aspect: error messages must be
clear, text-based, and linked to the affected field; they must not be carried by color alone (a red field) so
they stay usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum trennst du fachliche und technische Fehler? /
   **EN:** Why do you separate business and technical errors?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein fachlicher Fehler kann vom Nutzer korrigiert werden und darf die Regel nennen; ein technischer
   Fehler ist ein Systemproblem und bleibt allgemein. Die Trennung hilft dem Nutzer und verhindert
   Informationslecks.
   **EN:** A business error can be fixed by the user and may name the rule; a technical error is a system
   problem and stays general. The separation helps the user and prevents information leaks.

   </details>

2. **DE:** Warum muss ein Response-Modell eine feste Form haben? /
   **EN:** Why must a response model have a fixed shape?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine feste Form macht Antworten vorhersehbar, testbar und für Aufrufer stabil. Uneinheitliche
   Antworten erzeugen Fehler in der Weiterverarbeitung und verstecken Sicherheitslücken.
   **EN:** A fixed shape makes responses predictable, testable, and stable for callers. Inconsistent responses
   cause errors in further processing and hide security gaps.

   </details>

3. **DE:** Welche Daten dürfen nicht ins Log, und warum? /
   **EN:** Which data must not go into the log, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine Passwörter, keine vollständigen personenbezogenen Daten, keine ungefilterten Roh-Eingaben.
   Sie verletzen Datenschutz und ermöglichen Log-Injection oder Informationslecks.
   **EN:** No passwords, no full personal data, no unfiltered raw inputs. They violate privacy and enable log
   injection or information leaks.

   </details>

4. **DE:** Warum darf ein technischer Fehler nur allgemein formuliert werden? /
   **EN:** Why may a technical error be phrased only generally?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Details wie Stack-Traces oder Verbindungszeichenketten helfen Angreifern und offenbaren die interne
   Struktur. Eine allgemeine Meldung schützt das System und bleibt trotzdem hilfreich.
   **EN:** Details like stack traces or connection strings help attackers and reveal internal structure. A
   general message protects the system and is still helpful.

   </details>

5. **DE:** Warum gehört zu jeder kritischen Eingabeart mindestens ein Negativtest? /
   **EN:** Why does every critical input type need at least one negative test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Negativtest beweist, dass ungültige Eingaben wirklich abgelehnt werden. Nur Erfolgspfade zu
   testen zeigt nicht, ob der Schutz greift.
   **EN:** A negative test proves that invalid inputs are really rejected. Testing only success paths does not
   show whether the protection works.

   </details>

6. **DE:** Wie macht diese Einheit die Benutzerschnittstelle (LF 10a) sicherer und verständlicher? /
   **EN:** How does this unit make the user interface (LF 10a) safer and clearer?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Klare, feldbezogene Fehlermeldungen sagen dem Nutzer verständlich, was zu tun ist, ohne interne
   Details preiszugeben. So werden Bedienbarkeit und Sicherheit gemeinsam verbessert.
   **EN:** Clear, field-related error messages tell the user understandably what to do without revealing
   internal details. This improves usability and security together.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Erfolg, fachliche und technische Fehler klar trennen.
- [ ] Validierungsregeln je Eingabe an der Grenze und im Kern festlegen.
- [ ] ein einheitliches Response-Modell ohne Interna entwerfen.
- [ ] Logging-Grenzen für sensible Daten setzen.
- [ ] je kritischer Eingabeart einen Negativtest angeben.

**EN:** I can …

- [ ] clearly separate success, business, and technical errors.
- [ ] set validation rules per input at the boundary and in the core.
- [ ] design a uniform response model without internals.
- [ ] set logging boundaries for sensitive data.
- [ ] give a negative test for each critical input type.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Application-Track_05_Validierung-Fehlerbehandlung-und-Response-Modell.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Application-Track_05_Validierung-Fehlerbehandlung-und-Response-Modell.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
