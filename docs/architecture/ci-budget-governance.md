# CI-Budget-Governance / CI Budget Governance

**Status / Disposition**: Applicable
**Owner**: home-baseline Feature Owner
**Reviewer**: iSAQB/arc42 Architecture Reviewer
**Restrisiko / Residual risk**: Stufe B und G4 bleiben außerhalb der aktuellen Authority.
**Follow-up**: Stufe B und G4 nur nach neuem, ausdrücklich autorisiertem Lauf beginnen.
**Re-Evaluation**: Bei Runtime-, Fleet-, Authority-, Workflow- oder Ruleset-Änderungen.

## Architekturstatus / Architecture Status

Die Stufe-A-Architektur ist implementiert. Sie erzeugt ausschließlich lokale
oder read-only Evidence und behauptet keine Remote-Konvergenz. Finaler
iSAQB-/arc42-Review am 2026-08-20: `Pass` für Kontextabgrenzung, Bausteine,
Laufzeit, Deployment/Stufen, Qualitätsziele, Risiken und technische Schuld.
Reviewer: iSAQB/arc42 Architecture Reviewer. Kein `Open`-Punkt verbleibt für
Stufe A.

*The Stage-A architecture is implemented. It produces local or read-only
evidence only and never claims remote convergence. The final iSAQB/arc42 review
is recorded again after all user and documentation surfaces are complete.*

## Kontext und Grenzen / Context and Boundaries

Der Level-0-Klon ist die einzige schreibbare fachliche Quelle. Fleet-Manifest,
Profil- und Pfadregistry sowie die inaktiven Workflow-/Ruleset-Templates sind
versionierte Eingaben. GitHub ist ausschließlich eine read-only
Beobachtungsgrenze. Zielrepositorys, Home Runtime, aktive Workflows, Rulesets,
Accounts, Reviewer und G4 bleiben außerhalb der Schreibgrenze.

*The Level-0 clone is the only writable business source. GitHub is a read-only
observation boundary. Target repositories, Home Runtime, active policy and G4
remain outside the write boundary.*

## Bausteine / Building Blocks

1. Bash und PowerShell validieren die Oberfläche und starten genau einen
   Python-Engine-Prozess.
2. Der Vertragskern lädt Profil- und Pfadregistry je einmal, validiert
   Referenzen und hält beide SHA-256-Grenzen getrennt.
3. Fixture- und GitHub-GET-Adapter liefern ein atomar gebundenes Inventory.
4. Pfad-, Workflow- und Kostenplaner erzeugen deterministische Stufe-A-
   Entscheidungen.
5. Der lokale Gate-Runner nutzt Argument-Arrays mit `shell=False`, bindet HEAD
   und Gate-Set-Hash doppelt und publiziert ausschließlich atomare
   Erfolgsevidence.
6. Pre-push-Hook und unabhängiger simulierter Server-Minimal-Gate bilden
   Defense in Depth.

## Laufzeit- und Deployment-Sicht / Runtime and Deployment View

```text
Wrapper -> ein Python-Prozess -> Vertragsprüfung -> Inventory/Pfadentscheidung
        -> Preview ODER lokale Gates -> HEAD/Hash-Revalidierung -> Evidence
```

Stufe A installiert oder aktiviert kein Deployment. Die beiden Templates unter
`scripts/templates/ci-budget-governance/` bleiben inaktiv. `remoteConverged`
ist in jeder Rolloutzeile konstant `false`.

## Qualitätsziele, Risiken und technische Schuld / Quality Goals, Risks and Debt

- Sicherheit: fail-closed Eingaben, sichere Pfade und keine Remote-Schreibverben.
- Nachvollziehbarkeit: getrennte Registry-Hashes, feste ID-Mengen und zehn
  hashgebundene Primary-Gates.
- Portabilität und Zugänglichkeit: identische lineare Bash-/PowerShell-Ausgabe,
  DE zuerst, EN danach, ohne Farbe.
- Risiko: Der gemeinsame Python-Kern bleibt groß. Follow-up-Owner ist der
  Architecture Owner; eine Modulaufteilung wird bei der nächsten strukturellen
  Erweiterung neu bewertet.
- Risiko: Lokale Hooks sind umgehbar. Der unabhängige Serververtrag bleibt
  deshalb zwingend und darf in Stufe B nicht abgeschwächt werden.

## Nicht ausgeführter Handoff Stufe B und G4 / Unexecuted Stage-B and G4 Handoff

Owner für eine spätere Stufe B ist der Fleet Delivery Owner. Blocker ist die
fehlende neue Remote-Mutationsautorität; der aktuelle `LocalImplementation`-
Lauf darf weder Zielrepositorys noch GitHub-Konfiguration ändern. Vor Stufe B
müssen aktueller HEAD, Intake-/Run-State, Live-Inventar, Assignment-Sichtbarkeit,
Budget und Ruleset-Semantik vollständig revalidiert werden.

G4 wurde nicht gestartet. Owner ist der Intake Series Owner. Blocker ist der
nicht abgeschlossene, separat zu autorisierende Stufe-B-Rollout. G4 darf erst
nach dokumentierter Remote-Konvergenz und erneutem Sequencing-Gate beginnen.
Diese Abschnitte sind Handoff-Evidence, keine Aktionsanweisung.

*Stage B needs fresh remote-mutation authority and complete revalidation. G4
was not started and requires separately proven Stage-B convergence plus a new
sequencing gate. This is handoff evidence, not an executed action.*
