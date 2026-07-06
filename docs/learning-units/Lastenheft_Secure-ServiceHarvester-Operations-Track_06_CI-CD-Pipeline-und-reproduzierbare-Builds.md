# Lastenheft: Secure ServiceHarvester Operations Track 06 - CI/CD-Pipeline und reproduzierbare Builds

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI - Systemintegration
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Eine CI/CD-Pipeline für den Sammel-Dienst wird geplant: Stufen, reproduzierbare Builds, festgesetzte Versionen, Build-Herkunft (Provenance) und Release-Nachweise. Lernende begründen, warum ein Build wiederholbar und nachvollziehbar sein muss. C#-Referenz: `InventarWorkerService`.

**EN:** A CI/CD pipeline for the collection service is planned: stages, reproducible builds, pinned versions, build provenance, and release evidence. Learners justify why a build must be repeatable and traceable. C# reference: `InventarWorkerService`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | hoch | Wie weist du nach, dass ein Release genau aus dem geprüften Quellstand entstanden ist? |
| AE | mittel bis hoch | Welche Build- oder Testschritte gehören verpflichtend in die Pipeline? |
| DPA | mittel | Welche Kennzahlen zu Build-Erfolg und Testabdeckung sind auswertbar? |
| DV | mittel bis hoch | Welche Registry-, Netz- oder Deploy-Ziele sind Teil der Pipeline? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Automatisierung von Build und Auslieferung, reproduzierbare Ergebnisse, sichere Lieferkette und auditfähige Release-Nachweise.

**EN:** The task supports third-year SI specialization. It connects automation of build and delivery, reproducible results, a secure supply chain, and audit-ready release evidence.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10b („Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Begründung: Eine CI/CD-Pipeline automatisiert wiederkehrende Administrations- und Auslieferungsaufgaben und stellt den Dienst reproduzierbar bereit. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10b ("Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Rationale: a CI/CD pipeline automates recurring administration and delivery tasks and provides the service reproducibly. Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Lieferkette, reproduzierbare Builds, Testbarkeit, auditfähige Evidenz, N/A-Begründung.
- **Checklisten:** CL_01, CL_05, CL_08, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Testmanagement, Lieferketten- und Abhängigkeitsbezug, Release- und Nachweisdokumentation.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für eine CI/CD-Pipeline des Secure ServiceHarvester eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: Pipeline-Stufen (Build, Test, Sicherheits- und Dependency-Prüfung, Paketierung, optionaler Release), reproduzierbare Builds durch festgesetzte Versionen und Lockfiles, Build-Herkunft (Provenance) sowie Release-Nachweise. Halte die Lösung für C#, Go, Java, Python, Rust und Swift vergleichbar. Beziehe die C#-Referenz `InventarWorkerService` als Beispiel für einen langlaufenden Dienst ein.

**EN:** Prepare a focused specification for a CI/CD pipeline of the Secure ServiceHarvester for the SI - System Integration specialization. Consider: pipeline stages (build, test, security and dependency checks, packaging, optional release), reproducible builds through pinned versions and lockfiles, build provenance, and release evidence. Keep the solution comparable across C#, Go, Java, Python, Rust, and Swift. Use the C# reference `InventarWorkerService` as an example of a long-running service.

## Anforderungen / Requirements

- **R-01:** Die Pipeline-Stufen sind klar benannt und in eine sinnvolle Reihenfolge gebracht.
- **R-02:** Reproduzierbarkeit ist beschrieben: festgesetzte Versionen, Lockfiles oder Versionsnachweise je Zielsprache.
- **R-03:** Sicherheits- und Dependency-Prüfungen sind als Pipeline-Schritt vorgesehen.
- **R-04:** Release-Nachweise (z. B. Build-Herkunft, Artefakt-Prüfsumme, Versionskennung) sind benannt.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Pipeline-Konfiguration, Build-Skripte, Abhängigkeiten und Artefakte als mögliche Vertrauensgrenzen prüfen.
- Zugangsdaten, Tokens oder Registry-Zugänge niemals im Klartext; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Positive Sicherheits- oder Qualitätsaussagen nur mit Nachweis treffen; nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Pipeline-Vertrag (Stufen, Reproduzierbarkeit, Nachweise) bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Build- und Audit-Werkzeuge dürfen gewählt werden, müssen aber benannt und begründet werden.
- MSL-Status ersetzt keine sichere Dependency-, Build- oder Release-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die CI/CD-Pipeline dieser Aufgabe.
- `plan.md` mit Pipeline-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Build-, Test-, Prüf- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Stufen-Diagramm als Text, Reproduzierbarkeits-Regeln je Sprache, Release-Nachweisliste, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Pipeline-Stufen, Reproduzierbarkeit und Release-Nachweise sind getrennt sichtbar.
- [ ] Für alle sechs Zielsprachen ist Reproduzierbarkeit benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine CI/CD-Pipeline mit reproduzierbaren Builds, Sicherheits- und Dependency-Prüfungen und Release-Nachweisen des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
