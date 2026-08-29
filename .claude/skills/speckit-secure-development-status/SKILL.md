---
name: speckit-secure-development-status
description: Inspect one secure-development evidence context without changing files
compatibility: Requires a Spec Kit project and the secure-development assurance preset
metadata:
  author: github-spec-kit
  source: secure-development-assurance-governance:commands/speckit.secure-development-status.md
---

# Secure Development Status

Syntax: $speckit-secure-development-status [<evidence-dir>]

Prüfe das ausdrücklich angegebene Evidence-Verzeichnis. Fehlt der Parameter,
verwende das lexikografisch neueste Verzeichnis unter
docs/security/secure-development/. Führe auf Windows das PowerShell-Skript und
auf macOS/Linux das Bash-Skript dieses Presets mit status aus.

Der Befehl ist strikt read-only. Er darf keine Evidence, Richtlinie,
Checkliste, Freigabe, Git- oder Remote-Zustände verändern. Berichte den
Kontext, die vier Gates, das Gesamtergebnis, die vier getrennten
Entscheidungsstände und die exakte nächste Aktion textorientiert.

## English

Inspect the selected evidence directory without changing it. Report all four
gates and all four human decision boundaries separately. Never infer an
approval from successful technical validation.
