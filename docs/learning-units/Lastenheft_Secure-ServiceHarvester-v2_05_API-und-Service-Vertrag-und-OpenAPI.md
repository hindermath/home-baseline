# Lastenheft: Secure ServiceHarvester v2 05 - API- und Service-Vertrag und OpenAPI

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Ein Service-Vertrag für die kleine API, seine Beschreibung als OpenAPI/Swagger, Operationen, Eingaben, Ausgaben, Validierung und eine Fehlerbehandlung ohne interne Details werden vertraglich beschrieben. Lernende machen den Dienstzugang nachvollziehbar und prüfbar.

**EN:** A service contract for the small API, its description as OpenAPI/Swagger, operations, inputs, outputs, validation, and error handling without internal details are described as a contract. Learners make the service access traceable and verifiable.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel bis hoch | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Projektplanung, sichere Entwicklung, Qualitätssicherung, Betrieb und dokumentierte Bewertung auf dem Niveau ab dem 2. Lehrjahr.

**EN:** The task connects customer task, project planning, secure development, quality assurance, operation, and documented assessment at second-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure ServiceHarvester v2"): **primär LF 8 („Daten systemübergreifend bereitstellen")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-v2_05_API-und-Service-Vertrag-und-OpenAPI.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure ServiceHarvester v2"): **primary LF 8 ("Daten systemübergreifend bereitstellen")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-v2_05_API-und-Service-Vertrag-und-OpenAPI.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_03, CL_05, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für einen nachvollziehbaren API- und Service-Vertrag eine fokussierte Spezifikation. Berücksichtige: Operationen der kleinen Leseschnittstelle, Eingaben, Ausgaben, Validierung, Netzwerkgrenzen, eine maschinenlesbare Beschreibung als OpenAPI/Swagger und eine Fehlerbehandlung, die niemals interne Details (Stack-Trace, Pfad, Verbindungszeichenkette) preisgibt, werden beschrieben.

**EN:** Prepare a focused specification for a traceable API and service contract. Consider: operations of the small read interface, inputs, outputs, validation, network boundaries, a machine-readable description as OpenAPI/Swagger, and error handling that never exposes internal details (stack trace, path, connection string). Keep the later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang und der Vertragsumfang sind klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Aufrufe, Eingaben, Ausgaben, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Operationenliste, Validierungsregeln, Fehlervertrag (ohne Interna), OpenAPI/Swagger-Skizze, ASVS-N/A-Prüfung.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Der Vertrag ist als OpenAPI/Swagger skizzenhaft beschreibbar.
- [ ] Ein sicherer Fehlervertrag ohne interne Details ist als Test- oder Reviewpfad benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-v2_05_API-und-Service-Vertrag-und-OpenAPI.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für einen nachvollziehbaren API- und Service-Vertrag mit OpenAPI/Swagger und sicherer Fehlerbehandlung der EuFPA-Lernreihe Secure ServiceHarvester v2. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
