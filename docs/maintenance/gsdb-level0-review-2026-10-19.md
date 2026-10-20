# GSDB Level-0-Konsolidierung / GSDB Level-0 Consolidation

Owner: Thorsten Hindermann. Review: Codex unter ausdrücklichem Umsetzungsauftrag,
keine unabhängige menschliche Freigabe / explicit implementation authority,
no independent human approval. Review date: 2026-10-19.

## Ergebnis und Grenzen / Outcome and Boundaries

**Fachliches Gesamtergebnis / Overall subject-matter outcome: Blocked.**
Nicht vollständig prüfbare Primärquellen und menschliche PR-Prüfung bleiben
offen. Strukturelle Konsistenz und Quellenzugang sind getrennte Nachweise.
Die Lieferung ist eine prüfbare Konsolidierung als PR, keine uneingeschränkte
fachliche Freigabe, Zertifizierung, Pilot-, Produkt- oder Flottenabnahme.

**EN:** Unresolved primary-source review and human PR review prevent
unconditional approval. Structural validation and source access are separate
proofs. This delivery provides a reviewable consolidation PR, not certification
or pilot, product, or fleet acceptance.

Scope: Level 0 only. Die drei Piloten, weitere Level-2-Repos und die restliche
Flotte bleiben jeweils WaitingAuthorization. Kein Merge oder Home-Sync.
The three pilots and all wider rollouts remain separately commissioned.

## Bestand und Prüfmethode / Inventory and Method

Ausgangscommit: `63ab18d636cd1499fcc33463bbafdadb0346afb0`, vor Beginn mit dem
veröffentlichten main abgeglichen. [Inventar mit 37 Dateihashes](gsdb-inventory-2026-10-19.json).
Baseline 3.3.0 wird als 3.4.0 konsolidiert; Sammelband 2.4.0. Alle 157
Prüfpunkt-IDs bleiben erhalten. Metadatenpatches der Dokumente halten ihre
Baseline-Bindung aktuell; historische Fassungen bleiben in Git erhalten.

EN: The starting commit matched published main. Inventory hashes identify all
37 source files. Consolidation moves baseline 3.3.0 to 3.4.0 and compendium to
2.4.0 without changing the 157 stable item IDs. Document patches update active
baseline binding; historical versions remain in Git.

Geprüfte Ebenen: Dokumentzweck, Anforderungen, Anwendbarkeit, Statusachsen,
Akzeptanzkriterien, Rollen und Evidenzpfade; anschließend Querverweise zwischen
Richtlinie, CL-IDs, mitgeltenden Dokumenten, Lernpfad und Presets.
[Abdeckungsmatrix mit einer Zeile je Prüfpunkt](gsdb-coverage-2026-10-19.md).
Die Matrix ordnet Zuständigkeiten und erwartete Evidence zu; sie ist keine
Bestätigung, dass ein Projekt sämtliche Kontrollen umgesetzt hat.

EN: Review covers document purpose, requirements, applicability, status axes,
acceptance criteria, roles and evidence paths, then cross-document mapping.
The linked row-level matrix maps all items without claiming implemented
project controls. Examples and local policy thresholds are not automatically
requirements of the cited external standard.

[Quellenprotokoll](gsdb-source-review-2026-10-19.json) erfasst jede Referenz aus
dem Register und ergänzende Quellen mit eigenem Ergebnis. Katalogmetadaten
sind kein vollständiger ISO-Normtextreview. Blockierte URLs werden nach
gezielten offiziellen Alternativen erneut geprüft; Suchtreffer allein sind
kein Nachweis einer aktuellen Fassung. Historische PDFs und Übersetzungen
bleiben mit Herkunft und Integritätsnachweis erhalten; ihre fachliche
Neubestätigung bleibt bei unzugänglicher Originalquelle offen.

EN: Each register reference has an explicit outcome. Catalogue metadata does
not establish full ISO-text review. Targeted official alternatives were tried;
search snippets alone do not establish currency. Local PDFs/translations retain
provenance and integrity without invented online revalidation.

## Befunde und Korrekturen / Findings and Corrections

| ID | Schwere / Severity | Befund und Behandlung / Finding and treatment |
|---|---|---|
| G01 | Medium | Aktive Baseline-Header 3.0/3.2, veraltete Daten und unvollständige Profilverzahnung korrigiert; historische Versionshistorien erhalten. / Corrected active header/date/profile drift; retained history. |
| G02 | High | SSDF PW.4/PW.5/PW.7/PW.8 vermischt; CL-01-01 korrigiert und Final 1.1 von Draft 1.2 getrennt. / Corrected practice mapping and final/draft distinction. |
| G03 | Medium | Proactive-Controls-Ausgabe und Nummern vermischt; CL-01-10 an Ausgabe 2024 gebunden. / Corrected edition binding. |
| G04 | High | Veraltete pauschale Zertifikatsfrist; CL-03-10 nennt ausstellungsabhängige CA/Browser-Grenzen. / Corrected certificate validity limits. |
| G05 | High | Pauschales Escaping und String-Präfixprüfung können zu Injektion/Path-Traversal führen; CL-08-02/-10 präzisiert. / Clarified safe sinks and component-aware path confinement. |
| G06 | Medium | Pauschale Lizenzverbote, Snippet-Längengrenzen und unbelegte Rechtsverfahrensbehauptungen entfernt; konkrete Rechteentscheidung bleibt erforderlich. / Removed blanket licence and legal claims. |
| G07 | High | Unbelegte pauschale sechs-/zehnjährige Log-Aufbewahrung korrigiert; datenkategoriebezogene Entscheidung erforderlich. / Corrected blanket retention claims. |
| G08 | Medium | Produktnamen als Datenschutzbeweis und vermeintlich allgemeine Ignore-Konfigurationen ersetzt; Kontoeinstellungen müssen belegt werden. / Require version/account evidence for AI configuration. |
| G09 | Medium | CRA-Supportregel und Konformitätsausnahmen präzisiert; Volltextprüfung bleibt offen. OAuth-Autorisierung von Authentifizierung getrennt. / Clarified CRA exceptions and OAuth boundary. |
| G10 | Medium | Preflight prüfte nur acht Verzeichnisse; prüft jetzt zugewiesene exakte Matrix und stoppt bei unbekanntem Profil. Registry- und Manifestidentität werden getrennt geprüft. / Profile-bound exact validation replaces directory presence. |
| G11 | High/Open | BSI TR-02102/C3A/C5, DORA, GDPR, G7-2026-Original und CISA online nicht vollständig geprüft; keine stillschweigende Bestätigung. / Unresolved primary sources remain explicit blockers. |
| G12 | Medium/Open | AI-Act-Konsolidierung und nationale NIS2-Umsetzung nicht vollständig geprüft. / Consolidation/transposition review remains incomplete. |

Die kompakten Ersatztexte entfernen fehlerhafte oder ungesicherte Detailrezepte,
erhalten jedoch Ziel, stabile ID, zweisprachige Anforderung und prüfbare
Akzeptanz. Externe Preset-Pakete und ihre Quellrepositories wurden nicht
verändert. Aus den Befunden folgt keine automatische neue Preset-Version.

EN: Compact replacements remove incorrect or unverified recipes while keeping
purpose, stable identity, bilingual requirements and testable acceptance.
No external preset package/source changed; no automatic release follows.

## Presets, Assurance und Distribution / Composition and Distribution

[Installations-/Release-Abgleich aller 14 Presets](gsdb-preset-review-2026-10-19.json).
Security Governance unterstützt den SDD-Workflow, Assurance bindet Manifest,
Versionen und normalisierte Hashes an vier Gates, Project Statistics misst
Aktivität. Kein Bestandteil ersetzt fachliche oder menschliche Prüfung.
Neue Evidence liegt im [eigenen Kontext](../security/secure-development/2026-10-19-gsdb-level0-consolidation/).
Historische Evidence bleibt unverändert und bezieht sich weiter auf ihren
früher geprüften Stand.

EN: All fourteen preset versions are compared with current published releases.
Assurance binds the revised documents to a new context. Historical evidence
retains its original meaning and is not rewritten to fit current files.

`docs/` ist sourceOnly. Geänderte Prüfskripte unter `scripts/` sind homeRuntime.
Home-Sync ist daher **nach einem später genehmigten Merge erforderlich**.
Vorher Hilfe, Syntaxcheck und Vorschau aus der stabilen Level-0-Quelle,
anschließend Konfliktprüfung; kein Force bei ungeklärten Konflikten.
Der aktuelle PR verteilt nichts nach Home oder an andere Repositories.

EN: Docs are source-only; changed scripts are Home Runtime. Sync is required
after a separately approved merge, following help, syntax, preview and conflict
checks. This PR does not distribute to Home or any downstream repository.

## Schedule und Mail / Schedule and Mail

Chat-Automation `quartalsreview-gsdb-level-0` ist ACTIVE und wurde zurückgelesen.
Feste Termine: 10. Januar/April/Juli/Oktober, 10:00 Europe/Berlin; erster
regulärer Termin 10.01.2027 (09:00 UTC). Die gespeicherte Regel und der
Erstlauf-Guard ergeben diesen nächsten Termin; die App liefert kein separates
nextRunAt-Feld. Die bestehende Jahresautomation bleibt unverändert.

EN: The active chat automation was read back. Recurrence and first-run guard
establish 2027-01-10 10:00 Berlin as the next regular date; no separate
nextRunAt is exposed. Annual automation remains unchanged.

Gmail-Profil bestätigte das autorisierte Absenderkonto. Empfängerzahl drei,
Adressen, Quartalsmarker und Versandgrenzen wurden gegen den Benutzerauftrag
und die Tool-Schnittstelle geprüft; kein Send-/Draft-Tool wurde aufgerufen.
Dies belegt Konfiguration, nicht die künftige Zustellung. App, Rechner und
Verbindung müssen zum Termin verfügbar sein. Unklaren Versand nicht blind
wiederholen. Private Automation enthält die vollständigen Versandparameter.

EN: Gmail profile and the tool interface validate sender/recipient configuration,
not future delivery. No send or draft action was performed. Computer, app and
connections must be available. Ambiguous sending requires reconciliation.

## Prüfung und offene Entscheidungen / Validation and Open Decisions

Ausführbare Nachweise stehen im [Validierungsprotokoll](gsdb-validation-2026-10-19.md).
Keine Freigabe wird aus einem technisch erfolgreichen Validator abgeleitet.
Open-Quellen haben Owner Thorsten Hindermann; nächste fachliche Klärung bis
31.10.2026 beziehungsweise vor einer darauf beruhenden Sicherheitsentscheidung.
Dies ist keine akzeptierte Risikoausnahme. Regelmäßige Wiedervorlage bleibt
10.01.2027. Menschliche PR-Prüfung, Merge, Home-Sync und alle Rollouts sind offen.

EN: Executable evidence is in the validation log. Open sources need owner review
by 2026-10-31 or before a dependent security decision. No accepted-risk waiver
is claimed. Regular review remains 2027-01-10. Human PR review, merge, Home sync
and downstream rollouts remain pending.
