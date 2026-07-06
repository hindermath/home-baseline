# Lernbegleiter: Secure ServiceHarvester v2 02 – Plattformübergreifendes Dienst-Hosting und Lebenszyklus / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-v2_02_Plattformuebergreifendes-Dienst-Hosting-und-Lebenszyklus.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Dienst läuft nicht einfach im Terminal – er wird von einem **Dienst-Host** des Betriebssystems
gestartet, überwacht und gestoppt: unter Windows als **Windows-Service**, unter Linux als **systemd**-Unit,
unter macOS über **launchd**. Der Secure ServiceHarvester soll auf allen drei Plattformen laufen, aber es
wäre teuer und fehleranfällig, die Fachlogik dreimal zu schreiben. Ziel ist deshalb **ein gemeinsamer
Codepfad**: Der Dienstkern ist plattformneutral, und nur eine dünne Hosting-Schicht bindet ihn an das
jeweilige System.

**EN:** A service does not just run in the terminal – it is started, supervised, and stopped by an operating
system **service host**: on Windows as a **Windows Service**, on Linux as a **systemd** unit, on macOS via
**launchd**. The Secure ServiceHarvester should run on all three platforms, but writing the business logic
three times would be expensive and error-prone. The goal is therefore **one shared code path**: the service
core is platform-neutral, and only a thin hosting layer binds it to the respective system.

**DE:** Genauso wichtig ist der **Lebenszyklus**: Der Dienst muss sauber **starten**, dauerhaft **laufen** und
kontrolliert **stoppen**. Beim Stopp darf keine begonnene Arbeit verloren gehen; das nennt man **Graceful
Shutdown**. Dafür bekommt der Dienst ein **Abbruch-Signal** (z. B. ein `CancellationToken`), auf das er
reagiert, statt einfach hart abgebrochen zu werden.

**EN:** Just as important is the **lifecycle**: the service must **start** cleanly, **run** continuously, and
**stop** in a controlled way. On stop, no started work may be lost; this is called **graceful shutdown**. For
this the service receives a **cancellation signal** (e.g. a `CancellationToken`) that it reacts to, instead of
being killed hard.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Dienst-Host / Service host | Betriebssystem-Mechanismus, der einen Dienst startet, überwacht und stoppt. |
| Windows-Service / systemd / launchd | Die drei Ziel-Host-Umgebungen für Windows, Linux und macOS. |
| Lebenszyklus / Lifecycle | Die Phasen Start, Laufen und Stopp eines Dienstes. |
| Graceful Shutdown / Graceful shutdown | Kontrolliertes Beenden, ohne begonnene Arbeit zu verlieren. |
| Abbruch-Signal / Cancellation signal | Ein Signal (z. B. `CancellationToken`), das laufende Arbeit sauber beenden lässt. |
| Least Privilege / Least privilege | Der Dienst läuft mit den geringsten nötigen Rechten. |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Dienstkern und Hosting trennen.** Trenne die Fachlogik (sammeln, speichern,
bereitstellen) von der Anbindung an das Betriebssystem. **Warum wichtig:** Nur ein plattformneutraler Kern mit
einer dünnen Hosting-Schicht ergibt *einen* Codepfad. Sonst pflegst du drei fast gleiche, leicht
auseinanderlaufende Varianten.

**EN:** **Step 1 – Separate service core and hosting.** Separate the business logic (collect, store, provide)
from the binding to the operating system. **Why it matters:** only a platform-neutral core with a thin hosting
layer yields *one* code path. Otherwise you maintain three almost equal, slowly diverging variants.

**DE:** **Schritt 2 – Host-Mapping beschreiben.** Notiere, wie derselbe Kern in jeder Umgebung gestartet wird:
Windows-Service, systemd-Unit, launchd-Job. Halte fest, welche Startparameter, welches Arbeitsverzeichnis und
welches Benutzerkonto gelten. **Warum wichtig:** Betrieb ist plattformabhängig; die Annahmen müssen sichtbar
und vergleichbar sein.

**EN:** **Step 2 – Describe the host mapping.** Note how the same core is started in each environment: Windows
Service, systemd unit, launchd job. Record which start parameters, working directory, and user account apply.
**Why it matters:** operation is platform-dependent; the assumptions must be visible and comparable.

**DE:** **Schritt 3 – Lebenszyklus festlegen.** Beschreibe die Phasen: **Start** (Konfiguration laden,
Ressourcen öffnen), **Laufen** (Harvester in Abständen arbeiten lassen), **Stopp** (Signal empfangen, Arbeit
sauber beenden, Ressourcen schließen). **Warum wichtig:** Ein Dienst ohne klaren Lebenszyklus verliert beim
Neustart oder Update Daten oder bleibt hängen.

**EN:** **Step 3 – Define the lifecycle.** Describe the phases: **start** (load configuration, open resources),
**run** (let the harvester work at intervals), **stop** (receive signal, finish work cleanly, close
resources). **Why it matters:** a service without a clear lifecycle loses data on restart or update, or hangs.

**DE:** **Schritt 4 – Graceful Shutdown mit Abbruch-Signal planen.** Der Dienst-Host sendet beim Stopp ein
Signal. Der Dienst reicht ein **Abbruch-Signal** (z. B. `CancellationToken`) an die laufende Arbeit weiter,
beendet den aktuellen Sammelschritt geordnet und speichert, was er kann. Plane ein **Timeout**: Reagiert der
Dienst nicht rechtzeitig, wird er härter beendet. **Warum wichtig:** Ein harter Abbruch mitten im Schreiben
kann Daten beschädigen (Integrität).

**EN:** **Step 4 – Plan graceful shutdown with a cancellation signal.** The service host sends a signal on
stop. The service passes a **cancellation signal** (e.g. `CancellationToken`) to the running work, finishes
the current collection step in an orderly way, and saves what it can. Plan a **timeout**: if the service does
not react in time, it is stopped more harshly. **Why it matters:** a hard abort in the middle of a write can
corrupt data (integrity).

**DE:** **Schritt 5 – Least Privilege und Betriebsannahmen trennen.** Der Dienst soll mit möglichst geringen
Rechten laufen (kein Administrator, nur nötige Datei- und Netzrechte). Trenne Sicherheits-, Datenschutz- und
Betriebsannahmen und gib je positiver Sicherheitsaussage einen Nachweispfad (z. B. Shutdown-Test,
Rechte-Review). **Warum wichtig:** Ein Dienst läuft dauerhaft; überhöhte Rechte vergrößern den Schaden bei
einem Fehler.

**EN:** **Step 5 – Separate least privilege and operational assumptions.** The service should run with the
least possible rights (no administrator, only necessary file and network rights). Separate security, privacy,
and operational assumptions and give each positive security claim an evidence path (e.g. shutdown test, rights
review). **Why it matters:** a service runs continuously; excessive rights enlarge the damage on a fault.

**DE:** **Typische Fehler.** Die Fachlogik je Plattform kopieren. Den Dienst nur im Terminal denken, ohne
Dienst-Host. Beim Stopp hart abbrechen und Daten riskieren. Kein Abbruch-Signal weiterreichen. Den Dienst als
Administrator laufen lassen. Betriebsannahmen nicht aufschreiben.

**EN:** **Common mistakes.** Copying the business logic per platform. Thinking of the service only in the
terminal, without a service host. Aborting hard on stop and risking data. Not passing a cancellation signal.
Running the service as administrator. Not writing down operational assumptions.

### Beispiel / Example

```text
Ein Codepfad, drei Hosts:

  [Dienstkern: sammeln/speichern/bereitstellen]  (plattformneutral)
        ^                    ^                    ^
   [Windows-Service]     [systemd-Unit]       [launchd-Job]   (duenne Hosting-Schicht)

Lebenszyklus:
  Start   -> Konfiguration laden, Store oeffnen, Harvester und API starten
  Laufen  -> Harvester sammelt im Intervall; API antwortet lesend
  Stopp   -> Signal empfangen -> CancellationToken setzen -> aktuellen Schritt geordnet beenden
             -> speichern -> Ressourcen schliessen -> beenden

Graceful Shutdown:
  Signal empfangen        -> laufender Sammelschritt darf zu Ende gehen (bis Timeout)
  Timeout ueberschritten  -> kontrollierter harter Stopp, Zustand bleibt konsistent
  Nachweis                -> Shutdown-Test: Stopp-Signal -> kein Datenverlust, kein Haengen

Betrieb (Least Privilege):
  laeuft als eigener Dienstnutzer, KEIN Administrator
  nur noetige Datei- und Netzrechte
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 9 Netzwerke und Dienste bereitstellen | Primär / Primary | Dienst-Hosting, Lebenszyklus und plattformübergreifender Betrieb sind der Kern der Dienstbereitstellung. |
| LF 6 Serviceanfragen bearbeiten | Berührt / Touched | Ein sauber startender und stoppender Dienst ist Voraussetzung, um Serviceanfragen zuverlässig zu bedienen. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: sichere Architektur, sichere Programmierung, Least
Privilege, Fail-Safe-Defaults und auditfähige Nachweise. Passende Checklisten: `CL_01`
(Standards-Anwendbarkeit), `CL_02` (sichere Programmierung), `CL_03` (sichere Architektur), `CL_08`
(Sicherheits-Code-Review) und `CL_12` (Nachweise/N/A-Begründung). Die Sicherheitsentscheidung dieser Einheit
lautet: *Der Dienst läuft mit minimalen Rechten und beendet sich auf Signal geordnet, bevor Arbeit verloren
geht.* A11Y-Aspekt: Lebenszyklus- und Host-Tabellen müssen als klarer Text lesbar sein, ohne reine
Farbmarkierung, damit Screenreader- und Braille-Nutzende die Phasen und Host-Umgebungen erfassen.

**EN:** Relation to the Secure Development Guideline: secure architecture, secure coding, least privilege,
fail-safe defaults, and auditable evidence. Matching checklists: `CL_01` (standards applicability), `CL_02`
(secure coding), `CL_03` (secure architecture), `CL_08` (security code review), and `CL_12` (evidence / N/A
rationale). The security decision of this unit is: *the service runs with minimal rights and stops in an
orderly way on a signal before work is lost.* Accessibility aspect: lifecycle and host tables must be readable
as clear text, without color-only marking, so screen-reader and Braille users grasp the phases and host
environments.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Warum ist ein gemeinsamer Codepfad für Windows-Service, systemd und launchd besser als drei
   Varianten? / **EN:** Why is one shared code path for Windows Service, systemd, and launchd better than three
   variants?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein plattformneutraler Kern mit dünner Hosting-Schicht wird nur einmal gepflegt und getestet. Drei
   Varianten laufen langsam auseinander, verursachen doppelte Fehler und erschweren Sicherheit und Wartung.
   **EN:** A platform-neutral core with a thin hosting layer is maintained and tested only once. Three variants
   slowly diverge, cause duplicate bugs, and make security and maintenance harder.

   </details>

2. **DE:** Was bedeutet Graceful Shutdown, und warum ist er wichtig? /
   **EN:** What does graceful shutdown mean, and why is it important?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Dienst beendet auf ein Stopp-Signal die begonnene Arbeit geordnet und speichert, was er kann,
   statt hart abzubrechen. Das verhindert Datenverlust und beschädigte, halb geschriebene Daten (Integrität).
   **EN:** On a stop signal the service finishes started work in an orderly way and saves what it can, instead
   of aborting hard. This prevents data loss and corrupted, half-written data (integrity).

   </details>

3. **DE:** (SI) Warum soll der Dienst mit möglichst geringen Rechten laufen, und wie weist man das nach? /
   **EN:** (SI) Why should the service run with the least possible rights, and how do you evidence it?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein dauerhaft laufender Dienst mit überhöhten Rechten vergrößert den Schaden bei einem Fehler oder
   Angriff. Least Privilege begrenzt ihn. Nachweis: ein Rechte-Review, das das Dienstkonto und die vergebenen
   Datei- und Netzrechte dokumentiert.
   **EN:** A continuously running service with excessive rights enlarges the damage on a fault or attack. Least
   privilege limits it. Evidence: a rights review documenting the service account and the granted file and
   network rights.

   </details>

4. **DE:** (AE) Wie reicht man ein Abbruch-Signal (z. B. `CancellationToken`) an die laufende Arbeit weiter? /
   **EN:** (AE) How do you pass a cancellation signal (e.g. `CancellationToken`) to the running work?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Der Dienst empfängt das Stopp-Signal des Hosts und gibt ein Abbruch-Signal an den laufenden
   Sammelschritt weiter. Die Arbeit prüft es an geeigneten Stellen und beendet sich geordnet, statt eine
   Operation mitten im Schreiben abzubrechen.
   **EN:** The service receives the host's stop signal and passes a cancellation signal to the running
   collection step. The work checks it at suitable points and finishes in an orderly way, instead of aborting an
   operation mid-write.

   </details>

5. **DE:** (DPA) Warum kann ein harter Abbruch mitten im Speichern ein Datenschutz- und Datenqualitätsproblem
   sein? / **EN:** (DPA) Why can a hard abort mid-save be a privacy and data-quality problem?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Halb geschriebene Datensätze können widersprüchlich oder unvollständig sein und zu falschen
   Auswertungen führen. Bei personenbezogenen Bezügen kann ein inkonsistenter Zustand zudem die Nachvollziehbar-
   keit und Löschung erschweren.
   **EN:** Half-written records can be inconsistent or incomplete and lead to wrong analysis. With personal
   references, an inconsistent state can also hinder traceability and deletion.

   </details>

6. **DE:** (DV) Welche Kommunikations- oder Betriebsannahme unterscheidet sich zwischen den drei Host-Umgebungen?
   / **EN:** (DV) Which communication or operational assumption differs between the three host environments?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Startparameter, Arbeitsverzeichnis, Dienstkonto und das Stopp-Signal werden je Host unterschiedlich
   geliefert (Windows-Service, systemd, launchd). Der plattformneutrale Kern muss dieselbe Bedeutung aus
   unterschiedlichen Quellen verarbeiten.
   **EN:** Start parameters, working directory, service account, and the stop signal are delivered differently
   per host (Windows Service, systemd, launchd). The platform-neutral core must process the same meaning from
   different sources.

   </details>

7. **DE:** Warum braucht ein Graceful Shutdown zusätzlich ein Timeout? /
   **EN:** Why does a graceful shutdown additionally need a timeout?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ohne Timeout könnte ein hängender Sammelschritt den Stopp blockieren. Das Timeout erlaubt geordnetes
   Beenden bis zu einer Grenze und danach einen kontrollierten harten Stopp, der den Zustand konsistent lässt.
   **EN:** Without a timeout a hanging collection step could block the stop. The timeout allows orderly
   finishing up to a limit and then a controlled hard stop that keeps the state consistent.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] den plattformneutralen Dienstkern von der Hosting-Schicht trennen.
- [ ] das Host-Mapping für Windows-Service, systemd und launchd beschreiben.
- [ ] den Lebenszyklus in Start, Laufen und Stopp gliedern.
- [ ] einen Graceful Shutdown mit Abbruch-Signal und Timeout planen.
- [ ] Least-Privilege- und Betriebsannahmen mit Nachweispfad benennen.

**EN:** I can …

- [ ] separate the platform-neutral service core from the hosting layer.
- [ ] describe the host mapping for Windows Service, systemd, and launchd.
- [ ] structure the lifecycle into start, run, and stop.
- [ ] plan a graceful shutdown with a cancellation signal and a timeout.
- [ ] name least-privilege and operational assumptions with an evidence path.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-v2_02_Plattformuebergreifendes-Dienst-Hosting-und-Lebenszyklus.md`. Der
Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-v2_02_Plattformuebergreifendes-Dienst-Hosting-und-Lebenszyklus.md`. The
copy-paste prompt for a later, manually started Spec Kit run is provided there.
