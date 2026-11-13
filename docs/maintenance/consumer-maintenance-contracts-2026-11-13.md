# Projektspezifische Wartungsverträge / Project maintenance contracts

## Deutsch

**Documentation Impact: UpdateRequired.** Owner: Thorsten Hindermann.
Kanonische Quelle ist das Verteilungsmanifest
`scripts/config/agentic-toolchain-maintenance-files.json`. Dieses Dokument
erklärt die Ausnahmen für Wartende und Agenten. Leserpfad: Manifest,
Projektskripte, projektbezogene Tests, PR-Prüfungen. Dokumentklasse:
Wartungsnachweis; Distribution: Level-0-Quelle. Die Änderung an diesem
Manifest benötigt keinen Home-Runtime-Sync und verteilt keine Dateien.
Bei einer Änderung der Projektverträge oder des Manifests erneut prüfen.

TuiVision prüft npm-Pakete mit exakter Version und SHA-512, bindet Spec Kit
an eine vollständige Git-Revision und besitzt eigene Wartungs- und
Homogenitätsadapter. Die generischen Level-0-Kopien dürfen diese Schutzregeln
und ihre Tests nicht überschreiben. Die gemeinsamen neuen Probegrenzen
werden in den Projektadaptern ergänzt.

Die Sandbox hält Vorschau und Vergleich frei von durch Registries
festgelegten Prozessstarts. Ihr Registry-Snapshot und ihre Linux-Hilfsfunktionen
gehören zu dieser Grenze. Auch hier werden neue Probegrenzen im
Projektadapter ergänzt; Container, Images und Laufzeitdaten sind nicht
Gegenstand dieser Manifeständerung.

Die Sandbox behält außerdem ihren festgelegten Maintenance-TUI-SDK-Stand,
die Feature-004-Ausführungskontexte und Identitätsprüfungen vor einer
Speicherbereinigung. Gemeinsame Fleet-Härtungen bleiben verteilt.

Die Ausnahmen gelten nur für die benannten Pfade und Repositories.
Quellrevisionen und Beleglinks stehen je Eintrag im Manifest. Technische
PR-Prüfungen und CodeQL-Analyse bleiben eigenständige Auslieferungstore.

## English

**Documentation Impact: UpdateRequired.** Owner: Thorsten Hindermann.
The canonical source is
`scripts/config/agentic-toolchain-maintenance-files.json`. This document
explains the exceptions for maintainers and agents. Reader path: manifest,
project scripts, project tests, and PR checks. Document class: maintenance
record; distribution: Level 0 source. This manifest change needs no Home
Runtime sync and distributes no files. Reevaluate when the project contracts
or manifest change.

TuiVision verifies npm packages by exact version and SHA-512, pins Spec Kit
to a full Git revision, and has its own maintenance and homogeneity adapters.
Generic Level 0 copies must not replace these safeguards or their tests.
The new shared probe boundaries are added to the project adapters.

The sandbox keeps preview and compare operations free from process launches
specified by registries. Its registry snapshot and Linux helpers form part
of this boundary. The new probe boundaries are added to its project adapter.
Containers, images, and runtime data are outside this manifest change.

The sandbox also keeps its pinned Maintenance TUI SDK, Feature 004 execution
contexts and identity checks before storage cleanup. Shared fleet hardening
continues to be distributed.

Exceptions apply only to the named paths and repositories. Each manifest
entry records its source revision and evidence link. Technical PR checks
and CodeQL analysis remain separate delivery gates.
