# Lernbegleiter: Secure OrderDesk v2 08 – Betrieb, Logging, Health und Monitoring / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_08_Betrieb-Logging-Health-und-Monitoring.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Bestell-/Handelsplattform muss im Betrieb **beobachtbar** sein: Betreiber wollen erkennen, ob der
Dienst läuft, ob die Datenbank erreichbar ist und wie viele Bestellungen ankommen. In dieser Einheit planst du
**strukturiertes Logging** (Ereignis, Ebene, Kontext als geordnete Felder statt roher Text), einen **Health-
und Status-Endpunkt** (eine Abfrage, die „gesund/ungesund" und die Datenbank-Erreichbarkeit meldet) und
einfache **Betriebs- und Bestellkennzahlen** (z. B. angenommene Bestellungen, letzte erfolgreiche Auswertung,
Fehlerzahl, Umsatzsumme je Zeitraum).

**EN:** An ordering/trading platform must be **observable** in operation: operators want to see whether the
service runs, whether the database is reachable, and how many orders arrive. In this unit you plan **structured
logging** (event, level, context as ordered fields instead of raw text), a **health and status endpoint** (a
query reporting "healthy/unhealthy" and database reachability), and simple **operational and order metrics**
(e.g. accepted orders, last successful report, error count, revenue sum per period).

**DE:** Beobachtbarkeit darf nicht zum Leck werden. Weder Logs noch Statusausgaben dürfen **Secrets**
(Verbindungszeichenketten, Tokens) oder **personenbezogene Kundendaten im Klartext** enthalten. `ALFKI` dient
als fiktives Beispiel: Eine Kennzahl darf „Anzahl Bestellungen" zählen, aber der Status darf nicht die volle
Adresse von `ALFKI` ausgeben.

**EN:** Observability must not become a leak. Neither logs nor status output may contain **secrets**
(connection strings, tokens) or **personal customer data in clear text**. `ALFKI` serves as a fictional
example: a metric may count "number of orders", but the status must not print `ALFKI`'s full address.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Strukturiertes Logging / Structured logging | Log-Einträge als geordnete Felder (Zeit, Ebene, Ereignis, Kontext). |
| Log-Ebene / Log level | Wichtigkeit eines Eintrags (z. B. info, warn, error). |
| Health-Endpunkt / Health endpoint | Abfrage, die meldet, ob der Dienst und die Datenbank gesund sind. |
| Statusausgabe / Status output | Kurzbericht über Zustand und Auslastung, ohne Geheimnisse. |
| Betriebskennzahl / Operational metric | Messwert wie Bestellzahl, Fehlerzahl, Umsatz je Zeitraum. |
| Datenschutz im Log / Privacy in logs | Regel: keine personenbezogenen Kundendaten in Logs/Status. |
| Log-Injection / Log injection | Angriff, der über ungefilterte Eingaben das Protokoll fälscht. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Log-Felder festlegen.** Bestimme feste Felder: Zeit, Ebene, Ereignis, Kontext (z. B.
Bestell-ID/-Hash), Ergebnis. **Warum wichtig:** Strukturierte Felder lassen sich filtern und auswerten; roher
Freitext nicht.

**EN:** **Step 1 – Define log fields.** Determine fixed fields: time, level, event, context (e.g. order
ID/hash), result. **Why it matters:** structured fields can be filtered and analyzed; raw free text cannot.

**DE:** **Schritt 2 – Log-Ebenen sinnvoll nutzen.** Ordne Ereignisse Ebenen zu: info (normaler Betrieb), warn
(auffällig), error (Fehler). **Warum wichtig:** Ebenen helfen, Wichtiges von Rauschen zu trennen und Alarme
sinnvoll zu setzen.

**EN:** **Step 2 – Use log levels sensibly.** Assign events to levels: info (normal operation), warn (notable),
error (failure). **Why it matters:** levels help separate important messages from noise and set alarms
meaningfully.

**DE:** **Schritt 3 – Health-/Status-Vertrag definieren.** Lege fest, was der Health-Endpunkt prüft (Dienst
läuft, Datenbank erreichbar) und was er zurückgibt (gesund/ungesund plus wenige Kennzahlen). **Warum wichtig:**
Ein klarer Vertrag macht die Überwachung automatisierbar und vergleichbar.

**EN:** **Step 3 – Define the health/status contract.** Decide what the health endpoint checks (service runs,
database reachable) and what it returns (healthy/unhealthy plus a few metrics). **Why it matters:** a clear
contract makes monitoring automatable and comparable.

**DE:** **Schritt 4 – Kennzahlen wählen.** Bestimme wenige, aussagekräftige Kennzahlen: angenommene
Bestellungen, Fehlerzahl, letzte erfolgreiche Auswertung, Umsatzsumme je Zeitraum. **Warum wichtig:** Wenige
gute Kennzahlen sind nützlicher als viele verwirrende; die Aussagegrenze muss klar sein (z. B. „nur fiktive
Daten").

**EN:** **Step 4 – Choose metrics.** Determine a few meaningful metrics: accepted orders, error count, last
successful report, revenue sum per period. **Why it matters:** a few good metrics are more useful than many
confusing ones; the limit of interpretation must be clear (e.g. "fictional data only").

**DE:** **Schritt 5 – Datenschutz und Log-Injection absichern.** Prüfe jede Log- und Statusausgabe: keine
Secrets, keine Klartext-Kundendaten, keine ungefilterten Eingaben. Freitext begrenzen und bereinigen. **Warum
wichtig:** Ein Log ist oft breit lesbar; ein Leck dort wirkt weit.

**EN:** **Step 5 – Secure privacy and against log injection.** Check every log and status output: no secrets,
no clear-text customer data, no unfiltered inputs. Limit and sanitize free text. **Why it matters:** a log is
often widely readable; a leak there has broad impact.

**DE:** **Typische Fehler.** Rohen Freitext statt strukturierter Felder loggen. Alles auf einer Ebene
protokollieren. Im Health-Endpunkt interne Details oder Verbindungszeichenketten ausgeben. Kundennamen oder
Adressen in Kennzahlen aufnehmen. Ungefilterte Eingaben ins Log schreiben (Log-Injection).

**EN:** **Common mistakes.** Logging raw free text instead of structured fields. Logging everything on one
level. Printing internal details or connection strings in the health endpoint. Including customer names or
addresses in metrics. Writing unfiltered inputs into the log (log injection).

### Beispiel / Example

```text
Strukturierter Log-Eintrag (sicher):
  zeit=2026-06-15T10:12Z  ebene=info  ereignis=OrderAccepted  bestellung=Order#50218  kunde=hash(ALFKI)  ergebnis=ok

Health-/Status-Ausgabe (sicher):
  status=gesund  db=erreichbar  bestellungen_heute=42  fehler_24h=0  letzte_auswertung=2026-06-15T09:00Z

NICHT so (unsicher):
  ebene=info  text="verbunden mit db-01 conn=Server=...;Pwd=..."          -> Secret im Log
  status=gesund  letzter_kunde="Maria Anders, Berlin"                     -> Klartext-Kundendaten
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 9 Netzwerke und Dienste bereitstellen | Primär / Primary | Beobachtbarer Betrieb mit Logging, Health und Monitoring ist Kern des sicheren Bereitstellens von Diensten. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Health-/Statusabfragen und Betriebskennzahlen unterstützen die Bearbeitung von Serviceanfragen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Programmierung, sicheres Logging, Datenschutz und
Betrieb. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_04` (Datenschutz/Logging), `CL_07`
(Konfiguration/Betrieb), `CL_08` (Sicherheits-Code-Review), `CL_09` (Betriebs-/Nachweisbezug). Die
Sicherheitsentscheidung dieser Einheit lautet: *Der Dienst ist beobachtbar, aber Logs und Statusausgaben
enthalten weder Secrets noch Klartext-Kundendaten.* A11Y-Aspekt: Statusinformationen müssen textbasiert und
ohne reine Farbsignale sein; „gesund/ungesund" darf nicht nur an einer grün/roten Ampel hängen, sondern muss
als Text erkennbar sein, damit Screenreader und Braille-Zeile ihn wiedergeben.

**EN:** Relation to the Secure Development Guideline: secure coding, safe logging, privacy, and operation.
Matching checklists: `CL_01` (standards applicability), `CL_04` (privacy/logging), `CL_07`
(configuration/operation), `CL_08` (security code review), `CL_09` (operational/evidence relation). The security
decision of this unit is: *the service is observable, but logs and status output contain neither secrets nor
clear-text customer data.* Accessibility aspect: status information must be text-based and free of color-only
signals; "healthy/unhealthy" must not depend only on a green/red light but be recognizable as text, so a screen
reader and Braille display can convey it.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist strukturiertes Logging besser als roher Freitext? /
   **EN:** Why is structured logging better than raw free text?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Geordnete Felder lassen sich filtern, zählen und auswerten. Roher Freitext ist schwer maschinell zu
   verarbeiten und führt leicht zu übersehenen Fehlern.
   **EN:** Ordered fields can be filtered, counted, and analyzed. Raw free text is hard to process by machine
   and easily leads to overlooked errors.

   </details>

2. **DE:** (SI) Was soll ein Health-/Status-Endpunkt prüfen und zurückgeben? /
   **EN:** (SI) What should a health/status endpoint check and return?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ob der Dienst läuft und die Datenbank erreichbar ist, plus wenige Kennzahlen. Er gibt gesund/ungesund
   zurück, aber keine Interna oder Verbindungszeichenketten.
   **EN:** Whether the service runs and the database is reachable, plus a few metrics. It returns
   healthy/unhealthy but no internals or connection strings.

   </details>

3. **DE:** Warum dürfen keine Secrets in Logs oder Statusausgaben stehen? /
   **EN:** Why must no secrets appear in logs or status output?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Logs und Status sind oft breit lesbar. Ein Secret dort (z. B. Verbindungszeichenkette) ist ein
   direktes Leck, das Angreifern Zugang verschaffen kann.
   **EN:** Logs and status are often widely readable. A secret there (e.g. a connection string) is a direct
   leak that can give attackers access.

   </details>

4. **DE:** (DPA) Wie hältst du Kundendaten aus Kennzahlen heraus, ohne die Aussage zu verlieren? /
   **EN:** (DPA) How do you keep customer data out of metrics without losing the insight?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Kennzahlen zählen oder summieren (z. B. Anzahl Bestellungen, Umsatz je Zeitraum), ohne einzelne
   Kundennamen oder Adressen auszugeben. Die Aussagegrenze („nur fiktive Daten") wird benannt.
   **EN:** Metrics count or sum (e.g. number of orders, revenue per period) without printing individual
   customer names or addresses. The limit of interpretation ("fictional data only") is stated.

   </details>

5. **DE:** Was ist Log-Injection und wie verhinderst du sie? /
   **EN:** What is log injection and how do you prevent it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Angreifer schleust über ungefilterte Eingaben gefälschte Zeilen ins Protokoll. Verhinderung:
   Freitext begrenzen und bereinigen, Eingaben nicht roh loggen.
   **EN:** An attacker injects forged lines into the log via unfiltered inputs. Prevention: limit and sanitize
   free text, do not log inputs raw.

   </details>

6. **DE:** Warum sind Log-Ebenen nützlich? /
   **EN:** Why are log levels useful?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie trennen Wichtiges (error, warn) von normalem Betrieb (info). So findet man Fehler schneller und
   kann sinnvolle Alarme setzen.
   **EN:** They separate important messages (error, warn) from normal operation (info). This helps find errors
   faster and set meaningful alarms.

   </details>

7. **DE:** (DV) Warum ist die Datenbank-Erreichbarkeit Teil des Health-Checks? /
   **EN:** (DV) Why is database reachability part of the health check?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne erreichbare Datenbank kann die Plattform keine Bestellungen speichern oder auswerten. Der
   Health-Check muss diese Systemgrenze prüfen, sonst gilt der Dienst fälschlich als gesund.
   **EN:** Without a reachable database the platform cannot store or report orders. The health check must test
   this system boundary, otherwise the service is falsely considered healthy.

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

- [ ] strukturierte Log-Felder und sinnvolle Log-Ebenen festlegen.
- [ ] einen Health-/Status-Vertrag inkl. Datenbank-Erreichbarkeit beschreiben.
- [ ] wenige aussagekräftige Betriebs- und Bestellkennzahlen wählen und ihre Aussagegrenze nennen.
- [ ] begründen, warum keine Secrets und keine Klartext-Kundendaten in Logs oder Status gehören.
- [ ] Log-Injection erklären und Gegenmaßnahmen benennen.
- [ ] einen Test- oder Reviewpfad für die Beobachtbarkeit angeben.

**EN:** I can …

- [ ] define structured log fields and sensible log levels.
- [ ] describe a health/status contract including database reachability.
- [ ] choose a few meaningful operational and order metrics and state their limit of interpretation.
- [ ] justify why no secrets and no clear-text customer data belong in logs or status.
- [ ] explain log injection and name countermeasures.
- [ ] give a test or review path for observability.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-v2_08_Betrieb-Logging-Health-und-Monitoring.md`. Der Copy-Paste-Prompt für einen
späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-v2_08_Betrieb-Logging-Health-und-Monitoring.md`. The copy-paste prompt for a later,
manually started Spec Kit run is provided there.
