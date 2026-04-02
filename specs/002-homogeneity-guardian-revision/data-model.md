# Datenmodell / Data Model
# Phase 1 — Workspace Homogeneity Guardian Revision

**Feature**: `002-homogeneity-guardian-revision`  
**Datum / Date**: 2026-04-02

---

## Kernentitäten / Core Entities

### WorkspaceLevel

```
WorkspaceLevel :: 0 | 1 | 2

0 = Home-Verzeichnis ~/  (home-baseline Repository)
1 = Direktes Workspace-Unterverzeichnis von ~/  (z.B. ~/RiderProjects/)
2 = Projekt innerhalb eines Level-1-Workspace mit eigenem .git/
```

**Erkennung / Detection**:
- Level 0: Immer `~/` — kein Test nötig
- Level 1: `[ -d "$HOME/$dir/.git" ]` für jedes `$dir` in `~/`
- Level 2: `find "$level1_path" -mindepth 2 -maxdepth 2 -name ".git" -type d`

---

### WorkspaceInfo

```
WorkspaceInfo {
  name:        string        # Verzeichnisname (basename), z.B. "RiderProjects"
  path:        string        # Absoluter Pfad, z.B. "/Users/thorstenhindermann/RiderProjects"
  level:       WorkspaceLevel
  git_root:    string        # Absoluter Pfad zum .git-Verzeichnis
  has_remote:  boolean       # git remote -v liefert mindestens eine URL
  is_csharp:   boolean       # find . -maxdepth 2 -name "*.sln" liefert ≥1 Treffer (Level 2 only)
  children:    WorkspaceInfo[]  # Level-2-Projekte (nur wenn level == 1)
}
```

---

### ComplianceCheck

```
ComplianceCheck {
  file:       string          # Relativer Pfad zur geprüften Datei (z.B. "README.md")
  check:      string          # Name der Prüfung (z.B. "A11Y section", "STATS.md present")
  level:      WorkspaceLevel
  status:     "pass" | "fail" | "warn"
  workspace:  string          # Name des Level-1-Workspace (oder "root" für Level 0)
}
```

**Pflichtdatei-Matrix / Mandatory File Matrix**:

| Datei / File | Level 0 | Level 1 | Level 2 | Level 2 C# only |
|---|:---:|:---:|:---:|:---:|
| `README.md` | ✓ | ✓ | ✓ | ✓ |
| `AGENTS.md` | ✓ | ✓ | — | — |
| `CLAUDE.md` | ✓ | ✓ | — | — |
| `GEMINI.md` | ✓ | ✓ | — | — |
| `.github/copilot-instructions.md` | ✓ | ✓ | — | — |
| `constitution.md` | ✓ | ✓ | ✓ | ✓ |
| `STATS.md` | ✓ | ✓ | ✓ | ✓ |
| `.github/workflows/homogeneity-check.yml` | ✓ | ✓ | ✓ | ✓ |
| `scripts/hooks/pre-push` | ✓ | ✓ | — | — |
| `.git/hooks/pre-push` | ✓ | ✓ | ✓ | ✓ |
| `.editorconfig` | — | — | — | ✓ |

**Inhalts-Checks / Content Checks** (über reine Präsenz hinaus):

| Check-Name | Zieldatei | Prüfung |
|---|---|---|
| `A11Y section` | `README.md` | Enthält `## Barrierefreiheit / Accessibility (A11Y)` |
| `Spec-kit section` | `README.md` | Enthält `## Spec-kit-Workflow` |
| `Azubis section` | `README.md` | Enthält `## Für Azubis / For Apprentices` |
| `EN placeholder` | `README.md`, Agent-Dateien | Enthält `<!-- EN:` |
| `no ANSI codes` | `scripts/**` | Kein `\x1b[`, `\033[`, `\e[` (NFR-REV-07) |

---

### ComplianceReport

```
ComplianceReport {
  score:     integer (0–100)   # ✓ / (✓ + ✗) × 100; WARN zählt nicht als Fehler
  by_level:  {
    "0": integer,
    "1": integer,
    "2": integer
  }
  failures:  ComplianceCheck[] (nur status == "fail")
  warnings:  ComplianceCheck[] (nur status == "warn")
}
```

**JSON-Beispiel** (Ausgabe bei `--json`):
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

---

### StatsEntry

```
StatsEntry {
  timestamp:  string          # Format: "YYYY-MM-DD HH:MM" (lokale Zeit)
  score:      integer (0–100)
  ascii_bar:  string          # Berechnete Balkendarstellung (20 Zeichen)
  label:      string          # Freitext-Label, z.B. "baseline" oder "post-migrate"
}
```

**ASCII-Bar-Berechnung / ASCII Bar Calculation**:
- `filled = round(score / 5) * 1`  (auf 5 % gerundet → 0–20 █-Zeichen)
- `empty  = 20 - filled`
- Darstellung: `"█" * filled + "░" * empty`
- Zeile: `YYYY-MM-DD HH:MM | ████░░░░░░░░░░░░░░░░ 20%`

---

### StatsMd

```
StatsMd {
  level:        WorkspaceLevel
  project_path: string        # Absoluter Pfad zum Projektverzeichnis
  header:       string        # Bilinguale Kopfzeile (NFR-REV-05)
  entries:      StatsEntry[]  # Append-only; älteste zuerst
}
```

**Dateipfade / File Paths**:
- Level 0: `~/STATS.md`
- Level 1: `~/{workspace-name}/STATS.md`
- Level 2: `~/{workspace-name}/{project-name}/STATS.md`

**Bilingualer Header (NFR-REV-05)**:
```markdown
# Statistiken / Statistics

| Datum / Date | Compliance-Score | Fortschritt / Progress |
|---|---|---|
```

---

### ConstitutionVersion

```
ConstitutionVersion {
  major:       integer
  minor:       integer
  patch:       integer
  raw_version: string    # z.B. "1.1.0"
  source:      string    # Absoluter Pfad zur extrahierten Datei
}
```

**Extraktion / Extraction** (aus erster Zeile der Datei):
```bash
grep -m1 "^# Constitution v" constitution.md | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'
```
Fehlt diese Zeile → `ERROR: constitution.md hat keine Versionszeile`

---

### TemplateDatei / TemplateFile

```
TemplateFile {
  name:          string          # Dateiname (z.B. "a11y-section.md")
  path:          string          # Absoluter Pfad (z.B. "scripts/templates/a11y-section.md")
  target_files:  string[]        # Zieldateien, in die der Inhalt eingefügt wird
  language:      "bilingual"     # Immer bilingual DE first, EN second, CEFR B2
}
```

| Template | Zieldatei / Target | Einfügeposition |
|---|---|---|
| `a11y-section.md` | `README.md` | Nach vorhandenem Inhalt |
| `speckit-workflow-section.md` | `README.md` | Nach vorhandenem Inhalt |
| `azubis-section.md` | `README.md` | Nach vorhandenem Inhalt |
| `readme-template.md` | `README.md` (neu) | Vollständige Vorlage für neue Projekte |

---

## Zustandsübergänge / State Transitions

### Migration-Lifecycle

```
[non-compliant] 
    → migrate-workspace.sh --dry-run  →  [preview only, no change]
    → migrate-workspace.sh            →  [pending confirmation]
    → Proceed? [y/N] = y              →  [migrating]
    → git commit + init-stats.sh      →  [migrated, STATS.md baseline created]
    → check-homogeneity.sh            →  [score ≥ baseline + 40pp]  (SC-REV-07)
```

### Bootstrap-Lifecycle (neues Projekt)

```
[neues Verzeichnis]
    → bootstrap-project.sh            →  [files created]
    → git init + gh repo create       →  [local + remote repo]
    → init-stats.sh (auto)            →  [STATS.md baseline]
    → check-homogeneity.sh            →  [100% compliant]  (SC-001)
```

### Constitution-Propagation-Lifecycle

```
[constitution.md v1.1.0 → v1.2.0]
    → sync-constitution.sh --dry-run  →  [WOULD UPDATE preview]
    → sync-constitution.sh            →  [Proceed? [y/N] = y]
    → copy + git commit per workspace →  [UPDATED / SKIPPED / ALREADY UP-TO-DATE]
```

---

## Validierungsregeln / Validation Rules

| Entity | Feld / Field | Regel / Rule |
|---|---|---|
| StatsEntry.timestamp | Format | `YYYY-MM-DD HH:MM` (keine Sekunden) |
| StatsEntry.score | Bereich / Range | 0–100 (ganze Zahl / integer) |
| StatsEntry.ascii_bar | Länge / Length | Immer exakt 20 Zeichen |
| ConstitutionVersion | Quelle / Source | Erste Zeile der Datei, kein Fallback |
| ComplianceReport.score | Formel / Formula | `✓ / (✓ + ✗) × 100`; WARN ignoriert |
| TemplateFile | Sprache / Language | Immer bilingual DE/EN, CEFR B2 |
