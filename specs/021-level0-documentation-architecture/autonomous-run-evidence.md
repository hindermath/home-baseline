# Autonomous Run Evidence: Feature 021

## Run Identity

- Run: `cf8e7a2f-baac-44cc-b5a5-b660906adf8d`
- Branch: `021-level0-documentation-architecture`
- Delivery mode: `MergeAndSync`
- Starting commit: `edf33bc88029edea261e9c461d45c347d449ad3f`
- Binding finding: `DIA001`

## Accepted Inputs

| Artifact | Normalized SHA-256 | Decision |
|---|---|---|
| `Lastenheft_Level-0-Dokumentationsarchitektur-und-Sprachtrennung.md` | `f2bfdcd46841551e33962536eaf397c6715403c6df9531acf08bdd4ad4e959ef` | Accepted |
| `specs/documentation-architecture-intakes/reviews/d5/intake-review-request.json` | `15183c7a4a87962d19e18c6f07f2f7bdb3301562ebff3cef2d1fa0619391a3dc` | Accepted |
| `specs/documentation-architecture-intakes/reviews/d5/intake-review-result.json` | `05ee0478a27d0425ad739eca909d88b138d95839178304429d8a88f419c70159` | `Ready` |
| `requirements/intakes/series/home-baseline-delivery/manifest.json` | `442d549f08dba795acc356bf0d4f13f14161b61ad377497c3dca5570d0f6983e` | D5 sole preferred Eligible |
| `.specify/memory/constitution.md` | `629ee3de68cb3010c5d90a7332e7414e304b0892d13b2918a33eb4cb1c0369e0` | Accepted |

## Preflight

- `main == origin/main` before branch: PASS
- clean worktree before branch: PASS
- Feature 020 state: `Retrospective`, `Completed`, `130/130`, `N/A`: PASS
- D5 Intake Review, Bash and PowerShell: PASS
- active Series manifest and receipt, Bash and PowerShell: PASS (`36/3/43`)
- Series eligibility: three technically executable roots; D5 is the sole
  declared preferred `Eligible` candidate
- `specify check`: PASS
- prerequisites with required tasks: PASS (`tasks.md` discovered)
- Clarify: no material ambiguity
- Requirements and plan checklists: PASS
- repeated Analyze: zero Critical, High, or unresolved Medium findings

## Documentation Impact

Decision: `UpdateRequired`. The feature changes the root and documentation
portals, navigation, language partners, governance, templates, and agent
guidance. Runtime behavior remains unchanged. Semantic and deterministic proof
are recorded separately.

## Validation Log

- Reference slice RED: 12 test groups failed because the validator did not yet
  exist; no product or documentation file had been migrated.
- Reference slice GREEN: 12 test groups passed after the fail-closed validator
  implemented source-commit/hash, section, decision, target, anchor, language,
  reader-path, link, private-path, successor-scope, and normalization checks.
- Complete migration validator: PASS (`16` sections, `4` reader paths, `17`
  linked active files).
- Lychee offline with fragments: PASS (`3508` links, `0` errors).
- Documentation Impact fixtures and Feature-021 evidence: PASS in Bash and
  PowerShell.
- Learning-package self-tests: PASS in Bash and PowerShell.
- Secure-development generated-document checks: PASS in Bash and PowerShell.
- Homogeneity runtime-closure tests: PASS in Bash and PowerShell.
- PowerShell static analysis: PASS (`147` files, zero Error/Warning findings).
- Secret scan: PASS (zero high findings; local `.claude` state remains the
  documented non-publishable medium observation).
- `specify check`: PASS.
- Eleven-preset sequencing profile: PASS. The eight-preset default profile was
  intentionally not used because this Level-0 repository declares the current
  eleven-preset profile.
- Shared Documentation Impact block: identical SHA-256 on all five maintained
  agent surfaces; Constitution mirror is byte-identical.
- DocFX/Playwright/Axe: `N/A`; no DocFX configuration, generated HTML site, or
  browser documentation test project exists. Markdown, learning-package,
  semantic WCAG, and provider link gates are applicable instead.
- Homogeneity architecture checks: PASS after language-pair and portal-aware
  validator alignment. Bash and PowerShell both report `30/30`, `100%` after
  T099 rendered the statistics from clean checkpoint `08ead0b7ac9f`.
- Local ignored Python and .NET build caches were removed before the PowerShell
  Homogeneity proof; they were not tracked or used as delivery evidence.
- Script-reference renderers: Bash write followed by Bash/PowerShell
  `CURRENT` checks (`124` canonical, `159` embedded scripts).
- Statistics renderers: Bash write followed by Bash/PowerShell `CURRENT`
  checks (`588631` text lines, `80` active days at checkpoint).
- Scope inventory: documentation, documentation governance, CI/test-only
  validation, feature evidence, and statistics only. The Homogeneity helper
  changes recognize reciprocal `.en.md` language partners and portal links;
  maintenance runtime, APIs, dependencies, packages, fleet state, historical
  evidence, D6, and D7 are unchanged.

### Final Candidate Revalidation

- Autonomous-run state validators: PASS in Bash and PowerShell (`98/110` at
  the pre-delivery checkpoint).
- Migration contract: PASS (`12` fixture groups); complete migration: PASS
  (`16` sections, `4` reader paths, `17` linked files).
- The first ad-hoc migration-validator invocation used obsolete positional
  arguments and was rejected by `argparse`; the documented `--repo` and
  `--migration` invocation then passed. No files changed during the rejected
  call.
- The first ad-hoc Lychee invocation omitted the repository's intentional
  project-template exclusion and therefore reported seven fixture-relative
  links. The exact workflow invocation then passed (`3508` links, `0` errors).
- Documentation Impact fixtures and Feature-021 evidence: PASS in Bash and
  PowerShell. One guessed `check-documentation-impact.sh` path was rejected as
  absent; discovery identified and successfully ran the canonical
  `validate-documentation-impact.*` pair. No files changed during discovery.
- Learning-package self-tests and generated secure-development-document checks:
  PASS in Bash and PowerShell.
- PSScriptAnalyzer: PASS (`147` files, zero Error/Warning findings).
- Secret scan: PASS (zero high findings; the machine-local `.claude` medium
  observation is excluded from publication).
- `specify check` and the exact eleven-preset profile check: PASS.
- Homogeneity runtime-closure fixtures: PASS in Bash and PowerShell.
- Repository-scoped Homogeneity has `29/30` before the evidence checkpoint;
  only the deterministically generated statistics profile is stale. It will be
  rendered from the committed evidence checkpoint and rechecked in both shells
  before the delivery head is pushed.
- Script reference: `CURRENT` in Bash and PowerShell (`124` canonical, `159`
  embedded scripts).
- A mistakenly unscoped PowerShell Homogeneity invocation inspected the wider
  local fleet and reported pre-existing machine-wide drift. It did not mutate
  files and is not Feature-021 acceptance evidence; the canonical
  repository-scoped invocation is the applicable proof.
- The first provider run exposed two cross-platform proof defects: shallow
  checkout could not resolve the frozen source commit on Ubuntu/macOS, and
  JSON escaping hid a Windows private path from the negative fixture. The
  learning-package job now fetches full history, and the validator inspects
  original recursive string values. The expanded four-path fixture and the
  complete migration validator pass locally; exact-head provider confirmation
  remains required before merge.
- Copilot then identified the reciprocal language-partner defect in both
  Homogeneity helpers and the BSD-incompatible `basename --` call. New
  bidirectional DE-to-EN and EN-to-DE fixtures failed first, then passed after
  symmetric partner derivation and shell-native basename extraction. The
  correction changes validation only and preserves the documented migration
  scope.
- A later Copilot review found that the expanded Documentation Impact fields
  were normative but not yet enforced. Schema `1.1` now requires audience,
  reader-path, source, navigation, language, platform/example, distribution,
  Home-sync, risk, and re-evaluation evidence, while schema `1.0` remains
  readable for historical records. Ten Bash and PowerShell fixtures cover a
  current positive row, a legacy positive row, and eight fail-closed cases; the
  Feature-021 evidence passes the strict schema.
- Copilot's next pass identified that one new negative fixture failed through
  several independent fields. It is now atomic, and separate distribution,
  Home-sync-type, and language-partner-type fixtures preserve regression
  sensitivity. Both shell entry points now pass `10` focused cases.

## Governance

Applicability and trigger-based N/A decisions are defined in `spec.md` and the
gate requirements. No cloud, deployment, dependency, API, or regulated data
processing boundary changes.

## Delivery

Pending.
