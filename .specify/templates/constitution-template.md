# [PROJECT_NAME] Constitution
<!-- Example: Spec Constitution, TaskFlow Constitution, etc. -->

## Core Principles

### [PRINCIPLE_1_NAME]
<!-- Example: I. Library-First -->
[PRINCIPLE_1_DESCRIPTION]
<!-- Example: Every feature starts as a standalone library; Libraries must be self-contained, independently testable, documented; Clear purpose required - no organizational-only libraries -->

### [PRINCIPLE_2_NAME]
<!-- Example: II. CLI Interface -->
[PRINCIPLE_2_DESCRIPTION]
<!-- Example: Every library exposes functionality via CLI; Text in/out protocol: stdin/args → stdout, errors → stderr; Support JSON + human-readable formats -->

### [PRINCIPLE_3_NAME]
<!-- Example: III. Test-First (NON-NEGOTIABLE) -->
[PRINCIPLE_3_DESCRIPTION]
<!-- Example: TDD mandatory: Tests written → User approved → Tests fail → Then implement; Red-Green-Refactor cycle strictly enforced -->

### [PRINCIPLE_4_NAME]
<!-- Example: IV. Integration Testing -->
[PRINCIPLE_4_DESCRIPTION]
<!-- Example: Focus areas requiring integration tests: New library contract tests, Contract changes, Inter-service communication, Shared schemas -->

### [PRINCIPLE_5_NAME]
<!-- Example: V. Observability, VI. Versioning & Breaking Changes, VII. Simplicity -->
[PRINCIPLE_5_DESCRIPTION]
<!-- Example: Text I/O ensures debuggability; Structured logging required; Or: MAJOR.MINOR.BUILD format; Or: Start simple, YAGNI principles -->

## [SECTION_2_NAME]
<!-- Example: Additional Constraints, Security Requirements, Performance Standards, etc. -->

[SECTION_2_CONTENT]
<!-- Example: Technology stack requirements, compliance standards, deployment policies, etc. -->

## [SECTION_3_NAME]
<!-- Example: Development Workflow, Review Process, Quality Gates, etc. -->

[SECTION_3_CONTENT]
<!-- Example: Code review requirements, testing gates, deployment approval process, etc. -->

## Lernenden- und A11Y-Basis / Learner and A11Y Baseline

Learner-facing and user-facing work MUST name its audience and review path.
For Home Baseline, the ABS-DD sandbox, TuiVision, TinyPl0, TinyCalc, and
InventarWorkerService, content MUST be understandable from the first training
year for IT specialist apprentices, IT systems electronics technician
apprentices, and both IT management occupations. It MUST be
German-first/English-second at approximately CEFR B2, explain technical terms
at first use, assume no prior Spec Kit experience, provide text-first
dependency/state/decision information, and apply WCAG 2.2 Level AA wherever
the criteria are applicable.

## macOS-first-Plattformnachweis / macOS-First Platform Evidence

Plattformabhängige Nachweise MUST zuerst lokal im passenden macOS-Safe-Mode
laufen. Fehlt ein nativer Linux-Host, MUST ein isolierter nativer Container mit
schreibgeschütztem Repository und ohne unnötiges Netzwerk oder ein eng
begrenzter nativer Linux-CI-Job verwendet werden. Fehlt ein nativer
Windows-Host, MUST ein eng begrenzter nativer Windows-CI-Job verwendet werden.
Evidence MUST exakten Commit, Befehl, Runner/Plattform, Exitcode,
Payload-SHA-256, Entscheidungs-SHA-256 und Nullschreibwerte binden. Ein
Teilnachweis MUST NOT als vollständiger Regressions-, Security-, A11Y-,
Review- oder Delivery-Pass berichtet werden.

*Run platform-dependent evidence in the matching local macOS safe mode first.
Without a native Linux host, use an isolated native container with a read-only
repository and no unnecessary network, or narrowly scoped native Linux CI.
Without a native Windows host, use narrowly scoped native Windows CI. Bind the
exact commit, command, runner/platform, exit code, payload SHA-256, decision
SHA-256, and zero-write values. Never report a partial proof as a full
regression, security, accessibility, review, or delivery pass.*

## Governance
<!-- Example: Constitution supersedes all other practices; Amendments require documentation, approval, migration plan -->

[GOVERNANCE_RULES]
<!-- Example: All PRs/reviews must verify compliance; Complexity must be justified; Use [GUIDANCE_FILE] for runtime development guidance -->

**Version**: [CONSTITUTION_VERSION] | **Ratified**: [RATIFICATION_DATE] | **Last Amended**: [LAST_AMENDED_DATE]
<!-- Example: Version: 2.1.1 | Ratified: 2025-06-13 | Last Amended: 2025-07-16 -->
