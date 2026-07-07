# Lastenheft: Secure CaseTracker 10 - Prozessanalyse und Kennzahlen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** DPA, AE, SI

## Lernziel / Learning Goal

**DE:** Lernende können einfache Prozesskennzahlen definieren, berechnen und kritisch bewerten, ohne Datenschutz und Aussagegrenzen zu ignorieren.

**EN:** Learners can define, calculate, and critically assess simple process metrics without ignoring privacy and limits of interpretation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | Sekundär | Welche Berechnung muss deterministisch testbar sein? |
| SI | Ergänzend | Welche Betriebsdaten wären für Kennzahlen nützlich, aber sensibel? |
| DPA | Primär | Welche Kennzahl kann leicht falsch interpretiert werden? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Daten- und Prozessanalyse, Datenqualität, Datenschutz, Bewertung von Ergebnissen und kundenverständliche Darstellung.

**EN:** The task connects data and process analysis, data quality, privacy, assessment of results, and customer-understandable presentation.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 6 („Serviceanfragen bearbeiten")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_10_Prozessanalyse-und-Kennzahlen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 6 ("Serviceanfragen bearbeiten")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_10_Prozessanalyse-und-Kennzahlen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Datenschutz, Zweckbindung, nachvollziehbare Dokumentation.
- **Checklisten:** CL_01, CL_08, CL_11.
- **Presets:** security-governance, a11y-governance.

## Aufgabenstellung / Task

**DE:** Definiere Kennzahlen für offene Fälle, geschlossene Fälle, durchschnittliche Durchlaufzeit, Fehlerquote und Datenqualitätsprobleme. Beschreibe, welche Daten dafür genutzt werden dürfen und welche Aussagegrenzen bestehen.

**EN:** Define metrics for open cases, closed cases, average throughput time, error rate, and data-quality issues. Describe which data may be used and what limits of interpretation exist.

## Anforderungen / Requirements

- **R-01:** Kennzahlen für offene Fälle, geschlossene Fälle, durchschnittliche Durchlaufzeit, Fehlerquote und Datenqualitätsprobleme sind definiert; jede Kennzahl hat Zweck, sprachneutrale Formel und Aussagegrenze.
- **R-02:** Es ist beschrieben, welche Daten für die Kennzahlen genutzt werden dürfen und welche Aussagegrenzen bestehen; personenbezogene Details werden nicht für Lernkennzahlen benötigt.
- **R-03:** Fehlende, fehlerhafte oder widersprüchliche Daten werden sichtbar behandelt, nicht still gefüllt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; Echtzeit-Dashboards sind `N/A`, wenn nur Lernkennzahlen berechnet werden, personenbezogene Auswertungen sind `N/A` ohne reale Rechtsgrundlage und echten Zweck, und Machine Learning ist `N/A`, solange einfache Kennzahlen ausreichen.
- **R-05:** Die Kennzahlen bleiben vergleichbar für C#, Go, Java, Python, Rust und Swift und werten dieselben fiktiven Testdaten gleich aus.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Kennzahlen dürfen keine Rückschlüsse auf echte Personen ermöglichen.
- Aggregierte Werte dürfen keine vertraulichen Details aus Freitexten enthalten.
- Fehlende oder fehlerhafte Daten werden sichtbar behandelt.
- Datenverarbeitung braucht Zweck und Minimierung.
- Personenbezogene Details werden nicht für Lernkennzahlen benötigt.
- Auswertungen enthalten Warnhinweise zu Aussagegrenzen.
- Nicht anwendbare Standards werden als `N/A` mit kurzer technischer Begründung dokumentiert.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Kennzahlenformeln sind unabhängig von der Zielprogrammiersprache.
- Jede Sprache muss dieselben fiktiven Testdaten gleich auswerten.
- Fehlende, fehlerhafte oder widersprüchliche Daten werden sichtbar behandelt.
- Sprachspezifische Datums- und Zeittypen müssen deterministisch getestet werden.
- Rundung, Zeitzonen und fehlende Werte werden je Sprache dokumentiert, wenn sie die Aussage beeinflussen.

## Erwartete Artefakte / Expected Artifacts

- Kennzahlenkatalog.
- Datenqualitätsnotiz.
- Beispielauswertung mit fiktiven Daten.
- Hinweis zu Fehlinterpretationen.
- Liste offener Punkte: unklare Kennzahlen als `Open` vor dem Abschlussreview und Datenschutzfragen zu Auswertungen in der Evidenzmatrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Jede Kennzahl hat Zweck, Formel und Aussagegrenze.
- [ ] Testdaten sind fiktiv und wiederholbar.
- [ ] Datenschutzrisiken sind bewertet.
- [ ] Fehlinterpretationen werden in einfacher Sprache erklärt.
- [ ] Es gibt einen Test für korrekte Zählung offener und geschlossener Fälle sowie einen Test für die Durchlaufzeit mit fehlenden oder ungültigen Daten; Datenschutz- und Aussagegrenzen werden im Review geprüft.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_10_Prozessanalyse-und-Kennzahlen.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Prozesskennzahlen, Datenqualität, Datenschutz, Aussagegrenzen und Tests der Secure-CaseTracker-Lernreihe. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
