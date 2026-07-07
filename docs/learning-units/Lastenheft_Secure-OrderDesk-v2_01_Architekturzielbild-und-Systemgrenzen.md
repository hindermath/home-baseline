# Lastenheft: Secure OrderDesk v2 01 - Architekturzielbild und Systemgrenzen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Systemgrenzen zwischen Bestellannahme, Katalog, relationaler Ablage und Schnittstelle, Trust Boundaries, Komponenten, ADR-Kandidaten und der Schutzbedarf jeder Komponente werden für den Secure OrderDesk sichtbar. Lernende schneiden die Handelsplattform sauber, bevor Code entsteht. Die Northwind-Bestelldomäne der Kundenfirma Secure Trader inkl. `ALFKI` bleibt der fachliche Kernvertrag.

**EN:** System boundaries between order intake, catalog, relational store, and interface, trust boundaries, components, ADR candidates, and the protection need of each component become visible for the Secure OrderDesk. Learners cut the trading platform cleanly before code exists. The Northwind ordering domain of the client company Secure Trader incl. `ALFKI` stays the shared core contract.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel bis hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel bis hoch | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Projektplanung, sichere Entwicklung, Qualitätssicherung, Betrieb und dokumentierte Bewertung auf dem Niveau ab dem 2. Lehrjahr.

**EN:** The task connects customer task, project planning, secure development, quality assurance, operation, and documented assessment at second-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk v2"): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 8 („Daten systemübergreifend bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk v2"): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 8 ("Daten systemübergreifend bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_03, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für ein sprachneutrales Architekturzielbild des Secure OrderDesk eine fokussierte Spezifikation. Berücksichtige: Systemgrenzen zwischen Bestellannahme (Order Intake), Katalog (Kunden, Produkte, Kategorien), relationaler Ablage (austauschbarer Store) und API (Lese-/Schreibschnittstelle für Bestellungen), Trust Boundaries, Komponenten, ADR-Kandidaten und der Schutzbedarf jeder Komponente werden sichtbar. Die Northwind-Bestelldomäne inkl. `ALFKI` bleibt gültig; halte die spätere Implementierung von diesem Intake getrennt.

**EN:** Prepare a focused specification for a language-neutral architecture target picture of the Secure OrderDesk. Consider: system boundaries between order intake, catalog (customers, products, categories), relational store (swappable), and API (read/write interface for orders), trust boundaries, components, ADR candidates, and the protection need of each component. The Northwind ordering domain incl. `ALFKI` stays valid; keep the later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang und die Komponentengrenzen (Bestellannahme, Katalog, Store, API) sind klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert.
- **R-03:** Test- oder Reviewpfade sind benannt.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; `ALFKI` und alle Erweiterungen sind fiktiv.
- Eingaben, Bestelldaten, Katalogdaten, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Systemkontext (Bestellannahme/Katalog/Store/API), Trust-Boundary-Liste, ADR-Kandidaten, Schutzbedarf je Komponente, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Die vier Komponenten Bestellannahme, Katalog, Store und API sind mit je einer Aufgabe abgegrenzt.
- [ ] Mindestens ein Test- oder Reviewpfad ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein sprachneutrales Architekturzielbild mit Systemgrenzen zwischen Bestellannahme, Katalog, relationalem Store und API der EuFPA-Lernreihe Secure OrderDesk v2 (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
