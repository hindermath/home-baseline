# Lernenden- und A11Y-Vertrag für Presets und Lernreihen / Learner and A11Y Contract for Presets and Learning Series

## Zweck / Purpose

**DE:** Dieser Nachweis dokumentiert, wie die projektlokale Lernenden- und
Barrierefreiheitsbasis portabel in die elf Spec-Kit-Presets und verbindlich in
die Lernreihen übernommen wird. Die öffentlichen Presets schreiben keine
deutschen Ausbildungsberufe vor. Sie transportieren und prüfen stattdessen den
vom jeweiligen Projekt deklarierten Zielgruppenvertrag.

**EN:** This record documents how the project learner and accessibility
baseline is carried portably through the eleven Spec Kit presets and bound to
the learning series. Public presets do not mandate German training
occupations. They carry and validate the audience contract declared by each
project.

## Preset-Entscheidungen / Preset Decisions

| Preset | Entscheidung / Decision | Begründung / Rationale |
|---|---|---|
| Security Governance | `N/A` | Sicherheitsanforderungen bleiben anwendbar, verarbeiten aber keinen Zielgruppenvertrag. / Security requirements remain applicable but do not process the audience contract. |
| Architecture Governance | `N/A` | Architektur-Governance benötigt keine duplizierte Lernendenregel. / Architecture governance does not need a duplicated learner rule. |
| iSAQB Architecture Governance | `N/A` | Architekturdokumentation erbt die Projekt- und A11Y-Regel über Komposition. / Architecture documentation inherits project and A11Y policy through composition. |
| A11Y Governance | `Updated` | Definiert Zielgruppe, Vorwissen, erste Begriffserklärung und textorientierte Informationswege als portablen Vertrag. / Defines audience, prior knowledge, first-use explanations, and text-first information paths as a portable contract. |
| Cross-Platform Governance | `N/A` | Shell-Parität und Plattformnachweise ändern den Zielgruppenvertrag nicht. / Shell parity and platform evidence do not change the audience contract. |
| Agent Parity Governance | `Updated` | Erzwingt semantische Gleichheit des Vertrags auf allen Agenten- und Template-Flächen. / Enforces semantic parity across agent and template surfaces. |
| Intake Authoring Governance | `Updated` | Übernimmt den Vertrag aus dem Projektprofil in neue oder aktualisierte Intakes. / Carries the contract from the project profile into new or updated intakes. |
| Intake Review Governance | `Updated` | Prüft Zielgruppe, Vorwissen, Begriffe, Sprache, Lesbarkeit und textorientierte Information unabhängig. / Independently reviews audience, prior knowledge, terms, language, readability, and text-first information. |
| Intake Sequencing Governance | `Updated` | Hält Reihenfolge, Abhängigkeiten, Blocker, Status und nächste Aktion textorientiert verständlich. / Keeps order, dependencies, blockers, status, and next action understandable as text. |
| Autonomous Run Governance | `Updated` | Trägt den akzeptierten Vertrag durch Specify, Plan, Tasks, Implementierung und Retrospektive. / Carries the accepted contract through Specify, Plan, Tasks, implementation, and retrospective. |
| Parallel Autonomous Run Governance | `Updated` | Verhindert eine Abschwächung durch Worker-, Runner- oder Provider-Defaults. / Prevents workers, runners, or provider defaults from weakening the contract. |

## Lernreihen-Grenze / Learning-Series Boundary

**DE:** Die zentrale Basis, Startseite, Blueprint, Register und vier Vorlagen
sind verbindlich aktualisiert. Alle 44 aktiven Reihenwurzeln verweisen auf die
Basis. Einzelne Lernaufgaben erben sie über Reihenwurzel und Vorlage; eine
redundante Änderung jeder Lerneinheit ist nicht erforderlich.

**EN:** The central baseline, start page, blueprint, register, and four
templates are updated as binding sources. All 44 active series roots reference
the baseline. Individual units inherit it through their series root and
template; changing every unit redundantly is not required.

## Abnahme / Acceptance

- Alle elf Presets wurden geprüft; sieben erhalten rückwärtskompatible
  Patch-Releases, vier eine begründete `N/A`-Entscheidung.
- Der konkrete Home-Baseline-Vertrag nennt die drei Ausbildungszielgruppen ab
  dem 1. Lehrjahr.
- Die öffentlichen Presets bleiben projekt-, provider- und sprachneutral.
- Keine Preset-Installation erteilt Ausführungs-, Remote-, Merge-, Bypass-
  oder Provider-Berechtigung.
- Paketquellen und Publikationskopien sind bytegleich.
- Flottenprofile behalten die Prioritäten `10` bis `80`.

## Veröffentlichung / Publication

| Preset | PR | Release | ZIP SHA-256 |
|---|---:|---|---|
| A11Y Governance | `#3` | `v0.4.2` | `d567e09006edda98adf39d339e40adb4371c54ffa10c8f19040215ddabe72141` |
| Agent Parity Governance | `#3` | `v0.4.1` | `2075345087f56e0d687d911edfbbe05a64820f4cda4e23b6aeb8414e42593987` |
| Intake Authoring Governance | `#3` | `v0.2.1` | `372adcdf2ac90e28674a8238ecd984c4c31bfbdfca46ff17da25af5c916f0cde` |
| Intake Review Governance | `#3` | `v0.1.2` | `7f4004782edd3bb4b892a12e16d7d0be4ac1bb4aa902c9a2130cbf0204fa6a82` |
| Intake Sequencing Governance | `#2` | `v0.1.1` | `765421e464abe4a8e1a1cbd29d78b528bab347f5318880c0c6f177f41e2f0974` |
| Autonomous Run Governance | `#12` | `v0.3.3` | `6044bd2b08695de9fee13d243bb79f53c0cc23f3ab1608522ca3b5ee2d4c887c` |
| Parallel Autonomous Run Governance | `#7` | `v0.2.4` | `d1915be9b57b3060a79f916260953b48d0fdccaf14e5326880f20b948fc9674d` |

**DE:** Alle sieben PRs wurden als Merge-Commit abgeschlossen. Die Repositories
besitzen keine technischen PR-Workflows; null Kommentare und null Reviews
waren vorhanden. Der genehmigte enge Admin-Bypass wurde ausschließlich für die
Human-Approval-Regel verwendet.

**EN:** All seven PRs were completed with merge commits. The repositories have
no technical pull-request workflows; zero comments and zero reviews were
present. The authorized narrow admin bypass was used only for the human
approval rule.

## Paket-Smoke / Package Smoke

- Alle sieben versionierten GitHub-ZIPs bestehen `unzip -t`.
- Ein temporäres Spec-Kit-Projekt installiert alle elf Presets aus den
  versionierten ZIPs mit den Prioritäten `10`, `20`, `30`, `40`, `50`, `60`,
  `64`, `65`, `66`, `70` und `80`.
- `specify preset list`, `specify preset resolve spec-template` und
  `specify check` bestehen.
- Die repräsentativen Codex-Skills `speckit-intake-create`,
  `speckit-intake-review`, `speckit-intake-series-create`,
  `speckit-autonomous` und `speckit-parallel-autonomous` erscheinen jeweils
  genau einmal.
- Intake Authoring, Intake Review und Intake Sequencing bestehen ihre
  Bash-/PowerShell-Paritäts- und Negativfixtures. Die Parallel-Abhängigkeit
  zum Autonomous-Preset besteht.

## Flottenabschluss / Fleet Closeout

**DE:** Das optionale Elf-Preset-Profil wurde über 32 Level-1/2-PRs verteilt.
Zusammen mit Home Baseline sind 33 von 33 registrierten Repositories auf dem
Profil. Alle PRs hatten null Kommentare, null Reviews und null umsetzbare
Review-Threads. 119 Checks waren erfolgreich und vier planmäßige Jobs wurden
übersprungen. 226 Jobs wurden nachweislich vor dem ersten Arbeitsschritt wegen
GitHub-Billing oder Spending-Limits abgewiesen; 19 davon abhängige Matrix-Jobs
wurden abgebrochen. Diese Provider-Abweisungen wurden nicht als technische
Erfolge gewertet. Der genehmigte enge Admin-Bypass wurde nur nach dieser
Klassifizierung und bei fehlenden umsetzbaren Threads verwendet. Der native
`cc65`-Build bestand auf Linux und Windows.

**EN:** The optional eleven-preset profile was distributed through 32 Level
1/2 pull requests. Together with Home Baseline, 33 of 33 registered
repositories now use the profile. All pull requests had zero comments, zero
reviews, and zero actionable review threads. 119 checks succeeded and four
planned jobs were skipped. GitHub rejected 226 jobs before their first step
because of billing or spending limits; 19 dependent matrix jobs were
cancelled. These provider rejections were not counted as technical passes. The
authorized narrow admin bypass was used only after this classification and
with no actionable threads. The native `cc65` build passed on Linux and
Windows.

| Repository-Gruppe / Repository group | PRs | Merge-Commits / Merge commits |
|---|---|---|
| C64 | `c64-baseline#17`, `cc65#17` | `33874470`, `80f7c622` |
| DataGrip | `datagrip-baseline#18`, `InventarDb#17` | `9fc68d81`, `102ef0fb` |
| Rider | `rider-baseline#17`, `InventarWorkerService#42`, `TinyCalc#36`, `TinyPl0#48`, `TuiVision#124` | `1175e6e3`, `833b8e35`, `73bb85da`, `044a7ad7`, `13405be6` |
| Secure OrderDesk | `secure-orderdesk-baseline#15`, `secureorderdesk-csharp#16`, `-go#15`, `-java#15`, `-python#15`, `-rust#15`, `-swift#15` | `44ed91d4`, `fdc833dc`, `b4bf1b76`, `f0aff62e`, `c69d2767`, `357c1c94`, `c840d920` |
| Secure ServiceHarvester | `secure-serviceharvester#15`, `secureserviceharvester-csharp#16`, `-go#15`, `-java#15`, `-python#15`, `-rust#15`, `-swift#15` | `5e72e055`, `6023e962`, `590c7c27`, `e241aeea`, `e897b6b1`, `2e212042`, `76453a88` |
| Container | `container-images#15`, `absdd-image-sandbox#24` | `7b9ef552`, `61f861a5` |
| Secure CaseTracker | `secure-casetracker-baseline#15`, `securecasetracker-csharp#21`, `-go#20`, `-java#20`, `-python#21`, `-rust#20`, `-swift#20` | `13dfeb65`, `faead6e4`, `6898ef72`, `4a9eb02f`, `2b191e36`, `b45b7234`, `9fa759c4` |

**DE:** Nach dem Merge wurden alle 32 lokalen Checkouts auf ihren über
`origin/HEAD` ermittelten Default-Branch umgestellt, mit `fetch --prune` und
`pull --ff-only` aktualisiert und gegen den exakten Remote-Commit geprüft.
`cc65` verwendet dabei korrekt `master`; alle übrigen Repositories verwenden
`main`. Jeder Arbeitsbaum ist sauber. Die Prüfung mit
`spec-kit-intake-sequencing-governance-presets.json` bestätigt in allen 32
Repositories genau die elf erwarteten Presets.

**EN:** After merge, all 32 local checkouts were switched to the default branch
resolved through `origin/HEAD`, updated with `fetch --prune` and
`pull --ff-only`, and compared with the exact remote commit. `cc65` correctly
uses `master`; all other repositories use `main`. Every worktree is clean. The
check with `spec-kit-intake-sequencing-governance-presets.json` confirms exactly
the expected eleven presets in all 32 repositories.
