# Lernbegleiter: Secure CaseTracker 04 – Datenschutz und Audit-Logging / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker_04_Datenschutz-und-Audit-Logging.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein **Audit-Log** ist wie ein Fahrtenbuch: Es hält fest, wer wann was getan hat, damit man später
nachvollziehen kann, was passiert ist. Für den Secure CaseTracker sind das Ereignisse wie „Fall angelegt",
„Status geändert" oder „Import durchgeführt". Der Trick liegt in der Balance: Das Log muss **nachvollziehbar**
sein, darf aber nicht **datenhungrig** werden. Es soll keine Secrets, keine vollständigen Freitexte und keine
unnötigen personenbezogenen Daten enthalten. Außerdem darf niemand über eine manipulierte Eingabe das
Protokoll fälschen (Log-Injection). In dieser Einheit planst du ein Audit-Logging, das gleichzeitig
datensparsam und beweiskräftig ist.

**EN:** An **audit log** is like a logbook: it records who did what and when, so that later you can trace what
happened. For the Secure CaseTracker these are events such as "case created", "status changed", or "import
performed". The trick is the balance: the log must be **traceable** but must not become **data-hungry**. It
should contain no secrets, no complete free text, and no unnecessary personal data. And no one may forge the
log through a manipulated input (log injection). In this unit you plan audit logging that is both
data-minimal and evidential.

**DE:** Du legst die Audit-Ereignisse fest, entscheidest, welche Felder erlaubt und welche verboten sind, und
planst Tests, die beweisen, dass keine Secrets oder personenbezogenen Werte im Log landen.

**EN:** You define the audit events, decide which fields are allowed and which are forbidden, and plan tests
that prove no secrets or personal values end up in the log.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Audit-Log / Audit log | Strukturierter Nachweis über sicherheits- und fachrelevante Ereignisse. |
| Log-Injection | Angriff, bei dem eine Eingabe das Protokoll verfälscht oder Zeilen fälscht. |
| Strukturiertes Logging / Structured logging | Log mit klar getrennten Feldern statt zusammengebauter Freitext-Zeilen. |
| Pseudonymisierung / Pseudonymization | Personenbezug durch ein Ersatzkennzeichen abschwächen. |
| Zweckbindung / Purpose limitation | Daten nur für den festgelegten Zweck erheben und nutzen. |
| Datensparsamkeit / Data minimization | So wenig Daten wie möglich protokollieren. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Audit-Ereignisse festlegen.** Bestimme, welche Ereignisse geloggt werden: Fall
angelegt, Status geändert, Bearbeitungsnotiz ergänzt, Fall geschlossen, Import durchgeführt. Warum eine feste
Liste? Nur benannte Ereignisse lassen sich einheitlich und testbar protokollieren.

**EN:** **Step 1 – Define audit events.** Determine which events are logged: case created, status changed,
work note added, case closed, import performed. Why a fixed list? Only named events can be logged consistently
and testably.

**DE:** **Schritt 2 – Erlaubte und verbotene Felder trennen.** Ein Audit-Eintrag enthält Zweck, Zeitpunkt,
Aktion, Rolle und eine technische Referenz. Verboten sind Secrets, Tokens, Zugangsdaten und vollständige
Freitexte. Warum diese Trennung? Sie hält das Log beweiskräftig, aber datensparsam, und verhindert, dass
sensible Inhalte versehentlich gespeichert werden.

**EN:** **Step 2 – Separate allowed and forbidden fields.** An audit entry contains purpose, time, action,
role, and a technical reference. Forbidden are secrets, tokens, credentials, and complete free text. Why this
separation? It keeps the log evidential yet data-minimal and prevents accidental storage of sensitive
content.

**DE:** **Schritt 3 – Log-Injection verhindern.** Bereinige Werte, bevor sie ins Log gehen: entferne oder
maskiere Zeilenumbrüche und Steuerzeichen. Nutze **strukturiertes Logging** mit getrennten Feldern statt
zusammengebauter Textzeilen. Warum? Sonst kann eine Eingabe wie `"Status geändert\nFAKE: Admin-Login"` eine
falsche Log-Zeile vortäuschen.

**EN:** **Step 3 – Prevent log injection.** Sanitize values before they enter the log: remove or escape line
breaks and control characters. Use **structured logging** with separate fields instead of concatenated text
lines. Why? Otherwise an input like `"status changed\nFAKE: admin login"` could fake a false log line.

**DE:** **Schritt 4 – Personenbezug minimieren und Ebenen trennen.** Minimiere oder pseudonymisiere
personenbezogene Angaben. Trenne außerdem **nutzerseitige Fehlermeldungen** von **internen Logs**: Der
Endnutzer sieht keine internen Details, das interne Log enthält keine Secrets. Warum? Datenschutz und
Sicherheit gewinnen beide, wenn nur das Nötige an der richtigen Stelle steht.

**EN:** **Step 4 – Minimize personal reference and separate levels.** Minimize or pseudonymize personal data.
Also separate **user-facing error messages** from **internal logs**: the end user sees no internal details,
the internal log contains no secrets. Why? Privacy and security both benefit when only the necessary data is
in the right place.

**DE:** **Typische Fehler.** Ganze Freitexte oder Objekte einfach mitloggen. Secrets oder Tokens im Log.
Zeilenumbrüche aus Eingaben ungefiltert übernehmen. Interne Details in nutzerseitige Fehler geben.
Aufbewahrung ohne Zweck.

**EN:** **Common mistakes.** Logging whole free texts or objects. Secrets or tokens in the log. Taking line
breaks from inputs unfiltered. Putting internal details into user-facing errors. Retention without a purpose.

### Beispiel / Example

```text
Audit-Eintrag (gut):
  event=status_changed  role=developer  caseRef=CASE-0007  from=new  to=in_progress  ts=2026-07-05T09:12Z
Audit-Eintrag (schlecht - NICHT so):
  "developer aenderte Fall; token=abcd1234; notiz=<voller Freitext mit Namen>\nADMIN login ok"
Log-Injection-Eingabe:  "in_progress\nFAKE: closed by admin"
Behandlung:             Zeilenumbruch entfernt/maskiert -> nur ein sauberes Feld, keine falsche Zeile.
Datenschutz:            kein Name, kein Token, note nicht vollstaendig -> nur Referenz + Aktion.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Datenschutz, Zweckbindung und Log-Injection-Schutz sind Kern der Schutzbedarfsbewertung. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Nachvollziehbare, datensparsame Protokollierung ist Teil der Datenverwaltung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, sichere Protokollierung sowie Review- und
Evidenzpflicht. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review),
`CL_09` (Testmanagement) und `CL_11` (Datenschutz/Datenqualität). Die Sicherheitsentscheidung dieser Einheit
lautet: *Das Audit-Log ist nachvollziehbar, aber datensparsam, und keine Eingabe darf es fälschen.*
A11Y-Aspekt: Log-Ausgaben und Fehlermeldungen bleiben klare Textfelder ohne reine Farbsignale, damit sie mit
Screenreader und Braille-Zeile gut lesbar sind.

**EN:** Relation to the Secure Development Guideline: privacy, safe logging, and review/evidence obligations.
Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), `CL_09` (test
management), and `CL_11` (privacy/data quality). The security decision of this unit is: *the audit log is
traceable yet data-minimal, and no input may forge it.* Accessibility aspect: log output and error messages
stay clear text fields without color-only signals, so they are easy to read with a screen reader and Braille
display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist strukturiertes Logging sicherer als zusammengebaute Freitext-Zeilen? /
   **EN:** Why is structured logging safer than concatenated free-text lines?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Getrennte Felder lassen sich gezielt bereinigen und auswerten. Zusammengebaute Zeilen können durch
   Zeilenumbrüche in Eingaben gefälscht werden (Log-Injection).
   **EN:** Separate fields can be sanitized and evaluated precisely. Concatenated lines can be forged through
   line breaks in inputs (log injection).

   </details>

2. **DE:** (DPA) Welche Audit-Daten reichen für eine Prozessauswertung aus, ohne datenhungrig zu sein? /
   **EN:** (DPA) Which audit data is enough for process analysis without being data-hungry?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aktion, Zeitpunkt, Rolle und eine technische Referenz reichen für Durchlaufzeiten und Fallzahlen.
   Vollständige Freitexte oder Namen sind dafür nicht nötig.
   **EN:** Action, time, role, and a technical reference are enough for throughput times and case counts.
   Complete free text or names are not needed for that.

   </details>

3. **DE:** Welche Inhalte dürfen niemals im Audit-Log stehen? /
   **EN:** Which content must never appear in the audit log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Secrets, Tokens, Zugangsdaten und vollständige Freitexte sowie unnötige personenbezogene Daten.
   Solche Inhalte sind ein Datenschutz- und Sicherheitsrisiko.
   **EN:** Secrets, tokens, credentials, complete free text, and unnecessary personal data. Such content is a
   privacy and security risk.

   </details>

4. **DE:** (AE) Welche Daten werden technisch leicht geloggt, sind aber fachlich unnötig? /
   **EN:** (AE) Which data is technically easy to log but functionally unnecessary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ganze Objekte, komplette Notizen oder Debug-Ausgaben. Sie landen schnell im Log, obwohl nur Aktion
   und Referenz gebraucht werden. Datensparsamkeit spart Risiko.
   **EN:** Whole objects, complete notes, or debug output. They quickly end up in the log although only action
   and reference are needed. Data minimization reduces risk.

   </details>

5. **DE:** (SI) Wie bleiben Logs im Betrieb nützlich und trotzdem datensparsam? /
   **EN:** (SI) How do logs stay useful in operation and still data-minimal?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Indem sie strukturierte, zweckgebundene Felder enthalten: genug für Nachvollzug und Fehlersuche,
   aber keine Secrets oder vollständigen Personendaten.
   **EN:** By containing structured, purpose-bound fields: enough for tracing and troubleshooting, but no
   secrets or complete personal data.

   </details>

6. **DE:** Warum werden nutzerseitige Fehlermeldungen und interne Logs getrennt? /
   **EN:** Why are user-facing error messages and internal logs separated?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nutzer sollen keine internen Details sehen, und interne Logs sollen keine Secrets enthalten. Die
   Trennung schützt gleichzeitig Sicherheit und Datenschutz.
   **EN:** Users should not see internal details, and internal logs should not contain secrets. The separation
   protects security and privacy at the same time.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die zu protokollierenden Audit-Ereignisse benennen.
- [ ] erlaubte und verbotene Log-Felder klar trennen.
- [ ] Log-Injection erklären und eine Gegenmaßnahme nennen.
- [ ] personenbezogene Daten im Log minimieren oder pseudonymisieren.
- [ ] Tests planen, die Secrets und personenbezogene Werte im Log ausschließen.

**EN:** I can …

- [ ] name the audit events to be logged.
- [ ] clearly separate allowed and forbidden log fields.
- [ ] explain log injection and name a countermeasure.
- [ ] minimize or pseudonymize personal data in the log.
- [ ] plan tests that exclude secrets and personal values from the log.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker_04_Datenschutz-und-Audit-Logging.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker_04_Datenschutz-und-Audit-Logging.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
