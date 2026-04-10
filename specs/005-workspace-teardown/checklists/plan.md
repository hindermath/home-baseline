# Plan Quality Checklist: Workspace- und Projekt-Teardown

**Purpose**: Validate completeness, clarity, consistency and constitution compliance of plan.md — for both author self-review and PR peer review. Each item includes a Durchführungshinweis (how to evaluate the item).
**Created**: 2026-04-10
**Feature**: [plan.md](../plan.md) | [spec.md](../spec.md)
**Audience**: Author (vor `/speckit.tasks`) + Reviewer (PR)
**Scope**: plan.md intern · plan↔spec alignment · Constitution Principles I–V

---

## Requirement Completeness — Plan ↔ Spec Alignment

- [x] CHK001 — ✓ Alle 16 FRs sind in `plan.md` fachlich abgebildet; einzelne Anforderungen liegen in gleichwertigen Design-Sektionen statt ausschließlich in den P1–P4-Schritten. [Completeness, Spec §FR-001–016]
  > **Durchführungshinweis**: Liste alle FRs aus `spec.md` auf und suche für jede eine fachliche Abbildung im Plan. Schnell-Scan: `rg -o 'FR-[0-9]+' ../spec.md ../plan.md | sort -u`. Wichtig: Nicht nur nach FR-Tokens suchen, sondern prüfen, ob die Anforderung in einem Implementierungsschritt oder einer gleichwertigen Design-Sektion konkretisiert ist.

- [x] CHK002 — ✓ `plan.md` deckt jetzt alle 6 Success Criteria als explizite oder klar benannte Planungsziele ab, einschließlich SC-006 über Constraints und Verification Notes. [Completeness, Spec §SC-001–006]
  > **Durchführungshinweis**: Lies `Performance Goals`, `Constraints`, `Constitution Check`, `Implementation Order` und `Exit Code Table` in `plan.md`. Prüfe alle sechs Success Criteria, nicht nur SC-001/002/004: SC-003 (Artefakt-Bereinigung), SC-005 (Parität) und SC-006 (keine Regressionen) müssen ebenfalls einen Ableitungspfad haben.

- [x] CHK003 — ✓ P1 bis P4 sind in `plan.md` als Step 1 bis Step 4 explizit entlang der User-Story-Priorität abgebildet. [Completeness, Spec §User Stories]
  > **Durchführungshinweis**: Lies Abschnitt `Implementation Order (P1 → P4)` und prüfe, ob Story 1 (Core), Story 2 (Backup + Remote), Story 3 (Recursive), Story 4 (Alias) je einem benannten Step entsprechen.

- [x] CHK004 — ✓ Alle 8 Edge Cases aus `spec.md` sind in Plan, Research oder den abgeleiteten Designartefakten adressiert, inkl. "kein Remote" und " `~/` kein Git-Repository". [Coverage, Spec §Edge Cases]
  > **Durchführungshinweis**: Lies `spec.md` §Edge Cases und prüfe je einen Punkt gegen `research.md` (R-001 bis R-009), `plan.md` §Implementation Order und bei Bedarf `data-model.md` / `contracts/cli.md`. Besonders: tar-Fallback → R-007; dry-run auf fehlendem Workspace → Exit-Code-Tabelle; "kein Remote" braucht einen expliziten Skip-Pfad.

- [x] CHK005 — ✓ FR-015 (`home-baseline`, Exit 2) und FR-016 (bilinguale Ausgaben) sind beide in `Step 1 — Core teardown skeleton` konkret genannt. [Completeness, Spec §FR-015, FR-016]
  > **Durchführungshinweis**: `rg -n 'FR-015|FR-016|home-baseline|bilingual|bilingu' ../plan.md`. Beide müssen in `Step 1 — Core teardown skeleton` enthalten sein.

---

## Requirement Clarity — Eindeutigkeit der Plan-Anforderungen

- [x] CHK006 — ✓ Die 5-Schritt-Reihenfolge aus FR-004 ist nun im Plan eindeutig dokumentiert, einschließlich des Gate-Verhaltens nach einem fehlgeschlagenen Remote-Delete. [Clarity, Spec §FR-004]
  > **Durchführungshinweis**: Unterscheide zwischen Implementierungs-Schritten (`Step 1` bis `Step 4` im Plan) und Laufzeit-Schritten des Teardowns. Prüfe über `Summary`, `Implementation Order`, `Exit Code Table` und `data-model.md`, ob die Laufzeitfolge `Backup → Checks → Remote → Lokal → Artefakte` eindeutig rekonstruierbar ist und ob "Scheitert Schritt 3, bleiben Schritte 4 und 5 aus" explizit formuliert wird.

- [x] CHK007 — ✓ Die Exit-Code-Tabelle ist nun vollständig und sprachlich sauber zwischen Warning/Partial und Safe Abort getrennt. [Clarity, Spec §FR-002, §Edge Cases]
  > **Durchführungshinweis**: Lies `plan.md` §Exit Code Table. Prüfe: Exit 2 für `home-baseline` + nicht vorhandenen Workspace + dry-run auf fehlendem Workspace; Exit 1 für Safety-Check-Fehler + Remote-Fehler + tar-Fehler. Vergleiche gegen `contracts/cli.md` §Exit Codes und §Behavioral Invariants.

- [x] CHK008 — ✓ Das `--force`-Propagationsverhalten ist in `Step 3` klar als konkretes Verhalten beschrieben (`--force` propagates to all Level-2). [Clarity, Spec §FR-010 (clarified)]
  > **Durchführungshinweis**: `rg -n 'force|Force|propagiert|propagate' ../plan.md`. Prüfe, ob "propagiert zu allen Level-2-Projekten" oder ähnliche Formulierung in `Step 3` vorkommt, nicht nur in der Parameter-Liste.

- [x] CHK009 — ✓ Commit-Scope ist hinreichend klar: `plan.md` nennt die getrackten Dateien, `research.md` stellt explizit klar, dass `.gitconfig` und `.inc` nicht committed werden. [Clarity, Spec §FR-006 (clarified), research.md §R-009]
  > **Durchführungshinweis**: Lies `plan.md` §Artifact Commit Message und `research.md` §R-009. Prüfe, ob explizit steht, dass `.gitconfig` und `.inc`-Datei NICHT committed werden. Fehlende Klarheit hier führt zu falschen Implementierungen.

- [x] CHK010 — ✓ "Atomarer Commit" ist messbar definiert: ein Commit, Inhalt explizit auf README.md + .gitignore begrenzt, Message-Format vorhanden. [Clarity, Spec §FR-006 (clarified)]
  > **Durchführungshinweis**: Lies `plan.md` §Artifact Commit Message und §Step 1 (Artifact cleanup). Prüfe, ob der Inhalt des Commits explizit aufgelistet ist (README.md + .gitignore) und ob das Commit-Message-Format angegeben ist.

- [x] CHK011 — ✓ Die Backup-Kollisionsstrategie ist in `research.md` jetzt plattformkonsistent spezifiziert, inklusive Bash- und PowerShell-Variante. [Clarity, Spec §Edge Cases, research.md §R-007]
  > **Durchführungshinweis**: Lies `research.md` §R-007. Prüfe, ob ein konkretes Bash-Pattern und eine PowerShell-Variante dokumentiert sind und ob die Entscheidung für den numerischen Suffix explizit begründet wird.

---

## Requirement Consistency — Interne und cross-file Widerspruchsfreiheit

- [x] CHK012 — ✓ Die 5-Schritt-Reihenfolge aus FR-004 ist konsistent im Plan verankert; die Laufzeitliste ist explizit beschrieben und widerspricht der P1/P2-Struktur nicht mehr. [Consistency, Spec §FR-004]
  > **Durchführungshinweis**: Lies `spec.md` §FR-004 und `plan.md` parallel. Nummeriere die Laufzeit-Schritte aus FR-004 und prüfe, ob sie im Plan explizit in derselben Reihenfolge dokumentiert sind. Eine bloße Verteilung auf P1/P2 reicht für diesen Check nicht.

- [x] CHK013 — ✓ Die Behavioral Invariants in `contracts/cli.md` stimmen jetzt mit Spec und Plan überein, einschließlich des geklärten Remote-Failure-Pfads. [Consistency, Spec §FR-002, FR-004, FR-011]
  > **Durchführungshinweis**: Lies `contracts/cli.md` §Behavioral Invariants. Vergleiche Punkt 2 (`--force`) mit `spec.md` §FR-002-Klärung; Punkt 3 (Remote-Failure) mit `spec.md` §FR-004 und User Story 2 / Szenario 4; Punkt 8 (konsolidierter Prompt) mit `spec.md` §FR-011-Klärung.

- [x] CHK014 — ✓ Das Commit-Message-Format in `plan.md` ist Constitution-konform, inklusive verpflichtendem `Co-authored-by`-Trailer. [Consistency, Constitution §Commit & PR Standards]
  > **Durchführungshinweis**: Lies Constitution §Commit & PR Standards: Format ist `chore:`, `docs:`, `feat:`, `fix:` + Betreff. Prüfe, ob `chore: teardown <WorkspaceName> — ...` diesem Format entspricht und ob der `Co-authored-by`-Trailer im Plan erwähnt ist.

- [x] CHK015 — ✓ `plan.md` referenziert jetzt explizit die bestehende `normalize_name()`-/`ConvertTo-NormalizedName`-Logik aus den Bootstrap-Skripten. [Consistency, Spec §Key Entities, research.md §R-003 from 003-git-config-scope]
  > **Durchführungshinweis**: `rg -n 'normalize' ../plan.md ../research.md ../../scripts/bootstrap-workspace.sh ../../scripts/bootstrap-workspace.ps1`. Prüfe, ob `plan.md` explizit auf die bestehende Funktion aus `bootstrap-workspace.sh` verweist. Abweichende Normalisierung würde `.inc`-Dateinamen-Mismatch erzeugen.

- [x] CHK016 — ✓ Preamble-Box und `ArtifactSet` sind konsistent; alle 4 Artefakte sind in `contracts/cli.md` und `data-model.md` aufgeführt. [Consistency, Spec §FR-011]
  > **Durchführungshinweis**: Lies `contracts/cli.md` §Preamble Box und `data-model.md` §ArtifactSet. Prüfe, ob alle 4 Artefakte (README, .gitignore, .gitconfig-Block, .inc-Datei) in der Preamble-Box-Vorlage aufgeführt sind.

---

## Scenario Coverage — Vollständigkeit der abgedeckten Szenarien

- [x] CHK017 — ✓ Der geklärte Fehlerpfad für ein nicht erreichbares Remote ist explizit im Plan beschrieben: ohne `--keep-remote` Abbruch, mit gesetztem `--keep-remote` bewusster Skip. [Coverage, Spec §User Story 2, Szenario 4]
  > **Durchführungshinweis**: Lies `plan.md` §Step 2 und `contracts/cli.md` §Behavioral Invariants Punkt 3. Prüfe, ob der geklärte Pfad "Delete-Versuch schlägt fehl → Warnung + Abort" und der bewusste Skip-Pfad via `--keep-remote` beide explizit erscheinen.

- [x] CHK018 — ✓ Der GitLab-Pfad ist explizit beschrieben: `glab` ist optional, fehlendes `glab` führt laut Plan/Research zu Warnung statt Abbruch. [Coverage, Spec §FR-005, §Assumptions]
  > **Durchführungshinweis**: Lies `plan.md` §Step 2 und `research.md` §R-003. Prüfe, ob "glab nicht vorhanden → Warnung + Teardown weiter ohne Remote-Löschen" als benannter Pfad im Plan oder Research vorkommt.

- [x] CHK019 — ✓ Die Auswirkungen von `--dry-run` / `-WhatIf` sind in `plan.md` jetzt über die gesamte Laufzeitkette explizit beschrieben, einschließlich des ausbleibenden Artefakt-Commits. [Coverage, Spec §FR-012, SC-001]
  > **Durchführungshinweis**: `rg -n 'dry-run|dry_run|WhatIf' ../plan.md ../contracts/cli.md ../quickstart.md`. Prüfe, ob "kein Schreibzugriff auf Dateisystem" als Invariante im Plan steht. Gemeint ist auch der Artefakt-Commit (Quickstart Schritt 8 / Laufzeit Step 5): Er muss bei `--dry-run` explizit ausbleiben.

- [x] CHK020 — ✓ `plan.md` §Step 3 deckt jetzt explizit ab, dass Level-2-Projekte keinen eigenen Artefakt-Commit auslösen. [Coverage, Spec §FR-010, data-model.md §State Transitions]
  > **Durchführungshinweis**: Lies `plan.md` §Step 3 und `data-model.md` §State Transitions (`--recursive` pre-processing). Prüfe, ob klar ist, dass der Artefakt-Commit nur einmal für den Workspace ausgeführt wird — nicht pro Level-2-Projekt.

- [x] CHK021 — ✓ Die konsolidierte Einmal-Bestätigung für Level-2 + Workspace ist in `plan.md` explizit beschrieben. [Coverage, Spec §FR-011 (clarified)]
  > **Durchführungshinweis**: `rg -n 'recursive|Recursive|Level-2|konsolidiert|consolidated' ../plan.md`. Prüfe, ob "eine konsolidierte Bestätigung" als Formulierung im Plan erscheint — nicht nur "Preamble-Box mit allen Aktionen".

---

## Constitution Compliance — Principles I–V

- [x] CHK022 — ✓ Sicherheitsüberlegungen für die destruktiven Operationen sind im Plan dokumentiert: `home-baseline`-Schutz, Safety Checks, Confirmation und Remote-Failure-Gate. [Constitution §I, Spec §FR-015]
  > **Durchführungshinweis**: `rg -n 'Sicherheit|security|home-baseline|FR-015|Exit 2|Safety|confirmation|abort' ../plan.md`. Prüfe, ob der Selbstschutz-Mechanismus und die Laufzeit-Sicherungen als sicherheitsrelevante Leitplanken im Plan erkennbar sind.

- [x] CHK023 — ✓ Als Hinweis ist der Pre-Push-Hook in `plan.md` erwähnt; eine zwingende Vorbedingung ergibt sich hier aber nicht aus der Constitution, weil weder Hook- noch Scanner-Logik geändert wird. [Constitution §I]
  > **Durchführungshinweis**: `rg -n 'pre-push|scan-agent|hook' ../plan.md ../research.md ../../constitution.md`. Die Constitution verlangt `scan-agent-secrets.sh --fail-on-high` zwingend nur bei Änderungen an Hook- oder Scanner-Logik. Für dieses Feature ist daher ein Hinweis sinnvoll, aber keine harte Pflicht.

- [x] CHK024 — ✓ `plan.md` dokumentiert explizit, dass `teardown-workspace.sh` und `teardown-workspace.ps1` im selben Commit committed werden müssen. [Constitution §II]
  > **Durchführungshinweis**: `rg -n 'selben Commit|same commit|together|Principle II' ../plan.md`. Constitution §II: "A new script is not considered complete until both variants ... are committed together in the same commit."

- [x] CHK025 — ✓ Die vier betroffenen Skripte sind nun als zwei Paare beschrieben: neues Teardown-Paar und zusammengehöriges Bootstrap-Alias-Paar. [Constitution §II]
  > **Durchführungshinweis**: Lies `plan.md` §Source Code und §PowerShell Mirror. Prüfe, ob die 4 Dateien als 2 Paare (teardown-workspace: sh+ps1; bootstrap-workspace: sh+ps1) dargestellt sind, mit dem Hinweis "zusammen committen".

- [x] CHK026 — ✓ `--dry-run` / `-WhatIf` ist als verpflichtende Erstprüfung dokumentiert: `plan.md` verweist auf Principle V, `quickstart.md` sagt ausdrücklich "Preview (always start here)". [Constitution §V, Spec §FR-012]
  > **Durchführungshinweis**: Lies `plan.md` §Technical Context, `plan.md` §Constitution Check und `quickstart.md` §Most Common Uses. Die Constitution sagt: "always test with `--dry-run` before running for real." Prüfe, ob das als Muss-Schritt formuliert ist.

- [x] CHK027 — ✓ Das `--teardown`-Alias ist als reine Delegation beschrieben und verletzt die Bootstrap-Automatisierungs-Invariante nicht. [Constitution §III, Spec §FR-014]
  > **Durchführungshinweis**: Lies `plan.md` §Step 4. Prüfe, ob der Alias als reine Delegation (`exec teardown-workspace.sh`) beschrieben ist — ohne eigenständige Teardown-Logik im bootstrap-Skript. Ein eigenständiger Code-Pfad würde die Single-Source-of-Truth brechen.

---

## Dependencies & Assumptions — Validierung der Planungsvoraussetzungen

- [x] CHK028 — ✓ Alle externen Tool-Abhängigkeiten sind im `Technical Context` mit Pflicht-/Optional-/Assumption-Status dokumentiert. [Completeness, Spec §Assumptions]
  > **Durchführungshinweis**: `rg -n 'gh|glab|tar|git.*2\\.13|required|optional|assumed' ../plan.md`. Prüfe, ob jede Abhängigkeit als `required`, `optional` oder `assumed present` klassifiziert ist — insbesondere: `glab = optional`, `tar = assumed present`.

- [x] CHK029 — ✓ Die Soft-Dependency auf Feature 003 und der Fallback bei fehlender `~/.gitconfig.d/` sind jetzt im Plan explizit ausformuliert. [Dependency, Spec §Assumptions, Spec §FR-008]
  > **Durchführungshinweis**: `rg -n '003|gitconfig\\.d|inc.*file|FR-008' ../plan.md ../research.md`. Spec sagt: "bei fehlender ~/.gitconfig.d/ wird ohne Fehler übersprungen". Prüfe, ob dieser Fallback-Pfad in `plan.md` oder `research.md` explizit adressiert ist.

- [x] CHK030 — ✓ Das Verhalten bei fehlendem Git-Repo in `~/` ist nun in Spec, Plan, Research, Contract und Quickstart adressiert. [Assumption, Spec §Assumptions]
  > **Durchführungshinweis**: Lies `spec.md` §Assumptions und prüfe, ob `plan.md` diesen Fall erwähnt. Wenn `~/` kein git-Repo ist, schlägt der Artefakt-Commit fehl — ist das als Edge Case im Plan oder `research.md` erfasst?

---

## Ambiguities & Conflicts — Offene Fragen und Widersprüche

- [x] CHK031 — ✓ Der frühere Konflikt zwischen FR-004-Hard-Abort und dem `--keep-remote`-Szenario ist in Spec und Plan aufgelöst. [Conflict, Spec §FR-004, §Edge Cases]
  > **Durchführungshinweis**: Lies `spec.md` §FR-004 und User Story 2 / Szenario 4+5. Prüfe, ob `plan.md` explizit klärt: "Remote-Fehler nach Delete-Versuch → Abbruch; `--keep-remote` ist ein bewusster Vorab-Skip und kein nachträglicher Retry-Pfad."

- [x] CHK032 — ✓ Die frühere Suffix-Inkonsistenz ist aufgelöst: Spec und Research verwenden jetzt konsistent den numerischen Suffix, inklusive plattformbezogener Umsetzung. [Ambiguity, Spec §Edge Cases, research.md §R-007]
  > **Durchführungshinweis**: Lies `spec.md` §Edge Cases und `research.md` §R-007. Prüfe, ob beide Artefakte den numerischen Suffix konsistent verwenden und ob Bash- wie PowerShell-Umsetzung dokumentiert sind.

- [x] CHK033 — ✓ Der `Co-authored-by`-Trailer für den automatisch erzeugten Artefakt-Cleanup-Commit ist jetzt in `plan.md`, `research.md` und `contracts/cli.md` explizit adressiert. [Ambiguity, Constitution §Commit & PR Standards]
  > **Durchführungshinweis**: `rg -n 'Co-author|co-author|Co-Authored|trailer' ../plan.md ../research.md ../contracts/cli.md ../../constitution.md`. Die Constitution verlangt den Trailer für jeden Commit; prüfe, ob der automatische Artefakt-Commit ihn explizit mitführt.

---

## Notes

- Items abhaken mit `[x]` sobald geprüft
- Befunde inline annotieren, z.B. `[x] CHK001 — ✓ alle 16 FRs referenziert` oder `[~] CHK031 — ⚠ Konflikt in FR-004 vs. Edge Case noch nicht aufgelöst`
- Prüfliste gilt für Autor-Review VOR `/speckit.tasks` und für Peer-Review im PR
- Constitution-Version zum Zeitpunkt dieser Prüfliste: **1.1.0** (2026-03-31)
