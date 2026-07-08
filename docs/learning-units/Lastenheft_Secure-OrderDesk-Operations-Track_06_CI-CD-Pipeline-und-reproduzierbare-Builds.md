# Lastenheft: Secure OrderDesk Operations Track 06 - CI/CD-Pipeline und reproduzierbare Builds

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI - Systemintegration
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Eine CI/CD-Pipeline für die Bestell-/Handelsplattform Secure OrderDesk wird geplant: Stufen, reproduzierbare Builds, festgesetzte Versionen, Datenbank-Migrationsschritte, Build-Herkunft (Provenance) und Release-Nachweise. Lernende begründen, warum ein Build der relationalen Plattform (Northwind inkl. `ALFKI`) wiederholbar und nachvollziehbar sein muss. Die C#-Referenz `InventarWorkerService` dient nur zur Orientierung.

**EN:** A CI/CD pipeline for the Secure OrderDesk ordering/trading platform is planned: stages, reproducible builds, pinned versions, database migration steps, build provenance, and release evidence. Learners justify why a build of the relational platform (Northwind incl. `ALFKI`) must be repeatable and traceable. The C# reference `InventarWorkerService` serves only as orientation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | hoch | Wie weist du nach, dass ein Plattform-Release genau aus dem geprüften Quellstand entstanden ist? |
| AE | mittel bis hoch | Welche Build-, Test- oder Migrationsschritte gehören verpflichtend in die Pipeline? |
| DPA | mittel | Welche Kennzahlen zu Build-Erfolg und Testabdeckung sind auswertbar? |
| DV | mittel bis hoch | Welche Registry-, Netz- oder Datenbank-Deploy-Ziele sind Teil der Pipeline? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Automatisierung von Build und Auslieferung, reproduzierbare Ergebnisse, sichere Lieferkette und auditfähige Release-Nachweise für eine relationale Handelsplattform.

**EN:** The task supports third-year SI specialization. It connects automation of build and delivery, reproducible results, a secure supply chain, and audit-ready release evidence for a relational trading platform.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 10b („Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Begründung: Eine CI/CD-Pipeline automatisiert wiederkehrende Administrations-, Migrations- und Auslieferungsaufgaben und stellt die Handelsplattform reproduzierbar bereit. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 10b ("Serverdienste bereitstellen und Administrationsaufgaben automatisieren")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Rationale: a CI/CD pipeline automates recurring administration, migration, and delivery tasks and provides the trading platform reproducibly. Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Lieferkette, reproduzierbare Builds, Testbarkeit, auditfähige Evidenz, N/A-Begründung.
- **Checklisten:** CL_01, CL_05, CL_08, CL_11, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Testmanagement, Lieferketten- und Abhängigkeitsbezug, Release- und Nachweisdokumentation.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für eine CI/CD-Pipeline des Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: Pipeline-Stufen (Build, Test, Sicherheits- und Dependency-Prüfung, Datenbank-Migration, Paketierung, optionaler Release), reproduzierbare Builds durch festgesetzte Versionen und Lockfiles, Build-Herkunft (Provenance) sowie Release-Nachweise. Nutze `ALFKI` als fiktives Beispiel in Test- und Migrationsdaten (Northwind-Layout). Halte die Lösung für C#, Go, Java, Python, Rust und Swift vergleichbar. Die C#-Referenz `InventarWorkerService` dient nur zur Orientierung.

**EN:** Prepare a focused specification for a CI/CD pipeline of the Secure OrderDesk for the SI - System Integration specialization. Consider: pipeline stages (build, test, security and dependency checks, database migration, packaging, optional release), reproducible builds through pinned versions and lockfiles, build provenance, and release evidence. Use `ALFKI` as a fictional example in test and migration data (Northwind layout). Keep the solution comparable across C#, Go, Java, Python, Rust, and Swift. The C# reference `InventarWorkerService` serves only as orientation.

## Anforderungen / Requirements

- **R-01:** Die Pipeline-Stufen sind klar benannt und in eine sinnvolle Reihenfolge gebracht, inklusive Datenbank-Migrationsschritt.
- **R-02:** Reproduzierbarkeit ist beschrieben: festgesetzte Versionen, Lockfiles oder Versionsnachweise je Zielsprache.
- **R-03:** Sicherheits- und Dependency-Prüfungen sind als Pipeline-Schritt vorgesehen.
- **R-04:** Release-Nachweise (z. B. Build-Herkunft, Artefakt-Prüfsumme, Versionskennung) sind benannt.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten personenbezogenen Kunden- oder Bestelldaten verwenden; Testdaten bleiben fiktiv (Northwind-Layout inkl. `ALFKI`).
- Pipeline-Konfiguration, Build-Skripte, Migrationsskripte, Abhängigkeiten und Artefakte als mögliche Vertrauensgrenzen prüfen.
- Zugangsdaten, Tokens, Datenbank-Verbindungszeichenketten oder Registry-Zugänge niemals im Klartext; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Positive Sicherheits- oder Qualitätsaussagen nur mit Nachweis treffen; nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Pipeline-Vertrag (Stufen, Reproduzierbarkeit, Migration, Nachweise) bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Build-, Migrations- und Audit-Werkzeuge dürfen gewählt werden, müssen aber benannt und begründet werden.
- MSL-Status ersetzt keine sichere Dependency-, Build- oder Release-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die CI/CD-Pipeline dieser Aufgabe.
- `plan.md` mit Pipeline-, Migrations-, Sicherheits-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Build-, Test-, Migrations-, Prüf- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Stufen-Diagramm als Text, Reproduzierbarkeits-Regeln je Sprache, Migrations-Schrittfolge, Release-Nachweisliste, N/A-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Pipeline-Stufen, Reproduzierbarkeit, Datenbank-Migration und Release-Nachweise sind getrennt sichtbar.
- [ ] Für alle sechs Zielsprachen ist Reproduzierbarkeit benannt.
- [ ] Offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_06_CI-CD-Pipeline-und-reproduzierbare-Builds.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für eine CI/CD-Pipeline mit reproduzierbaren Builds, Datenbank-Migrationsschritt, Sicherheits- und Dependency-Prüfungen und Release-Nachweisen der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
