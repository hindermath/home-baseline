# Lastenheft: Secure ServiceHarvester Operations Track 05 - Observability: Logging, Health und Metriken

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

**DE:** Der betriebene ServiceHarvester wird beobachtbar gemacht: strukturiertes Logging ohne Secrets, Health-Checks (liveness/readiness) und aussagekräftige Metriken. Lernende verbinden Observability mit den SLO aus der Track-Baseline und mit dem Schutzbedarf der Log-Daten.

**EN:** The operated ServiceHarvester is made observable: structured logging without secrets, health checks (liveness/readiness), and meaningful metrics. Learners connect observability with the SLOs from the track baseline and with the protection need of log data.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Welches Log-, Health- und Metrik-Signal belegt ein SLO auditfähig? |
| AE | mittel | Welche strukturierten Log- und Health-Endpunkte muss der Code bereitstellen? |
| DPA | mittel bis hoch | Welche Log-Inhalte sind schützenswert und wie weit trägt eine Metrik als Aussage? |
| DV | mittel | Welche Health-/Metrik-Endpunkte werden über welche Netzgrenze abgefragt? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Betriebsüberwachung, Beobachtbarkeit vernetzter Systeme und Schutzbedarf der Betriebsdaten mit auditfähiger Betriebsdokumentation.

**EN:** The task supports third-year System Integration specialization. It connects operational monitoring, observability of networked systems, and the protection need of operational data with audit-ready operational documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Operations Track SI): **primär LF 11b („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen") und LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_05_Observability-Logging-Health-und-Metriken.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, Operations Track SI): **primary LF 11b ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen") and LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_05_Observability-Logging-Health-und-Metriken.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** auditfähiges Logging, Datenschutz, Separation of Concerns, Testbarkeit, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Logging- und Datenschutzbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für Observability des Secure ServiceHarvester eine fokussierte Spezifikation für die Spezialisierung SI. Berücksichtige: strukturiertes Logging mit sinnvollen Log-Ebenen und ohne Secrets, Health-Checks für liveness und readiness, aussagekräftige Metriken (z. B. Sammelläufe, Fehlerquote, Laufzeit), die Verbindung jeder Kennzahl zu einem SLO aus Einheit 01 und den Schutzbedarf der Log-Daten. Die C#-Referenz `InventarWorkerService` dient als Beispiel für einen zu beobachtenden Dienst.

**EN:** Prepare a focused specification for observability of the Secure ServiceHarvester for the System Integration specialization. Consider: structured logging with meaningful log levels and without secrets, health checks for liveness and readiness, meaningful metrics (e.g. collection runs, error rate, runtime), linking each metric to an SLO from unit 01, and the protection need of log data. The C# reference `InventarWorkerService` serves as an example of a service to be observed.

## Anforderungen / Requirements

- **R-01:** Logging ist strukturiert, mit sinnvollen Ebenen und ohne Secrets.
- **R-02:** Health-Checks für liveness und readiness sind beschrieben und prüfbar.
- **R-03:** Jede Metrik ist mit einem SLO oder einer Betriebsfrage verbunden.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte tragen Evidenzpfad oder Begründung.
- **R-05:** Das Observability-Modell bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Log-Inhalte, Health-Ausgaben, Metrik-Labels und Endpunkte als Vertrauensgrenzen prüfen.
- Keine Secrets, Tokens oder personenbezogenen Daten in Logs, Health-Ausgaben oder Metrik-Labels.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Log-Struktur, Health-Semantik und Metrik-Bedeutung bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Logging- und Metrik-Bibliotheken dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere Logging-, Health- und Metrik-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Observability-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Log-Ebenen-Tabelle, Health-Check-Beschreibung, Metrik-zu-SLO-Zuordnung, Datenschutz-Prüfung der Logs, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Logging, Health und Metriken sind getrennt und ohne Secrets beschrieben.
- [ ] Jede Metrik ist einem SLO oder einer Betriebsfrage zugeordnet.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Operations-Track_05_Observability-Logging-Health-und-Metriken.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Observability (Logging, Health und Metriken) des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
