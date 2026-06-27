# Lastenheft: Secure CaseTracker Lernreihe

## Metadaten / Metadata

- **Stand / Date:** 2026-06-27
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielgruppe / Audience:** Fachinformatiker*innen in Ausbildung, Ausbilder*innen, Reviewer, KI-Agenten / IT specialist apprentices, trainers, reviewers, AI agents
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** Dieses Lastenheft ist die Gesamtlandkarte. Die einzelnen Aufgaben-Lastenhefte werden später separat als Spec-Kit-Intakes genutzt.
- **Sandbox-Bezug / Sandbox relation:** `absdd-image-sandbox` ist das Zielbild für sichere, reproduzierbare Lern- und Agentenarbeit.

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

## Aufgabenstellung / Task

**DE:** Erstelle keine Implementierung. Nutze dieses Lastenheft als Gesamtlandkarte. Spätere Spec-Kit-Läufe starten jeweils mit einem der Aufgaben-Lastenhefte `01` bis `11`.

**EN:** Do not create an implementation from this intake. Use it as the overall map. Later Spec Kit runs start with one of the task intake files `01` to `11`.

## Erwartete Artefakte / Expected Artifacts

- Übersicht in `docs/learning-units/Secure-CaseTracker-Lernreihe.md`.
- Einzelne Aufgaben-Intakes `Lastenheft_Secure-CaseTracker_01_*.md` bis `Lastenheft_Secure-CaseTracker_11_*.md`.
- Sichtbare Reihenfolge in `Lastenheft_Abarbeitungsreihenfolge.md`.
- Keine Feature-Branch-Erzeugung in diesem Schritt.

## Akzeptanzkriterien / Acceptance Criteria

- Alle elf Aufgaben-Lastenhefte existieren.
- Jedes Aufgaben-Lastenheft enthält Fachrichtungsbezug, Richtlinienbezug, Sicherheitsanforderungen, Datenschutzanforderungen, Tests, Evidenz und Copy-Paste-Prompt.
- Deutsche Texte verwenden Umlaute und `ß`; Dateinamen bleiben ASCII.
- DE-first, EN-second ist sichtbar.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze Lastenheft_Secure-CaseTracker-Lernreihe.md nur als Gesamtlandkarte. Starte daraus keinen einzelnen großen Implementierungslauf. Wähle stattdessen das nächste konkrete Aufgaben-Lastenheft der Secure-CaseTracker-Reihe und erstelle dafür eine fokussierte Feature-Spezifikation.
```
