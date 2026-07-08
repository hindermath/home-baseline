# Lernbegleiter: Secure OrderDesk Operations Track 05 – Observability: Logging, Health und Metriken / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_05_Observability-Logging-Health-und-Metriken.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Bestell-/Handelsplattform mit Datenbank läuft oft still im Betrieb: Nimmt sie Bestellungen an? Ist die Datenbank erreichbar? Wie oft schlägt eine Abfrage fehl? **Observability** (Beobachtbarkeit) macht den Betrieb von außen erkennbar, ohne ihn zu öffnen. Drei Bausteine gehören dazu: **Logging** (was ist passiert?), **Health-Checks** (lebt die Plattform und ist die Datenbank bereit?) und **Metriken** (wie viele Bestellungen, wie oft, wie schnell?). Als Systemintegrator*in verbindest du diese Signale mit den **SLO** aus Einheit 01 – nur so kannst du belegen, ob der Betrieb von Secure OrderDesk seine Ziele erreicht.

**EN:** An ordering/trading platform with a database often runs silently in operation: is it accepting orders? Is the database reachable? How often does a query fail? **Observability** makes operation recognizable from the outside without opening it. Three building blocks belong to it: **logging** (what happened?), **health checks** (is the platform alive and is the database ready?), and **metrics** (how many orders, how often, how fast?). As a system integrator you link these signals with the **SLOs** from unit 01 – only this way can you prove whether Secure OrderDesk operation meets its goals.

**DE:** In dieser Einheit lernst du, strukturiert und ohne Secrets oder Kundendaten zu loggen, sinnvolle Log-Ebenen zu wählen, liveness- und readiness-Health-Checks (inkl. Datenbank-Erreichbarkeit) zu unterscheiden, aussagekräftige Metriken zu bilden und jede Kennzahl an ein SLO zu binden. Dabei achtest du auf den Schutzbedarf der Log- und Kundendaten. Die in v2 gebaute Plattform mit der Northwind-Datenbasis inkl. Kunde `ALFKI` dient als Beispiel für einen zu beobachtenden Datenbank-Betrieb.

**EN:** In this unit you learn to log in a structured way without secrets or customer data, choose meaningful log levels, distinguish liveness and readiness health checks (including database reachability), form meaningful metrics, and bind each metric to an SLO. You watch the protection need of log and customer data. The platform built in v2 with the Northwind data base including customer `ALFKI` serves as an example of a database operation to be observed.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Observability / Observability | Fähigkeit, den inneren Zustand des Betriebs von außen zu erkennen. |
| Strukturiertes Logging / Structured logging | Log-Einträge in einheitlicher, maschinenlesbarer Form (z. B. Schlüssel-Wert). |
| Log-Ebene / Log level | Wichtigkeit eines Eintrags, z. B. debug, info, warning, error. |
| Liveness / Liveness | Health-Check, der zeigt, ob die Plattform überhaupt lebt. |
| Readiness / Readiness | Health-Check, der zeigt, ob die Plattform bereit ist – inkl. Datenbank-Erreichbarkeit. |
| Metrik / Metric | Messbare Kennzahl über den Betrieb, z. B. Bestellungen pro Zeitraum oder Fehlerquote. |
| SLO / SLO | Betriebsziel (Service Level Objective), das eine Metrik belegen oder widerlegen soll. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Strukturiert und ohne Secrets/Kundendaten loggen.** Schreibe Logs in einheitlicher Form mit festen Feldern (Zeit, Ebene, Ereignis, Kontext). Strukturierte Logs lassen sich durchsuchen und auswerten. Wichtig: keine Secrets, Tokens, Verbindungszeichenketten oder Kundendaten – auch nicht `ALFKI`-Klartext – ins Log. Log-Inhalte sind selbst schützenswert.

**EN:** **Step 1 – Log structured and without secrets/customer data.** Write logs in a uniform form with fixed fields (time, level, event, context). Structured logs can be searched and analyzed. Important: no secrets, tokens, connection strings, or customer data – not even `ALFKI` in clear text – in the log. Log contents are themselves worth protecting.

**DE:** **Schritt 2 – Log-Ebenen sinnvoll wählen.** Nutze Ebenen (debug, info, warning, error) bewusst: debug nur bei Bedarf, info für normale Betriebsereignisse (z. B. „Bestellung angelegt"), warning für auffällige, aber tolerierbare Zustände, error für echte Fehler (z. B. Datenbank nicht erreichbar). Falsch gewählte Ebenen erzeugen entweder Rauschen oder blinde Flecken.

**EN:** **Step 2 – Choose log levels sensibly.** Use levels (debug, info, warning, error) deliberately: debug only when needed, info for normal operational events (e.g. "order created"), warning for noticeable but tolerable states, error for real failures (e.g. database unreachable). Wrongly chosen levels create either noise or blind spots.

**DE:** **Schritt 3 – Liveness und Readiness trennen.** Ein **liveness**-Check sagt: „Ich lebe" – sonst wird die Plattform neu gestartet. Ein **readiness**-Check sagt: „Ich bin bereit, Bestellungen anzunehmen" – dazu gehört, dass die Datenbank erreichbar ist. Erst dann darf die Plattform belastet werden. Die Trennung verhindert, dass eine Plattform mit nicht erreichbarer Datenbank fälschlich als gesund gilt oder eine lebende Plattform unnötig neu gestartet wird.

**EN:** **Step 3 – Separate liveness and readiness.** A **liveness** check says "I am alive" – otherwise the platform is restarted. A **readiness** check says "I am ready to take orders" – which includes the database being reachable. Only then may the platform be loaded. The separation prevents a platform with an unreachable database from wrongly counting as healthy or a living platform from being restarted unnecessarily.

**DE:** **Schritt 4 – Metriken an SLO binden.** Bilde Metriken, die eine Betriebsfrage beantworten: Bestellungen pro Zeitraum, Abfrage-Antwortzeit, Fehlerquote, fehlgeschlagene Anmeldungen. Ordne jede Metrik einem SLO aus Einheit 01 zu. Eine Metrik ohne zugehörige Frage ist meist überflüssig; ein SLO ohne Metrik ist nicht prüfbar.

**EN:** **Step 4 – Bind metrics to SLOs.** Form metrics that answer an operational question: orders per period, query response time, error rate, failed logins. Assign each metric to an SLO from unit 01. A metric without a related question is usually superfluous; an SLO without a metric is not verifiable.

**DE:** **Schritt 5 – Schutzbedarf prüfen und nachweisen.** Prüfe Log-Inhalte, Health-Ausgaben, Metrik-Labels und Endpunkte als Vertrauensgrenzen: keine Kundendaten, keine Secrets, keine internen Details. Health- und Metrik-Endpunkte bleiben nur für berechtigte Abfragen erreichbar. Der Nachweis besteht aus einer Log-Ebenen-Tabelle, einer Health-Check-Beschreibung inkl. Datenbank-Readiness, einer Metrik-zu-SLO-Zuordnung und einer Datenschutz-Prüfung der Logs; nicht Anwendbares wird als `N/A` mit Begründung notiert.

**EN:** **Step 5 – Check and evidence the protection need.** Check log contents, health output, metric labels, and endpoints as trust boundaries: no customer data, no secrets, no internal details. Health and metric endpoints stay reachable only for authorized queries. The evidence consists of a log-level table, a health-check description including database readiness, a metric-to-SLO mapping, and a privacy check of the logs; non-applicable items are recorded as `N/A` with a rationale.

**DE:** **Typische Fehler.** Secrets, Verbindungszeichenketten oder Kundendaten (z. B. `ALFKI`-Klartext) ins Log schreiben. Alles auf debug loggen und im Rauschen versinken. Liveness und Readiness verwechseln, sodass eine Plattform ohne Datenbank als bereit gilt. Metriken sammeln, ohne zu wissen, welche Frage sie beantworten. Positive Aussagen („läuft stabil") ohne Metrik als Beleg. Health-Endpunkte öffentlich erreichbar lassen.

**EN:** **Common mistakes.** Writing secrets, connection strings, or customer data (e.g. `ALFKI` in clear text) into the log. Logging everything at debug and drowning in noise. Confusing liveness and readiness, so a platform without a database counts as ready. Collecting metrics without knowing which question they answer. Positive claims ("runs stably") without a metric as evidence. Leaving health endpoints publicly reachable.

### Beispiel / Example

```text
Log (strukturiert):  {"zeit":"...","ebene":"info","ereignis":"bestellung_angelegt","dauer_ms":37}
                     -> kein Secret, keine Verbindungszeichenkette, kein Kundenklartext

Health-Check         | Aussage                             | Reaktion
---------------------|-------------------------------------|-------------------------
liveness             | "Plattform-Prozess lebt"            | bei rot: Neustart
readiness            | "bereit + Datenbank erreichbar"     | bei rot: keine Last

Metrik               | Betriebsfrage                | gebundenes SLO (Einheit 01)
---------------------|------------------------------|----------------------------------
bestellungen/stunde  | Nimmt die Plattform an?      | "Bestellannahme im Zielkorridor"
abfrage_antwortzeit  | Wie schnell antwortet die DB?| "95 % Abfragen < 200 ms"
fehlerquote          | Wie oft schlägt es fehl?     | "< 1 % Fehl-Abfragen/Tag"
fehl_anmeldungen     | Auffällige Anmeldeversuche?  | "Schwelle X pro Zeitraum"
Nachweis:            | Log-Ebenen-Tabelle + Metrik-zu-SLO-Zuordnung; Logs datenschutzgeprüft
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11b Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Logging, Health und Metriken sind die Grundlage, um Betrieb und Sicherheit des Datenbank- und Bestellbetriebs zu überwachen. |
| LF 4 Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen | Berührt / Touched | Log- und Kundendaten sind schützenswert; ihr Schutzbedarf begrenzt, was geloggt werden darf. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Health- und Metrik-Endpunkte werden über Netzgrenzen bereitgestellt und abgefragt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: auditfähiges Logging, Datenschutz, Separation of Concerns und Nachweisführung. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Review), `CL_10` (Logging/Datenschutz) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Es wird strukturiert und ohne Secrets oder Kundendaten geloggt, die Datenbank-Erreichbarkeit ist Teil der Readiness, und jede Kennzahl belegt ein SLO.* A11Y-Aspekt: Log-, Health- und Metrik-Tabellen müssen als klarer Text lesbar sein, nicht nur als farbiges Dashboard, damit sie mit Screenreader und Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: audit-ready logging, privacy, separation of concerns, and evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security review), `CL_10` (logging/privacy), and `CL_12` (documentation/N-A). The security decision of this unit is: *logging is structured and without secrets or customer data, database reachability is part of readiness, and every metric evidences an SLO.* Accessibility aspect: log, health, and metric tables must be readable as clear text, not only as a colored dashboard, so they stay usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum sollte man strukturiert statt in freiem Text loggen? /
   **EN:** Why should you log in a structured way rather than in free text?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Strukturierte Logs haben feste Felder und sind maschinenlesbar. Sie lassen sich zuverlässig durchsuchen, filtern und auswerten. Freitext ist für Menschen lesbar, aber für automatische Analyse und Nachweise schlecht geeignet.
   **EN:** Structured logs have fixed fields and are machine-readable. They can be searched, filtered, and analyzed reliably. Free text is human-readable but poorly suited for automatic analysis and evidence.

   </details>

2. **DE:** (SI) Worin unterscheiden sich liveness- und readiness-Health-Checks, und wo kommt die Datenbank ins Spiel? /
   **EN:** (SI) How do liveness and readiness health checks differ, and where does the database come in?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Liveness sagt, ob der Plattform-Prozess überhaupt lebt – ist er tot, wird er neu gestartet. Readiness sagt, ob die Plattform bereit ist, Bestellungen anzunehmen; dazu muss die Datenbank erreichbar sein. Ist die Datenbank weg, ist die Readiness rot, aber ein Neustart hilft nicht unbedingt.
   **EN:** Liveness says whether the platform process is alive at all – if dead, it is restarted. Readiness says whether the platform is ready to take orders; for this the database must be reachable. If the database is gone, readiness is red, but a restart does not necessarily help.

   </details>

3. **DE:** (SI) Warum bindet man jede Metrik an ein SLO? /
   **EN:** (SI) Why do you bind each metric to an SLO?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Metrik ohne zugehörige Frage ist meist überflüssig, und ein SLO ohne Metrik ist nicht prüfbar. Die Bindung macht den Betrieb auditfähig: Man kann mit Zahlen belegen, ob ein Betriebsziel – etwa eine Antwortzeit-Grenze für Bestellabfragen – erreicht wurde.
   **EN:** A metric without a related question is usually superfluous, and an SLO without a metric is not verifiable. The binding makes operation audit-ready: you can prove with numbers whether an operational goal – e.g. a response-time bound for order queries – was met.

   </details>

4. **DE:** (DPA) Warum sind Log-Inhalte selbst schützenswert, gerade bei Kunden- und Bestelldaten? /
   **EN:** (DPA) Why are log contents themselves worth protecting, especially with customer and order data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Logs können unbeabsichtigt schützenswerte Angaben enthalten (Zugänge, interne Zustände, Kundendaten wie `ALFKI`). Sie werden gespeichert und weitergeleitet, daher gilt: keine Secrets und keine Kundendaten in Klartext ins Log, und der Zugriff wird begrenzt.
   **EN:** Logs can unintentionally contain sensitive data (access data, internal state, customer data such as `ALFKI`). They are stored and forwarded, so: no secrets and no customer data in clear text in the log, and access is limited.

   </details>

5. **DE:** (DV) Worauf achtest du, wenn Health- und Metrik-Endpunkte über das Netz erreichbar sind? /
   **EN:** (DV) What do you watch when health and metric endpoints are reachable over the network?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie sollen nur für berechtigte Abfragen erreichbar sein, nicht öffentlich. Man beschränkt Zugriff (lokal oder authentisiert), gibt keine internen Details preis (kein SQL, keine Verbindungszeichenkette) und dokumentiert, über welche Netzgrenze welcher Endpunkt abgefragt wird.
   **EN:** They should be reachable only for authorized queries, not public. You restrict access (local or authenticated), reveal no internal details (no SQL, no connection string), and document over which network boundary each endpoint is queried.

   </details>

6. **DE:** (AE) Wie sollte die Plattform die Log-Ebenen behandeln? /
   **EN:** (AE) How should the platform handle log levels?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Ebene richtet sich nach der Wichtigkeit: debug nur bei Bedarf, info für normale Ereignisse wie „Bestellung angelegt", warning für auffällige, error für echte Fehler wie „Datenbank nicht erreichbar". Die Ebene sollte konfigurierbar sein, damit man im Betrieb das Rauschen steuern kann, ohne Code zu ändern.
   **EN:** The level follows importance: debug only when needed, info for normal events like "order created", warning for noticeable ones, error for real failures like "database unreachable". The level should be configurable so operation can control noise without changing code.

   </details>

7. **DE:** Welche Aussagegrenze hat eine einzelne Metrik über den Datenbank-Betrieb? /
   **EN:** What is the significance limit of a single metric about the database operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Metrik beantwortet genau eine Frage in einem Zeitraum, nicht die Gesamtlage. „Fehlerquote < 1 %" belegt nicht, dass alles gesund ist – die Datenbank kann trotzdem langsam sein. Erst mehrere Metriken zusammen und ihre SLO-Bindung geben ein belastbares Bild; nicht Anwendbares wird als `N/A` mit Begründung notiert.
   **EN:** A metric answers exactly one question in a period, not the whole picture. "Error rate < 1 %" does not prove everything is healthy – the database can still be slow. Only several metrics together and their SLO binding give a robust picture; non-applicable items are recorded as `N/A` with a rationale.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] strukturiert und ohne Secrets oder Kundendaten loggen.
- [ ] Log-Ebenen bewusst und konfigurierbar wählen.
- [ ] liveness- und readiness-Health-Checks inkl. Datenbank-Erreichbarkeit unterscheiden.
- [ ] aussagekräftige Metriken bilden und je Metrik ein SLO aus Einheit 01 zuordnen.
- [ ] Health- und Metrik-Endpunkte als Vertrauensgrenzen absichern.
- [ ] den Schutzbedarf der Log-Daten prüfen und nicht Anwendbares als `N/A` mit Begründung notieren.

**EN:** I can …

- [ ] log in a structured way and without secrets or customer data.
- [ ] choose log levels deliberately and configurably.
- [ ] distinguish liveness and readiness health checks including database reachability.
- [ ] form meaningful metrics and assign an SLO from unit 01 per metric.
- [ ] secure health and metric endpoints as trust boundaries.
- [ ] check the protection need of log data and record non-applicable items as `N/A` with a rationale.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-Operations-Track_05_Observability-Logging-Health-und-Metriken.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-Operations-Track_05_Observability-Logging-Health-und-Metriken.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
