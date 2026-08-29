# Vorimplementierungsabnahme / Pre-Implementation Acceptance

**Status**: `Accepted`

**Scope**: T001-T010, Safe Boundary A0

**Owner / Reviewer**: Fleet Governance Owner / Feature, Runner, Security, Architecture, A11Y, Cross-Platform, Intake and Authority Reviewers

| Prueffeld / Review area | Applicability | Status | Evidence | Restrisiko / Residual risk | Follow-up / Re-Evaluation |
|---|---|---|---|---|---|
| TA-007 Runnerbaseline | Applicable | Accepted | `operational/runner-adoption/baseline.json` | Keine / None | Bei Runner-, Fixture-, Test-, Help- oder Manpage-Aenderung |
| TA-007 Sechsfallmatrix | Applicable | Accepted | `red-contract-matrix.json`, `green-direct.json`, `green-wrapper.json` | Native Linux-/Windows-Proof bleibt spaeter offen | T126-T128 und T158-T159 |
| TerminalAwareRunnerAdoption | Applicable | Accepted | `implementation.json`, `reconciliation.json` | Exakte Terminaladoption bleibt auf `implement-closeout` begrenzt | Bei State-, Result-, Tasks-, Git- oder Routingvertragsdrift |
| Artefakte und Hashes | Applicable | Accepted | Run-State `acceptedArtifacts` 10/10 | Keine / None | Bei jedem Hash- oder Inhaltswechsel |
| Plan, Research, Plan Review 3 | Applicable | Accepted | `plan.md`, `research.md`, `plan-review-3.md` und validiertes Resultat | Keine / None | Bei Artefaktdrift |
| Tasks und Stable Keys | Applicable | Accepted | 168/168 Tasks, 50/50 Stable Keys, 10/10 Gatebefehle | Keine / None | Bei Tasks-/Spec-/Plan-/Gate-JSON-Aenderung |
| Constitutions | Applicable | Accepted | 2/2 bytegleich, v1.21.0 | Keine / None | Bei Policyaenderung |
| Contracts | Applicable | Accepted | 7/7 JSON-Schemas und Providervertrag | Keine / None | Bei Schema-/Providerdrift |
| Intake, Serie und Stage B | Applicable | Accepted | Ready-Review, Manifest/Receipt und 48/48 Stage-B-Evidence | Position 7 bleibt gesperrt | Nach G4-Closeout read-only revalidieren |
| Delivery Set | Applicable | Accepted | `operational/preflight/delivery-set-before-implementation.json` | Vorbestehende autorisierte/unabhaengige Pfade bleiben getrennt | Vor Delivery erneut exakt pruefen |
| External Write Authority | Applicable | Accepted: nicht erteilt / not granted | Spec, Plan, State und Tasks | Providerwrites bleiben blockiert | Nur frischer operationsspezifischer Authority-Record |
| Position 7, Subscription, Budget, Cancellation | Applicable | Accepted: unveraendert / unchanged | Scope- und Mutationzaehler `0` | Keine implizite Autoritaet | Bei jeder Scopeaenderung Hard Stop |

TA-007 ist Accepted. Der autonome Run, Credentials, `MergeAndSync`, eine
Runnerkorrektur oder Admin-Bypass erteilen keine External-Write-Autoritaet.
Position 7 bleibt unveraendert und darf nicht gestartet werden.

*TA-007 is accepted. The autonomous run, credentials, `MergeAndSync`, a runner
fix, or Admin Bypass does not grant external-write authority. Position 7
remains unchanged and must not be started.*
