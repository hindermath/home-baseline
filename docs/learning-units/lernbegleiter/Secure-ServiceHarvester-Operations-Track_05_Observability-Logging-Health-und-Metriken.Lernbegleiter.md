# Lernbegleiter: Secure ServiceHarvester Operations Track 05 – Observability: Logging, Health und Metriken / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_05_Observability-Logging-Health-und-Metriken.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Dienst, der still im Hintergrund läuft, ist eine Blackbox: Läuft er noch? Sammelt er? Wie oft
schlägt etwas fehl? **Observability** (Beobachtbarkeit) macht den Dienst von außen erkennbar, ohne ihn zu
öffnen. Drei Bausteine gehören dazu: **Logging** (was ist passiert?), **Health-Checks** (lebt der Dienst und
ist er bereit?) und **Metriken** (wie viel, wie oft, wie schnell?). Als Systemintegrator*in verbindest du
diese Signale mit den **SLO** aus Einheit 01 – nur so kannst du belegen, ob der Betrieb seine Ziele erreicht.

**EN:** A service running silently in the background is a black box: is it still running? Is it collecting?
How often does something fail? **Observability** makes the service recognizable from the outside without
opening it. Three building blocks belong to it: **logging** (what happened?), **health checks** (is the
service alive and ready?), and **metrics** (how much, how often, how fast?). As a system integrator you link
these signals with the **SLOs** from unit 01 – only this way can you prove whether operation meets its goals.

**DE:** In dieser Einheit lernst du, strukturiert und ohne Secrets zu loggen, sinnvolle Log-Ebenen zu wählen,
liveness- und readiness-Health-Checks zu unterscheiden, aussagekräftige Metriken zu bilden und jede Kennzahl
an ein SLO zu binden. Dabei achtest du auf den Schutzbedarf der Log-Daten. Die C#-Referenz
`InventarWorkerService` dient als Beispiel für einen zu beobachtenden Dienst.

**EN:** In this unit you learn to log in a structured way without secrets, choose meaningful log levels,
distinguish liveness and readiness health checks, form meaningful metrics, and bind each metric to an SLO. You
watch the protection need of log data. The C# reference `InventarWorkerService` serves as an example of a
service to be observed.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Observability / Observability | Fähigkeit, den inneren Zustand eines Dienstes von außen zu erkennen. |
| Strukturiertes Logging / Structured logging | Log-Einträge in einheitlicher, maschinenlesbarer Form (z. B. Schlüssel-Wert). |
| Log-Ebene / Log level | Wichtigkeit eines Eintrags, z. B. debug, info, warning, error. |
| Liveness / Liveness | Health-Check, der zeigt, ob der Dienst überhaupt lebt. |
| Readiness / Readiness | Health-Check, der zeigt, ob der Dienst bereit ist, Arbeit anzunehmen. |
| Metrik / Metric | Messbare Kennzahl über den Betrieb, z. B. Anzahl Sammelläufe oder Fehlerquote. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Strukturiert und ohne Secrets loggen.** Schreibe Logs in einheitlicher Form mit festen
Feldern (Zeit, Ebene, Ereignis, Kontext). Strukturierte Logs lassen sich durchsuchen und auswerten. Wichtig:
Keine Secrets, Tokens oder personenbezogenen Daten ins Log. Log-Inhalte sind selbst schützenswert.

**EN:** **Step 1 – Log structured and without secrets.** Write logs in a uniform form with fixed fields
(time, level, event, context). Structured logs can be searched and analyzed. Important: no secrets, tokens, or
personal data in the log. Log contents are themselves worth protecting.

**DE:** **Schritt 2 – Log-Ebenen sinnvoll wählen.** Nutze Ebenen (debug, info, warning, error) bewusst:
debug nur bei Bedarf, info für normale Betriebsereignisse, warning für auffällige, aber tolerierbare
Zustände, error für echte Fehler. Falsch gewählte Ebenen erzeugen entweder Rauschen oder blinde Flecken.

**EN:** **Step 2 – Choose log levels sensibly.** Use levels (debug, info, warning, error) deliberately: debug
only when needed, info for normal operational events, warning for noticeable but tolerable states, error for
real failures. Wrongly chosen levels create either noise or blind spots.

**DE:** **Schritt 3 – Liveness und Readiness trennen.** Ein **liveness**-Check sagt: „Ich lebe" – sonst wird
der Dienst neu gestartet. Ein **readiness**-Check sagt: „Ich bin bereit, Arbeit anzunehmen" – erst dann darf
er belastet werden. Die Trennung verhindert, dass ein noch nicht startbereiter Dienst fälschlich als gesund
gilt oder ein lebender Dienst unnötig neu gestartet wird.

**EN:** **Step 3 – Separate liveness and readiness.** A **liveness** check says "I am alive" – otherwise the
service is restarted. A **readiness** check says "I am ready to take work" – only then may it be loaded. The
separation prevents a not-yet-ready service from wrongly counting as healthy or a living service from being
restarted unnecessarily.

**DE:** **Schritt 4 – Metriken an SLO binden.** Bilde Metriken, die eine Betriebsfrage beantworten: Anzahl
erfolgreicher/fehlgeschlagener Sammelläufe, Fehlerquote, Laufzeit je Lauf, Zeit bis Neustart. Ordne jede
Metrik einem SLO aus Einheit 01 zu. Eine Metrik ohne zugehörige Frage ist meist überflüssig; ein SLO ohne
Metrik ist nicht prüfbar.

**EN:** **Step 4 – Bind metrics to SLOs.** Form metrics that answer an operational question: number of
successful/failed collection runs, error rate, runtime per run, time to restart. Assign each metric to an SLO
from unit 01. A metric without a related question is usually superfluous; an SLO without a metric is not
verifiable.

**DE:** **Typische Fehler.** Secrets oder personenbezogene Daten ins Log schreiben. Alles auf debug loggen und
im Rauschen versinken. Liveness und Readiness verwechseln. Metriken sammeln, ohne zu wissen, welche Frage sie
beantworten. Positive Aussagen („läuft stabil") ohne Metrik als Beleg.

**EN:** **Common mistakes.** Writing secrets or personal data into the log. Logging everything at debug and
drowning in noise. Confusing liveness and readiness. Collecting metrics without knowing which question they
answer. Positive claims ("runs stably") without a metric as evidence.

### Beispiel / Example

```text
Log (strukturiert):  {"zeit":"...","ebene":"info","ereignis":"sammellauf_ok","dauer_ms":842}
                     -> kein Secret, kein personenbezogenes Datum

Health-Check         | Aussage                          | Reaktion
---------------------|----------------------------------|-------------------------
liveness             | "Prozess lebt"                   | bei rot: Neustart
readiness            | "bereit, Sammellauf zu starten"  | bei rot: keine Last

Metrik               | Betriebsfrage             | gebundenes SLO (Einheit 01)
---------------------|---------------------------|----------------------------------
sammellaeufe_ok/tag  | Sammeln zuverlässig?      | "95 % geplante Läufe/Tag erfolgreich"
fehlerquote          | Wie oft schlägt es fehl?  | "< 5 % Fehlläufe/Tag"
neustartzeit_s       | Erholt sich der Dienst?   | "Neustart nach Absturz < 60 s"
Nachweis:            | Log-Ebenen-Tabelle + Metrik-zu-SLO-Zuordnung; Logs datenschutzgeprüft
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Logging, Health und Metriken sind die Grundlage, um Betrieb und Sicherheit zu überwachen. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Log-Inhalte sind schützenswert; ihr Schutzbedarf begrenzt, was geloggt werden darf. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Health- und Metrik-Endpunkte werden über Netzgrenzen bereitgestellt und abgefragt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: auditfähiges Logging, Datenschutz, Separation of Concerns
und Nachweisführung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Review),
`CL_10` (Logging/Datenschutz) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit
lautet: *Es wird strukturiert und ohne Secrets geloggt, und jede Kennzahl belegt ein SLO.* A11Y-Aspekt: Log-,
Health- und Metrik-Tabellen müssen als klarer Text lesbar sein, nicht nur als farbiges Dashboard, damit sie
mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: audit-ready logging, privacy, separation of concerns,
and evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security review), `CL_10`
(logging/privacy), and `CL_12` (documentation/N-A). The security decision of this unit is: *logging is
structured and without secrets, and every metric evidences an SLO.* Accessibility aspect: log, health, and
metric tables must be readable as clear text, not only as a colored dashboard, so they stay usable with a
screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum sollte man strukturiert statt in freiem Text loggen? /
   **EN:** Why should you log in a structured way rather than in free text?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Strukturierte Logs haben feste Felder und sind maschinenlesbar. Sie lassen sich zuverlässig
   durchsuchen, filtern und auswerten. Freitext ist für Menschen lesbar, aber für automatische Analyse und
   Nachweise schlecht geeignet.
   **EN:** Structured logs have fixed fields and are machine-readable. They can be searched, filtered, and
   analyzed reliably. Free text is human-readable but poorly suited for automatic analysis and evidence.

   </details>

2. **DE:** (SI) Worin unterscheiden sich liveness- und readiness-Health-Checks? /
   **EN:** (SI) How do liveness and readiness health checks differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Liveness sagt, ob der Prozess überhaupt lebt – ist er tot, wird er neu gestartet. Readiness sagt,
   ob er bereit ist, Arbeit anzunehmen – ist er es nicht, bekommt er keine Last, wird aber nicht neu
   gestartet. Die Trennung verhindert falsche Reaktionen.
   **EN:** Liveness says whether the process is alive at all – if dead, it is restarted. Readiness says whether
   it is ready to take work – if not, it gets no load but is not restarted. The separation prevents wrong
   reactions.

   </details>

3. **DE:** (SI) Warum bindet man jede Metrik an ein SLO? /
   **EN:** (SI) Why do you bind each metric to an SLO?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Metrik ohne zugehörige Frage ist meist überflüssig, und ein SLO ohne Metrik ist nicht prüfbar.
   Die Bindung macht den Betrieb auditfähig: Man kann mit Zahlen belegen, ob ein Betriebsziel erreicht wurde.
   **EN:** A metric without a related question is usually superfluous, and an SLO without a metric is not
   verifiable. The binding makes operation audit-ready: you can prove with numbers whether an operational goal
   was met.

   </details>

4. **DE:** (DPA) Warum sind Log-Inhalte selbst schützenswert? /
   **EN:** (DPA) Why are log contents themselves worth protecting?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Logs können unbeabsichtigt schützenswerte Angaben enthalten (Zugänge, personenbezogene Daten,
   interne Zustände). Sie werden gespeichert und weitergeleitet, daher gilt: keine Secrets und keine
   personenbezogenen Daten ins Log, und der Zugriff wird begrenzt.
   **EN:** Logs can unintentionally contain sensitive data (access data, personal data, internal state). They
   are stored and forwarded, so: no secrets and no personal data in the log, and access is limited.

   </details>

5. **DE:** (DV) Worauf achtest du, wenn Health- und Metrik-Endpunkte über das Netz erreichbar sind? /
   **EN:** (DV) What do you watch when health and metric endpoints are reachable over the network?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie sollen nur für berechtigte Abfragen erreichbar sein, nicht öffentlich. Man beschränkt Zugriff
   (lokal oder authentisiert), gibt keine internen Details preis und dokumentiert, über welche Netzgrenze
   welcher Endpunkt abgefragt wird.
   **EN:** They should be reachable only for authorized queries, not public. You restrict access (local or
   authenticated), reveal no internal details, and document over which network boundary each endpoint is
   queried.

   </details>

6. **DE:** (AE) Wie sollte der Code die Log-Ebenen behandeln? /
   **EN:** (AE) How should the code handle log levels?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Ebene richtet sich nach der Wichtigkeit: debug nur bei Bedarf, info für normale Ereignisse,
   warning für auffällige, error für echte Fehler. Die Ebene sollte konfigurierbar sein, damit man im Betrieb
   das Rauschen steuern kann, ohne Code zu ändern.
   **EN:** The level follows importance: debug only when needed, info for normal events, warning for
   noticeable ones, error for real failures. The level should be configurable so operation can control noise
   without changing code.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] strukturiert und ohne Secrets loggen.
- [ ] Log-Ebenen bewusst und konfigurierbar wählen.
- [ ] liveness- und readiness-Health-Checks unterscheiden.
- [ ] aussagekräftige Metriken bilden und je Metrik ein SLO zuordnen.
- [ ] den Schutzbedarf der Log-Daten prüfen und nicht Anwendbares als `N/A` mit Begründung notieren.

**EN:** I can …

- [ ] log in a structured way and without secrets.
- [ ] choose log levels deliberately and configurably.
- [ ] distinguish liveness and readiness health checks.
- [ ] form meaningful metrics and assign an SLO per metric.
- [ ] check the protection need of log data and record non-applicable items as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_05_Observability-Logging-Health-und-Metriken.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_05_Observability-Logging-Health-und-Metriken.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
