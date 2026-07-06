# Lastenheft: Secure ServiceHarvester Operations Track 07 - Backup, Recovery und Datenmigration

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI - Systemintegration
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Backup-Ziele (RPO/RTO), Restore-Ablauf, Recovery-Übung und eine sichere Datenmigration zwischen Versionen oder Backends werden geplant. Lernende begründen, warum nur ein getesteter Restore und eine geprüfte Migration als Nachweis gelten. C#-Referenz: `InventarWorkerService`.

**EN:** Backup goals (RPO/RTO), restore procedure, recovery drill, and a safe data migration between versions or backends are planned. Learners justify why only a tested restore and a verified migration count as evidence. C# reference: `InventarWorkerService`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | hoch | Wie beweist du, dass ein Restore innerhalb des RTO gelingt und die Daten vollständig sind? |
| AE | mittel | Welche Datenstrukturen erschweren oder erleichtern eine Migration? |
| DPA | mittel bis hoch | Welche Datenverlustgrenze ist aus dem Schutzbedarf noch vertretbar? |
| DV | mittel bis hoch | Welche Netz- oder Speicherwege muss ein Backup sicher nutzen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Verfügbarkeit, sichere Speicherung, geprüfte Wiederherstellung und nachvollziehbare Datenmigration mit auditfähiger Dokumentation.

**EN:** The task supports third-year SI specialization. It connects availability, secure storage, tested recovery, and traceable data migration with audit-ready documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11b („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Begründung: Backup, Recovery und Datenmigration sichern Verfügbarkeit und geordneten Betrieb des laufenden Dienstes und stellen ihn nach einem Ausfall wieder bereit. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_07_Backup-Recovery-und-Datenmigration.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11b ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Rationale: backup, recovery, and data migration secure availability and orderly operation of the running service and provide it again after an outage. Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_07_Backup-Recovery-und-Datenmigration.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Verfügbarkeit, sichere Speicherung, Datenintegrität, auditfähige Evidenz, ehrliche Restrisiken.
- **Checklisten:** CL_01, CL_07, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung, Datenschutz nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für ein Backup-, Recovery- und Datenmigrationskonzept des Secure ServiceHarvester eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: Backup-Ziele (RPO/RTO), sicheren und geschützten Backup-Speicher, einen nummerierten Restore-Ablauf, eine Recovery-Übung mit Zeitmessung sowie eine geprüfte Datenmigration zwischen Schema-Versionen oder Speicher-Backends. Halte die Lösung für C#, Go, Java, Python, Rust und Swift vergleichbar.

**EN:** Prepare a focused specification for a backup, recovery, and data-migration concept of the Secure ServiceHarvester for the SI - System Integration specialization. Consider: backup goals (RPO/RTO), secure and protected backup storage, a numbered restore procedure, a recovery drill with time measurement, and a verified data migration between schema versions or storage backends. Keep the solution comparable across C#, Go, Java, Python, Rust, and Swift.

## Anforderungen / Requirements

- **R-01:** Backup-Ziele (RPO und RTO) sind benannt und aus dem Schutzbedarf begründet.
- **R-02:** Der Restore-Ablauf ist als klare, nummerierte Schrittfolge beschrieben.
- **R-03:** Eine Recovery-Übung mit gemessener Zeit und Vollständigkeitsprüfung ist vorgesehen.
- **R-04:** Die Datenmigration enthält eine Prüfung auf Vollständigkeit und Korrektheit sowie einen Rückfallweg.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Backups selbst schützen: Verschlüsselung und Zugriff nach Least Privilege.
- Migrationsskripte, Backup-Speicher und Wiederherstellungswege als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsaussagen nur mit Nachweis; nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren. Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Backup-, Restore- und Migrationsvertrag bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Werkzeuge für Backup, Prüfsummen oder Migration dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine Prüfung von Datenintegrität, Speicherzugriff oder Migrationslogik.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für das Backup-, Recovery- und Migrationskonzept dieser Aufgabe.
- `plan.md` mit Verfügbarkeits-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Backup-, Restore-, Migrations- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: RPO/RTO-Ableitung, Restore-Testplan, Recovery-Übungsergebnis, Migrations-Prüfbericht, Restrisiken.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] RPO/RTO, Restore-Ablauf, Recovery-Übung und Migration sind getrennt sichtbar.
- [ ] Der Unterschied zwischen einem angelegten und einem getesteten Backup ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Operations-Track_07_Backup-Recovery-und-Datenmigration.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Backup-Ziele, Restore-Ablauf, Recovery-Übung und geprüfte Datenmigration des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
