# Lastenheft: Secure ServiceHarvester v2 09 - Sichere Konfiguration, Secrets und Betriebsnachweise

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`, öffentliches Referenz-Repo: <https://github.com/hindermath/absdd-image-sandbox>

## Lernziel / Learning Goal

**DE:** Sichere Konfiguration, Secrets aus einem Secret-Store statt aus dem Quellcode, Schreibgrenzen und Betriebsnachweise werden geplant. Im 2. Lehrjahr ist die Sandbox ein vorbereitetes Betriebs- und Nachweiskonzept; praktische Nutzung kann begründet `N/A` oder `Open` bleiben.

**EN:** Secure configuration, secrets from a secret store instead of from source code, write limits, and operational evidence are planned. In year 2 the sandbox is a prepared operations and evidence concept; practical use may remain `N/A` or `Open` with justification.

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
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt Secure ServiceHarvester v2): **primär LF 9 („Netzwerke und Dienste bereitstellen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section Secure ServiceHarvester v2): **primary LF 9 ("Netzwerke und Dienste bereitstellen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_07, CL_08, CL_09, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für sichere Konfiguration, Secrets und Betriebsnachweise des Secure ServiceHarvester eine fokussierte Spezifikation. Berücksichtige: Konfiguration ohne Secrets im Quellcode, Secrets aus einem plattformgeeigneten Secret-Store, Schreibgrenzen, Laufzeitannahmen und die Public-Referenz `absdd-image-sandbox`. Dokumentiere außerdem, ob praktische Sandbox-Nutzung für diesen Lauf `Applicable`, `N/A` oder `Open` ist. Die C#-Referenz `InventarWorkerService` dient nur zur Orientierung.

**EN:** Prepare a focused specification for secure configuration, secrets, and operational evidence of the Secure ServiceHarvester. Consider configuration without secrets in source code, secrets from a platform-appropriate secret store, write limits, runtime assumptions, and the public reference `absdd-image-sandbox`. Also document whether practical sandbox use for this run is `Applicable`, `N/A`, or `Open`. The C# reference `InventarWorkerService` serves only as orientation.

**DE:** Allgemeine Codearbeit, Lesen, Review und Bedienung von JetBrains IDEs, VS Code oder Windows-only Visual Studio dürfen außerhalb der Sandbox stattfinden. KI-gestützte Schreibarbeit soll aber so geplant werden, dass ab dem 3. Lehrjahr eine sichere Sandbox-Nutzung möglich und nachweisbar ist.

**EN:** General code work, reading, review, and use of JetBrains IDEs, VS Code, or Windows-only Visual Studio may happen outside the sandbox. AI-assisted write work should be planned so that secure sandbox use is possible and reviewable from the third training year onward.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang ist klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.
- **R-06:** Praktische Sandbox-Nutzung wird im 2. Lehrjahr nicht stillschweigend vorausgesetzt, sondern ausdrücklich begründet.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden.
- Konfiguration, Secrets, Schreibpfade, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>` dokumentieren, nie als echte Werte.
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
- Erwartete Evidenz: Konfigurationsregeln, Secret-Store-Regeln, Schreibgrenzen, Betriebsgrenzen, Incident-/Backup-N/A-Prüfung.
- Erwartete Evidenz: Link zur Public-Sandbox, Entscheidung `Applicable`/`N/A`/`Open`, IDE-/Editor-Abgrenzung.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens ein Test- oder Reviewpfad ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-v2_09_Sichere-Konfiguration-Secrets-und-Betriebsnachweise.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für sichere Konfiguration, Secrets und Betriebsnachweise der EuFPA-Lernreihe Secure ServiceHarvester v2. Berücksichtige die Public-Referenz `https://github.com/hindermath/absdd-image-sandbox`, die Jahr-2-Abgrenzung ohne harte Nutzungspflicht, IDE-/Editor-Arbeit außerhalb der Sandbox und die Vorbereitung auf verpflichtendere Sandbox-Kompetenz ab Jahr 3. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
