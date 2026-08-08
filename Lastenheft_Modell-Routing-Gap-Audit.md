<!-- intake-authoring:begin -->
# Lastenheft: Modell-Routing-Gap-Audit

**Status:** Ready for Intake Review

**Delivery Mode:** MergeAndSync
**Reihenfolge:** 1 von 3 innerhalb der begrenzten Modell-Routing-Serie

## Zielgruppe und Zweck

Dieses Lastenheft richtet sich an Maintainer sowie Lernende in IT-Berufen ab
dem ersten Lehrjahr. **Modell-Routing** ordnet eine stabile Arbeitsrolle einem
lokal verfügbaren KI-Modell zu. Der Audit prüft read-only, welche Harnesses,
Modelle, Rollenverträge, Agentenflächen und Flottenpfade bereits belastbar
nachgewiesen sind.

*This intake targets maintainers and first-year-or-later IT learners. Model
routing maps a stable work role to a locally available AI model. The audit
inspects harness, role, agent-surface, and fleet evidence without changing
provider or product state.*

## Verbindliche Quellen

- `docs/work-items/2026-08-07-balanced-spec-kit-model-routing.md`
- alle elf bestehenden `specs/spec-kit-presets/*/model-routing.json`
- lokale Harness-Nachweise für Codex, Antigravity, Claude, Copilot und OpenCode
- Flottenregister und Preset-Profile von Level 0, Level 1 und Level 2

## Anforderungen

- **MRGA-001:** Alle erkannten Harnesses werden mit ausführbarer Version,
  Discovery-Fähigkeit und belastbarer Proof-Grenze inventarisiert.
- **MRGA-002:** Die Rollen `frontier-reasoning`,
  `long-running-implementation`, `coding-review`, `fast-mechanical` und
  `script-only` werden gegen alle Spec-Kit-Kommandos geprüft.
- **MRGA-003:** Konkrete Modellnamen, Reasoning-Stufen, private Pfade und
  Zugangsdaten bleiben maschinenlokal und außerhalb versionierter Intakes,
  Specs, Pläne und Tasks.
- **MRGA-004:** Mehrdeutige, unbekannte oder nicht nachweisbare Zuordnungen
  werden `Blocked`; es gibt keinen stillen Provider-Fallback.
- **MRGA-005:** Level-0-/1-/2-Propagation, Agentenparität und das bestehende
  Acht-/Neun-/Zehn-/Elf-Preset-Profil werden vollständig erfasst.
- **MRGA-006:** Der Audit erzeugt eine Gap-Matrix mit Owner, Evidence,
  Restrisiko, nächster Aktion und Entscheidung `Covered`, `Partial`, `N/A` oder
  `FollowUp`.

## Nicht-Ziele und Grenzen

Keine Modelle deployen, keine Providerkonten ändern, keine Secrets lesen,
keine Feature-Ausführung starten und keine Produktlogik ändern. Externe
Modellverfügbarkeit ist eine lokale Momentaufnahme, keine dauerhaft
versionierbare Wahrheit.

## Abnahme

- alle fünf Rollen und alle aktiven Agentenflächen sind genau einmal bewertet;
- Codex-Enumeration und Antigravity-Namensinventar sind reproduzierbar belegt;
- Harnesses ohne sichere Enumeration besitzen eine ehrliche Validierungsgrenze;
- null ungeklärte Critical-/High-Lücken vor der Preset-Produktisierung;
- Bericht ist Deutsch zuerst, Englisch danach, CEFR B2 und textorientiert.

## Kopierbare Prompts

<!-- intake-authoring:prompts -->

```text
$speckit-intake-review Lastenheft_Modell-Routing-Gap-Audit.md
```

<!-- spec-kit-command-id: speckit.specify -->
```text
$speckit-specify Use `Lastenheft_Modell-Routing-Gap-Audit.md` as the binding intake. Create only a read-only model-routing gap-audit feature. Do not implement routing, change provider state, or perform remote delivery.
```

<!-- spec-kit-command-id: speckit.autonomous -->
```text
$speckit-autonomous Execute `Lastenheft_Modell-Routing-Gap-Audit.md` as a complete read-only audit in delivery mode MergeAndSync. Preserve machine-local model identities, use no provider administration, and do not start the next intake.
```
<!-- intake-authoring:end -->
