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

## Feature 030: Stage-B-Sicherheitsreview / Stage B Security Review

**NIST SSDF / CWE Top 25**

- [x] **PW.1/PW.4 – Design und sichere Implementierung**: Spec, Plan,
  geschlossene Schemas, Threat Model und ADR binden Trust Boundaries,
  ExternalWriteGate und exakte Remote-Transaktionen vor einem Writer.
- [x] **PW.7 – Code Review**: Python-, Bash- und PowerShell-I/O wurde gegen
  Injection, Traversal, SSRF, unklare Providerantworten, Auth-/Authority-
  Verwechslung und Restricted-Ausgabe geprüft.
- [x] **PW.8/PW.9 – Testen und Schwachstellenbehebung**: Contract-,
  ProviderBoundary-, SecurityBoundary-, Ruleset-, Bypass-, Stop/Resume- und
  Redaktionsfixtures decken positive und negative Grenzen ab; T124 bleibt das
  vollständige lokale Regressionsgate.
- [x] **PS.2/PS.3 – Herkunft und Integrität**: Keine neue Dependency; direkte
  Plan-/Run-/Head-/Blob-/Evidence-SHA-256-Bindungen und atomare Publikation.
- [x] **CWE Top 25**: OS Command Injection, Path Traversal, Improper Input
  Validation, Authorization Bypass, SSRF, Uncontrolled Resource Consumption,
  Cleartext Secret Exposure und Improper Output Neutralization sind durch
  geschlossene Eingaben und Negativfixtures dispositioniert.

**Sichere Sprach- und I/O-Grenzen / Secure Language and I/O Boundaries**

- [x] Python startet Git, `gh` und Validatoren ausschließlich als Executable
  plus Argumentliste mit `shell=False`, festem Arbeitsverzeichnis, Timeout und
  begrenzter/redigierter Ausgabe. Providerhost, numerische ID, Slug, Methode
  und Endpoint werden vor Netzwerk-I/O validiert.
- [x] Bash 3.2 nutzt `set -euo pipefail`, gequotete Variablen/Arrays, `--` für
  Pfade und kein `eval`; PowerShell 7 nutzt Strict Mode, validierte Enums/Pfade,
  unmittelbaren `$LASTEXITCODE` und kein `Invoke-Expression`.
- [x] Authentifizierung aus dem bestehenden Credential Store ist keine
  Autorisierung. `MergeAndSync`, Run-/Scope-/Plan-/Repository-ID-Hash und
  aktueller ExternalWriteGate werden vor jeder Write-Klasse neu geprüft.
- [x] Datei-I/O bleibt repository-relativ, Root-/Symlink-geprüft, atomar
  (`temp` + Flush/`fsync` + Replace) und mit restriktiven Rechten. Teil- oder
  schemaungültige Evidence wird nicht publiziert.
- [x] Netzwerk-I/O trennt bounded Reads von einmaligen Writes. Ein Timeout nach
  Write löst read-only Reconciliation über den Idempotency Key aus, nie einen
  blinden Retry.
- [x] Fehler und Logs nennen stabilen Blockercode, Status und nächste sichere
  Aktion, aber keine Tokens, Connection Strings, privaten Home-Pfade, Actor-
  Namen, Providerrohdaten oder Stacktraces für Endnutzer.
- [x] Secret Scan, Redaktionsfixtures und die getrennte maschinenlokale
  Evidence-Grenze schützen Credentials und unnötige Personendaten.

Die Kontrollen belegen Defense in Depth, Least Privilege, Fail-Safe Defaults,
Attack Surface Reduction und Separation of Concerns im gemeinsamen Python-
Kern und den dünnen Plattformadaptern. Owner: Security Owner. Reviewer:
Secure-Coding Reviewer. Restrisiko: Ein kompromittierter lokaler Account oder
zeitgleicher Providerdrift bleibt außerhalb vollständiger lokaler Kontrolle.
Re-Evaluation bei Dependency-, Auth-, Authority-, Crypto-, Datei-, Netzwerk-,
Logging-, Provider-, Ruleset- oder Plattformänderung.
