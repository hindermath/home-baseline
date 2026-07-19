# Lastenheft: Secure ServiceHarvester Lernreihe

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielgruppe / Audience:** Fachinformatiker*innen und anschlussfähige IT-Berufe in Ausbildung, Ausbilder*innen, Reviewer, KI-Agenten / IT specialist apprentices and related IT occupations, trainers, reviewers, AI agents
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** Dieses Lastenheft ist die Gesamtlandkarte der Basis-Reihe. Die einzelnen Aufgaben-Lastenhefte werden später separat als Spec-Kit-Intakes genutzt.
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox` ist das Zielbild für sichere, reproduzierbare Lern- und Agentenarbeit.
- **Operatives Zielmodell / Operational target model:** späteres privates Level-1-Workspace-Repo mit sechs privaten Level-2-Sprach-Repos.

## Lernziel / Learning Goal

**DE:** Lernende verstehen die Basis-Reihe der Familie Secure ServiceHarvester als strukturiertes Grundlagenprojekt im 1. Lehrjahr. Sie erkennen, wie Richtlinie Sichere Entwicklung, Checklisten, Spec Kit, MSL, Datenschutz, Informationssicherheit, Testbarkeit, Sandbox, ein langlaufender Dienst und kundenorientierte Projektarbeit zusammenwirken. Der durchgehende Faden ist das verantwortliche Arbeiten mit agentischer KI und Spec-Driven Development.

**EN:** Learners understand the base series of the Secure ServiceHarvester family as a structured foundational project in year 1. They see how the Secure Development Guideline, checklists, Spec Kit, MSL, privacy, information security, testability, sandboxing, a long-running service, and customer-oriented project work fit together. The continuous thread is responsible work with agentic AI and Spec-Driven Development.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Die Reihe enthält Domänenmodell, Validierung, Berechtigungen, Persistenz, Tests und sichere Implementierungsentscheidungen. |
| SI | Primär | Die Reihe enthält Sandbox, Dienst-Laufzeit, Toolchain, Secrets, Logging, Supply Chain und reproduzierbare Entwicklungsumgebung. |
| DPA | Primär | Die Reihe enthält Datenschutz, Datenqualität, Betriebskennzahlen, Auswertung und Grenzen der Aussagekraft. |
| DV | Primär | Die Reihe enthält Systemkontext, Maschinen-/Netzbezüge, Trust Boundaries, Verfügbarkeit und sichere Vernetzung. |

**EN:** The series is primary material for all four IT specialist specializations because it connects service behavior, secure runtime, operational data, and machine/network relations in one shared training project.

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Reihe stützt die gemeinsamen IT-Lernfelder zu Kundenauftrag, Arbeitsplatz, Schutzbedarf, Datenverwaltung, Service, systemübergreifender Datenbereitstellung sowie Netzwerken und Diensten. Die konkrete Lernfeldzuordnung je Einheit (00–12) steht in `Rahmenlehrplan-Lernfeld-Mapping.md`.

**EN:** The series supports the shared IT learning fields around customer tasks, workplace context, protection needs, data management, service, cross-system data provisioning, and networks and services. The concrete learning-field mapping per unit (00–12) is documented in `Rahmenlehrplan-Lernfeld-Mapping.md`.

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

**DE:** Dieses Master-Lastenheft beschreibt die Gesamtlandkarte der Basis-Reihe. Die spätere praktische Bearbeitung soll in einer privaten Level-1-/Level-2-Struktur erfolgen:

- **Level 0:** `home-baseline-tmp` als zentrale Quelle für Lernmaterial, Richtlinie, Checklisten, Presets und Intakes.
- **Level 1:** `SecureServiceHarvesterProjects` als privates Koordinations-Repo mit README, Statusmatrix und Abarbeitungsreihenfolge.
- **Level 2:** sechs private Sprach-Repos: `SecureServiceHarvester-CSharp`, `SecureServiceHarvester-Go`, `SecureServiceHarvester-Java`, `SecureServiceHarvester-Python`, `SecureServiceHarvester-Rust`, `SecureServiceHarvester-Swift`.

**DE:** Die Level-2-Namen bezeichnen die lokalen Ordner. Die Repository-Slugs werden durch den Bootstrap lowercase erzeugt, zum Beispiel `secureserviceharvester-csharp`.

**EN:** This master intake describes the overall map of the base series. Later practical work should use a private Level 1 / Level 2 structure:

- **Level 0:** `home-baseline-tmp` as the central source for learning material, guideline, checklists, presets, and intakes.
- **Level 1:** `SecureServiceHarvesterProjects` as the private coordination repository with README, status matrix, and processing order.
- **Level 2:** six private language repositories: `SecureServiceHarvester-CSharp`, `SecureServiceHarvester-Go`, `SecureServiceHarvester-Java`, `SecureServiceHarvester-Python`, `SecureServiceHarvester-Rust`, `SecureServiceHarvester-Swift`.

**EN:** The Level 2 names identify the local folders. The repository slugs are created lowercase by the bootstrap, for example `secureserviceharvester-csharp`.

**DE:** C# ist als erster manueller Referenzpfad vorgesehen. Go, Java, Python, Rust und Swift folgen als Vergleichs- und Vertiefungspfade. Ein KI-Agent bereitet diese Struktur nur vor; die Spec-Kit-Läufe starten später manuell durch Lehrende oder Lernende. Vor Aufgabe `01` gibt es den technischen Startlauf `00`; nach dem Abschluss von Jahr 2 gibt es den Baseline- und Track-Ableitungslauf `12`.

**EN:** C# is planned as the first manual reference path. Go, Java, Python, Rust, and Swift follow as comparison and deeper practice paths. An AI agent only prepares this structure; the Spec Kit runs are started later and manually by instructors or learners. Before task `01`, there is the technical scaffold run `00`; after year 2, there is the baseline and track derivation run `12`.

## Aufgabenstellung / Task

**DE:** Erstelle keine Implementierung. Nutze dieses Lastenheft als Gesamtlandkarte. Spätere Spec-Kit-Läufe starten jeweils mit einem der Aufgaben-Lastenhefte `00` bis `12`. `00` bereitet nur das Sprachrepo vor, `01` bis `11` bearbeiten die fachliche Jahr-1-Reihe, und `12` sichert später den Jahr-2-Stand als Grundlage für Jahr 3.

**EN:** Do not create an implementation from this intake. Use it as the overall map. Later Spec Kit runs start with one of the task intake files `00` to `12`. `00` only prepares the language repository, `01` through `11` cover the functional year-1 series, and `12` later preserves the year-2 state as the basis for year 3.

## Erwartete Artefakte / Expected Artifacts

- Übersicht in `docs/learning-units/Secure-ServiceHarvester-Lernreihe.md`.
- Einzelne Aufgaben-Intakes `docs/learning-units/Lastenheft_Secure-ServiceHarvester_00_*.md` bis `docs/learning-units/Lastenheft_Secure-ServiceHarvester_12_*.md`.
- Lernbegleiter je Einheit unter `docs/learning-units/lernbegleiter/`.
- Berufsbild-Mapping `docs/learning-units/IT-Berufe-Secure-ServiceHarvester-Mapping.md` als Zuordnungs- und Abgrenzungsdokument.
- Unterrichtsleitfaden `docs/learning-units/Secure-ServiceHarvester-Unterrichtsleitfaden.md`.
- Späteres Level-1-Koordinations-Repo mit Statusmatrix und sechs Level-2-Sprach-Repos.
- Keine Feature-Branch-Erzeugung in diesem Schritt.

## Akzeptanzkriterien / Acceptance Criteria

- Alle dreizehn Aufgaben-Lastenhefte (00–12) existieren.
- Jedes Aufgaben-Lastenheft enthält Fachrichtungsbezug, Richtlinienbezug, Sicherheitsanforderungen, Datenschutzanforderungen, Tests, Evidenz und Copy-Paste-Prompt.
- Deutsche Texte verwenden Umlaute und `ß`; Dateinamen bleiben ASCII.
- DE-first, EN-second ist sichtbar.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Lege auch noch keinen Level-1-/Level-2-Arbeitsraum an. Wähle stattdessen in einem bereits vorbereiteten Sprach-Repo das nächste konkrete Aufgaben-Lastenheft der Secure-ServiceHarvester-Basis-Reihe. Bei einem neuen oder leeren Sprachrepo beginne mit `00`; bei fachlicher Jahr-1-Arbeit beginne mit `01`; für die spätere Jahr-2-Baseline nutze `12`.
```
