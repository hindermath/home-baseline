# Lastenheft: Secure OrderDesk Operations Track 02 - Datenbank-Deployment (Windows-Service, systemd, launchd)

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI - Systemintegration
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Die Bestell-/Handelsplattform und ihr relationaler Datenbank-Dienst werden plattformgerecht als betriebene Dienste installiert: als Windows-Service, als `systemd`-Unit und als `launchd`-Agent/Daemon. Lernende beschreiben Lebenszyklus, Autostart, sauberes Beenden (Graceful Shutdown mit Checkpoint) und den Dienstbenutzer der Datenbank.

**EN:** The ordering/trading platform and its relational database service are installed as operated services in a platform-appropriate way: as a Windows service, a `systemd` unit, and a `launchd` agent/daemon. Learners describe lifecycle, autostart, graceful shutdown with checkpoint, and the database service account.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Welche Deployment-, Autostart- und Shutdown-Annahme je Plattform für den Datenbank-Dienst muss auditfähig dokumentiert werden? |
| AE | mittel | Welche Host- und Verbindungsintegration muss die Datenzugriffsschicht unterstützen? |
| DPA | niedrig bis mittel | Welche Betriebsmetadaten des Datenbanklaufs sind auswertbar und wo endet die Aussage? |
| DV | mittel | Welche Netz-/Firewall-Annahme berührt der Datenbank-Port beim Start auf dem Zielhost? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Serverdienst-Bereitstellung, Automatisierung von Administrationsaufgaben und plattformübergreifendes Datenbank-Deployment mit auditfähiger Betriebsdokumentation.

**EN:** The task supports third-year System Integration specialization. It connects server-service provisioning, automation of administrative tasks, and cross-platform database deployment with audit-ready operational documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primäre LF 10b, 11b, 12b; berührt LF 4, LF 9): **primär LF 10b („Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Operations-Track_02_Datenbank-Deployment.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk Professional Tracks", Operations Track SI, primary LF 10b, 11b, 12b; touched LF 4, LF 9): **primary LF 10b ("Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Operations-Track_02_Datenbank-Deployment.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, Least Privilege, Fail-Safe Defaults, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Zugangssteuerung, Betriebs- und Deploymentbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für das plattformgerechte Deployment des Datenbank-Dienstes und der Bestell-/Handelsplattform Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung SI. Berücksichtige: Windows-Service, `systemd`-Unit und `launchd`-Agent/Daemon, Autostart und Neustartverhalten, sauberes Beenden auf Stopp-Signal mit sauberem Checkpoint/Flush der Datenbank, einen dedizierten Datenbank-Dienstbenutzer mit minimalen Rechten und plattformspezifische, aber vergleichbare Installationsschritte. Die in v2 gebaute Plattform mit Northwind-Datenbasis inkl. `ALFKI` dient als Beispiel für einen zu betreibenden Datenbank-Dienst.

**EN:** Prepare a focused specification for platform-appropriate deployment of the database service and the Secure OrderDesk ordering/trading platform for the System Integration specialization. Consider: Windows service, `systemd` unit, and `launchd` agent/daemon, autostart and restart behavior, clean stop on a stop signal with a clean database checkpoint/flush, a dedicated database service account with minimal rights, and platform-specific yet comparable installation steps. The platform built in v2 with the Northwind data base including `ALFKI` serves as an example of a database service to be operated.

## Anforderungen / Requirements

- **R-01:** Für Windows-Service, `systemd` und `launchd` sind Installation, Autostart und Neustart des Datenbank-Dienstes beschrieben.
- **R-02:** Sauberes Beenden auf Stopp-Signal (Graceful Shutdown mit Checkpoint/Flush) ist je Plattform benannt und prüfbar.
- **R-03:** Der Datenbank-Dienst läuft unter einem dedizierten Konto mit minimalen Rechten (Least Privilege).
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte tragen Evidenzpfad oder Begründung.
- **R-05:** Die Lösung bleibt fachlich vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; die Northwind-/`ALFKI`-Daten bleiben fiktiv; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Dienstbenutzer, Datei- und Datenverzeichnisrechte, Autostart-Konfiguration und Servicebeschreibungen als Vertrauensgrenzen prüfen.
- Der Datenbank-Dienst läuft nicht mit Administrator- oder root-Rechten, sofern nicht zwingend begründet.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Lebenszyklus, Autostart und Shutdown bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Service-Hosts und Datenbank-Treiber (z. B. Worker-Host, Daemon-Bibliothek, Verbindungspool) dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere Rechte-, Pfad-, Verbindungs- und Autostart-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Deployment-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Deployment-Matrix je Plattform, Datenbank-Dienstbenutzer- und Rechtekonzept, Shutdown-/Checkpoint-Test, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Windows-Service, `systemd` und `launchd` sind vergleichbar abgedeckt.
- [ ] Graceful Shutdown mit Checkpoint und Least-Privilege-Dienstbenutzer sind belegt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_02_Datenbank-Deployment.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für das plattformgerechte Datenbank-Deployment (Windows-Service, systemd, launchd) der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
