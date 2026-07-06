# Lastenheft: Secure ServiceHarvester Operations Track 01 - Track-Baseline und Betriebszielbild

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** SI - Systemintegration
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Referenzprojekt / Reference project:** C#-Referenz `InventarWorkerService`
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Die Baseline des Operations Track und ein messbares Betriebszielbild für den ServiceHarvester werden festgelegt: Betriebsziele als SLO, Systemgrenzen innen/außen, Verantwortlichkeiten und Schutzbedarf. Lernende bauen aus dem in v2 gebauten Dienst einen betriebenen Dienst auf.

**EN:** The baseline of the Operations Track and a measurable operations target picture for the ServiceHarvester are defined: operational goals as SLO, inside/outside system boundaries, responsibilities, and protection need. Learners turn the service built in v2 into an operated service.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Welches Betriebsziel, welche Systemgrenze und welche Betriebsannahme muss auditfähig dokumentiert werden? |
| AE | mittel | Welche Betriebsanforderung wirkt auf Codeaufbau und Konfigurierbarkeit zurück? |
| DPA | mittel | Welcher Schutzbedarf der Betriebs- und Statusdaten begrenzt Auswertungen? |
| DV | mittel | Welche Netz- oder Kommunikationsgrenze berührt das Betriebszielbild? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Betriebsplanung, sichere Entwicklung, Verantwortlichkeiten und Schutzbedarf mit auditfähiger Betriebsdokumentation.

**EN:** The task supports third-year System Integration specialization. It connects operations planning, secure development, responsibilities, and protection need with audit-ready operational documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Operations Track SI): **primär LF 12b („Kundenspezifische Systemintegration durchführen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_01_Track-Baseline-und-Betriebszielbild.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, Operations Track SI): **primary LF 12b ("Kundenspezifische Systemintegration durchführen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Operations-Track_01_Track-Baseline-und-Betriebszielbild.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, klare Verantwortlichkeiten, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Track-Baseline und ein Betriebszielbild des Secure ServiceHarvester eine fokussierte Spezifikation für die Spezialisierung SI. Berücksichtige: Betriebsziele als messbare SLO, Systemgrenzen innen/außen, Verantwortlichkeiten (führt aus / entscheidet) und Schutzbedarf für Vertraulichkeit, Integrität und Verfügbarkeit. Nutze den in v2 gebauten Dienst (C#-Referenz `InventarWorkerService`) als Ausgangspunkt, ohne ihn neu zu bauen.

**EN:** Prepare a focused specification for the track baseline and an operations target picture of the Secure ServiceHarvester for the System Integration specialization. Consider: operational goals as measurable SLOs, inside/outside system boundaries, responsibilities (executes / decides), and protection need for confidentiality, integrity, and availability. Use the service built in v2 (C# reference `InventarWorkerService`) as a starting point without rebuilding it.

## Anforderungen / Requirements

- **R-01:** Betriebsziele sind als messbare SLO beschrieben.
- **R-02:** Systemgrenzen sind schriftlich in innen und außen getrennt.
- **R-03:** Verantwortlichkeiten trennen „führt aus" von „entscheidet".
- **R-04:** Der Schutzbedarf ist begründet eingestuft; alle `Applicable`, `N/A` und `Open` Punkte tragen Evidenzpfad oder Begründung.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Statusdaten, Konfiguration, Logs, Abhängigkeiten und Betriebszugänge als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Verfügbarkeits- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das Betriebszielbild bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Betriebs- und Hosting-Werkzeuge dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung im Betrieb.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Betriebs-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: SLO-Tabelle, Systemgrenzen innen/außen, Rollen-/Verantwortungsmatrix, Schutzbedarf, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Mindestens ein Betriebsziel ist als messbares SLO formuliert.
- [ ] Systemgrenzen und Verantwortlichkeiten sind getrennt dokumentiert.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Operations-Track_01_Track-Baseline-und-Betriebszielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Track-Baseline und ein Betriebszielbild des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
