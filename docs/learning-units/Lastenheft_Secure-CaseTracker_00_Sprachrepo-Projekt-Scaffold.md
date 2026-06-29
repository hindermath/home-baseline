# Lastenheft: Secure CaseTracker 00 - Sprachrepo-Projekt-Scaffold

## Metadaten / Metadata

- **Stand / Date:** 2026-06-29
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** Eigenständiger späterer technischer Spec-Kit-Intake vor der ersten fachlichen Aufgabe
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Lernende können ein minimales, lauffähiges Sprachrepo so vorbereiten, dass spätere fachliche Secure-CaseTracker-Aufgaben auf einer sauberen Build-, Test-, Dokumentations- und Governance-Basis starten.

**EN:** Learners can prepare a minimal runnable language repository so later Secure CaseTracker tasks start from a clean build, test, documentation, and governance baseline.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Das Sprachrepo braucht eine minimale Projektstruktur, Testbasis und klare Erweiterungspunkte. |
| SI | Primär | Toolchain, Sandbox, Presets, Build- und Testbefehle müssen nachvollziehbar sein. |
| DPA | Sekundär | Die spätere Arbeit mit Daten und Kennzahlen braucht eine reproduzierbare Projektbasis. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt Arbeitsorganisation, Einrichtung einer Entwicklungsumgebung, Versionsverwaltung, Qualitätssicherung und dokumentierte Vorbereitung für spätere Kundenaufträge.

**EN:** The task supports work organization, development environment setup, version control, quality assurance, and documented preparation for later customer tasks.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Entwicklungsumgebung, MSL-Präferenz, sichere Code-Erzeugung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Programmierung, Leitlinie Sichere Entwicklungs-Sandbox, Kompetenzprofile und Schulungsplan.
- **Presets:** alle sechs Governance-Presets als lokale Arbeits- und Nachweisbasis.

## Aufgabenstellung / Task

**DE:** Erzeuge oder prüfe in einem bereits vorbereiteten Level-2-Sprachrepo ein minimales lauffähiges Projekt für genau eine Zielsprache. Dieses Projekt enthält noch keine fachliche Secure-CaseTracker-Logik. Es stellt nur sicher, dass Build, Tests, Dokumentation, Secure-Development-Basis und Governance-Presets vor der ersten fachlichen Lerneinheit funktionieren.

**EN:** Create or verify a minimal runnable project in one prepared level-2 language repository for exactly one target language. This project does not contain Secure CaseTracker domain logic yet. It only ensures that build, tests, documentation, the secure-development baseline, and governance presets work before the first functional learning unit.

## Sprachpfade / Language Paths

| Sprache | Minimaler Startpunkt |
|---|---|
| C# | `.NET` Console- oder CLI-Projekt mit Testprojekt und `dotnet test`. |
| Go | `go.mod`, kleines CLI-Programm, Basistest und `go test ./...`. |
| Java | Maven- oder Gradle-Projekt mit kleinem CLI-Einstieg und Test. |
| Python | Paket- oder CLI-Struktur mit Testlauf, zum Beispiel `pytest`. |
| Rust | `cargo` Binary-Projekt mit Basistest und `cargo test`. |
| Swift | Swift-Package-Executable mit Basistest und `swift test`. |

## Sicherheitsanforderungen / Security Requirements

- Keine echten Kundendaten, Secrets oder produktiven Konfigurationen anlegen.
- Keine Fachlogik vorwegnehmen, die in den Aufgaben `01` bis `11` spezifiziert wird.
- Build- und Testbefehle müssen dokumentiert sein.
- Die Secure-Development-Basis muss lokal unter `docs/secure-development/` vorhanden oder als fehlend mit Folgeaufgabe dokumentiert sein.
- Die sechs Governance-Presets müssen installiert oder als Blocker mit konkretem Behebungsweg dokumentiert sein.

## Datenschutzanforderungen / Privacy Requirements

- Keine personenbezogenen Beispieldaten verwenden.
- Beispielausgaben bleiben neutral und enthalten keine echten Namen, E-Mail-Adressen, Tokens oder Pfade mit privaten Informationen.
- Nicht benötigte Telemetrie, externe Dienste und Netzwerkzugriffe bleiben ausgeschaltet oder werden als `N/A` begründet.

## Erwartete Artefakte / Expected Artifacts

- Minimale Projektstruktur für eine der sechs Zielsprachen.
- Dokumentierte lokale Build- und Testbefehle.
- Nachweis der installierten Governance-Presets, zum Beispiel durch Ausgabe von `specify preset list`.
- Lokale Secure-Development-Basis oder dokumentierter Blocker.
- Kurze Entscheidung, warum dieses Projektgerüst für die spätere Lernreihe ausreicht.

## Akzeptanzkriterien / Acceptance Criteria

- Das Projekt baut lokal oder der Blocker ist konkret dokumentiert.
- Der Basistest läuft lokal oder der Blocker ist konkret dokumentiert.
- Es gibt keine fachliche CaseTracker-Logik in diesem Schritt.
- Die spätere Aufgabe `01` kann auf dem Projektgerüst aufsetzen.
- `N/A` und `Open` werden sichtbar dokumentiert.

## Tests und Nachweise / Tests and Evidence

- Build-Befehl ausführen oder nachvollziehbaren Blocker dokumentieren.
- Test-Befehl ausführen oder nachvollziehbaren Blocker dokumentieren.
- Prüfen, ob keine Secrets, echten Kundendaten oder produktiven Pfade entstanden sind.
- Prüfen, ob `docs/secure-development/` und Governance-Presets als Arbeitsbasis verfügbar sind.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche minimale Struktur braucht die Sprache, damit spätere Fachlogik sauber ergänzt werden kann?
- **SI:** Welche Toolchain-, Sandbox- oder Pfadannahme muss vor dem ersten Fachlauf klar sein?
- **DPA:** Welche Datenannahmen dürfen noch nicht vorweggenommen werden?

## N/A-Regeln / N/A Rules

- Fachliche Rollen, Persistenz, API, Import, Export und Kennzahlen sind in diesem Schritt `N/A`, weil nur das Projektgerüst vorbereitet wird.
- Cloud, KI-Runtime und produktiver Betrieb sind `N/A`, solange nur ein lokales Lernrepo vorbereitet wird.
- Jede `N/A`-Entscheidung nennt kurz, warum sie für diesen Spec-Kit-Lauf nicht greift.

## Offene Punkte / Open Follow-Ups

- Fehlende Toolchains, Presets oder Secure-Development-Dateien werden nicht stillschweigend übersprungen, sondern als `Open` mit Folgeaufgabe dokumentiert.
- Sprachspezifische Architekturentscheidungen werden erst in den fachlichen Aufgaben vertieft.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_00_Sprachrepo-Projekt-Scaffold.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für den technischen Sprachrepo-Scaffold der Secure-CaseTracker-Lernreihe. Lege ein minimales lauffähiges Projekt für die gewählte MSL-Sprache mit Build-/Teststruktur, Secure-Development-Basis und Preset-Nachweis an, aber erzeuge keine fachliche CaseTracker-Logik.
```
