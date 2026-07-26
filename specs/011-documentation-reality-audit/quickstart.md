# Quickstart: Validate D1 Evidence

## Deutsch

Eine **Registry-Snapshot** ist die eingefrorene Liste der geprüften
Repositories. Sie verhindert, dass ein während des Audits geändertes Register
unbemerkt die Zielmenge verändert.

```bash
python3 specs/011-documentation-reality-audit/tools/validate_documentation_audit.py \
  --repo . \
  --snapshot specs/011-documentation-reality-audit/registry-snapshot.json \
  --audit specs/011-documentation-reality-audit/documentation-audit.json

python3 -m unittest discover \
  -s specs/011-documentation-reality-audit/tests \
  -p 'test_*.py'
```

Der Validator liest nur. Ein erfolgreicher Lauf bestätigt Zielmenge,
Entscheidungen, Evidence, Findings, Handoffs und Datenschutzgrenzen.

## English

A **registry snapshot** is the frozen list of assessed repositories. It keeps a
registry change during the audit from silently changing the target set.

Run the same commands above. The validator is read-only. Success confirms
target coverage, decisions, evidence, findings, handoffs, and privacy
boundaries; it does not claim that every document is already correct.
