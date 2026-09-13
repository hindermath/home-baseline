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
