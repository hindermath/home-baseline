# Lastenheft: Secure OrderDesk Application Track 01 - Track-Baseline und Feature-Zielbild

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader (fiktive Handelsfirma / fictional trading company)
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE (Schwerpunkt)
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Ausgehend von der v2-Basis von Secure OrderDesk wird ein belastbares Feature-Zielbild für den Application Track erarbeitet. Lernende trennen die vorhandene Handels-/Bestellplattform (Kunden, Produkte, Bestellungen, Bestellpositionen im Northwind-Layout inkl. `ALFKI`) als Baseline von geplanten Erweiterungen, Nicht-Zielen und Schutzbedarf und begründen Entwurfsentscheidungen mit Trade-offs und Nachweispfaden.

**EN:** Starting from the Secure OrderDesk v2 base, a robust feature target picture for the Application Track is developed. Learners separate the existing trading/ordering platform (customers, products, orders, order lines in Northwind layout incl. `ALFKI`) as a baseline from planned extensions, non-goals, and protection need, and justify design decisions with trade-offs and evidence paths.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch (Schwerpunkt) | Welche Implementierungsentscheidung und welcher Datenvertrag folgen aus diesem Zielbild? |
| SI | mittel | Welche Betriebs-, Toolchain- oder Sandbox-Annahme wird durch die Erweiterung berührt? |
| DPA | mittel | Welche Kunden- oder Bestelldatenqualität verändert sich durch neue Features? |
| DV | mittel | Welche Schnittstelle oder Systemgrenze wächst durch die Erweiterung? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die AE-Spezialisierung im 3. Lehrjahr. Sie verbindet kundenspezifische Anwendungsentwicklung auf der Handelsdomäne, sichere Architektur und auditfähige Dokumentation eines Feature-Zielbilds.

**EN:** The task supports the AE specialization in year 3. It connects customer-specific application development on the trading domain, secure architecture, and audit-ready documentation of a feature target picture.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Professional Tracks"): Der Application Track trägt **LF 10a, LF 11a, LF 12a** (berührt LF 4, LF 5). Für diese Einheit ist **LF 12a („Kundenspezifische Anwendungsentwicklung durchführen")** primär; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Application-Track_01_Track-Baseline-und-Feature-Zielbild.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk Professional Tracks"): the Application Track carries **LF 10a, LF 11a, LF 12a** (touches LF 4, LF 5). For this unit **LF 12a ("Kundenspezifische Anwendungsentwicklung durchführen")** is primary; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Application-Track_01_Track-Baseline-und-Feature-Zielbild.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_02, CL_08, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Architektur- und Entscheidungsdokumentation nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für den Application Track ein fokussiertes Feature-Zielbild auf Basis der Secure-OrderDesk-v2-Baseline. Berücksichtige: welche Baseline vorhanden ist (relationale Handels-/Bestellplattform für Secure Trader auf Northwind-Basis inkl. `ALFKI`), welche Features geplant sind (gut geschnittene Funktionen auf Kunden, Produkten, Bestellungen und Positionen, saubere Persistenz-Adapter mit parametrisierten Queries, wartbarer Viewer/Client, belastbare Tests), welche Nicht-Ziele gelten, welcher Schutzbedarf betroffen ist und welche Trade-offs die zentralen Entwurfsentscheidungen begleiten. Halte das Zielbild als prüfbare Baseline für die folgenden Track-Einheiten fest.

**EN:** Develop a focused feature target picture for the Application Track based on the Secure OrderDesk v2 baseline. Consider: which baseline exists (relational trading/ordering platform for Secure Trader on Northwind base incl. `ALFKI`), which features are planned (well-scoped functions on customers, products, orders, and order lines, clean persistence adapters with parameterized queries, a maintainable viewer/client, robust tests), which non-goals apply, which protection need is affected, and which trade-offs accompany the central design decisions. Fix the target picture as a testable baseline for the following track units.

## Anforderungen / Requirements

- **R-01:** Die vorhandene v2-Baseline und die geplanten Erweiterungen auf der Bestelldomäne sind klar und getrennt beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Mindestens zwei zentrale Entwurfsentscheidungen sind mit Alternative und Trade-off als ADR-Kandidat notiert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als fiktive Quelle benannt.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; `ALFKI` und alle Erweiterungen sind fiktiv.
- Baseline-Schnittstellen, Persistenz, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheits-, Qualitäts- oder Compliance-Aussagen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag des Feature-Zielbilds bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, SQL-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für dieses Feature-Zielbild.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Baseline-Abgrenzung, Feature-Liste, Nicht-Ziele, Schutzbedarf, ADR-Kandidaten-Tabelle mit Trade-offs, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die AE-Spezialisierung und der Bezug zur v2-Baseline sind klar sichtbar.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens zwei Entwurfsentscheidungen sind mit Trade-off begründet.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Application-Track_01_Track-Baseline-und-Feature-Zielbild.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein belastbares Feature-Zielbild des Application Track der EuFPA-Lernreihe Secure OrderDesk Application Track (Kundenfirma Secure Trader, Northwind-Basis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
