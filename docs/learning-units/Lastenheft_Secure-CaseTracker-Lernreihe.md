# Lastenheft: Secure CaseTracker Lernreihe

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielgruppe / Audience:** Fachinformatiker*innen und anschlussfähige IT-Berufe in Ausbildung, Ausbilder*innen, Reviewer, KI-Agenten / IT specialist apprentices and related IT occupations, trainers, reviewers, AI agents
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** Dieses Lastenheft ist die Gesamtlandkarte. Die einzelnen Aufgaben-Lastenhefte werden später separat als Spec-Kit-Intakes genutzt.
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox` ist das Zielbild für sichere, reproduzierbare Lern- und Agentenarbeit.
- **Operatives Zielmodell / Operational target model:** späteres privates Level-1-Workspace-Repo mit sechs privaten Level-2-Sprach-Repos.

## Lernziel / Learning Goal

**DE:** Lernende verstehen die gesamte Secure-CaseTracker-Reihe als strukturiertes Abschluss- und Integrationsprojekt. Sie erkennen, wie Richtlinie Sichere Entwicklung, Checklisten, Spec Kit, MSL, Datenschutz, Informationssicherheit, Testbarkeit, Sandbox und kundenorientierte Projektarbeit zusammenwirken.

**EN:** Learners understand the Secure CaseTracker series as a structured final and integration project. They see how the Secure Development Guideline, checklists, Spec Kit, MSL, privacy, information security, testability, sandboxing, and customer-oriented project work fit together.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Die Reihe enthält Domänenmodell, Validierung, Berechtigungen, Persistenz, Tests und sichere Implementierungsentscheidungen. |
| SI | Primär | Die Reihe enthält Sandbox, Laufzeit, Toolchain, Secrets, Logging, Supply Chain und reproduzierbare Entwicklungsumgebung. |
| DPA | Primär | Die Reihe enthält Datenschutz, Datenqualität, Prozesskennzahlen, Auswertung und Grenzen der Aussagekraft. |
| DV | Primär | Die Reihe enthält Systemkontext, Schnittstellen, Kommunikationsflüsse, Trust Boundaries, Verfügbarkeit und sichere Vernetzung. |

**EN:** The series is primary material for all four IT specialist specializations because it connects application behavior, secure runtime, process data, and digital networking in one shared training project.

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Reihe stützt die gemeinsamen IT-Lernfelder zu Kundenauftrag, Arbeitsplatz, vernetzten Systemen, Schutzbedarf, Datenverwaltung, Service, systemübergreifender Datenbereitstellung und fachrichtungsspezifischer Vertiefung. Sie ist bewusst so geschnitten, dass AE, SI, DPA und DV jeweils eigene Schwerpunkte erkennen.

**EN:** The series supports the shared IT learning fields around customer tasks, workplace context, networked systems, protection needs, data management, service, cross-system data provisioning, and specialization-specific depth.

**DE:** Spec-Kit-Läufe sind begleitende SDD-Aufgaben innerhalb dieser Lernreihe. Sie ersetzen nicht das klassische Erlernen des jeweiligen Berufsbilds, den Berufsschulunterricht, die betriebliche Ausbildung, Ausbilderentscheidungen oder Prüfungsvorbereitung.

**EN:** Spec Kit runs are companion SDD tasks inside this learning series. They do not replace classical learning of the occupation, vocational school, workplace training, trainer decisions, or exam preparation.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Relevante Richtlinienprinzipien:** sichere Anforderungen, sichere Architektur, sichere Code-Erzeugung, MSL-Präferenz, auditfähige Evidenz.
- **Relevante Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Programmierung, Leitlinie Sichere Entwicklungs-Sandbox, Kompetenzprofile und Schulungsplan.
- **Spec-Kit-Presets:** alle acht Governance-Presets als Bewertungsrahmen.
- **Evidenz:** Aufgaben-Lastenhefte, spätere `spec.md`, `plan.md`, `tasks.md`, Checklisten und Review-Notizen.
- **Level-2-Arbeitsbasis:** Jedes Sprachrepo führt die Richtlinie, alle 12 Einzel-Checklisten, den Checklistensammelband, die mitgeltenden Dokumente und die Preset-Verzahnung lokal unter `docs/secure-development/`. Die acht Governance-Presets sind aus der zentralen Matrix installiert und mit `specify preset list` nachweisbar.
- **Selbstprüfung vor Härtung:** Jedes Sprachrepo führt `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` als separaten späteren Intake; MSL-Status ist dabei Prüfpunkt, aber keine Voraussetzung.

**EN:** The full guideline and the eight governance presets are the assessment frame for all later task intakes.

## Operatives Arbeitsmodell / Operational Working Model

**DE:** Dieses Master-Lastenheft beschreibt die Gesamtlandkarte. Die spätere praktische Bearbeitung soll in einer privaten Level-1-/Level-2-Struktur erfolgen:

- **Level 0:** `home-baseline-source` als zentrale Quelle für Lernmaterial, Richtlinie, Checklisten, Presets und Intakes.
- **Level 1:** `SecureCaseTrackerProjects` als privates Koordinations-Repo mit README, Statusmatrix und Abarbeitungsreihenfolge.
- **Level 2:** sechs private Sprach-Repos: `SecureCaseTracker-CSharp`, `SecureCaseTracker-Go`, `SecureCaseTracker-Java`, `SecureCaseTracker-Python`, `SecureCaseTracker-Rust`, `SecureCaseTracker-Swift`.

**DE:** Die Level-2-Namen bezeichnen die lokalen Ordner. Die Repository-Slugs werden durch den Bootstrap lowercase erzeugt, zum Beispiel `securecasetracker-csharp`.

**EN:** This master intake describes the overall map. Later practical work should use a private Level 1 / Level 2 structure:

- **Level 0:** `home-baseline-source` as the central source for learning material, guideline, checklists, presets, and intakes.
- **Level 1:** `SecureCaseTrackerProjects` as the private coordination repository with README, status matrix, and processing order.
- **Level 2:** six private language repositories: `SecureCaseTracker-CSharp`, `SecureCaseTracker-Go`, `SecureCaseTracker-Java`, `SecureCaseTracker-Python`, `SecureCaseTracker-Rust`, `SecureCaseTracker-Swift`.

**EN:** The Level 2 names identify the local folders. The repository slugs are created lowercase by the bootstrap, for example `securecasetracker-csharp`.

**DE:** C# ist als erster manueller Referenzpfad vorgesehen. Go, Java, Python, Rust und Swift folgen als Vergleichs- und Vertiefungspfade. Codex bereitet diese Struktur nur vor; die Spec-Kit-Läufe starten später manuell durch Lehrende oder Lernende. Vor Aufgabe `01` gibt es den technischen Startlauf `00`; nach dem Abschluss von Jahr 2 gibt es den Baseline- und Track-Ableitungslauf `12`.

**EN:** C# is planned as the first manual reference path. Go, Java, Python, Rust, and Swift follow as comparison and deeper practice paths. Codex only prepares this structure; the Spec Kit runs are started later and manually by instructors or learners. Before task `01`, there is the technical scaffold run `00`; after year 2, there is the baseline and track derivation run `12`.

## Aufgabenstellung / Task

**DE:** Erstelle keine Implementierung. Nutze dieses Lastenheft als Gesamtlandkarte. Spätere Spec-Kit-Läufe starten jeweils mit einem der Aufgaben-Lastenhefte `00` bis `12`. `00` bereitet nur das Sprachrepo vor, `01` bis `11` bearbeiten die fachliche Jahr-1-Reihe, und `12` sichert später den Jahr-2-Stand als Grundlage für Jahr 3.

**EN:** Do not create an implementation from this intake. Use it as the overall map. Later Spec Kit runs start with one of the task intake files `00` to `12`. `00` only prepares the language repository, `01` through `11` cover the functional year-1 series, and `12` later preserves the year-2 state as the basis for year 3.

## Erwartete Artefakte / Expected Artifacts

- Übersicht in `docs/learning-units/Secure-CaseTracker-Lernreihe.md`.
- Einzelne Aufgaben-Intakes `docs/learning-units/Lastenheft_Secure-CaseTracker_00_*.md` bis `docs/learning-units/Lastenheft_Secure-CaseTracker_12_*.md`.
- Berufsbild-Mapping `docs/learning-units/IT-Berufe-Secure-CaseTracker-Mapping.md` als Zuordnungs- und Abgrenzungsdokument.
- Spec-Kit-SDD-Auftakt `docs/learning-units/SPEC-KIT-SDD-AUFTAKT.md` als neutrale Startinformation.
- Sichtbare Reihenfolge in `Lastenheft_Abarbeitungsreihenfolge.md`.
- Späteres Level-1-Koordinations-Repo mit Statusmatrix und sechs Level-2-Sprach-Repos.
- Keine Feature-Branch-Erzeugung in diesem Schritt.

## Akzeptanzkriterien / Acceptance Criteria

- Alle dreizehn Aufgaben-Lastenhefte existieren.
- Jedes Aufgaben-Lastenheft enthält Fachrichtungsbezug, Richtlinienbezug, Sicherheitsanforderungen, Datenschutzanforderungen, Tests, Evidenz und Copy-Paste-Prompt.
- Deutsche Texte verwenden Umlaute und `ß`; Dateinamen bleiben ASCII.
- DE-first, EN-second ist sichtbar.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Lege auch noch keinen Level-1-/Level-2-Arbeitsraum an. Wähle stattdessen in einem bereits vorbereiteten Sprach-Repo das nächste konkrete Aufgaben-Lastenheft der Secure-CaseTracker-Reihe. Bei einem neuen oder leeren Sprachrepo beginne mit `00`; bei fachlicher Jahr-1-Arbeit beginne mit `01`; für die spätere Jahr-2-Baseline nutze `12`.
```
