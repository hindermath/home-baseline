# Lastenheft: Secure ServiceHarvester Digital Networking Track 01 - Track-Baseline und Netzzielbild

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **C#-Referenz / C# reference:** `InventarWorkerService`
- **Primär geeignet für / Primary fit:** DV (Schwerpunkt); berührt SI, AE, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Die Track-Baseline aus Jahr 2 (v2) wird festgehalten und in ein **Netzzielbild** übersetzt: Schutzziele des Netzes, das Szenario des verteilten Sammelns, grobe Vertrauenszonen, Verfügbarkeitsziele sowie Scope und Nicht-Ziele des DV-Tracks. Lernende trennen das fachliche Sammel-Ziel klar vom vernetzten Betriebsziel.

**EN:** The track baseline from year 2 (v2) is recorded and translated into a **network target picture**: network protection goals, the distributed collection scenario, coarse trust zones, availability targets, and the scope and non-goals of the Digital Networking Track. Learners separate the functional collection goal clearly from the networked operational goal.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welches Netz-Schutzziel und welche Vertrauenszone entscheiden über die spätere Architektur? |
| SI | hoch | Welche Betriebs-, Verfügbarkeits- oder Sandbox-Annahme muss als Nachweis dokumentiert werden? |
| AE | mittel bis hoch | Welche Schnittstellen- oder Vertragsentscheidung folgt aus dem Netzzielbild? |
| DPA | mittel | Welche Datenklasse oder Datenschutzgrenze wird durch das verteilte Sammeln berührt? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die Spezialisierung DV im 3. Lehrjahr. Sie verbindet den sicheren Betrieb vernetzter Systeme, sichere Architektur, Verfügbarkeit, Datenschutz und auditfähige Dokumentation. Spec-Kit begleitet diese Aufgabe, ersetzt aber nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.

**EN:** The task supports the Digital Networking specialization in the third training year. Spec Kit accompanies the task but does not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11d („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 10d („Cyber-physische Systeme entwickeln"), LF 12d („Kundenspezifisches cyber-physisches System optimieren") und LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11d ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 10d ("Cyber-physische Systeme entwickeln"), LF 12d ("Kundenspezifisches cyber-physisches System optimieren"), and LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, Trust Boundaries, Verfügbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_04, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie Sicheres Softwaredesign, Zugangssteuerung und Testmanagement.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die Track-Baseline und das Netzzielbild eine fokussierte Spezifikation für die Spezialisierung DV - Digitale Vernetzung. Berücksichtige: den Stand aus v2 (Jahr 2), das Szenario des verteilten Sammelns, die Netz-Schutzziele (Vertraulichkeit, Integrität, Verfügbarkeit), grobe Vertrauenszonen, Verfügbarkeitsziele, Scope und Nicht-Ziele des Tracks. Die C#-Referenz `InventarWorkerService` dient als Orientierung, die Lösung bleibt sprachneutral.

**EN:** Prepare a focused specification for the track baseline and network target picture for the Digital Networking specialization. Consider the year-2 (v2) state, the distributed collection scenario, network protection goals (confidentiality, integrity, availability), coarse trust zones, availability targets, and the track scope and non-goals. The C# reference `InventarWorkerService` serves as orientation; the solution stays language-neutral.

## Anforderungen / Requirements

- **R-01:** Der v2-Ausgangsstand und das Netzzielbild sind klar beschrieben und voneinander getrennt.
- **R-02:** Netz-Schutzziele, grobe Vertrauenszonen und Verfügbarkeitsziele sind getrennt dokumentiert.
- **R-03:** Scope, Nicht-Ziele und erste Netz-Nachweispfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift, soweit das Lernziel sprachneutral ist.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Netzgrenzen, Sammel-Agenten, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Verfügbarkeits- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag des Netzzielbilds bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks für Dienst-Hosting oder Netzkommunikation dürfen gewählt, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit DV-, Sicherheits-, Verfügbarkeits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Baseline-Kurzbeschreibung (v2), Netz-Schutzziel-Tabelle, grobe Vertrauenszonen-Liste, Verfügbarkeitsziele, Nicht-Ziele, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DV und der Aufbau auf v2 sind klar sichtbar.
- [ ] Netz-Schutzziele, Vertrauenszonen und Verfügbarkeitsziele sind getrennt sichtbar.
- [ ] Mindestens ein Netz-Nachweispfad (z. B. Verfügbarkeits- oder Segmentnachweis) ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Digital-Networking-Track_01_Track-Baseline-und-Netzzielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine Track-Baseline und ein Netzzielbild der EuFPA-Lernreihe Secure ServiceHarvester Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
