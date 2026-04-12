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

---

## Gesamtstand des Repositories / Repository Snapshot

Stand / As of: **2026-04-12**

| Kategorie / Category | Dateien / Files | Zeilen / Lines | Anteil / Share |
|---|---:|---:|---:|
| Skripte / Scripts (`.sh` + `.ps1`) | 52 | 8 671 | 20.7 % |
| Templates (`.tmpl` + Konfigurationsdateien) | 14 | 851 | 2.0 % |
| Hooks + CI (pre-push + YAML/JSON) | 4 | 186 | 0.4 % |
| Dokumentation / Documentation (`.md`) | 190 | 32 261 | 76.9 % |
| **Gesamt / Total** | **260** | **41 969** | **100 %** |

### Aufgliederung Dokumentation / Documentation Breakdown

| Untertyp / Subtype | Zeilen / Lines | Anteil an Doku / Share of Docs |
|---|---:|---:|
| Spec-Kit-Artefakte (`specs/`) | 9 781 | 30.3 % |
| Lastenhefte (`Lastenheft*.md`) | 3 554 | 11.0 % |
| Governance (AGENTS / CLAUDE / GEMINI / constitution) | 841 | 2.6 % |
| README / CHANGELOG / STATS | 2 099 | 6.5 % |
| Sonstiges (Templates, andere `.md`) | 15 986 | 49.6 % |

---

## Phasen und Haupt-Branches / Phases and Main Branches

Die Spalte „Insertions" gibt den dokumentierten Netto-Beitrag der Phase an
(Zeilen eingefügt, ohne nachträgliche Löschungen in späteren Phasen abzuziehen).

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

**Hinweis zu Phase 1:** Der hohe Insertions-Wert (26 519 Zeilen an einem Aktivtag)
entsteht durch die Spec-Kit-Batch-Generierung: Spec-Kit erstellt `spec.md`,
`plan.md`, `tasks.md`, `checklist.md` und zugehörige Artefakte in einem einzigen
orchestrierten Lauf. Das ist kein manueller Tippaufwand, sondern der dokumentierte
Output agentischer KI-Unterstützung — genau das, was das Speedup-Modell abbildet.

*Note on Phase 1: The high insertion count (26 519 lines in one active day) results
from Spec-Kit batch generation: Spec-Kit produces spec.md, plan.md, tasks.md,
checklist.md and related artifacts in a single orchestrated run. This is not
manual typing effort but documented output of agentic AI support — precisely what
the speedup model captures.*

---

## Gesamtstatistik / Overall Statistics

Basis dieses Schlussblocks sind die aktuell dokumentierten Snapshot- und
Phasenwerte aus den Abschnitten oben.

*This closing block is based on the currently documented snapshot and phase values
from the sections above.*

| Kennzahl / Metric | Verdichteter Gesamtblick / Condensed Overview |
|---|---:|
| Artefaktbasis gesamt / Total artifact base | `41 969` Zeilen |
| Operativer Code / Operational code (Skripte + Hooks + CI) | `9 708` Zeilen (`23.1 %`) |
| Dokumentationsanteil / Documentation share | `32 261` Zeilen (`76.9 %`) |
| Beobachtbarer Projektzeitraum / Observable project window | `2026-03-31` bis `2026-04-12` |
| Sichtbare Git-Aktivtage / Observable active days | `11` |
| Git-Commits gesamt / Total commits | `216` |
| Git-Commits pro Aktivtag / Commits per active day | `19.6` (`216 / 11`) |
| Zeilen pro Aktivtag / Lines per active day | `3 815.4` (`41 969 / 11`) |
| Zeilen pro Commit / Lines per commit | `194.3` (`41 969 / 216`) |
| Konservative Einzelentwickler-Untergrenze | `524.6` Arbeitstage / `4 091.9` Stunden |
| Thorsten-Solo-Untergrenze (Scripting-Infra, 100 Z./Tag) | `419.7` Arbeitstage / `3 273.7` Stunden |
| Kleines 3er-Team mit Koordinationsaufschlag | `209.8` Arbeitstage |
| Repo-weiter Speedup gg. 80-Zeilen-Referenz | `47.7x` |
| Repo-weiter Speedup gg. Thorsten-Referenz (100 Z./Tag) | `38.2x` |

Kurzfazit:
`home-baseline` ist ein stark dokumentations- und Governance-getriebenes
Infrastruktur-Repository: `76.9 %` der sichtbaren Basis liegen in Markdown-
Artefakten (Specs, Lastenhefte, Governance, README). Der operative Code
(Skripte, Hooks, CI) macht `23.1 %` aus. Der groesste dokumentierte
Volumensprung liegt in Phase `1` (Spec-Kit-Batch fuer Homogeneity Guardian);
die hoechste manuelle Referenzlast entsteht in Phasen `1` und `4` (Teardown +
GitLab). Die Beschleunigungsfaktoren beschreiben keine Stoppuhrzeit, sondern
die sichtbare Lieferdichte gegen konservative manuelle Referenzmodelle.

*Short summary: `home-baseline` is a strongly documentation- and governance-driven
infrastructure repository: `76.9 %` of the visible base sits in Markdown artifacts
(specs, Lastenhefte, governance, README). Operational code (scripts, hooks, CI)
accounts for `23.1 %`. The largest documented volume jump is in Phase `1`
(Spec-Kit batch for Homogeneity Guardian); the highest manual reference load
arises in Phases `1` and `4` (Teardown + GitLab). The acceleration factors
describe visible delivery density, not stopwatch measurements.*

### ASCII-Diagramme / ASCII Charts

```text
Artefaktmix nach aktuell dokumentiertem Snapshot (Zeilen)
Operativer Code | #######                        |  9 708 | 23.1 %
Dokumentation   | ############################### | 32 261 | 76.9 %
```

Dieses Diagramm zeigt, wie der aktuelle Snapshot zwischen operativem Code
(Skripte, Hooks, CI) und Dokumentation verteilt ist. `home-baseline` ist
bewusst dokumentationslastig: Specs, Governance-Dateien und Lastenhefte
wachsen parallel zum operativen Code.

*This chart shows the split between operational code (scripts, hooks, CI) and
documentation in the current snapshot. `home-baseline` is intentionally
documentation-heavy: specs, governance files, and Lastenhefte grow in parallel
with the operational code.*

```text
Phasenvolumen nach dokumentierter Netto-Basis (Insertions)
0 Init   | #                        |    954
1 001+   | ######################## | 26 519
2 pub    | #####                    |  6 168
3 CI+003 | #                        |  1 523
4 005+   | ##########               | 10 769
5 proj   | #                        |    686
```

Dieses Diagramm zeigt den Netto-Insertions-Beitrag der dokumentierten Phasen.
Phase `1` dominiert durch Spec-Kit-Batch-Generierung. Phase `4` (Teardown +
GitLab) ist das naechstgroesste Paket durch neue Skripte und Spezifikationen.

*This chart shows the net insertion contribution per documented phase. Phase `1`
dominates due to Spec-Kit batch generation. Phase `4` (Teardown + GitLab) is
the next largest package due to new scripts and specifications.*

```text
Konservative Handarbeits-Referenz je dokumentierter Phase (Arbeitstage, 80 Z./Tag)
0 Init   | #                        |   11.9 d
1 001+   | ######################## |  331.5 d
2 pub    | ######                   |   77.1 d
3 CI+003 | ##                       |   19.0 d
4 005+   | ##########               |  134.6 d
5 proj   | #                        |    8.6 d
```

Jeder Balken zeigt, wie viele Arbeitstage ein erfahrener Einzelentwickler
bei `80` manuell erstellten Zeilen pro Tag fuer das jeweilige Phasenpaket
benoetigt haette. Lange Balken bedeuten grosses sichtbares Liefervolumen.

*Each bar shows how many workdays an experienced solo developer would have needed
at `80` manually created lines per day for the respective phase package. Longer
bars mean larger visible delivery volume.*

```text
Dokumentierte Beschleunigungsfaktoren (Phasen-Speedup vs. 80-Zeilen-Referenz)
Repo ges.| ############################################ | 47.7x
0 Init   | ############ | 11.9x
1 001+   | >> Spec-Kit-Batch: 331.5x (ausserhalb Skala)
2 pub    | ####################################### | 38.6x
3 CI+003 | ####### | 6.3x
4 005+   | ################################################ | 67.3x
5 proj   | ######### | 8.6x
```

Hier werden keine Stoppuhrzeiten gemessen. Verglichen wird die dokumentierte
Lieferdichte pro Aktivtag gegen die 80-Zeilen-Referenz. Phase `1` liegt weit
ausserhalb der Skala, weil Spec-Kit an einem einzigen Tag ein vollstaendiges
Artefaktpaket generiert hat. Phase `3` (CI-Fixes) zeigt den niedrigsten Wert —
viele kleine Korrekturen erzeugen wenig Netto-Zeilen pro Aktivtag.

*This chart does not measure stopwatch time. It compares documented delivery
density per active day against the 80-line reference. Phase `1` is far off the
scale because Spec-Kit generated a complete artifact package in a single day.
Phase `3` (CI fixes) shows the lowest value — many small corrections produce
few net lines per active day.*

```text
Vergleich dokumentierter Gesamtaufwand / sichtbares KI-Lieferfenster
Erfahren (80 Z./Tag)   | ######################## | 524.6 d / 4 091.9 h
Thorsten (100 Z./Tag)  | ###################### | 419.7 d / 3 273.7 h
KI sichtbar            | #                        |  11.0 d
```

Dieser Vergleich macht die grobe Groessenordnung sichtbar: Zwischen klassischer
Handarbeit und dem im Repository sichtbaren Lieferfenster liegt eine deutliche
Verdichtung. Genau diese Verdichtung beschreibt das Ledger als
blended repository speedup.

*This comparison makes the scale visible: there is clear compression between
classical manual effort and the delivery window visible in the repository.
That documented compression is what the ledger labels as blended repository speedup.*

```text
X/Y-Diagramm: Phasenvolumen (X = Phase 0..5, Y = Insertions)
30000 |
25000 |   *
20000 |
15000 |
10000 |               *
 5000 |         *
    0 | *           *   *
      +-------------
       0 1 2 3 4 5
```

Als zweite Ansicht zeigt diese X/Y-Kurve denselben Verlauf ueber die
Phasenachse. Phase `1` ragt deutlich heraus; der Abfall zu Phase `3` (CI-Fixes)
und Phase `5` (Bootstrap-Erweiterungen) ist gut sichtbar.

*As a second view, this X/Y curve shows the same progression across the phase
axis. Phase `1` stands out clearly; the drop to Phase `3` (CI fixes) and
Phase `5` (bootstrap enhancements) is well visible.*
