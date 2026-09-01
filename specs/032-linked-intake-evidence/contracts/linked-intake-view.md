# Contract: Linked Intake Order View

## Scope

This contract governs every generated active intake-order table in the seven
accepted repositories. Local prose, headings, and notes may remain
repository-specific, but the canonical row projection and fallback text are
identical.

## Required Table Shape

The header has exactly five columns in this order:

```markdown
| Position | Status | Lastenheft/Intake | Abhängigkeiten / Dependencies | Spec-Kit-Feature |
```

Each active manifest entry produces exactly one row. Rows are ordered by the
canonical active series order and display the stable visible position supplied
by the model. No backlog item is inserted into this table.

## Intake Cell

- The visible label is the repository-local intake name or its established
  display label.
- The label is a Markdown link from the generated view to the existing intake
  file.
- The target is repository-relative from the view location, uses `/`, and is
  URL/Markdown escaped without changing the underlying filename.
- Absolute paths, `file:` URIs, machine names, workspace roots, credentials,
  query strings, and fragments containing evidence secrets are forbidden.

## Dependency Cell

For a row with no direct incoming dependency, render exactly:

```text
— (Root / keine direkte Abhängigkeit)
```

For each direct incoming edge, render a deterministic item containing:

1. a relative Markdown link to the source intake;
2. the direction from the source toward the current target;
3. the exact `kind` value; and
4. literal `binding: true` or `binding: false`.

Multiple incoming edges retain canonical manifest order and are separated with
`<br>` so table linearization preserves one complete edge per line. The
renderer must not add transitive edges, suppress advisory edges, invert edge
direction, translate `kind`, or reinterpret `binding`.

## Feature Cell

Exactly one valid feature proof produces a relative Markdown link to the
existing feature directory. The visible label is that directory's stable
`NNN-slug` name.

When no valid feature proof exists, render exactly:

```text
— (kein Spec-Kit-Feature / no Spec Kit feature)
```

Two or more valid candidates, a missing target, an unsafe target, or a proof
contradiction is a renderer error. It must not be converted to the no-feature
fallback. Numeric and slug similarity are not proof.

## Escaping and Encoding

- Inputs and outputs are strict UTF-8 without NUL.
- Markdown table delimiters, brackets, parentheses, backslashes, and link
  destinations are escaped by one shared repository-local routine.
- German umlauts and `ß` are retained, not transliterated.
- Output line endings follow the repository's declared policy and are stable
  across unchanged runs.
- Trailing whitespace and private absolute paths are forbidden.

## Accessibility and Language

The table remains understandable in source order and after linearization by a
screen reader or text browser. Meaning does not depend on color, emoji, visual
position, or link styling. Explanatory user-facing text follows the local
German-first/English-second policy at CEFR B2. The exact bilingual fallbacks
above are part of the machine-verifiable contract.

## Determinism

Given the same validated canonical inputs and feature evidence, every
supported renderer implementation produces semantically identical rows and
links. A second unchanged write-mode run produces zero file changes. Check
mode reports stale output without writing.
