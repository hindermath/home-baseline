# Feature Specification: Workspace- und Projekt-Teardown / Workspace and Project Teardown

**Feature Branch**: `005-workspace-teardown`
**Created**: 2026-04-10
**Status**: Draft
**Input**: Lastenheft_Workspace_Teardown.md

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Sicheres lokales Entfernen eines Workspace (Priority: P1)

Ein Entwickler hat einen Workspace (`~/MyProjects/`) fertiggestellt und möchte ihn vollständig von seiner Maschine entfernen — inklusive lokales Verzeichnis, README-Eintrag und .gitignore-Eintrag. Er will sichergehen, dass keine uncommitteten Änderungen verloren gehen, und erhält eine klare Bestätigung, was gelöscht wurde.

**Why this priority**: Kernfunktion des Features — ohne sicheres lokales Entfernen gibt es keinen Teardown. Schließt direkt die offene Lücke aus Feature 003-git-config-scope (orphaned includeIf-Einträge).

**Independent Test**: `teardown-workspace.sh --dry-run MyProjects` zeigt alle geplanten Aktionen; Live-Test: Workspace anlegen, Teardown ausführen, Verzeichnis nicht mehr vorhanden.

**Acceptance Scenarios**:

1. **Given** ein Workspace `~/MyProjects/` mit sauberem git-Status, **When** `teardown-workspace.sh MyProjects` ausgeführt wird und der Nutzer bestätigt, **Then** ist `~/MyProjects/` nicht mehr vorhanden, der Eintrag in `~/README.md` entfernt und in `~/` committet.
2. **Given** ein Workspace mit uncommitteten Änderungen, **When** `teardown-workspace.sh MyProjects` (ohne `--force`) ausgeführt wird, **Then** bricht das Skript mit einer bilingualen Fehlermeldung ab und löscht nichts.
3. **Given** ein Workspace mit ungepushten Commits, **When** `teardown-workspace.sh MyProjects` ausgeführt wird, **Then** bricht das Skript mit einer Warnung ab.
4. **Given** ein beliebiger Workspace, **When** `teardown-workspace.sh --dry-run MyProjects` ausgeführt wird, **Then** werden alle geplanten Aktionen angezeigt, aber keine Datei gelöscht oder verändert.

---

### User Story 2 — Backup vor Löschung + Remote-Repo entfernen (Priority: P2)

Ein Entwickler möchte vor dem Teardown eine Sicherungskopie des Workspace als Archiv erstellen und gleichzeitig das zugehörige GitHub- oder GitLab-Remote-Repo löschen.

**Why this priority**: Datenverlust-Schutz und vollständige Bereinigung (kein verwaistes Remote-Repo). Kann unabhängig von Story 3 und 4 implementiert und getestet werden.

**Independent Test**: `teardown-workspace.sh MyProjects --backup` → `.tar.gz`-Archiv in `~/` vorhanden nach Ausführung; `--keep-remote` → Remote-Repo bleibt erhalten.

**Acceptance Scenarios**:

1. **Given** ein Workspace mit konfiguriertem GitHub-Remote, **When** `teardown-workspace.sh MyProjects --backup` ausgeführt wird, **Then** existiert `~/MyProjects-backup-YYYY-MM-DD.tar.gz` vor der Löschung, und das Remote-Repo wird gelöscht.
2. **Given** ein Workspace mit Remote, **When** `teardown-workspace.sh MyProjects --keep-remote` ausgeführt wird, **Then** wird das lokale Verzeichnis entfernt, das Remote-Repo bleibt erhalten.
3. **Given** ein Workspace mit GitLab-Remote, **When** Teardown ausgeführt wird, **Then** wird das GitLab-Remote-Repo gelöscht (automatische Plattform-Erkennung via Remote-URL).
4. **Given** ein nicht erreichbares Remote, **When** Teardown ausgeführt wird, **Then** erscheint eine Warnung und der Teardown kann mit `--keep-remote` fortgesetzt werden.

---

### User Story 3 — Rekursiver Teardown mit Level-2-Projekten (Priority: P3)

Ein Entwickler möchte einen Workspace entfernen, der noch Level-2-Projekte (eigene git-Repos in Unterverzeichnissen) enthält. Ohne Flag wird abgebrochen; mit `--recursive` werden Level-2-Projekte einzeln abgearbeitet.

**Why this priority**: Seltener Use-Case; ohne `--recursive` wird sicher abgebrochen — kein Datenverlustrisiko.

**Independent Test**: Workspace mit zwei Level-2-Repos anlegen; ohne `--recursive` → Abbruch mit Warnung; mit `--recursive` → alle Repos und Workspace entfernt.

**Acceptance Scenarios**:

1. **Given** ein Workspace mit zwei Level-2-Projekten, **When** `teardown-workspace.sh MyProjects` (ohne `--recursive`) ausgeführt wird, **Then** bricht das Skript ab und listet die Level-2-Projekte auf.
2. **Given** ein Workspace mit Level-2-Projekten, **When** `teardown-workspace.sh MyProjects --recursive` ausgeführt wird und der Nutzer bestätigt, **Then** werden alle Level-2-Remote-Repos gelöscht, alle lokalen Verzeichnisse entfernt, danach der Workspace selbst.

---

### User Story 4 — `--teardown`-Alias in bootstrap-workspace (Priority: P4)

Ein Entwickler will sich nur ein Skript merken. `bootstrap-workspace.sh --teardown MyProjects` delegiert intern an `teardown-workspace.sh`.

**Why this priority**: Komfort-Feature ohne eigenständigen Wert — nur Convenience.

**Independent Test**: `bootstrap-workspace.sh --teardown --dry-run MyProjects` → identische Ausgabe wie `teardown-workspace.sh --dry-run MyProjects`.

**Acceptance Scenarios**:

1. **Given** ein Workspace, **When** `bootstrap-workspace.sh --teardown MyProjects` ausgeführt wird, **Then** ist das Verhalten identisch zu einem direkten `teardown-workspace.sh MyProjects`-Aufruf.

---

### Edge Cases

- Was passiert, wenn `home-baseline` als WorkspaceName angegeben wird? → Abbruch mit explizitem Schutzfehler.
- Was passiert, wenn `~/README.md` keinen Eintrag für den Workspace enthält? → Schritt wird still übersprungen (kein Fehler).
- Was passiert, wenn kein Remote konfiguriert ist? → Remote-Schritt wird übersprungen, Rest läuft durch.
- Was passiert, wenn das Backup-Archiv bereits existiert (gleicher Tag, zweiter Versuch)? → Timestamp-Suffix verhindert Überschreiben.
- Was passiert, wenn `tar` nicht verfügbar ist? → Fehlermeldung, Teardown ohne Backup fortsetzen (mit Warnung, Exit 1).
- Was passiert bei `--dry-run` auf einem nicht existierenden Workspace? → Fehlermeldung: Verzeichnis nicht gefunden, Exit 2.
- Was passiert, wenn `~/.gitconfig` einen `includeIf`-Eintrag für den Workspace enthält? → Block und zugehörige `.inc`-Datei werden entfernt.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Das System MUSS zwei neue Skripte bereitstellen: `teardown-workspace.sh` (Bash) und `teardown-workspace.ps1` (PowerShell 7), die funktional äquivalent sind.
- **FR-002**: Das System MUSS vor jeder destruktiven Aktion uncommittete Änderungen und ungepushte Commits prüfen und bei Fund abbrechen (außer `--force` / `-Force`).
- **FR-003**: Das System MUSS Level-2-Projekte erkennen und ohne `--recursive` abbrechen.
- **FR-004**: Das System MUSS das lokale Workspace-Verzeichnis nach erfolgreicher Sicherheitsprüfung und Nutzerbestätigung entfernen.
- **FR-005**: Das System MUSS das Remote-Repo (GitHub oder GitLab, automatisch erkannt via Remote-URL) standardmäßig löschen; `--keep-remote` / `-KeepRemote` verhindert dies.
- **FR-006**: Das System MUSS den Tabelleneintrag in `~/README.md` entfernen und in `~/` committen.
- **FR-007**: Das System MUSS den Eintrag in `~/.gitignore` (sofern vorhanden) entfernen.
- **FR-008**: Das System MUSS den `[includeIf]`-Block in `~/.gitconfig` und die zugehörige `~/.gitconfig.d/<normalized-name>.inc`-Datei entfernen (Cleanup aus Feature 003-git-config-scope; bei fehlender `~/.gitconfig.d/` ohne Fehler überspringen).
- **FR-009**: Das System MUSS mit `--backup` / `-Backup` vor der Löschung ein `.tar.gz`-Archiv in `~/` erstellen.
- **FR-010**: Das System MUSS mit `--recursive` / `-Recursive` Level-2-Projekte einzeln (Sicherheitsprüfung + Remote-Löschen + lokal Löschen) vor dem Workspace-Teardown abarbeiten.
- **FR-011**: Das System MUSS eine Präambel-Box mit allen geplanten Aktionen anzeigen und eine interaktive Bestätigung einholen; `--yes` / `-Yes` überspringt den Prompt.
- **FR-012**: Das System MUSS `--dry-run` (Bash) / `-WhatIf` (PowerShell) unterstützen: alle Aktionen anzeigen ohne Ausführung.
- **FR-013**: Das System MUSS nach Abschluss einen bilingualen Abschlussbericht mit allen durchgeführten und übersprungenen Aktionen ausgeben.
- **FR-014**: `bootstrap-workspace.sh/.ps1` MUSS einen `--teardown` / `-Teardown`-Parameter erhalten, der intern an `teardown-workspace` delegiert.
- **FR-015**: Das System MUSS `home-baseline` als WorkspaceName explizit ablehnen (Selbstschutz, Exit 2).
- **FR-016**: Alle Benutzerausgaben MÜSSEN bilingual sein (Deutsch zuerst, dann Englisch).

### Key Entities

- **Workspace**: Lokales Verzeichnis `~/WorkspaceName/` mit eigenem `.git/`; besitzt optionale Remote-URL und optionale Level-2-Projekte.
- **Level-2-Projekt**: Direktes Kind-Unterverzeichnis eines Workspace mit eigenem `.git/`; wird bei `--recursive` eigenständig abgebaut.
- **Artefakt-Set**: Die zum Workspace gehörenden externen Artefakte: `~/README.md`-Zeile, `~/.gitignore`-Eintrag, `~/.gitconfig` includeIf-Block, `~/.gitconfig.d/<name>.inc`.
- **Backup-Archiv**: `~/WorkspaceName-backup-YYYY-MM-DD.tar.gz`; erstellt vor jeder destruktiven Aktion, liegt außerhalb des zu löschenden Verzeichnisses.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: `teardown-workspace --dry-run` zeigt alle geplanten Aktionen in unter 2 Sekunden, ohne Schreibzugriff auf das Dateisystem.
- **SC-002**: Ein vollständiger Teardown (lokal + remote + alle Artefakte) ist in unter 30 Sekunden abgeschlossen (ohne Backup-Archivierung großer Repos).
- **SC-003**: Nach einem Teardown sind keine Rückstände des Workspace in `~/README.md`, `~/.gitignore`, `~/.gitconfig` oder `~/.gitconfig.d/` vorhanden (100 % Artefakt-Bereinigung).
- **SC-004**: Ein Teardown mit uncommitteten Änderungen bricht in 100 % der Fälle ohne `--force` ab.
- **SC-005**: Bash- und PowerShell-Variante produzieren bei gleichem Input identische Aktionen und Exit-Codes auf ihren jeweiligen Plattformen.
- **SC-006**: Bestehende Workspaces, Skripte und git-Operationen funktionieren nach einem Teardown eines anderen Workspace unverändert (keine Regressionen).

---

## Assumptions

- `gh` CLI ist bereits installiert (bestehende Abhängigkeit); `glab` ist optional — fehlt es, wird der GitLab-Remote-Schritt mit Warnung übersprungen.
- Das Home-Verzeichnis (`~/`) ist ein git-Repository (von `sync-home` verwaltet); `~/README.md` und `~/.gitignore` sind getrackt.
- `tar` ist auf allen Zielplattformen verfügbar (macOS/Linux: built-in; Windows: Git for Windows bringt `tar` mit).
- Die `~/.gitconfig.d/`-Bereinigung (FR-008) setzt Feature `003-git-config-scope` voraus — bei fehlender `~/.gitconfig.d/` wird ohne Fehler übersprungen.
- Level-2-Projekte sind nur direkte Kind-Verzeichnisse des Workspace (Tiefe 1) — tiefer verschachtelte `.git/`-Verzeichnisse werden nicht berücksichtigt.
- Plattform-Erkennung (GitHub vs. GitLab) erfolgt anhand der Remote-URL (`github.com` / `gitlab.com`).
- `teardown-project` (Löschen von Level-2-Projekten ohne Workspace-Teardown) ist Out of Scope — separates Feature bei Bedarf.
- `home-baseline` selbst kann nicht per Teardown entfernt werden (FR-015).
