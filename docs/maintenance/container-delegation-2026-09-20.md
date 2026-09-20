# Container-Delegation: Lieferung und Aktivierung / Container delegation: delivery and activation

## Stand und Grenze / Status and boundary

Der Owner hat Container-Delegation und den vollständigen Wartungslauf
beauftragt. Die Umsetzung wird über
`codex/container-maintenance-delegation` geliefert. Code-Lieferung und
erfolgreiche Betriebsabnahme sind getrennte Nachweise.
Am 20.09.2026 hat der Owner ausdrücklich auch die Veröffentlichung des neuen
Level-0-Pakets und den anschließenden Sandbox-Image-Pin mit
`MergeAndSync` einschließlich begrenztem Admin-Bypass genehmigt.
Technische Prüfungen bleiben verbindlich.

Die echte Vorprüfung am 20.09.2026 wurde vor Fetches und Änderungen durch die
Quellbindung blockiert. Run-ID: `6522ecc2-8930-418a-a325-6c3766d3485a`,
Exitcode `2`, finalisierter Status `FAILED`. Das laufende Image enthält
Level-0-Commit `5b3096c244a6b08266916d2cb4ba5981ebafbd67`, aber weder
`maintenance_execution_context.py` noch `maintenance_container_worker.py`.
Ein vollständiger Wartungserfolg wird nicht behauptet.

*The Owner requested container delegation and a full maintenance run.
Implementation is delivered through `codex/container-maintenance-delegation`.
Code delivery and successful operational acceptance are separate evidence.
The real preflight on 20 September 2026 stopped
before fetches or mutations because the embedded source did not match.
Run ID: `6522ecc2-8930-418a-a325-6c3766d3485a`, exit code `2`, finalized
status `FAILED`. The image embeds commit
`5b3096c244a6b08266916d2cb4ba5981ebafbd67` but lacks both delegation modules.
No successful full maintenance run is claimed.*

*On 20 September 2026, the Owner also explicitly approved publishing the new
Level 0 package and updating the sandbox image pin using MergeAndSync with
bounded admin bypass. Technical gates remain mandatory.*

## Vertrag / Contract

- Der Host besitzt Netzwerk-Git und die zentrale Registry; keine Übertragung
  von Provider-Zugangsdaten.
- 21 Secure-Trader-Repositories werden ausschließlich in den drei vorhandenen
  Workspace-Mounts bearbeitet. Keine neuen Mounts oder stillen Host-Fallbacks.
- Vorabprüfung bindet Container-ID, Image, Freigabedokument und Paket-Hashes.
  Das Quellpaket muss für den Containerbenutzer schreibgeschützt sein.
- Lokale Fast-forwards verwenden geprüfte Commit-IDs nach allen Fetches.
- Leaf-Worker führen einzelne Phasen aus, niemals rekursive Vollwartung.
- Container-Storage beschränkt sich auf Projektartefakte; keine globalen
  Caches, Images oder Agentenvolumes. Vor Änderungen erfolgt eine Vorschau.
- Die Owner-Freigabe endet am 31.12.2026. Sie ersetzt keine ausstehende
  CISO-/ISB-/KIB-Freigabe.

*The host owns network Git and the central registry; credentials are not
transferred. The 21 Secure Trader repositories use only the three existing
workspace mounts, without new mounts or host fallback. Preflight binds the
container ID, image, approval document and package hashes. The source package
must be read-only to the container user. Local fast-forwards use checked
commit IDs after all fetches. Leaf workers execute individual phases, never
recursive full maintenance. Container storage covers only project artifacts,
not global caches, images or agent volumes; changes require a preview. Owner
approval expires on 31 December 2026 and does not replace pending approval
by the designated security or AI governance roles.*

## Noch ausstehend / Still pending

Lokal bestanden 22 gezielte Delegationstests, darunter echte isolierte
Registry-/Paketprüfungen und Fast-forwards nach allen Fetches. Die erste
Gesamtregression bestand mit 287 Tests, darunter 12 ausdrücklich übersprungene
Tests. Native Plattformnachweise werden am veröffentlichten Commit geprüft.
Vor produktiver Aktivierung folgen Veröffentlichung des geprüften Quellpakets,
explizit gepinntes Image-Update unter Erhalt der Volumes, erneute Vorschau,
Vollwartung und abschließender Check-only-Lauf. Neue technische Fehler werden
nicht durch den zuvor genehmigten Admin-Bypass übergangen.

Container-Reparaturen bleiben ausdrücklich zustimmungspflichtig. Dirty-Ziele
und alte Container-Resume-Evidence benötigen separaten Review; sie werden
weder überschrieben noch auf dem Host wiederaufgenommen.

*Locally, 22 focused delegation tests passed, including real isolated
registry/package checks and fast-forwards after all fetches. The first full
regression passed with 287 tests, including 12 explicit skips. Native platform
evidence is checked against the published commit. Before production
activation, publish the reviewed package, update the explicitly
pinned image while preserving volumes, repeat the preview, run full
maintenance and finish with check-only. Previously authorized admin bypass
does not waive new technical failures.*

*Container repairs still require explicit authority. Dirty targets and older
container resume evidence require separate review; neither is overwritten or
resumed on the host.*

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`. Owner: Workspace-Maintainer. Zielgruppen: Maintainer und
Wartungsoperatoren. Kanonische Quellen: Ausführungsvertrag, beide
Einstiegsskripte und Leaf-Worker unter `scripts/`. Leserpfad: Manpage
`docs/man/maintain-agentic-workspace.1.md` → diese Arbeitsevidence.
Dokumentklasse: Betriebsevidence; Sprache: Deutsch zuerst, Englisch danach.
Diese Datei ist source-only. Runtime- und Paketdistribution sind erforderlich,
aber bis zum Abschluss der Prüfungen und Quellbindung nicht ausgeführt.
Re-Evaluation: vor Veröffentlichung und bei Image-, Mount- oder
Freigabeänderung. Plattformnachweis bisher: macOS; keine Windows-Abnahme.

*Decision: `UpdateRequired`. Owner: workspace maintainer. Readers: maintainers
and maintenance operators. Canonical sources: execution contract, both entry
scripts and leaf workers under `scripts/`. Reader path: maintenance manpage to
this evidence. Document class: operational evidence; German first, English
second. This file is source-only. Runtime/package distribution is required
but has not been performed pending verification and source binding. Reevaluate
before publication and whenever image, mounts or approval change. Platform
evidence currently covers macOS, not Windows acceptance.*
