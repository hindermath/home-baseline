<!-- intake-authoring:begin -->
# Lastenheft: Flottenweite CI-Budget-Governance und Actions-Rationalisierung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review / Ready for Intake Review
**Version:** 1.0.0
**Stand:** 2026-08-19
**Aktive Serienrolle:** G3, `Primary`, allein deklarierter `Eligible`-Kandidat
**Bindende Vorgänger:** keine innerhalb der aktiven Serie
**Bindender Nachfolger:** G4 Copilot-Review-Governance
**Delivery Authority:** `LocalImplementation`
**Zielgruppe:** Maintainer, Flotten-Operator*innen, Repository-Verantwortliche und Reviewer
**Vorausgesetztes Wissen:** grundlegende Git-, GitHub-Actions-, Bash- und PowerShell-Kenntnisse; keine Spec-Kit-Erfahrung

## Deutscher Vertrag

### 1. Zweck und Zielzustand

Dieses Lastenheft begrenzt den Verbrauch privater GitHub-Actions-Minuten, ohne
technische, Sicherheits-, Barrierefreiheits- oder Review-Gates abzuschwächen.
Die Flotte erhält nachvollziehbare CI-Profile, lokale Pflichtprüfungen,
HEAD-gebundene Evidence und einen schlanken serverseitigen Pflicht-Gate als
nicht lokal umgehbare Sicherheitsgrenze. Öffentliche CI bleibt dort erhalten,
wo sie kostenfrei und für Portabilitäts- oder Produktnachweise erforderlich
ist.

Der Planungsstand umfasst 48 Git-Repositories: die Level-0-Quelle sowie 47 im
Flottenregister deklarierte Git-Repositories; die zusätzliche Collection ist
nur ein logischer Gruppenknoten. Die bisherige Einteilung von 27 privaten und
21 öffentlichen Repositories ist vor einer Umsetzung live zu revalidieren und
nicht als zeitloser Festwert zu behandeln. Auch die Profilzahlen
`3/6/6/21/12` sind ein datierter Planungs-Snapshot vom 19. August 2026 und
keine unveränderlichen Soll-Kardinalitäten.

### 2. Begriffe

- **CI:** Automatisierte Prüfung eines Commits oder Pull Requests.
- **Lokales Gate:** Pflichtprüfung auf dem Entwicklungsrechner vor dem Push.
- **Serverseitiger Pflicht-Gate:** Schlanke, pfadabhängige und durch ein
  Repository-Ruleset verpflichtende PR-Prüfung, die relevante Sicherheits-
  und Governance-Regeln unabhängig vom lokalen Hook validiert.
- **Evidence:** Maschinenlesbarer Nachweis, welche Prüfungen für welchen HEAD
  und welche Gate-Konfiguration erfolgreich waren.
- **Profilzuordnung:** Versionierter Level-0-Vertrag, der einer stabilen
  Registry-ID genau ein CI-Profil zuweist.
- **Canary:** Öffentliches Referenzrepository, das den gemeinsamen
  plattformübergreifenden CI-Vertrag früh sichtbar prüft.
- **Pfadabhängig:** Ein Job startet nur, wenn für ihn relevante Dateien
  verändert wurden.

### 3. Verbindliche Anforderungen

- **CBG-001 – Live-Inventur:** Die Umsetzung ermittelt Repository, Sichtbarkeit,
  Default-Branch, Workflow-Auslöser, Runner, durchschnittliche Dauer und
  geplante Läufe erneut aus Register und GitHub-Livezustand.
- **CBG-002 – Profilvertrag und Drift:** Eine versionierte Level-0-Zuordnung
  bindet jede stabile Registry-ID genau an eines der fünf Profile Public
  Canary, Public Product, Private Product, Private Governance/Scaffold oder
  Public Preset. Public Canary, Public Product und Public Preset verlangen
  öffentliche Sichtbarkeit; Private Product und Private Governance/Scaffold
  verlangen private Sichtbarkeit. Die Live-Inventur berechnet die
  Kardinalitäten daraus neu. Neue oder fehlende IDs, Mehrfachzuordnungen sowie
  eine mit dem Profil unvereinbare Sichtbarkeit stoppen fail-closed und
  verlangen ein geprüftes Mapping-Update; sie werden nicht automatisch geraten
  oder umklassifiziert.
- **CBG-003 – Private Governance:** Private Governance-/Scaffold-Repositories
  führen keine automatischen vollständigen PR- oder Main-Builds aus. Ihre
  vollständigen Pflichtprüfungen laufen lokal und fail-closed vor dem Push.
  Zusätzlich erzwingt ein Ruleset genau einen schlanken, pfadabhängigen
  serverseitigen PR-Gate, der betroffene Sicherheits-, Governance-, Workflow-
  und Abhängigkeitsflächen unabhängig prüft.
- **CBG-004 – Private Products:** Private Produkt-Repositories führen
  pfadabhängige PR-Prüfungen aus. Derselbe Build wird nach dem Merge nicht ohne
  zusätzlichen fachlichen Zweck erneut auf `main` ausgeführt.
- **CBG-005 – CaseTracker:** Eine Änderung an allen sechs
  SecureCaseTracker-Sprachrepositories erzeugt höchstens sechs passende
  Produktjobs.
- **CBG-006 – Swift:** Swift-PRs verwenden Linux für die verpflichtende
  PR-Prüfung. Ein macOS-Lauf erfolgt wöchentlich oder manuell als gesonderter
  Plattformnachweis.
- **CBG-007 – Release Please:** In privaten Repositories läuft Release Please
  nur wöchentlich und über eine manuelle Auslösung.
- **CBG-008 – Öffentliche CI:** Notwendige Standard-Runner-CI in öffentlichen
  Repositories bleibt erhalten. `home-baseline`, `AgentOperationsCockpit` und
  `TuiVision` bilden die drei Canaries.
- **CBG-009 – Public Presets:** Die zwölf öffentlichen Preset-Repositories
  erhalten in diesem Kostensenkungsprojekt keine eigenen neuen
  Actions-Workflows. Veröffentlichung und Validierung bleiben über die
  kanonische Flottenpipeline beziehungsweise lokale Evidence nachweisbar.
- **CBG-010 – Ein-Kommando-Gate:** Das Wartungsskript erhält funktional
  gleichwertig `--ci-gate` in Bash und `-CiGate` in PowerShell.
- **CBG-011 – Evidence-Pfad:** Erfolgreiche lokale Gates erzeugen
  `~/.home-baseline/evidence/ci-gates/<repo-id>/<head-commit>.json`.
- **CBG-012 – Evidence-Inhalt:** Jeder Nachweis enthält mindestens
  Schema-Version, Repository-ID, HEAD-Commit, CI-Profil, Gate-Set-Hash,
  Plattform, Zeitstempel und Einzelergebnisse.
- **CBG-013 – Evidence-Gültigkeit:** Ein anderer HEAD, eine andere
  Gate-Konfiguration, ein fehlgeschlagenes Gate oder fehlende Evidence macht
  den Nachweis ungültig.
- **CBG-014 – Pre-push:** Der gemeinsame Pre-push-Hook verlangt in privaten
  Flottenrepositories passende erfolgreiche Evidence, bevor er einen Push
  zulässt. Wartung und Tests prüfen Installation sowie Versionsfrische des
  Hooks. Der Hook ist ein lokales Qualitäts-Gate, aber nicht die alleinige
  Sicherheitsgrenze; `--no-verify`, fehlende Hooks und alternative Clones
  umgehen den verpflichtenden serverseitigen Gate nicht.
- **CBG-015 – Prozessgrenze:** Pfadfilter sind ein bewusster Prozessvertrag.
  Änderungen an Build-, Sicherheits-, Governance- oder Abhängigkeitsflächen
  müssen die zugehörigen Produktjobs auslösen.
- **CBG-016 – Copilot-Abgrenzung:** GitHub-Copilot-Code-Review-Runnerzeiten
  werden als eigene Verbrauchskategorie erfasst. Die Reviewer-Konfiguration
  gehört ausschließlich zum nachfolgenden G4-Intake.
- **CBG-017 – Plattformparität:** Bash und PowerShell liefern dieselben
  Profile, Entscheidungen, Evidence-Felder, Exitcodes und A11Y-tauglichen
  Textausgaben.
- **CBG-018 – Sicherheitsgrenze:** Gates, Secret-Scanning, Branch-Schutz,
  Mutation Barriers und menschliche Reviewpflichten dürfen nicht zur
  Kostensenkung umgangen werden. Für private Governance-/Scaffold-Repositories
  verlangt das serverseitige Ruleset einen Pull Request und den erfolgreichen
  Minimal-Gate vor jeder Änderung am Default-Branch; direkte Pushes sowie
  umgehende Web- oder API-Schreibpfade sind gesperrt. Ein Admin-Bypass ist
  weder Voraussetzung noch normaler Lieferpfad dieses Intakes.
- **CBG-019 – Keine Eigenmutation:** Das Wartungsskript startet genau einen
  Engine-Prozess und committet oder pusht kein Zielrepository.
- **CBG-020 – Dokumentation:** Documentation Impact ist `UpdateRequired`.
  Bedienung, Profile, Evidence, Fehlerfälle, Home-Runtime-Verteilung und
  Re-Evaluation werden bilingual dokumentiert.
- **CBG-021 – Lieferstufen:** Stufe A unter `LocalImplementation` ändert nur
  das Level-0-Repository und erzeugt dort die kanonischen Profile, Skripte,
  Hooks, Workflow-Vorlagen, Tests sowie vollständige Dry-Run-, Mapping- und
  Rollout-Evidence. Die tatsächliche Änderung und Konvergenz der 47
  Ziel-Repositories ist Stufe B und benötigt einen separaten, ausdrücklich
  autorisierten Flotten-Rollout.

### 4. Ergebnisartefakte

- versionierter CI-Profil- und Kostenvertrag;
- Bash-/PowerShell-Oberfläche für das lokale CI-Gate;
- versioniertes Evidence-Schema und deterministische Evidence-Erzeugung;
- Pre-push-Prüfung gegen HEAD und Gate-Set-Hash;
- kanonische private Workflow-Vorlagen, Ruleset-Anforderungen und Zeitpläne;
- deterministische geplante Diffs und ein Evidence-Vertrag für den späteren
  Flotten-Rollout, ohne Ziel-Repositories in Stufe A zu verändern;
- Testmatrix für Profile, Pfade, Plattformen und Fehlerfälle;
- Betriebs- und A11Y-Dokumentation mit Verbrauchsmessung.

### 5. Qualitäts-, Sicherheits- und A11Y-Grenzen

Ausgaben bleiben linear, textorientiert und ohne Farbe verständlich. Sie nennen
Profil, Entscheidung, Status, Blocker und nächste Aktion in stabiler Reihenfolge.
Dateipfade und Git-Daten werden als nicht vertrauenswürdige Eingaben behandelt.
Shell-Aufrufe verwenden sichere Quotierung und kein `eval`; PowerShell bleibt
unter Strict Mode. Evidence enthält keine Tokens, Secrets, privaten
Abrechnungsdetails oder unnötigen personenbezogenen Daten. WCAG 2.2 AA und
CEFR B2 gelten, soweit auf CLI und Dokumentation anwendbar.

### 6. Nicht-Ziele und Hard Stops

- keine Self-hosted-Runner-Architektur;
- keine Abschaltung öffentlicher notwendiger Produkt- oder Canary-CI;
- keine Schwächung von Security-, A11Y-, Validator- oder Review-Gates;
- keine Copilot-Ruleset- oder Accountänderung in diesem Intake;
- keine Änderung des GitHub-Abonnements oder zusätzlicher Budgets;
- keine Änderung oder Remote-Konvergenz der 47 Ziel-Repositories in Stufe A;
- kein automatisches Committen, Pushen, Mergen oder Starten von G4;
- kein Intake Review, Specify oder Autonomous durch die Erstellung dieses
  Lastenhefts.

### 7. Risiken und Gegenmaßnahmen

- Zu enge Pfadfilter können notwendige Tests auslassen; deshalb werden
  sicherheits- und buildrelevante Pfade als verbindliche Auslöser getestet.
- Veraltete lokale Evidence kann einen falschen Pass vortäuschen; deshalb ist
  sie an HEAD und Gate-Set-Hash gebunden.
- Fehlende oder umgangene lokale Hooks dürfen keine serverseitige
  Sicherheitslücke erzeugen; deshalb bleiben Pull Request und Minimal-Gate im
  Ruleset verpflichtend.
- Ein zu breiter Minimal-Gate kann das Budgetziel gefährden; deshalb ist er
  pfadabhängig, wird gegen sicherheitsrelevante Negativfälle getestet und
  getrennt von vollständigen Builds gemessen.
- Plattformfehler können bei Linux-only-PRs später sichtbar werden; deshalb
  bleibt der geplante macOS-Nachweis erhalten.
- Flottendrift kann Profilzahlen verändern; deshalb ist die Live-Inventur ein
  Pflicht-Preflight. Unbekannte, fehlende, doppelte oder sichtbarkeitswidrige
  Zuordnungen stoppen die Planung und lösen ein geprüftes Mapping-Update aus.

### 8. Messbare Abnahme

- **AC-CBG-001:** Jedes live ermittelte Git-Repository ist über seine stabile
  Registry-ID genau einem gültigen Profil zugeordnet; Collection-Knoten werden
  nicht als Repository gezählt. Jede ungeklärte Drift führt zu einem
  reproduzierbaren Hard Stop statt zu einer stillen Umklassifizierung.
- **AC-CBG-002:** Eine Stufe-A-Simulation mit Workflow- und Ruleset-Fixtures
  weist nach, dass eine typische private Governance-Lieferung keinen
  vollständigen privaten PR-/Main-Build, aber höchstens einen schlanken
  verpflichtenden PR-Gate starten würde. Lokale Evidence und der unabhängige
  serverseitige Gate sind gemeinsam als spätere Liefergrenze nachgewiesen.
- **AC-CBG-003:** Eine Stufe-A-Simulation einer Änderung an allen sechs
  CaseTracker-Produkten plant höchstens sechs pfadgerechte PR-Jobs.
- **AC-CBG-004:** Das Stufe-A-Kostenmodell weist eine geplante wiederkehrende
  private Grundlast von ungefähr 22 Jobs pro Woche aus. Bedarfsabhängige
  Minimal-Gates werden separat ausgewiesen; Abweichungen werden erklärt.
- **AC-CBG-005:** Das Stufe-A-Kostenmodell liegt unter 500 von 3.000 geplanten
  privaten Actions-Minuten im Monat, ohne Copilot-AI-Credits damit zu
  vermischen.
- **AC-CBG-006:** Null-, Einzel- und Mehrfachrepository-Läufe erzeugen
  deterministische Ergebnisse und passende Exitcodes.
- **AC-CBG-007:** Lokale Hook-Tests blockieren bei fehlender, veralteter oder
  fehlgeschlagener Evidence und lassen passende Evidence zu. Ruleset- und
  Workflow-Fixtures weisen zusätzlich nach, dass fehlende oder umgangene lokale
  Hooks keinen ungeprüften Default-Branch-Schreibpfad erlauben würden.
- **AC-CBG-008:** Bash-/PowerShell-Parität, bestehende Wartungsregressionen,
  A11Y-, Secret-Scan- und Workflowtests sind grün.
- **AC-CBG-009:** Copilot-Konfiguration blieb unverändert und G4 wurde nicht
  gestartet.
- **AC-CBG-010:** Stufe A verändert ausschließlich versionierte Level-0-
  Artefakte und weist für alle live ermittelten Ziel-Repositories Profil,
  geplanten Diff, Gate-Entscheidung und Rollout-Blocker deterministisch nach.
  Keine Abnahme behauptet eine remote ausgerollte Flottenkonvergenz.

### 9. Reihenfolge und Abschlussgrenze

G3 besitzt keinen bindenden Vorgänger. Nach erfolgreichem Intake Review,
Specify und einem ausdrücklich autorisierten Implementierungslauf liefert G3
in Stufe A die lokale `ActionsBudgetBaseline` für G4. Der getrennte
Flotten-Rollout der Stufe B benötigt neue ausdrückliche Autorität und ist keine
Voraussetzung für den lokalen G3-Abschluss. Die bloße Einstufung als `Eligible`
erteilt keine Start-, Commit-, Push-, Merge- oder Bypass-Autorität.

## English Contract

### 10. Purpose and target state

This intake limits private GitHub Actions consumption without weakening
technical, security, accessibility, or review gates. The fleet receives
explicit CI profiles, mandatory local gates, HEAD-bound evidence, and one lean
required server-side gate as the non-local security boundary. Public CI remains
where it is cost-free and required for portability or product proof. The
planning snapshot contains 48 Git repositories; implementation must recompute
visibility, membership, and profile cardinalities from live evidence. The
current `3/6/6/21/12` profile split is dated evidence, not a timeless target.

### 11. Binding requirements

- **CBG-001–002:** Re-inventory all repositories and bind every stable registry
  ID to exactly one versioned CI profile. Unknown, missing, duplicate, or
  visibility-incompatible mappings stop fail-closed and require review.
- **CBG-003–004:** Private governance repositories use fail-closed local gates,
  no automatic full PR/main builds, and exactly one lean ruleset-required PR
  gate; private products use path-gated PR CI and no duplicate main build
  without a separate purpose.
- **CBG-005–007:** Six CaseTracker changes start at most six jobs; Swift PRs use
  Linux with weekly/manual macOS evidence; private Release Please is weekly and
  manual only.
- **CBG-008–009:** Preserve required public CI and the three canaries; do not
  add per-repository Actions workflows to the twelve public presets in this
  cost project.
- **CBG-010–014:** Add `--ci-gate`/`-CiGate`, emit versioned evidence under the
  declared local path, bind it to repository HEAD and gate-set hash, and require
  matching evidence in the shared private-fleet pre-push hook. Validate hook
  installation and freshness without treating the hook as the sole security
  boundary.
- **CBG-015–017:** Treat path filters as a tested process contract, account for
  Copilot review runner usage separately, and preserve Bash/PowerShell parity.
- **CBG-018–020:** Require PR and successful minimal status through server-side
  rulesets, preserve all security and review barriers, keep the maintenance
  engine non-committing and non-pushing, and update bilingual operational
  documentation.
- **CBG-021:** Stage A under `LocalImplementation` changes only Level 0 and
  produces canonical artifacts plus deterministic mapping, dry-run, and
  rollout evidence. Mutating or converging the 47 target repositories is a
  separately authorized Stage B fleet rollout.

### 12. Acceptance and boundaries

Stage A proves exact live profile coverage, hard-stop drift behavior, no
automatic full private-governance PR/main build, at most one lean required PR
gate per governance delivery, no more than six CaseTracker PR jobs for a
six-product change, about 22 recurring private jobs per week, and a target
below 500 of 3,000 private Actions minutes per month including separately
reported demand-driven minimal gates. Missing or stale evidence blocks the
normal private push; required PR and status rules protect alternate write
paths. Existing cross-platform, maintenance, security, accessibility, and
workflow regression tests remain green. Self-hosted runners, Copilot settings,
subscription changes, Stage B remote delivery, and an automatic G4 start are
out of scope.

<!-- intake-authoring:prompts -->
## Kopierbare Spec-Kit-Prompts / Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md` as the binding G3 intake. Specify the versioned registry-ID-to-profile contract, fail-closed drift handling, private local gates, the independent ruleset-required minimal PR gate, HEAD- and gate-set-bound evidence, Bash `--ci-gate`, PowerShell `-CiGate`, private pre-push enforcement, path-gated product CI, scheduled macOS and Release Please runs, public canaries, separate Copilot runner accounting, the Stage A Level-0 boundary, the separate Stage B rollout handoff, security and A11Y invariants, and the measurable monthly targets. Preserve CBG-001 through CBG-021 and AC-CBG-001 through AC-CBG-010. Do not implement, write to GitHub, start G4, commit, push, merge, mutate any target repository, or change the Home runtime.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute Stage A of the complete reviewed Spec Kit feature for `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md` with deliveryAuthority=LocalImplementation. Implement and verify only the Level-0-owned registry-ID profile contract, local gate, evidence, pre-push, canonical workflow and ruleset templates, tests, statistics, documentation, and deterministic fleet rollout plan authorized by G3. Do not mutate any of the 47 target repositories, GitHub rulesets or account settings, commit, push, merge, use an admin bypass, sync Home, perform the Stage B fleet rollout, or start G4. Stop if remote authority or a safety-gate exception would be required.
```

<!-- intake-authoring:end -->
