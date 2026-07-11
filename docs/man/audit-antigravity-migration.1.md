# audit-antigravity-migration(1)

## NAME

`audit-antigravity-migration` - Antigravity-Migrationsstand in Level-0/1/2-Repositories pruefen. *Audit Antigravity migration state in Level-0/1/2 repositories.*

## SYNOPSIS

```text
bash scripts/audit-antigravity-migration.sh [--home-dir PATH] [--json] [--fail-on-open]
pwsh -NoProfile -File scripts/audit-antigravity-migration.ps1 [-HomeDir PATH] [-Json] [-FailOnOpen]
```

## DESCRIPTION

Der Audit erkennt Spec-Kit-Repositories dynamisch und prueft das `agy`-Manifest, gemeinsame `.agents/skills/`, entfernte Gemini-Manifeste und -Kommandos, die sichere `.agents`-Allowlist sowie versehentlich getrackte MCP-Konfiguration. Aktive direkte Gemini-CLI-Aufrufe werden gemeldet; abgeschlossene Specs, Changelogs, Bugreports und die Migrationshistorie bleiben bewusst ausgenommen.

*The audit discovers Spec Kit repositories dynamically and checks the `agy` manifest, shared `.agents/skills/`, removal of Gemini manifests and commands, the secure `.agents` allowlist, and accidentally tracked MCP configuration. Active direct Gemini CLI invocations are reported; completed specs, changelogs, bug reports, and migration history are intentionally excluded.*

## EXIT STATUS

- `0`: Audit ausgefuehrt, oder keine offenen Befunde mit Fail-on-open.
- `1`: Aufruf- oder Laufzeitfehler.
- `2`: Offene Befunde bei `--fail-on-open` beziehungsweise `-FailOnOpen`.
