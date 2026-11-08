# Spec-Kit-Preset-Sicherheitsrollout 2026-11-08

## Geltungsbereich

DE: Sieben Presets mit behobenen Sicherheitsbefunden werden als Patch-Versionen
veröffentlicht und anschließend im Level-0-Repository sowie in TinyCalc,
absdd-image-sandbox und Show-CommandTui400 installiert. Die übrigen sieben
Presets der 14er-Matrix behalten ihre veröffentlichten Versionen.

EN: Seven presets containing security fixes are published as patch releases
and installed in Level 0 and the three named pilots. The other seven presets
in the fourteen-preset matrix retain their published versions.

| Preset | Version |
| --- | --- |
| autonomous-run-governance | v0.4.11 |
| intake-authoring-governance | v0.3.12 |
| intake-review-governance | v0.2.8 |
| intake-sequencing-governance | v0.2.12 |
| model-routing-governance | v0.2.7 |
| parallel-autonomous-run-governance | v0.2.12 |
| secure-development-assurance-governance | v0.1.9 |

DE: Intake Authoring v0.3.12 erhält gültige Receipts aus 0.3.10/0.3.11
und gebundene historische Lernpaket-Proposals. Pfad-, Hash-, Receipt-,
Operations- und Freigabeprüfungen bleiben verpflichtend.
EN: Intake Authoring v0.3.12 preserves valid 0.3.10/0.3.11 receipts
and bound historical learning-package proposals. Path, hash, receipt,
operation and approval checks remain mandatory.

## Nachweis und Bedienung

DE: Die Preset-Repositories sind die kanonischen Paketquellen; Manifestversion,
GitHub-Tag und Release-Archiv müssen übereinstimmen. Die acht Matrizen unter
[scripts/config](../../scripts/config/) sind die Installationsvorgabe. Der Lauf
nutzt das vierzehnteilige Project-Statistics-Profil. Vor dem Schreiben werden
Syntax, Check-Modus und Vorschau geprüft. Nach dem Schreiben bestätigt der
Check-Modus die exakte Matrix. Der Home-Sync verteilt die manifestgebundene
Runtime; Preset-Paketquellen und Evidence bleiben im Quellklon.

EN: Preset repositories are the canonical package sources. Manifest version,
GitHub tag and release archive must match. The eight matrices under
[scripts/config](../../scripts/config/) define installation. The installation
uses the fourteen-preset project statistics profile. Syntax, check mode and
preview precede writes; check mode confirms the exact installed matrix
afterward. Home sync distributes manifest-bound runtime; preset sources and
evidence remain in the source clone.

## Installationsprüfung / Installation verification

DE: Die sieben neuen Tag-Archive wurden heruntergeladen, auf ihre
Manifestversion geprüft und mit SHA-256 gehasht. Die 14er-Matrix wurde in
Level-0, TinyCalc, absdd-image-sandbox und Show-CommandTui400 installiert.
Der exakte Matrix-Check bestand in allen vier Repositories. Der Installer
änderte außerdem Agenten-Registrierungen außerhalb der Preset-Pakete.
Diese unbeabsichtigte Registrierungsdrift wurde auf den vorherigen
Repository-Stand zurückgesetzt; die aktualisierten Preset-Inhalte unter
.specify/presets bleiben erhalten. Im ABS-DD-Piloten wurde ein einzelner
Download-Timeout durch gezielte Fortsetzung behoben. Drei zuvor vorhandene
nicht versionierte Dateien dort blieben unangetastet.

EN: All seven new tag archives were downloaded, checked against their
manifest version and hashed with SHA-256. The fourteen-preset matrix was
installed in all four repositories and the exact-matrix check passed in each.
Installer-induced agent registration drift outside preset packages was
restored to the previous repository state; updated preset contents remain
under .specify/presets. A single download timeout in the ABS-DD pilot was
resolved by resuming the missing package. Three pre-existing untracked
files there were left untouched.

DE: Die Root-Runtime von Model Routing wurde in allen vier Repositories
bytegleich zum installierten Release nachgezogen; der Paritätstest bestand
jeweils 48 Prüfungen. Parallel v0.2.12 enthält einen Verbose-Hinweis für
eine bereits tolerierte Prozessbeendigungs-Race-Condition und verwendet
keine automatische PowerShell-Variable als lokalen Profilnamen. Der
Steuerungsablauf bleibt gleich.
Die Source- und Installed-Locks binden alle sieben aktuellen Tags und
die tatsächlich installierten Dateien.

EN: The Model Routing root runtime was aligned byte for byte with the
installed release in all four repositories; each parity test passed 48
assertions. Parallel v0.2.12 adds a Verbose diagnostic for an already
tolerated process-exit race and avoids using an automatic PowerShell
variable as a local profile name. Control flow is unchanged. Source and
installed locks bind all seven current tags and
actual installed files.

| Tag-Archiv / Tag archive | SHA-256 |
| --- | --- |
| autonomous-run-governance v0.4.11 | 07889029fe3fc53d175fd8c4d9460227ebd64efc7c62ceb51a911f755369b05e |
| intake-authoring-governance v0.3.12 | 109aaa5f2014209695ef9ee3aa4529dfd8be6ea107f077249242ccf5a951bb81 |
| intake-review-governance v0.2.8 | ddc36c0608fcf4399d81e8a6dc8de7efc026536319b310827e9f57f7fc73acf2 |
| intake-sequencing-governance v0.2.12 | 794bd7257d442eb4958f407d7118b7f49be9492aadc3a8edd911667e6a563ab7 |
| model-routing-governance v0.2.7 | 921f95dfae41d0007faf6a2417917a7dcdfca046b085e2c0febd88844559be16 |
| parallel-autonomous-run-governance v0.2.12 | 1fbd9ec88e282f412b25cce3401ae150bfb373662b7ed07ee9630a560670c030 |
| secure-development-assurance-governance v0.1.9 | 0d7ffd14f9e1bd02f66251d30e6b5003fc57077c6c90b4c6c3e84436f83cdc55 |

## Dokumentationsauswirkung

UpdateRequired. Kanonische Quelle und Owner: Level-0-Versionmatrix und
Thorsten Hindermann. Zielgruppen: Betreiber der Level-0-Quelle und der drei
Piloten. Leserpfad: Matrix, Preset-Release und dieser Rollout-Nachweis.
Dokumentklasse: versionierte Betriebs- und Sicherheits-Evidence, DE zuerst und
EN danach. Plattformnachweis: macOS-Lauf und CI der Preset-Repositories.
Distributionsklasse: homeRuntime für die Matrizen; installierte Preset-Kopien
werden separat versioniert. Re-Evaluation: nach Security Diff Scan und bei
jedem erneuten Preset-Release.
