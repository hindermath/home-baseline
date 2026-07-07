# Lastenheft: Secure CaseTracker Digital Networking Track 07 - Konfiguration, Secrets und Rollout-Pfade

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Konfigurationsquellen, Secret-Grenzen, Rollout, Rückfallpfade und Änderungsnachweise werden festgelegt.

**EN:** Learners define configuration sources, secret boundaries, rollout, rollback paths, and change evidence.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welcher Rollout- oder Rückfallpfad entscheidet über den sicheren Betrieb des vernetzten CaseTracker? |
| SI | hoch | Welche Konfigurations-, Secret- oder Rollout-Annahme muss als Betriebs- und Änderungsnachweis geprüft werden? |
| AE | mittel bis hoch | Welche Implementierungsentscheidung folgt aus Konfigurationsquelle und Secret-Grenze? |
| DPA | mittel bis hoch | Welche Datenklasse oder welches Secret verlangt einen engeren Speicherort und warum? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr und nutzt Spec-Kit als begleitende Nachweisstruktur.

**EN:** The task supports Digital Networking in year 3 and uses Spec Kit as a companion evidence structure.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_07_Konfiguration-Secrets-und-Rollout-Pfade.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_07_Konfiguration-Secrets-und-Rollout-Pfade.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Konfiguration, Least Privilege, Change Management, Secrets-Schutz und Evidenz.
- **Checklisten:** CL_01, CL_02, CL_05, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Changemanagement, Richtlinie Zugangssteuerung, Leitlinie Sichere Entwicklungs-Sandbox.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Konfiguration, Secrets und Rollout-Pfade. Berücksichtige Konfigurationsquellen, erlaubte und verbotene Speicherorte, Secret-Behandlung, Rollout-Schritte, Rückfallpfade, Änderungsnachweise und Sandbox-Grenzen.

**EN:** Prepare a specification for configuration, secrets, and rollout paths. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Konfigurationsquellen und Secret-Grenzen sind getrennt beschrieben.
- **R-02:** Rollout- und Rückfallpfade sind nachvollziehbar.
- **R-03:** Änderungsnachweise und Reviewpunkte sind benannt.
- **R-04:** Keine echten Secrets werden erzeugt, gespeichert oder als Beispiel verwendet.
- **R-05:** `Applicable`, `N/A` und `Open` Punkte werden begründet.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Secrets, Tokens, Schlüssel oder produktiven Konfigurationen verwenden.
- Beispielwerte müssen eindeutig synthetisch sein.
- Konfigurationsfehler dürfen nicht zu offener Kommunikation oder Privilegienausweitung führen.
- Rollout-Entscheidungen brauchen nachvollziehbare Review- oder Testevidenz.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das Konfigurations-, Secret- und Rollout-Modell bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Konfigurations-, Secret- oder Deployment-Werkzeuge dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Konfigurations-, Secret- und Rollout-Nachweisen.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Erwartete Evidenz: Konfigurationsmatrix, Secret-Regeln, Rollout-/Rollback-Notiz, Änderungsnachweis.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Konfigurations- und Secret-Grenzen sind klar sichtbar.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Rollout und Rückfallpfad sind prüfbar beschrieben.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_07_Konfiguration-Secrets-und-Rollout-Pfade.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Konfiguration, Secrets und Rollout-Pfade der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
