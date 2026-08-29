# Implementierungsplan: Flottenweite GitHub-Copilot-Review-Governance / Implementation Plan: Fleet-Wide GitHub Copilot Review Governance

**Branch**: `031-github-copilot-review-governance` | **Datum / Date**: 2026-08-28 | **Spezifikation / Spec**: [spec.md](spec.md)
**Input**: Ready-Review `d76c8231-c875-41ee-9dfc-65afe756f626`, `CRG-001` bis `CRG-018`, `AC-CRG-001` bis `AC-CRG-010`, aktiver Autonomous Run `1b7788fb-81f3-4d76-8006-885d834dd454`

## Zusammenfassung / Summary

G4 implementiert den deterministischen Produkt- und Entscheidungskern als
PowerShell-7-Modul auf .NET und stellt ihn über das vollständige PowerShell-
Cmdlet sowie einen gleichwertigen Bash-Adapter bereit. Eine frische read-only
Inventur ermittelt alle vom
persönlichen Account besessenen Repositories, deren Sichtbarkeit und Default-
Branches, jedes aktive Repository-Ruleset mit `copilot_code_review`, die
persönliche Accountautomatik sowie Abrechnungs-/Usage-Anzeigen. Der feste
Sollvertrag aktiviert genau acht benannte Repository-/Branch-Ziele, mit
`review_draft_pull_requests=false`, `review_on_push=false` und dem getrennt
belegten Browserwert `Lite`; alle frisch bestätigten dedizierten Nichtziel-
Rulesets werden deaktiviert und nie gelöscht.

*G4 implements the deterministic product and decision core as a PowerShell 7
module on .NET, exposed through the full PowerShell cmdlet and an equivalent
Bash adapter.
Fresh read-only inventory, an exact eight-repository desired state, exact-ID
plans, operation-specific write gates, after-state validation, rollback,
idempotency, redaction, and separate API/browser evidence form one fail-closed
transaction contract.*

## Technischer Kontext / Technical Context

**Sprachen / Language versions**: PowerShell 7+ auf .NET als primärer
speichersicherer Produkt- und Entscheidungskern samt Cmdlet; Bash-3.2+-
kompatibler Adapter für macOS/Linux; Python 3 ausschließlich für bereits
zulässige repositoryeigene Test- und Validierungshelfer

**Abhängigkeiten / Primary dependencies**: PowerShell 7/.NET,
Git, authentifizierte `gh` CLI und vorhandene Repository-Validatoren; Python-
Standardbibliothek nur für Test-/Validierungshelfer; keine neue Package-
Dependency

**Speicher / Storage**: versionierte Sollkonfiguration und JSON-Schemas;
restriktive maschinenlokale Lauf-Evidence unter `.specify/runtime/`; nur
redigierte terminale Evidence unter dem Featurepfad

**Tests / Testing**: PowerShell-Pester-freie repositoryeigene Vertragschecks,
Python-`unittest`-Validierungshelfer, deterministische Fake-Provider- und
Browser-Evidence-Fixtures, Schema-/Semantikvalidatoren, Mutation Spies,
Bash-Syntax, PowerShell-Parser/PSScriptAnalyzer, Security-/A11Y-/Secret-
Prüfungen und native macOS-/Linux-/Windows-Nachweise

**Zielplattformen / Target platforms**: macOS/Linux über Bash, Windows über
PowerShell 7+, GitHub.com REST/API plus ausdrücklich manuelle Browserflächen

**Projekttyp / Project type**: Level-0-Control-Plane-CLI mit externer SaaS-
Providergrenze; kein eigener Webservice und keine neue Zielrepository-Runtime

**Leistungsziele / Performance goals**: genau ein Engine-Prozess pro Aufruf;
read-only Seiten bis 100 Einträge vollständig paginiert; höchstens drei
begrenzte Retries nur für transiente Reads; genau ein serialisierter Writer;
zweiter Validate-Lauf mit null Drift und null Writes

**Grenzen / Constraints**: historische `22/6/2/16` niemals als Livefakt;
keine Shellstrings, keine freien Provider-URLs, kein Delete, keine blinden
Write-Retries, kein Credential-/Cookie-/Billingrohdatenspeicher, kein
Providerwrite ohne aktuellen operationsspezifischen External-Write-Gate

**Umfang / Scale**: dynamische vollständige Menge aller aktuell besessenen
Account-Repositories und ihrer Rulesets; fester fachlicher Zielzustand von
exakt acht Repository-/Default-Branch-Paaren; sieben getrennte Provider-
Operationsklassen `AccountSetting`, `EffortLevel`, `RulesetCreate`,
`RulesetUpdate`, `RulesetDisable`, `PRLifecycleAcceptance` und
`ManualReviewAcceptance`. `Delivery` und `Rollback` bleiben eigene
Kontrollklassen.

**Offene technische Fragen / Technical unknowns**: keine. Alle
Provideroberflächen und Browsergrenzen sind in [research.md](research.md)
entschieden; Providerdrift bleibt ein Laufzeit-Hard-Stop, keine Planfrage.
Der supporting lokale Runner-Fix `TerminalAwareRunnerAdoption` ist unten als
vollständiger, Python-freier PowerShell/.NET-Entscheidungsvertrag festgelegt;
seine Implementierung und deterministische Matrix bleiben ein
Pre-Implementation-Gate vor jeder G4-Produktänderung.

## Verfassungsprüfung vor Design / Pre-Design Constitution Check

Beide Verfassungen sind bytegleich, Version `1.21.0`, SHA-256
`1d146f90d35be75ece1f5fd41bca5cf488a8861002fe28943072195fde3f26df`.
Alle akzeptierten Intake-, Review-, Serien- und Stage-B-Artefakte stimmen mit
den zehn Hashbindungen des Run-State überein. G4 ist `Primary/Eligible`;
Position 7 bleibt durch `HardCompletionGate` blockiert.

| Prüfpunkt / Checkpoint | Konkrete Designbindung / Concrete design binding | Status |
|---|---|---|
| Security-First und Secure Coding | PowerShell/.NET ist der primäre MSL-Kern; Bash bleibt der vorhandene Unix-Adapter mit `set -euo pipefail`, Quotes und `--`. Python ist auf repositoryeigene Test-/Validierungshelfer begrenzt. Eingaben, IDs, Pfade und Providerdaten werden closed-world validiert; `eval`, `Invoke-Expression`, Shellstrings und freie URLs sind verboten. | Pass |
| Sichere Architektur | Account-UI, Repository-API, Ruleset, Billing/Usage, PR-Lifecycle, lokale Evidence und Git-Lieferung sind getrennte Trust Boundaries. Least Privilege, deny-by-default, TOCTOU-Hashbindung, Defense in Depth und begrenzter Rollback sind explizit. | Pass |
| Security-Evidence | Threat Model mit STRIDE+CIA/CAPEC, S-ADR, arc42 Abschnitt 8, Security Checklist, Dependency Audit, Security Quality Scenarios, Zero Trust, SAMM, BSI C3A/C5, Supply Chain und Regulatory Applicability werden aktualisiert. ASVS und AI-SBOM bleiben mit Begründung `N/A`. | Pass |
| Supply Chain | Keine neue Dependency. SBOM/VEX/SLSA/OpenSSF- und Dependency-Evidence werden für die distributablen Skripte revalidiert; Providerdokumentation ersetzt keine Dependencyprüfung. | Pass |
| Architektur/iSAQB | Kontext, Bausteine, Schnittstellen, Laufzeit, Deployment-/Providerfluss, Qualitätsattribute, Risiken und technische Schuld werden in `docs/architecture/copilot-review-governance.md` und S-ADR festgehalten. | Pass |
| A11Y/Inklusion | CLI, Help, Manpage, Quickstart und Evidence bleiben linear, text-first, farbunabhängig, tastatur-/Screenreader-/Braille-/Textbrowser-tauglich nach WCAG 2.2 AA soweit anwendbar. | Pass |
| Sprache/Lernbasis | Deutsch zuerst, Englisch danach, CEFR B2; Fachbegriffe und sichere nächste Aktion werden vor Details erklärt, ohne Spec-Kit-Vorwissen. | Pass |
| Cross-Platform | Bash und PowerShell werden zusammen geplant; Manpage, vollständige bilinguale PowerShell-Hilfe, `Set-HBCopilotReviewGovernance`, `--dry-run`/`-WhatIf`, gemeinsame Exitcodes und native Evidence sind ein Gate. | Pass |
| Agent Parity | Shared Guidance wird auf allen fünf gepflegten Flächen geprüft. Eine Änderung erfolgt nur atomar samt Templates und beiden Verfassungen; wenn keine Policyänderung nötig ist, wird `N/A` mit Diff-/Validatornachweis festgehalten. | Pass |
| Intake/Autonomous | Ready-Review, Serienstatus, Stage-B-Terminalität, `MergeAndSync`, bounded bypass und Phasenergebnisse bleiben hashgebunden. Providerautorität wird daraus nicht abgeleitet. | Pass |
| Statistik | Nach abgeschlossener Implementierung wird nur `docs/project-statistics.config.json` kanonisch geändert und Profil 2 über den Renderer aktualisiert/verifiziert; Baselines 80/100 Zeilen pro Arbeitstag. | Pass |
| Documentation Impact | Die einzige Entscheidung ist unten einmal festgelegt; Leserpfad, Owner, Navigation, Sprachpartner, Plattformproof, Distribution, Home-Sync und Re-Evaluation sind vollständig geplant. | Pass |

### Standardsdisposition / Standards Disposition

| Standard | Entscheidung / Decision | Evidence |
|---|---|---|
| NIST SSDF, CWE Top 25, CAPEC | `Applicable` für Remote-Write-, Eingabe-, Pfad-, Authority- und Evidence-Risiken | `docs/security/security-checklist.md`, `threat-model.md` |
| OWASP ASVS | `N/A`: kein eigener Web/API/Auth-Service | `docs/security/asvs-verification.md` |
| SBOM, VEX, SLSA, OpenSSF Scorecard | `Applicable` für distributable Level-0-Skripte und öffentliche Repositories | `docs/security/supply-chain-evidence.md`, `dependency-audit.md` |
| AI-SBOM | `N/A`: Copilot ist externes Reviewwerkzeug, keine ausgelieferte KI-Runtime | Supply-Chain-Evidence |
| Zero Trust, SAMM | `Applicable` für langlebige Remote-Governance | `zero-trust-applicability.md`, `samm-assessment.md` |
| BSI C3A, BSI C5 | `Applicable` für GitHub/Copilot/Actions/Settings als reale SaaS-Fläche; keine Zertifizierungsaussage | Cloud-Autonomie-/Assurance-Evidence |
| NIS2, CRA, EU AI Act, DORA | `N/A` gemäß Spezifikation; keine nachgewiesene regulierte Rolle oder neue Marktkomponente | `regulatory-applicability.md` |

## Governance-Evidence-Plan / Governance Evidence Plan

Jeder anwendbare Checkpoint erhält in Plan Review, Tasks und Implementation
`Applicable`, Implementierungsstatus, Rationale, Evidencepfad, Owner, Reviewer,
Restrisiko, Re-Evaluation Trigger und Follow-up. `N/A` bleibt sichtbar mit
Begründung; `Open` ist im vorimplementativen Gatevertrag nicht zulässig.

| Governance | Applicability | Owner / Reviewer | Geplante Evidence / Planned evidence |
|---|---|---|---|
| Security | Applicable | Security Owner / Security Reviewer | `docs/security/` und `checklists/security.md` |
| Architecture | Applicable | Architecture Owner / Architecture Reviewer | Architekturübersicht, S-ADR, arc42, Qualitätszenarien |
| iSAQB | Applicable | Architecture Owner / iSAQB Reviewer | Kontext-, Baustein-, Laufzeit-, Deployment- und Risikosichten |
| A11Y | Applicable | A11Y Owner / A11Y Reviewer | `docs/accessibility/copilot-review-governance.md`, text-first Fixtures |
| Cross-Platform | Applicable | Script Owner / Cross-Platform Reviewer | macOS Safe Mode, native Linux-/Windows-CI-Records, Paritätscheckliste |
| Agent Parity | Applicable | Governance Owner / Agent Parity Reviewer | vollständiger Surface-Diff und Paritätsvalidator; Änderung oder begründetes `N/A` |
| Intake Sequencing | Applicable/Fulfilled | Intake Owner / Intake Reviewer | unveränderte Manifest-/Receipt-/Operation-/Stage-B-Hashes |
| Autonomous Run | Applicable | Run Owner / Autonomous Reviewer | Gate Requirements, Phase Results, Pre-/PostMerge- und Closeout-Evidence |

## Architektur und Datenfluss / Architecture and Data Flow

### Bausteine / Building Blocks

1. **CopilotReviewInventoryAdapter** erweitert die vorhandenen sicheren
   `gh`-Argumentarrays. Er listet `/user/repos?affiliation=owner` vollständig,
   liest Repository-ID/Sichtbarkeit/Default-Branch, paginiert
   `repos/{owner}/{repo}/rulesets?includes_parents=false`, lädt jedes Detail
   über die numerische Ruleset-ID und prüft zusätzlich effektive Branchregeln.
2. **BrowserEvidenceBoundary** importiert nur redigierte, manuell bestätigte
   Fakten für persönliche Accountautomatik und Repository-Effort-Level. Cookies,
   HTML, Screenshots mit Accountdetails und Browserprofile bleiben
   `machineLocal`; versioniert werden Zustand, UI-Pfadklasse, Zeit, Reviewer
   und normalisierter Evidencehash.
3. **UsageInventoryAdapter** liest die aktuell unterstützten User-Billing-
   Endpunkte mit `Plan:read`, filtert Actions-Berichte auf
   `dynamic/agents/copilot-pull-request-reviewer` und hält AI Credits,
   Actions-Minuten sowie automatische/manuelle Auslöser in getrennten Feldern.
   Nicht eindeutig klassifizierbare Trigger bleiben `Unknown` und blockieren
   eine vollständige Kostenbehauptung.
4. **DesiredStateLoader** validiert die exakt acht unveränderlichen Target-
   Selector-Einträge aus
   `scripts/config/copilot-review-governance-desired-state.json`; jeder
   Selector enthält nur Position, Slug und Default-Branch. Das getrennte
   closed-world Objekt `desiredSettings` enthält Accountautomatik,
   Ruleset-Target/-Enforcement, Draft-/Push-/Ready-Parameter und `Lite` als
   gemeinsame gewünschte Revieweinstellungen. Frisch inventarisierte
   Live-Identität enthält zusätzlich Provider-ID und Sichtbarkeit. Vor jedem
   Write müssen Selector und Live-Identität bei Slug und Default-Branch exakt
   übereinstimmen; Provider-ID und Sichtbarkeit werden ausschließlich aus der
   frischen Inventur gebunden und erneut gelesen.
5. **MutationPlanner** bildet ausschließlich aus frischer Inventur und
   Sollvertrag die Aktionen `NoOp`, `Update`, `Create`, `Disable` oder
   `Blocked`. `Delete` existiert weder im Schema noch im Adaptervokabular.
6. **ExternalWriteGateValidator** bindet Operationsklasse, Run-ID, Planhash,
   fuer `AccountSetting` den exakten `accountOwner=hindermath`, sonst exakte
   Repository-/Ruleset-/PR-IDs, Aktionsallowlist, Berechtigungsscope,
   Frische, Ablaufzeit, Secret-Behandlung, Vorzustandshashes, Rollback sowie
   Acceptance-/Security-/Review-/Technik-Evidence. Jede der neun Klassen ist
   closed-world an ihre Methoden, Identitätsfelder und Minimum-Scopes
   gebunden. `AccountSetting` verlangt genau `BrowserManual`, leere
   Repository-/Ruleset-/PR-ID-Arrays,
   `PersonalCopilotSettings:write` und einen aktuellen ausdruecklichen
   Authority-Record, dessen Accountidentitaet exakt uebereinstimmt. Der
   `accountOwner` ist bei allen nicht accountbezogenen direkten Klassen
   verboten; nur `Rollback` aus `AccountSetting` uebernimmt ihn. Insbesondere
   erlaubt `Delivery` ausschließlich `GitPush` und `GitHubMerge` mit
   Repository-/PR-IDs und niemals Provider-`POST`/`PUT`,
   Ruleset-IDs oder Settings-Scope; `Rollback` bindet zusätzlich die
   Quelloperationsklasse. `MergeAndSync` und Admin-Bypass erweitern keine
   dieser Providergrenzen.
7. **RulesetTransaction** serialisiert exakt eine API-Mutation und akzeptiert
   pro Gate genau eine der Klassen `RulesetCreate`, `RulesetUpdate` oder
   `RulesetDisable`. `POST` ist nur für `RulesetCreate` und einen frisch
   bestätigten fehlenden Zielregelsatz zulässig; `PUT` ändert bei
   `RulesetUpdate` oder deaktiviert bei `RulesetDisable` eine exakte ID. Eine
   Autorität gilt nie klassenübergreifend. Nach unklarer Antwort wird read-only
   reconciled, nie blind erneut geschrieben. Update-/Disable-Resultate binden
   immer exakte Repository- und Ruleset-ID. Create übernimmt die neue
   Ruleset-ID nur, wenn validierte `201`-Antwort und frische Post-Inventur
   exakt dieselbe ID liefern; Resultat, After-State und Rollback binden diese
   eine ID samt Ergebnis- und Inventurhash.
8. **ManualBrowserTransaction** führt Account-Disable und acht `Lite`-
   Einstellungen als getrennte, ausdrücklich autorisierte Operator-Schritte.
   Der Account-Schritt bindet in Mutationsplan, External-Write-Gate,
   Mutationsergebnis und Rollback durchgehend exakt
   `accountOwner=hindermath`; Missing oder Mismatch blockiert vor Apply.
   Vorher-/Nachher-/Rollback-Checkliste und Reviewer-Bestätigung sind Pflicht;
   Browserautomation ist keine Implementierungsvoraussetzung.
9. **EvidencePublisher** verwendet die vorhandene kanonische JSON-
   Normalisierung, Owner-only temporäre Dateien, atomisches Replace,
   Symlink-/Pfadprüfung, Redaction und separate operative/terminale Namespaces.
10. **AcceptanceAggregator** führt genau einen stabilen Primary-Gatebefehl je
    `AC-CRG-001` bis `AC-CRG-010` aus und aggregiert erst nach kompletter
    Mengengleichheit terminale Evidence.

### Exakter Acht-Repository-Sollvertrag / Exact Eight-Repository Desired State

Die Tabelle ist der statische Target-Selector-Vertrag. Sie enthält bewusst
keine Provider-ID und keine Sichtbarkeit. Diese Live-Identitätsfelder stammen
ausschließlich aus der frischen vollständigen Inventur und werden unmittelbar
vor jedem Write zusammen mit Slug und Default-Branch verglichen.

| Reihenfolge | Repository | Default Branch | API-Zustand | Browser-Zustand |
|---:|---|---|---|---|
| 1 | `hindermath/home-baseline` | `main` | genau ein aktives dediziertes `copilot_code_review`; Draft `false`; Push `false` | `Lite` |
| 2 | `hindermath/agent-operations-cockpit` | `main` | wie oben | `Lite` |
| 3 | `hindermath/TuiVision` | `main` | wie oben | `Lite` |
| 4 | `hindermath/TinyPl0` | `main` | wie oben | `Lite` |
| 5 | `hindermath/TinyCalc` | `main` | wie oben | `Lite` |
| 6 | `hindermath/InventarWorkerService` | `main` | wie oben | `Lite` |
| 7 | `hindermath/cc65` | `master` | wie oben | `Lite` |
| 8 | `hindermath/tvision` | `master` | wie oben | `Lite` |

Accountweit ist die persönliche automatische Revieweinstellung `Disabled`.
Außerhalb dieser Acht ist kein aktives Repository-Ruleset mit
`copilot_code_review` zulässig. `TuiVision` wird genau einmal gezählt.

### Planungsregeln aus Livefakten / Live-Fact Planning Rules

- `NoOp`: exakte Repository-/Branch-/Ruleset-ID und vollständiger API-/Browser-
  Sollzustand stimmen; der zweite Lauf schreibt nullmal.
- `Update`: genau ein dediziertes Zielruleset mit bestätigter ID existiert,
  aber Branchcondition, Enforcement oder Copilotparameter weichen ab.
- `Create`: am exakten Zielrepository existiert nach vollständiger Pagination
  kein entsprechendes Ruleset; die neue ID wird erst aus der `201`-Antwort und
  Post-Write-Inventur übernommen.
- `Disable`: ein frisch bestätigtes dediziertes aktives Nichtziel- oder
  überschüssiges Zielruleset wird per exakter ID auf `disabled` gesetzt und
  vollständig für Rollback erhalten.
- `Blocked`: gemischtes Schutz-/Copilot-Ruleset, geerbte/organisationsweite
  Quelle, doppelte Identität, unbekannte ID, unvollständige Pagination,
  Sichtbarkeits-/Branchdrift, Browser/API-Widerspruch oder unsicherer Rollback.

Die authoring-zeitlichen sechs Updates, zwei Creates und sechzehn Disables sind
nur Vergleichswerte. Jede Abweichung erzeugt eine neue reviewpflichtige
Change-Menge; sie wird nicht still neu klassifiziert.

### Zieltransaktion und TOCTOU-Schutz / Target Transaction and TOCTOU Protection

1. Frische vollständige Inventur mit serverseitiger Zeitquelle, Seitenzählern
   und normalisiertem Snapshot-Hash erfassen.
2. Sollvertrag, vollständige Inventur, API-Version und Browser-Evidence prüfen.
3. Deterministischen Plan sortiert nach Operationsklasse, Repository-ID und
   Ruleset-ID erstellen; Vorzustand, Desired State und Rollback hashen.
4. Feature Owner und Reviewer akzeptieren Gate-Map und konkrete Change-Menge.
5. Operationsspezifische ausdrückliche Provider-Write-Autorität in einem
   zeitbegrenzten External-Write-Gate binden; Preview weist null Writes aus.
6. Unmittelbar vor Write dieselben IDs und Vorzustandshashes erneut lesen.
7. Exakt eine Aktion mit fester Argumentliste ausführen; unbekannte Ergebnisse
   read-only über Idempotenz-ID/Zustand reconciliieren.
8. Frische Nachinventur gegen Desired State prüfen und Resultat atomar sichern.
9. Bei falschem Nachzustand nur den vorab gebundenen exakten Rollback erwägen;
   neuere legitime Änderung oder Hashdrift führt zum Hard Stop.
10. Nach jeder Operationsklasse neue Inventur, Authority- und Gateprüfung;
    erst vollständige API- plus Browserkonvergenz erlaubt terminale Evidence.

### Review-, Usage- und Delivery-Grenzen / Review, Usage, and Delivery Boundaries

- Ready-open oder erster Draft-to-Ready löst höchstens ein automatisches
  Review aus; Draft- und Pushoption bleiben `false`. Controlled PR-Lifecycle-
  Evidence ist eine eigene Provider-Write-Klasse und benötigt aktuelle
  Autorität; ein natürlicher exakter Feature-PR darf nur die nachgewiesene
  Teilstrecke ersetzen.
- Manuelle Anforderung bleibt erhalten. Eine echte manuelle Testanforderung
  verbraucht Providerressourcen und wird nicht aus `MergeAndSync` abgeleitet;
  Browser-Verfügbarkeitsproof und tatsächlicher Trigger werden getrennt.
- Copilot bleibt advisory. Human Review, technische CI, Security und
  Acceptance werden getrennt berichtet; Quota/Billing-Refusal ist kein Pass.
- Der Git-Lieferpfad dieses Repositories verwendet exakt Branch, Commit,
  Push, PR, Gate-Map, Exact-Head-Review und regulären Mergeversuch. Der
  autorisierte Bypass folgt nur auf `ProtectionOnlyRefusal`, ist zeit-/ziel-
  gebunden und ersetzt keine Evidence.
- Nach Merge werden lokaler/remote Default-Branch synchronisiert und der
  exakte Merge-Commit read-only geprüft. Position 7, Subscription, Budgetkauf
  und Cancellation bleiben unverändert.

### TerminalAwareRunnerAdoption (TA-007)

`TerminalAwareRunnerAdoption` ist eine eng begrenzte Korrektur des installierten
Parent-Runners und keine zweite Zustandsquelle. Der feature-lokale
`autonomous-run-state.json` bleibt der einzige kanonische Zustand. Der Vertrag
gilt ausschließlich für die explizit terminale Routingphase
`implement-closeout`; alle normalen nichtterminalen Phasen behalten ihr
bisheriges parent-owned Verhalten.

#### Parent-/Child-Protokoll / Parent/Child Protocol

1. Der Parent führt Preflight, `Running`-Persistenz und Child-Start unverändert
   aus. Direkt nach seinem atomaren `Running`-Write hält er die exakten Bytes
   und den lowercase SHA-256 dieses Disk-Snapshots sowie Schema, Run-ID,
   Featurepfad, Branch, Delivery-Modus, kanonischen Statepfad, Phasenidentität
   und aufgelöste Routingmetadaten nur im Speicher fest.
2. Ein Exitcode ungleich null ist ein definitiver Child-Fehler. Vor jedem
   parent-owned Blocked-Write wird der State erneut byteweise gelesen. Ist er
   unverändert, bleiben heutige Fehlersemantik und atomarer Parent-Write
   erhalten. Ist er verändert, wird nichts überschrieben; der Runner endet
   deterministisch mit
   `TERMINAL_STATE_DRIFT_REQUIRES_READ_ONLY_RECONCILIATION` und Nonzero-Exit.
3. Nach Child-Exit `0` muss zuerst die Ergebnisdatei am exakt normalisierten
   Runnerpfad existieren und der bestehende semantische Phase-Result-Validator
   für dieselbe `phaseId` und Exitcode `0` erfolgreich sein. Der Parent lädt
   danach den feature-lokalen State frisch von Disk, bevor er irgendeinen
   Success-Write erwägt.
4. Ist der Disk-State gegenüber dem gespeicherten `Running`-Snapshot
   unverändert, gelten die bisherigen Success-/Failure-Wege: Der Parent bindet
   Resultpfad/-hash, setzt die Phase `Completed` und schreibt atomar. Das gilt
   für jede normale Phase und auch für einen `implement-closeout`-Child, der
   keinen terminalen State publiziert hat.
5. Ist der Disk-State verändert, ist Adoption nur bei Phase
   `implement-closeout`, Kommando `speckit.implement` und vollständig erfülltem
   Terminalvertrag zulässig. Bei exakter Adoption verwendet der Parent das
   frisch geladene Objekt für Antwort und Rückgabemetadaten. Nach Child-Rückkehr
   ruft er weder `Write-AMRJsonAtomic` noch irgendeinen anderen Writer auf einen
   Featurepfad auf. Die maschinenlokale Ergebnisdatei und ein best-effort Log
   unter dem bereits gebundenen `OutputDirectory` sind ausdrücklich
   `runnerLocal`-Evidence: Sie sind keine Zustandsquelle, dürfen keinen
   Featurepfad ändern und ein Log-Materialisierungsfehler darf eine bereits
   exakt validierte terminale Adoption nicht nachträglich blockieren.
6. Jede fehlende, unbekannte oder abweichende Terminalbedingung verwirft die
   Adoption fail-closed. Der Parent bewahrt den vollständigen Disk-Snapshot,
   gibt denselben deterministischen Reconciliation-Code aus und schreibt weder
   `Blocked` noch stale Routingdaten darüber. Status/Resume müssen danach nur
   read-only State, Tasks, Resultat und Gitbeziehung abgleichen.
7. Der Catch-Pfad führt vor jedem Write denselben Byte-/Hashvergleich gegen den
   gespeicherten `Running`-Snapshot aus. Bei Drift ist jeder stale Write
   verboten; nur bei unverändertem State bleiben heutiger `Blocked`-Write und
   atomare Parent-Ownership erhalten.

#### Exakter Adoptionsvertrag / Exact Adoption Contract

Alle folgenden Prüfungen sind konjunktiv; unbekannte Enumwerte, fehlende
Properties, falsche Typen, zusätzliche Identitätsdeutung oder ein einziger
Mismatch blockieren:

- Schema-Version, `runId`, `featurePath`, `branch` und `deliveryMode` stimmen
  exakt mit dem Parent-Snapshot überein; der State liegt nach kanonischer
  Auflösung exakt unter `<repo>/<featurePath>/autonomous-run-state.json`.
- Der frisch geladene State besteht den installierten Run-State-Validator,
  hat `status=Completed`, `nextExactAction=N/A` und für `MergeAndSync`
  `closeout.mergeOrPublication=Completed`,
  `closeout.defaultBranchSync=Completed`,
  `closeout.postMergeActions` in `N/A|Completed` sowie
  `closeout.finalValidation=Completed`.
- `tasks.path` ist der kanonische feature-lokale `tasks.md`; sein tatsächlicher
  lowercase SHA-256 stimmt mit `tasks.sha256` überein. Exakt 168 eindeutige,
  fortlaufende Checkboxen `T001..T168` sind abgeschlossen und
  `tasks.completed=tasks.total=168`.
- Die eine Routingphase `implement-closeout` ist im reloaded State bereits
  `Completed`, hat `exitCode=0`, `preflight=Completed`, den tatsächlichen
  normalisierten repositoryrelativen Resultpfad und dessen validierten
  lowercase Hash. `command`, `routingRole`, `runnerProfile`, `agentFamily`,
  `model` und `reasoningEffort` stimmen exakt mit Parent-Katalog und
  aufgelöstem Runnerprofil überein. `lastOperation.kind` ist exakt
  `ModelRoutingPhase:implement-closeout`, `lastOperation.state=Completed` und
  der letzte Gate-/Next-Action-Stand behauptet keinen offenen Folgeschritt.
- Das strukturierte Resultat hat dieselbe Phase, Exitcode-Semantik, vollständige
  Tasks/Gates und einen existierenden repositoryrelativen Payload, dessen
  tatsächlicher Hash dem validierten Payloadhash entspricht. Resultpfad und
  Payload dürfen weder absolut sein noch `..`, Symlink-/Reparse- oder
  OutputDirectory-Escape enthalten.
- Die terminale Gitbeziehung ist read-only exakt: Repository-/Worktree-Root
  stimmen, `HEAD`, lokaler Default-Ref und Remote-Default-Ref zeigen auf
  denselben Terminal-Commit. Dieser Commit hat genau einen Parent; dessen
  committed State ist der exakte `Active/NeedsRevalidation/167/168`-Anker und
  der Terminal-State ist `Completed/168/168`. State und Tasks sind genau die
  Blobs des jeweiligen Commits, der Parent ist Ancestor des Terminal-Heads,
  Index und getrackter Worktree haben keinen undeliverten Diff und die
  Remote-Beziehung ist der nicht erzwungene Fast-forward. Runnerlokale,
  ignorierte Log-/Resultdateien bleiben außerhalb dieser Feature-/Gitprüfung.
- Unmittelbar vor der Antwort werden Statebytes/-hash, Tasks-/Payloadhash und
  lokale/remote Terminalrelation ein zweites Mal verglichen. Jede TOCTOU-
  Änderung führt ohne Writer in read-only Reconciliation.

Die Adoption implementiert Pfadcontainment, Symlink-/Reparse-Point-Abweisung,
direkte Git-Argumentarrays, geschlossene Enum-/Typprüfung und SHA-256 über
PowerShell/.NET. Python bleibt ausschließlich der bereits vorhandenen
repositoryeigenen Test-/Validatorfläche vorbehalten und wird keine neue
Produkt- oder Adoptionsabhängigkeit.

#### TA-007-Disposition

| Ebene | Disposition | Gate zur Schließung |
|---|---|---|
| Plan/Research | `Resolved by exact design` | Dieser Vertrag und Research-Entscheidung 13 sind vollständig; G4-/Providergrenzen bleiben unverändert. |
| Implementation | `Open - blocks G4 product work` | Installed Runner, Fixture, Tests, Hilfe/Manpage und lokale Parität sind umgesetzt; positive, definite-failure und uncertain-result Pfade bestehen. |
| Tasks/Analyze | `Open` | Tasks ordnet die Runnerkorrektur vor dem ersten G4-Produktedit ein, bewahrt insgesamt `T001..T168` und T165–T168, danach vollständiger Analyze-Lauf mit `0` Critical/High/unresolved Medium. |

Diese Disposition ändert weder die 18 Requirements noch die zehn
Acceptance-Gates, neun Provider-Operationsklassen, Rollbackklassen,
Account-Identitätsverträge oder den terminalen Fast-forward-Ablauf T165–T168.
Sie korrigiert ausschließlich den stale Parent-Write nach T168 und erteilt
keine GitHub-, Account-, Ruleset-, Subscription-, Budget-, Home-Sync-,
Position-7- oder sonstige Providerautorität.

## Projektstruktur / Project Structure

### Designartefakte dieses Features / Feature Design Artefacts

```text
specs/031-github-copilot-review-governance/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── autonomous-run-gate-requirements.json
├── contracts/
│   ├── desired-state.schema.json
│   ├── inventory.schema.json
│   ├── external-write-gate.schema.json
│   ├── mutation-plan.schema.json
│   ├── mutation-result.schema.json
│   ├── rollback.schema.json
│   ├── terminal-evidence.schema.json
│   └── provider-workflow-contract.md
└── tasks.md                         # erst durch /speckit.tasks
```

### Geplante Implementierungsflächen / Planned Implementation Surfaces

```text
scripts/
├── manage-copilot-review-governance.sh
├── manage-copilot-review-governance.ps1
├── modules/CopilotReviewGovernance.psm1
├── config/
│   ├── copilot-review-governance-desired-state.json
│   ├── home-sync-manifest.json
│   └── script-catalog.json
└── tests/
    ├── test_copilot_review_governance.py
    ├── run_copilot_review_governance_acceptance.py
    └── copilot-review-governance/fixtures/

.github/workflows/
└── copilot-review-governance-native-proof.yml

docs/
├── man/manage-copilot-review-governance.1.md
├── scripts/                            # aus Katalog gerenderte Referenz
├── architecture/copilot-review-governance.md
├── accessibility/copilot-review-governance.md
├── security/                           # bestehende Governancefamilie aktualisieren
├── project-statistics.config.json
└── project-statistics.md               # nur Rendereroutput
```

Der supporting Runner-Fix wird vor diesen G4-Flächen als eigene lokale
Delivery-Einheit umgesetzt:

```text
.specify/presets/autonomous-run-governance/
├── scripts/invoke-autonomous-model-phase.ps1
├── scripts/invoke-autonomous-model-phase.sh        # Delegation unverändert, Wrapperproof
├── tests/fixture-model-runner.ps1
├── tests/test-model-routing.ps1
├── tests/test-model-routing.sh                     # Bash-Wrapperproof
└── docs/man/invoke-autonomous-model-phase.1
```

Die bytegleichen lokalen Quellen unter
`specs/spec-kit-presets/autonomous-run-governance/` und
`specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/` werden
im selben repositorylokalen Change synchron gehalten und per `cmp` geprüft;
dies autorisiert weder eine Standalone-Preset-Veröffentlichung noch Matrix-,
Constitution-, Provider- oder Home-Sync-Änderungen. Die vorhandene
PowerShell-Comment-Help und die Manpage erhalten Adoptionsvoraussetzungen,
`runnerLocal`-Klassifikation, Reconciliation-Disposition und Exitverhalten.
Es entsteht kein neues Skript und damit keine neue Manpage. Shared Agent
Guidance und beide Constitutions bleiben `NoUpdateRequired`, weil die
Korrektur ihre bestehende Single-State-/Fail-Closed-Regel ausführt statt sie zu
ändern; dies wird im Implementierungsnachweis erneut semantisch geprüft.

**Strukturentscheidung / Structure decision**: Kein neues `src/` oder Projekt.
Das PowerShell-7-Modul auf .NET besitzt den gemeinsamen Produkt- und
Entscheidungskern mit Normalisierung, sicheren Provider-Argumentarrays,
Schema-/Semantikprüfung, Evidence-Publikation und Transaktionsmustern.
PowerShell-Skript/Cmdlet laden dieses Modul direkt; der Bash-Adapter startet
genau einen `pwsh -NoProfile`-Prozess. Python bleibt ausschließlich in den
repositoryeigenen Test-/Validierungshelfern und trifft keine Produktentscheidung.

## Implementierungs- und Nachweisphasen / Implementation and Proof Phases

0. **TA-007 Runnerkorrektur**: Bevor irgendeine G4-Produktdatei geändert wird,
   implementiert Tasks `TerminalAwareRunnerAdoption` im installierten Runner,
   Fixture und Routingtest, hält die zwei lokalen Quellen bytegleich, aktualisiert
   PowerShell-Hilfe/Manpage und führt die positive, definite-failure und
   uncertain-result Matrix direkt sowie über den Bash-Wrapper aus. Die
   Gesamtfolge bleibt `T001..T168`; T165–T168 und ihr Fast-forward-Protokoll
   bleiben unverändert und dürfen sich erst nach bestandenem Runner-Gate darauf
   verlassen.
1. **Pre-Implementation Gate**: Schemas, Sollvertrag und zehn stabile Gates
   semantisch reviewen und `Accepted` dokumentieren, bevor Code geändert wird.
2. **Repräsentativer Red-Slice auf macOS**: `home-baseline`-Fixture und Fake
   Provider beweisen zunächst fehlende Inventurpagination, Snapshotdrift,
   Browser-Evidence-Lücke, falsche Ruleset-ID und Write-Versuch im Preview als
   rot; Mutationszähler bleiben null.
3. **Grüner Kern-Slice**: gewünschter Acht-Vertrag, Inventory, Planer,
   External-Write-Gate, No-op/Update/Create/Disable, Resultat/Rollback,
   Redaction und Idempotenz machen denselben Slice grün. Danach erst Bash-
   Adapter, PowerShell-Skript-/Cmdlet-Oberfläche und User Output.
4. **Komplette lokale Matrix**: alle positiven/negativen Fixtures, API-/Browser-
   Grenzen, Usagekategorien, PR-Lifecycle, Security, A11Y, Agent Parity,
   bestehende G3/Stage-B-Regressions und Dokumentverträge.
5. **Native Plattformproofs**: macOS Safe Mode zuerst. Dann führt der eng
   berechtigte Workflow auf `ubuntu-latest` Bash und `windows-latest`
   PowerShell 7 gegen dieselbe Fixture aus. Jeder Record bindet exakten Commit,
   Befehl, Runner, Exitcode, Payload-/Entscheidungshash und null Writes; er ist
   kein Ersatz für Vollregression, Security-, A11Y- oder Reviewproof.
6. **Frische Live-Read-Inventur**: erst nach grüner lokaler Matrix; keine
   Mutation. Inventory- und Change-Plan-Hashes werden reviewt. Jede Abweichung
   vom historischen Snapshot blockiert bis zur neuen akzeptierten Change-Menge.
7. **Operationsspezifische Providerklassen**: Account-Disable, acht Lite-
   Einstellungen, `RulesetCreate`, `RulesetUpdate`, `RulesetDisable` und
   gegebenenfalls PR-Lifecycle/Manual-Review werden jeweils erst nach eigenem
   aktuellem External-Write-Gate serialisiert. Keine Ruleset-Klasse übernimmt
   Autorität oder IDs einer anderen. Ohne neue ausdrückliche Provider-Write-
   Autorität endet der Lauf korrekt `Blocked`.
8. **Abnahme und Dokumentation**: alle zehn Gates, Docs/Security/A11Y,
   Skriptreferenz, Manpage/Help, Statistikrenderer, Secret Scan, Supply Chain,
   Null-Drift-Zweitlauf und Position-7-Isolation.
9. **Repositorylieferung**: exakter Delivery Set, Commit/Push/PR, aktuelle
   Checks, exact-head Review, regulärer Mergeversuch, bounded bypass nur nach
   protection-only Refusal, Branch-Cleanup, Default-Sync und PostMerge-
   Validierung. Keine Provider-Settings-Autorität entsteht aus diesem Schritt.
10. **Home Runtime**: nur wenn der akzeptierte Merge tatsächlich
    manifestgebundene `homeRuntime` ändert; nach Merge zuerst Check/Preview,
    dann autorisierter Sync. Source-only-Änderung bedeutet `N/A`.

## Repräsentativer vertikaler Slice / Representative Vertical Slice

Der Slice verwendet `hindermath/home-baseline` als feste fachliche Identität,
aber ausschließlich einen Fake Provider und temporäre Evidence. Rotfälle
beweisen: fehlende Ruleset-Detailseite, `main`-Drift, falsche Repository-ID,
Browserwert `Unknown`, historisch abgeleitete Updateaktion und API-Write ohne
Gate. Der grüne Fall erzeugt aus einer frischen vollständigen Inventur exakt
eine `Update`- oder `NoOp`-Entscheidung, bindet Vorzustand/Desired/Rollback,
liefert bytegleiches Bash-/PowerShell-JSON und schreibt im Preview nullmal.

Der echte read-only `home-baseline`-Vertikalschnitt folgt erst danach. Eine
echte Mutation ist weder Bestandteil des Slices noch durch diese Planphase
autorisiert.

## Test- und Abnahmestrategie / Test and Acceptance Strategy

Ein einziger Aggregatorbefehl je Gate ist in
[autonomous-run-gate-requirements.json](autonomous-run-gate-requirements.json)
vor Implementierung festgeschrieben. Er prüft konkrete Unterbefehle statt
grüner Sammelnamen.

Vor dieser G4-Matrix belegt die Runner-Fixture deterministisch in einem
temporären lokalen Repository mit lokalem Bare-Remote genau diese Fälle:

| Fall | Erwartete Bindung |
|---|---|
| normale nichtterminale Phase | bisheriger Parent-Success-Write, korrekter Resultpfad/-hash und nächste Phase |
| exakte terminale Adoption | Child publiziert gültiges `Completed/168/168`; Statebytes/-hash bleiben nach Child exakt erhalten; kein Post-Child-Featurewrite |
| Result-Hash-, Result-Pfad- oder Identitätsmismatch | Nonzero Reconciliation-Disposition; Child-Disk-State bytegleich bewahrt |
| Child publiziert `Active` oder `NeedsRevalidation` | ungewisse Drift, kein Parent-Overwrite, ausschließlich read-only Fortsetzung |
| definitiver Child-Fehler ohne Drift | bisheriger atomarer Parent-Blocked-State und definite-failure Semantik |
| Exception/Catch nach Child-Drift | kein stale Catch-Write; exakte Diskbytes und Hash bewahrt |

`fixture-model-runner.ps1` erhält geschlossene Szenarioparameter und erzeugt
Resultat, State-/Tasks-Projektion sowie lokale Git-/Bare-Remote-Relation ohne
Netzwerk oder Provider. `test-model-routing.ps1` prüft neben Inhaltshashes auch
die vor/nach Child beobachteten Bytes und die Refs; `test-model-routing.sh`
beweist dieselbe Matrix über die Bash-Delegation. Success, definite failure und
uncertain result sind separate Assertions und dürfen nicht zu einem grünen
Sammelfall kollabieren.

Exakte Implementierungsverifikation:

```bash
bash -n .specify/presets/autonomous-run-governance/scripts/invoke-autonomous-model-phase.sh
bash -n .specify/presets/autonomous-run-governance/tests/test-model-routing.sh
pwsh -NoProfile -File .specify/presets/autonomous-run-governance/tests/test-model-routing.ps1
bash .specify/presets/autonomous-run-governance/tests/test-model-routing.sh
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
cmp .specify/presets/autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1 specs/spec-kit-presets/autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1
cmp .specify/presets/autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1 specs/spec-kit-preset-repos/spec-kit-preset-autonomous-run-governance/scripts/invoke-autonomous-model-phase.ps1
bash .specify/presets/autonomous-run-governance/scripts/validate-autonomous-run-state.sh --state specs/031-github-copilot-review-governance/autonomous-run-state.json
bash scripts/scan-agent-secrets.sh --fail-on-high .
git diff --check
```

Auf macOS laufen PowerShell-Direkttest und Bash-Wrapper zuerst. Derselbe
Bash-Wrapper läuft nativ auf Linux, der PowerShell-Direkttest nativ auf
Windows; jeder übertragbare Nachweis bindet Commit, Befehl, Runner/Plattform,
Exitcode und Fixture-/Entscheidungshashes. Diese Tests schreiben ausschließlich
in ein temporäres Repository und führen keine GitHub-, Account-, Ruleset-,
Subscription-, Budget-, Home-Sync- oder Position-7-Operation aus.

Die Planungsvertragsmatrix prueft `ExternalWriteGateAccountIdentityContract`
vor jeder Implementierung: Ein exaktes `AccountSetting`-Gate mit
`accountOwner=hindermath`, aktuellem Authority-Record, genau
`BrowserManual`, genau `PersonalCopilotSettings:write` und drei leeren
Repository-/Ruleset-/PR-ID-Arrays ist positiv. Negativ muessen fehlender oder
abweichender `accountOwner`, jede nicht leere Ziel-ID-Menge, `accountOwner` in
einer nicht accountbezogenen Klasse sowie jede Abweichung zwischen
AccountSetting-Plan, Gate, Resultat und Account-Rollback scheitern. Danach wird
die bestehende positive Minimalmatrix aller neun closed-world
Operationsklassen erneut ausgefuehrt; die Negativfaelle fuer Delivery-Methoden,
Ruleset-IDs, Settings-Scope und alle Closure-Nachweise `PR-001` bis `PR-012`
bleiben unveraendert gruen.

### Kanonische Gate-Befehlsmatrix / Canonical Gate Command Matrix

Jede Zeile bindet genau einen vollständigen ausführbaren Primaerbefehl. Exakt
diese ganze Zeichenfolge ist das einzige `requiredCommandTokens`-Element des
Gates; ein nicht ausgewertetes `requiredCommand`-Feld wird nicht verwendet.
Browser-Tokens erscheinen nur bei browsergebundenem Proof. `--check-only` bei
`AC-CRG-001` sowie `--dry-run` und `-WhatIf` bei `AC-CRG-009` sind Teil des
tatsächlichen Befehls. `MergeAndSync` bei `AC-CRG-010` bindet den aktuellen
Git-Liefermodus, nicht Provider-Write-Autorität.

| Gate | Validator-bound primary command | Runner/platform tokens |
|---|---|---|
| `AC-CRG-001` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-001 --check-only --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly`, `BrowserManual` |
| `AC-CRG-002` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-002 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly` |
| `AC-CRG-003` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-003 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly` |
| `AC-CRG-004` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-004 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly`, `BrowserManual` |
| `AC-CRG-005` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-005 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `GitHub`, `PRLifecycle` |
| `AC-CRG-006` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-006 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `GitHub`, `ManualReview`, `BrowserManual` |
| `AC-CRG-007` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-007 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `GitHub`, `Review` |
| `AC-CRG-008` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-008 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `GitHubReadOnly`, `BillingReadOnly` |
| `AC-CRG-009` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-009 --dry-run -WhatIf --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `Linux`, `Windows` |
| `AC-CRG-010` | `python3 scripts/tests/run_copilot_review_governance_acceptance.py --gate AC-CRG-010 --repository-root . --evidence-root .specify/runtime/autonomous-routing/1b7788fb-81f3-4d76-8006-885d834dd454/copilot-review-governance/evidence/v1` | `macOS`, `GitHubReadOnly`, `MergeAndSync` |

| Gate | Geplanter Kernproof / Planned core proof |
|---|---|
| AC-CRG-001 | vollständige paginierte Account-/Billing-/Repo-/Branch-/Ruleset-Inventur, getrennte Browser-Evidence, Frische und null Writes |
| AC-CRG-002 | Mengen- und Identitätsgleichheit exakt der acht Ziele nach autorisierter Konvergenz |
| AC-CRG-003 | jedes frisch bestätigte dedizierte Nichtziel disabled, vorhanden und rollbackfähig; kein Delete |
| AC-CRG-004 | achtmal Draft=false, Push=false und Browser-Lite |
| AC-CRG-005 | Ready-open/erstes Draft-to-Ready höchstens einmal, Push null; Providerrefusal getrennt |
| AC-CRG-006 | außerhalb der Acht keine Automatik; manuelle Reviewer-Verfügbarkeit bleibt getrennt belegt |
| AC-CRG-007 | Human-/CI-/Security-Gate-Map vor/nach unverändert; Copilot nie sole required |
| AC-CRG-008 | AI Credits, Copilot-Actions-Minuten und Auto/Manual-Trigger getrennt, redigiert, ohne Fixpreisclaim |
| AC-CRG-009 | exact-ID Apply/Rollback, TOCTOU, Reconciliation, Idempotenz und zweiter Null-Write-Lauf auf drei Plattformen |
| AC-CRG-010 | Serien-/Mutation-Allowlist beweist null Position-7-, Subscription-, Budgetkauf- und Cancellation-Aktion |

## Risiken und technische Schuld / Risks and Technical Debt

| Risiko / Risk | Behandlung / Treatment |
|---|---|
| Offizielle UI ohne Settings-API | Manuelle redigierte Browser-Evidence; kein DOM-Scraping als Wahrheit. Re-Evaluation bei offizieller API. |
| Effort-Level fehlt im Rulesetvertrag | Acht separate Browserwerte plus Review-Kommentar-Probe; API-Erfolg allein reicht nicht. |
| Gemischtes Ruleset enthält weitere Schutzregeln | `Blocked`; kein Deaktivieren, bis eine neue reviewte sichere Change-Menge vorliegt. |
| Providerpagination oder Schema driftet | Closed-world Validator und Link-/Seitenvollständigkeit; unbekannte Felder/Seiten blockieren. |
| PowerShell-Kern wächst | Domänenfunktionen im Modul bleiben rein, getrennt und fixture-getestet; Re-Evaluation bei unübersichtlicher Modulgrenze. Python-Helfer dürfen keine Produktentscheidung duplizieren. |
| UI-Evidence kann Personendaten enthalten | Nur abstrahierte Zustandsrecords versionieren; Rohscreenshots/Browserprofile `machineLocal`. |
| Teilmutation | Nach jeder Aktion atomarer Resultatstatus; Resume revalidiert Authority/IDs/Hashes; Rollback überschreibt keine Drift. |
| Child ändert State außerhalb exakter Terminaladoption | Disk-Snapshot bewahren, deterministic Reconciliation-Exit, Catch ohne stale Write; keine alternative Statequelle. |
| TOCTOU zwischen Terminalprüfung und Antwort | zweifache Byte-/Hash-/Ref-Prüfung, committed State-/Tasks-Blobs, sauberer Index/getrackter Worktree und fail-closed ohne Writer. |
| Runner-Fix driftet zwischen lokalen Kopien | Installed-, Scaffold- und Repository-Quelle bytegleich im selben lokalen Change; `cmp`-Gate vor G4-Produktarbeit. |

## Remote-Autoritätszuordnung / Remote Authority Mapping

| Operation | Oberfläche / Surface | Erforderliche Autorität / Required authority | Evidence |
|---|---|---|---|
| Provider-/Billing-/Repo-/Ruleset-Reads | `gh api --method GET` mit festen Argumentarrays | Read-only, least privilege; keine Write-Autorität | Inventory Snapshot |
| Accountautomation lesen/ändern | manuelle GitHub Copilot Settings UI | eigener aktueller Gate für `AccountSetting`; kein Cookieexport | Browser Before/After/Rollback |
| Effort-Level lesen/ändern | acht Repository Settings → Copilot → Code review | eigener aktueller Gate für `EffortLevel`; exakte Repo-IDs | acht Browser Records |
| Ruleset erstellen | `gh api ... --method POST --input FILE` | eigener Gate `RulesetCreate` für exakte Repository-IDs und Planhash | Mutation Result + neue ID |
| Ruleset ändern | `gh api .../{ruleset_id} --method PUT --input FILE` | eigener Gate `RulesetUpdate` für exakte ID und Vorzustand | Result + After + Rollback |
| Ruleset deaktivieren | `gh api .../{ruleset_id} --method PUT --input FILE` | eigener Gate `RulesetDisable` für exakte ID und Vorzustand | Result + After + Rollback |
| PR-Lifecycle-Test | `gh pr`/REST als explizite Testoperation | separates Gate; Kosten-/Cleanup-Scope | PR Lifecycle Evidence |
| Feature-Lieferung | `git` und `gh` | aktuelles `MergeAndSync`; Bypass nur nach protection-only Refusal | PreMerge/PostMerge |
| Home-Sync | vorhandene Sync-Skripte | nur nach Merge, Preview und manifestgebundenem Runtime-Diff | Home-Sync Result oder `N/A` |

## Dokumentationsauswirkung / Documentation Impact

**Entscheidung / Decision**: `UpdateRequired` — die einzige
Documentation-Impact-Entscheidung des Features.

- **Zielgruppen/Leserpfad**: Maintainer, Fleet Operators und Reviewer beginnen
  bei Zweck, Voraussetzungen, Authority-/Datenschutzgrenze und genau einer
  sicheren Preview-Aktion; danach Inventory → Sollvertrag → Browser/API-
  Grenze → Gate → Apply/Rollback → Usage → Fehler/Refusal → Closeout.
- **Kanonische Quelle/Owner**: Level 0 besitzt Soll-, Schema-, Skript-, Gate-
  und Betriebsvertrag; Fleet Governance Owner. GitHub-Livezustand bleibt
  externe Laufzeitwahrheit.
- **Betroffene Dokumente/Navigation**: README und `docs/README*`,
  `docs/scripts/`, Manpage, PowerShell-Hilfe, Architektur, Security, A11Y,
  Usage-/Rollback-/Incidentführung, Changelog/Closeout und Statistik. Für
  TA-007 werden zusätzlich die vorhandene Runner-Comment-Help und
  `docs/man/invoke-autonomous-model-phase.1` in allen drei lokalen Kopien
  synchron aktualisiert; Bash-Help verweist weiterhin auf diese Manpage.
- **Dokumentklasse/Sprache**: source-only Governance-/Betriebsvertrag, DE
  zuerst/EN danach auf CEFR B2; große Seiten erhalten nur bei besserer
  Orientierung synchronisierte `.en.md`-Partner.
- **Plattform-/Beispielnachweis**: Bash/macOS/Linux, PowerShell/Windows,
  gemeinsame Fixturehashes und getrennte manuelle Browser-Evidence.
- **Distribution**: Design, Docs, Schemas und redigierte terminale Evidence
  `sourceOnly`; manifestgebundene finale Skripte `homeRuntime`; Credentials,
  Cookies, Billingrohbelege, Browserprofile und operative Rohlogs `machineLocal`.
- **Home-Sync**: nur wenn der finale Merge den `homeRuntime`-Manifestumfang
  tatsächlich ändert; erst nach Preview und merged source. Diese Planphase
  synchronisiert nichts.
- **Generated output**: Statistik und Skriptreferenz werden nur über ihre
  kanonischen JSON-Quellen plus Renderer aktualisiert, nicht manuell editiert.
- **Evidence/Re-Evaluation**: Documentation-Impact-Evidence und semantische
  Review; erneut bei Zielmenge, UI/API, Billing, Authority, Plattform,
  Evidence-Schema, Distribution, Home Runtime oder Position-7-Grenze.

## Verfassungsprüfung nach Design / Post-Design Constitution Check

- **Security/Architecture**: Pass. Trust Boundaries, STRIDE+CIA/CAPEC,
  Least Privilege, TOCTOU, sichere Argumentarrays, Pfadschutz, Redaction,
  Supply Chain, Rollback und Providerfehlerklassen besitzen konkrete
  Artefakt-, Test- und Reviewpfade.
- **MSL/Scripting**: Pass. PowerShell/.NET ist der bindende primäre MSL-
  Produktkern; Bash ist die begründete vorhandene Unix-Oberfläche. Python ist
  nur repositoryeigener Test-/Validierungshelfer. Die nicht-MSL Zielprojekte `cc65`
  und `tvision` ändern keine Runtime; ihre Registry-Begründungen bleiben
  unverändert und bestehende Gates werden nur read-only geschützt.
- **A11Y/Bilingual**: Pass. Text-first Reihenfolge ist Repository → Branch →
  Zustand → Aktion → Ergebnis → Blocker → nächste sichere Aktion. Deutsch
  steht zuerst; visuelle Browserbelege werden durch lineare Textrecords ergänzt.
- **Cross-Platform**: Pass. Paired Scripts, Cmdlet, Manpage/Help, macOS-first
  Slice sowie native Linux-/Windows-CI-Proofs sind exakt geplant.
- **Agent/Intake/Autonomous**: Pass. Atomare Paritätsregel, accepted hashes,
  zehn stabile Gates, `MergeAndSync`, bounded bypass, External-Write-Gate und
  Position-7-Isolation sind vollständig und widerspruchsfrei.
- **Documentation/Statistics**: Pass. Genau eine Documentation-Impact-
  Entscheidung, kanonische Rendererquellen und bedingter Home-Sync sind festgelegt.
- **Offene Gates**: Keine semantische oder technische Planfrage. Providerwrite
  bleibt bewusst geschlossen, bis eine spätere Operationsklasse frische
  ausdrückliche Autorität und vollständige Gate-Evidence besitzt.

## Komplexitätsverfolgung / Complexity Tracking

Keine Verfassungsverletzung. Der PowerShell-7/.NET-Produktkern und die
vorhandenen Adapter-/Evidence-Muster werden wiederverwendet; Python bleibt auf
Test-/Validierungshelfer begrenzt. Browser-Evidence ist eine reale
Providergrenze und keine zusätzliche Anwendungsruntime.
