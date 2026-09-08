# Evidence-Matrix: Home Baseline ↔ ABSDD

| Gate | Lokale Evidence | Ergebnis | Nächste Entscheidung |
|---|---|---|---|
| baseline | Home Baseline 3.2.0, Zwölfer-Profil, ABSDD 3.1.0 | Ready | Delta prüfen |
| delta | Vertrag, Befehle, Runbooks, Intake- und Serienlineage | Ready | Upstream-Triage von `github/spec-kit#4455` abwarten |
| closure | PR #264 technisch validiert; v0.1.2-Feldtest `ReleaseAccepted`; Community-Einreichung `github/spec-kit#4455`; Copilot-Review durch Repository-Owner ausdrücklich abbedungen | NeedsRemediation | Automatisierten Katalog-PR sowie Positionen 14–17 und menschliche Freigaben getrennt behandeln |
| image-impact | ABSDD Commit 7adaeac; keine Änderung ausgeführt | NeedsRemediation | Position 17 separat autorisieren |

Technische Validierung, Pilotfreigabe, Projektabnahme und allgemeine Freigabe
sind nicht austauschbar. Der heutige Nachweis gewährt keine der drei
menschlichen Freigaben. Das fehlende Copilot-Review ist nur für PR #264 als
Restrisiko akzeptiert. HOSK/GWDG ist nur externer Vergleich.

## Preset-Veröffentlichung v0.1.0 / Preset Publication v0.1.0

Das öffentliche Repository
`hindermath/spec-kit-preset-secure-development-assurance-governance` wurde über
PR #1 mit Merge-Commit `e51e40e8ff46d8b4c00aa99b654b0d82264885ab`
veröffentlicht. Tag und GitHub-Release `v0.1.0` sind vorhanden. Das
unveränderliche Tag-ZIP besitzt SHA-256
`d9effc395e590d1ffe832d059f8681501da1d1b6e7d44d79a3e61929bc5229c1`.
Ein frisches temporäres Spec-Kit-Projekt bestätigte die vollständige
13-Preset-Komposition, Bash-/PowerShell-Parität, den read-only Statuslauf, alle
vier Reviews sowie Deaktivieren, Reaktivieren, Entfernen und Neuinstallation
aus dem veröffentlichten ZIP. Zu diesem damaligen v0.1.0-Publikationsstand
blieben praktischer Feldtest, Community-Einreichung und menschliche Freigaben
getrennte, noch nicht ausgelöste Phasen.

## Feldtestabschluss v0.1.2 / Field-test Closeout v0.1.2

Der praktische TinyCalc-Feldtest ist mit genau der Bewertung
`ReleaseAccepted` abgeschlossen. Das unveränderliche v0.1.2-Tag-ZIP mit
SHA-256
`4eb30804bb3c329681e0b7d44187c8daeb3e9e4f250bb6003d5b746c0ad0b656`
bestand die Paket- und Installationsprüfungen sowie die seriellen RL-SE- und
GSDB-Läufe einschließlich ihrer kausalen Closeouts in TinyCalc PR #67 bis #71.
Der GSDB-Closeout-Merge `94624918c455da86ec59af8e4153e764113725ad`
entspricht dem geprüften TinyCalc-`main`.

Die Bewertung gilt ausschließlich für Preset v0.1.2 und seinen
Evidence-Vertrag. Dreizehn TinyCalc-Folgefindings, 42 Human-only-Zeilen,
Pilotfreigabe, Projektabnahme, Sandbox-/Produkt-/Flottenfreigabe sowie C5-,
ISO-, Konformitäts-, Testat- oder Zertifizierungsbehauptungen bleiben davon
unberührt. Am 2026-09-06 wurde genau eine Community-Einreichung von v0.1.2
separat autorisiert und als
[github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455)
angelegt. Der offizielle Draft-Katalog-PR entsteht erst nach
Upstream-Maintainer-Triage automatisch; ein manueller Parallel-PR wurde nicht
erstellt. Welche Level-2-Repositories das Preset später erhalten, ist
ausdrücklich keine Entscheidung dieses Abschlusses.

## English

The baseline and handoff delta are inspectable. PR #264 is technically
validated, with the missing Copilot review explicitly accepted as a bounded
risk by the repository owner. Closure and image impact remain open because the
later ABSDD adoption and human authorizations have not been executed.

The public releases are available. The immutable v0.1.2 archive passed package,
installation, and two serial TinyCalc field-test runs with their causal
closeouts. The preset field test is therefore concluded as `ReleaseAccepted`.
Exactly one Community submission was authorised separately and filed as
`github/spec-kit#4455` on 2026-09-06. Upstream maintainer triage and the
automation-generated draft catalog PR remain pending. Human approvals, product
findings, image impact, and every Level-2 rollout decision remain independent
and open where previously recorded.
