# Tasks: Flottenweite CI-Budget-Governance / Fleet-Wide CI Budget Governance

**Input / Eingabe**: Akzeptierte Designartefakte aus `specs/029-ci-budget-governance/`

**Prerequisites / Voraussetzungen**: `spec.md`, `plan.md`, `research.md`, `data-model.md`, `quickstart.md`, vier JSON-Verträge, `contracts/workflow-ruleset-contract.md`, alle akzeptierten Checklisten, `autonomous-run-gate-requirements.json`, Run-State `eca02c0f-5399-49c0-8de4-b21233834254`, Constitution v1.20.2 und die installierte Zwölf-Preset-Matrix

**Delivery boundary / Liefergrenze**: Ausschließlich Stufe A unter `LocalImplementation`. Diese Tasks dürfen nur Level-0-Artefakte und maschinenlokale Evidence erzeugen oder ändern. Verboten bleiben Commit, Push, Merge, Home-Sync, GitHub-Schreibzugriff, aktive Workflow-/Ruleset-/Account-/Reviewer-Mutation, Admin-Bypass, Zielrepository-Edits und G4-Start. Stufe B ist nur als nicht ausgeführter Handoff zu dokumentieren.

**Mandatory pre-implementation gate / Verbindliches Gate vor Implementierung**: Nach Erzeugung dieser Datei und vor T001 muss die geroutete Phase `speckit.analyze` erfolgreich laufen und ein gültiges Ergebnis unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/analyze.result.json` erzeugen. Die bekannte Whitespace-Normalisierung von `spec.md` und `checklists/requirements.md` ist dabei als nicht semantisch zu revalidieren. Bei einem Critical-/High- oder ungelösten Medium-Finding beginnt keine Implementierung.

**Tests / Tests**: Test-first ist für Verträge, den repräsentativen Vertical Slice und alle fail-closed Negativfälle verbindlich. Ein roter Nachweis muss vor dem zugehörigen grünen Implementierungsschritt vorliegen.

**Format**: Jede Task-Zeile folgt strikt `- [ ] TNNN [P?] [US?] Beschreibung mit Pfad`.

## Phase 1: Evidence- und Ausführungs-Setup / Evidence and Execution Setup

**Purpose / Zweck**: Exakte Evidence-Ziele und lokale Schutzgrenzen vor der ersten Runtime-Implementierungsänderung anlegen.

- [x] T001 Lege vor jeder Runtime-Codeänderung die getrackten Evidence-Skelette `specs/029-ci-budget-governance/checklists/cross-platform.md`, `specs/029-ci-budget-governance/checklists/stage-a-mutation-allowlist.md`, `specs/029-ci-budget-governance/checklists/implementation-governance.md`, `specs/029-ci-budget-governance/documentation-impact-evidence.json`, `docs/architecture/ci-budget-governance.md`, `docs/accessibility/ci-budget-governance.md`, `docs/security/adr/ADR-002-ci-gate-defense-in-depth.md`, `docs/security/regulatory-applicability.md`, `docs/security/cloud-autonomy-applicability.md` und `docs/security/cloud-compliance-assurance.md` mit `Applicable`/`N/A`, Owner, Reviewer, Restrisiko, Follow-up und Re-Evaluation-Trigger an.
- [x] T002 Lege vor jeder Runtime-Codeänderung die maschinenlokalen Verzeichnisse `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/` und `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/` an, ohne Dateien zu stagen.
- [x] T003 Ergänze die eng begrenzte Ignore-Regel für `.specify/runtime/` in `.gitignore` und belege mit `git check-ignore -q .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence`, dass Lauf-Evidence nicht getrackt werden kann.
- [x] T004 [P] Parse die vier Designverträge `specs/029-ci-budget-governance/contracts/ci-budget-profile-registry.schema.json`, `specs/029-ci-budget-governance/contracts/ci-budget-path-contracts.schema.json`, `specs/029-ci-budget-governance/contracts/ci-gate-evidence.schema.json` und `specs/029-ci-budget-governance/contracts/ci-inventory-rollout-plan.schema.json` mit `python3 -m json.tool` und protokolliere den erwarteten grünen Struktur-Preflight in `specs/029-ci-budget-governance/checklists/cross-platform.md`.
- [x] T005 Erfasse die exakte Stufe-A-Git-Diff-Allowlist einschließlich `.gitignore`, aller geplanten Level-0-Implementierungs-, Test-, Dokumentations- und Lastenheftpfade in `specs/029-ci-budget-governance/checklists/stage-a-mutation-allowlist.md`; schließe Zielrepositories, aktive `.github/workflows/`, Copilot-/G4-/Account- und Runtime-Evidence-Pfade ausdrücklich aus.
- [x] T006 Prüfe den aktuellen Run-State mit `bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-run-state.sh --state specs/029-ci-budget-governance/autonomous-run-state.json` und protokolliere Run-ID, Branch, `LocalImplementation`, Analyze-Voraussetzung und die bekannte nicht semantische Hashdrift in `specs/029-ci-budget-governance/checklists/stage-a-mutation-allowlist.md`.

**Checkpoint**: Alle späteren Evidence-Pfade sind benannt und Lauf-Evidence ist nachweislich maschinenlokal.

---

## Phase 2: Foundational Contracts (Blocking)

**Purpose / Zweck**: Gemeinsame, fail-closed Vertragsbasis für alle Stories schaffen.

**Critical / Kritisch**: Keine User-Story-Implementierung beginnt vor Abschluss dieser Phase.

- [x] T007 [P] Leite `scripts/config/ci-budget-profiles.schema.json` aus `specs/029-ci-budget-governance/contracts/ci-budget-profile-registry.schema.json` ab und bewahre genau fünf Profile, Self-Record, Assignments, Gate Sets und Budgetannahmen ohne `pathContracts`.
- [x] T008 [P] Leite `scripts/config/ci-budget-path-contracts.schema.json` aus `specs/029-ci-budget-governance/contracts/ci-budget-path-contracts.schema.json` als einzigen installierbaren Laufzeitvertrag für die sechs Pfadkategorien ab.
- [x] T009 [P] Installiere die finalen Verträge für atomare Gate-Evidence und Inventory-/Rolloutpläne in `scripts/config/ci-gate-evidence.schema.json` und `scripts/config/ci-inventory-rollout-plan.schema.json` aus den gleichnamigen Designschemas unter `specs/029-ci-budget-governance/contracts/`.
- [x] T010 Erstelle die kanonische Profilregistry `scripts/config/ci-budget-profiles.json` mit genau fünf Profilen, `home-baseline`-Self-Record, exakt einer Assignment-Zeile je autoritativer Repository-ID, geordneten Argument-Arrays, Gate Sets und Decimal-Budgetannahmen; bette keine Pfadverträge ein.
- [x] T011 Erstelle die alleinige Pfadregistry `scripts/config/ci-budget-path-contracts.json` für `build`, `security`, `governance`, `dependency`, `product` und `documentation` mit geordneten Include-/Exclude-Mustern sowie Gate-/Produktjob-Referenzen.
- [x] T012 [P] Erstelle nach `specs/029-ci-budget-governance/contracts/workflow-ruleset-contract.md` die inaktiven Stufe-A-Simulationsvorlagen `scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml` und `scripts/templates/ci-budget-governance/private-governance-ruleset.json`; lege keine Vorlage unter `.github/workflows/` an.
- [x] T013 Schreibe zuerst rote Vertrags- und Negativtests für unbekannte Gate-/Produktjob-Referenzen, ein zweites `pathContracts`, Schema-Mehrfelder, Traversal, Symlink-Escape, Zeilenumbrüche, NUL, führende Bindestriche und denormalisierte `profileId`-Abweichung in `scripts/tests/test_ci_budget_governance.py` und `scripts/tests/ci-budget-governance/fixtures/contracts/`.
- [x] T014 Implementiere einmaliges Laden und Schema-Validieren beider Registries, dateiübergreifende Referenzprüfung sowie getrennte kanonische `profileRegistryHash`- und `pathContractHash`-Berechnung in `scripts/lib/agentic_workspace_fleet.py`, bis T013 grün ist.
- [x] T015 Implementiere die `ci-gate`- und `ci-budget-plan`-Subcommand-Grenzen, die Exitcodes `0`, `1`, `2`, `130` und die Reservierung von `3` im gemeinsamen Kern `scripts/lib/agentic_workspace_fleet.py`.
- [x] T016 Erstelle den fail-closed Primary-Aggregator `scripts/tests/run_ci_budget_acceptance.py`, der genau einen AC-Scope ausführt oder alle internen Inputs samt normalisiertem SHA-256 validiert und keine `Supplemental`-Zeilen erzeugt.

**Checkpoint**: Schemas, Registries, Referenzen, Hashgrenzen, CLI-Grundvertrag und Acceptance-Aggregator sind ausführbar.

---

## Phase 3: User Story 2 – Private Änderungen sicher lokal prüfen / Gate Private Changes Safely and Locally (Priority: P1) 🎯 MVP

**Goal / Ziel**: Ein repräsentatives privates Fixture läuft durch Wrapper, genau einen Engine-Prozess, zwei harmlose Gates, stabile HEAD-Prüfung und atomare lokale Evidence; Hook und unabhängiger Serververtrag bilden Defense in Depth.

**Independent Test / Unabhängiger Test**: `python3 scripts/tests/test_ci_budget_governance.py VerticalSliceTests HookEvidenceRulesetTests` beweist Erfolg, Vorschau und alle fail-closed Negativfälle ohne Netzwerk- oder Zielrepository-Mutation.

- [x] T017 [US2] Schreibe den repräsentativen roten Vertical-Slice-Test samt festem HEAD, zwei harmlosen Gate-Kommandos, temporärem Home und Engine-Prozesszähler in `scripts/tests/test_ci_budget_governance.py` und `scripts/tests/ci-budget-governance/fixtures/vertical-slice/`; protokolliere den erwarteten Fehlschlag in `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/vertical-slice-red-macos.json`.
- [x] T018 [P] [US2] Ergänze `--ci-gate` und `--dry-run` im dünnen Adapter `scripts/maintain-agentic-workspace.sh`, der validiert und genau einen `scripts/lib/agentic_workspace_fleet.py`-Prozess startet.
- [x] T019 [P] [US2] Ergänze `-CiGate` und `-WhatIf` im dünnen Adapter `scripts/maintain-agentic-workspace.ps1`, bewahre `Invoke-HBAgenticWorkspaceMaintenance`, Strict Mode und die unmittelbare `$LASTEXITCODE`-Weitergabe.
- [x] T020 [US2] Implementiere Repository-ID-Auflösung, doppelte HEAD-Lesung, geordnete Gate-Auswahl und kanonischen Gate-Set-Hash in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T021 [US2] Implementiere in `scripts/lib/agentic_workspace_fleet.py` den sequenziellen Gate-Runner mit validierten Executable-/Argument-Arrays, `shell=False`, Working-Directory-Grenze, Timeout, sanitisierten Diagnosekanälen und kontrolliertem Exitcode `130`.
- [x] T022 [US2] Implementiere sichere Pfadbildung und atomare Erfolgspublikation mit temporärer Datei im Zielverzeichnis, restriktiven Rechten, Flush/Fsync, Schemavalidierung und `os.replace` in `scripts/lib/agentic_workspace_fleet.py`; publiziere ausschließlich `Passed` nach stabilem HEAD und Hash.
- [x] T023 [US2] Erweitere die roten/grünen Negativtests in `scripts/tests/test_ci_budget_governance.py` für `--dry-run`/`-WhatIf`, Gate-Fehler, fehlendes Gate, HEAD-Wechsel, Gate-Set-Wechsel, Signal, Timeout, unsicheren Parent, Symlink, Metazeichen und eine zu entwertende alte Erfolgsdatei.
- [x] T024 [US2] Ergänze die private Profil-, HEAD-, Gate-Set- und Hook-Version-Prüfung unter Erhalt des Secret Scans in `scripts/hooks/pre-push`; fehlende, alte, fehlgeschlagene oder inkonsistente Evidence muss blockieren.
- [x] T025 [US2] Installiere unmittelbar nach T024 serialisiert mit `bash scripts/install-hooks.sh`, vergleiche `scripts/hooks/pre-push` und `.git/hooks/pre-push` byteweise und per SHA-256 und rufe den installierten Hook ohne Push mit sicherem Pass- und Block-Fixture direkt auf; schreibe Befehl, Hashes, Fixture-IDs und Exitcodes nach `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/ac-cbg-007-008-hook-installation-macos.json`.
- [x] T026 [US2] Implementiere die unabhängige Simulation von Pull-Request-Pflicht, exakt `home-baseline/ci-minimal-gate`, gesperrten `direct`/`web`/`api`-Pfaden, `adminBypassNormalPath=false` und `remoteConverged=false` aus `scripts/templates/ci-budget-governance/` in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T027 [US2] Ergänze Hook-Bypass-, Null-/Mehrfachstatus-, zu-breit-, nicht-pfadabhängig-, Full-Build- und Main-Push-Negativfixtures in `scripts/tests/ci-budget-governance/fixtures/workflow-ruleset/` und prüfe sie in `scripts/tests/test_ci_budget_governance.py` fail-closed.
- [x] T028 [US2] Führe den zuvor roten Slice über Bash und PowerShell 7 auf macOS grün aus, belege genau einen Engine-Start, identischen Gate-Set-Hash, Feldreihenfolge und Exitcode sowie keine Restdatei in Fehlerfällen unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/vertical-slice-green-macos.json`.

**Checkpoint**: CBG-010 bis CBG-014, CBG-017 bis CBG-019 sowie AC-CBG-002 und AC-CBG-007 sind im repräsentativen Slice unabhängig beweisbar.

---

## Phase 4: User Story 1 – Flotte eindeutig klassifizieren / Classify the Fleet Unambiguously (Priority: P1)

**Goal / Ziel**: Jede ID der autoritativen Union aus `home-baseline` und 47 aktiven Git-Zielen erhält genau ein sichtbarkeitskompatibles Profil; jede Drift stoppt vor Planung.

**Independent Test / Unabhängiger Test**: `python3 scripts/tests/test_ci_budget_governance.py FleetClassificationTests` prüft das vollständige positive Fixture und alle Mapping-/Sichtbarkeitsfehler offline.

- [x] T029 [P] [US1] Erstelle ein vollständiges 1+47-Inventarfixture sowie fehlende, unbekannte, doppelte, Collection-, Level-0-Duplikat- und sichtbarkeitswidrige Varianten unter `scripts/tests/ci-budget-governance/fixtures/inventory/`.
- [x] T030 [US1] Implementiere die autoritative Repository-Menge aus dem `home-baseline`-Self-Record und aktiven `kind=git-repository`-Zielen aus `scripts/config/agentic-workspace-fleet.json` in `scripts/lib/agentic_workspace_fleet.py`; schließe `spec-kit-preset-projects` und alle Collections aus.
- [x] T031 [US1] Implementiere die exakte Eins-zu-eins-Assignment-, Sichtbarkeits- und Pflicht-Canary-Prüfung (`home-baseline`, `agent-operations-cockpit`, `tui-vision`) sowie Live-Kardinalitäten in `scripts/lib/agentic_workspace_fleet.py`; rate oder reklassifiziere keine ID.
- [x] T032 [US1] Implementiere den `fixture`-Adapter und den ausschließlich `gh api --method GET` nutzenden `github-read-only`-Adapter mit minimierten Datenfeldern und Transport-Spy in `scripts/lib/agentic_workspace_fleet.py` und `scripts/tests/test_ci_budget_governance.py`.
- [x] T033 [US1] Implementiere ein einziges Wurzelpaar `source`/`sourceRevision`, atomare Vollsnapshot-Frische, geordnetes `WorkflowJobInventoryEntry` und erst nach erfolgreicher Assignment-Prüfung kopiertes `profileId` in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T034 [US1] Implementiere höchstens drei injizierbar getestete Retries nur für Timeout, Connection Reset, DNS, 502/503/504 und explizites Rate Limit in `scripts/lib/agentic_workspace_fleet.py`; Auth-, 404-, Schema-, Mapping- und Sichtbarkeitsfehler bleiben ohne Retry fail-closed.
- [x] T035 [US1] Ergänze positive und negative Klassifikations-, Quellenmix-, Partial-Refresh-, Live-Ausfall-, Rate-Limit- und Raw-Data-Minimierungstests in `scripts/tests/test_ci_budget_governance.py`, bis jeder Blocker vor Kosten- oder Rolloutplanung entsteht.

**Checkpoint**: CBG-001, CBG-002 und AC-CBG-001 sind unabhängig prüfbar.

---

## Phase 5: User Story 3 – CI-Auslöser und Kosten rationalisieren / Rationalize CI Triggers and Cost (Priority: P2)

**Goal / Ziel**: Profil-, Pfad-, Workflow- und Zeitplanentscheidungen bleiben sicher, deterministisch und unter dem privaten Budgetziel.

**Independent Test / Unabhängiger Test**: `python3 scripts/tests/test_ci_budget_governance.py WorkflowPathBudgetTests` prüft alle Profile, Pfadklassen, Sonderfälle und getrennten Kostenkategorien.

- [x] T036 [P] [US3] Erstelle Mehrfachtreffer-, reine-Dokumentation-, Build-, Security-, Governance-, Dependency- und Product-Pfadfixtures unter `scripts/tests/ci-budget-governance/fixtures/path-contracts/`.
- [x] T037 [US3] Implementiere normalisierte Pfadauswertung, Include-/Exclude-Schutz, Vereinigungssemantik für Mehrfachtreffer und stabile Gate-/Job-Sortierung aus `scripts/config/ci-budget-path-contracts.json` in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T038 [US3] Implementiere Profilregeln für null Full-PR-/Main-Builds plus höchstens einen Minimal-Gate bei Private Governance und pfadabhängige PR-Prüfung ohne identischen unbegründeten Main-Rebuild bei Private Product in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T039 [P] [US3] Erstelle die sechs SecureCaseTracker-, Swift-Linux/macOS-, private-Release-Please-, Public-Canary-, Public-Product- und zwölf-Public-Preset-Fixtures unter `scripts/tests/ci-budget-governance/fixtures/profile-policies/`.
- [x] T040 [US3] Implementiere die sechs deduplizierten CaseTracker-Produktjobs, Swift-PR auf Linux, wöchentlich/manuellen macOS-Nachweis und ausschließlich wöchentlich/manuelles Private Release Please in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T041 [US3] Bewahre erforderliche öffentliche Standard-Runner-CI und die drei Canaries und plane für Public Presets ausschließlich `FleetPipeline` oder lokale Evidence ohne neue Einzelworkflows in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T042 [US3] Implementiere das Decimal-Kostenmodell mit `52/12`, ungefähr 22 wiederkehrenden privaten Jobs pro Woche, getrennten Bedarfsgates, `<500` von `3000` privaten Monatsminuten und separaten Copilot-Review-Runnerwerten in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T043 [US3] Ergänze fail-closed Tests für fehlende Dauer-/Run-/Copilotwerte, verbotene Nullannahmen, frühe Rundung, doppelte Schedule-/Manual-Zählung und unerklärte Abweichungen in `scripts/tests/test_ci_budget_governance.py`.
- [x] T044 [US3] Ergänze positive und negative Workflow-/Pfad-/Kosten-Simulationstests für CBG-003 bis CBG-009, CBG-015 und CBG-016 in `scripts/tests/test_ci_budget_governance.py`.

**Checkpoint**: AC-CBG-003 bis AC-CBG-005 sowie die Workflow-/Kostenanteile von AC-CBG-002 sind unabhängig prüfbar.

---

## Phase 6: User Story 4 – Rollout ohne Eigenmutation vorbereiten / Prepare Rollout Without Self-Mutation (Priority: P2)

**Goal / Ziel**: Null-, Einzel- und Mehrfachläufe liefern denselben geordneten lokalen Stufe-A-Plan, während jede Remote- oder Zielmutation technisch blockiert bleibt.

**Independent Test / Unabhängiger Test**: `python3 scripts/tests/test_ci_budget_governance.py RolloutDeterminismMutationTests` beweist geordnete Pläne, identische Hashes/Exitcodes und null schreibende Operationen.

- [x] T045 [P] [US4] Erstelle Null-, Einzel-, Mehrfach- und vollständige 48-Repository-Rolloutfixtures mit fester Uhr unter `scripts/tests/ci-budget-governance/fixtures/rollout/`.
- [x] T046 [US4] Implementiere geordnete `RolloutPlanEntry`-Werte mit `profileId`, `plannedDiff`, `gateDecision`, `blockers`, DE-first/EN-second `nextAction` und konstantem `remoteConverged=false` in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T047 [US4] Implementiere `InventoryRolloutPlan` mit `stage="A"`, `deliveryMode="LocalImplementation"`, `mutationsPerformed=false`, identischen Inventory-/Rollout-ID-Mengen und getrennten Inventory-/Profil-/Pfadhashes in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T048 [US4] Implementiere den Mutation-Spy, der POST/PUT/PATCH/DELETE, aktive Ruleset-/Account-/Reviewer-/G4-Pfade, Zielrepository-Dateizugriffe, Commit, Push, Merge und Home-Sync in `scripts/tests/test_ci_budget_governance.py` sofort fehlschlagen lässt.
- [x] T049 [US4] Implementiere und teste genau einen Engine-Prozess, keine Eigenmutation des Wartungswerkzeugs und keine Ausgabe, die Stufe-A-Evidence als Remote-Konvergenz bezeichnet, in `scripts/maintain-agentic-workspace.sh`, `scripts/maintain-agentic-workspace.ps1` und `scripts/tests/test_agentic_workspace_maintenance.py`.
- [x] T050 [US4] Prüfe den tatsächlichen Arbeitsbaum gegen `specs/029-ci-budget-governance/checklists/stage-a-mutation-allowlist.md` und erfasse jeden nicht erlaubten Pfad als Hard Stop in `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/stage-a-diff-allowlist.json`.
- [x] T051 [US4] Dokumentiere die nicht ausgeführte, neu zu autorisierende Stufe-B-Konvergenz und den ebenfalls nicht gestarteten G4-Nachfolger als Handoff mit Owner, Blocker und Revalidierungs-Trigger in `docs/architecture/ci-budget-governance.md`; führe keine Handoff-Aktion aus.
- [x] T052 [US4] Ergänze bytegleich normalisierte Wiederholungstests für Null/eins/mehrere, Timestamp-Ausschluss, stabile Reihenfolge, identische Exitcodes, Quellenmix und `profileId`-Drift in `scripts/tests/test_ci_budget_governance.py`.

**Checkpoint**: CBG-019, CBG-021 sowie AC-CBG-006, AC-CBG-009 und AC-CBG-010 sind unabhängig prüfbar.

---

## Phase 7: User Story 5 – Plattformgleich und barrierearm arbeiten / Work with Platform Parity and Accessibility (Priority: P2)

**Goal / Ziel**: Bash und PowerShell liefern unter macOS/Linux/Windows dieselbe fachliche Aussage; CLI, Hilfe und Dokumentation bleiben text-first und ohne Farbe verständlich.

**Independent Test / Unabhängiger Test**: Gemeinsame Fixtures plus je ein realer Bash- und PowerShell-7-Lauf auf macOS ergeben identische normalisierte Profile, Entscheidungen, Evidence-Felder und Exitcodes, ohne nicht ausgeführte Linux-/Windows-Runner zu behaupten.

- [x] T053 [US5] Vereinheitliche die lineare Ausgabe `Profil / Profile -> Entscheidung / Decision -> Status -> Blocker -> Naechste Aktion / Next action` einschließlich Gate-Set-Hash, Einzelschritten und Evidence-Ziel in `scripts/lib/agentic_workspace_fleet.py`.
- [x] T054 [US5] Stelle sicher, dass `--dry-run` in `scripts/maintain-agentic-workspace.sh` und `-WhatIf` in `scripts/maintain-agentic-workspace.ps1` denselben Engine-Einstieg nutzen, Exitcode `0` liefern und weder Evidence noch Repository/Home verändern.
- [x] T055 [P] [US5] Erstelle gemeinsame macOS-/Linux-/Windows-Normalisierungs-, Leerzeichen-, führende-Bindestrich-, Metazeichen- und Unicode-Textfixtures unter `scripts/tests/ci-budget-governance/fixtures/platform-parity/`.
- [x] T056 [US5] Ergänze feldweise Bash-/PowerShell-Parität, Bash-3.2-Kompatibilität, Windows-`HOME`-Grenze, unmittelbare `$LASTEXITCODE`-Prüfung und Exitcode-Parität in `scripts/tests/test_ci_budget_governance.py`, `scripts/tests/test_agentic_workspace_maintenance.py` und `scripts/tests/test_maintenance_contracts.py`.
- [x] T057 [US5] Aktualisiere `docs/man/maintain-agentic-workspace.1.md` für `--ci-gate`, Vorschau, Exitcodes, Evidence, Fehler und Stufe-A-Grenze sowie die vollständige DE-first/EN-second Comment-based Help in `scripts/maintain-agentic-workspace.ps1` für `-CiGate`/`-WhatIf` und `Invoke-HBAgenticWorkspaceMaintenance`.
- [x] T058 [US5] Aktualisiere `docs/man/install-hooks.1.md` mit dem verpflichtenden Reinstallations-, Hash- und direkten Pass-/Block-Prüfpfad ohne `git push`.
- [x] T059 [US5] Fülle `specs/029-ci-budget-governance/checklists/cross-platform.md` mit `Applicable`, macOS-Bash-, macOS-PowerShell-, semantischer Linux-/Windows-Fixture-Evidence, `--dry-run`/`-WhatIf`, Cmdlet-, Manpage-, Hilfe-, Quoting-/Strict-Mode- und Re-Evaluation-Nachweis.
- [x] T060 [US5] Dokumentiere WCAG-2.2-AA-Anwendbarkeit, Screenreader/Braille/Textbrowser, Bedienung ohne Farbe, CEFR B2, DE-first/EN-second, Fachbegriffserklärung, Codeblock-Sprachtags, Textalternativen und didaktische Kommentarprüfung in `docs/accessibility/ci-budget-governance.md`.
- [x] T061 [US5] Führe Bash-Syntax und den realen macOS-Bash-Previewpfad aus und schreibe wahrheitsgemäß nur den Token `macOS` nach `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/manual-bash-macos.json`.
- [x] T062 [US5] Führe PowerShell 7, PSScriptAnalyzer und den realen macOS-PowerShell-Previewpfad mit sofortiger `$LASTEXITCODE`-Prüfung aus und schreibe wahrheitsgemäß nur den Token `macOS` nach `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/manual-powershell-macos.json`.

**Checkpoint**: CBG-017 und der Plattform-/A11Y-Scope von AC-CBG-008 sind unabhängig prüfbar.

---

## Phase 8: User Story 6 – Dokumentation und Verbrauch nachvollziehen / Understand Documentation and Consumption (Priority: P3)

**Goal / Ziel**: Bedienung, Architektur, Sicherheit, A11Y, Kosten, Distribution, Re-Evaluation und Stufe-B-Handoff sind auditierbar, bilingual und navigierbar.

**Independent Test / Unabhängiger Test**: Documentation-Impact-, A11Y-, Link-, Agent-Parity-, Security- und Statistikvalidatoren laufen lokal grün; Actions-Minuten und Copilot-Verbrauch bleiben getrennt.

- [x] T063 [US6] Aktualisiere die Progressive-Disclosure-Navigation und den DE-first/EN-second Betriebsweg für Profile, Gate, Evidence, Fehler, Kosten und sichere Vorschau in `README.md` und `docs/scripts/reference.md`.
- [x] T064 [US6] Vervollständige Kontext-, Baustein-, Laufzeit-, Deployment-/Stufensicht, Qualitätsszenarien, Risiken und technische Schuld in `docs/architecture/ci-budget-governance.md` und führe den finalen iSAQB-/arc42-Architekturreview dort aus.
- [x] T065 [US6] Dokumentiere die Defense-in-Depth-Entscheidung zwischen lokaler Evidence/Hook und unabhängigem Server-Minimal-Gate als S-ADR in `docs/security/adr/ADR-002-ci-gate-defense-in-depth.md`.
- [x] T066 [US6] Aktualisiere STRIDE+CIA, relevante CAPEC-Pfade, Trust Boundaries, Datenklassen, Least Privilege, Fail-Safe Defaults, Attack Surface Reduction und Separation of Concerns in `docs/security/threat-model.md`, `docs/security/arc42-security.md` und `docs/security/security-quality-scenarios.md`.
- [x] T067 [US6] Aktualisiere NIST-SSDF-/CWE-Top-25-, sichere Bash-/PowerShell-/Python-I/O-, Secret-, Crypto-, Fehler-/Logging- und Mutationsbarrieren in `docs/security/security-checklist.md` und begründe die bestehende Bash-Nicht-MSL-Oberfläche bei unveränderter Runtime.
- [x] T068 [US6] Aktualisiere Dependency-, SBOM-, VEX-, SLSA-/Provenance- und OpenSSF-Scorecard-Evidence ohne neue Abhängigkeit in `docs/security/dependency-audit.md` und `docs/security/supply-chain-evidence.md`; erfasse AI-SBOM als `N/A`, weil KI nur Entwicklungswerkzeug ist.
- [x] T069 [US6] Aktualisiere Zero-Trust- und OWASP-SAMM-Dispositionen in `docs/security/zero-trust-applicability.md` und `docs/security/samm-assessment.md` für den langlebigen Level-0-Workspace.
- [x] T070 [US6] Erfasse OWASP ASVS, BSI C3A, BSI C5 sowie NIS2/CRA/EU AI Act/DORA mit `N/A`, Begründung, Owner, Reviewer und Re-Evaluation-Trigger in `docs/security/asvs-verification.md`, `docs/security/cloud-autonomy-applicability.md`, `docs/security/cloud-compliance-assurance.md` und `docs/security/regulatory-applicability.md`.
- [x] T071 [US6] Vervollständige genau eine Feature-weite `UpdateRequired`-Entscheidung mit Zielgruppen/Leserpfaden, Quelle/Owner, Navigation, Dokumentklasse, Sprachpartnern, Plattformbeleg, Distribution (`sourceOnly`/`homeRuntime`/`machineLocal`), `homeSyncRequired=false`, Evidence und Re-Evaluation in `specs/029-ci-budget-governance/documentation-impact-evidence.json` und validiere sie mit `bash scripts/validate-documentation-impact.sh --evidence specs/029-ci-budget-governance/documentation-impact-evidence.json`.
- [x] T072 [US6] Prüfe die fünf Agentenflächen `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `.github/agents/copilot-instructions.md` sowie `constitution.md`, `.specify/memory/constitution.md` und `.specify/templates/` auf Shared-Guidance-Drift; dokumentiere `NoUpdateRequired` im Evidence-Record, solange keine gemeinsame Regel geändert wurde, andernfalls aktualisiere alle Flächen atomar.
- [x] T073 [US6] Führe `python3 scripts/tests/test_spec_kit_agent_surface_parity.py` aus und binde Ergebnis, Reviewer, Restrisiko und Re-Evaluation in `specs/029-ci-budget-governance/documentation-impact-evidence.json`.
- [x] T074 [US6] Aktualisiere ausschließlich die kanonischen Feature-/Ledgerwerte in `docs/project-statistics.config.json` nach abgeschlossener Implementierung.
- [x] T075 [US6] Rendere danach serialisiert mit `bash scripts/render-project-statistics.sh --repo .` den Profil-2-Block in `docs/project-statistics.md` und verifiziere ihn mit `bash scripts/render-project-statistics.sh --repo . --check-only` sowie `pwsh -NoProfile -File scripts/test-render-project-statistics.ps1`.

**Checkpoint**: CBG-016, CBG-020 und der Dokumentations-/Statistikanteil von AC-CBG-004, AC-CBG-005 und AC-CBG-008 sind unabhängig prüfbar.

---

## Phase 9: Polish, Acceptance Gates and Local Closeout

**Purpose / Zweck**: Gesamte Stufe A gegen alle 21 Anforderungen, zehn ACs, Governance-Gates und die lokale Authority-Grenze abschließend prüfen.

- [x] T076 Führe `python3 scripts/tests/test_ci_budget_governance.py`, `python3 scripts/tests/test_agentic_workspace_maintenance.py` und `python3 scripts/tests/test_maintenance_contracts.py` aus und speichere die vollständigen Exitcodes als interne Inputs unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/regression-macos.json`.
- [x] T077 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-001 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-001.json`.
- [x] T078 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-002 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-002.json`.
- [x] T079 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-003 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-003.json`.
- [x] T080 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-004 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-004.json`.
- [x] T081 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-005 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-005.json`.
- [x] T082 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-006 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-006.json`.
- [x] T083 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-007 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus, validiere den internen Hook-Installationsrecord fail-closed und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-007.json`.
- [x] T084 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-008 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus, validiere Bash/PowerShell/PSScriptAnalyzer/Parität/Secret/A11Y/Doku/Workflow/Statistik und beide manuellen macOS-Inputs fail-closed und schreibe genau eine `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-008.json`.
- [x] T085 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-009 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus, validiere Mutation-Spy und exakte Stufe-A-Diff-Allowlist und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-009.json`.
- [x] T086 Führe `python3 scripts/tests/run_ci_budget_acceptance.py --gate AC-CBG-010 --repository-root . --evidence-root .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence` aus, validiere Fixture-Vollständigkeit plus getrennten read-only Live-Inventurnachweis und schreibe genau eine hashgebundene `Primary`-Zeile mit `runnerOrPlatform="macOS"` unter `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/primary/AC-CBG-010.json`.
- [x] T087 Aggregiere exakt zehn aktuelle `Primary`- und null `Supplemental`-Zeilen, die vollständigen ausgeführten Befehle, internen Input-Hashes und nur wahrheitsgemäße `macOS`-Tokens in `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/final-gate-evidence.json`; binde unmittelbar davor `head=$(git rev-parse HEAD)` und validiere mit `bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-gate-evidence.sh --requirements specs/029-ci-budget-governance/autonomous-run-gate-requirements.json --evidence .specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/final-gate-evidence.json --head "$head"`.
- [x] T088 Führe `bash scripts/scan-agent-secrets.sh --fail-on-high .` aus und binde den grünen Exitcode ohne sensible Ausgabe in `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/security-final-macos.json`.
- [x] T089 Prüfe `scripts/hooks/pre-push`, `scripts/scan-agent-secrets.*`, sichere Argument-Arrays, `eval`/`Invoke-Expression`-Verbote, Dependency-/Supply-Chain-Dispositionen und die Defense-in-Depth-Grenze abschließend gegen `docs/security/security-checklist.md`.
- [x] T090 Prüfe alle Aufgaben und Evidence gegen CBG-001 bis CBG-021 und AC-CBG-001 bis AC-CBG-010 und schließe `security-governance`, `architecture-governance`, `isaqb-architecture-governance`, `a11y-governance`, `cross-platform-governance`, `agent-parity-governance`, `model-routing-governance`, `intake-authoring-governance`, `intake-review-governance`, `intake-sequencing-governance`, `autonomous-run-governance` und `parallel-autonomous-run-governance` als `Applicable` oder begründetes `N/A` mit Implementation-Status, Owner, Reviewer, Evidence, Restrisiko, Follow-up und Re-Evaluation in `specs/029-ci-budget-governance/checklists/implementation-governance.md`; `Open` blockiert den Abschluss.
- [x] T091 Führe einen lokalen Exact-Candidate-Check ohne Commit oder Push mit temporärem Index, `git diff --cached --check`, Statusabgleich und `specs/029-ci-budget-governance/checklists/stage-a-mutation-allowlist.md` aus, stelle den ursprünglichen Index wieder her und dokumentiere das Ergebnis in `.specify/runtime/autonomous-routing/eca02c0f-5399-49c0-8de4-b21233834254/acceptance-evidence/internal/exact-candidate-local.json`.
- [x] T092 Führe die Implementierungs-Quickstart-Schritte unter `specs/029-ci-budget-governance/quickstart.md` aus, bestätige null Remote-/Home-/Zielmutation und aktualisiere nur nach tatsächlichem Erfolg die Evidence-Verweise in `specs/029-ci-budget-governance/checklists/implementation-governance.md`.
- [x] T093 Benenne als letzten lokalen Feature-Abschlussschritt das Lastenheft mit `bash scripts/rename-lastenheft.sh Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md 029-ci-budget-governance` um; führe weiterhin keinen Commit, Push, Merge, Home-Sync, Stufe-B-Rollout oder G4-Start aus.

---

## Dependencies & Execution Order / Abhängigkeiten und Reihenfolge

### Phase Dependencies / Phasenabhängigkeiten

1. Die externe Analyze-Phase muss vor T001 bestanden sein.
2. Phase 1 schafft alle Evidence-Ziele und blockiert Runtime-Codeänderungen bis T001–T006 abgeschlossen sind.
3. Phase 2 ist die gemeinsame Vertragsbasis und blockiert alle User Stories.
4. US2 kommt trotz gleicher P1-Priorität vor US1, weil der akzeptierte Plan den repräsentativen Vertical Slice vor Fleet-Breite verlangt.
5. US1 folgt US2 und liefert die klassifizierte Inventarbasis für US3 und US4.
6. US3 und US4 dürfen nach US1 fachlich parallel vorbereitet werden; gemeinsame Writer in `scripts/lib/agentic_workspace_fleet.py` werden dennoch seriell integriert.
7. US5 nutzt die fertigen Wrapper-/Engine-Verträge; US6 folgt nach stabilen Nutzeroberflächen.
8. Phase 9 beginnt erst nach allen sechs Story-Checkpoints und bleibt vollständig lokal/read-only.

### User Story Dependency Graph / Story-Abhängigkeitsgraph

```text
Foundational -> US2 (P1 Vertical Slice) -> US1 (P1 Fleet Classification)
                                      \-> US3 (P2 Workflow/Cost) --\
                                       \> US4 (P2 Rollout/Barrier) -+-> US5 (P2 Parity/A11Y)
                                                                    \-> US6 (P3 Docs/Evidence)
                                                                         -> Final Acceptance
```

Textalternative: Der lokale Gate-Slice beweist zuerst den sicherheitskritischen Pfad. Danach klassifiziert US1 die Flotte. US3 und US4 bauen auf dieser Klassifikation auf. US5 vereinheitlicht die fertigen Oberflächen, US6 dokumentiert sie, und erst danach laufen alle zehn Acceptance-Gates.

### Serialized Shared Writers / Serialisierte gemeinsame Writer

- `scripts/lib/agentic_workspace_fleet.py`: T014–T015, T020–T022, T026, T030–T034, T037–T042, T046–T047, T053 werden in Task-ID-Reihenfolge integriert.
- `scripts/hooks/pre-push` und `.git/hooks/pre-push`: T024 unmittelbar gefolgt von T025; kein paralleler Hook-/Installer-Writer.
- `specs/029-ci-budget-governance/documentation-impact-evidence.json`: T071–T073 seriell.
- Agenten-/Constitution-/Template-Flächen: ausschließlich die bedingte atomare Entscheidung in T072.
- `docs/project-statistics.config.json` und `docs/project-statistics.md`: T074 unmittelbar gefolgt von T075.
- Final-Gate-Evidence: T077–T087 seriell, damit kein Shared-Writer oder Hashinput konkurriert.
- Lastenheft: T093 ist zwingend die letzte lokale Dateioperation.

---

## Parallel Execution Examples / Beispiele für Parallelisierung

### US1

Nach Abschluss von T014–T016 kann T029 unabhängig vorbereitet werden; T030–T035 bleiben wegen des gemeinsamen Engine-Writers seriell.

### US2

Nach dem roten T017 können T018 und T019 parallel in getrennten Wrapperdateien entstehen. T020–T028 bleiben wegen Engine-, Hook- und Evidence-Abhängigkeiten seriell.

### US3

T036 und T039 können parallel ihre getrennten Fixture-Bäume erstellen. Die gemeinsame Engine-Integration T037–T044 bleibt seriell.

### US4

T045 kann parallel zu einer reinen Review-Vorbereitung von T051 erfolgen; die Runtime- und Mutation-Barrier-Tasks T046–T050 und T052 bleiben seriell.

### US5

T055 kann parallel zur Text-/Output-Analyse vorbereitet werden. Manuelle Evidence-Writer T061 und T062 werden trotz getrennter Dateien nacheinander ausgeführt, damit die Plattformprotokolle eindeutig bleiben.

### US6

Security-, Architektur-, A11Y-, Documentation-Impact-, Agent-Parity- und Statistikdateien sind gemeinsame Governance-Nachweise und werden bewusst nicht mit `[P]` markiert.

---

## Implementation Strategy / Implementierungsstrategie

### MVP First

1. Analyze-Gate bestehen.
2. Phase 1 und Phase 2 abschließen.
3. US2 als repräsentativen roten/grünen Vertical Slice abschließen.
4. Anhalten und `VerticalSliceTests` sowie `HookEvidenceRulesetTests` unabhängig prüfen.
5. Erst danach Flottenklassifikation und Wiederholung in der Breite beginnen.

### Incremental Delivery

1. Verträge und Evidence-Pfade.
2. Lokaler Gate-/Hook-/Serververtrags-Slice.
3. Exakte Flottenklassifikation.
4. Workflow-, Pfad- und Kostenrationalisierung.
5. Deterministische Stufe-A-Rolloutplanung ohne Mutation.
6. Plattform-/A11Y-Parität.
7. Architektur-, Security-, Betriebs-, Statistik- und Governance-Evidence.
8. Zehn Primary-Acceptance-Gates, lokale Candidate-Prüfung, Quickstart und Lastenheft-Rename.

---

## Traceability / Rückverfolgbarkeit

| Vertrag | Primäre Tasks |
|---|---|
| CBG-001–002 | T029–T035 |
| CBG-003–004 | T026–T027, T038, T078 |
| CBG-005–009 | T039–T041, T079 |
| CBG-010, CBG-011, CBG-012, CBG-013, CBG-014 | T017–T025, T083 |
| CBG-015–016 | T036–T044, T063 |
| CBG-017 | T018–T019, T028, T053–T062, T084 |
| CBG-018–019 | T024–T027, T048–T050, T085 |
| CBG-020 | T057–T060, T063–T075 |
| CBG-021 | T045–T052, T085–T093 |
| AC-CBG-001 | T029–T035, T077 |
| AC-CBG-002 | T026–T027, T038, T078 |
| AC-CBG-003 | T039–T040, T079 |
| AC-CBG-004–005 | T042–T043, T080–T081 |
| AC-CBG-006 | T045–T047, T052, T082 |
| AC-CBG-007 | T023–T027, T083 |
| AC-CBG-008 | T053–T075, T084 |
| AC-CBG-009 | T048–T050, T085 |
| AC-CBG-010 | T045–T052, T086 |

## Completion Conditions / Abschlussbedingungen

- Alle 93 Task-Zeilen bleiben bis zur tatsächlichen Ausführung ungekreuzt.
- Jede Story besitzt einen unabhängigen Test und einen klaren Checkpoint.
- Alle zehn ACs besitzen genau einen tatsächlich ausgeführten Primary-Aggregator mit `runnerOrPlatform="macOS"`; keine Supplemental-Zeile ist zulässig.
- `implementation-governance.md` enthält keinen `Open`-Eintrag und keinen still ausgelassenen Governance-Checkpoint.
- Stufe A behauptet für null Zielrepositories Remote-Konvergenz und führt keine ausgeschlossene Operation aus.
- T093 bleibt der letzte lokale Feature-Abschlussschritt.
