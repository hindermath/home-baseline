# Feature Specification: Workspace- und Projekt-Teardown
# Lastenheft: Fehlerfreies Entfernen von Workspaces und Projekten

**Feature Branch**: `feat/workspace-teardown` *(wird nach Spec-kit-Lauf aktualisiert / updated after Spec-kit run)*
**Erstellt / Created**: 2026-04-08
**Status**: Draft
**Verwandte Lastenheft / Related Lastenheft**: `Lastenheft_GitLab_Support.md`, `Lastenheft_CICD_Pipeline_Konfiguration.md`, `Lastenheft_Workspace_Migration.md`
**Konstitutions-Version / Constitution Version**: 1.1.0
**Autor / Author**: hindermath (`hindermath`)

---

> ## ⚠️ Implementierungsreihenfolge / Implementation Order
>
> Diese Lastenheft-Datei ist **unabhängig** von den anderen und kann
> parallel oder in beliebiger Reihenfolge implementiert werden. Sie ergänzt
> die Bootstrap- und Migrations-Skripte um den umgekehrten Lifecycle-Schritt.
>
> Empfohlene Gesamtreihenfolge aller fünf Features:
>
> ```text
> Schritt 0 → Lastenheft_Git_Config_Scope.md               (ZUERST oder parallel — Grundlage)
> Schritt 1 → Lastenheft_GitLab_Support.md
> Schritt 2 → Lastenheft_CICD_Pipeline_Konfiguration.md    (erfordert Schritt 1)
> Schritt 3 → Lastenheft_Workspace_Migration.md             (erfordert Schritt 1 + 2)
> Schritt 4 → Lastenheft_Workspace_Teardown.md              ← DU BIST HIER / YOU ARE HERE
>             (unabhängig — kann parallel zu Schritt 0–3 begonnen werden)
> ```
>
> *This Lastenheft is independent of the other three and can be implemented in
> parallel or in any order. It adds the reverse lifecycle step to bootstrap and
> migration scripts.*

---

## Dateibenennungs-Konvention / File Naming Convention

```
Lastenheft_{KurzName}.{branch-name}.md
```

Aktueller Stand vor Spec-kit-Durchlauf: `Lastenheft_Workspace_Teardown.md`
Nach Spec-kit-Durchlauf: `Lastenheft_Workspace_Teardown.{branch-name}.md`

---

## Anforderungskatalog (Originalanforderung) / Requirements Catalog (Original Request)

> Dieses Kapitel dokumentiert die ursprüngliche Anforderung vollständig und
> unverändert.
>
> *This chapter documents the original requirement in full and unchanged.*

### Originaltext (DE)

> Es wird noch ein Lastenheft benötigt, das beschreibt wie Git-Repos auch wieder
> fehler- und rückstandsfrei entfernt werden können. Da können vielleicht auch
> die vorhandenen Skripte um einen Parameter und Funktionalität erweitert werden.

### Klärungsergebnisse / Clarification Outcomes

| Frage / Question | Antwort / Answer |
|---|---|
| Neues Skript oder Erweiterung? | Neues Skript `teardown-workspace.sh/.ps1` + optionaler `--teardown`-Parameter in `bootstrap-workspace.sh/.ps1` |
| Was genau wird entfernt? | Lokales Verzeichnis + GitHub/GitLab-Remote-Repo + README.md-Tabelleneintrag + `.gitignore`-Eintrag in `~/` |
| Backup vor Löschung? | Ja — optionaler `--backup`-Parameter erzeugt ein `.tar.gz`-Archiv |
| GitHub-Repo zwingend löschen? | Nein — `--keep-remote` behält das Remote-Repo |
| Bestätigung erforderlich? | Ja — interaktiver Prompt + `--yes` für CI/non-interaktiv |
| GitLab-Unterstützung? | Ja — Remote-URL-Erkennung analog zu `Lastenheft_Workspace_Migration.md` |
| Projekte innerhalb des Workspace? | Warnung ausgeben; `--recursive` löscht auch Level-2-Projekte |

---

## Systemüberblick / System Overview

### Ist-Zustand / Current State

```
╔══════════════════════════════════════════════════════════════════════╗
║  Teardown — Ist-Zustand / Current State                              ║
╠══════════════════════════════════════════════════════════════════════╣
║  Komponente                           Status   Befund                ║
║  ───────────────────────────────────  ──────   ──────────────────── ║
║  teardown-workspace.sh                ✗ FEHLT  kein Skript           ║
║  teardown-workspace.ps1               ✗ FEHLT  kein Skript           ║
║  bootstrap-workspace --teardown       ✗ FEHLT  kein Parameter        ║
║  README.md-Eintrag entfernen          ✗ FEHLT  manuell nötig         ║
║  .gitignore-Eintrag entfernen         ✗ FEHLT  manuell nötig         ║
║  Remote-Repo löschen (gh/glab)        ✗ FEHLT  manuell nötig         ║
║  Backup vor Löschung                  ✗ FEHLT  kein Mechanismus      ║
║  Uncommittete Änderungen prüfen       ✗ FEHLT  kein Schutz           ║
║  Level-2-Projekte berücksichtigen     ✗ FEHLT  kein Schutz           ║
╠══════════════════════════════════════════════════════════════════════╣
║  Legende: ✓ OK · ✗ FEHLT                                            ║
╚══════════════════════════════════════════════════════════════════════╝
```

### Lifecycle-Überblick / Lifecycle Overview

```text
bootstrap-workspace  →  (Nutzung)  →  teardown-workspace
     ↓                                       ↑
  Erstellt:                           Entfernt:
  - ~/WorkspaceName/                  - ~/WorkspaceName/
  - GitHub/GitLab-Repo                - Remote-Repo (optional)
  - ~/README.md Tabellenzeile         - ~/README.md Tabellenzeile
  - ~/.gitignore Eintrag              - ~/.gitignore Eintrag
  - ~/scripts/ Kopie                  - Backup (optional)
  - pre-push Hook
```

---

## Funktionale Anforderungen / Functional Requirements

### FR-01 — Neues Skript: teardown-workspace.sh / .ps1

Zwei neue Skripte werden erstellt:

- `scripts/teardown-workspace.sh` (Bash — macOS/Linux)
- `scripts/teardown-workspace.ps1` (PowerShell 7 — Windows)

Verwendung / Usage:
```bash
bash ~/scripts/teardown-workspace.sh <WorkspaceName> [Optionen]
bash ~/scripts/teardown-workspace.sh --dry-run MyProjects
```
```powershell
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName MyProjects [-WhatIf]
```

*Two new scripts are created for Bash and PowerShell.*

---

### FR-02 — Sicherheitsprüfungen vor dem Teardown / Pre-Teardown Safety Checks

Vor jeder destruktiven Aktion werden folgende Prüfungen durchgeführt:

1. **Uncommittete Änderungen**: `git status --porcelain` — Warnung ausgeben,
   bei `--force` ignorieren, sonst abbrechen
2. **Ungepushte Commits**: `git log @{u}..HEAD` — Warnung ausgeben,
   bei `--force` ignorieren, sonst abbrechen
3. **Level-2-Projekte vorhanden**: Auflistung aller `.git`-Unterverzeichnisse —
   Warnung + Bestätigung erforderlich, außer `--recursive`
4. **Remote-Repo nicht erreichbar**: Warnung, Teardown trotzdem möglich mit
   `--keep-remote`

Fehlermeldungen bilingual (DE/EN).

*Safety checks before any destructive action: uncommitted changes, unpushed
commits, Level-2 projects, unreachable remote.*

---

### FR-03 — Backup-Option / Backup Option

Mit `--backup` / `-Backup`:

```bash
bash ~/scripts/teardown-workspace.sh MyProjects --backup
```

Erzeugt vor der Löschung:
```text
~/MyProjects-backup-YYYY-MM-DD.tar.gz
```

- Enthält das gesamte lokale Verzeichnis (inkl. `.git/`)
- Ausgabe des Backup-Pfads im Abschlussbericht
- Backup liegt **außerhalb** des zu löschenden Verzeichnisses

*With `--backup`, a `.tar.gz` archive is created in `~/` before deletion.*

---

### FR-04 — Lokales Verzeichnis entfernen / Remove Local Directory

```bash
rm -rf "$HOME/$WORKSPACE_NAME"
```

- Nur nach erfolgreichen Sicherheitsprüfungen (FR-02) und Nutzerbestätigung
- Bei `--dry-run` / `-WhatIf`: nur Ausgabe, keine Aktion

*Removes the local directory after safety checks and user confirmation.*

---

### FR-05 — Remote-Repo entfernen / Remove Remote Repository

Standardmäßig wird das Remote-Repo **ebenfalls gelöscht**:

```bash
# GitHub
gh repo delete "$REPO_FULL_NAME" --yes

# GitLab
glab repo delete "$REPO_FULL_NAME" --yes
```

Die Plattform wird automatisch erkannt (analog FR-04 aus
`Lastenheft_Workspace_Migration.md`):
```bash
remote_url=$(git -C "$WORKSPACE_DIR" remote get-url origin 2>/dev/null || echo "")
```

Mit `--keep-remote` / `-KeepRemote` wird das Remote-Repo behalten.

*By default, the remote repo is also deleted. Platform auto-detection via
remote URL. `--keep-remote` skips remote deletion.*

---

### FR-06 — ~/README.md-Tabelleneintrag entfernen / Remove README Table Entry

Der beim Bootstrap eingefügte Tabelleneintrag wird entfernt:

```bash
sed -i '' "/~\/$WORKSPACE_NAME\//d" "$HOME/README.md"
git -C "$HOME" add README.md
git -C "$HOME" commit -m "chore: $WORKSPACE_NAME aus ~/README.md entfernt (teardown)"
```

- Nur wenn der Eintrag vorhanden ist (kein Fehler bei fehlendem Eintrag)
- `~/` hat kein Remote — kein Push nötig

*Removes the workspace table row from `~/README.md` and commits the change.*

---

### FR-07 — ~/.gitignore-Eintrag entfernen / Remove .gitignore Entry

Der beim Bootstrap eingefügte `.gitignore`-Eintrag (`!$WORKSPACE_NAME/` o.ä.)
wird entfernt — sofern vorhanden:

```bash
sed -i '' "/^\!$WORKSPACE_NAME\//d" "$HOME/.gitignore"
```

- Nur wenn Eintrag vorhanden (kein Fehler bei fehlendem Eintrag)
- Commit in `~/` zusammen mit README-Änderung (FR-06)

*Removes the workspace entry from `~/.gitignore`.*

---

### FR-08 — Rekursiver Teardown für Level-2-Projekte / Recursive Level-2 Teardown

Mit `--recursive` / `-Recursive`:

Vor dem Löschen des Workspace werden alle Level-2-Projekte (Unterverzeichnisse
mit `.git/`) einzeln abgearbeitet:

1. Uncommittete/ungepushte Änderungen prüfen (FR-02)
2. Remote-Repo löschen (FR-05, außer `--keep-remote`)
3. Lokales Verzeichnis löschen (FR-04)

Ohne `--recursive` bei vorhandenen Level-2-Projekten: Abbruch mit Warnung.

*With `--recursive`, Level-2 projects within the workspace are torn down
individually before the workspace itself.*

---

### FR-09 — Erweiterung bootstrap-workspace: --teardown / -Teardown

Als Alternative zu einem separaten Skript erhält `bootstrap-workspace.sh/.ps1`
einen neuen Parameter:

```bash
bash ~/scripts/bootstrap-workspace.sh --teardown MyProjects [--backup] [--keep-remote]
pwsh ~/scripts/bootstrap-workspace.ps1 -Teardown -WorkspaceName MyProjects [-Backup] [-KeepRemote]
```

Dieser Parameter delegiert intern an `teardown-workspace.sh/.ps1`.
Zweck: Nutzer müssen sich nur ein Skript merken.

*`bootstrap-workspace` receives a `--teardown` parameter that delegates to
`teardown-workspace`. Users only need to remember one script.*

---

### FR-10 — Präambel-Box / Preamble Box

Das Skript gibt vor der Ausführung eine Übersicht der geplanten Aktionen aus:

```text
╔══════════════════════════════════════════════════════╗
║  teardown-workspace — Workspace entfernen            ║
╚══════════════════════════════════════════════════════╝

  Workspace : ~/MyProjects
  Remote    : github.com/hindermath/myprojects-baseline
  Backup    : ~/MyProjects-backup-2026-04-08.tar.gz
  Geplante Aktionen / Planned actions:
    ✗ Lokales Verzeichnis ~/MyProjects/ löschen
    ✗ GitHub-Repo hindermath/myprojects-baseline löschen
    ✓ ~/README.md Tabelleneintrag entfernen
    ✓ ~/.gitignore Eintrag entfernen
    ✓ Backup erstellen
```

*The script shows a preamble box with all planned actions before execution.*

---

### FR-11 — Interaktive Bestätigung / Interactive Confirmation

```text
⚠️  Diese Aktion ist nicht rückgängig zu machen (außer via Backup)!
    This action cannot be undone (except via backup)!

Fortfahren? / Continue? [j/y/N]
```

- Standard: Abbruch (kein Enter → kein Löschen)
- `--yes` / `-Yes`: kein Prompt (für CI / Scripting)

*Interactive confirmation with double-check for destructive actions.
`--yes` skips the prompt.*

---

### FR-12 — Dry-Run / WhatIf

`--dry-run` (Bash) / `-WhatIf` (PowerShell):

- Zeigt alle geplanten Aktionen ohne Ausführung
- Keine Dateien werden gelöscht, kein Remote wird entfernt
- Ausgabe markiert mit `[dry-run]`

*`--dry-run` / `-WhatIf` shows all planned actions without execution.*

---

### FR-13 — Abschlussbericht / Summary Report

```text
╔══════════════════════════════════════════════════════╗
║  Teardown abgeschlossen / Teardown complete           ║
╚══════════════════════════════════════════════════════╝

  ✓ Backup erstellt  : ~/MyProjects-backup-2026-04-08.tar.gz
  ✓ Remote gelöscht  : github.com/hindermath/myprojects-baseline
  ✓ Lokal gelöscht   : ~/MyProjects/
  ✓ README.md        : Tabellenzeile entfernt
  ✓ .gitignore       : Eintrag entfernt
  ✓ ~/  committet    : chore: MyProjects aus ~/README.md entfernt
```

*A summary report lists all completed actions.*

---

## Nicht-funktionale Anforderungen / Non-Functional Requirements

### NFR-01 — Keine ungewollten Seiteneffekte / No Unintended Side Effects

Das Skript darf **ausschließlich** den angegebenen Workspace und seine
explizit aufgelisteten Artefakte entfernen. Keine anderen Workspaces,
keine `~/`-Dateien außer README.md und .gitignore.

*The script must only remove the specified workspace and its explicitly listed
artifacts. No other files or directories.*

---

### NFR-02 — Idempotenz bei Fehlern / Idempotency on Errors

Schlägt ein Schritt fehl (z. B. Remote nicht erreichbar), werden die
verbleibenden Schritte fortgesetzt und der Fehlschlag im Abschlussbericht
vermerkt. Exit-Code 1 (partial).

*If a step fails, remaining steps continue. Failures are listed in the
summary report. Exit code 1 (partial).*

---

### NFR-03 — Exit-Code-Protokoll / Exit Code Protocol

| Exit-Code | Bedeutung / Meaning |
|:---:|---|
| 0 | Vollständiger Teardown / Complete teardown |
| 1 | Partiell — Warnungen / Partial — warnings present |
| 2 | Abgebrochen — Sicherheitsprüfung / Aborted — safety check failed |

---

### NFR-04 — Bilingualität / Bilingualism

Alle Benutzerausgaben bilingual: Deutsch zuerst, Englisch (CEFR B2).

---

### NFR-05 — Konsistenz Bash / PowerShell

Bash- und PowerShell-Varianten sind funktional äquivalent. Parameter-Namen
folgen den jeweiligen Konventionen (kebab-case / PascalCase).

---

## Abgrenzung / Out of Scope

| Thema / Topic | Begründung / Reason |
|---|---|
| Löschen von Projekten innerhalb eines bestehenden Workspace ohne Workspace-Teardown | Separates `teardown-project`-Feature bei Bedarf |
| Wiederherstellen aus Backup | `tar xzf` ist ausreichend; kein eigenes Restore-Skript nötig |
| Löschen von GitHub-Teams, Webhooks, Secrets | Zu projektspezifisch |
| Archivierung statt Löschung (GitHub Repo archivieren) | Separates Feature bei Bedarf |
| `home-baseline` selbst löschen | Explizit ausgeschlossen — Schutz vor versehentlichem Selbst-Teardown |

---

## Akzeptanzkriterien / Acceptance Criteria

| ID | Kriterium / Criterion | Testmethode |
|---|---|---|
| AC-01 | `teardown-workspace.sh --dry-run TestWS` zeigt alle Aktionen ohne Ausführung | `--dry-run` |
| AC-02 | `teardown-workspace.ps1 -DryRun -WorkspaceName TestWS` äquivalent | Cross-Plattform |
| AC-03 | Uncommittete Änderungen → Abbruch mit Fehlermeldung | Fehlertest |
| AC-04 | Ungepushte Commits → Abbruch mit Fehlermeldung | Fehlertest |
| AC-05 | `--backup` erzeugt `.tar.gz` in `~/` vor Löschung | Live-Test |
| AC-06 | Lokales Verzeichnis nach Teardown nicht mehr vorhanden | Live-Test |
| AC-07 | GitHub-Repo nach Teardown gelöscht (ohne `--keep-remote`) | Live-Test |
| AC-08 | `--keep-remote` → Remote-Repo bleibt erhalten | Live-Test |
| AC-09 | `~/README.md` Tabellenzeile entfernt + committet | Sichtprüfung |
| AC-10 | `~/.gitignore` Eintrag entfernt | Sichtprüfung |
| AC-11 | Level-2-Projekte vorhanden ohne `--recursive` → Abbruch mit Warnung | Fehlertest |
| AC-12 | `--recursive` löscht Level-2-Projekte vor Workspace | Live-Test |
| AC-13 | `bootstrap-workspace --teardown` delegiert korrekt | Live-Test |
| AC-14 | `home-baseline` als WorkspaceName → Abbruch mit Schutzfehler | Fehlertest |
| AC-15 | Abschlussbericht bilingual und vollständig | Sichtprüfung |

---

## Technische Abhängigkeiten / Technical Dependencies

| Tool | Zweck / Purpose |
|---|---|
| `gh` ≥ 2.30 | `gh repo delete` (GitHub) |
| `glab` ≥ 1.40 | `glab repo delete` (GitLab, optional) |
| `git` ≥ 2.30 | Uncommittete/ungepushte Prüfung, Commits in `~/` |
| `tar` | Backup-Archivierung |
| `bash` ≥ 5 / `pwsh` ≥ 7 | Laufzeitumgebung |
| `scripts/bootstrap-workspace.sh/.ps1` | `--teardown`-Erweiterung (FR-09) |

---

## Dateien mit Änderungsbedarf / Files Requiring Changes

| Datei / File | Art der Änderung / Type of Change |
|---|---|
| `scripts/teardown-workspace.sh` | Neu erstellen |
| `scripts/teardown-workspace.ps1` | Neu erstellen |
| `scripts/bootstrap-workspace.sh` | `--teardown`-Parameter hinzufügen (FR-09) |
| `scripts/bootstrap-workspace.ps1` | `-Teardown`-Parameter hinzufügen (FR-09) |
| `README.md` | Teardown-Befehle dokumentieren |
| `AGENTS.md` / `CLAUDE.md` / `GEMINI.md` | Teardown-Skript in bekannte Skripte aufnehmen |

---

## Spec-Kit-Hinweise / Spec-Kit Notes

> Dieses Lastenheft ist als Eingabe für den Slash-Command `/speckit.specify`
> konzipiert. Es ist **unabhängig** von den anderen Lastenheft-Dateien und
> kann jederzeit begonnen werden.
>
> *This Lastenheft is designed as input for the `/speckit.specify` slash command.
> It is independent of the other Lastenheft files and can be started at any time.*

```bash
cd ~/home-baseline-tmp
claude
```
Folgendes im Claude-Interface aufrufen / Then run in the Claude interface:
```text
# Spec-Kit starten / Start Spec-Kit (in Claude Code)
/speckit.specify Lastenheft_Workspace_Teardown.md
```
