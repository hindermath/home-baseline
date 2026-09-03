# Evidence-Matrix: Home Baseline ↔ ABSDD

| Gate | Lokale Evidence | Ergebnis | Nächste Entscheidung |
|---|---|---|---|
| baseline | Home Baseline 3.2.0, Zwölfer-Profil, ABSDD 3.1.0 | Ready | Delta prüfen |
| delta | Vertrag, Befehle, Runbooks, Intake- und Serienlineage | Ready | Draft-PR prüfen |
| closure | PR #264 technisch validiert; Copilot-Review durch Repository-Owner ausdrücklich abbedungen | NeedsRemediation | Positionen 14–17 und menschliche Freigaben separat autorisieren |
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
aus dem veröffentlichten ZIP. Der praktische Feldtest bleibt eine getrennte
nächste Phase; Community-Einreichung und menschliche Freigaben wurden nicht
ausgelöst.

## English

The baseline and handoff delta are inspectable. PR #264 is technically
validated, with the missing Copilot review explicitly accepted as a bounded
risk by the repository owner. Closure and image impact remain open because the
later ABSDD adoption and human authorizations have not been executed.

The public v0.1.0 repository, tag, and release are available. The immutable tag
archive was verified in a fresh thirteen-preset Spec Kit project with matching
Bash and PowerShell results and a read-only status proof. Practical field
evaluation remains the next separate phase; no Community submission or human
approval was inferred.
