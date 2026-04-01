# CLI-Vertrag: check-homogeneity

**Tool**: `scripts/check-homogeneity.sh` / `scripts/check-homogeneity.ps1`  
**Zweck**: Read-only Compliance-Scanner für alle drei Hierarchieebenen  
**Branch**: `001-workspace-homogeneity-guardian`

---

## Synopsis

```bash
# Bash
check-homogeneity.sh [OPTIONS] [TARGET_DIR]

# PowerShell
check-homogeneity.ps1 [[-TargetDir] <String>] [OPTIONS]
```

---

## Optionen

| Bash-Flag | PS-Parameter | Typ | Standard | Beschreibung |
|-----------|-------------|------|----------|--------------|
| (positional) | `-TargetDir` | `string` | `~/` | Startverzeichnis (Level 0) |
| `--verbose` | `-Verbose` | `switch` | off | Alle geprüften Dateien mit Status ausgeben |
| `--json` | `-Json` | `switch` | off | Maschinenlesbarer JSON-Output (kein ASCII/Markdown) |
| `--dry-run` | `-DryRun` | `switch` | off | Keine Schreibvorgänge (kein STATS.md, kein Patch) |
| `--apply-patch` | `-ApplyPatch` | `string` | — | Pfad zu `memory-patch.md`; wendet Patch an + committet |
| `--no-patch` | `-NoPatch` | `switch` | off | Kein `memory-patch.md` generieren, auch bei Trigger |
| `--fail-fast` | `-FailFast` | `switch` | off | Abbruch beim ersten FAIL (kein WARN-Abbruch) |

---

## Exit-Codes

| Code | Bedeutung |
|------|-----------|
| `0` | Alle Checks PASS |
| `1` | Mindestens ein FAIL oder WARN |
| `2` | Fataler Fehler (kein `rg`, STATS.md locked, keine Schreibrechte) |

---

## Standard-Output (ohne `--json`)

```
Workspace Homogeneity Guardian — check-homogeneity v1.0
Scan-Startpunkt: /Users/hindermath
══════════════════════════════════════════════════════

[Level 0] ~/
  ✓  AGENTS.md
  ✓  CLAUDE.md
  ✗  GEMINI.md                    FAIL: file missing
  ✓  README.md
  WARN README.md                  WARN: bilingual section missing
  ✓  STATS.md
  ✓  scripts/hooks/pre-push       PASS: hook SHA-256 match

[Level 1] ~/RiderProjects/
  ✓  AGENTS.md
  ✓  CLAUDE.md
  ✓  GEMINI.md
  ✓  README.md
  ✓  STATS.md
  ✓  .git/hooks/pre-push          PASS: hook SHA-256 match

[Level 2] ~/RiderProjects/TuiVision/
  ✓  AGENTS.md
  ✓  CLAUDE.md
  ✓  GEMINI.md
  ✓  README.md
  ✓  STATS.md
  ✓  .git/hooks/pre-push
  ✓  specs/001-tuivision/spec.md

══════════════════════════════════════════════════════
COMPLIANCE SUMMARY

~/             [█████████░] 87 %   (13/15 checks)
RiderProjects  [██████████] 100 %  (15/15 checks)
TuiVision      [██████████] 100 %  (15/15 checks)

Overall: 96 %  |  Workspaces: 1  |  Projects: 1
STATS.md updated: ~/STATS.md
memory-patch.md: ~/specs/001-workspace-homogeneity-guardian/memory-patch.md (1 entry)

Exit code: 1 (1 FAIL, 1 WARN)
```

---

## Verbose-Output (mit `--verbose`)

Identisch mit Standard, aber jede Datei wird ausgegeben — auch PASS-Ergebnisse:

```
  ✓  AGENTS.md                    PASS: file present
  ✓  CLAUDE.md                    PASS: bilingual OK, a11y OK
  ✗  GEMINI.md                    FAIL: file missing
  ...
```

---

## JSON-Output (mit `--json`)

Kein ASCII/Markdown. Einzeiliges JSON-Objekt auf stdout:

```json
{
  "score": 87,
  "workspaces_scanned": 1,
  "projects_scanned": 1,
  "failures": [
    {"path": "~/GEMINI.md", "check": "file-missing"}
  ],
  "warnings": [
    {"path": "~/README.md", "check": "bilingual-missing"}
  ],
  "stats_updated": "~/STATS.md",
  "patch_generated": "~/specs/001-workspace-homogeneity-guardian/memory-patch.md"
}
```

Alle Secret-Matches in `detail`-Feldern sind `[REDACTED]`.

---

## Apply-Patch-Modus (`--apply-patch <path>`)

```bash
check-homogeneity.sh --apply-patch ~/specs/001-workspace-homogeneity-guardian/memory-patch.md
```

1. Liest `memory-patch.md`
2. Zeigt alle vorgeschlagenen Änderungen mit Zieldatei + Inhalt
3. Fragt interaktiv: `Patch anwenden? [j/N]`
4. Bei Bestätigung: schreibt Patches in Zieldateien (append, keine Überschreibung)
5. Erstellt git-Commit: `chore: apply memory-patch — N entries updated`

**Nicht-interaktiver Modus**:
```bash
echo "j" | check-homogeneity.sh --apply-patch memory-patch.md
# oder
check-homogeneity.sh --apply-patch memory-patch.md --yes
```

---

## Constraints

- Erfordert: `git`, `bash` ≥ 5, `rg` (ripgrep), `sha256sum` oder `shasum`
- Optional: `gh` (für Remote-Push bei `--apply-patch`)
- Keine Netzwerkverbindung für Scan erforderlich
- Keine Schreibrechte für `--dry-run` erforderlich
- Scan-Tiefe: fest 3 Ebenen (Level 0–2); Level 3+ wird ignoriert
- Directories ohne `.git/` auf Level 1/2 werden übersprungen (kein WARN)
