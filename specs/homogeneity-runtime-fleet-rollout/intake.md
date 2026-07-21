# Homogeneity Runtime Fleet Rollout

## Ziel / Goal

Das gemergte Home-Baseline-Homogeneity-Paket aus Commit `1a400192e8d504bb322a558aca815bee6585c39d`
wird in alle registrierten Level-1- und Level-2-Repositories uebertragen. Jeder
Wrapper muss sein vollstaendiges `hg-*`-Hilfspaket laden oder vor dem Scan mit
Exitcode 2 abbrechen.

*Propagate the merged Home Baseline Homogeneity package from commit
`1a400192e8d504bb322a558aca815bee6585c39d` to every registered level-1 and
level-2 repository. Each wrapper must load its complete `hg-*` helper package
or stop before scanning with exit code 2.*

## Zielgruppe / Audience

Maintainer, Lernende und autonome Agenten, die lokale oder CI-basierte
Homogeneity-Nachweise ausfuehren.

*Maintainers, learners, and autonomous agents that run local or CI-based
Homogeneity evidence.*

## Verbindlicher Umfang / Binding Scope

- Genau zwei Wrapper und 21 Bibliotheken aus
  `scripts/config/homogeneity-runtime-files.json` werden bytegleich verteilt.
- Jeder Worker verwendet seinen im Campaign-Manifest gepinnten `main`-Commit.
- Vorhandene Homogeneity-Workflows muessen den Bash-Wrapper auf Linux/macOS und
  den PowerShell-Wrapper auf Windows mit explizitem Repository-Root aufrufen.
- Der Rollout verwendet hoechstens drei gleichzeitige Worker.
- Jeder geaenderte Worker wird ueber einen nicht leeren PR geliefert, validiert,
  gemergt und lokal auf einen sauberen synchronen `main` gebracht.

*Exactly two wrappers and 21 libraries from the bounded manifest are
distributed byte-for-byte. Existing workflows must call Bash on Linux/macOS
and PowerShell on Windows with an explicit repository root. The rollout uses
at most three concurrent workers, and every changed worker is delivered
through a validated non-empty pull request before local main synchronization.*

## Nicht im Umfang / Out of Scope

- Keine Produkt-, Runtime-, API-, Dependency-, Preset- oder Lerninhaltsaenderung.
- Keine automatische Behebung fachlicher Homogeneity-Findings.
- Keine Uebernahme anderer driftender Wartungsdateien aus dem allgemeinen
  Verteilungsmanifest.
- Kein Admin-Bypass fuer technische Fehler oder offene Review-Threads.

*No product, runtime, API, dependency, preset, or learning-content changes. Do
not remediate unrelated Homogeneity findings or propagate other maintenance
drift. Technical failures and actionable review threads never permit bypass.*

## Abnahme / Acceptance

1. Das unvollstaendige Testpaket liefert in Bash und PowerShell Exitcode 2.
2. Alle 23 Runtime-Pfade entsprechen nach dem Merge bytegleich Home Baseline.
3. Kein Wrapper meldet `command not found`, `CommandNotFoundException` oder
   einen verdeckten ErrorRecord.
4. Jeder vorhandene Homogeneity-Workflow fuehrt einen echten Wrapper aus.
5. Alle technischen Pflichtchecks und umsetzbaren Reviews sind abgeschlossen.
6. Alle 31 Repositories enden sauber auf `main` mit `HEAD == origin/main`.

*The incomplete fixture returns exit code 2 in both shells, all 23 runtime
paths match Home Baseline byte-for-byte, workflows execute a real wrapper, all
technical and actionable review gates close, and all 31 repositories finish on
clean synchronized main branches.*

## Berechtigung und Stop-Grenzen / Authority and Stop Boundaries

`MergeAndSync` ist fuer diese begrenzte Fleet-Kampagne autorisiert. Ein enger
Admin-Bypass ist nur zulaessig, wenn alle technischen Gates gruen, null
umsetzbare Threads offen und Human Approval die einzige Regel ist. Ein
unsauberer Worker, Pin-Drift, technischer Fehler oder fachlicher
Homogeneity-Fund stoppt nur den betroffenen Worker und wird separat berichtet.

*`MergeAndSync` is authorized for this bounded fleet campaign. A narrow admin
bypass is allowed only when every technical gate is green, no actionable
thread remains, and Human Approval is the sole rule. Dirty state, pin drift,
technical failure, or a substantive Homogeneity finding stops the affected
worker and is reported separately.*
