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

## Feature 030: Stage-B-Remote-Transaktion / Stage B Remote Transaction

**Status / Disposition**: `Applicable`; lokaler Entwurf und deterministische
Provider-Fixtures sind geprüft. Live-Providerfakten bleiben bis T127 ff. ein
blockierendes Gate. / The local design and deterministic provider fixtures are
reviewed; live provider facts remain a blocking gate until T127 ff.

Vertrauensgrenzen sind getrennt zwischen Level-0-Arbeitsbaum und Git-Index,
isoliertem Ziel-Worktree, Git-Objekten und Remote-Head, authentifizierter
GitHub-API, PR/Checks/Review, Ruleset, aktueller Authority, unveränderlichem
Plan, veränderlichem Run-State sowie redigierter operativer Evidence. Keine
Grenze übernimmt Vertrauen von einer anderen; Identität, Head, Hash und
Authority werden unmittelbar vor der abhängigen Aktion erneut vermittelt.

| Kategorie | Stage-B-Bedrohung | Kontrolle und Nachweis |
|---|---|---|
| Spoofing | Repositoryname, PR oder Check gehört nicht zur gebundenen numerischen Provider-ID | feste Host-Allowlist, numerische ID, kanonischer Slug, PR-/Head-/Runnerbindung |
| Tampering | Plan, Kandidat, Ruleset oder Evidence driftet zwischen Prüfung und Write | direkter SHA-256, exakter Blob-/Mode-Diff, immutable Plan, atomare Publikation, erneutes ExternalWriteGate |
| Repudiation | Push, Merge, Bypass oder Restore ist später nicht kausal zuordenbar | Run-/Repository-/Action-Idempotency-Key, Provideraktions-ID, PreMerge-/PostMerge-Kette |
| Information Disclosure | Token, private Pfade, Actor oder Providerrohantwort gelangen in Evidence | minimierte Allowlist-Felder, Redaktionsprüfung, Output-Limit, restriktive maschinenlokale Rechte |
| Denial of Service | Retry-Schleife, Budgetdrift oder halb ausgeführte Welle | begrenzte Read-Retries, kein blinder Write-Retry, serieller Writer, atomarer Stop vor Folgeziel |
| Elevation of Privilege | Admin-Bypass oder Ruleset-Write wird Normalpfad | regulärer Review/Merge zuerst, protection-only Refusal, frische enge Ausnahme-Evidence, keine Bypass-Akteure im Ruleset |

- **CIA**: Vertraulichkeit entsteht durch Datenminimierung und Redaction;
  Integrität durch Plan-/Run-/Head-/Evidence-Hashketten; Verfügbarkeit durch
  Stop/Resume, Reconciliation und begrenzte Leseversuche ohne Sicherheits-
  oder Budgetgrenzen zu umgehen.
- **CAPEC-115 Authentication Bypass**: Review-, Gate- und Ruleset-Pflichten
  bleiben auch bei eng autorisiertem Admin-Bypass unabhängig vollständig.
- **CAPEC-15 Command Delimiters**: Git, `gh` und Validatoren erhalten nur
  validierte Argumentarrays; kein Shell-String, `eval` oder
  `Invoke-Expression`.
- **CAPEC-126 Path Traversal**: repository-relative Allowlist-Pfade,
  Root-Containment, Symlink-Escape-Prüfung und `--` vor Pfadargumenten.
- **CAPEC-23 File Content Injection**: kanonisches UTF-8/LF-JSON, geschlossene
  Schemas, NUL-/CR/LF-/Metazeichen-Negativtests und Redaktion vor Publikation.

Owner: Security Architecture Owner. Reviewer: Security Reviewer. Restrisiko:
Provider-, Schutzregel- oder Authority-Zustand kann nach lokaler Prüfung
driften. Re-Evaluation bei Plan-, Head-, Provider-, Ruleset-, Bypass-,
Resume-, Schema- oder Trust-Boundary-Änderung.

## Feature 031: Copilot-Review-Governance

Assets sind der Acht-Ziel-Vertrag, Account-/Repository-/Ruleset-Identitäten,
Authority- und Rollbackrecords sowie redigierte Evidence (Vertraulichkeit,
Integrität, Verfügbarkeit). STRIDE/CAPEC: ID- oder State-Spoofing wird durch
exakte IDs und Freshness blockiert; Evidence-Tampering durch kanonische Hashes,
atomaren Replace und restriktive Rechte; Repudiation durch Operationsklasse,
Owner/Reviewer und Result-Envelope; Disclosure durch Redaction und verbotene
Cookies/Tokens/HTML/private Pfade; Provider-DoS durch höchstens drei GET-Retries
ohne Write-Retry; Privilege Escalation durch getrennte Least-Privilege-Gates.
Relevant sind CAPEC-115 Authentication Bypass, CAPEC-122 Privilege Abuse,
CAPEC-165 File Manipulation und CAPEC-212 Functionality Misuse. Jede Boundary
hat Hard Stop als Mitigation. Restrisiko: externer TOCTOU-Drift. Owner: Security
Owner; Reviewer: Security Reviewer; Trigger: API/UI/Identity/Gate/Hash-Drift.
