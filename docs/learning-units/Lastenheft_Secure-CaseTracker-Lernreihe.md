# Lastenheft: Secure CaseTracker Lernreihe

## Metadaten / Metadata

- **Stand / Date:** 2026-06-27
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielgruppe / Audience:** Fachinformatiker*innen in Ausbildung, Ausbilder*innen, Reviewer, KI-Agenten / IT specialist apprentices, trainers, reviewers, AI agents
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

**EN:** The series is primary material for all three specializations because it connects application behavior, secure runtime, and process data in one shared training project.

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Reihe stützt die gemeinsamen IT-Lernfelder zu Kundenauftrag, Arbeitsplatz, vernetzten Systemen, Schutzbedarf, Datenverwaltung, Service, systemübergreifender Datenbereitstellung und fachrichtungsspezifischer Vertiefung. Sie ist bewusst so geschnitten, dass AE, SI und DPA jeweils eigene Schwerpunkte erkennen.

**EN:** The series supports the shared IT learning fields around customer tasks, workplace context, networked systems, protection needs, data management, service, cross-system data provisioning, and specialization-specific depth.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Relevante Richtlinienprinzipien:** sichere Anforderungen, sichere Architektur, sichere Code-Erzeugung, MSL-Präferenz, auditfähige Evidenz.
- **Relevante Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Programmierung, Leitlinie Sichere Entwicklungs-Sandbox, Kompetenzprofile und Schulungsplan.
- **Spec-Kit-Presets:** alle sechs Governance-Presets als Bewertungsrahmen.
- **Evidenz:** Aufgaben-Lastenhefte, spätere `spec.md`, `plan.md`, `tasks.md`, Checklisten und Review-Notizen.

**EN:** The full guideline and the six governance presets are the assessment frame for all later task intakes.

## Operatives Arbeitsmodell / Operational Working Model

**DE:** Dieses Master-Lastenheft beschreibt die Gesamtlandkarte. Die spätere praktische Bearbeitung soll in einer privaten Level-1-/Level-2-Struktur erfolgen:

- **Level 0:** `home-baseline-tmp` als zentrale Quelle für Lernmaterial, Richtlinie, Checklisten, Presets und Intakes.
- **Level 1:** `SecureCaseTrackerProjects` als privates Koordinations-Repo mit README, Statusmatrix und Abarbeitungsreihenfolge.
- **Level 2:** sechs private Sprach-Repos: `SecureCaseTracker-CSharp`, `SecureCaseTracker-Go`, `SecureCaseTracker-Java`, `SecureCaseTracker-Python`, `SecureCaseTracker-Rust`, `SecureCaseTracker-Swift`.

**DE:** Die Level-2-Namen bezeichnen die lokalen Ordner. Die GitHub-Repository-Slugs werden durch den Bootstrap lowercase erzeugt, zum Beispiel `securecasetracker-csharp`.

**EN:** This master intake describes the overall map. Later practical work should use a private Level 1 / Level 2 structure:

- **Level 0:** `home-baseline-tmp` as the central source for learning material, guideline, checklists, presets, and intakes.
- **Level 1:** `SecureCaseTrackerProjects` as the private coordination repository with README, status matrix, and processing order.
- **Level 2:** six private language repositories: `SecureCaseTracker-CSharp`, `SecureCaseTracker-Go`, `SecureCaseTracker-Java`, `SecureCaseTracker-Python`, `SecureCaseTracker-Rust`, `SecureCaseTracker-Swift`.

**EN:** The Level 2 names identify the local folders. The GitHub repository slugs are created lowercase by the bootstrap, for example `securecasetracker-csharp`.

**DE:** C# ist als erster manueller Referenzpfad vorgesehen. Go, Java, Python, Rust und Swift folgen als Vergleichs- und Vertiefungspfade. Codex bereitet diese Struktur nur vor; die Spec-Kit-Läufe starten später manuell durch Lehrende oder Lernende.

**EN:** C# is planned as the first manual reference path. Go, Java, Python, Rust, and Swift follow as comparison and deeper practice paths. Codex only prepares this structure; the Spec Kit runs are started later and manually by instructors or learners.

## Aufgabenstellung / Task

**DE:** Erstelle keine Implementierung. Nutze dieses Lastenheft als Gesamtlandkarte. Spätere Spec-Kit-Läufe starten jeweils mit einem der Aufgaben-Lastenhefte `01` bis `11`.

**EN:** Do not create an implementation from this intake. Use it as the overall map. Later Spec Kit runs start with one of the task intake files `01` to `11`.

## Erwartete Artefakte / Expected Artifacts

- Übersicht in `docs/learning-units/Secure-CaseTracker-Lernreihe.md`.
- Einzelne Aufgaben-Intakes `docs/learning-units/Lastenheft_Secure-CaseTracker_01_*.md` bis `docs/learning-units/Lastenheft_Secure-CaseTracker_11_*.md`.
- Sichtbare Reihenfolge in `Lastenheft_Abarbeitungsreihenfolge.md`.
- Späteres Level-1-Koordinations-Repo mit Statusmatrix und sechs Level-2-Sprach-Repos.
- Keine Feature-Branch-Erzeugung in diesem Schritt.

## Akzeptanzkriterien / Acceptance Criteria

- Alle elf Aufgaben-Lastenhefte existieren.
- Jedes Aufgaben-Lastenheft enthält Fachrichtungsbezug, Richtlinienbezug, Sicherheitsanforderungen, Datenschutzanforderungen, Tests, Evidenz und Copy-Paste-Prompt.
- Deutsche Texte verwenden Umlaute und `ß`; Dateinamen bleiben ASCII.
- DE-first, EN-second ist sichtbar.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Lege auch noch keinen Level-1-/Level-2-Arbeitsraum an. Wähle stattdessen in einem bereits vorbereiteten Sprach-Repo das nächste konkrete Aufgaben-Lastenheft der Secure-CaseTracker-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation.
```
