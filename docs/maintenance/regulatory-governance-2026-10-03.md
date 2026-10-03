# Regulatorischer Governance-Rollout / Regulatory governance rollout

Date: 2026-10-03. Owner: Thorsten Hindermann.
Documentation Impact: UpdateRequired. State: SourcesReleasedCentralIntegrationInProgress.

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
Bash/PowerShell CheckOnly. Central commit/CI/merge/Home sync and both pilot
deliveries remain open. Stages C/D are WaitingAuthorization, not executing.

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
2. Prepared: released source bindings, baseline 3.3.0 / compendium 2.3.0,
   shared guidance, annual register and staged rollout. Await central PR checks,
   exact merge, default-branch synchronization and bounded Home Runtime sync.
3. Deliver only Show-CommandTui400 and TinyCalc, preserving prior findings,
   receipts and human decisions. Perform bounded GSDB and project regression,
   reproducible statistics and exact merge/default-branch synchronization.
4. Complete [Show-CommandTui400 #19](https://github.com/hindermath/Show-CommandTui400/issues/19)
   and [TinyCalc #92](https://github.com/hindermath/TinyCalc/issues/92)
   with actual delivery evidence. Both contain current source-release and stage boundaries.
5. Recheck review freshness, series/candidate, local model routing, tools and
   current authority before any separately authorized product implementation.

Preserve earlier coordinated Intake/maintenance work; this report does not
claim its pending central/pilot delivery was completed.

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

Audience: maintainers, learners, project owners and privacy/compliance reviewers.
Reader path: source PR -> source contract -> this tracking report -> pilot issue.
Canonical source: standalone source repos for presets, Home Baseline for integration.
Language partner: inline DE-first/EN-second. Class: sourceOnly; no Home sync
for this report. Reevaluation: source review/release, legal amendment or scope change.
