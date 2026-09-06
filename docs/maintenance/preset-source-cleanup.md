# Preset-Quellenbereinigung / Preset Source Cleanup

Stand / Date: 2026-09-06. Owner: Thorsten Hindermann.

## Verbindlicher Stand / Binding State

Die 13 veroeffentlichten GitHub-Preset-Repositories sind die alleinigen
Produktquellen. Die [Quellenuebersicht](../../specs/spec-kit-presets/README.md)
bindet die verifizierten Tags; die [Quellenbindung](preset-source-lock.json)
enthaelt Commit und ZIP-SHA-256. Sie ist kein Installationsprofil.
Weiterentwicklung erfolgt in den eigenstaendigen Preset-Git-Repositories.

The 13 published GitHub preset repositories are the sole product sources.
The source index links verified tags; the source lock records commits and
archive hashes. It is not an installation profile. Develop changes in the
standalone preset Git repositories.

Die zwoelf ausgerollten Presets sowie vorhandene Installationen des 13. Presets
bleiben unveraendert. Weitere Verteilung des 13. Presets, Home-Sync und
Flotten-Rollout sind nicht Teil dieser Bereinigung. Profilzuordnungen und
Prioritaeten bleiben erhalten. C5-bezogene Entwicklungs-Evidence ersetzt
weder eine vollstaendige C5-Pruefung noch ein Testat oder menschliche Freigaben.

The twelve deployed presets and existing installations of preset 13 remain
unchanged. Further distribution of preset 13, Home sync, and fleet rollout are
outside this cleanup. Profile assignments and priorities remain unchanged.
C5-related development evidence grants neither attestation nor human approval.

## Befund und Wiederherstellung / Findings and Recovery

Die 26 doppelten Scaffold-Verzeichnisse enthielten 658 Git-getrackte Dateien.
Beide Scaffold-Saetze waren untereinander bytegleich. Ihr letzter vollstaendiger
Stand ist Commit `ca07d025b74908d8e162b6d7980422c4f14f16db` in Home Baseline.
Eine Wiederherstellung ist aus diesem Git-Commit moeglich. Die eigenstaendigen
Git-Klone unter `~/SpecKitPresetProjects/` bleiben erhalten.

The 26 duplicate scaffold directories contained 658 tracked files. Both sets
were byte-identical. Commit `ca07d025b74908d8e162b6d7980422c4f14f16db` retains
their complete pre-cleanup state for recovery; standalone Git clones remain.

Der [Dateivergleich](preset-source-audit-2026-09-06.json) sichert Pfade,
SHA-256 und vollstaendige Text-Diffs vor der Entfernung:

| Bereich / Surface | Befund / Finding | Behandlung / Treatment |
|---|---|---|
| Autonomous Run v0.4.1 | Fuenf lokale Dateien unterscheiden sich vom Release: Manpage, PowerShell-Runner und drei Testdateien / five local files differ from release | Diffs gesichert; Installation unveraendert / diffs retained; installation unchanged |
| Intake Sequencing v0.2.3 | Installierte `tests/test-home-baseline-field.ps1` weicht ab / installed test differs | Dokumentiert, nicht korrigiert / recorded, not corrected |
| Security v0.6.2 | Drei generierte `.composed`-Dateien nur lokal / three generated local files | Benoetigte Ableitungen erhalten / required derived files retained |
| Assurance v0.1.2 | Veroeffentlichter Workflow und zwei PR-Texte fehlen nur in Scaffolds / published workflow and two PR texts absent from scaffolds | Scaffolds entfernt; Installation stimmt mit Paket ueberein / scaffolds removed; installed package matches |
| Uebrige neun Presets / Other nine presets | Keine Dateidrift / no file drift | Installationen unveraendert / installations unchanged |

Die lokalen Sonderaenderungen werden nicht zu neuen Produktquellen. Eine
spaetere fachliche Uebernahme in einen Preset-Release ist ein eigener Auftrag.
Der Vergleich erfasst die Home-Baseline-Installation, nicht saemtliche externen
Repos. Diese Bereinigung fuehrt dort keinerlei Schreiboperationen aus.

Local differences do not become product sources. Any later adoption into a
preset release is separate work. The comparison covers the Home Baseline
installation, not every external repository; this cleanup writes to none of them.

## Historie und aktueller Auftrag / History and Current Work

v0.1.0-Veroeffentlichungsvorbereitung und der damals ausstehende Feldtest sind
abgeschlossen. Der [Feldbericht](secure-development-assurance-v011-field-test.md)
dokumentiert v0.1.2 als `ReleaseAccepted`; die einzelne autorisierte
[Einreichung #4455](https://github.com/github/spec-kit/issues/4455) ist erfolgt.
Maintainer-Triage und Katalogaufnahme bleiben Upstream-Aufgaben. v0.1.2 ist
weiterhin als Prerelease markiert; alte Tags werden nicht veraendert.

The v0.1.0 preparation and subsequent field test are complete. The field report
records v0.1.2 as `ReleaseAccepted`; submission #4455 exists. Upstream triage
and catalog acceptance remain pending. v0.1.2 remains a prerelease; old tags
are unchanged.

Historische Lastenhefte, Receipts, PR-Texte, Feature-Plaene, Paketnachweise und
Dokumentationsinventare behalten ihre damaligen Pfade und Hashbindungen.
Verweise auf entfernte Scaffolds in diesen historischen Artefakten bezeichnen
den damaligen Git-Stand, keine aktuellen Arbeitsanweisungen. Das betrifft
insbesondere die Features 010, 011, 020, 027 und 031, die alten Autonomous-
Paketnachweise, Work-Items von Juni/August und die Assurance-PR-Texte.
Aktuelle Produktpflege folgt ausschliesslich der neuen Quellenregel.

Historical intakes, receipts, PR texts, feature plans, package evidence, and
documentation inventories retain their original paths and hash bindings.
Retired scaffold references there describe historical Git state, not current
instructions. Current product maintenance follows the new source rule.

## Pruefung / Verification

`pwsh -NoProfile -File scripts/tests/test-preset-sources.ps1` wird vom Repo-Root
ausgefuehrt. Der Test laedt hashgepruefte Release-Pakete, installiert Profile
8 bis 13 ausschliesslich temporaer und prueft Assurance-Vertraege und erzeugte
Befehle. CI fuehrt denselben Test nativ unter macOS, Linux und Windows aus.
Bestehende Projektinstallationen werden von diesem Test nicht verwendet.

Vorher-/Nachher-Nachweis: 635 geschuetzte Git-getrackte Dateien aus installierten
Presets, Profilkonfigurationen und generierten Agentenbefehlen wurden nach
relativem Pfad sortiert und mit SHA-256 verglichen; alle blieben bytegleich.
Der SHA-256 des unveraenderten JSON-Snapshots lautet
`545e660862762aab5048ea03668d65d203a034edb67ce240a55b8a9070d02374`.
Die fuenf gemeinsam gepflegten Agenten-Guidance-Dateien sind die beabsichtigte
Ausnahme; generierte Preset-Skills und -Commands sind keine Ausnahme.

Before/after proof: all 635 protected tracked installation, profile, and
generated-command files remained byte-identical. The sorted JSON snapshot's
SHA-256 is recorded above. Only the five shared agent guidance documents are
intentional exceptions; generated preset skills and commands are protected.

Run the command above from the repository root. It downloads verified release
archives, installs profiles 8 through 13 only in temporary projects, and checks
assurance contracts and generated commands. Native macOS, Linux, and Windows
CI use the same test without using existing project installations.

## Dokumentationsauswirkung / Documentation Impact

`UpdateRequired`. Owner: Thorsten Hindermann. Zielgruppen: Maintainer,
KI-Agenten und Pruefende. Leserpfad: Quellenuebersicht → Quellenbindung →
Dateivergleich → Pakettest. Kanonische Produktquellen: oeffentliche Preset-
Repositories; Quelleninventar und Integration: Home Baseline. Dokumentklasse:
ActiveSemantic plus historische Audit-Evidence. DE zuerst/EN danach in
derselben Datei; keine getrennten Sprachpartner. Navigation: beide ehemaligen
Scaffold-Einstiege bleiben als Verweise bestehen. Plattformnachweis: nativer
CI-Pakettest auf drei Betriebssystemen und lokaler macOS-Lauf.

Distribution: Dokumentation und Audit `sourceOnly`; gemeinsame Agent-Guidance
normalerweise `homeRuntime`, hier ausdruecklich ohne Home-Sync. Die abweichende
Home-Kopie wird durch diesen Auftrag nicht aktualisiert. Wiedervorlage erfolgt
bei einem spaeter ausdruecklich beauftragten Sync oder Preset-Release.
Risiko: lokale bekannte Paketabweichungen bleiben bewusst bestehen; der Auftrag
verbietet ihre Korrektur. Evidence: Quellen-Audit, geschuetzter Dateivergleich
und CI-Ergebnisse im Liefer-PR. Keine neue Rollout-Autoritaet.

`UpdateRequired`: maintainers, agents, and reviewers follow index → source lock
→ audit → tests. Product authority belongs to public preset repositories;
Home Baseline owns the inventory and integration. Bilingual active guidance
and historical evidence are maintained together. Documentation is source-only;
shared guidance is normally home runtime, but this task explicitly excludes
Home sync. Reassess at a separately authorised sync or preset release. Known
installed differences remain because their correction is outside the mandate.
