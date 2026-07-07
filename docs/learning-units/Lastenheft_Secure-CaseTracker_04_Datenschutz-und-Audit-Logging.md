# Lastenheft: Secure CaseTracker 04 - Datenschutz und Audit-Logging

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA

## Lernziel / Learning Goal

**DE:** Lernende können Audit-Logging planen, ohne unnötige personenbezogene Daten, Secrets oder vertrauliche Inhalte zu protokollieren.

**EN:** Learners can plan audit logging without recording unnecessary personal data, secrets, or confidential content.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Sekundär | Welche Daten werden technisch leicht geloggt, sind aber fachlich unnötig? |
| SI | Sekundär | Wie bleiben Logs im Betrieb nützlich und trotzdem datensparsam? |
| DPA | Primär | Welche Audit-Daten reichen für Prozessauswertung aus? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenschutz, Informationssicherheit, Datenverarbeitung und nachvollziehbare Dokumentation.

**EN:** The task connects privacy, information security, data processing, and traceable documentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_04_Datenschutz-und-Audit-Logging.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_04_Datenschutz-und-Audit-Logging.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, sichere Protokollierung, Review- und Evidenzpflicht.
- **Checklisten:** CL_01, CL_08, CL_09, CL_11.
- **Mitgeltende Dokumente:** Datenschutzleitlinie, Richtlinie Testmanagement.

## Aufgabenstellung / Task

**DE:** Definiere, welche Ereignisse protokolliert werden: Fall angelegt, Status geändert, Bearbeitungsnotiz ergänzt, Fall geschlossen, Import durchgeführt. Beschreibe, welche Daten im Audit-Log stehen dürfen und welche nicht.

**EN:** Define which events are logged: case created, status changed, work note added, case closed, import performed. Describe which data may appear in the audit log and which must not.

## Anforderungen / Requirements

- **R-01:** Die Audit-Ereignisse (Fall angelegt, Status geändert, Bearbeitungsnotiz ergänzt, Fall geschlossen, Import durchgeführt) sind mit Zweck und erlaubten Feldern benannt.
- **R-02:** Erlaubte und verbotene Log-Felder sind ausdrücklich getrennt; Secrets, Tokens, Zugangsdaten und vollständige Freitexte sind ausgeschlossen.
- **R-03:** Log-Injection wird als Risiko behandelt; Steuerzeichen und Zeilenumbrüche in Logwerten werden sicher behandelt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert: produktive Log-Aufbewahrungsfristen sind `N/A`, wenn nur Lern- und Testdaten betrachtet werden; zentrales SIEM ist `N/A`, wenn keine Betriebsintegration geplant wird; jede `N/A`-Entscheidung nennt, was stattdessen als Lernnachweis gilt.
- **R-05:** Die Audit-Fälle und Log-Regeln gelten vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine Secrets, Tokens, Zugangsdaten oder vollständigen Freitexte im Audit-Log.
- Log-Injection verhindern, zum Beispiel durch Bereinigung von Zeilenumbrüchen.
- User-facing Fehler und interne Logs trennen.
- Audit-Log enthält Zweck, Zeitpunkt, Aktion, Rolle und technische Referenz.
- Personenbezug wird minimiert oder pseudonymisiert.
- Testdaten bleiben fiktiv.
- Nicht anwendbare Standards (z. B. produktive Aufbewahrungsfristen, zentrales SIEM) werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Audit-Einträge sind strukturiert.
- Audit-Log ist nachvollziehbar, aber nicht datenhungrig.
- Jede Sprache muss dieselben Audit-Fälle abdecken.
- Jede Sprache nutzt strukturierte Logwerte oder klar getrennte Felder statt zusammengebauter Freitext-Zeilen.
- C#, Go, Java, Python, Rust und Swift müssen Steuerzeichen in Logwerten sicher behandeln.
- Framework-spezifische Logging-Bibliotheken dürfen keine Secrets oder vollständigen Freitexte automatisch mitschreiben.

## Erwartete Artefakte / Expected Artifacts

- Audit-Event-Liste.
- erlaubte und verbotene Log-Felder.
- Datenschutznotiz.
- Logging-Testfälle.
- Offene Punkte: unklare Aufbewahrungs- oder Exportfragen werden als `Open` markiert; offene Datenschutzfragen werden vor Prozessanalyse und Abschlussreview erneut geprüft.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Jedes Audit-Ereignis hat Zweck und erlaubte Felder.
- [ ] Verbotene Log-Inhalte sind ausdrücklich genannt.
- [ ] Log-Injection wird als Risiko behandelt.
- [ ] Datenschutz und Nachvollziehbarkeit sind gemeinsam abgewogen.
- [ ] Nachweise vorhanden: Test, dass Secrets und personenbezogene Beispielwerte nicht im Log erscheinen, Test, dass Zeilenumbrüche oder Steuerzeichen in Logwerten sicher behandelt werden, und ein Review gegen die Datenschutzanforderungen.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_04_Datenschutz-und-Audit-Logging.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Datenschutz, Audit-Events, erlaubte und verbotene Log-Felder, Log-Injection-Schutz und Logging-Tests des Secure CaseTracker. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
