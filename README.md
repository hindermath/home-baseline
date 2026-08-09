# home-baseline

[English version](README.en.md)

`home-baseline` ist die versionierte Level-0-Quelle für einen sicheren,
plattformübergreifenden und agentisch unterstützten Entwicklungsarbeitsplatz.
Sie verwaltet gemeinsame Skripte, Governance, Spec-Kit-Presets,
Dokumentationsregeln und Lernmaterialien. Du brauchst keine Spec-Kit-Erfahrung,
um hier zu beginnen.

## Sicher starten

Arbeite für Änderungen, Commits, Pull Requests und Pushes immer im dauerhaften
Checkout `~/home-baseline-source`. Das Home-Verzeichnis `~/` enthält nur die
ausgewählte **Home Runtime**, also betriebliche Kopien und maschinenlokalen
Zustand. Es ist keine zweite Level-0-Quelle.

Vor einem schreibenden Wartungslauf zuerst die Vorschau verwenden:

```bash
# macOS oder Linux: prüft und zeigt geplante Änderungen
bash scripts/maintain-agentic-workspace.sh --dry-run
```

```powershell
# Windows mit PowerShell 7: prüft und zeigt geplante Änderungen
pwsh -NoProfile -File scripts/maintain-agentic-workspace.ps1 -WhatIf
```

Die Vorschau kann sichere Remote-Abfragen ausführen, verändert aber keine
Arbeitsdateien. Prüfe das textorientierte Ergebnis und die genannte nächste
Aktion, bevor du einen echten Lauf autorisierst.

## Wähle deinen Leserpfad

| Du möchtest ... | Einstieg | Nächste Aktion |
|---|---|---|
| lernen oder neu beginnen | [Lernpfad](docs/learning-units/START-HERE-FUER-LERNENDE.md) | Beruf, Lehrjahr und erste Unit auswählen |
| den Workspace täglich pflegen | [Wartung](docs/maintenance/README.md) | Plattform wählen und Vorschau ausführen |
| als Maintainer oder KI-Agent arbeiten | [Source und Home Runtime](docs/architecture/source-and-home-runtime.md) | kanonischen Änderungsort und Sync-Bedarf bestimmen |
| prüfen oder Fehler analysieren | [Prüfung und Fehleranalyse](docs/troubleshooting/README.md) | Head, Evidence und Proof-Grenze feststellen |

Der ausführliche
[Effizienzleitfaden](docs/maintenance/agentic-workspace-efficiency-guide.md)
verbindet diese vier Leserpfade mit sicheren Befehlen, Evidence und klaren
Stop-Grenzen.

## Lokales Modell-Routing für KI-Agenten

**Modell-Routing** bedeutet: Eine stabile Arbeitsrolle wie
`frontier-reasoning` oder `fast-mechanical` wird auf ein Modell abgebildet, das
das lokal installierte Agentenprogramm tatsächlich anbietet. Fachliche
Spec-Kit-Artefakte nennen deshalb Rollen, keine vergänglichen Modellnamen.

Das optionale Preset `model-routing-governance` auf Priorität `61` erkennt
lokale Harness-Fähigkeiten, zum Beispiel über Codex oder Antigravity. Es
veröffentlicht keine Modellliste und übernimmt keine Zugangsdaten. Die konkrete
Auswahl bleibt als `machineLocal`-Konfiguration auf dem jeweiligen Rechner.
Unbekannte oder mehrdeutige Zuordnungen werden blockiert und niemals geraten.

```bash
# Nur lesen: installierte Harness-Fähigkeiten und lokale Bindung prüfen
bash scripts/resolve-model-routing.sh -Action Status -Harness Codex \
  -RoutingRoot .specify/presets
```

```powershell
# Ausdrücklich lokal aktualisieren; keine Repository-Datei wird geändert
pwsh -NoProfile -File scripts/resolve-model-routing.ps1 `
  -Action Refresh -Harness Codex -RoutingRoot .specify/presets
```

Der Ein-Kommando-Wartungslauf führt nach der Toolchain-Prüfung nur den
read-only Status aus. Ein Refresh braucht eine aktuelle lokale Autorisierung.
Autonome Presets dürfen Modelle ausschließlich an validierten Phasengrenzen in
einem neuen Prozess wechseln. Delivery- und Provider-Rechte entstehen dadurch
nicht.

Das vollständige [Dokumentationsportal](docs/README.md) ordnet alle Themen und
kanonischen Quellen ein. Die [Skriptreferenz](docs/scripts/reference.md) listet
die verfügbaren Befehle, Plattformen und sicheren Prüfmodi.

## Voraussetzungen

- Git und ein persönliches oder institutionelles Git-Repository;
- auf Windows PowerShell 7, auf macOS/Linux Bash;
- `gh` für GitHub oder `glab` für GitLab nur dann, wenn du diese Plattform nutzt;
- Python 3 und `pwsh` für die vollständigen Governance-Prüfungen;
- für agentische Arbeit an Secure-Trader-Systemen eine freigegebene Sandbox.

Die ausführliche Installation steht unter
[Erste Schritte](docs/getting-started.md). GitHub ist ein mögliches Profil,
aber keine allgemeine Voraussetzung für Lernende.

## Sicherheits- und Zugänglichkeitsgrenzen

- `Programmierung #include<everyone>` gilt für Dokumentation, CLI und UI.
- Nutzerseitige Inhalte folgen Deutsch zuerst, Englisch danach, CEFR B2 und
  anwendbaren Kriterien der WCAG 2.2 AA.
- Geheimnisse, produktive Daten und persönliche absolute Pfade gehören nicht in
  Commits oder veröffentlichbare Evidence.
- Agentische Arbeit an Secure-Trader-Systemen läuft container-first in einer
  freigegebenen Sandbox.
- Wartungsskripte committen, pushen oder mergen nicht selbst in Ziel-Repositories.
- Remote- oder Adminrechte entstehen nur durch eine aktuelle ausdrückliche
  Autorisierung.

Siehe [Sicherheitsdokumentation](docs/security/README.md),
[A11Y für die Wartungs-TUI](docs/accessibility/maintenance-tui.md) und
[Dokumentations-Governance](docs/documentation-governance.md).

## Source, Runtime und lokaler Zustand

Die drei Distributionsklassen verhindern, dass Quelle, betriebliche Kopie und
private Maschinendaten verwechselt werden:

- `homeRuntime`: wird kanonisch in Level 0 geändert und anschließend
  manifestgesteuert nach `~/` synchronisiert;
- `sourceOnly`: wird direkt aus `~/home-baseline-source` gelesen und benötigt
  keinen Home-Sync;
- `machineLocal`: bleibt ausschließlich auf der Maschine und erhält keine
  implizite Remote-Autorität.

Die vollständige Erklärung mit Ownern, Sync-Triggern und Container-Grenze steht
unter [Source und Home Runtime](docs/architecture/source-and-home-runtime.md).
Konkrete Runtime-Mitglieder werden aus
[`scripts/config/home-sync-manifest.json`](scripts/config/home-sync-manifest.json)
abgeleitet.

In der ABS-DD-Sandbox bleibt der allgemeine schreibende Home-Sync gesperrt. Der
explizite Runtime-only-Modus verteilt nur `homeRuntime` nach `/home/adedev` und
überspringt Pull, Commit, Git-Konfiguration und Git-Identität:

```bash
bash ~/home-baseline-source/scripts/sync-home.sh --runtime-only
```

*Inside the ABS-DD sandbox, general writing Home sync remains blocked. The
explicit runtime-only mode distributes only `homeRuntime` into `/home/adedev`
and skips pull, commit, Git configuration, and Git identity.*

## Änderungen beitragen

1. `AGENTS.md` und die Constitution lesen.
2. Auf einem aktuellen `codex/`- oder nummerierten Feature-Branch arbeiten.
3. Vor Änderungen den sicheren Prüfmodus des betroffenen Skripts verwenden.
4. Genau eine Documentation-Impact-Entscheidung dokumentieren.
5. Betroffene Tests, Links, Sprachpartner, A11Y- und Sicherheitsprüfungen ausführen.
6. Pull Request gegen den kanonischen Default-Branch erstellen.

Weitere Einzelheiten stehen im
[Maintainer- und Agentenpfad](docs/architecture/source-and-home-runtime.md#maintainer-und-ki-agenten)
und in den [Repository Guidelines](AGENTS.md).
