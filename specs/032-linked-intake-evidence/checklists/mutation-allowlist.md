# Mutation Allowlist

## Foundation increment

Only the following Home feature-local classes are writable now:

- `specs/032-linked-intake-evidence/**`, excluding
  `specs/032-linked-intake-evidence/autonomous-run-state.json`;
- ignored `.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/**`;
- `docs/project-statistics.config.json` and generated
  `docs/project-statistics.md` only after the 22-task phase is complete;
- `constitution.md` and `.specify/memory/constitution.md` solely for the
  separately authorised v1.21.1 metadata/version-reference mirror repair.
- `.gitattributes` solely for three literal, non-wildcard
  `whitespace=-trailing-space` entries naming
  `checklists/resume-analysis-2026-09-08.md` and
  `checklists/resume-reanalysis-2026-09-08.md` plus
  `checklists/resume-analysis-2026-09-09.md`; this classifies their preserved
  Markdown hard breaks and authorizes no byte edit to any historical file. The
  entries are introduced before the T067 Preservation Commit, are never broad
  patterns or cached-check exclusions, and are merged with PR279's incoming LF
  rules.

Home PR279 is a separate exact base-integration class, not Feature-032 payload:
all and only paths in `git diff --name-status
2d1dc80065817426b97c13eeba8387f653b8cc41
91e9c7e5919063388dcc22da7616b3dd878acd19` may enter through the preserved
merge ancestry. Source reconciliation may touch the overlapping local
`docs/project-statistics.md`, `scripts/config/script-catalog.json`, and
generated `docs/scripts/reference.md`; it must preserve the new
`.gitattributes`, `scripts/config/home-sync-manifest.json` `sourceOnly` rule,
and all non-overlapping incoming paths. `docs/project-statistics.md` is not
manually made current: the configured renderer remains the only current-profile
writer at T071.

The two Constitution paths authorize no principle, policy, registry, runtime,
toolchain, or scope change. The autonomous run state is never writable by this
phase.

## Planned repository-local implementation allowlists

| Repository | Allowed planned paths |
|---|---|
| home-baseline | `scripts/lib/secure-development-hardening.sh`, `.ps1`; `scripts/prepare-secure-development-hardening.sh`, `.ps1`; `scripts/test-requirements-intake-governance.sh`, `.ps1`; `scripts/tests/linked-intake-evidence/**`; `.github/workflows/linked-intake-evidence-native-proof.yml` only for the T071 exact-head native proof; `Lastenheft_Abarbeitungsreihenfolge.md`; related man/help, feature governance docs, statistics source/output |
| agent-operations-cockpit | same proven paired renderer/test/fixture families; `specs/intake-series/aoc-phase-2/manifest.json` only if a renderer declaration is required and never for lifecycle mutation; root/series owned views; local governance evidence and statistics; `constitution.md`, `.specify/memory/constitution.md`, and only directly dependent local agent/template current-version references for the approved autonomous-preset mirror correction |
| TinyPl0 | `scripts/render-requirements-intake-governance.mjs`; `scripts/validate-requirements-intake-alignment.*`; `scripts/tests/requirements-intake-alignment-tests.mjs`; feature fixtures; manifest only for renderer declarations; root/series views; help/docs/evidence/statistics; `src/Pl0.Ide/Pl0.Ide.csproj` remains read-only evidence, never writable |
| TinyCalc | same JavaScript/alignment/fixture families; its manifest declarations; root/series views; help/docs/evidence/statistics; `Directory.Build.props` remains read-only evidence, never writable |
| InventarWorkerService | planned `scripts/render-requirements-intake-governance.sh`, `.ps1`; paired tests and fixtures; its manifest declarations; root view; required man/help; evidence/statistics; `constitution.md`, `.specify/memory/constitution.md`, and only directly dependent local agent/template current-version references for the approved autonomous-preset mirror correction; `Directory.Build.props` remains read-only evidence |
| TuiVision | existing JavaScript/alignment tests; exact fixtures; manifest renderer declarations; root/series views; help/docs/evidence/statistics; `Directory.Build.props` remains read-only evidence, never writable |
| absdd-image-sandbox | planned paired Bash/PowerShell renderer/tests/fixtures; sandbox manifest declarations; root view; required man/help; evidence/statistics/session evidence required by local guidance; `constitution.md`, `.specify/memory/constitution.md`, and only directly dependent local agent/template current-version references for the approved autonomous-preset mirror correction |

## Forbidden everywhere

Product source, API, runtime behavior, public types, project/solution version
files, `Dockerfile`, Containerfile, image layers, Compose files, package
manifests, dependency manifests, lockfiles, generated build artifacts, agent
credentials/state, provider configuration, and files outside the seven accepted
repositories are forbidden. A required forbidden delta stops for new authority
and reviewed planning; it is never silently allowlisted.

The four named product version files remain forbidden as mutations despite the
approved exception: the exception authorizes zero-diff build execution and
proof, not a write. The three Constitution allowances cover only stale current
`autonomous-run-governance` version references plus required local
patch-version/date metadata and directly dependent local parity references;
principles, historical release facts, preset files, central/shared guidance,
product, runtime, image, package, and dependency changes remain forbidden.
