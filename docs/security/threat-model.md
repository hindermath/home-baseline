# Bedrohungsmodell / Threat Model: home-baseline

**Projekt / Project**: home-baseline (Level-1)
**Erstellt / Created**: 2026-04-24
**Status**: Stub — mit projektspezifischen Inhalten zu befuellen / Stub — to be populated with project-specific content
**Template-Quelle / Template Source**: `.specify/templates/threat-model-template.md`
**Constitution-Referenz / Constitution Reference**: Principle XIII (A.8.27), Principle XII (A.8.28)

<!--
  Dieses Dokument ist ein Stub. Die vollstaendige Struktur findet sich im
  Template unter .specify/templates/threat-model-template.md.
  Bei der Befuellung das Template als Vorlage verwenden.

  This document is a stub. The complete structure can be found in the
  template at .specify/templates/threat-model-template.md.
  Use the template as a guide when populating.
-->

## Geltungsbereich / Scope

home-baseline verwaltet Workspace-Bootstrapping, Git-Hook-Installation,
Credential-Scanning und KI-Agenten-Auditing. Es laeuft ausschliesslich
lokal auf dem Entwickler-Rechner (macOS, Linux, Windows).

*home-baseline manages workspace bootstrapping, git hook installation,
credential scanning, and AI agent auditing. It runs exclusively on the
developer's local machine (macOS, Linux, Windows).*

## Trust Boundaries / Vertrauensgrenzen

```text
  +-----------+    TB1    +------------------+    TB2    +----------+
  | Benutzer  | --------> | home-baseline    | --------> | GitHub / |
  | / User    |  lokal    | Scripts & Hooks  |  HTTPS    | GitLab   |
  +-----------+           +------------------+           +----------+
                               |
                          TB3  |
                               v
                          +------------------+
                          | Credential Store |
                          | (Keychain / CM)  |
                          +------------------+
```

## STRIDE-Analyse / STRIDE Analysis

[Zu befuellen / To be populated — see template]

## Risikobewertung / Risk Assessment

[Zu befuellen / To be populated — see template]
