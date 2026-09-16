# Home-Baseline-Statistikpilot / Home Baseline statistics pilot

## Stand und naechste Aktion / Status and next action

2026-09-16: Konfiguration nach ausdruecklicher Freigabe lokal committed;
erste Messung samt Snapshot erzeugt. Bash und PowerShell bestaetigen
`CURRENT`, `reproducible=true`, `current=true`, jeweils Exit 0.
Thorsten Hindermann hat Messbericht und Nachweis fachlich gesichtet und den
naechsten Schritt freigegeben. Diese Freigabe umfasst die lokale Sicherung
der Messartefakte und die Wiederholungspruefung auf sauberem Git-Stand.
Keine vollstaendige Feldtest- oder Release-Abnahme; kein Push oder Merge.
Die Statistik-Skills liefern kein Git; lokale Commits erfolgen separat.

The configuration was locally committed under explicit separate authority.
The first measurement and snapshot passed both Bash and PowerShell replay:
CURRENT, reproducible and current, exit 0. Thorsten Hindermann reviewed the report
and evidence and authorized local commits and clean-tree repeat checks.
This is not full field or release acceptance and does not authorize push or merge.
Statistics skills do not deliver Git changes.

- [Konfiguration / Configuration](config.json)
- [Messbericht / Measurement report](report.md)
- [Gebundener Snapshot / Bound snapshot](snapshot.json)
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

Die Ausgangsrevision enthaelt die neue Konfiguration noch nicht. Messrevision
ist der separat genehmigte Vorbereitungs-Commit
`e1d6d36e444cc252a0321572e70da8874de81fe3` auf
`codex/project-statistics-home-field-test`; Stichtag ist `2026-09-16` in UTC.
The starting revision predates the configuration. The explicitly authorized
preparation commit above binds the measurement, with cutoff 2026-09-16 UTC.

## Initialisierungsnachweis (historisch) / Initialization evidence (historical)

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

`reproducible=false` und `current=false` bedeuteten hier fehlende Mess-Evidence,
nicht einen nachgewiesenen Reproduzierbarkeitsfehler. Reproduzierbarkeit,
Aktualitaet, Abdeckung, Messwerte und manuelle Abschnittserhaltung beim Update
waren damals noch nicht geprueft. / Both false values reflect missing evidence, not a
proven reproducibility defect. These were the pre-measurement results;
the executed measurement and successful replay are documented below.

## Erste Messung / First measurement

| Pruefung / Check | Exit | Ergebnis / Result |
| --- | ---: | --- |
| Bash Update --dry-run --json, fester Commit und Stichtag / pinned inputs | 0 | DRY_RUN; 696425 Zeilen / lines, 110 Aktivtage / active days |
| PowerShell Update -WhatIf -Json, gleiche Eingaben / same inputs | 0 | Identische Messwerte, keine Dateiaenderung / same values, no writes |
| Bash Update --json, gleiche Eingaben / same inputs | 0 | UPDATED; report.md und snapshot.json erzeugt / generated |
| Bash Status --json | 0 | CURRENT; reproducible=true; current=true; changed=false |
| PowerShell Status -Json | 0 | Identische Entscheidung / same decision |
| Summen, Datumsgrenzen, Hash, manuelle Abschnitte / content validation | 0 | Bestanden / passed |

Vorschau und Messung verwenden jeweils `--revision` mit dem vollstaendigen
Messcommit und `--as-of 2026-09-16` bzw. `-Revision` und `-AsOf`.
Status spielt die gespeicherte Messung erneut ab und prueft die Aktualitaet
gegen den lokalen Git-HEAD. Er belegt keine Remote-Aktualitaet; kein Fetch.
Both previews and the write bind the full measurement commit and cutoff.
Status replays the stored snapshot and compares against local HEAD, not remote
freshness. No fetch was performed.

- Bestand / inventory: 3234 Textdateien / text files, 696425 Textzeilen / lines.
- Aktivitaet / activity: 110 Tage / days, 2025-09-21 bis / through 2026-09-16 UTC.
- Abdeckung / coverage: 2 binaere Dateien / binary files; 0 Symlinks / symlinks;
  0 Submodule / submodules; 2 explizit ausgelassene Ledger / excluded ledgers.
  Der Pilotkontext ist auch aus den Abdeckungszaehlern entfernt.
  / The pilot context is also outside the coverage counters.
- Renderer-SHA-256 / renderer SHA-256:
  `a40f565e2f7451d5688103b69e40a7a39e226507cf3ee43144a60af386d65d30`.
- Generierter Abschnitt / generated section SHA-256:
  `0bd5074f55cfdeb2df6b8129b15ae406bb5635987de9873c5a09854606f4e242`.
- Snapshot-Datei / snapshot file SHA-256:
  `1c0b65b54c7c42a2be9ecb99268532ccf647e583cbde4c631e5f359ceb992584`.

Die Vorschauen liessen den Arbeitsbaum sauber und erzeugten keinen Snapshot.
Beide Statusaufrufe liessen alle sechs geprueften Datei-Hashes (Konfiguration,
Bericht, Snapshot, README, bestehender Ledger und dessen Konfiguration) sowie
den Git-Status unveraendert. Die Messung erhielt den manuellen Berichtsvorspann
bytegleich zum Vorbereitungsstand. Anschliessend wurde ausschliesslich dessen
Statusaussage bewusst auf den gemessenen Stand aktualisiert.

Previews kept a clean tree and created no snapshot. Both status calls preserved
all six checked file hashes and Git status. Rendering preserved the authored
report prefix exactly. Its status wording was then intentionally updated to
describe the completed measurement, without changing the generated block.

Kategorien summieren sich exakt zu Dateien und Zeilen; alle Tageswerte liegen
im Fenster. Der Bericht bleibt hoechstens 100 Zeichen breit; erzeugte Ausgaben
verwenden LF und UTF-8 ohne BOM. Numerische Heatmaps haben Tageswerte als
Textalternative; Referenzmodellrechnungen fehlen wie konfiguriert.
Category sums, date bounds, generated-section hash, 100-column width and
LF/UTF-8 without BOM checks passed. Heatmaps have exact daily text values;
reference estimates remain disabled.

Grenzen: Diese Messung beweist Reproduzierbarkeit auf macOS, keine unabhaengige
mathematische Vollpruefung des Renderers. Native Linux-/Windows-Feldtests,
LF/CRLF/BOM-Eingabeparitaet, erneutes schreibendes Update auf sauberem Stand,
Drift-/Negativfall-Vollsuite und vollstaendige Feldtest-Abnahme bleiben hier offen.
Bestehende Statistik blieb unveraendert; ihre regulaere Fortschreibung ist
vor einer spaeteren Lieferung separat zu pruefen. Keine `ReleaseAccepted`-Aussage.
Limits: native Linux/Windows field runs, input encoding parity, a repeated
write on a clean tree, the full drift/negative suite and full field acceptance are
not established here. Existing statistics remain unchanged; review their normal
refresh before later delivery. No ReleaseAccepted claim or full independent
mathematical validation of the renderer.

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
