---
description: Ein Secure-Development-Gate kontrolliert prüfen
---

# Secure Development Review

Syntax: $speckit-secure-development-review <baseline|delta|closure|image-impact> <context-id> <training|mixed|development>

Validiere genau das benannte Gate im Evidence-Verzeichnis
docs/security/secure-development/<datum>-<context-id>/. Führe auf Windows das
PowerShell-Skript und auf macOS/Linux das Bash-Skript dieses Presets mit
review aus. training und mixed benötigen ein Runbook; development benötigt
entweder ein Runbook oder eine dokumentierte Nichtanwendbarkeitsbegründung.

Ändere nur ausdrücklich autorisierte Review-Evidence innerhalb des gewählten
Kontexts. Verändere niemals Richtlinie, Checklisten, Baseline-Quellen,
Produktcode, Images, Git- oder Remote-Zustände. Technische Validierung darf
keine Pilotfreigabe, Projektabnahme oder allgemeine Sandbox-/Flottenfreigabe
ersetzen.

## English

Review exactly one named gate and context. Preserve the four independent
decision boundaries and fail closed on missing evidence, invalid status
combinations, drift, or absent authority.
