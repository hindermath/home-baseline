# Assurance 0.1.5: Paketkorrektur und Level 0 / Package Fix and Level 0

Owner: Thorsten Hindermann. Documentation Impact: `UpdateRequired` für
Paketbindung, Bedienung und Nachweise; `GeneratedUpdate` für den Statistikblock.
Details: [Impact-Evidence](assurance-0.1.5-level0-impact.json).

## Befund und Korrektur / Finding and Fix

Assurance 0.1.4 prüfte Versionen per Teiltextsuche. Falsche aktive Metadaten
konnten deshalb trotz korrekter Hashbindung mit einem passenden Beispiel im
Fließtext bestehen. 0.1.5 verlangt exakte, eindeutige aktive Metadaten für
Dokumentversionen, Checklisten-IDs und die Sammelband-Baseline; die Richtlinie
wird in DE und EN an ihrer ersten Metadatentabelle geprüft. Eingebettete
Checklisten behalten ihre eigene Baseline im jeweiligen Metadatenblock.
Historische Tabellen und normale Textnennungen bleiben zulässig. Doppelte
Felder, Präfixe und passende Werte außerhalb des aktiven Blocks genügen nicht.

Version 0.1.4 could accept matching body text despite stale active metadata.
Hash binding alone does not prove semantic correctness. Version 0.1.5 checks
exact unique active fields and both guideline language sections. Embedded
checklist baselines are scoped separately from the compendium header. Legacy
inconsistent or monolingual sources may block; migrate explicitly and create
fresh evidence, never rewrite historical hash-bound records.

## Quellen und Scope / Sources and Scope

- [Paket-PR #7 / Package PR #7](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/7)
- [Zielrelease v0.1.5 / Target release v0.1.5](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.5)
- [Verbindliche Quellenbindung / Authoritative source binding](preset-source-lock.json)
- [Verifizierte Installationsbindung / Verified installed-state binding](preset-installed-lock.json)

Die zentrale 13-/14-Preset-Matrix erhält ausschließlich Assurance 0.1.5 bei
Priorität 15. Alle anderen Versionen, Prioritäten und das globale Acht-Preset-
Default bleiben erhalten. Keine Level-1-/Level-2-Verteilung und keine
Community-Katalogeinreichung. GSDB-PR #337 bleibt ausdrücklich offen;
sein Head und seine historische Evidence werden hier nicht geändert.

Only Assurance changes in the thirteen-/fourteen-preset profiles. Existing
priorities and all other versions remain unchanged. MergeAndSync authority
covers this package and Level-0 delivery only. No fleet rollout or catalog
submission. GSDB PR #337 remains open and its historical evidence is preserved.

Der Installed-Lock wird erst nach tatsächlicher, ausdrücklich autorisierter
Installation und Prüfung aktualisiert. Vorherige Bindung, Registry und alle
462 Dateien der übrigen dreizehn Presets sind gesichert; der Paketwechsel darf
deren Inhalte nicht ändern. Hashes folgen dem bestehenden kanonischen Vertrag
`normalized_hash`/`payload_binding` im Agenten-Paritätstest. Die frühere Evidence
bleibt historisch erhalten; ein neu berechneter Hash ersetzt keine Prüfung.

Refresh the installed-state lock only after the actual authorized install and
verification. Preserve its predecessor and verify every unrelated preset file
unchanged, including the accepted runner overlay. Reuse the existing canonical
normalization/payload-binding functions; never refresh evidence merely to make
a test pass. The immutable pre-installation Level-0 commit anchors the snapshot;
package tag/commit and archive hash separately identify the new installed code.

## Technische Prüfgrenzen / Technical Verification Boundaries

47 Negativfälle pro Shell binden manipulierte Dokumente neu an gültige Hashes;
so darf kein Hashfehler den Metadatenfehler verdecken. Diagnose muss Pfad und
Feld enthalten; Byte-Snapshots prüfen Read-only. Die Positivfixture enthält
zwölf eingebettete Metadatenblöcke mit eigener, abweichender Baseline.
Bestehende Gate-, BOM-/CRLF- und generierte Oberflächenprüfungen bleiben nötig.
Native CI, exakte Release-/PR-Heads, Archivhash und tatsächliche Exitcodes
werden im Liefer-PR festgehalten. Ein Verfahrensplan allein ist kein Pass.

Forty-seven rebound negative cases per shell distinguish metadata rejection
from hash drift. Positive coverage includes embedded checklist metadata,
historical tables and narrative mentions. Actual native CI, archive identity,
installed-matrix, gate and source synchronization results belong to delivery
evidence. A green technical status grants no product or human acceptance.

Die Level-0-Assurance-CI erhält 30 statt 15 Minuten Laufzeitbudget: Die
erweiterte Paketprüfung benötigt unter Windows bereits rund 14 Minuten,
zusätzlich prüft Level 0 vierzehn Archive und alle Profile. Assertions und
Fehlerkriterien bleiben vollständig erhalten. / The Level-0 job allows thirty
minutes because the measured Windows package regression alone takes about
fourteen minutes, before fourteen-archive/profile integration. All checks and
failure conditions remain intact.

Die lesende Vorprüfung der neuen Validatoren gegen den unveränderten
Level-0-Kontext `2026-10-18-home-baseline-preset-patch-rollout` ergab in Bash
und PowerShell Baseline/Delta/Closure/Image/Gesamt `Ready`. Der dort bereits
historisch vorhandene technische Entscheid `Fulfilled` wurde nicht neu erteilt;
Pilot, Projektabnahme und allgemeine Freigabe bleiben `Open`.

The read-only preflight against the existing Level-0 context passed in both
shells without changing its historical decisions. Its recorded technical
decision was already fulfilled; this run does not renew it or grant any of
the three open human approvals.

## Distribution und Abschluss / Distribution and Closeout

Profilkonfigurationen unter `scripts/` und die deutsche README sind
`homeRuntime`; die englische README wird vom Runtime-Selektor nicht verteilt.
Quellenbindung, dieser Bericht und Statistik bleiben im Quellrepository.
Der installierte Preset-Cache ist `machineLocal` und wird nicht per Home-Sync
kopiert. Ein echter Home-Sync darf erst nach exaktem Level-0-Merge, Syntaxcheck,
Vorschau und Konfliktprüfung aus der stabilen Level-0-Quelle laufen.
Das akzeptierte lokale Runner-Overlay anderer Presets bleibt erhalten.

Profile configuration and the German root README are homeRuntime; the English
README is not selected for runtime copying. Provenance and statistics stay in
the source repository. Preset caches remain machineLocal. Home sync uses
the merged stable Level-0 source after syntax, preview and conflict checks.
Preserve the unrelated accepted runner overlay and all other repositories.
Final PR evidence records merge, local/main parity, installation and sync;
none of those outcomes is inferred from the preparation described here.

## Verifizierte Installation / Verified Installation

Das veröffentlichte Tag `v0.1.5` bindet Paketcommit
`55be0314488f1aeedc396f652cb247f9e5678817`; geprüft wurde PR-Head
`f9d6de4aef5d19c6ca2d2ed6275194d5cad9f806` mit identischem Git-Baum.
ZIP-SHA-256: `2fde15a7562bea6fcb151a0476a34b41519a6511f4424085da7fe0b1aac637a9`.
Alle 19 Dateien wurden gegen das Tag-Artefakt und nach der Installation erneut
bytegenau verglichen. Die 462 Dateien der übrigen dreizehn Presets blieben
bytegleich; deren bisherige Payload-Bindungen bleiben erhalten.
Der aktuelle Installed-Lock wurde erst nach dieser Prüfung fortgeschrieben.

The published archive, tagged package tree and nineteen installed files were
verified byte-identical. All 462 unrelated preset files and their thirteen
payload bindings remain unchanged. Only then was the current installed-state
lock refreshed under the explicit installation authority. The later Level-0
merge and Home-sync receipt is recorded in the delivery PR; this section
records the installation proof, not a human/product acceptance.
