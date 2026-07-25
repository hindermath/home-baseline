<!-- intake-authoring:begin -->
# Lastenheft: Didactic Script and Config Comment Hardening

**Repository:** home-baseline
**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** vorbereitet fuer separaten Kommentar-Haertungslauf
**Stand:** 2026-07-03

## 1. Zweck / Purpose

Dieses Lastenheft bereitet einen spaeteren Spec-Kit-Lauf fuer didaktische,
code-nahe Kommentare in Skripten und Konfigurationsdateien vor. Ziel ist nicht
mehr Text an jeder Stelle, sondern bessere Nachvollziehbarkeit dort, wo
Auszubildende, Maintainer oder KI-Agenten sonst nur sehen, dass ein Ablauf
funktioniert, aber nicht warum er so gebaut wurde.

*This requirements document prepares a later Spec Kit run for didactic,
code-near comments in scripts and configuration files. The goal is not more
text everywhere, but better traceability where apprentices, maintainers, or AI
agents would otherwise see that a flow works without understanding why it is
built that way.*

### 1.1 Reihenfolge und Abhaengigkeiten / Order and Dependencies

Dieser Intake steht auf Position 12. Er prueft die gelieferten Flaechen aus
CI/CD auf Position 9, PowerShell-Cmdlets auf Position 10 und
Skript-Dokumentation auf Position 11. Sein Ergebnis ist eine bindende Eingabe
fuer das abschliessende GSDB-Audit auf Position 13.

*This intake is position 12. It reviews surfaces delivered by positions 9, 10,
and 11 and provides binding input for the final audit at position 13.*

## 2. Ausgangslage / Current State

`Lastenheft_Script_Dokumentation.md` behandelt Unix-Manpages und PowerShell
comment-based help. Dieses Lastenheft ist bewusst enger und behandelt
Kommentare in der eigentlichen Skript- und Konfigurationslogik.

Die relevante Tooling-Flaeche umfasst aktuell:

- Shell/Bash-Skripte in `scripts/` und `.specify/`
- PowerShell-Skripte in `scripts/` und `.specify/`
- YAML/YML-Dateien in `.github/`, `.specify/` und Preset-/Workflow-Kontexten
- JSON-Konfigurationen, die eventuell auf JSONC migriert werden koennen

Standard-JSON erlaubt keine Kommentare. JSONC erlaubt Kommentare, aber nur,
wenn alle Leser und Werkzeuge das Format unterstuetzen oder eine robuste
Konvertierung nach strict JSON existiert. Deshalb wird JSONC als eigener
Pruef- und Migrationspfad behandelt.

## 3. Scope

In Scope:

- nicht-triviale Logik in Bash- und PowerShell-Skripten
- Hilfsbibliotheken unter `scripts/lib/`
- Spec-Kit-bezogene lokale Skripte unter `.specify/`
- CI-/Workflow-YAML, besonders bei Shell-Bloecken, Matrix-Logik und
  plattformabhaengigen Schritten
- repo-eigene JSON-Konfigurationsdateien als JSONC-Kandidaten, wenn alle
  Konsumenten kompatibel gemacht werden koennen
- Evidence-Datei fuer gepruefte Dateien, Flow-Bereiche und Entscheidungen

Out of Scope:

- keine Verhaltensaenderung an Skripten ohne direkten Kommentar- oder
  JSONC-Migrationsgrund
- keine pauschale Kommentierung jeder Funktion, jeder Variable oder jeder
  Zuweisung
- keine Manpage- oder PowerShell-Help-Vervollstaendigung; das bleibt Scope von
  `Lastenheft_Script_Dokumentation.md`
- kein PowerShell-Cmdlet-Umbau; das bleibt Scope von
  `Lastenheft_PowerShell_Cmdlets.md`
- keine Umstellung externer Spec-Kit-Manifeste auf JSONC, solange externe
  Tools strict JSON oder stabile `.json`-Pfade erwarten

## 4. JSONC-Regel / JSONC Rule

JSONC ist fuer kommentierungswuerdige, repo-eigene Konfigurationen erlaubt,
wenn der spaetere Spec-Kit-Lauf vor der Umstellung alle Konsumenten nachweist
und anpasst.

Voraussichtliche JSONC-Kandidaten:

- `scripts/config/spec-kit-governance-presets.json`
- `scripts/config/level2-repository-registry.example.json`

Vorerst strict JSON:

- `.specify/init-options.json`
- `.specify/integration.json`
- `.specify/integrations/*.manifest.json`
- `.specify/workflows/workflow-registry.json`
- Release-Please-Konfigurationen, solange externe Tools strict JSON erwarten

Wenn eine Datei nach JSONC migriert wird, muessen Bash, PowerShell und
gegebenenfalls Python-Leser entweder JSONC direkt lesen oder Kommentare
deterministisch entfernen, bevor strict-JSON-Parser genutzt werden.

## 5. Kommentar-Intensitaet / Comment Intensity

Die Zielintensitaet ist moderat und reviewbar:

- Datei-/Modulkommentar: 1 bis 3 Zeilen, wenn ein gepflegter Einstieg fehlt.
- Blockkommentar: 1 bis 3 Zeilen vor nicht-trivialer Logik.
- YAML-Kommentar: kurz und nur fuer nicht-offensichtliche Matrix-, Rechte-,
  Shell- oder Plattformentscheidungen.
- JSONC-Kommentar: nur nach bewusster JSONC-Migration und nur fuer
  fachlich relevante Konfigurationsentscheidungen.
- Keine Kommentare, die nur Namen, Operatoren, offensichtliche Zuweisungen oder
  schon klare Help-Texte wiederholen.
- Didaktische Erklaerbloecke sind Deutsch zuerst und Englisch danach,
  CEFR-B2-nah und textfreundlich.

## 6. Review-Modell / Review Model

Jede gepruefte Datei oder jeder gepruefte Flow-Bereich erhaelt genau eine
Entscheidung:

- `CommentAdequate`: vorhandene Kommentare reichen.
- `CommentNeeded`: nicht-triviale Logik braucht kurze didaktische Erklaerung.
- `NoCommentNeeded`: Code oder Konfiguration ist selbsterklaerend; Kommentar
  waere Rauschen.
- `UpdateExistingComment`: vorhandener Kommentar ist veraltet, zu breit oder
  irrefuehrend.
- `JsoncCandidate`: Datei ist repo-eigen und kann nach Parser-Nachweis auf
  JSONC migriert werden.
- `JsonStrictRequired`: Datei bleibt strict JSON, weil externe Tools oder
  stabile Pfade das erwarten.
- `FollowUpHardening`: beim Review wurde ein echtes Verhalten-, Sicherheits-
  oder Wartungsproblem sichtbar, das nicht in diesen Kommentar-Lauf gehoert.

## 7. Fachliche Hotspots / Functional Hotspots

Der spaetere Lauf soll mindestens diese Bereiche pruefen:

- Bootstrap-, Migration-, Teardown- und Sync-Flows
- Secret-Scanning, Hook-Installation und Pre-Push-Pruefungen
- GitHub-/GitLab-Release- und Remote-Operationen
- GSDB-Registry, Level-2-Registrierung und GSDB-Preflight
- Spec-Kit-Update, Preset-Installation und Governance-Propagation
- Lernreihen-Paketierung und Lastenheft-Reihenfolge
- Cross-Platform-Pfade zwischen Bash, PowerShell, macOS, Linux und Windows
- CI-Workflow-YAML mit Shell-Bloecken und Matrix-Logik

## 8. Akzeptanzkriterien / Acceptance Criteria

- Eine Evidence-Matrix dokumentiert gepruefte Dateien oder Flow-Bereiche,
  Entscheidung, Kommentarbedarf, Aenderung und Follow-up-Grenzen.
- Keine Skript- oder CI-Verhaltensaenderung entsteht allein durch diesen Lauf.
- Kommentare erklaeren Warum, Trade-off, Randbedingung, Sicherheitsgrenze,
  Cross-Platform-Abweichung oder Proof-Grenze.
- Triviale Kommentare werden nicht neu eingefuehrt.
- Veraltete Kommentare in geprueften Bereichen werden aktualisiert oder
  entfernt.
- JSONC-Migrationen erfolgen nur mit nachgewiesener Parser-Kompatibilitaet.
- Strict-JSON-Dateien bleiben strict JSON, wenn externe Tools oder stabile
  Pfade dies erwarten.

## 9. Erwartete Ergebnisartefakte / Expected Result Artefacts

| Artefakt | Erwartung |
|---|---|
| Bestandsmatrix | Dateien und Flow-Bereiche mit Review-Entscheidung |
| Kommentar-Evidence | Begruendung, Evidenzpfad, Aenderung und Follow-up |
| JSONC-Migrationsmatrix | `JsoncCandidate` oder `JsonStrictRequired` je JSON-Datei |
| Parser-Nachweis | Bash/PowerShell/Python-Leser fuer JSONC-Kandidaten dokumentiert |
| Validierung | `git diff --check`, JSON/JSONC-Parserpruefung und relevante Syntaxchecks |

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_Didactic-Script-and-Config-Comment-Hardening.md als verbindliche Eingabedatei. Pruefe zuerst die Surface Baselines der Positionen 9, 10 und 11 und bewahre die Position 12 als Audit-Eingabe fuer Position 13. Erstelle eine Feature-Spezifikation fuer einen didaktischen Skript- und Konfigurations-Kommentar-Haertungslauf im home-baseline-Repository.

Ziel: Nicht-triviale Bash-, PowerShell-, YAML- und geeignete JSONC-Konfigurationslogik soll fuer Auszubildende, Maintainer und KI-Agenten besser nachvollziehbar werden. Kommentare muessen Warum, Trade-off, Randbedingung, Sicherheitsgrenze, Cross-Platform-Abweichung oder Proof-Grenze erklaeren und duerfen offensichtlichen Code nicht nacherzaehlen.

Wichtig:
- Trenne diesen Lauf von Lastenheft_Script_Dokumentation.md und Lastenheft_PowerShell_Cmdlets.md.
- Starte keine Verhaltensaenderung und keinen breiten Refactor.
- Pruefe zuerst eine Bestandsmatrix fuer Skripte, YAML und JSON-Dateien.
- Nutze die Entscheidungen CommentAdequate, CommentNeeded, NoCommentNeeded, UpdateExistingComment, JsoncCandidate, JsonStrictRequired und FollowUpHardening.
- JSONC ist erlaubt, aber nur fuer repo-eigene Konfigurationsdateien mit nachgewiesener Parser-Kompatibilitaet. Dateien unter .specify/*.json, .specify/integrations/*.manifest.json und .specify/workflows/workflow-registry.json bleiben strict JSON, solange externe Tools oder stabile Pfade das erwarten.
- Halte die Kommentarintensitaet moderat: normalerweise 1 bis 3 Zeilen vor nicht-trivialer Logik.
- Dokumentiere Evidence, gepruefte Dateien, Entscheidung, Kommentarbedarf, JSONC-Status, Restrisiko und Follow-up-Grenzen.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Didactic-Script-and-Config-Comment-Hardening.md Fuehre den vollstaendigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake. Pruefe zuerst die Surface Baselines der Positionen 9, 10 und 11 und bewahre die Position 12, die Audit-Eingabe fuer Position 13 sowie alle Anforderungen, Nicht-Ziele, Sicherheits-, A11Y-, Plattform-, Evidence- und Abnahmegrenzen. Implementiere und validiere nur lokal. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
