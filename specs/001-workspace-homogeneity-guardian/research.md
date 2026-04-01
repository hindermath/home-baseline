# Research: Workspace Homogeneity Guardian

**Branch**: `001-workspace-homogeneity-guardian` | **Date**: 2026-04-01  
**Purpose**: Resolve all NEEDS CLARIFICATION items from Technical Context.

---

## R-01 — Bilingualitätserkennung in Markdown (FR-004)

**Entscheidung**: Heuristisches Heading-Keyword-Scanning mit ripgrep  
**Rationale**: Echte CEFR-B2-NLP-Analyse erfordert Python-Bibliotheken oder
externe APIs — beides verletzt die Offline-First- und No-Extra-Dependency-Constraint.
Heading-Schlüsselwörter sind der zuverlässigste Proxy ohne Abhängigkeiten, da
gut strukturierte Dokumentation immer benannte Abschnitte verwendet.

**Implementierung**:
```bash
# Deutsche Indikatoren (##-Ebene Heading):
DE_PATTERNS="Überblick|Verwendung|Einrichtung|Voraussetzungen|Azubi|Hinweise|Zweck|Beschreibung|Schnellstart"
# Englische Indikatoren:
EN_PATTERNS="Overview|Usage|Setup|Prerequisites|Apprentice|Notes|Purpose|Description|Quickstart"

has_de=$(rg -i "^#{1,3} .*(${DE_PATTERNS})" "$file" -c 2>/dev/null || echo 0)
has_en=$(rg -i "^#{1,3} .*(${EN_PATTERNS})" "$file" -c 2>/dev/null || echo 0)

[ "$has_de" -gt 0 ] && [ "$has_en" -gt 0 ] && echo "PASS" || echo "WARN: bilingual section missing"
```

**Limitation**: Prüft nur Heading-Ebenen 1–3; tief verschachtelte Abschnitte
werden nicht erkannt. Akzeptabel für die definierten Anforderungen (README,
agent files — nicht Source-Code).  
**Verworfene Alternativen**: langdetect (Python-Abhängigkeit), hunspell
(Wörterbuch-Dependency) — beide Out of Scope.

---

## R-02 — Accessibility-Prüfung in Markdown (FR-005)

**Entscheidung**: Drei separate ripgrep-Checks  
**Rationale**: `rg` ist auf allen Zielplattformen verfügbar (Pflichtabhängigkeit
per Spec). Drei gezielte Pattern decken die vier in FR-005 genannten A11Y-Kriterien ab.

**Implementierung**:

```bash
# 1. Heading-Hierarchie: Lücken erkennen (z.B. h1 → h3)
check_heading_hierarchy() {
  local file="$1" prev=0
  while IFS= read -r line; do
    level=$(echo "$line" | grep -o '^#*' | wc -c)
    level=$((level - 1))  # wc -c zählt newline mit
    if [ "$level" -gt $((prev + 1)) ] && [ "$prev" -gt 0 ]; then
      echo "WARN: heading gap h${prev}→h${level} in ${file}"
    fi
    prev=$level
  done < <(grep '^#' "$file")
}

# 2. Leere Alt-Texte: ![](...) ohne Alt-Text
empty_alt=$(rg '!\[\]\(' "$file" -c 2>/dev/null || echo 0)
[ "$empty_alt" -gt 0 ] && echo "WARN: empty alt text in ${file}"

# 3. Nichtssagende Link-Texte
bad_links=$(rg -i '\[(hier|here|click here|link|mehr|more|this)\]\(' "$file" -c 2>/dev/null || echo 0)
[ "$bad_links" -gt 0 ] && echo "WARN: non-descriptive link text in ${file}"

# 4. Farbbasierte Information (inline HTML)
color_only=$(rg 'style="[^"]*color:' "$file" -c 2>/dev/null || echo 0)
[ "$color_only" -gt 0 ] && echo "WARN: colour-only styling detected in ${file}"
```

**Verworfene Alternativen**: axe-core (Browser-Abhängigkeit), markdownlint
(npm-Dependency) — zu schwer für reine Shell-Tools.

---

## R-03 — SHA-256-Vergleich cross-platform (FR-002)

**Entscheidung**: Runtime-Erkennung verfügbarer Hash-Utilities  
**Rationale**: `sha256sum` ist auf Linux/WSL Standard; macOS liefert `shasum`.
Beide produzieren identische Hashes; die Auswahl erfolgt einmalig beim Start.

**Implementierung**:

```bash
sha256_file() {
  local file="$1"
  if command -v sha256sum &>/dev/null; then
    sha256sum "$file" | awk '{print $1}'
  elif command -v shasum &>/dev/null; then
    shasum -a 256 "$file" | awk '{print $1}'
  else
    echo "ERROR: no sha256 utility found" >&2; exit 1
  fi
}
```

**PowerShell** (Windows/WSL-PS):
```powershell
(Get-FileHash -Algorithm SHA256 -Path $FilePath).Hash.ToLower()
```

---

## R-04 — File-Locking für STATS.md (FR-007)

**Entscheidung**: Atomares `mkdir`-basiertes Lock (POSIX-portabel)  
**Rationale**: `flock` ist auf macOS ohne Homebrew nicht garantiert verfügbar.
`mkdir` ist POSIX-atomar: entweder es gelingt (Lock erworben) oder es schlägt
fehl (Lock belegt) — keine Race Condition möglich.

**Implementierung**:

```bash
acquire_lock() {
  local lockdir="$1"
  local timeout="${2:-5}"
  local elapsed=0
  while ! mkdir "$lockdir" 2>/dev/null; do
    sleep 1; elapsed=$((elapsed + 1))
    if [ "$elapsed" -ge "$timeout" ]; then
      echo "WARN: stats file locked — try again" >&2
      return 1
    fi
  done
  return 0
}

release_lock() { rmdir "$1" 2>/dev/null || true; }

# Verwendung:
lockdir="${stats_file}.lock"
acquire_lock "$lockdir" 5 || exit 1
trap 'release_lock "$lockdir"' EXIT
# ... STATS.md schreiben ...
release_lock "$lockdir"
```

**PowerShell**:
```powershell
$lockDir = "${statsFile}.lock"
$elapsed = 0
while (-not (New-Item -ItemType Directory -Path $lockDir -ErrorAction SilentlyContinue)) {
  Start-Sleep -Seconds 1; $elapsed++
  if ($elapsed -ge 5) { Write-Warning "stats file locked — try again"; exit 1 }
}
try { # ... STATS.md schreiben ... }
finally { Remove-Item -Path $lockDir -Force -ErrorAction SilentlyContinue }
```

---

## R-05 — Spec-kit Template-Versionserkennung (FR-018)

**Entscheidung**: `speckit_version` aus `~/.specify/init-options.json` +
Template-Version-Marker in spec.md  
**Rationale**: Aktuelle spec.md-Dateien enthalten keinen expliziten Template-
Versions-Header. Zwei Teilmaßnahmen:

1. **Kurzfristig** (für bestehende Specs): Extrahiere `speckit_version` aus
   `~/.specify/init-options.json` (z.B. `0.4.3`). Vergleiche gegen den
   `**Created**:`-Datumstempel der spec.md. Wenn das Erstellungsdatum > 90 Tage
   alt ist, gib `WARN: spec may be outdated — verify template version`.

2. **Langfristig** (für neue Specs via bootstrap-project.sh): Injiziere einen
   `**Spec-kit Template Version**: 0.4.3`-Header in generierte spec-Stubs.
   Der Check liest diesen Wert und vergleicht ihn mit `init-options.json`.

**Implementierung** (Kurzfrist-Heuristik):
```bash
speckit_ver=$(jq -r '.speckit_version' ~/.specify/init-options.json 2>/dev/null || echo "unknown")
created_date=$(grep '^\*\*Created\*\*:' "$spec_file" | grep -o '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}')
# Wenn kein Version-Header vorhanden UND Spec älter als 90 Tage: WARN
```

---

## R-06 — Bezahlte NuGet-Pakete erkennen (FR-016)

**Entscheidung**: Statische Vendor-Blockliste per ripgrep in `*.csproj`-Dateien  
**Rationale**: Kein freies, öffentliches API zur Bestimmung NuGet-Lizenztypen
verfügbar. Eine Blockliste der bekannten kostenpflichtigen Komponentenverkäufer
deckt die praktisch relevanten Fälle ab (DevExpress, Telerik, Syncfusion usw.).

**Blockliste**:
```bash
PAID_VENDORS="DevExpress\.|Telerik\.|Syncfusion\.|Infragistics\.|MESCIUS\.|ComponentOne\.|GrapeCity\.|Actipro\."
```

**Implementierung**:
```bash
find_paid_deps() {
  local dir="$1"
  rg --glob '*.csproj' \
    "<PackageReference Include=\"(${PAID_VENDORS})" \
    "$dir" 2>/dev/null
}
```

**Limitation**: Kann keine unbekannten bezahlten Pakete erkennen; Entwickler
sind für die abschließende Überprüfung verantwortlich (WARN, kein ERROR).

---

## R-07 — JSON-Output ohne jq (FR-019)

**Entscheidung**: `printf`-basierte manuelle JSON-Konstruktion in Bash  
**Rationale**: `jq` ist auf Zielplattformen nicht garantiert vorinstalliert.
Manuelle Konstruktion vermeidet diese Abhängigkeit. Begrenzt sich auf ASCII-
kompatible Pfadzeichen (Standard auf allen Zielplattformen).

**Implementierung**:
```bash
# JSON-String escapen (nur " und \)
json_escape() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'; }

# Array von Objekten aufbauen
build_json_array() {
  local items=("$@")
  local json="["
  local first=true
  for item in "${items[@]}"; do
    $first || json+=","
    json+="{\"path\":\"$(json_escape "${item%%:*}")\",\"check\":\"$(json_escape "${item##*:}")\"}"
    first=false
  done
  json+="]"
  echo "$json"
}

# Ausgabe
printf '{"score":%d,"failures":%s,"warnings":%s}\n' \
  "$score" "$(build_json_array "${failures[@]}")" "$(build_json_array "${warnings[@]}")"
```

**PowerShell**: Native `[PSCustomObject]` → `ConvertTo-Json -Compress`

---

## R-08 — KI-Agenten-Initialisierung (FR-009)

**Entscheidung**: Verfügbarkeitsprüfung + graceful skip; interaktive Agents
erhalten manuelle Anweisung statt Auto-Init  
**Rationale**: Claude (`/init`) und Spec-kit (`npx speckit init`) können
nicht-interaktiv aufgerufen werden. Codex und Gemini sind rein interaktive
REPL-Tools ohne nicht-interaktiven Init-Befehl.

| Agent | Verfügbarkeitsprüfung | Init-Methode |
|---|---|---|
| Claude | `claude --version` | `echo "/init" \| claude` (stdin-Pipe) |
| Codex | `codex --version` | SKIP: interaktiv — WARN mit manueller Anweisung |
| Gemini | `gemini --version` | SKIP: interaktiv — WARN mit manueller Anweisung |
| Copilot | `gh extension list \| grep -q copilot` | `gh copilot --help` (Check only) |
| Spec-kit | `npx speckit --version` | `npx speckit init` (non-interaktiv) |

**Graceful-Skip-Muster**:
```bash
init_agent() {
  local agent_cmd="$1" agent_name="$2"
  if ! command -v "$agent_cmd" &>/dev/null; then
    echo "WARN: ${agent_name} not installed — skipping init"
    return 0
  fi
  # ... agent-spezifischer Init ...
}
```
