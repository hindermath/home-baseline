# Lastenheft: Secure CaseTracker Digital Networking Track 09 - Sandbox-Integration und Betriebsnachweise

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Sandbox-Bezug, Netzwerkgrenzen, Toolchain-Nachweise und abweichende Arbeitsweisen werden begründet.

**EN:** Learners justify sandbox relation, network boundaries, toolchain evidence, and deviations from the reference workflow.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welche Netzwerkgrenze der Sandbox entscheidet über den sicheren Betrieb des vernetzten CaseTracker? |
| SI | hoch | Welche Sandbox-, Toolchain- oder Betriebsannahme muss als Nachweis dokumentiert werden? |
| AE | mittel bis hoch | Welche Implementierungs- oder Abweichungsentscheidung folgt aus den Sandbox-Grenzen? |
| DPA | mittel | Welche Datenklasse oder Aussagegrenze wird durch Arbeit außerhalb der Sandbox berührt? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Spec-Kit begleitet die Dokumentation der Arbeitsweise, ersetzt aber nicht praktische Ausbildung, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports Digital Networking in year 3. Spec Kit accompanies documentation of the workflow but does not replace practical training.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12d („Kundenspezifisches cyber-physisches System optimieren")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_09_Sandbox-Integration-und-Betriebsnachweise.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12d ("Kundenspezifisches cyber-physisches System optimieren")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_09_Sandbox-Integration-und-Betriebsnachweise.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Entwicklungsumgebung, Sandbox-Grenzen, Agenten-Parität, Cross-Platform-Nachweise und Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Entwicklungs-Sandbox, Richtlinie Secure Development Life Cycle, Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite eine Spezifikation für Sandbox-Integration und Betriebsnachweise. Berücksichtige Netzwerkzugriffe, Mounts, Schreibgrenzen, Toolchain-Status, erlaubte Abweichungen und Nachweispfade. Das Container-First-Gate gilt verbindlich: Jeder KI-Agenten-Aufruf erfolgt im Container/der Sandbox, nie auf dem Arbeitsplatz-Rechner (ab Unit 00, Grundlage `Secure-Trader-Sandbox-Preflight.md`); nur agentenlose Arbeit außerhalb der Sandbox wird als Restrisiko bewertet.

**EN:** Prepare a specification for sandbox integration and operational evidence. Consider network access, mounts, write boundaries, toolchain status, permitted deviations, and evidence paths. The container-first gate is binding: every AI-agent invocation runs in the container/sandbox, never on the workstation (from unit 00, basis `Secure-Trader-Sandbox-Preflight.md`); only agent-free work outside the sandbox is assessed as residual risk. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Sandbox-Zielbild, genutzte Grenzen und Abweichungen sind dokumentiert.
- **R-02:** Netzwerkzugriffe, Mounts und Schreibbereiche sind nachvollziehbar.
- **R-03:** Toolchain-, Test- und Betriebsnachweise sind benannt.
- **R-04:** Risiken bei Arbeit außerhalb der Sandbox sind als `N/A`, `Open` oder Restrisiko begründet.
- **R-05:** Sprachpfade bleiben vergleichbar, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine produktiven Daten oder Secrets in Sandbox- oder Agentenläufe geben.
- Netzwerkzugriffe nur mit Zweck und Grenze dokumentieren.
- Schreibzugriffe bewusst begrenzen.
- Abweichungen nicht verschweigen, sondern als Risiko oder `N/A` begründen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Sandbox- und Betriebsnachweis-Vertrag bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Build-, Test- oder Toolchain-Werkzeuge dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Sandbox-, Toolchain- und Betriebsnachweisen.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Erwartete Evidenz: Sandbox-Grenzliste, Toolchain-Status, Netzwerkentscheidung, Abweichungsbegründung.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Sandbox-Bezug oder begründete Abweichung ist klar dokumentiert.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Netzwerk- und Schreibgrenzen sind prüfbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_09_Sandbox-Integration-und-Betriebsnachweise.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Sandbox-Integration und Betriebsnachweise der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
