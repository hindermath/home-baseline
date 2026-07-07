# Lastenheft: Secure CaseTracker Operations Track 01 - Betriebszielbild und Systemgrenzen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** SI - Systemintegration
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Betriebsziele, Systemgrenzen, Verantwortlichkeiten und Schutzbedarf werden für den betriebenen CaseTracker definiert.

**EN:** Learners can work on this specialization task and document decisions, risks, evidence paths, and boundaries.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Welches Betriebsziel, welche Systemgrenze und welche Betriebsannahme des CaseTracker muss auditfähig dokumentiert werden? |
| AE | mittel | Welche Betriebsanforderung wirkt auf Codeaufbau und Konfigurierbarkeit zurück? |
| DPA | mittel | Welcher Schutzbedarf der Betriebs- und Falldaten begrenzt Auswertungen? |
| DV | mittel | Welche Netz- oder Kommunikationsgrenze berührt das Betriebszielbild? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung im 3. Lehrjahr. Sie verbindet Projektarbeit, sichere Entwicklung, Qualitätssicherung, Betrieb oder Datenbewertung mit auditfähiger Dokumentation.

**EN:** The task supports third-year specialization. It connects project work, secure development, quality assurance, operation, or data assessment with audit-ready documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12b („Kundenspezifische Systemintegration durchführen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12b ("Kundenspezifische Systemintegration durchführen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_07, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für ein Betriebszielbild für den CaseTracker Operations Track eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: Betriebsziele, Systemgrenzen, Verantwortlichkeiten und Schutzbedarf werden für den betriebenen CaseTracker definiert.

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

- Das Betriebszielbild bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Betriebs- und Hosting-Werkzeuge dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung im Betrieb.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Spezialisierungs-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Betriebskontext, Systemgrenzen, Verantwortlichkeiten, Schutzbedarf.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Operations-Track_01_Betriebszielbild-und-Systemgrenzen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein Betriebszielbild für den CaseTracker Operations Track der EuFPA-Lernreihe Secure CaseTracker Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
