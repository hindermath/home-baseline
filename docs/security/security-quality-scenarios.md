# Sicherheits-Qualitätsszenarien / Security Quality Scenarios

**Stand / State**: 2026-08-01

| ID | Auslöser | Erwartete Reaktion und Nachweis |
|---|---|---|
| SQ-018-01 | Update gewählt, Bestätigung leer oder Nein | Kein Engine-Start, Exit `130`, keine Wartungsmutation |
| SQ-018-02 | Pfad enthält Leerzeichen, Semikolon oder Markup | Ein Argument bleibt ein Argument; sichtbarer Text ist maskiert |
| SQ-018-03 | JSONL-Zeile ist ungültig oder Sequenz springt | Anzeige degradiert dauerhaft, Engine läuft höchstens einmal weiter |
| SQ-018-04 | Bericht, Event und Exitcode widersprechen sich | `RESULT_MISMATCH`, Prozess-Exit bleibt unverändert |
| SQ-018-05 | Cache stammt von anderer Plattform oder Quelle | Cache wird abgelehnt; sicherer Build oder Plain-Fallback |
| SQ-018-06 | .NET 10 oder Restore fehlt | Plain-Assistent vor Engine-Start, keine zweite Ausführung |
| SQ-018-07 | `NO_COLOR`, `TERM=dumb` oder Breite 39 | vollständiger linearer Text mit Status und nächster Aktion |
| SQ-018-08 | Optionales Paket benötigt Adminprompt | bestehendes `DEFERRED_ADMIN_REQUIRED`, kein UI-Bypass |
| SQ-019-01 | Abschlussereignis fehlt, Bericht und Exitcode stimmen | Bericht bleibt kanonisch; Event-Degradierung bleibt separat sichtbar |
| SQ-019-02 | Abschlussereignis nennt fremden Berichtspfad | vorgebundener Run-Pfad bleibt maßgeblich; `RESULT_MISMATCH` |
| SQ-019-03 | Argumentloser Aufruf unter Bash 3.2 | genau eine sichere Delegation ohne leere Array-Expansion |

Jedes Szenario besitzt mindestens einen lokalen Test. Plattformabhängige
Pfade erhalten zusätzlich macOS-, Ubuntu- und Windows-Evidence.

*Every scenario has at least one local test. Platform-dependent paths also
receive macOS, Ubuntu, and Windows evidence.*

## Feature 029: CI-Budget-Governance

| ID | Auslöser | Erwartete Reaktion und Nachweis |
|---|---|---|
| SQ-029-01 | Assignment fehlt/doppelt oder Sichtbarkeit weicht ab | Block vor Inventory, Kosten und Rollout; `FleetClassificationTests` |
| SQ-029-02 | Pfad trifft Dokumentation und Security | Vereinigungssemantik behält Security-Gate; `WorkflowPathBudgetTests` |
| SQ-029-03 | HEAD oder Gate-Set ändert sich während Lauf | keine Erfolgsevidence; `VerticalSliceTests` |
| SQ-029-04 | Hook fehlt oder wird umgangen | unabhängige PR-Pflicht und exakt ein Serverstatus bleiben; `HookEvidenceRulesetTests` |
| SQ-029-05 | POST/PUT/PATCH/DELETE, Commit, Push, Merge, Home-Sync oder G4 | sofortiger Stage-A-Hard-Stop; `RolloutDeterminismMutationTests` |
| SQ-029-06 | Dauer/Run/Copilot-Wert fehlt | nicht als Null rechnen, Budgetentscheidung blockiert |
| SQ-029-07 | Bash/PowerShell Preview | gleiche lineare Felder/Hash/Exitcode, keine Evidence; macOS-Manualrecords |

Reviewer: Security Architecture Reviewer. Restrisiko: native Linux-/Windows-
Ausführung folgt erst bei entsprechender Plattformautorität. Re-Evaluation bei
Gate-, Plattform-, Provider-, Budget- oder Authority-Änderung.

<!-- EN: docs/security/security-quality-scenarios.md
[DE-Zusammenfassung: Prüfszenarien für Auswahl, Injection, Events, Cache und A11Y.]
-->

## Feature 030: Stage-B-Qualitätsszenarien / Stage B Quality Scenarios

| ID | Auslöser | Erwartete Reaktion und Nachweis |
|---|---|---|
| SQ-030-01 | Provider-ID, Slug, Remote-Head oder Default Branch driftet vor Write | ExternalWriteGate schließt; Exit `1/2`; keine Git-/Providermutation |
| SQ-030-02 | Kandidatenpfad, Modus oder Blob weicht vom fixierten Plan ab | Stop vor Staging/Commit; exakter Diff-Nachweis nennt Blocker und nächste sichere Aktion |
| SQ-030-03 | Push/PR/Ruleset-Write endet unklar oder mit Timeout | read-only Reconciliation über Idempotency Key; kein blinder zweiter Write |
| SQ-030-04 | Pflichtcheck oder Review gehört zu anderem PR-Head | Merge und Bypass blockieren; Runner/Befehl/Head müssen exakt gebunden sein |
| SQ-030-05 | Regulärer Merge scheitert nur an Schutzregel | Bypass nur mit frischer enger Authority und vollständigen unabhängigen Gates; sonst Stop |
| SQ-030-06 | Ruleset-Verifikation scheitert nach Write | höchstens exakt vorgeplanter Restore; danach Lauf immer stoppen |
| SQ-030-07 | Nicht behebbarer Fehler nach konvergiertem Ziel | atomarer State; kein Folgeziel; Resume erhält Erfolg und beginnt am ersten offenen Ziel |
| SQ-030-08 | Evidence enthält Token, privaten Pfad, Actor oder Rohantwort | Publikation blockiert; keine Teil- oder Restricted-Datei |
| SQ-030-09 | macOS-Preflight ist grün, Linux/Windows oder Vollsuite fehlen | nur der genaue Teilnachweis gilt; kein Plattform- oder Vollregressions-Pass wird abgeleitet |
| SQ-030-10 | Windows kann POSIX-`0600` nicht owner-only abbilden oder DACL-Setzung scheitert | temporäre Evidence erhält vor Replace eine geschützte Current-SID-DACL; Fehler bewahrt die letzte gültige Evidence |

Owner: Security Quality Owner. Reviewer: Security Architecture Reviewer.
Restrisiko: Live-Providerzustand kann nach der letzten Leseprüfung wechseln;
die unmittelbare Revalidierung minimiert, beseitigt aber kein externes
TOCTOU-Risiko. Re-Evaluation bei Gate-, Review-, Ruleset-, Bypass-, Provider-,
Plattform- oder Evidence-Vertragsänderung.
