# GSDB 3.4.4: P3-Nachprüfung / P3 Follow-up

DE: Owner Thorsten Hindermann. Ausgangscommit `4802fc55d839b747d2ec3039e91f5776d0ea451f`,
Level 0, PR #337. Claude Opus 5.5 (CLI 2.1.304, frische lesende Sitzung)
bestätigte die Behebung von I01–I06: kein offener P1/P2. Er fand acht P3-Punkte.
Dieser Nachtrag korrigiert diese Punkte mit Baseline **3.4.4**, Sammelband
**2.4.4** und unveränderten **157 Prüfpunkt-IDs**. Alle früheren Berichte,
Quellenprotokolle, Inventare und hashgebundenen Kontexte bleiben unverändert.

EN: Owner Thorsten Hindermann. Starting commit above, Level 0, PR #337.
An independent read-only Claude review confirmed I01–I06 resolved, with no
remaining P1/P2, and identified eight P3 findings. This follow-up corrects
them in baseline 3.4.4 / compendium 2.4.4, preserving all 157 IDs and earlier
reports, source logs, inventories and hash-bound contexts.

## Befunde und Korrekturen / Findings and Corrections

| ID | Korrektur / Correction | Nachweis / Evidence |
|---|---|---|
| P3-1 | CL-08-Historie 2.0.3 richtig benannt. Unveränderte Checklisten erhielten für 3.4.3 nur eine redaktionelle Bindungsnotiz statt einer zweiten gleichnamigen Dokumentversion. Fachlich geänderte Dokumente in 3.4.4 haben eigene neue Versionen; beide Richtlinienhistorien sind vollständige Vier-Spalten-Tabellen. / Correct CL-08 history and remove duplicate semantic-version entries; distinguish editorial binding from new semantic versions. | Manifest und zwölf Einzelhistorien / manifest and twelve histories |
| P3-2 | Vier neue Negativfälle belassen den aktiven Wert korrekt und fügen nur ein identisches Zweitfeld hinzu: Baseline, Dokumentversion, Richtlinie DE und EN. Damit muss die Eindeutigkeitsbedingung selbst wirken. / Four count-only duplicate probes isolate uniqueness from active-value mismatch. | 34 Fälle je Shell, 68 lokal / 34 cases per shell, 68 locally |
| P3-3 | CL-08-12 enthält nun eigene risikobasierte Tests für unsichere Sprach-/FFI-Grenzen, native Dependencies und Nicht-MSL: Fuzzing/Sanitizer bei Plattformunterstützung, sonst dokumentierte kompensierende Tests und Restrisiko. CL-08-13 bleibt Träger der Sprachwahl/Roadmap. / Add actual unsafe-boundary testing evidence rather than relying on a cross-reference alone. | CL-08-12/13; CISA-Zuordnung / CISA mapping |
| P3-4 | Die vier kanonischen Bootstrap-Vorlagen verwenden dieselbe manifestgebundene Formulierung wie AGENTS, CLAUDE, GEMINI und beide Copilot-Dateien. Kein veralteter aktiver 3.1.0-Pin wird neu erzeugt. / Align all four canonical templates with the five root guidance surfaces. | `scripts/templates/{AGENTS,CLAUDE,GEMINI}.md.tmpl`, `copilot-instructions.tmpl` |
| P3-5 | Matrix und Quellenprotokoll sind pro Prüfpunkt angeglichen: DSGVO/NIS2/BSIG/DORA bei CL-06-07, DSGVO bei CL-09-13/CL-10-12; TR-02102 nur für konkret zugeordnete Aussagen, lokale Krypto-/HSM-Policy gesondert. CRA-Reviewed nicht mehr pauschal für alle CL-06-Punkte. / Align specific reviewed assertions and remove blanket source-review labels. | Neue [Matrix](gsdb-coverage-p3-followup-2026-10-20.md) und [Quellen](gsdb-source-review-p3-followup-2026-10-20.json) |
| P3-6 | CL-08-06 verweist für TLS auf CL-03-07/TR-02102-2. Generische Algorithmen und 90-Tage-Rotation sind lokale Policy; ChaCha20/Ed25519/X25519 werden nicht als Empfehlung der TR-02102-1 ausgegeben. / Separate local algorithm policy from the reviewed TLS profile. | CL-08-06; TR-02102-2 Kap. 3 / Chapter 3 |
| P3-7 | Geänderter KI-VO Art. 4 verlangt Unterstützung der Entwicklung von KI-Kompetenz, keine Garantie eines individuellen Niveaus. CL-09-12 kennzeichnet Intervalle, Stunden, Zugangssperre und 95-%-Schwelle ausdrücklich als lokale Regeln; Akzeptanz zweisprachig. / Distinguish the amended support duty from local training/access thresholds. | KI-VO konsolidiert 27.07.2026; CL-01-12/CL-09-12 |
| P3-8 | CRA Art. 2(8) ist gesonderte Begrenzung von Auskunftspflichten zum Schutz wesentlicher Sicherheits-/Verteidigungsinteressen, kein Produkt-Scope-Ausschluss. / Clarify information-supply limits rather than product non-applicability. | CRA Art. 2(8); CL-07-12 |

## Fachlicher Abgleich und Grenzen / Semantic Review and Limits

DE: Für P3-7 wurden der geänderte Art. 4 in den vorhandenen offiziellen
KI-VO-/Änderungsakt-Captures und für P3-8 CRA Art. 2(8) erneut gelesen.
TR-02102-2 Kap. 3 und die lokalen Abweichungen sind bewusst getrennt.
Die Matrix kennzeichnet nur tatsächlich zugeordnete Aussagen als Reviewed;
sie behauptet weder Projektkontrollerfüllung noch Normkonformität.

EN: Re-read amended AI Act Article 4 and CRA Article 2(8) in the existing
official captures. Keep TR-02102-2 Chapter 3 separate from local deviations.
Reviewed labels cover mapped assertions only, not project fulfilment or
standards conformity.

DE: Eine zusätzliche Unsicherheit aus dem Claude-Bericht wurde an einer
frisch gelesenen [offiziellen Kommissionsseite zu CRA-Meldungen](https://digital-strategy.ec.europa.eu/en/policies/cra-reporting)
geklärt (Abruf 20.10.2026, angezeigter Stand 11.09.2026): Hersteller melden
seit 11.09.2026; für die Steward-Rolle nennt die Kommission Art. 24(3)/71(2)
und den 11.12.2027 ausdrücklich. Eine gleichzeitige Herstellerrolle bleibt
gesondert zu prüfen. Dies ist eine veröffentlichte behördliche Auslegung,
kein neuer Gesetzestext. Dieselbe Seite bestätigt den getrennten
CSIRT-Weiterleitungsaufschub und verlinkt (EU) 2026/881. Dessen direkten
EUR-Lex-Volltext blockierte weiterhin die JavaScript-Verifikation; die frühere
Zugangsgrenze wird nicht als behoben ausgegeben. Für 2025/2392 bleibt der
verwendete Aussageumfang aus dem offiziellen EUR-Lex-Index dokumentiert.

EN: A fresh official Commission page explicitly confirms separate reporting
dates: manufacturers since 2026-09-11; stewards under Articles 24(3)/71(2)
from 2027-12-11. Assess concurrent manufacturer roles separately. This is
published official interpretation, not legislation. The page also distinguishes
CSIRT dissemination delay and links (EU) 2026/881, whose direct EUR-Lex text
still required JavaScript verification. Retain that access limit and the
limited indexed-primary-text assertion scope for 2025/2392.

DE: ISO bleibt bibliografisch. Kein lizenzierter Volltextreview, keine
Produktkonformität und keine physische Assistenztechnik-Abnahme werden
behauptet. Sekundärbeobachtungen zu Omnibus-/NIS2-Vorschlägen ersetzen keine
Prüfung des konkret bezeichneten veröffentlichten Rechtsakts.

EN: ISO remains bibliographic. No licensed full-text review, product conformity
or physical assistive-technology acceptance is claimed. Secondary observations
about Omnibus/NIS2 proposals do not replace verification of a named published act.

## Technische Validierung / Technical Validation

DE: Bash zuerst, danach PowerShell. Generatorparität, 157 unveränderte IDs,
68 isolierte Regressionen inklusive korrekter aktiver Duplikatwerte,
37 Inventar-Hashes gegen den unmittelbaren Vorgänger und Ausgangscommit,
idempotente Erzeugung, neue Assurance-/Impact-Bindung, lokale Links,
PSScriptAnalyzer, Skriptreferenz und PR-Bereichs-Secret-Scan. Statistik aus
sauberem Quellcommit, anschließend eigener Statistikcommit. Tatsächliche
Ergebnisse und CI werden am geprüften Head im PR festgehalten; diese
Verfahrensliste allein bescheinigt keinen Erfolg.

EN: Run Bash before PowerShell, generator parity/idempotency, 157 stable IDs,
68 isolated regressions, 37 inventory hashes and predecessor/start bindings,
new impact/Assurance, local links, static/reference checks and PR-range secret
scan. Render statistics from a clean source commit. Record actual results and
CI against the tested head in the PR; the procedure alone is not a pass.

DE: Lokal tatsächlich bestanden: 68/68 Regressionen, acht zusätzliche isolierte
Mutationsproben (Original lehnt korrektes Feld plus Duplikat ab, Variante ohne
Zählbedingung akzeptiert es fälschlich), Generatorparität/Idempotenz, 37/37
Inventar-/Vorgänger-/Ausgangshashes, 157 identische IDs, eindeutige aktuelle
Checklisten-Historien, alle neun Guidance-/Vorlagenflächen, beide Impact- und
Assurance-Validatoren, 5557 Offline-Link-/Ankerprüfungen ohne Fehler,
Skriptreferenz CURRENT und PSScriptAnalyzer ohne Error/Warning (121 Dateien).
CI und erneuter unabhängiger Abschluss werden getrennt im PR dokumentiert.

EN: Actual local passes: 68/68 regressions, eight isolated count-guard mutation
probes, generator parity/idempotency, 37/37 current/predecessor/start hashes,
157 unchanged IDs, unique current checklist histories, all nine guidance/template
surfaces, both impact/Assurance validators, 5557 offline link/anchor checks
without errors, current script reference and zero PSScriptAnalyzer errors/warnings
across 121 files. CI and renewed independent conclusions remain separate PR evidence.

## Evidence und Autorität / Evidence and Authority

DE: Der [Claude-Bericht zu 4802fc55](gsdb-claude-review-4802fc55-2026-10-20.md)
bleibt als unveränderte historische KI-Nachprüfung erhalten. Der neue
[Assurance-Kontext](../security/secure-development/2026-10-20-gsdb-p3-followup/evidence-matrix.md)
bindet 3.4.4. Frühere Kontexte bleiben unverändert; alle vier menschlichen
Entscheidungen bleiben Open, Closure/Gesamt Blocked.

EN: Preserve the linked Claude review as an unchanged historical AI review.
New Assurance binds 3.4.4 without rewriting prior contexts. All four human
decisions remain Open; Closure and overall remain Blocked.

DE: Assurance **0.1.4** behält seine gesondert dokumentierte Teiltextschwäche;
der stärkere Generatorcheck bleibt zusätzlich erforderlich. Security Governance
**0.7.2** bietet bereits die Produkt-/Werkzeug-/Organisationsmatrix, verlangt
aber Projektergänzungen für explizite Betreiberrolle und Art.-4-Evidence nach
CL-01-12. Eine mögliche Vorlagenergänzung gehört in einen separaten Paketauftrag;
Owner Thorsten Hindermann, Wiedervorlage spätestens 10.01.2027/vor Verteilung.
Keine Paketquelle wird geändert. Die GSDB bleibt fachlich vorrangig vor
unvollständigen Vorlagenfeldern.

EN: Assurance 0.1.4 retains its separate substring-validation finding; the
stronger generator remains an additional gate. Security Governance 0.7.2
already provides product/tool/organisation mapping but needs project-specific
deployer/Article 4 evidence under CL-01-12. Any template enhancement is separate
package work, owned by Thorsten Hindermann, reviewed by 2027-01-10/before
distribution. No package source changes; GSDB governs substantive requirements.

DE: Ausschließlich Level 0. Dokumente/Evidence sourceOnly, geänderte Tests und
Agenten-Vorlagen homeRuntime. Späteren Home-Sync nur nach gesonderter
Merge-/Sync-Freigabe mit stabiler Quelle, Syntaxcheck, Vorschau und Konfliktprüfung.
Kein Merge, Home-Sync, Rollout, Schedule- oder Mail-Eingriff in diesem Auftrag.

EN: Level 0 only. Documents/evidence are sourceOnly; tests/agent templates are
homeRuntime. Any later sync requires separate merge/sync authority and stable
source, syntax check, preview and conflict review. No merge, Home sync, rollout,
schedule or mail changes.
