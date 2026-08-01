# Level-0-Quelle und Home Runtime

[English version](source-and-home-runtime.en.md)

## Begriffe

Die **Level-0-Quelle** ist der dauerhafte, versionierte Checkout
`~/home-baseline-source`. Dort entstehen kanonische Änderungen, Commits, Pull
Requests und Pushes.

Die **Home Runtime** ist eine manifestgesteuerte Auswahl betrieblicher Dateien
unter `~/`. Der Begriff bezeichnet nicht das gesamte Home-Verzeichnis. Die
Runtime bietet stabile Aufrufpfade, ist aber keine zweite Quelle.

**Maschinenlokaler Zustand** umfasst private Evidence, Caches, Einstellungen
und Ledger, die nicht veröffentlicht oder aus der Quelle überschrieben werden.

## Distributionsklassen

| Klasse | Kanonischer Änderungsort | Sync | Remote-Grenze |
|---|---|---|---|
| `homeRuntime` | Level-0-Quelle | nach Lieferung per `sync-home.*` | Runtime-Kopie nie direkt pushen |
| `sourceOnly` | Level-0-Quelle | keiner | direkt aus dem Checkout lesen |
| `machineLocal` | lokale Maschine | keiner | keine implizite Veröffentlichung |

Die aktuelle Mitgliedschaft steht in
[`scripts/config/home-sync-manifest.json`](../../scripts/config/home-sync-manifest.json).
Dokumentation nennt keine manuell gepflegte vollständige Dateianzahl.

## Gerichteter Synchronisationspfad

1. In Level 0 ändern und validieren.
2. Commit, Review und Merge nach Repository-Regeln durchführen.
3. `sync-home.*` zuerst mit `--check-only` oder `-CheckOnly` prüfen.
4. Nur manifestgebundene Runtime-Dateien synchronisieren.
5. Maschinenlokale Dateien und private Zustände erhalten.

Source-only-Änderungen benötigen keinen Home-Sync. Runtime-Änderungen werden
nicht zuerst unter `~/` repariert, weil die nächste Synchronisierung sie
überschreiben oder eine nicht veröffentlichte Abweichung erhalten könnte.

## Host und Container

Der schreibende Home-Sync läuft nur auf dem Host. Eine ABS-DD-Sandbox liest die
eingebundene Level-0-Referenz und schreibt nicht in die Host-Runtime. Agentische
Arbeit an Secure-Trader-Systemen läuft in der freigegebenen Sandbox; allgemeine
read-only Analyse kann außerhalb stattfinden.

## Maintainer und KI-Agenten

Vor einer Änderung:

1. Zielpfad und Distributionsklasse bestimmen.
2. Kanonische Quelle und Owner prüfen.
3. Documentation Impact festlegen.
4. Sprachpartner, Navigation, Plattform und A11Y berücksichtigen.
5. Home-Sync nur bei `homeRuntime` und erst nach kanonischer Lieferung planen.

Commit-, Push-, Merge-, Force- oder Adminrechte werden nie aus einem lokalen
Pfad, einer Runtime-Kopie oder allgemeiner Autonomie abgeleitet.

## Vorteile und Nicht-Ziele

Die Trennung schafft saubere Veröffentlichungshistorie, stabile betriebliche
Einstiegspunkte, begrenzte Verteilung, Schutz lokaler Daten und reproduzierbare
Updates. Sie ist kein zweites Repository, kein Backup aller Home-Dateien und
keine Berechtigung, lokale Änderungen pauschal zu löschen.
