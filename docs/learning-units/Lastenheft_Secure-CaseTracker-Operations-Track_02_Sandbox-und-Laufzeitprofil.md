# Lastenheft: Secure CaseTracker Operations Track 02 - Sandbox- und Laufzeitprofil

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** SI - Systemintegration
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Anwendung und Nachweis mit `absdd-image-sandbox`, öffentliches Referenz-Repo: <https://github.com/hindermath/absdd-image-sandbox>

## Lernziel / Learning Goal

**DE:** Sandbox, Laufzeit, Containerannahmen, Schreibgrenzen, Netzwerkgrenzen und Toolchain werden beschrieben. Im 3. Lehrjahr wird erwartet, dass Lernende KI-gestützte Entwicklungsarbeit in oder mit der Sandbox planen, nutzen oder begründet abgrenzen können.

**EN:** Learners can work on this specialization task and document decisions, risks, evidence paths, and boundaries.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | Schwerpunkt | Welche Laufzeit-, Schreib- und Netzwerkgrenze der Sandbox muss auditfähig dokumentiert werden? |
| AE | mittel | Welche Programm-Annahme bricht, wenn Schreib- oder Netzzugriff in der Sandbox eingeschränkt wird? |
| DPA | mittel | Welche Daten dürfen die Sandbox verlassen und welche nicht? |
| DV | mittel bis hoch | Welche Netzsegmente und Kommunikationswege sind für das Laufzeitprofil erlaubt? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung im 3. Lehrjahr. Sie verbindet Projektarbeit, sichere Entwicklung, Qualitätssicherung, Betrieb oder Datenbewertung mit auditfähiger Dokumentation.

**EN:** The task supports third-year specialization. It connects project work, secure development, quality assurance, operation, or data assessment with audit-ready documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10b („Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Operations-Track_02_Sandbox-und-Laufzeitprofil.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10b ("Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Operations-Track_02_Sandbox-und-Laufzeitprofil.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_07, CL_08, CL_09, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für ein sicheres Sandbox- und Laufzeitprofil eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: Public-Referenz `absdd-image-sandbox`, Laufzeit, Containerannahmen, Schreibgrenzen, Netzwerkgrenzen, Toolchain, KI-Agenten-Grenzen und Nachweise für sichere Sandbox-Nutzung.

**EN:** Prepare the corresponding specialization-focused feature specification. Keep the later implementation separate from this intake.

### Arbeitswerkzeuge außerhalb der Sandbox / Work Tools Outside the Sandbox

**DE:** JetBrains IDEs, VS Code und Windows-only Visual Studio dürfen weiterhin für Lesen, Review, Navigation, Debugging und normale Bearbeitung außerhalb der Sandbox genutzt werden. KI-gestützte Schreibarbeit, riskantere Experimente, reproduzierbare Toolchain-Prüfungen und Arbeiten mit klaren Schreib- oder Netzwerkgrenzen sollen im 3. Lehrjahr in oder mit der Sandbox erfolgen; Abweichungen werden begründet dokumentiert.

**EN:** JetBrains IDEs, VS Code, and Windows-only Visual Studio may still be used outside the sandbox for reading, review, navigation, debugging, and normal editing. From the third training year onward, AI-assisted write work, higher-risk experiments, reproducible toolchain checks, and work with clear write or network boundaries should happen in or with the sandbox; deviations are documented with rationale.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang ist klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz-, Betriebs- oder Datenannahmen sind getrennt dokumentiert.
- **R-03:** Test-, Review- oder Evidenzpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.
- **R-06:** KI-gestützte Entwicklungsarbeit wird für Jahr 3 entweder in/mit der Sandbox geplant oder als begründete Abweichung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Eingaben, Dateien, Konfiguration, Logs, Abhängigkeiten und Auswertungen als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Das Sandbox- und Laufzeitprofil bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Toolchains und Container-Basisbilder dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine Isolation, keine Rechtebeschränkung und keine Betriebsprüfung.
- KI-gestützte Schreibarbeit an oder mit der Sandbox wird begründet abgegrenzt und dokumentiert.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Spezialisierungs-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Sandbox-Profil, Laufzeitannahmen, Schreibgrenzen, Toolchain-Nachweis.
- Erwartete Evidenz: Public-Sandbox-Link, Agenten-Grenzen, IDE-/Editor-Abgrenzung, dokumentierte Abweichungen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] KI-gestützte Entwicklungsarbeit ist im 3. Lehrjahr mit Sandbox-Bezug oder begründeter Abweichung dokumentiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Operations-Track_02_Sandbox-und-Laufzeitprofil.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein sicheres Sandbox- und Laufzeitprofil der EuFPA-Lernreihe Secure CaseTracker Operations Track. Berücksichtige die Public-Referenz `https://github.com/hindermath/absdd-image-sandbox`, KI-gestützte Entwicklung in oder mit der Sandbox ab dem 3. Lehrjahr, IDE-/Editor-Arbeit außerhalb der Sandbox und dokumentierte Abweichungen. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
