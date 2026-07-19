---
lang: en
---

<!--
Markdown template for a PowerPoint presentation.
Slide separator: ---  |  Speaker/preparation notes: ::: notes ... :::
Compatible with Pandoc (PPTX), Marp, and Slidev.
Date: 2026-07-07
-->

# Secure OrderDesk

## Introduction to Secure Development with Spec Kit, MSL, and Sandbox

EuFPA – European Company Programs Everything · Client company Secure Trader

IT specialist apprentices · Year 1 · EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
This presentation introduces the Secure OrderDesk base learning series
for year 1. It does not replace a Spec Kit run. It explains the frame, roles,
order, and expected evidence. In year 1 the ordering/trading platform stays
intentionally simple.
:::


---

# Goal of the Learning Series

- Understand secure software development step by step
- Clarify requirements first, then plan, then implement
- Make privacy, information security, and tests visible
- Use SQL safely and with parameters
- Use Spec Kit as a learning structure
- Work responsibly with agentic AI
- Document decisions so that others can review them

::: notes
The series should not send learners directly into code.
The central learning point is: good development starts with a clear task,
justified decisions, and reviewable evidence. Because the domain is relational,
SQL security and privacy are present from the start.
:::


---

# Starting Point

- The trading company **Secure Trader** needs a Secure OrderDesk platform
- The software house **EuFPA** builds and maintains it
- The platform manages customers, products, and orders
- It stores the data through an interchangeable relational store
- It provides simple reports
- The example stays small, but the working method is professional

::: notes
EuFPA and Secure Trader are fictional. The business frame is intentionally simple
so that security, privacy, documentation, and tests remain in focus.
In year 1 the focus is fundamentals, not a production trading system.
:::


---

# What Is Secure OrderDesk?

- A relational ordering/trading platform as a learning object
- It holds customers, products, orders, and order lines
- Each order references a customer, products, and a period
- Data is stored through an interchangeable relational store
- Roles decide who may record, read, or manage
- Audit logs later show what happened to the data

::: notes
Secure OrderDesk is not a production merchandise management system.
It is a learning object that makes typical relational-application decisions visible:
data model, SQL access, storage, and traceability.
:::


---

# Data Base: Northwind and ALFKI

- The binding data base is the classic **Northwind sample database**
- Layout and data including the mandatory record **`ALFKI`**
- Original order data (~1996–1998), extended with fictional records up to 2026
- All data is fictional and used brand-neutrally
- "Microsoft" is mentioned only as a historical source note

::: notes
The Northwind database is a well-known, well-documented sample base.
The record ALFKI is mandatory so all language paths share the same reference point.
No real personal data or secrets may be used.
:::


---

# Shared Core Contract

- Hold customers, products, orders, and lines in Northwind layout (incl. `ALFKI`)
- Validate order and customer input, treating input as untrusted
- Store data through an interchangeable relational store
- Keep data access parameterized only (no SQL injection)
- Distinguish the roles `learner`, `developer`, and `reviewer`
- Keep an audit log without secrets and without unnecessary personal data
- Compute simple reports: revenue per category, top products, orders per period
- Produce tests and security evidence

::: notes
All language paths use the same functional core contract.
The technical implementation may differ, but behavior must remain comparable.
The parameterized data access is a deliberate learning point.
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
It accompanies the SDD tasks but does not replace vocational school or the workplace.
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
| Coordination | `SecureOrderDeskProjects` | `secure-orderdesk-baseline` |
| Reference | `SecureOrderDesk-CSharp` | `secureorderdesk-csharp` |
| Comparison | `SecureOrderDesk-Go` | `secureorderdesk-go` |
| Comparison | `SecureOrderDesk-Java` | `secureorderdesk-java` |
| Comparison | `SecureOrderDesk-Python` | `secureorderdesk-python` |
| Comparison | `SecureOrderDesk-Rust` | `secureorderdesk-rust` |
| Comparison | `SecureOrderDesk-Swift` | `secureorderdesk-swift` |

::: notes
Local folders use CamelCase.
The GitHub slugs are created lowercase by the bootstrap scripts.
The C# reference path is implemented first as a manual reference by instructors.
:::


---

# Six MSL Paths

- C# as the first reference path
- Go, Java, Python, Rust, and Swift as comparison paths
- All six languages are treated as memory-safe languages in this series
- MSL reduces certain memory errors
- MSL does not replace review of input, SQL, I/O, auth, crypto, logging, or dependencies

::: notes
One key learning point is: a memory-safe language is helpful,
but it is not a complete security guarantee. The ordering platform shows this well,
because SQL access, validation, and I/O must be secured properly in every language.
:::


---

# Specialization Fit

| Specialization | Focus |
|---|---|
| Application Development | Model, validation, permissions, relational persistence, tests |
| System Integration | Sandbox, toolchain, database operation, logging, supply chain |
| Data and Process Analysis | Privacy, data quality, reports, limits of interpretation |
| Digital Networking | System context, interfaces, order flows, availability |

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
- Special focus: parameterized SQL access and protection of customer/order data

::: notes
Learners should see that security is not a single test.
Security comes from requirements, architecture, code, tests, operation, and evidence.
For a relational domain, SQL security and privacy are especially prominent.
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

::: notes
The presets do not provide a finished solution.
They are installed from the central matrix and help keep important quality
questions visible in Spec Kit artifacts.
:::


---

# Order of Tasks

| No. | Task | Focus |
|---:|---|---|
| 00 | Language repo and project scaffold | create a starting point |
| 01 | Customer task, scope, and trading domain | clarify task |
| 02 | Domain model for customers, products, and orders | business model |
| 03 | Input validation and trust boundaries | security at boundaries |
| 04 | Privacy and audit logging | data and traceability |
| 05 | Roles and permissions | least privilege |
| 06 | Persistence, SQL, and secure data access | parameterized queries |

::: notes
This slide shows the first half of the series.
It intentionally starts with scaffold, task, and model, not implementation.
The scaffold step ensures a clean, reproducible start.
:::


---

# Order of Tasks

| No. | Task | Focus |
|---:|---|---|
| 07 | Testability and quality | evidence instead of claims |
| 08 | Suppliers, supply chain, and MSL assessment | dependencies and languages |
| 09 | Sandbox and agentic development | secure work environment |
| 10 | Reports and metrics | data quality and operation |
| 11 | Spec Kit review and closure | review and presentation |
| 12 | Year 2 baseline and track derivation | outlook |

::: notes
The second half makes clear that secure development does not end with code.
Toolchain, sandbox, reports, and final review are part of it.
Unit 12 prepares the continuation into year 2.
:::


---

# The Learning Series Family

- **Base (year 1)**: simple ordering platform, fundamentals made secure
- **v2 (year 2)**: extended baseline, more operations, more evidence
- **Professional Tracks (year 3)**: specialization-specific deepening
- Unit 12 introduces the year 2 baseline and the track derivation
- The base stays intentionally small so fundamentals settle

::: notes
The family shows the through-line across the apprenticeship.
Year 1 lays a solid, simple base.
Only on top of that do v2 and the Professional Tracks build.
:::


---

# Related Systems at Secure Trader

- **Secure OrderDesk**: the ordering/trading platform itself (this series)
- **Secure ServiceHarvester**: collects system/inventory data of PCs and servers
- **Secure CaseTracker**: support platform for support cases
- The coupling is deliberately light: enriching context, not a hard dependency
- Every learning series stays usable on its own

::: notes
EuFPA builds three interlocking, yet individually usable systems for Secure Trader.
The shared world and data model is in Secure-Trader-Systemlandschaft.md.
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
/speckit-specify Use docs/learning-units/Lastenheft_Secure-OrderDesk_01_Kundenauftrag-Scope-und-Handelsdomaene.md
as the binding input file. Create a feature specification for customer task,
scope, trading domain, roles, acceptance criteria, and first privacy/security
assumptions of the EuFPA Secure OrderDesk learning series. The data base is
Northwind including ALFKI. Do not create an implementation.
```

::: notes
The actual prompt is at the end of each intake file.
It is used deliberately per task and per language repository.
Unit 00 (scaffold) precedes the functional start.
:::


---

# Expected Evidence

| Evidence | Example |
|---|---|
| Functional | scope list, role matrix, Northwind data model |
| Security | trust boundaries, parameterized queries, negative tests |
| Privacy | data types, purpose, minimization, log rules |
| Spec Kit | `spec.md`, `plan.md`, `tasks.md`, checklists |
| Sandbox | mounts, network assumptions, secret rules |

::: notes
Evidence does not need to be perfect.
It must be honest, reviewable, and understandable.
The parameterized data access is a central security piece of evidence.
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
- Concatenating SQL from input instead of parameterizing it
- Treating privacy only as a legal add-on
- Planning tests only for success paths
- Using AI agents without clear boundaries
- Setting `N/A` without rationale

::: notes
These mistakes are useful for teaching.
They can be used as review questions at the end of each unit.
The SQL injection mistake is especially instructive in this series.
:::


---

# Closing the Learning Series

- Compare results per language
- Explain security decisions and SQL access
- Show evidence and open risks
- Make toolchain differences visible
- Prepare a customer-oriented short presentation
- Document follow-up tasks and the path to the year 2 baseline transparently

::: notes
Closure is not only technical completion.
Learners should explain their result clearly and in a customer-oriented way.
:::


---

# Pandoc Use

```bash
pandoc docs/learning-units/presentations/Praesentation-Secure-OrderDesk-Lernreihe.en.md \
  -o Secure-OrderDesk-Learning-Series.pptx
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
- Start with task 00 (scaffold), then task 01
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
- Are all data accesses parameterized?
- Which points are `N/A`?
- Which open risks remain visible?

::: notes
This closing slide can lead into discussion, live demo, or the first Spec Kit run.
:::
