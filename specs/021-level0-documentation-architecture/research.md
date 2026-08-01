# Research: Level-0 Documentation Architecture

## Decision 1: Keep the existing topic taxonomy

**Decision**: Use current `docs/` families as canonical destinations and add
only reader-oriented portals and missing task pages.

**Rationale**: D4 found an oversized entry point, not an invalid repository
taxonomy. A second taxonomy would create new ownership ambiguity.

## Decision 2: Split the root by language and task

**Decision**: Keep concise German `README.md` and English `README.en.md`, then
move detail into paired or short bilingual topic pages.

**Rationale**: Separate entry pages improve scanning while preserving the
repository rule that German is primary and English follows.

## Decision 3: Bind every former top-level section

**Decision**: Use a deterministic JSON migration matrix with one primary
decision per original top-level section.

**Rationale**: File movement and link checks alone cannot prove that active
content was retained or intentionally retired.

## Decision 4: Preserve normative and generated ownership

**Decision**: Topic pages link to Constitution, script references, manpages,
security documents, and generated outputs instead of copying their contracts.

**Rationale**: This prevents semantic drift and respects renderer boundaries.

## Decision 5: Treat source/runtime orientation as a reader contract

**Decision**: Explain Level-0 source, Home Runtime, `homeRuntime`, `sourceOnly`,
and `machineLocal` through paired task pages and portal summaries.

**Rationale**: D4 showed that users need an actionable edit/sync/authority map,
not an implementation inventory duplicated in prose.

## Decision 6: Validate semantics and mechanics separately

**Decision**: Record human semantic review independently from deterministic
matrix, link, language, and scope validation.

**Rationale**: A parser can prove structure and references, but not learner
comprehension, translation equivalence, or appropriate progressive disclosure.
