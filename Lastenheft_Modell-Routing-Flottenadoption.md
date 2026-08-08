<!-- intake-authoring:begin -->
# Lastenheft: Modell-Routing-Flottenadoption

**Status:** Ready for Intake Review

**Delivery Mode:** MergeAndSync
**Reihenfolge:** 3 von 3; benötigt veröffentlichtes und ZIP-validiertes Preset

## Ziel

Alle registrierten Level-0-/1-/2-Repositories erhalten das optionale Preset im
verwalteten Zwölferprofil. Repository-Dateien enthalten nur Rollen und
Routing-Policy. Jeder Rechner erkennt und speichert seine konkrete Modellwahl
selbst.

*All registered repositories receive the optional preset through the managed
twelve-preset profile. Repositories carry roles and policy only; each computer
discovers and stores its concrete model binding locally.*

## Anforderungen

- **MRFA-001:** Der Profilkatalog ergänzt
  `model-routing-twelve-governance-presets`; Acht-, Neun-, Zehn- und
  Elf-Preset-Profile bleiben kompatibel.
- **MRFA-002:** Die Remote-Freshness-Barriere läuft vor jeder Flottenmutation;
  Dirty, Ahead, Diverged oder fremde Branches werden nicht überschrieben.
- **MRFA-003:** Preset, Agentenflächen, Skripte, Manpage und Wartungsmanifest
  werden über normale nicht leere PRs propagiert.
- **MRFA-004:** Das Ein-Kommando-Wartungsskript prüft nach der Toolchain den
  lokalen Routing-Status. Es führt keinen stillen Refresh aus.
- **MRFA-005:** Ein Refresh braucht aktuelle lokale Autorität und darf weder
  Modellnamen noch private Pfade in Git schreiben.
- **MRFA-006:** Jeder Ziel-PR erhält Exact-Head-, Homogeneity-, Secret- und
  Agentenparitätsnachweis. Null-Schritt-Providerablehnung bleibt von einem
  technischen Pass getrennt.
- **MRFA-007:** Die öffentliche Community-Einreichung erfolgt seriell über das
  offizielle Template; `@mnriem` wird höchstens einmal freundlich angesprochen.

## Abnahme

- alle registrierten Ziele melden das exakte Zwölferprofil;
- zwei Routing-Kommandos erscheinen je Agentenfläche genau einmal;
- lokale Profile sind ignoriert und fehlen in sämtlichen PR-Diffs;
- Wartungs-Check meldet `Aligned`, `RefreshRequired` oder `Blocked` mit exakter
  nächster Aktion;
- alle bearbeiteten Repositories stehen abschließend sauber und `(0 0)` auf
  ihrem kanonischen Default-Branch.

## Grenzen

Das Preset ist öffentlich optional. Seine Flotteninstallation ist lokale
Workspace-Policy, keine allgemeine Spec-Kit-Pflicht. Ein enger Admin-Bypass ist
nur bei grünen technischen Gates, null umsetzbaren Threads und Human Approval
als einzigem offenen Gate zulässig.

## Kopierbare Prompts

<!-- intake-authoring:prompts -->

```text
$speckit-intake-review Lastenheft_Modell-Routing-Flottenadoption.md
```

<!-- spec-kit-command-id: speckit.specify -->
```text
$speckit-specify Use `Lastenheft_Modell-Routing-Flottenadoption.md` as the binding intake. Specify only the managed Level-0/1/2 adoption; keep concrete model bindings machine-local.
```

<!-- spec-kit-command-id: speckit.autonomous -->
```text
$speckit-autonomous Execute `Lastenheft_Modell-Routing-Flottenadoption.md` in delivery mode MergeAndSync. Apply the Remote Freshness Barrier, deliver non-empty fleet PRs, validate exact heads, and do not grant provider administration.
```
<!-- intake-authoring:end -->
