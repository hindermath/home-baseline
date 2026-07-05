# Secure CaseTracker Operations Track Unterrichtsleitfaden / Secure CaseTracker Operations Track Teaching Guide

**Stand / Date:** 2026-07-05

## Zweck / Purpose

**DE:** Dieser Leitfaden unterstützt Lehrende bei der Durchführung des SI - Systemintegration-Tracks im 3. Lehrjahr. Er legt die Spezialisierung, erwartete Tiefe, typische Fehler und Nachweisanforderungen fest.

**EN:** This guide supports instructors when using the System Integration track in the third training year. It defines specialization, expected depth, common mistakes, and evidence needs.

## Didaktische Einordnung / Didactic Position

**DE:** Lernende arbeiten im 3. Lehrjahr stärker eigenständig. Sie müssen Entscheidungen begründen, Risiken benennen, Evidenzpfade angeben und die Grenzen ihrer Aussagen dokumentieren.

**EN:** In the third training year, learners work more independently. They must justify decisions, name risks, provide evidence paths, and document the boundaries of their statements.

## Sandbox-Erwartung / Sandbox Expectation

**DE:** Ab dem 3. Lehrjahr wird erwartet, dass Lernende KI-gestützte Entwicklung in oder mit `absdd-image-sandbox` planen, nutzen oder begründet abgrenzen können. Das öffentliche Referenz-Repo ist <https://github.com/hindermath/absdd-image-sandbox>. Normale IDE-Arbeit, Lesen und Review dürfen weiterhin außerhalb der Sandbox stattfinden, zum Beispiel mit JetBrains IDEs, VS Code oder Windows-only Visual Studio.

**EN:** From year 3 onward, learners are expected to plan, use, or explicitly bound AI-assisted development in or with `absdd-image-sandbox`. The public reference repository is <https://github.com/hindermath/absdd-image-sandbox>. Normal IDE work, reading, and review may still happen outside the sandbox, for example with JetBrains IDEs, VS Code, or Windows-only Visual Studio.

## Empfohlene Reihenfolge / Recommended Order

| Nr. | Aufgabe | Lehrhinweis |
|---:|---|---|
| 01 | Betriebszielbild und Systemgrenzen | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 02 | Sandbox- und Laufzeitprofil | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 03 | CI/CD-Pipeline und Release-Nachweise | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 04 | Secrets, Konfiguration und Least Privilege | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 05 | Logging, Monitoring und Alerting | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 06 | Backup, Restore und Recovery-Übung | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 07 | Incident Response und Betriebsdokumentation | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 08 | Dependency-, SBOM- und Supply-Chain-Nachweise | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 09 | Härtungscheck gegen Richtlinie und Presets | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |
| 10 | Abschlussreview mit Betriebsrisiken und Übergabe | Entscheidung, Nachweis, Risiko und Spezialisierungsbezug sichtbar machen. |

## Bewertung / Assessment

- Prüfe, ob die Arbeit klar zur Spezialisierung SI passt.
- Prüfe, ob Entscheidungen mit Alternativen, Trade-offs und Evidenz begründet werden.
- Prüfe, ob `Applicable`, `N/A` und `Open` konsequent genutzt werden.
- Prüfe, ob MSL-Vorteile sichtbar werden, aber keine Secure-Coding-Prüfung ersetzen.
- Prüfe, ob die Sprache DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-freundlich bleibt.
- Prüfe, ob KI-gestützte Schreibarbeit einen Sandbox-Bezug oder eine begründete Abweichung dokumentiert.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
