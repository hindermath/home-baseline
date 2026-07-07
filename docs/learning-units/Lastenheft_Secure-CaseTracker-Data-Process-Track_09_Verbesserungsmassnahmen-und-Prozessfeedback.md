# Lastenheft: Secure CaseTracker Data & Process Track 09 - Verbesserungsmaßnahmen und Prozessfeedback

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DPA - Daten- und Prozessanalyse
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Kennzahlenergebnisse werden in Verbesserungsmaßnahmen, Prozessfeedback und Verantwortlichkeiten übersetzt.

**EN:** Learners can work on this specialization task and document decisions, risks, evidence paths, and boundaries.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DPA | hoch (Schwerpunkt) | Wie wird aus einer Kennzahl über die geprüfte Ursache eine wirksame Verbesserungsmaßnahme? |
| AE | mittel | Welche Codeänderung folgt aus einer Verbesserungsmaßnahme und wie wird sie getestet? |
| SI | mittel | Welche Betriebs- oder Konfigurationsmaßnahme verbessert den Prozess messbar? |
| DV | mittel | Welche Schnittstellen- oder Prozessmaßnahme schließt eine wiederkehrende Lücke? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung im 3. Lehrjahr. Sie verbindet Projektarbeit, sichere Entwicklung, Qualitätssicherung, Betrieb oder Datenbewertung mit auditfähiger Dokumentation.

**EN:** The task supports third-year specialization. It connects project work, secure development, quality assurance, operation, or data assessment with audit-ready documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11c („Prozesse analysieren und gestalten")**; berührt LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Data-Process-Track_09_Verbesserungsmassnahmen-und-Prozessfeedback.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11c ("Prozesse analysieren und gestalten")**; touched LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Data-Process-Track_09_Verbesserungsmassnahmen-und-Prozessfeedback.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für einen Prozessfeedback- und Verbesserungsplan eine fokussierte Spezifikation für die Spezialisierung DPA - Daten- und Prozessanalyse. Berücksichtige: Kennzahlenergebnisse werden in Verbesserungsmaßnahmen, Prozessfeedback und Verantwortlichkeiten übersetzt.

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

- Der fachliche Vertrag zu Maßnahmen, Wirkungshypothese und Follow-up bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Werkzeuge zur Auswertung dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Spezialisierungs-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Maßnahmenliste, Verantwortlichkeiten, Wirkungshypothesen, Follow-up-Regeln.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DPA ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Data-Process-Track_09_Verbesserungsmassnahmen-und-Prozessfeedback.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für einen Prozessfeedback- und Verbesserungsplan der EuFPA-Lernreihe Secure CaseTracker Data & Process Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
