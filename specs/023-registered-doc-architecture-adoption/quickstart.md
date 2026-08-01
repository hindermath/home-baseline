# Quickstart: Feature 023 Validation

## 1. Confirm Accepted Intake And Series

Run both Bash and PowerShell validators for the D7 authoring receipt, D7 review,
active Series review, Series manifest and Series receipt. All must pass before
planning or implementation.

## 2. Confirm The Fleet Barrier

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
```

Exit `1` may represent expected drift. Exit `2` requires inspection of the
reported operational boundary. Confirm that all target fetch attempts completed
before interpreting propagation or Home-sync findings.

## 3. Validate Feature Artifacts

```bash
python3 specs/023-registered-doc-architecture-adoption/tests/test_fleet_adoption.py
python3 specs/023-registered-doc-architecture-adoption/tools/validate_fleet_adoption.py \
  --repo . \
  --matrix specs/023-registered-doc-architecture-adoption/fleet-adoption-matrix.json
```

The validator proves structure and cardinality. It does not replace semantic
review of repository-specific applicability.

## 4. Validate A Changed Target

For any adopted target, run its own documented validation contract. At minimum:

```bash
git diff --check
```

Also validate internal links, language partners, Documentation Impact,
repository-native homogeneity, secret and A11Y checks, agent parity, staged path
inventory, provider checks and review threads.

## 5. Confirm Scope And Completion

- Compare the technical propagation target-set hash before and after the run.
- Confirm no product, runtime, package, dependency, workflow or toolchain path
  changed.
- Confirm every target has one decision and only adopted targets have PRs.
- Confirm Feature 023 and all changed targets are clean on synchronized default
  branches.
- Do not start the next intake.
