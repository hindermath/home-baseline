# Workspace Context: home-baseline (Root)

Dieses Repository ist die **oberste Ebene** der Workspace-Infrastruktur. Es dient als "Baseline" für die gesamte Entwicklungsumgebung und bietet Automatisierungswerkzeuge, um neue Projektverzeichnisse (Workspaces) standardisiert einzurichten.

## Überblick & Architektur / Project Overview & Architecture

Die "home-baseline" verfolgt einen **Multi-Repo-Ansatz**. Das Root-Verzeichnis selbst ist ein Git-Repository, das jedoch alle Unterverzeichnisse (die eigenen Git-Repositories enthalten) per `.gitignore` ignoriert.

- **Zweck:** Bereitstellung von Bootstrap-Skripten, Sicherheits-Hooks und globalen Konfigurationen.
- **Automatisierung:** Nutzung von Bash (macOS/Linux) und PowerShell Core (Windows) für plattformübergreifende Kompatibilität.
- **Sicherheit:** Integrierter Secret-Scan für KI-Agenten-Verzeichnisse (`.agents`, `.gemini`, `.claude`, etc.).

## Arbeitsverzeichnis / Working Directory

**WICHTIG / IMPORTANT:** Always work in `~/home-baseline-source` — this is the git clone with the GitHub remote. `~/` is a local copy only (no remote) and changes there cannot be pushed.

```bash
cd ~/home-baseline-source   # start Antigravity CLI here
agy
# → make changes, commit, push

# After runtime-distribution changes: sync to ~/
bash ~/scripts/sync-home.sh --no-pull
```

| Verzeichnis / Directory | Git-Remote | Zweck / Purpose |
|---|---|---|
| `~/home-baseline-source` | ✅ `origin` → GitHub | Entwicklung, Commits, Push |
| `~/` | ❌ kein Remote | Lokale Kopie für Scripts & Hooks |

Der persönliche Fork unter `~/home-baseline-source` bleibt dauerhaft als
versionierte Level-0-Quelle erhalten. `sync-home.*` verteilt nur
`homeRuntime`: Skripte, gemeinsame Agent-Guidance und ausgewaehlte
Spec-Kit-Oberflaechen. Dokumentation, Specs, Preset-Quellen und Evidence werden
direkt im Klon gelesen; `STATS.md` und private Agentenzustaende bleiben lokal.
Nach reinen Source-only-Aenderungen ist kein Home-Sync erforderlich. Vor echten
Laeufen `--check-only` / `-CheckOnly` verwenden; `--force` / `-Force` nur nach
Pruefung der Konflikte. In der ABS-DD-Sandbox die eingebundene Referenz direkt
verwenden; der allgemeine schreibende Home-Sync bleibt gesperrt. Nur ein
ausdruecklich angeforderter `--runtime-only`-/`-RuntimeOnly`-Lauf darf
manifestgebundene `homeRuntime` in die Container-Betriebskopie verteilen, ohne
Pull, Commit, Git-Konfigurations- oder Identitaetsaenderung.

*Keep the personal fork at `~/home-baseline-source` permanently as the versioned
Level 0 source. `sync-home.*` distributes only `homeRuntime`: scripts, shared
agent guidance, and selected Spec Kit surfaces. Read documentation, specs,
preset sources, and evidence directly from the clone; `STATS.md` and private
agent state remain local. Source-only changes do not require Home sync. Use
`--check-only` / `-CheckOnly` before a real run and review conflicts before
using force. General writing Home sync remains host-only; only an explicitly
requested runtime-only run may distribute manifest-bound `homeRuntime` inside
the container without pull, commit, Git configuration, or identity changes.*

## GitHub/GitLab CLI First / GitHub/GitLab CLI zuerst

Für GitHub-Repositories zuerst die authentifizierte `gh` CLI für mögliche Schreibaktionen und Live-Repository-Operationen verwenden, einschließlich PR-/Issue-Kommentaren, PR-Statusprüfungen, Review-Follow-up, Workflow-Prüfung und Merge-/Statusabfragen. GitHub-Connector-Tools hauptsächlich für strukturierte Read-only-Inspektion oder Fälle nutzen, in denen die CLI nicht geeignet ist.

Für GitLab-Repositories die authentifizierte `glab` CLI zuerst für gleichwertige Aktionen verwenden. Bekanntermaßen fehlschlagende Connector-Schreibwege nicht wiederholt versuchen, wenn `gh`/`glab` die Aufgabe direkt erledigen kann.

For GitHub repositories, use the authenticated `gh` CLI first for feasible write actions and live repository operations, including PR/issue comments, PR status checks, review follow-up, workflow inspection, and merge/status queries. Use GitHub connector tools mainly for structured read-only inspection or when the CLI is not suitable.

For GitLab repositories, use the authenticated `glab` CLI first for equivalent actions. Do not repeatedly try connector write paths that are known to fail when `gh`/`glab` can perform the task directly.

## Skriptreferenz und Quellpfad / Script Reference and Source Path

- Die vollstaendige Skriptinventur steht unter `docs/scripts/`; neue Skripte
  muessen genau einer Kategorie in `scripts/config/script-catalog.json`
  zugeordnet sein.
- Vor einem schreibenden Skriptlauf Hilfe und vorhandenen Check-, Dry-Run- oder
  WhatIf-Modus verwenden.
- Die Level-0-Quelle wird ueber den gemeinsamen Resolver ermittelt; neue
  Automationen duerfen den absoluten Pfad nicht fest eincodieren.

*The complete script inventory lives under `docs/scripts/`. New scripts must
match exactly one catalog category. Read help and use a check or preview mode
before writing. Resolve Level 0 through the shared contract rather than a
hard-coded absolute path.*

## Dokumentationsauswirkung / Documentation Impact

Jede technische oder fachliche Änderung erhält genau eine Entscheidung:
`UpdateRequired`, `NoUpdateRequired`, `GeneratedUpdate` oder `FollowUp`.
Quelle, Owner, betroffene Dokumente und Evidence richten sich nach
`docs/documentation-governance.md`. `GeneratedUpdate` ändert die kanonische
Quelle und führt den Renderer aus. `FollowUp` benötigt Owner, Risiko, Frist,
Wiedervorlage, Evidence und Scope-Grund; Sicherheits-, Bedienungs- oder
Breaking-Change-Dokumentation zusätzlich akzeptierte Risikoevidence.
Erfasse außerdem Zielgruppen und Leserpfade, kanonische Quelle und Owner,
Navigation, Dokumentklasse, Sprachpartner, Plattform-/Beispielnachweis,
Distributionsklasse, Home-Sync-Bedarf und Re-Evaluation. Große Einstiegsseiten
verwenden Progressive Disclosure und bei Bedarf synchron gepflegte `.en.md`-
Sprachpartner.

*Every technical or professional change records exactly one Documentation
Impact decision. Follow the source, ownership, generated-output, and evidence
contract in `docs/documentation-governance.md`; deterministic validation does
not replace semantic review. Also record reader paths, navigation, language
partners, distribution class, Home-sync need, and reevaluation.*

## Lernreihen-Governance / Learning Series Governance

### Git-Hosting fuer Lernende / Git Hosting for Learners

Lernenden-Dokumentation darf kein GitHub-Konto pauschal voraussetzen. `origin`
ist der persoenliche Fork beziehungsweise das persoenliche Lernenden-Repository,
`upstream` die institutionell gepflegte Referenz. GitHub ist ein Profil neben
GitLab, Codeberg, Forgejo und anderen Git-faehigen Systemen. Ein GitHub-Konto
darf nur fuer den direkten GitHub-Pfad oder die optionale Copilot-Anmeldung
verlangt werden. Maintainer-Remotes und Produktnamen bleiben unberuehrt.

*Learner documentation must not assume a GitHub account universally. `origin`
is the personal fork or learner repository and `upstream` is the
institution-maintained reference. GitHub is one profile alongside GitLab,
Codeberg, Forgejo, and other Git-capable systems. A GitHub account may only be
required for the direct GitHub route or optional Copilot sign-in. Maintainer
remotes and product names remain unaffected.*

Neue Lernreihen fuer Fachinformatiker*innen und weitere IT-Ausbildungsberufe werden zuerst in `docs/learning-units/` als Level-0-Quelle vorbereitet. Der `Lernreihen-Blueprint`, das `Lernreihen-Register`, das IT-Berufe-Mapping und die Vorlagen unter `docs/learning-units/templates/` sind verbindlich, bevor eine konkrete Level-1-/Level-2-Struktur gespiegelt wird. KI-Agenten duerfen Lernreihen, Lastenhefte, Berufsbild-Mappings, Reihenfolgen und ZIP-Paketierung vorbereiten, starten aber keine Spec-Kit-Laeufe fuer Lernende ohne ausdruecklichen Auftrag. Spec-Kit-Laeufe sind begleitende SDD-Aufgaben und ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Pruefungsvorbereitung.

*New learning series for IT specialist apprentices and additional IT training occupations are prepared first in `docs/learning-units/` as the level-0 source. The Learning Series Blueprint, Learning Series Register, IT occupation mapping, and templates under `docs/learning-units/templates/` are binding before a concrete level-1/level-2 structure is mirrored. AI agents may prepare learning series, intake files, occupation mappings, ordering, and ZIP packaging, but must not start learner Spec Kit runs without an explicit instruction. Spec Kit runs are companion SDD tasks and do not replace vocational school, workplace training, the curriculum, instructor decisions, or exam preparation.*

## Container-First fuer KI-Agenten / Container-First for AI Agents

Jeder KI-Agenten-Aufruf fuer Arbeit an einem Secure-Trader-System (Secure OrderDesk, Secure ServiceHarvester, Secure CaseTracker) erfolgt in einer freigegebenen Sandbox bzw. einem Container (Referenz: `absdd-image-sandbox`), nie direkt auf dem Arbeitsplatz-Rechner der Auszubildenden, auf gemeinsam genutzten Servern oder in produktionsnahen Umgebungen. In den Lernreihen ist diese Regel ein Gate ab dem 1. Lehrjahr (Unit 00) und gilt, bevor der erste Agent gestartet wird. Nur agentenlose Taetigkeit (Lesen, Review, allgemeine Entwicklung) darf ausserhalb der Sandbox erfolgen. In ISO/IEC-27001-zertifizierten (oder gleichwertigen) Organisationen ist dies ein pruefbarer Kontrollpunkt (u. a. A.5.23, A.8.25, A.8.28, A.8.31). Verbindliche Grundlagen: `docs/learning-units/Secure-Trader-Sandbox-Preflight.md`, `docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md` und `docs/secure-development/checklisten/CL_12_Agentische-KI-Sandbox.md`.

*Every AI-agent invocation for work on a Secure Trader system (Secure OrderDesk, Secure ServiceHarvester, Secure CaseTracker) runs in an approved sandbox/container (reference: `absdd-image-sandbox`), never directly on the apprentice's workstation, on shared servers, or in production-near environments. In the learning series this rule is a gate from year 1 (unit 00) and applies before the first agent is started. Only agent-free work (reading, review, general development) may happen outside the sandbox. In ISO/IEC 27001-certified (or equivalent) organizations this is an auditable control point (e.g. A.5.23, A.8.25, A.8.28, A.8.31). Authoritative basis: `docs/learning-units/Secure-Trader-Sandbox-Preflight.md`, `docs/secure-development/mitgeltende-dokumente/Leitlinie_Sichere-Entwicklungs-Sandbox.md`, and `docs/secure-development/checklisten/CL_12_Agentische-KI-Sandbox.md`.*

## Zentrale Abläufe & Befehle / Key Workflows & Commands

### Neuen Workspace einrichten / Create a New Workspace
Um ein neues Projektverzeichnis als standardisierten Workspace mit GitHub-Anbindung zu initialisieren:
```bash
# macOS / Linux
bash ~/scripts/bootstrap-workspace.sh <Verzeichnisname>

# Windows (PowerShell Core)
pwsh ~/scripts/bootstrap-workspace.ps1 -WorkspaceName <Verzeichnisname>
```
*Dieser Vorgang erstellt das Verzeichnis, initialisiert Git, kopiert die Baseline-Skripte, erstellt ein privates GitHub-Repo und installiert die Hooks.*

### Workspace entfernen / Remove a Workspace
Workspace sicher entfernen (Remote, lokales Verzeichnis, Artefakte):
```bash
# macOS / Linux
bash ~/scripts/teardown-workspace.sh <WorkspaceName>
bash ~/scripts/teardown-workspace.sh <WorkspaceName> --backup      # Archiv vor Löschung
bash ~/scripts/teardown-workspace.sh <WorkspaceName> --keep-remote # Remote behalten
bash ~/scripts/teardown-workspace.sh -- <WorkspaceName>            # Name beginnt mit -
```
```powershell
# Windows
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name>
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name> -Backup
pwsh ~/scripts/teardown-workspace.ps1 -WorkspaceName <Name> -KeepRemote
```

### Sicherheit & Wartung / Security & Maintenance
- **Git-Hooks installieren (in jedem Workspace):**
  `bash scripts/install-hooks.sh`
- **Git-Identität prüfen und einrichten (einmalig nach Klonen):**
  `bash scripts/setup-git-identity.sh --check-only`  — prüfen / check
  `bash scripts/setup-git-identity.sh`               — einrichten / set
  `pwsh -NoProfile scripts/setup-git-identity.ps1 -CheckOnly`  — Windows prüfen
  `pwsh -NoProfile scripts/setup-git-identity.ps1`             — Windows einrichten
- **Manueller Secret-Scan:**
  `bash scripts/scan-agent-secrets.sh`
  Wenn `gitleaks` installiert ist, prueft der manuelle Scan zusaetzlich den aktuellen Git-Diff mit `gitleaks git --pre-commit`.
- **Lokales Agent-Audit für spaetere Herkunftsspur:**
  `bash scripts/audit-agent-changes.sh snapshot`
  `bash scripts/audit-agent-changes.sh report`
  `pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action snapshot`
  `pwsh -NoProfile scripts/audit-agent-changes.ps1 -Action report`

Das Agent-Audit speichert eine lokale Baseline unter `~/.home-baseline/agent-audit/` und vergleicht spaetere Aenderungen in agentverwalteten Dateien gegen diese Baseline. Die Zuordnung zu Codex, Claude, Copilot oder Continue ist bewusst heuristisch und dient der lokalen Nachvollziehbarkeit, nicht als manipulationssicherer Beweis.

### Plattform-Test / Platform Test
Falls Terminal-Output nicht zwischen Maschinen copy-pastebaar ist, passende Test-Scripts verwenden:
```bash
bash ~/home-baseline-source/scripts/mac-test.sh     # macOS
bash ~/home-baseline-source/scripts/linux-test.sh   # Linux / WSL
```
```powershell
pwsh ~/home-baseline-source/scripts/windows-test.ps1  # Windows
```
Ergebnisse landen als `mac-test-output.txt`, `linux-test-output.txt` bzw. `windows-test-output.txt` im Repo und können von jedem Gerät gelesen werden.

*Use the matching platform test script to collect results, commit and push them. Output files are in the repo and readable from any device.*

## OS-Erkennung — Skript-Auswahl / OS Detection — Script Selection

Zu Beginn jeder Session das Betriebssystem ermitteln und die passende Skript-Variante aufrufen:

| Betriebssystem | Shell | Endung | Erkennung |
|---|---|---|---|
| Windows | `pwsh` (PowerShell 7+) | `.ps1` | `$IsWindows` / `$env:OS -eq 'Windows_NT'` |
| macOS | `bash` | `.sh` | `$IsMacOS` / `uname -s` → `Darwin` |
| Linux | `bash` | `.sh` | `$IsLinux` / `uname -s` → `Linux` |

**Regel:** Auf Windows immer `pwsh scripts/xyz.ps1` aufrufen, auf macOS/Linux immer `bash scripts/xyz.sh`. Beide Varianten sind funktional äquivalent — nie mischen.

**Skriptsprachenwahl / Script language choice:** Nach der OS-Erkennung vorhandene PowerShell-7-Skripte oder Cmdlets bevorzugen, wenn sie die Aufgabe loesen und `pwsh` verfuegbar ist. Fuer strukturierte lokale Automationen ist C# ueber `.NET` oder `mono` ein zulaessiger zweiter Weg, wenn Typisierung, Dateiformate oder Wiederverwendbarkeit davon profitieren. Erst wenn PowerShell oder C# nicht sinnvoll passen, die OS-nahe vorhandene Repo-Variante nutzen, auf macOS/Linux typischerweise Bash. Keine neue Sprache nur aus Bequemlichkeit einfuehren, wenn ein bestehendes Repo-Skript denselben Zweck erfuellt.

## Statistik-Pflege / Statistics Maintenance

- `docs/project-statistics.md` ist das lebende Statistik-Ledger dieses Repositories.
- Nach jedem abgeschlossenen Feature/Lastenheft, nach jeder abgeschlossenen Spec-Kit-Phase und auf explizite Anforderung aktualisieren.
- `## Fortschreibungsprotokoll` chronologisch halten: ältester Eintrag oben, neuester unten.
- `## Gesamtstatistik` bleibt immer der letzte Top-Level-Abschnitt.
- `docs/project-statistics.config.json` und der markierte Profil-2-Block bilden den verbindlichen Vertrag; mit `render-project-statistics.*` aktualisieren.
- Profil 2 zeigt KPI, Artefaktmix, 52-Wochen-Tagesaktivität, Wochen- und kumulatives Volumen, Phasen- oder Monatsvolumen, Speedup-Gauges und den Vergleich Erfahren/Thorsten-Solo/KI-sichtbar.
- Nur ASCII verwenden: Heatmap `0..4`, `-` für noch nicht abgelaufene Tage, Gauges `#`/`.`. Keine Unicode-Blöcke, Farbcodierung oder `\ | /` als Intensitätsskala.
- Phasenslots stabil halten und ab 17 Einträgen in 16er-Blöcke teilen. Ohne belastbare Phasendaten Monatsvolumen zeigen und keine Phasen erfinden.
- Jedes Diagramm bleibt höchstens 100 Zeichen breit und erhält genaue Werte sowie eine CEFR-B2-Textalternative in DE zuerst, EN danach.
- Methodik v2 nutzt Git-getrackten Text und Bruttoänderungen aus Nicht-Merge-Commits; Ledger, `STATS.md` und Binärdaten bleiben ausgeschlossen.
- Für dieses Repository gelten `80` Zeilen/Arbeitstag als konservative Referenz und `100` Zeilen/Arbeitstag als Thorsten-Solo-Basis für Scripting-Infrastruktur.
- Gemeinsame Default-Basis für C#/.NET-Repositories: `125` Zeilen/Arbeitstag, sofern das jeweilige Repo keinen abweichenden, begründeten Wert dokumentiert.
- TVöD-Basis: `7.8 h` pro Arbeitstag, `21.5` Arbeitstage pro Monat, 30 Urlaubstage bis Ende 2026 und 31 ab 2027.
- Änderungen an Statistikmethodik oder gemeinsamer Guidance immer gleichzeitig in allen fünf Agentenflächen einschließlich `.github/agents/copilot-instructions.md` pflegen.

## Inklusion & Barrierefreiheit / Inclusion & Accessibility

- `Programmierung #include<everyone>` gilt repo-weit als verbindlicher Leitsatz.
- Alle nutzerseitigen Artefakte müssen barrierefrei gedacht und geprüft werden: CLI-Ausgaben, Dokumentation, HTML, UI und generierte Templates.
- WCAG 2.2 Level AA ist die praktische Standard-Basis, sobald die Kriterien auf das Artefakt anwendbar sind.
- Inhalte müssen in textorientierten Assistenz-Setups nutzbar bleiben, besonders mit Tastatur, Screenreadern, Braille-Zeilen und Textbrowsern.
- Neue oder geänderte nicht-triviale Logik wird auf didaktischen Inline-Kommentarbedarf geprüft: Kommentare erklären Warum, Trade-off, Randbedingung, historische Abweichung oder Proof-Grenze, nicht offensichtliches Was.
- Gemeinsame Guidance und lernrelevante Doku folgen DE zuerst, EN danach; bei großen normativen Dokumenten ist eine synchron gepflegte `.EN.md`-Parallelfassung zulässig.
- Shared guidance nie nur hier ändern: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md` werden gemeinsam gepflegt; Abweichungen müssen in derselben Änderung begründet werden.

## Selbstaktualisierende Skripte / Self-Updating Scripts

Bei Sync- oder Bootstrap-Skripten, die ihr eigenes Verzeichnis kopieren oder ersetzen, vor echten Läufen immer Syntaxcheck und Vorschau verwenden: `bash -n`, `--dry-run` und `-WhatIf`. Echte Läufe aus einer stabilen Repo-Kopie wie `~/home-baseline-source/scripts/` starten oder sicherstellen, dass das Skript dorthin delegiert.

*For sync or bootstrap scripts that copy or replace their own directory, always use syntax checks and previews before real runs: `bash -n`, `--dry-run`, and `-WhatIf`. Start real runs from a stable repository copy such as `~/home-baseline-source/scripts/`, or ensure the script delegates there.*

Bei erzeugten oder schnell angepassten PowerShell-Skripten Variablen in Strings vor angrenzender Interpunktion immer mit `${Name}` abgrenzen, z. B. `${Path}:`. So entstehen keine fehlerhaften Bereichsvariablen wie `$Path:`.

*In generated or quickly adapted PowerShell scripts, always delimit variables before adjacent punctuation with `${Name}`, for example `${Path}:`. This avoids invalid scoped-variable parsing such as `$Path:`.*

Bei Workspace-/Repo-Migrationen eine vorhandene oder remote neuere `README.md` nicht stillschweigend überschreiben. Wenn die Remote-README kanonisch ist oder ausdrücklich erhalten bleiben soll, vor dem Push `fetch`/Rebase ausführen und `README.md` aus `origin/main` bewahren oder wiederherstellen.

*During workspace/repository migrations, do not silently overwrite an existing or newer remote `README.md`. If the remote README is canonical or must be preserved, fetch/rebase before pushing and preserve or restore `README.md` from `origin/main`.*

## Level-2-Umgebungsregister / Level-2 Environment Registry

- Die zentrale `constitution.md` enthält das verbindliche Level-2 Project Environment Registry.
- Spec-Kit-Pläne und Gemini-Arbeit in Level-2-Projekten müssen die passende Registry-Zeile als verbindlichen Kontext für Runtime, Build/Test, A11Y, Statistik und Agentenflächen verwenden.
- Änderungen an einer Level-2-Runtime, Toolchain oder Statistik-Basis müssen `constitution.md`, `.specify/memory/constitution.md` und betroffene KI-Agenten-Dateien gemeinsam prüfen.

*The central `constitution.md` contains the binding Level-2 Project Environment Registry. Spec-Kit plans and Gemini work in Level-2 projects must use the matching registry row as binding context for runtime, build/test, A11Y, statistics, and agent surfaces. Changes to Level-2 runtime, toolchain, or statistics baselines require a joint review of `constitution.md`, `.specify/memory/constitution.md`, and affected AI-agent files.*

## Memory-Safe Languages (MSL) / Speichersichere Sprachen

- Level-2-Projekte SOLLEN eine speichersichere Sprache (Memory-Safe Language, MSL) als primäre Laufzeit verwenden, wenn die Zielplattform es erlaubt.
- Verbindliche MSL-Erlaubnisliste, Regeln und Begründungspflicht: siehe `constitution.md`, Prinzip XI.
- MSL-Kurzliste: Rust, Swift, C#, F#, Java, Kotlin, Scala, Go, Dart, Python, Ruby, JavaScript, TypeScript, Haskell, OCaml, Erlang, Elixir, Ada, SPARK.
- **Nicht** MSL (Begründung im Level-2-`constitution.md` erforderlich): C, C++, klassisches Objective-C, Assembly, `cc65`-C89, Zig (pre-1.0), Nim (manual), D ohne GC.
- In Nicht-MSL-Repositories (z. B. `C64Projects/cc65`) die im Level-2-`constitution.md` hinterlegte Begründung im Plan- und Task-Kontext erwähnen.
- `speckit.constitution` und `speckit.specify` SOLLEN bei Nicht-MSL-Primärsprache einen **nicht blockierenden** Hinweis ausgeben (Tooling-Aufgabe, separate Umsetzung).
- Änderungen an dieser Empfehlung erfordern ein gemeinsames Update in `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md`.

*Level-2 projects SHOULD use a memory-safe language (MSL) as their primary runtime when the target platform allows. Authoritative rules: `constitution.md`, Principle XI. MSL short list: Rust, Swift, C#/F#, Java/Kotlin/Scala, Go, Dart, Python, Ruby, JavaScript/TypeScript, Haskell, OCaml, Erlang/Elixir, Ada/SPARK. Non-MSL languages (C, C++, Assembly, `cc65`, Zig pre-1.0, …) require a documented justification in the Level-2 `constitution.md`. In non-MSL repositories (e.g. `C64Projects/cc65`), surface the documented justification in plans and tasks. `speckit.constitution` and `speckit.specify` SHOULD emit a non-blocking advisory warning when the primary language is not an MSL — tracked as a separate tooling task. Changes to this recommendation require a joint update across `constitution.md`, `.specify/memory/constitution.md`, and all four agent guidance files.*

## Sichere Code-Erzeugung / Secure Code Generation (ISO 27001/27002 A.8.28)

- KI-generierter und menschlich geschriebener Code MUSS den etablierten Secure-Coding-Best-Practices der Zielsprache und des Frameworks folgen. LLMs erzeugen nicht zuverlässig sicheren Code; explizite Durchsetzung ist erforderlich.
- Verbindliche Regeln und sprachspezifische Anforderungen: siehe `constitution.md`, Prinzip XII.
- Sprachspezifische Kurzregeln (Detailprofil: `.specify/templates/secure-coding-language-rules-template.md`):
  - **C / C89**: Bounds-Checking, kein `gets()`, kein ungeprueftes `sprintf()`/`strcpy()`, CERT C.
  - **C# / .NET**: parametrisierte Queries, Output-Encoding gegen XSS, Anti-Forgery-Tokens, sichere Deserialisierung, Microsoft Secure Coding Guidelines.
  - **Rust**: `unsafe` isolieren und begruenden, keine Panic-Pfade aus nicht vertrauenswuerdigem Input, Deserialisierung validieren, `cargo audit` oder gleichwertig verwenden.
  - **Go**: HTTP-/Client-Timeouts setzen, `context` propagieren, SSRF pruefen, `crypto/rand` nutzen, `govulncheck` oder gleichwertig verwenden.
  - **Swift**: keine Force-Unwraps auf nicht vertrauenswuerdigen Daten, dekodierte Eingaben validieren, Keychain/CryptoKit/TLS-Defaults nutzen, Datei-URLs einschraenken.
  - **Java / Kotlin**: DTOs validieren, Persistence-Zugriffe parametrisieren, Deserialisierung beschraenken, Auth/CSRF/CORS/Session-Defaults pruefen.
  - **Python**: Boundary-Input validieren, keine unsichere Deserialisierung oder dynamische Ausfuehrung, `subprocess`/Dateipfade einschraenken, Dependency-Audit nutzen.
  - **TypeScript / JavaScript**: Runtime-Input validieren, XSS/Prototype-Pollution/SSRF pruefen, keine dynamische Code-Ausfuehrung, Lockfiles auditieren.
  - **SQL**: nur parametrisierte Statements, kein dynamisches SQL aus nicht vertrauenswuerdigem Input.
  - **Bash**: Variable in Anfuehrungszeichen (`"$var"`), kein `eval` auf nicht vertrauenswuerdigem Input, `--` End-of-Options.
  - **PowerShell**: `Set-StrictMode -Version Latest`, validierte Parameter, kein `Invoke-Expression` auf nicht vertrauenswuerdigem Input.
- Kryptografie: aktuelle Algorithmen (AES-256, RSA >= 3072, SHA-256+, Ed25519); veraltete (MD5, SHA-1 für Signaturen, DES, RC4) nur mit expliziter Risikobegründung.
- Fehlerbehandlung darf keine internen Zustände, Stack-Traces oder Verbindungszeichenketten an Endbenutzer preisgeben.
- Hinzugefügte Abhängigkeiten müssen aktiv gepflegt sein und dürfen keine bekannten kritischen CVEs aufweisen.
- Code-Reviews MÜSSEN eine Sicherheitsperspektive für Eingabeverarbeitung, Authentifizierung, Autorisierung, Kryptografie und Datei-/Netzwerk-I/O enthalten.
- Änderungen an dieser Regel erfordern ein gemeinsames Update in `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md`.

*AI-generated and human-written code MUST follow the secure-coding best practices of the target language and framework. Authoritative rules: `constitution.md`, Principle XII, and `.specify/templates/secure-coding-language-rules-template.md`. Language-specific short rules cover C/C89, C#/.NET, Rust, Go, Swift, Java/Kotlin, Python, TypeScript/JavaScript, SQL, Bash, and PowerShell. MSL status does not replace secure API, I/O, auth, SQL, crypto, logging, or dependency review. Cryptography: use current algorithms (AES-256, SHA-256+, Ed25519); deprecated (MD5, SHA-1 for signatures, DES, RC4) only with explicit risk acknowledgement. Error handling must not expose internals. Dependencies must have no known critical CVEs. Code reviews must include a security perspective for input handling, auth, crypto, and I/O. Changes require a joint update across `constitution.md`, `.specify/memory/constitution.md`, and all four agent guidance files.*

## Sichere Software-Architektur / Secure Software Architecture (ISO 27001/27002 A.8.27)

- KI-generierte und menschlich geschriebene Software-Architektur MUSS etablierten sicheren Architekturprinzipien folgen. Sicherer Code (Prinzip XII) ohne sichere Architektur reicht nicht aus — beide Ebenen müssen zusammenwirken.
- Verbindliche Regeln und sprachspezifische Architekturvorgaben: siehe `constitution.md`, Prinzip XIII.
- Verbindliche Architekturprinzipien:
  - **Trust Boundaries**: Explizite Vertrauensgrenzen definieren; alle Eingaben an Vertrauensgrenzen validieren und bereinigen.
  - **Defense in Depth**: Mindestens zwei unabhängige Sicherheitsschichten für kritische Assets.
  - **Least Privilege**: Jede Komponente, jeder Dienst und Prozess arbeitet mit minimalen Berechtigungen.
  - **Fail-Safe Defaults**: Zugriff standardmäßig verweigern, explizit gewähren; Fehlerpfade fallen in sicheren Zustand zurück.
  - **Angriffsfläche reduzieren**: Ungenutzte Endpunkte, Dienste und Debug-Funktionen deaktivieren oder entfernen.
  - **Separation of Concerns**: Authentifizierung, Autorisierung, Logging und Eingabevalidierung als Cross-Cutting Concerns implementieren, nicht ad-hoc verstreuen.
  - **Sichere Konfiguration**: Secrets in plattformgeeigneten Secret-Stores (z. B. Azure Key Vault, macOS Keychain), nie im Quellcode oder in Git-tracked Config-Dateien.
  - **Supply-Chain-Sicherheit**: Abhängigkeiten aus verifizierten Registries; Lock-Files committen; verwundbare Abhängigkeiten vor Release ersetzen.
- Änderungen an dieser Regel erfordern ein gemeinsames Update in `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md` und `.github/copilot-instructions.md`.

*AI-generated and human-written software architecture MUST follow secure-architecture principles. Authoritative rules: `constitution.md`, Principle XIII. Core principles: trust boundaries (validate all input at system boundaries), defense in depth (at least two independent security layers), least privilege (minimum required permissions), fail-safe defaults (deny by default), attack surface reduction (disable unused features), separation of concerns (auth/logging/validation as cross-cutting concerns), secure configuration (secrets in secret stores, never in code or Git), supply-chain security (verified registries, lock files, no known-vulnerable dependencies). Principles XII + XIII together form the complete secure-development approach: XII = tactical code-level security, XIII = strategic architecture-level security. Changes require a joint update across `constitution.md`, `.specify/memory/constitution.md`, and all four agent guidance files.*

## Sicherheitsdokumentation / Security Documentation (XII–XIX Extensions)

- Jedes Level-2-Projekt MUSS die folgenden Sicherheitsdokumente pflegen, basierend auf den Templates in `.specify/templates/`:
  - **Bedrohungsmodell / Threat Model** (`threat-model-template.md`) — STRIDE-Methodik, Trust Boundaries, Risikobewertung, CAPEC-Referenzen (Prinzip XIII + XVII)
  - **Security Architecture Decision Records (S-ADR)** (`adr-template.md`) — architektonische Sicherheitsentscheidungen mit Compliance-Nachweis (Prinzip XIII)
  - **arc42 Section 8 Sicherheits-Querschnittskonzepte** (`arc42-security-template.md`) — Authentifizierung, Autorisierung, Verschlüsselung, Eingabevalidierung, Fehlerbehandlung, Logging, Abhängigkeiten, Deployment (Prinzip XIII)
  - **Sicherheits-Checkliste / Security Checklist** (`security-checklist-template.md`) — sprachspezifische Code-Review-Checkliste (Prinzip XII)
  - **Abhängigkeits-Audit / Dependency Audit** (`dependency-audit-template.md`) — CVE-Tracking, Lizenz-Compliance, Supply-Chain-Sicherheit (Prinzip XII)
  - **Sicherheits-Qualitätsszenarien / Security Quality Scenarios** (`security-quality-scenarios-template.md`) — iSAQB CPSA-F Qualitätsszenario-Methodik (Prinzip XII + XIII, SHOULD)
  - **ASVS-Verifikation / ASVS Verification** (`asvs-verification-template.md`) — OWASP ASVS Level, Scope und Evidenz (Prinzip XV, Web-/API-Projekte MUST)
  - **Supply-Chain-Evidenz / Supply Chain Evidence** (`supply-chain-evidence-template.md`) — SBOM, AI-SBOM, VEX, SLSA, OpenSSF Scorecard (Prinzip XVI, releasefähige Projekte MUST; AI-SBOM nur bei KI-Runtime-/Produktkomponenten)
  - **Zero-Trust-Anwendbarkeit / Zero Trust Applicability** (`zero-trust-applicability-template.md`) — NIST SP 800-207-Bewertung (Prinzip XVIII, verteilte Systeme SHOULD)
  - **SAMM-Bewertung / SAMM Assessment** (`samm-assessment-template.md`) — OWASP SAMM Reifegrad und Verbesserungsplan (Prinzip XVIII, langlebige Projekte SHOULD)
  - **Cloud-Autonomie / Cloud Autonomy** (`cloud-autonomy-applicability-template.md`) — BSI C3A-Anwendbarkeit für Cloud-Service-Auswahl, Provider-Abhängigkeiten, Audit-/Nachweisstand und Autonomie-Risiken (Prinzip XVIII, cloudnahe Projekte MUST)
  - **Cloud-Compliance-Assurance** (`cloud-compliance-assurance-template.md`) — BSI C5-Anwendbarkeit für Cloud-Testate, Assurance-Scope, Shared Responsibility, Provider-/Subprocessor-Abhängigkeiten, Datenstandort, Logging, Backup und Incident-Evidence (Prinzip XVIII, cloudnahe Projekte SHOULD)
  - **Regulatorische Anwendbarkeit / Regulatory Applicability** (`regulatory-applicability-template.md`) — NIS2, CRA, EU AI Act und DORA als Scope-/N/A-Prüfung mit ausdrücklicher Begründung für private Ausbildungsprojekte (Prinzip XIX, projektartabhängig)
- Projektspezifische Instanzen werden in `docs/security/` gepflegt; S-ADRs als einzelne Dateien in `docs/security/adr/`.

*Every Level-2 project MUST maintain security documents based on templates in `.specify/templates/`: threat model (STRIDE+CAPEC), S-ADRs, arc42 Section 8 security concepts, security checklist, dependency audit, security quality scenarios (SHOULD), ASVS verification (web/API MUST), supply-chain evidence (release-capable MUST; AI-SBOM when AI runtime/product components apply), Zero Trust applicability note (distributed systems SHOULD), SAMM assessment (long-lived projects SHOULD), cloud autonomy applicability record (cloud-dependent projects MUST), cloud compliance assurance record (cloud-dependent projects SHOULD), and regulatory applicability record (project-type-dependent). Project-specific instances live in `docs/security/`; S-ADRs in `docs/security/adr/`. See `constitution.md`, Principles XII–XIX for authoritative requirements.*

## Sicherheitsstandards & Anwendbarkeit / Security Standards & Applicability

- Vor jeder Level-2-Aufgabe die anwendbaren Sicherheitsstandards aus `constitution.md`, Prinzipien XIV-XVIII bestimmen und explizit benennen.
- `NIST SSDF` und `CWE Top 25` gelten immer für Level-2-Arbeit.
- `OWASP ASVS` gilt für Web-, API-, HTTP- und authentifizierte Dienste; der gewählte ASVS-Level muss benannt werden.
- `SBOM` gilt für releasefähige oder verteilbare Artefakte; `VEX`, wenn bekannte Schwachstellen in ausgelieferten oder geprüften Komponenten bewertet werden müssen.
- `AI-SBOM` gilt projektartabhängig bei KI-Modellen, KI-Diensten, Trainings-/Embedding-Daten, Inferenz-Infrastruktur oder KI-Runtime-Komponenten im ausgelieferten oder betriebenen System; reine Entwicklungswerkzeug-Nutzung wird als `N/A` mit Toolchain-Begründung dokumentiert.
- `SLSA` gilt als Soll-Vorgabe für CI/CD- oder veröffentlichte Artefakte; `Zero Trust` ist für verteilte, servicebasierte, cloudnahe oder remote-verwaltete Systeme explizit zu prüfen.
- `BSI C3A` gilt projektartabhängig bei Cloud-Service-Auswahl, Cloud-Betrieb, SaaS/PaaS/IaaS, Managed Services, Container-/Artefakt-Hosting oder providerabhängigen Deployments; reine Entwicklungsinfrastruktur wird als `N/A` mit Toolchain-Begründung dokumentiert.
- `BSI C5` gilt projektartabhängig bei Cloud-Service-Auswahl, Cloud-Betrieb, SaaS/PaaS/IaaS, Managed Services, Container-/Artefakt-Hosting, providerabhängigen Deployments oder Cloud-Assurance-Prüfungen; reine Entwicklungsinfrastruktur wird als `N/A` mit Toolchain-Begründung dokumentiert.
- `NIS2`, `CRA`, `EU AI Act` und `DORA` werden als regulatorische Anwendbarkeitsmatrix geprüft; private Ausbildungsprojekte sind standardmäßig `N/A`, wenn kein regulierter Dienst, kein Marktprodukt, kein regulierter Kunde und keine regulierte Lieferkettenrolle vorliegt.
- `CAPEC` soll in Bedrohungsmodellen für die risikoreichsten Angriffswege verwendet werden; `OWASP SAMM` soll für langlebige Projekte/Workspaces in Verbesserungspläne einfließen.
- `OWASP Cheat Sheet Series`, `OWASP Proactive Controls` und bei öffentlichen OSS-Repositories oder kritischen Abhängigkeiten `OpenSSF Scorecard` sind als ergänzende Referenzen zu berücksichtigen.
- Nichtanwendbarkeit immer als `N/A` mit kurzer Begründung dokumentieren; keine stillschweigende Auslassung.

*At the start of every Level-2 task, determine and name the applicable security standards from `constitution.md`, Principles XIV-XIX. `NIST SSDF` and `CWE Top 25` always apply. `OWASP ASVS` applies to web/API/HTTP/auth-bearing services; `SBOM` applies to releasable or distributable artefacts; `AI-SBOM` applies when AI models, AI services, datasets, inference infrastructure, or AI runtime components are part of the released or operated system; `VEX` applies when known vulnerabilities in shipped/evaluated components need a disposition statement. `SLSA` is the target model for CI/CD and published artefacts; `Zero Trust` must be explicitly evaluated for distributed, service-based, cloud, or remotely managed systems. `BSI C3A` applies when cloud services, SaaS/PaaS/IaaS, managed services, artifact hosting, or provider-dependent deployments are part of the released or operated system; development infrastructure alone is `N/A` with a toolchain rationale. `BSI C5` applies when cloud-service selection, cloud operation, managed services, artifact hosting, provider-dependent deployments, or cloud assurance reviews are in scope; development infrastructure alone is `N/A` with the same toolchain rationale. `NIS2`, `CRA`, `EU AI Act`, and `DORA` are screened through a regulatory applicability matrix; private training projects default to `N/A` when no regulated service, market product, regulated customer, or regulated supply-chain role exists. `CAPEC`, `OWASP SAMM`, `OWASP Cheat Sheet Series`, `OWASP Proactive Controls`, and `OpenSSF Scorecard` are supporting references where relevant. Record non-applicability as `N/A` with justification rather than omitting it silently.*

## Agentischer Security-Workflow / Agentic Security Workflow

- In `spec.md`, `plan.md` und `tasks.md` die anwendbaren Standards samt Evidenzpfad festhalten.
- Bei Bedrohungsmodellen `STRIDE` als Basis und bei risikoreichen Flows zusätzlich relevante `CAPEC`-Patterns verwenden.
- Bei Web/API-Features den `ASVS`-Level und den Verifikationsumfang in `docs/security/` oder gleichwertiger Projektdokumentation ablegen.
- KI-Nutzung explizit klassifizieren: Entwicklungswerkzeug, keine KI im ausgelieferten/betriebenen System, oder KI-Runtime-/Produktkomponente; `AI-SBOM` entsprechend als `N/A` begründen oder in der Supply-Chain-Evidenz dokumentieren.
- Bei Release-/Artefakt-Arbeit `SBOM`, `AI-SBOM`, `VEX`, Provenance/SLSA-Nachweise und gegebenenfalls `OpenSSF Scorecard` in Release- oder Sicherheitsdokumentation einplanen.
- Bei Architekturänderungen `Zero Trust`-Anwendbarkeit und bei langlebigen Projekten `SAMM`-Folgeaktionen prüfen.
- Bei Cloud-Service-Auswahl oder providerabhängigen Deployments `BSI C3A`-Anwendbarkeit prüfen und den Evidenzpfad dokumentieren.
- Bei Cloud-Service-Auswahl, providerabhängigen Deployments oder Cloud-Assurance-Prüfungen `BSI C5`-Anwendbarkeit prüfen und den Evidenzpfad dokumentieren.
- Bei Release, Marktbereitstellung, Kundenübergabe, Cloud-Betrieb, KI-Runtime-/Produktkomponenten, Finanzsektor-ICT-Abhängigkeiten oder regulierten Kunden/Lieferketten `NIS2`, `CRA`, `EU AI Act` und `DORA` als Anwendbarkeitsmatrix prüfen.
- Default-Evidenzpfad: `docs/security/asvs-verification.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, `docs/security/samm-assessment.md`, `docs/security/cloud-autonomy-applicability.md`, `docs/security/cloud-compliance-assurance.md`, `docs/security/regulatory-applicability.md`; Abweichungen nur mit lokal dokumentierter Begründung.

*Capture the applicable standards and the evidence path in `spec.md`, `plan.md`, and `tasks.md`. Use `STRIDE` as the base for threat modeling and add relevant `CAPEC` patterns for the highest-risk flows. For web/API work, record the chosen `ASVS` level and verification scope in `docs/security/` or equivalent project documentation. Classify AI usage as development tooling, absent from the released/operated system, or AI runtime/product component; document `AI-SBOM` as `N/A` or as supply-chain evidence accordingly. For release and artefact work, plan `SBOM`, `AI-SBOM`, `VEX`, provenance/SLSA evidence, and `OpenSSF Scorecard` review where applicable. For architectural changes, evaluate `Zero Trust`; for long-lived projects, consider `OWASP SAMM` follow-up actions. The default evidence path is `docs/security/asvs-verification.md`, `docs/security/supply-chain-evidence.md`, `docs/security/zero-trust-applicability.md`, `docs/security/samm-assessment.md`, `docs/security/cloud-autonomy-applicability.md`, `docs/security/cloud-compliance-assurance.md`, and `docs/security/regulatory-applicability.md`, unless the repository documents a justified equivalent location.*

## Zentrale Verzeichnisse / Key Directories

- `~/scripts/`: Zentrale Automatisierungsskripte (Bootstrap, Secret-Scan, Hook-Installer).
- `~/`: Weitere Workspace-Verzeichnisse werden per `bootstrap-workspace` angelegt und hier eingetragen.
- `~/.gemini/`: Globale Gemini-Konfiguration und persistente Erinnerungen.

## Entwicklungskonventionen / Development Conventions

- **Plattformunabhängigkeit & Dokumentation:** Alle kritischen Skripte müssen sowohl als `.sh` (Bash) als auch als `.ps1` (PowerShell Core) vorliegen. Jedes Skript erfordert eine Unix man-Page (`.sh`, in `docs/man/`), eine vollständige PowerShell-Hilfe (`.ps1`) und muss zusätzlich als PowerShell Cmdlet (Advanced Function) im `Verb-Noun` Format verfügbar sein.
- **Sicherheits-Standard:** Jedes Projekt muss über einen `pre-push` Hook verfügen, der `gitleaks` für zu pushende Commit-Ranges nutzt, wenn verfügbar, und zusätzlich den bestehenden Regex-Fallback für Secret-Scanning ausführt.
- **Git-Strategie:** Keine Submodules; stattdessen werden Sub-Repos durch die Baseline-Skripte in der `.gitignore` des übergeordneten Workspaces erfasst.

## Projektstatus / Repository Status

- **Sichtbarkeit:** Öffentliches **Template-Repo** — über „Use this template" nutzbar; kein Fork, keine History-Übertragung
- **Lizenz:** MIT
- **Branch-Schutz:** PR-Pflicht auf `main`; Admin (Eigentümer) kann direkt pushen (`enforce_admins: false`)
- **CI:** ✅ Ubuntu 22.04 · macOS 14 · Windows 2022
- **Compliance-Score:** 100 % (25/25 Checks)

## Bekannte Fallstricke / Known Pitfalls

### `gh auth login --web` bleibt hängen / `gh auth login --web` Hangs
Browser-Callback kommt in Hintergrundprozessen nicht an.
In **interaktivem Terminal** ausführen.

### `glab auth login --web` bleibt hängen / `glab auth login --web` Hangs
Browser-Callback kommt in Hintergrundprozessen nicht an.
In **interaktivem Terminal** ausführen.

### `gh`-Keyring ungültig (Windows) / `gh` Keyring Invalid (Windows)
Windows Credential Store korrupt.
`gh auth logout` + neu anmelden; danach `gh auth setup-git`.

### `ssh-agent` startet nicht (Windows) / `ssh-agent` Does Not Start (Windows)
Service deaktiviert, Admin nötig.
HTTPS + `gh auth setup-git` verwenden.

### `CursorPosition`-Fehler in PS-Subprocess / `CursorPosition` Error in PowerShell Subprocess
PowerShell-Profil (Oh-My-Posh) lädt im Subprozess.
`-NoProfile` zu `pwsh -File`-Aufrufen hinzufügen.

### `migrate-workspace.*` läuft parallel in Timeouts / `migrate-workspace.*` Times Out in Parallel
Jeder Migrationslauf startet `init-stats.*` und aktualisiert die Level-0/1/2-Statistiken global.
Mehrere parallele Läufe können sich gegenseitig ausbremsen. Erst Vorschau (`-WhatIf`/`--dry-run`),
dann echte Migrationen seriell pro Workspace mit längerem Timeout ausführen.

### `git pull` meldet divergierende Branches (Linux) / `git pull` Reports Divergent Branches (Linux)
Kein globales Rebase-Setup.
`git config --global pull.rebase true`.

### Push rejected: `fetch first` / Push Rejected: `fetch first`
Remote ist neuer als lokal.
`git pull --rebase --autostash && git push`.

### Test-Skript blockiert Pull / Test Script Blocks Pull
Output-Datei wird vor `pull` geschrieben.
`git pull --rebase --autostash origin main`.

### Lastenheft nach Feature-Abschluss nicht umbenannt / Lastenheft Not Renamed After Feature Completion
`tasks.md` enthielt keinen Rename-Schritt (seit constitution v1.1.1 behoben).
`bash scripts/rename-lastenheft.sh <LH-Datei> <branch-name>` oder `pwsh scripts/rename-lastenheft.ps1 -File <LH-Datei> -BranchName <branch-name>`.

### Windows: `$env:HOME` ist leer, nicht `$null` / Windows: `$env:HOME` Is Empty, Not `$null`
```powershell
# Falsch (??-Operator fängt '' nicht ab):
$home = $env:HOME ?? $env:USERPROFILE
# Richtig:
$home = if ($env:HOME) { $env:HOME } else { $env:USERPROFILE }
```

### CI: Scanner-Verzeichnis / CI: Scanner Directory
```bash
# Falsch (CWD = Repo-Root, Dateien nicht gefunden):
bash scripts/check-homogeneity.sh home-baseline
# Richtig (aus dem Parent heraus):
cd "$(dirname "$GITHUB_WORKSPACE")"
bash "$(basename "$GITHUB_WORKSPACE")/scripts/check-homogeneity.sh" "$(basename "$GITHUB_WORKSPACE")"
```

### `.gitignore`-Whitelist / `.gitignore` Whitelist
Jede neue Datei muss explizit als `!DATEINAME` in `.gitignore` eingetragen werden, sonst wird `git add` lautlos ignoriert (z. B. `LICENSE`).

### `bootstrap-workspace`: GitHub-Username / `bootstrap-workspace`: GitHub Username
Früher hardcodiert. Jetzt dynamisch:
```bash
GH_USER=$(gh api user --jq '.login')
```

### Doppelte Überschriften in TOC / Duplicate heading anchors
Gleiche Heading-Texte → GitHub hängt `-1`, `-2` an. TOC-Links für zweite Vorkommen müssen den Suffix enthalten.

### Pflicht für bilinguale Headings / Bilingual Heading Requirement
Format: `## DE / EN` — immer. Nur-Deutsch verletzt WCAG 2.4.6 und bilinguales Konsistenzgebot.
Ausnahme: Eigennamen wie `### Homogeneity Guardian` oder `### Compliance-Check`.

### Code-Blöcke immer mit Sprach-Tag (WCAG 4.1.1) / Code Blocks Must Always Have a Language Tag (WCAG 4.1.1)
Bare ` ``` ` ohne Sprache ist ein A11Y-Fehler. Für ASCII/Dialog/Verzeichnisse: ` ```text `.

### CHANGELOG.md hinzugefügt / CHANGELOG.md Added
Dokumentiert Versionen v0.1.0–v0.4.0. Muss in `.gitignore`-Whitelist (`!CHANGELOG.md`) eingetragen sein.

### ASCII-Box-Drawing-Tabellen: Zeilenbreite / ASCII Box-Drawing Tables: Line Width
Alle Zeilen einer `text`-Code-Block-Tabelle müssen exakt gleich breit sein. Ein überzähliges Leerzeichen vor dem schließenden `│` macht die Zeile 1 Zeichen zu lang.
Prüfen: PowerShell `$line.Length` oder `wc -m` (Bash) für jede Rahmen-Zeile.

### Spec-Kit-Verzeichnis initialisieren / Initialize the Spec-Kit Directory
Nie manuell aus `~/home-baseline-source/` kopieren. Stattdessen:
`specify init --here --force --integration {agent}` je Agent für `agy`, `opencode`, `claude`, `copilot` und `codex` ausführen.

### Spec-Kit-Updates repo-weit / Repository-Wide Spec-Kit Updates
Fuer Level 0, Level 1 und Level 2 nicht mehr per Hand in jedem Repo nachziehen.
Stattdessen zuerst `bash scripts/update-spec-kit.sh --dry-run` bzw.
`pwsh scripts/update-spec-kit.ps1 -WhatIf` ausfuehren, danach bei Bedarf
`--commit --push` / `-Commit -Push`.

Das Skript erkennt neue Repos dynamisch ueber `.git` plus `.specify/`, sichert
`.specify/memory/constitution.md`, legt die lokalen Governance-Templates wieder
auf und nimmt `RiderProjects/TuiVision` normal mit. OpenCode wird nur ueber
`.opencode/command/*.md` getrackt; `.opencode`-Caches, Sessions, Logs,
Credentials und lokale Abhängigkeiten bleiben ausgeschlossen.

Die Standard-Template-Quelle ist das oeffentliche `home-baseline`-Repo, aus dem
das Skript laeuft. Private Repos wie `RiderProjects/TuiVision` duerfen nur
bewusst mit `--template-source` / `-TemplateSource` als Override genutzt werden.

### GitHub-Housekeeping: Archivierung, Sichtbarkeit, Forks und Stars / GitHub Housekeeping: Archiving, Visibility, Forks, and Stars
`archived` bedeutet bei GitHub nur read-only, nicht unsichtbar. Public archived Repos bleiben ohne Anmeldung sichtbar.
Archivierte Repos sind API-seitig read-only; Sichtbarkeit ändern geht deshalb nur über:
`archived=false` → `private=true` → `archived=true`.

Öffentliche Forks lassen sich nicht einfach auf private setzen. Optionen: öffentlich archiviert lassen, löschen, oder als private Mirror-Repos neu anlegen. Vor Löschungen die Repo-Liste eng festlegen; `gh repo delete` benötigt ggf. `gh auth refresh -h github.com -s delete_repo`.

Für Aktivitätsbewertungen `pushedAt` statt `updatedAt` verwenden, weil `updatedAt` durch Metadatenänderungen springt. Stars sind kontogebundene Metadaten und können über `DELETE /user/starred/{owner}/{repo}` entfernt werden; danach `user/starred` gegenprüfen.


## Agentische Toolchain-Wartung / Agentic Toolchain Maintenance

- Wiederkehrende Toolchain-Wartungsrunden sind im README unter `Wiederkehrende agentische Toolchain-Wartung / Recurring Agentic Toolchain Maintenance` dokumentiert.
- Wenn ein bekannter KI-Agent in `~` oder `~/home-baseline-source` startet und keine strengere Read-only-Aufgabe im Vordergrund steht, fragt er einmal nach: nur pruefen, pruefen und fehlende Required-Tools installieren, vollstaendig inklusive GSDB-Preflight vorbereiten oder ueberspringen.
- macOS/Linux nutzen `scripts/maintain-agentic-brew-apps.sh` und `scripts/config/brew-apps-registry.json`; Windows nutzt `scripts/maintain-agentic-winget-apps.ps1` und `scripts/config/winget-apps-registry.json`; VS-Code-Extensions werden ueber `scripts/config/vscode-extensions-registry.json`, Required-CLI-Pruefungen ueber `scripts/config/required-cli-tools-registry.json`, npm-Agenten-CLIs ueber `scripts/config/npm-agent-cli-registry.json` gepflegt.
- PSScriptAnalyzer `1.25.0` ist ein Required-PowerShell-Modul aus `scripts/config/powershell-modules-registry.json`; alle getrackten repo-eigenen `.ps1`, `.psm1` und `.psd1` muessen den gemeinsamen Analyselauf bestehen. Nur die dort begruendet dokumentierten, von GitHub Spec Kit erzeugten Upstream-Pfade sind ausgenommen. / PSScriptAnalyzer `1.25.0` is a required module; every tracked, repository-owned PowerShell file must pass the shared analysis run. Only generated GitHub Spec Kit upstream paths documented there with a rationale are excluded.
- Level-0 unter `~/home-baseline-source` ist die kanonische Quelle fuer diese Wartungsdateien. Bestehende Level-1-/Level-2-Kopien mit `propagate-agentic-toolchain-maintenance.*` zuerst als Vorschau, danach schreibend und abschliessend mit `--check-only` / `-CheckOnly` synchronisieren; das Werkzeug commitet oder pusht nicht.
- Fuer komplette Wartungslaeufe `maintain-agentic-workspace.sh` auf macOS/Linux beziehungsweise `maintain-agentic-workspace.ps1` auf Windows verwenden. Ohne Optionen aktualisieren sie Level-0/1/2 und die Required-Toolchain; `--check-only` / `-CheckOnly` prueft, Vorschau zeigt Schreibschritte, und Drift-Reparatur bleibt mit `--repair-drift` / `-RepairDrift` ausdruecklich zustimmungspflichtig. Die Orchestratoren wechseln keine Branches und committen oder pushen keine Ziel-Repositories.
- Vollwartung verwendet Storage-Profil `Safe`: sieben Tage Aufbewahrung, Pressure Mode unter 15 Prozent freiem Speicher und ausschließlich Git-ignorierte, nicht getrackte, repo-interne Buildausgaben. `Deep` benötigt im echten Lauf eine eigene Bestätigung; `scripts-only` erzwingt `None`. Container-Volumes, `--all` und `system prune` sind ausgeschlossen. Non-MSL-Repositories wie `cc65` und `tvision` dürfen nur über kuratierte Adapter mit dokumentierter Begründung und geschützter Build-Evidence bereinigt werden.

*Full maintenance uses the `Safe` storage profile: seven-day retention, pressure mode below 15 percent free space, and only Git-ignored, untracked, repository-contained build outputs. An update `Deep` run requires separate confirmation; `scripts-only` enforces `None`. Container volumes, `--all`, and `system prune` are excluded. Non-MSL repositories such as `cc65` and `tvision` may be cleaned only by curated adapters that preserve their documented justification and build evidence.*
- VS Code ist der grafische Required-Editor fuer Auszubildende; Helix (`hx`) ist der Required-A11Y-/CLI-Editor. Fuer die sechs MSL-Pfade C#, Go, Java, Python, Rust und Swift sind die offiziellen minimalen VS-Code-Extensions required; Microsoft Container Tools ist zusaetzlich required fuer Podman-Workflows.
- Podman CLI und Compose-Unterstuetzung sowie die sechs MSL-CLI-Toolchains `.NET`, Go, Java/Javac, Python, Rust/Cargo und Swift sind Required; `syft` fuer SBOM-Nachweise und GitHub Spec Kit (`specify`) fuer SDD sind ebenfalls Required. `specify` wird bei Bedarf ueber `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git` installiert.
- Die Agenten-CLI-Oberflaechen `codex`, `claude` und `copilot` sind plattformuebergreifend Required und nutzen bei Bedarf die npm-Registry als Fallback. Google Antigravity ersetzt Gemini CLI; `agy` ist plattformuebergreifend Required: macOS nutzt Homebrew, Windows `Google.AntigravityCLI` per WinGet und Linux den pruefsummengeprueften offiziellen Installer.
- Standardlaeufe installieren nur `required`; `optional` dient als dokumentierter Komfort-/Projektkontext. `xquartz` bleibt bewusst aus der Brew-Registry ausgeschlossen.
- Fehlende Required-Programme aus `--compare-only` / `-CompareOnly` werden bei freigegebener Wartung installiert; optionale Tools nur nach ausdruecklicher Zustimmung.
- `gitleaks`, `syft`, `specify`, die MSL-CLI-Toolchains und die Required-Agenten-CLIs muessen nach Paketmanager-Wartung pruefbar sein.
- Zweitgeraete ueber `mac-test.sh`, `linux-test.sh` und `windows-test.ps1` vergleichen; bewusst installierte Top-Level-Tools danach in die passende Registry uebernehmen.

*Recurring toolchain maintenance rounds are documented in the README section `Wiederkehrende agentische Toolchain-Wartung / Recurring Agentic Toolchain Maintenance`. macOS/Linux use `scripts/maintain-agentic-brew-apps.sh` with `scripts/config/brew-apps-registry.json`; Windows uses `scripts/maintain-agentic-winget-apps.ps1` with `scripts/config/winget-apps-registry.json`; VS Code extensions are maintained through `scripts/config/vscode-extensions-registry.json`, required CLI checks through `scripts/config/required-cli-tools-registry.json`, and npm agent CLIs through `scripts/config/npm-agent-cli-registry.json`. VS Code is the required graphical editor for apprentices; Helix (`hx`) is the required A11Y/CLI editor. The official minimal VS Code extensions are required for the six MSL paths C#, Go, Java, Python, Rust, and Swift; Microsoft Container Tools is also required for Podman workflows. Podman CLI and Compose support plus the six MSL CLI toolchains `.NET`, Go, Java/Javac, Python, Rust/Cargo, and Swift are required; `syft` for SBOM evidence and GitHub Spec Kit (`specify`) for SDD are required as well. The `codex`, `claude`, and `copilot` agent CLI surfaces are required across platforms and use the npm registry as a fallback when needed. Google Antigravity replaces Gemini CLI; `agy` is required cross-platform: macOS uses Homebrew, Windows uses `Google.AntigravityCLI` through WinGet, and Linux uses the checksum-verified official installer. `specify` is installed through `uv tool install specify-cli --from git+https://github.com/github/spec-kit.git` when missing. Default runs install only `required`; `optional` records convenience/project context. `xquartz` stays intentionally excluded from the Brew registry. `gitleaks`, `syft`, `specify`, the MSL CLI toolchains, and the required agent CLIs must be verifiable after package-manager maintenance; compare second machines through the platform test scripts and then update the matching registry for intentional top-level tools.*

*Level-0 under `~/home-baseline-source` is the canonical source for these maintenance files. Synchronize existing Level-1/Level-2 copies with `propagate-agentic-toolchain-maintenance.*`: preview first, apply second, and finish with `--check-only` / `-CheckOnly`. The tool performs no commits or pushes.*

*Use `maintain-agentic-workspace.sh` on macOS/Linux or `maintain-agentic-workspace.ps1` on Windows for complete maintenance. With no options they update Level-0/1/2 and the required toolchain; check-only reports state, preview shows mutating steps, and drift repair requires explicit `--repair-drift` / `-RepairDrift`. The orchestrators never switch branches or commit/push target repositories.*

*At startup in `~` or `~/home-baseline-source`, known AI agents ask once whether to check only, check and install missing required tools, prepare full maintenance including GSDB preflight, or skip. Missing required tools from compare mode may be installed after approval; optional tools require explicit approval.*


## Secure-Development-Hardening Intake / Secure Development Hardening Intake

- Level-2-Repositories SOLLEN die zentrale sichere-Entwicklung-Basis aus `docs/secure-development/` enthalten; MSL-Status ist ein Pruefpunkt, aber keine Voraussetzung fuer die RL-SE-/Checklist-Selbstpruefung.
- Dazu gehoeren Richtlinie, Checklisten, Sammelband, `docs/secure-development/mitgeltende-dokumente/` und die zentrale Verzahnungsdatei `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`.
- `docs/secure-development/baseline-manifest.json` ist die kanonische Dateiliste fuer Basis 3.1.0; die Einzelchecklisten sind Quelle und der Sammelband wird mit `build-secure-development-docs.*` erzeugt und geprueft.
- Projektnachweise liegen getrennt unter `docs/security/secure-development/<datum>-<scope>/`; Sicherheit beginnt ab dem ersten Ausbildungs- und Entwicklungsauftrag gemaess dem Lernpfad Lehrjahr 1 bis 3.
- Die mitgeltende `Leitlinie_Sichere-Entwicklungs-Sandbox.md` beschreibt das Sandbox-Referenzprofil fuer KI-Agenten, Spec Kit, MSL-basierte Level-2-Projekte und die oeffentlichkeitsfaehige `absdd-image-sandbox`.
- Neue Level-2-Projekte koennen diese Basis beim Bootstrap ueber `bootstrap-project.* --primary-language <Sprache>` / `-PrimaryLanguage <Sprache>` erhalten. Level-2-Repos werden standardmaessig unabhaengig vom MSL-Status als GSDB-pflichtig mit dem Acht-Preset-Profil in der lokalen Registry `~/.home-baseline/level2-repository-registry.json` registriert; begruendete Ausnahmen muessen explizit gesetzt werden. Bei Lern-Sprachrepos gilt die vorgesehene Sprache aus dem eindeutigen Repo-Suffix oder einem expliziten Sprachparameter bereits vor dem Runtime-Scaffold.
- Fuer GSDB-Zielmengen zuerst diese lokale Registry lesen; manuelle Repo-Listen sind nur ein bewusster Override. Bestehende Repos koennen mit `register-level2-repository.*` nachgetragen werden.
- Wiederkehrende Wartung prueft GSDB-Registry-Drift mit `register-level2-repository.* --scan-root` / `-ScanRoot` zuerst im Trockenlauf. Wartungsscans duerfen bekannte Sprach-, MSL-, GSDB- oder Preset-Metadaten nicht auf `unknown`, `false` oder `none` herabstufen; neu erkannte Level-2-Repositories werden nach Bestaetigung in der lokalen Registry gemerkt.
- Wiederkehrende Level-2-Wartungsrunden sind im README unter `Wiederkehrende Level-2-Wartungsrunde / Recurring Level-2 Maintenance Round` dokumentiert; dort die Reihenfolge fuer Toolchain-Pruefung, Klonen/Pullen, Registry, Spec-Kit/Governance, GSDB und Statistikabschluss verwenden.
- Bestehende Level-2-Projekte werden registry-basiert mit `prepare-rl-se-checklist-selbstpruefung.*` vor der Haertung und mit `prepare-secure-development-hardening.*` fuer den spaeteren Haertungs-Intake vorbereitet; zuerst `--dry-run` / `-WhatIf` nutzen.
- Die Vorbereitung erzeugt nur Intake- und Ordnungsartefakte: `docs/secure-development/`, `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`, `Lastenheft_Secure-Development-Hardening.md` und `Lastenheft_Abarbeitungsreihenfolge.md`.
- `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` verlangt getrennt Anwendbarkeit (`Applicable`, `N/A`, `Open`) und Umsetzung (`Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`, `Not Assessed`) sowie Begruendung, Evidenzpfad, Owner, Follow-up, Re-Evaluation-Trigger und Restrisiko.
- Das Suchmuster fuer die automatische Reihenfolge ist strikt `Lastenheft*.md`; `Lastenheft_Abarbeitungsreihenfolge.md` wird selbst nicht als Arbeitspaket einsortiert.
- Vorhandene Reihenfolge-Dateien werden geschuetzt: nur der markierte generierte Abschnitt wird aktualisiert; manuelle Begruendungen bleiben erhalten.
- `check-gsdb-self-assessment.*` prueft die GSDB ohne Spec-Kit-Lauf als Self-Assessment/Preflight. `--check-only` / `-CheckOnly` bleibt rein lesend. Ein normaler Lauf schreibt `docs/security/gsdb-self-assessment.md`, erzeugt oder aktualisiert `Lastenheft_GSDB-Spec-Kit-Intensivpruefung.md` und nimmt dieses Lastenheft in `Lastenheft_Abarbeitungsreihenfolge.md` auf.
- Diese Vorbereitung startet keinen Spec-Kit-Lauf, erzeugt keinen Feature-Branch und befuellt ausser dem GSDB-Preflight-Bericht keine weiteren `docs/security/`-Nachweise. Die eigentlichen Haertungs- und Intensivpruefungslaeufe werden separat gestartet.
- Aktive Lastenhefte fuer spaetere Spec-Kit-Laeufe SOLLEN als Intake-Dateien eine klare Mindeststruktur enthalten: Zweck, Ausgangslage, Zielbild, Scope, Nicht-Ziele, Anforderungen, erwartete Artefakte, Akzeptanzkriterien und einen kopierbaren `/speckit-specify`-Prompt. Lastenhefte mit Feature-Branch-Suffix gelten als historisch und werden nicht erneut gestartet.

*Level-2 repositories SHOULD contain the central secure-development baseline from `docs/secure-development/`, including guideline, checklists, compendium, `docs/secure-development/mitgeltende-dokumente/`, and the related-documents alignment file `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`. MSL status is a checkpoint, not a prerequisite for GSDB scope. Level-2 repositories default to GSDB-required with the eight-preset profile; justified exceptions must be explicit. A learning-language repository's intended language is valid from its unambiguous suffix or an explicit parameter before a runtime scaffold exists. Maintenance scans must not downgrade known language, MSL, GSDB, or preset metadata to `unknown`, `false`, or `none`. Existing projects are prepared with `prepare-rl-se-checklist-selbstpruefung.*` before hardening and with `prepare-secure-development-hardening.*` for the later hardening intake; use `--dry-run` / `-WhatIf` first. Read the local registry before using manual target lists. Recurring level-2 maintenance rounds are documented in the README section `Wiederkehrende Level-2-Wartungsrunde / Recurring Level-2 Maintenance Round`; use that order for toolchain checks, clone/pull, registry, Spec Kit/governance, GSDB, and statistics closeout. `check-gsdb-self-assessment.*` performs a GSDB preflight without starting Spec Kit, can run read-only with `--check-only` / `-CheckOnly`, and in normal mode writes `docs/security/gsdb-self-assessment.md`, creates or updates `Lastenheft_GSDB-Spec-Kit-Intensivpruefung.md`, and updates `Lastenheft_Abarbeitungsreihenfolge.md`. The generated intake is for a later manually started Spec Kit run; the preflight itself does not create a feature branch or claim formal hardening.*

*Secure-development baseline 3.1.0 is controlled by `docs/secure-development/baseline-manifest.json`; individual checklists are canonical and the compendium is generated. Project evidence stays under `docs/security/secure-development/<date>-<scope>/`. Every item uses separate applicability and implementation axes. Security learning starts with the first training and development task. Registry-based baseline-only propagation does not modify Lastenhefte or start Spec Kit.*

*Recurring maintenance checks GSDB registry drift with `register-level2-repository.* --scan-root` / `-ScanRoot` first as a dry run. Newly detected level-2 repositories are remembered after confirmation without downgrading stronger existing metadata.*

## Spec-Kit-Modell-Routing / Spec Kit Model Routing

- Modellwahl ist operative Agenten-Routing-Guidance, keine Feature-Anforderung. Modellnamen nicht in `spec.md`, `plan.md`, `tasks.md` oder einzelne Feature-Specs schreiben; diese Artefakte muessen reproduzierbar bleiben, auch wenn Modellnamen wechseln oder ein anderer KI-Agent verwendet wird.
- Der jeweilige Agent soll diese Empfehlungen auf seine aktuell verfuegbaren Modelle abbilden; keine feste Anbieter- oder Modellbindung ableiten.
- Fuer Spec-Kit-Spezifikation, Klaerung, Planung, Tasks und Analyse (`/speckit-specify`, `/speckit-clarify`, `/speckit-plan`, `/speckit-tasks`, `/speckit-analyze`; je nach Agent auch `/speckit.specify` usw.) das staerkste verfuegbare Frontier-Reasoning-/Coding-Modell bevorzugen.
- Fuer vollstaendige, lang laufende `/speckit-implement`-Laeufe das staerkste verfuegbare Long-Running-Agent-Modell bevorzugen; das Frontier-Modell nutzen, wenn maximale Urteilsguete wichtiger ist als Laufzeitstabilitaet.
- Fuer fokussierte Reviews oder CI-Fixes ein coding-optimiertes Modell bevorzugen.
- Fuer triviale Bereinigung, Formatierung oder risikoarme mechanische Edits ist ein schnelles kleines Coding-Modell akzeptabel.
- Die stabilen operativen Rollen heissen `frontier-reasoning`, `long-running-implementation`, `coding-review`, `fast-mechanical` und `script-only`. Installierte Presets deklarieren ihre Kommandos in `model-routing.json`; bei mehreren Wrappern gewinnt die staerkste Rolle.
- Intake-Create/Update/Delete, Intake-Review/Repair, Sequencing-Create/Update/Delete sowie Specify/Clarify/Plan/Tasks/Analyze verwenden `frontier-reasoning`. Read/Status/Next duerfen `fast-mechanical` verwenden; Stop und deterministische Validatoren bleiben `script-only`.
- Ein nicht-paralleler autonomer Lauf darf Modelle nur an einer validierten Phasengrenze wechseln. Jede Phase startet einen neuen Prozess, bindet ihr Handoff per SHA-256 und schreibt Profil, Modell und Reasoning-Aufwand in den Run-State.
- Lokale Runner-Profile muessen `fail-closed` arbeiten. Fehlendes Profil, Modell, Reasoning oder erfolgreicher Preflight fuehrt zu `Blocked`; kein stiller Fallback.

*Model choice is operational agent-routing guidance, not a feature requirement. Do not pin model names in `spec.md`, `plan.md`, `tasks.md`, or individual feature specs. Stable roles are `frontier-reasoning`, `long-running-implementation`, `coding-review`, `fast-mechanical`, and `script-only`. Installed presets declare command roles in `model-routing.json`; the strongest applicable wrapper role wins. Semantic intake and Spec-Kit decisions use frontier reasoning, read/status/next may use fast mechanical routing, and stop plus deterministic validators remain script-only. A non-parallel autonomous run changes models only at a validated phase boundary through a new process and SHA-256-bound handoff. Local profiles fail closed: missing profile, model, effort, or successful preflight results in `Blocked`, never a silent fallback.*

## Spec-Kit-Preset-Pflege / Spec Kit Preset Maintenance

- Standard-Preset-Set: `security-governance` v0.6.2 prio 10, `architecture-governance` v0.5.2 prio 20, `isaqb-architecture-governance` v0.2.2 prio 30, `a11y-governance` v0.4.3 prio 40, `cross-platform-governance` v0.2.2 prio 50, `agent-parity-governance` v0.4.2 prio 60, `autonomous-run-governance` v0.3.6 prio 70, `parallel-autonomous-run-governance` v0.2.6 prio 80.
- Optionale Presets: `model-routing-governance` v0.1.4 prio 61 sowie Intake Authoring v0.3.1 prio 64, Intake Review v0.2.1 prio 65 und Intake Sequencing v0.2.3 prio 66 bleiben ausserhalb der Standard-Achtermatrix. Thorstens verwaltete Flotte installiert alle vier ueber `model-routing-twelve-governance-presets`; bestehende Neun-, Zehn- und Elf-Preset-Profile bleiben kompatibel, ersetzen aber nicht das Zwölfer-Flottenprofil. Konkrete Modelle werden pro Rechner erkannt und nie aus einem Remote-Repository uebernommen. *Optional Model Routing v0.1.4 and the three Intake Governance presets remain outside the standard eight. Thorsten's managed fleet installs all four through `model-routing-twelve-governance-presets`; compatible nine-, ten-, and eleven-preset profiles do not replace that fleet profile. Concrete models are discovered per machine and never copied from a remote repository.*
- Intake Authoring trennt Create, Read, Update und Delete. Create schreibt nur neue Ziele; Update benoetigt aktuelle ausdrueckliche Autoritaet und archiviert den Vorgaenger; Delete verschiebt Ziel und Receipt in ein hashgebundenes Archiv und hinterlaesst einen Tombstone; Read bleibt standardmaessig eine read-only Summary. Oeffentliche Quellen sind auf statisches HTTPS mit begrenzten Antworten und SSRF-Schutz beschraenkt. Mehrere Intakes benoetigen einen vollstaendigen Series-Vorschlag und ausdrueckliche Freigabe; partielle Publikation ist unzulaessig. Materielle Fragen werden einzeln und hoechstens fuenfmal gestellt. `ReadyForReview` startet Review, Specify oder autonome Laeufe nie automatisch. *Intake Authoring separates Create, Read, Update, and Delete; protects updates and logical deletion with archived hash evidence; limits URL input to bounded public HTTPS; and requires explicit approval before publishing a complete intake series. It never infers overwrite, remote authority, or downstream execution.*
- Intake Review akzeptiert bei aktiver Projekt- oder Kampagnenpolicy nur aktuelle `Ready`- oder menschlich akzeptierte `ReadyWithAcceptedRisks`-Ergebnisse; Critical/High, offene materielle Fragen, Hash-Drift oder fehlende Worker-Coverage blockieren. Review und Status sind read-only, Repair benoetigt ausdrueckliche Aenderungsautoritaet. Series-Reviews verwenden Schema 1.1, binden den normalisierten Request-Hash und pruefen exakte Zielreihenfolge, explizite Roots sowie einen azyklischen Graphen; nicht belegbare Vorgaengerbeziehungen fuehren zu `NeedsClarification`. *Series reviews use schema 1.1, bind the normalized request hash, and verify exact target order, explicit roots, and an acyclic graph; unprovable predecessor relations result in `NeedsClarification`.*
- Intake Sequencing verwaltet nur Reihenfolge und Lifecycle bereits vorhandener Intakes. Create/Update/Delete benoetigen ausdrueckliche aktuelle Autoritaet; Read/Status/Next bleiben read-only. `next` meldet startfaehige Ziele oder konkrete Blocker, startet aber weder Review noch Specify noch autonome Laeufe. Bindende Kanten werden von reiner Liefer- oder Shared-Writer-Serialisierung unterschieden; unklare Graph- oder Abschlussfakten bleiben `NeedsClarification`. *Intake Sequencing manages only the order and lifecycle of existing intakes. It separates binding dependencies from delivery-only serialization, requires explicit write authority, and never starts downstream work.*
- `autonomous-run-governance` v0.3.6 prio 70 ist Teil der Standard-Achtermatrix. Ein vollständiger autonomer Lauf bleibt ausdrücklich delegationspflichtig; die Installation allein erteilt weder Ausführungsberechtigung noch Remote-, Merge-, Bypass- oder Provider-Rechte und `LocalImplementation` bleibt Default. Dokumentations-, Status-, Schema- oder Evidence-Änderungen gelten erst dann als testfrei, wenn keine ausführbaren Validatoren die geänderten Pfade, Marker, Schemas oder Zustandswerte konsumieren. Vor autorisierten Commits wird der exakt beabsichtigte Kandidat mit `git diff --cached --check` und Statusabgleich geprüft; fremde Änderungen bleiben unberührt. Vor einem Merge wird jeder Acceptance-Gate dem tatsächlich ausgeführten Workflow, Job, Runner beziehungsweise der Plattform und dem Befehl zugeordnet; grüne Namen oder ein Bypass ersetzen keinen technischen Nachweis. Bewusst pausierte Läufe werden als `PausedByUser` gespeichert und nur über `speckit.autonomous-resume` fortgesetzt; `speckit.autonomous-stop` wirkt kooperativ am nächsten sicheren Grenzpunkt, und ein gespeicherter Delivery-Modus ist keine aktuelle Berechtigung. Nach Preset- oder Governance-Drift werden neue zwingende Korrektheits-, Sicherheits-, Berechtigungs- und Evidenzregeln minimal mit akzeptierten Plan-, Task- und Checklist-Artefakten abgeglichen; reine Effizienzpräferenzen lösen keine rückwirkende Neugenerierung aus. Die lesbare Skill-Überschrift `Deliver` ist kein Run-State-Wert; für Remote-Closeout gelten ausschließlich `Publish`, `Review` oder `MergeAndSync`.
- `parallel-autonomous-run-governance` v0.2.6 prio 80 ist Teil der Standard-Achtermatrix. Die Installation startet keine Kampagne und erteilt keine zusaetzlichen Remote-, Merge-, Bypass-, Abbruch-, Secret- oder Provider-Rechte. Kampagnen bleiben ausdruecklich delegationspflichtig, verwenden getrennte Worktrees und maximal drei gleichzeitig aktive Worker. Schema 1.1 erlaubt ein `runnerProfile` je Worker mit Kampagnen-Fallback; Modell und Reasoning-Stufe sind optionale, nicht geheime Metadaten und werden ohne Deklaration nicht erraten. Konsolidierung verlangt exakten Head, aktuelle Review- und Check-Evidenz, ist nach Teilmerges fortsetzbar und setzt `Completed` erst nach Synchronisation, manifestdeklarierten idempotenten Post-Merge-Aktionen und Abschlussvalidierung.
- Reale Preset-8-Kampagnen setzen in jedem Worker-Repository ein installiertes und aktiviertes `autonomous-run-governance >=0.2.2` voraus. Preset 7 mit Prioritaet `70` liefert Lebenszyklus, Evidenz und Berechtigungsgrenzen; Preset 8 mit Prioritaet `80` koordiniert die Kampagne. Fehlt Preset 7, ist es deaktiviert oder zu alt, endet der Preflight vor dem Worker-Start. `requireAutonomousPreset: false` bleibt auf isolierte interne Fixtures begrenzt und ist kein Produktionsmodus. *Real Preset 8 campaigns require installed and enabled `autonomous-run-governance >=0.2.2` in every worker repository. Preset 7 at priority `70` supplies lifecycle, evidence, and authority boundaries; Preset 8 at priority `80` coordinates the campaign. Missing, disabled, or outdated Preset 7 fails preflight before worker start. `requireAutonomousPreset: false` remains limited to isolated internal fixtures and is not a production mode.*
- `a11y-governance` v0.4.3 ergänzt didaktische Inline-Code-Kommentar-Governance für neue oder geaenderte nicht-triviale Logik.
- `security-governance` v0.6.2 fuehrt `AI-SBOM` weiter als bedingt anwendbare Supply-Chain-Evidenz, ergänzt sprachspezifische Secure-Coding-Profile und ergänzt regulatorische Anwendbarkeit für NIS2, CRA, EU AI Act und DORA. Reine Entwicklungswerkzeug-Nutzung bleibt `N/A`; KI-Runtime-/Produktkomponenten benoetigen Evidenz nach G7/BSI AI-SBOM-Clustern; private Ausbildungsprojekte dokumentieren regulatorische Nichtanwendbarkeit mit kurzer Begründung.
- `architecture-governance` v0.5.2 ergänzt `BSI C3A` als bedingte Cloud-Autonomie-Evidenz und `BSI C5` als bedingte Cloud-Compliance-Assurance-Evidenz für Cloud-Service-Auswahl, Provider-Abhängigkeiten, Audit-/Nachweisstand, Shared Responsibility und Betriebsnachweise.
- Alle acht Presets enthalten ab diesem Release-Block audit-ready Spec-Kit-Run-Evidenz: `Applicable` / `N/A` / `Open`, Begründung, Evidenzpfad, Reviewer, Restrisiko und Follow-up muessen im aktuellen Spec-Kit-Lauf dokumentiert werden.
- Die ursprünglichen sechs Presets sind seit 2026-05-04 und `autonomous-run-governance` v0.2.2 ist seit 2026-07-17 im `github/spec-kit` Community-Katalog enthalten und liegen zusätzlich als veröffentlichte Repos unter `https://github.com/hindermath/spec-kit-preset-*`.
- `parallel-autonomous-run-governance` v0.2.6 ist eigenstaendig veroeffentlicht; v0.2.2 wurde mit `github/spec-kit#3591` fuer den Community-Katalog eingereicht.
- Registrierte Level-0-, Level-1- und Level-2-Repositories installieren bei vorhandener Spec-Kit-Integration standardmäßig alle acht Presets aus `scripts/config/spec-kit-governance-presets.json`, sofern keine begründete Ausnahme dokumentiert ist.
- Referenz-Rollout für alle acht Presets: `RiderProjects/TinyPl0`, `RiderProjects/TinyCalc`, `RiderProjects/TuiVision`, `RiderProjects/InventarWorkerService`.
- Installation erfolgt bevorzugt mit `install-spec-kit-governance-presets.*` aus der zentralen Matrix; die Skriptlogik enthaelt keine fest eingebauten Versionen. Bei neuen Preset-Releases zuerst die Matrix aktualisieren, dann bestehende Repos bewusst mit `--force` / `-Force` nachziehen.
- Flotten-Rollouts erfassen Level-0, Level-1 und Level-2 explizit. Eine reine Level-2-Registry beweist keine vollstaendige Abdeckung; jeder Zielstatus wird bis Installation, exakter Matrixvalidierung, Commit, Push und Remote-Synchronisation verfolgt.
- Vor dem Staging werden generierte Preset-/Agentenpfade mit dem gesamten Arbeitsbaum abgeglichen. Fremde Aenderungen bleiben unberuehrt; bei Konflikten wird ein sauberer Worktree statt eines erzwungenen Misch-Commits verwendet.
- Aktuelle normative Sechs-/Siebenerangaben werden auf die Achtermatrix migriert. Historische Statistik-, Changelog-, Feldnachweis- und Kompatibilitaetsangaben bleiben erhalten und werden durch einen dokumentierten Allowlist-Scan unterschieden.
- Provider-/Billing-Ablehnung, technischer Gate-Fehler und bestandener Gate sind getrennte Ergebnisse. Bypass oder gruene Sammelnamen ersetzen keinen exakten technischen Nachweis.
- `.specify/presets/` und generierte Agenten-/Command-Dateien committen, wenn Presets Projekt-Policy sind; `.specify/presets/.cache/` nie committen.
- Nach Installation oder Update prüfen: `specify preset list`, mindestens ein `specify preset info <id>`, bei Template-Fragen zusätzlich `specify preset resolve <template>`.
- Die lokale Arbeitskopie der veröffentlichten Preset-Repos liegt unter `~/SpecKitPresetProjects/`; kanonische Scaffolds in diesem Repo liegen unter `specs/spec-kit-presets/` und `specs/spec-kit-preset-repos/`.
- Verbesserungen an Presets zuerst im `home-baseline`-Scaffold einarbeiten, dann in die passenden Repos unter `~/SpecKitPresetProjects/` übertragen, committen, pushen und mit GitHub-ZIP-URL smoke-testen.
- Bei Änderungen an Preset-Regeln immer prüfen, ob `constitution.md`, `.specify/memory/constitution.md`, `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md` und `scripts/templates/*` ebenfalls aktualisiert werden müssen.
- Bei jeder Preset-Version oder Prioritätsänderung zuerst `scripts/config/spec-kit-governance-presets.json` aktualisieren und danach README-Tabellen, Constitution, Agenten-Dateien, `scripts/templates/speckit-workflow-section.md` und Agenten-Templates gemeinsam prüfen.
- Community-Katalog-Einreichungen an `github/spec-kit` strikt einzeln erstellen und aktivieren: erst den erzeugten PR prüfen und mergen lassen sowie das Issue abschließen, dann das nächste Issue einreichen. Bei einer bereits vorhandenen Warteschlange nur den nächsten Kandidaten für `preset-submission` benennen; keine neuen Batch-Issues oder parallelen Label-Anfragen. Grundlage ist der Maintainer-Hinweis in `github/spec-kit#3679`; der Betriebsvertrag steht in `docs/maintenance/Preset-and-Fleet-Operations-Lessons-Learned.md`. *Submit and activate `github/spec-kit` community catalog updates strictly one at a time. Complete the generated PR and issue before filing the next issue; for an existing queue, name only the next label candidate. Do not create new batch issues or parallel label requests.*

*Fleet rollouts explicitly cover level 0, level 1, and level 2 and track each
target through installation, exact matrix validation, commit, push, and remote
synchronization. Separate generated paths from unrelated work before staging.
Migrate current normative six/seven references while preserving allowlisted
history and compatibility aliases. Provider refusal, technical gate failure,
and passing evidence are distinct; bypass is not technical proof.*
- Community-/Katalog-Abstimmung läuft über `github/spec-kit#2362`.

*Standard preset set: `security-governance` v0.6.2 prio 10, `architecture-governance` v0.5.2 prio 20, `isaqb-architecture-governance` v0.2.2 prio 30, `a11y-governance` v0.4.3 prio 40, `cross-platform-governance` v0.2.2 prio 50, `agent-parity-governance` v0.4.2 prio 60, `autonomous-run-governance` v0.3.6 prio 70, and `parallel-autonomous-run-governance` v0.2.6 prio 80. `a11y-governance` v0.4.3 adds didactic inline-code-comment governance for new or changed non-trivial logic. `architecture-governance` v0.5.2 adds conditional `BSI C3A` cloud-autonomy evidence and `BSI C5` cloud-compliance assurance evidence for cloud-service selection, provider dependencies, audit/assurance status, shared responsibility, and operational evidence. `security-governance` v0.6.2 keeps conditional `AI-SBOM` evidence, language-specific secure-coding profiles, and regulatory applicability screening for NIS2, CRA, EU AI Act, and DORA: development-tool-only AI usage is `N/A`, AI runtime/product components require G7/BSI AI-SBOM cluster evidence, and private training projects record regulatory `N/A` when no regulated scope exists. All eight presets now include audit-ready Spec-Kit run evidence: `Applicable` / `N/A` / `Open`, rationale, evidence path, reviewer, residual risk, and follow-up must be documented for the current Spec-Kit run. The original six presets have been in the `github/spec-kit` community catalog since 2026-05-04, and `autonomous-run-governance` v0.2.2 was verified there on 2026-07-17. All eight are also published under `https://github.com/hindermath/spec-kit-preset-*`. `parallel-autonomous-run-governance` v0.2.2 was submitted to the community catalog as `github/spec-kit#3591`. Registered level-0, level-1, and level-2 repositories with Spec Kit default to all eight presets from `scripts/config/spec-kit-governance-presets.json` unless a justified exception is documented. Use `install-spec-kit-governance-presets.*` so preset versions stay centralized in the matrix. Commit `.specify/presets/` and generated agent command updates when presets are project policy, but never commit `.specify/presets/.cache/`. Verify installs with `specify preset list`, `specify preset info`, and where relevant `specify preset resolve`. Improve presets in the home-baseline scaffold first, propagate to standalone preset repos, then commit, push, and smoke-test via GitHub ZIP URL. Preset-rule changes and preset version/priority changes require reviewing the central matrix, constitution, README tables/install snippets, all agent guidance files, and relevant templates together. Community/catalog coordination happens in `github/spec-kit#2362`.*

<!-- EN: GEMINI.md placeholder
[DE-Zusammenfassung: GEMINI.md enthaelt Antigravity-CLI-Anweisungen fuer das home-baseline Repository.]
-->

## Aktive Technologien / Active Technologies
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + git ≥ 2.13 (required for `includeIf`), gh CLI (existing dependency) (003-git-config-scope)
- File system — `~/.gitconfig` (INI), `~/.gitconfig.d/*.inc` (INI fragments) (003-git-config-scope)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `gh` CLI, `glab` CLI (optional), `tar` (built-in), `git` ≥ 2.13 (005-workspace-teardown)
- File system — `~/WorkspaceName/`, remote repo, `~/README.md`, `~/.gitignore`, `~/.gitconfig`, `~/.gitconfig.d/` (005-workspace-teardown)
- Bash 3.x+ (macOS/Linux) · PowerShell 7+ (Windows) + `glab` ≥ 1.40 (GitLab support), `gh` ≥ 2.30, `git` ≥ 2.30 (006-gitlab-support)
- Existing script files plus `~/README.md` row updates for GitHub/GitLab bootstrap flows (006-gitlab-support)
- Bash 3.x+ (macOS/Linux), PowerShell 7+ (Windows) + `specify` CLI ≥ 0.8.3, `git` ≥ 2.30 (008-spec-kit-update-automation)

## Letzte Änderungen / Recent Changes
- 003-git-config-scope: Git-Konfiguration Scope-Isolierung — `includeIf` in `~/.gitconfig`, `~/.gitconfig.d/` als workspace-spezifische Include-Fragmente; bootstrap-workspace, sync-home, check-homogeneity und pre-push hook erweitert
- 005-workspace-teardown: `teardown-workspace.sh/.ps1` — Backup, Remote-Löschung (GitHub/GitLab), lokale Löschung, Artefakt-Bereinigung; `--teardown`-Alias in `bootstrap-workspace.*`
- 006-gitlab-support: Added GitLab CLI support, self-hosted GitLab URL handling, and `glab auth login` pitfall guidance
- 007-gitlab-release-automation: Added `setup-gitlab-release.*`, reusable GitLab release templates, detached-head and changelog-refresh fixes, and a non-blocking manual `release` job validated with real GitLab releases in `sysinfotool` (`v0.1.0`) and `inventarworkerservice2` (`v0.0.1`)
- 008-spec-kit-update-automation: Added `update-spec-kit.*` for dynamic Level-0/1/2 Spec-Kit refreshes, governance-template preservation, TuiVision inclusion, and `.opencode/command` tracking

<!-- learner-a11y-baseline:start -->
## Hinweise zur Lernenden- und A11Y-Basis / Notes on the Learner and A11Y Baseline

- Verbindliche Zielgruppen ab dem ersten Ausbildungsjahr sind
  Fachinformatiker*innen, IT-System-Elektroniker*innen, Kaufleute für
  IT-System-Management und Kaufleute für Digitalisierungsmanagement.
- Lern-, Bedien-, Governance- und Spec-Kit-Inhalte stehen auf Deutsch zuerst
  und Englisch danach, verwenden ungefähr CEFR B2 und erklären Fachbegriffe
  beim ersten Auftreten.
- Spec-Kit-Erfahrung wird nicht vorausgesetzt. Befehle, Artefakte, Zustände und
  Übergänge werden beim ersten Gebrauch verständlich eingeführt.
- Abhängigkeiten, Zustände und Entscheidungen erhalten eine vollständige
  textorientierte Erklärung; eine ausschließlich visuelle Darstellung genügt
  nicht.
- `Programmierung #include<everyone>` und WCAG 2.2 Level AA gelten als
  verbindliche Prüfbasis, soweit die Kriterien auf das Artefakt anwendbar sind.

*The binding audience starts in the first training year and includes IT
specialist apprentices, IT systems electronics technician apprentices, and
both IT management occupations. Learner, usage, governance, and Spec Kit
content is German-first/English-second at about CEFR B2, explains technical
terms at first use, assumes no prior Spec Kit experience, and never relies on
visual-only dependency, state, or decision information. `Programmierung
#include<everyone>` and WCAG 2.2 Level AA are the review baseline wherever
applicable.*
<!-- learner-a11y-baseline:end -->

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
