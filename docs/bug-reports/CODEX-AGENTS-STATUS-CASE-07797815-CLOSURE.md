# Case 07797815 Closure Report

## Zweck / Purpose

Dieser Bericht fasst den abgeschlossenen OpenAI-Supportfall `07797815` zur `AGENTS.md`-Erkennung in Codex CLI zusammen.

*This report summarizes the closed OpenAI support case `07797815` about `AGENTS.md` detection in Codex CLI.*

## Kurzfassung / Executive Summary

Auf macOS mit case-insensitive Dateisystem zeigte Codex CLI `v0.120.0` bei einem frischen Start in `~/home-baseline-tmp` in `/status` den Eintrag `Agents.md: <none>`, obwohl eine echte Datei `AGENTS.md` im Arbeitsverzeichnis vorhanden war.

*On macOS with a case-insensitive filesystem, Codex CLI `v0.120.0` showed `Agents.md: <none>` in `/status` on a fresh start in `~/home-baseline-tmp`, even though a real `AGENTS.md` file was present in the working directory.*

Durch kontrollierte Tests wurde der Fehler als First-Session-Detection-Bug eingegrenzt. Resume-Sessions konnten einen spaeter "gelernten" korrekten Zustand beibehalten, aber frische Sessions reproduzierten den Fehler.

*Controlled tests narrowed the issue down to a first-session detection bug. Resume sessions could preserve a later "learned" correct state, but fresh sessions reproduced the bug.*

Nach dem Update auf Codex CLI `v0.121.0` war das Problem bei frischem Start nicht mehr reproduzierbar. `/status` zeigte nun korrekt `Agents.md: AGENTS.md`.

*After updating to Codex CLI `v0.121.0`, the issue was no longer reproducible on a fresh start. `/status` then correctly showed `Agents.md: AGENTS.md`.*

## Umfeld / Environment

- Repository: `~/home-baseline-tmp`
- Plattform / Platform: macOS
- Dateisystemverhalten / Filesystem behavior: case-insensitive
- Betroffene Version / Affected version: Codex CLI `v0.120.0`
- Behobene Version / Fixed version: Codex CLI `v0.121.0`
- Support-Fall / Support case: `07797815`

## Problembild / Observed Problem

Im Ausgangszustand galt:

*In the initial state, the following applied:*

- Die Datei `AGENTS.md` existierte bereits vor Start der Codex-Session im Repo.
- `/status` zeigte dennoch `Agents.md: <none>`.
- Die CLI lief auf macOS in einem Verzeichnis mit case-insensitive Namensaufloesung.

*The file `AGENTS.md` already existed before the Codex session started in the repo. `/status` still showed `Agents.md: <none>`. The CLI was running on macOS in a directory with case-insensitive name resolution.*

## Reproduktion / Reproduction Summary

Die Untersuchung bestand aus mehreren Schritten:

*The investigation consisted of several steps:*

1. Anfangszustand dokumentieren: `AGENTS.md` vorhanden, `/status` zeigt `<none>`.
2. Alias-/Symlink-Idee pruefen: auf dem case-insensitive Dateisystem nicht sauber parallel moeglich.
3. Temporaeren Case-Rename testen: `AGENTS.md -> AGENTS.tmp -> Agents.md`.
4. Danach frische und resumierte Sitzungen vergleichen.
5. Rueck-Rename testen: `Agents.md -> Agents.tmp -> AGENTS.md`.
6. Prozessliste auswerten: bisherige "Restarts" waren in Wirklichkeit `codex resume <session-id>`.
7. Echten Fresh-Start ohne laufende Codex-Prozesse testen.
8. Zusaetzlich pruefen, ob das repo-lokale Verzeichnis `.agents/` Einfluss hat.
9. Abschliessend Update auf `v0.121.0` testen.

*The investigation documented the initial state, tested case-only rename behavior, compared resumed versus truly fresh sessions, verified that previous "restarts" were actually `codex resume <session-id>`, checked the effect of removing `.agents/`, and finally re-tested after updating to `v0.121.0`.*

## Zentrale Befunde / Key Findings

- Ein echter frischer Start in `v0.120.0` erzeugte eine neue Session-ID und reproduzierte wieder `Agents.md: <none>`.
- Resume-Sessions konnten nach einem Rename-Zyklus den spaeter korrekt erkannten Zustand beibehalten.
- Das repo-lokale Verzeichnis `.agents/` war nicht die Ursache. Auch ohne `.agents/` zeigte ein frischer Start in `v0.120.0` weiterhin `Agents.md: <none>`.
- Das spricht fuer einen Fehler in der Initial-Erkennung bei neuer Session auf macOS mit case-insensitive Dateisystem, nicht fuer einen allgemeinen Datei- oder Repo-Fehler.

*A true fresh start in `v0.120.0` produced a new session ID and reproduced `Agents.md: <none>`. Resume sessions could preserve the later corrected state after a rename cycle. The repo-local `.agents/` directory was not the cause, because a fresh start without `.agents/` still showed `Agents.md: <none>`. This points to an initial detection bug on new sessions on macOS case-insensitive filesystems, not a general repository or file problem.*

## Workaround / Workaround

Als temporaerer Workaround vor `v0.121.0` funktionierte:

*Before `v0.121.0`, the following temporary workaround worked:*

```bash
cd ~/home-baseline-tmp
git mv AGENTS.md AGENTS.tmp
git mv AGENTS.tmp Agents.md
```

Dann Codex frisch starten, `/status` pruefen und danach wieder zurueckbenennen:

*Then start Codex fresh, check `/status`, and rename back afterward:*

```bash
cd ~/home-baseline-tmp
git mv Agents.md Agents.tmp
git mv Agents.tmp AGENTS.md
```

Resume-Sessions konnten danach den korrigierten Zustand weiter anzeigen.

*Resume sessions could then continue showing the corrected state.*

## Fix-Validierung / Fix Validation

Nach dem Update auf Codex CLI `v0.121.0` ergab ein frischer Start folgenden Status:

*After updating to Codex CLI `v0.121.0`, a fresh start produced the following status:*

```text
OpenAI Codex (v0.121.0)

 Model:                gpt-5.4 (reasoning high, summaries auto)
 Directory:            ~/home-baseline-tmp
 Permissions:          Custom (workspace-write, on-request)
 Agents.md:            AGENTS.md
 Account:              hindermath@googlemail.com (Plus)
 Collaboration mode:   Default
 Session:              019d9809-6a81-7213-be9c-901951337fcb
```

Damit war die vorherige Fehlersituation bei frischem Start nicht mehr reproduzierbar. OpenAI bestaetigte daraufhin, dass der Fall als geloest betrachtet werden kann, solange kein Regress auftritt.

*This means the previous faulty fresh-start behavior was no longer reproducible. OpenAI then confirmed that the case could be treated as resolved unless the issue regresses.*

## Ergebnis / Outcome

- Fallstatus / Case status: abgeschlossen / closed
- Support-Fall / Support case: `07797815`
- Technischer Status / Technical status: in `v0.121.0` offenbar behoben
- Weitere Aktion / Further action: nur bei Regress erneut melden, dann mit neuer Session-ID und denselben Clean-Start-Schritten

## Zugehoerige Dateien / Related Files

- [CODEX-AGENTS-STATUS-BUG-REPORT.md](/Users/thorstenhindermann/home-baseline-tmp/docs/bug-reports/CODEX-AGENTS-STATUS-BUG-REPORT.md)
- [CODEX-AGENTS-STATUS-OUTPUT.md](/Users/thorstenhindermann/home-baseline-tmp/docs/bug-reports/CODEX-AGENTS-STATUS-OUTPUT.md)
- [CODEX-AGENTS-STATUS-REPLY-TO-OPENAI.md](/Users/thorstenhindermann/home-baseline-tmp/docs/bug-reports/CODEX-AGENTS-STATUS-REPLY-TO-OPENAI.md)
