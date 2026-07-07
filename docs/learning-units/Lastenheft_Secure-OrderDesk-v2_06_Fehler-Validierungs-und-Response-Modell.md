# Lastenheft: Secure OrderDesk v2 06 - Fehler-, Validierungs- und Response-Modell

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 2. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Einheitliche Validierung, fachliche Fehler, technische Fehler und ein sicheres Fehler- und Response-Modell werden für die Bestell-/Handelsplattform getrennt festgelegt. Bestellannahme und Anfragen an den Service-Vertrag teilen denselben Fehler-Vertrag, ohne interne Details oder Kundendaten preiszugeben. Die Northwind-Datenbasis inkl. `ALFKI` bleibt fiktiver Testanker.

**EN:** Unified validation, business errors, technical errors, and a safe error and response model are defined separately for the ordering/trading platform. Order intake and requests to the service contract share the same error contract without exposing internals or customer data. The Northwind data base including `ALFKI` stays the fictional test anchor.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | mittel bis hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | hoch | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Kundenauftrag, Projektplanung, sichere Entwicklung, Qualitätssicherung, Betrieb und dokumentierte Bewertung auf dem Niveau ab dem 2. Lehrjahr.

**EN:** The task connects customer task, project planning, secure development, quality assurance, operation, and documented assessment at second-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Zuordnung Secure OrderDesk v2"): **primär LF 5 („Software zur Verwaltung von Daten anpassen")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-v2_06_Fehler-Validierungs-und-Response-Modell.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Zuordnung Secure OrderDesk v2"): **primary LF 5 ("Software zur Verwaltung von Daten anpassen")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-v2_06_Fehler-Validierungs-und-Response-Modell.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Architektur, sichere Programmierung, Testbarkeit, Datenschutz, N/A-Begründung und auditfähige Evidenz.
- **Checklisten:** CL_01, CL_03, CL_05, CL_08.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie für sichere Programmierung, Testmanagement, Zugangssteuerung und Lieferkettenbezug nach Bedarf.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für ein einheitliches Fehler-, Validierungs- und Response-Modell des Secure OrderDesk eine fokussierte Spezifikation. Berücksichtige: eine gemeinsame Validierung für Bestellannahme (Kunden, Produkte, Bestellungen, Positionen im Northwind-Layout) und Service-Vertrag, die Trennung von Validierungs-, fachlichen und technischen Fehlern (z. B. „Kunde unbekannt", „Produkt nicht lieferbar", „Menge ungültig"), sichere Rückmeldungen ohne Interna und ohne Kundendaten sowie Negativtests. Nutze `ALFKI` als festen Beispiel- und Testanker. Die C#-Referenz `InventarWorkerService` dient nur zur Orientierung.

**EN:** Prepare a focused specification for a unified error, validation, and response model of the Secure OrderDesk. Consider a shared validation for order intake (customers, products, orders, lines in Northwind layout) and the service contract, the separation of validation, business, and technical errors (e.g. "unknown customer", "product not deliverable", "invalid quantity"), safe responses without internals and without customer data, and negative tests. Use `ALFKI` as a fixed example and test anchor. The C# reference `InventarWorkerService` serves only as orientation.

## Anforderungen / Requirements

- **R-01:** Der fachliche Umfang (Bestellannahme und Service-Vertrag) und die drei Fehlerebenen sind klar beschrieben.
- **R-02:** Sicherheits-, Datenschutz- und Betriebsannahmen sind getrennt dokumentiert; Fehlermeldungen enthalten keine Kundendaten.
- **R-03:** Zu jeder kritischen Regel ist ein Negativtest oder Reviewpfad benannt (inkl. `ALFKI`-Beispiel).
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Fehler-Vertrag und Response-Modell bleiben vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Daten verwenden; Kundenbezug bleibt fiktiv (`ALFKI`).
- Bestellannahme, Service-Eingaben, Konfiguration, Logs und Abhängigkeiten als mögliche Vertrauensgrenzen prüfen.
- Fehlermeldungen geben weder interne Details (SQL-Text, Stack-Traces, Tabellennamen) noch personenbezogene Kundendaten an Endnutzer aus.
- Positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Fehler-Vertrag (Validierung, fachlich, technisch) bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Frameworks dürfen gewählt werden, müssen aber begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Architektur-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Fehlertabelle für Bestellannahme und Service-Vertrag, Negativtests (inkl. `ALFKI`), sichere Meldungen ohne Kundendaten, Logging-Grenzen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 2. Lehrjahr verständlich.
- [ ] Fachliche Entscheidung, Sicherheitsbezug und erwarteter Nachweis sind getrennt sichtbar.
- [ ] Mindestens ein Test- oder Reviewpfad ist benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-v2_06_Fehler-Validierungs-und-Response-Modell.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein einheitliches Fehler-, Validierungs- und Response-Modell der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk v2. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
