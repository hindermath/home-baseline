# Intake Review Report: Active Lastenhefte

## Ergebnis / Outcome

`Ready`

- Review-ID: `5ce575e0-90a0-4946-b183-b8c3e1d83a71`
- Ersetzt: `dfcf1ff5-95ad-488a-879a-65e81e8e350f`
- Schema: `1.1`
Request SHA-256:
`df0b897e276ab82eaa6ad90f76abad3370211a897942a5d094da60b2a421e187`

Alle 14 aktiven Root-Intakes sind einzeln und als geordnete, hashgebundene
Serie geprüft.
Identität, Ziel, Scope, Nicht-Ziele, Anforderungen, Abnahme, Evidence,
Delivery Authority und Prompt-Vertrag sind für die spätere Spec-Kit-Planung
ausreichend bestimmt. Es bleiben keine offenen Critical-, High-, Medium- oder
Low-Findings. Der aktualisierte Position-1-Intake bildet die aktuelle
32-Repository-Flotte, die drei vorhandenen und zehn gewuenschten
Preset-Repositories sowie die bereits ausgelieferten Bash-3.2- und
Toolchain-Baselines ab. Seine Grenze zur flottenweiten
Remote-Freshness-Haertung auf Position 4 ist entscheidungsvollstaendig.

*All 14 active root intakes were reviewed individually and as an ordered
request-bound series. Identity, goal, scope, non-goals, requirements,
acceptance, evidence, delivery authority, and prompt contracts are sufficiently
defined for later Spec Kit planning. The updated position-1 intake reflects
the current 32-repository fleet, the three present and ten desired preset
repositories, and the already delivered Bash 3.2 and toolchain baselines. Its
boundary to the fleet-wide position-4 Remote Freshness hardening is
decision-complete. No Critical, High, Medium, or Low finding remains.*

## Abdeckung / Coverage

- Aktive Intakes: 14/14
- Intake-Creator-Marker: 14/14
- Gültige Receipts: 14/14, davon 1 Schema 2.0 und 13 Schema 1.1
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
6. Der breite Wartungsintake unterscheidet nun die 32 registrierten
   Level-1-/Level-2-Repositories, drei aktuell ausgecheckte und zehn
   gewuenschte Preset-Repositories. Die portable Acht-Preset-Standardmatrix
   bleibt davon ausdruecklich unberuehrt.
7. Der Position-4-Intake verlangt nun einen vollständigen Flotten-Preflight vor
   Home-Sync, Preset-Reparatur, Propagation, Paketmanager-, Toolchain- oder
   anderen mutierenden Folgephasen. Nur nachweislich sichere
   Fast-forward-Fälle dürfen gepullt werden; Einzelbefunde brechen die
   restliche read-only Bestandsaufnahme nicht ab.
8. Der bisherige Schema-1.0-Series-Review wurde unverändert archiviert. Der
   neue Review bindet Request-Pfad und Hash, deklariert alle Roots und
   validiert Zielmenge, Rollen, Reihenfolge, Referenzen und Azyklizität.
9. Der Position-1-Intake wurde als nachvollziehbare Schema-2.0-Supersession
   aktualisiert. PR #90 und die optionale Toolchain-Klassifikation sind
   verbindliche Baselines statt erneut zu implementierender Arbeit. Position 4
   behaelt die Ownership fuer Remote-Freshness-, Default-Branch-, Worktree- und
   Hard-Abort-Hardening.

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

`$speckit-specify Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md`

Vor dem Lauf sind weiterhin die aktuelle Benutzerfreigabe und der unveraenderte
`LocalImplementation`-Vertrag zu pruefen. Der Review startet weder Specify noch
einen autonomen Lauf automatisch.
