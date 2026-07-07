# Lernbegleiter: Secure OrderDesk v2 02 – Plattformübergreifendes Hosting und Lebenszyklus / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-v2_02_Plattformuebergreifendes-Hosting-und-Lebenszyklus.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Der Secure OrderDesk soll nicht nur auf einem Laptop laufen, sondern als **dauerhaft betriebener Dienst** – auf Windows als Windows-Service, auf Linux mit **systemd**, auf macOS mit **launchd**. Statt drei getrennter Programme baust du **einen gemeinsamen Codepfad**, der auf allen drei Host-Umgebungen startet, läuft und stoppt. Der **Lebenszyklus** (Start, Laufen, Stopp) und besonders das **saubere Beenden (Graceful Shutdown)** stehen im Mittelpunkt: Wenn der Dienst gestoppt wird, während gerade eine Bestellung von `ALFKI` angenommen wird, darf diese Arbeit nicht halb ausgeführt zurückbleiben.

**EN:** The Secure OrderDesk should run not only on a laptop but as a **continuously operated service** – on Windows as a Windows Service, on Linux with **systemd**, on macOS with **launchd**. Instead of three separate programs you build **one shared code path** that starts, runs, and stops on all three host environments. The **lifecycle** (start, run, stop) and especially the **clean stop (graceful shutdown)** are central: if the service is stopped while an order from `ALFKI` is being accepted, that work must not remain half-executed.

**DE:** Das Werkzeug für sauberes Beenden ist ein **Abbruch-Signal** (in .NET z. B. `CancellationToken`, in Go `context.Context`, anderswo ein Flag oder Signal-Handler). Die Fachlogik prüft dieses Signal an sicheren Stellen und schließt begonnene Arbeit ab oder rollt sie zurück.

**EN:** The tool for a clean stop is a **cancellation signal** (in .NET e.g. `CancellationToken`, in Go `context.Context`, elsewhere a flag or signal handler). The business logic checks this signal at safe points and completes started work or rolls it back.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Dienst / Service | Programm, das dauerhaft im Hintergrund läuft und vom Betriebssystem verwaltet wird. |
| Gemeinsamer Codepfad / Shared code path | Eine Codebasis, die auf mehreren Host-Umgebungen ohne Fork läuft. |
| Windows-Service / systemd / launchd | Die drei Host-Mechanismen für Dienste auf Windows, Linux und macOS. |
| Lebenszyklus / Lifecycle | Die Phasen Start, Laufen und Stopp eines Dienstes. |
| Graceful Shutdown / Graceful shutdown | Sauberes Beenden ohne halbe Arbeit oder Datenverlust. |
| Abbruch-Signal / Cancellation signal | Signal (z. B. CancellationToken), das laufende Arbeit geordnet beendet. |
| Least Privilege / Least privilege | Der Dienst läuft mit den minimal nötigen Rechten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Einen Codepfad, drei Hosts.** Trenne die **Fachlogik** (Bestellannahme, Store-Zugriff) vom **Host-Adapter**. Der Adapter meldet den Dienst je Plattform an (Windows-Service, systemd-Unit, launchd-plist), ruft aber dieselbe Start-/Stopp-Logik auf. **Warum wichtig:** Ein gemeinsamer Codepfad verhindert, dass sich drei Varianten auseinanderentwickeln und Sicherheitsfixes nur an einer Stelle landen.

**EN:** **Step 1 – One code path, three hosts.** Separate the **business logic** (order intake, store access) from the **host adapter**. The adapter registers the service per platform (Windows Service, systemd unit, launchd plist) but calls the same start/stop logic. **Why it matters:** a shared code path prevents three variants from drifting apart and security fixes from landing in only one place.

**DE:** **Schritt 2 – Lebenszyklus beschreiben.** Halte fest, was bei **Start** passiert (Konfiguration laden, Store verbinden), was im **Laufen** passiert (Bestellungen annehmen, API bedienen) und was beim **Stopp** passiert (keine neuen Bestellungen annehmen, laufende abschließen). **Warum wichtig:** Ein klarer Lebenszyklus macht das Verhalten vorhersehbar und testbar.

**EN:** **Step 2 – Describe the lifecycle.** Record what happens on **start** (load configuration, connect store), during **run** (accept orders, serve API), and on **stop** (accept no new orders, finish running ones). **Why it matters:** a clear lifecycle makes behaviour predictable and testable.

**DE:** **Schritt 3 – Graceful Shutdown planen.** Beim Stoppsignal: erst die Annahme neuer Bestellungen stoppen, dann laufende Datenbanktransaktionen sauber abschließen oder zurückrollen, dann Ressourcen (Verbindungen, Dateien) freigeben. **Warum wichtig:** Ein hartes Beenden mitten in einer Transaktion kann zu einer halben Bestellung führen – ein `Order`-Kopf ohne Positionen oder eine doppelte Buchung.

**EN:** **Step 3 – Plan graceful shutdown.** On the stop signal: first stop accepting new orders, then cleanly finish or roll back running database transactions, then release resources (connections, files). **Why it matters:** a hard stop in the middle of a transaction can lead to a half order – an `Order` header without lines or a double booking.

**DE:** **Schritt 4 – Abbruch-Signal verdrahten.** Reiche das Abbruch-Signal von außen (Betriebssystem-Stopp) bis in die Fachlogik durch. Prüfe es an sicheren Stellen (zwischen zwei Bestellungen, nicht mitten in einem `INSERT`). **Warum wichtig:** Nur wenn die Logik das Signal kennt, kann sie geordnet beenden.

**EN:** **Step 4 – Wire the cancellation signal.** Pass the cancellation signal from outside (operating-system stop) down into the business logic. Check it at safe points (between two orders, not in the middle of an `INSERT`). **Why it matters:** only if the logic knows the signal can it stop in an orderly way.

**DE:** **Schritt 5 – Betriebsrechte minimieren.** Der Dienst läuft unter einem eigenen Betriebskonto mit minimalen Rechten (Least Privilege): nur der nötige Datenbankzugriff, nur die nötigen Dateipfade, kein Administrator. **Warum wichtig:** Wird der Dienst kompromittiert, bleibt der Schaden begrenzt.

**EN:** **Step 5 – Minimize operating rights.** The service runs under its own operating account with minimal rights (least privilege): only the necessary database access, only the necessary file paths, no administrator. **Why it matters:** if the service is compromised, the damage stays limited.

**DE:** **Typische Fehler.** Drei getrennte Programme statt eines Codepfads. Hartes `kill` ohne Graceful Shutdown. Das Abbruch-Signal nicht bis in die Fachlogik durchreichen. Den Dienst als Administrator/root laufen lassen. Secrets in der systemd-Unit oder plist im Klartext ablegen.

**EN:** **Common mistakes.** Three separate programs instead of one code path. A hard `kill` without graceful shutdown. Not passing the cancellation signal down into the business logic. Running the service as administrator/root. Storing secrets in cleartext in the systemd unit or plist.

### Beispiel / Example

```text
Ein Codepfad, drei Hosts:

  [Windows-Service] --\
  [systemd-Unit]    ---> [Host-Adapter] --> [gemeinsame Start/Stopp-Logik] --> [Bestellannahme + Store]
  [launchd-plist]   --/

Lebenszyklus:
  Start:  Konfiguration laden, Store verbinden (Verbindungszeichenkette = <PLATZHALTER-KEIN-ECHTER-WERT>)
  Laufen: Bestellungen annehmen (z. B. fuer ALFKI), API bedienen
  Stopp:  Signal empfangen -> keine neuen Bestellungen -> laufende Transaktion abschliessen/rollback -> Ressourcen frei

Graceful-Shutdown-Test:
  1. Bestellung fuer ALFKI starten
  2. Stoppsignal senden, waehrend die Bestellung laeuft
  3. Erwartung: entweder ganze Bestellung gespeichert ODER sauber zurueckgerollt, nie halb
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 9 Netzwerke und Dienste bereitstellen | Primär / Primary | Der OrderDesk wird als plattformübergreifender Dienst mit klarem Lebenszyklus bereitgestellt. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Start, Stopp und Graceful Shutdown sind wiederkehrende Betriebs-/Serviceanfragen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, sichere Programmierung, Least Privilege und auditfähige Betriebsnachweise. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_02` (sichere Konfiguration), `CL_03` (sichere Architektur), `CL_08` (Sicherheits-Code-Review) und `CL_12` (Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit lautet: *Kein Stopp verliert oder halbt begonnene Bestellarbeit, und der Dienst läuft mit minimalen Rechten.* A11Y-Aspekt: Beschreibe Host-Mapping und Lebenszyklus als Text-Tabelle statt als reines Diagramm; nutze klare Statuswörter (Start/Laufen/Stopp) statt farbiger Symbole, damit Screenreader und Braille-Zeile alles erfassen.

**EN:** Relation to the Secure Development Guideline: secure architecture, secure programming, least privilege, and auditable operational evidence. Matching checklists: `CL_01` (standards applicability), `CL_02` (secure configuration), `CL_03` (secure architecture), `CL_08` (security code review), and `CL_12` (evidence / N/A rationale). The security decision of this unit is: *no stop loses or halves started order work, and the service runs with minimal rights.* Accessibility aspect: describe the host mapping and lifecycle as a text table instead of a pure diagram; use clear status words (start/run/stop) instead of colored symbols so a screen reader and Braille display can grasp everything.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum baut man einen gemeinsamen Codepfad statt drei getrennter Dienstprogramme? /
   **EN:** Why build one shared code path instead of three separate service programs?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Codepfad verhindert, dass sich drei Varianten auseinanderentwickeln. Sicherheitsfixes und Fachlogik bleiben an einer Stelle; nur der dünne Host-Adapter unterscheidet sich je Plattform.
   **EN:** One code path prevents three variants from drifting apart. Security fixes and business logic stay in one place; only the thin host adapter differs per platform.

   </details>

2. **DE:** Was kann bei einem harten Stopp mitten in einer Bestelltransaktion passieren? /
   **EN:** What can happen on a hard stop in the middle of an order transaction?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Es kann eine halbe Bestellung entstehen – z. B. ein `Order`-Kopf ohne Positionen oder eine doppelte Buchung. Graceful Shutdown schließt die Transaktion ab oder rollt sie sauber zurück.
   **EN:** A half order can result – e.g. an `Order` header without lines or a double booking. Graceful shutdown finishes the transaction or rolls it back cleanly.

   </details>

3. **DE:** (AE) Wo im Code prüft man das Abbruch-Signal sinnvoll? /
   **EN:** (AE) Where in the code do you sensibly check the cancellation signal?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** An sicheren Stellen zwischen abgeschlossenen Arbeitsschritten (z. B. zwischen zwei Bestellungen), nicht mitten in einem `INSERT` oder einer offenen Transaktion. So endet die Arbeit in einem konsistenten Zustand.
   **EN:** At safe points between completed work steps (e.g. between two orders), not in the middle of an `INSERT` or open transaction. This way work ends in a consistent state.

   </details>

4. **DE:** (SI) Warum läuft der Dienst nicht als Administrator/root? /
   **EN:** (SI) Why does the service not run as administrator/root?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Least Privilege begrenzt den Schaden bei einer Kompromittierung. Der Dienst braucht nur den nötigen Datenbankzugriff und die nötigen Pfade, nicht volle Systemrechte.
   **EN:** Least privilege limits the damage on compromise. The service only needs the necessary database access and paths, not full system rights.

   </details>

5. **DE:** (DV) Welche Nachbarn braucht der Dienst zur Laufzeit, die in den Betrieb gehören? /
   **EN:** (DV) Which runtime neighbours does the service need that belong to operations?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Eine Konfigurationsquelle, ein Logziel und eine Datenbankverbindung. Diese Kommunikationswege müssen benannt und abgesichert sein; die Verbindungszeichenkette bleibt ein Secret (`<PLATZHALTER-KEIN-ECHTER-WERT>`).
   **EN:** A configuration source, a log target, and a database connection. These communication paths must be named and secured; the connection string stays a secret (`<PLATZHALTER-KEIN-ECHTER-WERT>`).

   </details>

6. **DE:** (DPA) Warum ist ein reproduzierbarer Shutdown-Test für die Datenqualität wichtig? /
   **EN:** (DPA) Why is a reproducible shutdown test important for data quality?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Halbe Bestellungen verfälschen später Umsatz- und Bestellkennzahlen. Ein wiederholbarer Test zeigt, dass ein Stopp entweder die ganze Bestellung speichert oder gar keine – die Datenbasis bleibt konsistent.
   **EN:** Half orders later distort revenue and order metrics. A repeatable test shows that a stop either saves the whole order or none – the data base stays consistent.

   </details>

7. **DE:** Warum darf man die Framework-/Host-Wahl nicht ohne Begründung treffen? /
   **EN:** Why must the framework/host choice not be made without a rationale?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Die Lösung soll für alle sechs Sprachen vergleichbar bleiben. Eine begründete Wahl macht Folgen und Alternativen sichtbar und verhindert eine versteckte Bindung an ein Werkzeug.
   **EN:** The solution must stay comparable across all six languages. A justified choice makes consequences and alternatives visible and prevents a hidden lock-in to one tool.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] einen gemeinsamen Codepfad für Windows-Service, systemd und launchd beschreiben.
- [ ] den Lebenszyklus Start/Laufen/Stopp des OrderDesk benennen.
- [ ] Graceful Shutdown mit einem Abbruch-Signal erklären.
- [ ] einen Shutdown-Test mit einer laufenden Bestellung skizzieren.
- [ ] Least-Privilege-Betriebsannahmen für den Dienst nennen.

**EN:** I can …

- [ ] describe one shared code path for Windows Service, systemd, and launchd.
- [ ] name the start/run/stop lifecycle of the OrderDesk.
- [ ] explain graceful shutdown with a cancellation signal.
- [ ] sketch a shutdown test with a running order.
- [ ] name least-privilege operating assumptions for the service.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft `Lastenheft_Secure-OrderDesk-v2_02_Plattformuebergreifendes-Hosting-und-Lebenszyklus.md`. Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake `Lastenheft_Secure-OrderDesk-v2_02_Plattformuebergreifendes-Hosting-und-Lebenszyklus.md`. The copy-paste prompt for a later, manually started Spec Kit run is provided there.
