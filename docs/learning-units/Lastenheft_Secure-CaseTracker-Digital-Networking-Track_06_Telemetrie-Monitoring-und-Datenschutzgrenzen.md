# Lastenheft: Secure CaseTracker Digital Networking Track 06 - Telemetrie, Monitoring und Datenschutzgrenzen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Metriken, Logs, Traces, Warnungen, Datenschutzgrenzen und Aussagegrenzen werden getrennt dokumentiert.

**EN:** Learners document metrics, logs, traces, alerts, privacy boundaries, and interpretation limits separately.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welche Metrik oder welcher Log belegt, dass der vernetzte CaseTracker erreichbar und gesund ist? |
| DPA | hoch | Welche Datenschutzgrenze, Zweckbindung oder Aufbewahrung begrenzt Logs, Traces und Metriken? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| AE | mittel | Welche Implementierungsentscheidung folgt aus Metrik-, Log- und Trace-Struktur? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Spec-Kit begleitet die Spezifikation und Nachweise, ersetzt aber nicht klassische Lern- und Prüfungsanteile.

**EN:** The task supports Digital Networking in year 3. Spec Kit accompanies specification and evidence but does not replace conventional training and assessment.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_06_Telemetrie-Monitoring-und-Datenschutzgrenzen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_06_Telemetrie-Monitoring-und-Datenschutzgrenzen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, sichere Protokollierung, minimale Datenerhebung, Nachvollziehbarkeit und Evidenz.
- **Checklisten:** CL_01, CL_04, CL_08, CL_10, CL_11, CL_12.
- **Mitgeltende Dokumente:** Datenschutzleitlinie, Testmanagement, Leitlinie Sicheres Softwaredesign.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Telemetrie, Monitoring und Datenschutzgrenzen. Berücksichtige Metriken, Logs, Traces, Alerts, Aufbewahrung, Zugriff, Zweckbindung, Datenminimierung und Aussagegrenzen.

**EN:** Prepare a specification for telemetry, monitoring, and privacy boundaries. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Metriken, Logs, Traces und Alerts sind getrennt beschrieben.
- **R-02:** Zweck, Zugriff, Aufbewahrung und Datenminimierung sind dokumentiert.
- **R-03:** Personenbezug und Aussagegrenzen sind sichtbar.
- **R-04:** Test-, Review- oder Evidenzpfade sind benannt.
- **R-05:** `Applicable`, `N/A` und `Open` Punkte werden begründet.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Keine Secrets, Tokens, vollständigen Pfade oder unnötigen personenbezogenen Daten protokollieren.
- Monitoring-Daten nur mit Zweck und Zugriffsschutz planen.
- Aus Monitoring darf keine stärkere Aussage abgeleitet werden, als die Datenqualität trägt.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Health-, Metrik- und Log-Struktur bleiben für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Observability- oder Logging-Bibliotheken dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Monitoring-, Datenschutz- und Evidenzpfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Erwartete Evidenz: Telemetriematrix, Log-Datenschutzregeln, Alert-Liste, Aussagegrenzen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Telemetrie und Datenschutzgrenzen sind nachvollziehbar getrennt.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Monitoring-Behauptungen haben Evidenz oder sind als offen markiert.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_06_Telemetrie-Monitoring-und-Datenschutzgrenzen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Telemetrie, Monitoring und Datenschutzgrenzen der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
