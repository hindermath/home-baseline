# PR Evidence: Intake Sequencing Governance v0.1.0

## Scope And Authority

- Binding intake: `Lastenheft_Spec-Kit-Intake-Sequencing-Governance.md`
- Branch: `010-intake-sequencing-governance`
- Delivery mode: `MergeAndSync`
- Authorized repositories: Home Baseline, owned publication repository,
  registered optional fleet installation
- Admin bypass: not granted
- Product runtime, intake content, and downstream execution: unchanged

## Bootstrap Evidence

| Check | Result |
|---|---|
| Authoring receipt schema 2.0, Bash | PASS |
| Authoring receipt schema 2.0, PowerShell | PASS |
| Single intake review, Bash | Ready |
| Single intake review, PowerShell | Ready |
| Clarification findings | 0 |
| Analyze Critical/High findings | 0 |

## Validator Evidence

| Evidence | Bash | PowerShell | Boundary |
|---|---|---|---|
| Three targets, one root, two binding edges | PASS | PASS | Synthetic |
| Invalid repository-relative path | ISG003 | ISG003 | Fail closed |
| Unknown type or wrong binding flag | ISG006 | ISG006 | Fail closed |
| Order contradiction or cycle | ISG007 | ISG007 | Fail closed |
| Incorrect roots | ISG008 | ISG008 | Fail closed |
| Unknown lifecycle | ISG009 | ISG009 | Fail closed |
| Receipt/manifest hash drift | ISR004 | ISR004 | Fail closed |
| Home Baseline 13/6/15 | PASS | PASS | Read-only Legacy Adoption |

## Composition Evidence

- Spec Kit CLI: `0.12.11`
- Existing profile hashes remained:
  - standard eight: `1c8dfe93b426f25e8c653c215af7b46917362f24`
  - review nine: `79ee6a4d52494be7a09233b18ac6d4376a625f0e`
  - authoring ten: `90539ac924c006624123a23566575d3220b05ab6`
- Eleven presets installed at priorities 10, 20, 30, 40, 50, 60, 64, 65,
  66, 70, and 80.
- Add, list, info, template resolve, disable, enable, remove, and reinstall:
  PASS.
- Codex, Claude, Copilot, Antigravity, and OpenCode generated each of the six
  sequencing commands exactly once on their active surface.
- No command invokes Intake Review, Specify, Autonomous, or Parallel
  Autonomous.

## Repository Validation

| Command | Result |
|---|---|
| `bash -n` for both Bash wrappers | PASS |
| `python3 -m py_compile` | PASS |
| `scripts/invoke-psscriptanalyzer.ps1` | PASS, 114 files |
| `git diff --check` | PASS |
| `scripts/scan-agent-secrets.sh --fail-on-high .` | PASS, high=0 |
| `specify check` | PASS |
| Canonical/publication byte comparison | PASS |

## Conditional Governance

- Cloud, runtime threat-model, AI-SBOM, regulatory, and deployment-topology
  triggers: `N/A`; this package adds no service or runtime boundary.
- Supply-chain release evidence: Applicable for the new public repository,
  tag, release ZIP, and checksum.
- A11Y: Applicable to README, commands, templates, and text-first output.
- Cross-platform: Applicable to Bash/PowerShell wrappers and shared result
  classes.
- Agent parity: Applicable to five maintained generation surfaces.

## Delivery Evidence

| Boundary | Evidence | Result |
|---|---|---|
| Home Baseline feature | [PR #115](https://github.com/hindermath/home-baseline/pull/115), merge `044a17be98af6d3c2c0b00a5e0d51f9a4debe8e7` | Merged and synchronized |
| Publication package | [PR #1](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/pull/1), merge `030d1473ba01b58b56b7215077269fc244ba52ce` | Merged and synchronized |
| Public release | [v0.1.0](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/releases/tag/v0.1.0) | Published from the reviewed merge head |
| Versioned ZIP | `https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/archive/refs/tags/v0.1.0.zip` | `c2fed951047fd0ab1b0edae7e4e6cdc06f2779488c585d0064c46b8974b19bbe` |
| Eleven-preset smoke | Fresh Spec Kit 0.12.11 project | Add, list, info, resolve, disable, enable, remove, reinstall, and six Codex skills passed |

PR #115 and publication PR #1 used the explicitly authorized narrow bypass
only after local validation passed, no actionable thread existed, and Human
Approval was the sole remaining merge rule. No technical failure was bypassed.

Fleet PRs and the community submission remain pending until their exact heads
and remote outcomes are known.
