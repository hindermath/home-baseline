# Feature Specification: Git-Konfiguration Scope-Isolierung
# Lastenheft: Git-Einstellungen auf Ebene 0 und 1 korrekt isolieren

**Feature Branch**: `feat/git-config-scope-isolation` *(wird nach Spec-kit-Lauf aktualisiert / updated after Spec-kit run)*
**Erstellt / Created**: 2026-04-08
**Status**: Draft
**Priorität / Priority**: ⚠️ HOCH — betrifft alle anderen Features als Voraussetzung
**Konstitutions-Version / Constitution Version**: 1.1.0
**Autor / Author**: hindermath (`hindermath`)

---

> ## ⚠️ Implementierungsreihenfolge / Implementation Order
>
> Dieses Lastenheft ist **unabhängig** von den anderen Features und sollte
> **zuerst oder parallel** implementiert werden, da es ein Grundsatzproblem
> der gesamten Infrastruktur behebt.
>
> Empfohlene Gesamtreihenfolge aller fünf Features:
>
> ```text
> Schritt 0 → Lastenheft_Git_Config_Scope.md               ← DU BIST HIER / YOU ARE HERE
>             (ZUERST oder parallel — betrifft alle anderen Features)
> Schritt 1 → Lastenheft_GitLab_Support.md
> Schritt 2 → Lastenheft_CICD_Pipeline_Konfiguration.md    (erfordert Schritt 1)
> Schritt 3 → Lastenheft_Workspace_Migration.md             (erfordert Schritt 1 + 2)
> Schritt 4 → Lastenheft_Workspace_Teardown.md              (unabhängig)
> ```
>
> *This Lastenheft is independent of the other features and should be implemented
> **first or in parallel**, as it fixes a foundational issue affecting the entire
> infrastructure.*

---

## Dateibenennungs-Konvention / File Naming Convention

```
Lastenheft_{KurzName}.{branch-name}.md
```

Aktueller Stand vor Spec-kit-Durchlauf: `Lastenheft_Git_Config_Scope.md`
Nach Spec-kit-Durchlauf: `Lastenheft_Git_Config_Scope.{branch-name}.md`

---

## Anforderungskatalog (Originalanforderung) / Requirements Catalog (Original Request)

> Dieses Kapitel dokumentiert die ursprüngliche Anforderung vollständig und
> unverändert.
>
> *This chapter documents the original requirement in full and unchanged.*

### Originaltext (DE)

> Es müsste via Lastenheft geschaut werden, dass die Git-Einstellungen auf
> Level 0 und Level 1 nur auf diese Ebene/Subdir wirken und nicht implizit
> alle SubDirs auf Level 0 und 1 inkludieren. Das ist mir heute aufgefallen.
> Vielleicht kann das Feature zuerst von der Reihenfolge genommen werden.

### Problem-Analyse / Problem Analysis

Die `~/.gitconfig`-Datei wird von `sync-home.sh/.ps1` aus `home-baseline-tmp`
nach `~/` kopiert und dort als **globale** Git-Konfiguration wirksam. Das bedeutet:

1. Einstellungen in `~/.gitconfig` gelten für **alle** Git-Repositories auf dem
   gesamten System — Level 0 (`~/`), Level 1 (`~/MyProjects/`), Level 2
   (`~/MyProjects/my-app/`) und jedes andere Repo.

2. Soll z. B. `core.autocrlf=input` nur für home-baseline gelten, greift es
   trotzdem in einem .NET-Projekt (das `crlf` benötigt) oder einem
   Python-Projekt.

3. Zukünftige plattform-spezifische Einstellungen (z. B. GitLab-Credentials,
   Signing-Keys, abweichende E-Mail-Adressen je Workspace) können nicht sauber
   pro Ebene isoliert werden.

*The `~/.gitconfig` synced by home-baseline becomes the global git config,
affecting ALL repos on the system. Level-specific settings bleed into
unintended repos.*

### Klärungsergebnisse / Clarification Outcomes

| Frage / Question | Antwort / Answer |
|---|---|
| Welche Einstellungen sollen global bleiben? | `user.name`, `user.email`, `init.defaultBranch`, `core.autocrlf` als sicherer Basis-Default |
| Welche sollen Level-spezifisch sein? | Signing-Keys, abweichende E-Mails, Plattform-Credentials, workspace-spezifische Aliase |
| Mechanismus? | `git config includeIf "gitdir:..."` — Directory-scoped Includes |
| Bootstrap-Skripte anpassen? | Ja — `git config --local` statt globaler Konfiguration wo möglich |
| Rückwärtskompatibilität? | Ja — bestehende `~/.gitconfig` bleibt als Basis erhalten |
| Windows-Parität? | Ja — `includeIf` funktioniert auf allen Plattformen |

---

## Systemüberblick / System Overview

### Ist-Zustand / Current State

```
╔══════════════════════════════════════════════════════════════════════╗
║  Git-Config-Scope — Ist-Zustand / Current State                      ║
╠══════════════════════════════════════════════════════════════════════╣
║  Ebene / Level  Konfigurationsquelle             Scope-Problem        ║
║  ─────────────  ───────────────────────────────  ────────────────── ║
║  Level 0 (~/):  ~/.gitconfig (global)            ✗ gilt überall       ║
║  Level 1 WS:    ~/.gitconfig (global, geerbt)    ✗ kein eigener Scope ║
║  Level 2 Proj:  ~/.gitconfig (global, geerbt)    ✗ kein eigener Scope ║
║  bootstrap-ws:  kein git config --local Aufruf   ✗ keine Lokalisierung║
║  bootstrap-proj:kein git config --local Aufruf   ✗ keine Lokalisierung║
║  sync-home:     kopiert .gitconfig global        ✗ kein includeIf     ║
╠══════════════════════════════════════════════════════════════════════╣
║  Legende: ✓ OK · ✗ Problem                                           ║
╚══════════════════════════════════════════════════════════════════════╝
```

### Ziel-Zustand / Target State

```
~/.gitconfig          → Nur sichere globale Defaults (user, init, autocrlf)
~/.gitconfig.d/
  home-baseline.inc   → Einstellungen nur für ~/home-baseline-tmp/
  myprojects.inc      → Einstellungen für ~/MyProjects/ UND alle darin enthaltenen Projekte
  <custom>.inc        → Nutzerdefinierte Workspace-Overrides

[includeIf "gitdir:~/home-baseline-tmp/"]
    path = ~/.gitconfig.d/home-baseline.inc

[includeIf "gitdir:~/MyProjects/"]
    path = ~/.gitconfig.d/myprojects.inc
    # ↑ Trailing-Slash = gilt für ~/MyProjects/.git (Level 1)
    #   UND alle ~/MyProjects/irgendein-projekt/.git (Level 2)
    #   Projektinterne Unterordner (src/, tests/, obj/, bin/ …)
    #   sind NICHT betroffen — git erlaubt sie immer (kein Scope-Eingriff)
```

> **⚠️ Wichtige Klarstellung zu Level 2 / Important Clarification for Level 2**
>
> `includeIf "gitdir:~/MyProjects/"` mit **Trailing-Slash** greift für:
> - den Workspace selbst (`~/MyProjects/.git` → Level 1)
> - **alle Projekte darin** (`~/MyProjects/my-csharp-app/.git` → Level 2)
>
> `includeIf` beeinflusst ausschließlich **git-Konfigurationseinstellungen**.
> Es schränkt Unterordner innerhalb eines Projekts **in keiner Weise** ein.
> C#-, Java-, Python-, Flutter-Projekte usw. mit tiefer Ordnerstruktur
> (`src/`, `tests/`, `lib/`, `bin/`, `obj/`, `packages/`) funktionieren
> vollständig unverändert.
>
> *`includeIf` only scopes git configuration settings. It never restricts
> subdirectory access or file tracking within a project repo. Level 2 project
> repos with complex subdirectory structures (C#, Java, Flutter, etc.) are
> fully supported and completely unaffected.*

---

## Funktionale Anforderungen / Functional Requirements

### FR-01 — Minimaler globaler ~/.gitconfig / Minimal Global Config

Die getrackte `~/.gitconfig` wird auf ein sicheres Minimum reduziert:

```ini
[user]
    name  = Your Name
    email = your@email.example

[init]
    defaultBranch = main

[core]
    autocrlf = input

[pull]
    rebase = true
```

Alle weiteren Einstellungen werden in scoped Include-Dateien ausgelagert.

*The tracked `~/.gitconfig` is reduced to a safe minimum. All other settings
are moved to scoped include files.*

---

### FR-02 — Include-Verzeichnis: ~/.gitconfig.d/

Ein neues Verzeichnis `~/.gitconfig.d/` wird als Ablageort für scoped
Konfigurationsdateien eingeführt:

```text
~/.gitconfig.d/
├── home-baseline.inc     (Einstellungen für home-baseline-tmp)
└── README.md             (Kurzdokumentation des Mechanismus)
```

Nutzer können eigene `.inc`-Dateien für ihre Workspaces anlegen.
Das Verzeichnis wird von `sync-home` **nicht** überschrieben — es ist
ein Nutzerbereich.

*A new `~/.gitconfig.d/` directory holds scoped config files. It is never
overwritten by sync-home.*

---

### FR-03 — includeIf für home-baseline-tmp / includeIf for home-baseline-tmp

In `~/.gitconfig` wird ein `includeIf`-Block für das home-baseline-Repo
eingefügt:

```ini
[includeIf "gitdir:~/home-baseline-tmp/"]
    path = ~/.gitconfig.d/home-baseline.inc
```

`~/.gitconfig.d/home-baseline.inc` enthält vorerst keine zusätzlichen
Einstellungen (Platzhalter), kann aber bei Bedarf erweitert werden.

*An `includeIf` block scopes future home-baseline-specific settings to
`~/home-baseline-tmp/` only.*

---

### FR-04 — bootstrap-workspace: git config --local

`bootstrap-workspace.sh/.ps1` setzt workspace-spezifische Einstellungen
**lokal** im neu erstellten Repo:

```bash
git -C "$WORKSPACE_DIR" config --local core.autocrlf input
```

Zusätzlich wird optional ein `includeIf`-Eintrag in `~/.gitconfig` für den
neuen Workspace angelegt:

```ini
[includeIf "gitdir:~/WorkspaceName/"]
    path = ~/.gitconfig.d/workspacename.inc
```

Der Include wird nur angelegt wenn `~/.gitconfig.d/` existiert.

> **Hinweis Level 2 / Note Level 2:** Der Trailing-Slash in
> `gitdir:~/WorkspaceName/` bewirkt, dass dieser Include automatisch auch
> für alle **Level-2-Projekte** innerhalb des Workspace gilt
> (z. B. `~/WorkspaceName/my-app/`). Projektinterne Unterordner
> (`src/`, `tests/`, `bin/` usw.) sind davon nicht betroffen —
> `includeIf` scopet nur Konfigurationseinstellungen, nie Verzeichnisstrukturen.
>
> *The trailing slash means the `includeIf` automatically covers Level 2
> project repos inside the workspace as well. Subdirectories within those
> projects (src/, tests/, bin/, etc.) are entirely unaffected — `includeIf`
> only scopes config settings, never directory structures.*

*`bootstrap-workspace` sets workspace-specific settings with `git config --local`
and optionally adds an `includeIf` entry to `~/.gitconfig`.*

---

### FR-05 — bootstrap-project: git config --local

`bootstrap-project.sh/.ps1` setzt projekt-spezifische Einstellungen
**lokal** im neu erstellten Projekt-Repo:

```bash
git -C "$TARGET_DIR" config --local core.autocrlf input
```

Keine `includeIf`-Manipulation auf Projekt-Ebene — das ist Verantwortung
des Workspace-Setups.

*`bootstrap-project` sets project-specific settings with `git config --local`.
No `includeIf` manipulation at project level.*

---

### FR-06 — sync-home: ~/.gitconfig.d/ NICHT überschreiben

`sync-home.sh/.ps1` kopiert `~/.gitconfig` (die Minimal-Version), aber
**nicht** `~/.gitconfig.d/`. Das Verzeichnis ist ein Nutzerbereich.

Neue Logik in sync-home:
```bash
# ~/.gitconfig kopieren (wie bisher)
cp "$SRC/.gitconfig" "$HOME/.gitconfig"

# ~/.gitconfig.d/ anlegen falls nicht vorhanden — aber NICHT überschreiben
if [ ! -d "$HOME/.gitconfig.d" ]; then
  mkdir -p "$HOME/.gitconfig.d"
  # Initiale home-baseline.inc anlegen
  echo "# home-baseline spezifische Einstellungen" > "$HOME/.gitconfig.d/home-baseline.inc"
fi
```

*`sync-home` creates `~/.gitconfig.d/` if missing but never overwrites it.*

---

### FR-07 — teardown-workspace: includeIf-Eintrag entfernen

`teardown-workspace.sh/.ps1` (aus `Lastenheft_Workspace_Teardown.md`) entfernt
beim Teardown auch den zugehörigen `includeIf`-Eintrag aus `~/.gitconfig`
und die zugehörige `.inc`-Datei aus `~/.gitconfig.d/`.

*`teardown-workspace` also removes the `includeIf` entry and `.inc` file
when tearing down a workspace.*

---

### FR-08 — Dokumentation des Mechanismus / Documentation of the Mechanism

`README.md` erhält einen neuen Unterabschnitt „Git-Konfiguration / Git Configuration"
(unter „Architektur" oder als eigener Abschnitt), der den `includeIf`-Mechanismus
erklärt:

- Was ist in `~/.gitconfig` global?
- Wie legt man workspace-spezifische Overrides an?
- Beispiel: abweichende E-Mail-Adresse für Work-Workspace

*`README.md` receives a new subsection explaining the `includeIf` mechanism
with examples.*

---

### FR-09 — check-homogeneity: Prüfung der Scope-Isolation

`check-homogeneity.sh/.ps1` erhält einen neuen Check:

- Prüft ob `~/.gitconfig.d/` existiert
- Prüft ob für den Target-Workspace ein `includeIf`-Eintrag in `~/.gitconfig`
  vorhanden ist
- Warnt (nicht Fehler) wenn fehlend

*`check-homogeneity` gets a new check for `includeIf` presence.*

---

## Nicht-funktionale Anforderungen / Non-Functional Requirements

### NFR-01 — Rückwärtskompatibilität / Backward Compatibility

Bestehende Git-Operationen in allen Repos funktionieren weiterhin unverändert.
Der `includeIf`-Mechanismus ist additiv — er fügt Konfiguration hinzu, entfernt
nichts Bestehendes.

*Existing git operations in all repos continue to work. `includeIf` is additive.*

---

### NFR-02 — Plattformparität / Platform Parity

`git config includeIf` ist seit Git 2.13 verfügbar und funktioniert auf
macOS, Linux und Windows identisch. Keine plattformspezifischen Workarounds
nötig.

*`git config includeIf` works identically on macOS, Linux, and Windows since
Git 2.13.*

---

### NFR-03 — Bilingualität / Bilingualism

Alle neuen Benutzerausgaben und die `~/.gitconfig.d/README.md` sind bilingual.

---

### NFR-04 — Keine Secrets in ~/.gitconfig.d/

Die `.inc`-Dateien in `~/.gitconfig.d/` dürfen **keine** Credentials oder
Tokens enthalten. Der pre-push-Hook prüft dies (sofern `~/.gitconfig.d/` in
den Scan einbezogen wird).

*`.inc` files must not contain credentials or tokens. The pre-push hook
should scan `~/.gitconfig.d/`.*

---

### NFR-05 — Level-2-Projektstruktur unberührt / Level 2 Project Structure Unaffected

Der `includeIf`-Mechanismus darf die interne Ordnerstruktur von Level-2-Projekten
**in keiner Weise einschränken**. Projekte mit komplexer Unterordner-Hierarchie —
C# (`src/`, `tests/`, `bin/`, `obj/`), Java (`src/main/`, `src/test/`),
Flutter (`lib/`, `assets/`, `android/`, `ios/`), Python (`src/`, `venv/`)
usw. — müssen vollständig und unverändert funktionieren.

`git config --local` in einem Level-2-Projekt gilt für das **gesamte Repo**
inklusive aller Unterordner. Das ist git-internes Standardverhalten und
liegt außerhalb des Einflussbereichs dieses Features.

*The `includeIf` mechanism must not restrict internal folder structures of
Level 2 project repos in any way. Projects with deep subdirectory hierarchies
(C#, Java, Flutter, Python, etc.) must work completely unchanged.
`git config --local` in a project repo applies to the entire repo including
all subdirectories — standard git behavior, outside the scope of this feature.*

---

## Abgrenzung / Out of Scope

| Thema / Topic | Begründung / Reason |
|---|---|
| Credential-Helper Konfiguration | Systemspezifisch (Keychain, Windows Credential Manager) — separates Feature |
| Git Signing (GPG/SSH) | Zu komplexes Sicherheitsthema — separates Feature |
| Automatische Migration bestehender Workspaces | Nutzentscheidung — Anleitung reicht aus |
| `.gitattributes` Scope | Ist immer repo-lokal — kein Problem |

---

## Akzeptanzkriterien / Acceptance Criteria

| ID | Kriterium / Criterion | Testmethode |
|---|---|---|
| AC-01 | `~/.gitconfig` enthält nur die 5 Minimal-Einstellungen (user, init, pull, core) | Sichtprüfung |
| AC-02 | `git config --show-origin user.name` in `~/home-baseline-tmp/` zeigt `~/.gitconfig` | `git config --show-origin` |
| AC-03 | Ein `.inc`-File in `~/.gitconfig.d/` mit abweichendem `user.email` wird in `~/home-baseline-tmp/` korrekt angewendet | Test-Konfiguration |
| AC-04 | Dasselbe `.inc`-File wird in `~/MyProjects/` (ohne `includeIf`) **nicht** angewendet | `git config --show-origin` |
| AC-05 | `bootstrap-workspace` setzt `core.autocrlf` lokal (`--local`) im neuen Repo | `git -C ws config --local --list` |
| AC-06 | `bootstrap-workspace` legt `includeIf`-Eintrag in `~/.gitconfig` an | Sichtprüfung |
| AC-07 | `sync-home` überschreibt `~/.gitconfig.d/` nicht | Manuelle Prüfung |
| AC-08 | `check-homogeneity` warnt bei fehlendem `includeIf` | Dry-Run |
| AC-09 | `teardown-workspace` entfernt `includeIf`-Eintrag + `.inc`-Datei | Live-Test |
| AC-10 | README-Abschnitt erklärt den Mechanismus mit Beispiel | Sichtprüfung |
| AC-11 | In einem Level-2-Projekt (`~/MyProjects/my-csharp-app/`) können Unterordner (`src/`, `tests/`, `bin/`, `obj/`) ohne Einschränkungen von git getrackt werden | `git status` + `git add src/` in Projektrepo |

---

## Technische Abhängigkeiten / Technical Dependencies

| Tool / Feature | Mindestversion | Zweck |
|---|---|---|
| `git` | ≥ 2.13 | `includeIf` Unterstützung |
| `bash` ≥ 5 / `pwsh` ≥ 7 | — | Skript-Laufzeit |
| `sync-home.sh/.ps1` | vorhanden | Anpassen (FR-06) |
| `bootstrap-workspace.sh/.ps1` | vorhanden | Anpassen (FR-04) |
| `bootstrap-project.sh/.ps1` | vorhanden | Anpassen (FR-05) |
| `check-homogeneity.sh/.ps1` | vorhanden | Anpassen (FR-09) |
| `teardown-workspace.sh/.ps1` | neu (Lastenheft_Workspace_Teardown.md) | Anpassen (FR-07) |

---

## Dateien mit Änderungsbedarf / Files Requiring Changes

| Datei / File | Art der Änderung / Type of Change |
|---|---|
| `.gitconfig` | Auf Minimal-Einstellungen reduzieren + `includeIf`-Block für home-baseline-tmp |
| `scripts/sync-home.sh` | `~/.gitconfig.d/` anlegen falls nicht vorhanden — nie überschreiben |
| `scripts/sync-home.ps1` | dito |
| `scripts/bootstrap-workspace.sh` | `git config --local` + optionaler `includeIf`-Eintrag |
| `scripts/bootstrap-workspace.ps1` | dito |
| `scripts/bootstrap-project.sh` | `git config --local` für projekt-spezifische Einstellungen |
| `scripts/bootstrap-project.ps1` | dito |
| `scripts/check-homogeneity.sh` | Neuer Check: `includeIf`-Präsenz |
| `scripts/check-homogeneity.ps1` | dito |
| `scripts/teardown-workspace.sh` | `includeIf`-Eintrag + `.inc`-Datei entfernen (FR-07) |
| `scripts/teardown-workspace.ps1` | dito |
| `README.md` | Neuer Abschnitt: Git-Konfigurationsmechanismus |

---

## Spec-Kit-Hinweise / Spec-Kit Notes

> Dieses Lastenheft ist als Eingabe für den Slash-Command `/speckit.specify`
> konzipiert. Es hat **keine Abhängigkeiten** von den anderen Lastenheften
> und kann **sofort** begonnen werden.
>
> *This Lastenheft is designed as input for the `/speckit.specify` slash command.
> It has no dependencies on other Lastenheft files and can be started immediately.*

```bash
cd ~/home-baseline-tmp
claude
```
Folgendes im Claude-Interface aufrufen / Then run in the Claude interface:
```text
# Spec-Kit starten / Start Spec-Kit (in Claude Code)
/speckit.specify Lastenheft_Git_Config_Scope.md
```
