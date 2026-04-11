# Research: Workspace- und Projekt-Teardown

**Feature**: `005-workspace-teardown` | **Date**: 2026-04-10

## Decision Log

---

### R-001: `[includeIf]`-Block aus `~/.gitconfig` entfernen

**Decision**: `awk`-basierte Mehrzeilen-Löschung in Bash; Array-Filter in PowerShell.

**Rationale**: `~/.gitconfig` ist eine INI-Datei. Jeder `[includeIf]`-Block besteht aus der Sektion-Kopfzeile plus einer oder mehreren eingerückten `key = value`-Zeilen. `git config --unset` unterstützt keine `includeIf`-Sektionen. Direkte Dateimanipulation ist der einzig zuverlässige Weg (identische Entscheidung wie in R-002 von Feature 003-git-config-scope).

**Bash implementation**:
```bash
# Pattern: header line is exact match; following indented lines belong to the block
awk -v header="[includeIf \"gitdir:${HOME}/${WORKSPACE_NAME}/\"]" '
  $0 == header { skip=1; next }
  skip && /^[[:space:]]/ { next }
  { skip=0; print }
' "${HOME}/.gitconfig" > "${HOME}/.gitconfig.tmp" \
  && mv "${HOME}/.gitconfig.tmp" "${HOME}/.gitconfig"
```

**PowerShell implementation**:
```powershell
$header = "[includeIf `"gitdir:$homeDir/$WorkspaceName/`"]"
$lines  = Get-Content "$homeDir/.gitconfig"
$out    = [System.Collections.Generic.List[string]]::new()
$skip   = $false
foreach ($line in $lines) {
    if ($line -eq $header)           { $skip = $true; continue }
    if ($skip -and $line -match '^\s') { continue }
    $skip = $false
    $out.Add($line)
}
Set-Content "$homeDir/.gitconfig" $out
```

**Note**: The gitconfig entry written by bootstrap-workspace uses the expanded `$HOME` path (e.g., `/Users/username/WorkspaceName/`), not `~`. The detection pattern must use the same expanded form.

**Alternatives considered**:
- Python `configparser` — requires Python assumption; adds dependency
- `sed` multi-line — address ranges with `/pattern1/,/pattern2/d` are error-prone when blocks have variable line counts

---

### R-002: GitHub-Remote-Repo löschen

**Decision**: Remote-URL parsen → `gh repo delete <owner/repo> --yes`.

**Rationale**: `gh` CLI ist bereits Pflicht-Abhängigkeit (Assumption in spec). Plattform-Erkennung via `github.com` in der Remote-URL.

**Implementation pattern (Bash)**:
```bash
remote_url=$(git -C "$WORKSPACE_DIR" remote get-url origin 2>/dev/null || true)
# Handles both HTTPS and SSH remote formats
owner_repo=$(echo "$remote_url" \
  | sed 's|.*github\.com[:/]\(.*\)\.git$|\1|; s|.*github\.com[:/]\(.*\)$|\1|')
gh repo delete "$owner_repo" --yes
```

**PowerShell**:
```powershell
$remoteUrl = git -C $workspaceDir remote get-url origin 2>$null
$ownerRepo = $remoteUrl -replace '.*github\.com[:/](.*)\.git$', '$1' `
                        -replace '.*github\.com[:/](.*)',       '$1'
gh repo delete $ownerRepo --yes
```

**Failure handling**: Ist kein Remote konfiguriert, wird Schritt 3 still übersprungen. Schlägt ein tatsächlicher GitHub-Delete-Versuch fehl und `--keep-remote` war nicht gesetzt, bricht das Teardown vor lokaler Löschung und Artefakt-Cleanup mit Exit 1 ab.

**Alternatives considered**: GitHub REST API via `curl` — more portable but requires token management already handled by `gh`.

---

### R-003: GitLab-Remote-Repo löschen (optional)

**Decision**: `glab repo delete <owner/repo> --yes`; wenn `glab` fehlt, Remote-Schritt mit Warnung überspringen und lokalen Teardown fortsetzen.

**Rationale**: `glab` ist laut Assumption optional. Das Teardown soll nicht scheitern, nur weil `glab` nicht installiert ist — der Nutzer kann das Remote manuell löschen. Das ist ein bewusst degradierter Pfad und kein Remote-Löschfehler nach einem gestarteten Delete-Versuch.

**Implementation pattern (Bash)**:
```bash
if command -v glab >/dev/null 2>&1; then
  owner_repo=$(echo "$remote_url" \
    | sed 's|.*gitlab\.com[:/]\(.*\)\.git$|\1|; s|.*gitlab\.com[:/]\(.*\)$|\1|')
  glab repo delete "$owner_repo" --yes
else
  echo "Warnung: glab nicht installiert — GitLab-Remote bleibt erhalten." >&2
  echo "Warning: glab not installed — GitLab remote was not deleted." >&2
fi
```

---

### R-004: Zeile aus `~/README.md` entfernen

**Decision**: `grep -v` / `-ne` zum Herausfiltern der Workspace-Zeile aus der Markdown-Tabelle.

**Rationale**: Die Tabelle hat festes Format `| WorkspaceName | ... |`. Die Zeile ist eindeutig durch den Workspace-Namen identifizierbar. Kein Risiko von Kollisionen, da `home-baseline` als WorkspaceName verboten ist (FR-015) und Workspace-Namen eindeutig sind.

**Bash implementation**:
```bash
# Remove the table row starting with "| WorkspaceName |"
grep -v "^| *${WORKSPACE_NAME} *|" "${HOME}/README.md" > "${HOME}/README.md.tmp" \
  && mv "${HOME}/README.md.tmp" "${HOME}/README.md"
```

**PowerShell**:
```powershell
$content = Get-Content "$homeDir/README.md"
$filtered = $content | Where-Object { $_ -notmatch "^\| *$WorkspaceName *\|" }
Set-Content "$homeDir/README.md" $filtered
```

**Edge case**: Wenn kein Eintrag vorhanden ist, erzeugt `grep -v` keine Änderung — kein Fehler (spec Edge Cases: "still übersprungen").

---

### R-005: Sicherheitsprüfungen (uncommittete Änderungen + ungepushte Commits)

**Decision**: `git status --porcelain` für uncommittete Änderungen; `git log @{u}..HEAD` für ungepushte Commits (mit Upstream-Existenz-Check).

**Rationale**: `git status --porcelain` produziert leere Ausgabe bei sauberem Status — zuverlässig und skript-freundlich. `@{u}` (upstream shorthand) schlägt fehl wenn kein Upstream konfiguriert — muss vorab geprüft werden.

**Bash implementation**:
```bash
check_safety() {
  local dir="$1"
  # Uncommitted changes
  if [ -n "$(git -C "$dir" status --porcelain 2>/dev/null)" ]; then
    echo "Fehler: uncommittete Änderungen in $dir / Error: uncommitted changes in $dir" >&2
    return 1
  fi
  # Unpushed commits (only if upstream configured)
  if git -C "$dir" rev-parse @{u} >/dev/null 2>&1; then
    if [ -n "$(git -C "$dir" log @{u}..HEAD --oneline 2>/dev/null)" ]; then
      echo "Fehler: ungepushte Commits in $dir / Error: unpushed commits in $dir" >&2
      return 1
    fi
  fi
}
```

**With --force**: Skip `check_safety` entirely for the workspace and all Level-2 projects (FR-002 + FR-010 clarifications).

---

### R-006: `.gitignore`-Eintrag entfernen

**Decision**: `grep -v` zum Entfernen der Zeile (identisches Pattern wie R-004).

**Rationale**: bootstrap-workspace.sh fügt `WorkspaceName/` in `~/.gitignore` ein (whitelist-Modell). Die Zeile hat exaktes Format.

**Bash implementation**:
```bash
if grep -qF "${WORKSPACE_NAME}/" "${HOME}/.gitignore" 2>/dev/null; then
  grep -v "^${WORKSPACE_NAME}/$" "${HOME}/.gitignore" > "${HOME}/.gitignore.tmp" \
    && mv "${HOME}/.gitignore.tmp" "${HOME}/.gitignore"
fi
```

**Edge case**: Eintrag fehlt → `grep -qF` gibt false zurück → Schritt wird übersprungen, kein Fehler.

---

### R-007: Backup-Archiv-Benennung (Kollisionsvermeidung)

**Decision**: Primärname `WorkspaceName-backup-YYYY-MM-DD.tar.gz`; bei Kollision numerisches Suffix `-1`, `-2`, usw.

**Rationale**: Die Spec wurde auf numerischen Suffix präzisiert. Ein einfacher Zähler ist deterministisch, plattformneutral und leicht testbar.

**Bash implementation**:
```bash
archive_base="${HOME}/${WORKSPACE_NAME}-backup-$(date +%Y-%m-%d)"
archive="${archive_base}.tar.gz"
i=1
while [ -f "$archive" ]; do
  archive="${archive_base}-${i}.tar.gz"
  i=$((i + 1))
done
tar czf "$archive" -C "${HOME}" "${WORKSPACE_NAME}/"
```

**PowerShell implementation**:
```powershell
$archiveBase = Join-Path $homeDir "$WorkspaceName-backup-$(Get-Date -Format 'yyyy-MM-dd')"
$archivePath = "$archiveBase.tar.gz"
$i = 1
while (Test-Path $archivePath) {
    $archivePath = "$archiveBase-$i.tar.gz"
    $i++
}
tar czf $archivePath -C $homeDir "$WorkspaceName/"
```

**tar failure handling**: Wenn `tar` nicht verfügbar ist (edge case): Fehlermeldung ausgeben, Teardown ohne Backup fortsetzen, am Ende Exit 1 (nicht Exit 0). Das Teardown wird NICHT vollständig abgebrochen.

---

### R-008: Level-2-Projekte erkennen

**Decision**: `find`-basierte Tiefe-1-Suche nach `.git/`-Verzeichnissen innerhalb des Workspace.

**Rationale**: Die Spec-Assumption beschränkt Level-2-Projekte auf direkte Kind-Verzeichnisse (Tiefe 1). `find -maxdepth 2 -mindepth 2 -name .git -type d` findet exakt diese.

**Bash implementation**:
```bash
level2_projects=()
while IFS= read -r gitdir; do
  level2_projects+=("$(dirname "$gitdir")")
done < <(find "${WORKSPACE_DIR}" -maxdepth 2 -mindepth 2 -name ".git" -type d 2>/dev/null)
```

**PowerShell**:
```powershell
$level2Projects = Get-ChildItem -Path $workspaceDir -Depth 1 -Directory |
  Where-Object { Test-Path (Join-Path $_.FullName '.git') -PathType Container }
```

---

### R-009: Atomarer Artefakt-Commit

**Decision**: `git add` für alle geänderten getrackt Dateien, dann ein Commit mit standardisierter Message inklusive `Co-authored-by`-Trailer. Ist `~/` kein Git-Repository, wird der Commit-Schritt mit Warnung übersprungen und das Teardown endet mit Exit 1.

**Rationale**: Nur `~/README.md` und `~/.gitignore` sind in `~/` getrackt (whitelist-Modell). `~/.gitconfig` ist NICHT getrackt — keine Commit-Operation nötig. Die `.inc`-Datei liegt in `~/.gitconfig.d/` (untracked). Der Commit enthält ausschließlich die beiden getrackt Dateien.

**Bash implementation**:
```bash
cd "${HOME}"
git add README.md .gitignore
git commit -m "chore: teardown ${WORKSPACE_NAME} — Artefakte bereinigt / artifacts cleaned up

Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
```

**Note**: `~/.gitconfig` und `~/.gitconfig.d/*.inc` sind Dateisystem-Operationen ohne Git-Tracking — sie werden nur als Dateien gelöscht/bearbeitet, nicht committed.
