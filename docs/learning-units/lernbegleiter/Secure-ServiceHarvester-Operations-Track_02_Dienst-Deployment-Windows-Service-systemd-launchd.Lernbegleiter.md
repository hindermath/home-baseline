# Lernbegleiter: Secure ServiceHarvester Operations Track 02 – Dienst-Deployment (Windows-Service, systemd, launchd) / Study Companion

**Stand / Date:** 2026-07-06
**Zugehöriges Lastenheft / Related intake:** `Lastenheft_Secure-ServiceHarvester-Operations-Track_02_Dienst-Deployment-Windows-Service-systemd-launchd.md`
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Hinweis zur Einordnung / Note on Classification

**DE:** Dieser Lernbegleiter ist ein zusätzliches Erklär- und Übungsmaterial. Er ersetzt nicht die
Berufsschule, die betriebliche Ausbildung, den Rahmenlehrplan, Ausbilderentscheidungen oder die
Prüfungsvorbereitung. Er hilft, die zugehörige Aufgabe zu verstehen, bevor sie bearbeitet wird.

**EN:** This study companion is additional explanatory and practice material. It does not replace vocational
school, workplace training, the curriculum, instructor decisions, or exam preparation. It helps you
understand the related task before working on it.

## Worum geht es? / What Is This About?

**DE:** Ein Programm zu starten ist nicht dasselbe wie einen **Dienst zu betreiben**. Ein Dienst muss beim
Systemstart automatisch anlaufen, nach einem Absturz neu starten, auf ein Stopp-Signal sauber beenden und
unter einem eigenen, rechtearmen Konto laufen. Jedes Betriebssystem hat dafür einen eigenen Mechanismus: auf
Windows den **Windows-Service** (Service Control Manager), auf Linux **`systemd`** (Unit-Dateien), auf macOS
**`launchd`** (Agents/Daemons). Als Systemintegrator*in bringst du denselben ServiceHarvester auf allen drei
Plattformen vergleichbar in Betrieb.

**EN:** Starting a program is not the same as **operating a service**. A service must start automatically at
system boot, restart after a crash, stop cleanly on a stop signal, and run under its own low-privilege
account. Each operating system has its own mechanism for this: on Windows the **Windows service** (Service
Control Manager), on Linux **`systemd`** (unit files), on macOS **`launchd`** (agents/daemons). As a system
integrator you bring the same ServiceHarvester into operation comparably on all three platforms.

**DE:** In dieser Einheit lernst du, den Lebenszyklus eines Dienstes je Plattform zu beschreiben, Autostart
und Neustart zu konfigurieren, das saubere Beenden (Graceful Shutdown) nachzuweisen und einen dedizierten
Dienstbenutzer mit minimalen Rechten festzulegen. Die C#-Referenz `InventarWorkerService` zeigt beispielhaft
einen Worker-/Service-Host.

**EN:** In this unit you learn to describe a service's lifecycle per platform, to configure autostart and
restart, to evidence graceful shutdown, and to define a dedicated service account with minimal rights. The C#
reference `InventarWorkerService` shows an example of a worker/service host.

## Kernbegriffe / Key Terms

| Begriff / Term | Erklärung / Explanation (CEFR B2) |
|---|---|
| Dienst / Service | Programm, das dauerhaft im Hintergrund läuft und vom Betriebssystem verwaltet wird. |
| Windows-Service / Windows service | Vom Service Control Manager verwalteter Hintergrunddienst auf Windows. |
| systemd-Unit / systemd unit | Konfigurationsdatei, die einen Dienst unter Linux beschreibt und steuert. |
| launchd-Agent/Daemon | Von macOS `launchd` verwalteter Hintergrundprozess (nutzerbezogen oder systemweit). |
| Graceful Shutdown / Graceful shutdown | Geordnetes Beenden auf ein Stopp-Signal, ohne Datenverlust oder Hängenbleiben. |
| Dienstbenutzer / Service account | Eigenes Konto mit minimalen Rechten, unter dem der Dienst läuft (Least Privilege). |

## Erklärung Schritt für Schritt / Step-by-Step Explanation

**DE:** **Schritt 1 – Lebenszyklus verstehen.** Jeder Dienst hat dieselben Phasen: installieren, starten,
laufen, stoppen, deinstallieren. Beschreibe diese Phasen einmal fachlich und ordne dann je Plattform den
konkreten Mechanismus zu. So bleibt der Betrieb vergleichbar, obwohl die Werkzeuge verschieden sind.

**EN:** **Step 1 – Understand the lifecycle.** Every service has the same phases: install, start, run, stop,
uninstall. Describe these phases once functionally, then map the concrete mechanism per platform. This keeps
operation comparable although the tools differ.

**DE:** **Schritt 2 – Autostart und Neustart konfigurieren.** Der Dienst soll beim Systemstart automatisch
laufen und nach einem Absturz neu starten. Windows: Starttyp „Automatisch" und Wiederherstellungsaktionen;
`systemd`: `WantedBy` plus `Restart=on-failure`; `launchd`: `RunAtLoad` plus `KeepAlive`. Begründe je
Plattform, warum dein Neustartverhalten zum SLO aus Einheit 01 passt.

**EN:** **Step 2 – Configure autostart and restart.** The service should run automatically at boot and
restart after a crash. Windows: start type "Automatic" and recovery actions; `systemd`: `WantedBy` plus
`Restart=on-failure`; `launchd`: `RunAtLoad` plus `KeepAlive`. Justify per platform why your restart behavior
matches the SLO from unit 01.

**DE:** **Schritt 3 – Graceful Shutdown nachweisen.** Auf ein Stopp-Signal (Windows: Stop-Kommando; Linux:
`SIGTERM`; macOS: `SIGTERM`) muss der Dienst laufende Sammelläufe geordnet abschließen oder abbrechen, Puffer
schreiben und sich beenden. Weise das mit einem Shutdown-Test nach: Signal senden, prüfen, dass keine Daten
verloren gehen und der Prozess innerhalb einer definierten Zeit endet.

**EN:** **Step 3 – Evidence graceful shutdown.** On a stop signal (Windows: stop command; Linux: `SIGTERM`;
macOS: `SIGTERM`) the service must finish or cancel running collection runs in an orderly way, flush buffers,
and exit. Evidence this with a shutdown test: send the signal, check that no data is lost and the process
ends within a defined time.

**DE:** **Schritt 4 – Dienstbenutzer und Rechte minimieren.** Der Dienst läuft nicht als Administrator oder
root, sondern unter einem dedizierten Konto mit genau den Rechten, die er braucht (Least Privilege). Prüfe
Dateirechte, Verzeichniszugriffe und ob überhaupt Netzrechte nötig sind. Dokumentiere je Plattform, welches
Konto und welche Rechte gelten.

**EN:** **Step 4 – Minimize service account and rights.** The service does not run as administrator or root
but under a dedicated account with exactly the rights it needs (least privilege). Check file permissions,
directory access, and whether network rights are needed at all. Document per platform which account and which
rights apply.

**DE:** **Typische Fehler.** Den Dienst mit Administrator-/root-Rechten laufen lassen. Autostart vergessen,
sodass der Dienst nach einem Reboot stillsteht. Kein sauberes Beenden, sodass Sammelläufe abrupt abbrechen.
Plattformen ungleich behandeln, sodass ein System heimlich schwächer konfiguriert ist. Deployment nur „von
Hand" ohne dokumentierte, wiederholbare Schritte.

**EN:** **Common mistakes.** Running the service with administrator/root rights. Forgetting autostart so the
service stays down after a reboot. No clean shutdown so collection runs abort abruptly. Treating platforms
unequally so one system is silently weaker. Deploying only "by hand" without documented, repeatable steps.

### Beispiel / Example

```text
Phase        | Windows-Service        | systemd                    | launchd
-------------|------------------------|----------------------------|---------------------------
Installieren | sc create / Service-API| Unit-Datei nach /etc/...   | plist nach LaunchDaemons
Autostart    | Starttyp "Automatisch" | WantedBy=multi-user.target | RunAtLoad=true
Neustart     | Recovery-Aktionen      | Restart=on-failure         | KeepAlive=true
Stoppen      | Stop-Kommando          | SIGTERM (Graceful)         | SIGTERM (Graceful)
Dienstkonto  | dediziert, rechtearm   | User=svc-harvester         | UserName=svc-harvester
Nachweis     | Shutdown-/Autostart-Test dokumentiert; keine Admin-/root-Rechte ohne Begründung
```

## Rahmenlehrplanbezug im Detail / Curriculum Relation in Detail

**DE:** Diese Einheit gehört zu folgenden Lernfeldern (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9):

**EN:** This unit belongs to the following learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`,
Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9):

| Lernfeld / Learning Field | Rolle / Role | Warum / Why |
|---|---|---|
| LF 10b Serverdienste bereitstellen und Administrationsaufgaben automatisieren | Primär / Primary | Der Dienst wird plattformgerecht installiert, automatisiert gestartet und verwaltet. |
| LF 9 Netzwerke und Dienste bereitstellen | Berührt / Touched | Der Dienst wird als betriebener Dienst auf einem Zielhost bereitgestellt. |

## Sicher & barrierefrei denken / Thinking Secure & Accessible

**DE:** Bezug zur Richtlinie Sichere Entwicklung: Least Privilege, Fail-Safe Defaults und auditfähige
Evidenz. Passende Checklisten: `CL_01` (Standards-Anwendbarkeit), `CL_05` (Zugangssteuerung/Rechte), `CL_08`
(Sicherheits-Review) und `CL_12` (Dokumentation/N-A). Die Sicherheitsentscheidung dieser Einheit lautet: *Der
Dienst läuft rechtearm, startet und stoppt kontrolliert, und jedes Verhalten wird nachgewiesen.* A11Y-Aspekt:
Die Deployment-Matrix muss als Text-Tabelle mit gleich breiten Spalten lesbar sein, nicht nur als Screenshot,
damit sie mit Screenreader und Braille-Zeile nutzbar bleibt.

**EN:** Relation to the Secure Development Guideline: least privilege, fail-safe defaults, and audit-ready
evidence. Matching checklists: `CL_01` (standards applicability), `CL_05` (access control/rights), `CL_08`
(security review), and `CL_12` (documentation/N-A). The security decision of this unit is: *the service runs
low-privilege, starts and stops in a controlled way, and every behavior is evidenced.* Accessibility aspect:
the deployment matrix must be readable as a text table with equal-width columns, not only as a screenshot, so
it stays usable with a screen reader and Braille display.

## Verständnisfragen / Comprehension Questions

**DE:** Denke zuerst selbst nach. Klappe die Musterantwort erst danach auf.

**EN:** Think for yourself first. Open the model answer only afterwards.

1. **DE:** Was unterscheidet einen betriebenen Dienst von einem einfach gestarteten Programm? /
   **EN:** What distinguishes an operated service from a simply started program?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Ein Dienst wird vom Betriebssystem verwaltet: Er startet automatisch beim Boot, startet nach einem
   Absturz neu, beendet auf ein Stopp-Signal sauber und läuft unter einem eigenen Konto. Ein einfach
   gestartetes Programm hat diese Betriebseigenschaften nicht.
   **EN:** A service is managed by the operating system: it starts automatically at boot, restarts after a
   crash, stops cleanly on a stop signal, and runs under its own account. A simply started program does not
   have these operational properties.

   </details>

2. **DE:** (SI) Warum konfiguriert man denselben Dienst auf Windows, `systemd` und `launchd` vergleichbar? /
   **EN:** (SI) Why do you configure the same service comparably on Windows, `systemd`, and `launchd`?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Damit kein System heimlich schwächer oder anders läuft. Vergleichbare Autostart-, Neustart- und
   Shutdown-Regeln machen den Betrieb vorhersehbar und prüfbar, unabhängig vom Zielhost. Die Werkzeuge
   unterscheiden sich, die Betriebseigenschaften sollen gleich sein.
   **EN:** So that no system runs secretly weaker or differently. Comparable autostart, restart, and shutdown
   rules make operation predictable and verifiable regardless of the target host. The tools differ, but the
   operational properties should be equal.

   </details>

3. **DE:** (SI) Warum soll der Dienst nicht mit Administrator- oder root-Rechten laufen? /
   **EN:** (SI) Why should the service not run with administrator or root rights?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Nach dem Least-Privilege-Prinzip soll ein Prozess nur die Rechte haben, die er braucht. Läuft der
   Dienst mit vollen Rechten, kann ein Fehler oder Angriff das ganze System kompromittieren. Ein rechtearmes
   Dienstkonto begrenzt den möglichen Schaden.
   **EN:** By the least-privilege principle a process should only have the rights it needs. If the service
   runs with full rights, an error or attack can compromise the whole system. A low-privilege service account
   limits the possible damage.

   </details>

4. **DE:** Wie weist man Graceful Shutdown nach? /
   **EN:** How do you evidence graceful shutdown?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Mit einem Shutdown-Test: Man sendet das Stopp-Signal und prüft, dass laufende Sammelläufe geordnet
   abgeschlossen oder abgebrochen werden, keine Daten verloren gehen und der Prozess innerhalb einer
   definierten Zeit endet. Das Ergebnis wird dokumentiert.
   **EN:** With a shutdown test: send the stop signal and check that running collection runs finish or cancel
   in an orderly way, no data is lost, and the process ends within a defined time. The result is documented.

   </details>

5. **DE:** (DV) Welche Netz- oder Firewall-Annahme kann der Dienststart auf dem Zielhost berühren? /
   **EN:** (DV) Which network or firewall assumption can the service start touch on the target host?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Wenn der Dienst Ports öffnet oder ausgehende Verbindungen aufbaut, müssen Firewall-Regeln das
   erlauben. Man dokumentiert, welche Ports und Richtungen nötig sind, und prüft, ob überhaupt Netzrechte
   gebraucht werden. Unnötige Netzflächen bleiben zu.
   **EN:** If the service opens ports or makes outbound connections, firewall rules must allow this. You
   document which ports and directions are needed and check whether network rights are needed at all.
   Unnecessary network surfaces stay closed.

   </details>

6. **DE:** (AE) Was muss der Code eines Worker-/Service-Hosts wie `InventarWorkerService` unterstützen? /
   **EN:** (AE) What must the code of a worker/service host like `InventarWorkerService` support?

   <details><summary>Musterantwort / Model answer</summary>

   **DE:** Er muss sich sauber initialisieren, ein Stopp-Signal empfangen und darauf geordnet reagieren
   (Cancellation), Zustände speichern und ohne Datenverlust beenden. Der Host kapselt den Lebenszyklus, damit
   die eigentliche Sammellogik betriebsfähig wird.
   **EN:** It must initialize cleanly, receive a stop signal and react to it in an orderly way (cancellation),
   persist state, and exit without data loss. The host encapsulates the lifecycle so the actual collection
   logic becomes operational.

   </details>

## Selbstcheck / Self-Check

**DE:** Ich kann …

- [ ] den Lebenszyklus eines Dienstes fachlich und je Plattform beschreiben.
- [ ] Autostart und Neustart für Windows-Service, `systemd` und `launchd` konfigurieren.
- [ ] Graceful Shutdown mit einem Test nachweisen.
- [ ] einen dedizierten, rechtearmen Dienstbenutzer je Plattform festlegen.
- [ ] Deployment-Schritte wiederholbar und vergleichbar dokumentieren.

**EN:** I can …

- [ ] describe a service's lifecycle functionally and per platform.
- [ ] configure autostart and restart for Windows service, `systemd`, and `launchd`.
- [ ] evidence graceful shutdown with a test.
- [ ] define a dedicated low-privilege service account per platform.
- [ ] document deployment steps repeatably and comparably.

## Weiter zur Aufgabe / On to the Task

**DE:** Wenn du diese Erklärung verstanden hast, bearbeite das zugehörige Lastenheft
`Lastenheft_Secure-ServiceHarvester-Operations-Track_02_Dienst-Deployment-Windows-Service-systemd-launchd.md`.
Der Copy-Paste-Prompt für einen späteren, manuell gestarteten Spec-Kit-Lauf steht dort.

**EN:** Once you understand this explanation, work on the related intake
`Lastenheft_Secure-ServiceHarvester-Operations-Track_02_Dienst-Deployment-Windows-Service-systemd-launchd.md`.
The copy-paste prompt for a later, manually started Spec Kit run is provided there.
