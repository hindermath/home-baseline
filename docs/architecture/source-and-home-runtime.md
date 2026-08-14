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

Der normale schreibende Home-Sync läuft nur auf dem Host. Eine ABS-DD-Sandbox
liest die eingebundene Level-0-Referenz und schreibt nicht in die Host-Runtime.
Für eine ausdrücklich angeforderte Betriebskopie im Container darf sie
`sync-home.* --runtime-only` beziehungsweise `-RuntimeOnly` verwenden. Dieser
Modus verteilt nur `homeRuntime`, führt keinen Pull oder Commit aus und ändert
weder Git-Konfiguration noch Git-Identität. Lokale Konflikte stoppen den Lauf
vor dem ersten Schreibzugriff. Agentische Arbeit an Secure-Trader-Systemen läuft
in der freigegebenen Sandbox; allgemeine read-only Analyse kann außerhalb
stattfinden.

## Verantwortung zwischen Basis und Image

| Inhalt | Kanonische Quelle | Verlinkte Vertiefung |
|---|---|---|
| Lernendenweg, Git-Hosting, Level-0-Governance und Source-/Runtime-Vertrag | `home-baseline` | diese Architektur und `docs/learning-units/` |
| Image-Build, installierte Versionen, Mounts, Container-Kommandos und Runtime-Wrapper | `absdd-image-sandbox` | [Sandbox-Dokumentation](https://github.com/hindermath/absdd-image-sandbox/tree/main/docs) |

Die Home Baseline beschreibt also, **warum** und **wann** eine Betriebskopie
zulaessig ist. Das Image beschreibt, **wie** sein konkreter Wrapper, seine
Mounts und seine gepinnte Home-Baseline-Referenz funktionieren. Beide Seiten
verlinken einander; sie duplizieren kein zweites Betriebshandbuch.

## Maintainer und KI-Agenten

Vor einer Änderung:

1. Zielpfad und Distributionsklasse bestimmen.
2. Kanonische Quelle und Owner prüfen.
3. Documentation Impact festlegen.
4. Sprachpartner, Navigation, Plattform und A11Y berücksichtigen.
5. Home-Sync nur bei `homeRuntime` und erst nach kanonischer Lieferung planen.

Commit-, Push-, Merge-, Force- oder Adminrechte werden nie aus einem lokalen
Pfad, einer Runtime-Kopie oder allgemeiner Autonomie abgeleitet.

Der
[Maintainer- und Agentenpfad](../maintenance/agentic-workspace-efficiency-guide.md#maintainer-und-ki-agenten-maintainers-and-ai-agents)
ergänzt dazu Authority-Modi, Serialisierungsgrenzen und einen
wiederverwendbaren Agenten-Prompt.

## Vorteile und Nicht-Ziele

Die Trennung schafft saubere Veröffentlichungshistorie, stabile betriebliche
Einstiegspunkte, begrenzte Verteilung, Schutz lokaler Daten und reproduzierbare
Updates. Sie ist kein zweites Repository, kein Backup aller Home-Dateien und
keine Berechtigung, lokale Änderungen pauschal zu löschen.
