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
Die Flotte erhält nachvollziehbare CI-Profile, lokale Pflichtprüfungen und eine
HEAD-gebundene Evidence. Öffentliche CI bleibt dort erhalten, wo sie kostenfrei
und für Portabilitäts- oder Produktnachweise erforderlich ist.

Der Planungsstand umfasst 48 Git-Repositories: die Level-0-Quelle sowie 47 im
Flottenregister deklarierte Git-Repositories; die zusätzliche Collection ist
nur ein logischer Gruppenknoten. Die bisherige Einteilung von 27 privaten und
21 öffentlichen Repositories ist vor einer Umsetzung live zu revalidieren und
nicht als zeitloser Festwert zu behandeln.

### 2. Begriffe

- **CI:** Automatisierte Prüfung eines Commits oder Pull Requests.
- **Lokales Gate:** Pflichtprüfung auf dem Entwicklungsrechner vor dem Push.
- **Evidence:** Maschinenlesbarer Nachweis, welche Prüfungen für welchen HEAD
  und welche Gate-Konfiguration erfolgreich waren.
- **Canary:** Öffentliches Referenzrepository, das den gemeinsamen
  plattformübergreifenden CI-Vertrag früh sichtbar prüft.
- **Pfadabhängig:** Ein Job startet nur, wenn für ihn relevante Dateien
  verändert wurden.

### 3. Verbindliche Anforderungen

- **CBG-001 – Live-Inventur:** Die Umsetzung ermittelt Repository, Sichtbarkeit,
  Default-Branch, Workflow-Auslöser, Runner, durchschnittliche Dauer und
  geplante Läufe erneut aus Register und GitHub-Livezustand.
- **CBG-002 – Profilvertrag:** Jedes der 48 Git-Repositories gehört genau einem
  Profil an: drei Public Canaries, sechs Public Products, sechs Private
  Products, 21 Private Governance/Scaffold oder zwölf Public Presets.
- **CBG-003 – Private Governance:** Private Governance-/Scaffold-Repositories
  führen keine automatischen PR- oder Main-Builds aus. Ihre Pflichtprüfungen
  laufen lokal und fail-closed vor dem Push.
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
  zulässt.
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
  Kostensenkung umgangen werden.
- **CBG-019 – Keine Eigenmutation:** Das Wartungsskript startet genau einen
  Engine-Prozess und committet oder pusht kein Zielrepository.
- **CBG-020 – Dokumentation:** Documentation Impact ist `UpdateRequired`.
  Bedienung, Profile, Evidence, Fehlerfälle, Home-Runtime-Verteilung und
  Re-Evaluation werden bilingual dokumentiert.

### 4. Ergebnisartefakte

- versionierter CI-Profil- und Kostenvertrag;
- Bash-/PowerShell-Oberfläche für das lokale CI-Gate;
- versioniertes Evidence-Schema und deterministische Evidence-Erzeugung;
- Pre-push-Prüfung gegen HEAD und Gate-Set-Hash;
- angepasste private Workflow-Auslöser und Zeitpläne;
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
- kein automatisches Committen, Pushen, Mergen oder Starten von G4;
- kein Intake Review, Specify oder Autonomous durch die Erstellung dieses
  Lastenhefts.

### 7. Risiken und Gegenmaßnahmen

- Zu enge Pfadfilter können notwendige Tests auslassen; deshalb werden
  sicherheits- und buildrelevante Pfade als verbindliche Auslöser getestet.
- Veraltete lokale Evidence kann einen falschen Pass vortäuschen; deshalb ist
  sie an HEAD und Gate-Set-Hash gebunden.
- Plattformfehler können bei Linux-only-PRs später sichtbar werden; deshalb
  bleibt der geplante macOS-Nachweis erhalten.
- Flottendrift kann Profilzahlen verändern; deshalb ist die Live-Inventur ein
  Pflicht-Preflight und ein Re-Evaluation-Trigger.

### 8. Messbare Abnahme

- **AC-CBG-001:** Jedes aktuelle Git-Repository ist genau einem gültigen Profil
  zugeordnet; Collection-Knoten werden nicht als Repository gezählt.
- **AC-CBG-002:** Eine typische private Governance-Lieferung startet keine
  privaten PR-/Main-Actions-Jobs und wird durch erfolgreiche lokale Evidence
  geschützt.
- **AC-CBG-003:** Eine Änderung an allen sechs CaseTracker-Produkten startet
  höchstens sechs pfadgerechte PR-Jobs.
- **AC-CBG-004:** Die geplante private Grundlast liegt bei ungefähr 22 Jobs pro
  Woche; Abweichungen werden erklärt.
- **AC-CBG-005:** Das Ziel liegt unter 500 von 3.000 privaten Actions-Minuten im
  Monat, ohne Copilot-AI-Credits damit zu vermischen.
- **AC-CBG-006:** Null-, Einzel- und Mehrfachrepository-Läufe erzeugen
  deterministische Ergebnisse und passende Exitcodes.
- **AC-CBG-007:** Fehlende, veraltete oder fehlgeschlagene Evidence blockiert
  den privaten Push; passende Evidence lässt ihn zu.
- **AC-CBG-008:** Bash-/PowerShell-Parität, bestehende Wartungsregressionen,
  A11Y-, Secret-Scan- und Workflowtests sind grün.
- **AC-CBG-009:** Copilot-Konfiguration blieb unverändert und G4 wurde nicht
  gestartet.

### 9. Reihenfolge und Abschlussgrenze

G3 besitzt keinen bindenden Vorgänger. Nach erfolgreichem Intake Review,
Specify und einem ausdrücklich autorisierten Implementierungslauf liefert G3
die `ActionsBudgetBaseline` für G4. Die bloße Einstufung als `Eligible` erteilt
keine Start-, Commit-, Push-, Merge- oder Bypass-Autorität.

## English Contract

### 10. Purpose and target state

This intake limits private GitHub Actions consumption without weakening
technical, security, accessibility, or review gates. The fleet receives
explicit CI profiles, mandatory local gates, and HEAD-bound evidence. Public CI
remains where it is cost-free and required for portability or product proof.
The planning snapshot contains 48 Git repositories; implementation must
recompute visibility and fleet membership from live evidence.

### 11. Binding requirements

- **CBG-001–002:** Re-inventory all repositories and assign each repository to
  exactly one of the five approved CI profiles.
- **CBG-003–004:** Private governance repositories use fail-closed local gates
  without automatic PR/main builds; private products use path-gated PR CI and
  no duplicate main build without a separate purpose.
- **CBG-005–007:** Six CaseTracker changes start at most six jobs; Swift PRs use
  Linux with weekly/manual macOS evidence; private Release Please is weekly and
  manual only.
- **CBG-008–009:** Preserve required public CI and the three canaries; do not
  add per-repository Actions workflows to the twelve public presets in this
  cost project.
- **CBG-010–014:** Add `--ci-gate`/`-CiGate`, emit versioned evidence under the
  declared local path, bind it to repository HEAD and gate-set hash, and require
  matching evidence in the shared private-fleet pre-push hook.
- **CBG-015–017:** Treat path filters as a tested process contract, account for
  Copilot review runner usage separately, and preserve Bash/PowerShell parity.
- **CBG-018–020:** Preserve all security and review barriers, keep the
  maintenance engine non-committing and non-pushing, and update bilingual
  operational documentation.

### 12. Acceptance and boundaries

The final solution proves exact profile coverage, zero automatic private
governance PR/main jobs, no more than six CaseTracker PR jobs for a six-product
change, about 22 scheduled private jobs per week, and a target below 500 of
3,000 private Actions minutes per month. Missing or stale evidence blocks a
private push. Existing cross-platform, maintenance, security, accessibility,
and workflow regression tests remain green. Self-hosted runners, Copilot
settings, subscription changes, remote delivery, and an automatic G4 start are
out of scope.

<!-- intake-authoring:prompts -->
## Kopierbare Spec-Kit-Prompts / Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md` as the binding G3 intake. Specify the registry-derived five-profile CI budget contract, private local gates, HEAD- and gate-set-bound evidence, Bash `--ci-gate`, PowerShell `-CiGate`, private pre-push enforcement, path-gated product CI, scheduled macOS and Release Please runs, public canaries, separate Copilot runner accounting, security and A11Y invariants, and the measurable monthly targets. Preserve CBG-001 through CBG-020 and AC-CBG-001 through AC-CBG-009. Do not implement, write to GitHub, start G4, commit, push, merge, or change the Home runtime.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete reviewed Spec Kit feature for `Lastenheft_Flottenweite-CI-Budget-Governance-und-Actions-Rationalisierung.md` with deliveryAuthority=LocalImplementation. Implement and verify only the repository-owned CI profile, local gate, evidence, pre-push, workflow, test, statistics, and documentation changes authorized by G3. Do not mutate Copilot rulesets or account settings, commit, push, merge, use an admin bypass, sync Home, or start G4. Stop if remote authority or a safety-gate exception would be required.
```

<!-- intake-authoring:end -->
