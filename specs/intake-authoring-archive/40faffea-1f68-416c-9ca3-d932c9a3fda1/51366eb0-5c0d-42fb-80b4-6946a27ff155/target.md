<!-- intake-authoring:begin -->
# Lastenheft: Preset-Profil-, Default-Branch- und Worktree-Härtung

**Status:** ReadyForReview  
**Zielgruppe / Audience:** Maintainer der `home-baseline`-Wartung und spätere Spec-Kit-Ausführende / maintainers of `home-baseline` maintenance and later Spec Kit operators  
**Profil / Profile:** `home-baseline-lastenheft`  
**Repository:** `home-baseline`  
**Dokumenttyp / Document type:** Spec-Kit-Intake für eine allgemeine Wartungshärtung / Spec Kit intake for general maintenance hardening  
**Version:** 1.1
**Stand / Date:** 2026-07-23  
**Delivery Authority:** `LocalImplementation`

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt eine begrenzte, repository-neutrale Härtung der
Preset-Profilprüfung in der Ein-Kommando-Wartung. Der bereits gelieferte Fix
aus PR #94 prüft Presets eines abweichenden oder älteren Arbeitszweigs
isoliert auf dem kanonischen Default-Branch. Dieser Intake schließt die noch
offenen Grenzen bei Remote-Aktualität, beliebigen Default-Branch-Namen,
Hard-Abort-Bereinigung, PowerShell-Verhaltenstests und Registry-Konsistenz.

*This intake defines bounded, repository-neutral hardening for preset-profile
validation in one-command maintenance. The fix delivered through PR #94
already validates presets from a different or older working branch against the
canonical default branch in an isolated worktree. This intake closes the
remaining boundaries around remote freshness, arbitrary default-branch names,
hard-abort cleanup, PowerShell behavior tests, and registry consistency.*

Das Dokument startet weder einen Spec-Kit-Lauf noch eine Implementierung. Es
erteilt keine Autorität für Commit, Push, Pull Request, Merge, Admin-Bypass,
Provider-Administration oder Änderungen in fachlichen Ziel-Repositories.

*This document starts neither a Spec Kit run nor implementation. It grants no
authority to commit, push, open or merge pull requests, bypass rules,
administer providers, or change functional target repositories.*

## 2. Bindende Vorgänger und Reihenfolge / Binding Predecessors and Order

Fachlicher Vorgänger ist
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md`. Der vorhandene
Stand aus Home-Baseline-PR #94 ist die technische Ausgangslage. Dieses
Lastenheft ersetzt weder den breiten Wartungsintake noch die getrennten
Windows- und Linux-/Ubuntu-Härtungen.

*The functional predecessor is
`Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.md`. Home Baseline
PR #94 provides the technical starting point. This intake replaces neither the
broad maintenance intake nor the separate Windows and Linux/Ubuntu hardening
rounds.*

Die aktive Abarbeitungsreihenfolge führt diesen Intake auf Position 4 nach der
plattformübergreifenden Wartung sowie den Windows- und Linux-/Ubuntu-
Härtungen. Die Wartungs-TUI folgt auf Position 5 und bleibt gesperrt, bis die
Positionen 1 bis 4 vollständig implementiert, validiert und gemäß ihrer
jeweiligen Delivery Authority abgeschlossen sind.

*The active processing order places this intake at position 4 after
cross-platform, Windows, and Linux/Ubuntu maintenance hardening. The
maintenance TUI moves to position 5 and remains blocked until items 1 through
4 are fully implemented, validated, and closed under their respective delivery
authority.*

## 3. Ausgangslage / Current State

### 3.1 Remote-Aktualität

Die Repository-Wartung beendet die Prüfung eines schmutzigen Arbeitsbaums
derzeit vor dem sicheren `fetch --prune`. Eine spätere isolierte
Preset-Prüfung kann dadurch einen lokal vorhandenen, aber veralteten
`origin/HEAD`-Stand verwenden. Der Gesamtlauf meldet zwar einen Befund, die
einzelne Preset-Ausgabe kann trotzdem fälschlich aktuell wirken.

*Repository maintenance currently stops a dirty-worktree check before a safe
`fetch --prune`. A later isolated preset check can therefore use a locally
available but stale `origin/HEAD`. Although the complete run reports a
finding, the individual preset result can still appear current.*

### 3.2 Beliebige Default-Branch-Namen

Wenn `refs/remotes/origin/HEAD` fehlt, kennt der aktuelle lokale Fallback nur
`origin/main` und `origin/master`. Ein Repository mit einem gültigen
Default-Branch wie `trunk` kann dadurch nicht eindeutig geprüft werden, obwohl
der Remote-HEAD read-only ermittelt werden könnte.

*When `refs/remotes/origin/HEAD` is missing, the current local fallback only
knows `origin/main` and `origin/master`. A repository with a valid default
branch such as `trunk` cannot be validated unambiguously even though its remote
HEAD could be resolved read-only.*

### 3.3 Verwaiste temporäre Worktrees

Normale Exit-, Interrupt- und Terminate-Pfade bereinigen den temporären
Preset-Prüf-Worktree. Ein harter Prozessabbruch kann jedoch Worktree-
Registrierung und temporären Pfad zurücklassen. Der nächste Wartungslauf
besitzt noch keinen sicheren Eigentums- und Altersnachweis für eine gezielte
Bereinigung.

*Normal exit, interrupt, and termination paths clean up the temporary preset
validation worktree. A hard process abort can still leave the worktree
registration and temporary path behind. The next maintenance run currently
lacks safe ownership and age evidence for targeted cleanup.*

### 3.4 PowerShell-Verhaltensnachweis

Die Bash-Implementierung besitzt ausführbare Worktree-Fixtures für
Default-Branch, unveränderte lokale Dateien und Fehlerfälle. Die
PowerShell-Variante wird durch Parser, PSScriptAnalyzer und Plattform-CI
geprüft, aber nicht durch semantisch identische Worktree-Verhaltensfixtures.

*The Bash implementation has executable worktree fixtures for default-branch
handling, unchanged local files, and failure cases. The PowerShell variant is
checked by the parser, PSScriptAnalyzer, and platform CI, but not by
semantically identical worktree behavior fixtures.*

### 3.5 Registry-Konsistenz

Die Registrierung erkennt bekannte Nicht-MSL-Sprachen wie `cc65`, C und C++.
Ein bereits kuratierter, widersprüchlicher Eintrag kann jedoch erhalten
bleiben. Automatisches Überschreiben wäre riskant, aber der Widerspruch muss
als eigener Governance-Befund sichtbar werden.

*Registration recognizes known non-MSL languages such as `cc65`, C, and C++.
An existing curated but contradictory entry can nevertheless remain.
Automatic overwrite would be risky, but the contradiction must become visible
as a separate governance finding.*

## 4. Zielzustand / Target State

Jede Preset-Profilprüfung verwendet einen im aktuellen Wartungslauf
nachweislich aktualisierten kanonischen Remote-Stand oder endet mit einem
eindeutigen, nicht erfolgreichen Befund. Ein schmutziger Arbeitsbaum verhindert
weiterhin Pull, Merge oder Dateiänderungen, aber nicht das sichere Aktualisieren
der Remote-Tracking-Informationen.

*Every preset-profile check uses a canonical remote state proven fresh in the
current maintenance run or ends with an explicit non-success finding. A dirty
worktree still prevents pull, merge, or file changes, but it does not prevent a
safe refresh of remote-tracking information.*

Default-Branches werden unabhängig von ihrem Namen read-only aufgelöst.
Temporäre Prüf-Worktrees besitzen einen engen Eigentumsnachweis und können nach
einem Hard Abort beim nächsten Lauf sicher bereinigt werden. Bash und
PowerShell liefern für dieselben Fixtures dieselben Statusklassen und
Sicherheitsgrenzen. Registry-Widersprüche werden gemeldet, nicht still
korrigiert.

Vor Home-Sync, Preset-Reparatur, Propagation, Paketmanager-, Toolchain- oder
anderen mutierenden Wartungsphasen MUSS ein flottenweiter
Remote-Freshness-Preflight abgeschlossen sein. Er inventarisiert Level 0 und
alle registrierten Level-1-/Level-2-Repositories, aktualisiert jedes
erreichbare `origin` sicher und sammelt Befunde weiter, auch wenn ein früheres
Repository nicht synchronisiert werden kann. Nur eindeutig sichere
Fast-forward-Fälle dürfen gepullt werden. Jeder andere Pflichtbefund sperrt
alle nachfolgenden mutierenden Phasen.

*Default branches are resolved read-only regardless of their name. Temporary
validation worktrees carry bounded ownership evidence and can be cleaned up
safely by the next run after a hard abort. Bash and PowerShell produce the same
status classes and safety boundaries for identical fixtures. Registry
contradictions are reported rather than silently corrected. Before Home Sync,
preset repair, propagation, package-manager, toolchain, or other mutating
maintenance phases, a fleet-wide remote-freshness preflight must finish. It
continues read-only inventory after individual findings, pulls only proven
fast-forward cases, and blocks downstream mutations when a required repository
cannot be proven synchronized.*

## 5. Scope und Nicht-Ziele / Scope and Non-Goals

### In Scope

- sichere Remote-Aktualisierung vor der Preset-Profilentscheidung;
- flottenweiter Remote-Freshness-Preflight vor mutierenden Wartungsphasen;
- sichere, explizite Fast-forward-Pull-Klassifikation;
- vollständige Bestandsaufnahme trotz einzelner Repository-Befunde;
- fail-closed Sperre für Home-Sync, Reparatur, Propagation und Toolchain;
- read-only Auflösung beliebiger `origin`-Default-Branches;
- fail-closed Behandlung von fehlendem, nicht erreichbarem oder mehrdeutigem
  Remote-HEAD;
- eindeutige Lease-Metadaten für temporäre Preset-Prüf-Worktrees;
- sichere Wiederanlaufbereinigung nach einem harten Prozessabbruch;
- identische Bash-/PowerShell-Fixtures auf macOS, Linux und Windows;
- Registry-Konsistenzprüfung für bekannte MSL- und Nicht-MSL-Sprachen;
- textorientierte, farbunabhängige Status- und Evidence-Ausgabe;
- betroffene Manpages, Help, Skriptinventur und Projektstatistik.

*In scope are a fleet-wide remote-freshness preflight, safe fast-forward
classification, complete inventory despite individual findings, a fail-closed
downstream mutation barrier, arbitrary read-only default-branch resolution,
owned temporary-worktree leases, safe hard-abort recovery, cross-platform
Bash/PowerShell behavior fixtures, MSL-registry consistency checks, accessible
text evidence, and affected documentation.*

### Non-Goals

- keine Neuentwicklung der gesamten Wartungsarchitektur;
- keine Paketmanager-, TUI- oder fachliche Produktänderung;
- kein Pull, Reset, Merge, Rebase oder Checkout im aktiven Zielarbeitsbaum;
- kein automatisches Überschreiben manuell kuratierter Registry-Werte;
- kein Löschen fremder Worktrees oder unbekannter temporärer Verzeichnisse;
- keine neue Default-Branch-Konvention für Ziel-Repositories;
- keine Änderung an Branch-Protection, Rulesets oder Remote-Rechten;
- keine Commit-, Push-, PR- oder Merge-Aktion in diesem Authoring.

*The work does not redesign maintenance, change package managers, the TUI, or
product code, mutate active target worktrees, overwrite curated registry
values, remove foreign worktrees, impose new branch naming, change repository
rules, or perform remote delivery during authoring.*

## 6. Atomare Anforderungen / Atomic Requirements

### PWH-001 - Aktueller Remote-Nachweis

Vor jeder Preset-Profilprüfung eines registrierten Git-Repositories MUSS der
Wartungslauf `origin` sicher aktualisieren. `fetch --prune` DARF auch bei einem
schmutzigen Arbeitsbaum ausgeführt werden, weil es weder Index noch
Arbeitsdateien verändert. Pull und andere Worktree-Mutationen bleiben in diesem
Zustand verboten.

*Before every preset-profile check of a registered Git repository, maintenance
must safely refresh `origin`. `fetch --prune` may run for a dirty worktree
because it changes neither the index nor working files. Pull and other worktree
mutations remain forbidden.*

### PWH-002 - Freshness-Provenienz

Der Preset-Nachweis MUSS Remote, aufgelösten Default-Ref, exakten Commit und
Ergebnis des aktuellen Fetch-Versuchs zuordnen. Scheitert der Fetch, DARF ein
alter Remote-Tracking-Ref nicht als aktueller erfolgreicher Nachweis gelten.

*Preset evidence must associate the remote, resolved default ref, exact commit,
and current fetch result. If fetching fails, a stale remote-tracking ref cannot
count as current successful evidence.*

### PWH-003 - Namensunabhängige Default-Branch-Auflösung

Die Auflösung verwendet zuerst ein gültiges lokales
`refs/remotes/origin/HEAD`. Fehlt es, MUSS der Remote-HEAD mit einem
read-only Git-Aufruf wie `git ls-remote --symref origin HEAD` ermittelt werden.
Der ermittelte Branch MUSS nach dem Fetch als lokaler Remote-Tracking-Ref mit
dem erwarteten Commit vorhanden sein.

*Resolution first uses a valid local `refs/remotes/origin/HEAD`. If absent, the
remote HEAD must be obtained through a read-only Git operation such as
`git ls-remote --symref origin HEAD`. After fetching, the resulting branch must
exist locally as a remote-tracking ref at the expected commit.*

### PWH-004 - Fail-closed Fallback

Ist der Remote nicht erreichbar, liefert keinen symbolischen HEAD oder ergeben
sich mehrere plausible lokale Kandidaten, MUSS die Preset-Prüfung mit einer
eindeutigen nächsten Aktion stoppen. `main`, `master`, `trunk` oder ein anderer
Name DARF nicht geraten werden.

*If the remote is unreachable, returns no symbolic HEAD, or leaves multiple
plausible local candidates, preset validation must stop with an explicit next
action. It must not guess `main`, `master`, `trunk`, or another name.*

### PWH-005 - Worktree-Lease

Vor dem Anlegen eines temporären Prüf-Worktrees MUSS ein maschinenlokaler
Lease-Nachweis mindestens Schema-Version, Lauf-ID, PID, Repository, Remote-Ref,
Commit, Worktree-Pfad und UTC-Startzeit enthalten. Pfade MÜSSEN unter dem
reservierten Home-Baseline-State-Verzeichnis liegen.

*Before creating a temporary validation worktree, a machine-local lease must
record at least schema version, run ID, PID, repository, remote ref, commit,
worktree path, and UTC start time. Paths must remain below the reserved Home
Baseline state directory.*

### PWH-006 - Sichere Hard-Abort-Bereinigung

Beim Start prüft die Wartung ausschließlich eigene Lease-Einträge. Ein
verwaister Eintrag DARF nur bereinigt werden, wenn Repository, Worktree-Pfad,
Lease-Pfad und Git-Worktree-Registrierung zusammenpassen und kein zugehöriger
Prozess mehr läuft. Unbekannte, widersprüchliche oder aktive Einträge werden
nicht gelöscht, sondern als Befund gemeldet.

*At startup, maintenance checks only its own leases. An orphan may be cleaned
only when repository, worktree path, lease path, and Git worktree registration
agree and no owning process remains. Unknown, contradictory, or active entries
are reported rather than removed.*

### PWH-007 - Normale Bereinigung und Idempotenz

Erfolg, normaler Fehler, `INT`, `TERM` und ein späterer Wiederanlauf nach Hard
Abort MÜSSEN zu einem konsistenten Endzustand ohne eigene verwaiste Worktrees
führen. Ein zweiter Bereinigungslauf MUSS ein sicherer No-op sein.

*Success, normal failure, `INT`, `TERM`, and a later restart after a hard abort
must converge on a consistent state without owned orphan worktrees. Repeating
cleanup must be a safe no-op.*

### PWH-008 - Bash-/PowerShell-Verhaltensparität

Die Unix- und Windows-Orchestratoren MÜSSEN für dieselben isolierten Git-
Fixtures semantisch gleiche Default-Ref-, Freshness-, Lease-, Cleanup-,
Fehler- und Exitcode-Ergebnisse liefern. Reine Parser- oder Linter-Prüfungen
reichen als Paritätsnachweis nicht aus.

*Unix and Windows orchestrators must produce semantically equivalent
default-ref, freshness, lease, cleanup, error, and exit-code results for the
same isolated Git fixtures. Parser or linter checks alone are insufficient.*

### PWH-009 - Registry-MSL-Konsistenz

Wenn `primaryLanguage` eindeutig als bekannte Nicht-MSL-Sprache klassifiziert
ist und `mslStatus` den Wert `msl` trägt, MUSS die Wartung einen
`RegistryMetadataConflict` oder eine gleichwertige stabile Statusklasse
melden. Dasselbe gilt umgekehrt für eindeutig bekannte MSL-Sprachen mit
`non-msl`, sofern kein dokumentierter Mixed-Tooling-Status vorliegt.

*When `primaryLanguage` is unambiguously a known non-MSL language but
`mslStatus` is `msl`, maintenance must report `RegistryMetadataConflict` or an
equivalent stable status. The inverse applies to known MSL languages marked
`non-msl` unless a documented mixed-tooling status exists.*

### PWH-010 - Keine stille Registry-Reparatur

Die Konsistenzprüfung DARF einen manuell kuratierten Eintrag nicht automatisch
ändern. Sie MUSS Pfad, widersprüchliche Felder, erkannte Sprachklasse und eine
konkrete manuelle oder separat autorisierte nächste Aktion ausgeben.

*Consistency validation must not automatically modify a manually curated
entry. It must report the path, conflicting fields, detected language class,
and a concrete manual or separately authorized next action.*

### PWH-011 - Evidence und Barrierefreiheit

Terminal-, Log- und strukturierte Evidence MÜSSEN Ziel-Repository, Ref, Commit,
Status und nächste Aktion textuell unterscheiden. Farbe darf nur ergänzend
verwendet werden. Private absolute Pfade, Secrets und unnötige
personenbezogene Daten dürfen nicht in veröffentlichbare Evidence gelangen.

*Terminal, log, and structured evidence must distinguish target repository,
ref, commit, status, and next action in text. Color may only be supplementary.
Publishable evidence must exclude private absolute paths, secrets, and
unnecessary personal data.*

### PWH-012 - Flottenweiter Remote-Freshness-Preflight

Vor jeder nachfolgenden mutierenden Wartungsphase MUSS der Lauf Level 0 und
alle registrierten Level-1-/Level-2-Repositories vollständig inventarisieren.
Für jedes erreichbare `origin` MUSS `fetch --prune` oder ein semantisch
gleichwertiger sicherer Fetch ausgeführt werden, auch bei schmutzigem
Arbeitsbaum. Ein Befund in einem Repository DARF die read-only Fetch- und
Bestandsprüfung der übrigen Flotte nicht überspringen.

*Before any downstream mutating maintenance phase, the run must fully inventory
Level 0 and every registered Level 1/Level 2 repository. It must run
`fetch --prune`, or a semantically equivalent safe fetch, for every reachable
`origin`, including dirty worktrees. A finding in one repository must not skip
the read-only fetch and inventory checks for the remaining fleet.*

### PWH-013 - Sichere Pull-Entscheidung

`pull --ff-only` DARF ausschließlich für ein sauberes Repository auf seinem
eindeutig aufgelösten kanonischen Default-Branch mit eindeutigem Upstream,
null Ahead-Commits und einem reinen Behind-Zustand ausgeführt werden. Dirty,
Ahead, Diverged, Detached HEAD, Non-Default-Branch, fehlender Upstream,
nicht erreichbarer Remote oder uneindeutiger Remote-HEAD MÜSSEN ohne Pull und
ohne andere Worktree-Mutation enden.

*`pull --ff-only` may run only for a clean repository on its unambiguously
resolved canonical default branch with an unambiguous upstream, zero ahead
commits, and a purely behind state. Dirty, Ahead, Diverged, Detached HEAD,
Non-Default-Branch, missing-upstream, unreachable-remote, or ambiguous
remote-HEAD states must end without pull or any other worktree mutation.*

### PWH-014 - Fail-closed Folgeaktionsbarriere

Home-Sync, Preset-Reparatur, Propagation, Paketmanager-, Toolchain- und andere
mutierende Wartungsphasen DÜRFEN erst beginnen, wenn der gesamte
Remote-Freshness-Preflight abgeschlossen ist und jedes Pflicht-Repository
nachweislich synchron oder sicher fast-forward aktualisiert wurde.
Fetch-Fehler, Drift oder ein nicht sicher aktualisierbarer Pflichtzustand
MÜSSEN diese Folgephasen sperren. `--check-only` sammelt alle Befunde, verändert
keine Arbeitsdateien und führt keinen Pull aus.

*Home Sync, preset repair, propagation, package-manager, toolchain, and other
mutating maintenance phases may start only after the complete
remote-freshness preflight and after every required repository is proven
synchronized or safely fast-forwarded. Fetch failures, drift, or an unsafe
required state must block these downstream phases. `--check-only` collects all
findings, changes no working files, and performs no pull.*

### PWH-015 - Deterministischer Flottenbericht

Die textorientierte Flotten-Evidence MUSS für jedes inventarisierte Repository
mindestens Level, repository-relativen Bezeichner, lokalen Branch,
kanonischen Remote-Ref, exakten Remote-Commit, Fetch-Ergebnis, Ahead-/Behind-
Zähler, Pull-Entscheidung, Sperrgrund und genaue nächste Aktion ausgeben.
Zusätzlich MUSS ein Gesamtergebnis eindeutig angeben, ob mutierende
Folgephasen freigegeben oder gesperrt sind.

*Text-first fleet evidence must report at least level, repository-relative
identifier, local branch, canonical remote ref, exact remote commit, fetch
result, ahead/behind counts, pull decision, blocking reason, and exact next
action for every inventoried repository. An aggregate result must state
unambiguously whether downstream mutating phases are permitted or blocked.*

## 7. Betroffene Flächen / Affected Surfaces

Voraussichtlich betroffen sind die Bash- und PowerShell-Varianten der
Ein-Kommando-Wartung, ihre internen Git-/Worktree-Helfer, das
Level-2-Registrierungsmodell, isolierte Testfixtures sowie die zugehörigen
Manpages und Bedienungsdokumente.

*Expected affected surfaces are the Bash and PowerShell one-command
orchestrators, their internal Git/worktree helpers, the Level-2 registration
model, isolated fixtures, and related manuals and usage documentation.*

Die konkrete Implementierung DARF gemeinsame interne Helfer extrahieren, wenn
dadurch Parität und Testbarkeit verbessert werden. Neue öffentliche Befehle
oder Registry-Felder sind nur zulässig, wenn Plan und Contract ihre
Kompatibilitäts- und Migrationsgrenzen ausdrücklich nachweisen.

*Implementation may extract shared internal helpers when this improves parity
and testability. New public commands or registry fields are allowed only when
the plan and contract explicitly prove compatibility and migration
boundaries.*

## 8. Sicherheits-, Plattform- und Governance-Grenzen

- Git-Netzwerkzugriffe bleiben read-only und verwenden die vorhandene
  authentifizierte Remote-Konfiguration.
- Remote-URLs und Zugangsdaten werden nicht in Logs oder Leases kopiert.
- Lease-Pfade werden kanonisch aufgelöst und gegen Path Traversal,
  Symlink-Ausbruch und fremde Eigentümerschaft geprüft.
- Bereinigung verwendet keine pauschalen `rm -rf`- oder
  `Remove-Item -Recurse`-Operationen außerhalb eines verifizierten eigenen
  Lease-Pfads.
- Bash bleibt mit den unterstützten macOS-/Linux-Versionen kompatibel;
  PowerShell erfordert PowerShell 7.
- Nutzerseitige Ausgabe folgt WCAG 2.2 AA, soweit auf CLI und Dokumentation
  anwendbar, und bleibt mit Screenreader, Braille-Zeile und Textterminal
  verständlich.
- C, C89, C++ und `cc65` bleiben zulässige, begründungspflichtige
  Nicht-MSL-Sprachen; der Status ist kein Ausschluss aus der GSDB.

*Git access remains read-only, credentials stay out of evidence, lease paths
are canonical and ownership-bound, cleanup never broadens beyond verified
owned state, supported Bash and PowerShell versions remain compatible,
user-facing output stays text-first and accessible, and justified non-MSL
languages remain valid GSDB targets.*

## 9. Erwartete Artefakte / Expected Artifacts

- gehärtete Bash- und PowerShell-Orchestratoren oder klar abgegrenzte interne
  Helfer;
- dokumentierter Freshness- und Default-Ref-Vertrag;
- dokumentierter flottenweiter Preflight- und Folgeaktionsbarrieren-Vertrag;
- deterministischer textorientierter Flottenbericht;
- maschinenlokales Lease-Schema mit sicherer Wiederanlaufbereinigung;
- positive und negative Git-/Worktree-Fixtures für beide Skriptvarianten;
- Registry-Konsistenzprüfung ohne automatische Reparatur;
- aktualisierte Manpage, README, Skriptreferenz und gegebenenfalls
  Konfigurationsschema;
- reproduzierbare Validation-Evidence und aktualisierte Projektstatistik.

*Expected artifacts include hardened cross-platform orchestrators or bounded
internal helpers, documented freshness/default-ref and fleet-barrier
contracts, deterministic text-first fleet evidence, a local lease schema with
safe recovery, positive and negative fixtures for both shells, non-mutating
registry consistency validation, affected documentation, and reproducible
evidence.*

## 10. Risiken und Fehlergrenzen / Risks and Failure Boundaries

- Ein Fetch-Fehler darf nicht als erfolgreiche Preset-Prüfung kaschiert werden.
- Ein früher Flottenbefund darf die read-only Prüfung späterer registrierter
  Repositories nicht unterdrücken.
- Eine unvollständige oder nicht eindeutig synchrone Flotte darf keine
  mutierende Folgephase freigeben.
- Ein wiederverwendeter PID-Wert allein reicht nicht als Eigentumsnachweis.
- Ein Lease mit ungültigem oder aus dem State-Verzeichnis ausbrechendem Pfad
  darf keine Löschaktion auslösen.
- Ein Remote-HEAD, dessen Commit nicht zum lokalen Tracking-Ref passt, ist
  Drift und kein gültiger Fallback.
- Plattformabhängige Unterschiede in Prozess- oder Symlink-Prüfung müssen in
  Fixtures sichtbar sein und fail-closed behandelt werden.
- Registry-Konflikte blockieren die betroffene Governance-Aussage, aber
  verändern nicht automatisch Sprache, MSL-Status oder GSDB-Pflicht.

*Fetch failure, incomplete fleet inventory, unsafe downstream release, PID
reuse, path escape, mismatched remote HEAD, platform differences, and
contradictory registry metadata must fail safely without mutating unrelated
state.*

## 11. Messbare Abnahmekriterien / Measurable Acceptance Criteria

- **AC-001:** Ein Fixture mit schmutzigem Arbeitsbaum und fortgeschrittenem
  Remote aktualisiert `origin` sicher, prüft den neuen exakten Default-Commit
  und behält Index-, Arbeitsdatei- und Statushash unverändert.
- **AC-002:** Ein Repository mit Default-Branch `trunk` und fehlendem lokalem
  `origin/HEAD` wird über den read-only Remote-HEAD korrekt aufgelöst.
- **AC-003:** Nicht erreichbarer Remote, fehlender symbolischer HEAD,
  mehrdeutige Kandidaten und Commit-Abweichung enden jeweils fail-closed und
  ohne erfolgreiche Preset-Aussage.
- **AC-004:** Ein normaler Check hinterlässt weder Lease noch temporären
  Worktree oder zusätzliche Git-Worktree-Registrierung.
- **AC-005:** Ein kontrolliert hart abgebrochenes Fixture hinterlässt eine
  erkennbare eigene Lease. Der nächste Lauf entfernt genau diesen verwaisten
  Worktree; ein zweiter Lauf ist ein No-op.
- **AC-006:** Aktive, fremde, manipulierte und außerhalb des reservierten
  State-Pfads liegende Leases werden nicht gelöscht und erzeugen einen
  eindeutigen Befund.
- **AC-007:** Bash und PowerShell liefern für alle positiven und negativen
  Fixtures dieselben semantischen Statusklassen und erwarteten Exitcodes.
- **AC-008:** `cc65`, C und C++ mit `mslStatus: msl` sowie bekannte
  MSL-Sprachen mit unbegründetem `non-msl` werden als Registry-Konflikt
  gemeldet; die Registry bleibt bytegleich.
- **AC-009:** Korrekte Werte wie `cc65/non-msl`, `C#/msl` und ein begründetes
  `msl-mixed-tooling` bestehen die Prüfung.
- **AC-010:** `--check-only`, `--dry-run` beziehungsweise `-WhatIf` verändern
  keine getrackten Ziel-Dateien, Registry-Werte oder fremden Worktrees.
- **AC-011:** Bash-Syntax, PowerShell-Parser, PSScriptAnalyzer,
  Fixture-Tests, Homogeneity, `git diff --check` und Secret-Scan bestehen.
- **AC-012:** Dokumentation und Evidence sind DE zuerst/EN danach,
  textorientiert, ohne farbabhängige Bedeutung und ohne veröffentlichte private
  Pfade.
- **AC-013:** Ein Mehr-Repository-Fixture beweist über eine geordnete
  Operations-Evidence, dass alle vorgesehenen Fetch-Versuche abgeschlossen
  sind, bevor Home-Sync, Toolchain-Wartung oder eine andere mutierende
  Folgephase beginnen kann.
- **AC-014:** Ein sauberes Repository auf seinem kanonischen Default-Branch mit
  null Ahead-Commits und reinem Behind-Zustand wird ausschließlich per
  `pull --ff-only` aktualisiert und endet mit Ahead/Behind `0/0`.
- **AC-015:** Dirty, Ahead, Diverged, Non-Default-Branch, Detached HEAD,
  fehlender Upstream, nicht erreichbarer Remote und uneindeutiger Remote-HEAD
  blockieren mutierende Folgephasen, ohne Index oder Arbeitsdateien zu ändern.
- **AC-016:** Ein Fehler im ersten Repository verhindert weder Fetch-Versuche
  noch textorientierte Statuszeilen für alle späteren registrierten
  Repositories; das Gesamtergebnis bleibt fail-closed.
- **AC-017:** Bash und PowerShell liefern für den flottenweiten Preflight, alle
  Pull-Klassifikationen, die Folgeaktionsbarriere und den Bericht dieselben
  semantischen Statusklassen und Exitcodes.

*Acceptance covers fresh dirty-worktree validation, a complete fleet preflight
before downstream mutations, safe fast-forward classification, continued
inventory after individual errors, arbitrary default branch names, fail-closed
remote ambiguity, normal and hard-abort cleanup, foreign lease protection,
Bash/PowerShell parity, non-mutating MSL consistency checks, safe preview
modes, complete validation, and accessible evidence.*

## 12. Annahmen und offene Fragen / Assumptions and Open Questions

Annahmen:

- `origin` bleibt der kanonische Remote-Name der verwalteten Flotte.
- Ein sicherer Fetch ist auch bei schmutzigem Arbeitsbaum zulässig; mutierende
  Worktree-Aktionen bleiben verboten.
- Lease-Daten sind maschinenlokale Betriebsdaten und werden nicht committed.
- Die bestehende Zehn-Preset-Matrix und ihre Prioritäten ändern sich nicht.
- `LocalImplementation` erlaubt nur lokale Implementierung und Validierung im
  aktuellen Repository.

*Assumptions are that `origin` remains canonical, safe fetch is allowed for
dirty worktrees, leases remain machine-local, the ten-preset matrix stays
unchanged, and LocalImplementation grants local work only.*

Offene materielle Fragen: keine.

*Open material questions: none.*

## 13. Abschlussgrenze / Completion Boundary

Die Härtung ist abgeschlossen, wenn alle Abnahmekriterien auf den unterstützten
Plattformen reproduzierbar bestanden sind, kein eigener temporärer Worktree
zurückbleibt und Registry-Widersprüche ohne stille Mutation sichtbar werden.
Mit `LocalImplementation` endet der spätere Lauf vor Commit, Push, Pull Request
oder Merge.

*Hardening is complete when all acceptance criteria pass reproducibly on
supported platforms, no owned temporary worktree remains, and registry
contradictions are visible without silent mutation. Under LocalImplementation,
the later run stops before commit, push, pull request, or merge.*

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md Erstelle die Spezifikation ausschließlich aus diesem Intake und seinem bindenden Vorgänger. Bewahre PWH-001 bis PWH-015, AC-001 bis AC-017, die flottenweite Remote-Freshness-Barriere vor allen mutierenden Folgephasen, die sichere Fast-forward-Klassifikation, die vollständige Bestandsaufnahme trotz Einzelbefunden, die Position-4-Reihenfolge, die TUI-Sperre sowie alle Git-, Hard-Abort-, Registry-, Nicht-MSL-, Plattform-, Sicherheits- und A11Y-Grenzen. Implementiere nichts, verändere keine Remote-Zustände und starte keinen Autonomous- oder Parallel-Autonomous-Lauf.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md Führe den vollständigen Spec-Kit-Lauf gebunden an diesen Intake mit deliveryAuthority=LocalImplementation aus. Implementiere und validiere PWH-001 bis PWH-015 sowie AC-001 bis AC-017 lokal bis zur definierten Abschlussgrenze. Beweise, dass der flottenweite Remote-Freshness-Preflight vor jeder mutierenden Folgephase abgeschlossen wird, nur sichere Fast-forward-Fälle gepullt werden und Einzelbefunde die restliche read-only Bestandsaufnahme nicht abbrechen. Bewahre aktive Arbeitsbäume und fremde Worktrees, repariere Registry-Widersprüche nicht still und stoppe bei fehlender Vorgänger-Evidence oder einem harten Sicherheitsstopp. Erstelle keine Commits, Pushes, Pull Requests oder Merges und verändere keine Remote-Zustände. Starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
