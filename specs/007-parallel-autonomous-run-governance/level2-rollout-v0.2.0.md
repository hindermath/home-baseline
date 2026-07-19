# Level-2-Rollout v0.2.0

## Deutsch

### Umfang

Am 2026-07-19 wurde die freigegebene Acht-Preset-Matrix in alle sauberen,
registrierten Level-2-Ziele mit aktiver Governance-Preset-Policy ausgerollt.

| Gruppe | Validierte Repositories |
|---|---:|
| InventarDb | 1 |
| Rider-Referenzprojekte | 4 |
| Secure OrderDesk | 6 |
| Secure ServiceHarvester | 6 |
| Container-Images und ABS-DD-Sandbox | 2 |
| Secure CaseTracker | 6 |
| **Gesamt** | **25** |

Jedes Ziel enthaelt exakt die acht IDs und die freigegebenen
Version-/Prioritaets-Paare aus
`scripts/config/spec-kit-governance-presets.json`. Das neue Preset ist
`parallel-autonomous-run-governance` v0.2.0 mit Prioritaet `80`.

### Ablauf und Befunde

1. Alle Ziele wurden vor dem Schreiben auf Branch, Arbeitsbaum und
   `HEAD == origin/main` geprueft.
2. Der Dry-Run zeigte nur die erwartete Preset-Aktualisierung.
3. Ein Download-Timeout trat nach einem Teilupdate von
   `SecureOrderDesk-CSharp` auf. Der Stand wurde pro Repository gelesen und nur
   in den 14 noch unvollstaendigen Zielen ohne `--force` fortgesetzt.
4. Die sechs Secure-CaseTracker-Feldtest-Repositories wurden gezielt von der
   experimentellen Version `0.1.2` auf `0.2.0` aktualisiert.
5. Unnoetige Neu-Erzeugung bereits aktueller Presets aus dem ersten
   `--force`-Abschnitt wurde in sechs zuvor nachweislich sauberen
   Arbeitsbaeumen entfernt. Danach wurde dort nur das achte Preset installiert.
6. Die maschinenlesbare Abschlusspruefung meldete
   `validated=25 errors=0`.
7. Ein weiterer Installer-Lauf meldete alle acht Presets in allen 25 Zielen
   als vorhanden und unveraendert.
8. Das lokale Betriebsregister verwendet fuer alle betroffenen Eintraege
   `standard-eight-governance-presets`.

`C64Projects/cc65` blieb wegen eines fremden Arbeitsbranches und 23 bereits
vorhandener Aenderungen vom schreibenden Preset-Rollout ausgenommen. Nur sein
lokaler Profilvermerk wurde auf den Kompatibilitaetsnamen der aktuellen Matrix
migriert; Repository-Dateien wurden nicht veraendert.

## English

### Scope

On 2026-07-19, the released eight-preset matrix was rolled out to every clean,
registered Level-2 target with an active governance-preset policy.

| Group | Validated repositories |
|---|---:|
| InventarDb | 1 |
| Rider reference projects | 4 |
| Secure OrderDesk | 6 |
| Secure ServiceHarvester | 6 |
| Container images and ABS-DD sandbox | 2 |
| Secure CaseTracker | 6 |
| **Total** | **25** |

Every target contains exactly the eight IDs and the released version/priority
pairs from `scripts/config/spec-kit-governance-presets.json`. The new preset is
`parallel-autonomous-run-governance` v0.2.0 with priority `80`.

### Procedure and findings

1. Branch, working tree, and `HEAD == origin/main` were checked before writes.
2. The dry run showed only the expected preset update.
3. A download timeout occurred after a partial update of
   `SecureOrderDesk-CSharp`. Repository state was inspected, and only the 14
   incomplete targets were resumed without `--force`.
4. The six Secure CaseTracker field repositories were updated specifically
   from experimental version `0.1.2` to `0.2.0`.
5. Unnecessary regeneration of already-current presets from the initial
   `--force` segment was removed from six previously verified clean working
   trees. Only the eighth preset was then installed there.
6. The machine-readable final check reported
   `validated=25 errors=0`.
7. A further installer run reported all eight presets present and unchanged in
   all 25 targets.
8. The local operational registry now uses
   `standard-eight-governance-presets` for all affected entries.

`C64Projects/cc65` was excluded from the writing preset rollout because it was
on a separate work branch with 23 pre-existing changes. Only its local profile
note was migrated to the compatibility name for the current matrix; no
repository file was changed.
