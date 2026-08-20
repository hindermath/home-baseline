# Stufe-A-Mutations-allowlist / Stage A Mutation Allowlist

**Status / Disposition**: Applicable
**Owner**: home-baseline Feature Owner
**Reviewer**: Stage-A Security Reviewer
**Restrisiko / Residual risk**: Ein neu entstehender, nicht gelisteter Pfad muss fail-closed blockieren.
**Follow-up**: Arbeitsbaum vor jedem Acceptance-Lauf erneut exakt vergleichen.
**Re-Evaluation**: Bei Scope-, Authority-, Pfad- oder Distributionsänderungen.

## Erlaubte Pfade / Allowed Paths

Nur die folgenden repositoryrelativen Pfade beziehungsweise ausdrücklich
begrenzten Bäume dürfen im Stufe-A-Kandidaten erscheinen:

- `.gitignore`
- `README.md`
- `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md`
- `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.029-ci-budget-governance.md`
- `specs/029-ci-budget-governance/autonomous-run-state.json`
- `specs/029-ci-budget-governance/tasks.md`
- `specs/029-ci-budget-governance/retrospective.md`
- `specs/029-ci-budget-governance/checklists/cross-platform.md`
- `specs/029-ci-budget-governance/checklists/stage-a-mutation-allowlist.md`
- `specs/029-ci-budget-governance/checklists/implementation-governance.md`
- `specs/029-ci-budget-governance/documentation-impact-evidence.json`
- `scripts/config/ci-budget-profiles.schema.json`
- `scripts/config/ci-budget-path-contracts.schema.json`
- `scripts/config/ci-gate-evidence.schema.json`
- `scripts/config/ci-inventory-rollout-plan.schema.json`
- `scripts/config/ci-budget-profiles.json`
- `scripts/config/ci-budget-path-contracts.json`
- `scripts/config/agentic-toolchain-maintenance-files.json`
- `scripts/config/home-sync-manifest.json`
- `scripts/config/script-catalog.json`
- `scripts/templates/ci-budget-governance/`
- `scripts/lib/agentic_workspace_fleet.py`
- `scripts/maintain-agentic-workspace.sh`
- `scripts/maintain-agentic-workspace.ps1`
- `scripts/rename-lastenheft.sh`
- `scripts/hooks/pre-push`
- `scripts/tests/test_ci_budget_governance.py`
- `scripts/tests/run_ci_budget_acceptance.py`
- `scripts/tests/ci-budget-governance/`
- `scripts/tests/test_agentic_workspace_maintenance.py`
- `scripts/tests/test_maintenance_contracts.py`
- `scripts/render-script-reference.ps1`
- `docs/scripts/reference.md`
- `docs/man/install-hooks.1.md`
- `docs/man/maintain-agentic-workspace.1.md`
- `docs/architecture/ci-budget-governance.md`
- `docs/accessibility/ci-budget-governance.md`
- `docs/security/adr/ADR-002-ci-gate-defense-in-depth.md`
- `docs/security/threat-model.md`
- `docs/security/arc42-security.md`
- `docs/security/security-checklist.md`
- `docs/security/security-quality-scenarios.md`
- `docs/security/dependency-audit.md`
- `docs/security/supply-chain-evidence.md`
- `docs/security/zero-trust-applicability.md`
- `docs/security/samm-assessment.md`
- `docs/security/asvs-verification.md`
- `docs/security/regulatory-applicability.md`
- `docs/security/cloud-autonomy-applicability.md`
- `docs/security/cloud-compliance-assurance.md`
- `docs/project-statistics.config.json`
- `docs/project-statistics.md`

`.specify/runtime/` darf lokal geschrieben werden, ist aber ausdrücklich kein
Git-Lieferpfad und kein Bestandteil des Exact Candidate.

## Verbotene Pfade / Forbidden Paths

- Zielrepositories und deren Dateien
- aktive `.github/workflows/`
- GitHub-Rulesets, Account-, Reviewer-, Copilot- und G4-Flächen
- `.specify/runtime/` als Git-Lieferinhalt
- Home-Runtime und Home-Sync-Ziele

## Run-State-Nachweis / Run-State Evidence

- Validator: Pass via `validate-autonomous-run-state.sh`
- Run-ID: `eca02c0f-5399-49c0-8de4-b21233834254`
- Branch: `029-ci-budget-governance`
- Delivery Authority: `LocalImplementation`
- Stage/Status: `Retrospective` / `Completed`
- Analyze-Voraussetzung: geroutete Phase `analyze` ist `Completed`, Exitcode 0.
- Bekannte nicht semantische Hashdrift: commit-time
  Trailing-Whitespace-Normalisierung in `spec.md` und
  `checklists/requirements.md`; durch Resume-Audit und Analyze akzeptiert.
- Der terminale Run-State und die tatsächlichen Checkboxen in `tasks.md`
  bestätigen beide 93/93 abgeschlossene Aufgaben.
