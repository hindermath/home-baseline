# Research: RL-SE-Checklisten-Selbstprüfung

## Forschungsrahmen

Diese Phase klärt alle Designentscheidungen für die dokumentations- und evidenzorientierte Selbstprüfung. Sie bindet ihre Aussagen an den geprüften Ausgangs-Commit `07fcb1419f011c4c73b8415f968e71c9cde3fb82`; die spätere Umsetzung muss die Bindung auf ihren tatsächlichen Commit oder dokumentierten Arbeitsbaumzustand erneuern. Es verbleiben keine offenen technischen Klärungen.

## Entscheidung 1: Kanonische Baseline und Drift

**Entscheidung**: Die zwölf Dateien unter `docs/secure-development/checklisten/` sind die kanonische Quelle der 157 stabilen IDs. Das Manifest definiert die Baseline 3.2.0 und ihre Mengen, der generierte Sammelband ist eine überprüfte Ableitung. Die Umsetzung validiert Bash- und PowerShell-Builder vor jeder positiven Baseline-Aussage.

**Begründung**: Das Manifest zählt 12 Checklisten, 157 Punkte und 15 mitgeltende Dokumente, enthält aber nicht selbst alle konkreten IDs. Nur die Quelldateien erlauben einen vollständigen Mengenidentitätsnachweis. Zehn Checklisten tragen noch Dokumentmetadaten zur Baseline 3.0.0; dies ist ein erklärungsbedürftiger Bestandszustand und darf nicht still korrigiert werden.

**Erwogene Alternativen**: Nur den Manifestzählwert übernehmen; IDs aus dem Sammelband extrahieren; Versionsunterschiede im Rahmen der Selbstprüfung ändern. Diese Varianten wurden verworfen, weil sie die Quelle/Ableitung-Grenze verwischen oder den reinen Prüf-Scope überschreiten.

## Entscheidung 2: Zeilenidentität und Zusatzprüfpunkte

**Entscheidung**: Jede Quell-ID im Format `CL-NN-NN` erscheint genau einmal. Zusätzliche Prüfpunkte verwenden semantische, sortierunabhängige IDs nach `^HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)*$` und werden in einem expliziten Zusatz-ID-Register mit Quelle und Bedarf begründet.

**Begründung**: Eine Zeile pro stabiler ID bewahrt Rückverfolgbarkeit und verhindert Mehrfachentscheidungen. Semantische Slugs bleiben stabil, wenn später Zeilen eingefügt oder umsortiert werden. Das Register macht die variable Gesamtkardinalität als `157 + Anzahl Zusatz-IDs` überprüfbar.

**Erwogene Alternativen**: Fortlaufende IDs wie `RLSE-001`; eine Zeile pro Quelle-und-Prüfpunkt-Kombination; feste Gesamtzahl vorab. Diese Varianten wurden verworfen, weil Reihenfolgeänderungen IDs verschieben, Quellenkombinationen Checklisten-IDs duplizieren und die Zusatzmenge erst aus der fachlichen Deduplizierung entsteht.

## Entscheidung 3: Workflowstatus und getrennte Statusachsen

**Entscheidung**: Genau ein Workflowstatus aus `Applicable`, `AlreadySatisfied`, `N/A`, `Open`, `FollowUp` wird nach der Vorrangfolge `N/A` → `AlreadySatisfied` → `FollowUp` → `Open` → `Applicable` gewählt. Wo die Baseline es verlangt, werden zusätzlich `Applicability` (`Applicable`, `N/A`, `Open`) und `ImplementationStatus` (`Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`, `Not Assessed`) geführt.

**Begründung**: Der Workflowstatus steuert die weitere Behandlung; die getrennten Achsen bewahren die fachliche Audit-Semantik. `N/A` bildet stets `Applicability=N/A` und `ImplementationStatus=Not Assessed` ab. Ein positives `AlreadySatisfied` verlangt `Applicable` und `Fulfilled` sowie aktuelle Evidence.

**Erwogene Alternativen**: Nur eine Statusspalte; automatische Gleichsetzung von `Applicable` mit `Fulfilled`; Übernahme von Feature-024-Statuswerten. Diese Varianten wurden verworfen, weil Anwendbarkeit und Erfüllung verschiedene Fragen sind und Vorgängerevidenz einen anderen Proof-Scope besitzt.

## Entscheidung 4: Evidenzfrische und externe Ausfälle

**Entscheidung**: Positive Evidenz ist nur aktuell, wenn sie an einen Commit oder dokumentierten Arbeitsbaumzustand gebunden ist. Ausgeführte Prüfungen nennen Befehl, Zeitpunkt und Ergebnis. Veränderliche externe Quellen nennen zusätzlich Quelle und Abrufdatum. Fehlt ein Pflichtfeld oder ist eine externe Quelle nicht erreichbar, ist `AlreadySatisfied` unzulässig; der Prüfpunkt wird mit Owner, Risiko und Trigger `Open`, ohne die Gesamtprüfung abzubrechen.

**Begründung**: So bleiben Aussagen reproduzierbar und veralten nicht unbemerkt. Die Gesamtprüfung bleibt robust gegen temporäre Provider- oder Netzwerkfehler, ohne Unsicherheit als Erfolg umzudeuten.

**Erwogene Alternativen**: Pfadnennung ohne Zustandsbindung; Abbruch bei erster externer Nichterreichbarkeit; positives Urteil auf Basis historischer TUI-Evidenz. Diese Varianten wurden wegen schwacher Kausalität, unnötiger Fragilität oder unzulässiger Beweisverallgemeinerung verworfen.

## Entscheidung 5: Governance-Abdeckung ohne versteckte Härtung

**Entscheidung**: Alle elf installierten Presets sind Prüfflächen. Das Feature bewertet ihren aktuellen Repository-Bezug, ändert aber weder Presets noch Constitution, Agent-Guidance, Code, Skripte, Abhängigkeiten oder Runtime. Handlungsbedürftige Findings werden `Open` oder `FollowUp`.

**Begründung**: Die Spezifikation autorisiert eine Selbstprüfung, keine Umsetzung der gefundenen Maßnahmen. Die Trennung bewahrt Review- und Delivery-Grenzen und verhindert, dass eine Bestandsaufnahme ihren eigenen Prüfgegenstand verändert.

**Erwogene Alternativen**: Kleine Findings sofort beheben; fehlende Standarddokumente automatisch erzeugen; nicht unmittelbar relevante Presets auslassen. Diese Varianten wurden verworfen, weil sie den genehmigten Scope ausweiten oder die geforderte vollständige Profilabdeckung schwächen.

## Entscheidung 6: Architektur, iSAQB und bestehende Nachweise

**Entscheidung**: Architecture und iSAQB sind als Bestandsprüfflächen anwendbar, für das Feature-Delta aber `N/A`. Bestehende Architektur-, Threat-Model- und Source/Home-Runtime-Dokumente werden als mögliche Evidenz bewertet; es entstehen keine neue Sicht, S-ADR oder Trust Boundary.

**Begründung**: Die Selbstprüfung muss vorhandene Architekturkontrollen abdecken, erzeugt jedoch nur Dokumentation. TUI-spezifische Artefakte belegen nicht automatisch den gesamten Level-0-Workspace.

**Erwogene Alternativen**: Architecture vollständig `N/A`; neue S-ADR als Teil der Prüfung. Beide wurden verworfen: die erste würde Bestandssicherheit auslassen, die zweite wäre eine nicht autorisierte Architekturänderung.

## Entscheidung 7: Barrierefreiheit, Sprache und Zielgruppen

**Entscheidung**: Matrix, Summary, Indexänderung und Planungsartefakte bleiben textorientiert, linear lesbar, WCAG-2.2-AA-tauglich und CEFR B2. Der vollständige deutsche Inhalt steht jeweils vor dem vollständigen englischen Inhalt. Begriffe werden bei erster Verwendung erklärt; Spec-Kit-Erfahrung und Sicherheitsabkürzungen werden nicht vorausgesetzt.

**Begründung**: Primäre Zielgruppen sind Maintainer und Ausbildungsverantwortliche, sekundär Auszubildende. Tabellen benötigen eindeutige Überschriften und dürfen Bedeutung nicht nur über Farbe, Position oder Symbole vermitteln.

**Erwogene Alternativen**: Spaltenweise Sprachmischung; visuelles Dashboard; nur maintainerorientierte Kurzsprache. Diese Varianten wurden wegen schlechter linearer Nutzbarkeit, unnötiger UI-Komplexität oder Zielgruppenbruch verworfen.

## Entscheidung 8: Plattform- und Agent-Parität

**Entscheidung**: Cross-Platform und Agent-Parity sind als Prüfpunkte anwendbar, für den Feature-Diff jedoch `N/A`. Die bestehenden Bash- und PowerShell-Baselineprüfungen werden ausgeführt. Gemeinsame Guidance-Dateien werden nicht geändert.

**Begründung**: Das Ergebnisformat ist plattformneutral. Die Gegenprobe belegt die bestehende Validatorparität, ohne neue plattformspezifische Logik einzuführen.

**Erwogene Alternativen**: Nur Bash prüfen; Shared Guidance vorsorglich aktualisieren. Diese Varianten wurden verworfen, weil eine verfügbare Paritätsprüfung ausgelassen beziehungsweise unnötiger Scope erzeugt würde.

## Entscheidung 9: Lieferkette, Standards und Regulierung

**Entscheidung**: NIST SSDF, CWE Top 25, SBOM, VEX, SLSA, OpenSSF Scorecard und OWASP SAMM werden als Bestandsprüfungen behandelt. ASVS, AI-SBOM, BSI C3A/C5 sowie neue STRIDE/CIA/CAPEC-Artefakte sind für das Delta begründet `N/A`. NIS2, CRA, EU AI Act und DORA werden ohne Rechtsbehauptung gescreent. Der aktuelle Zero-Trust-Widerspruch bleibt bis zur Evidenzklärung `Open`.

**Begründung**: Im Repository fehlen unter anderem aktuelle maschinenlesbare SBOM/VEX-Nachweise und mehrere erwartete kanonische Applicability-Dokumente. Vorhandene Security-Dateien sind teils als Stub oder Feature-018/TUI-spezifisch gekennzeichnet. Das genügt nicht für pauschales `AlreadySatisfied`.

**Erwogene Alternativen**: Alle Standards wegen Dokumentationsdelta `N/A`; historische Dateien ungeprüft positiv übernehmen; fehlende Dokumente sofort anlegen. Diese Varianten wurden wegen unvollständiger Bestandsprüfung, schwacher Evidenz oder Scope-Ausweitung verworfen.

## Entscheidung 10: Dokumentationsauswirkung und Leserpfad

**Entscheidung**: Die einzige Documentation-Impact-Entscheidung lautet `UpdateRequired`. Die datierte Matrix und Summary werden unter `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/` angelegt; `docs/security/README.md` erhält den Reader Path. Distribution ist `sourceOnly`, `homeSyncRequired=false`.

**Begründung**: Dies entspricht CR-013 und hält fachliche Baselinequellen von projektspezifischer Evidence getrennt. Die Statistik ist innerhalb dieser Entscheidung eine deterministisch erzeugte Abschlussaktualisierung, keine zweite Documentation-Impact-Entscheidung.

**Erwogene Alternativen**: `GeneratedUpdate` als Gesamtentscheidung; Evidence neben dem Intake; Home-Sync. Diese Varianten wurden verworfen, weil die fachlichen Ergebnisdokumente aktiv semantisch erstellt werden, der Standardpfad festgelegt ist und Source-Dokumentation nicht in die Home-Runtime gehört.

## Entscheidung 11: Validierungsstrategie

**Entscheidung**: Vorhandene Bash-/PowerShell-Validatoren, Mapping-Tests, Repository-Gates und prüfbare Shell-Abfragen belegen den Vertrag. Das Feature fügt kein neues Validator-Skript hinzu. Die spätere Prüfung umfasst Mengenidentität 157/157, Zusatz-ID-Register, Statusdomänen und Pflichtfelder, 15/15-Dokument- und 11/11-Preset-Abdeckung, repository-relative Pfade, Evidenzfrische sowie DE/EN-Entscheidungsparität.

**Begründung**: RLSE-023 schließt Skriptänderungen aus. Deterministische, dokumentierte Abfragen und vorhandene Werkzeuge reichen für dieses bounded Evidence-Feature; die semantische und A11Y-Prüfung bleibt zusätzlich menschlich überprüfbar.

**Erwogene Alternativen**: Neuer Python-Validator; ausschließlich manuelle Prüfung; nur Wiederverwendung des Feature-024-Validators. Sie wurden verworfen, weil ersteres den Scope verletzt, zweites keine Mengenbeweise liefert und drittes nur Mapping-Integrität statt Assessment-Semantik prüft.

## Entscheidung 12: Statistik und kausaler Abschluss

**Entscheidung**: Der Statistik-Renderer wird nach vollständigem Feature-Diff geprüft. Da sein Schreibmodus einen sauberen Arbeitsbaum verlangt und `LocalImplementation` keinen Commit autorisiert, wird ein verbleibender Git-basierter Statistik-`DRIFT` als begrenztes Follow-up für eine später autorisierte Lieferung dokumentiert. Der Series-Closeout wird erst nach tatsächlicher Feature-Erfüllung und gegen den dann aktuellen Graphen vorbereitet; kein Nachfolger wird gestartet.

**Begründung**: Der aktuelle Renderer-Test besteht mit 146 Assertions, während `--check-only --json` erwartbar `DRIFT` meldet. Eine Clean-Tree-Barriere darf nicht umgangen werden. Commit, Push, PR, Merge und Remote-Veröffentlichung liegen außerhalb `LocalImplementation`. Auch die aktuell erwartbaren Graphwerte 33→32 Ziele, 4→3 Roots und 36 Kanten müssen beim Closeout neu berechnet werden.

**Erwogene Alternativen**: Renderer trotz schmutzigem Arbeitsbaum erzwingen; ungecommitete Werte als `CURRENT` behaupten; Series vor Ergebnisabschluss schließen; Remote-Lieferung implizieren. Diese Varianten wurden verworfen, weil sie Reproduzierbarkeit, Autoritätsgrenzen oder kausale Reihenfolge verletzen.

---

# Research: RL-SE Checklist Self-Assessment

## Research Frame

This phase resolves every design decision for the documentation- and evidence-oriented self-assessment. Its findings are bound to inspected commit `07fcb1419f011c4c73b8415f968e71c9cde3fb82`; implementation must renew the binding to its actual commit or documented working-tree state. No technical clarification remains open.

## Decision 1: Canonical Baseline and Drift

**Decision**: The twelve files under `docs/secure-development/checklisten/` are the canonical source of the 157 stable identifiers. The manifest defines baseline 3.2.0 and its counts; the generated compendium is a verified derivative. Implementation validates the Bash and PowerShell builders before making a positive baseline claim.

**Rationale**: The manifest counts 12 checklists, 157 items, and 15 related documents, but does not contain all concrete identifiers. Only the source files support a complete set-identity proof. Ten checklists still carry document metadata for baseline 3.0.0; this existing state needs explanation and must not be silently corrected.

**Alternatives considered**: Trust only the manifest count; extract identifiers from the compendium; change version differences during the assessment. These options blur source/derivative boundaries or exceed the assessment-only scope.

## Decision 2: Row Identity and Additional Checkpoints

**Decision**: Every source identifier matching `CL-NN-NN` appears exactly once. Additional checkpoints use semantic, order-independent identifiers matching `^HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)*$` and are declared in an explicit register with source and rationale.

**Rationale**: One row per stable identifier preserves traceability and prevents conflicting decisions. Semantic slugs remain stable when rows are inserted or reordered. The register makes the variable total `157 + additional-ID count` verifiable.

**Alternatives considered**: Sequential IDs such as `RLSE-001`; one row per source/checkpoint combination; a predeclared total. These would shift identifiers, duplicate checklist controls, or invent a count before semantic deduplication.

## Decision 3: Workflow Status and Separate Status Axes

**Decision**: Exactly one workflow status from `Applicable`, `AlreadySatisfied`, `N/A`, `Open`, and `FollowUp` is selected using precedence `N/A` → `AlreadySatisfied` → `FollowUp` → `Open` → `Applicable`. Where required by the baseline, the assessment also records `Applicability` (`Applicable`, `N/A`, `Open`) and `ImplementationStatus` (`Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`, `Not Assessed`).

**Rationale**: Workflow status controls next handling; separate axes preserve audit semantics. `N/A` always maps to `Applicability=N/A` and `ImplementationStatus=Not Assessed`. Positive `AlreadySatisfied` requires `Applicable`, `Fulfilled`, and current evidence.

**Alternatives considered**: A single status column; equating `Applicable` with `Fulfilled`; copying Feature 024 status values. These confuse applicability with fulfillment or cross incompatible proof scopes.

## Decision 4: Evidence Freshness and External Failures

**Decision**: Positive evidence is current only when bound to a commit or documented working-tree state. Executed checks record command, timestamp, and result. Mutable external sources also record source and retrieval date. Missing required fields or unavailable external evidence prohibits `AlreadySatisfied`; the checkpoint becomes `Open` with owner, risk, and trigger, while the overall assessment continues.

**Rationale**: Claims remain reproducible and cannot silently age. The assessment remains resilient to temporary provider or network failures without turning uncertainty into success.

**Alternatives considered**: Path-only evidence; abort on the first external outage; positive status based on historical TUI evidence. These lack causality, create unnecessary fragility, or overgeneralize a proof.

## Decision 5: Governance Coverage Without Hidden Hardening

**Decision**: All eleven installed presets are assessment surfaces. The feature evaluates their current repository relevance but changes no preset, constitution, agent guidance, code, script, dependency, or runtime. Findings that require action become `Open` or `FollowUp`.

**Rationale**: The specification authorizes assessment, not implementation of findings. Separation preserves review and delivery boundaries and prevents the assessment from changing its own subject.

**Alternatives considered**: Fix small findings immediately; auto-create missing standards documents; omit presets judged peripheral. These expand scope or weaken complete profile coverage.

## Decision 6: Architecture, iSAQB, and Existing Evidence

**Decision**: Architecture and iSAQB apply as current-state assessment areas and are `N/A` for the feature delta. Existing architecture, threat-model, and source/Home-runtime documents are evaluated as possible evidence; no new view, S-ADR, or trust boundary is created.

**Rationale**: The self-assessment must cover existing architecture controls but produces documentation only. TUI-specific artifacts do not automatically prove the entire Level 0 workspace.

**Alternatives considered**: Mark Architecture entirely N/A; create a new S-ADR as part of assessment. The former omits current-state security; the latter is an unauthorized architecture change.

## Decision 7: Accessibility, Language, and Audiences

**Decision**: Matrix, summary, index change, and planning artifacts remain text-oriented, linearly readable, WCAG 2.2 AA capable, and CEFR B2. Complete German content precedes complete English content. Terms are explained on first use; no Spec Kit experience or knowledge of security abbreviations is assumed.

**Rationale**: Primary audiences are maintainers and training leads; apprentices are secondary. Tables require clear headers and must not encode meaning only through color, position, or symbols.

**Alternatives considered**: Mixed-language columns; a visual dashboard; maintainer-only shorthand. These reduce linear usability, add unnecessary UI complexity, or violate the audience contract.

## Decision 8: Platform and Agent Parity

**Decision**: Cross-Platform and Agent Parity apply as assessment points and are `N/A` for the feature diff. Existing Bash and PowerShell baseline checks are executed. Shared guidance files are not changed.

**Rationale**: The result format is platform-neutral. The cross-check proves existing validator parity without adding platform-specific logic.

**Alternatives considered**: Test Bash only; update shared guidance preemptively. These would omit an available parity proof or create needless scope.

## Decision 9: Supply Chain, Standards, and Regulation

**Decision**: NIST SSDF, CWE Top 25, SBOM, VEX, SLSA, OpenSSF Scorecard, and OWASP SAMM are current-state assessment areas. ASVS, AI-SBOM, BSI C3A/C5, and new STRIDE/CIA/CAPEC artifacts are justified N/A for the delta. NIS2, CRA, EU AI Act, and DORA are screened without legal claims. The current Zero Trust contradiction remains `Open` until evidence resolves it.

**Rationale**: The repository currently lacks, among other things, current machine-readable SBOM/VEX evidence and several expected canonical applicability documents. Existing security files are partly marked as stubs or limited to Feature 018/the TUI. That does not support blanket `AlreadySatisfied` decisions.

**Alternatives considered**: Mark every standard N/A because the delta is documentation; accept historical files without review; create missing documents immediately. These would produce an incomplete assessment, weak evidence, or scope expansion.

## Decision 10: Documentation Impact and Reader Path

**Decision**: The single Documentation Impact decision is `UpdateRequired`. The dated matrix and summary are created under `docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/`; `docs/security/README.md` receives the reader path. Distribution is `sourceOnly`, with `homeSyncRequired=false`.

**Rationale**: This follows CR-013 and separates canonical baseline sources from project-specific evidence. Within this decision, statistics are a deterministically generated completion update, not a second Documentation Impact decision.

**Alternatives considered**: `GeneratedUpdate` as the overall decision; store evidence beside the intake; Home sync. These conflict with semantic authoring, the prescribed evidence path, or the source-only distribution boundary.

## Decision 11: Validation Strategy

**Decision**: Existing Bash/PowerShell validators, mapping tests, repository gates, and auditable shell queries prove the contract. The feature adds no validator script. Later checks cover 157/157 set identity, the additional-ID register, status domains and required fields, 15/15 document and 11/11 preset coverage, repository-relative paths, evidence freshness, and German/English decision parity.

**Rationale**: RLSE-023 excludes script changes. Deterministic documented queries and existing tools are sufficient for this bounded evidence feature, with separate semantic and accessibility review.

**Alternatives considered**: Add a Python validator; manual-only review; reuse only Feature 024 validation. The first violates scope, the second lacks set proofs, and the third validates mapping integrity rather than assessment semantics.

## Decision 12: Statistics and Causal Closeout

**Decision**: The statistics renderer is checked after the complete feature diff. Because write mode requires a clean worktree and `LocalImplementation` does not authorize a commit, remaining Git-derived statistics `DRIFT` is recorded as a bounded follow-up for a later authorized delivery. Series closeout is prepared only after actual feature fulfillment and against the then-current graph; no successor is started.

**Rationale**: The current renderer tests pass 146 assertions while `--check-only --json` reports expected `DRIFT`. The clean-tree barrier must not be bypassed. Commit, push, pull request, merge, and remote publication are outside `LocalImplementation`. Even currently expected graph values of 33→32 targets, 4→3 roots, and 36 edges must be recalculated at closeout.

**Alternatives considered**: Force rendering on a dirty tree; claim uncommitted figures are `CURRENT`; close the series before results are complete; imply remote delivery. These violate reproducibility, authority boundaries, or causal ordering.
