# Secure OrderDesk Operations Track Unterrichtsleitfaden / Secure OrderDesk Operations Track Teaching Guide

**Stand / Date:** 2026-07-07

## Zweck / Purpose

**DE:** Dieser Leitfaden unterstützt Lehrende bei der Durchführung des SI - Systemintegration-Tracks der Familie Secure OrderDesk im 3. Lehrjahr. Er legt Spezialisierung, erwartete Tiefe, typische Fehler und Nachweisanforderungen für die relationale Handels-/Bestellplattform (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. `ALFKI`) fest.

**EN:** This guide supports instructors when using the System Integration track of the Secure OrderDesk family in the third training year. It defines specialization, expected depth, common mistakes, and evidence needs for the relational trading/ordering platform (client company Secure Trader, Northwind data base incl. `ALFKI`).

## Didaktische Einordnung / Didactic Position

**DE:** Lernende arbeiten im 3. Lehrjahr stärker eigenständig. Sie müssen Betriebsentscheidungen begründen, Risiken benennen, Evidenzpfade angeben und die Grenzen ihrer Aussagen dokumentieren. Der Track baut auf dem Stand `learning/year-2-complete` auf und bleibt sprachneutral; die C#-Referenz `SecureOrderDesk-CSharp` dient nur der Anschauung.

**EN:** In the third training year, learners work more independently. They must justify operational decisions, name risks, provide evidence paths, and document the boundaries of their statements. The track builds on the `learning/year-2-complete` baseline and stays language-neutral; the C# reference `SecureOrderDesk-CSharp` serves only as illustration.

## Sandbox-Erwartung / Sandbox Expectation

**DE:** Ab dem 3. Lehrjahr wird erwartet, dass Lernende KI-gestützte Entwicklung in oder mit `absdd-image-sandbox` planen, nutzen oder begründet abgrenzen können. Das öffentliche Referenz-Repo ist <https://github.com/hindermath/absdd-image-sandbox>. Normale IDE-Arbeit, Lesen und Review dürfen weiterhin außerhalb der Sandbox stattfinden, zum Beispiel mit JetBrains IDEs, VS Code oder Windows-only Visual Studio.

**EN:** From year 3 onward, learners are expected to plan, use, or explicitly bound AI-assisted development in or with `absdd-image-sandbox`. The public reference repository is <https://github.com/hindermath/absdd-image-sandbox>. Normal IDE work, reading, and review may still happen outside the sandbox, for example with JetBrains IDEs, VS Code, or Windows-only Visual Studio.

## Empfohlene Reihenfolge / Recommended Order

| Nr. | Aufgabe | Lehrhinweis |
|---:|---|---|
| 01 | Track-Baseline und Betriebszielbild | Systemgrenzen, Betriebsverantwortung und Baseline-Bezug sichtbar machen. |
| 02 | Datenbank-Deployment (Windows-Service, systemd, launchd) | Plattformgerechten Datenbank- und Dienstlebenszyklus je Zielsystem begründen. |
| 03 | Konfiguration, Secrets und sichere Defaults | Sichere Defaults, Secret-Store-Nutzung und Least Privilege belegen. |
| 04 | Härtung und Angriffsflächen-Reduktion | Ungenutzte Endpunkte und Rechte reduzieren; Härtung nachweisen. |
| 05 | Observability: Logging, Health und Metriken | Logging, Health-Checks und Metriken ohne Datenschutzverletzung planen. |
| 06 | CI/CD-Pipeline und reproduzierbare Builds | Reproduzierbarkeit, Pipeline-Nachweise und Provenance zeigen. |
| 07 | Backup, Recovery und Datenmigration | Wiederherstellung der Northwind-Daten üben; Migrationspfad und Grenzen dokumentieren. |
| 08 | Supply Chain, SBOM und Dependency-Audit | SBOM, CVE-Status und Lieferkettennachweise belegen. |
| 09 | Sandbox, Isolation und Betriebsnachweise | Sandbox-Bezug, Isolation und Betriebsnachweise sichtbar machen. |
| 10 | Betriebs-Review, Runbook und Abschluss | Runbook, Restrisiken und Übergabe strukturiert abschließen. |

## Bewertung / Assessment

- Prüfe, ob die Arbeit klar zur Spezialisierung SI passt.
- Prüfe, ob Betriebsentscheidungen mit Alternativen, Trade-offs und Evidenz begründet werden.
- Prüfe, ob parametrisierte SQL-Zugriffe und der Pflicht-Datensatz `ALFKI` in Betrieb und Wiederherstellung prüfbar bleiben.
- Prüfe, ob `Applicable`, `N/A` und `Open` konsequent genutzt werden.
- Prüfe, ob MSL-Vorteile sichtbar werden, aber keine Secure-Coding-Prüfung ersetzen.
- Prüfe, ob die Sprache DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-freundlich bleibt.
- Prüfe, ob KI-gestützte Schreibarbeit einen Sandbox-Bezug oder eine begründete Abweichung dokumentiert.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
