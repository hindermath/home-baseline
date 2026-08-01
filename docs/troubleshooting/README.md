# Prüfung und Fehleranalyse

[English version](README.en.md)

## Bevor du etwas reparierst

1. Repository, Branch und exakten Commit feststellen.
2. Working Tree, Index, unversionierte Pfade und Worktrees read-only prüfen.
3. Akzeptierte Artefakthashes und den letzten bestandenen Gate ermitteln.
4. Report, Live-Evidence und Exitcode gemeinsam bewerten.
5. Eine veraltete oder unvollständige Operation als erneut zu validieren behandeln.

Keine pauschalen Reset-, Clean-, Stash- oder Löschbefehle verwenden. Nach einer
Zustandsänderung muss die Kandidatenmenge neu inventarisiert werden.

## Häufige Befunde

### Lokaler Branch ist hinter dem Remote

Zuerst `fetch --prune`. `pull --ff-only` ist nur auf sauberem, eindeutigem
Default-Branch mit `ahead=0` erlaubt. Andernfalls Befund und nächste Aktion
dokumentieren.

### Autonomer Lauf wurde unterbrochen

Zuerst `$speckit-autonomous-status` read-only ausführen. Der allgemeine
Autonomous-Befehl darf einen bestehenden Lauf nicht überschreiben. Fortsetzung
erfolgt nur über `$speckit-autonomous-resume` mit erneuerter Autorität.

### Live-Evidence ist unvollständig

Bei `EVENT_STREAM_DEGRADED` den vorgebundenen Abschlussreport und den Exitcode
prüfen. Ein fehlendes Event ist weder automatisch Erfolg noch Fehler.

### Dokumentation und Verhalten widersprechen sich

Kanonische Quelle, Dokumentklasse, Generator und exakten Implementierungs-Head
bestimmen. Der technische Validator beweist Struktur; ein semantischer Review
prüft Aussage und Verständlichkeit.

Der
[Auditpfad des Effizienzleitfadens](../maintenance/agentic-workspace-efficiency-guide.md#fehleranalyse-und-audit--troubleshooting-and-audit)
ordnet Lock, Run-ID, Report, Exitcode, JSONL und Wiederanlauf in eine feste
Diagnosereihenfolge ein.

## Evidence-Pfade

- aktuelle Projektentwicklung: [Projektstatistik](../project-statistics.md)
- Skriptverträge: [Skriptreferenz](../scripts/reference.md)
- Security: [Security-Dokumentation](../security/README.md)
- autonome Features: jeweiliges `specs/NNN-*/autonomous-run-evidence.md`
- historische oder archivierte Evidence: unverändert lesen, nicht korrigieren

**Nächste Aktion:** Evidence nur für den exakten akzeptierten Head verwenden;
bei Drift die betroffene Prüfung vollständig wiederholen.
