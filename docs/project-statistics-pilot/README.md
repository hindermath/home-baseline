# Home-Baseline-Statistikpilot / Home Baseline statistics pilot

## Stand und naechste Aktion / Status and next action

2026-09-16: Schritt 4, Teil 1 begonnen; Kontext initialisiert und Konfiguration
technisch geprueft. Noch keine Messung, kein Snapshot, keine Feldtest-Abnahme.
Naechste Aktion: Konfiguration und Begleitdokumentation sichten und unter
separater Git-Autoritaet committen. Erst danach Update-Vorschau und Messung.
Die Statistik-Skills fuehren weder Commit noch Push oder Merge aus.

Step 4, part 1 started: context initialized and configuration technically
validated. No measurement, snapshot or field acceptance yet. Review and commit
the configuration and accompanying documentation under separate Git authority
before previewing and running Update. Statistics skills do not deliver Git changes.

- [Konfiguration / Configuration](config.json)
- [Berichtsvorlage / Report scaffold](report.md)
- [Pilotuebersicht / Pilot overview](../maintenance/project-statistics-pilot-v010.md)
- [Kanonische Bestandsstatistik / Authoritative existing statistics](../project-statistics.md)
- [Projekttracking / Project tracking](https://github.com/hindermath/home-baseline/issues/298)

## Konfigurationsentscheidung / Configuration decision

`Home Baseline`, Methodik `project-transparency/1`, 52 Wochen, Zeitzone `UTC`.
UTC bleibt bewusst der portable Preset-Default; Tagesgrenzen sind nicht die
lokalen Europe/Berlin-Tagesgrenzen. Keine manuellen Phasen oder Kategorien-
Overrides, keine zusaetzlichen Ausschluesse, keine Referenz-Modellrechnungen.
Der Renderer schliesst den eigenen Kontext, `docs/project-statistics.md` und
`STATS.md` bereits aus. Die bestehende Profil-2-Konfiguration schliesst den
Pilotkontext ebenfalls aus und bleibt unveraendert. Uebernommene Preset- und
Agenten-Dateien bleiben Teil des Bestands; Zeilenzahlen beweisen keine eigene
Programmierleistung, Qualitaet oder KI-Produktivitaet.

Use the portable UTC default and a 52-week window, without manual phase values,
category overrides, extra exclusions or reference estimates. UTC date boundaries
differ from local Berlin time. Built-in exclusions remove this context and both
existing statistics ledgers. Legacy configuration already excludes the pilot.
Imported preset and agent files remain included; volume is not individual
authorship, quality or AI productivity evidence.

## Quellen und Umgebung / Sources and environment

- Ausgangsrevision / starting revision: `b5df226bf6ed7fdb8492cfe06ea822c0441f20c2`.
- Start: sauberer `main`, lokale Remote-Tracking-Differenz `0/0`; kein Fetch.
  / Clean main, local remote-tracking delta 0/0; no fetch performed.
- Vollstaendiger lokaler Klon; kein Shallow-/Partial-/Promisor-Klon.
  / Full local clone, not shallow, partial or promisor.
- macOS/arm64, PowerShell 7.6.6; Linux und Windows hier nicht ausgefuehrt.
  / Linux and Windows were not executed in this preparation.
- Preset v0.1.0: alle 26 installierten Dateien stimmen mit den SHA-256-Werten
  im [Installationsnachweis](../maintenance/project-statistics-installation-v010.json)
  ueberein. / All 26 installed payload hashes match the installation receipt.
- Quellencommit / package source: `7e824ca8de11212aefdc5b05d7d05637f5343dab`.
- Konfigurations-SHA-256 / configuration SHA-256:
  `5dd852e65b76795bc0272362c38d0eda78273dec2005679ec62e495bc0e86427`.

Die Ausgangsrevision ist noch keine Messrevision: sie enthaelt die neue
Konfiguration nicht. Der Stichtag und die tatsaechliche Messrevision werden
beim spaeteren Update explizit gebunden. / The starting revision is not a
measurement revision: it does not contain the configuration yet. Bind the
actual measurement revision and cutoff explicitly when Update is run.

## Ausgefuehrte Pruefungen / Executed checks

Alle Befehle verwenden `--repo . --config docs/project-statistics-pilot/config.json`
beziehungsweise die entsprechenden PowerShell-Parameter. Installierte Skripte:
`.specify/presets/project-statistics-governance/scripts/project-statistics.sh`
und die gleichnamige `.ps1`-Datei. / All checks use the explicit pilot context
and installed entrypoints, never the default statistics context.

| Pruefung / Check | Exit | Ergebnis / Result |
| --- | ---: | --- |
| Bash Init --dry-run --json | 0 | DRY_RUN; Arbeitsbaum weiter sauber / tree still clean |
| PowerShell Init -WhatIf -Json | 0 | DRY_RUN; Arbeitsbaum weiter sauber / tree still clean |
| Bash Init --json | 0 | INITIALIZED; nur config.json und report.md erzeugt / created |
| Konfiguration gegen mitgeliefertes JSON-Schema / schema validation | 0 | Gueltig / valid |
| Bash Status --json | 1 | DRIFT: Snapshot fehlt / no snapshot |
| PowerShell Status -Json | 1 | Identische Entscheidung / same decision |
| Bash Update --revision HEAD --as-of 2026-09-16 --dry-run --json | 2 | Clean-worktree-Gate blockiert / blocked |
| PowerShell Update -Revision HEAD -AsOf 2026-09-16 -WhatIf -Json | 2 | Identische Blockierung / same block |

Bei Status und Update-Vorschau bleiben SHA-256 von Pilotkonfiguration,
Berichtsvorlage sowie bestehendem Ledger und dessen Konfiguration unveraendert.
Kein Snapshot erzeugt. Dies belegt den begrenzten Read-only-Test, nicht einen
vollstaendigen Dateisystem-Audit. / The four file hashes remain unchanged;
no snapshot is created. This is scoped read-only evidence, not a filesystem audit.

Geschuetzte Hashes / preserved hashes:

- Pilot-Berichtsvorlage / pilot scaffold:
  `7f5c606bc20cdcce092e49bab51b3abfd8e1393f5301e2bd71b327a068402aa0`
- Bestehender Ledger / existing ledger:
  `6c734f907c2d230994ae8f40ebdaaef552077f4419fa9db37e479c483184b43f`
- Bestehende Konfiguration / existing configuration:
  `b98169acc91ccf24b0ca1b32358c5f7180dd7af128e79d42022028e095d08bd1`

`reproducible=false` und `current=false` bedeuten hier fehlende Mess-Evidence,
nicht einen nachgewiesenen Reproduzierbarkeitsfehler. Reproduzierbarkeit,
Aktualitaet, Abdeckung, Messwerte und manuelle Abschnittserhaltung beim Update
sind noch nicht geprueft. / Both false values reflect missing evidence, not a
proven reproducibility defect. Measurement and successful replay remain pending.

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`; Owner und fachlicher Reviewer: Thorsten Hindermann.
Leserpfad fuer Lernende, Maintainer und Pruefende: Pilotuebersicht -> dieses
Dokument -> Konfiguration/Bericht -> spaeterer zentraler Feldbericht.
Kanonische Quellen: Preset fuer Methodik, lokale Konfiguration und Git-Objekte
fuer den Pilot. ActiveSemantic, DE zuerst/EN danach, `sourceOnly`, kein Home-Sync.
Konfiguration aendert weder Laufzeit noch Produkt-API oder gemeinsame Regeln;
Constitution und Agentenflaechen benoetigen fuer diesen Kontext keine Anpassung.
Keine externe Datenuebertragung, neue Abhaengigkeit oder menschliche Freigabe.
Wiedervorlage nach Konfigurations-Commit, Preset-/Quellen-/Methodikwechsel.

UpdateRequired; owner/reviewer Thorsten Hindermann. The reader path connects
overview, preparation, configuration and report. The preset owns methodology;
local configuration and Git objects supply pilot inputs. Bilingual source-only
documentation, no Home sync, runtime/API change or new shared governance rule.
No external data transfer, new dependency or human approval is inferred.
Reevaluate after the configuration commit or source/method changes.
