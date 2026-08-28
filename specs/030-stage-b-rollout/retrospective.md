# Retrospektive: Stage-B-Flottenrollout / Stage B Fleet Rollout Retrospective

## Ergebnis / Outcome

Der autonome Lauf konvergierte 48 von 48 autoritativen Repositories in fünf strikt serialisierten Wellen: 28 semantische No-ops und 20 reguläre Private-Governance-PRs. Alle 20 Zielrepositorys besitzen den bytegleichen Minimal-Workflow und ein aktives Default-Branch-Ruleset mit genau einem Status, einer Approval, strict checks und ohne Bypass-Akteure. Die monatliche private Actions-Projektion blieb in allen fünf Wellen bei 210,666667 Minuten und damit unter 500/3000.

*The autonomous run converged all 48 authoritative repositories in five strictly serialized waves: 28 semantic no-ops and 20 regular private-governance pull requests. All 20 target repositories now have the byte-identical minimal workflow and an active default-branch ruleset with exactly one status, one approval, strict checks, and no bypass actors. The monthly private Actions projection remained 210.666667 minutes in all five waves, below 500/3000.*

## Wiederverwendbare Erkenntnisse / Reusable Learnings

1. macOS-first-Entwicklung kann native Linux- und Windows-Nachweise sicher über eng berechtigte GitHub-Actions-Runner beziehen. Payload-, Entscheidungs- und Head-Hashes müssen dabei zusammengebunden bleiben; ein Plattformnachweis ersetzt keine Vollregression. / macOS-first development can obtain native Linux and Windows proof through narrowly permissioned GitHub Actions runners. Payload, decision, and head hashes must stay bound; a platform proof does not replace a full regression.
2. Ein vor Runnerstart abgelehnter Billing-/Quota-Run ist `BillingOrQuotaRefusal`, kein technischer Pass. Das bekannte Copilot-Kontingent bleibt bis 2026-09-01 unverändert; Aufstocken ist nicht Teil dieses Laufs. / A billing/quota run rejected before runner start is `BillingOrQuotaRefusal`, not a technical pass. The known Copilot quota remains unchanged until 2026-09-01; topping up is outside this run.
3. Neu gelieferte Workflowdateien werden vom Provider erst nach Default-Branch-Merge als dispatch- und check-sichtbare Workflows erkannt. Die sichere Reihenfolge ist deshalb Workflow-PR, Merge/Sync, anschließend Ruleset-Write und frische Verifikation. / Newly delivered workflow files become dispatch- and check-visible only after default-branch merge. The safe order is workflow PR, merge/sync, then ruleset write and fresh verification.
4. Flottenpläne müssen nach jeder Control-Plane-Remediation neu erzeugt werden. Der alte Plan wurde hashverifiziert archiviert, bevor der frische 48-Repo-Plan autorisiert wurde. / Fleet plans must be regenerated after every control-plane remediation. The old plan was hash-verified and archived before the fresh 48-repository plan was authorized.
5. Statistikprofile sind Git-historienabhängig. Der erste Closeout-Commit erzeugte erwartbaren Profil-2-Drift; ein deterministischer, auf genau `docs/project-statistics.md` begrenzter Companion-Commit stellte alle 26 Cross-Platform-Gates wieder grün. / Statistics profiles depend on Git history. The first closeout commit caused expected Profile 2 drift; a deterministic companion commit limited to `docs/project-statistics.md` restored all 26 cross-platform gates.
6. Wenn der Repository-Owner zugleich PR-Autor ist und Copilot wegen des bekannten Kontingents nicht antwortet, muss die Owner/Codex-Self-Review-Ausnahme den exakten Head, null Findings und den fehlenden Provider-Approval-Status wahrheitsgemäß dokumentieren. Sie ersetzt weder Tests noch Schutzregel-Refusal-Evidence. / When the repository owner is also the PR author and Copilot cannot respond because of the known quota, the Owner/Codex self-review exception must truthfully record the exact head, zero findings, and missing provider approval. It replaces neither tests nor protection-refusal evidence.

## Evidence-Bindung / Evidence Binding

- Run: `954ff259-ffed-44a8-883f-28742b031a9b`
- Plan: `adbcb81091443fe10f283211b1d13e0572feb57cfd1e42816ba7e1e894343ce5`
- Operative Acceptance: `f397fba8d4b340f5ff0bdb4a0bd03bf15c50989292224d4deefd59281753a081`
- PreMerge: `e2deecb76cb712f87936f2cb1c126ae2963f7b4214867d0467caf1a11507978c`
- Regular merge: `27b02c34dcd2a73d2c811ddfe28f9d4e71e917bd`
- Home sync: `9f395d0dbe6ca749a3276275d80ab3169aa1ca4e`
- Causal PostMerge: `1f1e1a8d43da453149807a6d8ee22b02c49f1f76c762057d06b458f149696261`

## Disposition

`NoPromotion` für neue Produkt- oder Providerfunktion: Die wiederverwendbaren Regeln sind bereits in den Stage-B-Verträgen, Tests, Shared Guidance und Evidence-Grenzen enthalten. Neue Erkenntnisse nach dem terminalen T190-Merge werden ausschließlich als separat autorisierter Follow-up erfasst; diese Retrospektive wird nach T190 nur read-only revalidiert. G4 bleibt unverändert und benötigt ein separates Intake-Series-Sequencing-Update.

*`NoPromotion` for new product or provider functionality: the reusable rules are already represented in the Stage B contracts, tests, shared guidance, and evidence boundaries. New learning after the terminal T190 merge is recorded only as a separately authorized follow-up; this retrospective is read-only revalidated after T190. G4 remains unchanged and requires a separate intake-series sequencing update.*
