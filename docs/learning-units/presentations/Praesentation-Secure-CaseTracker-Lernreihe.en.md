---
lang: en
---

<!--
Markdown template for a PowerPoint presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
-->

# Secure CaseTracker

## Introduction to Secure Development with Spec Kit, MSL, and Sandbox

EuFPA – European Company Programs Everything

IT specialist apprentices · EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the Secure CaseTracker learning series.
It does not replace a Spec Kit run. It explains the frame, roles,
order, and expected evidence.
:::


---

# Goal of the Learning Series

- Understand secure software development step by step
- Clarify requirements first, then plan, then implement
- Make privacy, information security, and tests visible
- Use Spec Kit as a learning structure
- Document decisions so that others can review them

::: notes
The series should not send learners directly into code.
The central learning point is: good development starts with a clear task,
justified decisions, and reviewable evidence.
:::


---

# Starting Point

- The training company **EuFPA** needs a Secure CaseTracker
- The system manages customer requests, affected assets, and work notes
- It also produces simple process metrics
- The example stays small, but the working method is professional

::: notes
EuFPA is fictional. The business frame is intentionally simple so that
security, privacy, documentation, and tests remain in focus.
:::


---

# What Is a CaseTracker?

- A case describes a request or a problem
- Each case has a status, notes, and affected data
- Roles decide who may see or change what
- Audit logs later show what happened
- Metrics help understand the process

::: notes
The CaseTracker is not a real production ticket system.
It is a learning object that makes typical decisions visible.
:::


---

# Shared Core Contract

- Create, update, and close cases
- Store customer data sparingly
- Validate input and provide understandable error messages
- Distinguish the roles `learner`, `developer`, and `reviewer`
- Keep an audit log without secrets and without unnecessary personal data
- Import and export data safely
- Produce tests and security evidence

::: notes
All language paths use the same functional core contract.
The technical implementation may differ, but behavior must remain comparable.
:::


---

# Why Spec Kit?

- Spec Kit structures work into specification, planning, tasks, and review
- The first step is not code, but a reviewable task
- Each task creates traceable artifacts
- Governance presets keep security, architecture, A11Y, and agent rules visible
- Non-applicable points are documented as `N/A` with rationale

::: notes
In this series, Spec Kit is not only a tool. It is a teaching structure
that prevents important checks from being silently skipped.
:::


---

# Three Levels

| Level | Purpose |
|---|---|
| Level 0 | Central learning material, guideline, checklists, and presets |
| Level 1 | Coordination of the learning series and language-path comparison |
| Level 2 | Practical work per language with separate Spec Kit artifacts |

::: notes
Level 0 remains the source. Level 1 coordinates. Level 2 is the place
where the later Spec Kit runs and implementations happen.
:::


---

# Repository Structure

| Role | Local folder | GitHub slug |
|---|---|---|
| Coordination | `secure-casetracker-baseline` | `secure-casetracker-baseline` |
| Reference | `securecasetracker-csharp` | `securecasetracker-csharp` |
| Comparison | `securecasetracker-go` | `securecasetracker-go` |
| Comparison | `securecasetracker-java` | `securecasetracker-java` |
| Comparison | `securecasetracker-python` | `securecasetracker-python` |
| Comparison | `securecasetracker-rust` | `securecasetracker-rust` |
| Comparison | `securecasetracker-swift` | `securecasetracker-swift` |

::: notes
Local folders use CamelCase.
The GitHub slugs are created lowercase by the bootstrap scripts.
:::


---

# Six MSL Paths

- C# as the first reference path
- Go, Java, Python, Rust, and Swift as comparison paths
- All six languages are treated as memory-safe languages in this series
- MSL reduces certain memory errors
- MSL does not replace review of input, I/O, auth, crypto, logging, or dependencies

::: notes
One key learning point is: a memory-safe language is helpful,
but it is not a complete security guarantee.
:::


---

# Specialization Fit

| Specialization | Focus |
|---|---|
| Application Development | Model, validation, permissions, persistence, tests |
| System Integration | Sandbox, toolchain, logging, secrets, supply chain |
| Data and Process Analysis | Privacy, data quality, metrics, limits of interpretation |
| Digital Networking | System context, interfaces, communication flows, availability |

::: notes
The series can be used jointly.
Depending on the class, some tasks can receive stronger focus.
Spec Kit accompanies the SDD tasks, but it does not replace occupation learning.
:::


---

# Secure Development as Anchor

- Secure Development Guideline
- Secure Programming Guideline
- Secure Development Sandbox Guideline
- 12 checklists and compendium
- eight installed Spec Kit governance presets
- audit-ready documentation with status, evidence, and rationale

::: notes
Learners should see that security is not a single test.
Security comes from requirements, architecture, code, tests, operation, and evidence.
:::


---

# The Eight Governance Presets

| Preset | Focus |
|---|---|
| security-governance | secure development, standards, supply chain |
| architecture-governance | architecture, cloud, C3A/C5 |
| isaqb-architecture-governance | architecture quality and iSAQB relation |
| a11y-governance | accessibility and didactic comments |
| cross-platform-governance | cross-platform usability |
| agent-parity-governance | agent parity and traceable work |
| autonomous-run-governance | protected individual autonomous runs |
| parallel-autonomous-run-governance | governed parallel autonomous campaigns |

::: notes
The presets do not provide a finished solution.
They are installed from the central matrix and help keep important quality questions visible in Spec Kit artifacts.
:::


---

# Order of Tasks

| No. | Task | Focus |
|---:|---|---|
| 01 | Customer task and scope | clarify task |
| 02 | Domain model and states | business model |
| 03 | Input validation and trust boundaries | security at boundaries |
| 04 | Privacy and audit logging | data and traceability |
| 05 | Roles and permissions | least privilege |
| 06 | Persistence, import, and export | store data safely |

::: notes
This slide shows the first half of the series.
It intentionally starts with task and model, not implementation.
:::


---

# Order of Tasks

| No. | Task | Focus |
|---:|---|---|
| 07 | Testability and quality | evidence instead of claims |
| 08 | Supply chain and MSL assessment | dependencies and languages |
| 09 | Sandbox and agentic development | secure work environment |
| 10 | Process analysis and metrics | data quality |
| 11 | Spec Kit review and closure | review and presentation |

::: notes
The second half makes clear that secure development does not end with code.
Toolchain, sandbox, metrics, and final review are part of it.
:::


---

# Manual Spec Kit Runs

- Spec Kit runs are started later and deliberately
- One concrete task intake is selected per Level 2 repository
- The master intake is only the overall map
- A run creates specification, plan, tasks, and review artifacts
- No automatic implementation without a deliberate decision

::: notes
This boundary is important: preparation is not implementation.
Learners should consciously start and understand a Spec Kit run.
:::


---

# Example First Start

```text
/speckit-specify Use docs/learning-units/Lastenheft_Secure-CaseTracker_01_Kundenauftrag-und-Scope.md
as the binding input file. Create a feature specification for customer task,
scope, roles, acceptance criteria, and first privacy/security assumptions of
the EuFPA Secure CaseTracker learning series. Do not create an implementation.
```

::: notes
The actual prompt is at the end of each intake file.
It is used deliberately per task and per language repository.
:::


---

# Expected Evidence

| Evidence | Example |
|---|---|
| Functional | scope list, role matrix, state model |
| Security | trust boundaries, negative tests, dependency audit |
| Privacy | data types, purpose, minimization, log rules |
| Spec Kit | `spec.md`, `plan.md`, `tasks.md`, checklists |
| Sandbox | mounts, network assumptions, secret rules |

::: notes
Evidence does not need to be perfect.
It must be honest, reviewable, and understandable.
:::


---

# `N/A`, `Open`, and Evidence

- `Done`: checkpoint was handled and evidenced
- `N/A`: checkpoint is not applicable and justified
- `Open`: checkpoint is known but still open
- Evidence points to files, tests, decisions, or review results
- No silent omissions

::: notes
A clearly justified N/A is better than a gap.
A visible Open is better than a hidden risk.
:::


---

# Sandbox and AI Agents

- Container-first gate: every AI-agent invocation inside the container, never on the workstation
- Binding from unit 00, before the first agent starts
- Public reference: <https://github.com/hindermath/absdd-image-sandbox>
- Basis: `Secure-Trader-Sandbox-Preflight.md`
- Secrets and real personal data do not belong in prompts, logs, or Git
- Network and mount rules are documented
- Results are reviewed by humans
- Only agent-free work (reading, review, IDEs) may run outside the sandbox

::: notes
AI agents are tools, not approval authorities.
The gate is binding from unit 00; an auditable control point in ISO-27001-certified organizations (A.8.25, A.8.31).
Learners should understand boundaries and control points.
:::


---

# Accessibility and Language

- DE-first, EN-second
- CEFR B2 as understandability target
- WCAG 2.2 AA as orientation
- Text-oriented artifacts remain usable
- Abbreviations and technical terms are explained
- Slides and Markdown should work well when read aloud

::: notes
Accessibility is not only about web UIs.
Markdown, console output, slides, and tables must also remain understandable.
:::


---

# Common Mistakes

- Implementing too early
- Treating MSL as a complete security guarantee
- Treating privacy only as a legal add-on
- Planning tests only for success paths
- Using AI agents without clear boundaries
- Setting `N/A` without rationale

::: notes
These mistakes are useful for teaching.
They can be used as review questions at the end of each unit.
:::


---

# Closing the Learning Series

- Compare results per language
- Explain security decisions
- Show evidence and open risks
- Make toolchain differences visible
- Prepare a customer-oriented short presentation
- Document follow-up tasks transparently

::: notes
Closure is not only technical completion.
Learners should explain their result clearly and in a customer-oriented way.
:::


---

# Pandoc Use

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-CaseTracker-Lernreihe.en.md \
  -o Secure-CaseTracker-Learning-Series.pptx
```

- The Markdown file remains the source
- The `.pptx` file is generated when needed
- Generated presentations are not automatically versioned

::: notes
Pandoc is intended for later conversion.
Markdown remains the maintained source because it is diffable and more accessible.
:::


---

# Next Step

- Switch into a Level 2 repository
- Read the master intake as the overall map
- Start with task 01
- Review the Spec Kit artifacts
- Evidence security and privacy decisions
- Continue only after review

::: notes
C# is planned as the reference path for the first run.
The other language paths can then be used for comparison.
:::


---

# Thank You

## Questions, review points, and next decisions

- What is still unclear functionally?
- Which security assumptions must we evidence?
- Which points are `N/A`?
- Which open risks remain visible?

::: notes
This closing slide can lead into discussion, live demo, or the first Spec Kit run.
:::
