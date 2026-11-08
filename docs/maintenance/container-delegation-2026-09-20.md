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

### Schema 3: dokumentierte Owner-Entscheidung / Documented owner decision

Stand 08.11.2026: Die ausdrueckliche Owner-Entscheidung und der nachvollziehbare
Repository-Review ersetzen die zusaetzliche kryptografische Owner-Signatur.
Es werden weder Schluessel noch Signaturdateien benoetigt. SHA-256 erkennt
Abweichungen; es beweist nicht die Identitaet oder Zustimmung des Owners.
Agenten duerfen keine Freigabe selbst erteilen oder erweitern. Die aktuell
ausgelieferte Konfiguration bleibt `PendingOwnerApproval`; erfolgreiche Tests
und Migration setzen sie nicht automatisch auf `OwnerApproved`.

`approvedSourceSha256` bindet die sortierte Pfad-/Hash-Abbildung des vorhandenen
Paketmanifests einschliesslich Manifest, Validator, Worker und Hilfsskripten.
Textdateien verwenden wie bisher LF-normalisierte Bytes. Der Gesamthash
verwendet UTF-8-JSON mit sortierten Schluesseln und kompakten Trennzeichen.
Nur `scripts/config/maintenance-execution-contexts.json` wird ausgeschlossen,
um eine Hash-Selbstreferenz zu vermeiden. Dessen Inhalt wird separat durch
strikte Feldvalidierung und `approvalBindingSha256` geprueft. Die Git-Revision
wird als `sourceRevision` protokolliert, nicht als Freigabebedingung verwendet.
Reine Dokumentations-Commits ausserhalb des Pakets erfordern damit keine neue
Paketfreigabe; jede Aenderung eines gebundenen Paketmitglieds dagegen schon.

Migration: Schema 2 wird mit einer Migrationsmeldung abgewiesen. Nach
technischer Pruefung werden Dokumenthash, tatsaechliche Image-ID,
Paketfingerabdruck, Mounts und Ablaufdatum zusammengestellt; erst die konkrete
Owner-Entscheidung erlaubt `OwnerApproved`. Anschliessend wird der kanonische
Vertrags-Binding-Hash berechnet. Kein automatisches Uebernehmen eines neueren
Images und kein pauschales Deaktivieren von Gates. Das Ablaufdatum bleibt
31.12.2026 einschliesslich (UTC); ab 01.01.2027 ist die Freigabe ungueltig.

Die Sandbox muss non-root, ohne zusaetzliche Capabilities, mit vollstaendigem
Drop der Podman-Default-Capabilities (oder `ALL`) und `no-new-privileges`
laufen. Die Referenzquelle muss eingebaut oder read-only eingebunden und fuer
den Sandbox-Benutzer unveraenderlich sein. Fehlende Referenz, Paketdrift und
fehlende Owner-Freigabe werden getrennt gemeldet. Diese Aenderung stellt keine
Betriebsaktivierung dar: Image, Container, Volumes und die noch offenen
organisatorischen Rollenfreigaben bleiben unveraendert.

*As of 8 November 2026, an explicit owner decision and traceable repository
review replace the additional cryptographic owner signature. No key or
signature files are needed. SHA-256 detects drift, not owner identity or
consent. Agents must never grant or expand approval themselves. The shipped
contract remains `PendingOwnerApproval`; migration and tests never activate it.
`approvedSourceSha256` hashes the sorted path/hash map of the declared package,
including its manifest, validator, worker and helpers. Text uses LF-normalized
bytes; the aggregate uses sorted, compact UTF-8 JSON. Only the execution
contract is excluded to avoid self-reference; strict field validation and its
separate binding hash protect it against drift. Git `sourceRevision` is
provenance only. Documentation outside the package does not change approval;
bound package changes do. Schema 2 requires explicit migration. Review the
document hash, actual image, package fingerprint, mounts and expiry before an
explicit owner decision permits `OwnerApproved`; then compute the contract
binding hash. No automatic image approval or gate bypass is allowed. Approval
remains valid through 31 December 2026 UTC and expires on 1 January 2027.
Non-root execution, no added capabilities, the complete Podman default
capability drop set or ALL, no-new-privileges and an immutable embedded or
read-only mounted reference remain required. Missing reference, package drift
and missing owner approval have separate errors. This change does not activate
operations or change images, containers, volumes or pending role approvals.*

- Der Host besitzt Netzwerk-Git und die zentrale Registry. Fuer beschreibbar
  eingebundene Secure-Trader-Ziele ist Host-Git-Netzwerkzugriff jedoch
  gesperrt, bis ein isolierter, repository-unabhaengiger Transport geprueft
  ist; keine Übertragung von Provider-Zugangsdaten.
- 21 Secure-Trader-Repositories werden ausschließlich in den drei vorhandenen
  Workspace-Mounts bearbeitet. Der Vertrag muss jede aktive Secure-Trader-
  Wurzel vollständig abdecken; eine Teilmenge blockiert den Lauf vor Git.
  Keine neuen Mounts oder stillen Host-Fallbacks.
- Vorabprüfung bindet Container-ID, Image, Freigabedokument und Paket-Hashes.
  Die Hashbindung umfasst auch alle vom Leaf-Worker ausgeführten und direkt
  eingebundenen Hilfsskripte. Das Quellpaket muss für den Containerbenutzer
  schreibgeschützt sein.
- Secure-Trader-Fast-forwards bleiben bis zum geprueften isolierten Transport
  mit `HostGitTransportBlocked` gesperrt.
- Leaf-Worker führen einzelne Phasen aus, niemals rekursive Vollwartung.
- Container-Storage beschränkt sich auf Projektartefakte; keine globalen
  Caches, Images oder Agentenvolumes. Vor Änderungen erfolgt eine Vorschau.
- Die Owner-Freigabe endet am 31.12.2026. Sie ersetzt keine ausstehende
  CISO-/ISB-/KIB-Freigabe.

*The host owns network Git and the central registry; credentials are not
transferred. The 21 Secure Trader repositories use only the three existing
workspace mounts; every active Secure Trader root must be covered, and a
partial contract blocks before Git. There are no new mounts or host fallbacks.
Host network Git remains available for non-mapped repositories. It is blocked
for writable mounted Secure Trader targets until an isolated,
repository-independent transport has been reviewed. Preflight binds the
container ID, image, approval document and the complete
executed helper closure. The source package must be read-only to the container
user. Secure Trader fast-forwards report `HostGitTransportBlocked` until that
transport exists. Leaf workers execute individual phases, never
recursive full maintenance. Container storage covers only project artifacts,
not global caches, images or agent volumes; changes require a preview. Owner
approval expires on 31 December 2026 and does not replace pending approval
by the designated security or AI governance roles.*

## Noch ausstehend / Still pending

### Begrenzter Bundle-Transport / Bounded bundle transport

Der Transport ist in der gemeinsamen Python-Engine implementiert; Bash und
PowerShell verwenden denselben Pfad. Direkte Netzwerk-Git-Aufrufe gegen
Secure-Trader-Checkouts bleiben verboten. Erst ein erfolgreicher Schema-3-
Preflight erlaubt den neuen Transport fuer genau die 21 kanonischen Ziele.
Ein abweichendes Manifest, eine Teilmenge oder eine andere Remote-Adresse
wird abgewiesen. Der kanonische Fleet-Katalog gehoert zur Paketbindung.

Auf dem Host entstehen ausschliesslich frische temporaere Bare-Repositories,
ohne Checkout. System-/Benutzer-Git-Konfiguration und geerbte Git-Variablen
sind abgeschaltet; HTTPS ist das einzige Netzwerkprotokoll. Der ausdrueckliche
Host-`gh`-Credential-Helper liest den vorhandenen Host-Credential-Store.
Hooks, Templates, Submodule und automatische Wartung werden nicht ausgefuehrt.
Remote-Adressen kommen nie aus den eingebundenen Zielrepositories.

Alle Branch-Heads einschliesslich Release-Branches werden geladen; Tags und
Remote-Zustand bleiben unveraendert. Ein zweiter Remote-Ref-Abgleich sowie die
Pruefung des symbolischen Default-HEAD verhindern gemischte Snapshots. Jedes
vollstaendige Bundle bindet Run-ID, Ziel, kanonische URL, Defaultbranch,
Ref-/Commit-Menge, UTC-Zeit und SHA-256. Der Nachweis im Wartungsbericht
enthaelt nur Metadaten, keine Zugangsdaten oder Quelltexte.

Erst nach allen 21 Downloads werden Bundles ueber Standard-Input an den
unveraenderlichen Sandbox-Worker uebergeben, ohne neue Mounts oder Credentials.
Dieser prueft Pfade, Dateityp, Alter (maximal eine Stunde), Hash und Ref-Menge
sowie `git bundle verify`. Bundles mit Voraussetzungen oder unbekannten Refs
sind unzulaessig. Import per lokalem `unbundle` benoetigt weder Remote-URL
noch Netzwerk. Atomare Ref-Transaktionen aktualisieren nur direkte origin-
Tracking-Refs; lokale Branches und Tags bleiben erhalten. Ausser origin/HEAD
sind symbolische Tracking-Refs verboten. Hooks und Credential-Helper bleiben
auch beim Import deaktiviert.

Dry-run prueft das Bundle ohne Ziel-Ref-, Index- oder Worktree-Aenderung;
Check-only importiert Tracking-Metadaten ohne Fast-forward. Update erlaubt
nur saubere kanonische Branches mit passendem Upstream und ausschliesslich
Fast-forward gegen die gepruefte Commit-ID. Dirty-Resume-Ausnahmen gelten
nicht fuer Secure Trader. Die gemeinsame Mutationsbarriere bleibt erhalten:
ein nicht bereites Flottenziel kann Fast-forwards insgesamt sperren.
Es erfolgt kein Reset, Stash, Branchwechsel, Commit oder Push.

Limits: ein Bundle maximal 1 GiB, alle Bundles eines Laufs zusammen maximal
2 GiB. Erfolgreiche temporaere Host- und Container-Artefakte werden entfernt;
bei Fehlern bleibt der private Host-Laufordner als geschuetzte Diagnose
erhalten (Pfad in der Fehlermeldung). Wiederholungen erzeugen neue Run-IDs;
alte Artefakte werden nicht automatisch wiederverwendet. Diagnoseordner vor
spaeterer gezielter Bereinigung pruefen; kein globales Temp- oder Podman-Prune.

Vor Betriebsabnahme muessen der neue Quellstand geliefert, die Sandbox-Lock-
Datei gepinnt, das Image gebaut und getestet sowie die konkrete Owner-
Freigabe erneuert werden. Auditexport, Sicherungspruefung und Erhalt aller
Volumes gehen dem Containerwechsel voraus. Der alte Container bleibt
zunaechst gestoppt als Rueckfallmoeglichkeit. Danach Vorschau, gezielter Lauf,
frischer Host-`gh`-Abgleich aller 21 Default-Heads und erneuter Check.
Bei Remote-Bewegung wird einmal erneut synchronisiert; weitere Bewegung
wird offen berichtet. Ein erfolgreicher Quelltest ist keine Betriebsabnahme.

*The shared Python engine implements bounded bundle transport for both shell
entry points. Direct host network Git against Secure Trader checkouts remains
forbidden. Schema 3 preflight and the exact canonical 21-target catalog are
required; the catalog is package-bound. Host downloads use fresh temporary
bare repositories without checkout, with system/user Git configuration and
inherited Git variables disabled. Only HTTPS and the explicit host gh helper
are used. Hooks, templates, submodules and automatic maintenance are disabled.
No URL comes from target configuration. All branch heads, including release
branches, are downloaded; tags and remote repositories are untouched. A
second ref query and symbolic default HEAD check reject moving snapshots.
Complete bundles bind run, target, URL, default branch, refs, UTC time and
SHA-256. Reports contain metadata, not credentials or source text.*

*All 21 downloads finish before stdin transfer to the immutable sandbox worker.
No mounts or credentials are added. The worker checks paths, type, age (one
hour maximum), digest, exact refs and bundle verification. Prerequisite bundles
and unexpected refs are rejected. Local unbundle needs no network or remote
URL. Atomic no-dereference transactions update only origin tracking refs;
local branches and tags are preserved. Only origin/HEAD may be symbolic.
Import hooks and credential helpers are disabled. Dry-run leaves target refs,
index and worktree unchanged; check-only imports metadata without merging.
Update permits only clean canonical branches with correct upstream and an
exact-OID fast-forward. Dirty resume exceptions do not apply. The shared
fleet barrier can block all fast-forwards if a target is not ready. No reset,
stash, branch switch, commit or push is performed. Limits are 1 GiB per bundle
and 2 GiB per run. Successful temporary artifacts are removed; failed private
host directories are retained for scoped diagnostic review, never reused
automatically. No global temp or Podman pruning is allowed.*

*Operational acceptance requires published source, an updated sandbox source
pin, a tested image and renewed explicit approval for that image/package.
Audit export, verified backup and volume retention precede container replacement;
keep the old container stopped as a fallback. Then preview, update, compare all
21 default heads using fresh host gh metadata and check again. Retry remote
movement once; report further movement as unresolved. Source tests do not
constitute live operational acceptance.*

Die fruehere Fast-forward-Evidence ist durch die neue Host-Transportbarriere
ersetzt. Gezielte Delegationstests pruefen jetzt, dass `fetch`, `ls-remote` und
`pull` fuer gemappte Ziele keinen Host-Prozess starten. Die erste
Gesamtregression bestand mit 287 Tests, darunter 12 ausdrücklich übersprungene
Tests. Native Plattformnachweise werden am veröffentlichten Commit geprüft.
Vor produktiver Aktivierung folgen Veröffentlichung des geprüften Quellpakets,
explizit gepinntes Image-Update unter Erhalt der Volumes, erneute Vorschau,
Vollwartung und abschließender Check-only-Lauf. Neue technische Fehler werden
nicht durch den zuvor genehmigten Admin-Bypass übergangen.

Container-Reparaturen bleiben ausdrücklich zustimmungspflichtig. Dirty-Ziele
und alte Container-Resume-Evidence benötigen separaten Review; sie werden
weder überschrieben noch auf dem Host wiederaufgenommen.

*The earlier fast-forward evidence is superseded by the host transport
barrier. Focused delegation tests now verify that `fetch`, `ls-remote`, and
`pull` start no host process for mapped targets. The first full
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

Lokaler Nachweis fuer Schema 3 (08.11.2026): 38 Delegationstests (davon ein
nativer Windows-Test auf macOS uebersprungen), 34 Wartungs- und 25
Vertragsregressionen erfolgreich; Bash-/PowerShell-Syntax, Secret-Scan und
Diff-Pruefung erfolgreich. Keine native Windows-Abnahme und kein echter
Secure-Trader-Lauf. Der Statistik-Check meldet Drift; der Renderer verweigert
Schreiben im schmutzigen Arbeitsbaum. Der generierte Block bleibt bis zum
autorisierten Inhaltscommit und getrennten Renderer-Nachlauf unveraendert.

*Local schema 3 proof (8 November 2026): 38 delegation tests (one native
Windows case skipped on macOS), 34 maintenance and 25 contract regressions
completed successfully; Bash/PowerShell syntax, secret scan and diff checks
passed. No native Windows acceptance or live Secure Trader run is claimed.
Statistics verification reports drift; the renderer refuses a dirty worktree.
The generated block remains unchanged pending an authorized content commit
and a separate rendering follow-up.*

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
