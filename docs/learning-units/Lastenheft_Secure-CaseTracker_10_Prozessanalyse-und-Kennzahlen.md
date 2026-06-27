# Lastenheft: Secure CaseTracker 10 - Prozessanalyse und Kennzahlen

## Metadaten / Metadata

- **Stand / Date:** 2026-06-27
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Lernziel / Learning Goal

**DE:** Lernende können einfache Prozesskennzahlen definieren, berechnen und kritisch bewerten, ohne Datenschutz und Aussagegrenzen zu ignorieren.

**EN:** Learners can define, calculate, and critically assess simple process metrics without ignoring privacy and limits of interpretation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Sekundär | Kennzahlen müssen korrekt aus dem Modell berechnet werden. |
| SI | Ergänzend | Betriebsdaten und Logs können Kennzahlen beeinflussen. |
| DPA | Primär | Datenqualität, Prozessanalyse und Interpretation sind Kern der Aufgabe. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Daten- und Prozessanalyse, Datenqualität, Datenschutz, Bewertung von Ergebnissen und kundenverständliche Darstellung.

**EN:** The task connects data and process analysis, data quality, privacy, assessment of results, and customer-understandable presentation.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, Zweckbindung, nachvollziehbare Dokumentation.
- **Checklisten:** CL_01, CL_08, CL_11.
- **Presets:** security-governance, a11y-governance.

## Aufgabenstellung / Task

**DE:** Definiere Kennzahlen für offene Fälle, geschlossene Fälle, durchschnittliche Durchlaufzeit, Fehlerquote und Datenqualitätsprobleme. Beschreibe, welche Daten dafür genutzt werden dürfen und welche Aussagegrenzen bestehen.

**EN:** Define metrics for open cases, closed cases, average throughput time, error rate, and data-quality issues. Describe which data may be used and what limits of interpretation exist.

## Sicherheitsanforderungen / Security Requirements

- Kennzahlen dürfen keine Rückschlüsse auf echte Personen ermöglichen.
- Aggregierte Werte dürfen keine vertraulichen Details aus Freitexten enthalten.
- Fehlende oder fehlerhafte Daten werden sichtbar behandelt.

## Datenschutzanforderungen / Privacy Requirements

- Datenverarbeitung braucht Zweck und Minimierung.
- Personenbezogene Details werden nicht für Lernkennzahlen benötigt.
- Auswertungen enthalten Warnhinweise zu Aussagegrenzen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Kennzahlenformeln sind unabhängig von der Zielprogrammiersprache.
- Jede Sprache muss dieselben fiktiven Testdaten gleich auswerten.
- Fehlende, fehlerhafte oder widersprüchliche Daten werden sichtbar behandelt.

## Sprachspezifische Hinweise / Language-Specific Notes

- Sprachspezifische Datums- und Zeittypen müssen deterministisch getestet werden.
- Rundung, Zeitzonen und fehlende Werte werden je Sprache dokumentiert, wenn sie die Aussage beeinflussen.

## Erwartete Artefakte / Expected Artifacts

- Kennzahlenkatalog.
- Datenqualitätsnotiz.
- Beispielauswertung mit fiktiven Daten.
- Hinweis zu Fehlinterpretationen.

## Akzeptanzkriterien / Acceptance Criteria

- Jede Kennzahl hat Zweck, Formel und Aussagegrenze.
- Testdaten sind fiktiv und wiederholbar.
- Datenschutzrisiken sind bewertet.
- Fehlinterpretationen werden in einfacher Sprache erklärt.

## Tests und Nachweise / Tests and Evidence

- Test für korrekte Zählung offener und geschlossener Fälle.
- Test für Durchlaufzeit mit fehlenden oder ungültigen Daten.
- Review der Datenschutz- und Aussagegrenzen.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche Berechnung muss deterministisch testbar sein?
- **SI:** Welche Betriebsdaten wären für Kennzahlen nützlich, aber sensibel?
- **DPA:** Welche Kennzahl kann leicht falsch interpretiert werden?

## N/A-Regeln / N/A Rules

- Echtzeit-Dashboards sind `N/A`, wenn nur Lernkennzahlen berechnet werden.
- Personenbezogene Auswertungen sind `N/A`, wenn keine reale Rechtsgrundlage und kein echter Zweck vorliegen.
- Machine Learning ist `N/A`, solange einfache Kennzahlen ausreichend sind.

## Offene Punkte / Open Follow-Ups

- Unklare Kennzahlen werden als `Open` markiert und vor Abschlussreview geklärt.
- Datenschutzfragen zu Auswertungen werden in die Evidenzmatrix übernommen.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_10_Prozessanalyse-und-Kennzahlen.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Prozesskennzahlen, Datenqualität, Datenschutz, Aussagegrenzen und Tests der Secure-CaseTracker-Lernreihe. Erzeuge keine Implementierung.
```
