# Bedrohungsmodell / Threat Model: home-baseline

**Stand / State**: 2026-08-01
**Umfang / Scope**: Agentic Workspace Maintenance und Wartungs-TUI

## Systemgrenze / System Boundary

```text
Benutzer/Tastatur
  -> TUI oder Plain-Assistent
  -> typisierte Prozessargumente
  -> Bash-/PowerShell-Engine
  -> Python-Vertragskern, lokale Git-Repositories und Paketmanager

Engine -> private JSONL-Ereignisse -> TUI-Live-Anzeige
Engine -> atomarer JSON-Bericht + Exitcode -> Ergebnisabgleich
```

Die TUI ist keine neue Wartungs-Engine. Sie darf keine Zielrepository-Aktion,
kein Secret, keine Providerberechtigung und keine
Administratorautorisierung hinzufügen.

## STRIDE

| Kategorie | Bedrohung | Kontrolle |
|---|---|---|
| Spoofing | Fremdes Ereignis oder Bericht behauptet einen anderen Lauf | UUID-Bindung, Sequenz, vorgebundener Berichtspfad, finalisierter Bericht |
| Tampering | Cache, JSONL oder Bericht wird verändert | SHA-256-/Plattformprüfung, striktes JSON, Ergebnisabgleich |
| Repudiation | Unklar, welche Auswahl gestartet wurde | sichtbarer Befehl, Run-ID, Log, Bericht und Eventpfad |
| Information Disclosure | Pfad oder Meldung enthält Secret/Markup | privates State-Verzeichnis, Secret-Scan, Markup-Escaping |
| Denial of Service | Hängender Build, Lock oder langsamer Eventstrom | Plain-Fallback, begrenzter Lock-Wait, 10-Hz-Anzeige |
| Elevation of Privilege | UI-Bestätigung wird als Adminrecht behandelt | Least Privilege, getrennte `allow-admin-prompts`-Autorität |

## CIA und CAPEC / CIA and CAPEC

- **Confidentiality:** Ereignisse und Cache liegen unter dem privaten
  Home-State. Freie Konsolentexte werden nicht als Protokoll geparst.
- **Integrity:** Prozessargumente sind typisiert; Event, Bericht und Exitcode
  werden unabhängig geprüft. Der Berichtspfad ist vor Prozessstart an Home und
  Run-ID gebunden; eine Suche nach der neuesten Datei ist ausgeschlossen.
- **Availability:** Der Plain-Assistent bleibt ohne Enhanced-TUI verfügbar.
- **CAPEC-15 Command Delimiters:** Kein `eval`, `Invoke-Expression` oder
  ausführbarer zusammengesetzter Befehlsstring.
- **CAPEC-23 File Content Injection:** Striktes JSON und Spectre-Markup-Escaping.
- **CAPEC-126 Path Traversal:** Eventpfad ist auf
  `.home-baseline/events` begrenzt; Cachepfade werden intern abgeleitet.

## Restrisiko und Wiedervorlage / Residual Risk and Re-evaluation

Ein kompromittiertes Benutzerkonto kann private lokale Dateien verändern.
Das System ersetzt keine Betriebssystem-Isolation. Neu bewerten bei
öffentlicher Binärverteilung, Netzwerk-UI, Remote-Events, Plugin-System,
automatischer Elevation oder zusätzlicher Providerautorität.

<!-- EN: docs/security/threat-model.md
[DE-Zusammenfassung: STRIDE-, CIA- und CAPEC-Modell für Wartungs-TUI und Engine.]
-->

## Feature 029: CI-Budget-Governance

Trust Boundaries: versionierte Registries/Templates, ausführendes Git-Repository,
GET-only-GitHub-Beobachtung, Gate-Kindprozesse, maschinenlokale Evidence und
Pre-push-Hook. Datenklassen: öffentliche IDs/Verträge; private Sichtbarkeit und
Minuten als minimierte lokale Metadaten; Credentials, Actor-Namen, Logs und
Billing-Rohdaten sind verboten.

- STRIDE: manipulierte Zuordnung/Pfadregistry (Tampering), fremde Evidence
  (Spoofing), unklare Befehle (Repudiation), Rohantworten (Disclosure), Retry-
  Schleifen (DoS), Ruleset-/Adminpfade (Elevation).
- CIA: getrennte Hashes und atomare HEAD-Bindung schützen Integrität;
  Datenminimierung schützt Vertraulichkeit; begrenzte Retries/Timeouts und
  Offline-Fixtures schützen Verfügbarkeit.
- CAPEC-15/126/23: Argument-Arrays mit `shell=False`, keine Traversal-/Symlink-
  Escapes und strikte JSON-Felder. CAPEC-115 Authentication Bypass wird durch
  die unabhängige PR-/Statuspflicht adressiert.
- Least Privilege, Fail-Safe Defaults, Attack Surface Reduction und Separation
  of Concerns: Remote nur GET; Wrapper, Vertragskern, Runner, Publisher und Hook
  besitzen getrennte Rollen. Jede unbekannte Eigenschaft blockiert.

Restrisiko: Ein kompromittiertes Benutzerkonto kann lokale Hooks ändern. Der
separate Serververtrag bleibt daher Pflicht. Re-Evaluation bei Remote-
Mutation, neuer Dependency, Auth-, Crypto-, Provider- oder Trust-Boundary-
Änderung.
