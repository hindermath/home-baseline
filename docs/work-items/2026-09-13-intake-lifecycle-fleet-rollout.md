# Workitem: Intake-Lifecycle-Presets verteilen / Distribute intake lifecycle presets

- Status: InProgress
- Datum / Date: 2026-09-13
- Owner: Thorsten Hindermann, Repository Maintainer
- DeliveryMode: MergeAndSync, aktueller Admin-Bypass nach technischen Gates autorisiert.
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

29 von 36 Repositories sind gemergt und lokal synchronisiert. Die finalen
Releases 0.3.4 / 0.2.3 / 0.2.6 sind veroeffentlicht; alle neun
nativen Quellrepository-Jobs auf macOS, Linux und Windows waren erfolgreich.
Versionierte ZIPs wurden gegen die Release-Baeume geprueft. Alle 36
Verbraucher-Aenderungen sind vorbereitet und als PR veroeffentlicht. Der genaue
Merge-/Sync-Stand mit unveraenderlichen Commit- und CI-Verweisen steht in
`deliveryCounts` und `finalTargets` der verlinkten Evidence.

29 of 36 repositories are merged and locally synchronized. The final releases
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

Folgende Arbeiten verhindern weiterhin den Abschluss:

- GitHub startete 13 Jobs in sechs Repositories wegen Abrechnung bzw.
  Ausgabenlimit nicht: secureorderdesk-java, secureorderdesk-swift,
  secure-serviceharvester, secureserviceharvester-go,
  secureserviceharvester-java und secureserviceharvester-python.
  Nach Behebung durch den Kontoinhaber: betroffene Jobs erneut starten,
  technische Gates pruefen, mergen und synchronisieren.
- TinyCalc: Zwei bestehende Authoring-Receipts besitzen bereits vor diesem
  Rollout veraltete README-Quellhashes. Die gezielte Erneuerung samt neuen
  Operationen, Archiv-/Nachfolgernachweisen und Reviews ist vorbereitet,
  wartet aber auf ausdrueckliche aktuelle Update-/Review-Autorisierung.
  Intake-IDs, Inhalte, Namen, Reihenfolge und Abhaengigkeiten bleiben erhalten.
  Betroffen sind `rename-microcalc-tinycalc.json` und
  `tui-funktionsabnahme-und-regressionsvertrag.json`.

Thirteen jobs in the six repositories above could not start due to GitHub
billing/spending limits. After the account owner resolves this, rerun the jobs
and complete technical gates, merge and sync. TinyCalc additionally needs
explicit current authority for the prepared renewal of two stale receipts and
their reviews; their README hash drift predates this rollout. No receipt
renewal or business-intake relocation has been performed.

Bei InventarWorkerService war nur der optionale Claude-Review nach zwei
Versuchen technisch fehlgeschlagen (Tool-Berechtigungen). Alle technischen
Gates bestanden; acht Review-Befunde wurden bearbeitet. Der aktuelle
Admin-Bypass wurde fuer die formale Review-Freigabe verwendet. Dieser begrenzte
Fall erlaubt keinen Bypass nicht gestarteter oder fehlgeschlagener Pflichtjobs.

InventarWorkerService's optional Claude review failed twice due to tool
permissions. Technical gates passed and eight findings were addressed; current
admin authority covered formal review approval. This bounded exception does
not waive unstarted or failed mandatory jobs.

Owner der offenen Schritte: Thorsten Hindermann / Maintainer. Wiedervorlage:
nach Billing-Korrektur bzw. ausdruecklicher Receipt-Autorisierung. Bis dahin
bleibt dieses Workitem InProgress; fachliche Bestandsbefunde bleiben separat
sichtbar und werden nicht als erfolgreiche Lifecycle-Pruefungen ausgegeben.

The maintainer owns these remaining actions. Resume after billing resolution
or explicit receipt authority. This workitem remains InProgress; existing
business findings are reported separately, never as successful lifecycle checks.

## Abschlusskriterien / Completion criteria

- Alle 36 ausgewaehlten Verbraucher inklusive TuiVision und deren bestehende Profilbindungen aktualisiert.
- Lokale Erweiterungen geprueft; keine neuen Presets oder unbeabsichtigten Fremdaenderungen.
- Paket-/Shell-Nachweise, verpflichtende technische PR-Gates und Review-Befunde erfasst.
- MergeAndSync je Repository nachgewiesen; Feature-Arbeit bleibt erhalten.
- Frischer Checkout bestaetigt Paketinhalt und dokumentierte fachliche Ergebnisse.
- Home-Runtime nach Vorschau synchronisiert; Preset-Quellen und -Verzeichnisse bleiben im Klon.
- Historische Test-Repositories unveraendert; verbleibende Bestandsbefunde explizit benannt.

All installations/profile references, preserved overlays, technical gates,
review disposition, merge/sync, fresh-checkout checks, checked home runtime sync
and unchanged historical fixtures must be evidenced. Remaining project findings
must be named explicitly.

## Dokumentation / Documentation

UpdateRequired; Owner: Maintainer; Leser: Maintainer und Agenten. Kanonische
Quellen sind die drei Release-Tags, optionale Profile und Flotten-Evidence.
Navigation: Workitem und verlinkte Repository-Evidence; Dokumentklasse:
Wartungsnachweis; Sprachpartner: DE/EN in derselben Datei. Textorientierte
Darstellung, Plattformnachweis macOS/Bash zuerst, PowerShell und Container/Linux.
Distributionsklasse: source-only Evidence; geaenderte Profile/shared Guidance
sind homeRuntime und benoetigen abschliessenden Sync. Re-Evaluation bei
Versionsdrift, neuen lokalen Erweiterungen oder offenen Lifecycle-Korrekturen.
