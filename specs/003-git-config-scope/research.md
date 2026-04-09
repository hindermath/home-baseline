# Research: Git Configuration Scope Isolation

**Feature**: `003-git-config-scope` | **Date**: 2026-04-09

## Decision Log

---

### R-001: `includeIf "gitdir:..."` mit Trailing Slash — Reichweite

**Decision**: `[includeIf "gitdir:~/WorkspaceName/"]` (mit Trailing Slash) aktiviert das Include für:
1. Das Workspace-Repository selbst (`~/WorkspaceName/.git`)
2. Alle direkten Kind-Repositories darin (`~/WorkspaceName/project-a/.git`, etc.)

**Rationale**: Git-Dokumentation (git-config(1)): „If a trailing `/` is appended to the path, any git repository within the given directory will match, regardless of depth." Level 2 Repos werden also automatisch abgedeckt. Subdirectory-Strukturen innerhalb eines Repos (src/, tests/, etc.) sind von `includeIf` vollständig unberührt — das Mechanismus greift nur auf `.git`-Verzeichnisebene.

**Alternatives considered**:
- `gitdir/i:` (case-insensitive) — nicht nötig; macOS/Linux sind case-sensitive für Pfade
- Ohne Trailing Slash — würde nur exakt den Workspace-Root matchen, nicht Kind-Repos

---

### R-002: Idempotentes Hinzufügen von `includeIf`-Blöcken

**Decision**: Vor dem Anhängen prüfen, ob bereits ein `includeIf`-Block für den Workspace-Pfad in `~/.gitconfig` existiert. Erkennungsmuster: `grep -F "gitdir:~/WorkspaceName/"`.

**Rationale**: `~/.gitconfig` ist ein Plaintext INI-Format. Doppelte `[includeIf]`-Sektionen werden von git angehängt ausgewertet — kein Fehler, aber semantisch redundant und schwer zu bereinigen. Idempotenz ist Standard für Infrastruktur-Scripts.

**Implementation pattern (Bash)**:
```bash
if ! grep -qF "gitdir:${HOME}/${workspace_name}/" "${HOME}/.gitconfig" 2>/dev/null; then
  printf '\n[includeIf "gitdir:%s/%s/"]\n  path = %s\n' \
    "${HOME}" "${workspace_name}" "${HOME}/.gitconfig.d/${normalized_name}.inc" \
    >> "${HOME}/.gitconfig"
fi
```

**Alternatives considered**: `git config --file ~/.gitconfig` CLI — kann keine `includeIf`-Sektionen lesen/prüfen; direkte Dateimanipulation ist der einzige reliable Weg.

---

### R-003: Workspace-Name-Normalisierung für `.inc`-Dateinamen

**Decision**: Transformation: lowercase → Sonderzeichen/Leerzeichen → Bindestriche → führende/trailing Bindestriche entfernen.

**Rationale**: Dateinamen müssen auf macOS (case-preserving, case-insensitive HFS+), Linux (case-sensitive) und Windows (case-insensitive NTFS) valide und konsistent sein. Kebab-case ist die Projektkonvention (Scripts, Branch-Namen).

**Bash implementation**:
```bash
normalize_name() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/-\+/-/g' | sed 's/^-\|-$//g'
}
```

**PowerShell implementation**:
```powershell
function ConvertTo-NormalizedName([string]$Name) {
  $Name.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-|-$', ''
}
```

---

### R-004: Forward-Slash-Normalisierung in `includeIf`-Pfaden (Windows)

**Decision**: Auf Windows (`$env:USERPROFILE`) müssen alle Pfade in `includeIf`-Werten mit Forward-Slashes geschrieben werden. Git on Windows (Git for Windows / MSYS2) erwartet POSIX-Pfade in git-config.

**Rationale**: `includeIf "gitdir:C:/Users/foo/MyProjects/"` funktioniert. `includeIf "gitdir:C:\Users\foo\MyProjects\"` schlägt fehl. PowerShell: `$path -replace '\\', '/'`.

**Alternatives considered**: `$HOME`-Variable auf Windows — `$env:HOME` kann leer sein; Fallback auf `$env:USERPROFILE` ist notwendig (dokumentiert in CLAUDE.md).

---

### R-005: Pre-Push Hook — Erweiterung auf `~/.gitconfig.d/`

**Decision**: Den bestehenden `scripts/hooks/pre-push` um einen zusätzlichen Scan-Block erweitern, der `~/.gitconfig.d/` mit dem bereits definierten `secret_content_regex` prüft. Der Scan ist NICHT Teil von `git ls-files` (untracked directory) — eigener `find`/`grep`-Block erforderlich.

**Rationale**: `~/.gitconfig.d/` ist bewusst untracked (Security-Whitelist-Modell). Der bestehende Hook prüft nur git-verwaltete Dateien. Ein separater Block für das untracked `.inc`-Verzeichnis ist die sauberste Erweiterung ohne Architekturänderung.

**Implementation pattern**:
```bash
gitconfig_d="${HOME}/.gitconfig.d"
if [ -d "$gitconfig_d" ]; then
  inc_hits=()
  while IFS= read -r f; do
    inc_hits+=("$f")
  done < <(grep -rEl --include='*.inc' "$secret_content_regex" "$gitconfig_d" 2>/dev/null || true)
  if [ "${#inc_hits[@]}" -gt 0 ]; then
    found_high=1
    echo "  HIGH: Secret-Muster in ~/.gitconfig.d/ gefunden:" >&2
    printf '       %s\n' "${inc_hits[@]}" >&2
  fi
fi
```

**Security note (Principle I)**: Dieser Block ist sicherheitskritisch. Änderungen MÜSSEN in der PR explizit Principle I referenzieren und Scanner-Output bestätigen.

---

### R-006: `sync-home` — Behandlung von `~/.gitconfig.d/`

**Decision**: `sync-home` erstellt `~/.gitconfig.d/` mit einem `home-baseline.inc` Placeholder, wenn das Verzeichnis nicht existiert. Bei bestehendem Verzeichnis: keine Aktion (preserve-only).

**Rationale**: `~/.gitconfig.d/` enthält User-Customizations die nicht aus dem Repo kommen. Überschreiben wäre ein Datenverlust-Szenario. Der Placeholder-Ansatz stellt sicher, dass neue Installationen einen Einstiegspunkt haben.

**Placeholder content for `home-baseline.inc`**:
```ini
# home-baseline workspace git configuration
# Hier workspace-spezifische git-Einstellungen eintragen:
# [user]
#   email = work@example.com
```

---

### R-007: `check-homogeneity` — Scope-Isolation-Check

**Decision**: Den bestehenden Check-Mechanismus (lib/hg-*.sh) um einen neuen Check `hg-git-scope.sh` erweitern. Status: WARN (non-fatal) wenn `~/.gitconfig.d/` fehlt oder kein `includeIf` für den Target-Workspace vorhanden. Compliance-Score wird NICHT reduziert.

**Rationale**: Backwards-kompatibel — Nutzer mit vorhandener Installation werden nicht plötzlich auf roten Status gesetzt. WARN ist die richtige Severity für „optionale aber empfohlene" Konfiguration.

---

### R-008: Scope von FR-008 (`teardown-workspace`)

**Decision**: FR-008 (teardown-workspace) ist in dieser Feature-Branch NICHT implementierbar — `teardown-workspace.sh/.ps1` existieren noch nicht und gehören zu `Lastenheft_Workspace_Teardown.md` (separates Feature).

**Rationale**: Die Spec-Assumption ist korrekt: FR-008 ist als Abhängigkeit dokumentiert. Implementation erfolgt in Feature-Branch `teardown-workspace` nach diesem Feature. FR-008 wird in `plan.md` als Out-of-Scope markiert.

---

### R-009: `bootstrap-project.sh` — Aktueller Stand

**Decision**: `bootstrap-project.sh` setzt bereits `git config --local` für projektspezifische Settings. Keine neue Logik nötig für Scope-Isolation; `~/.gitconfig` und `~/.gitconfig.d/` werden nicht berührt. FR-006-Compliance ist bereits gegeben — nur Bilingual-Output (NFR-001) fehlt noch.

**Rationale**: Code-Review des vorhandenen Scripts zeigt, dass die lokale git-config-Nutzung bereits der FR-006-Spezifikation entspricht.
