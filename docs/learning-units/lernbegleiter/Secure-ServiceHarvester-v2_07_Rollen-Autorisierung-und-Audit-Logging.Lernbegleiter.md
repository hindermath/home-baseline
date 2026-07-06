# Lernbegleiter: Secure ServiceHarvester v2 07 – Rollen-, Autorisierung und Audit-Logging / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_07_Rollen-Autorisierung-und-Audit-Logging.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Nicht jede Person darf mit dem Secure ServiceHarvester alles tun. Wer nur Statusdaten ansehen will,
braucht keine Rechte zum Löschen. In dieser Einheit legst du zwei Dinge zusammen fest: **wer welche Aktion
darf** (Rollen und Autorisierung) und **welche sicherheitsrelevanten Aktionen nachvollziehbar
aufgeschrieben** werden (Audit-Logging). Die Grundregel für die Rechte ist **Deny-by-default**: erlaubt ist
nur, was ausdrücklich erlaubt wurde. Die Grundregel für das Audit-Log ist **Nachvollziehbarkeit ohne
Geheimnisse**: es zeigt, wer wann was tat, aber niemals Passwörter, Tokens oder personenbezogene Details.

**EN:** Not every person may do everything with the Secure ServiceHarvester. Someone who only wants to view
status data needs no rights to delete. In this unit you define two things together: **who may perform which
action** (roles and authorization) and **which security-relevant actions are written down traceably** (audit
logging). The base rule for rights is **deny-by-default**: only what was explicitly allowed is permitted. The
base rule for the audit log is **traceability without secrets**: it shows who did what and when, but never
passwords, tokens, or personal details.

**DE:** Rechte und Audit gehören zusammen, weil ein Audit-Log erst dann Sinn ergibt, wenn klar ist, welche
Aktionen überhaupt erlaubt sind. Du erstellst eine **Rechtematrix**, sammelst **Missbrauchsfälle** und legst
eine **Audit-Event-Liste** mit erlaubten und verbotenen Logfeldern an.

**EN:** Rights and audit belong together, because an audit log only makes sense once it is clear which actions
are allowed at all. You create a **permission matrix**, collect **abuse cases**, and set up an **audit event
list** with allowed and forbidden log fields.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Rolle / Role | Bündel von Rechten für eine Aufgabe, z. B. Betrachter, Bearbeiter, Betreiber. |
| Autorisierung / Authorization | Prüfung, ob eine angemeldete Rolle eine Aktion ausführen darf. |
| Deny-by-default / Deny-by-default | Sicherer Standard: alles ist verboten, außer es ist ausdrücklich erlaubt. |
| Missbrauchsfall / Abuse case | Bewusst durchdachter Weg, wie jemand Rechte umgehen könnte. |
| Audit-Event / Audit event | Nachvollziehbarer Eintrag über eine sicherheitsrelevante Aktion. |
| Verbotenes Logfeld / Forbidden log field | Feld, das nie protokolliert wird, z. B. Secret, Token, Klartext-Person. |
| Datenminimierung / Data minimization | Nur so viele Daten erfassen, wie für den Zweck nötig sind. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Rollen und Aktionen benennen.** Liste die Rollen (z. B. Betrachter, Bearbeiter,
Betreiber) und die möglichen Aktionen (Snapshot ansehen, Snapshot importieren, Maschine löschen, Dienst
neu starten). **Warum wichtig:** Ohne benannte Rollen und Aktionen lässt sich kein Recht sauber zuordnen.

**EN:** **Step 1 – Name roles and actions.** List the roles (e.g. viewer, editor, operator) and the possible
actions (view snapshot, import snapshot, delete machine, restart service). **Why it matters:** without named
roles and actions no right can be assigned cleanly.

**DE:** **Schritt 2 – Rechtematrix mit Deny-by-default aufstellen.** Trage in eine Tabelle ein, welche Rolle
welche Aktion darf. Alles, was nicht ausdrücklich erlaubt ist, gilt als verboten. **Warum wichtig:**
Deny-by-default schließt vergessene Fälle sicher, statt sie versehentlich offenzulassen.

**EN:** **Step 2 – Build the permission matrix with deny-by-default.** Enter in a table which role may perform
which action. Everything not explicitly allowed counts as forbidden. **Why it matters:** deny-by-default
closes forgotten cases safely instead of accidentally leaving them open.

**DE:** **Schritt 3 – Missbrauchsfälle durchdenken.** Frage: Wie könnte jemand ein Recht umgehen? Beispiele:
ein Betrachter versucht zu importieren, oder ein fehlerhafter Zustand lässt eine verbotene Aktion durch.
**Warum wichtig:** Missbrauchsfälle zeigen Lücken, bevor sie ausgenutzt werden.

**EN:** **Step 3 – Think through abuse cases.** Ask: how could someone bypass a right? Examples: a viewer
tries to import, or a faulty state lets a forbidden action through. **Why it matters:** abuse cases reveal
gaps before they are exploited.

**DE:** **Schritt 4 – Audit-Events festlegen.** Bestimme, welche Aktionen protokolliert werden (z. B. Login,
Import, Löschung, Rechteänderung) und welche Felder ein Event enthält: Zeitpunkt, Rolle, Aktion, Ergebnis.
**Warum wichtig:** Nur benannte Events lassen sich später prüfen; wahllos alles zu loggen erzeugt Rauschen und
Risiko.

**EN:** **Step 4 – Define audit events.** Determine which actions are logged (e.g. login, import, deletion,
rights change) and which fields an event contains: timestamp, role, action, result. **Why it matters:** only
named events can be reviewed later; logging everything indiscriminately creates noise and risk.

**DE:** **Schritt 5 – Verbotene Logfelder ausschließen.** Secrets, Tokens, Passwörter und personenbezogene
Klartextdaten dürfen nie ins Audit-Log. Nutze Datenminimierung: nur Ereignis, Rolle und Ergebnis, keine
sensiblen Werte. **Warum wichtig:** Ein Log, das Geheimnisse enthält, wird selbst zum Angriffsziel.

**EN:** **Step 5 – Exclude forbidden log fields.** Secrets, tokens, passwords, and personal plain-text data
must never enter the audit log. Use data minimization: only event, role, and result, no sensitive values.
**Why it matters:** a log that contains secrets becomes an attack target itself.

**DE:** **Typische Fehler.** Rechte allow-by-default vergeben. Missbrauchsfälle weglassen. Zu viele Rollen
erfinden, die niemand pflegt. Secrets oder ganze Eingaben ins Audit-Log schreiben. Audit-Events nur bei
Erfolg, aber nicht bei Ablehnung protokollieren.

**EN:** **Common mistakes.** Granting rights allow-by-default. Omitting abuse cases. Inventing too many roles
that nobody maintains. Writing secrets or whole inputs into the audit log. Logging audit events only on
success but not on denial.

### Beispiel / Example

```text
Rechtematrix (Deny-by-default):

  Aktion \ Rolle        Betrachter   Bearbeiter   Betreiber
  Snapshot ansehen      erlaubt      erlaubt      erlaubt
  Snapshot importieren  verboten     erlaubt      erlaubt
  Maschine loeschen     verboten     verboten     erlaubt
  Dienst neu starten    verboten     verboten     erlaubt
  (nicht gelistet)      verboten     verboten     verboten   <- Deny-by-default

Missbrauchsfall: Betrachter ruft Import-Endpunkt direkt auf -> muss mit "nicht erlaubt" abgelehnt werden

Audit-Event (erlaubte Felder):
  { ts, rolle: "Bearbeiter", aktion: "import", ergebnis: "ok", anzahl: 12 }

NICHT so (verbotene Felder):
  { ts, token: "<PLATZHALTER-KEIN-ECHTER-WERT>", passwort: "...", person: "..." }  -> niemals loggen
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Rechtematrix, Deny-by-default und ein secret-freies Audit-Log setzen den Schutzbedarf praktisch um. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Autorisierung und Audit-Events verändern das Verhalten der datenverwaltenden Dienst-Software. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Zugangssteuerung, Least Privilege, Fail-safe-Defaults,
Datenschutz und auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04`
(Logging und Nachweise), `CL_05` (Zugangssteuerung/Autorisierung), `CL_08` (Sicherheits-Code-Review),
`CL_10` (Datenschutz) und `CL_12` (Nachweise und Abschluss). Die Sicherheitsentscheidung dieser Einheit
lautet: *Rechte gelten deny-by-default, jede sicherheitsrelevante Aktion wird auditiert, und kein Secret
gelangt ins Log.* A11Y-Aspekt: Rechtematrix und Audit-Felder müssen als klarer Text ohne reine Farbmarkierung
lesbar sein, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: access control, least privilege, fail-safe defaults,
privacy, and audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (logging and
evidence), `CL_05` (access control / authorization), `CL_08` (security code review), `CL_10` (privacy), and
`CL_12` (evidence and closure). The security decision of this unit is: *rights are deny-by-default, every
security-relevant action is audited, and no secret reaches the log.* Accessibility aspect: the permission
matrix and audit fields must be readable as clear text without color-only marking, so they remain usable with
a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Deny-by-default und warum ist es sicherer als Allow-by-default? /
   **EN:** What does deny-by-default mean and why is it safer than allow-by-default?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Deny-by-default verbietet alles, was nicht ausdrücklich erlaubt ist. Vergessene oder neue Aktionen
   bleiben so automatisch gesperrt, statt versehentlich offen zu sein. Allow-by-default öffnet dagegen
   unbemerkt Lücken.
   **EN:** Deny-by-default forbids everything not explicitly allowed. Forgotten or new actions stay blocked
   automatically instead of being accidentally open. Allow-by-default, in contrast, opens gaps unnoticed.

   </details>

2. **DE:** Warum gehören Rollen/Autorisierung und Audit-Logging in einer Einheit zusammen? /
   **EN:** Why do roles/authorization and audit logging belong together in one unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Audit-Log ergibt erst Sinn, wenn klar ist, welche Aktionen erlaubt sind. Rechte legen fest, was
   passieren darf; das Audit-Log zeigt, was tatsächlich passiert ist. Zusammen ergeben sie Kontrolle und
   Nachweis.
   **EN:** An audit log only makes sense once it is clear which actions are allowed. Rights define what may
   happen; the audit log shows what actually happened. Together they provide control and evidence.

   </details>

3. **DE:** (SI) Warum dürfen keine Secrets oder Tokens in ein Audit-Log gelangen? /
   **EN:** (SI) Why must no secrets or tokens enter an audit log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Log wird oft breit gespeichert, kopiert und ausgewertet. Enthält es Geheimnisse, wird es selbst
   zum Angriffsziel und kann Zugangsdaten preisgeben. Deshalb gehören Secrets nie ins Log.
   **EN:** A log is often stored broadly, copied, and analyzed. If it contains secrets, it becomes an attack
   target itself and can expose credentials. Therefore secrets never belong in the log.

   </details>

4. **DE:** (AE) Wie hilft eine Rechtematrix bei der Umsetzung im Code? /
   **EN:** (AE) How does a permission matrix help with implementation in code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Matrix bündelt an einer Stelle, welche Rolle welche Aktion darf. Der Code kann daraus eine
   zentrale Autorisierungsprüfung ableiten, statt verstreute Einzelprüfungen zu pflegen, die leicht
   widersprüchlich werden.
   **EN:** The matrix bundles in one place which role may perform which action. The code can derive a central
   authorization check from it, instead of maintaining scattered individual checks that easily become
   inconsistent.

   </details>

5. **DE:** Warum ist es sinnvoll, auch abgelehnte Aktionen als Audit-Event zu protokollieren? /
   **EN:** Why is it useful to also log denied actions as an audit event?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wiederholte Ablehnungen können auf einen Missbrauchsversuch hinweisen. Wer nur Erfolge loggt,
   übersieht genau die verdächtigen Muster, die für die Sicherheit am wichtigsten sind.
   **EN:** Repeated denials can indicate an abuse attempt. Logging only successes misses exactly the suspicious
   patterns that matter most for security.

   </details>

6. **DE:** (DPA) Wie setzt du Datenminimierung in Audit-Events um? /
   **EN:** (DPA) How do you apply data minimization in audit events?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur Felder erfassen, die für die Nachvollziehbarkeit nötig sind: Zeit, Rolle, Aktion, Ergebnis.
   Personenbezogene Klartextdaten und ganze Eingaben werden weggelassen oder pseudonymisiert.
   **EN:** Record only fields needed for traceability: time, role, action, result. Personal plain-text data and
   whole inputs are omitted or pseudonymized.

   </details>

7. **DE:** Was ist ein Missbrauchsfall und wozu dient er in dieser Einheit? /
   **EN:** What is an abuse case and what is its purpose in this unit?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Missbrauchsfall beschreibt, wie jemand ein Recht umgehen könnte, z. B. ein Betrachter, der den
   Import-Endpunkt direkt aufruft. Er zeigt Lücken in der Autorisierung, bevor sie ausgenutzt werden.
   **EN:** An abuse case describes how someone could bypass a right, e.g. a viewer calling the import endpoint
   directly. It reveals gaps in authorization before they are exploited.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Rollen und mögliche Aktionen des Dienstes benennen.
- [ ] eine Rechtematrix mit Deny-by-default aufstellen.
- [ ] mindestens zwei Missbrauchsfälle formulieren.
- [ ] eine Audit-Event-Liste mit erlaubten Feldern definieren.
- [ ] verbotene Logfelder (Secrets, Tokens, Klartext-Person) sicher ausschließen.
- [ ] begründen, warum auch abgelehnte Aktionen auditiert werden.

**EN:** I can …

- [ ] name the service's roles and possible actions.
- [ ] build a permission matrix with deny-by-default.
- [ ] state at least two abuse cases.
- [ ] define an audit event list with allowed fields.
- [ ] safely exclude forbidden log fields (secrets, tokens, plain-text person).
- [ ] justify why denied actions are also audited.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_07_Rollen-Autorisierung-und-Audit-Logging.md`. Der Copy-Paste-Prompt
für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_07_Rollen-Autorisierung-und-Audit-Logging.md`. The copy-paste prompt
for a later, manually started Spec Kit run is provided there.
