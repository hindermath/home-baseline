# Sicherheits-Checkliste / Security Checklist: home-baseline

**Stand / State**: 2026-07-29
**Prüfer / Reviewer**: Feature-018-Review

## Anwendbar / Applicable

- [x] NIST SSDF: Anforderungen, Design, Test-first-Proof und
  Lieferkettennachweis sind versioniert.
- [x] CWE Top 25: Prozess-, Pfad-, JSON- und Markup-Eingaben besitzen
  Negativtests.
- [x] OWASP SAMM: Design-, Implementation- und Verification-Evidence ist
  verknüpft.
- [x] Shell: Variablen sind zitiert; kein `eval`; interne Optionen sind
  getrennt.
- [x] PowerShell: Strict Mode, validierte Parameter, keine dynamische
  Ausführung.
- [x] C#: Nullable, typed `ArgumentList`, striktes JSON, keine Shell-Strings.
- [x] Abhängigkeiten: feste Versionen, Lockfiles, offizielle Quelle,
  Vulnerability-Scan.
- [x] Geheimnisse: keine Zugangsdaten in Events, Cache, Tests oder Git.
- [x] A11Y: Tastatur, Textstatus, `NO_COLOR`, schmale und lineare Ausgabe.

## Nicht anwendbar / Not Applicable

- [x] ASVS: keine Webanwendung, Authentifizierung oder HTTP-API.
- [x] Zero Trust, BSI C3A/C5: keine Cloud-, Identitäts- oder
  Provider-Servicegrenze.
- [x] NIS2, CRA, EU AI Act, DORA: kein regulierter oder am Markt
  bereitgestellter Dienst.
- [x] AI-SBOM: kein KI-Modell in der Laufzeit.
- [x] SLSA/Scorecard: keine öffentliche Binär- oder Paketveröffentlichung.

Jede N/A-Entscheidung wird neu geprüft, wenn eine der genannten Grenzen in
den Feature-Scope aufgenommen wird.

<!-- EN: docs/security/security-checklist.md
[DE-Zusammenfassung: Sicherheits- und N/A-Entscheidungen für Feature 018.]
-->

## Feature 029: CI-Budget-Governance

- [x] NIST SSDF/CWE Top 25: Eingaben, Pfade, Referenzen, Subprozesse und
  Fehlerkanäle besitzen positive und negative Tests.
- [x] Bash: `set -euo pipefail`, gequotete Arrays, kein `eval`.
- [x] PowerShell: Strict Mode, validierte Parameter, unmittelbare
  `$LASTEXITCODE`-Weitergabe, kein `Invoke-Expression`.
- [x] Python: `subprocess` nur mit Argument-Arrays und `shell=False`, begrenzte
  Arbeitsverzeichnisse/Timeouts, keine dynamische Ausführung.
- [x] Datei-/Netz-I/O: Traversal, Symlink, NUL, Zeilenumbruch und führende
  Bindestriche blockieren; GitHub-Transport ist GET-only.
- [x] Secrets/Logging: Secret-Scan bleibt im Hook; Rohantworten, Tokens,
  Actors, Home-Pfade und Billingdetails werden nicht publiziert.
- [x] Kryptografie: SHA-256 bindet Registries, Gate-Set, Inputs und Evidence;
  keine neue Verschlüsselungs- oder Signaturfunktion.
- [x] Mutationsbarriere: kein Commit, Push, Merge, Home-Sync, G4 oder aktiver
  Workflow-/Ruleset-/Account-/Reviewer-Pfad.
- [x] Bash bleibt als bestehende native Unix-Oberfläche begründet; der
  gemeinsame Python-Kern und PowerShell/.NET sind MSL. Keine neue Runtime.
- [x] Defense in Depth: lokaler Hook plus unabhängiger simulierter Server-Gate.

Owner: Feature Owner; Reviewer: Security Reviewer. Restrisiko: ein lokaler
Hook ist umgehbar. Follow-up: Serververtrag nur unter neuer Stufe-B-Autorität
anwenden. Re-Evaluation bei Input-, Dependency-, Auth-, Crypto-, Datei-, Netz-
oder Authority-Änderung.
