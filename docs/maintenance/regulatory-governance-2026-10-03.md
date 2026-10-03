# Regulatorischer Governance-Rollout / Regulatory governance rollout

Date: 2026-10-03. Owner: Thorsten Hindermann.
Documentation Impact: UpdateRequired. State: SourcesAndPilotsDeliveredTrackingCloseout.

## Genehmigter Umfang / Approved scope

DE: DS-GVO, KI-VO, CRA, NIS2 und DORA als portable Evidence-Vorlagen und
praezise Anwendbarkeitspruefung integrieren. Security fuehrt die Entscheidung;
Architecture dokumentiert technische Auswirkungen. Kein Rechtsentscheid,
keine Zertifizierung, kein Produktlauf, kein Flotten- oder Community-Rollout.
EN: Portable evidence for all five regulations. Security owns applicability;
Architecture links design implications. No legal decision engine, certification,
product run, fleet delivery or community submission.

## Quellenkandidaten / Source candidates

| Repository | Candidate | Exact tested head | Review |
| --- | --- | --- | --- |
| Security Governance | v0.7.0 | e68433ce5e108f291053785f11c4ea7e964dcc44 | [PR #5](https://github.com/hindermath/spec-kit-preset-security-governance/pull/5), merged |
| Architecture Governance | v0.6.1 | e8a503625c740b9b54a0518a3acfe20f7c54de9d | [PR #7](https://github.com/hindermath/spec-kit-preset-architecture-governance/pull/7), merged |

DE: Thorsten hat beide PRs gesichtet und die begrenzten Copilot-Korrekturen sowie
MergeAndSync mit Admin-Bypass nach gruenen Checks freigegeben. Beide Quellen
sind gemergt, stabil veroeffentlicht und auf main 0/0 synchronisiert. Vorhandene
Tags bleiben unveraendert. README-Nachlaeufe PR #6 (Security) / #8 (Architecture)
sind nach eigener dreifach nativer CI gemergt; die Release-Tags wurden nicht bewegt.
EN: Human source review and bounded corrections authorised. Both sources are
merged, published stable and synchronized at 0/0. Post-publication README PRs
were separately checked and merged without moving immutable release tags.

| Release binding | Merge/tag commit | Tag ZIP SHA-256 |
| --- | --- | --- |
| Security v0.7.0 | ad0b642db325db6803b33ecd99bc7935b43d2d59 | a121ea1f9be7597a40f6f328581f680b8670ea6dc6d9ba8743095ece32af179c |
| Architecture v0.6.1 | 21c0f43d1c93455c43e989de965d45c2851e824f | 9ea0721e9475e4e955c4b71214adcc96b117ef97f977115446128bd157ed05c6 |

All 29 Security and 26 Architecture archive files matched released sources.
Release asset SHA-256 (different ZIP encoding, same payload): Security
52b62379336387cbc0b15321799f8cd0b2cc90c697179ad7dde4dbb663007142;
Architecture fcc77e2e59179e23fba64ad967260c2188073b85433df3612affedef08ec9839.
Final native PR CI: [Security](https://github.com/hindermath/spec-kit-preset-security-governance/actions/runs/37135102416),
[Architecture](https://github.com/hindermath/spec-kit-preset-architecture-governance/actions/runs/37135101688).
All six jobs completed successfully at the exact reviewed correction heads.

## Jahresreview und Stufen / Annual review and stages

See [binding policy](governance-review-and-rollout.md) and
[seven-preset register](governance-review-register.json). Annual read-only
automation is active; next due 2027-10-03 at 10:00 Europe/Berlin.
Initial full seven-preset source review remains PendingReview, not fabricated
from two source PR reviews. Central installation passes full 14-preset
Bash/PowerShell CheckOnly. Central delivery through PR #321 and both pilot
deliveries are complete. Stages C/D are WaitingAuthorization, not executing.
This final tracking/parity-test follow-up still requires its own exact-head
checks, merge and one manifest-bound Home Runtime copy.

## Technische Evidence / Technical evidence

- Local Security: six reviewed-input synthetic examples, nine negative regressions;
  offline manifest/field/wrapper contract checks passed.
- Local Architecture: five cloud/privacy/composition tests passed.
- Pinned PSScriptAnalyzer for the new PowerShell test: no findings.
- Both source trees: gitleaks and whitespace checks passed.
- All seven temporary profiles (8-14 presets): candidate source installation,
  preset list/info, new/CRA/C3A resolves and Bash/PowerShell CheckOnly passed.
- Development-source composition does not prove released-tag archive identity.
- Candidate ZIP payloads matched every tracked file: Security 29, Architecture 26.
- Candidate ZIP SHA-256 Security:
  e5f25cd309a23cfc637079bc124e49020d7d37dc78b8c51ea102c2a6fcede306
- Candidate ZIP SHA-256 Architecture:
  7b3bcfe704907abb351d647f2b78cfa29b7eb83bb7ca61c287f084e0cb224ac7
- Native exact-head CI: [Security](https://github.com/hindermath/spec-kit-preset-security-governance/actions/runs/37126054638),
  [Architecture](https://github.com/hindermath/spec-kit-preset-architecture-governance/actions/runs/37126058453).
  Read final run/job status live before merge; local results are not native proof.

## Fachliche Grenzen / Professional boundaries

DE: Produkt, Entwicklungswerkzeuge und Organisation sowie direkte gesetzliche
und vertragliche Pflichten sind getrennt. Ausbildungszweck und AI-SBOM: N/A
entscheiden nicht automatisch ueber Datenschutz/KI-VO. DORA-Rollen und NIS2-
nationale Umsetzung sind scopegebunden; Incident-Fristen nicht zwischen
Regelwerken kopieren. Teile der konsolidierten EUR-Lex-Texte waren automatisch
nicht vollstaendig abrufbar. Rechtsstand und Rolle muessen vor der konkreten
Projektentscheidung bestaetigt werden; unbekannte Angaben bleiben Open.
EN: Separate product/tool/organisation and direct/contractual duties. Education
and product AI-SBOM: N/A do not decide privacy/AI Act scope. Roles, jurisdiction
and incident triggers require independent evidence. Some consolidated texts
were not fully accessible automatically; confirm legal currency for the actual
project decision. Unknown remains Open. Tests do not prove compliance.

## Verbleibende Schritte / Remaining steps

1. Completed: human source review, bounded Copilot corrections, exact-head
   native CI, MergeAndSync, stable releases and verified immutable tag ZIPs.
2. Completed: central released bindings, baseline 3.3.0 / compendium 2.3.0,
   shared guidance, annual register and stages through PR #321, six successful
   merge workflows, managed main 0/0 and verified Home Runtime synchronization.
3. Completed: exactly Show-CommandTui400 and TinyCalc, preserving prior findings,
   receipts and human decisions. Both delivered after successful PR/merge CI;
   default branches are clean 0/0 and existing statistics are CURRENT.
4. Completed: [Show-CommandTui400 #19](https://github.com/hindermath/Show-CommandTui400/issues/19)
   and [TinyCalc #92](https://github.com/hindermath/TinyCalc/issues/92) closed as
   completed with actual delivery evidence. Final central tracking/parity-test
   closeout requires its own checks and bounded runtime copy.
5. Report-only future gate: recheck review freshness, series/candidate, local model routing, tools and
   current authority before any separately authorized product implementation.

Preserve earlier coordinated Intake/maintenance work; this report does not
authorize another fleet stage or a product implementation.

Central delivery is isolated in a managed worktree. Existing unrelated
Autonomous runner removals in the original dirty checkout are preserved there,
not included in this delivery. Whitespace was normalized only in regenerated
specify/tasks surfaces. Initial full seven-preset source review remains open;
annual-contract tests do not substitute for that review.

Local completion checks: all 14 hash/tag-bound packages, seven profiles 8-14,
Assurance lifecycle/negative/zero-write tests and annual contract negatives pass.
Documentation Impact (three entries), Bash/PowerShell generated-document checks
and secret scan of the changed diff pass. Full-directory secret-scan hits were
unchanged educational prose/examples, not introduced credentials. Legacy Profile
2 and the separate statistics-pilot context are generated and checked separately.

## Zentraler Liefernachweis und Nachlauf / Central delivery and follow-up

DE: PR #318 ist mit 23 erfolgreichen technischen Checks und einem erwarteten
Skip geliefert. Merge 58a9a10f424964653fe2316dd3a162e34c912f4a. Home Runtime
wurde nach Vorschau synchronisiert und CheckOnly bestaetigt. Der Statistik-
Drift nach Squash wurde ausschliesslich generiert in PR #319 korrigiert:
20 erfolgreiche PR-Checks, Merge 33776b8b94c053c60248ad48627d5e90ba07d46b,
alle sechs main-Workflows erfolgreich, sauberes verwaltetes main auf 0/0,
beide Statistiken CURRENT und lokale Homogenitaet 100. Originale fremde
Aenderungen im dauerhaften Klon sind weiterhin erhalten.

EN: Central source/runtime delivery and its generated statistics follow-up
passed exact-head technical gates. All six workflows at the final merge are
successful; managed main is clean 0/0. The original dirty clone is preserved.

- [Central PR #318](https://github.com/hindermath/home-baseline/pull/318)
- [Generated-only follow-up #319](https://github.com/hindermath/home-baseline/pull/319)
- [Final Assurance run](https://github.com/hindermath/home-baseline/actions/runs/37138857437)
- [Final Homogeneity run](https://github.com/hindermath/home-baseline/actions/runs/37138857411)

DE: Beim Pilot-Abgleich verblieb ein Absatz mit alten Optional-Intake-Versionen
in allen fuenf Guidance- und vier Template-Flaechen sowie zwei alte Tabellen-
Versionen im Workflow-Template. Der gezielte Nachlauf
korrigiert 0.3.5/0.2.3/0.2.6 auf 0.3.6/0.2.4/0.2.7; Pakete, Tags, Matrix,
Methodik und Validatoren bleiben unveraendert. PR #321 lieferte diesen Nachlauf
nach 20 erfolgreichen PR-Checks; Merge 8aa6fd0ed7b6ebe81c0db3e90e7fdcfd9c4fe59e,
sechs erfolgreiche main-Workflows, beide Statistiken CURRENT, verwaltetes main
0/0 und gepruefte Home-Runtime-Synchronisierung.
EN: A remaining stale optional-version paragraph requires a bounded shared
guidance follow-up was delivered before both pilots. No package/tag or validator
weakening. A new regression guard rejects the five observed obsolete prose/table
forms across ten current normative surfaces, never historical receipts.
PR #321 delivered the correction with successful PR and merge checks and verified runtime sync.

## Pilotabschluss / Pilot closeout

| Pilot | Delivery / merge | PR checks | Merge workflows | Tracking |
| --- | --- | --- | --- | --- |
| Show-CommandTui400 | [PR #21](https://github.com/hindermath/Show-CommandTui400/pull/21), 12224440ee851711fb5f2c73eb8cd98eee7e07fe | 5 successful | 3 successful | [#19 completed](https://github.com/hindermath/Show-CommandTui400/issues/19#issuecomment-5972401690) |
| TinyCalc | [PR #93](https://github.com/hindermath/TinyCalc/pull/93), 4d2a3ed622c492a2e44608c6c5c251202db1f443 | 21 successful | 7 successful | [#92 completed](https://github.com/hindermath/TinyCalc/issues/92#issuecomment-5972725565) |

DE: Beide Piloten binden Security 0.7.0, Architecture 0.6.1 und Intake
0.3.6/0.2.4/0.2.7 mit unveraenderlichen Quellen und Wartungspaket #317.
Beide operativen Zuordnungen bleiben beim 14er-Profil. Show bleibt im
Konzeptstadium: Produktbuild/Runtime sind nicht definiert und nicht geprueft.
TinyCalc: Restore, Release-Build ohne Warnungen/Fehler, 82 Tests und TUI-Smoke
bestanden. Die begrenzte GSDB-Quellenbindung wurde aktualisiert; alle vier
Aktionen bestanden in beiden Shells, 89 Evidence-Dateihashes blieben bei der
Read-only-Pruefung unveraendert. Bestehende menschliche Entscheidungen,
157 Kontrollachsen, 16 externe Pflichten und 13 Findings wurden nicht ersetzt.
Beide bestehenden Statistik-Vertraege wurden reproduzierbar fortgeschrieben,
nicht als gemessene KI-Produktivitaet ausgegeben.

EN: Both pilots bind the five released packages and maintenance #317. Show
remains concept-only; no undefined product runtime/build is claimed tested.
TinyCalc restore/build, 82 tests and smoke passed. Bounded GSDB source refresh
and both-shell read-only checks preserve existing human decisions and controls.
Existing statistics remain reproducible repository-history views.

DE: Ein roter Show-Maintenance-Check legte den fest codierten OpenCode-Pfad
offen. Der gemeinsame Paritaetstest liest jetzt ausschliesslich das getrackte
Integrationsmanifest und akzeptiert genau einen Namespace: `.opencode/command`
oder `.opencode/commands`. Leere, gemischte, absolute und Traversal-Pfade
blockieren weiterhin. Vier gezielte Tests und 89 Wartungstests (12 explizite
Plattform-/Umgebungs-Skips) bestanden in beiden Piloten. Keine Abschwaechung,
kein Cache-Fallback und kein Rerun zum Umgehen des urspruenglichen Fehlers.
Der zentrale Nachlauf verteilt genau diese gemeinsame Testdatei zur Home Runtime.

EN: The failed Show check exposed a hard-coded OpenCode namespace. The shared
test now uses only the tracked manifest, accepts one declared namespace and
rejects invalid/mixed paths. Four focused tests and the maintenance suite passed
in both pilots; platform/environment skips are explicit. No gate was bypassed.

Initial sieben vollstaendige fachliche Quellenreviews bleiben PendingReview.
Die feste Read-only-Wiedervorlage ist aktiv; sie startet keine Reparatur oder
Lieferung. C/D benoetigen eigene Auftraege. Kein Produktfeature, keine neue
Rechts-/Risiko-/C5-/Zertifizierungsfreigabe und keine Community-Einreichung.
EN: Initial full seven-preset professional reviews remain PendingReview;
the annual automation is read-only. Later fleet stages require separate authority.

Audience: maintainers, learners, project owners and privacy/compliance reviewers.
Reader path: source PR -> source contract -> this tracking report -> pilot issue.
Canonical source: standalone source repos for presets, Home Baseline for integration.
Language partner: inline DE-first/EN-second. Class: sourceOnly; no Home sync
for this report. Reevaluation: source review/release, legal amendment or scope change.
