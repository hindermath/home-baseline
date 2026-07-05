# Lernbegleiter: Secure CaseTracker v2 06 – Audit-Logging und Datenschutz / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-v2_06_Audit-Logging-und-Datenschutz.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein **Audit-Log** ist das Gedächtnis eines Systems: Es hält fest, *wer wann was* getan hat – etwa
„Fall 42 wurde geschlossen“. Das ist wichtig, um Vorgänge nachzuvollziehen und Missbrauch zu erkennen. Aber
genau hier liegt eine Spannung: Ein Protokoll, das *zu viel* speichert, wird selbst zur Datenschutz-Gefahr,
weil es personenbezogene Daten sammelt. Gutes Audit-Logging ist deshalb ein Balanceakt: **genug für die
Nachvollziehbarkeit, so wenig personenbezogen wie möglich**.

**EN:** An **audit log** is a system's memory: it records *who did what and when* – for example "case 42 was
closed". This matters to trace processes and detect misuse. But exactly here lies a tension: a log that stores
*too much* becomes a privacy hazard itself, because it collects personal data. Good audit logging is
therefore a balancing act: **enough for traceability, as little personal data as possible**.

**DE:** In dieser Einheit legst du fest, welche **Audit-Events** es gibt, welche **Logfelder erlaubt** und
welche **verboten** sind, wie lange protokolliert wird (**Aufbewahrung**) und wo die **Datenschutzgrenzen**
liegen. Ein Leitgedanke ist Datenminimierung; ein anderer ist Integrität: Logs sollen nicht unbemerkt
verändert werden können.

**EN:** In this unit you define which **audit events** exist, which **log fields are allowed** and which are
**forbidden**, how long logging is kept (**retention**), and where the **privacy boundaries** lie. One
guiding idea is data minimization; another is integrity: logs should not be alterable unnoticed.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Audit-Log / Audit log | Protokoll sicherheitsrelevanter Ereignisse mit Zeit und Auslöser. |
| Audit-Event / Audit event | Einzelnes protokolliertes Ereignis, z. B. „Status geändert“. |
| Datenminimierung / Data minimization | Nur die Daten protokollieren, die für den Zweck nötig sind. |
| Aufbewahrung / Retention | Zeitraum, in dem Logs gespeichert und danach gelöscht werden. |
| Pseudonymisierung / Pseudonymization | Ersetzen direkter Kennungen durch nicht direkt zuordenbare Werte. |
| Log-Integrität / Log integrity | Schutz davor, dass Logeinträge unbemerkt geändert werden. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Audit-Events auswählen.** Bestimme, welche Ereignisse sicherheits- oder
nachweisrelevant sind: Anmeldung, Rechteänderung, Statusänderung, Export, fehlgeschlagener Zugriff. **Warum
wichtig:** Nicht jedes Ereignis muss ins Audit-Log; zu viele Events verwässern den Nachweis und erhöhen das
Datenschutzrisiko.

**EN:** **Step 1 – Select audit events.** Determine which events are security- or evidence-relevant: login,
rights change, status change, export, failed access. **Why it matters:** not every event needs to be in the
audit log; too many events dilute the evidence and raise the privacy risk.

**DE:** **Schritt 2 – Erlaubte und verbotene Logfelder trennen.** Erlaubt sind z. B. Ereignistyp, Zeit, Fall-
ID, pseudonyme Akteurskennung. Verboten sind z. B. Klartextnamen, Passwörter, ganze Fallnotizen,
Zugangsdaten. **Warum wichtig:** Das Log wird sonst selbst zur sensiblen Datensammlung. Pseudonymisierung
hält die Nachvollziehbarkeit, ohne die Person direkt offenzulegen.

**EN:** **Step 2 – Separate allowed and forbidden log fields.** Allowed are e.g. event type, time, case ID,
pseudonymous actor identifier. Forbidden are e.g. plain-text names, passwords, whole case notes, credentials.
**Why it matters:** otherwise the log itself becomes a sensitive data collection. Pseudonymization keeps
traceability without directly exposing the person.

**DE:** **Schritt 3 – Aufbewahrung und Löschung planen.** Lege fest, wie lange Logs gebraucht werden und wann
sie gelöscht werden. **Warum wichtig:** Unbegrenztes Aufheben verletzt Datenminimierung und Datenschutz. Eine
klare Frist ist auch eine Sicherheitsentscheidung.

**EN:** **Step 3 – Plan retention and deletion.** Set how long logs are needed and when they are deleted.
**Why it matters:** keeping logs indefinitely violates data minimization and privacy. A clear retention period
is also a security decision.

**DE:** **Schritt 4 – Integrität und Log-Injection bedenken.** Logs sollen nachträglich nicht unbemerkt
änderbar sein (z. B. nur anhängen). Freitext in Events muss bereinigt sein, damit niemand über eine Eingabe
gefälschte Logzeilen einschleust (**Log-Injection**). **Warum wichtig:** Ein manipulierbares Log ist als
Nachweis wertlos.

**EN:** **Step 4 – Consider integrity and log injection.** Logs should not be alterable unnoticed afterwards
(e.g. append-only). Free text in events must be sanitized so no one injects forged log lines through an input
(**log injection**). **Why it matters:** a tamperable log is worthless as evidence.

**DE:** **Typische Fehler.** Klartextnamen oder ganze Notizen loggen. Passwörter oder Tokens ins Log
schreiben. Alles unbegrenzt aufheben. Freitext ungefiltert protokollieren. Kein Schutz gegen nachträgliche
Änderung.

**EN:** **Common mistakes.** Logging plain-text names or whole notes. Writing passwords or tokens into the
log. Keeping everything indefinitely. Logging free text unfiltered. No protection against later alteration.

### Beispiel / Example

```text
Audit-Event: STATUS_GEAENDERT
  erlaubt:   event=STATUS_GEAENDERT, zeit=2026-07-05T10:12Z, fall_id=42,
             akteur=usr_7f3 (Pseudonym), alt=offen, neu=geschlossen
  verboten:  name="Erika Mustermann", notiz="voller Freitext ...", passwort=...

Aufbewahrung: 180 Tage, danach automatische Loeschung (Datenminimierung)
Integritaet:  append-only; keine nachtraegliche Aenderung einzelner Zeilen
Log-Injection-Schutz: Freitextfelder werden vor dem Schreiben bereinigt
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Audit-Logging und Datenschutzgrenzen setzen den ermittelten Schutzbedarf konkret um. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Das Logging ist Teil der nachvollziehbaren Datenverwaltung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Datenschutz, Datenminimierung, sichere Programmierung und
auditfähige Nachweise. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04`
(Bedrohungsmodellierung), `CL_08` (Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12`
(Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet: *Protokolliere genug für die
Nachvollziehbarkeit, aber so wenig personenbezogen wie möglich, und schütze das Log vor Veränderung.*
A11Y-Aspekt: Logausgaben und Audit-Berichte müssen als klarer Text lesbar sein, ohne dass Bedeutung nur über
Farbe transportiert wird, damit Screenreader- und Braille-Nutzende sie erfassen.

**EN:** Relation to the Secure Development Guideline: privacy, data minimization, secure coding, and auditable
evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat modeling), `CL_08` (security
code review), `CL_10` (privacy), and `CL_12` (evidence / N/A rationale). The security decision of this unit
is: *log enough for traceability, but as little personal data as possible, and protect the log from
alteration.* Accessibility aspect: log outputs and audit reports must be readable as clear text without
meaning carried only by color, so screen-reader and Braille users can grasp them.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist ein Audit-Log wichtig, und warum darf es trotzdem nicht alles speichern? /
   **EN:** Why is an audit log important, and why must it still not store everything?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es macht Vorgänge nachvollziehbar und deckt Missbrauch auf. Speichert es zu viel Personenbezogenes,
   wird es selbst zur Datenschutz-Gefahr. Datenminimierung hält die Balance.
   **EN:** It makes processes traceable and reveals misuse. If it stores too much personal data, it becomes a
   privacy hazard itself. Data minimization keeps the balance.

   </details>

2. **DE:** Welche Logfelder sind typischerweise verboten, und warum? /
   **EN:** Which log fields are typically forbidden, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Passwörter, Tokens, Klartextnamen und ganze Fallnotizen. Sie sind sensibel; im Log gespeichert
   erhöhen sie das Schadensrisiko bei einem Leck erheblich.
   **EN:** Passwords, tokens, plain-text names, and whole case notes. They are sensitive; stored in the log they
   greatly increase the damage risk in a leak.

   </details>

3. **DE:** (DPA) Wie hilft Pseudonymisierung, Nachvollziehbarkeit und Datenschutz zu verbinden? /
   **EN:** (DPA) How does pseudonymization help combine traceability and privacy?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine pseudonyme Akteurskennung erlaubt, Vorgänge einer Kennung zuzuordnen, ohne den Klarnamen im Log
   zu führen. So bleibt der Bezug nachvollziehbar, aber nicht direkt personenbezogen.
   **EN:** A pseudonymous actor identifier lets you attribute actions to an identifier without carrying the real
   name in the log. The reference stays traceable but not directly personal.

   </details>

4. **DE:** (SI) Warum sollte ein Audit-Log möglichst nur anhängbar (append-only) sein? /
   **EN:** (SI) Why should an audit log ideally be append-only?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Log, das nachträglich unbemerkt änderbar ist, taugt nicht als Nachweis. Append-only schützt die
   Integrität: Einträge lassen sich hinzufügen, aber nicht heimlich verändern.
   **EN:** A log that can be altered unnoticed afterwards is useless as evidence. Append-only protects
   integrity: entries can be added but not secretly changed.

   </details>

5. **DE:** Was ist Log-Injection, und wie verhindert man sie? /
   **EN:** What is log injection, and how do you prevent it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Angreifer schleust über eine Eingabe gefälschte Logzeilen ein. Man verhindert es, indem man
   Freitext vor dem Schreiben bereinigt und Länge begrenzt.
   **EN:** An attacker injects forged log lines through an input. You prevent it by sanitizing free text before
   writing and limiting its length.

   </details>

6. **DE:** Warum braucht ein Log eine klare Aufbewahrungsfrist? /
   **EN:** Why does a log need a clear retention period?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Unbegrenztes Aufheben verletzt Datenminimierung und Datenschutz. Eine Frist mit automatischer
   Löschung begrenzt das Risiko und ist eine bewusste Sicherheitsentscheidung.
   **EN:** Keeping logs indefinitely violates data minimization and privacy. A period with automatic deletion
   limits the risk and is a deliberate security decision.

   </details>

7. **DE:** Warum sollten nicht anwendbare Standards als `N/A` mit Begründung dokumentiert werden statt
   weggelassen? /
   **EN:** Why should non-applicable standards be documented as `N/A` with a rationale instead of omitted?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine begründete `N/A`-Angabe bleibt auditfähig und zeigt, dass der Punkt bewusst geprüft wurde.
   Stille Auslassung sieht aus wie ein Vergessen.
   **EN:** A justified `N/A` stays auditable and shows the point was deliberately reviewed. Silent omission
   looks like an oversight.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] sicherheitsrelevante Audit-Events auswählen und begründen.
- [ ] erlaubte von verbotenen Logfeldern unterscheiden.
- [ ] eine Aufbewahrungs- und Löschregel festlegen.
- [ ] Log-Integrität und Schutz gegen Log-Injection erklären.
- [ ] Datenschutzgrenzen des Loggings als `Applicable`/`N/A`/`Open` dokumentieren.

**EN:** I can …

- [ ] select and justify security-relevant audit events.
- [ ] distinguish allowed from forbidden log fields.
- [ ] set a retention and deletion rule.
- [ ] explain log integrity and protection against log injection.
- [ ] document logging privacy boundaries as `Applicable`/`N/A`/`Open`.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-v2_06_Audit-Logging-und-Datenschutz.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-v2_06_Audit-Logging-und-Datenschutz.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
