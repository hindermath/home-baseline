# Lernbegleiter: Secure OrderDesk Digital Networking Track 06 – Verfügbarkeit, Timeouts und Wiederholstrategien / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Das Secure OrderDesk ist die Bestell-/Handelsplattform der fiktiven Firma Secure Trader auf
Northwind-Datenbasis (Kunden, Produkte, Bestellungen, inkl. `ALFKI`). Die Bestell-Pipeline besteht aus
mehreren Diensten über das Netz: Bestellannahme, Katalogabfrage und die relationale Ablage. Netze sind aber
unzuverlässig: Verbindungen brechen ab, die Datenbank antwortet langsam, der Katalog ist kurz nicht
erreichbar. In dieser Einheit lernst du, wie die Plattform trotzdem **verfügbar** bleibt. Die Werkzeuge dafür
sind **Timeouts** (wie lange warte ich?), **Wiederholstrategien** (wie oft und in welchen Abständen versuche
ich es erneut?) und **Idempotenz** (eine wiederholte Bestellung darf keine Doppelbestellung erzeugen).

**EN:** Secure OrderDesk is the ordering/trading platform of the fictional company Secure Trader on a Northwind
data base (customers, products, orders, incl. `ALFKI`). The order pipeline consists of several services over
the network: order intake, catalog lookup, and the relational store. But networks are unreliable: connections
drop, the database responds slowly, the catalog is briefly unreachable. In this unit you learn how the
platform stays **available** anyway. The tools for this are **timeouts** (how long do I wait?), **retry
strategies** (how often and at what intervals do I try again?), and **idempotency** (a repeated order must not
create a duplicate order).

**DE:** Diese Einheit baut auf der Transportsicherheit und Endpunkt-Authentifizierung (Einheit 05) auf und
liefert die Grundlage für die verteilte Integration (Einheit 07,
[`lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md`](Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md)).
An der Bestellannahme lässt sich Timeout- und Wiederholverhalten sprachneutral für C#, Go, Java, Python, Rust
und Swift einordnen.

**EN:** This unit builds on transport security and endpoint authentication (unit 05) and provides the basis for
the distributed integration (unit 07,
[`lernbegleiter/Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md`](Secure-OrderDesk-Digital-Networking-Track_07_Verteilte-Integration-und-Agentenkommunikation.Lernbegleiter.md)).
On the order intake, timeout and retry behavior can be placed in a language-neutral way for C#, Go, Java,
Python, Rust, and Swift.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Verfügbarkeit / Availability | Anteil der Zeit, in dem die Bestell-Pipeline nutzbar ist; oft als Ziel formuliert. |
| Timeout / Timeout | Feste Obergrenze, wie lange auf eine Verbindung oder Antwort (z. B. der Datenbank) gewartet wird. |
| Wiederholung / Retry | Ein erneuter Versuch nach einem fehlgeschlagenen Aufruf, etwa einer Bestellannahme. |
| Backoff / Backoff | Wachsende Wartezeit zwischen Wiederholungen, oft exponentiell. |
| Jitter / Jitter | Zufällige Streuung der Wartezeit, damit nicht alle Clients gleichzeitig erneut anfragen. |
| Idempotenz / Idempotency | Eine wiederholte Bestellung führt zum selben Ergebnis wie eine einzelne (keine Doppelbestellung). |
| Circuit Breaker / Circuit Breaker | Schutzschalter, der nach vielen Fehlern kurz aussetzt, statt weiter zu drängen. |
| Retry-Sturm / Retry storm | Überlastung, wenn viele Clients gleichzeitig und ohne Backoff wiederholen. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Timeouts setzen.** Lege für jede Netzoperation eine Obergrenze fest: Verbindungs-Timeout,
Anfrage-Timeout und gegebenenfalls ein Gesamt-Timeout, etwa für den Zugriff auf Katalog und relationale
Ablage. Unbegrenztes Warten ist gefährlich, weil ein einziger hängender Datenbankaufruf Verbindungen blockiert
und die Bestellannahme lahmlegen kann. Ein Timeout ist damit auch eine Sicherheitsmaßnahme gegen
Erschöpfungsangriffe.

**EN:** **Step 1 – Set timeouts.** Define an upper limit for every network operation: connection timeout,
request timeout, and if needed an overall timeout, for example for access to the catalog and the relational
store. Waiting without a limit is dangerous because a single hanging database call blocks connections and can
bring order intake down. A timeout is therefore also a security measure against exhaustion attacks.

**DE:** **Schritt 2 – Wiederholstrategie wählen.** Nicht jeder Fehler darf wiederholt werden. Wiederhole nur
bei vorübergehenden Fehlern (z. B. Zeitüberschreitung der Datenbank), nicht bei dauerhaften (z. B. „ungültige
Bestellung" oder „nicht berechtigt"). Nutze **Backoff** mit **Jitter** und eine **Obergrenze** der Versuche.
So vermeidest du einen Retry-Sturm, der Katalog oder relationale Ablage zusätzlich überlastet.

**EN:** **Step 2 – Choose a retry strategy.** Not every error may be retried. Retry only on transient errors
(e.g. a database timeout), not on permanent ones (e.g. "invalid order" or "not authorized"). Use **backoff**
with **jitter** and a **maximum** number of attempts. This avoids a retry storm that would overload the catalog
or relational store even more.

**DE:** **Schritt 3 – Idempotenz sicherstellen.** Wenn eine Bestellannahme wiederholt wird, darf für einen
Kunden wie `ALFKI` nicht zweimal dieselbe Bestellung entstehen. Mit einer eindeutigen Kennung je Bestellvorgang
(Idempotenzschlüssel) erkennt die Plattform Wiederholungen und behandelt sie sicher. Ohne Idempotenz führt jede
Wiederholung zu einem neuen Risiko für die Datenqualität und für die Umsatzauswertung.

**EN:** **Step 3 – Ensure idempotency.** If order intake is retried, a customer such as `ALFKI` must not get
the same order twice. With a unique identifier per order operation (idempotency key) the platform recognizes
repeats and handles them safely. Without idempotency every retry becomes a new risk to data quality and to
revenue reporting.

**DE:** **Schritt 4 – Dauerfehler behandeln.** Wenn die relationale Ablage dauerhaft nicht antwortet, hilft
weiteres Wiederholen nicht, sondern schadet. Ein **Circuit Breaker** setzt nach vielen Fehlern kurz aus und
probiert später vorsichtig erneut. So bleibt der Rest der Plattform handlungsfähig (Fail-Safe statt Blockade),
etwa indem die Bestellannahme sauber ablehnt oder zwischenpuffert.

**EN:** **Step 4 – Handle permanent errors.** If the relational store never answers, more retries do not help
but harm. A **circuit breaker** pauses after many failures and cautiously tries again later. This keeps the
rest of the platform able to act (fail-safe instead of blockade), for example by cleanly rejecting or buffering
order intake.

**DE:** **Schritt 5 – Verfügbarkeitsziel und Nachweis.** Formuliere ein einfaches, ehrliches Verfügbarkeitsziel
und benenne je Aussage einen Nachweispfad, etwa einen Test, der eine langsame oder ausgefallene Datenbank
simuliert. Positive Verfügbarkeitsaussagen ohne Nachweis sind nur Wunschdenken.

**EN:** **Step 5 – Availability target and evidence.** State a simple, honest availability target and point each
claim to an evidence path, for example a test that simulates a slow or failed database. Positive availability
claims without evidence are only wishful thinking.

**DE:** **Typische Fehler.** Kein Timeout auf den Datenbankzugriff setzen. Jeden Fehler blind wiederholen. Ohne
Backoff und Jitter arbeiten. Keine Obergrenze der Versuche. Bestellannahme ohne Idempotenz wiederholen.
Interne Fehlermeldungen mit Verbindungszeichenketten oder SQL-Fragmenten nach außen geben.

**EN:** **Common mistakes.** Setting no timeout on the database access. Blindly retrying every error. Working
without backoff and jitter. No maximum number of attempts. Retrying order intake without idempotency. Leaking
internal error messages with connection strings or SQL fragments.

### Beispiel / Example

```text
Operation:        Bestellannahme fuer Kunde ALFKI -> Katalog + relationale Ablage
Timeouts:         connect = 2 s, request = 5 s, gesamt = 10 s
Wiederholung:     nur bei transienten Fehlern; max = 3 Versuche
Backoff + Jitter: 1 s, 2 s, 4 s (+/- Zufallsanteil)
Idempotenz:       je Bestellung eine order_key -> doppelte Annahmen werden verworfen
Dauerfehler:      Circuit Breaker offen nach 5 Fehlern -> 30 s Pause
Verfuegbarkeitsziel: Bestellannahme lehnt sauber ab, wenn die DB kurz ausfaellt
Nachweis:         Test mit simuliertem DB-Timeout + Test gegen doppelte order_key
N/A:              Geo-Redundanz der DB in dieser Einheit N/A -> Begruendung dokumentiert
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 11d Betrieb und Sicherheit vernetzter Systeme gewährleisten | Primär / Primary | Timeouts, Wiederholung und Verfügbarkeit sichern den Betrieb der Bestell-Pipeline. |
| LF 3 Clients in Netzwerke einbinden | Berührt / Touched | Bestellannahme, Katalog und Ablage müssen unter Störung sicher weiterlaufen. |
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

1. **DE:** Warum ist ein fehlendes Timeout auf den Datenbankzugriff ein Verfügbarkeits- und Sicherheitsrisiko? /
   **EN:** Why is a missing timeout on the database access an availability and security risk?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Timeout kann ein einziger hängender Datenbankaufruf dauerhaft Verbindungen oder Threads
   blockieren. Häufen sich solche Aufrufe, wird die Bestellannahme unbrauchbar. Angreifer können das gezielt zur
   Erschöpfung ausnutzen. Ein Timeout begrenzt das Warten und schützt so Verfügbarkeit und Ressourcen.
   **EN:** Without a timeout a single hanging database call can block connections or threads permanently. If such
   calls accumulate, order intake becomes unusable. Attackers can exploit this for exhaustion. A timeout bounds
   the waiting and thus protects availability and resources.

   </details>

2. **DE:** Wozu dienen Backoff und Jitter bei Wiederholungen? /
   **EN:** What are backoff and jitter used for in retries?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Backoff vergrößert die Wartezeit zwischen Versuchen, damit eine überlastete Datenbank sich erholen
   kann. Jitter streut die Wartezeit zufällig, damit nicht alle Clients gleichzeitig erneut anfragen. Zusammen
   verhindern sie einen Retry-Sturm, der das Problem verschlimmern würde.
   **EN:** Backoff increases the wait time between attempts so an overloaded database can recover. Jitter randomly
   spreads the wait time so not all clients retry at the same moment. Together they prevent a retry storm that
   would make the problem worse.

   </details>

3. **DE:** Warum muss eine wiederholbare Bestellannahme idempotent sein? /
   **EN:** Why must a retryable order intake be idempotent?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Bei einer Wiederholung kann dieselbe Bestellung mehrfach ankommen. Ist die Annahme idempotent, führt
   das zum selben Ergebnis wie eine einzelne Bestellung. Ohne Idempotenz entstünde für einen Kunden wie `ALFKI`
   eine Doppelbestellung, was Datenqualität, Umsatzauswertung und Kundenvertrauen verfälscht.
   **EN:** On a retry the same order can arrive several times. If intake is idempotent, this leads to the same
   result as a single order. Without idempotency a customer such as `ALFKI` would get a duplicate order,
   corrupting data quality, revenue reporting, and customer trust.

   </details>

4. **DE:** Welche Fehler sollten wiederholt werden und welche nicht? /
   **EN:** Which errors should be retried and which should not?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Vorübergehende (transiente) Fehler wie kurze Zeitüberschreitungen oder „Datenbank gerade nicht
   erreichbar" dürfen wiederholt werden. Dauerhafte Fehler wie „nicht berechtigt" oder „Bestellung ungültig"
   sollten nicht wiederholt werden, weil das Ergebnis gleich bleibt und nur Last erzeugt.
   **EN:** Transient errors such as short timeouts or "database currently unreachable" may be retried. Permanent
   errors such as "not authorized" or "invalid order" should not be retried, because the result stays the same
   and only creates load.

   </details>

5. **DE:** (SI) Wofür ist ein Circuit Breaker im Betrieb der Bestell-Pipeline nützlich? /
   **EN:** (SI) What is a circuit breaker useful for in operating the order pipeline?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Circuit Breaker erkennt, dass die relationale Ablage dauerhaft ausfällt, und setzt Anfragen dorthin
   kurz aus. So werden Ressourcen nicht in aussichtslose Aufrufe gesteckt, und die übrige Plattform bleibt
   handlungsfähig. Später prüft er vorsichtig, ob die Datenbank wieder antwortet.
   **EN:** A circuit breaker detects that the relational store keeps failing and briefly pauses requests to it.
   This avoids spending resources on hopeless calls, and the rest of the platform stays able to act. Later it
   cautiously checks whether the database answers again.

   </details>

6. **DE:** (DV) Wie weist du nach, dass dein Timeout- und Wiederholverhalten funktioniert? /
   **EN:** (DV) How do you evidence that your timeout and retry behavior works?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit gezielten Tests, die eine langsame, eine ausgefallene und eine wieder erreichbare Datenbank
   simulieren. Man prüft, ob das Timeout greift, die Wiederholungen mit Backoff und Obergrenze ablaufen und
   doppelte Bestellungen dank Idempotenz keinen Schaden anrichten. Diese Tests sind der Nachweispfad.
   **EN:** With targeted tests that simulate a slow, a failed, and a recovering database. You check whether the
   timeout triggers, retries run with backoff and a limit, and duplicate orders cause no harm thanks to
   idempotency. These tests are the evidence path.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] für jeden Datenbank- und Netzzugriff ein sinnvolles Timeout festlegen und begründen.
- [ ] eine Wiederholstrategie mit Backoff, Jitter und Obergrenze beschreiben.
- [ ] transiente von dauerhaften Fehlern unterscheiden.
- [ ] erklären, warum eine wiederholbare Bestellannahme idempotent sein muss.
- [ ] die Idee eines Circuit Breakers in eigenen Worten wiedergeben.
- [ ] je Verfügbarkeitsaussage einen Nachweispfad angeben.

**EN:** I can …

- [ ] set and justify a sensible timeout for each database and network access.
- [ ] describe a retry strategy with backoff, jitter, and a limit.
- [ ] distinguish transient from permanent errors.
- [ ] explain why a retryable order intake must be idempotent.
- [ ] restate the idea of a circuit breaker in my own words.
- [ ] give an evidence path for each availability claim.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort. Danach folgt Einheit 07
zur verteilten Integration und Agentenkommunikation.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Digital-Networking-Track_06_Verfuegbarkeit-Timeouts-und-Wiederholstrategien.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there. Unit 07 on distributed
integration and agent communication follows next.
