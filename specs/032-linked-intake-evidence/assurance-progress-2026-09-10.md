# Feature 032 – Exaktvertrag und Assurance T050–T066

## Ergebnis / Result

Der autorisierte lokale Slice T050 bis T066 ist abgeschlossen (`17/17`). Er
materialisiert den exakten TuiVision-Vertrag ausschließlich als Home-Fixtures
und Evidence und schließt die macOS-Quell-, Barrierefreiheits-, Sicherheits-
und Architektur-Gates des Home-Renderers ab. Feature 032 bleibt nach diesem
Slice mit `66/169` Tasks unvollständig; T067 bis T169 bleiben offen.

*The authorised local slice T050 through T066 is complete (`17/17`). It
materialises the exact TuiVision contract only as Home fixtures and evidence
and completes the Home renderer's macOS source, accessibility, security, and
architecture gates. Feature 032 remains incomplete at `66/169`; T067 through
T169 remain open.*

## TuiVision: getrennter exakter Read-only-Nachweis

Der TuiVision-Checkout blieb auf
`a58c202668209b3b0cf116bcc8a0b0c5d6ac5d9b`, Branch `main` synchron mit
`origin/main`, Status sauber. Das kanonische Manifest besitzt den normalisierten
SHA-256
`538d12fcc60cab96e5d70865a9ab9c31885634f3981e1c10dc2cd09d1ee2d2e7`.
Es gab dort null Writes.

| Komponente | Tatsächliches Ergebnis | Eigenständiges Gate |
|---|---:|---|
| Exakte Intake-/Featurezuordnungen 037–046 | `10/10` | Pass |
| Exakte geordnete Kanten | `6/6` | Pass |
| Bindungswerte | `true: 4`, `false: 2` | Pass |
| Jüngster Abschluss 046 an Position 10 | `1/1` | Pass |
| Separater `DeferredOptional`-Backlog, `active:false` | `1/1` | Pass |

Fünfzehn In-memory-Mutationen belegten jeweils den erwarteten eindeutigen
Blocker: vier Mapping-, fünf Edge-, zwei Recency/Count- und vier Backlogfälle.
Alle `15/15` Expected/Observed-Paare stimmen überein; kein Summenpass verdeckt
ein Teilgate. Der eingefrorene TuiVision-Fixturevertrag ist
`a292b6d07e6675affb1b5f98358cd3db2fde7b3668c6aca87499ae4cb9f2b457`.

*The exact mapping, edge, binding, recency, and backlog components passed
separately. All fifteen negative mutations observed their own expected blocker,
and the TuiVision repository remained read-only.*

## Home-Renderer, Accessibility und Diagnosegrenze

- Fünf linearisierte Referenzen prüfen Root, eine Kante, mehrere Kanten,
  vorhandenen Featurelink und den exakten No-Feature-Fallback in derselben
  Feldreihenfolge.
- Zwölf Referenzdiagnosen `LIE001`–`LIE012` enthalten stabilen Code, sicheres
  repositoryrelatives Subject sowie deutsche und danach englische Remediation.
- Bash und PowerShell escapen HTML-förmige nicht vertrauenswürdige Status- und
  Kantenwerte kontextuell als Entities und danach als Markdown. Nur der vom
  Renderer erzeugte `<br>`-Separator bleibt vertrauenswürdig und sichtbar.
- Die realen öffentlichen CLIs wurden mit einem synthetischen absoluten Pfad,
  Credential-Form und Steuerzeichen aufgerufen. Beide enden fail-closed mit
  `LIE003` und sicherer Remediation; weder Eingabewert noch privater Root oder
  PowerShell-Stack erscheinen in der Ausgabe.
- Beide öffentlichen Hilfen zeigen den Fünf-Spalten-Vertrag ohne privaten Pfad.
  Beide echten Safe-Mode-Aufrufe liefern `Current` und `writes=0`.

Die anwendbaren WCAG-2.2-AA-Kriterien 1.3.1, 1.4.1, 2.1.1, 2.4.6, 3.1.2,
3.3.1 und 3.3.2 sind für die Markdown-/CLI-Quellgrenze dispositioniert. Dies
war eine ehrliche Source-Order-/Linearisierungsprüfung. Kein benannter
Screenreader, keine Braille-Zeile und kein unabhängiger menschlicher
Accessibility-Review wurden ausgeführt; diese Grenzen bleiben offen.

*Five linear references and all twelve bilingual diagnostics pass in both real
test runners. The evidence applies only to the Markdown/CLI source boundary and
does not invent assistive-device or human review.*

## Sicherheit und Architektur

Der proportionale Renderer-Scope wurde gegen STRIDE und CIA, CAPEC-126 und
CAPEC-88, NIST SSDF PW.4/PW.5/RV.1 sowie CWE-20, CWE-22, CWE-78, CWE-79,
CWE-116 und CWE-209 geprüft. Es gibt kein Netzwerk, keine Authentifizierungs-
oder Autorisierungsentscheidung, keine neue Kryptografie, keine Produkt-API,
kein Image und keine neue Dependency. Der einzige Trust Boundary führt von
repositorylokalen, nicht vertrauenswürdigen Dateien über strikte Validierung in
eine In-memory-Projektion und lokale Markdown-Ausgabe.

Sechs messbare Architektur-Qualitätsszenarien decken Integrität, sichere
Diagnosen, lineare Verständlichkeit, Determinismus, Rollback und Paarwartbarkeit
ab. arc42 Section 8 ist durch Path Containment, Encoding, eindeutige
Proof-Auflösung, candidate-first Publication, atomaren Rollback und Idempotenz
dispositioniert. ADR/S-ADR bleibt `N/A`, weil Owner, Komponenten, externe
Schnittstelle, Deployment und Trust Boundary unverändert bleiben. Kommentare
erklären Warum, Randbedingung und Proof-Grenze.

## Ausgeführte Governance-Gates

| Gate | Ergebnis |
|---|---|
| `bash scripts/test-requirements-intake-governance.sh` | Exit 0 |
| `pwsh -NoProfile -File scripts/test-requirements-intake-governance.ps1` | Exit 0 |
| `bash scripts/scan-agent-secrets.sh --fail-on-high .` | Exit 0; `high=0`, `gitleaks_high=0` |
| Konfigurierter PSScriptAnalyzer 1.25.0 | Exit 0; 107 getrackte owned Dateien, null Error/Warning |
| Expliziter gleicher Analyzer für das ungetrackte PowerShell-Testskript | Exit 0; `1/1`, null Error/Warning |
| Dependency-Diff über Modul-/Paket-/Lock-/Projektflächen | Exit 0; Nullmenge |
| Fokussierter Diff-/LF-Check des T050–T066-Slices | Exit 0 |

Die vier durch die Registry benannten generierten PowerShell-Upstreamdateien
blieben vom getrackten Analyzer ausgeschlossen. Die explizite zusätzliche
Prüfung verhindert, dass dieser Ausschlussmechanismus das neue ungetrackte
owned Testskript übersieht. Die vollständige Maschinen-Evidence liegt in
`governance-macos.json` unter dem akzeptierten ignorierten Evidence-Root.

*All configured local governance gates passed. The untracked owned PowerShell
test received its own analysis with the same pinned analyzer and settings.*

## Lock-Lineage, Dokumentation und Statistik

Die T057–T066-Änderungen invalidierten den T049-Lock regelkonform, bevor eine
Downstream-Adoption begonnen hatte. Der frühere Hash bleibt historische
Evidence, wird aber nicht als aktuell dargestellt. Der revalidierte
Level-0-Vertrag bindet 13 aktuelle Quellen, acht unveränderte akzeptierte
Artefakte und neun Gate-Evidence-Dateien:
`5072efab2c7a4f56eaefb2cbde2586ae2354f82db223096fdee3d91a4c323aca`.
Die beiden öffentlichen Wrapper sind nun ausdrückliche Source-Member.

Es bleibt genau eine Documentation-Impact-Entscheidung: `GeneratedUpdate`.
Renderer und Wrapper sind `homeRuntime`; Feature-Fixtures, Locks, Governance-
Dokumente, Checklisten, Bericht und Statistikquelle sind `sourceOnly`. Kein
Home-Sync wurde ausgeführt.

Statistik-Slot 81 bindet 676 Nettozeilen aus den seit dem akzeptierten
T049-Lock neu erstellten oder fachlich geänderten Implementierungs-, Fixture-
und Governance-Dokumentationspfaden. Task-, Phasenresultat-, Runtime-Evidence-
und Statistikbuchhaltung sind nicht eingerechnet. Der ausschließlich
ausgeführte Check-only-Renderer meldete erwartungsgemäß `DRIFT`, Exit 1,
`changed=true`, Methodik 2, 656.193 Textzeilen und 105 sichtbare Aktivtage. Der
Dirty-Tree-Guard wurde nicht umgangen und das generierte Ledger nicht verändert.

*The refreshed Level-0 lock records explicit lineage from the invalidated T049
hash. The single documentation decision remains `GeneratedUpdate`. Statistics
source is prepared, while the generated ledger honestly remains open behind
the clean-worktree gate.*

## Grenzen und nächste zulässige Arbeit

- Native Linux-/Windows-, Exact-Head-, unabhängige Human-Review- und
  Statistik-current-Gates bleiben offen; dieser Slice etikettiert sie nicht
  als `Completed` oder `N/A` um.
- PR 279 wurde in diesem Slice weder integriert noch getestet. T067 und spätere
  Tasks besitzen ausschließlich diese spätere Autorität.
- Es gab keine Downstream-Mutation, kein Staging, keinen Commit, Push, PR,
  Merge, Presetwechsel, Home-Sync oder Subagentenlauf.
- `autonomous-run-state.json` blieb im exklusiven Besitz des Parents und wurde
  nicht geschrieben. Historische hashgebundene Reports blieben byteidentisch.

Die nächste zulässige Aufgabe ist T067; diese Phase hat sie nicht begonnen.

*All later delivery, native-platform, independent-review, statistics-current,
PR 279 integration, downstream, and fleet gates remain open. The next allowed
task is T067, which this phase did not start.*
