# CLI-Vertrag: init-stats.sh / .ps1
# CLI Contract: init-stats.sh / .ps1

**FR-REV-B04**

---

## Aufruf / Invocation

```bash
# Bash
bash scripts/init-stats.sh [workspace-name]

# PowerShell
pwsh scripts/init-stats.ps1 [-WorkspaceName <string>]
```

## Argumente / Arguments

| Argument | Pflicht / Required | Beschreibung |
|---|:---:|---|
| `workspace-name` / `-WorkspaceName` | Nein | Scoped: nur dieser Level-1-Workspace + seine Level-2-Projekte. Ohne Argument: Level 0, alle Level-1, alle Level-2 |

## Prozessablauf / Process Flow

```
1. check-homogeneity.sh --json aufrufen → score extrahieren
   → check-homogeneity.sh nicht verfügbar: ERROR + Abbruch
2. StatsEntry berechnen: timestamp, score, ascii_bar
3. Pro Ebene (Level 0, Level 1, Level 2):
   a. STATS.md existiert → append neuen Eintrag (append-only)
   b. STATS.md fehlt → neu erstellen mit bilingualem Header + erstem Eintrag
4. Ausgabe: "✓ STATS.md updated at {path}"
```

## STATS.md-Format / File Format

```markdown
# Statistiken / Statistics

| Datum / Date | Compliance-Score | Fortschritt / Progress |
|---|---|---|
| 2026-04-02 16:30 | 45% | ████████░░░░░░░░░░░░ 45% |
| 2026-04-03 09:15 | 80% | ████████████████░░░░ 80% |
```

**ASCII-Bar-Formel**:
- `filled = round(score / 5)` (0–20)
- `bar = "█" * filled + "░" * (20 - filled)`

## Fehlerbehandlung / Error Handling

| Fehlerfall | Verhalten |
|---|---|
| `check-homogeneity.sh` nicht gefunden | `ERROR: check-homogeneity.sh nicht gefunden — zuerst FR-REV-B01 implementieren` + Abbruch |

## Exit-Codes

| Code | Bedeutung |
|---|---|
| `0` | Erfolgreich |
| `1` | Fehler |

## Seiteneffekte / Side Effects

- STATS.md-Dateien werden angelegt oder aktualisiert (append-only)
- Kein Git-Commit (wird vom Aufrufer, z.B. migrate/bootstrap, erzeugt)
