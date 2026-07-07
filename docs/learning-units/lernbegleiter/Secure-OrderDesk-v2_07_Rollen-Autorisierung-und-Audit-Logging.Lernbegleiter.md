# Lernbegleiter: Secure OrderDesk v2 07 – Rollen-, Autorisierung und Audit-Logging / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_07_Rollen-Autorisierung-und-Audit-Logging.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Im Secure OrderDesk arbeiten verschiedene Rollen: jemand erfasst Bestellungen, jemand pflegt den
Produktkatalog, jemand wertet Umsätze aus. Nicht jede Rolle darf alles. In dieser Einheit modellierst du
**Rollen**, eine **Rechtematrix** mit **sicheren Defaults** (Deny-by-default: was nicht ausdrücklich erlaubt
ist, ist verboten), **Missbrauchsfälle** (z. B. „darf die Katalogpflege fremde Kundenbestellungen einsehen?")
und ein **Audit-Logging**, das jede sicherheitsrelevante Aktion nachvollziehbar macht.

**EN:** In the Secure OrderDesk several roles work together: someone records orders, someone maintains the
product catalog, someone reports revenue. Not every role may do everything. In this unit you model **roles**, a
**permission matrix** with **secure defaults** (deny-by-default: whatever is not explicitly allowed is
forbidden), **abuse cases** (e.g. "may catalog maintenance view another customer's orders?"), and an **audit
log** that makes every security-relevant action traceable.

**DE:** Ein Audit-Log ist kein Ort für Geheimnisse. Es darf **keine Secrets** (Passwörter, Tokens,
Verbindungszeichenketten) und **keine personenbezogenen Kundendaten im Klartext** enthalten. Du legst deshalb
eine **Audit-Event-Liste** mit erlaubten und verbotenen Feldern an. `ALFKI` dient als fiktives Beispiel: Der
Zugriff auf Bestellungen von `ALFKI` wird protokolliert, aber ohne die volle Adresse.

**EN:** An audit log is not a place for secrets. It must contain **no secrets** (passwords, tokens, connection
strings) and **no personal customer data in clear text**. You therefore create an **audit event list** with
allowed and forbidden fields. `ALFKI` serves as a fictional example: access to `ALFKI`'s orders is logged, but
without the full address.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Rolle / Role | Bündel erlaubter Aktionen für eine Aufgabe (z. B. Bestellerfassung). |
| Rechtematrix / Permission matrix | Tabelle: welche Rolle darf welche Aktion (erlauben/verbieten). |
| Deny-by-default / Deny-by-default | Sicherer Grundzustand: alles verboten, außer ausdrücklich erlaubt. |
| Missbrauchsfall / Abuse case | Szenario, in dem jemand Rechte umgehen oder überschreiten will. |
| Audit-Event / Audit event | Protokollierte sicherheitsrelevante Aktion mit erlaubten Feldern. |
| Least Privilege / Least privilege | Jede Rolle hat nur die minimal nötigen Rechte. |
| Datenminimierung / Data minimization | Nur die wirklich nötigen (Kunden-)Daten werden verarbeitet oder protokolliert. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Rollen und Aktionen benennen.** Liste die fachlichen Aktionen (Bestellung anlegen,
Katalog ändern, Umsatz auswerten) und ordne sie Rollen zu. **Warum wichtig:** Ohne klare Aktionsliste bleibt
unklar, was überhaupt geschützt werden muss.

**EN:** **Step 1 – Name roles and actions.** List the business actions (create order, change catalog, report
revenue) and assign them to roles. **Why it matters:** without a clear action list it stays unclear what needs
protection at all.

**DE:** **Schritt 2 – Rechtematrix mit Deny-by-default.** Trage in eine Tabelle ein, welche Rolle welche
Aktion darf. Alles Nicht-Eingetragene ist verboten. **Warum wichtig:** Ein sicherer Grundzustand verhindert,
dass vergessene Fälle versehentlich erlaubt sind.

**EN:** **Step 2 – Permission matrix with deny-by-default.** Record in a table which role may perform which
action. Everything not recorded is forbidden. **Why it matters:** a secure default state prevents forgotten
cases from being accidentally allowed.

**DE:** **Schritt 3 – Missbrauchsfälle durchdenken.** Frage bei jeder Aktion: Wer könnte sie missbrauchen? Was
passiert, wenn die Bestellerfassung Umsatzberichte oder fremde Kundenbestellungen abrufen will? **Warum
wichtig:** Missbrauchsfälle decken Lücken auf, die die reine Erlaubnis-Liste nicht zeigt.

**EN:** **Step 3 – Think through abuse cases.** Ask for each action: who could abuse it? What happens if order
entry tries to fetch revenue reports or another customer's orders? **Why it matters:** abuse cases reveal gaps
that the plain permission list does not show.

**DE:** **Schritt 4 – Audit-Event-Liste festlegen.** Bestimme, welche Aktionen protokolliert werden (Login,
Bestellung angelegt, Katalog geändert, Zugriff verweigert) und welche Felder erlaubt sind (Zeit, Rolle,
Aktion, Ergebnis, Objekt-ID/-Hash) und welche verboten (Passwörter, Tokens, Klartext-Kundendaten). **Warum
wichtig:** Nur eine feste Liste hält das Log vollständig und datenschutzkonform.

**EN:** **Step 4 – Define the audit event list.** Decide which actions are logged (login, order created,
catalog changed, access denied) and which fields are allowed (time, role, action, result, object ID/hash) and
which are forbidden (passwords, tokens, clear-text customer data). **Why it matters:** only a fixed list keeps
the log complete and privacy-compliant.

**DE:** **Schritt 5 – Prüfpfade planen.** Zu jeder wichtigen Regel gehört ein Test: Ein erlaubter Zugriff
gelingt, ein verbotener wird abgelehnt **und** als Audit-Event „Zugriff verweigert" protokolliert. **Warum
wichtig:** Autorisierung, die man nicht prüft, kann still versagen.

**EN:** **Step 5 – Plan verification paths.** Every important rule needs a test: an allowed access succeeds, a
forbidden one is denied **and** logged as an audit event "access denied". **Why it matters:** authorization you
do not test can silently fail.

**DE:** **Typische Fehler.** Alles erlauben und nur Einzelfälle verbieten (statt Deny-by-default). Rechte im
Code verstreuen statt in einer Matrix bündeln. Kundendaten oder Secrets ins Audit-Log schreiben. Nur erlaubte
Zugriffe testen, verbotene nicht. Verweigerte Zugriffe gar nicht protokollieren.

**EN:** **Common mistakes.** Allowing everything and forbidding only single cases (instead of deny-by-default).
Scattering rights in code instead of bundling them in a matrix. Logging customer data or secrets into the audit
log. Testing only allowed accesses, not forbidden ones. Not logging denied accesses at all.

### Beispiel / Example

```text
Rechtematrix (Deny-by-default, Auszug):

  Aktion                          Bestellerfassung  Katalogpflege  Auswertung
  Bestellung anlegen              erlaubt           verboten       verboten
  Produkt aendern                 verboten          erlaubt        verboten
  Umsatz je Zeitraum lesen        verboten          verboten       erlaubt
  Fremde Kundenbestellung sehen   verboten          verboten       verboten

Audit-Event (erlaubte Felder):
  zeit=2026-06-15T10:12Z  rolle=Bestellerfassung  aktion=OrderCreated  ergebnis=ok  objekt=Order#50218  kunde=hash(ALFKI)

NICHT so (verbotene Felder):
  passwort=***  token=***  kundenadresse="Maria Anders, Berlin"  -> Secret + Klartext-Kundendaten
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Rollen, Rechtematrix und Audit-Logging setzen die Schutzbedarfsanalyse für Zugriffe auf Bestell- und Kundendaten praktisch um. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Die Autorisierung ist Teil der datenverwaltenden Bestell-Software und beeinflusst ihr Verhalten. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Least Privilege, Deny-by-default, Datenschutz und
Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Datenschutz/Logging), `CL_05`
(Zugangssteuerung/Autorisierung), `CL_08` (Sicherheits-Code-Review), `CL_10` und `CL_12` (Betriebs- und
Nachweisbezug). Die Sicherheitsentscheidung dieser Einheit lautet: *Rechte werden zentral in einer Matrix mit
Deny-by-default gebündelt, und jede sicherheitsrelevante Aktion wird ohne Secrets und ohne Klartext-Kundendaten
protokolliert.* A11Y-Aspekt: „Zugriff verweigert" muss als klarer Text erscheinen, nicht nur als rotes Symbol,
damit Screenreader und Braille-Zeile die Meldung wiedergeben.

**EN:** Relation to the Secure Development Guideline: least privilege, deny-by-default, privacy, and
testability. Matching checklists: `CL_01` (standards applicability), `CL_04` (privacy/logging), `CL_05` (access
control / authorization), `CL_08` (security code review), `CL_10` and `CL_12` (operational and evidence
relation). The security decision of this unit is: *rights are bundled centrally in a matrix with deny-by-default,
and every security-relevant action is logged without secrets and without clear-text customer data.*
Accessibility aspect: "access denied" must appear as clear text, not only as a red symbol, so a screen reader
and Braille display can convey the message.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Deny-by-default und warum ist es sicherer? /
   **EN:** What does deny-by-default mean and why is it safer?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Alles ist verboten, außer es ist ausdrücklich erlaubt. So sind vergessene oder neue Fälle
   automatisch gesperrt, statt versehentlich offen zu stehen.
   **EN:** Everything is forbidden unless it is explicitly allowed. This way forgotten or new cases are
   automatically blocked instead of being accidentally open.

   </details>

2. **DE:** Warum bündelt man Rechte in einer Matrix statt sie im Code zu verstreuen? /
   **EN:** Why bundle rights in a matrix instead of scattering them in code?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine zentrale Matrix ist vollständig prüfbar und leichter zu warten. Verstreute Prüfungen führen zu
   Lücken und Widersprüchen.
   **EN:** A central matrix is fully reviewable and easier to maintain. Scattered checks lead to gaps and
   contradictions.

   </details>

3. **DE:** (SI) Welche Felder dürfen nicht ins Audit-Log, und warum? /
   **EN:** (SI) Which fields must not go into the audit log, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine Secrets (Passwörter, Tokens, Verbindungszeichenketten) und keine personenbezogenen
   Klartext-Kundendaten. Secrets im Log sind ein Leck; Klartext-Kundendaten verletzen den Datenschutz.
   **EN:** No secrets (passwords, tokens, connection strings) and no personal clear-text customer data. Secrets
   in the log are a leak; clear-text customer data violate privacy.

   </details>

4. **DE:** Warum ist ein Missbrauchsfall nützlicher als nur eine Erlaubnis-Liste? /
   **EN:** Why is an abuse case more useful than just a permission list?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Missbrauchsfall zeigt, wie jemand Rechte umgehen oder überschreiten könnte, und deckt so Lücken
   auf, die die reine Erlaubnis-Liste nicht sichtbar macht.
   **EN:** An abuse case shows how someone could bypass or exceed rights and thus reveals gaps that the plain
   permission list does not make visible.

   </details>

5. **DE:** (AE) Wie testest du, dass ein verbotener Zugriff wirklich abgelehnt wird? /
   **EN:** (AE) How do you test that a forbidden access is really denied?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einem Negativtest: Eine Rolle ohne Recht versucht die Aktion, das System lehnt ab und
   protokolliert „Zugriff verweigert". Nur erlaubte Zugriffe zu testen reicht nicht.
   **EN:** With a negative test: a role without the right tries the action, the system denies it and logs
   "access denied". Testing only allowed accesses is not enough.

   </details>

6. **DE:** (DPA) Wie hilft Datenminimierung im Audit-Log dem Datenschutz? /
   **EN:** (DPA) How does data minimization in the audit log help privacy?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es werden nur die wirklich nötigen Felder protokolliert, z. B. eine ID oder ein Hash statt Name und
   Adresse. So bleibt die Nachvollziehbarkeit erhalten, ohne mehr Kundendaten als nötig zu speichern.
   **EN:** Only the truly necessary fields are logged, e.g. an ID or hash instead of name and address. This
   keeps traceability while storing no more customer data than needed.

   </details>

7. **DE:** Warum sollte auch ein verweigerter Zugriff protokolliert werden? /
   **EN:** Why should a denied access also be logged?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Verweigerte Zugriffe zeigen mögliche Missbrauchsversuche. Ohne dieses Ereignis bliebe ein Angriff
   auf die Autorisierung unsichtbar.
   **EN:** Denied accesses show possible abuse attempts. Without this event an attack on authorization would
   stay invisible.

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

- [ ] Rollen und Aktionen für den Secure OrderDesk benennen.
- [ ] eine Rechtematrix mit Deny-by-default aufstellen und begründen.
- [ ] Missbrauchsfälle beschreiben und daraus Regeln ableiten.
- [ ] eine Audit-Event-Liste mit erlaubten und verbotenen Feldern definieren.
- [ ] einen Negativtest für einen verbotenen Zugriff angeben.
- [ ] begründen, warum keine Secrets und keine Klartext-Kundendaten ins Audit-Log gehören.

**EN:** I can …

- [ ] name roles and actions for the Secure OrderDesk.
- [ ] build and justify a permission matrix with deny-by-default.
- [ ] describe abuse cases and derive rules from them.
- [ ] define an audit event list with allowed and forbidden fields.
- [ ] give a negative test for a forbidden access.
- [ ] justify why no secrets and no clear-text customer data belong in the audit log.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-v2_07_Rollen-Autorisierung-und-Audit-Logging.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-v2_07_Rollen-Autorisierung-und-Audit-Logging.md`. The copy-paste prompt for a
later, manually started Spec Kit run is provided there.
