# Wartungspaket: Teilreparatur / Maintenance package: partial repair

## Deutsch

Status: lokale Reparatur und Flottenverteilung abgeschlossen; Remote-Closeout offen.
Owner: Home-Baseline-Maintainer. Fortschreibung: 2026-09-20.

Documentation Impact: UpdateRequired. Quelle ist das Paketmanifest
`scripts/config/agentic-toolchain-maintenance-files.json`; Bedienungsdokument
ist `docs/man/propagate-agentic-toolchain-maintenance.1.md`. Dieser Nachweis
richtet sich an Maintainer, ist Source-only und benötigt keinen Home-Sync.
Deutsch und Englisch stehen in derselben textorientierten Datei.

Der verteilte Profilkatalog bietet die optionale Statistik-Preset-Matrix an,
aber das Paket enthielt sie nicht. Der Manifesteintrag ist ergänzt; die
Profilwahl und installierte Presets bleiben unverändert. Die beiden
TuiVision-Ausnahmen bleiben erhalten. Ein neuer Regressionstest prüft alle
angebotenen Matrizen. Er schlug vor der Korrektur erwartungsgemäß fehl.
Danach bestanden dieser Test und die beiden bestehenden Propagationstests
für nicht registrierte Ziele und exakt begrenzte Ausnahmen (3 Tests, macOS).
Alle 151 Manifestdateien existieren; `git diff --check` ist erfolgreich.

Stage B bleibt gemäß freigegebener Paketgrenze zentral: Bash- und
PowerShell-Wrapper verwenden den gemeinsamen Level-0-Quellresolver für Engine
und Repository-Root. Angenommene Vertragsschemata aus
`specs/030-stage-b-rollout/contracts` bleiben in Level 0. Fehlende Quelle oder
Engine führt zum Abbruch ohne lokalen Ersatz. Normale Wartung, CI-Gate und
Stage-B-Autoritätsbarrieren bleiben unverändert. Bedienungsquelle ist außerdem
`docs/man/maintain-agentic-workspace.1.md` samt PowerShell-Hilfe; diese ist aus
der bestehenden Stage-B-Navigation erreichbar. Wrapper sind homeRuntime und
benötigen erst bei der gesonderten Auslieferung einen geprüften Home-Sync.
Die Regressionstests verwenden Projektkopien ohne Engine und Spezifikationen
sowie unvollständige Quellcheckouts in beiden Shells. Die reale Flottenfreigabe
und vollständige Paketverifikation bleiben separate nächste Schritte.

Validierung: Alle 98 Stage-B-Tests bestanden auf macOS mit Bash und PowerShell.
Der ergänzte Negativfall für eine vollständig fehlende Quelle bestand danach
ebenfalls in beiden Shells. `bash -n` und `git diff --check` bestanden.

Fortschreibung: 129 Stage-B-/Wartungstests auf macOS bestanden. Die Quelle
wurde auf dem Reparaturbranch veröffentlicht und die Home-Runtime geprüft
synchronisiert. 14 normale Ziele erhielten 267 Dateikopien, anschließend
21 Secure-Trader-Ziele im Container weitere 404. Alle 35 Paketprüfungen
bestanden; die zwei TuiVision-Ausnahmen blieben erhalten.

Die Podman-VM bleibt nach Start über eine unabhängige Terminal-Sitzung
erreichbar. Ein beschädigter Container wurde nach Datensicherung ersetzt;
Image, sechs Volumes und Mounts blieben erhalten. Die begrenzte menschliche
Owner-Freigabe für Secure-Trader-Wartung gilt bis 31.12.2026. Die getrennte
CISO-/ISB-/KIB-Rollenfreigabe wurde nicht als abgeschlossen dargestellt.
63 Paritätstests in den Secure-Trader-Zielen und 36 zusätzliche Linux-/TUI-
Wrapper-Tests bestanden. Vier normale Ziele erhielten eine OpenCode-
Pfadmigration (159 Befehle, zwölf Paritätstests); im OrderDesk-Workspace
wurden elf fehlende Befehle unter Erhalt bestehender Inhalte verschoben.
Zieländerungen sind noch nicht remote geliefert. Dies ist kein vollständiger
Produktbuild- oder Remote-CI-Nachweis.

Nächste Schritte: Änderungen und Nachweise reviewen, zielgenau committen,
pushen, PR-Gates prüfen und nach erfolgreichem Merge synchronisieren. NIST SSDF und
CWE Top 25 gelten für Abhängigkeitsvollständigkeit und sichere Verteilung;
dieser Teilnachweis ist keine Sicherheits- oder Sandbox-Abnahme.

## English

Status: local repair and fleet distribution complete; remote closeout pending. Owner: Home Baseline
maintainer. Documentation Impact: UpdateRequired, implemented in the manifest
and propagation manual. This source-only, text-first maintainer record does
not require Home sync.

The profile catalog advertised the optional statistics matrix without shipping
it. The manifest now includes it without changing profile selections or
installed presets. Both TuiVision exceptions remain intact. The new test for
all advertised matrices failed before the fix and passed afterwards, together
with the existing unregistered-target and exact-exception propagation tests
(3 tests on macOS). All 151 manifest files exist; whitespace validation passed.

The approved Stage-B boundary is central-only: both wrappers use the shared
Level-0 source resolver for the engine and repository root. Accepted schemas
stay in Level 0. Missing source or engine stops execution without a local
fallback. Ordinary maintenance, CI gate and authority barriers are unchanged.
The maintenance manual and PowerShell help document this through the existing
Stage-B reader path. Wrappers are homeRuntime and require checked Home sync
only at separate delivery. Regression tests cover project copies without an
engine or specifications and incomplete sources in both shells. Fleet approval
and complete package verification remain separate next steps.

Validation: all 98 Stage-B tests passed on macOS with Bash and PowerShell.
The subsequently added completely missing-source negative case also passed
in both shells. `bash -n` and `git diff --check` passed.

Update of 2026-09-20: 129 macOS maintenance/Stage-B tests passed. The source
branch was pushed and Home runtime synchronized. Fourteen normal targets
received 267 file copies; 21 Secure Trader targets received 404 inside the
container. All 35 package checks passed, preserving both TuiVision exceptions.
The VM persists after independent Terminal startup. The damaged container was
replaced after backup, preserving image, six volumes and mounts. The owner's
bounded maintenance approval expires on 2026-12-31; separate formal role
approval remains open. All 63 Secure Trader parity tests and 36 additional
Linux/TUI wrapper tests passed. Four normal targets migrated 159 OpenCode
commands with twelve passing parity tests; OrderDesk moved eleven missing
commands while preserving existing content. Target changes remain unpublished;
full product builds and remote CI acceptance are not claimed. Next: review,
commit, push, check PR gates, merge and synchronize eligible deliveries.
NIST SSDF/CWE Top 25 inform dependency integrity and safe distribution; this
record is not security or sandbox acceptance.
