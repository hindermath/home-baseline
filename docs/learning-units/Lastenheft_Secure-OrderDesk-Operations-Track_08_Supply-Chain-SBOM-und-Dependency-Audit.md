# Lastenheft: Secure OrderDesk Operations Track 08 - Supply Chain, SBOM und Dependency-Audit

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

**DE:** Die technische Lieferkette der Handelsplattform Secure OrderDesk wird belegt: eine Stückliste der Software (SBOM), ein Dependency-Audit je Zielsprache und eine Bewertung von SBOM, AI-SBOM und VEX. Besonders die Bibliotheken für den relationalen Datenzugriff (parametrisierte Queries) werden erfasst. Lernende begründen, warum bekannte Schwachstellen bewertet und nicht ignoriert werden. Die C#-Referenz `SecureOrderDesk-CSharp` dient nur zur Orientierung.

**EN:** The technical supply chain of the Secure OrderDesk trading platform is evidenced: a software bill of materials (SBOM), a dependency audit per target language, and an assessment of SBOM, AI-SBOM, and VEX. In particular, the libraries for relational data access (parameterized queries) are recorded. Learners justify why known vulnerabilities are assessed rather than ignored. The C# reference `SecureOrderDesk-CSharp` serves only as orientation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| SI | hoch | Wie weist du nach, welche Versionen und Paketquellen im betriebenen Plattform-Build enthalten sind? |
| AE | mittel bis hoch | Welche Bibliothek würdest du ersetzen, wenn sie ungepflegt ist oder eine kritische CVE hat? |
| DPA | mittel | Welche Risiken entstehen, wenn Reporting- oder Datenbank-Bibliotheken für die Handelsdaten ungeprüft bleiben? |
| DV | mittel bis hoch | Welche Registries und Bezugswege sind Teil der Lieferkette? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt die SI-Spezialisierung im 3. Lehrjahr. Sie verbindet Schutzbedarf der Lieferkette, sichere Abhängigkeiten, Nachweise über eingesetzte Komponenten und den sicheren Betrieb der Handelsplattform.

**EN:** The task supports third-year SI specialization. It connects the supply chain's protection need, secure dependencies, evidence of used components, and secure operation of the trading platform.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 11b („Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Begründung: SBOM und Dependency-Audit sind Sicherheitsmaßnahmen für die laufende Plattform; die Bewertung der Lieferkette ist eine Schutzbedarfsfrage. Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-OrderDesk-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 11b ("Betrieb und Sicherheit vernetzter Systeme gewährleisten")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"). Rationale: SBOM and dependency audit are security measures for the running platform; assessing the supply chain is a protection-need question. Deeper explanation and comprehension questions: `lernbegleiter/Secure-OrderDesk-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Supply-Chain-Sicherheit, sichere Abhängigkeiten, MSL-Präferenz, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_12.
- **Mitgeltende Dokumente:** THE-CASE-FOR-MEMORY-SAFE-ROADMAPS, Leitlinie für sichere Programmierung, Lieferketten- und Abhängigkeitsbezug, Supply-Chain-Evidenz.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite für die technische Lieferkette des Secure OrderDesk eine fokussierte Spezifikation für die Spezialisierung SI - Systemintegration. Berücksichtige: Erzeugung und Pflege einer SBOM, ein Dependency-Audit je Zielsprache mit Paketquelle und Audit-Werkzeug, die Benennung der Bibliothek für parametrisierten Datenzugriff, den Umgang mit bekannten Schwachstellen (CVE) sowie die Bewertung von SBOM, AI-SBOM und VEX als `Applicable`, `N/A` oder `Open`. Halte fachliche Lieferanten der Handelsdomäne (Northwind-Tabelle `Suppliers`) klar getrennt von der technischen Software-Lieferkette. Halte die Lösung für C#, Go, Java, Python, Rust und Swift vergleichbar. Die C#-Referenz `SecureOrderDesk-CSharp` dient nur zur Orientierung.

**EN:** Prepare a focused specification for the Secure OrderDesk's technical supply chain for the SI - System Integration specialization. Consider: generating and maintaining an SBOM, a dependency audit per target language with package source and audit tool, naming the library for parameterized data access, handling known vulnerabilities (CVE), and assessing SBOM, AI-SBOM, and VEX as `Applicable`, `N/A`, or `Open`. Keep business suppliers of the trading domain (Northwind `Suppliers` table) clearly separated from the technical software supply chain. Keep the solution comparable across C#, Go, Java, Python, Rust, and Swift. The C# reference `SecureOrderDesk-CSharp` serves only as orientation.

## Anforderungen / Requirements

- **R-01:** Eine SBOM ist als Nachweis eingesetzter Komponenten vorgesehen und je Sprache benannt.
- **R-02:** Je Zielsprache sind Paketquelle, Audit-Werkzeug (z. B. Dependency-Scan) und die Bibliothek für parametrisierten Datenzugriff benannt.
- **R-03:** Der Umgang mit bekannten kritischen Schwachstellen ist beschrieben (bewerten, ersetzen oder begründen).
- **R-04:** SBOM, AI-SBOM und VEX werden als `Applicable`, `N/A` oder `Open` mit Begründung bewertet.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Bekannte kritische Schwachstellen werden nicht ignoriert; ungepflegte Abhängigkeiten werden vermieden oder begründet.
- MSL-Status ersetzt keine Prüfung von Eingabe, I/O, Auth, SQL, Crypto, Logging oder Dependencies; SQL-Injection bleibt unabhängig von der Sprache prüfpflichtig.
- Dependency- und Audit-Nachweise enthalten keine Tokens oder privaten Registry-Zugangsdaten; Secrets nur als Platzhalter `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- SBOM- und Audit-Ausgaben werden vor Veröffentlichung auf sensible Informationen geprüft; fachliche Lieferantendaten bleiben fiktiv (Northwind-Layout).

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Sprache nennt Paketquelle, Audit-Werkzeug und Umgang mit Lockfiles oder Versionsnachweisen.
- Die MSL-Bewertung nutzt dieselbe ehrliche Aussage: Speicherfehler werden reduziert, andere Sicherheitsklassen (inkl. SQL-Injection) bleiben prüfpflichtig.
- `AI-SBOM` ist `N/A`, solange nur Entwicklungswerkzeuge genutzt und keine KI-Runtime in der Plattform ausgeliefert oder betrieben wird.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für die Lieferketten- und SBOM-Bewertung dieser Aufgabe.
- `plan.md` mit Audit-, Sicherheits- und Nachweispfaden.
- `tasks.md` mit umsetzbaren SBOM-, Audit- und Dokumentationsschritten.
- Trennung fachliche Lieferanten / technische Abhängigkeiten, Dependency-Liste, SBOM-Bezug je Sprache, Audit-Werkzeug je Sprache, SBOM-/AI-SBOM-/VEX-Entscheidung.
- Erwartete Evidenz: SBOM-Verweis, Dependency-Tabelle, CVE-Umgang, Applicable-/N/A-/Open-Matrix.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung SI ist klar sichtbar.
- [ ] Alle sechs Zielsprachen sind in der Lieferketten-Bewertung sichtbar.
- [ ] SBOM, AI-SBOM und VEX sind als `Applicable`, `N/A` oder `Open` bewertet.
- [ ] Offene Lücken sind als `Open` mit Folgeaufgabe notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Operations-Track_08_Supply-Chain-SBOM-und-Dependency-Audit.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für SBOM-Erzeugung, Dependency-Audit je Sprache, CVE-Umgang und SBOM-/AI-SBOM-/VEX-Entscheidung der Bestell-/Handelsplattform Secure OrderDesk (Kundenfirma Secure Trader, Northwind-Datenbasis inkl. ALFKI) der EuFPA-Lernreihe Secure OrderDesk Operations Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
