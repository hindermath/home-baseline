# Feature Specification: Workspace-Migration
# Lastenheft: Workspace-Migrations-Werkzeug — Erweiterung & Härtung

**Feature Branch**: `feat/workspace-migration` *(wird nach Spec-kit-Lauf aktualisiert / updated after Spec-kit run)*
**Erstellt / Created**: 2026-04-08
**Status**: Draft
**Verwandte Lastenheft / Related Lastenheft**: `Lastenheft_GitLab_Support.md`, `Lastenheft_CICD_Pipeline_Konfiguration.md`
**Bezugs-Skript / Reference Script**: `scripts/migrate-workspace.sh` (v1.0)
**Konstitutions-Version / Constitution Version**: 1.1.0
**Autor / Author**: hindermath (`hindermath`)

---

## Dateibenennungs-Konvention / File Naming Convention

```
Lastenheft_{KurzName}.{branch-name}.md
```

Aktueller Stand vor Spec-kit-Durchlauf: `Lastenheft_Workspace_Migration.md`
Nach Spec-kit-Durchlauf: `Lastenheft_Workspace_Migration.{branch-name}.md`

---

## Anforderungskatalog (Originalanforderung) / Requirements Catalog (Original Request)

> Dieses Kapitel dokumentiert die ursprüngliche Anforderung vollständig und
> unverändert.
>
> *This chapter documents the original requirement in full and unchanged.*

### Originaltext (DE)

> Das Skript `migrate-workspace.sh` (v1.0) existiert bereits, weist aber
> mehrere Lücken auf:
>
> - Kein PowerShell-Äquivalent (`migrate-workspace.ps1`) für Windows-Nutzer
> - Kein Rollback-Mechanismus bei Fehler — Änderungen sind irreversibel
> - Keine GitLab-Unterstützung (Remote-URL, `.gitlab-ci.yml`)
> - Kein Fortschritts-Reporting / Exit-Code-Protokoll für CI-Nutzung
> - Kein Migrationspfad für bereits vorhandene, aber unvollständige
>   STATS.md-Dateien
> - Die Homogenitäts-Prüfung nach der Migration fehlt — es gibt keine
>   automatische Verifikation ob die Migration erfolgreich war
> - Keine Unterstützung für neue CI-Workflow-Templates
>   (Secret-Scan, Release-Please) aus `Lastenheft_CICD_Pipeline_Konfiguration.md`

### Klärungsergebnisse / Clarification Outcomes

| Frage / Question | Antwort / Answer |
|---|---|
| PowerShell-Parität? | Ja — `migrate-workspace.ps1` als vollständiges Äquivalent |
| Rollback-Mechanismus? | `git stash` vor Migration + automatischer Rollback bei kritischem Fehler |
| GitLab-Unterstützung? | Ja — `.gitlab-ci.yml` anlegen wenn Remote GitLab ist; Abhängigkeit von GitLab-Support-Feature |
| Verifikation nach Migration? | Ja — `check-homogeneity.sh/.ps1` nach Migration automatisch ausführen |
| STATS.md-Migration? | Ja — fehlende STATS.md via `init-stats.sh/.ps1` anlegen (bereits teils implementiert) |
| CI-nutzbar? | Ja — maschinenlesbare Exit-Codes + optionales JSON-Report |
| Interaktiver Prompt? | Beibehalten; `--yes` Flag für CI/non-interaktiv |

---

## Systemüberblick / System Overview

### Ist-Zustand / Current State

```
╔══════════════════════════════════════════════════════════════════════╗
║  Workspace-Migration — Ist-Zustand / Current State (v1.0)            ║
╠══════════════════════════════════════════════════════════════════════╣
║  Komponente                           Status   Befund                ║
║  ───────────────────────────────────  ──────   ──────────────────── ║
║  migrate-workspace.sh                 ✓ OK     v1.0 vorhanden        ║
║  migrate-workspace.ps1                ✗ FEHLT  kein Windows-Äquiv.   ║
║  Rollback bei Fehler                  ✗ FEHLT  irreversibel           ║
║  Post-Migration-Verifikation          ✗ FEHLT  kein auto-Check        ║
║  GitLab-Remote-Erkennung              ✗ FEHLT  nur GitHub             ║
║  .gitlab-ci.yml anlegen               ✗ FEHLT  nicht implementiert    ║
║  secret-scan.yml anlegen              ✗ FEHLT  nur homogeneity.yml   ║
║  release-please.yml anlegen           ✗ FEHLT  nicht implementiert    ║
║  STATS.md-Migration                   ~ WARN   init-stats aufgerufen, ║
║                                                aber nicht verifiziert ║
║  JSON-Report (CI-Output)              ✗ FEHLT  nur Text-Output        ║
║  Fortschritts-Protokoll               ~ WARN   Text, kein strukturiert║
╠══════════════════════════════════════════════════════════════════════╣
║  Legende: ✓ OK · ✗ FEHLT · ~ WARN                                   ║
╚══════════════════════════════════════════════════════════════════════╝
```

### Ziel-Zustand / Target State

`migrate-workspace` v2.0 ist eine robuste, cross-platform Migration mit
Rollback-Sicherheit, automatischer Verifikation, GitLab-Unterstützung und
CI-tauglichem Reporting.

*`migrate-workspace` v2.0 is a robust, cross-platform migration tool with
rollback safety, automatic verification, GitLab support, and CI-ready reporting.*

---

## Funktionale Anforderungen / Functional Requirements

### FR-01 — migrate-workspace.ps1 (Windows-Parität)

Eine neue Datei `scripts/migrate-workspace.ps1` wird erstellt, die funktional
äquivalent zu `migrate-workspace.sh` v2.0 ist.

Parameter-Konventionen (PascalCase):
```text
-WorkspaceName <string>   (optional — leer = alle Workspaces)
-DryRun                   (Switch)
-Yes                      (Switch — kein interaktiver Prompt)
-JsonReport               (Switch — maschinenlesbaren JSON-Report ausgeben)
```

*A new `migrate-workspace.ps1` is created, functionally equivalent to the
Bash variant.*

---

### FR-02 — Rollback-Mechanismus / Rollback Mechanism

Vor dem ersten Schreibzugriff auf einen Workspace:

1. `git stash` ausführen falls uncommittete Änderungen vorhanden
2. Stash-Referenz merken
3. Bei kritischem Fehler (`exit 2`): `git stash pop` ausführen
4. Bei Erfolg: Stash wird nicht automatisch gepoppt (Nutzer entscheidet)

Ausgabe:
```text
→ Stash erstellt: stash@{0} (zur Sicherheit / as safety net)
```

*Before the first write access, `git stash` is run if uncommitted changes exist.
On critical error, `git stash pop` restores the original state.*

---

### FR-03 — Post-Migration-Verifikation / Post-Migration Verification

Nach Abschluss aller Migrations-Schritte wird automatisch ausgeführt:

```bash
bash scripts/check-homogeneity.sh "$WORKSPACE_NAME"
```

PowerShell:
```powershell
& scripts/check-homogeneity.ps1 -TargetDir $WorkspaceName
```

- Ergebnis wird im Abschlussbericht ausgegeben
- Schlägt `check-homogeneity` fehl, endet `migrate-workspace` mit Exit-Code 1
  (partial fail) — nicht 2 (critical error)

*After all migration steps, `check-homogeneity` runs automatically. Failure
exits with code 1 (partial).*

---

### FR-04 — Remote-Plattform-Erkennung / Remote Platform Detection

Das Skript erkennt automatisch ob ein Workspace-Repo auf GitHub oder GitLab liegt:

```bash
remote_url=$(git -C "$ws_dir" remote get-url origin 2>/dev/null || echo "")
if echo "$remote_url" | grep -q "gitlab"; then
  PLATFORM="gitlab"
else
  PLATFORM="github"
fi
```

Die erkannte Plattform steuert welche CI-Workflow-Templates angelegt werden
(FR-05, FR-06).

*The script auto-detects whether a workspace repo is hosted on GitHub or GitLab
and selects appropriate CI templates.*

---

### FR-05 — CI-Template-Migration: GitHub Actions

Bei erkanntem GitHub-Remote und fehlendem `secret-scan.yml`:

- `scripts/templates/workflows/github/secret-scan.yml` → `.github/workflows/`
- (Abhängigkeit: `Lastenheft_CICD_Pipeline_Konfiguration.md` — FR-02)

Bereits vorhandene Templates werden nicht überschrieben (außer `--force`).

*When GitHub remote is detected and `secret-scan.yml` is missing, the template
is copied. Existing files are not overwritten unless `--force` is passed.*

---

### FR-06 — CI-Template-Migration: GitLab CI

Bei erkanntem GitLab-Remote und fehlender `.gitlab-ci.yml`:

- Erzeugt `.gitlab-ci.yml` aus `scripts/templates/workflows/gitlab/`
- (Abhängigkeit: `Lastenheft_GitLab_Support.md` + `Lastenheft_CICD_Pipeline_Konfiguration.md`)

*When GitLab remote is detected and `.gitlab-ci.yml` is missing, it is generated
from the appropriate template.*

---

### FR-07 — STATS.md-Verifikation / STATS.md Verification

Nach der Migration wird geprüft ob `STATS.md` vorhanden ist. Falls nicht:

```bash
bash scripts/init-stats.sh "$WORKSPACE_NAME"
```

Die init-stats-Ausführung wird im Migrationsprotokoll vermerkt.

*After migration, STATS.md presence is verified and `init-stats.sh` is run
if missing.*

---

### FR-08 — JSON-Report / JSON Report

Mit dem Flag `--json-report` / `-JsonReport` wird nach der Migration eine
maschinenlesbare Zusammenfassung auf stdout ausgegeben:

```json
{
  "workspace": "MyProjects",
  "status": "success",
  "steps": [
    { "action": "en-placeholder", "file": "README.md", "result": "appended" },
    { "action": "secret-scan.yml", "result": "created" },
    { "action": "check-homogeneity", "result": "passed", "score": "25/25" }
  ],
  "exit_code": 0
}
```

*With `--json-report`, a machine-readable JSON summary is output to stdout.*

---

### FR-09 — Bilingualer Fortschritts-Output / Bilingual Progress Output

Alle Statuszeilen erscheinen bilingual:

```text
→ Migriere / Migrating: ~/MyProjects
  ✓ EN-Platzhalter / EN placeholder: README.md
  ✓ Workflow hinzugefügt / Workflow added: secret-scan.yml
  ✓ Verifikation bestanden / Verification passed: 25/25 Checks
```

*All status lines appear bilingual: German + English.*

---

### FR-10 — --force Flag

Neues optionales Flag `--force` / `-Force`:

- Überschreibt bereits vorhandene Workflow-Dateien mit aktuellen Templates
- Nützlich wenn Templates sich geändert haben
- Wird in der Dry-Run-Ausgabe angezeigt welche Dateien überschrieben würden

*New `--force` flag overwrites existing workflow files with current templates.
Useful after template updates.*

---

### FR-11 — Versions-Prüfung von Workflow-Templates / Workflow Template Version Check

Das Skript liest den Versions-Header aus bestehenden Workflow-Dateien
(FR-08 aus `Lastenheft_CICD_Pipeline_Konfiguration.md`) und warnt wenn
die installierte Version älter als die Template-Version ist.

```text
WARN: homogeneity-check.yml in MyProjects/ ist veraltet (v1.0 → v1.2)
      Aktualisieren mit / Update with: --force
```

*The script reads version headers from existing workflow files and warns
when the installed version is older than the current template.*

---

## Nicht-funktionale Anforderungen / Non-Functional Requirements

### NFR-01 — Exit-Code-Protokoll / Exit Code Protocol

| Exit-Code | Bedeutung / Meaning |
|:---:|---|
| 0 | Vollständiger Erfolg / Complete success |
| 1 | Partieller Erfolg — Warnungen vorhanden / Partial success — warnings present |
| 2 | Kritischer Fehler — Migration abgebrochen / Critical error — migration aborted |

*Consistent exit codes for CI usage.*

---

### NFR-02 — Rückwärtskompatibilität / Backward Compatibility

Alle bestehenden Aufrufe von `migrate-workspace.sh` ohne neue Flags funktionieren
unverändert. Neue Features sind ausschließlich opt-in via neue Flags.

*All existing calls without new flags continue to work unchanged.*

---

### NFR-03 — Idempotenz / Idempotency

Mehrfaches Ausführen auf demselben Workspace erzeugt dieselben Ergebnisse.
Bereits vorhandene Dateien werden nicht erneut angelegt (außer `--force`).

*Multiple runs on the same workspace produce the same results. Existing files
are not re-created (unless `--force`).*

---

### NFR-04 — Bilingualität / Bilingualism

Alle neuen Benutzerausgaben bilingual: Deutsch zuerst, Englisch (CEFR B2).

*All new user-facing output is bilingual: German first, English (CEFR B2).*

---

## Abgrenzung / Out of Scope

| Thema / Topic | Begründung / Reason |
|---|---|
| Automatische Datei-Inhaltsmigration (z. B. README-Umstrukturierung) | Zu riskant ohne Review; manueller Schritt |
| Git-History-Rewrite | Nicht im Rahmen einer Homogenitäts-Migration |
| Workspace-zu-Workspace-Kopie | Separates Feature |
| Automatisches `git push` nach Migration | Nutzer soll Änderungen vor Push reviewen |
| Migration von Projekten auf Ebene 2 ohne Level-1 Workspace | Out of Scope |

---

## Akzeptanzkriterien / Acceptance Criteria

| ID | Kriterium / Criterion | Testmethode |
|---|---|---|
| AC-01 | `migrate-workspace.sh --dry-run` zeigt alle geplanten Schritte | `--dry-run` |
| AC-02 | `migrate-workspace.ps1 -DryRun` verhält sich äquivalent | Cross-Plattform |
| AC-03 | Uncommittete Änderungen → Stash angelegt und Referenz ausgegeben | Manuell |
| AC-04 | Kritischer Fehler → `git stash pop` stellt Zustand wieder her | Fehlertest |
| AC-05 | Nach erfolgreicher Migration läuft `check-homogeneity` automatisch | Live-Test |
| AC-06 | GitHub-Remote → `secret-scan.yml` wird angelegt | Live-Test |
| AC-07 | GitLab-Remote → `.gitlab-ci.yml` wird angelegt | Live-Test (nach GitLab-Feature) |
| AC-08 | `--json-report` gibt valides JSON aus | `jq .` Parsen |
| AC-09 | Zweiter Aufruf ohne `--force` → keine Doppel-Writes (Idempotenz) | Regressions-Check |
| AC-10 | Veraltetes Template → WARN-Ausgabe mit Versions-Info | Sichtprüfung |
| AC-11 | Exit-Code 0/1/2 korrekt gesetzt bei Erfolg/Warnung/Fehler | CI-Test |
| AC-12 | Abschluss-Ausgabe bilingual | Sichtprüfung |

---

## Technische Abhängigkeiten / Technical Dependencies

| Abhängigkeit | Typ | Richtung |
|---|---|---|
| `Lastenheft_GitLab_Support.md` | Feature-Abhängigkeit | GitLab-Remote-Erkennung (FR-04, FR-06) |
| `Lastenheft_CICD_Pipeline_Konfiguration.md` | Feature-Abhängigkeit | CI-Templates (FR-05, FR-06, FR-11) |
| `scripts/check-homogeneity.sh/.ps1` | Vorhanden | Post-Migration-Verifikation (FR-03) |
| `scripts/init-stats.sh/.ps1` | Vorhanden | STATS.md-Verifikation (FR-07) |
| `scripts/templates/workflows/` | Neu (CICD-Feature) | CI-Template-Quelle |

---

## Dateien mit Änderungsbedarf / Files Requiring Changes

| Datei / File | Art der Änderung / Type of Change |
|---|---|
| `scripts/migrate-workspace.sh` | v2.0: Rollback, JSON, GitLab, Verifikation, neue Flags |
| `scripts/migrate-workspace.ps1` | Neu anlegen — vollständiges PS7-Äquivalent |
| `README.md` | Neue Flags dokumentieren; migrate-workspace-Abschnitt erweitern |
| `AGENTS.md` / `CLAUDE.md` / `GEMINI.md` | Pitfall-Eintrag: Rollback-Verhalten |

---

## Empfohlene Implementierungsreihenfolge / Recommended Implementation Order

1. `migrate-workspace.ps1` erstellen (FR-01) — unabhängig
2. Rollback-Mechanismus in `.sh` + `.ps1` (FR-02)
3. Post-Migration-Verifikation (FR-03)
4. JSON-Report (FR-08)
5. Remote-Plattform-Erkennung (FR-04) — nach GitLab-Support-Feature
6. CI-Template-Migration GitHub (FR-05) — nach CICD-Feature
7. CI-Template-Migration GitLab (FR-06) — nach beiden Abhängigkeiten
8. Versions-Prüfung (FR-11) — nach CICD-Feature

---

## Spec-Kit-Hinweise / Spec-Kit Notes

> Dieses Lastenheft ist als Eingabe für `specify specify` konzipiert.
> Dieses Feature hat **zwei Abhängigkeiten**:
> - `Lastenheft_GitLab_Support.md` (für GitLab-Remote-Erkennung)
> - `Lastenheft_CICD_Pipeline_Konfiguration.md` (für CI-Templates)
>
> FR-01 bis FR-03 und FR-07–FR-09 können **unabhängig** von diesen
> Abhängigkeiten implementiert werden.
>
> *This Lastenheft has two dependencies. FR-01 to FR-03 and FR-07-FR-09
> can be implemented independently.*

```bash
# Spec-Kit starten / Start Spec-Kit
cd ~/home-baseline-tmp
specify specify Lastenheft_Workspace_Migration.md
```
