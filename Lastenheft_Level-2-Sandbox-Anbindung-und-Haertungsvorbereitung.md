<!-- intake-authoring:begin -->
# Lastenheft: Level-2-Sandbox-Anbindung und Haertungsvorbereitung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft  
**Status:** Vorbereitung fuer spaetere Spec-Kit-Laeufe, kein gestarteter Lauf  
**Zielgruppe:** Fachinformatiker*innen in Ausbildung, Entwickler*innen, Reviewer und KI-Agenten  
**Scope:** MSL-basierte Level-2-Repositories mit Secure-Development-Basis

## Ziel / Goal

Dieses Lastenheft beschreibt, wie Level-2-Repositories von einer sicheren Entwicklungs-Sandbox profitieren sollen. Es erzeugt nur Intake, Reihenfolge und Vorbereitung. Die eigentliche Haertung einzelner Level-2-Repositories bleibt je Repository ein separater Spec-Kit-Lauf.

*This intake document describes how level-2 repositories should benefit from a secure development sandbox. It creates only intake, ordering, and preparation. The actual hardening of individual level-2 repositories remains a separate Spec Kit run per repository.*

## Kontext / Context

Die zentrale Secure-Development-Basis besteht aus Richtlinie, Checklisten, Sammelband, mitgeltenden Dokumenten und acht Governance-Presets. `absdd-image-sandbox` ist das vorgesehene Referenzprofil fuer eine oeffentlichkeitsfaehige Ausbildungs-Sandbox. Level-2-Repositories bleiben die konkreten Entwicklungs- und Haertungsziele.

## Geltungsbereich / Scope

Dieses Lastenheft gilt fuer Level-2-Repositories, die:

- eine Memory-Safe Language als Primaersprache nutzen oder als MSL-Projekt vorbereitet werden,
- KI-Agenten fuer Analyse, Spezifikation, Planung, Review, Tests oder Codeaenderungen einsetzen,
- spaeter in oder mit `absdd-image-sandbox` bearbeitet werden sollen,
- die Secure-Development-Basis aus `docs/secure-development/` enthalten oder erhalten sollen.

## Nicht-Ziele / Non-Goals

- Kein Start eines Spec-Kit-Laufs.
- Keine technische Haertung eines konkreten Level-2-Repositories.
- Kein automatisches Fuellen von `docs/security/`-Nachweisen.
- Kein Container-Build und keine Aenderung am Sandbox-Image.
- Keine pauschale Pflicht, alle MSL-Toolchains sofort im Sandbox-Image bereitzustellen.

## Anforderungen / Requirements

1. Fuer jedes betroffene Level-2-Repository wird eine konkrete Intake-Datei fuer einen spaeteren Sandbox-gestuetzten Secure-Development-Haertungslauf bereitgestellt.
2. Die Intake-Datei nennt Projektkontext, Runtime, Build/Test-Baseline, Dokumentations-/A11Y-Basis und Agentenflaechen aus dem zentralen Level-2-Register.
3. Die Intake-Datei verweist auf Richtlinie, `CL_12`, `Leitlinie_Sichere-Entwicklungs-Sandbox.md`, vorhandene Secure-Development-Lastenhefte und die acht Governance-Presets.
4. Die Intake-Datei prueft, wie das Projekt sicher in oder mit der Sandbox bearbeitet werden kann: Mounts, Schreibgrenzen, Secrets, Build/Test, SBOM, Scans, KI-Agenten, Statistik und Review.
5. Jede Intake-Datei endet mit einem kopierbaren `/speckit-specify` Prompt.
6. `Lastenheft_Abarbeitungsreihenfolge.md` wird geschuetzt ergaenzt. Branch-spezifische Lastenhefte mit Feature-Branch-Kennung werden nicht erneut eingeplant.

## Erste Zielmenge / Initial Target Set

Die erste konkrete Zielmenge sind die vier C#/.NET-Referenzrepos:

- `RiderProjects/TuiVision`
- `RiderProjects/TinyCalc`
- `RiderProjects/TinyPl0`
- `RiderProjects/InventarWorkerService`

## Akzeptanzkriterien / Acceptance Criteria

- Die zentrale Sandbox-Leitlinie ist vorhanden und in Richtlinie, `CL_12`, Sammelband, README und Verzahnungsdokument referenziert.
- Jedes der vier C#/.NET-Referenzrepos besitzt `Lastenheft_Sandbox-gestuetzte-Secure-Development-Haertung.md`.
- Die Reihenfolgedateien ordnen das neue Lastenheft nach dem bestehenden Secure-Development-Hardening-Intake ein.
- Jede neue Intake-Datei ist DE/EN-verstaendlich genug fuer Auszubildende auf CEFR-B2-Niveau.
- Keine Datei behauptet, dass die technische Haertung bereits umgesetzt wurde.

## Evidenzpfade / Evidence Paths

| Artefakt | Erwartete Evidenz |
|---|---|
| Zentrale Leitlinie | `docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md` |
| Zentrale Reihenfolge | `Lastenheft_Abarbeitungsreihenfolge.md` |
| Level-2-Intake | `Lastenheft_Sandbox-gestuetzte-Secure-Development-Haertung.md` im jeweiligen Repo |
| Sandbox-Kontext | `container-images/absdd-image-sandbox` und dortige `docs/security/`-Nachweise |
| Preset-Kontext | `.specify/presets/`, `specify preset list`, Preset-Versionen und Prioritaeten |

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_Level-2-Sandbox-Anbindung-und-Haertungsvorbereitung.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation fuer die Vorbereitung MSL-basierter Level-2-Repositories auf spaetere Sandbox-gestuetzte Secure-Development-Haertung.

Ziel: Level-2-Repositories sollen sicher, nachvollziehbar und ausbildungsgeeignet in oder mit der absdd-image-sandbox bearbeitet werden koennen. Die Spezifikation darf noch keine technische Haertung eines konkreten Level-2-Repositories starten.

Beruecksichtige:
- Richtlinie Sichere Entwicklung und CL_12 Agentische KI in Sandbox-Umgebungen.
- Leitlinie_Sichere-Entwicklungs-Sandbox.md.
- Die acht Governance-Presets mit auditfaehigen Applicable/N/A/Open-Entscheidungen.
- MSL-Scope: Rust, Swift, C#, F#, Java, Kotlin, Scala, Go, Dart, Python, Ruby, JavaScript, TypeScript, Haskell, OCaml, Erlang, Elixir, Ada und SPARK.
- Die vier C#/.NET-Referenzrepos TuiVision, TinyCalc, TinyPl0 und InventarWorkerService als erste Zielmenge.
- Keine Spec-Kit-Implementierung und keine Projekt-Haertung in diesem Lauf.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Level-2-Sandbox-Anbindung-und-Haertungsvorbereitung.md Fuehre den vollstaendigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake und bewahre alle Anforderungen, Nicht-Ziele, Sicherheits-, A11Y-, Plattform-, Evidence- und Abnahmegrenzen. Implementiere und validiere nur lokal. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
