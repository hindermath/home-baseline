# Wartungspaket: Teilreparatur / Maintenance package: partial repair

## Deutsch

Status: Teilreparatur, Flottenverteilung noch nicht ausgeführt.
Owner: Home-Baseline-Maintainer. Datum: 2026-09-19.

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

Sandbox: statische Compose-Prüfung bestanden. Die vorhandene Podman-Maschine
wurde gestartet; beim zweiten Versuch bestanden auch `podman info` und
`podman compose up -d --no-build`. Nach Rückkehr des Aufrufs war der Socket
erneut nicht erreichbar. Laufende Mounts konnten somit nicht abschließend
verifiziert werden. Die Sandbox-Freigabedokumentation steht weiterhin auf
Entwurf; ihre menschliche Freigabe wurde nicht vom Agenten ersetzt.
Keine Secure-Trader-Projektdateien verändert. Keine Mounts erweitert,
Volumes gelöscht, Commits oder Pushes ausgeführt.

Nächste Schritte: Podman-Lebenszyklus und
Sandbox-Freigabe klären; danach geprüfte Propagation mit unveränderten
Projektausnahmen und abschließender Verifikation durchführen. NIST SSDF und
CWE Top 25 gelten für Abhängigkeitsvollständigkeit und sichere Verteilung;
dieser Teilnachweis ist keine Sicherheits- oder Sandbox-Abnahme.

## English

Status: partial repair; fleet distribution has not run. Owner: Home Baseline
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

Static Compose validation passed. Podman startup was attempted; the second
attempt also passed `podman info` and `podman compose up -d --no-build`.
The socket became unreachable again after the command returned, so live mounts
could not be fully verified. Formal sandbox approval remains a draft and was
not fabricated. No Secure Trader files changed; no new mounts, volume deletion,
commits or pushes. Next: resolve Podman lifecycle and human
sandbox approval, then perform verified propagation preserving exceptions.
NIST SSDF/CWE Top 25 inform dependency integrity and safe distribution; this
record is not security or sandbox acceptance.
