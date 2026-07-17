# Lastenheft: Secure CaseTracker 00 - Sprachrepo-Projekt-Scaffold

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** Eigenständiger späterer technischer Spec-Kit-Intake vor der ersten fachlichen Aufgabe
- **Sandbox-Bezug / Sandbox relation:** Container-First-Gate ab Unit 00 verbindlich — jeder KI-Agenten-Aufruf im Container/der Sandbox `absdd-image-sandbox`, nie auf dem Arbeitsplatz-Rechner; Grundlage `Secure-Trader-Sandbox-Preflight.md`

> **Vorbedingung / Prerequisite:** Zuerst
> [`START-HERE-FUER-LERNENDE.md`](START-HERE-FUER-LERNENDE.md) und den
> [`Secure-Trader-Sandbox-Preflight`](Secure-Trader-Sandbox-Preflight.md)
> durcharbeiten. Dieser Intake startet noch keinen Spec-Kit-Lauf.

## Lernziel / Learning Goal

**DE:** Lernende können ein minimales, lauffähiges Sprachrepo so vorbereiten, dass spätere fachliche Secure-CaseTracker-Aufgaben auf einer sauberen Build-, Test-, Dokumentations- und Governance-Basis starten.

**EN:** Learners can prepare a minimal runnable language repository so later Secure CaseTracker tasks start from a clean build, test, documentation, and governance baseline.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Primär | Welche minimale Struktur braucht die Sprache, damit spätere Fachlogik sauber ergänzt werden kann? |
| SI | Primär | Welche Toolchain-, Sandbox- oder Pfadannahme muss vor dem ersten Fachlauf klar sein? |
| DPA | Sekundär | Welche Datenannahmen dürfen im Gerüst noch nicht vorweggenommen werden? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt Arbeitsorganisation, Einrichtung einer Entwicklungsumgebung, Versionsverwaltung, Qualitätssicherung und dokumentierte Vorbereitung für spätere Kundenaufträge.

**EN:** The task supports work organization, development environment setup, version control, quality assurance, and documented preparation for later customer tasks.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 1 („Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; berührt LF 2 („Arbeitsplätze nach Kundenwunsch ausstatten") und LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen", wegen Container-First-Gate). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_00_Sprachrepo-Projekt-Scaffold.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 1 ("Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; touched LF 2 ("Arbeitsplätze nach Kundenwunsch ausstatten") and LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen", because of the container-first gate). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_00_Sprachrepo-Projekt-Scaffold.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Entwicklungsumgebung, MSL-Präferenz, sichere Code-Erzeugung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Programmierung, Leitlinie Sichere Entwicklungs-Sandbox, `Secure-Trader-Sandbox-Preflight.md` (Container-First-Gate), Kompetenzprofile und Schulungsplan.
- **Presets:** alle sieben Governance-Presets als lokale Arbeits- und Nachweisbasis.

## Aufgabenstellung / Task

**DE:** Erzeuge oder prüfe in einem bereits vorbereiteten Level-2-Sprachrepo ein minimales lauffähiges Projekt für genau eine Zielsprache. Dieses Projekt enthält noch keine fachliche Secure-CaseTracker-Logik. Es stellt nur sicher, dass Build, Tests, Dokumentation, Secure-Development-Basis und Governance-Presets vor der ersten fachlichen Lerneinheit funktionieren. Halte das Gerüst im 1. Lehrjahr bewusst einfach.

**EN:** Create or verify a minimal runnable project in one prepared level-2 language repository for exactly one target language. This project does not contain Secure CaseTracker domain logic yet. It only ensures that build, tests, documentation, the secure-development baseline, and governance presets work before the first functional learning unit. Keep the scaffold deliberately simple in year 1.

**DE:** Wenn im Scaffold-Schritt ein KI-Agent genutzt wird, gilt das Container-First-Gate: Der Agenten-Aufruf erfolgt in der freigegebenen Sandbox/im Container (`absdd-image-sandbox`), nie auf dem Arbeitsplatz-Rechner. Führe vor dem ersten Agenten-Aufruf die Preflight-Checkliste aus `Secure-Trader-Sandbox-Preflight.md` durch.

**EN:** If an AI agent is used in the scaffold step, the container-first gate applies: the agent invocation happens in the approved sandbox/container (`absdd-image-sandbox`), never on the workstation. Run the preflight checklist from `Secure-Trader-Sandbox-Preflight.md` before the first agent invocation.

## Anforderungen / Requirements

- **R-01:** Ein minimales lauffähiges Projekt für genau eine der sechs Zielsprachen ist vorhanden oder wird angelegt.
- **R-02:** Lokale Build- und Testbefehle sind vollständig dokumentiert und reproduzierbar.
- **R-03:** Die sieben Governance-Presets sind installiert oder als Blocker mit konkretem Behebungsweg dokumentiert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert: fachliche Rollen, Persistenz, API, Import, Export und Kennzahlen sind in diesem Schritt `N/A`, weil nur das Projektgerüst vorbereitet wird; Cloud, KI-Runtime und produktiver Betrieb sind `N/A`, solange nur ein lokales Lernrepo vorbereitet wird; jede `N/A`-Entscheidung nennt kurz, warum sie für diesen Spec-Kit-Lauf nicht greift.
- **R-05:** Der Gerüst-Zweck bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.
- **R-06 (Container-First-Gate):** Wird ein KI-Agent genutzt, erfolgt der Aufruf ausschließlich in der freigegebenen Sandbox/im Container (`absdd-image-sandbox`), nie auf dem Arbeitsplatz-Rechner. Die Preflight-Checkliste aus `Secure-Trader-Sandbox-Preflight.md` ist vor dem ersten Agenten-Aufruf abgearbeitet; wird kein Agent genutzt, wird dies als `N/A` mit Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten, Secrets oder produktiven Konfigurationen anlegen; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Keine Fachlogik vorwegnehmen, die in den Aufgaben `01` bis `11` spezifiziert wird.
- Build- und Testbefehle müssen dokumentiert sein.
- Die Secure-Development-Basis muss lokal unter `docs/secure-development/` vorhanden oder als fehlend mit Folgeaufgabe dokumentiert sein.
- Die sieben Governance-Presets müssen installiert oder als Blocker mit konkretem Behebungsweg dokumentiert sein.
- Keine personenbezogenen Beispieldaten verwenden; Beispielausgaben bleiben neutral und enthalten keine echten Namen, E-Mail-Adressen, Tokens oder Pfade mit privaten Informationen.
- Nicht benötigte Telemetrie, externe Dienste und Netzwerkzugriffe bleiben ausgeschaltet oder werden als `N/A` mit kurzer technischer Begründung dokumentiert.
- KI-Agenten werden nur im Container/der Sandbox gestartet, nie direkt auf dem Arbeitsplatz-Rechner; Schreibgrenzen, Mounts und Secret-Regeln folgen `Secure-Trader-Sandbox-Preflight.md`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Gerüst-Zweck bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar: bauen, testen, dokumentieren.
- Sprachspezifische Projekt- und Testwerkzeuge dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.
- Sprachspezifische Architekturentscheidungen werden erst in den fachlichen Aufgaben vertieft; der minimale Startpunkt je Sprache ist:

| Sprache | Minimaler Startpunkt |
|---|---|
| C# | `.NET` Console- oder CLI-Projekt mit Testprojekt und `dotnet test`. |
| Go | `go.mod`, kleines CLI-Programm, Basistest und `go test ./...`. |
| Java | Maven- oder Gradle-Projekt mit kleinem CLI-Einstieg und Test. |
| Python | Paket- oder CLI-Struktur mit Testlauf, zum Beispiel `pytest`. |
| Rust | `cargo` Binary-Projekt mit Basistest und `cargo test`. |
| Swift | Swift-Package-Executable mit Basistest und `swift test`. |

## Erwartete Artefakte / Expected Artifacts

- Minimale Projektstruktur für eine der sechs Zielsprachen.
- Dokumentierte lokale Build- und Testbefehle.
- Nachweis der installierten Governance-Presets, zum Beispiel durch Ausgabe von `specify preset list`.
- Lokale Secure-Development-Basis oder dokumentierter Blocker.
- Kurze Entscheidung, warum dieses Projektgerüst für die spätere Lernreihe ausreicht.
- Kurzer Nachweis der Container-First-Preflight-Entscheidung (Agent im Container genutzt oder `N/A` mit Begründung).
- Offene Punkte: fehlende Toolchains, Presets oder Secure-Development-Dateien werden nicht stillschweigend übersprungen, sondern als `Open` mit Folgeaufgabe dokumentiert.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Projekt baut lokal oder der Blocker ist konkret dokumentiert.
- [ ] Der Basistest läuft lokal oder der Blocker ist konkret dokumentiert.
- [ ] Es gibt keine fachliche CaseTracker-Logik in diesem Schritt.
- [ ] Die spätere Aufgabe `01` kann auf dem Projektgerüst aufsetzen.
- [ ] `N/A` und `Open` werden sichtbar mit Begründung dokumentiert.
- [ ] Wird ein KI-Agent genutzt, erfolgt der Aufruf im Container/der Sandbox (nie auf dem Arbeitsplatz-Rechner); die Preflight-Checkliste ist abgearbeitet oder als `N/A` begründet.
- [ ] Nachweise vorhanden: Build-Befehl ausgeführt oder Blocker dokumentiert, Test-Befehl ausgeführt oder Blocker dokumentiert, Prüfung auf fehlende Secrets/echte Kundendaten/produktive Pfade und Prüfung, ob `docs/secure-development/` und Governance-Presets als Arbeitsbasis verfügbar sind.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_00_Sprachrepo-Projekt-Scaffold.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für den technischen Sprachrepo-Scaffold der Secure-CaseTracker-Lernreihe. Lege ein minimales lauffähiges Projekt für die gewählte MSL-Sprache mit Build-/Teststruktur, Secure-Development-Basis und Preset-Nachweis an, aber erzeuge keine fachliche CaseTracker-Logik. Halte das Container-First-Gate fest: Wird ein KI-Agent genutzt, erfolgt der Aufruf im Container/der Sandbox absdd-image-sandbox (nie auf dem Arbeitsplatz-Rechner) gemäß Secure-Trader-Sandbox-Preflight.md, sonst als N/A begründet. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
