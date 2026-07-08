# Lernbegleiter: Secure OrderDesk Digital Networking Track 08 – Betriebs- und Netznachweise / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_08_Betriebs-und-Netznachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** „Die Bestell-Pipeline läuft" ist eine Behauptung. Ein **Betriebs- oder Netznachweis** belegt sie: Ein
Health-Check zeigt, dass die Bestellannahme antwortet; eine Verbindungsprobe zeigt, dass die Bestellannahme
den Katalogdienst und die relationale Ablage erreicht; eine Metrik zeigt, wie viele Bestellungen erfolgreich
verarbeitet wurden. In dieser Einheit lernst du, solche Nachweise für die Bestell-Pipeline von Secure Trader
zu planen, sie datenschutzgerecht zu führen und ehrlich ihre **Aussagegrenze** zu benennen: Was belegt ein
Nachweis, und was belegt er gerade nicht?

**EN:** "The order pipeline is running" is a claim. An **operational or network evidence** proves it: a health
check shows the order intake responds; a connectivity probe shows the order intake reaches the catalog service
and the relational store; a metric shows how many orders were processed successfully. In this unit you learn to
plan such evidence for Secure Trader's order pipeline, to keep it privacy-compliant, and to honestly state its
**interpretation limit**: what does an evidence item prove, and what does it not prove?

**DE:** Diese Einheit baut auf der verteilten Integration und Agentenkommunikation (Einheit 07,
[`lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md`](Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md))
auf und liefert die Grundlage für Ausfallszenarien und Resilienz (Einheit 09,
[`lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md`](Secure-OrderDesk-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md)).
Die Korrelations-ID aus Einheit 07 verbindet hier Nachweise über Bestellannahme, Katalog und Ablage hinweg.

**EN:** This unit builds on the distributed integration and agent communication (unit 07,
[`lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md`](Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md))
and provides the basis for failure scenarios and resilience (unit 09,
[`lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md`](Secure-OrderDesk-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md)).
The correlation ID from unit 07 here links evidence across order intake, catalog, and store.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Health-Check / Health check | Prüfung, ob ein Dienst der Bestell-Pipeline antwortet und arbeitsbereit ist. |
| Erreichbarkeit / Reachability | Nachweis, dass ein Ziel wie Katalog oder Ablage über das Netz erreichbar ist. |
| Verbindungsprobe / Connectivity probe | Aktiver Test einer Netzverbindung, z. B. Testaufruf zur relationalen Ablage. |
| Metrik / Metric | Zahlenwert über den Betrieb, z. B. erfolgreiche Bestellungen pro Minute. |
| Log / Log | Zeitgeordneter Ereigniseintrag zur späteren Nachvollziehbarkeit. |
| Aussagegrenze / Interpretation limit | Klarstellung, was ein Nachweis belegt und was nicht. |
| Zweckbindung / Purpose limitation | Daten nur für den angegebenen Zweck erheben und nutzen. |
| Datenminimierung / Data minimization | So wenig Daten wie möglich erheben und speichern. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Nachweisarten trennen.** Unterscheide Health-Check (antwortet die Bestellannahme?),
Erreichbarkeit (sind Katalog und relationale Ablage im Netz erreichbar?), Metrik (wie viele Bestellungen und wie
erfolgreich?) und Log (was ist wann in der Pipeline passiert?). Jede Art beantwortet eine andere Frage; vermische
sie nicht.

**EN:** **Step 1 – Separate evidence types.** Distinguish health check (does the order intake respond?),
reachability (are catalog and relational store reachable on the network?), metric (how many orders and how
successful?), and log (what happened when in the pipeline?). Each type answers a different question; do not mix
them.

**DE:** **Schritt 2 – Zweck, Zugriff und Aufbewahrung festlegen.** Für jeden Nachweis notierst du: Wozu wird er
gebraucht? Wer darf ihn sehen? Wie lange wird er aufbewahrt? Ohne Zweckbindung sammelt man leicht zu viel.
Datenminimierung ist hier eine Sicherheits- und Datenschutzregel zugleich, gerade weil Bestelldaten Kundenbezug
haben.

**EN:** **Step 2 – Define purpose, access, and retention.** For each evidence item note: what is it needed for?
Who may see it? How long is it kept? Without purpose limitation it is easy to collect too much. Data
minimization here is both a security and a privacy rule, especially because order data relates to customers.

**DE:** **Schritt 3 – Logs datenschutzgerecht führen.** Protokolliere keine Secrets, Tokens, vollständigen
Verbindungszeichenketten oder unnötigen Kundendaten. Statt vollständiger Kundendatensätze genügt eine fiktive
Kundenkennung wie `ALFKI` oder die Korrelations-ID aus Einheit 07. Ein Log soll nachvollziehbar sein, ohne ein
Datenleck zu werden.

**EN:** **Step 3 – Keep logs privacy-compliant.** Do not log secrets, tokens, full connection strings, or
unnecessary customer data. Instead of complete customer records, a fictional customer identifier such as `ALFKI`
or the correlation ID from unit 07 is enough. A log should be traceable without becoming a data leak.

**DE:** **Schritt 4 – Aussagegrenze benennen.** Zu jedem Nachweis gehört der Satz „Das belegt … nicht." Ein
erfolgreicher Health-Check belegt zum Beispiel, dass die Bestellannahme antwortet, aber nicht, dass jede
Bestellung korrekt in der Ablage landet. Wer die Grenze verschweigt, leitet zu starke Schlüsse ab.

**EN:** **Step 4 – State the interpretation limit.** Each evidence item comes with the sentence "This does not
prove …". A successful health check, for example, proves that the order intake responds, but not that every
order is correctly persisted in the store. Hiding the limit leads to overly strong conclusions.

**DE:** **Schritt 5 – Nachweise ausnutzungssicher halten.** Ein Nachweis darf keine ausnutzbaren Details
verraten, etwa interne Endpunkte, Datenbanknamen oder genaue Versionsstände in öffentlicher Ausgabe. Balanciere
Nachvollziehbarkeit und Angriffsflächenreduktion bewusst.

**EN:** **Step 5 – Keep evidence non-exploitable.** Evidence must not reveal exploitable details, such as
internal endpoints, database names, or exact version levels in public output. Deliberately balance traceability
and attack surface reduction.

**DE:** **Typische Fehler.** Nachweisarten vermischen. Alles ohne Zweck sammeln. Secrets oder Kundendaten loggen.
Aussagegrenzen weglassen. Aus einer grünen Metrik auf eine fehlerfreie Bestell-Pipeline schließen.

**EN:** **Common mistakes.** Mixing evidence types. Collecting everything without purpose. Logging secrets or
customer data. Omitting interpretation limits. Concluding from one green metric that the whole order pipeline is
error-free.

### Beispiel / Example

```text
Nachweis 1: Health-Check /health (Bestellannahme) -> belegt: Dienst antwortet | NICHT: Bestellung persistiert
Nachweis 2: Verbindungsprobe Bestellannahme->Ablage -> belegt: Netzpfad offen | NICHT: Auth erfolgreich
Nachweis 3: Metrik orders_ok/min -> belegt: Durchsatz | NICHT: Datenqualitaet je Position
Nachweis 4: Log mit correlation_id -> belegt: Bestellablauf nachvollziehbar | NICHT: Ursache eines Fehlers
Datenschutz: kein Secret, kein Token, keine vollen Kundendaten; nur ALFKI-Kennung + neutrale IDs
Aufbewahrung: 14 Tage, Zugriff nur Betrieb; Zweck: Fehlersuche in der Bestell-Pipeline
N/A:         Distributed Tracing ueber Fremdsysteme in dieser Einheit N/A -> begruendet
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF 11d**
ist primär, weil erreichbare, gesunde und nachweisbare Dienste der Bestell-Pipeline Kern des sicheren Betriebs
vernetzter Systeme sind; LF 9 ist berührt, weil die Nachweise belegen, dass die bereitgestellten Dienste
erreichbar sind.

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`). **LF
11d** is primary because reachable, healthy, and provable order-pipeline services are core to the secure
operation of networked systems; LF 9 is touched because the evidence proves that the provided services are
reachable.

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Health, Erreichbarkeit, Metriken und Logs der Bestell-Pipeline sind Kern des sicheren Betriebs. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Nachweise belegen, dass die bereitgestellten Pipeline-Dienste erreichbar und gesund sind. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Protokollierung, Datenschutz, Nachvollziehbarkeit und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review),
`CL_10` (Datenschutz), `CL_11` (Betrieb/Monitoring) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Nachweise sind zweckgebunden und datenminimiert, Logs enthalten
keine Secrets oder vollen Kundendaten, und jede Aussage nennt ihre Grenze.* A11Y-Aspekt: Nachweistabellen und
Aussagegrenzen müssen als klarer Text ohne reine Farbmarkierung lesbar sein, damit sie mit Screenreader oder
Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure logging, privacy, traceability, and audit-ready
evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), `CL_10`
(privacy), `CL_11` (operations/monitoring), and `CL_12` (evidence and closure). The security decision of this
unit is: *evidence is purpose-bound and data-minimized, logs contain no secrets or full customer data, and every
claim names its limit.* Accessibility aspect: evidence tables and interpretation limits must be readable as
clear text without color-only marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum sollte man Health-Check, Erreichbarkeit, Metrik und Log getrennt betrachten? /
   **EN:** Why should you treat health check, reachability, metric, and log separately?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Art beantwortet eine andere Frage: antwortet die Bestellannahme, ist Katalog oder Ablage
   erreichbar, wie viele Bestellungen laufen erfolgreich, was ist wann passiert. Vermischt man sie, zieht man
   leicht falsche Schlüsse, etwa von Erreichbarkeit auf korrekte Persistenz. Getrennte Nachweise bleiben
   aussagekräftig.
   **EN:** Each type answers a different question: does the order intake respond, is catalog or store reachable,
   how many orders run successfully, what happened when. Mixing them leads to wrong conclusions, e.g. from
   reachability to correct persistence. Separate evidence stays meaningful.

   </details>

2. **DE:** Was bedeutet die Aussagegrenze eines Nachweises und warum ist sie wichtig? /
   **EN:** What does the interpretation limit of an evidence item mean and why does it matter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Aussagegrenze sagt, was ein Nachweis nicht belegt. Ein grüner Health-Check belegt nicht, dass
   jede Bestellung korrekt in der Ablage landet. Ohne diese Grenze zieht man zu starke Schlüsse und hält die
   Pipeline für sicherer oder gesünder, als sie ist.
   **EN:** The interpretation limit states what an evidence item does not prove. A green health check does not
   prove that every order is correctly persisted. Without this limit you draw too strong conclusions and consider
   the pipeline safer or healthier than it is.

   </details>

3. **DE:** Welche Daten dürfen nicht in ein Log der Bestell-Pipeline geschrieben werden? /
   **EN:** Which data must not be written to an order-pipeline log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine Secrets, Tokens, vollständigen Verbindungszeichenketten oder unnötigen Kundendaten. Solche
   Inhalte machen aus einem Log ein Datenleck. Stattdessen nutzt man eine fiktive Kennung wie `ALFKI` oder die
   Korrelations-ID, um Nachvollziehbarkeit ohne Preisgabe zu erreichen.
   **EN:** No secrets, tokens, full connection strings, or unnecessary customer data. Such content turns a log
   into a data leak. Instead you use a fictional identifier such as `ALFKI` or the correlation ID to achieve
   traceability without disclosure.

   </details>

4. **DE:** Was bedeutet Zweckbindung für Betriebsnachweise? /
   **EN:** What does purpose limitation mean for operational evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jeder Nachweis wird nur für einen benannten Zweck erhoben und genutzt, etwa Fehlersuche in der
   Bestell-Pipeline. Das begrenzt, welche Daten überhaupt anfallen, und verhindert, dass Betriebsdaten unbemerkt
   für andere Zwecke verwendet werden. Zweckbindung stützt die Datenminimierung.
   **EN:** Each evidence item is collected and used only for a named purpose, e.g. troubleshooting the order
   pipeline. This limits which data arises at all and prevents operational data being used unnoticed for other
   purposes. Purpose limitation supports data minimization.

   </details>

5. **DE:** (DPA) Warum darf man aus einer einzelnen grünen Metrik nicht auf eine fehlerfreie Pipeline schließen? /
   **EN:** (DPA) Why must you not conclude a flawless pipeline from a single green metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Metrik misst nur einen Ausschnitt, etwa den Durchsatz erfolgreich angenommener Bestellungen. Sie
   sagt nichts über die Datenqualität einzelner Positionen, seltene Fehler oder eine ausgefallene Ablage. Wer
   daraus eine fehlerfreie Pipeline ableitet, überschätzt die Aussagekraft der Zahl.
   **EN:** A metric measures only one aspect, e.g. the throughput of successfully accepted orders. It says
   nothing about the data quality of single line items, rare errors, or a failed store. Concluding a flawless
   pipeline overestimates the metric's significance.

   </details>

6. **DE:** (DV) Wie hilft die Korrelations-ID aus Einheit 07 bei Betriebsnachweisen? /
   **EN:** (DV) How does the correlation ID from unit 07 help with operational evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit der Korrelations-ID lassen sich zusammengehörige Ereignisse über Bestellannahme, Katalog und
   Ablage hinweg verknüpfen. So kann man den Ablauf einer Bestellung nachvollziehen, ohne volle Kundendaten zu
   speichern. Der Nachweis bleibt aussagekräftig und datensparsam.
   **EN:** With the correlation ID you can link related events across order intake, catalog, and store. This lets
   you trace an order's flow without storing full customer data. The evidence stays meaningful and data-minimal.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Health-Check, Erreichbarkeit, Metrik und Log für die Bestell-Pipeline unterscheiden.
- [ ] Zweck, Zugriff und Aufbewahrung je Nachweis festlegen.
- [ ] ein Log datenschutzgerecht und ohne Secrets oder volle Kundendaten planen.
- [ ] zu jedem Nachweis die Aussagegrenze benennen.
- [ ] erklären, warum Nachweise keine ausnutzbaren Details verraten dürfen.
- [ ] die Korrelations-ID für nachvollziehbare, datensparsame Nachweise nutzen.

**EN:** I can …

- [ ] distinguish health check, reachability, metric, and log for the order pipeline.
- [ ] define purpose, access, and retention per evidence item.
- [ ] plan a log privacy-compliant and without secrets or full customer data.
- [ ] state the interpretation limit for each evidence item.
- [ ] explain why evidence must not reveal exploitable details.
- [ ] use the correlation ID for traceable, data-minimal evidence.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_08_Betriebs-und-Netznachweise.md`. Sie baut auf der
verteilten Integration (Einheit 07) auf und liefert die Grundlage für Ausfallszenarien und Resilienz (Einheit
09). Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_08_Betriebs-und-Netznachweise.md`. It builds on the
distributed integration (unit 07) and provides the basis for failure scenarios and resilience (unit 09). The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
