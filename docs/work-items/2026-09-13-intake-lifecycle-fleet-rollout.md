# Workitem: Intake-Lifecycle-Presets verteilen / Distribute intake lifecycle presets

- Status: Completed
- Datum / Date: 2026-09-13
- Owner: Thorsten Hindermann, Repository Maintainer
- DeliveryMode: MergeAndSync, aktueller Admin-Bypass; 13 nicht gestartete Billing-Jobs ausdruecklich ausgenommen.
- Documentation Impact: UpdateRequired

## Umfang / Scope

Die drei bestehenden Presets werden in allen 35 ausgewaehlten regulaeren
Verbrauchern sowie erneut in TuiVision auf Authoring **0.3.4**, Review **0.2.3**
und Sequencing **0.2.6** gebracht: insgesamt 36 Repositories. Die erste Welle
0.3.2/0.2.2/0.2.4 bleibt als historische Delivery-Evidence erhalten.
Flottenreviews fuehrten zur zentralen Korrektur physischer Pfadgrenzen und
unbekannter Lifecycle-Zustaende. Ein anschliessend erkannter Fehler in zwei
JSON-Vorlagen der Zwischenpatches 0.3.3/0.2.5 wurde vor Verbraucher-Merges
behoben; native CI prueft jetzt auch alle ausgelieferten JSON-Vorlagen.

The final rollout covers 35 selected consumers plus TuiVision (36 repositories)
with Authoring 0.3.4, Review 0.2.3 and Sequencing 0.2.6. First-wave evidence is
retained. Fleet review led to central physical-boundary/state hardening; an
interim JSON-template substitution defect was corrected before consumer merges
and is now covered by native template-integrity CI.

Bestehende Prioritaeten, Aktivierungszustaende und andere Presets bleiben erhalten.
Die zentrale Standard-Achtermatrix wird nicht erweitert. Bestehende optionale
Profile, Source-Locks und Bootstrap-/Agent-Vorlagen binden die finalen Releases.
Existing priorities, enabled state and other presets remain intact. The standard
eight-preset matrix is unchanged; no new enrollment. Existing profile, source-lock
and bootstrap/guidance mirrors bind the final releases.

Die drei historischen 0.1.0-Test-Repositories unter SpecKitTestProjects bleiben
entsprechend der ausdruecklichen Auswahl unveraendert:

- intake-authoring-release-smoke-v010
- intake-authoring-v010
- intake-review-governance-v010

These three historical 0.1.0 fixtures remain unchanged as explicitly selected.

## Lieferung und Nachweis / Delivery and proof

[Maschinenlesbare Flotten-Evidence](2026-09-13-intake-lifecycle-fleet-rollout-evidence.json)
verzeichnet den Basisstand und spaeter PR-Head, technische Checks, Review-Befunde,
Merge und Synchronisierung jedes Repositories. Die jeweiligen Repositories
enthalten docs/maintenance/intake-lifecycle-fleet-rollout.json und die zugehoerige
bilinguale Dokumentationsentscheidung. Secure-Trader-Arbeit laeuft im bestehenden
freigegebenen Container. Fremde Arbeitsbaum-Aenderungen bleiben erhalten.

The fleet evidence records baseline and subsequent PR heads, technical checks,
review findings, merge and sync for each repository. Per-repository evidence
records package hashes, local overlays, shell parity and project findings.
Secure Trader changes run inside the approved existing container. Unrelated
working-tree changes remain intact.

Technische Paketpruefungen und fachliche Bestandsbefunde werden getrennt erfasst.
Neu erkannte Lifecycle-Verstoesse werden nicht als erfolgreiche Projektpruefung
ausgegeben; fachliche Intakes und historische Receipts werden nicht allein fuer
einen gruenen Rollout umgeschrieben. Die Flottenauslieferung und offene
Bestandskorrekturen erhalten getrennte Abschlusskriterien.

Package validation and project inventory findings are recorded separately.
Newly detected lifecycle violations are not reported as passing project checks.
Business intakes and historical receipts are not rewritten merely to obtain
green rollout results. Delivery and outstanding inventory corrections have
separate completion criteria.

## Lieferstand und offene Arbeiten / Delivery status and remaining work

36 von 36 Repositories sind gemergt und lokal synchronisiert. Die finalen
Releases 0.3.4 / 0.2.3 / 0.2.6 sind veroeffentlicht; alle neun
nativen Quellrepository-Jobs auf macOS, Linux und Windows waren erfolgreich.
Versionierte ZIPs wurden gegen die Release-Baeume geprueft. Alle 36
Verbraucher-Aenderungen sind vorbereitet und als PR veroeffentlicht. Der genaue
Merge-/Sync-Stand mit unveraenderlichen Commit- und CI-Verweisen steht in
`deliveryCounts` und `finalTargets` der verlinkten Evidence.

36 of 36 repositories are merged and locally synchronized. The final releases
are published, all nine native source CI jobs passed, and
versioned ZIP contents match the release trees. All 36 consumer changes have
published PRs. Evidence records the exact merge/sync count and immutable heads.

TuiVision ist gemergt und synchronisiert. Im frischen Checkout bestehen alle
zwoelf Manifest-/Receipt-Pruefungen in beiden Shells: zehn archivierte
Serienmitglieder, null physische aktive Intakes und null ausfuehrbare
Serienziele. Die Produktpruefung bestand mit 1028 erfolgreichen Tests.
Die 17 betroffenen Home-Runtime-Dateien wurden nach Vorschau synchronisiert
und per Hash geprueft; drei parallele Toolchain-Dateien und der bestehende
Voll-Sync-Zustand wurden erhalten.

TuiVision is merged and synced. Fresh-checkout proof passes all twelve
manifest/receipt checks in both shells, with ten archived members and zero
active or eligible targets. All 1028 product tests passed. The 17 affected
home runtime files were previewed, synchronized and hash-verified while
preserving unrelated toolchain work and the existing full-sync state.

Die folgenden Abschlussaktionen sind durchgefuehrt:

- Alle 13 blockierten Jobs der sechs Repositories secureorderdesk-java,
  secureorderdesk-swift, secure-serviceharvester, secureserviceharvester-go,
  secureserviceharvester-java und secureserviceharvester-python wurden erneut
  angefordert. GitHub nahm die Wiederholungen an, startete die Jobs wegen
  Abrechnung/Ausgabenlimit aber erneut nicht. Die aktuelle ausdrueckliche
  Nutzerfreigabe erlaubt genau hier MergeAndSync mit Admin-Bypass ohne diese
  Jobs. Alle sechs PRs sind gemergt und synchronisiert; die 13 Jobs gelten
  als nicht ausgefuehrt, nicht als bestanden. Diese native CI-Abdeckung fehlt.
- TinyCalc PR #78 ist nach ausdruecklicher aktueller Autorisierung gemergt
  und synchronisiert. Zwei neue Receipts und Operationen erhalten bytegleiche
  Vorgaengerarchive und unveraenderte Intake-Inhalte, IDs und Reihenfolgen.
  Im frischen Checkout bestehen 15 Artefaktpruefungen sowie beide Receipt-,
  Operation- und Review-Pruefungen in Bash und PowerShell ohne Schreibzugriffe.
  Alle technischen PR-Checks bestanden. Der optionale Claude-Review brach
  zweimal ohne Codebefund ab; der aktuelle Admin-Bypass deckt die formale
  Review-Freigabe, nicht einen behaupteten erfolgreichen Bot-Lauf.
- Bei InventarWorkerService scheiterte ebenfalls nur der optionale
  Claude-Review zweimal technisch. Technische Gates bestanden, acht Befunde
  wurden bearbeitet; die formale Review-Freigabe erfolgte per Admin-Bypass.

All 13 billing-blocked jobs were retried but again refused before execution.
The user's current, explicit exception authorizes merge and sync without
exactly these jobs; their missing native CI coverage is recorded, never counted
as passed. All six repositories are delivered. TinyCalc's two authorized
receipt successors, operations and scoped reviews pass fresh-checkout checks
in both shells; targets and predecessor evidence are preserved. Technical CI
passed. TinyCalc and InventarWorkerService each have a separately documented
optional review-bot execution failure and formal admin approval exception.

TinyCalcs zwei neue Single-Reviews sind bewusst `NeedsRemediation`: je ein
vorhandener IR001-Befund betrifft falsche Feature-Verweise. Die vollstaendige
Serienreview bleibt ausstehend; der vorhandene RIG017-Platzierungsbefund
bleibt ebenfalls eine fachliche Folgearbeit. Es erfolgte keine Freigabe
spaeterer Produktimplementierung und keine fachliche Intake-Umschreibung.

Bei der Receipt-Erneuerung wurde zusaetzlich die Generator-Versionsliste des
Authoring-Validators korrigiert: kanonische Quell-PR #9, native CI auf macOS,
Linux und Windows bestanden. Genau drei Dateien sind als deklarierte lokale
Erweiterung nach TinyCalc uebernommen; die installierte Version bleibt 0.3.4.
Ein neuer oeffentlicher Patch und seine weitere Verteilung bleiben im eigenen
[Folge-Workitem](2026-09-13-authoring-generator-patch-followup.md) offen.
Andere 35 Verbraucher und veroeffentlichte ZIPs wurden dafuer nicht veraendert.

The two TinyCalc Single reviews truthfully remain NeedsRemediation for existing
IR001 feature-reference findings. Full-series review and the existing RIG017
placement finding remain separate business work. The canonical authoring
generator-version fix passed all three native platforms and was backported
as three declared TinyCalc overlays. A public patch and wider adoption remain
in the separate linked follow-up; immutable release ZIPs and the other 35
consumers were not changed by this compatibility backport.

Der Flottenauftrag ist abgeschlossen. Verbleibende fachliche Befunde und die
oeffentliche Patch-Folgearbeit sind keine erledigten Projektpruefungen.
The fleet delivery is complete; the remaining business findings and public
patch follow-up are explicitly outside this completed delivery.

## Abschlusskriterien / Completion criteria

- Alle 36 ausgewaehlten Verbraucher inklusive TuiVision und deren bestehende Profilbindungen aktualisiert.
- Lokale Erweiterungen geprueft; keine neuen Presets oder unbeabsichtigten Fremdaenderungen.
- Paket-/Shell-Nachweise, technische PR-Gates und Review-Befunde erfasst; genau 13 nicht gestartete Billing-Jobs durch aktuelle explizite Freigabe ausgenommen.
- MergeAndSync je Repository nachgewiesen; Feature-Arbeit bleibt erhalten.
- Frischer Checkout bestaetigt Paketinhalt und dokumentierte fachliche Ergebnisse.
- Home-Runtime nach Vorschau synchronisiert; Preset-Quellen und -Verzeichnisse bleiben im Klon.
- Historische Test-Repositories unveraendert; verbleibende Bestandsbefunde explizit benannt.

All installations/profile references, preserved overlays, technical gates,
the exact current 13-job billing waiver, review disposition, merge/sync, fresh-checkout checks, checked home runtime sync
and unchanged historical fixtures must be evidenced. Remaining project findings
must be named explicitly.

## Dokumentation / Documentation

UpdateRequired; Owner: Maintainer; Leser: Maintainer und Agenten. Kanonische
Quellen sind die drei Release-Tags, optionale Profile und Flotten-Evidence.
Navigation: Workitem und verlinkte Repository-Evidence; Dokumentklasse:
Wartungsnachweis; Sprachpartner: DE/EN in derselben Datei. Textorientierte
Darstellung, Plattformnachweis macOS/Bash zuerst, PowerShell und Container/Linux.
Distributionsklasse: source-only Evidence; geaenderte Profile/shared Guidance
sind homeRuntime; ihr gepruefter Sync ist abgeschlossen. Dieser reine
Source-only-Nachweis benoetigt keinen weiteren Home-Sync. Re-Evaluation bei
Versionsdrift, neuen lokalen Erweiterungen oder offenen Lifecycle-Korrekturen.

The changed runtime profiles and shared guidance have completed their verified
home sync. This source-only evidence update requires no additional home sync.
