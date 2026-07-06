# Lastenheft: Secure ServiceHarvester 00 - Sprachrepo-Projekt-Scaffold

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer technischer Spec-Kit-Intake vor der ersten fachlichen Aufgabe
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Lernende können ein minimales, lauffähiges Sprachrepo so vorbereiten, dass spätere fachliche Secure-ServiceHarvester-Aufgaben auf einer sauberen Build-, Test-, Dokumentations- und Governance-Basis starten. Die C#-Referenz ist das Worker-Service-Projekt `InventarWorkerService`.

**EN:** Learners can prepare a minimal runnable language repository so later Secure ServiceHarvester tasks start from a clean build, test, documentation, and governance baseline. The C# reference is the worker-service project `InventarWorkerService`.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche minimale Projektstruktur braucht die Sprache, damit spätere Dienst-Logik sauber ergänzt werden kann? |
| SI | hoch | Welche Toolchain-, Sandbox- oder Pfadannahme muss vor dem ersten Fachlauf klar sein? |
| DPA | mittel bis hoch | Welche Datenannahmen zu Statusdaten dürfen im Gerüst noch nicht vorweggenommen werden? |
| DV | mittel bis hoch | Welche Schnittstellen- oder Kommunikationsannahme des späteren Dienstes bleibt in diesem Schritt bewusst offen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt Arbeitsorganisation, Einrichtung einer Entwicklungsumgebung, Versionsverwaltung, Qualitätssicherung und dokumentierte Vorbereitung für spätere Kundenaufträge auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task supports work organization, development environment setup, version control, quality assurance, and documented preparation for later customer tasks at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 1 („Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; berührt LF 2 („Arbeitsplätze nach Kundenwunsch ausstatten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_00_Sprachrepo-Projekt-Scaffold.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 1 ("Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; touched LF 2 ("Arbeitsplätze nach Kundenwunsch ausstatten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_00_Sprachrepo-Projekt-Scaffold.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Entwicklungsumgebung, MSL-Präferenz, sichere Code-Erzeugung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Programmierung, Leitlinie Sichere Entwicklungs-Sandbox, Kompetenzprofile und Schulungsplan.
- **Presets:** alle sechs Governance-Presets als lokale Arbeits- und Nachweisbasis.

## Aufgabenstellung / Task

**DE:** Erzeuge oder prüfe in einem bereits vorbereiteten Level-2-Sprachrepo ein minimales lauffähiges Projekt für genau eine Zielsprache. Dieses Projekt enthält noch keine fachliche Secure-ServiceHarvester-Logik (kein Sammeln, keine Ablage, keine Zustandslogik). Es stellt nur sicher, dass Build, Tests, Dokumentation, Secure-Development-Basis und Governance-Presets vor der ersten fachlichen Lerneinheit funktionieren. Halte das Gerüst im 1. Lehrjahr bewusst einfach.

**EN:** Create or verify a minimal runnable project in one prepared level-2 language repository for exactly one target language. This project does not contain Secure ServiceHarvester domain logic yet (no harvesting, no storage, no state logic). It only ensures that build, tests, documentation, the secure-development baseline, and governance presets work before the first functional learning unit. Keep the scaffold deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Ein minimales lauffähiges Projekt für genau eine der sechs Zielsprachen ist vorhanden oder wird angelegt.
- **R-02:** Lokale Build- und Testbefehle sind vollständig dokumentiert und reproduzierbar.
- **R-03:** Die sechs Governance-Presets sind installiert oder als Blocker mit konkretem Behebungsweg dokumentiert.
- **R-04:** Die Secure-Development-Basis unter `docs/secure-development/` ist vorhanden oder als fehlend mit Folgeaufgabe dokumentiert.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten, Secrets oder produktiven Konfigurationen anlegen; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Keine Fachlogik vorwegnehmen, die in den späteren Aufgaben spezifiziert wird.
- Beispielausgaben bleiben neutral und enthalten keine echten Namen, E-Mail-Adressen, Tokens oder privaten Pfade.
- Nicht benötigte Telemetrie, externe Dienste und Netzwerkzugriffe bleiben ausgeschaltet oder werden als `N/A` mit kurzer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Gerüst-Zweck bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar: bauen, testen, dokumentieren.
- Sprachspezifische Projekt- und Testwerkzeuge dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- Minimale Projektstruktur für eine der sechs Zielsprachen.
- Dokumentierte lokale Build- und Testbefehle.
- Nachweis der installierten Governance-Presets, zum Beispiel durch Ausgabe von `specify preset list`.
- Lokale Secure-Development-Basis oder dokumentierter Blocker.
- Kurze Entscheidung, warum dieses Projektgerüst für die spätere ServiceHarvester-Lernreihe ausreicht.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Projekt baut lokal oder der Blocker ist konkret dokumentiert.
- [ ] Der Basistest läuft lokal oder der Blocker ist konkret dokumentiert.
- [ ] Es gibt keine fachliche ServiceHarvester-Logik in diesem Schritt.
- [ ] Die spätere Aufgabe `01` kann auf dem Projektgerüst aufsetzen.
- [ ] `N/A` und `Open` werden sichtbar mit Begründung dokumentiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_00_Sprachrepo-Projekt-Scaffold.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für den technischen Sprachrepo-Scaffold der EuFPA-Lernreihe Secure ServiceHarvester. Lege ein minimales lauffähiges Projekt für die gewählte MSL-Sprache mit Build-/Teststruktur, Secure-Development-Basis und Preset-Nachweis an, aber erzeuge keine fachliche ServiceHarvester-Logik und starte keinen Sammellauf für die gesamte Lernreihe.
```
