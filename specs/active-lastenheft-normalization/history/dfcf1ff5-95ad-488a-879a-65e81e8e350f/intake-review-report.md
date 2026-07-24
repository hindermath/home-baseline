# Intake Review Report: Active Lastenhefte

## Ergebnis / Outcome

`Ready`

- Review-ID: `dfcf1ff5-95ad-488a-879a-65e81e8e350f`
- Ersetzt: `4c059d46-adda-48ef-934a-a7158ca565bc`
- Schema: `1.1`
Request SHA-256:
`37d1d3b87d9f4057f2c7b6c54e11a289c2cce516c383807e4b2175733b9f32bc`

Alle 14 aktiven Root-Intakes sind einzeln und als geordnete, hashgebundene
Serie geprüft.
Identität, Ziel, Scope, Nicht-Ziele, Anforderungen, Abnahme, Evidence,
Delivery Authority und Prompt-Vertrag sind für die spätere Spec-Kit-Planung
ausreichend bestimmt. Es bleiben keine offenen Critical-, High-, Medium- oder
Low-Findings. Die flottenweite Remote-Freshness-Barriere ist in PWH-012 bis
PWH-015 und AC-013 bis AC-017 entscheidungsvollständig beschrieben.

*All 14 active root intakes were reviewed individually and as an ordered
request-bound series. Identity, goal, scope, non-goals, requirements,
acceptance, evidence, delivery authority, and prompt contracts are sufficiently
defined for later Spec Kit planning. The fleet-wide Remote Freshness Barrier
is decision-complete. No Critical, High, Medium, or Low finding remains.*

## Abdeckung / Coverage

- Aktive Intakes: 14/14
- Intake-Creator-Marker: 14/14
- Gültige Receipts: 14/14
- Specify-Prompts: 14/14
- Autonomous-Prompts: 14/14
- Delivery Authority: 14/14 `LocalImplementation`
- Schema-1.1-Request-Bindung: 1/1
- Deklarierte und validierte Roots: 8/8
- Eindeutige, reihenfolgekonforme DAG-Kanten: 9/9
- Offene Fragen: 0
- Akzeptierte Risiken: 0

## Behobene Vorbefunde / Resolved Preliminary Findings

1. Das Linux-/Ubuntu-Lastenheft verwies noch auf die TUI an Position 4. Es
   nennt nun die zusätzliche Härtung auf Position 4 und die TUI auf Position 5.
2. Das TUI-Lastenheft prüfte nur den breiten Wartungsintake. Metadaten, Gate,
   Acceptance und Prompts binden jetzt alle vier Vorgänger ein.
3. Das Windows-Lastenheft beschreibt nun die vollständige Folge bis zum
   TUI-Gate, ohne Linux oder die Position-4-Härtung als technische Abhängigkeit
   der Windows-Arbeit auszugeben.
4. Elf Alt-Intakes wurden mit nachgewiesenem Git-Blob als `LegacyAdoption`
   übernommen; zwei Creator-Intakes wurden regulär supersediert und der neue
   Position-4-Intake auf Schema 1.1 ausgerichtet.
5. Frühere oder fehlende Prompt-Blöcke wurden auf genau einen Specify- und
   einen Autonomous-Prompt normalisiert. Die aktuelle Normalisierung erteilt
   keine Remote-Autorität.
6. Der breite Wartungsintake nennt nun die aktuelle Flottenkardinalität von
   zehn separat gewarteten Preset-Repositories. Die portable
   Acht-Preset-Standardmatrix bleibt davon ausdrücklich unberührt.
7. Der Position-4-Intake verlangt nun einen vollständigen Flotten-Preflight vor
   Home-Sync, Preset-Reparatur, Propagation, Paketmanager-, Toolchain- oder
   anderen mutierenden Folgephasen. Nur nachweislich sichere
   Fast-forward-Fälle dürfen gepullt werden; Einzelbefunde brechen die
   restliche read-only Bestandsaufnahme nicht ab.
8. Der bisherige Schema-1.0-Series-Review wurde unverändert archiviert. Der
   neue Review bindet Request-Pfad und Hash, deklariert alle Roots und
   validiert Zielmenge, Rollen, Reihenfolge, Referenzen und Azyklizität.

## Seriengrenzen / Series Boundaries

- Die Positionen 1 bis 4 müssen jeweils abgeschlossen sein, bevor Position 5
  beginnen darf.
- Innerhalb von Position 4 muss der Remote-Freshness-Preflight für Level 0 und
  alle registrierten Level-1-/Level-2-Repositories abgeschlossen sein, bevor
  eine mutierende Folgephase beginnt.
- Die Positionen 6 bis 14 bleiben fachlich getrennte Intakes; die sichtbare
  Reihenfolge ist kein stiller Auftrag, sie gemeinsam auszuführen.
- Historische Root-Lastenhefte und 222 Lernreihen-Intakes wurden nicht
  verändert und sind nicht Teil dieses Reviews.
- Kein Review, Specify- oder Autonomous-Lauf wird durch diese Evidence
  automatisch gestartet.

## Nächste Aktion / Next Action

Der nächste zulässige Befehl ist:

`$speckit-specify Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md`

Vor dem Lauf sind weiterhin das Vorgänger-Gate, die aktuelle Benutzerfreigabe
und der unveränderte `LocalImplementation`-Vertrag zu prüfen. Der Review startet
weder Specify noch einen autonomen Lauf automatisch.
