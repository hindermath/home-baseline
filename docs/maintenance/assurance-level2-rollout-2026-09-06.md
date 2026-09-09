# Assurance-Level-2-Rollout / Assurance Level-2 Rollout

## Aktueller Feldteststand 2026-09-09 / Current field-test state

Die Gruppe umfasst jetzt sieben Ausbildungs-/Referenz-Repositories:
TinyCalc, TinyPl0, InventarWorkerService, absdd-image-sandbox, TuiVision,
home-baseline (Level 0) und AOC. Alle sieben Einzelberichte empfehlen
`ReleaseAccepted` ausschließlich im jeweiligen technischen Feldtest-Scope.
Level-0-PR #277 und AOC-PR #44 sind gemergt und beide main-Branches wurden
auf 0/0 synchronisiert. Die bisherigen fünf Abnahmen bleiben historisch erhalten.

*The group now includes seven educational/reference repositories. All seven
scoped technical field reports recommend `ReleaseAccepted`. The two new
installation PRs are merged and synchronized; historical evidence is retained.*

Der [kanonische Siebener-Bericht](secure-development-assurance-v013-field-test-rollup.md)
enthält Merge-Commits, Prüfgrenzen, Findings und Termine. Er ersetzt keine
Produktfreigabe und ist keine zentrale Preset-Abnahme. Diese bleibt bis zum
Upstream-Ergebnis von github/spec-kit#4455 separat ausstehend.

*The canonical seven-repository report binds evidence, limits and dates.
Central preset acceptance remains a separate future review after the upstream
outcome; no product approval is inferred.*

## Historischer Feldteststand 2026-09-08 / Historical field-test state

Der v0.1.3-Feldtest ist in allen fünf vorgesehenen Level-2-Repositories
abgeschlossen. Jeder projektbezogene Feldbericht empfiehlt `ReleaseAccepted`
ausschließlich für die Funktionsfähigkeit des unveränderten Presets in seinem
jeweiligen Ausbildungs- und Beispielscope. Der kanonische
[5/5-Konsolidierungsbericht](secure-development-assurance-v013-field-test-rollup.md)
bindet die Einzelberichte, geprüften PRs und Merge-Commits.

*The v0.1.3 field test is complete in all five intended Level-2 repositories.
Each project report recommends `ReleaseAccepted` solely for the unchanged
preset's behavior in its educational/example scope. The canonical
[5/5 roll-up](secure-development-assurance-v013-field-test-rollup.md) binds the
individual reports, verified pull requests, and merge commits.*

| Reihenfolge / Order | Ziel / Target | Feldtest-PR / Field-test PR | Merge | Projekturteil / Project verdict |
|---|---|---|---|---|
| 1 | TinyCalc | [#74](https://github.com/hindermath/TinyCalc/pull/74) | `1aa45a86d8fd310bb2a848d96c8ce10bf5a7d9f7` | `ReleaseAccepted` |
| 2 | TinyPl0 | [#92](https://github.com/hindermath/TinyPl0/pull/92) | `a988d6418aeddf3e8979edb3f1e25275661bdf2a` | `ReleaseAccepted` |
| 3 | InventarWorkerService | [#67](https://github.com/hindermath/InventarWorkerService/pull/67) | `73ceab5a9057afded9abc3b47f1b5ea2b1ddef96` | `ReleaseAccepted` |
| 4 | absdd-image-sandbox | [#60](https://github.com/hindermath/absdd-image-sandbox/pull/60) | `d3731df24649cf189e3d97412c9285d3170c082a` | `ReleaseAccepted` |
| 5 | TuiVision | [#171](https://github.com/hindermath/TuiVision/pull/171) | `a58c202668209b3b0cf116bcc8a0b0c5d6ac5d9b` | `ReleaseAccepted` |

Alle aktiven Gate-Kontexte melden Baseline, Delta, Closure und Image Impact
`Ready`; `technicalValidation` ist jeweils `Fulfilled`. Die technische
Evidence-Wiedervorlage ist einheitlich auf `2027-09-08` gesetzt. C5, CRA und
formale Produktkonformität sind für den gegenwärtigen nichtkommerziellen
Ausbildungs- und Beispielscope `N/A`; die regulatorische Scope-Wiedervorlage
ist `2026-12-31`. Die synthetischen C5-/Zertifizierungs-Negativfälle prüfen nur
das sichere Blockieren unzulässiger Behauptungen und sind keine C5-Prüfung.
`pilotAuthorization`, `projectAcceptance` und `generalRelease` bleiben überall
`Open`.

*All active gate contexts report baseline, delta, closure, and image impact as
`Ready`; `technicalValidation` is `Fulfilled`. Technical evidence is due for
review on `2027-09-08`. C5, CRA, and formal product conformity are `N/A` for
the current non-commercial educational/example scope; regulatory scope review
is due on `2026-12-31`. Synthetic C5/certification negative cases test safe
blocking only and are not C5 assessments. `pilotAuthorization`,
`projectAcceptance`, and `generalRelease` remain `Open` everywhere.*

Die zentrale v0.1.3-Preset-Abnahme ist **noch nicht entschieden**. Die
Community-Einreichung [github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455)
war bei der Live-Prüfung am 2026-09-08 weiterhin `OPEN` und ohne
Maintainer-Kommentar. Erst nach dem Upstream-Ergebnis folgt eine gesonderte
zentrale Preset-Prüfung mit genau einer Empfehlung. Pre-Release-Status,
Community-Issue und Maintainer-Kommunikation wurden in diesem Abschluss nicht
verändert.

*The central v0.1.3 preset acceptance is **not decided yet**. At the live check
on 2026-09-08, community submission
[github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455) remained
`OPEN` without a maintainer comment. A separate central preset review with
exactly one recommendation follows only after the upstream outcome. This
closeout does not change the pre-release state, community issue, or maintainer
communication.*

## Historischer Rolloutstand 2026-09-07 / Historical Rollout State

Das genehmigte Assurance-Preset **v0.1.3** ist in allen fünf Ziel-Repositories
gemergt, lokal synchronisiert und im lokalen Register mit Profil 13 erfasst.
Die zwölf bisherigen Presets, ihre Versionen, Prioritäten und Aktivierungswerte
bleiben je Ziel unverändert. Keine weitere Installation, kein Home-Sync.
Dieser Abschnitt und die Abschnitte ab „Auftrag und Grenzen“ bewahren die
historischen v0.1.2-/v0.1.3-Rolloutschritte mit ihren damaligen
Unterbrechungen. Ihre Pending-Aussagen sind keine aktuellen Arbeitsaufträge;
maßgeblich ist der aktuelle Feldteststand oben.

*Approved Assurance v0.1.3 is merged, locally synchronized and registered at
profile 13 in all five targets. Preserve the twelve previous presets and their
versions/priorities/enabled states in every target. No additional deployment
or Home sync. This section and the sections below retain historical v0.1.2 and
v0.1.3 rollout steps and stops. Their old pending statements are not current
work instructions; the current field-test state above is authoritative.*

| Ziel / Target | v0.1.3-PR | Merge |
|---|---|---|
| TinyCalc | [#73](https://github.com/hindermath/TinyCalc/pull/73) | `5da06eb06ee1635208b17d4b4b4f97afa1f06023` |
| TinyPl0 | [#87](https://github.com/hindermath/TinyPl0/pull/87) | `a3835067ef3cfad37248f2e5be2329fb2694a289` |
| InventarWorkerService | [#63](https://github.com/hindermath/InventarWorkerService/pull/63) | `82b9e17743235fc0d656972cf637470392a76604` |
| absdd-image-sandbox | [#57](https://github.com/hindermath/absdd-image-sandbox/pull/57) | `1e80727f6fe4b8a82b7fd4956c723681c49661c1` |
| TuiVision | [#168](https://github.com/hindermath/TuiVision/pull/168) | `6af85182ba5f31964c7d92fec4d78177c81db7c0` |

### Wiederaufnahme und technische Ausnahmen / Resumption and Technical Exceptions

Sandbox: 14/14 finale CI-Checks an Head `a90ccc669dc1e9641238aa1f234bccaf6e788f4b`
bestanden. Drei ursprüngliche Review-Threads mit kanonischer v0.1.3-Korrektur
aufgelöst; einziger neuer Hinweis zum PR-Link korrigiert. 1144 Bestandsdateien,
zwölf Registry-Einträge und ältere Profile erhalten. Die bestehende Matrix
bleibt unverändert. Kein Container-/Image-Eingriff, kein Home-Sync.

TuiVision: 3373 geschützte Bestandsdateien erhalten. Einzige zusätzliche,
ausdrücklich genehmigte technische Evidence-Ausnahme: genau drei Hashfelder
für die geänderte Registry und AGENTS.md, mit
[Alt-/Neu-Provenienz](https://github.com/hindermath/TuiVision/blob/main/docs/maintenance/assurance-technical-rebinding.md).
Alle anderen Bytes des Bewertungs-JSON, sämtliche 157 Kontrollbewertungen,
Reviewdaten, Rollen, Risiken und Human-only-Entscheidungen bleiben identisch.
Die neue Matrix erschließt diese Bewertungen; die historischen zwölf
Preset-Bewertungen werden nicht nachträglich in 13 umgeschrieben.

Die drei zunächst roten RLSE007-Tests sind nach der Hashkorrektur ohne jede
Teständerung grün. Vollständiger Release-/Coverage-Lauf bei Build 520: Exit 0;
alle fünf Framework-Module oberhalb 70 %. Finale TuiVision-CI an Head
`6dc38662489d4239d7a60cdab59283a127966a82`: 31 erfolgreiche Checks, ein optionaler
Skip. Copilot konnte zweimal wegen eines Dienstfehlers nicht prüfen; dies
ist **keine** unabhängige Reviewfreigabe. Abschließende Diff-/Erhaltungskontrolle
ohne offenen Befund; Admin-Merge unter Thorstens expliziter Freigabe nur für
die formale Reviewer-Hürde, niemals für technische Fehler.

*Sandbox passed all 14 exact-head checks, resolved canonical product findings
and fixed its PR-body link. It preserves 1144 files and older presets. TuiVision
preserves 3373 protected files and changes exactly three additionally authorized
hash fields with old/new provenance; every other evidence byte and all domain
and human decisions remain intact. Previously failing tests pass unchanged;
full Release coverage passes with all five modules above 70%. Its 31 final
checks pass with one optional skip. Copilot failed twice; no independent
approval is claimed. Focused diff/preservation review found no outstanding
issue, and explicit admin authority covered only the formal reviewer barrier.*

### Evidence-Matrizen / Evidence Matrices

| Ziel / Target | Quelle / Source | Lieferung / Delivery |
|---|---|---|
| TinyCalc | Bestehende Matrix erhalten / existing matrix preserved | Keine Ergänzung erforderlich / no addition needed |
| absdd-image-sandbox | Bestehende GSDB-Matrix erhalten / existing GSDB matrix preserved | Keine Ergänzung erforderlich / no addition needed |
| TuiVision | 157 Kontrollen aus rl-se-self-review.json / 157 controls | Enthalten in PR #168 / included in PR #168 |
| TinyPl0 | 157 Kontrollen aus assessment.json / 157 controls | [PR #88](https://github.com/hindermath/TinyPl0/pull/88), Merge: `018550004034a2393144d7e5fc958aebf7d428a5` |
| InventarWorkerService | 157 Kontrollen aus assessment-records.json / 157 controls | PR: [#64](https://github.com/hindermath/InventarWorkerService/pull/64); Merge: `siehe verknüpften PR / see linked PR` |

Die neuen Dateien heißen exakt `evidence-matrix.md`. Sie binden ihren
Quell-Dateihash und erschließen alle 157 eindeutigen IDs mit unveränderten
Quellstatuswerten. Sie sind keine erneute fachliche Bewertung. Rollen,
Begründungen, Risiken und Trigger bleiben in der verlinkten kanonischen Quelle.
Bei TinyPl0 bleiben zusätzlich die verpflichtenden IDE-Commitmetadaten und
der Worklog die einzigen Änderungen außerhalb der neuen Matrix und Statistik;
kein IDE-Verhalten, lokaler Produkt-Build/-Test oder NuGet-Release.

*New evidence-matrix.md files bind source file hashes and index all 157 unique
IDs with literal source states. They do not reassess the domain. Roles, reasons,
risks and triggers remain in the canonical source. TinyPl0 additionally updates
only mandatory IDE commit metadata/worklog, not product behavior or releases.*

### Statusgrenzen / Status Boundaries

Die gleichartige Präzisierung des TinyPl0-Statistiktexts ist separat in
[PR #89](https://github.com/hindermath/TinyPl0/pull/89) nachvollziehbar.
Der jeweilige verknüpfte PR ist der maßgebliche Nachweis für endgültigen
Merge-Commit, CI und bearbeitete Review-Kommentare der Matrix-/Dokumentations-
Ergänzungen. / TinyPl0 ledger clarification is separately tracked in PR #89;
linked PRs are authoritative for the final merge commit, CI and addressed
review comments of matrix/documentation additions.

TinyCalc: Kontext `2026-09-05-rl-se-self-assessment`, Baseline/Delta/Closure/
Image-Impact jeweils `Ready`, gesamt `Ready`. `technicalValidation=Fulfilled`;
`pilotAuthorization`, `projectAcceptance` und `generalRelease` bleiben
`Open`. Dokumentierte nächste Aktion: unabhängigen technischen Review
durchführen und Human-only-Entscheidungen bis zu autorisierter Evidence offen
lassen. Technische `Ready`-Ergebnisse sind keine menschliche Freigabe.
TinyPl0, InventarWorkerService, Sandbox und TuiVision melden unter Bash und
PowerShell weiterhin `Blocked` (Exit 2): Im jeweils ausgewählten Kontext
fehlt `baseline.json`; die weiteren Gate-JSONs dürfen ebenfalls nicht erfunden
werden. Ohne vollständigen Vertrag werden für Baseline, Delta, Closure und
Image-Impact keine erfolgreichen Ergebnisse und für `technicalValidation`,
`pilotAuthorization`, `projectAcceptance`, `generalRelease` keine fehlenden
Entscheidungen abgeleitet. Die Matrizen schließen die Navigationslücke,
nicht die fachliche Gate-Evidence-Lücke.

Ausgewählte blockierte Kontexte / selected blocked contexts:

- TinyPl0: `2026-08-30-tinypl0-hardening`.
- InventarWorkerService: `2026-08-30-secure-development-hardening`.
- Sandbox: `2026-08-30-gsdb-baseline-assessment`.
- TuiVision: `2026-08-30-rl-se-checklist-self-review`.

Nächster möglicher fachlicher Schritt ist ein separat beauftragter Kontext-
Review mit Quellenaktualität, Manifestbindung, echten Gate-Nachweisen und
menschlichen Entscheidungen in getrennten Grenzen. Keine automatische neue
Community-Einreichung, kein Maintainer-Kontakt, kein C5-Konformitäts-, Testat-
oder Zertifizierungsclaim.

*TinyCalc retains its prior complete gate contract; technical Ready is not
pilot/project/general authorization. The other four contexts still return
Blocked (exit 2) in both shells because baseline.json is absent. Never fabricate
the remaining gate records or human decisions. Matrices close navigation gaps,
not domain evidence gaps. Any substantive context review requires a separate
instruction, genuine evidence and separate human boundaries. No new community
submission, maintainer contact or C5 conformity/attestation/certification claim.*

### Zentrale Prüfung / Central Verification

Das öffentliche v0.1.3-Archiv ist gebunden an Commit
`0d03aa9ebe8f74a26e331815bca5609fb48d7a14` und ZIP-SHA-256
`9023b442b4d82e25bee5a7fe9b73efb7f591a4f265f54061ae6e4a56b9b5c75f`.
Quellenbindung, Quellenübersicht und Profilmatrix verwenden denselben Pin.
Lokaler vollständiger Lauf von `scripts/tests/test-preset-sources.ps1` am
2026-09-07 bestanden: 13 hashgeprüfte Pakete, Profile 8–13, Assurance-Vertrags- und
Negativtests, Bash-/PowerShell-Parität und alle acht erzeugten Befehlsoberflächen.
Die Tests laufen nur in temporären Projekten. Ein Vorher-Snapshot schützt
623 zentrale Installations-/Agentendateien; keine Home-Baseline-Installation
wird durch die neue Quellenbindung aktualisiert.

*The source lock, index and profile use the same immutable v0.1.3 pin and ZIP
hash. The complete local package-source suite passed on 2026-09-07: thirteen
verified packages, profiles 8–13, contract/negative/parity tests and eight
generated command surfaces in temporary projects. A snapshot protects 623
central installation/agent files; the new source pin does not upgrade the
Home Baseline installation.*

Distributionsgrenze: Nachweise und Quellenübersicht sind `sourceOnly`.
Die Profilkonfiguration unter `scripts/config/` gehört laut Home-Sync-Manifest
zu `homeRuntime`. Sie wird in diesem Auftrag ausdrücklich **nicht** nach
`~/` verteilt. Die dadurch verbleibende unterschiedliche Pin-Version in der
Home-Betriebskopie ist bewusst, kein Auftrag zu einem impliziten Home-Sync.
Ein späterer Home-Runtime-Sync benötigt einen separaten Auftrag.

*Evidence and source documentation are sourceOnly; scripts/config belongs to
homeRuntime under the manifest. This task explicitly does not distribute it
to the Home operating copy. Its retained older pin is intentional, not authority
for an implicit sync. A later Home-runtime sync requires a separate request.*

## Auftrag und Grenzen / Authority and Boundaries

Thorsten hat Assurance v0.1.2 für genau fünf bestehende Level-2-Repositories
freigegeben, seriell in der Reihenfolge unten. Die zwölf vorherigen Presets
werden weder aktualisiert noch neu installiert. Das neue Paket bleibt
Priorität 15, aktiviert. Ältere Profile und globale Defaults bleiben erhalten.
Keine neue Preset-Version oder Community-Einreichung, kein Home-Sync,
kein Image-Build/-Publish und keine fachlichen Assurance-/GSDB-Reviews.
Admin-Merge ist ausdrücklich ausschließlich für die formale Codeowner-Hürde
nach erfolgreicher technischer Prüfung und bearbeitetem Review freigegeben.

*Thorsten authorized exactly five targets in the serial order below. Preserve
the existing twelve presets and add only Assurance v0.1.2, enabled at priority
15. Keep older profiles and global defaults. No release, community submission,
Home sync, image build/publication or substantive assurance/GSDB review.
Explicit admin-merge authority covers only the formal Codeowner barrier after
passing technical checks and addressed review findings.*

## Paketbindung / Package Binding

Die ursprüngliche v0.1.2-Bindung bleibt hier als historische Evidence erhalten.
Die [aktuelle Quellenbindung](preset-source-lock.json) ist inzwischen v0.1.3
gemäß dem gesondert freigegebenen Korrekturauftrag unten.

- [Repository / repository](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance).
- Tag `v0.1.2`, Commit `02423602592ad0183454e259df628ab940436ba6`.
- [Tag-ZIP / tag ZIP](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/archive/refs/tags/v0.1.2.zip).
- SHA-256 `4eb30804bb3c329681e0b7d44187c8daeb3e9e4f250bb6003d5b746c0ad0b656`.

Archivprüfung, isolierte Vertrags-/Oberflächentests sowie Komposition der
Profile 8 bis 13 sind bestanden. Das installierte Paket wird je Ziel gegen
das verifizierte Archiv verglichen. Beide Statusvalidatoren laufen lesend;
`Blocked` bei fehlender Evidence ist keine fehlgeschlagene Paketinstallation.

*The archive hash, isolated contract/surface tests and profile 8–13 composition
passed. Compare each installation against the verified archive. Status is
read-only in both shells; missing evidence blocks assessment, not installation.*

## Lieferstand / Delivery State

| Reihenfolge / Order | Ziel / Target | PR | Merge-Commit | Zustand / State |
|---|---|---|---|---|
| 1 | RiderProjects/TinyCalc | [#72](https://github.com/hindermath/TinyCalc/pull/72) | `74b1e5665c807e73d6fd1c5474aa23be9ff9e6ea` | Gemergt, synchronisiert, Profil registriert / merged, synchronized, profile registered |
| 2 | RiderProjects/TinyPl0 | [#85](https://github.com/hindermath/TinyPl0/pull/85) | `c5e722f559ea957e0728465319235d2e5c7dc6ec` | Gemergt, synchronisiert, Profil registriert / merged, synchronized, profile registered |
| 3 | RiderProjects/InventarWorkerService | [#62](https://github.com/hindermath/InventarWorkerService/pull/62) | `cc87614f0a27e6e596101e16a0d81a2641ac86ac` | Gemergt, synchronisiert, Profil registriert / merged, synchronized, profile registered |
| 4 | container-images/absdd-image-sandbox | [#57](https://github.com/hindermath/absdd-image-sandbox/pull/57) | Nicht gemergt / not merged | CI grün, bestätigte Produktfehler im Review; Rollout gestoppt / CI green, confirmed product defects; rollout stopped |
| 5 | RiderProjects/TuiVision | Noch offen / pending | Noch offen / pending | Unverändert / unchanged |

Die lokale Registry wird pro Ziel erst nach Merge und Main-Synchronisation
auf `secure-development-assurance-thirteen-governance-presets` umgestellt.
Andere Metadaten, Einträge und der Registry-Default bleiben unverändert.
Die Tabelle unterscheidet bewusst Vorbereitung und erfolgreiche Lieferung.

*Switch each local registry entry only after successful merge and main sync.
Preserve other metadata, targets and defaults. Preparation is not completion.*

## Erhaltungsnachweis und Ausnahmen / Preservation and Exceptions

## Korrekturadoption v0.1.3 / v0.1.3 Patch Adoption

Thorsten hat MergeAndSync mit Admin-Bypass auch für den kanonischen
Korrektur-PR ausdrücklich freigegeben. [Produkt-PR #4](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/4)
ist gemergt, lokales `main` synchronisiert. Finaler Head:
`b0c29f2cbc5cfe4f623db432f77f4289ee875aa3`; Merge und Tag:
`0d03aa9ebe8f74a26e331815bca5609fb48d7a14`.
[Release v0.1.3](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.3)
ist öffentlich als Patch-Prerelease verfügbar.
ZIP-SHA-256: `9023b442b4d82e25bee5a7fe9b73efb7f591a4f265f54061ae6e4a56b9b5c75f`.

Alle drei CI-Plattformen des finalen Commits bestanden in Lauf 34059234091.
Review-Kommentare sind bearbeitet: README-Gliederung korrigiert,
fehlende/leere Risiken zusätzlich getestet; der behauptete PowerShell-
Syntaxfehler wurde durch direkte Ausführung und CI als Fehlalarm widerlegt.
Öffentliches Paket bytegleich zur gemergten Quelle; öffentliche ZIP-Oberflächen,
13 Paketbindungen und isolierte Komposition aller Profile 8 bis 13 bestanden.

| Ziel / Target | Korrektur-PR / Patch PR | Zustand / State |
|---|---|---|
| TinyCalc | [#73](https://github.com/hindermath/TinyCalc/pull/73) | Gemergt und synchronisiert: `5da06eb06ee1635208b17d4b4b4f97afa1f06023`; 19/19 Checks, Review ohne Befunde / merged and synchronized; 19 passing checks, clean review |
| TinyPl0 | Noch offen / pending | Unverändert v0.1.2 / unchanged v0.1.2 |
| InventarWorkerService | Noch offen / pending | Unverändert v0.1.2 / unchanged v0.1.2 |
| absdd-image-sandbox | [#57](https://github.com/hindermath/absdd-image-sandbox/pull/57) | Noch v0.1.2 auf offenem Branch / still v0.1.2 on open branch |
| TuiVision | Noch offen / pending | Zwölf Presets unverändert / twelve presets unchanged |

*The additional product PR's MergeAndSync/admin authority was explicitly
granted. Product PR #4 is merged and synchronized; immutable v0.1.3 is public.
All exact-head CI platforms passed. Review findings were fixed or refuted
with executable evidence. Public archive identity, generated surfaces,
thirteen package bindings and profiles 8–13 composition passed. The table
tracks adoption separately from the earlier v0.1.2 integration.*

### Ursprüngliche Integration / Original Integration

Vorher-Snapshots schützen vorhandene Presets, generierte Befehle, Baseline und
Security-Evidence. Unveränderte Registereinträge und Profildefinitionen werden
strukturell verglichen. Jeder Ziel-PR enthält seinen Integrationsnachweis unter
`docs/maintenance/secure-development-assurance-integration.md`.

- TinyCalc: Assurance war bereits installiert, keine Neuinstallation.
  581 geschützte Dateien geprüft. Einzige ausdrücklich nachträglich genehmigte
  Ausnahme: `sourceInventory[SRC-055].normalizedSha256` in der GSDB-Matrix
  wurde an die geänderte `AGENTS.md` gebunden. 580 Dateien bytegleich;
  alle Bewertungen und menschlichen Entscheidungen unverändert.
  Bash-/PowerShell-GSDB-Prüfungen und 19/19 PR-Checks bestanden;
  erneuter Review ohne Befunde. Status: vier Gates `Ready`,
  `technicalValidation=Fulfilled`, übrige drei Entscheidungsgrenzen `Open`.
- TinyPl0: 553 geschützte Dateien und zwölf Registereinträge unverändert.
  Status in beiden Shells: `Blocked`, `evidence-matrix.md` fehlt.
  Vorgeschriebene IDE-Versionsmetadaten fortgeschrieben, kein IDE-Verhalten
  und keine NuGet-Paketversion geändert.
  32 PR-Checks bestanden, drei optionale Jobs übersprungen; erneuter Review
  ohne Befunde. / 32 passing checks, three optional skips, clean repeat review.
- InventarWorkerService: 562 geschützte Dateien und zwölf Registereinträge
  unverändert; Status `Blocked`, fehlende `evidence-matrix.md`.
  Der vorhandene Registry-Test musste von zwölf auf das genehmigte 13er-Profil
  umgestellt werden und prüft jetzt zusätzlich Versionen und Prioritäten.
  Eine bereits auf `main` fehlerhafte Intake-Testreferenz wurde auf den
  vorhandenen branchgestempelten Dateinamen korrigiert. Anforderungen,
  Baseline, Evidence und Produktverhalten bleiben unverändert.
  28 PR-Checks bestanden, nur Pages-Deployment übersprungen; erneuter Review
  ohne Befunde. / 28 passing checks, Pages deployment skipped, clean repeat review.

*InventarWorkerService preserves 562 protected files and the twelve original
entries. Assessment is blocked on missing evidence. Its existing registry test
now verifies the approved thirteen-preset profile, including version and
priority. An already-broken intake test reference now targets the existing
branch-stamped file; no requirements, baseline, evidence or product behavior
changed.*

*Snapshots protect installed presets, generated commands, baseline and security
evidence; original registry entries and profiles are compared structurally.
Each target PR carries its detailed integration record. TinyCalc's only
explicitly authorized evidence exception is the single AGENTS.md source hash;
ratings and human decisions are unchanged. TinyPl0 retains all protected files
and old registry entries, and correctly blocks assessment on missing evidence.
Its mandatory IDE version metadata update changes no behavior or NuGet release.*

## Lieferstopp nach Produktreview / Delivery Stop After Product Review

Am 2026-09-06 hat das Review von Sandbox-PR #57 drei Kommentare mit zwei
bestätigten Fehlerklassen im unveränderten öffentlichen v0.1.2-Paket geliefert.
Alle 14 CI-Checks des PR-Heads `da38035fc078e6781ded5a4b35ee0839954b9afc`
sind bestanden; die zusätzlich reproduzierten technischen Fehler blockieren
dennoch den Merge. Die Admin-Freigabe gilt nur für die formale Reviewer-Hürde.

1. [Kontextbindung / context binding](https://github.com/hindermath/absdd-image-sandbox/pull/57#discussion_r3945122941):
   In einer isolierten Fixture existiert ausschließlich der Kontext
   `2099-01-01-bar-foo` mit `contextId=bar-foo`. Ein Delta-Review mit
   angefordertem `contextId=foo` meldet in beiden Shells fälschlich
   `Reviewed: gate=delta context=foo mode=development outcome=Ready`, Exit 0.
   Das Suffix-Matching und die fehlende Gleichheitsprüfung der Evidence-ID
   erlauben damit eine falsche Erfolgszuordnung.
2. [Risikotyp-Parität / risk type parity](https://github.com/hindermath/absdd-image-sandbox/pull/57#discussion_r3945122997):
   Vollständig befülltes `acceptedRisks` als einzelnes JSON-Objekt statt Array
   ergibt Bash Exit 2, aber PowerShell `ReadyWithAcceptedRisks`, Exit 0.
   Die Kontrollfixture mit einem einelementigen Array besteht beide Shells.

Reproduktion ausschließlich in temporären synthetischen Delta-Fixtures,
ohne fachlichen Review eines Projektkontexts und ohne Änderung installierter
Pakete. Die zwölf bisherigen Presets bleiben überall unverändert. Die drei
bereits gemergten Integrationen werden nicht stillschweigend zurückgerollt
oder aktualisiert. Sandbox #57 bleibt offen, das zentrale Profil dort bleibt
zwölf; TuiVision wurde ausschließlich gelesen und bleibt unverändert.

Thorsten hat die Korrektur im eigenständigen Assurance-Preset-Repository,
eine neue unveränderliche Patch-Version und deren Integration in genau diese
fünf Ziel-Repositories anschließend ausdrücklich genehmigt.
[Korrektur-PR #4](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/4)
bereitet v0.1.3 vor. Neue Regressionstests wurden vor der Korrektur rot
nachgewiesen; lokal bestehen Vertrags-/Shell-Paritäts- und alle acht
Oberflächentests. Der funktionale Commit `d492dfcb9441dda4ed99c854bcbf19a9b5b1439d`
hat den vollständigen Linux-/macOS-/Windows-CI-Lauf 34058472667 bestanden.
Copilot empfiehlt die Freigabe; der einzige README-Gliederungshinweis wurde
in `4a1ca4c02464c5bd67132e6cac5a980464e38c29` korrigiert und aufgelöst.
Erneute Exact-Head-CI und Review sind angefordert; das Release ist noch offen.
Die Admin-Ausnahme für diesen zusätzlichen Produkt-PR ist separat angefragt.
Keine lokale
Produktkopie patchen, kein vorhandenes Tag verändern, keine zusätzliche
Community-Einreichung aus diesem Auftrag ableiten. Bis zur Korrektur die
betroffenen v0.1.2-Review-Erfolgsmeldungen nicht als belastbaren Nachweis nutzen.

*On 2026-09-06, the Sandbox review identified two reproducible product defects
despite all 14 CI checks passing: suffix-based context selection accepts the
wrong context in both shells, and a JSON object for acceptedRisks passes
PowerShell while Bash rejects it. A valid array control passes both shells.
Only isolated synthetic fixtures were used. The original twelve presets remain
unchanged. The first three deliveries remain installed; Sandbox PR #57 stays
open and its central profile remains twelve. TuiVision is untouched. Further
delivery now has Thorsten's explicit authority for a canonical patch release
and adoption in exactly these five repositories. Product PR #4 prepares v0.1.3;
red-first regressions and local contract/parity plus eight surface tests pass.
Functional commit d492dfc passed cross-platform CI run 34058472667. Copilot
recommended approval; its sole README heading nit was fixed and resolved in
4a1ca4c. Exact-head checks and repeat review are pending, as is release. The formal admin exception
for this additional product PR has been requested separately. Do not patch vendor copies,
rewrite tags, or infer a new community submission. Do not rely on affected
v0.1.2 review success messages until corrected.*

## Dokumentationsauswirkung / Documentation Impact

`UpdateRequired`; Owner Thorsten Hindermann. Zielgruppen: Maintainer,
KI-Agenten und spätere Fehleranalyse. Leserpfad: dieser Rollout-Nachweis →
Ziel-PR → lokale Integrationsanleitung → Paket-README. Produktquelle bleibt
das GitHub-Release, Integrationsquelle der Profilkatalog. Deutsch zuerst,
Englisch danach; Text und Links funktionieren ohne visuelle Zusatzinformation.
Diese Dokumentation ist `sourceOnly`; die Profilkonfiguration ist
`homeRuntime`, wird aber ausdrücklich nicht nach Home verteilt. Kein Home-Sync.
Re-Evaluation bei nächstem
autorisiertem Preset-Rollout, Baseline-/Profiländerungen oder neuen Befunden.
Die C5-Abgrenzung und alle Human-only-Entscheidungen bleiben unverändert.

*Documentation impact is UpdateRequired, owned by Thorsten Hindermann.
The bilingual text-first reader path connects rollout evidence, target PRs,
local integration guides and package README. This is sourceOnly with no Home
sync. The profile configuration is homeRuntime but is explicitly not distributed
to Home in this task; reevaluate at the next authorized rollout or new baseline/profile/finding
change. C5 boundaries and human-only decisions remain unchanged.*
