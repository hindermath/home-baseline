# Lernbegleiter: Secure OrderDesk Operations Track 02 – Datenbank-Deployment (Windows-Service, systemd, launchd) / Study Companion

**Stand / Date:** 2026-07-07
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-OrderDesk-Operations-Track_02_Datenbank-Deployment.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Eine Datenbank zu starten ist nicht dasselbe wie einen **Datenbank-Dienst zu betreiben**. Ein Dienst
muss beim Systemstart automatisch anlaufen, nach einem Absturz neu starten, auf ein Stopp-Signal sauber
beenden (mit Checkpoint, damit keine Bestellung verloren geht) und unter einem eigenen, rechtearmen Konto
laufen. Jedes Betriebssystem hat dafür einen eigenen Mechanismus: auf Windows den **Windows-Service** (Service
Control Manager), auf Linux **`systemd`** (Unit-Dateien), auf macOS **`launchd`** (Agents/Daemons). Als
Systemintegrator*in bringst du denselben Datenbank-Dienst der Secure-OrderDesk-Plattform auf allen drei
Plattformen vergleichbar in Betrieb.

**EN:** Starting a database is not the same as **operating a database service**. A service must start
automatically at system boot, restart after a crash, stop cleanly on a stop signal (with a checkpoint so no
order is lost), and run under its own low-privilege account. Each operating system has its own mechanism for
this: on Windows the **Windows service** (Service Control Manager), on Linux **`systemd`** (unit files), on
macOS **`launchd`** (agents/daemons). As a system integrator you bring the same database service of the Secure
OrderDesk platform into operation comparably on all three platforms.

**DE:** In dieser Einheit lernst du, den Lebenszyklus eines Datenbank-Dienstes je Plattform zu beschreiben,
Autostart und Neustart zu konfigurieren, das saubere Beenden (Graceful Shutdown mit Checkpoint) nachzuweisen
und einen dedizierten Datenbank-Dienstbenutzer mit minimalen Rechten festzulegen. Die Northwind-Datenbasis
inkl. `ALFKI` bleibt der fachliche Datenanker.

**EN:** In this unit you learn to describe a database service's lifecycle per platform, to configure autostart
and restart, to evidence graceful shutdown with a checkpoint, and to define a dedicated database service
account with minimal rights. The Northwind data base including `ALFKI` stays the functional data anchor.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Datenbank-Dienst / Database service | Programm, das die Datenbank dauerhaft im Hintergrund bereitstellt und vom Betriebssystem verwaltet wird. |
| Windows-Service / Windows service | Vom Service Control Manager verwalteter Hintergrunddienst auf Windows. |
| systemd-Unit / systemd unit | Konfigurationsdatei, die einen Dienst unter Linux beschreibt und steuert. |
| launchd-Agent/Daemon | Von macOS `launchd` verwalteter Hintergrundprozess (nutzerbezogen oder systemweit). |
| Graceful Shutdown / Graceful shutdown | Geordnetes Beenden auf ein Stopp-Signal mit Checkpoint/Flush, ohne Datenverlust oder Hängenbleiben. |
| Dienstbenutzer / Service account | Eigenes Konto mit minimalen Rechten, unter dem der Datenbank-Dienst läuft (Least Privilege). |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Lebenszyklus verstehen.** Jeder Dienst hat dieselben Phasen: installieren, starten,
laufen, stoppen, deinstallieren. Beschreibe diese Phasen einmal fachlich und ordne dann je Plattform den
konkreten Mechanismus zu. So bleibt der Betrieb vergleichbar, obwohl die Werkzeuge verschieden sind.

**EN:** **Step 1 – Understand the lifecycle.** Every service has the same phases: install, start, run, stop,
uninstall. Describe these phases once functionally, then map the concrete mechanism per platform. This keeps
operation comparable although the tools differ.

**DE:** **Schritt 2 – Autostart und Neustart konfigurieren.** Der Datenbank-Dienst soll beim Systemstart
automatisch laufen und nach einem Absturz neu starten. Windows: Starttyp „Automatisch" und
Wiederherstellungsaktionen; `systemd`: `WantedBy` plus `Restart=on-failure`; `launchd`: `RunAtLoad` plus
`KeepAlive`. Begründe je Plattform, warum dein Neustartverhalten zum Verfügbarkeits-SLO aus Einheit 01 passt.

**EN:** **Step 2 – Configure autostart and restart.** The database service should run automatically at boot
and restart after a crash. Windows: start type "Automatic" and recovery actions; `systemd`: `WantedBy` plus
`Restart=on-failure`; `launchd`: `RunAtLoad` plus `KeepAlive`. Justify per platform why your restart behavior
matches the availability SLO from unit 01.

**DE:** **Schritt 3 – Graceful Shutdown mit Checkpoint nachweisen.** Auf ein Stopp-Signal (Windows:
Stop-Kommando; Linux/macOS: `SIGTERM`) muss der Datenbank-Dienst laufende Transaktionen sauber abschließen
oder zurückrollen, einen Checkpoint schreiben (Puffer auf Platte) und sich beenden. Weise das mit einem
Shutdown-Test nach: Signal senden, prüfen, dass keine bestätigte Bestellung verloren geht und der Prozess
innerhalb einer definierten Zeit endet.

**EN:** **Step 3 – Evidence graceful shutdown with a checkpoint.** On a stop signal (Windows: stop command;
Linux/macOS: `SIGTERM`) the database service must finish or roll back running transactions cleanly, write a
checkpoint (flush buffers to disk), and exit. Evidence this with a shutdown test: send the signal, check that
no confirmed order is lost and the process ends within a defined time.

**DE:** **Schritt 4 – Dienstbenutzer und Rechte minimieren.** Der Datenbank-Dienst läuft nicht als
Administrator oder root, sondern unter einem dedizierten Konto mit genau den Rechten, die er braucht (Least
Privilege). Prüfe Datei- und Datenverzeichnisrechte, Zugriff auf die Datendateien und ob überhaupt Netzrechte
nötig sind. Dokumentiere je Plattform, welches Konto und welche Rechte gelten.

**EN:** **Step 4 – Minimize service account and rights.** The database service does not run as administrator
or root but under a dedicated account with exactly the rights it needs (least privilege). Check file and data
directory permissions, access to the data files, and whether network rights are needed at all. Document per
platform which account and which rights apply.

**DE:** **Typische Fehler.** Den Datenbank-Dienst mit Administrator-/root-Rechten laufen lassen. Autostart
vergessen, sodass der Dienst nach einem Reboot stillsteht. Kein sauberer Checkpoint, sodass Transaktionen
abrupt abbrechen. Plattformen ungleich behandeln, sodass ein System heimlich schwächer konfiguriert ist.
Deployment nur „von Hand" ohne dokumentierte, wiederholbare Schritte.

**EN:** **Common mistakes.** Running the database service with administrator/root rights. Forgetting autostart
so the service stays down after a reboot. No clean checkpoint so transactions abort abruptly. Treating
platforms unequally so one system is silently weaker. Deploying only "by hand" without documented, repeatable
steps.

### Beispiel / Example

```text
Phase        | Windows-Service        | systemd                    | launchd
-------------|------------------------|----------------------------|---------------------------
Installieren | sc create / Service-API| Unit-Datei nach /etc/...   | plist nach LaunchDaemons
Autostart    | Starttyp "Automatisch" | WantedBy=multi-user.target | RunAtLoad=true
Neustart     | Recovery-Aktionen      | Restart=on-failure         | KeepAlive=true
Stoppen      | Stop-Kommando          | SIGTERM (Graceful+Checkp.) | SIGTERM (Graceful+Checkp.)
Dienstkonto  | dediziert, rechtearm   | User=svc-orderdesk-db      | UserName=svc-orderdesk-db
Nachweis     | Shutdown-/Checkpoint-/Autostart-Test dokumentiert; keine Admin-/root-Rechte ohne Begründung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Abschnitt „Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primäre LF 10b, 11b, 12b;
berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
section "Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primary LF 10b, 11b, 12b;
touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10b Serverdienste bereitstellen und Administrationsaufgaben automatisieren | Primär / Primary | Der Datenbank-Dienst wird plattformgerecht installiert, automatisiert gestartet und verwaltet. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Der Datenbank-Dienst wird als betriebener Dienst auf einem Zielhost bereitgestellt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Least Privilege, Fail-Safe Defaults und auditfähige
Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05` (Zugangssteuerung/Rechte), `CL_08`
(Sicherheits-Review) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Der
Datenbank-Dienst läuft rechtearm, startet und stoppt kontrolliert mit Checkpoint, und jedes Verhalten wird
nachgewiesen.* A11Y-Aspekt: Die Deployment-Matrix muss als Text-Tabelle mit gleich breiten Spalten lesbar
sein, nicht nur als Screenshot, damit sie mit Screenreader und Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: least privilege, fail-safe defaults, and audit-ready
evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (access control/rights), `CL_08`
(security review), and `CL_12` (documentation/N-A). The security decision of this unit is: *the database
service runs low-privilege, starts and stops in a controlled way with a checkpoint, and every behavior is
evidenced.* Accessibility aspect: the deployment matrix must be readable as a text table with equal-width
columns, not only as a screenshot, so it stays usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet einen betriebenen Datenbank-Dienst von einer einfach gestarteten Datenbank? /
   **EN:** What distinguishes an operated database service from a simply started database?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Dienst wird vom Betriebssystem verwaltet: Er startet automatisch beim Boot, startet nach einem
   Absturz neu, beendet auf ein Stopp-Signal sauber mit Checkpoint und läuft unter einem eigenen Konto. Eine
   einfach gestartete Datenbank hat diese Betriebseigenschaften nicht.
   **EN:** A service is managed by the operating system: it starts automatically at boot, restarts after a
   crash, stops cleanly with a checkpoint on a stop signal, and runs under its own account. A simply started
   database does not have these operational properties.

   </details>

2. **DE:** (SI) Warum konfiguriert man denselben Datenbank-Dienst auf Windows, `systemd` und `launchd` vergleichbar? /
   **EN:** (SI) Why do you configure the same database service comparably on Windows, `systemd`, and `launchd`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Damit kein System heimlich schwächer oder anders läuft. Vergleichbare Autostart-, Neustart- und
   Shutdown-Regeln machen den Betrieb vorhersehbar und prüfbar, unabhängig vom Zielhost. Die Werkzeuge
   unterscheiden sich, die Betriebseigenschaften sollen gleich sein.
   **EN:** So that no system runs secretly weaker or differently. Comparable autostart, restart, and shutdown
   rules make operation predictable and verifiable regardless of the target host. The tools differ, but the
   operational properties should be equal.

   </details>

3. **DE:** (SI) Warum soll der Datenbank-Dienst nicht mit Administrator- oder root-Rechten laufen? /
   **EN:** (SI) Why should the database service not run with administrator or root rights?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nach dem Least-Privilege-Prinzip soll ein Prozess nur die Rechte haben, die er braucht. Läuft der
   Dienst mit vollen Rechten, kann ein Fehler oder Angriff das ganze System und alle Kundendaten
   kompromittieren. Ein rechtearmes Dienstkonto begrenzt den möglichen Schaden.
   **EN:** By the least-privilege principle a process should only have the rights it needs. If the service
   runs with full rights, an error or attack can compromise the whole system and all customer data. A
   low-privilege service account limits the possible damage.

   </details>

4. **DE:** Wie weist man Graceful Shutdown mit Checkpoint nach? /
   **EN:** How do you evidence graceful shutdown with a checkpoint?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einem Shutdown-Test: Man sendet das Stopp-Signal und prüft, dass laufende Transaktionen
   geordnet abgeschlossen oder zurückgerollt werden, ein Checkpoint geschrieben wird, keine bestätigte
   Bestellung verloren geht und der Prozess innerhalb einer definierten Zeit endet. Das Ergebnis wird
   dokumentiert.
   **EN:** With a shutdown test: send the stop signal and check that running transactions finish or roll back
   in an orderly way, a checkpoint is written, no confirmed order is lost, and the process ends within a
   defined time. The result is documented.

   </details>

5. **DE:** (DV) Welche Netz- oder Firewall-Annahme kann der Start des Datenbank-Ports auf dem Zielhost berühren? /
   **EN:** (DV) Which network or firewall assumption can starting the database port touch on the target host?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn der Datenbank-Dienst einen Port öffnet, müssen Firewall-Regeln entscheiden, wer darauf
   zugreifen darf. Man dokumentiert, welcher Port nötig ist, bindet ihn möglichst nur an localhost oder ein
   internes Netz und prüft, ob externer Zugriff überhaupt gebraucht wird. Unnötige Netzflächen bleiben zu.
   **EN:** If the database service opens a port, firewall rules must decide who may access it. You document
   which port is needed, bind it preferably only to localhost or an internal network, and check whether
   external access is needed at all. Unnecessary network surfaces stay closed.

   </details>

6. **DE:** (AE) Was muss die Datenzugriffsschicht der Plattform beim Dienst-Deployment unterstützen? /
   **EN:** (AE) What must the platform's data access layer support during service deployment?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Sie muss sich sauber mit dem Datenbank-Dienst verbinden, Verbindungen aus einem Pool wieder
   freigeben, ein Stopp-Signal geordnet verarbeiten (Cancellation, offene Transaktionen abschließen) und ohne
   Datenverlust enden. So wird die fachliche Bestell-Logik betriebsfähig.
   **EN:** It must connect cleanly to the database service, return connections to a pool, process a stop signal
   in an orderly way (cancellation, finishing open transactions), and end without data loss. This makes the
   functional order logic operational.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] den Lebenszyklus eines Datenbank-Dienstes fachlich und je Plattform beschreiben.
- [ ] Autostart und Neustart für Windows-Service, `systemd` und `launchd` konfigurieren.
- [ ] Graceful Shutdown mit Checkpoint durch einen Test nachweisen.
- [ ] einen dedizierten, rechtearmen Datenbank-Dienstbenutzer je Plattform festlegen.
- [ ] Deployment-Schritte wiederholbar und vergleichbar dokumentieren.

**EN:** I can …

- [ ] describe a database service's lifecycle functionally and per platform.
- [ ] configure autostart and restart for Windows service, `systemd`, and `launchd`.
- [ ] evidence graceful shutdown with a checkpoint via a test.
- [ ] define a dedicated low-privilege database service account per platform.
- [ ] document deployment steps repeatably and comparably.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-OrderDesk-Operations-Track_02_Datenbank-Deployment.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-OrderDesk-Operations-Track_02_Datenbank-Deployment.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
