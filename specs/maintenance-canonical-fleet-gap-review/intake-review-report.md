# Wartungsbefund: Lastenheft-Abdeckungsreview

**Review-ID:** `22275e90-59dd-4c62-ad42-b539b3f067d2`

**Modus:** `Series`

**Ergebnis:** `NeedsRemediation`
**Delivery-Autoritaet fuer die Korrektur:** `MergeAndSync`

## Ergebnis

Kein zukuenftiger aktiver Spec-Kit-Lauf behebt den beobachteten Befund
verbindlich:

- Feature 009 definiert das Desired-State-Manifest und begrenzt die
  Propagation auf aktive `canonical-fleet`-Ziele. Das Lastenheft ist
  historisch und wird laut Abarbeitungsreihenfolge nicht erneut ausgefuehrt.
- Das Intake-Sequencing-Bootstrap-Lastenheft fordert ein getrenntes
  Elf-Preset-Profil und dessen Flottennachweis. Es ist kein zukuenftiger
  aktiver Serienknoten.
- Die aktiven Windows- und Preset-/Worktree-Intakes bewahren ausdruecklich das
  bisherige Zehn-Preset-Profil. Das Linux-Intake behandelt Paketiteration,
  Exitcodes und Swift. Das TUI-Intake konsumiert die Engine und implementiert
  Registry-, Discovery- oder Propagationslogik nicht neu.

*No future active Spec Kit run is contractually responsible for this defect.
Feature 009 already owns manifest-bounded propagation but is historical. The
delivered sequencing intake already owns the separate eleven-preset profile
but is not a future active node. The remaining active maintenance intakes
either preserve the ten-preset baseline or cover different concerns.*

## Findings

| ID | Schweregrad | Befund | Disposition |
|---|---|---|---|
| `IR001` | High | Dateisystemweite Erkennung kann nicht-kanonische Legacy-Checkouts erneut registrieren und propagieren. | Sofortige, manifestgebundene Korrektur |
| `IR002` | High | Die operative Registry verwendet trotz ausgeliefertem Elf-Preset-Profil weiterhin das Zehn-Preset-Profil. | Sofortige lokale Migration und Flottennachweis |

## Abgrenzung

Die Review-Dateien dokumentieren nur die Abdeckungsentscheidung. Sie starten
keinen Spec-Kit-Lauf und veraendern keines der geprueften Lastenhefte.

## Naechste Aktion

Manifestgebundene Zielerkennung und Regressionstests implementieren, die
lokale Registry auf das Elf-Preset-Profil migrieren, per `MergeAndSync`
ausliefern und danach den Wartungs-Dry-run sowie `--repair-drift` ausfuehren.
