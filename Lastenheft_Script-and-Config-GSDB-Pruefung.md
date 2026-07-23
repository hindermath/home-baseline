<!-- intake-authoring:begin -->
# Lastenheft: Script and Config GSDB-Pruefung

**Repository:** home-baseline
**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** vorbereitet fuer separaten GSDB-Prueflauf
**Stand:** 2026-07-03

## 1. Zweck / Purpose

Dieses Lastenheft bereitet einen spaeteren, fokussierten Spec-Kit-Lauf zur
GSDB-Pruefung der Skript- und Konfigurationsflaechen vor. Ziel ist eine
nachvollziehbare Evidenzmatrix fuer die operativen Tooling-Pfade, nicht eine
pauschale Haertung des gesamten Repositorys.

*This requirements document prepares a later focused Spec Kit run for a GSDB
review of script and configuration surfaces. The goal is a traceable evidence
matrix for operational tooling paths, not a broad hardening pass over the whole
repository.*

## 2. Ausgangslage / Current State

`home-baseline` steuert Workspaces, Level-2-Repos, Spec-Kit-Integrationen,
Hooks, Secret-Scanning, Lernreihen-Paketierung und GSDB-Propagation ueber
Skripte und Konfigurationsdateien. Diese Flaechen sind sicherheitsrelevant,
weil sie lokale Dateien schreiben, Git-Remotes ansprechen, Registry-Daten
verarbeiten, CI beeinflussen und Agentenarbeit vorbereiten.

Die generische Secure-Development-Basis liegt unter `docs/secure-development/`.
Dieses Lastenheft nutzt sie als Pruefgrundlage, startet aber selbst keinen
Spec-Kit-Lauf und nimmt keine formale Freigabe vor.

## 3. Pruefgrundlagen / Review Baseline

Der spaetere Lauf muss mindestens diese Grundlagen beruecksichtigen:

- `docs/secure-development/Richtlinie_Sichere-Entwicklung.md`
- `docs/secure-development/Checklistensammelband_Sichere-Entwicklung.md`
- `docs/secure-development/checklisten/CL_01_*.md` bis `CL_12_*.md`
- `docs/secure-development/mitgeltende-dokumente/`
- `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`
- `constitution.md` und `.specify/memory/constitution.md`
- installierte Governance-Presets, soweit sie Projekt-Policy sind
- vorhandene Nachweise unter `docs/security/`

## 4. Scope

In Scope:

- Bash- und PowerShell-Skripte unter `scripts/`
- Hilfsbibliotheken unter `scripts/lib/`
- relevante `.specify/`-Skripte und Workflows
- `.github/workflows/*.yml`
- repo-eigene JSON-/JSONC-Konfigurationen und YAML-Konfigurationen
- lokale Registry- und Beispielregistry-Pfade, soweit sie von Skripten gelesen
  oder geschrieben werden
- Evidence fuer `Applicable`, `AlreadySatisfied`, `N/A`, `Open` und `FollowUp`

Out of Scope:

- keine vollstaendige GSDB-Pruefung aller Markdown- oder Lernreihenartefakte
- keine automatische Haertung ohne konkrete Spec-Kit-Aufgabe
- keine Secret-Rotation, keine Providerfreigabe, keine Branch-Protection-
  Aenderung und keine Repo-Sichtbarkeitsaenderung
- keine JSONC-Migration ohne nachgewiesene Parser-Kompatibilitaet
- keine formale Audit- oder Compliance-Freigabe

## 5. Sicherheitsstandards / Security Standards

Der spaetere Lauf benennt je Pruefpunkt die Anwendbarkeit:

- NIST SSDF und CWE Top 25: immer pruefen.
- OWASP Cheat Sheet Series und OWASP Proactive Controls: fuer Skript-, CLI-,
  Datei-, Netzwerk-, Secrets- und CI-relevante Punkte pruefen.
- OWASP ASVS: `N/A`, sofern kein Web-/API-/HTTP-/Auth-Service betroffen ist;
  andernfalls Scope und Level explizit benennen.
- SBOM/SLSA/VEX: fuer verteilbare Artefakte, CI/CD, Release-Skripte und
  Abhaengigkeiten pruefen.
- AI-SBOM: `N/A`, solange nur Entwicklungswerkzeuge KI nutzen und keine
  KI-Runtime-/Produktkomponente ausgeliefert oder betrieben wird.
- BSI C3A/C5, NIS2, CRA, EU AI Act und DORA: als Anwendbarkeitsmatrix mit
  kurzer `N/A`-Begruendung fuer private Ausbildungs- und Tooling-Kontexte.

## 6. Pruefbereiche / Review Areas

Der spaetere Lauf prueft insbesondere:

- Trust Boundaries bei Pfaden, Registry-Dateien, Repo-Zielen und Remote-URLs
- sichere Shell-/PowerShell-Parameterverarbeitung und Quoting
- `set -euo pipefail`, `Set-StrictMode`, Fehlerbehandlung und Exit-Codes
- Secret-Scanning, Hook-Installation und False-Positive-Behandlung
- GitHub-/GitLab-/Git-Operationen, Branch-Kontext und nicht-destruktive
  Defaults
- lokale Registry `~/.home-baseline/level2-repository-registry.json` und
  public-safe Beispielregistry
- JSON/JSONC/YAML-Parsergrenzen und Kompatibilitaet
- CI-Workflow-Rechte, Matrix-Logik, Pinning und Supply-Chain-Hinweise
- Spec-Kit-Preset-Installation und Governance-Propagation
- Paketierung von Lernreihen, ZIP-Erstellung und Ausschluss lokaler Daten

## 7. Statusmodell / Status Model

Jeder Pruefpunkt erhaelt genau einen Status:

- `Applicable`: gilt und braucht Evidenz oder Umsetzung.
- `AlreadySatisfied`: ist im aktuellen Stand bereits nachweisbar erfuellt.
- `N/A`: gilt nicht und braucht eine kurze technische oder fachliche
  Begruendung.
- `Open`: gilt, ist aber noch nicht ausreichend belegt oder umgesetzt.
- `FollowUp`: fachlich relevant, aber bewusst ausserhalb dieses Laufs.

Jeder Eintrag braucht Evidenzpfad, Begruendung, Owner, Restrisiko und
Re-Evaluation-Trigger.

## 8. JSONC-Anwendbarkeit / JSONC Applicability

JSONC ist als Konfigurationsformat nur dann zulaessig, wenn der Lauf
nachweist, dass alle Konsumenten Kommentare lesen oder vor strict-JSON-Parsing
robust entfernen koennen.

Der Lauf dokumentiert fuer jede JSON-Datei:

- ob sie repo-eigen oder extern/toolgebunden ist
- welcher Code oder welches Tool sie liest
- ob Pfad und Dateiendung stabil bleiben muessen
- ob JSONC-Kommentare fachlichen Mehrwert bringen
- welche Tests Parser-Kompatibilitaet belegen

Ohne diesen Nachweis bleibt die Datei strict JSON.

## 9. Erwartete Ergebnisartefakte / Expected Result Artefacts

| Artefakt | Erwartung |
|---|---|
| GSDB-Evidenzmatrix | Status, Begruendung, Evidenzpfad, Owner, Restrisiko und Follow-up |
| Standardsmatrix | NIST SSDF, CWE Top 25, OWASP, SLSA/SBOM/VEX, AI-SBOM und regulatorische Anwendbarkeit |
| JSONC-Kompatibilitaetsmatrix | Kandidaten, strict-JSON-Pflicht und Parser-Nachweise |
| Skript-/Workflow-Risikomatrix | Trust Boundaries, Secrets, Remote-I/O, Dateipfade und CI |
| Abschlussnotiz | offene Punkte, Follow-ups und Re-Evaluation-Trigger |

## 10. Akzeptanzkriterien / Acceptance Criteria

- Alle relevanten Skript-, JSON/JSONC-, YAML- und Workflow-Flaechen sind
  sichtbar behandelt.
- Kein GSDB-Pruefpunkt wird stillschweigend ausgelassen.
- Jede positive Aussage verweist auf konkrete Evidenz.
- Jede Nichtanwendbarkeit ist als `N/A` begruendet.
- Jeder offene Punkt hat Owner, Follow-up, Risiko und Re-Evaluation-Trigger.
- JSONC wird nur mit Parser-Nachweis und Teststrategie akzeptiert.
- Der Lauf startet keine formale Freigabe und behauptet keine Human-only-Punkte
  als erledigt.

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_Script-and-Config-GSDB-Pruefung.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation fuer eine GSDB-Pruefung der Skript-, JSON/JSONC-, YAML- und Workflow-Flaechen im home-baseline-Repository.

Ziel: Pruefe Bash-, PowerShell-, JSON/JSONC-, YAML- und CI-Workflow-Flaechen gegen docs/secure-development/, constitution.md, .specify/memory/constitution.md, vorhandene docs/security/-Nachweise und installierte Governance-Presets. Erzeuge eine Evidenzmatrix mit Applicable, AlreadySatisfied, N/A, Open und FollowUp.

Wichtig:
- Starte keine automatische Haertung und keine formale Freigabe.
- Pruefe NIST SSDF und CWE Top 25 immer.
- Pruefe OWASP Cheat Sheets/Proactive Controls, SLSA/SBOM/VEX, AI-SBOM, BSI C3A/C5, NIS2, CRA, EU AI Act und DORA mit expliziter Anwendbarkeit oder N/A-Begruendung.
- AI-SBOM bleibt N/A, wenn nur Entwicklungswerkzeuge KI nutzen und keine KI-Runtime-/Produktkomponente ausgeliefert oder betrieben wird.
- Pruefe Trust Boundaries, Pfade, Registry-Dateien, Secret-Scanning, GitHub-/GitLab-/Git-Operationen, CI-Rechte, Parsergrenzen und Paketierung.
- JSONC ist nur zulaessig, wenn alle Leser und Tests Parser-Kompatibilitaet belegen; ansonsten bleibt strict JSON.
- Dokumentiere je Pruefpunkt Evidenzpfad, Begruendung, Owner, Restrisiko, Follow-up und Re-Evaluation-Trigger.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Script-and-Config-GSDB-Pruefung.md Fuehre den vollstaendigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake und bewahre alle Anforderungen, Nicht-Ziele, Sicherheits-, A11Y-, Plattform-, Evidence- und Abnahmegrenzen. Implementiere und validiere nur lokal. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
