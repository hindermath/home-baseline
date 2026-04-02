# CLI-Vertrag: sync-constitution.sh / .ps1
# CLI Contract: sync-constitution.sh / .ps1

**FR-REV-F01** | **FR-REV-F02**

---

## Aufruf / Invocation

```bash
# Bash
bash scripts/sync-constitution.sh [--dry-run] [--yes]

# PowerShell
pwsh scripts/sync-constitution.ps1 [-WhatIf] [-Force]
```

## Argumente / Arguments

| Argument | Pflicht / Required | Beschreibung |
|---|:---:|---|
| `--dry-run` / `-WhatIf` | Nein | Preview mit `WOULD UPDATE` — keine Dateiänderungen |
| `--yes` / `-Force` | Nein | Überspringt `Proceed? [y/N]`-Prompt; Preview bleibt |

## Prozessablauf / Process Flow

```
1. Version aus ~/constitution.md extrahieren (erste Zeile: "# Constitution vX.Y.Z")
   → Fehlt Versionszeile: ERROR + Abbruch
2. Preview aller Level-1-Workspaces mit Status WOULD UPDATE / WOULD SKIP
3. Prompt: "Proceed? [y/N]" (entfällt bei --yes / --dry-run)
4. Pro Level-1-Workspace:
   a. Uncommittete Änderungen? → WARN: {ws} hat uncommittete Änderungen — übersprungen
   b. constitution.md fehlt ODER Version abweichend → kopieren + Commit
   c. Version identisch → ALREADY UP-TO-DATE
5. Zusammenfassung: UPDATED / SKIPPED / ALREADY UP-TO-DATE je Workspace
```

**Scope**: Nur Level-1-Workspaces — Level-2 erbt über Level-1-Parent (kein direkter Sync).

## Status-Werte / Status Values

| Status | Bedeutung |
|---|---|
| `UPDATED` | constitution.md kopiert + Commit erzeugt |
| `SKIPPED (dirty)` | Uncommittete Änderungen im Workspace |
| `ALREADY UP-TO-DATE` | Version identisch — keine Aktion |

## Fehlerbehandlung / Error Handling

| Fehlerfall | Verhalten |
|---|---|
| `constitution.md` hat keine Versionszeile | `ERROR: constitution.md hat keine Versionszeile` + Abbruch |
| Teilfehler bei Datei-Kopie | `git stash` + Fehlermeldung + Diff auf stderr |
| `git stash` schlägt fehl | `ERROR: git stash fehlgeschlagen — manuelle Bereinigung erforderlich` + Exit 2 |

## Exit-Codes

| Code | Bedeutung |
|---|---|
| `0` | Erfolgreich (inkl. --dry-run, inkl. SKIPPED-Workspaces) |
| `1` | Teilfehler |
| `2` | Kritischer Fehler (git stash, Versionszeile fehlt) |

## Git-Commit-Message

```
chore: sync constitution to v{version}
```
