# Bedrohungsmodell / Threat Model: home-baseline

**Stand / State**: 2026-07-29
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
| Spoofing | Fremdes Ereignis oder Bericht behauptet einen anderen Lauf | UUID-Bindung, Sequenz, finalisierter Bericht |
| Tampering | Cache, JSONL oder Bericht wird verändert | SHA-256-/Plattformprüfung, striktes JSON, Ergebnisabgleich |
| Repudiation | Unklar, welche Auswahl gestartet wurde | sichtbarer Befehl, Run-ID, Log, Bericht und Eventpfad |
| Information Disclosure | Pfad oder Meldung enthält Secret/Markup | privates State-Verzeichnis, Secret-Scan, Markup-Escaping |
| Denial of Service | Hängender Build, Lock oder langsamer Eventstrom | Plain-Fallback, begrenzter Lock-Wait, 10-Hz-Anzeige |
| Elevation of Privilege | UI-Bestätigung wird als Adminrecht behandelt | Least Privilege, getrennte `allow-admin-prompts`-Autorität |

## CIA und CAPEC / CIA and CAPEC

- **Confidentiality:** Ereignisse und Cache liegen unter dem privaten
  Home-State. Freie Konsolentexte werden nicht als Protokoll geparst.
- **Integrity:** Prozessargumente sind typisiert; Event, Bericht und Exitcode
  werden unabhängig geprüft.
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
