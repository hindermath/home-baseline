# Contract: Desired-State Fleet Manifest

Kanonischer Pfad:
`scripts/config/agentic-workspace-fleet.json`; Schema:
`scripts/config/agentic-workspace-fleet.schema.json`.

Das Manifest enthält genau die 32 aktiven `canonical-fleet`-Git-Ziele, die
Collection `SpecKitPresetProjects` und zehn aktive `preset`-Git-Ziele.
Level 0 wird nicht dupliziert.

Vor Mutation müssen JSON-Schema und Semantik bestehen:

- eindeutige IDs, Pfade und normalisierte aktive Git-Remotes;
- HOME-relative `/`-Pfade ohne leere Segmente, `.` oder `..`;
- Git-Ziele benötigen Remote, Forge und Default-Branch;
- Collections verbieten Git-Felder und verwenden `declared-targets`;
- jedes Level-2-Ziel liegt unter einem aktiven Level-1- oder Collection-Pfad;
- inaktive Ziele werden weder erzeugt noch aktualisiert noch propagiert.

Schemafehler liefern Exitcode 2, genaue Ziel- oder JSON-Pointer-Evidence und
verhindern alle Flottenmutationen.
