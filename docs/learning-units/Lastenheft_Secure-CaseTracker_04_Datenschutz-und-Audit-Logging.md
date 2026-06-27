# Lastenheft: Secure CaseTracker 04 - Datenschutz und Audit-Logging

## Metadaten / Metadata

- **Stand / Date:** 2026-06-27
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Lernziel / Learning Goal

**DE:** Lernende können Audit-Logging planen, ohne unnötige personenbezogene Daten, Secrets oder vertrauliche Inhalte zu protokollieren.

**EN:** Learners can plan audit logging without recording unnecessary personal data, secrets, or confidential content.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Sekundär | Logging muss in der Anwendung korrekt ausgelöst werden. |
| SI | Sekundär | Logs sind Betriebs- und Nachweisartefakte. |
| DPA | Primär | Datenschutz, Datenqualität und Zweckbindung sind zentral. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Datenschutz, Informationssicherheit, Datenverarbeitung und nachvollziehbare Dokumentation.

**EN:** The task connects privacy, information security, data processing, and traceable documentation.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, sichere Protokollierung, Review- und Evidenzpflicht.
- **Checklisten:** CL_01, CL_08, CL_09, CL_11.
- **Mitgeltende Dokumente:** Datenschutzleitlinie, Richtlinie Testmanagement.

## Aufgabenstellung / Task

**DE:** Definiere, welche Ereignisse protokolliert werden: Fall angelegt, Status geändert, Bearbeitungsnotiz ergänzt, Fall geschlossen, Import durchgeführt. Beschreibe, welche Daten im Audit-Log stehen dürfen und welche nicht.

**EN:** Define which events are logged: case created, status changed, work note added, case closed, import performed. Describe which data may appear in the audit log and which must not.

## Sicherheitsanforderungen / Security Requirements

- Keine Secrets, Tokens, Zugangsdaten oder vollständigen Freitexte im Audit-Log.
- Log-Injection verhindern, zum Beispiel durch Bereinigung von Zeilenumbrüchen.
- User-facing Fehler und interne Logs trennen.

## Datenschutzanforderungen / Privacy Requirements

- Audit-Log enthält Zweck, Zeitpunkt, Aktion, Rolle und technische Referenz.
- Personenbezug wird minimiert oder pseudonymisiert.
- Testdaten bleiben fiktiv.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Audit-Einträge sind strukturiert.
- Audit-Log ist nachvollziehbar, aber nicht datenhungrig.
- Jede Sprache muss dieselben Audit-Fälle abdecken.

## Sprachspezifische Hinweise / Language-Specific Notes

- Jede Sprache nutzt strukturierte Logwerte oder klar getrennte Felder statt zusammengebauter Freitext-Zeilen.
- C#, Go, Java, Python, Rust und Swift müssen Steuerzeichen in Logwerten sicher behandeln.
- Framework-spezifische Logging-Bibliotheken dürfen keine Secrets oder vollständigen Freitexte automatisch mitschreiben.

## Erwartete Artefakte / Expected Artifacts

- Audit-Event-Liste.
- erlaubte und verbotene Log-Felder.
- Datenschutznotiz.
- Logging-Testfälle.

## Akzeptanzkriterien / Acceptance Criteria

- Jedes Audit-Ereignis hat Zweck und erlaubte Felder.
- Verbotene Log-Inhalte sind ausdrücklich genannt.
- Log-Injection wird als Risiko behandelt.
- Datenschutz und Nachvollziehbarkeit sind gemeinsam abgewogen.

## Tests und Nachweise / Tests and Evidence

- Test, dass Secrets und personenbezogene Beispielwerte nicht im Log erscheinen.
- Test, dass Zeilenumbrüche oder Steuerzeichen in Logwerten sicher behandelt werden.
- Review gegen Datenschutzanforderungen.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche Daten werden technisch leicht geloggt, sind aber fachlich unnötig?
- **SI:** Wie bleiben Logs im Betrieb nützlich und trotzdem datensparsam?
- **DPA:** Welche Audit-Daten reichen für Prozessauswertung aus?

## N/A-Regeln / N/A Rules

- Produktive Log-Aufbewahrungsfristen sind `N/A`, wenn nur Lern- und Testdaten betrachtet werden.
- Zentrales SIEM ist `N/A`, wenn keine Betriebsintegration geplant wird.
- Jede `N/A`-Entscheidung nennt, was stattdessen als Lernnachweis gilt.

## Offene Punkte / Open Follow-Ups

- Unklare Aufbewahrungs- oder Exportfragen werden als `Open` markiert.
- Offene Datenschutzfragen werden vor Prozessanalyse und Abschlussreview erneut geprüft.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_04_Datenschutz-und-Audit-Logging.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Datenschutz, Audit-Events, erlaubte und verbotene Log-Felder, Log-Injection-Schutz und Logging-Tests des Secure CaseTracker. Erzeuge keine Implementierung.
```
