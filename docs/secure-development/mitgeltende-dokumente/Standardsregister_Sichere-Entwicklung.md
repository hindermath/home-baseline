# Standardsregister Sichere Entwicklung / Secure Development Standards Register

**Version / Version:** 1.1.0
**Stand / Date:** 2026-10-19
**Baseline-Version / Baseline version:** 3.4.0
**Verantwortliche Rolle / Responsible role:** Projekt- oder Ausbildungsverantwortung mit Security-Review / Project or training owner with security review
**Review-Zyklus / Review cycle:** mindestens quartalsweise und bei neuen Fassungen / at least quarterly and when new versions are published

## Zweck / Purpose

**DE:** Dieses Register verhindert, dass verschiedene Fassungen eines Standards vermischt werden. Es nennt die in der sicheren-Entwicklung-Basis verwendete Fassung, die offizielle Quelle und den letzten fachlichen Prüftag. Es ersetzt keine Normtexte und keine Rechtsberatung.

**EN:** This register prevents mixing different versions of a standard. It names the version used by the secure-development baseline, the official source, and the last technical review date. It does not replace standards or legal advice.

## Statuslogik / Status Logic

- `Current`: in dieser Basis verwendete aktuelle Fassung.
- `Pinned`: bewusst verwendete, versionierte Fassung; Wechsel braucht Migration.
- `Reference`: ergänzender Bezugsrahmen ohne vollständige Übernahme.
- `Applicability`: projektbezogene Anwendbarkeit muss entschieden werden.

## Register

| Standard / Standard | Fassung / Edition | Quellenprüfung / Source review | Quelle / Source | Versuch / Attempt |
|---|---|---|---|---|
| ISO/IEC 27001 | 2022 + Amd 1:2024 | `BibliographyVerified` | [Primärquelle / primary source](https://www.iso.org/standard/27001) | 2026-10-19 |
| ISO/IEC 27002 | 2022 | `BibliographyVerified` | [Primärquelle / primary source](https://www.iso.org/standard/75652.html) | 2026-10-19 |
| NIST SSDF SP 800-218 | 1.1 Final; 1.2 Initial Public Draft | `Reviewed` | [Primärquelle / primary source](https://csrc.nist.gov/pubs/sp/800/218/final) | 2026-10-19 |
| NIST Zero Trust SP 800-207 | 2020 Final | `Reviewed` | [Primärquelle / primary source](https://csrc.nist.gov/pubs/sp/800/207/final) | 2026-10-19 |
| NIST AI RMF | 1.0 | `Reviewed` | [Primärquelle / primary source](https://www.nist.gov/itl/ai-risk-management-framework) | 2026-10-19 |
| CWE Top 25 | 2025 auf Projektseite / on project page | `Reviewed` | [Primärquelle / primary source](https://cwe.mitre.org/top25/) | 2026-10-19 |
| OWASP ASVS | 5.0.0 | `Reviewed` | [Primärquelle / primary source](https://owasp.org/projects/asvs) | 2026-10-19 |
| OWASP Top 10 Web | 2025 | `Reviewed` | [Primärquelle / primary source](https://top10.owasp.org/2025/) | 2026-10-19 |
| OWASP Top 10 for LLM Applications | 2025 | `Reviewed` | [Primärquelle / primary source](https://genai.owasp.org/llm-top-10/) | 2026-10-19 |
| OWASP SAMM | 2 | `Reviewed` | [Primärquelle / primary source](https://owaspsamm.org/model/) | 2026-10-19 |
| OWASP Cheat Sheet Series | laufend / rolling | `Reviewed` | [Primärquelle / primary source](https://cheatsheetseries.owasp.org/) | 2026-10-19 |
| SLSA | 1.2 | `Reviewed` | [Primärquelle / primary source](https://slsa.dev/spec/v1.2/) | 2026-10-19 |
| CycloneDX | 1.7; tatsächlich erzeugte Fassung gesondert / emitted version separately | `Reviewed` | [Primärquelle / primary source](https://cyclonedx.org/specification/overview/) | 2026-10-19 |
| SPDX | 3.0 laut Übersichtsseite; Tool-Pin gesondert / overview; separate tool pin | `Reviewed` | [Primärquelle / primary source](https://spdx.dev/use/specifications/) | 2026-10-19 |
| BSI TR-02102 | Teilfassung vor Einsatz erneut prüfen / recheck applicable part | `Open` | [Primärquelle / primary source](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/Technische-Richtlinien/TR-nach-Thema-sortiert/tr02102/tr-02102.html) | 2026-10-19 |
| BSI C3A | Fassung offen / edition unresolved | `Open` | [Primärquelle / primary source](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Informationen-und-Empfehlungen/Empfehlungen-nach-Angriffszielen/Cloud-Computing/cloud-computing_node.html) | 2026-10-19 |
| BSI C5 | Fassung offen; 2020 archiviert auffindbar / current unresolved; 2020 archived | `Open` | [Primärquelle / primary source](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Informationen-und-Empfehlungen/Empfehlungen-nach-Angriffszielen/Cloud-Computing/Kriterienkatalog-C5/kriterienkatalog-c5_node.html) | 2026-10-19 |
| EU Cyber Resilience Act | Verordnung (EU) 2024/2847; Kommissionshinweise / Commission guidance | `Partial` | [Primärquelle / primary source](https://digital-strategy.ec.europa.eu/en/policies/cra-summary) | 2026-10-19 |
| EU AI Act | Verordnung (EU) 2024/1689 | `Partial` | [Primärquelle / primary source](https://eur-lex.europa.eu/eli/reg/2024/1689/oj/eng) | 2026-10-19 |
| NIS2 | Richtlinie (EU) 2022/2555 | `Partial` | [Primärquelle / primary source](https://eur-lex.europa.eu/legal-content/EN/TXT/HTML/?uri=CELEX:32022L2555) | 2026-10-19 |
| DORA | Verordnung (EU) 2022/2554 | `Open` | [Primärquelle / primary source](https://eur-lex.europa.eu/eli/reg/2022/2554/oj) | 2026-10-19 |
| G7 Software Bill of Materials for AI | Minimum Elements, 2026; Primärfassung offen / primary edition unresolved | `Open` | [Primärquelle / primary source](https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/KI/SBOM-for-AI_Food-for-thoughts.pdf?__blob=publicationFile&v=6) | 2026-10-19 |
| CISA Memory-Safe Roadmaps | lokale PDF, SHA-256 im Inventar / local PDF hash in inventory | `Open` | [Primärquelle / primary source](https://www.cisa.gov/resources-tools/resources/case-memory-safe-roadmaps) | 2026-10-19 |
| OWASP Proactive Controls | 2024 | `Reviewed` | [Primärquelle / primary source](https://top10proactive.owasp.org/the-top-10/) | 2026-10-19 |
| CA/Browser Forum TLS Baseline Requirements | 2.3.1, 2026-10-04; Abschnitt / section 6.3.2 | `Reviewed` | [Primärquelle / primary source](https://cabforum.org/working-groups/server/baseline-requirements/requirements/) | 2026-10-19 |
| OAuth Security BCP | RFC 9700, 2025 | `Reviewed` | [Primärquelle / primary source](https://www.rfc-editor.org/rfc/rfc9700.html) | 2026-10-19 |
| DSGVO / GDPR | Verordnung (EU) 2016/679 | `Open` | [Primärquelle / primary source](https://eur-lex.europa.eu/eli/reg/2016/679/oj) | 2026-10-19 |

DE: Der Versuchstag beweist keinen erfolgreichen Volltextreview. `Reviewed` bezeichnet die Prüfung der hier verwendeten Aussagen, `BibliographyVerified` nur Katalog-/Versionsmetadaten, `Partial` einen begrenzten Quellenumfang und `Open` eine fehlende Primärprüfung. Begründungen und Grenzen stehen im [Quellenprotokoll](../../maintenance/gsdb-source-review-2026-10-19.json). Die alte Statuslogik beschreibt die Verwendung in der Baseline; die Tabelle beschreibt davon getrennt den tatsächlichen Reviewstand.

EN: An attempt date does not establish successful full-text review. Reviewed covers the statements used here, BibliographyVerified covers catalogue/version metadata only, Partial means limited source coverage, and Open means missing primary review. Reasons are recorded in the linked source log. Baseline use and source-review status are separate axes.

## OWASP-LLM-Nummern / OWASP LLM Numbering

**DE:** Diese Basis verwendet ausschließlich die 2025-Nummern. Beispiele: `LLM02:2025 Sensitive Information Disclosure`, `LLM05:2025 Improper Output Handling`, `LLM06:2025 Excessive Agency` und `LLM09:2025 Misinformation`. Ältere Nummern dürfen nur mit explizitem Versionssuffix zitiert werden.

**EN:** This baseline uses only the 2025 numbering. Examples: `LLM02:2025 Sensitive Information Disclosure`, `LLM05:2025 Improper Output Handling`, `LLM06:2025 Excessive Agency`, and `LLM09:2025 Misinformation`. Older numbering may only be cited with an explicit version suffix.

## Pflege und Nachweis / Maintenance and Evidence

- Änderungen werden gegen offizielle Primärquellen geprüft.
- Ein Versionswechsel nennt betroffene Richtlinienabschnitte, CL-IDs und Migrationsbedarf.
- Projektspezifische Entscheidungen dokumentieren `Applicable`, `N/A` oder `Open` und einen Evidenzpfad.
- ISO-Inhalte werden nur über Kontroll- oder Klauselnummern referenziert; lizenzierte Normtexte werden nicht kopiert.

## Statusbedeutung / Status Meaning

- `Current`: Diese Fassung ist die aktuelle fachliche Arbeitsgrundlage.
- `Pinned`: Diese konkrete Fassung ist bewusst festgelegt; ein Wechsel braucht eine Migrationsprüfung.
- `Applicability`: Die Quelle wird nur verwendet, wenn Projektart oder Rechtskontext sie auslösen.
- `Reference`: Die Quelle unterstützt Entscheidungen, ist aber kein automatisch verbindlicher Kontrollkatalog.

*`Current` is the active technical baseline. `Pinned` is deliberately fixed and requires migration review. `Applicability` depends on project or legal scope. `Reference` supports decisions but is not automatically binding.*

## Aktualisierungsprozess / Update Process

1. Primärquelle und Veröffentlichungsdatum prüfen.
2. Unterschiede zur registrierten Fassung beschreiben.
3. Betroffene Richtlinienabschnitte, CL-IDs, Vorlagen und Presets ermitteln.
4. Kompatibilität, Lernwirkung und Migrationsbedarf bewerten.
5. Register, Dokumente, Generatornachweis und Versionshistorie gemeinsam aktualisieren.

## Für Auszubildende kurz erklärt / Short Explanation for Apprentices

**DE:** Standards ändern sich. Deshalb steht hinter einer Regel immer eine Fassung. Die Nummer ist wichtig: Derselbe Code wie `LLM02` kann in einer anderen Ausgabe eine andere Bedeutung haben. Prüfe immer Name, Jahr und Quelle gemeinsam.

**EN:** Standards change. Therefore every rule has a version. The number matters: the same code such as `LLM02` can mean something different in another edition. Always check name, year, and source together.

## Versionshistorie / Version History

| Version | Datum | Änderung |
|---|---|---|
| 1.0.0 | 2026-07-10 | Erstes kontrolliertes Register für sichere-Entwicklung-Basis 3.0.0. |
| 1.1.0 | 2026-10-19 | Level-0-Konsolidierung: Baseline-Bindung und fachliche Konsistenz geprüft; Grenzen im Reviewbericht. / Level-0 consolidation: baseline binding and consistency reviewed; limitations recorded in the review report. |

## Feste Wiedervorlage / Fixed Review Schedule

DE: Quartalsweise am 10. Januar, April, Juli und Oktober um 10:00 Europe/Berlin, nächster Termin 10.01.2027. Anlassbezogene Reviews verschieben diesen Termin nicht. Owner: Thorsten Hindermann. [Betriebsvertrag](../../maintenance/governance-review-and-rollout.md).

EN: Quarterly on 10 January, April, July, and October at 10:00 Europe/Berlin; next review 2027-01-10. Event-triggered reviews do not reset this schedule. Owner: Thorsten Hindermann. See the linked operating policy.
