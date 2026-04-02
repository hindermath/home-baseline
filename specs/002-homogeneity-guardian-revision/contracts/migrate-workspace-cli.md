# CLI-Vertrag: migrate-workspace.sh / .ps1
# CLI Contract: migrate-workspace.sh / .ps1

**FR-REV-A01–A06**

---

## Aufruf / Invocation

```bash
# Bash
bash scripts/migrate-workspace.sh [workspace-name] [--dry-run] [--yes]

# PowerShell
pwsh scripts/migrate-workspace.ps1 [-WorkspaceName <string>] [-WhatIf] [-Force]
```

## Argumente / Arguments

| Argument | Pflicht / Required | Beschreibung |
|---|:---:|---|
| `workspace-name` / `-WorkspaceName` | Nein | Migriert nur diesen Workspace. Ohne Argument: alle Level-1-Workspaces |
| `--dry-run` / `-WhatIf` | Nein | Preview-Modus — keine Dateiänderungen, Exit-Code 0 |
| `--yes` / `-Force` | Nein | Überspringt `Proceed? [y/N]`-Prompt; Preview erscheint weiterhin |

## Prozessablauf / Process Flow

```
1. Scan: Alle fehlenden Pflichtabschnitte identifizieren
2. Preview: Alle geplanten Einfügungen anzeigen
3. Prompt: "Proceed? [y/N]" (entfällt bei --dry-run / --yes)
4. Einfügen: append-only, nie überschreiben (FR-REV-A05)
   a. EN-Platzhalter → alle Agent-Dateien + README.md
   b. A11Y/Spec-kit/Azubis-Abschnitte → nur README.md (aus Templates)
   c. homogeneity-check.yml anlegen (falls fehlend, Level-1 + Level-2)
   d. .editorconfig anlegen (falls C#-Projekt, Level-2 only, FR-REV-E01)
   e. Level-2 pre-push Hook prüfen/installieren (FR-REV-A04)
5. Git-Commit: "chore: migrate {workspace} to homogeneity baseline v{version}"
6. init-stats.sh automatisch aufrufen (FR-REV-A03)
```

## Idempotenz-Regeln / Idempotency Rules

| Bedingung | Verhalten |
|---|---|
| EN-Block bereits vorhanden | `INFO: EN block already present — skip` |
| Pflichtabschnitt bereits vorhanden (exakter String-Match) | `INFO: section already present — skip` |
| `homogeneity-check.yml` bereits vorhanden | `INFO: homogeneity-check.yml already present — skip` |
| `.editorconfig` bereits vorhanden | `INFO: .editorconfig already present — skip` |
| Alles bereits compliant | `INFO: already compliant — nothing to do` (kein Commit) |

## Fehlerbehandlung / Error Handling

| Fehlerfall | Verhalten |
|---|---|
| Template-Datei fehlt | `ERROR: template not found: scripts/templates/{name}` + Abbruch |
| Teilfehler während Migration | `git stash` + Fehlermeldung + Diff auf stderr + weiter mit nächstem Workspace |
| `git stash` schlägt fehl | `ERROR: git stash fehlgeschlagen — manuelle Bereinigung erforderlich` + Exit 2, keine weiteren Workspaces |

## Exit-Codes

| Code | Bedeutung |
|---|---|
| `0` | Erfolgreich (inkl. --dry-run) |
| `1` | Teilfehler (mindestens ein Workspace fehlgeschlagen, andere verarbeitet) |
| `2` | Kritischer Fehler — Abbruch |

## Seiteneffekte / Side Effects

- Datei-Einfügungen (append-only)
- Git-Commits pro Workspace
- `init-stats.sh`-Aufruf am Ende
- `.github/workflows/homogeneity-check.yml` erstellt (falls fehlend)
