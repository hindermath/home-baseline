# Betrieb und Wartung

[English version](README.en.md)

## Sicherer Standardablauf

1. Betriebssystem erkennen und passende Skriptvariante wählen.
2. Hilfe und sicheren Prüfmodus lesen.
3. Flottenweiten Remote-Freshness-Preflight abschließen.
4. Sperrgründe und nächste Aktionen prüfen.
5. Mutationen nur mit ausdrücklicher Autorität ausführen.
6. Ergebnis, Exitcode und Evidence gemeinsam bewerten.

Auf macOS/Linux:

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/maintain-agentic-workspace.sh --dry-run
```

Auf Windows:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -CheckOnly
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
```

`--check-only` und `-CheckOnly` prüfen den Zustand und dürfen sichere Fetches
ausführen. `--dry-run` und `-WhatIf` zeigen geplante Mutationen. Ein interaktiver
Start wählt die Vorschau standardmäßig; umgeleitete Aufrufe bleiben headless.

## Remote-Freshness-Barriere

Alle registrierten Repositories werden zuerst inventarisiert und soweit sicher
möglich gefetcht. Ein einzelner Befund beendet die read-only Bestandsaufnahme
nicht. Pull ist nur bei sauberem Default-Branch, eindeutigem Upstream,
`ahead=0` und reinem Behind-Zustand erlaubt. Dirty, Ahead, Diverged, Detached,
Non-Default, fehlender Upstream oder Remote-Fehler blockieren Mutationen.

## TUI, Plain und Headless

- Enhanced TUI: interaktive Oberfläche mit Textstatus.
- Plain UI: lineare, textorientierte Auswahl.
- Headless: explizite Optionen für Automation und CI.

Alle Modi verwenden dieselbe Wartungsengine und dieselben Sicherheitsgrenzen.
Ein Fallback darf Fähigkeiten reduzieren, aber keine Bestätigung oder Sperre
umgehen. `Ctrl+C` erzeugt genau einen nachvollziehbaren Abbruchpfad.

## Evidence und Exitcodes

Der Live-JSONL-Stream zeigt Ereignisse. Der kanonische Abschlussreport und der
Exitcode entscheiden gemeinsam über Erfolg, Drift, reparierte Drift oder
Betriebsfehler. `EVENT_STREAM_DEGRADED` bedeutet, dass Live-Evidence lückenhaft
ist; der Abschluss darf dann nicht aus dem Stream allein abgeleitet werden.

## Vertiefung

- [Ausführlicher Effizienzleitfaden](agentic-workspace-efficiency-guide.md#regelmäßiger-betrieb-regular-operation)
- [Manpage des Ein-Kommando-Laufs](../man/maintain-agentic-workspace.1.md)
- [Wartungs-TUI-Architektur](../architecture/maintenance-tui.md)
- [A11Y der Wartungs-TUI](../accessibility/maintenance-tui.md)
- [Skriptreferenz](../scripts/reference.md)
- [Preset- und Flotten-Erkenntnisse](Preset-and-Fleet-Operations-Lessons-Learned.md)

**Nächste Aktion:** Zuerst den passenden Prüf- oder Vorschaumodus ausführen und
die textorientierte nächste Aktion lesen.
