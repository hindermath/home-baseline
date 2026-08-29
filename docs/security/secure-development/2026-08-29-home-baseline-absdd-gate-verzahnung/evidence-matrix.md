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

## English

The baseline and handoff delta are inspectable. PR #264 is technically
validated, with the missing Copilot review explicitly accepted as a bounded
risk by the repository owner. Closure and image impact remain open because the
later ABSDD adoption and human authorizations have not been executed.
