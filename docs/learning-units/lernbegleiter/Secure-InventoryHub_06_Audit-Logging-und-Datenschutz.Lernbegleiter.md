# Lernbegleiter: Secure InventoryHub 06 – Audit-Logging und Datenschutz / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-InventoryHub_06_Audit-Logging-und-Datenschutz.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Wenn sich Inventardaten ändern – ein Asset wird ausgemustert, eine Software aktualisiert, ein
Verantwortlicher gewechselt – muss nachvollziehbar sein, **wer wann was** getan hat. Genau das leistet das
**Audit-Logging**. Es macht Änderungen prüfbar und schützt vor unbemerkter Manipulation. Gleichzeitig ist ein
Log ein Datenschutz-Risiko: Wer zu viel protokolliert, sammelt personenbezogene oder sensible Daten, die dort
nicht hingehören. Die Kunst ist, **genug** zu protokollieren, um Ereignisse zu belegen, aber **nicht mehr** als
nötig.

**EN:** When inventory data changes – an asset is retired, a software updated, an owner changed – it must be
traceable **who did what when**. This is exactly what **audit logging** provides. It makes changes verifiable
and protects against unnoticed manipulation. At the same time a log is a privacy risk: whoever logs too much
collects personal or sensitive data that does not belong there. The art is to log **enough** to prove events
but **not more** than necessary.

**DE:** In dieser Einheit lernst du, welche Inventaränderungen als Audit-Events zählen, welche Felder ein Log
enthalten darf und welche verboten sind, wie lange Logs aufbewahrt werden und wie du dabei Datenschutz wahrst.

**EN:** In this unit you learn which inventory changes count as audit events, which fields a log may contain
and which are forbidden, how long logs are retained, and how you preserve privacy in the process.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Audit-Event / Audit event | Protokollierte, sicherheitsrelevante Aktion, z. B. Ausmusterung eines Assets. |
| Audit-Log / Audit log | Nachvollziehbare, geschützte Aufzeichnung von Audit-Events. |
| Verbotenes Logfeld / Forbidden log field | Feld, das nicht ins Log darf, z. B. Passwort oder unnötige personenbezogene Daten. |
| Aufbewahrungsfrist / Retention period | Zeitraum, für den Logs gespeichert und danach gelöscht werden. |
| Log-Injection / Log injection | Angriff, der über Eingaben das Protokoll verfälscht. |
| Datenschutz / Privacy | Schutz personenbezogener Daten vor unnötiger Verarbeitung. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Audit-Events bestimmen.** Lege fest, welche Aktionen protokolliert werden müssen:
Anlegen, Ändern, Ausmustern eines Assets, Statuswechsel, Rollen- oder Rechteänderung, Import und Export. Nicht
jede Leseaktion muss ins Audit-Log; wähle die sicherheitsrelevanten Ereignisse bewusst aus.

**EN:** **Step 1 – Determine audit events.** Define which actions must be logged: creating, changing, retiring
an asset, status change, role or permission change, import and export. Not every read action needs to go into
the audit log; deliberately choose the security-relevant events.

**DE:** **Schritt 2 – Erlaubte und verbotene Felder trennen.** Ein gutes Audit-Event enthält: Zeitstempel,
handelnde Rolle (nicht unbedingt Klarname), betroffenes Objekt, Aktion, Vorher-/Nachher-Bezug. Verboten sind
Passwörter, Geheimnisse, vollständige personenbezogene Datensätze und alles, was für den Nachweis nicht
gebraucht wird. Warum? Ein Log wird oft breit gelesen und lange aufbewahrt – sensible Daten darin sind ein
dauerhaftes Risiko.

**EN:** **Step 2 – Separate allowed and forbidden fields.** A good audit event contains: timestamp, acting
role (not necessarily a real name), affected object, action, before/after reference. Forbidden are passwords,
secrets, full personal records, and anything not needed for the proof. Why? A log is often read widely and
retained long – sensitive data in it is a lasting risk.

**DE:** **Schritt 3 – Log-Injection verhindern.** Werte aus Nutzereingaben können das Log fälschen, etwa durch
eingefügte Zeilenumbrüche oder Steuerzeichen. Begrenze und bereinige solche Werte, bevor sie ins Log gehen. So
bleibt das Protokoll echt und beweiskräftig.

**EN:** **Step 3 – Prevent log injection.** Values from user input can forge the log, e.g. via inserted line
breaks or control characters. Limit and sanitize such values before they enter the log. This keeps the log
authentic and evidential.

**DE:** **Schritt 4 – Aufbewahrung und Löschung festlegen.** Definiere, wie lange Logs gespeichert werden und
wann sie gelöscht werden. Datenschutz verlangt, personenbezogene Daten nicht unbegrenzt zu halten. Eine klare
Aufbewahrungsfrist ist zugleich Sicherheits- und Datenschutzmaßnahme. Schütze das Log außerdem gegen
nachträgliches Ändern (Integrität).

**EN:** **Step 4 – Define retention and deletion.** Define how long logs are stored and when they are deleted.
Privacy requires not keeping personal data indefinitely. A clear retention period is both a security and a
privacy measure. Also protect the log against later modification (integrity).

**DE:** **Typische Fehler.** Alles protokollieren, auch Geheimnisse. Klarnamen statt Rollen loggen. Keine
Aufbewahrungsfrist. Log-Injection ignorieren. Logs für jeden lesbar machen. Änderungen am Log zulassen, sodass
es nicht mehr beweiskräftig ist.

**EN:** **Common mistakes.** Logging everything, including secrets. Logging real names instead of roles. No
retention period. Ignoring log injection. Making logs readable for everyone. Allowing changes to the log so it
is no longer evidential.

### Beispiel / Example

```text
Audit-Event (gut):
  { ts: "2026-07-05T09:12Z", rolle: "asset-owner", aktion: "ausmustern",
    objekt: "AST-001", vorher: "aktiv", nachher: "ausgemustert" }

Verbotene Felder:   passwort, token, vollständiger Klarname, Standort-Historie ohne Zweck
Log-Injection:      kommentar "ok\n2026-... FAKE gelöscht" -> Zeilenumbruch entfernen/maskieren
Aufbewahrung:       Audit-Logs 365 Tage, danach automatische Löschung
Zugriff:            nur Rolle auditor darf lesen; niemand darf über die Standardrolle löschen
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Primär / Primary | Nachvollziehbarkeit und Datenschutz sind zentrale Schutzmaßnahmen. |
| LF 5 Software zur Verwaltung von Daten anpassen | Berührt / Touched | Audit-Logging ist Teil der sicheren Datenverwaltung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sicheres Logging, Datenschutz und sichere Fehlerbehandlung.
Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Bedrohungsmodellierung), `CL_08`
(Sicherheits-Code-Review), `CL_10` (Datenschutz) und `CL_12` (Nachweise). Die Sicherheitsentscheidung dieser
Einheit lautet: *Es wird genug protokolliert, um Ereignisse zu belegen, aber nicht mehr als nötig, und Logs
bleiben unveränderbar.* A11Y-Aspekt: Log-Einträge und Berichte müssen als klarer, strukturierter Text lesbar
sein, ohne reine Farbsignale, damit sie mit Screenreader oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: safe logging, privacy, and safe error handling. Matching
checklists: `CL_01` (standards applicability), `CL_04` (threat modeling), `CL_08` (security code review),
`CL_10` (privacy), and `CL_12` (evidence). The security decision of this unit is: *log enough to prove events
but no more than necessary, and keep logs tamper-evident.* Accessibility aspect: log entries and reports must
be readable as clear, structured text, without color-only signals, so they stay usable with a screen reader or
Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Wozu dient ein Audit-Log in einem Inventarsystem? /
   **EN:** What is an audit log for in an inventory system?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es macht nachvollziehbar, wer wann welche Änderung vorgenommen hat. So werden Aktionen prüfbar und
   unbemerkte Manipulation wird erschwert.
   **EN:** It makes traceable who made which change and when. This makes actions verifiable and hinders
   unnoticed manipulation.

   </details>

2. **DE:** Welche Felder dürfen nicht in ein Audit-Log, und warum? /
   **EN:** Which fields must not go into an audit log, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Passwörter, Geheimnisse und unnötige personenbezogene Daten. Logs werden oft breit gelesen und lange
   aufbewahrt; sensible Daten darin sind ein dauerhaftes Sicherheits- und Datenschutzrisiko.
   **EN:** Passwords, secrets, and unnecessary personal data. Logs are often read widely and retained long;
   sensitive data in them is a lasting security and privacy risk.

   </details>

3. **DE:** Warum ist es sinnvoll, die handelnde Rolle statt eines Klarnamens zu loggen? /
   **EN:** Why is it sensible to log the acting role instead of a real name?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Rolle reicht meist für den Nachweis und reduziert personenbezogene Daten. Das folgt der
   Datenminimierung und schützt die Privatsphäre, ohne die Nachvollziehbarkeit zu verlieren.
   **EN:** The role is usually enough for the proof and reduces personal data. This follows data minimization
   and protects privacy without losing traceability.

   </details>

4. **DE:** Was ist Log-Injection, und wie verhindert man sie? /
   **EN:** What is log injection, and how do you prevent it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Über manipulierte Eingaben, z. B. eingefügte Zeilenumbrüche, wird das Log gefälscht. Schutz: Werte
   vor dem Loggen begrenzen und bereinigen (Steuerzeichen entfernen oder maskieren).
   **EN:** Through manipulated inputs, e.g. inserted line breaks, the log is forged. Protection: limit and
   sanitize values before logging (remove or escape control characters).

   </details>

5. **DE:** (SI) Warum braucht ein Audit-Log eine Aufbewahrungsfrist? /
   **EN:** (SI) Why does an audit log need a retention period?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Personenbezogene Daten dürfen nicht unbegrenzt gehalten werden. Eine klare Frist begrenzt das Risiko
   und erfüllt Datenschutzanforderungen, während Ereignisse trotzdem für einen sinnvollen Zeitraum belegbar
   bleiben.
   **EN:** Personal data must not be kept indefinitely. A clear period limits the risk and meets privacy
   requirements while events remain provable for a reasonable time.

   </details>

6. **DE:** Warum muss ein Audit-Log gegen nachträgliches Ändern geschützt sein? /
   **EN:** Why must an audit log be protected against later modification?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nur ein unveränderbares Log ist beweiskräftig. Könnte man Einträge ändern oder löschen, ließe sich
   Manipulation verdecken, und das Log verlöre seinen Zweck.
   **EN:** Only a tamper-evident log is evidential. If entries could be changed or deleted, manipulation could
   be hidden, and the log would lose its purpose.

   </details>

7. **DE:** Warum wird nicht jede Leseaktion ins Audit-Log geschrieben? /
   **EN:** Why is not every read action written to the audit log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zu viele unwichtige Einträge machen das Log unübersichtlich und erhöhen das Datenvolumen und Risiko.
   Man protokolliert bewusst die sicherheitsrelevanten Ereignisse, nicht alles.
   **EN:** Too many unimportant entries make the log unclear and increase data volume and risk. One
   deliberately logs the security-relevant events, not everything.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] sicherheitsrelevante Audit-Events benennen.
- [ ] erlaubte von verbotenen Logfeldern unterscheiden.
- [ ] Log-Injection erklären und verhindern.
- [ ] eine Aufbewahrungsfrist begründen.
- [ ] erklären, warum Logs unveränderbar sein müssen.

**EN:** I can …

- [ ] name security-relevant audit events.
- [ ] tell allowed log fields from forbidden ones.
- [ ] explain and prevent log injection.
- [ ] justify a retention period.
- [ ] explain why logs must be tamper-evident.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-InventoryHub_06_Audit-Logging-und-Datenschutz.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-InventoryHub_06_Audit-Logging-und-Datenschutz.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
