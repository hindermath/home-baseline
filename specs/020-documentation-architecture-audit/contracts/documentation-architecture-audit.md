# Contract: Documentation Information Architecture Audit

## Inputs

The collector and validator operate on an explicit repository root and accepted
feature-local files. They do not fetch, pull, stage, commit, push, or modify
assessed documentation.

## Collector Contract

```text
python3 tools/collect_documentation_architecture.py \
  --repo REPOSITORY_ROOT \
  --commit ACCEPTED_PRE_FEATURE_COMMIT \
  --decisions DECISIONS_JSON \
  --output INVENTORY_JSON
```

The collector MUST:

- read paths from `git ls-tree -r -z --name-only` at the explicit accepted
  pre-feature commit;
- accept only repository-relative paths;
- normalize UTF-8 BOM and LF/CRLF before SHA-256;
- order records lexicographically by path;
- fail on undecodable text, duplicate paths, missing semantic decisions, or
  writes outside the explicit output path;
- leave tracked source files unchanged.

## Validator Contract

```text
python3 tools/validate_documentation_architecture.py \
  --repo REPOSITORY_ROOT \
  --audit AUDIT_JSON
```

Exit codes:

- `0`: complete and valid audit evidence;
- `1`: semantic or data-contract violation;
- `2`: invocation, I/O, or malformed-input failure.

Output is one text-first summary on stdout. Errors identify a stable category
and repository-relative evidence path on stderr. No result is inferred from an
empty stream or a schema-only pass.

## Required Rejections

The validator rejects missing or duplicate inventory paths; unknown classes or
decisions; missing evidence; incomplete reader paths; missing maintenance
contracts; incomplete source/runtime coverage; stale hashes; invalid finding
references; findings without owner or successor; accepted rows with `Gap`;
private absolute paths; credentials; and unnormalized identity drift.

## Proof Boundary

The tools prove structure, identity, hash, cardinality, and cross-reference
integrity. They do not prove that prose is pedagogically clear, that a language
split is desirable, or that two claims are semantically equivalent. Those
decisions require the recorded audit review.
