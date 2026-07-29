# Retrospective: Feature 018

## Run Identity

| Field | Value |
|---|---|
| Feature and source revision | `018-agentic-workspace-tui`; reviewed head pending |
| Delivery evidence | `specs/018-agentic-workspace-tui/autonomous-run-evidence.md` |
| Delivery mode | `MergeAndSync` |
| Remote result | Pending exact-head PR delivery |
| Interruptions and resumes | No interruption or resume |

## Observations

| ID | Observation | Artifact kind | Project exclusions | Provider-neutral target rule | Occurrences | Confidence | Permission and evidence risk | Reproducible synthetic test | Decision |
|---|---|---|---|---|---:|---|---|---|---|
| AR-018-001 | A safe UI default must be declared through the UI library's explicit default contract, not inferred from choice order. | implementation/test | Spectre.Console and the three Home-Baseline modes are project choices. | Declare and test the non-mutating default explicitly whenever an interactive selector can authorize later mutation. | 1 | High | An implicit library default can preselect a stronger mode after a dependency change. | Feed only Enter keys through an interactive test console and require the non-mutating mode. | NoPromotion |
| AR-018-002 | Every cache preparation failure, including an unwritable directory or failed atomic move, must select the plain path before the engine starts. | implementation/test | Home cache locations and .NET build layout are project-specific. | Treat all pre-start enhancement-cache failures equivalently and preserve the fully functional text fallback. | 1 | High | An unhandled cache error would make the optional UI a new availability dependency. | Exercise missing tool, restore/build failure, unwritable cache, incomplete metadata and failed publication without launching the engine twice. | NoPromotion |
| AR-018-003 | Advisory live events and canonical completion evidence need separate models and explicit visible degradation. | architecture/evidence | Current phase names and report fields belong to Home Baseline. | Never infer completion from free output or advisory events; reconcile finalized report and process exit, and expose mismatch textually. | 1 | High | A polished live view could otherwise misreport partial or failed maintenance as success. | Corrupt sequence/schema/run identity and disagree event, report and process exit while asserting unchanged process authority. | NoPromotion |
| AR-018-004 | Exact-head command tokens must identify the semantic command across platform launcher spelling such as `python3` and `python`. | evidence contract | The current GitHub matrix and Python commands are repository-specific. | Use the narrowest provider-neutral token that remains unique across supported platform invocations. | 1 | Medium | An OS-specific launcher token can reject valid Windows evidence or encourage a false exception. | Map equivalent Unix and Windows commands to one gate and reject unrelated commands. | NoPromotion |
| AR-018-005 | Cross-platform test discovery must not treat a foreign shell launcher as a usable native runtime, run POSIX-only fixtures on Windows, interpret Unix permission bits there or compare equivalent Windows short and long paths literally. | test/workflow | The Bash, Linux-hardening and PowerShell fixtures are Home-Baseline entry points. | Gate executable behavior by the target operating system while retaining portable source-contract checks and semantic path assertions on every platform. | 2 | High | A detected but unusable compatibility launcher or literal platform representation can create false failures, while a skipped native path can hide real regressions. | Run the same suite on Unix and Windows; execute POSIX fixtures only on Unix, native PowerShell behavior on Windows, and shared source/contract checks everywhere. | NoPromotion |

## Outcome

- Provisional decision: `NoPromotion`.
- The observations are implemented in this repository's code, tests,
  documentation and feature gate requirements. No reproducible defect has
  been found in Autonomous Run Governance or another reusable preset.
- Shared agent guidance and `.specify/templates/` remain
  `NoUpdateRequired`; Feature 018 changes the maintenance product and its
  evidence, not the durable autonomous workflow contract.
- Remote check, review, merge, Home Runtime sync and causal Series closeout
  remain pending. This retrospective is finalized only against their exact
  identifiers.
- No successor feature is started by this run.
