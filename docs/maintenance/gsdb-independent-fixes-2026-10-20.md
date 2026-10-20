# GSDB: unabhängige Reviewkorrekturen / Independent Review Corrections

DE: Level 0, Ausgangscommit `a943d7f989765cfda6622b588168c8c95674de0f`, PR #337.
Owner: Thorsten Hindermann. Baseline 3.4.3, Sammelband 2.4.3, zwölf Checklisten,
157 unveränderte Prüfpunkt-IDs und 37 kontrollierte Dateien. Dieser Bericht
ersetzt die bisherigen Berichte als aktuellen Befundstand; historische
Quellenprotokolle, Inventare und hashgebundene Assurance-Kontexte bleiben erhalten.

EN: Level 0, starting commit above, PR #337. Owner: Thorsten Hindermann.
Baseline 3.4.3, compendium 2.4.3, twelve checklists, 157 unchanged item IDs and
37 controlled files. This report is the current findings record; historical
source logs, inventories and hash-bound Assurance contexts remain intact.

## Fachliche Korrekturen / Semantic Corrections

| ID | Priorität / Priority | Befund, Auswirkung und Korrektur / Finding, impact and correction |
|---|---|---|
| I01 | P1 | CL-01-12 erlaubte pauschales N/A für internes Tooling trotz möglicher KI-Betreiberpflichten. Je Rechtsregime nun getrennte Produkt-, Werkzeugbetriebs- und Organisationszeilen mit Land, Rolle, Rechtsfassung, Datum, Evidence und Owner. KI-VO Art. 4 ausdrücklich; unbekannte Anwendbarkeit bleibt Open. / Blanket internal-tool N/A conflicted with potential AI deployer duties; separate role-specific decisions and Article 4 evidence now required. |
| I02 | P2 | C3A/C5, G7 und Memory-Safe Roadmaps waren falschen Prüfpunkten und teils falschen Presets zugeordnet. C3A → CL-02-12, C5 → CL-02-13, beide architecture-governance; G7 → CL-05-13/CL-09-15; MSL → CL-08-12/13 mit konkretem Sprachwahl-/Roadmap-Nachweis. Keine pauschale AI-Act-Quelle für CL-09-01 bis 15. / Correct actual source carriers and workflow owners; remove blanket AI Act attribution. |
| I03 | P2 | EN-Richtlinienversion war veraltet, Versionshistorien fehlerhaft, Generator akzeptierte Ersatztreffer im Text. Beide aktiven Sprach-Metadatentabellen werden nun abschnittsgebunden und exakt geprüft; vier Spalten in beiden Historien. Gezielte Negativfälle verhindern einen falschen technischen Pass. / Stale EN metadata and body-match false positives corrected, with bilingual history repair and exact section-bound validation. |
| I04 | P2 | CL-07-09 zitierte Fahrzeug-Scope-Verordnung (EU) 2025/1535 als Meldeausnahme. Diese gehört nach CL-07-01/12; Art. 1 enthält die Rückausnahme für L1e-Pedalfahrzeuge. CRA Art. 16(2)/14(9) und (EU) 2026/881 betreffen CSIRT-Weiterleitung, keine Verlängerung der Herstellerfristen. / Separate vehicle scope from CSIRT dissemination delay; manufacturer deadlines are unchanged. |
| I05 | P2 | CL-07-12 nannte falsche Art.-2-Absätze. MDR/IVDR/Fahrzeuge nun 2(2), zertifizierte Luftfahrt 2(3), Schiffsausrüstung 2(4), delegierte Ausschlüsse 2(5), identische Ersatzteile 2(6); weitere Absätze konkret. Nichtkommerzielle FOSS folgt aus Art. 2(1)/3(22), Steward-Rolle gesondert. / Correct statutory locators rather than inventing a FOSS paragraph exemption. |
| I06 | P2 | CRA-Bestandsproduktregel fehlte. CL-07-01/09/12 und Richtlinie unterscheiden Art. 69(2) (allgemeine Anforderungen bei wesentlicher Änderung ab 11.12.2027) von 69(3)/71(2) (Art.-14-Meldungen seit 11.09.2026 auch für bestehende in-scope Produkte). Inverkehrbringen je Einheit statt nur erstem Familienrelease prüfen. / Separate transitional general duties from existing-product reporting. |

Quellen / Sources:
[KI-VO](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02024R1689-20260727),
[CRA](https://eur-lex.europa.eu/eli/reg/2024/2847/oj),
[Fahrzeug-Scope / vehicle scope](https://eur-lex.europa.eu/eli/reg_del/2025/1535/oj),
[CSIRT-Weiterleitung / dissemination](https://eur-lex.europa.eu/eli/reg_del/2026/881/oj),
[technische Kategorien / technical categories](https://eur-lex.europa.eu/eli/reg_impl/2025/2392/oj).

## P3 im Scope / Scoped P3 Corrections

| Thema / Topic | Korrektur und Grenze / Correction and boundary |
|---|---|
| DORA / NIS2 | RTS (EU) 2025/301 Art. 5(3)–(6): Verzögerung anzeigen, Wochenende/Bankfeiertag, begrenzter Ausschluss für Erst-/Zwischenmeldungen und behördliche Entscheidung; Schlussbericht separat. NIS2-Schluss-/Fortschrittsbericht ergänzt. / Add delay notice, holiday relief, initial/intermediate exclusions and authority discretion; final reports remain distinct. |
| Testaussage / Test strength | Alle Negativfälle verlangen den vorgesehenen Fehler; Metadatenfehler nennen Datei/Feld. Anzahlgleiches Duplikat prüft den Duplikatpfad auch in PowerShell. Neun Richtlinienfälle plus anzahlgleiches Duplikat ergeben 30 Fälle je Shell, 60 lokal. / Assert intended errors and exercise actual duplicate detection. |
| Querbezüge / Traceability | Aktuelles Standardsregister und Verzahnung verlinken diesen Bericht, neues Quellenprotokoll und neue Matrix. Historische Berichte bleiben als solche erkennbar. Offizielle Konsolidierung ist Dokumentationshilfe, authentische Amtsblattakte sind maßgeblich. / Current links and source authority clarified. |
| Form / Sprache / Language | Checklisten-Historien als echte Listeneinträge; beide Richtlinienhistorien mit vier Spalten, keine verwaisten Zeilen. Metadatenbindung unveränderter Dokumente explizit redaktionell. Sprachmischung CL-02-02 entfernt; deutscher Richtlinienteil führt zum gemeinsamen zweisprachigen Fristenblock. / Repair histories, language separation and German navigation. |
| CRA-Lebenszyklus / Lifecycle | Art. 13(18) Anhang-II-Informationen mindestens zehn Jahre oder längerer Support; Art. 13(19) Supportende beim Kauf mindestens Monat/Jahr, EOL-Hinweis soweit technisch möglich. Getrennt von Update-/Dokumentationsfristen. / Complete separate information/support duties. |
| CRA-Präzision / Precision | Primärbezug Art. 32(5) statt bloßer Übersicht; eng begrenzte Maßanfertigungsvereinbarung aus Anhang I Teil I 2(b), Rücksetzung und Inverkehrbringen nach Art. 13(12). / Use exact FOSS/default-configuration provisions and placing-on-market trigger. |
| TLS | CL-03-07 an TR-02102-2 2026-01 Kap. 3 ausgerichtet: BSI-Suites, RSA-PSS, Ende PKCS#1-v1.5-Empfehlung 2025, TLS-1.2-Horizont 2031. ChaCha20 nicht als BSI-Empfehlung ausgeben; tatsächliche Signaturen/Gruppen prüfen. / Separate profile conformity from local cipher choices. |
| Inventarkette / Inventory lineage | Neues Inventar zeigt auf das unmittelbar vorige Inventar und übernimmt dessen consolidatedSha256 als sourceSha256. Der falsche previousInventory-Verweis im alten Remediation-Inventar bleibt als historischer Fehler ausdrücklich dokumentiert. / Correct the new chain without rewriting historical evidence. |
| Datenschutz / Privacy | CL-11-07 kennzeichnet abgeschlossene Klärung vor Verarbeitung als zusätzliche lokale Freigaberegel. Art. 36 selbst verlangt vorherige Konsultation bei verbleibendem hohen Risiko. / Distinguish local release policy from statutory prior consultation. |
| Gemeinsame Guidance / Shared guidance | Veralteten aktiven 3.1.0-Pin in AGENTS, CLAUDE, GEMINI und beiden Copilot-Dateien gemeinsam durch manifestgebundene Versionsauflösung ersetzt. Keine Verteilung. / Replace stale active pins consistently; no distribution. |

Primärbezüge / Primary references:
[DORA-RTS Art. 5](https://eur-lex.europa.eu/eli/reg_del/2025/301/oj),
[NIS2 Art. 23](https://eur-lex.europa.eu/eli/dir/2022/2555/oj),
[DSGVO Art. 36](https://eur-lex.europa.eu/eli/reg/2016/679/oj),
[BSI TR-02102](https://www.bsi.bund.de/DE/Themen/Unternehmen-und-Organisationen/Standards-und-Zertifizierung/Technische-Richtlinien/TR-nach-Thema-sortiert/tr02102/tr-02102.html).

## Quellenumfang und offene Grenzen / Source Scope and Limits

DE: Die zehn Quellenprüfungen sind im [neuen Quellenprotokoll](gsdb-source-review-independent-fixes-2026-10-20.json)
und in der [157-Punkte-Matrix](gsdb-coverage-independent-fixes-2026-10-20.md) nachvollziehbar.
Vorhandene Captures wurden für die korrigierten Aussagen erneut gelesen, nicht
als zehn neue vollständige Normprüfungen ausgegeben. Insbesondere wurden
TR-02102-2 Kap. 3, CRA Art. 2/13/14/16/32/69/71, DORA-RTS Art. 5 und DSGVO
Art. 36 gezielt abgeglichen. Neue CRA-Ergänzungsakte wurden im offiziellen
EUR-Lex-Suchindex geprüft; direkte Abrufe lieferten JavaScript-Verifikation.
Das ist keine neue Publisher-Byte-Capture und kein Volltextreview aller drei Akte.
EUR-Lex-Konsolidierungen haben keinen eigenen Rechtswert. ISO bleibt
bibliografisch; lizenzierter Volltext, konkrete Produktkonformität und
physische Assistenztechnik-Abnahme sind nicht nachgewiesen.

EN: The linked source log and matrix define the assertion scope. Existing
captures were re-read for corrected assertions; this is not ten new exhaustive
standards audits. Supplemental CRA acts were checked in the official EUR-Lex
search index; direct requests required JavaScript verification. No new
publisher-byte capture or full review of all supplemental acts is claimed.
ISO remains bibliographic; product conformity, licensed-text review and
physical assistive-technology acceptance are outside the evidence.

DE: NCSC-NZ-PDF: Der frühere unabhängige Claude-Abruf wurde gegen das lokale
Original gehasht, beide `dfe3e72e075738e345aab81a541f72ab4c0cd149235426108090bf48787bc34b`.
Der frühere Codex-403 bleibt historisch korrekt; der neue Quellenstand enthält
den späteren erfolgreichen Abruf mit dessen Herkunft. Kein neuer Live-Download
dieser Implementierungsrunde wird behauptet.

EN: The earlier independent Claude NCSC NZ retrieval hashes identically to
the local original. Preserve the historical Codex 403 and separately record
the later successful retrieval; no fresh download in this implementation run
is claimed.

## Technische Validierung / Technical Validation

DE: Bash zuerst, danach PowerShell-Parität: Generator/Versionen/157 IDs,
isolierte Regressionen, Preset-Matrix (14), Documentation Impact und neue
Assurance-Bindung. Ein zweiter Generatorlauf muss bytegleich sein.
Zusätzlich Inventar-Hashes, unveränderte historische Evidence, Offline-Links,
PSScriptAnalyzer, Skriptreferenz und Secret-Scan des PR-Commitbereichs.
Statistik wird nach sauberem Quellcommit gerendert und getrennt committet.
Aktueller Commit, tatsächliche Ergebnisse, CI und unabhängiger Claude-Abschluss
werden im PR am geprüften Head festgehalten; diese Verfahrensbeschreibung
allein ist keine Behauptung bestandener Prüfungen.

EN: Run Bash before PowerShell parity, isolated regressions, exact preset
matrix, impact and new bindings. Require generator idempotency, current
inventory hashes, unchanged historical evidence, offline links, static checks
and PR-range secret scan. Render statistics from a clean source commit.
Actual results and independent Claude conclusions are recorded in the PR
against the tested head; the procedure itself does not assert a pass.

## Externer Befund und Freigaben / External Finding and Decisions

DE: `secure-development-assurance-governance` **0.1.4** verwendet in seinen
installierten Validatoren weiterhin Teiltext-Versionsprüfungen. Auswirkung:
passender Text kann falsche aktive Metadaten verdecken; Hashbindung allein
beweist keine semantisch richtige Version. Das Paket und seine Quellrepos
bleiben außerhalb dieses Auftrags. Separate Paketkorrektur durch Thorsten
Hindermann vor einer Bewertung des Paketvalidators als alleinige
Metadatenkontrolle; bis dahin ist der strengere Level-0-Generatorcheck
zusätzlich erforderlich. Reviewdatum: spätestens 10.01.2027 oder vor
Weiterverteilung. Keine pauschale Aussage über andere Paketversionen.

EN: Installed Assurance 0.1.4 still uses substring version checks. A matching
body string can hide stale metadata; hashes alone do not establish semantic
version correctness. Package sources are outside scope. Thorsten Hindermann
owns a separate package correction before using that validator as the sole
metadata control; the stronger Level-0 generator remains an additional gate.
Review by 2027-01-10 or before further distribution.

DE: Neuer [Assurance-Kontext](../security/secure-development/2026-10-20-gsdb-independent-fixes/evidence-matrix.md)
bindet diesen Dokumentstand. Alle vier menschlichen Entscheidungen bleiben
Open; Closure und Gesamtstatus bleiben Blocked. Kein Merge, Home-Sync,
Rollout oder Preset-Paketupdate. Geänderte Prüfscripte und gemeinsame Guidance
sind homeRuntime: späterer Sync nur nach gesonderter Merge-/Sync-Freigabe aus
stabiler Level-0-Quelle mit Syntaxcheck, Vorschau und Konfliktprüfung. Reine
GSDB-Dokumente sind sourceOnly. Bestehende Schedules und Versandparameter
werden in dieser Korrekturrunde nicht geändert.

EN: New Assurance binds this revision, while all four human decisions remain
Open and Closure/overall remain Blocked. No merge, Home sync, rollout or
preset package update. Runtime scripts/guidance require a later separately
authorised sync after merge, from a stable Level-0 source with syntax check,
preview and conflict review. GSDB documents are sourceOnly. Existing schedules
and mail parameters are unchanged.
