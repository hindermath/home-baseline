# Ausgewogenes Spec-Kit-Modell-Routing / Balanced Spec Kit Model Routing

## Entscheidung und Zweck / Decision and purpose

Dokumentationsauswirkung: `UpdateRequired`.

Die zwölf Presets des verwalteten Flottenprofils erhalten einen
providerneutralen Kommando-zu-Rolle-Vertrag. Konkrete Agenten- und Modellnamen
bleiben in lokalen Runner-Profilen. Ein sequenzieller autonomer Lauf darf das
Modell nur zwischen abgeschlossenen Prozessen wechseln; Zustand, Preflight und
Ergebnis werden dabei SHA-256-gebunden. Fehlende Bindungen blockieren ohne
stillen Fallback.

*Documentation impact: `UpdateRequired`. The managed twelve-preset profile gains
a provider-neutral command-to-role contract. Concrete agent and model names
remain in local runner profiles. A sequential autonomous run may change models
only between completed processes with SHA-256-bound state, preflight, and
result evidence. Missing bindings fail closed without silent fallback.*

## Vertrag / Contract

| Rolle / Role | Typische Aufgaben / Typical work |
|---|---|
| `frontier-reasoning` | semantische Intake-, Specify-, Clarify-, Plan-, Tasks- und Analyze-Entscheidungen |
| `long-running-implementation` | `speckit.implement` und laengere Implementierungsphasen |
| `coding-review` | Retrospektive und Kampagnenkonsolidierung |
| `fast-mechanical` | Read-, Status- und Next-Abfragen |
| `script-only` | Stop und deterministische Validatoren ohne Modellprozess |

Wenn mehrere aktive Presets dasselbe Kommando deklarieren, gewinnt die
staerkste Rolle. Die konkrete lokale Codex-Bindung ordnet diesen Rollen jeweils
ein geeignetes starkes oder leichtgewichtiges Modell zu. Modellkennungen und
Reasoning-Stufen sind nicht Teil versionierter Feature-Anforderungen.

*When several active presets declare the same command, the strongest role wins.
The local Codex binding maps these roles to suitable frontier or lightweight
models. Model identifiers and reasoning levels are not part of versioned
feature requirements.*

## Dokumentationsvertrag / Documentation contract

- **Quelle und Owner / Source and owner:** Kanonische Quellen sind
  `specs/spec-kit-presets/*/model-routing.json`, die beiden Autonomous-Presets
  und diese Arbeitsnotiz; Owner sind die Level-0-Maintainer.
- **Betroffene Ausgaben / Outputs:** Preset-README, Lebenszyklus-, Runner- und
  Manpage-Dokumentation, Agenten-Addenda, generierte Kommandooberflaechen und
  gemeinsame Agent-Guidance.
- **Zielgruppen und Leserpfade / Audiences and reader paths:** Maintainer lesen
  zuerst diese Notiz und danach die Preset-Handbuecher; Operatoren verwenden
  Runner-Hilfe und Statusausgabe; Lernende benoetigen keine Modellkenntnis.
- **Navigation und Dokumentklasse / Navigation and class:** Dieses Work-Item ist
  der Level-0-Entscheidungsnachweis. Die Preset-READMEs bleiben die
  nutzerseitigen Einstiege; kein zusaetzlicher Hauptnavigationspunkt ist noetig.
- **Sprache und Barrierefreiheit / Language and accessibility:** Deutsch steht
  vor Englisch. Rollen, Status, Abhaengigkeiten und naechste Schritte bleiben
  textorientiert und ohne farbabhaengige Bedeutung nutzbar.
- **Plattform- und Beispielnachweis / Platform and example evidence:** Der
  PowerShell-7-Kern ist plattformneutral; der Bash-Wrapper ist fuer macOS und
  Linux. Synthetische Fixtures pruefen Prozesswechsel und Fail-Closed ohne
  Providerzugriff.
- **Distribution:** Preset-Quellen sind `sourceOnly`; gemeinsame Agent-Guidance
  ist `homeRuntime` und benoetigt nach der Source-Validierung einen Home-Sync.
- **Re-Evaluation:** Bei neuer Rolle, neuem Preset-Kommando, geaendertem lokalen
  Agenten-CLI-Vertrag oder erweitertem Runner-Provider erneut pruefen.

## Evidence

- zwölf kanonische `model-routing.json` und zwei bytegleiche Preset-Spiegel;
- Bash- und PowerShell-State-Validatoren;
- synthetischer Routing-, Prozessgrenz- und Fail-Closed-Test;
- bestehende Parallel-Koordinator-, Konsolidierungs- und
  Preset-Abhaengigkeitstests;
- PSScriptAnalyzer, Script-Reference-Renderer, Zwölf-Preset-Matrixcheck und
  read-only Modell-Preflights fuer die lokalen Rollenbindungen.

## Produktisierung 2026-08-09 / Productization 2026-08-09

Das optionale Preset `model-routing-governance` v0.1.0 konkretisiert den
Vertrag mit den read-only Status- und ausdrücklich autorisierten
Refresh-Kommandos. Codex wird über `model/list`, Antigravity über das lokale
`agy models`-Inventar geprüft. Claude und Copilot bleiben auf die Validierung
ausdrücklich konfigurierter Kandidaten begrenzt; OpenCode bleibt
`ConfiguredOnly`. Unbekannte oder mehrdeutige Zuordnungen blockieren.

*The optional v0.1.0 preset provides read-only status and explicitly authorized
refresh commands. Codex uses `model/list`; Antigravity uses its local model
inventory. Other harnesses retain documented fail-closed proof boundaries.*
