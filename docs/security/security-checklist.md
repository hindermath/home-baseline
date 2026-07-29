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
