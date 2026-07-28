# Governance Requirements Quality Checklist

**Purpose**: Die Vollständigkeit, Klarheit und Prüfbarkeit der bindenden
Governance-Anforderungen vor Tasks und Implementierung bewerten.  
**Created**: 2026-07-28  
**Feature**: `specs/016-linux-maintenance-hardening/spec.md`

## Scope and authority

- [x] CHK001 Ist der Level-0-Scope ohne implizite Mutation von Level-1-/Level-2-Repositories eindeutig begrenzt? [Completeness, Spec §CR-001]
- [x] CHK002 Trennt der Vertrag Merge-Admin-Bypass, Admin-Prompt-Autorität und tatsächliche technische Privilegien eindeutig? [Clarity, Spec §FR-009/CR-012]
- [x] CHK003 Bleiben Position 3, Wartungs-TUI-Gate und Verbot eines Folgefeatures ausdrücklich außerhalb des Scopes? [Consistency, Spec §FR-015]

## Security and architecture

- [x] CHK004 Sind alle Trust Boundaries für Registry, stdin, PATH, Unterprozesse, Download, Integrität, Admin und Reportpfade benannt? [Completeness, Spec §CR-005]
- [x] CHK005 Verlangen die Swift-Anforderungen Herkunfts-, Versions-, Plattform-, Architektur- und Integritätsprüfung vor Mutation? [Completeness, Spec §FR-005/FR-006]
- [x] CHK006 Sind fail-closed Verhalten und konkrete nächste Aktionen für unbekannte Plattformen, Hashabweichung und Installationsfehler messbar? [Measurability, Spec §SC-007]
- [x] CHK007 Verhindern die Anforderungen explizit technische Umgehungen von sudo, Capability-, Paketmanager-, Test- und Sicherheitsgrenzen? [Clarity, Spec §FR-013]
- [x] CHK008 Sind die Zustände `Missing`, `Unusable`, `TimedOut` und `CapabilityBlocked` trennscharf und durch begrenzte Evidence belegbar? [Clarity, Spec §FR-010]

## Functional completeness and verification

- [x] CHK009 Ist genau ein geordneter Endstatus pro Registry-Eintrag unabhängig vom stdin-Verhalten des Kindprozesses gefordert? [Completeness, Spec §FR-001/FR-002]
- [x] CHK010 Unterscheiden Exitcode- und Abschlussanforderungen Required-Drift, ausschließlich optionalen Drift und Betriebsfehler eindeutig? [Consistency, Spec §FR-003/FR-004]
- [x] CHK011 Decken die Kriterien Positiv-, Negativ-, Vorschau-, Idempotenz-, Timeout-, Capability-, Fehler- und Signalfälle ohne echte Mutation ab? [Coverage, Spec §FR-012]
- [x] CHK012 Fordert der Abschlussvertrag genau eine atomare, run-korrelierte Finalisierung mit letzter Stufe, Signal, Exitcode und nächster Aktion? [Measurability, Spec §FR-011/SC-015]

## Accessibility, parity and evidence

- [x] CHK013 Sind text-first, DE-first/EN-second, nicht farbabhängige und secret-freie Ausgaben samt CEFR-B2-Pfad ausdrücklich gefordert? [Completeness, Spec §FR-014/CR-007]
- [x] CHK014 Ist klar, wann Bash-/PowerShell-Parität und wann eine Änderung der Agenten-Guidance erforderlich oder `N/A` ist? [Clarity, Spec §FR-016/CR-008/CR-009]
- [x] CHK015 Sind Documentation Impact, Statistik, autonome Gate-Evidence und Exact-Head-Prüfung als Abschlussanforderungen eingeplant? [Completeness, Spec §CR-010/CR-011]

## Review result

15 von 15 Qualitätsfragen sind erfüllt. Es bestehen keine offenen
Begriffs-, Scope-, Sicherheits-, Paritäts- oder Evidence-Fragen, die Tasks
oder Implementierung blockieren.
