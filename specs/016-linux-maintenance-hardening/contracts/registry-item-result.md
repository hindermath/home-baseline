# Contract: Registry Item Result

Vor der ersten Mutation wird die ausgewählte Registry-Reihenfolge vollständig
in einem isolierten Snapshot festgehalten. Der Leser nutzt einen eigenen
Dateideskriptor; Kindprozesse lesen nicht aus diesem Kanal. Jeder Eintrag
erhält genau einen finalen Status:

`Present | Installed | Planned | Failed | StillMissing`.

Reihenfolge, Required-/Optional-Scope und Versuch bleiben nachvollziehbar.
Required-`Failed` oder `StillMissing` macht den Abschluss nicht erfolgreich;
ausschließlich optionaler Drift bleibt nicht fatal.
