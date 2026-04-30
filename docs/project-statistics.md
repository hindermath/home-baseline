# Projektstatistik / Project Statistics — home-baseline

> **Lebendiges Dokument / Living document** — wird nach jedem abgeschlossenen Feature,
> nach jeder abgeschlossenen Spec-Kit-Implementierungsphase und auf explizite Anfrage
> aktualisiert.
>
> *Updated after every completed feature, Spec-Kit implementation phase, or on explicit
> request.*

---

## Fortschreibungsprotokoll / Update Log

Ältester Eintrag oben, neuester Eintrag unten.
*Oldest entry at top, newest entry at bottom.*

| Datum / Date | Phase / Branch | Aktivtage ges. | Zeilen ges. | Commits ges. | Hauptarbeitspakete / Main Work Packages |
|---|---|---:|---:|---:|---|
| 2026-04-12 | Baseline (alle Phasen 0–5) | 11 | 41 969 | 216 | Init-Infrastruktur, Homogeneity Guardian (001+002), Public Template + Sync (pub), CI + Git-Config-Scope (003), Workspace Teardown + GitLab-Support (005+006), Bootstrap-Project + Release Please |
| 2026-04-18 | Maintenance-Rollup inkl. Agent-Audit | 17 | 45 712 | 256 | Nachlaufende Maintenance-Runden, Microsoft-Foundry-Skill-Sync im Arbeitsbaum, neues lokales Agent-Audit mit Baseline/Report fuer Codex, Claude, Copilot und Continue, README-, Guidance- und Manpage-Dokumentation |
| 2026-04-22 | Maintenance-Guidance serielle Migration | 21 | 42 875 | 266 | Remote-Fast-Forward auf Constitution v1.6.0, agentische Umgebung aktualisiert, Homogeneity-Statistiken fortgeschrieben, Fallstrick zu parallelen `migrate-workspace.*`-Laeufen in Shared Guidance und README dokumentiert |
| 2026-04-26 | Spec-Kit Preset Governance & Veroeffentlichung | 25 | 67 251 | 291 | Sechs Spec-Kit-Governance-Presets fachlich geschnitten, standalone GitHub-Repos veroeffentlicht, lokale und GitHub-ZIP-Smoke-Tests ausgefuehrt, Issue `github/spec-kit#2362` aktualisiert, Preset-Pflegeworkflow in Verfassung und Agenten-Dateien dokumentiert; Release-Matrix nachgetragen |
| 2026-04-29 | Agentische Praxisprobe OpenCode-Analyse | 26 | 67 359 | 292 | `WebStormProjects` und `opencode-analysis` praktisch eingerichtet, OpenCode-Fork-Workflow vorbereitet, `bootstrap-project.*` auf agentenweise Spec-Kit-Initialisierung fuer Gemini, OpenCode, Claude, Copilot und Codex korrigiert |
| 2026-04-29 | Git-Identity-Sync-Haertung | 26 | 67 456 | 294 | `.gitconfig` aus blindem `sync-home`-Kopiervorgang entfernt, lokale Git-Identitaet dauerhaft geschuetzt, alte Platzhalter-Warnkoepfe automatisch migriert und README-Dokumentation aktualisiert |
| 2026-04-29 | opencode-analysis CI-Fix | 26 | 67 507 | 302 | Fehlgeschlagenen Homogeneity-Workflow in `opencode-analysis` analysiert und behoben; `--exit-on-fail` durch gueltigen `--fail-fast .`-Aufruf ersetzt, Level-2-README-/Agenten-Templates ergaenzt und Scanner fuer git-ignorierte Unterrepos gehaertet |
| 2026-04-29 | Level-1-Workspace-Bootstrap-Haertung | 26 | 67 914 | 303 | Ursache fuer den minimal eingerichteten `WebStormProjects`-Workspace ermittelt, bestehenden Level-1-Workspace auf vollstaendige agentische Baseline gebracht und `bootstrap-workspace.*` samt Workspace-README-Template fuer kuenftige Erst-Einrichtungen erweitert |
| 2026-04-30 | Spec-Kit 0.8.3 Update-Automation | 28 | 71 461 | 306 | Spec-Kit-0.8.3-Integrationen ueber Level 0/1/2 aktualisiert, OpenCode-Command-Tracking aufgenommen, Governance-Template-Erhalt in Verfassung und Agenten-Dateien dokumentiert, `update-spec-kit.sh/.ps1` samt Manpage und `sync-home`-Docs-Sync ergaenzt |
| 2026-04-30 | Public-Template-Quelle fuer Spec-Kit-Updates | 28 | 71 527 | 309 | `update-spec-kit.*` von impliziter TuiVision-Prioritaet auf selbsttragendes `home-baseline`-Default umgestellt; private Template-Quellen nur noch als expliziter Override dokumentiert; Verfassung, Agenten-Dateien, README und Manpage nachgezogen |

---

## Gesamtstand des Repositories / Repository Snapshot

Stand / As of: **2026-04-30**

| Kategorie / Category | Dateien / Files | Zeilen / Lines | Anteil / Share |
|---|---:|---:|---:|
| Skripte / Scripts (`.sh` + `.ps1`) | 81 | 17 385 | 24.3 % |
| Templates (`.tmpl` + Konfigurationsdateien) | 21 | 1 057 | 1.5 % |
| Hooks + CI (pre-push + YAML/JSON) | 20 | 1 787 | 2.5 % |
| Dokumentation / Documentation (`.md`) | 423 | 48 564 | 67.9 % |
| Sonstiges / Other | 30 | 2 734 | 3.8 % |
| **Gesamt / Total** | **575** | **71 527** | **100 %** |

### Aufgliederung Dokumentation / Documentation Breakdown

| Untertyp / Subtype | Zeilen / Lines | Anteil an Doku / Share of Docs |
|---|---:|---:|
| Spec-Kit-Artefakte (`specs/`) | 16 277 | 33.6 % |
| Lastenhefte (`Lastenheft*.md`) | 3 840 | 7.9 % |
| Governance (AGENTS / CLAUDE / GEMINI / constitution) | 3 390 | 7.0 % |
| README / CHANGELOG / STATS | 3 040 | 6.3 % |
| Sonstiges (Templates, andere `.md`) | 22 017 | 45.3 % |

---

## Phasen und Haupt-Branches / Phases and Main Branches

Die Spalte „Insertions" gibt den dokumentierten Netto-Beitrag der Phase an
(Zeilen eingefuegt, ohne nachtraegliche Loeschungen in spaeteren Phasen abzuziehen).

*The "Insertions" column shows the documented net contribution per phase
(lines inserted, without subtracting later deletions in subsequent phases).*

| Phase | Bezeichnung / Label | Insertions | Commits | Aktivtage / Active Days | Zeitraum / Period |
|---|---|---:|---:|---:|---|
| 0 | main — Init-Backbone | 954 | 24 | 1 | 2026-03-31 |
| 1 | 001+002 — Homogeneity Guardian + Revision | 26 519 | 38 | 1 | 2026-04-01 |
| 2 | pub+sync — Public Template + Sync-Home | 6 168 | 51 | 2 | 2026-04-02 bis 04-03 |
| 3 | CI+003 — CI-Pipeline + Git-Config-Scope | 1 523 | 92 | 3 | 2026-04-04 bis 04-06 |
| 4 | 005+006 — Workspace Teardown + GitLab | 10 769 | 21 | 2 | 2026-04-08 bis 04-11 |
| 5 | proj — Bootstrap-Project + Release Please | 686 | 21 | 1 | 2026-04-12 |
| 6 | presets — Spec-Kit Governance Presets | 7 751 | 9 | 2 | 2026-04-25 bis 04-26 |

**Hinweis zu spaeteren Maintenance-Runden:** Die Snapshot- und Gesamtwerte oben
enthalten auch die nachfolgenden Maintenance-Arbeiten bis `2026-04-30`. Dazu
gehoeren insbesondere die Verfassungs- und Agenten-Guidance-Runden, Release-
Please-Aktualisierungen sowie die Preset-Governance-Arbeit.

*Note on later maintenance rounds: the snapshot and overall values above also
include follow-up maintenance work through `2026-04-30`, especially constitution
and agent-guidance rounds, Release Please updates, preset-governance work, and
the Level-1 workspace bootstrap hardening.*

**Hinweis zu Phase 1:** Der hohe Insertions-Wert (26 519 Zeilen an einem Aktivtag)
entsteht durch die Spec-Kit-Batch-Generierung: Spec-Kit erstellt `spec.md`,
`plan.md`, `tasks.md`, `checklist.md` und zugehoerige Artefakte in einem einzigen
orchestrierten Lauf. Das ist kein manueller Tippaufwand, sondern der dokumentierte
Output agentischer KI-Unterstuetzung — genau das, was das Speedup-Modell abbildet.

*Note on Phase 1: The high insertion count (26 519 lines in one active day) results
from Spec-Kit batch generation: Spec-Kit produces spec.md, plan.md, tasks.md,
checklist.md and related artifacts in a single day. This is not manual typing
effort but documented output of agentic AI support — precisely what the speedup
model captures.*

**Hinweis zu Phase 6:** Die Preset-Phase hat aus der Verfassung sechs
wiederverwendbare Spec-Kit-Presets abgeleitet, als repo-foermige Scaffolds
dokumentiert, in eigenstaendige GitHub-Repos veroeffentlicht und per GitHub-ZIP-
Installation smoke-getestet. Der Zeilenzuwachs liegt fast vollstaendig in
Markdown/YAML-Governance-Artefakten.

*Note on Phase 6: The preset phase derived six reusable Spec Kit presets from the
constitution, documented them as repo-shaped scaffolds, published standalone
GitHub repositories, and smoke-tested GitHub ZIP installation. The line growth is
almost entirely Markdown/YAML governance artifacts.*

---

## Release-Staende und Aenderungen / Release States and Changes

Quelle fuer diese Matrix ist `CHANGELOG.md`; lokale Git-Tags sind ab `v0.3.1`
vorhanden. Die Releases `v0.1.0` bis `v0.3.0` sind historisch im Changelog
dokumentiert, im aktuellen lokalen Tag-Satz aber nicht als Tags vorhanden.
GitHub-Releases sind per Remote-Abgleich am `2026-04-26` fuer `v0.4.0` bis
`v0.11.0` vorhanden; `v0.3.1` ist lokal getaggt und im Changelog dokumentiert.

*This matrix is based on `CHANGELOG.md`; local Git tags exist from `v0.3.1`
onward. Releases `v0.1.0` through `v0.3.0` are historically documented in the
changelog but are not present as tags in the current local tag set. Remote
GitHub Releases were checked on `2026-04-26` and exist for `v0.4.0` through
`v0.11.0`; `v0.3.1` is locally tagged and documented in the changelog.*

| Release | Datum / Date | Erfasst in Statistik / Captured in Statistics | Hauptaenderungen / Main Changes |
|---|---|---|---|
| v0.1.0 | 2026-03-31 | Phase 0 | Initiale Bootstrap-Infrastruktur, Agenten-Dateien, Spec-Kit-Integration, Whitelist-`.gitignore`, `STATS.md`, bilinguale README |
| v0.2.0 | 2026-04-03 | Phase 1 | Workspace Homogeneity Guardian, Stats-/Migrations-/Constitution-Sync-Skripte, MIT-Lizenz, Homogeneity-CI, Template-Repo-Umstellung |
| v0.3.0 | 2026-04-03 | Phase 2 | `sync-home.*`, CHANGELOG, README-Ausbau, Spec-Kit-Dokumentation, WCAG-Abschnitt, Agenten-Guidance und CI-Fixes |
| v0.3.1 | 2026-04-03 | Phase 2 | README-Tabellenkorrektur, `specify init --here --ai {agent}`, Agenten-Known-Pitfalls |
| v0.4.0 | 2026-04-03 | Phase 2 | Release Please eingerichtet, CI-Fehler behoben, Release-Please-Dokumentation |
| v0.4.1 | 2026-04-05 | Phase 2/3 | Compliance-Ziel korrigiert, OpenCode/Linux/Codex/sync-home-Fixes, Arbeitsverzeichnis- und OS-Detection-Guidance |
| v0.4.2 | 2026-04-05 | Phase 3 | Claude-Code-Installationsdokumentation fuer macOS/Linux/Windows korrigiert |
| v0.5.0 | 2026-04-06 | Phase 3 | Plattformtest-Skripte, Pull-/Push-Stabilisierung, macOS/Windows-Testdokumentation, `master`/`main` zusammengefuehrt |
| v0.5.1 | 2026-04-06 | Phase 3 | README-Nachfuehrung fuer Git-Schritte, Auth, neue Projekte, Auszubildenden-Workflow und Spec-Kit-Init-Links |
| v0.5.2 | 2026-04-06 | Phase 3 | CHANGELOG-Korrekturen und `sync-home`-Dateiliste erweitert |
| v0.5.3 | 2026-04-08 | Phase 4 | Spec-Kit-kompatible Lastenhefte fuer CI/CD, GitLab, Git-Config-Scope und Workspace-Teardown |
| v0.6.0 | 2026-04-11 | Phase 4 | Git-Config-Scope, Workspace-Teardown, GitLab-Support und zugehoerige Spezifikationen |
| v0.6.1 | 2026-04-11 | Phase 4 | Lastenheft-Rename-Pflicht in Templates und Agenten-Dateien, Lastenhefte umbenannt |
| v0.6.2 | 2026-04-11 | Phase 4 | `specify`-CLI statt `npx speckit`, `--`-Sentinel, Help-/grep-Guards, Teardown- und GitLab-Doku |
| v0.7.0 | 2026-04-12 | Phase 5 | Workspace-/Projekt-README-Erstellung, Bootstrap-Project Release Please, Statistik-Ledger, Agenten-Statistikregeln, Constitution v1.4.0 |
| v0.7.1 | 2026-04-12 | Phase 5 | Template-README bereinigt und `STATS.md` aktualisiert |
| v0.8.0 | 2026-04-13 | Maintenance-Rollup | GitLab-Release-Automation, GitLab-Release-Fixes, Release-Guidance fuer Agenten |
| v0.8.1 | 2026-04-15 | Maintenance-Rollup | Level-2-Repos weiter ignoriert, README zu Bootstrap, Migration, Versionierung und Security erweitert |
| v0.8.2 | 2026-04-16 | Maintenance-Rollup | Codex-Status-Fall, Speckit-Beispiele, Accessibility- und Agenten-Guidance erweitert |
| v0.9.0 | 2026-04-18 | Maintenance-Rollup | Lokaler Agent-Audit-Workflow, Microsoft-Foundry-Skills, Migrationsebenen |
| v0.9.1 | 2026-04-23 | Maintenance-Guidance | Constitution v1.5.1 bis v1.7.0, Spec-Kit-Assets, serielle Migrationen, Homogeneity-Stats |
| v0.9.2 | 2026-04-24 | Maintenance-Guidance | Lastenheft fuer agentische Umgebungspruefung, Constitution und Security-Templates aktualisiert |
| v0.10.0 | 2026-04-24 | Maintenance-Guidance | Git-Identity-Setup, Propagate-Security-Guidance, Security-Evidence-Templates, sichere Entwicklung in Constitution |
| v0.10.1 | 2026-04-24 | Maintenance-Guidance | Spec-Kit-Issue-Response-Playbook |
| v0.11.0 | 2026-04-26 | Phase 6 | Sechs Spec-Kit-Governance-Presets, iSAQB-Architektur-Preset, Standalone-Repos, Smoke-Tests, Preset-Pflegeworkflow |

Damit sind alle in `CHANGELOG.md` dokumentierten Release-Staende in der
Statistik entweder einer Hauptphase oder einer Maintenance-Runde zugeordnet.

*All release states documented in `CHANGELOG.md` are now assigned to either a
main phase or a maintenance round in this statistics ledger.*

---

## Gesamtstatistik / Overall Statistics

Basis dieses Schlussblocks sind der aktuelle Repository-Snapshot sowie die
dokumentierten Hauptphasen und Maintenance-Runden aus den Abschnitten oben.

*This closing block is based on the current repository snapshot plus the
documented main phases and maintenance rounds from the sections above.*

| Kennzahl / Metric | Verdichteter Gesamtblick / Condensed Overview |
|---|---:|
| Artefaktbasis gesamt / Total artifact base | `71 527` Zeilen |
| Operativer Code / Operational code (Skripte + Hooks + CI) | `19 172` Zeilen (`26.8 %`) |
| Dokumentationsanteil / Documentation share | `48 564` Zeilen (`67.9 %`) |
| Beobachtbarer Projektzeitraum / Observable project window | `2026-03-31` bis `2026-04-30` |
| Sichtbare Git-Aktivtage / Observable active days | `28` |
| Git-Commits gesamt / Total commits | `309` |
| Git-Commits pro Aktivtag / Commits per active day | `11.0` (`309 / 28`) |
| Zeilen pro Aktivtag / Lines per active day | `2 554.5` (`71 527 / 28`) |
| Zeilen pro Commit / Lines per commit | `231.5` (`71 527 / 309`) |
| Konservative Einzelentwickler-Untergrenze | `894.1` Arbeitstage / `6 973.9` Stunden |
| Thorsten-Solo-Untergrenze (Scripting-Infra, 100 Z./Tag) | `715.3` Arbeitstage / `5 579.1` Stunden |
| Kleines 3er-Team mit Koordinationsaufschlag | `357.6` Arbeitstage |
| Repo-weiter Speedup gg. 80-Zeilen-Referenz | `31.9x` |
| Repo-weiter Speedup gg. Thorsten-Referenz (100 Z./Tag) | `25.5x` |

Kurzfazit:
`home-baseline` bleibt nach der Spec-Kit-0.8.3-Automation dokumentations- und
Governance-getrieben: `67.9 %` der sichtbaren Basis liegen in Markdown-
Artefakten. Der operative Code (Skripte, Hooks, CI) macht `26.8 %` aus. Der
groesste dokumentierte Volumensprung bleibt Phase `1` (Spec-Kit-Batch fuer
Homogeneity Guardian). Die aktuelle Maintenance-Runde ergaenzt robuste
Spec-Kit-Update-Automation ueber Level 0/1/2. Die oeffentliche Vorlage bleibt
jetzt selbsttragend, weil private Repos wie TuiVision nur noch explizite
Template-Overrides sind. OpenCode-Command-Tracking und Governance-Template-Erhalt
bleiben Teil des Workflows. Die
Beschleunigungsfaktoren beschreiben keine Stoppuhrzeit, sondern sichtbare
Lieferdichte gegen konservative manuelle Referenzmodelle.

*Short summary: after the Spec-Kit 0.8.3 automation round, `home-baseline`
remains documentation- and governance-driven: `67.9 %` of the visible base sits
in Markdown artifacts. Operational code (scripts, hooks, CI) accounts for
`26.8 %`. The largest documented volume jump remains Phase `1` (Spec-Kit batch
for Homogeneity Guardian). The current maintenance round adds robust Level 0/1/2
Spec-Kit update automation. The public template is now self-contained because
private repositories such as TuiVision are only explicit template overrides.
OpenCode command tracking and governance-template preservation remain part of
the workflow. The acceleration factors describe visible
delivery density, not stopwatch measurements.*

### ASCII-Diagramme / ASCII Charts

```text
Artefaktmix nach aktuell dokumentiertem Snapshot (Zeilen)
Operativer Code | #############                  | 19 172 | 26.8 %
Dokumentation   | ############################## | 48 564 | 67.9 %
Sonstiges       | ##                             |  3 791 |  5.3 %
```

Dieses Diagramm zeigt, wie der aktuelle Snapshot zwischen operativem Code
(Skripte, Hooks, CI), Dokumentation und sonstigen Artefakten verteilt ist.
Die Preset-Arbeit hat den Dokumentations- und Governance-Anteil sichtbar
erhoeht.

*This chart shows the split between operational code (scripts, hooks, CI),
documentation, and other artifacts in the current snapshot. The preset work
visibly increased the documentation and governance share.*

```text
Phasenvolumen nach dokumentierter Netto-Basis (Insertions)
0 Init    | #                        |    954
1 001+    | ######################## | 26 519
2 pub     | #####                    |  6 168
3 CI+003  | #                        |  1 523
4 005+    | ##########               | 10 769
5 proj    | #                        |    686
6 presets | #######                  |  7 751
```

Dieses Diagramm zeigt den Netto-Insertions-Beitrag der dokumentierten Phasen.
Phase `6` ist nach Phase `4` das groesste sichtbare Paket und besteht vor allem
aus Preset-Templates, README-Dateien, Governance-Regeln und Smoke-Test-Doku.

*This chart shows the net insertion contribution per documented phase. Phase `6`
is the largest visible package after Phase `4` and mainly consists of preset
templates, README files, governance rules, and smoke-test documentation.*

```text
Konservative Handarbeits-Referenz je dokumentierter Phase (Arbeitstage, 80 Z./Tag)
0 Init    | #                        |   11.9 d
1 001+    | ######################## |  331.5 d
2 pub     | ######                   |   77.1 d
3 CI+003  | ##                       |   19.0 d
4 005+    | ##########               |  134.6 d
5 proj    | #                        |    8.6 d
6 presets | #######                  |   96.9 d
```

Jeder Balken zeigt, wie viele Arbeitstage ein erfahrener Einzelentwickler
bei `80` manuell erstellten Zeilen pro Tag fuer das jeweilige Phasenpaket
benoetigt haette. Die Preset-Phase entspricht konservativ knapp `97`
Arbeitstagen sichtbarem Governance-Output.

*Each bar shows how many workdays an experienced solo developer would have needed
at `80` manually created lines per day for the respective phase package. The
preset phase conservatively represents almost `97` workdays of visible
governance output.*

```text
Dokumentierte Beschleunigungsfaktoren (Phasen-Speedup vs. 80-Zeilen-Referenz)
Repo ges. | ################################  | 31.9x
0 Init    | ############                     | 11.9x
1 001+    | >> Spec-Kit-Batch: 331.5x (ausserhalb Skala)
2 pub     | ################################# | 38.6x
3 CI+003  | ######                           |  6.3x
4 005+    | ################################################ | 67.3x
5 proj    | ########                         |  8.6x
6 presets | ################################################ | 48.5x
```

Hier werden keine Stoppuhrzeiten gemessen. Verglichen wird die dokumentierte
Lieferdichte pro Aktivtag gegen die 80-Zeilen-Referenz. Phase `6` ist hoch,
weil sechs Presets, sechs externe Repos und mehrere Smoke-Test-Runden in zwei
sichtbaren Git-Aktivtagen abgeschlossen wurden.

*This chart does not measure stopwatch time. It compares documented delivery
density per active day against the 80-line reference. Phase `6` is high because
six presets, six external repositories, and several smoke-test rounds were
completed in two visible Git active days.*

```text
Vergleich dokumentierter Gesamtaufwand / sichtbares KI-Lieferfenster
Erfahren (80 Z./Tag)   | ######################## | 894.1 d / 6 973.9 h
Thorsten (100 Z./Tag)  | ###################      | 715.3 d / 5 579.1 h
KI sichtbar            | #                        |  28.0 d
```

Dieser Vergleich macht die grobe Groessenordnung sichtbar: Zwischen klassischer
Handarbeit und dem im Repository sichtbaren Lieferfenster liegt eine deutliche
Verdichtung. Genau diese Verdichtung beschreibt das Ledger als
blended repository speedup.

*This comparison makes the scale visible: there is clear compression between
classical manual effort and the delivery window visible in the repository.
That documented compression is what the ledger labels as blended repository
speedup.*

```text
X/Y-Diagramm: Phasenvolumen (X = Phase 0..6, Y = Insertions)
30000 |
25000 |   *
20000 |
15000 |
10000 |               *
 5000 |         *             *
    0 | *           *   *
      +---------------
       0 1 2 3 4 5 6
```

Als zweite Ansicht zeigt diese X/Y-Kurve denselben Verlauf ueber die
Phasenachse. Phase `1` ragt deutlich heraus; Phase `6` bildet den neuen
Governance- und Preset-Nachlauf nach den Sicherheits- und Architekturarbeiten.

*As a second view, this X/Y curve shows the same progression across the phase
axis. Phase `1` stands out clearly; Phase `6` forms the new governance and
preset follow-up after the security and architecture work.*
