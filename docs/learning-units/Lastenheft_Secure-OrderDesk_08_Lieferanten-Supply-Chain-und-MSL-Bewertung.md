# Lastenheft: Secure OrderDesk 08 - Lieferanten, Supply Chain und MSL-Bewertung

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** SI, AE, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

## Lernziel / Learning Goal

**DE:** Fachliche Lieferanten der Handelsdomäne und technische Software-Abhängigkeiten der Plattform werden bewusst getrennt und jeweils mit Zweck, Quelle und Risiko erfasst. Lernende erklären den Nutzen speichersicherer Sprachen (Memory-Safe Languages, MSL) und begründen, warum MSL eine sichere Lieferkette und sichere Entwicklung nicht ersetzen.

**EN:** Business suppliers in the trading domain and technical software dependencies of the platform are deliberately separated and each recorded with purpose, source, and risk. Learners explain the value of memory-safe languages (MSL) and justify why MSL do not replace a secure supply chain and secure development.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | hoch | Wie beweist du, welche Versionen und Paketquellen im Build der Plattform verwendet wurden? |
| AE | mittel bis hoch | Welche Bibliothek würdest du vermeiden, wenn sie ungepflegt ist? |
| DPA | mittel bis hoch | Welche Risiken entstehen, wenn Reporting- oder Datenbibliotheken für die Handelsdaten ungeprüft bleiben? |
| DV | mittel bis hoch | Welche bereitgestellten Paketquellen oder Registries sind Teil der technischen Lieferkette? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet fachliches Lieferantenverständnis in der Northwind-Handelsdomäne, sichere technische Lieferkette, Schutzbedarf und die Bewertung von Entwicklungswerkzeugen für eine relationale Bestell-/Handelsplattform.

**EN:** The task connects business supplier understanding in the Northwind trading domain, a secure technical supply chain, protection needs, and the assessment of development tools for a relational ordering/trading platform.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk_08_Lieferanten-Supply-Chain-und-MSL-Bewertung.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk_08_Lieferanten-Supply-Chain-und-MSL-Bewertung.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** MSL-Präferenz, Supply-Chain-Sicherheit, sichere Code-Erzeugung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09.
- **Mitgeltende Dokumente:** THE-CASE-FOR-MEMORY-SAFE-ROADMAPS, Leitlinie für sichere Programmierung, Lieferketten- und Abhängigkeitsbezug.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Trenne zuerst die fachliche Lieferantensicht (Northwind-Tabelle `Suppliers`, die Produkte für Secure Trader liefern) von der technischen Software-Lieferkette (Bibliotheken und Pakete der Plattform). Definiere für jede Zielsprachengruppe, wie technische Abhängigkeiten erfasst und geprüft werden. Dokumentiere je Sprache Paketquelle, Audit-Werkzeug und Umgang mit Lockfiles oder Versionsnachweisen und benenne, welche Bibliotheken den relationalen Datenzugriff (parametrisierte Queries) übernehmen. Halte fest, dass C#, Go, Java, Python, Rust und Swift in dieser Lernreihe als MSL-Zielsprachen behandelt werden, und beschreibe zusätzlich, welche Sicherheitsklassen MSL nicht automatisch lösen (z. B. SQL-Injection). Bewerte SBOM, AI-SBOM und VEX als `Applicable`, `N/A` oder `Open`.

**EN:** First separate the business supplier view (Northwind `Suppliers` table, providing products for Secure Trader) from the technical software supply chain (platform libraries and packages). For each target language group, define how technical dependencies are recorded and reviewed. Per language, document the package source, audit tool, and handling of lockfiles or version evidence, and name which libraries handle relational data access (parameterized queries). Record that C#, Go, Java, Python, Rust, and Swift are treated as MSL target languages in this learning series, and also describe which security classes MSL do not solve automatically (e.g. SQL injection). Assess SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open`.

## Anforderungen / Requirements

- **R-01:** Fachliche Lieferanten (Handelsdomäne) und technische Abhängigkeiten (Software) sind klar getrennt; neue Abhängigkeiten haben Zweck, Quelle und einen Risikohinweis.
- **R-02:** Je Zielsprache sind Paketquelle, Audit-Werkzeug und Lockfile-/Versionsnachweis benannt, inklusive der Bibliothek für parametrisierten Datenzugriff.
- **R-03:** Die MSL-Bewertung nutzt für alle sechs Sprachen dieselbe ehrliche Aussage und keine pauschale Sicherheitsfreigabe.
- **R-04:** SBOM, AI-SBOM und VEX werden als `Applicable`, `N/A` oder `Open` mit Begründung bewertet.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Bekannte kritische Schwachstellen werden nicht ignoriert; ungepflegte Abhängigkeiten werden vermieden oder begründet.
- MSL-Status ersetzt keine Prüfung von Eingabe, I/O, Auth, SQL, Crypto, Logging oder Dependencies; SQL-Injection bleibt unabhängig von der Sprache prüfpflichtig.
- Dependency- und Toolchain-Nachweise enthalten keine Tokens oder privaten Registry-Zugangsdaten; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Paketquellen und Audit-Ausgaben werden vor Veröffentlichung auf sensible Informationen geprüft; fachliche Lieferantendaten bleiben fiktiv (Northwind-Layout).

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Sprache nennt Paketquelle, Audit-Werkzeug und Umgang mit Lockfiles oder Versionsnachweisen.
- Die MSL-Bewertung nutzt dieselbe Aussage: Speicherfehler werden reduziert, andere Sicherheitsklassen (inkl. SQL-Injection) bleiben prüfpflichtig.
- `AI-SBOM` ist `N/A`, solange nur Entwicklungswerkzeuge genutzt und keine KI-Runtime in der Plattform ausgeliefert oder betrieben wird.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Lieferketten- und MSL-Bewertung dieser Aufgabe.
- `plan.md` mit Audit-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Audit- und Dokumentationsschritten.
- Trennung fachliche Lieferanten / technische Abhängigkeiten, Dependency-Liste, MSL-Bewertung, Audit-Werkzeug je Sprache, SBOM-/AI-SBOM-/VEX-Entscheidung.
- Erwartete Evidenz: Dependency-Tabelle, MSL-Aussage für alle sechs Sprachen, Applicable-/N/A-/Open-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Fachliche Lieferanten und technische Abhängigkeiten sind getrennt sichtbar.
- [ ] Alle sechs Zielsprachen sind in der Toolchain-Bewertung sichtbar.
- [ ] Jede Abhängigkeit hat Zweck, Quelle und Risikohinweis.
- [ ] MSL wird nicht als pauschale Sicherheitsfreigabe formuliert; SQL-Injection bleibt genannt.
- [ ] SBOM, AI-SBOM und VEX sind als `Applicable`, `N/A` oder `Open` bewertet.
- [ ] Offene Toolchain-Lücken sind als `Open` mit Folgeaufgabe notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_08_Lieferanten-Supply-Chain-und-MSL-Bewertung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die Trennung fachlicher Lieferanten und technischer Abhängigkeiten, Dependency-Erfassung, Audit-Werkzeuge je Sprache, MSL-Bewertung, SBOM-/AI-SBOM-/VEX-Entscheidung und sichere Lieferkettennachweise der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI). Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
