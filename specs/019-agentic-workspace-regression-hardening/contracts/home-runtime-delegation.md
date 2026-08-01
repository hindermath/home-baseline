# Contract: Home Runtime Delegation

The local Home Runtime resolves the versioned Level-0 wrapper and performs
exactly one `exec` transition.

- Zero arguments invoke only the interpreter and canonical script path.
- One or more arguments retain their order, empty values and exact boundaries.
- No argument is concatenated into executable shell text.
- Wildcards, whitespace, quotes and metacharacters are data, not syntax.
- Direct and delegated invocations preserve options and exit codes.
- The contract must pass under macOS system Bash 3.2 and current Bash.

