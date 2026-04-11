# Plan-Prüfliste / Plan Review Checklist: GitLab Support for Bootstrap Scripts

**Zweck / Purpose**: Vollständigkeit und Korrektheit von `plan.md` vor der Implementierung sicherstellen  
*Ensure completeness and correctness of `plan.md` before implementation begins*  
**Erstellt / Created**: 2026-04-10  
**Feature**: [plan.md](../plan.md) · [spec.md](../spec.md)  
**Publikum / Audience**: Implementierer, Reviewer

---

> **Hinweis zu GAPs**: Prüfpunkte mit `⚠️ GAP` bezeichnen Fehler oder Lücken, die vor der  
> Implementierung im `plan.md` korrigiert werden müssen.  
> *Items marked `⚠️ GAP` indicate bugs or gaps that must be corrected in `plan.md` before implementation.*

---

## 1. Technischer Kontext / Technical Context

- [x] **CHK001** [Compatibility] Sind alle neuen Bash-Konstrukte bash-3.x-kompatibel (keine Bash-4+-Syntax wie `mapfile`, assoziative Arrays oder `${var,,}`)?  
  *Are all new Bash constructs compatible with Bash 3.x (no Bash 4+ syntax such as `mapfile`, associative arrays, or `${var,,}`)?*
  > **Durchführungshinweis**: Plan §1 und §2 auf Bash-4+-Syntax prüfen. `while`, `case` und `[ ]` sind unkritisch; `[[ ]]` wäre zwar bash-3.x-kompatibel, wird im Plan hier aber ohnehin nicht verwendet.  
  > *Check plan §1 and §2 for Bash 4+ syntax. `while`, `case`, and `[ ]` are safe; `[[ ]]` would also be bash-3.x compatible, but is not used here anyway.*
  > **Ergebnis**: Ja — die Bash-Snippets bleiben bei bash-3.x-kompatiblen Konstrukten.

- [x] **CHK002** [Completeness] Ist `glab ≥ 1.40` als explizite Tool-Anforderung im Plan dokumentiert?  
  *Is `glab ≥ 1.40` documented as an explicit tool requirement in the plan?*
  > **Durchführungshinweis**: Plan §Technical Context → „Primary Dependencies" lesen. Prüfen ob `glab ≥ 1.40 (new)` eingetragen ist. Zur Verfügbarkeit: `glab --version` im Terminal ausführen.  
  > *Read plan §Technical Context → "Primary Dependencies". Verify `glab ≥ 1.40 (new)` is listed. To check availability: run `glab --version` in terminal.*
  > **Ergebnis**: Ja — im Plan dokumentiert; lokal ist `glab 1.91.0` verfügbar.

- [x] **CHK003** [Scope] Werden in `scripts/` ausschließlich bestehende Dateien modifiziert (keine neuen Dateien)?  
  *Are only existing files modified in `scripts/` (no new files created)?*
  > **Durchführungshinweis**: Plan §Project Structure → „Source Code Changes" lesen. Eintrag `0 new files created in scripts/` bestätigen. Alle aufgelisteten Dateien mit `ls scripts/` vergleichen.  
  > *Read plan §Project Structure → "Source Code Changes". Confirm entry `0 new files created in scripts/`. Compare all listed files with `ls scripts/`.*
  > **Ergebnis**: Ja — es werden nur bestehende Skripte erweitert.

- [x] **CHK004** [Constraints] Stimmt die Manual-First-Teststrategie mit Constitution Principle V überein?  
  *Does the manual-first testing strategy align with Constitution Principle V?*
  > **Durchführungshinweis**: Plan §Technical Context → „Testing" lesen und Constitution `.specify/memory/constitution.md` §V prüfen. Erlaubt sind manuelle `--dry-run`-, `-WhatIf`- und `-Preview`-Prüfungen sowie manuelle Live-Checks; ein neues automatisiertes Test-Framework darf nicht hinzukommen.  
  > *Read plan §Technical Context → "Testing" and constitution §V. Manual `--dry-run`, `-WhatIf`, `-Preview`, and manual live checks are acceptable; adding a new automated test framework is not.*
  > **Ergebnis**: Ja — der Plan bleibt manual-first und führt kein Test-Framework ein.

---

## 2. Constitution Check

- [x] **CHK005** [Security] Enthält das Implementation Design keine Credentials, Tokens oder Secrets im Code?  
  *Does the Implementation Design contain no credentials, tokens, or secrets in code?*
  > **Durchführungshinweis**: Plan §3 und §9 (glab checks) durchlesen. Auth wird ausschließlich an `glab auth login` delegiert. Alle Code-Snippets auf hartcodierte Tokens (`ghp_*`, `glpat-*`) prüfen — keine sollten vorhanden sein.  
  > *Read plan §3 and §9 (glab checks). Auth is delegated exclusively to `glab auth login`. Check all code snippets for hardcoded tokens — none should be present.*
  > **Ergebnis**: Ja — keine Tokens oder Secrets im Plan.

- [x] **CHK006** [Cross-Platform] Werden alle 4 Scripts als `.sh`/`.ps1`-Paare in derselben Commit-Einheit geändert?  
  *Are all 4 scripts changed as `.sh`/`.ps1` pairs within the same commit unit?*
  > **Durchführungshinweis**: Plan §Project Structure → Source Code Changes und Constitution Check lesen. Prüfen, ob `bootstrap-workspace.sh/.ps1` sowie `bootstrap-project.sh/.ps1` beide explizit als Paaränderungen vorgesehen sind.  
  > *Read plan §Project Structure → Source Code Changes and Constitution Check. Verify that `bootstrap-workspace.sh/.ps1` and `bootstrap-project.sh/.ps1` are both explicitly planned as paired changes.*
  > **Ergebnis**: Ja — beide Skriptfamilien sind als Paare im Plan vorgesehen.

- [x] **CHK007** [Integrity] Wird der bestehende Bootstrap-Flow nur erweitert (kein Ersetzen bestehender Logik)?  
  *Is the existing bootstrap flow only extended (not replaced)?*
  > **Durchführungshinweis**: Plan §6 (Remote Repo Creation) prüfen: GitHub-Pfad bleibt `gh repo create ... --source ... --push` (unverändert). GitLab-Pfad ist ein neuer `elif`-Zweig, kein Ersetzen. Plan §FR-003 in `spec.md`: „when no platform is specified, scripts MUST behave identically".  
  > *Check plan §6: GitHub path remains `gh repo create ... --source ... --push` (unchanged). GitLab path is a new `elif` branch, not a replacement. See also FR-003 in `spec.md`.*
  > **Ergebnis**: Ja — der GitHub-Default bleibt unverändert, GitLab kommt additiv hinzu.

- [x] **CHK008** [Isolation] Sind keine neuen `.gitignore`-Whitelist-Einträge oder neue Tracked-Categories erforderlich?  
  *Are no new `.gitignore` whitelist entries or new tracked categories required?*
  > **Durchführungshinweis**: Plan §Project Structure und §Documentation lesen. Prüfen ob nur bestehende Skripte und bereits getrackte Dokumentationsdateien geändert werden.  
  > *Read plan §Project Structure and §Documentation. Check whether only existing scripts and already-tracked documentation files are changed.*
  > **Ergebnis**: Ja — keine neuen Tracked-Categories oder Whitelist-Einträge erforderlich.

- [x] **CHK009** [Verification] Bleibt die Verifikation manual-first und ohne neues Test-Framework?  
  *Does verification remain manual-first and avoid introducing a new test framework?*
  > **Durchführungshinweis**: Plan §Verification Plan öffnen. Prüfen, ob die Verifikation aus manuellen Shell-/PowerShell-Aufrufen besteht und keine zusätzlichen Test-Tools oder Harnesses einführt.  
  > *Open plan §Verification Plan. Verify that validation consists of manual shell/PowerShell commands and introduces no additional test tools or harnesses.*
  > **Ergebnis**: Ja — der Verifikationsplan bleibt vollständig manuell.

---

## 3. Implementation Design — `bootstrap-workspace.sh`

- [x] **CHK010** [Backward Compat] Unterstützt der neue while-Loop weiterhin alle 3 Positional-Argumente (`WorkspaceName`, `RepoName`, `Description`)?  
  *Does the new while-loop still support all 3 positional arguments (`WorkspaceName`, `RepoName`, `Description`)?*
  > **Durchführungshinweis**: Plan §1 code snippet prüfen: `*)`-Branch des while-Loops setzt `WORKSPACE_NAME`, `REPO_NAME`, `REPO_DESC` aus Positional-Args. Folgenden Aufruf gedanklich durchspielen: `bash bootstrap-workspace.sh MyWS my-repo "My Desc"` — alle 3 Variablen sollten korrekt belegt werden.  
  > *Check plan §1 code snippet: `*)`-branch of while-loop sets `WORKSPACE_NAME`, `REPO_NAME`, `REPO_DESC` from positional args. Mentally trace: `bash bootstrap-workspace.sh MyWS my-repo "My Desc"` — all 3 vars should be set correctly.*
  > **Ergebnis**: Ja — die Positional-Argumente bleiben intakt.

- [x] **CHK011** [Error Handling] Gibt das Skript Exit-Code 1 bei ungültigem `--platform`-Wert aus, inklusive bilinguale Fehlermeldung?  
  *Does the script exit with code 1 on invalid `--platform` value, including bilingual error message?*
  > **Durchführungshinweis**: Plan §2 → `case "$PLATFORM"` Block: `*)`-Branch prüfen auf `exit 1` und DE+EN-Fehlertext. Nach Implementierung testen: `bash bootstrap-workspace.sh --dry-run TestWS --platform bitbucket; echo "exit: $?"`  
  > *Check plan §2 → `case "$PLATFORM"` block: verify `*)`-branch has `exit 1` and DE+EN error text. After implementation: `bash bootstrap-workspace.sh --dry-run TestWS --platform bitbucket; echo "exit: $?"`*
  > **Ergebnis**: Ja — der Fehlerpfad ist explizit und bilingual beschrieben.

- [x] **CHK012** [Compatibility] Wird `--gitlab-url` mit einem POSIX-kompatiblen `case`-Konstrukt validiert (kein `[[ ]]`)?  
  *Is `--gitlab-url` validated with a POSIX-compatible `case` construct (no `[[ ]]`)?*
  > **Durchführungshinweis**: Plan §2 → `case "$GITLAB_URL" in https://*)` prüfen. Diese Syntax funktioniert in bash 3.x.  
  > *Check plan §2 → `case "$GITLAB_URL" in https://*)`. This syntax works in bash 3.x.*
  > **Ergebnis**: Ja — die URL-Prüfung bleibt bash-3.x-kompatibel.

- [x] **CHK013** [UX] Enthält die „glab nicht installiert"-Fehlermeldung plattformspezifische Installationsanleitung (macOS/Linux + Windows)?  
  *Does the "glab not installed" error message contain platform-specific installation guidance (macOS/Linux + Windows)?*
  > **Durchführungshinweis**: Plan §3 → `glab nicht installiert`-Block prüfen: `brew install glab` (macOS/Linux) UND `winget install GLabCLI.GlabCLI` (Windows) müssen beide vorhanden sein. Zudem DE+EN-Pflicht beachten.  
  > *Check plan §3 → `glab not installed` block: `brew install glab` (macOS/Linux) AND `winget install GLabCLI.GlabCLI` (Windows) must both be present. Also check DE+EN bilingual requirement.*
  > **Ergebnis**: Ja — beide Installationspfade und bilingualer Text sind enthalten.

- [x] **CHK014** [Reuse] Wird die bereits vorhandene `normalize_name()`-Funktion aus `bootstrap-workspace.sh` für die Slug-Normalisierung wiederverwendet?  
  *Is the existing `normalize_name()` function from `bootstrap-workspace.sh` reused for slug normalization?*
  > **Durchführungshinweis**: `scripts/bootstrap-workspace.sh:29-31` lesen — `normalize_name()` ist bereits definiert. Plan §4 → `REPO_SLUG=$(normalize_name "$REPO_NAME")` — kein neuer Code nötig. Sicherstellen dass keine Duplikation der Funktion geplant ist.  
  > *Read `scripts/bootstrap-workspace.sh:29-31` — `normalize_name()` already defined. Plan §4 → `REPO_SLUG=$(normalize_name "$REPO_NAME")` — no new code needed. Ensure no duplication of the function is planned.*
  > **Ergebnis**: Ja — Wiederverwendung ist sauber geplant.

- [x] **CHK015** [ASCII Box] Haben alle neuen Preamble-Box-Zeilen exakt dieselbe Breite wie die bestehenden Zeilen (69 Zeichen)?  
  *Do all new preamble box lines have exactly the same width as existing lines (69 characters)?*
  > **Durchführungshinweis**: Die bestehende Box in `scripts/bootstrap-workspace.sh:78-84` als Referenz nehmen. Das Format `printf "║  Plattform   : %-51s║\n"` ergibt dieselbe Zeilenbreite wie `printf "║  Verzeichnis : %-51s║\n"`.  
  > *Use the existing box in `scripts/bootstrap-workspace.sh:78-84` as the reference. The format `printf "║  Plattform   : %-51s║\n"` yields the same line width as `printf "║  Verzeichnis : %-51s║\n"`.*  
  > **Ergebnis**: Ja — die neue Zeile passt zur bestehenden Boxbreite.

- [x] **CHK016** [Portability] Verwendet der GitLab-Push-Befehl `HEAD` statt eines hardcodierten Branch-Namens (`main`/`master`)?  
  *Does the GitLab push command use `HEAD` instead of a hardcoded branch name (`main`/`master`)?*
  > **Durchführungshinweis**: Plan §6 → `git -C '$WORKSPACE_DIR' push -u origin HEAD` prüfen. `HEAD` ist branch-agnostisch und funktioniert unabhängig von `init.defaultBranch`.  
  > *Check plan §6 → `git -C '$WORKSPACE_DIR' push -u origin HEAD`. `HEAD` is branch-agnostic and works regardless of `init.defaultBranch`.*
  > **Ergebnis**: Ja — der Plan bleibt branch-unabhängig.

---

## 4. Implementation Design — `bootstrap-workspace.ps1`

- [x] **CHK017** [Validation] Gibt es einen expliziten, bilingualen Fehlerpfad für ungültige `-Platform`-Werte, statt sich nur auf `ValidateSet` zu verlassen?  
  *Is there an explicit bilingual error path for invalid `-Platform` values instead of relying only on `ValidateSet`?*
  > **Durchführungshinweis**: Plan §9 gegen FR-013/FR-014 prüfen. Erwartet ist ein manueller Check wie `if ($Platform -notin @('github', 'gitlab')) { Write-Error ... }`.  
  > *Check plan §9 against FR-013/FR-014. Expect a manual check such as `if ($Platform -notin @('github', 'gitlab')) { Write-Error ... }`.*
  > **Ergebnis**: Ja — der Plan enthält jetzt einen expliziten bilingualen Fehlerpfad.

- [x] **CHK018** [Bug] Wird der Hostname in PowerShell ohne `TrimStart('https://')`-Bug abgeleitet?  
  *Is the hostname in PowerShell derived without the `TrimStart('https://')` bug?*
  > **Durchführungshinweis**: Plan §9 prüfen. Erwartet ist Regex- oder Substring-basierte Präfixentfernung, z. B. `($GitLabUrl -replace '^https://', '').TrimEnd('/')`.  
  > *Check plan §9. Expect regex- or substring-based prefix removal, e.g. `($GitLabUrl -replace '^https://', '').TrimEnd('/')`.*
  > **Ergebnis**: Ja — der Plan verwendet jetzt `-replace '^https://'`.

- [x] **CHK019** [State] Wird `$env:GITLAB_HOST` nach jedem `glab`-Aufruf zurückgesetzt, um Zustandslecks in der Session zu vermeiden?  
  *Is `$env:GITLAB_HOST` reset after each `glab` call to avoid state leaks in the session?*
  > **Durchführungshinweis**: Plan §9 glab-checks: `$env:GITLAB_HOST = $gitlabHostname` vor dem Aufruf und `$env:GITLAB_HOST = $null` danach prüfen.  
  > *Check plan §9 glab checks: verify `$env:GITLAB_HOST = $gitlabHostname` before call and `$env:GITLAB_HOST = $null` after.*
  > **Ergebnis**: Ja — Normal- und Fehlerpfad räumen den Host-State wieder auf.

---

## 5. Implementation Design — `bootstrap-project.sh` / `.ps1`

- [x] **CHK020** [Bug] Wird `normalize_name()` für `bootstrap-project.sh` jetzt explizit im Plan ergänzt?  
  *Is `normalize_name()` now explicitly added in the plan for `bootstrap-project.sh`?*
  > **Durchführungshinweis**: Plan §8 prüfen. Erwartet ist ein lokaler Helper vor den Preview-/Action-Helfern.  
  > *Check plan §8. Expect a local helper before the preview/action helpers.*
  > **Ergebnis**: Ja — die Funktion ist im Plan explizit ergänzt.

- [x] **CHK021** [Completeness] Werden `OPT_PLATFORM`, `OPT_GITLAB_URL` und die Hostname-Ableitung im Parsing/Init von `bootstrap-project.sh` beschrieben?  
  *Are `OPT_PLATFORM`, `OPT_GITLAB_URL`, and hostname derivation described in the parsing/initialization of `bootstrap-project.sh`?*
  > **Durchführungshinweis**: Plan §8 gegen `scripts/bootstrap-project.sh:20-57` lesen. Erwartet sind neue Default-Werte, neue Optionen im Parsing-Loop und Hostname-Ableitung.  
  > *Read plan §8 against `scripts/bootstrap-project.sh:20-57`. Expect new default values, new options in the parsing loop, and hostname derivation.*
  > **Ergebnis**: Ja — Parsing und Initialisierung sind jetzt vollständig beschrieben.

- [x] **CHK022** [UX] Wird der Preview-Block in `bootstrap-project.sh` für den GitLab-Pfad aktualisiert?  
  *Is the preview block in `bootstrap-project.sh` updated for the GitLab path?*
  > **Durchführungshinweis**: Plan §8 Preview-Block prüfen. Bei `--platform gitlab` sollen `glab repo create`, `git remote add`, `git push` erscheinen.  
  > *Check the preview block in plan §8. With `--platform gitlab`, it should show `glab repo create`, `git remote add`, and `git push`.*
  > **Ergebnis**: Ja — der Preview-Block ist plattformabhängig geplant.

- [x] **CHK023** [Compatibility] Ist Step 14 (`git push -u origin HEAD`) in `bootstrap-project.sh` ohne Änderung für beide Plattformen kompatibel?  
  *Is Step 14 (`git push -u origin HEAD`) in `bootstrap-project.sh` compatible for both platforms without changes?*
  > **Durchführungshinweis**: `scripts/bootstrap-project.sh:416-428` lesen. Step 14 prüft Remote-Existenz und pusht mit `git push -u origin HEAD` — plattformunabhängig.  
  > *Read `scripts/bootstrap-project.sh:416-428`. Step 14 checks remote existence and pushes with `git push -u origin HEAD` — platform-agnostic.*
  > **Ergebnis**: Ja — Step 14 kann unverändert bleiben.

---

## 6. Dokumentations-Updates

- [x] **CHK024** [Bilingualism] Hat der neue `glab auth login`-Pitfall-Eintrag einen bilingualen Heading im `DE / EN`-Format?  
  *Does the new `glab auth login` pitfall entry have a bilingual heading in `DE / EN` format?*
  > **Durchführungshinweis**: Plan §10 prüfen. Erwartet ist ein Heading im Format `DE / EN`.  
  > *Check plan §10. Expect a heading in `DE / EN` format.*
  > **Ergebnis**: Ja — der Pitfall-Heading ist jetzt bilingual formuliert.

- [x] **CHK025** [Precision] Sind die genauen Abschnittsnamen in `README.md` für die `--platform`-Beispiele präzise benannt?  
  *Are the exact `README.md` section names for the `--platform` examples named precisely?*
  > **Durchführungshinweis**: Plan §10 prüfen. Erwartet sind konkrete Zielstellen unter `### Nächste Schritte / Next steps`, inklusive Workspace-/Projekt-Beispielen und erklärenden Blockquotes.  
  > *Check plan §10. Expect concrete targets under `### Nächste Schritte / Next steps`, including workspace/project examples and explanatory blockquotes.*
  > **Ergebnis**: Ja — die Zielstellen sind jetzt präzise benannt.

- [x] **CHK026** [Completeness] Wurde `glab ≥ 1.40` bereits durch `update-agent-context.sh` in `CLAUDE.md` Active Technologies eingetragen?  
  *Was `glab ≥ 1.40` already added to `CLAUDE.md` Active Technologies by `update-agent-context.sh`?*
  > **Durchführungshinweis**: `grep "glab" CLAUDE.md` ausführen. Erwartetes Ergebnis: Zeile mit `glab ≥ 1.40 (new)` und Tag `(006-gitlab-support)` unter `## Active Technologies`. Falls vorhanden: Task 8 muss diesen Punkt nicht mehr erledigen.  
  > *Run `grep "glab" CLAUDE.md`. Expected result: line with `glab ≥ 1.40 (new)` tagged `(006-gitlab-support)` under `## Active Technologies`. If present: Task 8 need not address this anymore.*
  > **Ergebnis**: Ja — der Plan berücksichtigt jetzt korrekt, dass der Eintrag bereits vorhanden ist.

---

## 7. Implementierungsreihenfolge / Implementation Sequence

- [x] **CHK027** [Sequencing] Ist der kritische Pfad Tasks 1→2→3→4 (sequenziell, gleiche Datei) korrekt als Abhängigkeitskette markiert?  
  *Is the critical path Tasks 1→2→3→4 (sequential, same file) correctly marked as a dependency chain?*
  > **Durchführungshinweis**: Plan §Implementation Sequence → „Critical path: Tasks 1 → 2 → 3 → 4 (sequential, same file)" prüfen.  
  > *Check plan §Implementation Sequence → "Critical path: Tasks 1 → 2 → 3 → 4 (sequential, same file)".*
  > **Ergebnis**: Ja — der kritische Pfad ist sauber markiert.

- [x] **CHK028** [Parallelism] Sind Tasks 5, 6 und 8 korrekt als voneinander unabhängig (parallelisierbar) markiert?  
  *Are Tasks 5, 6, and 8 correctly marked as independent from each other (parallelizable)?*
  > **Durchführungshinweis**: Plan §Implementation Sequence prüfen. Task 5 (`bootstrap-workspace.ps1`) und Task 6 (`bootstrap-project.sh`) greifen auf unterschiedliche Dateien zu; Task 8 betrifft nur Dokumentation.  
  > *Check plan §Implementation Sequence. Task 5 (`bootstrap-workspace.ps1`) and Task 6 (`bootstrap-project.sh`) touch different files; Task 8 affects documentation only.*
  > **Ergebnis**: Ja — die Parallelisierung ist plausibel beschrieben.

---

## 8. Verifikationsplan / Verification Plan

- [x] **CHK029** [Coverage] Enthält der Verifikationsplan jetzt explizite Checks für README-Tabelleneintrag, Self-hosted GitLab und `bootstrap-project`?  
  *Does the Verification Plan now contain explicit checks for the README table entry, self-hosted GitLab, and `bootstrap-project`?*
  > **Durchführungshinweis**: Plan §Verification Plan lesen. Erwartet sind ein README-/Summary-Check, ein Self-hosted-Check mit `--gitlab-url` und ein Bash-Preview-Check für `bootstrap-project.sh`.  
  > *Read plan §Verification Plan. Expect a README/summary check, a self-hosted check using `--gitlab-url`, and a Bash preview check for `bootstrap-project.sh`.*
  > **Ergebnis**: Ja — alle drei Fälle sind explizit im Verifikationsplan enthalten.

- [x] **CHK030** [Parity] Enthält der Verifikationsplan einen PowerShell-Äquivalenztest für `bootstrap-project.ps1` (`-Preview`)?  
  *Does the Verification Plan contain a PowerShell equivalence test for `bootstrap-project.ps1` (`-Preview`)?*
  > **Durchführungshinweis**: Plan §Verification Plan prüfen: erwartet wird ein `pwsh scripts/bootstrap-project.ps1 -ProjectName ... -Preview -Platform gitlab`.  
  > *Check plan §Verification Plan: expect a `pwsh scripts/bootstrap-project.ps1 -ProjectName ... -Preview -Platform gitlab`.*
  > **Ergebnis**: Ja — der PowerShell-Preview-Test ist jetzt enthalten.

---

## Zusammenfassung / Summary

| Abschnitt | Prüfpunkte | GAPs |
|-----------|-----------|------|
| 1. Technischer Kontext | CHK001–CHK004 | 0 |
| 2. Constitution Check | CHK005–CHK009 | 0 |
| 3. `bootstrap-workspace.sh` | CHK010–CHK016 | 0 |
| 4. `bootstrap-workspace.ps1` | CHK017–CHK019 | 0 |
| 5. `bootstrap-project.sh/.ps1` | CHK020–CHK023 | 0 |
| 6. Dokumentation | CHK024–CHK026 | 0 |
| 7. Implementierungsreihenfolge | CHK027–CHK028 | 0 |
| 8. Verifikationsplan | CHK029–CHK030 | 0 |
| **Gesamt / Total** | **30** | **0** |

**Entscheidung / Decision**:
- [x] GENEHMIGT — alle Punkte bestanden, `plan.md` kann unverändert implementiert werden  
  *APPROVED — all items passed, `plan.md` can be implemented as-is*
- [x] GENEHMIGT NACH KORREKTUREN — nicht zutreffend, da keine GAPs mehr offen sind
  *APPROVED AFTER CORRECTIONS — not applicable because no gaps remain open*
- [x] ABGELEHNT — nicht zutreffend, da keine wesentliche Überarbeitung erforderlich ist
  *REJECTED — not applicable because no substantial revision is required*
