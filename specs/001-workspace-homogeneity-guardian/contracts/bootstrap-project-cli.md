# CLI-Vertrag: bootstrap-project

**Tool**: `scripts/bootstrap-project.sh` / `scripts/bootstrap-project.ps1`  
**Zweck**: Vollständiger Projekt-Bootstrap in einem einzigen idempotenten Aufruf  
**Branch**: `001-workspace-homogeneity-guardian`

---

## Synopsis

```bash
# Bash
bootstrap-project.sh <ProjectName> [TARGET_WORKSPACE] [OPTIONS]

# PowerShell
bootstrap-project.ps1 -ProjectName <String> [[-TargetWorkspace] <String>] [OPTIONS]
```

---

## Optionen

| Bash-Flag | PS-Parameter | Typ | Standard | Beschreibung |
|-----------|-------------|------|----------|--------------|
| `<ProjectName>` | `-ProjectName` | `string` | **Pflicht** | Name des neuen Projekts |
| `[TARGET_WORKSPACE]` | `-TargetWorkspace` | `string` | aktuelles Verzeichnis | Ziel-Workspace-Pfad (Level 1) |
| `--preview` | `-WhatIf` | `switch` | off | Zeigt alle geplanten Aktionen, schreibt nichts |
| `--force` | `-Force` | `switch` | off | Überschreibt bestehende Dateien |
| `--no-agents` | `-NoAgents` | `switch` | off | Überspringt KI-Agenten-Initialisierung |
| `--no-speckit` | `-NoSpeckit` | `switch` | off | Überspringt Spec-kit-Installation |
| `--no-remote` | `-NoRemote` | `switch` | off | Kein `gh repo create` (nur lokales git init) |
| `--lang` | `-Lang` | `string` | `de` | Primärsprache für Templates (`de` oder `en`) |

---

## Exit-Codes

| Code | Bedeutung |
|------|-----------|
| `0` | Bootstrap erfolgreich abgeschlossen |
| `1` | Teilfehler (Agent-Init übersprungen, Spec-kit nicht gefunden) — Projekt ist nutzbar |
| `2` | Fataler Fehler (Zielverzeichnis nicht les-/schreibbar, git nicht installiert) |

---

## Bootstrap-Sequenz (idempotent)

Jeder Schritt prüft zunächst, ob er bereits erledigt ist. Bei erneutem Aufruf
ohne `--force` wird ein vorhandener Schritt übersprungen.

```
Schritt  Beschreibung                                 Idempotenz-Check
──────────────────────────────────────────────────────────────────────
1        Verzeichnis anlegen                          Existiert bereits → skip
2        git init                                     .git/ vorhanden → skip
3        AGENTS.md erzeugen (bilingual, aus Template) Datei existiert → skip
4        CLAUDE.md erzeugen                           Datei existiert → skip
5        GEMINI.md erzeugen                           Datei existiert → skip
6        .github/copilot-instructions.md erzeugen     Datei existiert → skip
7        README.md erzeugen (mit Azubi-Abschnitt)     Datei existiert → skip
8        STATS.md (leere Initialdatei) erzeugen       Datei existiert → skip
9        .gitignore erzeugen (Whitelist-Modell)        Datei existiert → skip
10       scripts/ aus ~/scripts/ kopieren             scripts/ vorhanden → skip
11       pre-push Hook installieren                   Hook SHA-256 match → skip
12       Initialer git-Commit                         Commits vorhanden → skip
13       gh repo create (privat)                      Remote vorhanden → skip
14       git push                                     Remote up-to-date → skip
15       Claude init                                  CLAUDE.md hat Init-Marker → skip
16       Codex: manuelle Anweisung ausgeben           immer ausgegeben
17       Gemini: manuelle Anweisung ausgeben          immer ausgegeben
18       Copilot: Verfügbarkeit prüfen                gh copilot --help OK → skip
19       Spec-kit installieren (npx speckit init)     .specify/ vorhanden → skip
20       Initialer Compliance-Check                   Immer ausgeführt (read-only)
21       ~/README.md Workspace-Tabelle aktualisieren  Eintrag vorhanden → skip
```

---

## Standard-Output

```
╔══════════════════════════════════════════════════╗
║  bootstrap-project — Workspace Homogeneity Guardian ║
╚══════════════════════════════════════════════════╝

Projekt:    MyNewProject
Workspace:  ~/MyProjects/
Ziel:       ~/MyProjects/MyNewProject/

[1/21] → Verzeichnis anlegen ................. ✓
[2/21] → git init ............................ ✓
[3/21] → AGENTS.md erzeugen .................. ✓
[4/21] → CLAUDE.md erzeugen .................. ✓
[5/21] → GEMINI.md erzeugen .................. ✓
[6/21] → copilot-instructions.md erzeugen .... ✓
[7/21] → README.md erzeugen .................. ✓
[8/21] → STATS.md (initial) .................. ✓
[9/21] → .gitignore erzeugen ................. ✓
[10/21] → scripts/ kopieren .................. ✓
[11/21] → pre-push Hook installieren ......... ✓
[12/21] → Initialer git-Commit ............... ✓
[13/21] → gh repo create (privat) ............ ✓  YOUR_USERNAME/mynewproject
[14/21] → git push ........................... ✓
[15/21] → Claude init ........................ ✓
[16/21] → Codex (interaktiv):
          → Bitte manuell ausführen: cd ~/MyProjects/MyNewProject && codex
[17/21] → Gemini (interaktiv):
          → Bitte manuell ausführen: cd ~/MyProjects/MyNewProject && gemini
[18/21] → Copilot verfügbar .................. ✓
[19/21] → Spec-kit installieren .............. ✓  v0.4.3
[20/21] → Compliance-Check ................... ✓  Score: 100 %
[21/21] → ~/README.md aktualisiert ........... ✓

╔══════════════════════════════════════════════════╗
║  Bootstrap abgeschlossen ✓                          ║
║  ~/MyProjects/MyNewProject/ ist bereit.           ║
║                                                      ║
║  Nächste Schritte:                                   ║
║  → codex   (interaktive Initialisierung)             ║
║  → gemini  (interaktive Initialisierung)             ║
║  → npx speckit specify "Feature-Name"               ║
╚══════════════════════════════════════════════════╝
```

---

## Preview-Output (`--preview` / `-WhatIf`)

```
[PREVIEW] Folgende Aktionen würden ausgeführt:
  CREATE  ~/MyProjects/MyNewProject/
  CREATE  ~/MyProjects/MyNewProject/AGENTS.md      (aus AGENTS.md.tmpl)
  CREATE  ~/MyProjects/MyNewProject/CLAUDE.md      (aus CLAUDE.md.tmpl)
  ...
  INSTALL ~/MyProjects/MyNewProject/.git/hooks/pre-push
  EXEC    claude /init
  EXEC    npx speckit init
  UPDATE  ~/README.md  (Zeile nach <!-- workspace-table-end -->)
  [Keine Dateien wurden geschrieben]
```

---

## Idempotenz-Beispiel (bereits bootstrapptes Verzeichnis)

```bash
bootstrap-project.sh MyNewProject ~/MyProjects/
# → WARN: ~/MyProjects/MyNewProject/ already bootstrapped
#         Verwende --force um alle Schritte erneut auszuführen.
#         Fehlende Dateien werden ergänzt (3 von 21 Schritten übersprungen).
```

---

## Constraints

- Erfordert: `git`, `bash` ≥ 5
- Optional: `gh` (für Remote-Repo), KI-Agenten-CLIs, `node`/`npx` (für Spec-kit)
- Bildet Level-2-Projekte; kann nicht für Level-0 oder Level-1 verwendet werden
- Erzeugt keine Dateien außerhalb des Ziel-Workspace (außer `~/README.md`-Update)
- Alle erzeugten Markdown-Dateien: Deutsch primär, Englisch sekundär (CEFR B2)
- Alle erzeugten Dateien erfüllen sofort die A11Y-Anforderungen (FR-005/006)
