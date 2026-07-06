# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 08 – Betriebs- und Netznachweise / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** „Der Dienst läuft" ist eine Behauptung. Ein **Betriebs- oder Netznachweis** belegt sie: Ein
Health-Check zeigt, dass der Dienst antwortet; eine Verbindungsprobe zeigt, dass ein Agent den Dienst
erreicht; eine Metrik zeigt, wie viele Sammlungen erfolgreich waren. In dieser Einheit lernst du, solche
Nachweise zu planen, sie datenschutzgerecht zu führen und ehrlich ihre **Aussagegrenze** zu benennen: Was
belegt ein Nachweis, und was belegt er gerade nicht?

**EN:** "The service is running" is a claim. An **operational or network evidence** proves it: a health check
shows the service responds; a connectivity probe shows an agent reaches the service; a metric shows how many
collections succeeded. In this unit you learn to plan such evidence, to keep it privacy-compliant, and to
honestly state its **interpretation limit**: what does an evidence item prove, and what does it not prove?

**DE:** Diese Einheit baut auf der verteilten Sammlung und Agentenkommunikation (Einheit 07,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.Lernbegleiter.md))
auf und liefert die Grundlage für Ausfallszenarien und Resilienz (Einheit 09,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md)).
Die Korrelations-ID aus Einheit 07 verbindet hier Nachweise über mehrere Agenten hinweg.

**EN:** This unit builds on the distributed collection and agent communication (unit 07,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.Lernbegleiter.md))
and provides the basis for failure scenarios and resilience (unit 09,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_09_Ausfallszenarien-und-Resilienz.Lernbegleiter.md)).
The correlation ID from unit 07 here links evidence across several agents.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Health-Check / Health check | Prüfung, ob ein Dienst grundsätzlich antwortet und arbeitsbereit ist. |
| Erreichbarkeit / Reachability | Nachweis, dass ein Ziel über das Netz erreichbar ist. |
| Verbindungsprobe / Connectivity probe | Aktiver Test einer Netzverbindung, z. B. Ping oder Testaufruf. |
| Metrik / Metric | Zahlenwert über den Betrieb, z. B. erfolgreiche Sammlungen pro Minute. |
| Log / Log | Zeitgeordneter Ereigniseintrag zur späteren Nachvollziehbarkeit. |
| Aussagegrenze / Interpretation limit | Klarstellung, was ein Nachweis belegt und was nicht. |
| Zweckbindung / Purpose limitation | Daten nur für den angegebenen Zweck erheben und nutzen. |
| Datenminimierung / Data minimization | So wenig Daten wie möglich erheben und speichern. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Nachweisarten trennen.** Unterscheide Health-Check (antwortet der Dienst?),
Erreichbarkeit (ist das Ziel im Netz erreichbar?), Metrik (wie viel und wie erfolgreich?) und Log (was ist wann
passiert?). Jede Art beantwortet eine andere Frage; vermische sie nicht.

**EN:** **Step 1 – Separate evidence types.** Distinguish health check (does the service respond?), reachability
(is the target reachable on the network?), metric (how much and how successful?), and log (what happened when?).
Each type answers a different question; do not mix them.

**DE:** **Schritt 2 – Zweck, Zugriff und Aufbewahrung festlegen.** Für jeden Nachweis notierst du: Wozu wird er
gebraucht? Wer darf ihn sehen? Wie lange wird er aufbewahrt? Ohne Zweckbindung sammelt man leicht zu viel.
Datenminimierung ist hier eine Sicherheits- und Datenschutzregel zugleich.

**EN:** **Step 2 – Define purpose, access, and retention.** For each evidence item note: what is it needed for?
Who may see it? How long is it kept? Without purpose limitation it is easy to collect too much. Data
minimization here is both a security and a privacy rule.

**DE:** **Schritt 3 – Logs datenschutzgerecht führen.** Protokolliere keine Secrets, Tokens, vollständigen
Pfade oder unnötigen personenbezogenen Daten. Nutze stattdessen neutrale Kennungen wie die Korrelations-ID aus
Einheit 07. Ein Log soll nachvollziehbar sein, ohne ein Datenleck zu werden.

**EN:** **Step 3 – Keep logs privacy-compliant.** Do not log secrets, tokens, full paths, or unnecessary
personal data. Instead use neutral identifiers such as the correlation ID from unit 07. A log should be
traceable without becoming a data leak.

**DE:** **Schritt 4 – Aussagegrenze benennen.** Zu jedem Nachweis gehört der Satz „Das belegt … nicht." Ein
erfolgreicher Health-Check belegt zum Beispiel, dass der Dienst antwortet, aber nicht, dass alle Agenten korrekt
sammeln. Wer die Grenze verschweigt, leitet zu starke Schlüsse ab.

**EN:** **Step 4 – State the interpretation limit.** Each evidence item comes with the sentence "This does not
prove …". A successful health check, for example, proves that the service responds, but not that all agents
collect correctly. Hiding the limit leads to overly strong conclusions.

**DE:** **Schritt 5 – Nachweise ausnutzungssicher halten.** Ein Nachweis darf keine ausnutzbaren Details
verraten, etwa interne Endpunkte oder genaue Versionsstände in öffentlicher Ausgabe. Balanciere
Nachvollziehbarkeit und Angriffsflächenreduktion bewusst.

**EN:** **Step 5 – Keep evidence non-exploitable.** Evidence must not reveal exploitable details, such as
internal endpoints or exact version levels in public output. Deliberately balance traceability and attack
surface reduction.

**DE:** **Typische Fehler.** Nachweisarten vermischen. Alles ohne Zweck sammeln. Secrets oder personenbezogene
Daten loggen. Aussagegrenzen weglassen. Aus einer grünen Metrik auf ein fehlerfreies Gesamtsystem schließen.

**EN:** **Common mistakes.** Mixing evidence types. Collecting everything without purpose. Logging secrets or
personal data. Omitting interpretation limits. Concluding from one green metric that the whole system is
error-free.

### Beispiel / Example

```text
Nachweis 1: Health-Check /health  -> belegt: Dienst antwortet | NICHT: Agenten sammeln korrekt
Nachweis 2: Verbindungsprobe Agent->Dienst -> belegt: Netzpfad offen | NICHT: Auth erfolgreich
Nachweis 3: Metrik collections_ok/min -> belegt: Durchsatz | NICHT: Datenqualitaet
Nachweis 4: Log mit correlation_id -> belegt: Ablauf nachvollziehbar | NICHT: Ursache eines Fehlers
Datenschutz: kein Secret, kein Token, keine Personendaten im Log; nur neutrale IDs
Aufbewahrung: 14 Tage, Zugriff nur Betrieb; Zweck: Fehlersuche
N/A:         Distributed Tracing ueber Fremdsysteme in dieser Einheit N/A -> begruendet
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Health, Erreichbarkeit, Metriken und Logs sind Kern des sicheren Betriebs. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Nachweise belegen, dass die bereitgestellten Dienste erreichbar und gesund sind. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Protokollierung, Datenschutz, Nachvollziehbarkeit und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_08` (Sicherheits-Code-Review),
`CL_10` (Datenschutz), `CL_11` (Betrieb/Monitoring) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Nachweise sind zweckgebunden und datenminimiert, Logs enthalten
keine Secrets oder Personendaten, und jede Aussage nennt ihre Grenze.* A11Y-Aspekt: Nachweistabellen und
Aussagegrenzen müssen als klarer Text ohne reine Farbmarkierung lesbar sein, damit sie mit Screenreader oder
Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: secure logging, privacy, traceability, and audit-ready
evidence. Matching checklists: `CL_01` (standards applicability), `CL_08` (security code review), `CL_10`
(privacy), `CL_11` (operations/monitoring), and `CL_12` (evidence and closure). The security decision of this
unit is: *evidence is purpose-bound and data-minimized, logs contain no secrets or personal data, and every
claim names its limit.* Accessibility aspect: evidence tables and interpretation limits must be readable as
clear text without color-only marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum sollte man Health-Check, Erreichbarkeit, Metrik und Log getrennt betrachten? /
   **EN:** Why should you treat health check, reachability, metric, and log separately?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jede Art beantwortet eine andere Frage: antwortet der Dienst, ist das Ziel erreichbar, wie viel
   läuft erfolgreich, was ist wann passiert. Vermischt man sie, zieht man leicht falsche Schlüsse, etwa von
   Erreichbarkeit auf korrektes Sammeln. Getrennte Nachweise bleiben aussagekräftig.
   **EN:** Each type answers a different question: does the service respond, is the target reachable, how much
   runs successfully, what happened when. Mixing them leads to wrong conclusions, e.g. from reachability to
   correct collection. Separate evidence stays meaningful.

   </details>

2. **DE:** Was bedeutet die Aussagegrenze eines Nachweises und warum ist sie wichtig? /
   **EN:** What does the interpretation limit of an evidence item mean and why does it matter?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Aussagegrenze sagt, was ein Nachweis nicht belegt. Ein grüner Health-Check belegt nicht, dass
   alle Agenten korrekt sammeln. Ohne diese Grenze zieht man zu starke Schlüsse und hält das System für
   sicherer oder gesünder, als es ist.
   **EN:** The interpretation limit states what an evidence item does not prove. A green health check does not
   prove that all agents collect correctly. Without this limit you draw too strong conclusions and consider the
   system safer or healthier than it is.

   </details>

3. **DE:** Welche Daten dürfen nicht in ein Log geschrieben werden? /
   **EN:** Which data must not be written to a log?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Keine Secrets, Tokens, Schlüssel, vollständigen Pfade oder unnötigen personenbezogenen Daten. Solche
   Inhalte machen aus einem Log ein Datenleck. Stattdessen nutzt man neutrale Kennungen wie die
   Korrelations-ID, um Nachvollziehbarkeit ohne Preisgabe zu erreichen.
   **EN:** No secrets, tokens, keys, full paths, or unnecessary personal data. Such content turns a log into a
   data leak. Instead you use neutral identifiers such as the correlation ID to achieve traceability without
   disclosure.

   </details>

4. **DE:** Was bedeutet Zweckbindung für Betriebsnachweise? /
   **EN:** What does purpose limitation mean for operational evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Jeder Nachweis wird nur für einen benannten Zweck erhoben und genutzt, etwa Fehlersuche. Das
   begrenzt, welche Daten überhaupt anfallen, und verhindert, dass Betriebsdaten unbemerkt für andere Zwecke
   verwendet werden. Zweckbindung stützt die Datenminimierung.
   **EN:** Each evidence item is collected and used only for a named purpose, e.g. troubleshooting. This limits
   which data arises at all and prevents operational data being used unnoticed for other purposes. Purpose
   limitation supports data minimization.

   </details>

5. **DE:** (DPA) Warum darf man aus einer einzelnen grünen Metrik nicht auf ein fehlerfreies System schließen? /
   **EN:** (DPA) Why must you not conclude a flawless system from a single green metric?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Metrik misst nur einen Ausschnitt, etwa den Durchsatz erfolgreicher Sammlungen. Sie sagt nichts
   über Datenqualität, seltene Fehler oder ausgefallene Agenten. Wer daraus ein fehlerfreies Gesamtsystem
   ableitet, überschätzt die Aussagekraft der Zahl.
   **EN:** A metric measures only one aspect, e.g. the throughput of successful collections. It says nothing
   about data quality, rare errors, or failed agents. Concluding a flawless whole system overestimates the
   metric's significance.

   </details>

6. **DE:** (DV) Wie hilft die Korrelations-ID aus Einheit 07 bei Betriebsnachweisen? /
   **EN:** (DV) How does the correlation ID from unit 07 help with operational evidence?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit der Korrelations-ID lassen sich zusammengehörige Ereignisse über mehrere Agenten und Stationen
   hinweg verknüpfen. So kann man einen Ablauf nachvollziehen, ohne personenbezogene Daten zu speichern. Der
   Nachweis bleibt aussagekräftig und datensparsam.
   **EN:** With the correlation ID you can link related events across several agents and stations. This lets you
   trace a flow without storing personal data. The evidence stays meaningful and data-minimal.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] Health-Check, Erreichbarkeit, Metrik und Log unterscheiden.
- [ ] Zweck, Zugriff und Aufbewahrung je Nachweis festlegen.
- [ ] ein Log datenschutzgerecht und ohne Secrets planen.
- [ ] zu jedem Nachweis die Aussagegrenze benennen.
- [ ] erklären, warum Nachweise keine ausnutzbaren Details verraten dürfen.
- [ ] die Korrelations-ID für nachvollziehbare, datensparsame Nachweise nutzen.

**EN:** I can …

- [ ] distinguish health check, reachability, metric, and log.
- [ ] define purpose, access, and retention per evidence item.
- [ ] plan a log privacy-compliant and without secrets.
- [ ] state the interpretation limit for each evidence item.
- [ ] explain why evidence must not reveal exploitable details.
- [ ] use the correlation ID for traceable, data-minimal evidence.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort. Danach folgt Einheit 09
zu Ausfallszenarien und Resilienz.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_08_Betriebs-und-Netznachweise.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there. Unit 09 on failure scenarios
and resilience follows next.
