# Feature 032 – Validierungs-/Transaktions-Slice T039–T049

## Ergebnis / Result

Der begrenzte HOME-Slice T039 bis T049 ist abgeschlossen (`11/11`). Bash und
PowerShell 7 validieren dieselbe Negativmatrix `LIE001` bis `LIE012`, alle
sieben akzeptierten Feature-Proof-Zustaende und dieselbe candidate-first
Check-/Write-Transaktion. Feature 032 bleibt mit `49/169` Tasks unvollstaendig;
T050 bis T169 sind offen.

*The bounded HOME slice T039 through T049 is complete (`11/11`). Bash and
PowerShell 7 validate the same `LIE001`–`LIE012` negative matrix, all seven
accepted feature-proof states, and the same candidate-first check/write
transaction. Feature 032 remains incomplete at `49/169`; T050–T169 are open.*

## Nachweise / Evidence

- Reale Red-Laeufe vor Implementierung: Bash 2026-09-09 20:10:43–20:10:44
  UTC, PowerShell 20:11:05–20:11:06 UTC, jeweils Exit 1 wegen fehlender
  oeffentlicher Transaktionsfunktion; die spaetere hostile-Markdown-Assertion
  schlug vor der Escaping-Korrektur ebenfalls real fehl.
- Finaler Bash-Vertrag: 2026-09-09 21:22:47–21:24:01 UTC, Exit 0. Finaler
  PowerShell-Vertrag: 21:24:08–21:24:14 UTC, Exit 0. Ein zusaetzlicher realer
  Bash-Red-Lauf 21:21:19–21:22:32 UTC belegte zuvor den Verlust reiner
  CR-Zeilengrenzen in manuellen Prefix-/Suffix-Abschnitten.
- Beide Implementierungen: erster isolierter Multi-Output-Write `2`, zweiter
  unveraenderter Write `0`; Before/Candidate/After-Hashes identisch und beide
  `git diff --no-index --exit-code`-Pruefungen Exit 0.
- Oeffentlicher Bash-Fault-Probe `after-first-replace`: Exit 10/`LIE010`, beide
  Alt-Ausgaben vollstaendig wiederhergestellt, null Mixed State und null
  renderer-eigene Tempdateien. Der PowerShell-Vertrag prueft dieselben
  Rollback-Invarianten. Kanonischer Input-/Output-Overlap endet mit `LIE006`,
  null Writes und unveraenderter Eingabe. Manuelle Prefix-/Suffix-Inhalte
  bleiben bei CRLF-, CR- und LF-Normalisierung als getrennte LF-Zeilen erhalten.
- Home-Safe-Mode mit explizitem Repository und Manifest: Bash und PowerShell
  `Current, writes=0`. `git diff --check` ist gruen; nichts ist staged.
- PSScriptAnalyzer 1.25.0: 107 Dateien, null Error-/Warning-Befunde.
- Maschinenlesbare Evidence: `idempotence.json`, `parity-macos.json`,
  `tdd-red-us2.json` und `rollback/home-baseline-renderer.json` unter dem
  akzeptierten ignorierten Evidence-Root.

*Both final suites pass against real public implementations. The unchanged
second writes are byte-identical and write zero files; source/containment
rechecks fail before publication; simulated partial publication fully rolls
back both outputs and cleans all owned temporary files.*

## Vertrag, Dokumentation und Grenzen / Contract, documentation, and limits

Der finale Level-0-Vertrag ist
`3b106af318f90243ebe096dd4a9387b02d4185c8913078cce5a820448907e722`.
Er bindet 11 Quellen, acht Gate-Evidence-Dateien und alle acht akzeptierten
Artefakte; 28 Member und die Negativ-Fixturekopie wurden erneut validiert. Die
acht akzeptierten Artefakte blieben bytegleich. Der Parent bleibt alleiniger
Owner von `autonomous-run-state.json`; diese Phase hat ihn nicht geschrieben.

Documentation Impact ist `GeneratedUpdate`: Skripte sind `homeRuntime`,
Featurebericht/Evidence/Statistikquelle `sourceOnly`. Statistik-Slot 80 bindet
1.750 Nettozeilen. Der vorgeschriebene Check-only-Renderer meldet wegen des
akzeptierten Dirty-Feature-Worktrees erwartbar `DRIFT`, Exit 1; sein Clean-Gate
wurde nicht umgangen. Kein Home-Sync, Downstream-Write, Staging, Commit, Push,
PR, Merge, Remote-Write, Preset-Install oder Subagent wurde ausgefuehrt.

*The final Level-0 contract binds 11 sources, eight gate-evidence files, and
all eight byte-identical accepted artifacts. Documentation is generated from
its canonical source, with statistics rendering intentionally left behind its
clean-worktree gate. No delivery or downstream action occurred.*

## Verbleibende Blocker / Remaining blockers

- T050–T169 (`120` Tasks), einschliesslich nativer Linux-/Windows-Evidence,
  Downstream-Adoptionen, Delivery, Home-Sync und Retrospektive, bleiben offen.
- Die gemeinsame Schnittstelle erkennt sowohl `requirements/intakes/series/`
  als auch `specs/intake-series/`. Das aktuelle lokale AOC-Manifest wird bei
  direkter Vollvalidierung jedoch fail-closed mit `LIE004` abgelehnt, weil es
  historische logische Intakepfade nennt, deren aktuelle Dateien
  featuregestempelt/archiviert sind (META-LH-03 besitzt zusaetzlich einen
  neueren Lifecycle-Hash). Die frische AOC-Basis-/Quellinventur und
  repositorylokale Aufloesung gehoeren zu T079/T080; diese HOME-Phase hat weder
  AOC-Daten noch den akzeptierten Vertrag umgedeutet.
- PowerShell-Paritaet ist auf macOS belegt. Der native Windows-Nachweis bleibt
  das spaetere Gate T071.

*The remaining 120 tasks start at T050. Current AOC data requires its later
T079/T080 preflight and repository-local lifecycle resolution; the HOME
validator correctly performed no write. Native Windows proof remains T071.*
