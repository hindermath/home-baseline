# Lernbegleiter: Secure ServiceHarvester Digital Networking Track 06 – Verfügbarkeit, Timeouts und Wiederholstrategien / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure ServiceHarvester sammelt Statusdaten von vielen Maschinen über das Netz. Netze sind aber
unzuverlässig: Verbindungen brechen ab, eine Maschine antwortet langsam, ein Zieldienst ist kurz nicht
erreichbar. In dieser Einheit lernst du, wie der Dienst trotzdem **verfügbar** bleibt. Die Werkzeuge dafür
sind **Timeouts** (wie lange warte ich?), **Wiederholstrategien** (wie oft und in welchen Abständen versuche
ich es erneut?) und **Idempotenz** (eine Wiederholung darf keinen Schaden anrichten).

**EN:** The Secure ServiceHarvester collects status data from many machines over the network. But networks are
unreliable: connections drop, a machine responds slowly, a target service is briefly unreachable. In this unit
you learn how the service stays **available** anyway. The tools for this are **timeouts** (how long do I
wait?), **retry strategies** (how often and at what intervals do I try again?), and **idempotency** (a repeat
must not cause harm).

**DE:** Diese Einheit baut auf der Transportsicherheit und Endpunkt-Authentifizierung (Einheit 05) auf und
liefert die Grundlage für die verteilte Sammlung (Einheit 07,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.Lernbegleiter.md)).
Die C#-Referenz `InventarWorkerService` zeigt einen langlaufenden Worker, an dem sich Timeout- und
Wiederholverhalten sprachneutral einordnen lässt.

**EN:** This unit builds on transport security and endpoint authentication (unit 05) and provides the basis for
the distributed collection (unit 07,
[`lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.Lernbegleiter.md`](Secure-ServiceHarvester-Digital-Networking-Track_07_Verteilte-Sammlung-und-Agentenkommunikation.Lernbegleiter.md)).
The C# reference `InventarWorkerService` shows a long-running worker on which timeout and retry behavior can be
placed in a language-neutral way.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Verfügbarkeit / Availability | Anteil der Zeit, in dem der Dienst nutzbar ist; oft als Ziel formuliert. |
| Timeout / Timeout | Feste Obergrenze, wie lange auf eine Verbindung oder Antwort gewartet wird. |
| Wiederholung / Retry | Ein erneuter Versuch nach einem fehlgeschlagenen Aufruf. |
| Backoff / Backoff | Wachsende Wartezeit zwischen Wiederholungen, oft exponentiell. |
| Jitter / Jitter | Zufällige Streuung der Wartezeit, damit nicht alle gleichzeitig erneut anfragen. |
| Idempotenz / Idempotency | Eine wiederholte Aktion führt zum selben Ergebnis wie eine einzelne. |
| Circuit Breaker / Circuit Breaker | Schutzschalter, der nach vielen Fehlern kurz aussetzt, statt weiter zu drängen. |
| Retry-Sturm / Retry storm | Überlastung, wenn viele Clients gleichzeitig und ohne Backoff wiederholen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Timeouts setzen.** Lege für jede Netzoperation eine Obergrenze fest: Verbindungs-Timeout,
Anfrage-Timeout und gegebenenfalls ein Gesamt-Timeout. Unbegrenztes Warten ist gefährlich, weil ein einziger
hängender Aufruf Ressourcen blockiert und den Dienst lahmlegen kann. Ein Timeout ist damit auch eine
Sicherheitsmaßnahme gegen Erschöpfungsangriffe.

**EN:** **Step 1 – Set timeouts.** Define an upper limit for every network operation: connection timeout,
request timeout, and if needed an overall timeout. Waiting without a limit is dangerous because a single
hanging call blocks resources and can bring the service down. A timeout is therefore also a security measure
against exhaustion attacks.

**DE:** **Schritt 2 – Wiederholstrategie wählen.** Nicht jeder Fehler darf wiederholt werden. Wiederhole nur
bei vorübergehenden Fehlern (z. B. Zeitüberschreitung), nicht bei dauerhaften (z. B. „nicht berechtigt").
Nutze **Backoff** mit **Jitter** und eine **Obergrenze** der Versuche. So vermeidest du einen Retry-Sturm, der
den Zieldienst zusätzlich überlastet.

**EN:** **Step 2 – Choose a retry strategy.** Not every error may be retried. Retry only on transient errors
(e.g. a timeout), not on permanent ones (e.g. "not authorized"). Use **backoff** with **jitter** and a
**maximum** number of attempts. This avoids a retry storm that would overload the target service even more.

**DE:** **Schritt 3 – Idempotenz sicherstellen.** Wenn eine Sammelanfrage wiederholt wird, darf derselbe
Statuswert nicht doppelt gezählt oder doppelt gespeichert werden. Mit einer eindeutigen Kennung je Vorgang
erkennt der Dienst Wiederholungen und behandelt sie sicher. Ohne Idempotenz führt jede Wiederholung zu einem
neuen Risiko für die Datenqualität.

**EN:** **Step 3 – Ensure idempotency.** If a collection request is retried, the same status value must not be
counted or stored twice. With a unique identifier per operation the service recognizes repeats and handles
them safely. Without idempotency every retry becomes a new risk to data quality.

**DE:** **Schritt 4 – Dauerfehler behandeln.** Wenn ein Ziel dauerhaft nicht antwortet, hilft weiteres
Wiederholen nicht, sondern schadet. Ein **Circuit Breaker** setzt nach vielen Fehlern kurz aus und probiert
später vorsichtig erneut. So bleibt der Rest des Systems handlungsfähig (Fail-Safe statt Blockade).

**EN:** **Step 4 – Handle permanent errors.** If a target never answers, more retries do not help but harm. A
**circuit breaker** pauses after many failures and cautiously tries again later. This keeps the rest of the
system able to act (fail-safe instead of blockade).

**DE:** **Schritt 5 – Verfügbarkeitsziel und Nachweis.** Formuliere ein einfaches, ehrliches Verfügbarkeitsziel
und benenne je Aussage einen Nachweispfad, etwa einen Test, der einen langsamen oder ausgefallenen Endpunkt
simuliert. Positive Verfügbarkeitsaussagen ohne Nachweis sind nur Wunschdenken.

**EN:** **Step 5 – Availability target and evidence.** State a simple, honest availability target and point each
claim to an evidence path, for example a test that simulates a slow or failed endpoint. Positive availability
claims without evidence are only wishful thinking.

**DE:** **Typische Fehler.** Kein Timeout setzen. Jeden Fehler blind wiederholen. Ohne Backoff und Jitter
arbeiten. Keine Obergrenze der Versuche. Wiederholungen ohne Idempotenz. Interne Fehlermeldungen mit Endpunkten
oder Secrets nach außen geben.

**EN:** **Common mistakes.** Setting no timeout. Blindly retrying every error. Working without backoff and
jitter. No maximum number of attempts. Retries without idempotency. Leaking internal error messages with
endpoints or secrets.

### Beispiel / Example

```text
Operation:        Statusabruf von Maschine M über Netz
Timeouts:         connect = 2 s, request = 5 s, gesamt = 10 s
Wiederholung:     nur bei transienten Fehlern; max = 3 Versuche
Backoff + Jitter: 1 s, 2 s, 4 s (+/- Zufallsanteil)
Idempotenz:       je Abruf eine collection_id -> doppelte Abrufe werden verworfen
Dauerfehler:      Circuit Breaker offen nach 5 Fehlern -> 30 s Pause
Verfuegbarkeitsziel: Sammlung laeuft weiter, wenn einzelne Ziele ausfallen
Nachweis:         Test mit simuliertem Timeout + Test gegen doppelte collection_id
N/A:              Lastspitzen-Autoscaling in dieser Einheit N/A -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Timeouts, Wiederholung und Verfügbarkeit sichern den Betrieb vernetzter Dienste. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Client-Dienst-Verbindungen müssen unter Störung sicher weiterlaufen. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Verfügbarkeitsziele gehören zur Bereitstellung stabiler Dienste. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Fail-Safe Defaults, Verfügbarkeit, Defense in Depth und
auditfähige Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (Architektur/Design),
`CL_08` (Sicherheits-Code-Review), `CL_11` (Betrieb/Monitoring) und `CL_12` (Nachweise und Abschluss). Die
Sicherheitsentscheidung dieser Einheit lautet: *Jede Netzoperation hat ein Timeout, Wiederholungen sind
begrenzt und idempotent, und Dauerfehler führen in einen sicheren Zustand.* A11Y-Aspekt: Timeout- und
Wiederhol-Tabellen müssen als klarer Text ohne reine Farbmarkierung lesbar sein, damit sie mit Screenreader
oder Braille-Zeile nutzbar bleiben.

**EN:** Relation to the Secure Development Guideline: fail-safe defaults, availability, defense in depth, and
audit-ready evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (architecture/design),
`CL_08` (security code review), `CL_11` (operations/monitoring), and `CL_12` (evidence and closure). The
security decision of this unit is: *every network operation has a timeout, retries are bounded and idempotent,
and permanent errors lead to a safe state.* Accessibility aspect: timeout and retry tables must be readable as
clear text without color-only marking, so they remain usable with a screen reader or Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist ein fehlendes Timeout ein Verfügbarkeits- und Sicherheitsrisiko? /
   **EN:** Why is a missing timeout an availability and security risk?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Timeout kann ein einziger hängender Aufruf dauerhaft Ressourcen wie Verbindungen oder Threads
   blockieren. Häufen sich solche Aufrufe, wird der Dienst unbrauchbar. Angreifer können das gezielt zur
   Erschöpfung ausnutzen. Ein Timeout begrenzt das Warten und schützt so Verfügbarkeit und Ressourcen.
   **EN:** Without a timeout a single hanging call can block resources like connections or threads permanently.
   If such calls accumulate, the service becomes unusable. Attackers can exploit this for exhaustion. A timeout
   bounds the waiting and thus protects availability and resources.

   </details>

2. **DE:** Wozu dienen Backoff und Jitter bei Wiederholungen? /
   **EN:** What are backoff and jitter used for in retries?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Backoff vergrößert die Wartezeit zwischen Versuchen, damit ein überlastetes Ziel sich erholen kann.
   Jitter streut die Wartezeit zufällig, damit nicht alle Clients gleichzeitig erneut anfragen. Zusammen
   verhindern sie einen Retry-Sturm, der das Problem verschlimmern würde.
   **EN:** Backoff increases the wait time between attempts so an overloaded target can recover. Jitter randomly
   spreads the wait time so not all clients retry at the same moment. Together they prevent a retry storm that
   would make the problem worse.

   </details>

3. **DE:** Warum muss eine wiederholbare Sammelanfrage idempotent sein? /
   **EN:** Why must a retryable collection request be idempotent?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei einer Wiederholung kann dieselbe Anfrage mehrfach ankommen. Ist sie idempotent, führt das zum
   selben Ergebnis wie eine einzelne Anfrage. Ohne Idempotenz würden Statuswerte doppelt gezählt oder
   gespeichert, was die Datenqualität und daraus folgende Betriebsentscheidungen verfälscht.
   **EN:** On a retry the same request can arrive several times. If it is idempotent, this leads to the same
   result as a single request. Without idempotency status values would be counted or stored twice, corrupting
   data quality and the operational decisions derived from it.

   </details>

4. **DE:** Welche Fehler sollten wiederholt werden und welche nicht? /
   **EN:** Which errors should be retried and which should not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Vorübergehende (transiente) Fehler wie kurze Zeitüberschreitungen oder „Dienst gerade nicht
   erreichbar" dürfen wiederholt werden. Dauerhafte Fehler wie „nicht berechtigt" oder „Anfrage ungültig"
   sollten nicht wiederholt werden, weil das Ergebnis gleich bleibt und nur Last erzeugt.
   **EN:** Transient errors such as short timeouts or "service currently unreachable" may be retried. Permanent
   errors such as "not authorized" or "invalid request" should not be retried, because the result stays the
   same and only creates load.

   </details>

5. **DE:** (SI) Wofür ist ein Circuit Breaker im Betrieb nützlich? /
   **EN:** (SI) What is a circuit breaker useful for in operation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Circuit Breaker erkennt, dass ein Ziel dauerhaft ausfällt, und setzt Anfragen dorthin kurz aus.
   So werden Ressourcen nicht in aussichtslose Aufrufe gesteckt, und der übrige Dienst bleibt handlungsfähig.
   Später prüft er vorsichtig, ob das Ziel wieder antwortet.
   **EN:** A circuit breaker detects that a target keeps failing and briefly pauses requests to it. This avoids
   spending resources on hopeless calls, and the rest of the service stays able to act. Later it cautiously
   checks whether the target answers again.

   </details>

6. **DE:** (DV) Wie weist du nach, dass dein Timeout- und Wiederholverhalten funktioniert? /
   **EN:** (DV) How do you evidence that your timeout and retry behavior works?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit gezielten Tests, die einen langsamen, einen ausgefallenen und einen wieder erreichbaren Endpunkt
   simulieren. Man prüft, ob das Timeout greift, die Wiederholungen mit Backoff und Obergrenze ablaufen und
   doppelte Anfragen dank Idempotenz keinen Schaden anrichten. Diese Tests sind der Nachweispfad.
   **EN:** With targeted tests that simulate a slow, a failed, and a recovering endpoint. You check whether the
   timeout triggers, retries run with backoff and a limit, and duplicate requests cause no harm thanks to
   idempotency. These tests are the evidence path.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] für jede Netzoperation ein sinnvolles Timeout festlegen und begründen.
- [ ] eine Wiederholstrategie mit Backoff, Jitter und Obergrenze beschreiben.
- [ ] transiente von dauerhaften Fehlern unterscheiden.
- [ ] erklären, warum wiederholbare Anfragen idempotent sein müssen.
- [ ] die Idee eines Circuit Breakers in eigenen Worten wiedergeben.
- [ ] je Verfügbarkeitsaussage einen Nachweispfad angeben.

**EN:** I can …

- [ ] set and justify a sensible timeout for each network operation.
- [ ] describe a retry strategy with backoff, jitter, and a limit.
- [ ] distinguish transient from permanent errors.
- [ ] explain why retryable requests must be idempotent.
- [ ] restate the idea of a circuit breaker in my own words.
- [ ] give an evidence path for each availability claim.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort. Danach folgt Einheit 07
zur verteilten Sammlung und Agentenkommunikation.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there. Unit 07 on distributed
collection and agent communication follows next.
