# Feature Specification: GitLab-Support
# Lastenheft: GitLab-Unterstützung in Bootstrap-Skripten

**Feature Branch**: `feat/gitlab-support` *(wird nach Spec-kit-Lauf aktualisiert / updated after Spec-kit run)*
**Erstellt / Created**: 2026-04-08
**Status**: Draft
**Konstitutions-Version / Constitution Version**: 1.1.0
**Autor / Author**: hindermath (`hindermath`)

---

## Dateibenennungs-Konvention / File Naming Convention

Dieses Lastenheft folgt der Projektkonvention:

```
Lastenheft_{KurzName}.{branch-name}.md
```

Aktueller Stand vor Spec-kit-Durchlauf: `Lastenheft_GitLab_Support.md`
Nach Spec-kit-Durchlauf: `Lastenheft_GitLab_Support.{branch-name}.md`

---

## Anforderungskatalog (Originalanforderung) / Requirements Catalog (Original Request)

> Dieses Kapitel dokumentiert die ursprüngliche Anforderung vollständig und
> unverändert. Damit bleibt die Entstehungsgeschichte nachvollziehbar.
>
> *This chapter documents the original requirement in full and unchanged, ensuring
> full traceability of the specification's origins.*

### Originaltext (DE)

> Das Bootstrap-Skript (`bootstrap-workspace.sh` / `.ps1`) unterstützt derzeit
> ausschließlich GitHub als Remote-Plattform (via `gh repo create`). Das Projekt
> soll erweitert werden, sodass Nutzer wahlweise **GitHub** oder **GitLab** als
> Zielplattform angeben können. Die Erweiterung soll sowohl in den
> Bootstrap-Workspace-Skripten als auch in den Bootstrap-Project-Skripten
> umgesetzt werden und rückwärtskompatibel bleiben.

### Klärungsergebnisse / Clarification Outcomes

| Frage / Question | Antwort / Answer |
|---|---|
| Welche GitLab-Variante? | `gitlab.com` (SaaS) als primäres Ziel; Self-hosted GitLab über URL-Parameter |
| GitLab-CLI (`glab`)? | Ja — `glab repo create` analog zu `gh repo create` |
| Rückwärtskompatibilität? | Ja — Standard bleibt GitHub; GitLab nur bei explizitem `--platform gitlab` |
| bootstrap-project ebenfalls? | Ja — `bootstrap-project.sh/.ps1` ebenfalls anpassen |
| README / Dokumentation? | Ja — alle plattformspezifischen Abschnitte aktualisieren |
| Self-hosted GitLab? | Optionale URL via `--gitlab-url`; Default: `https://gitlab.com` |
| Sichtbarkeit | Privates Repo — analog zu GitHub |

---

## Systemüberblick / System Overview

### Ist-Zustand / Current State

```
╔══════════════════════════════════════════════════════════════════════╗
║  GitLab-Support — Ist-Zustand / Current State                        ║
╠══════════════════════════════════════════════════════════════════════╣
║  Komponente                          Status   Befund                 ║
║  ──────────────────────────────────  ──────   ───────────────────── ║
║  bootstrap-workspace.sh              ✗ FEHLT  nur GitHub (gh)        ║
║  bootstrap-workspace.ps1             ✗ FEHLT  nur GitHub (gh)        ║
║  bootstrap-project.sh                ✗ FEHLT  nur GitHub (gh)        ║
║  bootstrap-project.ps1               ✗ FEHLT  nicht geprüft          ║
║  README.md (Nächste Schritte)        ~ WARN   GitLab auth erwähnt,   ║
║                                               Bootstrap nur GitHub   ║
║  README.md (Ersteinrichtung)         ~ WARN   glab auth erwähnt,     ║
║                                               kein Bootstrap-Kontext ║
║  check-homogeneity.sh/.ps1           ? OFFEN  plattformneutral?      ║
╠══════════════════════════════════════════════════════════════════════╣
║  Legende: ✓ OK · ✗ FEHLT · ~ WARN · ? OFFEN                         ║
╚══════════════════════════════════════════════════════════════════════╝
```

### Ziel-Zustand / Target State

Die Bootstrap-Skripte erkennen die gewünschte Plattform per Parameter und
rufen entweder `gh repo create` (GitHub) oder `glab repo create` (GitLab) auf.
Alle anderen Schritte (git init, Scripts kopieren, Hooks installieren, README
aktualisieren) bleiben identisch.

*The bootstrap scripts detect the desired platform via a parameter and call
either `gh repo create` (GitHub) or `glab repo create` (GitLab). All other
steps (git init, copying scripts, installing hooks, updating README) remain
identical.*

---

## Funktionale Anforderungen / Functional Requirements

### FR-01 — Plattform-Parameter / Platform Parameter

**bootstrap-workspace.sh / .ps1** erhält einen neuen optionalen Parameter:

```text
--platform <github|gitlab>   (Bash)
-Platform <github|gitlab>    (PowerShell)
```

- Standard / Default: `github`
- Zulässige Werte / Valid values: `github`, `gitlab`
- Ungültige Werte erzeugen eine Fehlermeldung und beenden das Skript mit Exit-Code 1.

*`bootstrap-workspace.sh / .ps1` receives a new optional parameter. Default is
`github`. Invalid values produce an error message and exit with code 1.*

---

### FR-02 — GitLab-URL-Parameter / GitLab URL Parameter

Für Self-hosted GitLab-Instanzen:

```text
--gitlab-url <https://gitlab.example.com>   (Bash)
-GitLabUrl <https://gitlab.example.com>     (PowerShell)
```

- Standard / Default: `https://gitlab.com`
- Wird nur ausgewertet wenn `--platform gitlab` gesetzt ist.
- Wird an `glab` als `--hostname` übergeben.

*For self-hosted GitLab instances. Only evaluated when `--platform gitlab` is
set. Passed to `glab` as `--hostname`.*

---

### FR-03 — GitHub-Pfad (unverändert) / GitHub Path (Unchanged)

Bei `--platform github` (oder ohne Angabe) verhält sich das Skript exakt wie
bisher: `gh repo create … --private --source … --remote origin --push`.

*When `--platform github` (or no argument), the script behaves exactly as
before.*

---

### FR-04 — GitLab-Pfad / GitLab Path

Bei `--platform gitlab`:

1. GitLab-Benutzername ermitteln:
   ```bash
   GITLAB_USER=$(glab api user --jq '.username')
   ```
   PowerShell:
   ```powershell
   $gitlabUser = (glab api user --jq '.username')
   ```

2. Privates GitLab-Repo erstellen:
   ```bash
   glab repo create "$REPO_NAME" --private --description "$REPO_DESC"
   ```

3. Remote setzen und pushen:
   ```bash
   git -C "$WORKSPACE_DIR" remote add origin "https://gitlab.com/$GITLAB_USER/$REPO_NAME.git"
   git -C "$WORKSPACE_DIR" push -u origin main
   ```

4. Falls `--gitlab-url` angegeben: URL entsprechend ersetzen.

*When `--platform gitlab`: detect username via `glab api`, create private repo,
set remote, and push.*

---

### FR-05 — bootstrap-project.sh / .ps1

`bootstrap-project.sh` und `bootstrap-project.ps1` erhalten dieselben Parameter
`--platform` und `--gitlab-url` / `-Platform` und `-GitLabUrl` mit identischer
Logik wie FR-01–FR-04.

Der `--no-remote`-Flag bleibt unverändert erhalten.

*`bootstrap-project.sh` and `.ps1` receive the same parameters with identical
logic. The `--no-remote` flag remains unchanged.*

---

### FR-06 — Präambel-Ausgabe / Preamble Output

Die Präambel-Box (╔…╗) zeigt die gewählte Plattform an:

```text
║  Plattform   : GitHub (privat)                                    ║
```

oder:

```text
║  Plattform   : GitLab — https://gitlab.com (privat)              ║
```

*The preamble box displays the chosen platform.*

---

### FR-07 — README.md-Tabelle / README.md Table

Der automatisch eingefügte Workspace-Tabellen-Eintrag in `~/README.md` verlinkt
auf die korrekte Plattform-URL:

| Plattform | URL-Muster |
|---|---|
| GitHub | `https://github.com/$GH_USER/$REPO_NAME` |
| GitLab | `https://gitlab.com/$GITLAB_USER/$REPO_NAME` (oder custom URL) |

*The auto-inserted workspace table entry in `~/README.md` links to the correct
platform URL.*

---

### FR-08 — Abschluss-Ausgabe / Summary Output

Die Abschluss-Ausgabe zeigt plattformkorrekte URLs:

```text
  Repo   : https://gitlab.com/USER/REPO_NAME
  Clone  : git clone https://gitlab.com/USER/REPO_NAME.git ~/WORKSPACE_NAME
```

*The summary output shows platform-correct URLs.*

---

### FR-09 — Dry-Run / WhatIf

`--dry-run` (Bash) und `-WhatIf` (PowerShell) zeigen alle geplanten GitLab-
Aktionen ohne Ausführung an — analog zum bestehenden GitHub-Dry-Run-Verhalten.

*`--dry-run` and `-WhatIf` show all planned GitLab actions without executing
them — analogous to existing GitHub dry-run behavior.*

---

### FR-10 — Authentifizierungsprüfung / Authentication Check

Das Skript prüft, ob das passende CLI-Tool authentifiziert ist:

- GitHub: `gh auth status` → Fehler wenn nicht eingeloggt
- GitLab: `glab auth status` → Fehler wenn nicht eingeloggt

Fehlermeldung (DE/EN):
```text
Fehler: Nicht bei GitLab authentifiziert. Bitte 'glab auth login' ausführen.
Error: Not authenticated with GitLab. Please run 'glab auth login'.
```

*The script checks whether the matching CLI tool is authenticated, with
bilingual error messages.*

---

### FR-11 — Tool-Verfügbarkeitsprüfung / Tool Availability Check

Das Skript prüft, ob das benötigte CLI-Tool installiert ist:

- GitHub: `gh` muss vorhanden sein (bereits implementiert)
- GitLab: `glab` muss vorhanden sein; fehlt es, wird eine Installationsanleitung
  ausgegeben:

```text
Fehler: glab (GitLab CLI) ist nicht installiert.
  macOS/Linux: brew install glab
  Windows:     winget install GLabCLI.GlabCLI
Error: glab (GitLab CLI) is not installed.
```

*The script checks whether the required CLI tool is installed and provides
installation guidance if missing.*

---

## Nicht-funktionale Anforderungen / Non-Functional Requirements

### NFR-01 — Rückwärtskompatibilität / Backward Compatibility

Alle bestehenden Aufrufe ohne `--platform`-Parameter funktionieren unverändert.
Kein bestehender Workflow wird gebrochen.

*All existing calls without `--platform` parameter continue to work unchanged.*

---

### NFR-02 — Bilingualität / Bilingualism

Alle neuen Benutzerausgaben (Fehlermeldungen, Statuszeilen, Zusammenfassungen)
sind bilingual: Deutsch zuerst, dann Englisch (CEFR B2).

*All new user-facing output is bilingual: German first, then English (CEFR B2).*

---

### NFR-03 — Konsistenz Bash / PowerShell

Bash- und PowerShell-Varianten müssen funktional äquivalent sein. Parameternamen
folgen der jeweiligen Konvention (kebab-case für Bash, PascalCase für PS).

*Bash and PowerShell variants must be functionally equivalent. Parameter names
follow their respective conventions.*

---

### NFR-04 — Dokumentation / Documentation

`README.md` wird aktualisiert:

1. In „Nächste Schritte": Bootstrap-Befehle mit optionalem `--platform gitlab`
2. In „Ersteinrichtung": Authentifizierungs-Abschnitt um `glab`-Hinweis ergänzen
   (bereits vorhanden, ggf. Bootstrap-Kontext ergänzen)
3. In der Kopfzeile der Bootstrap-Skripte: `--platform`-Dokumentation

*`README.md` is updated: bootstrap commands with optional `--platform gitlab` in
"Nächste Schritte"; authentication section enriched with bootstrap context.*

---

### NFR-05 — Kein Self-Hosted GitHub (Scope-Grenze)

GitHub Enterprise Server (GHES) ist **nicht** im Scope. Nur `github.com` und
`gitlab.com` (+ Self-hosted GitLab via `--gitlab-url`).

*GitHub Enterprise Server is out of scope. Only `github.com` and `gitlab.com`
(plus self-hosted GitLab via `--gitlab-url`).*

---

## Abgrenzung / Out of Scope

| Thema / Topic | Begründung / Reason |
|---|---|
| Bitbucket | Kein `blab`-CLI-Äquivalent; zu geringe Relevanz im Projektzusammenhang |
| Gitea / Forgejo | Nischenplattform; separates Feature bei Bedarf |
| GitHub Enterprise Server | Separates Feature bei Bedarf |
| OAuth-Flows / PAT-Management | `glab auth login` übernimmt dies; kein eigener Auth-Code |
| CI/CD-Pipeline-Konfiguration | Separates Feature |
| Bestehende Workspaces migrieren | Separates Feature (migrate-workspace) |

---

## Akzeptanzkriterien / Acceptance Criteria

| ID | Kriterium / Criterion | Testmethode |
|---|---|---|
| AC-01 | `bootstrap-workspace.sh --dry-run TestWS --platform gitlab` gibt GitLab-Aktionen aus | `--dry-run` |
| AC-02 | `bootstrap-workspace.sh TestWS --platform gitlab` erstellt privates GitLab-Repo | Live-Ausführung |
| AC-03 | Aufruf ohne `--platform` erstellt wie bisher ein GitHub-Repo | Regressions-Check |
| AC-04 | `--platform invalid` bricht mit Exit-Code 1 und Fehlermeldung ab | Fehlertest |
| AC-05 | `glab` nicht installiert → bilingualer Fehler + Installationshinweis | Fehlertest |
| AC-06 | `glab auth status` nicht OK → bilingualer Fehler | Fehlertest |
| AC-07 | PowerShell-Variante verhält sich äquivalent zu Bash-Variante | Cross-Plattform-Test |
| AC-08 | `~/README.md`-Tabelleneintrag verlinkt auf GitLab-URL | Sichtprüfung |
| AC-09 | Self-hosted GitLab via `--gitlab-url https://gitlab.example.com` erreichbar | Live-Ausführung |
| AC-10 | bootstrap-project.sh/.ps1 unterstützt `--platform gitlab` analog | Live-Ausführung |

---

## Technische Abhängigkeiten / Technical Dependencies

| Tool | Version | Zweck / Purpose |
|---|---|---|
| `glab` (GitLab CLI) | ≥ 1.40 | `glab repo create`, `glab api user`, `glab auth status` |
| `gh` (GitHub CLI) | ≥ 2.30 | unverändert (GitHub-Pfad) |
| `bash` | ≥ 5 | Bootstrap-Skripte (macOS/Linux) |
| `pwsh` | ≥ 7 | Bootstrap-Skripte (Windows) |
| `git` | ≥ 2.30 | `git remote add`, `git push` |

---

## Dateien mit Änderungsbedarf / Files Requiring Changes

| Datei / File | Art der Änderung / Type of Change |
|---|---|
| `scripts/bootstrap-workspace.sh` | `--platform` + `--gitlab-url` Parameter; GitLab-Pfad |
| `scripts/bootstrap-workspace.ps1` | `-Platform` + `-GitLabUrl` Parameter; GitLab-Pfad |
| `scripts/bootstrap-project.sh` | `--platform` + `--gitlab-url` Parameter; GitLab-Pfad |
| `scripts/bootstrap-project.ps1` | `-Platform` + `-GitLabUrl` Parameter; GitLab-Pfad |
| `README.md` | Bootstrap-Befehle mit `--platform`-Hinweis |
| `AGENTS.md` | Pitfall-Eintrag: `glab auth login` in background processes |
| `CLAUDE.md` | dito |
| `GEMINI.md` | dito |
| `.github/copilot-instructions.md` | dito |

---

## Risiken / Risks

| ID | Risiko / Risk | Eintrittswahrscheinlichkeit | Auswirkung | Maßnahme |
|---|:---|:---:|:---:|---|
| R-01 | `glab` API-Änderungen brechen Skript | Niedrig | Mittel | Versionsprüfung; Tests |
| R-02 | Self-hosted GitLab mit abweichender API | Mittel | Niedrig | `--gitlab-url` dokumentieren; Fehlerausgabe verbessern |
| R-03 | `glab repo create` verhält sich anders als `gh repo create` | Mittel | Mittel | Dry-Run testen; Fallback dokumentieren |
| R-04 | README-Tabellen-Update mit GitLab-URL fehlerhaft | Niedrig | Niedrig | Regressions-Test für README-Insertion |

---

## Spec-Kit-Hinweise / Spec-Kit Notes

> Dieses Lastenheft ist als Eingabe für `specify specify` konzipiert.
> Nach dem Spec-kit-Lauf:
>
> 1. Feature Branch wird von Spec-kit vergeben (z. B. `006-gitlab-support`)
> 2. Datei umbenennen: `Lastenheft_GitLab_Support.006-gitlab-support.md`
> 3. `**Feature Branch**`-Feld oben aktualisieren
>
> *This Lastenheft is designed as input for `specify specify`. After the Spec-kit
> run, rename the file with the assigned branch suffix and update the Feature
> Branch field.*

```bash
# Spec-Kit starten / Start Spec-Kit
cd ~/home-baseline-tmp
specify specify Lastenheft_GitLab_Support.md
```
