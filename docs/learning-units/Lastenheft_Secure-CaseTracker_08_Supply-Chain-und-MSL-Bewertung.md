# Lastenheft: Secure CaseTracker 08 - Supply Chain und MSL-Bewertung

## Metadaten / Metadata

- **Stand / Date:** 2026-06-27
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Lernziel / Learning Goal

**DE:** Lernende können Abhängigkeiten prüfen, den Nutzen von Memory-Safe Languages erklären und begründen, warum MSL sichere Entwicklung nicht ersetzen.

**EN:** Learners can review dependencies, explain the value of memory-safe languages, and justify why MSL do not replace secure development.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Sekundär | Entwickler*innen wählen Bibliotheken und müssen Risiken verstehen. |
| SI | Primär | Toolchains, Paketquellen, Scans und SBOM sind Betriebs- und Lieferkettenthemen. |
| DPA | Ergänzend | Datenanalyse hängt von vertrauenswürdigen Werkzeugen und Bibliotheken ab. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Toolchain-Verständnis, sichere Lieferkette, Schutzbedarf und Bewertung von Entwicklungswerkzeugen.

**EN:** The task connects toolchain understanding, secure supply chain, protection needs, and assessment of development tools.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** MSL-Präferenz, Supply-Chain-Sicherheit, sichere Code-Erzeugung.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09.
- **Mitgeltende Dokumente:** THE-CASE-FOR-MEMORY-SAFE-ROADMAPS, Leitlinie Sichere Programmierung.
- **Presets:** security-governance, cross-platform-governance.

## Aufgabenstellung / Task

**DE:** Definiere für jede Zielsprachengruppe, wie Abhängigkeiten erfasst und geprüft werden. Dokumentiere, dass C#, Go, Java, Python, Rust und Swift in dieser Lernreihe als MSL-Zielsprachen behandelt werden. Beschreibe zusätzlich, welche Sicherheitsklassen MSL nicht automatisch lösen.

**EN:** Define how dependencies are recorded and reviewed for each target language. Document that C#, Go, Java, Python, Rust, and Swift are treated as MSL target languages in this learning series. Also describe which security classes MSL do not solve automatically.

## Sicherheitsanforderungen / Security Requirements

- Neue Abhängigkeiten brauchen Zweck und Quelle.
- Bekannte kritische Schwachstellen werden nicht ignoriert.
- Lockfiles oder vergleichbare Versionsnachweise werden eingeplant.
- MSL-Status ersetzt keine Prüfung von Eingabe, I/O, Auth, SQL, Crypto, Logging oder Dependencies.

## Datenschutzanforderungen / Privacy Requirements

- Dependency- und Toolchain-Nachweise enthalten keine Tokens oder privaten Registry-Zugangsdaten.
- Paketquellen und Audit-Ausgaben werden vor Veröffentlichung auf sensible Informationen geprüft.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Jede Sprache nennt Paketquelle, Audit-Werkzeug und Umgang mit Lockfiles oder Versionsnachweisen.
- Die MSL-Bewertung nutzt dieselbe Aussage: Speicherfehler werden reduziert, andere Sicherheitsklassen bleiben prüfpflichtig.
- `AI-SBOM` ist `N/A`, solange nur Entwicklungswerkzeuge genutzt und keine KI-Runtime ausgeliefert wird.

## Sprachspezifische Hinweise / Language-Specific Notes

- **C#:** NuGet-Audit oder gleichwertiger Nachweis.
- **Go:** `govulncheck`.
- **Java:** Maven-/Gradle-Audit oder OWASP Dependency-Check.
- **Python:** `pip-audit` oder gleichwertig.
- **Rust:** `cargo audit`.
- **Swift:** Swift Package Manager, Plattformhinweise und Abhängigkeitsprüfung dokumentieren.

## Erwartete Artefakte / Expected Artifacts

- Dependency-Liste.
- MSL-Bewertung.
- Audit-Werkzeug je Sprache.
- SBOM- oder `N/A`-Entscheidung mit Begründung.

## Akzeptanzkriterien / Acceptance Criteria

- Alle sechs Zielsprachen sind in der Toolchain-Bewertung sichtbar.
- Jede Abhängigkeit hat Zweck, Quelle und Risikohinweis.
- MSL wird nicht als pauschale Sicherheitsfreigabe formuliert.
- SBOM, AI-SBOM und VEX werden als `Applicable`, `N/A` oder `Open` bewertet.

## Tests und Nachweise / Tests and Evidence

- Review prüft, ob jede Abhängigkeit einen Zweck hat.
- Review prüft, ob MSL nicht als pauschale Sicherheitsfreigabe missverstanden wird.
- Offene Toolchain-Lücken werden als `Open` dokumentiert.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche Bibliothek würdest du vermeiden, wenn sie ungepflegt ist?
- **SI:** Wie beweist du, welche Versionen im Build verwendet wurden?
- **DPA:** Welche Risiken entstehen, wenn Analysebibliotheken ungeprüft bleiben?

## N/A-Regeln / N/A Rules

- AI-SBOM ist `N/A`, wenn keine KI-Runtime, kein Modell und keine KI-Komponente ausgeliefert oder betrieben wird.
- VEX ist `N/A`, wenn keine bekannte Schwachstelle bewertet werden muss.
- SBOM kann `Open` sein, wenn Tooling für die Sprache noch nicht festgelegt ist.

## Offene Punkte / Open Follow-Ups

- Fehlende Audit-Werkzeuge werden als `Open` je Sprache notiert.
- Unklare Paketquellen oder Lockfile-Regeln werden vor Implementierung geklärt.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_08_Supply-Chain-und-MSL-Bewertung.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Dependency-Erfassung, Audit-Werkzeuge, MSL-Bewertung, SBOM-/N/A-Entscheidung und sichere Lieferkettennachweise der Secure-CaseTracker-Lernreihe. Erzeuge keine Implementierung.
```
