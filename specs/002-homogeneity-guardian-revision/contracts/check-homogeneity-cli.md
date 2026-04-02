# CLI-Vertrag: check-homogeneity.sh / .ps1
# CLI Contract: check-homogeneity.sh / .ps1

**FR-REV-B01** | **FR-REV-E02** | **NFR-REV-07**

---

## Aufruf / Invocation

```bash
# Bash (macOS/Linux)
bash scripts/check-homogeneity.sh [workspace-name] [--json]

# PowerShell (Windows)
pwsh scripts/check-homogeneity.ps1 [-WorkspaceName <string>] [-Json]
```

## Argumente / Arguments

| Argument | Pflicht / Required | Beschreibung |
|---|:---:|---|
| `workspace-name` / `-WorkspaceName` | Nein | Scoped scan: nur dieser Level-1-Workspace + Level-2. Level-0-Checks entfallen. |
| `--json` / `-Json` | Nein | JSON-Ausgabe statt Klartext |

## Prozessablauf / Process Flow

```
1. Alle Checks aus der Pflichtdatei-Matrix sequentiell ausführen
2. Pro Check: Datei-Präsenz prüfen; ggf. Inhalts-Checks (A11Y, EN-Block, ANSI-Codes)
3. Ergebnis pro Check: [✓|✗|WARN] Level-N  {datei}  {check-name}
4. Score berechnen: ✓ / (✓ + ✗) × 100; by_level separat
5. Ausgabe: Plain Text → stdout; Markdown-Tabelle → $GITHUB_STEP_SUMMARY
```

## Ausgabe / Output

### Klartext (Standard / Default)

```
[✓|✗|WARN] Level-N  {datei}  {check-name}
...
Score: 75% (15/20 checks passed)
YYYY-MM-DD HH:MM | ████░░░░░░░░░░░░░░░░ 20%
```

### JSON (`--json`)

```json
{
  "score": 75,
  "by_level": {"0": 100, "1": 80, "2": 60},
  "failures": [
    {"file": "README.md", "check": "A11Y section", "level": 0, "workspace": "root"}
  ],
  "warnings": []
}
```

### GitHub Job Summary (`$GITHUB_STEP_SUMMARY`)

Markdown-Tabelle — immer befüllt (parallel zu stdout):

```markdown
## Homogeneity Check Report

| Level | Datei | Check | Status |
|---|---|---|---|
| 0 | README.md | A11Y section | ✗ |
| 1 | RiderProjects/AGENTS.md | EN placeholder | ✓ |

**Score: 75% (15/20 checks passed)**
```

## Exit-Codes

| Code | Bedeutung |
|---|---|
| `0` | Alle Checks PASS oder WARN — kein `✗` |
| `1` | Mindestens ein `✗`-Befund |
| `2` | Interner Fehler (Skript konnte nicht ausgeführt werden) |

## Checks (vollständig / complete)

| Check-Name | Datei / File | Ebene / Level |
|---|---|---|
| `README.md present` | README.md | 0, 1, 2 |
| `A11Y section` | README.md | 0, 1, 2 |
| `Spec-kit section` | README.md | 0, 1, 2 |
| `Azubis section` | README.md | 0, 1, 2 |
| `EN placeholder` | README.md, AGENTS.md, CLAUDE.md, GEMINI.md, copilot-instructions.md | 0, 1 |
| `AGENTS.md present` | AGENTS.md | 0, 1 |
| `CLAUDE.md present` | CLAUDE.md | 0, 1 |
| `GEMINI.md present` | GEMINI.md | 0, 1 |
| `copilot-instructions.md present` | .github/copilot-instructions.md | 0, 1 |
| `constitution.md present` | constitution.md | 0, 1, 2 |
| `STATS.md present` | STATS.md | 0, 1, 2 |
| `homogeneity-check.yml present` | .github/workflows/homogeneity-check.yml | 0, 1, 2 |
| `pre-push hook installed` | .git/hooks/pre-push | 0, 1, 2 |
| `.editorconfig present` | .editorconfig | Level-2 C# only |
| `no ANSI codes in scripts/` | scripts/** | 0 (global) |
