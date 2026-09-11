# Befehlsinventar / Command Inventory

Stand / As of: `2026-09-09`. Betriebssystem / Operating system:
`Darwin` (macOS). Die vollständige Inventur vom 2026-09-08 bleibt erhalten;
dieses Delta aktualisiert nur die aktuellen Home-/AOC-Annahmen. Geprueft wurden
damals in allen sieben Repositorywurzeln
`AGENTS.md`, die lokale Constitution und Registry-Zeile,
`.specify/extensions.yml` (AOC: nicht vorhanden), vorhandene Script-Hilfe,
Test-/Validatorflaechen und `docs/project-statistics.config.json`.

*All seven repository roots were checked against their local guidance,
constitution/registry context, extension hooks, current help surface,
test/validator surface, and statistics contract. Commands marked `planned` are
implementation outputs and have not been claimed as executed.*

## Gemeinsame Delivery-Befehle / Shared delivery commands

Diese Befehle werden spaeter jeweils in der benannten Repositorywurzel
ausgefuehrt; in diesem Foundation-Inkrement sind Git-/Provider-Schreibzugriffe
verboten.

```bash
git status --short --branch
git rev-parse HEAD
git rev-parse origin/main
git rev-list --left-right --count HEAD...origin/main
git diff --check
git diff --name-only
```

*These are later per-repository delivery checks. This foundation increment
performs no commit, push, pull request, merge, or downstream write.*

## 1. Home Baseline

- macOS/Linux: `bash -n scripts/lib/secure-development-hardening.sh`;
  `bash scripts/prepare-secure-development-hardening.sh --help`;
  `bash scripts/prepare-secure-development-hardening.sh --dry-run --repo .`
- Windows/PowerShell: `pwsh -NoProfile -Command 'Get-Help ./scripts/prepare-secure-development-hardening.ps1 -Full'`;
  `pwsh -NoProfile -File scripts/prepare-secure-development-hardening.ps1 -Repo . -WhatIf`
- Contract tests (`planned`): `bash scripts/test-requirements-intake-governance.sh`;
  `pwsh -NoProfile -File scripts/test-requirements-intake-governance.ps1`
- Security: `bash scripts/scan-agent-secrets.sh --fail-on-high .`;
  `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1`
- A11Y/text-first: source review with `scripts/lib/hg-a11y.sh`, plus the planned
  contract fixtures; no HTML/UI scope in this phase.
- Statistics: `bash scripts/render-project-statistics.sh --repo . --check-only --json`;
  `pwsh -NoProfile -File scripts/test-render-project-statistics.ps1`
- Baseline: scripting infrastructure, `80` conservative / `100` Thorsten-solo.
- Current governance: `bash scripts/install-spec-kit-governance-presets.sh
  --check-only --preset-config
  scripts/config/spec-kit-secure-development-assurance-governance-presets.json
  --repo .` passed with exit 0 for exactly 13 presets, Autonomous Run v0.4.2,
  and Assurance v0.1.3.
  The formal context is `home-baseline-assurance-v013` in `training` mode.
- Current statistics: ledger/configuration sources are preserved; write mode
  is blocked by the dirty-checkout guard and no current render pass is claimed.
  Use the clean-checkpoint/focused-follow-up path in T071/T161.

## 2. Agent Operations Cockpit

- macOS/Linux: `bash -n scripts/lib/secure-development-hardening.sh`;
  `bash scripts/prepare-secure-development-hardening.sh --help`;
  `bash scripts/prepare-secure-development-hardening.sh --dry-run --repo .`
- Windows/PowerShell: `pwsh -NoProfile -Command 'Get-Help ./scripts/prepare-secure-development-hardening.ps1 -Full'`;
  `pwsh -NoProfile -File scripts/prepare-secure-development-hardening.ps1 -Repo . -WhatIf`
- Programme gate: `python3 -B specs/001-programmquellen-baseline/contracts/validate_meta_lh01.py --repo . global-ready`
- Contract tests (`planned`): `bash scripts/test-requirements-intake-governance.sh`;
  `pwsh -NoProfile -File scripts/test-requirements-intake-governance.ps1`
- Security/PowerShell: `bash scripts/scan-agent-secrets.sh --fail-on-high .`;
  `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1`
- A11Y: `scripts/lib/hg-a11y.sh`-based text review; HTML/DocFX is `N/A` unless
  its source or navigation enters the diff.
- Statistics: `bash scripts/render-project-statistics.sh --repo . --check-only --json`;
  `pwsh -NoProfile -File scripts/test-render-project-statistics.ps1`
- Baseline: .NET scaffold, `80` / `125`. `.specify/extensions.yml` is absent.
- Current base: local clean `main` `17df5332...` is five commits behind
  `origin/main` `49bfa60c...`. Remote-only `git show origin/main` proves
  Assurance v0.1.3 plus context `aoc-assurance-v013`/`training`; it is not a
  local exact check. Before feature writes, fast-forward `main`, refresh the
  source/base inventory, prove local `0/0`, then run from Level 0:
  `bash scripts/install-spec-kit-governance-presets.sh --check-only
  --preset-config scripts/config/spec-kit-secure-development-assurance-governance-presets.json
  --repo ../RiderProjects/AgentOperationsCockpit`.

## 3. TinyPl0

- macOS/Linux/Windows JavaScript syntax: `node --check scripts/render-requirements-intake-governance.mjs`
- Current validator: `bash scripts/validate-requirements-intake-alignment.sh`;
  `pwsh -NoProfile -File scripts/validate-requirements-intake-alignment.ps1`
- Direct tests: `node scripts/tests/requirements-intake-alignment-tests.mjs`
- Help: no current help mode. `node scripts/render-requirements-intake-governance.mjs --help`
  currently executes the renderer; a real `--help` surface is `planned`.
- Security: `bash scripts/scan-agent-secrets.sh --fail-on-high .`;
  `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1`
- A11Y: Markdown linearisation; DocFX + Playwright/axe + `lynx` becomes
  Applicable only if generated HTML/API navigation changes.
- Statistics: `bash scripts/render-project-statistics.sh --repo . --check-only --json`
- Product builds: `dotnet restore`, `dotnet build`, and `dotnet test` are local
  product gates but are not run for Foundation documentation proof and may not
  change the IDE build counter. Baseline: `80` / `125`.

## 4. TinyCalc

- macOS/Linux/Windows JavaScript syntax: `node --check scripts/render-requirements-intake-governance.mjs`
- Current validator: `bash scripts/validate-requirements-intake-alignment.sh`;
  `pwsh -NoProfile -File scripts/validate-requirements-intake-alignment.ps1`
- Direct tests: `node scripts/tests/requirements-intake-alignment-tests.mjs`
- Help: no current help mode; a non-rendering `--help` interface is `planned`.
- Security: `bash scripts/scan-agent-secrets.sh --fail-on-high .`;
  `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1`
- A11Y: Markdown linearisation; DocFX/Playwright/axe/`lynx` only on matching
  documentation-output changes.
- Statistics: `bash scripts/render-project-statistics.sh --repo . --check-only --json`
- Product commands `dotnet restore MicroCalc.sln`,
  `dotnet build MicroCalc.sln --configuration Release --no-restore`, and
  `dotnet test MicroCalc.sln --configuration Release --no-build` are deferred
  to their triggered later gate; no build-version mutation here. Baseline:
  `80` / `125`.

## 5. InventarWorkerService

- Renderer pair/tests (`planned`):
  `bash scripts/render-requirements-intake-governance.sh --check`;
  `pwsh -NoProfile -File scripts/render-requirements-intake-governance.ps1 -Check`;
  `bash scripts/test-requirements-intake-governance.sh`;
  `pwsh -NoProfile -File scripts/test-requirements-intake-governance.ps1`
- Security: `bash scripts/scan-agent-secrets.sh --fail-on-high .`;
  `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1`
- A11Y: Markdown linearisation; DocFX/Playwright/axe/`lynx` only if DocFX
  sources or output are touched.
- Statistics: `bash scripts/render-project-statistics.sh --repo . --check-only --json`
- `dotnet restore InventarWorkerService.sln`, build and test are not used as
  documentation proof because each invocation changes the governed build
  counter. Baseline: `80` / `100`.

## 6. TuiVision

- macOS/Linux/Windows JavaScript syntax: `node --check scripts/render-requirements-intake-governance.mjs`
- Current validator: `bash scripts/validate-requirements-intake-alignment.sh`;
  `pwsh -NoProfile -File scripts/validate-requirements-intake-alignment.ps1`
- Direct tests: `node scripts/tests/requirements-intake-alignment-tests.mjs`
- Help: no current non-rendering `--help`; that surface is `planned`.
- Security: `bash scripts/scan-agent-secrets.sh --fail-on-high .`;
  `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1`
- A11Y if DocFX changes: `docfx docfx.json`; then
  `cd tests/web-a11y && npm run test:docfx`, plus a `lynx` spot check.
- Statistics: `bash scripts/render-project-statistics.sh --repo . --check-only --json`
- Product/coverage commands stay deferred and may not be run for documentation
  proof. Baseline: `80` / `125`.

## 7. absdd-image-sandbox

- Renderer pair/tests (`planned`): the same four exact `render-`/`test-requirements-intake-governance` Bash and PowerShell commands as InventarWorkerService.
- Security: `bash scripts/scan-agent-secrets.sh --fail-on-high .`;
  `pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1`;
  `uvx pre-commit run --all-files` at the later repository gate.
- Compose: `podman-compose config` is Applicable only if Compose scope changes;
  it is `N/A` for the planned documentation-only diff. Image builds are not
  Foundation evidence.
- A11Y: Markdown/CLI linearisation; no HTML/UI/media in planned scope.
- Statistics: `bash scripts/render-project-statistics.sh --repo . --check-only --json`
- Baseline: Python plus Bash/PowerShell sandbox tooling, `80` conservative and
  no C# default. The local compliance plan remains a human-boundary context.

## Inspection result

The six downstream repositories were clean at the 2026-09-08 inspection.
AOC is currently clean but behind as recorded above; this delta repeats no
other fleet inventory. The three 2026-09-08 JavaScript renderer invocations produced their existing PASS output
and left zero tracked or untracked changes. No native Linux/Windows run, story
acceptance, product build, provider write, Home Sync, preset installation, or
delivery action is claimed.
