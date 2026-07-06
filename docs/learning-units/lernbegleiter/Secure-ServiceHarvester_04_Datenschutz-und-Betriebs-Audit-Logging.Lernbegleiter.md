# Lernbegleiter: Secure ServiceHarvester 04 – Datenschutz und Betriebs-/Audit-Logging / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester_04_Datenschutz-und-Betriebs-Audit-Logging.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure ServiceHarvester sammelt im Hintergrund Statusdaten von Maschinen (z. B. name, os,
last_contact). Wie bei jedem Dienst gilt: Man muss später nachvollziehen können, **was** er getan hat. Dafür
gibt es zwei Arten von Protokollen. Das **Betriebs-Log** hält den Ablauf und Fehler des Dienstes fest (z. B.
„Sammellauf gestartet", „Import fehlgeschlagen"). Das **Audit-Log** hält sicherheits- und fachrelevante
Ereignisse fest (z. B. „Status einer Maschine geändert", „Export durchgeführt"). Beide müssen
**nachvollziehbar** sein, dürfen aber nicht **datenhungrig** werden: keine Secrets, keine vollständigen
Freitexte, keine unnötigen personenbezogenen Daten. Und niemand darf über eine manipulierte Eingabe das
Protokoll fälschen (Log-Injection).

**EN:** The Secure ServiceHarvester collects machine status data (e.g. name, os, last_contact) in the
background. As with any service: you must later be able to trace **what** it did. For this there are two kinds
of logs. The **operational log** records the service flow and errors (e.g. "collection run started", "import
failed"). The **audit log** records security- and business-relevant events (e.g. "machine status changed",
"export performed"). Both must be **traceable** but must not become **data-hungry**: no secrets, no complete
free text, no unnecessary personal data. And no one may forge the log through a manipulated input (log
injection).

**DE:** In dieser Einheit legst du die Ereignisliste fest, entscheidest je Log-Ebene, welche Felder erlaubt
und welche verboten sind, trennst die nutzerseitige Fehlermeldung vom internen Log und planst Tests, die
beweisen, dass keine Secrets oder personenbezogenen Werte im Log landen.

**EN:** In this unit you define the event list, decide per log level which fields are allowed and which are
forbidden, separate the user-facing error message from the internal log, and plan tests that prove no secrets
or personal values end up in the log.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Betriebs-Log / Operational log | Protokoll über Ablauf, Zustand und Fehler des laufenden Dienstes. |
| Audit-Log / Audit log | Strukturierter Nachweis über sicherheits- und fachrelevante Ereignisse. |
| Log-Injection | Angriff, bei dem eine Eingabe das Protokoll verfälscht oder Zeilen fälscht. |
| Strukturiertes Logging / Structured logging | Log mit klar getrennten Feldern statt zusammengebauter Freitext-Zeilen. |
| Pseudonymisierung / Pseudonymization | Personenbezug durch ein Ersatzkennzeichen abschwächen. |
| Datensparsamkeit / Data minimization | So wenig Daten wie möglich protokollieren, nur zweckgebunden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ereignisse festlegen.** Bestimme, welche Ereignisse geloggt werden: Sammellauf
gestartet, Maschine erstmals gesehen, Status geändert, Snapshot gespeichert, Import durchgeführt, Sammellauf
gestoppt. Warum eine feste Liste? Nur benannte Ereignisse lassen sich einheitlich und testbar protokollieren.

**EN:** **Step 1 – Define events.** Determine which events are logged: collection run started, machine first
seen, status changed, snapshot stored, import performed, collection run stopped. Why a fixed list? Only named
events can be logged consistently and testably.

**DE:** **Schritt 2 – Betriebs-Log und Audit-Log trennen.** Das Betriebs-Log dient dem Betrieb (Läuft der
Dienst? Wann war der letzte Lauf? Welcher Fehler trat auf?). Das Audit-Log dient dem Nachweis (Wer oder welche
Rolle hat welche fachliche Aktion ausgelöst?). Warum trennen? Die beiden Logs haben unterschiedliche Zwecke,
Empfänger und Aufbewahrungsfragen. Eine Vermischung macht beide schlechter prüfbar.

**EN:** **Step 2 – Separate operational log and audit log.** The operational log serves operations (is the
service running? when was the last run? which error occurred?). The audit log serves evidence (who or which
role triggered which business action?). Why separate? The two logs have different purposes, recipients, and
retention questions. Mixing them makes both harder to review.

**DE:** **Schritt 3 – Erlaubte und verbotene Felder je Log.** Ein Eintrag enthält Zweck, Zeitpunkt, Aktion,
Rolle und eine technische Referenz (z. B. eine Maschinen-Kennung). Verboten sind Secrets, Tokens, Zugangsdaten
und vollständige Freitexte. Warum diese Trennung? Sie hält das Log beweiskräftig, aber datensparsam, und
verhindert, dass sensible Inhalte versehentlich gespeichert werden.

**EN:** **Step 3 – Allowed and forbidden fields per log.** An entry contains purpose, time, action, role, and
a technical reference (e.g. a machine identifier). Forbidden are secrets, tokens, credentials, and complete
free text. Why this separation? It keeps the log evidential yet data-minimal and prevents accidental storage
of sensitive content.

**DE:** **Schritt 4 – Log-Injection verhindern und Ebenen trennen.** Bereinige Werte, bevor sie ins Log gehen:
entferne oder maskiere Zeilenumbrüche und Steuerzeichen und nutze **strukturiertes Logging**. Trenne außerdem
**nutzerseitige Fehlermeldungen** von **internen Logs**: Der Endnutzer sieht keine internen Details, das
interne Log enthält keine Secrets. Warum? Sonst kann eine Eingabe wie `"online\nFAKE: admin login"` eine
falsche Log-Zeile vortäuschen, und interne Details helfen Angreifern.

**EN:** **Step 4 – Prevent log injection and separate levels.** Sanitize values before they enter the log:
remove or escape line breaks and control characters and use **structured logging**. Also separate
**user-facing error messages** from **internal logs**: the end user sees no internal details, the internal log
contains no secrets. Why? Otherwise an input like `"online\nFAKE: admin login"` could fake a false log line,
and internal details help attackers.

**DE:** **Typische Fehler.** Ganze Snapshots oder Objekte einfach mitloggen. Secrets oder Tokens im Log.
Betriebs- und Audit-Log vermischen. Zeilenumbrüche aus gesammelten Daten ungefiltert übernehmen. Interne
Details in nutzerseitige Fehler geben. Nicht anwendbare Standards stillschweigend weglassen statt sie als
`N/A` mit kurzer Begründung zu dokumentieren.

**EN:** **Common mistakes.** Logging whole snapshots or objects. Secrets or tokens in the log. Mixing
operational and audit logs. Taking line breaks from collected data unfiltered. Putting internal details into
user-facing errors. Silently dropping non-applicable standards instead of documenting them as `N/A` with a
short justification.

### Beispiel / Example

```text
Audit-Eintrag (gut):
  event=status_changed  role=developer  machineRef=M-0007  from=online  to=offline  ts=2026-07-06T09:12Z
Audit-Eintrag (schlecht - NICHT so):
  "developer aenderte M-0007; token=<PLATZHALTER-KEIN-ECHTER-WERT>; note=<voller Freitext>\nADMIN login ok"
Betriebs-Log (gut):    event=harvest_run_started  interval=5m  ts=2026-07-06T09:10Z
Log-Injection-Eingabe: "offline\nFAKE: run_stopped by admin"
Behandlung:            Zeilenumbruch entfernt/maskiert -> nur ein sauberes Feld, keine falsche Zeile.
Datenschutz:           kein Name, kein Token, keine Standortdaten -> nur Referenz + Aktion.
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
lautet: *Betriebs- und Audit-Log sind nachvollziehbar, aber datensparsam, und keine Eingabe darf sie
fälschen.* A11Y-Aspekt: Log-Ausgaben und Fehlermeldungen bleiben klare Textfelder ohne reine Farbsignale,
damit sie mit Screenreader und Braille-Zeile gut lesbar sind.

**EN:** Relation to the Secure Development Guideline: privacy, safe logging, and review/evidence obligations.
Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), `CL_09` (test
management), and `CL_11` (privacy/data quality). The security decision of this unit is: *the operational and
audit logs are traceable yet data-minimal, and no input may forge them.* Accessibility aspect: log output and
error messages stay clear text fields without color-only signals, so they are easy to read with a screen
reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum trennt man beim Sammel-Dienst Betriebs-Log und Audit-Log? /
   **EN:** Why separate operational log and audit log in the collection service?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie haben unterschiedliche Zwecke und Empfänger: Das Betriebs-Log zeigt Ablauf und Fehler des
   Dienstes, das Audit-Log belegt fachliche und sicherheitsrelevante Aktionen. Getrennt bleiben beide besser
   prüfbar und aufbewahrbar.
   **EN:** They have different purposes and recipients: the operational log shows service flow and errors, the
   audit log evidences business and security actions. Separated, both stay easier to review and retain.

   </details>

2. **DE:** Warum ist strukturiertes Logging sicherer als zusammengebaute Freitext-Zeilen? /
   **EN:** Why is structured logging safer than concatenated free-text lines?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Getrennte Felder lassen sich gezielt bereinigen und auswerten. Zusammengebaute Zeilen können durch
   Zeilenumbrüche in gesammelten Daten gefälscht werden (Log-Injection).
   **EN:** Separate fields can be sanitized and evaluated precisely. Concatenated lines can be forged through
   line breaks in collected data (log injection).

   </details>

3. **DE:** Welche Inhalte dürfen niemals im Log stehen? /
   **EN:** Which content must never appear in the log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Secrets, Tokens, Zugangsdaten und vollständige Freitexte sowie unnötige personenbezogene Daten.
   Beispielwerte für Secrets bleiben Platzhalter wie `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** Secrets, tokens, credentials, complete free text, and unnecessary personal data. Example values for
   secrets stay placeholders like `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

4. **DE:** (AE) Welche Daten eines Snapshots werden technisch leicht geloggt, sind aber fachlich unnötig? /
   **EN:** (AE) Which snapshot data is technically easy to log but functionally unnecessary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der ganze Snapshot oder komplette Rohdaten. Meist reichen Aktion, Maschinen-Referenz und
   Zustandsänderung. Datensparsamkeit senkt das Risiko.
   **EN:** The whole snapshot or complete raw data. Usually action, machine reference, and state change are
   enough. Data minimization reduces risk.

   </details>

5. **DE:** (SI) Wie bleibt das Betriebs-Log eines Dienstes im Betrieb nützlich und trotzdem datensparsam? /
   **EN:** (SI) How does a service's operational log stay useful in operation and still data-minimal?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Indem es strukturierte, zweckgebundene Felder enthält: Startzeit, Intervall, Ergebnis und
   Fehlercode reichen für Betrieb und Fehlersuche, ohne Secrets oder vollständige Personendaten.
   **EN:** By containing structured, purpose-bound fields: start time, interval, result, and error code are
   enough for operation and troubleshooting, without secrets or complete personal data.

   </details>

6. **DE:** (DPA) Welche Audit-Daten reichen für eine Betriebsauswertung aus, ohne datenhungrig zu sein? /
   **EN:** (DPA) Which audit data is enough for operational analysis without being data-hungry?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Aktion, Zeitpunkt, Rolle und eine technische Referenz reichen für Kennzahlen wie Laufhäufigkeit
   oder Statuswechsel. Vollständige Freitexte oder Namen sind dafür nicht nötig.
   **EN:** Action, time, role, and a technical reference are enough for metrics such as run frequency or status
   changes. Complete free text or names are not needed for that.

   </details>

7. **DE:** (DV) Warum ist es wichtig, an der Systemgrenze gesammelte Werte vor dem Loggen zu bereinigen? /
   **EN:** (DV) Why is it important to sanitize values collected at the system boundary before logging?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Werte von entfernten Maschinen überqueren eine Vertrauensgrenze und können Steuerzeichen enthalten.
   Ohne Bereinigung könnten sie das Log fälschen oder Auswertungen stören.
   **EN:** Values from remote machines cross a trust boundary and may contain control characters. Without
   sanitization they could forge the log or disturb analysis.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: zentrales
   SIEM ist `N/A`, weil keine Betriebsintegration geplant ist; stattdessen gilt der Logging-Test als Nachweis.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: a central SIEM is
   `N/A` because no operational integration is planned; instead the logging test serves as evidence.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die zu protokollierenden Betriebs- und Audit-Ereignisse benennen.
- [ ] Betriebs-Log, Audit-Log und nutzerseitige Fehlermeldung trennen.
- [ ] erlaubte und verbotene Log-Felder klar unterscheiden.
- [ ] Log-Injection erklären und eine Gegenmaßnahme nennen.
- [ ] personenbezogene Daten im Log minimieren oder pseudonymisieren.
- [ ] Tests planen, die Secrets und personenbezogene Werte im Log ausschließen.

**EN:** I can …

- [ ] name the operational and audit events to be logged.
- [ ] separate operational log, audit log, and user-facing error message.
- [ ] clearly distinguish allowed and forbidden log fields.
- [ ] explain log injection and name a countermeasure.
- [ ] minimize or pseudonymize personal data in the log.
- [ ] plan tests that exclude secrets and personal values from the log.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester_04_Datenschutz-und-Betriebs-Audit-Logging.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester_04_Datenschutz-und-Betriebs-Audit-Logging.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
