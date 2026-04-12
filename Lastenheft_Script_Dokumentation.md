# Lastenheft: Skript-Dokumentation (Unix man-Pages & PowerShell Hilfe)

## 1. Einleitung / Introduction
Dieses Lastenheft beschreibt die Anforderungen für die Einführung von Unix man-Pages und die Standardisierung der PowerShell-Hilfe für alle Skripte im `home-baseline` Repository. Ziel ist es, eine professionelle und konsistente Dokumentation bereitzustellen, die über die Standard-Usage-Zeilen hinausgeht.

*This specification describes the requirements for introducing Unix man pages and standardizing PowerShell help for all scripts in the `home-baseline` repository. The goal is to provide professional and consistent documentation that goes beyond standard usage lines.*

## 2. Funktionale Anforderungen / Functional Requirements

### 2.1 Unix man-Pages für Bash-Skripte
- Für jedes Bash-Skript (`.sh`) im Verzeichnis `scripts/` muss eine korrespondierende Unix man-Page erstellt werden.
- Die man-Pages sollen im Verzeichnis `docs/man/` (oder einem ähnlichen Standardverzeichnis) abgelegt werden.
- Die man-Pages müssen den Namen des Skripts (ohne `.sh`-Endung) tragen und in der Sektion 1 angesiedelt sein (z. B. `bootstrap-workspace.1`).
- Inhaltlich müssen sie mindestens enthalten: NAME, SYNOPSIS, DESCRIPTION, OPTIONS, EXAMPLES, AUTHOR und SEE ALSO.

### 2.2 PowerShell Hilfe für PowerShell-Skripte
- Jedes PowerShell-Skript (`.ps1`) im Verzeichnis `scripts/` muss über eine vollständige kommentarbasierte Hilfe verfügen.
- Die Hilfe muss die Felder `.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE` und `.NOTES` enthalten.
- Die Hilfe muss sowohl auf Deutsch als auch auf Englisch (bilingual) verfasst sein, sofern dies mit den Projektstandards vereinbar ist (oder zumindest die bestehende Bilingualität des Projekts widerspiegeln).

### 2.3 Anpassung der Hilfe-Switches (`-h`, `--help`)
- Die `usage()`-Funktion in Bash-Skripten muss nach der "Verwendung:"-Zeile einen Hinweis auf die man-Page enthalten:
  - Beispiel: `Für detaillierte Informationen siehe 'man <skriptname>'. / For detailed information see 'man <scriptname>'.`
- PowerShell-Skripte müssen so konfiguriert sein, dass `-h` und `--help` zuverlässig auf die integrierte Hilfe verweisen und ebenfalls einen Hinweis auf die erweiterte Hilfe geben.

### 2.4 Automatisierung & Wartung
- Bei der Erstellung neuer Skripte müssen man-Pages und PowerShell-Hilfe zwingend mit erstellt werden.
- Bei Änderungen an der Funktionalität oder den Parametern eines Skripts müssen die man-Pages und die PS-Hilfe synchron aktualisiert werden.

## 3. Nicht-funktionale Anforderungen / Non-functional Requirements
- **Konsistenz**: Die Dokumentation muss in Stil und Format über alle Skripte hinweg einheitlich sein.
- **Aktualität**: Dokumentation und Code dürfen nicht divergieren.
- **Bilingualität**: Alle Dokumentationen müssen dem `DE / EN` Standard des Projekts entsprechen.

## 4. Änderungen an der Infrastruktur / Infrastructure Changes

### 4.1 Verfassung (`constitution.md`)
- Aufnahme einer Regel unter "Script & Code Conventions", dass Dokumentation (man-Pages/PS-Hilfe) integraler Bestandteil eines Skripts ist.
- Definition der Pfade für die man-Pages.

### 4.2 KI-Agenten Richtlinien (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`)
- Ergänzung der Anweisungen für KI-Agenten, dass bei Skripterstellung oder -änderung die Dokumentation zwingend mitzuführen ist.

## 5. Abnahmekriterien / Acceptance Criteria
- Alle bestehenden Skripte verfügen über eine man-Page (`.sh`) bzw. vollständige PS-Hilfe (`.ps1`).
- Der Aufruf von `script.sh -h` verweist auf die man-Page.
- Der Aufruf von `Get-Help script.ps1` zeigt eine vollständige Dokumentation an.
- Die Verfassung und die Agenten-Dateien sind aktualisiert.
- Ein neues Test-Skript (oder eine Erweiterung bestehender Tests) validiert die Existenz der Dokumentation.

## 6. Planung / Schedule
- Phase 1: Erstellung der Vorlagen für man-Pages und PS-Hilfe.
- Phase 2: Implementierung für alle bestehenden Skripte.
- Phase 3: Aktualisierung der globalen Richtlinien (Constitution/Agents).
- Phase 4: Validierung und Abschluss.

---
**Status**: Entwurf / Draft | **ID**: 007-script-documentation | **Author**: Gemini CLI
