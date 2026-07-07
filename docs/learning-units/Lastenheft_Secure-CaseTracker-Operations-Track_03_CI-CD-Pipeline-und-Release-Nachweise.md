# Lastenheft: Secure CaseTracker Operations Track 03 - CI/CD-Pipeline und Release-Nachweise

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** SI - Systemintegration
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Pipeline-Schritte, Gates, Tests, Artefakte, Release-Nachweise und manuelle Freigaben werden geplant.

**EN:** Learners can work on this specialization task and document decisions, risks, evidence paths, and boundaries.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Wie weist du nach, dass ein Release genau aus dem geprüften Quellstand entstanden ist? |
| AE | mittel bis hoch | Welche Build-, Test- oder Gate-Schritte gehören verpflichtend in die Pipeline? |
| DPA | mittel | Welche Kennzahlen zu Build-Erfolg und Testabdeckung sind auswertbar? |
| DV | mittel bis hoch | Welche Registry-, Netz- oder Deploy-Ziele sind Teil der Pipeline? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung im 3. Lehrjahr. Sie verbindet Projektarbeit, sichere Entwicklung, Qualitätssicherung, Betrieb oder Datenbewertung mit auditfähiger Dokumentation.

**EN:** The task supports third-year specialization. It connects project work, secure development, quality assurance, operation, or data assessment with audit-ready documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10b („Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Operations-Track_03_CI-CD-Pipeline-und-Release-Nachweise.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10b ("Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Operations-Track_03_CI-CD-Pipeline-und-Release-Nachweise.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_06, CL_08, CL_11.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für eine nachvollziehbare CI/CD- und Release-Spezifikation eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: Pipeline-Schritte, Gates, Tests, Artefakte, Release-Nachweise und manuelle Freigaben werden geplant.

**EN:** Prepare the corresponding specialization-focused feature specification. Keep the later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang ist klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz-, Betriebs- oder Datenannahmen sind getrennt dokumentiert.
- **R-03:** Test-, Review- oder Evidenzpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Eingaben, Dateien, Konfiguration, Logs, Abhängigkeiten und Auswertungen als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Pipeline-Vertrag (Stufen, Reproduzierbarkeit, Nachweise) bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Build- und Audit-Werkzeuge dürfen gewählt, müssen aber benannt und begründet werden.
- MSL-Status ersetzt keine sichere Dependency-, Build- oder Release-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Spezialisierungs-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Pipeline-Matrix, Gates, Artefaktnachweise, Freigaberegeln.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Operations-Track_03_CI-CD-Pipeline-und-Release-Nachweise.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine nachvollziehbare CI/CD- und Release-Spezifikation der EuFPA-Lernreihe Secure CaseTracker Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
