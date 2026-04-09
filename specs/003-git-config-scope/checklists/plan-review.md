# Plan Review Checklist: Git Configuration Scope Isolation

**Purpose**: Validate completeness, clarity, and consistency of the implementation plan before task generation
**Created**: 2026-04-09
**Feature**: [plan.md](../plan.md) | Audience: Autor + PR-Reviewer
**Depth**: Standard — alle Qualitätsdimensionen abgedeckt

---

## Technischer Kontext / Technical Context

- [ ] CHK001 — Sind die Ziel-Plattformen (macOS, Linux, Windows) vollständig spezifiziert und decken sie alle Varianten ab, die von den betroffenen Scripts unterstützt werden müssen? [Completeness, Plan §Technical Context]
  > **Durchführungshinweis**: `Technical Context → Target Platform` mit den existierenden Script-Varianten (`*.sh` / `*.ps1`) und den CI-Matrix-Werten aus `.github/workflows/` abgleichen. Fehlende Plattform-Angaben kennzeichnen.

- [ ] CHK002 — Ist die Mindest-git-Version (≥ 2.13) mit einer nachvollziehbaren Quelle belegt, und ist dokumentiert, was bei einer älteren Version passiert? [Clarity, Plan §Technical Context]
  > **Durchführungshinweis**: `research.md R-001` lesen — enthält die Begründung. Prüfen, ob im Plan ein Fallback oder eine Fehlermeldung für git < 2.13 spezifiziert ist; falls nicht, als Lücke markieren.

- [ ] CHK003 — Ist das Constraint „`~/.gitconfig.d/` MUSS ungetrackt bleiben" mit einer eindeutigen Verifikationsmethode verknüpft? [Measurability, Plan §Technical Context]
  > **Durchführungshinweis**: `Technical Context → Constraints` prüfen: Gibt es eine Anweisung, wie nach der Implementierung verifiziert wird, dass `.gitignore` die Whitelist korrekt setzt? Falls nur als Aussage formuliert (kein Prüfschritt), als Lücke markieren.

- [ ] CHK004 — Ist die Aussage „Performance Goals: N/A" hinreichend begründet, oder fehlt eine Aussage zu Fehlerverhalten bei langsamen Dateisystemoperationen (z. B. NFS)? [Completeness, Plan §Technical Context]
  > **Durchführungshinweis**: Überlegen ob `~/.gitconfig` auf einem Netzlaufwerk liegen kann (z. B. Home-Verzeichnis auf NFS). Falls ja: Fehlt eine Timeout-/Fehlerbehandlungsanforderung? Falls der Kontext rein lokal ist, kann N/A bestätigt werden.

---

## Constitution Check

- [ ] CHK005 — Ist für Principle I (Security-First) dokumentiert, welche konkreten Dateiname- und Inhaltsmuster der erweiterte pre-push-Hook prüft, und stimmen diese mit `secret_content_regex` in `scripts/hooks/pre-push` überein? [Clarity, Plan §Constitution Check]
  > **Durchführungshinweis**: `Plan §Phase 1C` mit dem bestehenden `pre-push`-Hook (Zeile 10: `secret_content_regex`) vergleichen. Prüfen, ob derselbe Regex für `.inc`-Dateien gilt oder ein separater definiert ist.

- [ ] CHK006 — Ist die Ausnahme „pre-push Hook ist Bash-only (git hook — acceptable exception)" für Principle II (Cross-Platform Parity) mit einer ausreichenden Begründung versehen, sodass sie in einer PR-Review akzeptiert werden kann? [Clarity, Plan §Constitution Check]
  > **Durchführungshinweis**: Constitution Principle II lesen: verlangt es explizite Ausnahmen mit Begründung? Prüfen, ob „git hooks are shell scripts on all platforms" als vollständige Begründung gilt oder ob Windows-seitig eine zusätzliche Absicherung nötig ist (z. B. Git for Windows nutzt sh.exe).

- [ ] CHK007 — Ist Principle III (Bootstrap Automation) als „N/A" ausreichend begründet, oder sollte dokumentiert sein, dass `bootstrap-workspace` nach der Änderung noch dem Bootstrap-Automationsgebot entspricht? [Consistency, Plan §Constitution Check]
  > **Durchführungshinweis**: Prüfen ob die neuen Schritte in `bootstrap-workspace` (includeIf + .inc) in die bestehende `bootstrap-workspace.sh`-Sequenz integriert werden (ja → Principle III gewahrt) oder ob ein separater Aufruf nötig wird (nein → Begründung erforderlich).

- [ ] CHK008 — Ist die Post-design-Wiederholung des Constitution Check ausreichend konkret, um als Gate zu dienen, oder ist sie eine reine Aussage ohne prüfbaren Inhalt? [Measurability, Plan §Constitution Check]
  > **Durchführungshinweis**: Den Satz „Constitution Check passes after Phase 1 design" daraufhin prüfen, ob er ein tatsächliches Ergebnis dokumentiert oder nur eine Behauptung ist. Ein Gate braucht: Was wurde geprüft? Durch wen? Mit welchem Ergebnis?

- [ ] CHK009 — Ist der Hinweis „PR MUST cite Principle I" in einer Form formuliert, die für den Implementierer als verbindliche Anforderung erkennbar ist (z. B. als eigenes FR oder als Checkliste im Plan), oder ist er nur als Kommentar in der Constitution-Tabelle versteckt? [Clarity, Plan §Constitution Check]
  > **Durchführungshinweis**: In `Plan §Phase 1C` prüfen, ob der Principle-I-Hinweis als eigenständiger, hervorgehobener Schritt formuliert ist (⚠️-Marker existiert bereits) oder ob er nur in der Tabelle steht. Ziel: Implementierer muss ihn nicht erst suchen.

---

## FR- und SC-Abdeckung / FR and SC Coverage

- [ ] CHK010 — Sind alle 12 Functional Requirements (FR-001 bis FR-012) aus `spec.md` explizit einer Implementierungsphase zugeordnet? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: FR-Liste aus `spec.md §Functional Requirements` mit den `Implements:`-Feldern der Phasen 1A–1E abgleichen. FR-002 (Verzeichnis `~/.gitconfig.d/` MUSS eingerichtet werden) ist möglicherweise nicht explizit zugeordnet — prüfen.

- [ ] CHK011 — Ist FR-002 (Einrichtung von `~/.gitconfig.d/`) eindeutig einer Phase zugeordnet, oder könnte es durch Überdeckung mit FR-007 übersehen werden? [Completeness, Plan §Phase 1A]
  > **Durchführungshinweis**: `spec.md FR-002` liest sich als Setup-Anforderung; `Plan §Phase 1A` deckt FR-007 (sync-home). Prüfen, ob FR-002 als eigene Anforderung dokumentiert oder implizit durch FR-007 erfüllt wird — und ob diese Implizitheit klar genug ist.

- [ ] CHK012 — Sind alle 8 Success Criteria (SC-001 bis SC-008) einem Implementierungsschritt oder einer Verifikationsmethode zugeordnet, sodass klar ist, wann sie als erfüllt gelten? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: SC-Liste aus `spec.md §Success Criteria` mit den `Verification:`-Abschnitten der Phasen abgleichen. SC-001 bis SC-007 haben möglicherweise keine explizite Verifikationsreferenz im Plan.

- [ ] CHK013 — Ist NFR-001 (Bilingualität) für alle 5 modifizierten Scripts explizit als Anforderung aufgeführt, und fehlt die Anforderung bei keinem Skript? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: Jede Phase (1A–1E) daraufhin prüfen, ob NFR-001 explizit erwähnt wird. Besonderes Augenmerk: `pre-push`-Hook (Phase 1C) — ist dort ein bilingualer Error-Output gefordert?

- [ ] CHK014 — Ist FR-008 (teardown-workspace, Out-of-Scope) so dokumentiert, dass klar ist, welche Lücke bis zum Merge bestehen bleibt, und ist die Auswirkung für den Nutzer beschrieben? [Completeness, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: `Plan §Dependencies & Risks` prüfen: Steht dort, dass orphaned `includeIf`-Einträge nach einem manuellen Workspace-Löschen verbleiben? Falls nur „harmless" ohne Nutzer-Hinweis: als Lücke markieren.

- [ ] CHK015 — Sind SC-002 und SC-003 (bootstrap-workspace-Nachbedingungen) durch die definierten Verifikationsschritte in Phase 1B vollständig testbar beschrieben? [Measurability, Plan §Phase 1B]
  > **Durchführungshinweis**: `Plan §Phase 1B → Verification` mit `spec.md SC-002` und `SC-003` abgleichen. Prüfen, ob der Verifikationsschritt (`--dry-run TestWorkspace`) SC-002 (keine workspace-spezifischen Werte in globalem Config) und SC-003 (Idempotenz) abdeckt.

---

## Phasen-Vollständigkeit / Phase Completeness

- [ ] CHK016 — Sind alle 5 Implementierungsphasen unabhängig voneinander lieferbar (MVP-Slice-Prinzip), oder sind implizite Reihenfolge-Abhängigkeiten nicht dokumentiert? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: Phasenfolge 1A → 1B → 1C → 1D → 1E analysieren: Kann Phase 1C (pre-push Hook) unabhängig von Phase 1A (sync-home erstellt `~/.gitconfig.d/`) deployed werden? Falls die Reihenfolge relevant ist, muss sie explizit als Abhängigkeit dokumentiert sein.

- [ ] CHK017 — Ist für Phase 1A spezifiziert, welchen genauen Inhalt der `home-baseline.inc`-Placeholder hat, oder ist dieser nur in `research.md` / `quickstart.md` definiert? [Clarity, Plan §Phase 1A]
  > **Durchführungshinweis**: `Plan §Phase 1A` prüfen: Steht dort der Placeholder-Inhalt (kommentierter `[user]`-Block), oder verweist der Plan auf ein anderes Artefakt? Ein Implementierer sollte den Inhalt ohne Suche in anderen Dokumenten kennen.

- [ ] CHK018 — Ist in Phase 1B die Normalisierungsfunktion vollständig durch ein Beispiel spezifiziert, das alle Sonderfälle (Leerzeichen, Großbuchstaben, Sonderzeichen, führende/trailing Bindestriche) abdeckt? [Clarity, Plan §Phase 1B]
  > **Durchführungshinweis**: `Plan §Phase 1B` und `data-model.md §Normalization Function Reference` vergleichen. Prüfen ob die Tabelle alle Grenzfälle enthält (z. B. rein numerischer Name wie `123`, Leerzeichen am Anfang/Ende, Doppel-Sonderzeichen wie `My--Project`).

- [ ] CHK019 — Ist die `check-homogeneity`-Erweiterung in Phase 1D mit dem bestehenden Lib-Pattern (`lib/hg-*.sh`) abgestimmt, d. h. ist spezifiziert, ob eine neue `lib/hg-git-scope.sh` erstellt oder eine bestehende Datei erweitert wird? [Clarity, Plan §Phase 1D]
  > **Durchführungshinweis**: `Plan §Phase 1D` liest „aligned with existing lib/hg-*.sh pattern" — prüfen, ob explizit ein neuer Dateiname angegeben ist (z. B. `lib/hg-git-scope.sh`) oder ob nur „wie bisher" gesagt wird. Ohne konkreten Dateinamen ist die Anforderung mehrdeutig.

- [ ] CHK020 — Ist für Phase 1E spezifiziert, wo im `README.md` der neue Abschnitt eingefügt wird (z. B. nach welchem bestehenden Abschnitt), oder ist die Position offen? [Clarity, Plan §Phase 1E]
  > **Durchführungshinweis**: `Plan §Phase 1E` prüfen: Steht dort ein Anker-Abschnitt oder eine Einfügeposition? `README.md` hat eine `<!-- workspace-table-end -->`-Konvention — gibt es eine ähnliche Konvention für neue Abschnitte?

---

## Cross-Platform Parität / Cross-Platform Parity

- [ ] CHK021 — Sind für jeden der 4 Script-Paare (bootstrap-workspace, bootstrap-project, sync-home, check-homogeneity) die PowerShell-Entsprechungen der neuen Bash-Logik explizit beschrieben, oder wird die PS1-Implementierung nur implizit durch „same (paired)" angedeutet? [Completeness, Plan §Project Structure]
  > **Durchführungshinweis**: Jede Phase (1A–1E) daraufhin prüfen, ob die `.ps1`-Implementierungsdetails explizit oder nur als „same" aufgeführt sind. Besondere Prüfung: Forward-Slash-Normalisierung (FR-012) — ist die PowerShell-Syntax (`-replace '\\'`, '/') spezifiziert?

- [ ] CHK022 — Ist die Ausnahme für `pre-push` (Bash-only) so formuliert, dass klar ist, wie Windows-Nutzer den Hook erhalten und ob `install-hooks.sh`/`.ps1` aktualisiert werden muss? [Completeness, Plan §Phase 1C]
  > **Durchführungshinweis**: Prüfen ob `install-hooks.sh` im Project Structure-Abschnitt als zu modifizierende Datei aufgeführt ist. Falls nein: der neue Bash-Hook wird nicht automatisch auf Windows-Systemen installiert, falls `install-hooks.ps1` den Hook separat verteilt.

- [ ] CHK023 — Ist der Windows-HOME-Pfad-Fallback (`$env:HOME` kann leer sein — bekannter Pitfall aus CLAUDE.md) in Phase 1B als Anforderung für die PowerShell-Implementierung explizit spezifiziert? [Completeness, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: `Plan §Dependencies & Risks → Windows HOME path` lesen: Steht dort die konkrete PowerShell-Syntax `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`? Prüfen, ob dieselbe Anforderung auch in Phase 1B und Phase 1A explizit referenziert wird.

---

## Sicherheit / Security

- [ ] CHK024 — Ist spezifiziert, was bei einem pre-push-Hook-Fehler (exit 2) konkret ausgegeben wird — insbesondere ob der Output bilingual (NFR-001) und für den Nutzer handlungsführend ist? [Clarity, Plan §Phase 1C]
  > **Durchführungshinweis**: Den Code-Block in `Plan §Phase 1C` lesen — der Kommentar im Bash-Code zeigt bereits bilingualen Text. Prüfen, ob die Anforderung an den Error-Output (bilingual, handlungsführend, kein Stack-Trace) als Anforderung formuliert ist oder nur im Beispielcode steht.

- [ ] CHK025 — Ist dokumentiert, dass `scripts/scan-agent-secrets.sh --fail-on-high` vor dem Commit der Hook-Änderung ausgeführt werden MUSS, und ist klar, wer das verifiziert? [Completeness, Plan §Phase 1C]
  > **Durchführungshinweis**: `Plan §Phase 1C → Verification` enthält den Hinweis. Prüfen, ob er als verbindliche Gate-Anforderung (MUSS) oder als Empfehlung formuliert ist. Bei MUSS: Ist klar, wer den Output beibringt (Autor im PR)?

- [ ] CHK026 — Ist die Anforderung, dass `.inc`-Dateien keine Credentials enthalten dürfen (FR-011), mit einem klaren Abgrenzungskriterium zu „erlaubten Secrets" versehen — z. B. sind SSH-Key-Pfade (`sshCommand`) erlaubt, aber Token-Werte nicht? [Clarity, Plan §Phase 1C]
  > **Durchführungshinweis**: `spec.md FR-011` und `research.md R-005` lesen. Prüfen, ob der `secret_content_regex` einen SSH-Befehlspfad (`ssh -i ~/.ssh/foo`) als False Positive flaggen würde. Falls ja: ist diese Einschränkung im Plan dokumentiert?

---

## Abhängigkeiten & Risiken / Dependencies & Risks

- [ ] CHK027 — Sind alle 5 Risiken in der Dependencies-Tabelle mit einem konkreten Mitigation-Schritt (nicht nur einer Einschätzung) versehen? [Completeness, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: Jede Tabellenzeile prüfen: `git ≥ 2.13` — gibt es eine Prüfung im Script? `~/.gitconfig write permissions` — gibt es eine explizite Fehlerbehandlung? Reine Kommentare ohne Implementierungsschritt sind als offene Risiken zu markieren.

- [ ] CHK028 — Ist das Risiko „Duplicate includeIf entries (existing installs)" vollständig durch die Idempotenz-Anforderung in FR-005 abgedeckt, oder besteht für bestehende Installationen (vor diesem Feature) eine zusätzliche Migrationslücke? [Coverage, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: FR-005 regelt neue Bootstrap-Läufe; prüfen ob bestehende `~/.gitconfig`-Dateien mit manuell hinzugefügten includeIf-Blöcken vor dem Feature als Risiko adressiert sind. Falls nicht, in der Tabelle als unresolved markieren.

- [ ] CHK029 — Ist die Abhängigkeit zu `teardown-workspace` (FR-008, Out-of-Scope) so dokumentiert, dass klar ist, welches technische Artefakt den Nutzer in der Zwischenzeit schützt (z. B. ein Hinweis in `quickstart.md` oder `README.md`)? [Completeness, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: `quickstart.md` und `Plan §Dependencies & Risks` lesen. Prüfen, ob der Nutzer einen klaren Hinweis erhält, dass orphaned `includeIf`-Einträge nach manuellem Workspace-Löschen manuell zu entfernen sind, bis `teardown-workspace` implementiert ist.

---

## Verifikation / Verification

- [ ] CHK030 — Ist für jede Phase (1A–1E) ein konkreter `--dry-run` / `-WhatIf`-Befehl spezifiziert, und deckt dieser Befehl die primäre neue Funktionalität der Phase vollständig ab? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: Jede Phase-Sektion auf `Verification:`-Block prüfen. Fehlende oder unvollständige Verifikationsschritte kennzeichnen. Besonderes Augenmerk: Phase 1E (README-Änderung hat kein `--dry-run`) und Phase 1D (check-homogeneity-Verifikation ist beschrieben, aber fehlt der `--json`-Output-Test).

## Notes

- Items mit [Gap] oder [Ambiguity] erfordern Überarbeitung des Plans vor `/speckit.tasks`
- Constitution-Compliance-Items (CHK005–CHK009) sind verbindliche Gates für den PR
- Alle Items mit [Completeness, Plan §Phase 1C] sind sicherheitsrelevant — bevorzugt zuerst abarbeiten
