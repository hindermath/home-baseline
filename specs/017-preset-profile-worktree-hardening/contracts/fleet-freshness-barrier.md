# Contract: Fleet Freshness Barrier

## Input

- valides Desired-State-Manifest;
- Level-0-Repository;
- Home-Wurzel;
- Betriebsmodus `CheckOnly | Preview | Update`;
- begrenzte Retry- und Timeoutwerte.

## Sequence

1. Kontroll-Evidence initialisieren.
2. eventuell verwaiste eigene Worktree-Leases prüfen.
3. Level 0 und jedes aktive Git-Ziel in stabiler Manifestreihenfolge fetchen.
4. Die Collection getrennt read-only inventarisieren.
5. jedes Git-Ziel nach aktuellem Fetch klassifizieren.
6. globale Barriereentscheidung atomar speichern.
7. nur bei offener Barriere Domainphasen zulassen.

## Result

Der Report nennt erwartete, versuchte und abgeschlossene Ziele sowie je Ziel
Ref, Commit, Versuch, Dauer, Ahead/Behind, Pull-Entscheidung, Sperrgrund und
nächste Aktion.

## Prohibitions

- kein Home-Sync, Registry-Write, Propagation-Write, Preset-Repair oder
  Toolchain-Write vor der Barriere;
- kein Abbruch der restlichen read-only Inventur nach einem Einzelbefund;
- kein Erfolg bei fehlendem, still gescheitertem oder zeitüberschrittenem
  Fetch.
