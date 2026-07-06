# Lernbegleiter: Secure ServiceHarvester v2 08 – Betrieb, Logging, Health und Monitoring / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_08_Betrieb-Logging-Health-und-Monitoring.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Dienst, den man nicht beobachten kann, ist im Betrieb blind. Der Secure ServiceHarvester läuft
dauerhaft und sammelt in Abständen – Betreiber müssen erkennen können: **Läuft der Dienst noch? Hat die letzte
Sammlung geklappt? Gibt es viele Fehler?** In dieser Einheit machst du den Dienst **beobachtbar**. Dazu
gehören drei Bausteine: **strukturiertes Logging** (klar aufgebaute Log-Einträge statt roher Textzeilen), ein
**Health- und Status-Endpunkt** (eine Stelle, die den Zustand meldet) und **einfache Betriebskennzahlen**
(z. B. Zeitpunkt der letzten erfolgreichen Sammlung, Anzahl verarbeiteter Snapshots, Fehlerzahl).

**EN:** A service you cannot observe is blind in operation. The Secure ServiceHarvester runs continuously and
collects at intervals – operators must be able to recognize: **is the service still running? Did the last
collection succeed? Are there many errors?** In this unit you make the service **observable**. This involves
three building blocks: **structured logging** (clearly built log entries instead of raw text lines), a
**health and status endpoint** (one place that reports the state), and **simple operational metrics** (e.g.
time of the last successful collection, number of processed snapshots, error count).

**DE:** Beobachtbarkeit darf jedoch nie zur Datenpanne werden. Deshalb gilt die feste Regel: **keine Secrets,
keine internen Pfade und keine personenbezogenen Klartextdaten** in Logs oder Statusausgaben. Ein Status-
Endpunkt soll Zustand zeigen, nicht Geheimnisse verraten.

**EN:** Observability, however, must never become a data breach. Therefore the firm rule holds: **no secrets,
no internal paths, and no personal plain-text data** in logs or status output. A status endpoint should show
state, not reveal secrets.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Beobachtbarkeit / Observability | Fähigkeit, den Zustand eines Dienstes von außen zu erkennen. |
| Strukturiertes Logging / Structured logging | Log-Einträge mit festen Feldern (Ereignis, Ebene, Kontext) statt Freitext. |
| Health-Endpunkt / Health endpoint | Aufruf, der meldet, ob der Dienst gesund und erreichbar ist. |
| Status-Endpunkt / Status endpoint | Aufruf, der Betriebszustand und Kennzahlen kompakt zeigt. |
| Kennzahl / Metric | Messbarer Wert über den Betrieb, z. B. letzte Sammlung, Fehlerzahl. |
| Log-Ebene / Log level | Wichtigkeit eines Eintrags, z. B. info, warn, error. |
| Secret-frei / Secret-free | Grundsatz: keine Geheimnisse in Logs oder Statusausgaben. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Betriebsfragen festlegen.** Schreibe auf, welche Fragen der Betrieb beantworten können
muss: Läuft der Dienst? Wann war die letzte erfolgreiche Sammlung? Wie viele Snapshots wurden verarbeitet? Wie
viele Fehler gab es? **Warum wichtig:** Nur benannte Fragen zeigen, welche Logs und Kennzahlen wirklich
gebraucht werden.

**EN:** **Step 1 – Define operational questions.** Write down which questions operations must be able to
answer: is the service running? When was the last successful collection? How many snapshots were processed?
How many errors occurred? **Why it matters:** only named questions show which logs and metrics are really
needed.

**DE:** **Schritt 2 – Strukturiertes Logging planen.** Lege feste Felder je Log-Eintrag fest: Zeitpunkt,
Ebene, Ereignis, Kontext (z. B. Anzahl). **Warum wichtig:** Strukturierte Logs lassen sich filtern und
auswerten; rohe Textzeilen sind schwer durchsuchbar und leicht widersprüchlich.

**EN:** **Step 2 – Plan structured logging.** Define fixed fields per log entry: timestamp, level, event,
context (e.g. count). **Why it matters:** structured logs can be filtered and analyzed; raw text lines are hard
to search and easily inconsistent.

**DE:** **Schritt 3 – Health- und Status-Endpunkt entwerfen.** Der Health-Endpunkt sagt kurz „gesund" oder
„nicht gesund". Der Status-Endpunkt zeigt kompakte Kennzahlen. **Warum wichtig:** Betreiber und
Überwachungswerkzeuge fragen diese Stelle regelmäßig ab; sie ist die Schnittstelle zwischen Dienst und
Betrieb.

**EN:** **Step 3 – Design health and status endpoint.** The health endpoint briefly says "healthy" or "not
healthy". The status endpoint shows compact metrics. **Why it matters:** operators and monitoring tools query
this place regularly; it is the interface between service and operations.

**DE:** **Schritt 4 – Kennzahlen auswählen.** Wähle wenige, aussagekräftige Kennzahlen: letzte erfolgreiche
Sammlung, Anzahl verarbeiteter Snapshots, Fehlerzahl, Laufzeit. **Warum wichtig:** Zu viele Kennzahlen
verwirren; wenige klare Werte machen den Betriebszustand sofort erkennbar.

**EN:** **Step 4 – Select metrics.** Choose few, meaningful metrics: last successful collection, number of
processed snapshots, error count, uptime. **Why it matters:** too many metrics confuse; few clear values make
the operational state immediately recognizable.

**DE:** **Schritt 5 – Secret-freie Ausgaben sichern.** Prüfe jede Log- und Statusausgabe: keine Tokens, keine
Passwörter, keine internen Pfade, keine personenbezogenen Klartextdaten. **Warum wichtig:** Ein offen
erreichbarer Status-Endpunkt oder ein breit gespeichertes Log wird sonst selbst zur Schwachstelle.

**EN:** **Step 5 – Ensure secret-free output.** Check every log and status output: no tokens, no passwords, no
internal paths, no personal plain-text data. **Why it matters:** otherwise an openly reachable status endpoint
or a broadly stored log becomes a vulnerability itself.

**DE:** **Typische Fehler.** Alles roh ins Log schreiben statt strukturiert. Secrets oder interne Pfade im
Status-Endpunkt zeigen. Zu viele oder unklare Kennzahlen wählen. Health und Status vermischen. Fehler zwar
loggen, aber keine Kennzahl dafür führen.

**EN:** **Common mistakes.** Writing everything raw into the log instead of structured. Showing secrets or
internal paths in the status endpoint. Choosing too many or unclear metrics. Mixing health and status. Logging
errors but keeping no metric for them.

### Beispiel / Example

```text
Strukturierter Log-Eintrag:
  { ts, level: "info", event: "harvest_ok", verarbeitet: 42 }
  { ts, level: "warn", event: "snapshot_rejected", grund: "os_nicht_erlaubt" }

Status-Endpunkt (kompakt, secret-frei):
  { status: "healthy", letzte_sammlung: "2026-07-06T08:15Z", verarbeitet: 42, fehler: 1, laufzeit_min: 73 }

NICHT so (verraet Geheimnis / Interna):
  { status: "ok", db_pfad: "/var/data/harvest.db", token: "<PLATZHALTER-KEIN-ECHTER-WERT>" }

Reviewpfad: Status-Ausgabe gegen die Feldliste pruefen -> kein verbotenes Feld enthalten
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 9 Netzwerke und Dienste bereitstellen | Primär / Primary | Beobachtbarer Betrieb mit Logging, Health/Status und Kennzahlen macht den bereitgestellten Dienst betreibbar. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Health- und Status-Endpunkt beantworten Betriebs- und Serviceanfragen zu Zustand und Auslastung. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sicherer Betrieb, sichere Konfiguration, Logging-Grenzen,
Datenschutz und Testbarkeit. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Logging und
Nachweise), `CL_07` (Betrieb und Deployment), `CL_08` (Sicherheits-Code-Review) und `CL_09`
(Konfiguration/Secrets). Die Sicherheitsentscheidung dieser Einheit lautet: *Der Dienst ist beobachtbar, aber
Logs und Statusausgaben bleiben secret-frei und ohne Interna.* A11Y-Aspekt: Statuswerte und Kennzahlen müssen
als klarer Text erkennbar sein, nicht nur über grüne oder rote Symbole, damit Screenreader und Braille-Zeile
den Betriebszustand wiedergeben.

**EN:** Relation to the Secure Development Guideline: secure operation, secure configuration, logging limits,
privacy, and testability. Matching checklists: `CL_01` (standards applicability), `CL_04` (logging and
evidence), `CL_07` (operation and deployment), `CL_08` (security code review), and `CL_09`
(configuration/secrets). The security decision of this unit is: *the service is observable, but logs and
status output stay secret-free and without internals.* Accessibility aspect: status values and metrics must be
recognizable as clear text, not only via green or red symbols, so a screen reader and Braille display can
convey the operational state.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was bedeutet Beobachtbarkeit und warum ist sie für einen langlaufenden Dienst wichtig? /
   **EN:** What does observability mean and why is it important for a long-running service?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Beobachtbarkeit heißt, den Zustand des Dienstes von außen zu erkennen: läuft er, wann war die letzte
   Sammlung, gibt es Fehler. Ein Dienst läuft dauerhaft; ohne Beobachtbarkeit bleiben Probleme unbemerkt.
   **EN:** Observability means recognizing the service's state from outside: is it running, when was the last
   collection, are there errors. A service runs continuously; without observability, problems stay unnoticed.

   </details>

2. **DE:** Warum ist strukturiertes Logging besser als rohe Textzeilen? /
   **EN:** Why is structured logging better than raw text lines?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Strukturierte Logs haben feste Felder und lassen sich filtern, zählen und auswerten. Rohe Textzeilen
   sind schwer durchsuchbar, uneinheitlich und leicht widersprüchlich.
   **EN:** Structured logs have fixed fields and can be filtered, counted, and analyzed. Raw text lines are
   hard to search, inconsistent, and easily contradictory.

   </details>

3. **DE:** (SI) Warum dürfen keine Secrets oder internen Pfade in Logs oder Statusausgaben erscheinen? /
   **EN:** (SI) Why must no secrets or internal paths appear in logs or status output?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Logs werden breit gespeichert und Status-Endpunkte oft offen abgefragt. Secrets oder Pfade darin
   machen den Betrieb selbst zur Schwachstelle und erleichtern Angriffe. Deshalb bleiben Ausgaben secret-frei.
   **EN:** Logs are stored broadly and status endpoints are often queried openly. Secrets or paths in them make
   operation itself a vulnerability and ease attacks. Therefore output stays secret-free.

   </details>

4. **DE:** (DV) Welche Rolle spielt der Health-/Status-Endpunkt als Schnittstelle zum Betrieb? /
   **EN:** (DV) What role does the health/status endpoint play as an interface to operations?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er ist die definierte Schnittstelle, über die Betreiber und Überwachungswerkzeuge den Zustand
   abfragen. Als Systemgrenze muss er klar spezifiziert und abgesichert sein und darf nur unkritische
   Informationen liefern.
   **EN:** It is the defined interface through which operators and monitoring tools query the state. As a system
   boundary it must be clearly specified and secured and may only deliver non-critical information.

   </details>

5. **DE:** (AE) Wie hilft eine kurze, klare Kennzahlen-Liste bei der Umsetzung? /
   **EN:** (AE) How does a short, clear list of metrics help with implementation?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenige klare Kennzahlen legen genau fest, was der Code messen und melden muss. Das vermeidet
   verstreute, uneinheitliche Zähler und macht den Status-Endpunkt einfach und prüfbar.
   **EN:** Few clear metrics define exactly what the code must measure and report. This avoids scattered,
   inconsistent counters and makes the status endpoint simple and reviewable.

   </details>

6. **DE:** (DPA) Wie verhinderst du, dass Betriebskennzahlen personenbezogene Daten preisgeben? /
   **EN:** (DPA) How do you prevent operational metrics from exposing personal data?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kennzahlen zählen und aggregieren nur (Anzahl, Zeit, Fehlerzahl) und nennen keine Einzelperson.
   Personenbezogene Klartextdaten werden weggelassen, sodass aus dem Status keine Person erkennbar wird.
   **EN:** Metrics only count and aggregate (count, time, error count) and name no individual. Personal
   plain-text data is omitted so that no person is identifiable from the status.

   </details>

7. **DE:** Worin unterscheiden sich Health-Endpunkt und Status-Endpunkt? /
   **EN:** How do the health endpoint and the status endpoint differ?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Health-Endpunkt gibt eine kurze Ja/Nein-Aussage („gesund/nicht gesund"). Der Status-Endpunkt
   zeigt kompakte Kennzahlen zum Betrieb. Getrennt gehalten bleiben beide einfach und eindeutig.
   **EN:** The health endpoint gives a short yes/no answer ("healthy/not healthy"). The status endpoint shows
   compact operational metrics. Kept separate, both stay simple and unambiguous.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] die zentralen Betriebsfragen für den Dienst benennen.
- [ ] strukturierte Log-Einträge mit festen Feldern entwerfen.
- [ ] Health- und Status-Endpunkt unterscheiden und beschreiben.
- [ ] wenige aussagekräftige Betriebskennzahlen auswählen.
- [ ] Logs und Statusausgaben secret-frei und ohne Interna halten.
- [ ] einen Reviewpfad gegen die Feldliste angeben.

**EN:** I can …

- [ ] name the central operational questions for the service.
- [ ] design structured log entries with fixed fields.
- [ ] distinguish and describe health and status endpoints.
- [ ] select few meaningful operational metrics.
- [ ] keep logs and status output secret-free and without internals.
- [ ] give a review path against the field list.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_08_Betrieb-Logging-Health-und-Monitoring.md`. Der Copy-Paste-Prompt für
einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_08_Betrieb-Logging-Health-und-Monitoring.md`. The copy-paste prompt for
a later, manually started Spec Kit run is provided there.
