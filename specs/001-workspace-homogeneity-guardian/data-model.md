# Datenmodell: Workspace Homogeneity Guardian

**Branch**: `001-workspace-homogeneity-guardian` | **Date**: 2026-04-01  
**Quelle**: `specs/001-workspace-homogeneity-guardian/spec.md` (Key Entities + FRs)

---

## Entitäten-Übersicht

```text
HierarchyLevel
  └── Directory (0..N)
        └── ComplianceCheck (0..M per required check type)
              └── CheckResult

StatRun
  └── StatEntry (1 pro gescanntem Directory)

MemoryPatch
  └── MemoryPatchEntry (1..N, kategoriegeroutet)

HookStatus (1 pro .git-Repository)
ArchiveEvent (entsteht bei STATS.md-Rotation)
```

---

## Entitäten im Detail

### HierarchyLevel

Repräsentiert eine der drei festen Scan-Ebenen.

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `level_id` | `int` | 0 = Home (`~/`), 1 = Workspace, 2 = Projekt |
| `label` | `string` | `"home"`, `"workspace"`, `"project"` |
| `required_files` | `string[]` | Pflichtdateien für diese Ebene (s. unten) |

**Pflichtdateien je Ebene**:

| Level 0 (Home) | Level 1 (Workspace) | Level 2 (Projekt) |
|---|---|---|
| `AGENTS.md` | `AGENTS.md` | `AGENTS.md` |
| `CLAUDE.md` | `CLAUDE.md` | `CLAUDE.md` |
| `GEMINI.md` | `GEMINI.md` | `GEMINI.md` |
| `.github/copilot-instructions.md` | `.github/copilot-instructions.md` | `.github/copilot-instructions.md` |
| `README.md` | `README.md` | `README.md` |
| `STATS.md` | `STATS.md` | `STATS.md` |
| `scripts/hooks/pre-push` | `.git/hooks/pre-push` | `.git/hooks/pre-push` |
| — | — | `specs/*/spec.md` (wenn SDD-Projekt) |

---

### Directory

Ein tatsächliches Verzeichnis im Dateisystem, das als Workspace oder Projekt
qualifiziert (enthält `.git/`).

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `path` | `string` | Absoluter Pfad |
| `level` | `int` | 0, 1 oder 2 |
| `has_git` | `bool` | `.git/`-Unterverzeichnis vorhanden |
| `is_sdd` | `bool` | Enthält `specs/*/spec.md` |
| `last_seen` | `string` | Timestamp des letzten Compliance-Runs (ISO 8601) |

**Qualifikationsregel**: Ein Directory wird nur gescannt, wenn `has_git = true`.
Level-0 (`~/`) wird immer gescannt (ist der Scan-Startpunkt).

**Zustandsübergänge**:
```text
[unbekannt] → discovered (erstmals gefunden) → memory-patch TRIGGER
[bekannt]   → score ändert sich ≥10%         → memory-patch TRIGGER
[bekannt]   → neuer WARN/FAIL-Typ            → memory-patch TRIGGER
```

---

### CheckResult

Ergebnis einer einzelnen Compliance-Prüfung für eine Datei/Regel in einem Directory.

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `directory_path` | `string` | Pfad des geprüften Verzeichnisses |
| `check_id` | `string` | Verweis auf FR (z.B. `FR-002`, `FR-004`) |
| `check_name` | `string` | Menschenlesbar: `"hook-integrity"`, `"bilingual"`, etc. |
| `target_file` | `string` | Geprüfte Datei (relativ zum directory_path) |
| `status` | `enum` | `PASS` / `FAIL` / `WARN` |
| `detail` | `string` | Meldungstext (Secret-Werte als `[REDACTED]`) |

**Status-Semantik**:
- `PASS`: Prüfung bestanden, zählt zum Score
- `FAIL`: Pflichtprüfung nicht bestanden (zieht Score-Punkte ab), Exit-Code 1
- `WARN`: Prüfung nicht bestanden, aber nicht blockierend (zieht Punkte ab), Exit-Code 1

**Exit-Codes des Tools**:
| Code | Bedeutung |
|------|-----------|
| 0 | Alle Prüfungen PASS |
| 1 | Mindestens ein FAIL oder WARN |
| 2 | Fataler Fehler (STATS.md locked, kein `rg`, etc.) |

---

### ComplianceScore

Aggregiertes Ergebnis für ein Directory nach einem Scan-Run.

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `directory_path` | `string` | Pfad |
| `run_timestamp` | `string` | ISO-8601-Timestamp |
| `checks_total` | `int` | Anzahl aller durchgeführten Checks |
| `checks_passed` | `int` | Anzahl PASS-Ergebnisse |
| `score_pct` | `int` | `round(checks_passed / checks_total * 100)` |
| `prev_score_pct` | `int\|null` | Score aus letztem STATS.md-Eintrag (für Trigger-Vergleich) |

---

### StatRun

Ein einzelner Schreibvorgang in `STATS.md` — entspricht einem vollständigen Scan-Run.

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `timestamp` | `string` | `YYYY-MM-DD HH:MM` (Heading in STATS.md) |
| `entries` | `StatEntry[]` | Ein Eintrag pro gescanntem Directory |
| `total_workspaces` | `int` | Anzahl Level-1-Directories |
| `total_projects` | `int` | Anzahl Level-2-Directories |
| `overall_score` | `int` | Durchschnitt aller Entry-Scores |

**STATS.md-Schema** (FR-008):
```markdown
## Run 2026-04-01 14:30

| Level | Verzeichnis | Score % |
|-------|-------------|---------|
| 0     | ~/          | 92      |
| 1     | RiderProjects | 87   |
| 2     | TuiVision   | 100     |

### Compliance-Balkendiagramm
~/             [█████████░] 92 %
RiderProjects  [████████░░] 87 %
TuiVision      [██████████] 100 %

### Datei-Präsenz-Matrix

| Verzeichnis | AGENTS | CLAUDE | GEMINI | Copilot | README | STATS | Hook |
|-------------|--------|--------|--------|---------|--------|-------|------|
| ~/          | ✓      | ✓      | ✓      | ✓       | ✓      | ✓     | ✓    |
| RiderProjects | ✓   | ✓      | ✗      | ✓       | ✓      | ✓     | ✓    |
| TuiVision   | ✓      | ✓      | ✓      | ✓       | ✓      | ✓     | ✓    |
```

---

### StatEntry

Zeile in der STATS.md-Tabelle eines StatRun.

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `level` | `int` | 0, 1 oder 2 |
| `directory` | `string` | Relativer Pfad ab `~/` |
| `score_pct` | `int` | Compliance-Score in Prozent |
| `file_presence` | `map<string, bool>` | Dateiname → vorhanden (true/false) |

---

### MemoryPatch

Generiertes Dokument mit vorgeschlagenen Ergänzungen für Agent-Dateien, READMEs
und die Verfassung.

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `generated_at` | `string` | ISO-8601-Timestamp |
| `trigger` | `string` | Auslösende Trigger-Klasse (s. FR-020) |
| `entries` | `MemoryPatchEntry[]` | Geordnet nach Zielkategorie |

**Dateiname**: `memory-patch.md` im SPECS_DIR des aktuellen Features.

---

### MemoryPatchEntry

Ein einzelner vorgeschlagener Eintrag im Memory Patch.

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `category` | `enum` | `constitution` / `agent_file` / `readme` |
| `target_path` | `string` | Absoluter Pfad der Zieldatei |
| `proposed_content` | `string` | Einzufügender Markdown-Block |
| `rationale` | `string` | Einzeilige Begründung + angewandte Routing-Regel |

**Routing-Schema** (FR-021):
| Kategorie | Bedingung | Zieldatei |
|-----------|-----------|-----------|
| `constitution` | Neue projektweite Konvention oder Sicherheitsregel | `~/.specify/memory/constitution.md` |
| `agent_file` | Werkzeugspezifischer Kontext-Fakt (Score, Workspace-Zustand) | `{dir}/CLAUDE.md`, `{dir}/GEMINI.md`, etc. |
| `readme` | Neue Azubi-Anleitungsergänzung | `{dir}/README.md` |

---

### HookStatus

Ergebnis der Hook-Integritätsprüfung für ein Repository (FR-002).

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `repo_path` | `string` | Absoluter Repo-Pfad |
| `hook_path` | `string` | `{repo_path}/.git/hooks/pre-push` |
| `canonical_path` | `string` | `~/scripts/hooks/pre-push` |
| `canonical_sha256` | `string` | SHA-256 des kanonischen Hooks |
| `installed_sha256` | `string\|null` | SHA-256 des installierten Hooks (null wenn fehlend) |
| `status` | `enum` | `PASS` / `WARN: hook outdated` / `FAIL: hook missing` |

---

### ArchiveEvent

Entsteht, wenn `STATS.md` die Schwelle von 500 Einträgen erreicht (FR-007).

| Feld | Typ | Beschreibung |
|------|-----|--------------|
| `original_path` | `string` | Pfad der archivierten `STATS.md` |
| `archive_path` | `string` | `STATS-archive-YYYY.md` |
| `entry_count` | `int` | Anzahl Run-Einträge beim Archivieren |
| `archived_at` | `string` | ISO-8601-Timestamp |

---

## Entitätsbeziehungen

```text
HierarchyLevel (0/1/2)
    └── qualifiziert Directory-Objekte (has_git = true)
            └── hat N CheckResults pro Scan
            └── hat 1 ComplianceScore pro Scan
            └── hat 1 StatEntry in StatRun
            └── hat 1 HookStatus (wenn .git vorhanden)

StatRun
    └── enthält N StatEntries
    └── wird in STATS.md geschrieben (FR-007/008)
    └── kann ArchiveEvent auslösen (bei ≥500 Runs)
    └── kann MemoryPatch auslösen (bei Trigger-Bedingung FR-020)

MemoryPatch
    └── enthält N MemoryPatchEntries (geroutet nach Kategorie)
    └── wird mit --apply-patch auf Zieldateien angewendet
```

---

## Validierungsregeln

| Regel | Beschreibung |
|-------|--------------|
| `score_pct` ∈ [0, 100] | Prozentsatz immer ganzzahlig gerundet |
| `detail` für Secrets | Muss `[REDACTED]` enthalten, nie matched value |
| `STATS.md` | Nur append; bestehende Einträge nie modifizieren |
| `MemoryPatchEntry.target_path` | Muss existieren (außer bei `constitution` — wird angelegt) |
| `HookStatus.canonical_path` | Immer `~/scripts/hooks/pre-push` (FR-002) |
| Lock-Timeout | `STATS.md.lock`: max. 5 Sekunden Wartezeit, dann Exit-Code 2 |
| `STATS.md`-Archivierung | Trigger bei ≥ 500 `## Run`-Einträgen; Archiv-Datei wird git-tracked |
