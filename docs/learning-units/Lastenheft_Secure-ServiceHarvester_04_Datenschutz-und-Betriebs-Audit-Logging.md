# Lastenheft: Secure ServiceHarvester 04 - Datenschutz und Betriebs-/Audit-Logging

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA, SI, AE, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Betriebs- und Audit-Logging für den Sammel-Dienst wird so geplant, dass es nachvollziehbar bleibt, ohne Secrets, vollständige Freitexte oder unnötige personenbezogene Daten zu protokollieren. Lernende trennen Betriebs-Log, Audit-Log und nutzerseitige Fehlermeldung.

**EN:** Operational and audit logging for the collection service is planned so it stays traceable without recording secrets, complete free text, or unnecessary personal data. Learners separate operational log, audit log, and user-facing error message.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | mittel bis hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Schutzbedarf, Datenschutz, nachvollziehbare Datenverarbeitung und Betriebsdokumentation auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects protection need, privacy, traceable data processing, and operational documentation at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_04_Datenschutz-und-Betriebs-Audit-Logging.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_04_Datenschutz-und-Betriebs-Audit-Logging.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, sichere Protokollierung, Trennung von Log-Ebenen, Review- und Evidenzpflicht.
- **Checklisten:** CL_01, CL_08, CL_09, CL_11.
- **Mitgeltende Dokumente:** Datenschutzleitlinie, Richtlinie Testmanagement, Leitlinie für sichere Programmierung.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Definiere für den Secure ServiceHarvester, welche Ereignisse protokolliert werden: Sammellauf gestartet, Maschine erstmals gesehen, Status geändert, Snapshot gespeichert, Import durchgeführt, Sammellauf gestoppt. Beschreibe getrennt ein Betriebs-Log (Ablauf und Fehler des Dienstes) und ein Audit-Log (sicherheits- und fachrelevante Ereignisse). Lege fest, welche Daten je Log erlaubt sind und welche nicht. Halte den Dienst im 1. Lehrjahr bewusst einfach.

**EN:** Define for the Secure ServiceHarvester which events are logged: collection run started, machine first seen, status changed, snapshot stored, import performed, collection run stopped. Describe separately an operational log (service flow and errors) and an audit log (security- and business-relevant events). Define which data is allowed per log and which is not. Keep the service deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Audit- und Betriebs-Ereignisse sind als feste, benannte Liste beschrieben.
- **R-02:** Erlaubte Log-Felder (Zweck, Zeitpunkt, Aktion, Rolle, technische Referenz) und verbotene Felder (Secrets, Tokens, vollständige Freitexte, unnötige personenbezogene Daten) sind getrennt.
- **R-03:** Log-Injection wird als Risiko behandelt; Steuerzeichen und Zeilenumbrüche werden sicher behandelt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine Secrets, Tokens, Zugangsdaten oder vollständigen Freitexte im Log; Beispielwerte nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Log-Injection verhindern, zum Beispiel durch Bereinigung von Zeilenumbrüchen und strukturiertes Logging.
- Nutzerseitige Fehlermeldungen und interne Logs trennen; keine internen Details an Endnutzer.
- Personenbezug minimieren oder pseudonymisieren; keine echten personenbezogenen Daten verwenden.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Audit-Einträge sind strukturiert und in allen sechs Zielsprachen inhaltlich gleich.
- Das Log ist nachvollziehbar, aber nicht datenhungrig (Datensparsamkeit, Zweckbindung).
- Jede Sprache behandelt Steuerzeichen in Logwerten sicher; Framework-Logging schreibt keine Secrets automatisch mit.
- MSL-Status ersetzt keine sichere Logging-, Datenschutz- oder Review-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Log-Architektur, Datenschutz-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Audit-Event-Liste, erlaubte/verbotene Log-Felder, Datenschutznotiz, Logging-Testfälle, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Jedes Audit-Ereignis hat Zweck und erlaubte Felder; verbotene Inhalte sind ausdrücklich genannt.
- [ ] Betriebs-Log, Audit-Log und nutzerseitige Fehlermeldung sind getrennt sichtbar.
- [ ] Log-Injection wird als Risiko behandelt und mit mindestens einem Test abgedeckt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_04_Datenschutz-und-Betriebs-Audit-Logging.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Datenschutz, Betriebs- und Audit-Events, erlaubte und verbotene Log-Felder, Log-Injection-Schutz und Logging-Tests des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
