# GSDB-Quellenabschluss / GSDB Source Closure

Owner: Thorsten Hindermann. Review: Codex unter ausdrücklichem Auftrag zur
Ergänzung von PR #337 / under explicit authority to update PR #337.
Prüftag / Review date: 2026-10-20. Ausgangscommit / Starting commit:
`9e51f7e70c00d8cf7aef4a1945731485a0bc3b53`.

## Ergebnis und Reichweite / Outcome and Scope

**DE:** Alle sieben `Open` und drei `Partial` aus dem Erstreview sind für die
in der GSDB verwendeten Aussagen gegen offizielle Volltexte geprüft. Der
aktuelle Quellenbestand enthält 25 `Reviewed` und zwei
`BibliographyVerified` (ISO, unverändert). Quellenzugangs-Blocker: **0**.
Die fachlichen Korrekturen stehen in Baseline **3.4.1**, Sammelband **2.4.1**;
alle **157** Prüfpunkt-IDs bleiben erhalten. `Ready` bezeichnet die
prüfbare Quellenkorrektur und erteilt keine menschliche, rechtliche,
Zertifizierungs-, Produkt- oder Flottenfreigabe.

**EN:** All seven Open and three Partial entries were checked against official
full texts for the assertions used by GSDB. Current counts are 25 Reviewed and
two BibliographyVerified (ISO, unchanged), with zero source-access blockers.
Corrections use baseline 3.4.1 and compendium 2.4.1, retaining all 157 IDs.
Ready means the source correction is reviewable, not human approval,
legal clearance, certification or product/fleet acceptance.

Nur Level 0. Kein Merge, Home-Sync, Paketupdate oder Rollout. Die bestehende
quartalsweise Automation und die jährliche Preset-Prüfung bleiben unverändert.
Diese Nachprüfung löst keine E-Mail aus.

Level 0 only. No merge, Home sync, package update or rollout. Existing quarterly
and annual schedules are unchanged; this follow-up sends no email.

## Methode und Nachweiskette / Method and Evidence Chain

[Quellenprotokoll](gsdb-source-review-2026-10-20.json) nennt je Quelle vorherigen
Status, genaue Fassung, geprüfte Fundstellen, CL-IDs, URL, Capture-Art,
SHA-256 und Umfang. PDF/HTML-Hashes beziehen sich auf empfangene Bytes;
Browser-Text-Hashes auf den sichtbaren Text des EUR-Lex-Textpanels als UTF-8,
nicht auf ein amtliches PDF. Rohtexte wurden lokal außerhalb des Repositories
geprüft; das Repository enthält eigene Befunde und Referenzen. Ein Hash
beweist Capture-Integrität, keine Rechtsgültigkeit oder Review-Vollständigkeit.

BSI-Downloads waren mit direktem HTTP-Abruf erreichbar. Die bei Web-/CLI-Abrufen
angezeigte EUR-Lex-JavaScript-Prüfung war im normalen Browser kein Hindernis;
die Texte wurden dort gelesen. Aktuelle Konsolidierungen wurden über die
sichtbare EUR-Lex-Versionsnavigation gewählt. Konsolidierungen sind
Dokumentationshilfen; maßgeblich bleiben die authentischen Amtsblattakte und
Korrigenda. Der AI-Änderungsakt wurde zusätzlich separat gelesen.

The source log records the prior status, edition, reviewed locators, IDs, URL,
capture representation, hash and size. PDF/HTML hashes cover received bytes;
browser hashes cover visible EUR-Lex text encoded as UTF-8, not authentic PDF
bytes. Raw source texts were reviewed outside the repository. Direct BSI
responses and ordinary-browser EUR-Lex navigation resolved prior access
failures. Consolidations are documentation aids; authentic OJ acts and
corrigenda remain authoritative. The AI amendment was read separately.

Die Nachweise vom 19.10.2026, einschließlich Inventar und hashgebundenem
Assurance-Kontext, bleiben unverändert als Historie erhalten. Der neue
[Assurance-Kontext](../security/secure-development/2026-10-20-gsdb-source-closure/evidence-matrix.md)
bindet den korrigierten Stand. [Aktuelle Abdeckungsmatrix](gsdb-coverage-2026-10-20.md).

The 2026-10-19 inventory, source log and assurance context remain unchanged
historical evidence. The new context binds the corrected state.

## Die zehn Quellenentscheidungen / Ten Source Decisions

| Quelle / Source | Vorher → jetzt / Before → now | Primärnachweis und geprüfter Umfang / Primary evidence and reviewed scope |
|---|---|---|
| BSI TR-02102 | Open → Reviewed | [BSI-Verzeichnis](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/Technische-Richtlinien/TR-nach-Thema-sortiert/tr02102/tr-02102.html): alle vier Teile 2026-01; Teil 1 Stand 23.01.2026, Teile 2–4 27.01.2026. Schutzbedarf, Mechanismen, Protokolltabellen und PQC-Migration / protection needs, mechanisms, protocol tables and PQC migration. |
| BSI C3A | Open → Reviewed | [BSI C3A v1.0](https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/CloudComputing/C3A_Cloud_Computing_Autonomy.pdf?__blob=publicationFile&v=5), 27.04.2026; §§1.1–1.3 und SOV-1..6; freiwillige Autonomie, C5-Voraussetzung / voluntary autonomy and C5 prerequisite. |
| BSI C5 | Open → Reviewed | [BSI C5:2026 v1.1.0](https://www.bsi.bund.de/SharedDocs/Downloads/DE/BSI/CloudComputing/Anforderungskatalog/2026/C5_2026.pdf?__blob=publicationFile&v=13), 11.08.2026; Kapitel 1–3, Scope/Zeitraum, OIS/SP/CRY/DEV und Kunden-/Lieferantenkontrollen / report scope/period and customer/supplier controls. |
| CRA | Partial → Reviewed | [EUR-Lex 02024R2847-20241120](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02024R2847-20241120), 000.003 mit Korrigenda bis 17.10.2025; Erwägungsgrund 12, Art. 2/3, 7/8, 13/14, 18–24, 27–32, 69/71, Anhänge I–VIII. |
| AI Act | Partial → Reviewed | [Konsolidierung 27.07.2026](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02024R1689-20260727), 001.001 und [Änderungsakt (EU) 2026/1744](https://eur-lex.europa.eu/eli/reg/2026/1744/oj/eng); Scope/Rollen, Risikoeinstufung, Transparenz, Art. 111/113 und Anhänge I/III / scope, roles, risk, transparency and application dates. |
| NIS2 und Deutschland / Germany | Partial → Reviewed | [EU-Konsolidierung](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02022L2555-20221227), 000.004, Art. 2–4, 20/21/23/41; [BSIG](https://www.gesetze-im-internet.de/bsig_2025/BJNR12D0B0025.html), in Kraft seit 06.12.2025, berücksichtigte Änderung 23.07.2026, §§28–30, 32/33/38/66, Anlagen 1/2. |
| DORA | Open → Reviewed | [(EU) 2022/2554](https://eur-lex.europa.eu/eli/reg/2022/2554/oj/eng), Art. 1–6, 17–19, 24–31/64; [Melde-RTS 2025/301](https://eur-lex.europa.eu/eli/reg_del/2025/301/oj/eng), Art. 1–5, einschließlich Ausnahmen / including exceptions. |
| G7 AI-SBOM | Open → Reviewed | [BSI Minimum Elements 2026](https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/KI/SBOM-for-AI_minimum-elements.pdf?__blob=publicationFile&v=4); [ANSSI-Veröffentlichung 13.05.2026](https://cyber.gouv.fr/en/publications/jointly-led-international-publications/software-bill-of-materials-sbom-for-artificial-intelligence/). Executive Summary, §§1–4 und sieben Cluster / seven clusters. |
| CISA Memory-Safe Roadmaps | Open → Reviewed | [Offizielle NCSC-NZ-Kopie](https://www.ncsc.govt.nz/assets/OLD/The-Case-for-Memory-Safe-Roadmaps-508c.pdf), Dezember 2023, S. 1–2, 9–16/19. Exakt derselbe SHA-256 wie lokales Original: `dfe3e72e075738e345aab81a541f72ab4c0cd149235426108090bf48787bc34b`. |
| DSGVO / GDPR | Open → Reviewed | [Konsolidierung 02016R0679-20160504](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02016R0679-20160504), 000.002 einschließlich Korrigendum 23.05.2018; Art. 2–6, 12–22, 25/28/30, 32–39, 44–49. |

## Befunde und Korrekturen / Findings and Corrections

| ID | Schwere / Severity | Korrektur / Correction | Fundstelle / Locator |
|---|---|---|---|
| S01 | High | CRA-Scope aus Produktdefinition/Rolle statt pauschaler SaaS-/NIS2-Ersetzung; korrekte Ausnahmen / product definition and role replace blanket SaaS/NIS2 assumptions. | CL-07-01/-12; Art. 2/3, Erwägungsgrund / recital 12 |
| S02 | High | Anhang I Teil I Nr. 2(a)–(m), Teil II Nr. 1–8 richtig zugeordnet; ausnutzbare Lücken statt aller bekannten Lücken; Datenminimierung betrifft auch nichtpersonenbezogene Daten / correct point mapping, exploitable vulnerabilities and all data. | CL-07-04/-05; Annex I |
| S03 | High | Keine pauschal harmonisierten RED-/IoT-Normen, EAL4+-Pflicht, Laborliste oder erfundene Zertifikate; Art.-32-Pfade und tatsächliche Notifizierung prüfen / remove invented conformity shortcuts. | CL-07-02/-03/-06/-07; Art. 8/27/32 |
| S04 | Medium | Software-CE auf Erklärung oder zugänglicher Website; richtige Art. 28–31; Zielmarktsprachen / correct CE location, articles and target-market languages. | CL-07-07; Art. 28–31 |
| S05 | High | Support, verfügbare Updates und Dossier-Aufbewahrung mit verschiedenen Startpunkten getrennt; weniger als fünf Jahre nur gesetzlich begründbar / distinguish three lifecycle clocks and statutory exception. | CL-06-09, CL-07-08/-10; Art. 13(8)–(10)/(13) |
| S06 | High | Gesetzliche CRA-Plattform statt ungesicherter Ersatz-Mailwege; Schwachstellen-/Vorfall-Schlussfristen und weitere Regime getrennt / statutory platform, separate final clocks and reporting regimes. | CL-06-07, CL-07-09; Art. 14/24/71; GDPR 33; DORA RTS 5 |
| S07 | Medium | Risikobasierte Vertragsregeln von unmittelbaren CRA-Pflichten getrennt; kein universelles Escrow-/24h-Zuliefergesetz / separate contracts from statutory duties. | CL-07-11; Art. 13/18–22 |
| S08 | High | KI-VO-Änderungsakt mit geänderten Hochrisiko-Fristen und deutscher BSIG-Rechtslage ergänzt / revised AI high-risk dates and enacted German BSIG. | CL-01-12; AI Act Art. 113; BSIG §§28–38 |
| S09 | Medium | TR-02102-Teilfassungen und PQC-Migrationshorizonte; Beispiele sind keine BSI-Profilfreigabe / part-specific editions and migration horizons, no blanket approval. | CL-03-02/-14; TR-02102-1 §2.1, Teil / part 2 §2 |
| S10 | Medium | DSB „soweit benannt“, Art.-30(5)-Grenze und lokale Jahresreview-Regel; Betroffenen-Verlängerung begründen und rechtzeitig mitteilen / qualify DPO, records exception, annual policy and response extensions. | CL-11-06/-08/-11/-12; GDPR 12/30/35 |
| S11 | Medium | Richtige G7-2026-Quelle; CycloneDX-Dienste in eigener `services`-Sammlung statt erfundenem Komponententyp / correct source and service representation. | CL-05-13; G7 §2; [CycloneDX 1.7 Schema](https://cyclonedx.org/docs/1.7/json/) |
| S12 | Low | C3A-Autonomie und C5-Sicherheits-Assurance getrennt; 2026-Fassungen statt offenen Versionsbehauptungen. CISA-Herkunft anhand byte-identischer Mitherausgeberkopie geklärt / distinguish cloud criteria and verify co-author provenance. | Richtlinie Quellenabschluss; Standardsregister; CISA DE/EN-Lesefassungen |
| S13 | Medium | Negative Baseline-Fixture an Manifestversion gebunden; fest verdrahtete 3.4.0-Ersetzung wurde beim Versionswechsel wirkungslos / bind negative fixture to manifest to prevent silent no-op after release change. | `scripts/tests/test-gsdb-consolidation.ps1`; manpage |

Die alten langen Produktbeispiele enthielten unzutreffende Rechtsstellen und
unbelegte Pflichten. Die Ersatztexte erhalten Kontrollziel, ID, DE/EN-Paar,
Akzeptanz und Statusfelder. Konkrete Scan-, Betriebs- und Übungspflichten bleiben
in ihren fachlichen Checklisten; Beispielprodukte sind keine amtliche Norm.
Für den bisher irreführenden Nachweispfad `cra-annex-ii-mapping.md` ist
`cra-annex-i-part-ii-mapping.md` das präzise Ziel; bestehende Projektnachweise
benötigen später eine dokumentierte Migration oder einen Legacy-Verweis.
In diesem Auftrag wird kein Level-2-Dateipfad geändert.

Replacement text retains control purpose, IDs, language pairs, acceptance and
status fields while removing wrong legal locators and unsupported recipes.
The corrected vulnerability-mapping filename needs a documented migration or
legacy alias in any later project rollout; this task changes no Level-2 file.

## Presets und verbleibende Grenzen / Presets and Remaining Boundaries

Security Governance v0.7.2 stellt offene Felder für Rechtsfassung,
Anwendungsdatum und Primärprüfung bereit; die neuen Quellen lassen sich darin
abbilden. Assurance v0.1.4 prüft Bindung und Gate-Vertrag, nicht die juristische
Wahrheit. Architecture Governance führt Cloud-Nachweise; C3A/C5 bleiben
unterschiedliche fachliche Quellen. Project Statistics liefert den
Statistikvertrag. Keine Änderung an Preset-Quellen oder installierten Paketen.
Eine neue Paketversion ist aus dieser Quellenkorrektur allein nicht erforderlich.

Security v0.7.2 has explicit version, application-date and source-review fields
that can record these findings. Assurance v0.1.4 validates binding and gate
contracts, not legal truth. Architecture provides cloud evidence; Statistics
provides the statistics contract. No preset source or installed package changed;
this source correction alone does not require a new preset release.

- ISO/IEC 27001/27002: nur bereits bestätigte Katalogmetadaten, keine neue
  lizenzierte Volltextprüfung / catalogue metadata only, no new licensed-text review.
- NIS2: Deutschland und EU-Quellen geprüft. Das BSIG nennt die Änderung vom
  21.07.2026 als textlich nachgewiesen, dokumentarisch noch nicht abschließend
  bearbeitet; dieser Verlagsstand ist ausdrücklich erhalten. Andere Länder,
  Landes-/Sektorregeln und tatsächliche Projektanwendbarkeit benötigen eigene
  Entscheidungen / Germany/EU reviewed; retain publisher editorial note;
  other jurisdictions, regional/sector rules and project applicability need decisions.
- Quellenstatus ist kein Kontroll-Umsetzungsstatus und keine Zustimmung zu
  Restrisiken / source status is neither implementation nor risk acceptance.
- Menschliche PR-Prüfung bleibt ausstehend. Home-Runtime-Ausführung und alle
  Flottenverteilungen bleiben ausgeschlossen / human review pending; no runtime or fleet execution.

## Validierung / Validation

Der [technische Nachweis](gsdb-source-validation-2026-10-20.md) trennt
Generator-/Vertrags-/Linktests vom hier dokumentierten semantischen Review.
[Documentation Impact](gsdb-source-documentation-impact-2026-10-20.json).
GSDB-Dokumente und Evidence sind `sourceOnly`. Der bestehende negative
Regressionstest enthielt eine feste 3.4.0-Ersetzung, die mit 3.4.1 wirkungslos
wurde; sie liest jetzt die Manifestversion und prüft den Ausgangsheader.
Dieser Test liegt nach Distributionsmanifest unter `homeRuntime`; ein späterer
Sync-Bedarf wird im PR vermerkt, aber in diesem Auftrag nicht ausgeführt.

The validation log separates executable checks from this semantic review.
Documents/evidence are sourceOnly. The negative baseline regression now uses
the manifest version and rejects a missing starting header, preventing the
old hard-coded replacement from becoming a no-op. This existing test is
homeRuntime under the distribution manifest; its sync remains deferred.
