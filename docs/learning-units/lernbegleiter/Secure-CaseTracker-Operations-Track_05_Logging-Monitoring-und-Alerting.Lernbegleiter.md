# Lernbegleiter: Secure CaseTracker Operations Track 05 – Logging, Monitoring und Alerting / Study Companion

**Stand / Date:** 2026-07-05
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-CaseTracker-Operations-Track_05_Logging-Monitoring-und-Alerting.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein System, das läuft, muss man auch beobachten können. **Logs** sind Protokolle: Sie schreiben auf,
was passiert ist. **Monitoring** sammelt Messwerte (Metriken) über den Zustand des Systems, etwa
Antwortzeiten oder Fehlerzahlen. **Alerting** meldet automatisch, wenn ein Wert eine Grenze überschreitet.
Zusammen sind sie die Augen und Ohren des Betriebs: Ohne sie merkt man einen Ausfall erst, wenn sich jemand
beschwert. Gleichzeitig sind Logs eine Datenschutzfalle – sie dürfen keine unnötigen personenbezogenen Daten
und keine Secrets enthalten.

**EN:** A system that runs must also be observable. **Logs** are records: they write down what happened.
**Monitoring** collects measurements (metrics) about the system's state, such as response times or error
counts. **Alerting** automatically reports when a value crosses a threshold. Together they are the eyes and
ears of operation: without them you notice an outage only when someone complains. At the same time logs are a
privacy trap – they must not contain unnecessary personal data or secrets.

**DE:** In dieser Einheit lernst du, sinnvolle Logs und Metriken zu wählen, Alert-Regeln mit klaren Grenzen
zu definieren, Datenschutzgrenzen im Log einzuhalten und die **Aussagegrenzen** deiner Kennzahlen ehrlich zu
benennen.

**EN:** In this unit you learn to choose meaningful logs and metrics, define alert rules with clear
thresholds, keep privacy boundaries in logs, and honestly name the **limits of meaning** of your metrics.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Log / Log | Protokolleintrag, der ein Ereignis mit Zeit und Kontext festhält. |
| Metrik / Metric | Messwert über den Systemzustand, z. B. Fehlerquote oder Antwortzeit. |
| Alert / Alert | Automatische Meldung, wenn ein Wert eine festgelegte Grenze überschreitet. |
| Schwellenwert / Threshold | Grenze, ab der ein Alert ausgelöst wird. |
| Aussagegrenze / Limit of meaning | Ehrliche Angabe, was eine Kennzahl nicht belegt. |
| Datenminimierung / Data minimization | Nur die wirklich nötigen Daten protokollieren. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Sinnvolle Logs wählen.** Nicht alles muss ins Log. Protokolliere Ereignisse, die für
Betrieb und Sicherheit wichtig sind: Start und Stopp, Fehler, sicherheitsrelevante Aktionen (z. B.
fehlgeschlagene Anmeldung). Jeder Eintrag braucht Zeit und genug Kontext, um verständlich zu sein – aber
nicht mehr.

**EN:** **Step 1 – Choose meaningful logs.** Not everything must be logged. Record events important for
operation and security: start and stop, errors, security-relevant actions (e.g. a failed login). Each entry
needs a timestamp and enough context to be understandable – but no more.

**DE:** **Schritt 2 – Metriken und Alerts definieren.** Wähle wenige, aussagekräftige Metriken (z. B.
Fehlerquote, Antwortzeit, freier Speicher). Lege für jede einen **Schwellenwert** fest, ab dem ein Alert
kommt. Ein guter Alert ist selten und bedeutsam. Zu viele Alerts führen dazu, dass man sie ignoriert
(Alarmmüdigkeit).

**EN:** **Step 2 – Define metrics and alerts.** Choose few, meaningful metrics (e.g. error rate, response
time, free storage). Set a **threshold** for each above which an alert fires. A good alert is rare and
meaningful. Too many alerts lead to people ignoring them (alert fatigue).

**DE:** **Schritt 3 – Datenschutzgrenzen im Log.** Logs dürfen keine Secrets und keine unnötigen
personenbezogenen Daten enthalten. Nutze **Datenminimierung**: Statt eines vollständigen Namens genügt oft
eine technische ID. Sensible Felder werden maskiert. Begründe, was protokolliert wird und warum – und was
bewusst nicht.

**EN:** **Step 3 – Privacy boundaries in logs.** Logs must not contain secrets or unnecessary personal data.
Use **data minimization**: instead of a full name a technical ID is often enough. Sensitive fields are
masked. Justify what is logged and why – and what is deliberately not.

**DE:** **Schritt 4 – Aussagegrenzen benennen.** Eine Metrik zeigt nur, was sie misst. Eine niedrige
Fehlerquote heißt nicht, dass alles sicher ist. Benenne offen, was deine Kennzahlen belegen und was nicht.
Das schützt vor falschen Schlüssen und ist Teil auditfähiger, ehrlicher Dokumentation.

**EN:** **Step 4 – Name the limits of meaning.** A metric shows only what it measures. A low error rate does
not mean everything is secure. State openly what your metrics prove and what they do not. This guards against
wrong conclusions and is part of audit-ready, honest documentation.

**DE:** **Typische Fehler.** Alles auf höchster Stufe loggen (das Wichtige geht unter). Namen, Passwörter
oder Token im Log. Alerts ohne klaren Schwellenwert oder viel zu viele Alerts. Kennzahlen als Beweis
verkaufen, den sie nicht leisten. Log-Injection ignorieren, indem Freitext ungeprüft ins Log geht.

**EN:** **Common mistakes.** Logging everything at the highest level (the important gets lost). Names,
passwords, or tokens in the log. Alerts without a clear threshold or far too many alerts. Selling metrics as
proof they cannot provide. Ignoring log injection by writing unchecked free text into the log.

### Beispiel / Example

```text
Log (gut):        2026-07-05T10:12Z  WARN  login_failed  user_id=U-4711  attempts=3
Log (schlecht):   2026-07-05T10:12Z  INFO  login  user="Anna Muster"  passwort=<KLARTEXT>   (NICHT so!)
Metrik:           Fehlerquote pro 5 Min.;  Schwellenwert Alert bei > 2 %
Datenschutz:      technische ID statt Klarname; Passwort/Token nie im Log
Aussagegrenze:    "Niedrige Fehlerquote belegt Verfügbarkeit, nicht Sicherheit."
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Logging, Monitoring und Alerting sind Kern der Überwachung eines laufenden Systems. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Datenschutzgrenzen im Log setzen den Schutzbedarf personenbezogener Daten um. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Protokollierung, Datenschutz, Bedrohungsbezug und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04`
(Bedrohungsmodellierung), `CL_07` (sichere Konfiguration), `CL_08` (Sicherheits-Review) und `CL_10`
(Logging/Nachweise). Die Sicherheitsentscheidung dieser Einheit lautet: *Logs sind nachvollziehbar, aber
frei von Secrets und unnötigen personenbezogenen Daten.* A11Y-Aspekt: Alerts und Dashboards dürfen einen
Zustand nie nur über Farbe (rot/grün) anzeigen; Text und Werte müssen mit Screenreader und Braille-Zeile
erfassbar sein.

**EN:** Relation to the Secure Development Guideline: secure logging, privacy, threat relation, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_04` (threat modeling),
`CL_07` (secure configuration), `CL_08` (security review), and `CL_10` (logging/evidence). The security
decision of this unit is: *logs are traceable but free of secrets and unnecessary personal data.*
Accessibility aspect: alerts and dashboards must never show a state by color alone (red/green); text and
values must be perceivable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet Logging, Monitoring und Alerting? /
   **EN:** What distinguishes logging, monitoring, and alerting?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Logging schreibt Ereignisse auf. Monitoring sammelt Messwerte über den Zustand. Alerting meldet
   automatisch, wenn ein Wert eine Grenze überschreitet. Zusammen machen sie den Betrieb beobachtbar.
   **EN:** Logging records events. Monitoring collects measurements about the state. Alerting reports
   automatically when a value crosses a threshold. Together they make operation observable.

   </details>

2. **DE:** Warum ist es schlecht, alles auf höchster Log-Stufe zu protokollieren? /
   **EN:** Why is it bad to log everything at the highest level?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Zu viele Einträge machen das Wichtige unsichtbar und kosten Speicher. Man findet Fehler schlechter.
   Sinnvolle Stufen und gezielte Auswahl halten Logs nützlich und übersichtlich.
   **EN:** Too many entries hide the important ones and cost storage. Errors are harder to find. Sensible
   levels and targeted selection keep logs useful and clear.

   </details>

3. **DE:** Welche Daten dürfen nicht in ein Log, und warum? /
   **EN:** Which data must not go into a log, and why?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Secrets (Passwörter, Token) und unnötige personenbezogene Daten. Logs werden gespeichert und
   geteilt; solche Daten wären ein Sicherheits- und Datenschutzrisiko. Datenminimierung: nur das Nötige, z. B.
   eine technische ID.
   **EN:** Secrets (passwords, tokens) and unnecessary personal data. Logs are stored and shared; such data
   would be a security and privacy risk. Data minimization: only what is necessary, e.g. a technical ID.

   </details>

4. **DE:** (SI) Was ist Alarmmüdigkeit, und wie vermeidest du sie? /
   **EN:** (SI) What is alert fatigue, and how do you avoid it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei zu vielen Alerts stumpfen Menschen ab und übersehen wichtige. Man vermeidet das mit wenigen,
   bedeutsamen Alerts und klaren Schwellenwerten, sodass ein Alarm wirklich Handeln bedeutet.
   **EN:** With too many alerts people become numb and miss important ones. You avoid it with few, meaningful
   alerts and clear thresholds, so an alarm really means action.

   </details>

5. **DE:** (SI) Warum benennt man die Aussagegrenze einer Kennzahl? /
   **EN:** (SI) Why do you name the limit of meaning of a metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Kennzahl belegt nur, was sie misst. Ohne Aussagegrenze zieht man falsche Schlüsse (z. B.
   „niedrige Fehlerquote = sicher"). Die ehrliche Grenze gehört zu auditfähiger Dokumentation.
   **EN:** A metric proves only what it measures. Without a limit of meaning you draw wrong conclusions (e.g.
   "low error rate = secure"). The honest limit is part of audit-ready documentation.

   </details>

6. **DE:** (SI) Wie hängt Log-Injection mit Eingabevalidierung zusammen? /
   **EN:** (SI) How is log injection related to input validation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wird Freitext ungeprüft ins Log geschrieben, kann eine manipulierte Eingabe das Protokoll
   verfälschen. Deshalb wird Freitext begrenzt und bereinigt, bevor er ins Log geht – eine Verbindung zur
   Eingabevalidierung.
   **EN:** If free text is written into the log unchecked, a manipulated input can forge the log. Therefore
   free text is limited and sanitized before it enters the log – a link to input validation.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] sinnvolle Log-Ereignisse und wenige aussagekräftige Metriken auswählen.
- [ ] Alert-Regeln mit klaren Schwellenwerten definieren.
- [ ] Datenschutzgrenzen im Log einhalten und Datenminimierung anwenden.
- [ ] die Aussagegrenze einer Kennzahl ehrlich benennen.
- [ ] erklären, wie Freitext Log-Injection verursachen kann und wie man sie verhindert.

**EN:** I can …

- [ ] select meaningful log events and few expressive metrics.
- [ ] define alert rules with clear thresholds.
- [ ] keep privacy boundaries in logs and apply data minimization.
- [ ] honestly name the limit of meaning of a metric.
- [ ] explain how free text can cause log injection and how to prevent it.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-CaseTracker-Operations-Track_05_Logging-Monitoring-und-Alerting.md`. Der Copy-Paste-Prompt
für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-CaseTracker-Operations-Track_05_Logging-Monitoring-und-Alerting.md`. The copy-paste prompt
for a later, manually started Spec Kit run is provided there.
