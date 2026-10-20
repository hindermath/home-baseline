# GSDB: erneute Prüfung mit Assurance 0.1.5 / Revalidation with Assurance 0.1.5

Owner: Thorsten Hindermann. Datum / Date: 2026-10-20. Scope: Level 0.

## Ausgangsstand und Autorität / Starting point and authority

PR #337 reviewed head: `15e877e0b932a5d862bb3cb4137e6d9543488e53`.
Integrated main / PR #338: `7b03bb36b3d533a33e66696ead868172c6113639`.
[Menschliche Sichtung / human review](https://github.com/hindermath/home-baseline/pull/337#pullrequestreview-5588625491):
Thorsten Hindermann, 2026-10-20, „Gesichtet und für in Ordnung befunden“.
GitHub speichert dies als COMMENTED; die ausdrückliche DeliveryMode-MergeAndSync-
Freigabe mit Admin-Bypass stammt zusätzlich aus dem Chat. Die frühere
Kein-Merge-Grenze ist für diesen Auftrag aufgehoben. Nur Level 0/Home Runtime.

EN: Human review covers the previous PR head. Explicit chat authority permits
conflict resolution, current-head validation, admin merge and bounded Home sync.
It does not authorise downstream rollout or blanket product/pilot acceptance.

## Konflikt und Paketstand / Conflict and package state

Einziger Mergekonflikt: `docs/project-statistics.md`. Beide Fortschreibungen
bleiben erhalten; der generierte Block wird aus sauberem Quellencommit mit
unveränderter Methodik v2 neu gerendert. Assurance 0.1.5, beide Matrizen,
Quellen-/Installed-Locks und Windows-CI-Zeitbudget aus PR #338 bleiben erhalten.
Historische Reviews, Inventare und hashgebundene Evidence werden nicht editiert.

EN: Preserve both ledger histories, regenerate only derived statistics, retain
all PR338 package/lock changes and historical evidence without modification.

## Fachliche Konsistenz / Semantic consistency

Keine neue fachliche Anforderung und keine neue GSDB-Version: Baseline 3.4.4,
Sammelband 2.4.4, zwölf Checklisten und 157 stabile IDs bleiben erhalten.
Erneut verglichen: die zehn Quellenabschlüsse und deren Korrekturen im
[Quellenprotokoll](gsdb-source-review-p3-followup-2026-10-20.json),
die [157-Punkte-Matrix](gsdb-coverage-p3-followup-2026-10-20.md), normative
DE-/EN-Prüfpunkte und die tatsächliche Vierzehnerkomposition.

- BSI TR-02102-1/-2: lokale Krypto-Policy von datierten BSI-Profilen getrennt;
  TLS, RSA-PSS, Migration und konkrete Handshakes statt Scanner-Pauschalurteil.
- C3A und C5: CL-02-12/13, Architecture Governance und Testat-/Scopegrenzen
  stimmen überein; keine automatische Souveränitäts-/Datenschutzfreigabe.
- CRA: Produkt-/Einheitsbezug, Bestandsprodukte, bedingte Zertifizierung,
  Hersteller-/Steward-Fristen und CSIRT-Weiterleitung bleiben getrennt.
- KI-VO: Produkt, Werkzeugbetrieb und Organisation je Rechtsregime;
  Art.-4-Unterstützungspflicht und lokale Schulungsregeln getrennt.
- NIS2/BSIG und DORA: Einrichtung/Rolle, direkte/vertragliche Pflichten und
  verschiedene Meldeauslöser; DORA-Fristausnahmen bleiben konkret abgegrenzt.
- G7 AI-SBOM und Memory-Safe Roadmaps: CL-05-13/09-15 beziehungsweise
  CL-08-12/13; freiwilliger Standard, lokale Tests und unsichere Grenzen klar.
- DSGVO: Schwellen, Verantwortlicher/Auftragsverarbeiter, DPIA/Konsultation
  und zusätzliche lokale Freigaberegel werden nicht gleichgesetzt.

GSDB ist die fachliche Grundlage; Security Governance unterstützt Workflows,
Assurance prüft Evidence-Bindung, Project Statistics den Statistikvertrag.
Alle übrigen Presets behalten ihre dokumentierten Architektur-, A11Y-,
Plattform-, Agenten-, Routing-, Intake- und Ausführungsgrenzen. Installation
startet keinen Workflow. Der Security-0.7.2-Projektzusatz für Betreiberrollen/
Art. 4 bleibt durch GSDB-Screening erforderlich, kein Paketfehler wird verdeckt.

EN: No new semantic conflict found in the compared assertions, bilingual
requirements, coverage rows and installed preset responsibilities. This is a
scoped consistency review, not a fresh full-text audit of every external source.
ISO remains BibliographyVerified. Earlier capture hashes are historical,
not new downloads. No product conformity or physical assistive-tech acceptance.

Gezielte aktuelle Primärquellen-Gegenprüfung / targeted fresh primary checks:
[Kommission: CRA-Meldungen](https://digital-strategy.ec.europa.eu/en/policies/cra-reporting)
bestätigt Hersteller seit 11.09.2026 und Steward Art.24(3) ab 11.12.2027.
[KI-VO-Änderungsakt](https://eur-lex.europa.eu/legal-content/EN/ALL/?uri=CELEX%3A32026R1744)
und [DORA-Meldeakt](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32025R0301)
wurden für Fristen/Ausnahmen über den offiziellen EUR-Lex-Index gegengeprüft;
direkte ELI-Opens waren JS-blockiert. Kein neuer Volltext-/Byte-Capture behauptet.

## Vierzehnerprofil / Fourteen-preset profile

Alle 14 sind aktiviert, entsprechen exakt der Matrix und dem jeweils aktuellen
veröffentlichten stabilen GitHub-Release beim erneuten Abruf. Unveröffentlichte
Repo-Arbeit oder spätere Community-Katalogeinreichung ist davon getrennt.

| Preset | Installiert = Release / Installed = release | Priorität / Priority |
|---|---|---:|
| security-governance | v0.7.2 | 10 |
| secure-development-assurance-governance | v0.1.5 | 15 |
| architecture-governance | v0.6.3 | 20 |
| isaqb-architecture-governance | v0.2.3 | 30 |
| a11y-governance | v0.4.4 | 40 |
| cross-platform-governance | v0.2.3 | 50 |
| agent-parity-governance | v0.4.3 | 60 |
| model-routing-governance | v0.1.5 | 61 |
| intake-authoring-governance | v0.3.8 | 64 |
| intake-review-governance | v0.2.5 | 65 |
| intake-sequencing-governance | v0.2.9 | 66 |
| autonomous-run-governance | v0.4.5 | 70 |
| parallel-autonomous-run-governance | v0.2.7 | 80 |
| project-statistics-governance | v0.1.1 | 90 |

## Evidence und technische Validierung / Evidence and technical validation

Neuer [Assurance-Kontext](../security/secure-development/2026-10-20-gsdb-assurance015-revalidation/evidence-matrix.md)
mit unveränderten kanonischen Dokumentbindungen; Assurance 0.1.5 validiert ihn
neu. Historische Kontexte bleiben unverändert. Die PR-Sichtung ist als eigene
Evidence erfüllt. Die vier breiteren menschlichen Entscheidungen werden aus
der PR-Mergefreigabe nicht abgeleitet; Closure/Gesamt bleiben entsprechend
Blocked, technische Baseline/Delta/Image-Prüfung davon getrennt.

Technische Ergebnisse und exakter geprüfter Head stehen im aktuellen
[PR-Checklauf](https://github.com/hindermath/home-baseline/pull/337/checks).
Bestätigte lokale Resultate werden nach Abschluss hier ergänzt. Frühere
Head-Ergebnisse gelten nicht als Prüfung des neuen Heads.

## Documentation Impact und Distribution

UpdateRequired: neuer Review-/Autoritäts-/Deliverynachweis mit diesem Bericht
und neuem Evidence-Kontext. Owner Thorsten Hindermann; Maintainer/Reviewer;
Leserpfad PR → Bericht → Matrix/Quellen → Assurance-Kontext → CI.
Kanonische Quellen bleiben GSDB-Manifest, Checklisten, Preset-Matrizen und
Installed-/Source-Locks. DE zuerst/EN danach im selben Dokument; beschreibende
Links, textliche Statuswerte, keine farbabhängigen Entscheidungen.
Dokumentklasse: Review-Evidence, sourceOnly; kein Sync dieser Evidence.
GeneratedUpdate: Statistik aus Git-Historie/Statistik-Konfiguration mit
`render-project-statistics.*`; keine Methodikänderung. Die Änderungen des
ursprünglichen PR an Prüfscripten und gemeinsamer Guidance sind homeRuntime
und benötigen nach Merge Syntaxcheck, Check-only, Vorschau und Konfliktprüfung
aus stabiler Level-0-Quelle. Keine Presetquellen-/Paketänderung, keine Level-2-
Verteilung. Re-Evaluation bei Quellen-, Preset-, Baseline- oder Autoritätsdrift.

EN: New source-only review evidence; generated statistics under the unchanged
contract; sync only manifest-selected runtime after successful exact-head merge.
No downstream rollout. Quarterly and annual schedules remain unchanged.
