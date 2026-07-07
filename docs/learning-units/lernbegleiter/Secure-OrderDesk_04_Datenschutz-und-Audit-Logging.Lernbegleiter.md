# Lernbegleiter: Secure OrderDesk 04 – Datenschutz und Audit-Logging / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk_04_Datenschutz-und-Audit-Logging.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Die Bestell-/Handelsplattform **Secure OrderDesk** verarbeitet Kunden-, Produkt- und Bestelldaten aus
der Northwind-Basis (inkl. `ALFKI`). Wie bei jeder Software muss man später nachvollziehen können, **was**
passiert ist. Dafür gibt es zwei Arten von Protokollen. Das **Betriebs-Log** hält den Ablauf und Fehler der
Plattform fest (z. B. „Auswertung gestartet", „Datenbankfehler beim Speichern"). Das **Audit-Log** hält
sicherheits- und fachrelevante Ereignisse fest (z. B. „Kunde geändert", „Bestellung erfasst", „Export
durchgeführt"). Beide müssen **nachvollziehbar** sein, dürfen aber nicht **datenhungrig** werden: keine
Secrets, keine vollständige Kundenanschrift, keine unnötigen personenbezogenen Daten. Und niemand darf über
eine manipulierte Eingabe das Protokoll fälschen (Log-Injection).

**EN:** The ordering/trading platform **Secure OrderDesk** processes customer, product, and order data from the
Northwind base (incl. `ALFKI`). As with any software, you must later be able to trace **what** happened. For
this there are two kinds of logs. The **operational log** records the platform flow and errors (e.g. "report
started", "database error while saving"). The **audit log** records security- and business-relevant events
(e.g. "customer changed", "order captured", "export performed"). Both must be **traceable** but must not become
**data-hungry**: no secrets, no complete customer address, no unnecessary personal data. And no one may forge
the log through a manipulated input (log injection).

**DE:** In dieser Einheit legst du die Ereignisliste fest, entscheidest je Log-Ebene, welche Felder erlaubt und
welche verboten sind, trennst die nutzerseitige Fehlermeldung vom internen Log und planst Tests, die beweisen,
dass keine Secrets oder personenbezogenen Kundendaten im Log landen. Statt eines vollständigen Kontaktnamens
protokollierst du eine technische Referenz wie `CustomerID` (z. B. `ALFKI`).

**EN:** In this unit you define the event list, decide per log level which fields are allowed and which are
forbidden, separate the user-facing error message from the internal log, and plan tests that prove no secrets
or personal customer data end up in the log. Instead of a full contact name you log a technical reference such
as `CustomerID` (e.g. `ALFKI`).

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Betriebs-Log / Operational log | Protokoll über Ablauf, Zustand und Fehler der laufenden Plattform. |
| Audit-Log / Audit log | Strukturierter Nachweis über sicherheits- und fachrelevante Ereignisse. |
| Log-Injection | Angriff, bei dem eine Eingabe das Protokoll verfälscht oder Zeilen fälscht. |
| Strukturiertes Logging / Structured logging | Log mit klar getrennten Feldern statt zusammengebauter Freitext-Zeilen. |
| Pseudonymisierung / Pseudonymization | Personenbezug durch ein Ersatzkennzeichen abschwächen, z. B. `CustomerID` statt Name. |
| Datensparsamkeit / Data minimization | So wenig Kundendaten wie möglich protokollieren, nur zweckgebunden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Ereignisse festlegen.** Bestimme, welche Ereignisse geloggt werden: Kunde angelegt oder
geändert, Bestellung erfasst, Bestellposition geändert, Auswertung ausgeführt, Export durchgeführt,
Anmeldeversuch einer Rolle. Warum eine feste Liste? Nur benannte Ereignisse lassen sich einheitlich und
testbar protokollieren.

**EN:** **Step 1 – Define events.** Determine which events are logged: customer created or changed, order
captured, order line changed, report executed, export performed, role sign-in attempt. Why a fixed list? Only
named events can be logged consistently and testably.

**DE:** **Schritt 2 – Betriebs-Log und Audit-Log trennen.** Das Betriebs-Log dient dem Betrieb (Läuft die
Plattform? Welcher Datenbankfehler trat auf?). Das Audit-Log dient dem Nachweis (Welche Rolle hat welche
fachliche Aktion an Kunden- oder Bestelldaten ausgelöst?). Warum trennen? Die beiden Logs haben
unterschiedliche Zwecke, Empfänger und Aufbewahrungsfragen. Eine Vermischung macht beide schlechter prüfbar.

**EN:** **Step 2 – Separate operational log and audit log.** The operational log serves operations (is the
platform running? which database error occurred?). The audit log serves evidence (which role triggered which
business action on customer or order data?). Why separate? The two logs have different purposes, recipients,
and retention questions. Mixing them makes both harder to review.

**DE:** **Schritt 3 – Erlaubte und verbotene Felder je Log.** Ein Eintrag enthält Zweck, Zeitpunkt, Aktion,
Rolle und eine technische Referenz (z. B. `CustomerID`, `OrderID`). Verboten sind Secrets, Tokens,
Zugangsdaten, vollständige Kundenanschrift, Kontaktname und vollständige Freitexte. Warum diese Trennung? Sie
hält das Log beweiskräftig, aber datensparsam, und verhindert, dass sensible personenbezogene Kundendaten
versehentlich gespeichert werden.

**EN:** **Step 3 – Allowed and forbidden fields per log.** An entry contains purpose, time, action, role, and
a technical reference (e.g. `CustomerID`, `OrderID`). Forbidden are secrets, tokens, credentials, full customer
address, contact name, and complete free text. Why this separation? It keeps the log evidential yet
data-minimal and prevents accidental storage of sensitive personal customer data.

**DE:** **Schritt 4 – Log-Injection verhindern und Ebenen trennen.** Bereinige Werte, bevor sie ins Log gehen:
entferne oder maskiere Zeilenumbrüche und Steuerzeichen aus Kunden-/Bestelleingaben und nutze **strukturiertes
Logging**. Trenne außerdem **nutzerseitige Fehlermeldungen** von **internen Logs**: Der Endnutzer sieht keine
SQL-Fehler, Tabellennamen oder Stack-Traces, das interne Log enthält keine Secrets. Warum? Sonst kann ein
Firmenname wie `"Foo\nFAKE: admin login"` eine falsche Log-Zeile vortäuschen, und interne Details helfen
Angreifern.

**EN:** **Step 4 – Prevent log injection and separate levels.** Sanitize values before they enter the log:
remove or escape line breaks and control characters from customer/order input and use **structured logging**.
Also separate **user-facing error messages** from **internal logs**: the end user sees no SQL errors, table
names, or stack traces, the internal log contains no secrets. Why? Otherwise a company name like `"Foo\nFAKE:
admin login"` could fake a false log line, and internal details help attackers.

**DE:** **Typische Fehler.** Ganze Kundendatensätze oder Bestellobjekte einfach mitloggen. Secrets oder
Verbindungszeichenketten im Log. Betriebs- und Audit-Log vermischen. Zeilenumbrüche aus Firmen- oder
Kontaktnamen ungefiltert übernehmen. Interne SQL-Fehler in nutzerseitige Meldungen geben. Nicht anwendbare
Standards stillschweigend weglassen statt sie als `N/A` mit kurzer Begründung zu dokumentieren.

**EN:** **Common mistakes.** Logging whole customer records or order objects. Secrets or connection strings in
the log. Mixing operational and audit logs. Taking line breaks from company or contact names unfiltered.
Putting internal SQL errors into user-facing messages. Silently dropping non-applicable standards instead of
documenting them as `N/A` with a short justification.

### Beispiel / Example

```text
Audit-Eintrag (gut):
  event=order_created  role=developer  customerRef=ALFKI  orderRef=50218  ts=2026-07-07T09:12Z
Audit-Eintrag (schlecht - NICHT so):
  "developer legte Bestellung fuer Alfreds Futterkiste, Maria Anders, Berlin an; token=<PLATZHALTER-KEIN-ECHTER-WERT>\nADMIN login ok"
Betriebs-Log (gut):    event=report_started  report=umsatz_je_kategorie  ts=2026-07-07T09:10Z
Log-Injection-Eingabe: CompanyName = "Foo\nFAKE: customer_deleted by admin"
Behandlung:            Zeilenumbruch entfernt/maskiert -> nur ein sauberes Feld, keine falsche Zeile.
Datenschutz:           kein Kontaktname, keine Anschrift, kein Token -> nur CustomerID + Aktion.
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Basis"):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Basis"):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Datenschutz der Kundendaten, Zweckbindung und Log-Injection-Schutz sind Kern der Schutzbedarfsbewertung. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Nachvollziehbare, datensparsame Protokollierung ist Teil der Verwaltung von Kunden- und Bestelldaten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, sichere Protokollierung sowie Review- und
Evidenzpflicht. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review),
`CL_09` (Testmanagement) und `CL_11` (Datenschutz/Datenqualität). Die Sicherheitsentscheidung dieser Einheit
lautet: *Betriebs- und Audit-Log sind nachvollziehbar, aber datensparsam, personenbezogene Kundendaten werden
pseudonymisiert, und keine Eingabe darf das Log fälschen.* A11Y-Aspekt: Log-Ausgaben und Fehlermeldungen
bleiben klare Textfelder ohne reine Farbsignale, damit sie mit Screenreader und Braille-Zeile gut lesbar sind.

**EN:** Relation to the Secure Development Guideline: privacy, safe logging, and review/evidence obligations.
Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), `CL_09` (test
management), and `CL_11` (privacy/data quality). The security decision of this unit is: *the operational and
audit logs are traceable yet data-minimal, personal customer data is pseudonymized, and no input may forge the
log.* Accessibility aspect: log output and error messages stay clear text fields without color-only signals, so
they are easy to read with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum trennt man in Secure OrderDesk Betriebs-Log und Audit-Log? /
   **EN:** Why separate operational log and audit log in Secure OrderDesk?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie haben unterschiedliche Zwecke und Empfänger: Das Betriebs-Log zeigt Ablauf und Fehler der
   Plattform, das Audit-Log belegt fachliche und sicherheitsrelevante Aktionen an Kunden- und Bestelldaten.
   Getrennt bleiben beide besser prüfbar und aufbewahrbar.
   **EN:** They have different purposes and recipients: the operational log shows platform flow and errors, the
   audit log evidences business and security actions on customer and order data. Separated, both stay easier to
   review and retain.

   </details>

2. **DE:** Warum ist strukturiertes Logging sicherer als zusammengebaute Freitext-Zeilen? /
   **EN:** Why is structured logging safer than concatenated free-text lines?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Getrennte Felder lassen sich gezielt bereinigen und auswerten. Zusammengebaute Zeilen können durch
   Zeilenumbrüche in Firmen- oder Kontaktnamen gefälscht werden (Log-Injection).
   **EN:** Separate fields can be sanitized and evaluated precisely. Concatenated lines can be forged through
   line breaks in company or contact names (log injection).

   </details>

3. **DE:** Welche Inhalte dürfen niemals im Log stehen? /
   **EN:** Which content must never appear in the log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Secrets, Tokens, Verbindungszeichenketten, vollständige Kundenanschrift, Kontaktname und
   vollständige Freitexte. Beispielwerte für Secrets bleiben Platzhalter wie `<PLATZHALTER-KEIN-ECHTER-WERT>`.
   **EN:** Secrets, tokens, connection strings, full customer address, contact name, and complete free text.
   Example values for secrets stay placeholders like `<PLATZHALTER-KEIN-ECHTER-WERT>`.

   </details>

4. **DE:** (AE) Welche Bestelldaten werden technisch leicht geloggt, sind aber fachlich unnötig? /
   **EN:** (AE) Which order data is technically easy to log but functionally unnecessary?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Das ganze Bestellobjekt mit Kundenanschrift oder kompletten Positionslisten. Meist reichen Aktion,
   `CustomerID`, `OrderID` und Zustandsänderung. Datensparsamkeit senkt das Risiko.
   **EN:** The whole order object with customer address or complete line lists. Usually action, `CustomerID`,
   `OrderID`, and state change are enough. Data minimization reduces risk.

   </details>

5. **DE:** (DPA) Wie protokolliert man eine Kundenänderung datenschutzgerecht? /
   **EN:** (DPA) How do you log a customer change in a privacy-compliant way?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit `CustomerID` (z. B. `ALFKI`), Aktion, Rolle und Zeitpunkt statt mit vollständigem Kontaktnamen
   und Anschrift. Die Referenz reicht für den Nachweis, ohne personenbezogene Kundendaten offenzulegen
   (Pseudonymisierung, Datenminimierung).
   **EN:** With `CustomerID` (e.g. `ALFKI`), action, role, and time instead of the full contact name and
   address. The reference is enough for evidence without disclosing personal customer data (pseudonymization,
   data minimization).

   </details>

6. **DE:** (SI) Warum darf ein Datenbankfehler nicht als interne Meldung an den Endnutzer gehen? /
   **EN:** (SI) Why must a database error not go to the end user as an internal message?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** SQL-Text, Tabellennamen oder Stack-Traces verraten interne Struktur und helfen Angreifern. Der
   Nutzer bekommt eine klare, allgemeine Meldung; die Details bleiben im internen Betriebs-Log ohne Secrets.
   **EN:** SQL text, table names, or stack traces reveal internal structure and help attackers. The user gets a
   clear, general message; the details stay in the internal operational log without secrets.

   </details>

7. **DE:** Warum ist `ALFKI` als fester Referenzanker im Logging-Test nützlich? /
   **EN:** Why is `ALFKI` a useful fixed reference anchor in the logging test?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** `ALFKI` (fiktiv, aus Northwind) ist ein bekannter, stabiler Kunde. Tests können reproduzierbar
   prüfen, dass nur die Referenz und nicht der Kontaktname im Log erscheint.
   **EN:** `ALFKI` (fictional, from Northwind) is a well-known, stable customer. Tests can reproducibly check
   that only the reference and not the contact name appears in the log.

   </details>

8. **DE:** Wie dokumentierst du einen Standard, der in dieser Einheit nicht anwendbar ist? /
   **EN:** How do you document a standard that is not applicable in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Als `N/A` mit kurzer technischer Begründung, nicht durch stilles Weglassen. Beispiel: zentrales SIEM
   ist `N/A`, weil keine Betriebsintegration geplant ist; stattdessen gilt der Logging-Test als Nachweis.
   **EN:** As `N/A` with a short technical justification, not by silent omission. Example: a central SIEM is
   `N/A` because no operational integration is planned; instead the logging test serves as evidence.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die zu protokollierenden Betriebs- und Audit-Ereignisse von Secure OrderDesk benennen.
- [ ] Betriebs-Log, Audit-Log und nutzerseitige Fehlermeldung trennen.
- [ ] erlaubte und verbotene Log-Felder klar unterscheiden (z. B. `CustomerID` statt Kontaktname).
- [ ] Log-Injection erklären und eine Gegenmaßnahme nennen.
- [ ] personenbezogene Kundendaten im Log minimieren oder pseudonymisieren.
- [ ] Tests planen, die Secrets und personenbezogene Kundendaten im Log ausschließen.

**EN:** I can …

- [ ] name the operational and audit events of Secure OrderDesk to be logged.
- [ ] separate operational log, audit log, and user-facing error message.
- [ ] clearly distinguish allowed and forbidden log fields (e.g. `CustomerID` instead of contact name).
- [ ] explain log injection and name a countermeasure.
- [ ] minimize or pseudonymize personal customer data in the log.
- [ ] plan tests that exclude secrets and personal customer data from the log.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk_04_Datenschutz-und-Audit-Logging.md`. Der Copy-Paste-Prompt für einen späteren,
manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk_04_Datenschutz-und-Audit-Logging.md`. The copy-paste prompt for a later, manually
started Spec Kit run is provided there.
