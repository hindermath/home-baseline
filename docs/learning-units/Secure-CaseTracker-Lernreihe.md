# Secure CaseTracker Lernreihe / Secure CaseTracker Learning Series

**Stand / Date:** 2026-06-27
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen in Ausbildung, Ausbilder*innen, Reviewer und KI-Agenten / IT specialist apprentices, trainers, reviewers, and AI agents
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zielbild / Target Picture

**DE:** Die Lernreihe führt Lernende schrittweise durch sichere Softwareentwicklung. Das Beispielprogramm ist kein fertiges Produkt, sondern ein didaktisches Abschluss- und Integrationsprojekt. Lernende üben, Anforderungen zu verstehen, sichere Entscheidungen zu treffen, Tests zu planen, Datenschutz zu beachten und ihre Entscheidungen so zu dokumentieren, dass andere sie prüfen können.

**EN:** The learning series guides learners step by step through secure software development. The example program is not a finished product but a didactic final and integration project. Learners practice understanding requirements, making secure decisions, planning tests, respecting privacy, and documenting decisions so others can review them.

## Projektidee / Project Idea

**DE:** EuFPA benötigt einen **Secure CaseTracker**. Das System verwaltet Kundenanfragen, betroffene Assets, Bearbeitungsnotizen und einfache Prozesskennzahlen. Die Lösung kann später als CLI, kleine API oder einfache lokale Anwendung umgesetzt werden. Wichtig ist, dass alle Zielsprachen dasselbe fachliche Verhalten abbilden.

**EN:** EuFPA needs a **Secure CaseTracker**. The system manages customer requests, affected assets, work notes, and simple process metrics. The solution may later be implemented as a CLI, small API, or simple local application. The important point is that all target languages implement the same functional behavior.

## Gemeinsamer Kernvertrag / Shared Core Contract

**DE:** Jede spätere Implementierung muss mindestens diese Fähigkeiten bereitstellen:

- Fälle anlegen, ändern und schließen.
- Kundendaten datensparsam speichern.
- Eingaben validieren und verständliche Fehlermeldungen liefern.
- Rollen `learner`, `developer` und `reviewer` unterscheiden.
- Audit-Log ohne Secrets und ohne unnötige personenbezogene Daten führen.
- Daten sicher importieren und exportieren.
- einfache Kennzahlen berechnen: offene Fälle, geschlossene Fälle, Durchlaufzeit, Fehlerquote.
- Tests und Sicherheitsnachweise erzeugen.
- Sandbox-Nutzung, Spec-Kit-Artefakte und Richtlinienbezug dokumentieren.

**EN:** Each later implementation must provide at least these capabilities:

- Create, update, and close cases.
- Store customer data sparingly.
- Validate input and provide understandable error messages.
- Distinguish the roles `learner`, `developer`, and `reviewer`.
- Keep an audit log without secrets and without unnecessary personal data.
- Import and export data safely.
- Calculate simple metrics: open cases, closed cases, throughput time, error rate.
- Produce tests and security evidence.
- Document sandbox use, Spec Kit artifacts, and guideline relation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Bedeutung in der Lernreihe |
|---|---|
| AE – Anwendungsentwicklung | Domänenmodell, Eingabevalidierung, Berechtigungen, Persistenz, Tests und sichere APIs. |
| SI – Systemintegration | Sandbox, Laufzeit, Konfiguration, Logging, Secrets, Supply Chain und Toolchain-Nachweise. |
| DPA – Daten- und Prozessanalyse | Datenschutz, Datenqualität, Kennzahlen, Prozessauswertung und Grenzen der Aussagekraft. |

**EN:** Application Development focuses on the domain model, validation, permissions, persistence, tests, and secure APIs. System Integration focuses on sandboxing, runtime, configuration, logging, secrets, supply chain, and toolchain evidence. Data and Process Analysis focuses on privacy, data quality, metrics, process evaluation, and limits of interpretation.

## Richtlinie Sichere Entwicklung / Secure Development Guideline

**DE:** Die Richtlinie Sichere Entwicklung ist der verbindliche Leitanker. Jede Lerneinheit verlangt sichtbare Bezüge zu Richtlinie, Checklisten, mitgeltenden Dokumenten und den sechs Spec-Kit-Governance-Presets. Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert; offene Punkte werden als `Open` mit Folgeaufgabe markiert.

**EN:** The Secure Development Guideline is the binding anchor. Each learning unit requires visible references to the guideline, checklists, related documents, and the six Spec Kit governance presets. Non-applicable points are documented as `N/A` with rationale; open points are marked as `Open` with follow-up work.

## Reihenfolge der Lerneinheiten / Order of Learning Units

| Nr. | Lerneinheit | Primär geeignet für |
|---:|---|---|
| 01 | Kundenauftrag und Scope | AE |
| 02 | Domänenmodell und Zustände | AE |
| 03 | Eingabevalidierung und Trust Boundaries | AE |
| 04 | Datenschutz und Audit-Logging | DPA |
| 05 | Rollen und Berechtigungen | AE |
| 06 | Persistenz, Import und Export | AE, DPA |
| 07 | Testbarkeit und Qualität | AE |
| 08 | Supply Chain und MSL-Bewertung | SI |
| 09 | Sandbox und agentische Entwicklung | SI |
| 10 | Prozessanalyse und Kennzahlen | DPA |
| 11 | Spec-Kit-Review und Abschluss | AE, SI, DPA |

## Sprachspezifische Adapterhinweise / Language-Specific Adapter Notes

| Sprache | Sichere Umsetzungshinweise |
|---|---|
| C# | `IConfiguration`, sichere Serialisierung, parametrisierte Persistenz, `dotnet test`, Dependency-Audit. |
| Go | `context`, HTTP-/I/O-Timeouts, `govulncheck`, sichere Pfade, klare Fehlerwerte. |
| Java | Bean Validation, sichere Deserialisierung, JUnit, Maven-/Gradle-Audit, parametrisierte Persistenz. |
| Python | Pydantic oder explizite Validierung, keine unsichere Deserialisierung, `pip-audit`, sichere Dateipfade. |
| Rust | Kein `unsafe` ohne Begründung, keine Panic-Pfade aus Eingaben, `cargo audit`, explizite Fehlerwerte. |
| Swift | Keine Force-Unwraps bei Eingaben, Keychain/CryptoKit/File-Scope, XCTest, klare Optional-Behandlung. |

## Erwartete Unterrichtsergebnisse / Expected Teaching Results

**DE:** Nach Abschluss der Reihe sollen Lernende erklären können, warum MSL wichtig sind, warum MSL sichere Entwicklung nicht ersetzen, wie Spec Kit Anforderungen, Planung, Aufgaben und Reviews strukturiert, wie Datenschutz und Informationssicherheit zusammenhängen und wie eine Sandbox sichere KI-gestützte Entwicklung unterstützt.

**EN:** After completing the series, learners should be able to explain why MSL matter, why MSL do not replace secure development, how Spec Kit structures requirements, planning, tasks, and reviews, how privacy and information security relate, and how a sandbox supports secure AI-assisted development.
