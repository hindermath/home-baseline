# Implementation Plan: Workspace Homogeneity Guardian

**Branch**: `001-workspace-homogeneity-guardian` | **Date**: 2026-04-01 | **Spec**: `specs/001-workspace-homogeneity-guardian/spec.md`  
**Input**: Feature specification from `specs/001-workspace-homogeneity-guardian/spec.md`

## Summary

Zwei neue Shell-Script-Werkzeuge erweitern die `home-baseline`-Infrastruktur:

1. **`check-homogeneity.sh/.ps1`** — Read-only Compliance-Scanner. Traversiert alle
   drei Hierarchieebenen (`~/` → Workspaces → Projekte), prüft Datei-Präsenz,
   Hook-Integrität (SHA-256), Bilingualität, A11Y, Secret-Exposition und SDD-Konformität.
   Schreibt `STATS.md` (append-only), erzeugt `memory-patch.md` bei definierten Triggern,
   unterstützt `--verbose`, `--json` und `--apply-patch`.

2. **`bootstrap-project.sh/.ps1`** — Projekt-Bootstrap-Tool. Legt in einem einzigen
   idempotenten Aufruf alle Pflichtdateien an, installiert den kanonischen Secret-Hook,
   initialisiert alle vier KI-Agenten (Claude, Codex, Gemini, Copilot), installiert
   Spec-kit und generiert ein erstes Spec-Scaffold — bilingual, A11Y-konform, Azubi-tauglich.

Beide Tools laufen auf macOS 14+, Ubuntu 22.04/24.04 LTS, Debian 12 und Windows (WSL2)
und nutzen ausschließlich freie Shell-Werkzeuge aus dem bestehenden Stack.

---

## Technical Context

**Language/Version**: Bash 5+ (primär), PowerShell Core 7+ (Windows-Parität)  
**Primary Dependencies**: `git`, `bash` ≥ 5, `ripgrep (rg)`, `sha256sum` (Linux/WSL) /
`shasum -a 256` (macOS), `gh` (optional — Remote-Push), KI-Agenten-CLIs (optional)  
**Storage**: Plain-Markdown-Dateien — `STATS.md` (append-only), `memory-patch.md`
(ephemeral), `STATS.md.lock` (ephemeral Mutex), `scripts/templates/` (Bootstrap-Vorlagen)  
**Testing**: Manuell mit `--dry-run` / `--preview` (Constitution V); kein automatisches Test-Framework  
**Target Platform**: macOS 14+, Ubuntu 22.04 LTS, Ubuntu 24.04 LTS, Debian 12, Windows 10/11 via WSL2  
**Project Type**: CLI tools (Shell-Skripte), Erweiterung des bestehenden `scripts/`-Baums  
**Performance Goals**: Vollscan < 30 s für ≤ 10 Workspaces + ≤ 50 Projekte (SC-002)  
**Constraints**: 100 % offline-fähig (außer Spec-kit-Install), keine bezahlten Tools,
kein GUI-Framework, kein automatisches Test-Framework  
**Scale/Scope**: 3 feste Hierarchieebenen; max. 10 Workspaces; max. 50 Projekte

---

## Constitution Check

*GATE: Muss vor Phase 0 bestehen. Re-Check nach Phase 1.*

| Prinzip | Status | Anmerkung |
|---------|--------|-----------|
| I. Security-First | ✅ PASS | FR-003 REDACTED-Ausgabe. FR-002 SHA-256-Hook-Vergleich. `memory-patch.md` kein Auto-Commit. `.gitignore` Whitelist braucht `!STATS*.md`, `!memory-patch.md`, `!scripts/templates/` |
| II. Cross-Platform Parity | ✅ PASS | Jedes neue Skript bekommt `.sh` + `.ps1`-Variante |
| III. Bootstrap Automation | ✅ PASS | `bootstrap-project.sh` ist der neue Bootstrap-Einstiegspunkt für Level-2-Projekte |
| IV. Workspace Isolation | ✅ PASS | Git-Submodule explizit Out of Scope. Scanner respektiert 3-Ebenen-Tiefenbegrenzung |
| V. Manual-First Verification | ✅ PASS | `--dry-run`/`--preview` Pflicht (FR-011). `--apply-patch` erfordert expliziten Aufruf. Kein Test-Runner |

**Gate-Ergebnis**: ✅ PASS — keine Verletzungen. Weiter zu Phase 0.

**Post-Design Re-Check** (nach Phase 1): ✅ alle erledigt
- `.gitignore`-Whitelist: `!STATS*.md` ✅, `!scripts/` ✅ (deckt lib/ + templates/), `!specs/` ✅, `!.specify/` ✅ — alle Einträge vorhanden
- SHA-256-Vergleichslogik in `hg-hook.sh` berührt `scripts/hooks/pre-push` → `scan-agent-secrets.sh --fail-on-high .` vor Push Pflicht (Constitution I) ✅
- Compliance-Score für neu bootstrappte Projekte: 100 % ✅ (verifiziert mit T032)
- Compliance-Score für bestehende Legacy-Workspaces: 57 % (0 FAILs, 64 WARNs — bilingual/A11Y in Pre-existing Dateien; kein Blocker)

---

## Project Structure

### Documentation (this feature)

```text
specs/001-workspace-homogeneity-guardian/
├── plan.md              # Dieses Dokument
├── research.md          # Phase 0 — technische Entscheidungen
├── data-model.md        # Phase 1 — Datenmodell & Entitäten
├── quickstart.md        # Phase 1 — Schnellstart-Anleitung
├── contracts/
│   ├── check-homogeneity-cli.md    # CLI-Vertrag: Compliance-Tool
│   └── bootstrap-project-cli.md   # CLI-Vertrag: Bootstrap-Tool
└── tasks.md             # Phase 2 — speckit-tasks (noch nicht erstellt)
```

### Source Code (repository root)

```text
scripts/
├── check-homogeneity.sh        # NEU — Compliance-Scanner (Bash)
├── check-homogeneity.ps1       # NEU — Compliance-Scanner (PowerShell)
├── bootstrap-project.sh        # NEU — Projekt-Bootstrap (Bash)
├── bootstrap-project.ps1       # NEU — Projekt-Bootstrap (PowerShell)
├── lib/
│   ├── hg-scan.sh              # Ebenen-Traversal & .git-Erkennung
│   ├── hg-bilingual.sh         # FR-004: Bilingualitätsprüfung
│   ├── hg-a11y.sh              # FR-005/006: Accessibility-Checks
│   ├── hg-hook.sh              # FR-002: Hook-SHA-256-Vergleich
│   ├── hg-secrets.sh           # FR-003: Secret-Pattern (REDACTED)
│   ├── hg-deps.sh              # FR-016: bezahlte NuGet-Pakete
│   ├── hg-speckit.sh           # FR-018: Spec-kit-Template-Version
│   ├── hg-stats.sh             # FR-007/008: STATS.md + Archivierung
│   └── hg-patch.sh             # FR-020/021: memory-patch.md
└── templates/
    ├── CLAUDE.md.tmpl           # Zweisprachige KI-Agenten-Vorlagen
    ├── GEMINI.md.tmpl
    ├── AGENTS.md.tmpl
    ├── copilot-instructions.tmpl
    ├── README.md.tmpl           # Bilingual mit Azubi-Abschnitt
    └── gitignore-project.tmpl   # .gitignore für Level-2-Projekte
```

**Structure Decision**: Erweiterung des bestehenden `scripts/`-Baums. Bibliotheks-
Funktionen tragen das Präfix `hg-` (homogeneity-guardian), um Namenskonflikte mit
bestehenden Skripten zu vermeiden. PowerShell-Varianten spiegeln die Bash-Logik
mit nativen PS-Idiomen (Cmdlets statt shell builtins).
