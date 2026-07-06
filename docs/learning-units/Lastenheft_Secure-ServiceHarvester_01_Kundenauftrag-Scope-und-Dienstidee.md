# Lastenheft: Secure ServiceHarvester 01 - Kundenauftrag, Scope und Dienstidee

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Kundenauftrag, Dienstidee, Scope, Nicht-Ziele, Schutzbedarf und erste Nachweispfade werden geklärt. Lernende unterscheiden einen langlaufenden Dienst von einem einmaligen Programm.

**EN:** The customer task, service idea, scope, non-goals, protection need, and first evidence paths are clarified. Learners distinguish a long-running service from a one-shot program.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel bis hoch | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Rolle im Betrieb, Dienstidee, sichere Entwicklung und erste dokumentierte Bewertung auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects customer task, role in the company, service idea, secure development, and a first documented assessment at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 1 („Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen") und LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_01_Kundenauftrag-Scope-und-Dienstidee.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 1 ("Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen") and LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_01_Kundenauftrag-Scope-und-Dienstidee.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für einen klaren Scope des Secure ServiceHarvester eine fokussierte Spezifikation. Berücksichtige: Kundenauftrag, Dienstidee (langlaufender Sammel-Dienst gegenüber einmaligem Programm), zu sammelnde Statusdaten, Nicht-Ziele, Schutzbedarf und erste Nachweispfade werden geklärt. Halte den Dienst im 1. Lehrjahr bewusst einfach.

**EN:** Prepare a focused specification for a clear scope of the Secure ServiceHarvester. Consider: customer task, service idea (long-running collection service versus one-shot program), status data to be collected, non-goals, protection need, and first evidence paths. Keep the service deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang und die Dienstidee sind klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Gesammelte Statusdaten, Importe, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
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
- Erwartete Evidenz: Scope-Tabelle, Statusdaten-Liste, Dienstidee-Abgrenzung, Nicht-Ziele, Schutzbedarf, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Der Unterschied zwischen langlaufendem Dienst und einmaligem Programm ist benannt.
- [ ] Mindestens ein Test- oder Reviewpfad ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_01_Kundenauftrag-Scope-und-Dienstidee.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für einen klaren Scope des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
