# Quickstart: Linux Maintenance Hardening

Alle Befehle laufen aus dem dauerhaften Level-0-Klon auf Linux:

```bash
bash -n scripts/maintain-agentic-brew-apps.sh
bash -n scripts/maintain-agentic-workspace.sh
python3 scripts/tests/test_linux_maintenance_hardening.py
bash scripts/maintain-agentic-brew-apps.sh --compare-only
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
```

Die drei letzten Befehle verändern weder Pakete noch Shell-Profile. Required-
Drift ist trotzdem ein wahrheitsgetreuer Nicht-Erfolg und kann Exitcode `1`
liefern.

Ein echter Linux-Wartungslauf ist erst nach grünen Vorschau- und Testgates
zulässig:

```bash
bash scripts/maintain-agentic-workspace.sh --allow-admin-prompts
```

`--allow-admin-prompts` erlaubt sichtbare Administratorabfragen nur für diesen
Lauf. Der Schalter umgeht weder `sudo`, Paketmanager-Sperren,
Integritätsprüfungen, Timeouts, Tests noch Repository-Reviews.
