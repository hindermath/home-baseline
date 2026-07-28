# Contract: Resume Evidence

Resume evidence is written to a temporary sibling file and atomically replaced.
Paths are repository-relative and traversal-free. SHA-256 values use lowercase
hex. Applied evidence is accepted only when every listed path exists in the
expected state and no unknown dirty path is present. Otherwise the run stops
without mutation.
