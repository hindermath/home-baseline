# Evidence-Matrix: Home Baseline ↔ ABSDD

| Gate | Lokale Evidence | Ergebnis | Nächste Entscheidung |
|---|---|---|---|
| baseline | Home Baseline 3.2.0, Zwölfer-Profil, ABSDD 3.1.0 | Ready | Delta prüfen |
| delta | Vertrag, Befehle, Runbooks, Intake- und Serienlineage | Ready | Draft-PR prüfen |
| closure | Draft-PR und menschliche Freigaben | NeedsRemediation | Technische Prüfung abschließen |
| image-impact | ABSDD Commit 7adaeac; keine Änderung ausgeführt | NeedsRemediation | Position 17 separat autorisieren |

Technische Validierung, Pilotfreigabe, Projektabnahme und allgemeine Freigabe
sind nicht austauschbar. Der heutige Nachweis gewährt keine der drei
menschlichen Freigaben. HOSK/GWDG ist nur externer Vergleich.

## English

The baseline and handoff delta are inspectable. Closure and image impact remain
open because the Draft PR and later ABSDD adoption have not been approved and
executed. No human authorization is inferred.
