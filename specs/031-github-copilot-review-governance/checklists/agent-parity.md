# Agenten- und Guidance-Parität

Entscheidung: `NoUpdateRequired`.

Geprüft wurden `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
`.github/copilot-instructions.md`, `.github/agents/copilot-instructions.md`,
`constitution.md`, `.specify/memory/constitution.md`, `.specify/templates/`
und `scripts/templates/`. Feature 031 implementiert bestehende Regeln zu
External Writes, Secure Coding, Documentation Impact, A11Y, Home Runtime und
Providergrenzen; es ändert keine gemeinsame Policy und keinen Routingvertrag.

| Prüfung | Status | Owner / Reviewer | Re-Evaluation |
|---|---|---|---|
| beide Constitutions byte-identisch | Fulfilled | Governance Owner / Constitution Reviewer | bei Constitutionänderung |
| fünf Agentenflächen und Templates | Fulfilled | Governance Owner / Agent Parity Reviewer | bei Shared-Guidance-Trigger |
| Paritätsvalidator | Fulfilled | Test Owner / Agent Parity Reviewer | bei Oberflächen-/Templateänderung |
| Home Sync | Not executed by authority | Runtime Distribution Owner / Delivery Reviewer | erst separat autorisieren |

Diffnachweis: Es gibt in dieser Featureänderung keine beabsichtigte Änderung an
den genannten Shared-Guidance-Flächen. Bestehende unrelated Änderungen werden
nicht absorbiert.
