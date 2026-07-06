# Lastenheft: Secure ServiceHarvester Operations Track 02 - Dienst-Deployment (Windows-Service, systemd, launchd)

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** SI - Systemintegration
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Referenzprojekt / Reference project:** C#-Referenz `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Der ServiceHarvester wird plattformgerecht als betriebener Dienst installiert: als Windows-Service, als `systemd`-Unit und als `launchd`-Agent/Daemon. Lernende beschreiben Lebenszyklus, Autostart, sauberes Beenden (Graceful Shutdown) und den Dienstbenutzer.

**EN:** The ServiceHarvester is installed as an operated service in a platform-appropriate way: as a Windows service, a `systemd` unit, and a `launchd` agent/daemon. Learners describe lifecycle, autostart, graceful shutdown, and the service account.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Welche Deployment-, Autostart- und Shutdown-Annahme je Plattform muss auditfähig dokumentiert werden? |
| AE | mittel | Welche Host-Integration (Worker/Service-Host) muss der Code unterstützen? |
| DPA | niedrig bis mittel | Welche Betriebsmetadaten des Dienstlaufs sind auswertbar und wo endet die Aussage? |
| DV | mittel | Welche Netz-/Firewall-Annahme berührt der Dienststart auf dem Zielhost? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Serverdienst-Bereitstellung, Automatisierung von Administrationsaufgaben und plattformübergreifendes Deployment mit auditfähiger Betriebsdokumentation.

**EN:** The task supports third-year System Integration specialization. It connects server-service provisioning, automation of administrative tasks, and cross-platform deployment with audit-ready operational documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Operations Track SI): **primär LF 10b („Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_02_Dienst-Deployment-Windows-Service-systemd-launchd.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, Operations Track SI): **primary LF 10b ("Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_02_Dienst-Deployment-Windows-Service-systemd-launchd.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, Least Privilege, Fail-Safe Defaults, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Zugangssteuerung, Betriebs- und Deploymentbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für das plattformgerechte Deployment des Secure ServiceHarvester eine fokussierte Spezifikation für die Spezialisierung SI. Berücksichtige: Windows-Service, `systemd`-Unit und `launchd`-Agent/Daemon, Autostart und Neustartverhalten, sauberes Beenden auf Stopp-Signal, dedizierter Dienstbenutzer mit minimalen Rechten und plattformspezifische, aber vergleichbare Installationsschritte. Die C#-Referenz `InventarWorkerService` dient als Beispiel für einen Worker-/Service-Host.

**EN:** Prepare a focused specification for platform-appropriate deployment of the Secure ServiceHarvester for the System Integration specialization. Consider: Windows service, `systemd` unit, and `launchd` agent/daemon, autostart and restart behavior, clean stop on a stop signal, a dedicated service account with minimal rights, and platform-specific yet comparable installation steps. The C# reference `InventarWorkerService` serves as an example of a worker/service host.

## Anforderungen / Requirements

- **R-01:** Für Windows-Service, `systemd` und `launchd` sind Installation, Autostart und Neustart beschrieben.
- **R-02:** Sauberes Beenden auf Stopp-Signal (Graceful Shutdown) ist je Plattform benannt und prüfbar.
- **R-03:** Der Dienst läuft unter einem dedizierten Konto mit minimalen Rechten (Least Privilege).
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte tragen Evidenzpfad oder Begründung.
- **R-05:** Die Lösung bleibt fachlich vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Dienstbenutzer, Dateirechte, Autostart-Konfiguration und Servicebeschreibungen als Vertrauensgrenzen prüfen.
- Der Dienst läuft nicht mit Administrator- oder root-Rechten, sofern nicht zwingend begründet.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Lebenszyklus, Autostart und Shutdown bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Service-Hosts (z. B. Worker-Host, Daemon-Bibliothek) dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere Rechte-, Pfad- und Autostart-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Deployment-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Deployment-Matrix je Plattform, Dienstbenutzer- und Rechtekonzept, Shutdown-Test, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Windows-Service, `systemd` und `launchd` sind vergleichbar abgedeckt.
- [ ] Graceful Shutdown und Least-Privilege-Dienstbenutzer sind belegt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Operations-Track_02_Dienst-Deployment-Windows-Service-systemd-launchd.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für das plattformgerechte Dienst-Deployment des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
