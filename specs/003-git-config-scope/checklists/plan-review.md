# Plan Review Checklist: Git Configuration Scope Isolation

**Purpose**: Validate completeness, clarity, and consistency of the implementation plan before task generation
**Created**: 2026-04-09
**Reviewed**: 2026-04-09
**Feature**: [plan.md](../plan.md) | Audience: Autor + PR-Reviewer
**Depth**: Standard — alle Qualitätsdimensionen abgedeckt
**Result**: 30/30 abgehakt — Plan korrigiert und freigegeben für `/speckit.tasks`

---

## Technischer Kontext / Technical Context

- [x] CHK001 — Sind die Ziel-Plattformen (macOS, Linux, Windows) vollständig spezifiziert und decken sie alle Varianten ab, die von den betroffenen Scripts unterstützt werden müssen? [Completeness, Plan §Technical Context]
  > **Durchführungshinweis**: `Technical Context → Target Platform` mit den existierenden Script-Varianten (`*.sh` / `*.ps1`) und den CI-Matrix-Werten aus `.github/workflows/` abgleichen. Fehlende Plattform-Angaben kennzeichnen.
  > **Ergebnis**: PASS — Plan listet macOS (Darwin), Linux, Windows (Git for Windows / MSYS2) und stimmt mit CI-Matrix (ubuntu-22.04, macos-14, windows-2022) überein.

- [x] CHK002 — Ist die Mindest-git-Version (≥ 2.13) mit einer nachvollziehbaren Quelle belegt, und ist dokumentiert, was bei einer älteren Version passiert? [Clarity, Plan §Technical Context]
  > **Durchführungshinweis**: `research.md R-001` lesen — enthält die Begründung. Prüfen, ob im Plan ein Fallback oder eine Fehlermeldung für git < 2.13 spezifiziert ist; falls nicht, als Lücke markieren.
  > **Ergebnis**: GAP behoben — `Dependencies & Risks` ergänzt: Scripts prüfen git-Version nicht zur Laufzeit; `includeIf` wird bei älterem git stillschweigend ignoriert (non-fatal). Annahme: git < 2.13 ist auf unterstützten Plattformen nicht vorhanden.

- [x] CHK003 — Ist das Constraint „`~/.gitconfig.d/` MUSS ungetrackt bleiben" mit einer eindeutigen Verifikationsmethode verknüpft? [Measurability, Plan §Technical Context]
  > **Durchführungshinweis**: `Technical Context → Constraints` prüfen: Gibt es eine Anweisung, wie nach der Implementierung verifiziert wird, dass `.gitignore` die Whitelist korrekt setzt? Falls nur als Aussage formuliert (kein Prüfschritt), als Lücke markieren.
  > **Ergebnis**: GAP behoben — Constraints-Zeile ergänzt: `git -C ~/home-baseline-tmp ls-files ~/.gitconfig.d/` MUSS leere Ausgabe liefern.

- [x] CHK004 — Ist die Aussage „Performance Goals: N/A" hinreichend begründet, oder fehlt eine Aussage zu Fehlerverhalten bei langsamen Dateisystemoperationen (z. B. NFS)? [Completeness, Plan §Technical Context]
  > **Durchführungshinweis**: Überlegen ob `~/.gitconfig` auf einem Netzlaufwerk liegen kann (z. B. Home-Verzeichnis auf NFS). Falls ja: Fehlt eine Timeout-/Fehlerbehandlungsanforderung? Falls der Kontext rein lokal ist, kann N/A bestätigt werden.
  > **Ergebnis**: PASS — Technical Context spezifiziert „Single developer workstation; up to ~10 workspace directories". NFS-Szenarien sind im Scope nicht vorgesehen. N/A ist korrekt.

---

## Constitution Check

- [x] CHK005 — Ist für Principle I (Security-First) dokumentiert, welche konkreten Dateiname- und Inhaltsmuster der erweiterte pre-push-Hook prüft, und stimmen diese mit `secret_content_regex` in `scripts/hooks/pre-push` überein? [Clarity, Plan §Constitution Check]
  > **Durchführungshinweis**: `Plan §Phase 1C` mit dem bestehenden `pre-push`-Hook (Zeile 10: `secret_content_regex`) vergleichen. Prüfen, ob derselbe Regex für `.inc`-Dateien gilt oder ein separater definiert ist.
  > **Ergebnis**: PASS — Plan §Phase 1C zeigt explizit `"$secret_content_regex"` (gleiche Variable wie Hook-Zeile 10). Kein separater Regex — design by reference ist korrekt dokumentiert.

- [x] CHK006 — Ist die Ausnahme „pre-push Hook ist Bash-only (git hook — acceptable exception)" für Principle II (Cross-Platform Parity) mit einer ausreichenden Begründung versehen, sodass sie in einer PR-Review akzeptiert werden kann? [Clarity, Plan §Constitution Check]
  > **Durchführungshinweis**: Constitution Principle II lesen: verlangt es explizite Ausnahmen mit Begründung? Prüfen, ob „git hooks are shell scripts on all platforms" als vollständige Begründung gilt oder ob Windows-seitig eine zusätzliche Absicherung nötig ist (z. B. Git for Windows nutzt sh.exe).
  > **Ergebnis**: PASS — Begründung ergänzt in Phase 1C `Files:`-Zeile: „Git for Windows ships with sh.exe". Gilt als vollständige Rechtfertigung für PR-Review.

- [x] CHK007 — Ist Principle III (Bootstrap Automation) als „N/A" ausreichend begründet, oder sollte dokumentiert sein, dass `bootstrap-workspace` nach der Änderung noch dem Bootstrap-Automationsgebot entspricht? [Consistency, Plan §Constitution Check]
  > **Durchführungshinweis**: Prüfen ob die neuen Schritte in `bootstrap-workspace` (includeIf + .inc) in die bestehende `bootstrap-workspace.sh`-Sequenz integriert werden (ja → Principle III gewahrt) oder ob ein separater Aufruf nötig wird (nein → Begründung erforderlich).
  > **Ergebnis**: PASS — Phase 1B integriert die neuen Schritte in die bestehende Bootstrap-Sequenz. Kein separater Aufruf. „N/A" bedeutet korrekt: kein neues Workspace-Bootstrap-Szenario geschaffen.

- [x] CHK008 — Ist die Post-design-Wiederholung des Constitution Check ausreichend konkret, um als Gate zu dienen, oder ist sie eine reine Aussage ohne prüfbaren Inhalt? [Measurability, Plan §Constitution Check]
  > **Durchführungshinweis**: Den Satz „Constitution Check passes after Phase 1 design" daraufhin prüfen, ob er ein tatsächliches Ergebnis dokumentiert oder nur eine Behauptung ist. Ein Gate braucht: Was wurde geprüft? Durch wen? Mit welchem Ergebnis?
  > **Ergebnis**: GAP behoben — Post-design-Check ergänzt mit „Reviewed by: feature author, 2026-04-09" und den geprüften Punkten (FR-012, R-005).

- [x] CHK009 — Ist der Hinweis „PR MUST cite Principle I" in einer Form formuliert, die für den Implementierer als verbindliche Anforderung erkennbar ist (z. B. als eigenes FR oder als Checkliste im Plan), oder ist er nur als Kommentar in der Constitution-Tabelle versteckt? [Clarity, Plan §Constitution Check]
  > **Durchführungshinweis**: In `Plan §Phase 1C` prüfen, ob der Principle-I-Hinweis als eigenständiger, hervorgehobener Schritt formuliert ist (⚠️-Marker existiert bereits) oder ob er nur in der Tabelle steht. Ziel: Implementierer muss ihn nicht erst suchen.
  > **Ergebnis**: PASS — Phase 1C enthält bereits `**⚠️ Principle I — MANDATORY**` als separaten, fettgedruckten Block. Eindeutig erkennbar.

---

## FR- und SC-Abdeckung / FR and SC Coverage

- [x] CHK010 — Sind alle 12 Functional Requirements (FR-001 bis FR-012) aus `spec.md` explizit einer Implementierungsphase zugeordnet? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: FR-Liste aus `spec.md §Functional Requirements` mit den `Implements:`-Feldern der Phasen 1A–1E abgleichen. FR-002 (Verzeichnis `~/.gitconfig.d/` MUSS eingerichtet werden) ist möglicherweise nicht explizit zugeordnet — prüfen.
  > **Ergebnis**: GAP behoben — FR-002 zu Phase 1A `Implements:` hinzugefügt. FR-006 als pre-existing in Phase 1E notiert (R-009). Vollständige Abdeckung: 1A: FR-001/002/003/007 | 1B: FR-004/005/012 | 1C: FR-011 | 1D: FR-009 | 1E: FR-010/NFR-001 | OOS: FR-008.

- [x] CHK011 — Ist FR-002 (Einrichtung von `~/.gitconfig.d/`) eindeutig einer Phase zugeordnet, oder könnte es durch Überdeckung mit FR-007 übersehen werden? [Completeness, Plan §Phase 1A]
  > **Durchführungshinweis**: `spec.md FR-002` liest sich als Setup-Anforderung; `Plan §Phase 1A` deckt FR-007 (sync-home). Prüfen, ob FR-002 als eigene Anforderung dokumentiert oder implizit durch FR-007 erfüllt wird — und ob diese Implizitheit klar genug ist.
  > **Ergebnis**: GAP behoben — FR-002 explizit in Phase 1A aufgenommen. FR-007 implementiert FR-002 (sync-home erstellt `~/.gitconfig.d/`) — Beziehung ist jetzt durch gemeinsame Phase-Zuordnung dokumentiert.

- [x] CHK012 — Sind alle 8 Success Criteria (SC-001 bis SC-008) einem Implementierungsschritt oder einer Verifikationsmethode zugeordnet, sodass klar ist, wann sie als erfüllt gelten? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: SC-Liste aus `spec.md §Success Criteria` mit den `Verification:`-Abschnitten der Phasen abgleichen. SC-001 bis SC-007 haben möglicherweise keine explizite Verifikationsreferenz im Plan.
  > **Ergebnis**: Teilweise behoben — Phase 1A Verification auf SC-003, Phase 1B auf SC-002, Phase 1C auf SC-008, Phase 1D auf SC-005 referenziert. Phase 1E Verification ergänzt mit SC-006/SC-007 Regressions-Test. SC-001 ist durch SC-002/SC-003 transitiv abgedeckt. SC-004 bleibt mit FR-008 out-of-scope.

- [x] CHK013 — Ist NFR-001 (Bilingualität) für alle 5 modifizierten Scripts explizit als Anforderung aufgeführt, und fehlt die Anforderung bei keinem Skript? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: Jede Phase (1A–1E) daraufhin prüfen, ob NFR-001 explizit erwähnt wird. Besonderes Augenmerk: `pre-push`-Hook (Phase 1C) — ist dort ein bilingualer Error-Output gefordert?
  > **Ergebnis**: GAP behoben — Phase 1C `Implements:` um `NFR-001 (bilingual error output)` ergänzt. Contracts/script-contracts.md pre-push Output auf bilingual aktualisiert.

- [x] CHK014 — Ist FR-008 (teardown-workspace, Out-of-Scope) so dokumentiert, dass klar ist, welche Lücke bis zum Merge bestehen bleibt, und ist die Auswirkung für den Nutzer beschrieben? [Completeness, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: `Plan §Dependencies & Risks` prüfen: Steht dort, dass orphaned `includeIf`-Einträge nach einem manuellen Workspace-Löschen verbleiben? Falls nur „harmless" ohne Nutzer-Hinweis: als Lücke markieren.
  > **Ergebnis**: GAP behoben — Dependencies & Risks ergänzt: Nutzer-Mitigation über `quickstart.md` dokumentiert. quickstart.md erhält neuen Abschnitt mit manueller Cleanup-Anleitung.

- [x] CHK015 — Sind SC-002 und SC-003 (bootstrap-workspace-Nachbedingungen) durch die definierten Verifikationsschritte in Phase 1B vollständig testbar beschrieben? [Measurability, Plan §Phase 1B]
  > **Durchführungshinweis**: `Plan §Phase 1B → Verification` mit `spec.md SC-002` und `SC-003` abgleichen. Prüfen, ob der Verifikationsschritt (`--dry-run TestWorkspace`) SC-002 (keine workspace-spezifischen Werte in globalem Config) und SC-003 (Idempotenz) abdeckt.
  > **Ergebnis**: PASS — Phase 1B Verification referenziert SC-002 explizit. SC-003 (sync-home idempotency) ist Phase 1A zugeordnet.

---

## Phasen-Vollständigkeit / Phase Completeness

- [x] CHK016 — Sind alle 5 Implementierungsphasen unabhängig voneinander lieferbar (MVP-Slice-Prinzip), oder sind implizite Reihenfolge-Abhängigkeiten nicht dokumentiert? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: Phasenfolge 1A → 1B → 1C → 1D → 1E analysieren: Kann Phase 1C (pre-push Hook) unabhängig von Phase 1A (sync-home erstellt `~/.gitconfig.d/`) deployed werden? Falls die Reihenfolge relevant ist, muss sie explizit als Abhängigkeit dokumentiert sein.
  > **Ergebnis**: PASS — alle Phasen sind durch Existenzprüfungen soft-entkoppelt: Phase 1C prüft `if [ -d "$gitconfig_d" ]`, Phase 1B prüft `if ~/.gitconfig.d/ exists`. Kein Hard-Dependency; Reihenfolge 1A→1B→1C→1D→1E ist logisch empfohlen aber nicht erzwungen.

- [x] CHK017 — Ist für Phase 1A spezifiziert, welchen genauen Inhalt der `home-baseline.inc`-Placeholder hat, oder ist dieser nur in `research.md` / `quickstart.md` definiert? [Clarity, Plan §Phase 1A]
  > **Durchführungshinweis**: `Plan §Phase 1A` prüfen: Steht dort der Placeholder-Inhalt (kommentierter `[user]`-Block), oder verweist der Plan auf ein anderes Artefakt? Ein Implementierer sollte den Inhalt ohne Suche in anderen Dokumenten kennen.
  > **Ergebnis**: GAP behoben — Phase 1A Key implementation details ergänzt mit explizitem Verweis auf R-006 in research.md für den Placeholder-Inhalt. Vollständiger Inhalt steht in research.md R-006 (ini-Block mit kommentierten user-Einstellungen).

- [x] CHK018 — Ist in Phase 1B die Normalisierungsfunktion vollständig durch ein Beispiel spezifiziert, das alle Sonderfälle (Leerzeichen, Großbuchstaben, Sonderzeichen, führende/trailing Bindestriche) abdeckt? [Clarity, Plan §Phase 1B]
  > **Durchführungshinweis**: `Plan §Phase 1B` und `data-model.md §Normalization Function Reference` vergleichen. Prüfen ob die Tabelle alle Grenzfälle enthält (z. B. rein numerischer Name wie `123`, Leerzeichen am Anfang/Ende, Doppel-Sonderzeichen wie `My--Project`).
  > **Ergebnis**: PASS — `data-model.md §Normalization Function Reference` enthält vollständige Tabelle inkl. `  Foo  Bar  ` → `foo-bar` (trailing spaces, dedup hyphens) und `123 Numbers!` → `123-numbers`. research.md R-003 enthält Bash + PS1 Implementierungen. Doppel-Bindestriche werden durch `sed 's/-\+/-/g'` abgefangen.

- [x] CHK019 — Ist die `check-homogeneity`-Erweiterung in Phase 1D mit dem bestehenden Lib-Pattern (`lib/hg-*.sh`) abgestimmt, d. h. ist spezifiziert, ob eine neue `lib/hg-git-scope.sh` erstellt oder eine bestehende Datei erweitert wird? [Clarity, Plan §Phase 1D]
  > **Durchführungshinweis**: `Plan §Phase 1D` liest „aligned with existing lib/hg-*.sh pattern" — prüfen, ob explizit ein neuer Dateiname angegeben ist (z. B. `lib/hg-git-scope.sh`) oder ob nur „wie bisher" gesagt wird. Ohne konkreten Dateinamen ist die Anforderung mehrdeutig.
  > **Ergebnis**: GAP behoben — Phase 1D Key implementation details Punkt 1 auf `scripts/lib/hg-git-scope.sh` konkretisiert (Verweis auf R-007).

- [x] CHK020 — Ist für Phase 1E spezifiziert, wo im `README.md` der neue Abschnitt eingefügt wird (z. B. nach welchem bestehenden Abschnitt), oder ist die Position offen? [Clarity, Plan §Phase 1E]
  > **Durchführungshinweis**: `Plan §Phase 1E` prüfen: Steht dort ein Anker-Abschnitt oder eine Einfügeposition? `README.md` hat eine `<!-- workspace-table-end -->`-Konvention — gibt es eine ähnliche Konvention für neue Abschnitte?
  > **Ergebnis**: GAP behoben — Phase 1E README section content ergänzt: Einfügeposition nach `## Workspace-Einrichtung / Workspace Setup`, vor `## Verzeichnisstruktur / Directory Structure`. TOC-Eintrag erforderlich.

---

## Cross-Platform Parität / Cross-Platform Parity

- [x] CHK021 — Sind für jeden der 4 Script-Paare (bootstrap-workspace, bootstrap-project, sync-home, check-homogeneity) die PowerShell-Entsprechungen der neuen Bash-Logik explizit beschrieben, oder wird die PS1-Implementierung nur implizit durch „same (paired)" angedeutet? [Completeness, Plan §Project Structure]
  > **Durchführungshinweis**: Jede Phase (1A–1E) daraufhin prüfen, ob die `.ps1`-Implementierungsdetails explizit oder nur als „same" aufgeführt sind. Besondere Prüfung: Forward-Slash-Normalisierung (FR-012) — ist die PowerShell-Syntax (`-replace '\\'`, '/') spezifiziert?
  > **Ergebnis**: PASS — research.md R-003 definiert `ConvertTo-NormalizedName` (PS1), R-004 definiert `-replace '\\', '/'` für Forward-Slash-Normalisierung. Plan-Phasen verweisen auf R-003/R-004. „Same (paired)" ist als Verweis auf research.md-Implementierungen ausreichend.

- [x] CHK022 — Ist die Ausnahme für `pre-push` (Bash-only) so formuliert, dass klar ist, wie Windows-Nutzer den Hook erhalten und ob `install-hooks.sh`/`.ps1` aktualisiert werden muss? [Completeness, Plan §Phase 1C]
  > **Durchführungshinweis**: Prüfen ob `install-hooks.sh` im Project Structure-Abschnitt als zu modifizierende Datei aufgeführt ist. Falls nein: der neue Bash-Hook wird nicht automatisch auf Windows-Systemen installiert, falls `install-hooks.ps1` den Hook separat verteilt.
  > **Ergebnis**: PASS — `install-hooks.sh/.ps1` kopieren `scripts/hooks/pre-push` nach `.git/hooks/pre-push` und benötigen keine Änderung. Git for Windows führt den Bash-Hook über sh.exe aus. Kein Update von install-hooks nötig.

- [x] CHK023 — Ist der Windows-HOME-Pfad-Fallback (`$env:HOME` kann leer sein — bekannter Pitfall aus CLAUDE.md) in Phase 1B als Anforderung für die PowerShell-Implementierung explizit spezifiziert? [Completeness, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: `Plan §Dependencies & Risks → Windows HOME path` lesen: Steht dort die konkrete PowerShell-Syntax `$(if ($env:HOME) { $env:HOME } else { $env:USERPROFILE })`? Prüfen, ob dieselbe Anforderung auch in Phase 1B und Phase 1A explizit referenziert wird.
  > **Ergebnis**: GAP behoben — Phase 1B Key implementation details Punkt 6 ergänzt mit explizitem Verweis auf Dependencies & Risks (Windows HOME path). Phase 1A ist nicht PowerShell-spezifisch — sync-home.ps1 übernimmt bestehende HOME-Logik.

---

## Sicherheit / Security

- [x] CHK024 — Ist spezifiziert, was bei einem pre-push-Hook-Fehler (exit 2) konkret ausgegeben wird — insbesondere ob der Output bilingual (NFR-001) und für den Nutzer handlungsführend ist? [Clarity, Plan §Phase 1C]
  > **Durchführungshinweis**: Den Code-Block in `Plan §Phase 1C` lesen — der Kommentar im Bash-Code zeigt bereits bilingualen Text. Prüfen, ob die Anforderung an den Error-Output (bilingual, handlungsführend, kein Stack-Trace) als Anforderung formuliert ist oder nur im Beispielcode steht.
  > **Ergebnis**: GAP behoben — Inkonsistenz zwischen plan.md (bilingual: „gefunden / Secret patterns found") und contracts/script-contracts.md (nur Deutsch) beseitigt. contracts/script-contracts.md auf bilingualen Output aktualisiert. NFR-001 jetzt in Phase 1C `Implements:` referenziert.

- [x] CHK025 — Ist dokumentiert, dass `scripts/scan-agent-secrets.sh --fail-on-high` vor dem Commit der Hook-Änderung ausgeführt werden MUSS, und ist klar, wer das verifiziert? [Completeness, Plan §Phase 1C]
  > **Durchführungshinweis**: `Plan §Phase 1C → Verification` enthält den Hinweis. Prüfen, ob er als verbindliche Gate-Anforderung (MUSS) oder als Empfehlung formuliert ist. Bei MUSS: Ist klar, wer den Output beibringt (Autor im PR)?
  > **Ergebnis**: PASS — Phase 1C §Verification enthält „MUST be run and output included in PR". ⚠️-Block bekräftigt als MANDATORY. Verantwortlichkeit (Autor im PR) ist durch „include scanner output" implizit klar.

- [x] CHK026 — Ist die Anforderung, dass `.inc`-Dateien keine Credentials enthalten dürfen (FR-011), mit einem klaren Abgrenzungskriterium zu „erlaubten Secrets" versehen — z. B. sind SSH-Key-Pfade (`sshCommand`) erlaubt, aber Token-Werte nicht? [Clarity, Plan §Phase 1C]
  > **Durchführungshinweis**: `spec.md FR-011` und `research.md R-005` lesen. Prüfen, ob der `secret_content_regex` einen SSH-Befehlspfad (`ssh -i ~/.ssh/foo`) als False Positive flaggen würde. Falls ja: ist diese Einschränkung im Plan dokumentiert?
  > **Ergebnis**: PASS — `secret_content_regex` matcht nicht auf SSH-Befehlspfade (`ssh -i ~/.ssh/key`). Nur Token-Muster (`ghp_*`, `sk-*`, `AKIA*`), Passwörter und Private-Key-Header werden erkannt. data-model.md §Include File zeigt `sshCommand` als explizit erlaubtes Beispiel.

---

## Abhängigkeiten & Risiken / Dependencies & Risks

- [x] CHK027 — Sind alle 5 Risiken in der Dependencies-Tabelle mit einem konkreten Mitigation-Schritt (nicht nur einer Einschätzung) versehen? [Completeness, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: Jede Tabellenzeile prüfen: `git ≥ 2.13` — gibt es eine Prüfung im Script? `~/.gitconfig write permissions` — gibt es eine explizite Fehlerbehandlung? Reine Kommentare ohne Implementierungsschritt sind als offene Risiken zu markieren.
  > **Ergebnis**: GAP behoben — git ≥ 2.13: explizit dokumentiert, dass kein Laufzeit-Check erfolgt und das Fail-Verhalten (non-fatal, includeIf wird ignoriert) beschrieben. teardown-workspace: Nutzer-Mitigation via quickstart.md ergänzt.

- [x] CHK028 — Ist das Risiko „Duplicate includeIf entries (existing installs)" vollständig durch die Idempotenz-Anforderung in FR-005 abgedeckt, oder besteht für bestehende Installationen (vor diesem Feature) eine zusätzliche Migrationslücke? [Coverage, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: FR-005 regelt neue Bootstrap-Läufe; prüfen ob bestehende `~/.gitconfig`-Dateien mit manuell hinzugefügten includeIf-Blöcken vor dem Feature als Risiko adressiert sind. Falls nicht, in der Tabelle als unresolved markieren.
  > **Ergebnis**: PASS — Dependencies & Risks Zeile 5 deckt diesen Fall: „Idempotency check handles this for new bootstrap runs; existing duplicates harmless." Manuell hinzugefügte Einträge vor diesem Feature sind harmlos (git wertet alle aus) und werden bei nächstem Bootstrap-Lauf nicht dupliziert.

- [x] CHK029 — Ist die Abhängigkeit zu `teardown-workspace` (FR-008, Out-of-Scope) so dokumentiert, dass klar ist, welches technische Artefakt den Nutzer in der Zwischenzeit schützt (z. B. ein Hinweis in `quickstart.md` oder `README.md`)? [Completeness, Plan §Dependencies & Risks]
  > **Durchführungshinweis**: `quickstart.md` und `Plan §Dependencies & Risks` lesen. Prüfen, ob der Nutzer einen klaren Hinweis erhält, dass orphaned `includeIf`-Einträge nach manuellem Workspace-Löschen manuell zu entfernen sind, bis `teardown-workspace` implementiert ist.
  > **Ergebnis**: GAP behoben — quickstart.md erhält neuen Abschnitt „Bekannte Lücken bis teardown-workspace" mit manueller Cleanup-Anleitung (nano ~/.gitconfig + rm .inc). Dependencies & Risks Zeile 1 verweist auf quickstart.md als Mitigation-Artefakt.

---

## Verifikation / Verification

- [x] CHK030 — Ist für jede Phase (1A–1E) ein konkreter `--dry-run` / `-WhatIf`-Befehl spezifiziert, und deckt dieser Befehl die primäre neue Funktionalität der Phase vollständig ab? [Completeness, Plan §Implementation Phases]
  > **Durchführungshinweis**: Jede Phase-Sektion auf `Verification:`-Block prüfen. Fehlende oder unvollständige Verifikationsschritte kennzeichnen. Besonderes Augenmerk: Phase 1E (README-Änderung hat kein `--dry-run`) und Phase 1D (check-homogeneity-Verifikation ist beschrieben, aber fehlt der `--json`-Output-Test).
  > **Ergebnis**: GAP behoben — Phase 1A Verification erweitert (SC-003 idempotency path). Phase 1D Verification ergänzt um `--json`-Output-Test. Phase 1E erhält neuen Verification-Block mit README-Render-Check, bootstrap-project dry-run und SC-006/SC-007 Regressions-Test.

## Notes

- Items mit [Gap] oder [Ambiguity] erfordern Überarbeitung des Plans vor `/speckit.tasks`
- Constitution-Compliance-Items (CHK005–CHK009) sind verbindliche Gates für den PR
- Alle Items mit [Completeness, Plan §Phase 1C] sind sicherheitsrelevant — bevorzugt zuerst abarbeiten
- **Review-Ergebnis**: 14 Korrekturen eingearbeitet in plan.md, quickstart.md, contracts/script-contracts.md. Plan ist freigegeben für `/speckit.tasks`.
