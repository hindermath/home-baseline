### Preset ID

intake-authoring-governance

### Preset Name

Intake Authoring Governance

### Version

0.1.0

### Description

Creates traceable Spec Kit intake files and receipts from ordered text sources while preserving clarification, update, and delivery-authority boundaries.

### Author

Thorsten Hindermann

### Repository URL

https://github.com/hindermath/spec-kit-preset-intake-authoring-governance

### Download URL

https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/archive/refs/tags/v0.1.0.zip

### Documentation URL

https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/blob/v0.1.0/README.md

### License

MIT

### Required Spec Kit Version

>=0.8.3

### Required Extensions (optional)

None

### Templates Provided

- `intake-template` - portable intake structure with copy-ready Specify and Autonomous prompts
- `intake-authoring-receipt-template` - machine-readable source, target, decision, and authority evidence
- `intake-authoring-policy-template` - repository policy for source, profile, update, and language boundaries
- `project-profile-template` - optional repository-specific structure and target-path contract
- `intake-authoring-runbook-template` - create, clarify, update, validate, and review-handoff workflow
- `intake-authoring-agent-guidance-addendum-template` - agent-neutral guidance and safety boundaries
- `intake-authoring-field-validation-summary` - package, composition, handoff, and fleet evidence

### Commands Provided

- `speckit.intake-create` - creates or explicitly updates one traceable intake and receipt from ordered text sources
- `speckit.intake-create-status` - checks receipt, source, target, prompt, and authority freshness without writing files

### Number of Scripts (optional)

2

### Tags

intake, authoring, governance, traceability, clarification

### Key Features

Hi @mnriem, thank you for the earlier guidance on optional, stackable presets and for the catalog workflow used by the related Intake Review submission #3604.

- Accepts direct text, pasted agent planning, explicitly named strict UTF-8 text files, or an ordered combination without silent last-source-wins behavior.
- Creates exactly one Markdown intake and one JSON receipt, with deterministic BOM, line-ending, and SHA-256 normalization compatible with Intake Review Governance.
- Asks at most five material questions per pass. Unresolved decisions produce a saved `NeedsClarification` draft whose visible prompts are marked `BLOCKED - DO NOT RUN`.
- Refuses binary or invalid UTF-8 input, secrets, unnecessary personal data, silent truncation, and unauthorized overwrites.
- Requires explicit update authority and records the predecessor receipt and prior target hash when an intake is superseded.
- Preserves repository language and profile rules while providing a portable core for scope, non-goals, atomic requirements, quality boundaries, risks, evidence, and measurable acceptance.
- Generates copy-ready Specify and Autonomous prompts, but never starts Review, Specify, Autonomous, Parallel Autonomous, commits, pushes, PRs, or merges.
- Keeps `LocalImplementation` as the safe Autonomous default and never infers bypass, secret, provider, admin, or higher remote authority.
- Composes optionally at priority 64 directly before Intake Review Governance at priority 65, Autonomous Run Governance at 70, and Parallel Autonomous Run Governance at 80. Existing eight- and nine-preset profiles remain unchanged.
- Provides equivalent Bash and PowerShell read-only validators and a shared positive/negative suite covering Ready and blocked receipts, ordered sources, UTF-8 normalization, source/target drift, update chains, secrets, and authority escalation.
- Passed installation and full lifecycle validation from the exact v0.1.0 GitHub tag ZIP with ten stacked presets across Codex, Claude, Copilot, OpenCode, Antigravity, and Zed without duplicate commands.
- Passed a synthetic Authoring-to-Intake-Review handoff without creating an autonomous run or Git remote.
- Was installed optionally in 33 managed Level-0/1/2 repositories, including 21 learning-series repositories across three families. All package suites passed, all 33 PRs were merged, and no learner Spec Kit run was started.

Maintainer feedback on the Authoring/Review boundary, the two command names, receipt metadata, profile model, and suitability for the community catalog would be appreciated. The preset is intentionally opt-in and grants no implicit execution or remote authority.

### Testing Checklist

- [x] Preset installs successfully via `specify preset add`
- [x] Template resolution works correctly after installation
- [x] Documentation is complete and accurate
- [x] Tested on at least one real project

### Submission Requirements

- [x] Valid `preset.yml` manifest included
- [x] Linked README explains how to use this preset and includes the exact tagged `specify preset add --from ...` command
- [x] LICENSE file included
- [x] GitHub release created with version tag
- [x] Preset ID follows naming conventions
