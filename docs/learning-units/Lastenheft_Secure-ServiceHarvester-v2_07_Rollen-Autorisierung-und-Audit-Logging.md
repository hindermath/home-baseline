# Lastenheft: Secure ServiceHarvester v2 07 - Rollen-, Autorisierung und Audit-Logging

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Rollen, erlaubte und verbotene Aktionen, sichere Defaults, Missbrauchsfälle und ein datenschutzbewusstes Audit-Logging ohne Secrets werden zusammen modelliert. Wer den Harvester-Dienst und die kleine API bedient, darf nur die vorgesehenen Aktionen ausführen, und jede sicherheitsrelevante Aktion ist nachvollziehbar.

**EN:** Roles, allowed and forbidden actions, secure defaults, abuse cases, and a privacy-aware audit log without secrets are modeled together. Whoever operates the harvester service and the small API may perform only the intended actions, and every security-relevant action is traceable.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Projektplanung, sichere Entwicklung, Qualitätssicherung, Betrieb und dokumentierte Bewertung auf dem Niveau ab dem 2. Lehrjahr.

**EN:** The task connects customer task, project planning, secure development, quality assurance, operation, and documented assessment at second-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt Secure ServiceHarvester v2): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-v2_07_Rollen-Autorisierung-und-Audit-Logging.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section Secure ServiceHarvester v2): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-v2_07_Rollen-Autorisierung-und-Audit-Logging.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_04, CL_05, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für Rollen, Autorisierung und Audit-Logging des Secure ServiceHarvester eine fokussierte Spezifikation. Berücksichtige: eine Rechtematrix mit sicheren Defaults (Deny-by-default), Missbrauchsfälle, eine Audit-Event-Liste mit erlaubten und verbotenen Logfeldern, sowie die klare Regel, dass keine Secrets ins Audit-Log gelangen. Die C#-Referenz `InventarWorkerService` dient nur zur Orientierung.

**EN:** Prepare a focused specification for roles, authorization, and audit logging of the Secure ServiceHarvester. Consider a permission matrix with secure defaults (deny-by-default), abuse cases, an audit event list with allowed and forbidden log fields, and the clear rule that no secrets reach the audit log. The C# reference `InventarWorkerService` serves only as orientation.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang ist klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Rollen, API-Aufrufe, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Keine Secrets, Tokens oder Passwörter in Audit-Logs schreiben.
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
- Erwartete Evidenz: Rechtematrix, Deny-by-default-Begründung, Missbrauchsfälle, Audit-Event-Liste mit erlaubten/verbotenen Feldern, Reviewpfad.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens ein Test- oder Reviewpfad ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-v2_07_Rollen-Autorisierung-und-Audit-Logging.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Rollen, Autorisierung und Audit-Logging der EuFPA-Lernreihe Secure ServiceHarvester v2. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
