# Begrenzter Dokumentations-Patch-Rollout / Bounded documentation patch rollout

## Stand und nächste Aktion / Status and next action

DE: Alle 14 neuen regulären Patch-Releases sind veröffentlicht und anhand
ihrer tatsächlichen Tag-Archive geprüft. Level 0 ist nur ein installierter
Arbeitskandidat: Der neue Rollout-PR benötigt noch fachliche Sichtung und
grüne Checks. Home Runtime und die drei Piloten wurden nicht aktualisiert.
Veröffentlichte Quellen sind nicht automatisch ausgelieferte Verbraucher.

EN: All fourteen new regular patch releases are published and verified using
their actual tag archives. Level 0 is an installed working candidate only:
its new rollout PR still needs human review and green checks. Home Runtime
and the three pilots have not been updated. Published sources do not imply
consumer delivery.

| Ziel / Target | Stand / State | Nächste Aktion / Next action |
|---|---|---|
| Level 0 | PreparedForReview | Exakten neuen PR-Head sichten / review exact new PR head |
| Host Home Runtime | Pending | Erst nach Level-0-Merge und grüner Merge-CI / after Level-0 delivery and green merge CI |
| TinyCalc | Pending | Bestehenden PR #117 fortschreiben; private Datei erhalten / update existing PR #117; preserve private file |
| Show-CommandTui400 | Pending | Neues sauberes Rollout-Worktree / new clean rollout worktree |
| absdd-image-sandbox | Blocked | VM-Start endet mit EOF; gezielte Diagnose separat beauftragen / VM start fails with EOF; separately authorize targeted diagnosis |

DE: Der genehmigte einmalige Start von `podman-machine-default` endete mit
Exitcode 125 und `Error: EOF`. Die VM blieb gestoppt; kein Containerstart,
Pull, Neuaufbau, Reset oder Eingriff in Volumes. Die Ursache ist nicht belegt.
EN: The authorized start of the existing VM returned exit 125 and `Error: EOF`.
It remained stopped. No container start, pull, rebuild, reset or volume change
occurred. The underlying cause has not been established.

## Veröffentlichte Kohorte / Published cohort

DE: Vollständige Tag-/Commit-/Archivbindungen stehen zusätzlich im
[maschinenlesbaren Bericht](preset-documentation-rollout-2026-10-24.json)
und im [Source-Lock](preset-source-lock.json). Alte Tags und ZIPs bleiben
unverändert. Der globale Acht-Preset-Default und alle Prioritäten bleiben gleich.
EN: Full tag, commit and archive bindings also appear in the linked JSON and
source lock. Previous tags and ZIPs remain unchanged. The global eight-preset
default and all priorities are unchanged.

| Preset / Release | Version | Lieferung / Delivery | Commit | ZIP SHA-256 |
|---|---|---|---|---|
| [security-governance](https://github.com/hindermath/spec-kit-preset-security-governance/releases/tag/v0.7.4) | 0.7.4 | [PR](https://github.com/hindermath/spec-kit-preset-security-governance/pull/12) | `16666d7c1f54aafa929c158d4bcdcb03bace1564` | `222697829118be22c6ddf6675852f1375dbb415061e5fe2fd31a5c82d65a5dcb` |
| [architecture-governance](https://github.com/hindermath/spec-kit-preset-architecture-governance/releases/tag/v0.6.5) | 0.6.5 | [PR](https://github.com/hindermath/spec-kit-preset-architecture-governance/pull/14) | `5d02e804c4fc617fbf17bd34900c53fccbc81e60` | `5d7151a1dadf36684f4f0f754b6630f51ff3bbcbbf11414e7537d855ca87e56c` |
| [isaqb-architecture-governance](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/releases/tag/v0.2.5) | 0.2.5 | [PR](https://github.com/hindermath/spec-kit-preset-isaqb-architecture-governance/pull/9) | `1bf9b5c72f8a39c570e8596e78ceac6b855af20b` | `03f1a946994ece3c30b0da3a733eb7c5eb88c8a65021831e75cf5543fed65d58` |
| [a11y-governance](https://github.com/hindermath/spec-kit-preset-a11y-governance/releases/tag/v0.4.6) | 0.4.6 | [PR](https://github.com/hindermath/spec-kit-preset-a11y-governance/pull/9) | `55b88a8d7be6586f5ef54e172742b1eb351bc5fe` | `150cc5c1709d0bc6e9f682badb510922595cd784299ff3d9a9c17389919ec89f` |
| [cross-platform-governance](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/releases/tag/v0.2.5) | 0.2.5 | [PR](https://github.com/hindermath/spec-kit-preset-cross-platform-governance/pull/8) | `9718ffa54f55fc63652abc92da85d1d558ee6029` | `eeb88517330858ceae706d35d79bb7ff04e7c37f1f17faf66159eb7e4d917cdc` |
| [agent-parity-governance](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/releases/tag/v0.4.5) | 0.4.5 | [PR](https://github.com/hindermath/spec-kit-preset-agent-parity-governance/pull/9) | `005efa0c62e4c80a04fdab8712debc048f48754d` | `2c730ad78a0dcc03893523e417c37f0be93754f888efd85739ab12001eb4eb11` |
| [model-routing-governance](https://github.com/hindermath/spec-kit-preset-model-routing-governance/releases/tag/v0.1.7) | 0.1.7 | [PR](https://github.com/hindermath/spec-kit-preset-model-routing-governance/pull/11) | `f5b86800ed5058dd0efb1a3e70b39f47b12c0753` | `79bbde5a52f1842fa02aea01532c9ba04922531b0ddd4ab46aff08e9e5ead204` |
| [intake-authoring-governance](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/releases/tag/v0.3.10) | 0.3.10 | [PR](https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/20) | `b4ddd5580277edb008132149ca5870b64c2dd68a` | `878f5c767360d623b3b3cccfd3fd01caa92298b9785f10da99d229329b45b10d` |
| [intake-review-governance](https://github.com/hindermath/spec-kit-preset-intake-review-governance/releases/tag/v0.2.7) | 0.2.7 | [PR](https://github.com/hindermath/spec-kit-preset-intake-review-governance/pull/15) | `e3ba5ffee691612568396c0074ef0b573c82709e` | `c2cd56a09676d7fe0859c030680f223575ba0bf89dde872058e6f36066d4eab0` |
| [intake-sequencing-governance](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/releases/tag/v0.2.11) | 0.2.11 | [PR](https://github.com/hindermath/spec-kit-preset-intake-sequencing-governance/pull/17) | `fa7ae29dced61da7cf8b255d351d5d8f5ea1e432` | `ddbea4dac1b21137700b31e7d9ef6e4bfff6fe4608506c07b522c433811c5164` |
| [autonomous-run-governance](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/releases/tag/v0.4.7) | 0.4.7 | [PR](https://github.com/hindermath/spec-kit-preset-autonomous-run-governance/pull/27) | `f5e5ae162b2309f35b91bece1a303ea4091ab364` | `5a9ed42d7f0caa9f65e2b9b3285dcf48e54372d54fa194109fce7e80334d8999` |
| [parallel-autonomous-run-governance](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/releases/tag/v0.2.9) | 0.2.9 | [PR](https://github.com/hindermath/spec-kit-preset-parallel-autonomous-run-governance/pull/16) | `b39ec31994aeb4f4c793808540ab55d1e2d0577b` | `e87ff1b325f5fff16a4e2c2fa805078620636044b53bba2f08bc9e7632ea866c` |
| [project-statistics-governance](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/releases/tag/v0.1.3) | 0.1.3 | [PR](https://github.com/hindermath/spec-kit-preset-project-statistics-governance/pull/10) | `e1e81b5c7c778314945539083b8aac557798e36c` | `6b963051c619b65e692247ced30997823e15feae82526ec69481c8e99df6cb32` |
| [secure-development-assurance-governance](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.8) | 0.1.8 | [PR](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/pull/13) | `100ff9e6e037b0d162bdadd8bfd0bf30520ff7b6` | `bce2969fa25b8753199ef40730037fedc7689971e6a54cc3a9da4ef0f64762dc` |

## Ausgeführte Prüfungen / Executed checks

- DE: Alle 14 tatsächlichen Tag-Archive heruntergeladen; 660 Originaldateien
  gegen die geprüften Quellstände verglichen. Einzelinstallationen, `list`,
  `info` und 145 Vorlagendeklarationen geprüft. Gemeinsame Installation mit
  exakter Bash-/PowerShell-Matrix und 49 stabilen Command-Deklarationen besteht.
  EN: Downloaded all fourteen real archives; compared 660 original files with
  reviewed sources. Individual installs, list, info and 145 template declarations
  pass. Combined installation passes both shell matrices and 49 command declarations.
- DE: Alle nativen PR-Prüfungen vor Quellen-Merge grün; keine offenen
  Review-Threads. Assurance und Statistik besitzen erfolgreiche Merge-CI.
  Andere Quellen lösen gemäß Workflow-Konfiguration keine Push-CI aus;
  `NotTriggeredByConfiguration` ist kein behaupteter Test-Pass.
  EN: Native source PR checks passed before merging, with no unresolved threads.
  Assurance and statistics merge CI passed. Other sources do not trigger push
  CI by configuration; absence of a run is not a test pass.
- DE: Der unveränderte Mindestkombinationstest von Assurance prüft ausdrücklich
  Model Routing 0.1.5 und Autonomous 0.4.5: 44 Prüfungen bestanden. Die neue
  Kombination 0.1.7/0.4.7 wurde getrennt mit denselben Assertions und nur explizit
  eingefrorenen Versionsparametern geprüft: ebenfalls 44 bestanden. Das
  veröffentlichte Mindesttestskript bleibt unverändert.
  EN: The unchanged packaged minimum test targets routing 0.1.5 and autonomous
  0.4.5: forty-four passes. A separate frozen-current test retains assertions,
  changes only explicit version parameters and accepts an explicit evidence
  root: forty-four passes for 0.1.7/0.4.7. The published test is unchanged.
- DE: Lokale Dokumentations-/Release- und einschlägige Preset-Tests bestanden.
  42 gerenderte Leserpfade ergänzen die semantische Prüfung. Dies ist keine
  vollständige B2-, Screenreader-, Braille- oder WCAG-2.2-AA-Abnahme.
  EN: Relevant local documentation, release and preset suites passed. Forty-two
  rendered reader paths supplement semantic review, not full language or
  assistive-technology accessibility acceptance.

## Installation und Komposition / Installation and composition

DE: Die eingebettete Skriptreferenz wurde nach Vorschau aus dem bestehenden
Katalog neu erzeugt; sie führt jetzt die zusätzlich veröffentlichten
Release-Status-Tests auf. Keine Änderung an der Katalogmethodik.
EN: The embedded-script reference was regenerated after preview using the
existing catalog. It now includes the additional released status tests;
catalog methodology is unchanged.

DE: Der aktuelle Installed-Lock bindet die tatsächlich geprüfte Installation,
nicht nur ein Versionsziel. Fünf bereits vorhandene Home-only-Runner-Dateien
bleiben byte-identisch und sind separat gebunden. Sie gehören nicht in Piloten.
Private Routing-Profile wurden nicht erneuert oder migriert.
EN: The installed lock binds the real verified installation rather than a
version target. Five existing Home-only runner files remain byte-identical
and separately bound; they must not enter pilots. Private routing profiles
were neither refreshed nor migrated.

DE: Die SDK-Neuregistrierung erzeugte bei unveränderten Command-, Markdown-
Template-, Routing- und Projekt-Core-Eingaben unvollständige Ableitungen mit
`{CORE_TEMPLATE}`. Deshalb wurden ausschließlich die bereits vorher vollständig
geprüften neun Agenten-Ableitungen aus Basis `bd84dd7e` bytegetreu übernommen.
Die neuen Pakete und Registry bleiben installiert. Der unveränderte
Paritätstest besteht danach mit 9/9. Diese Übernahme gilt nur für nachweislich
identische semantische Eingaben; bei künftigen Command-Änderungen stoppt sie.
Es gab keine SDK-Änderung, Validator-Abschwächung oder Integration-Migration.
EN: SDK re-registration produced incomplete derived surfaces although command,
Markdown-template, routing and project-core inputs were unchanged. Only nine
previously validated generated agent surfaces were inherited byte-for-byte
from base bd84dd7e. New packages and registry remain installed. The unchanged
parity suite then passes nine of nine tests. This inheritance is limited to
proven identical semantic inputs; changed command inputs must stop it. Neither
the SDK nor validators nor integration layout were changed.

## Technische Evidence und Grenzen / Technical evidence and limits

DE: Der zusätzliche vollständige Level-0-Test `test-preset-sources.ps1`
ist lokal noch nicht abgeschlossen: Zwei Versuche scheiterten beim lesenden
Git-Remote-Abruf mit Verbindungstimeout, einmal bei Intake Review und einmal
bei Architecture. Das ist kein Pass. Die gesonderten Paketprüfungen oben
bleiben belegt; dieser Gesamtcheck muss vor Lieferung erfolgreich nachgeholt
werden, beispielsweise durch die native PR-CI. Dokumentationsarchitektur:
2/2 lokale Prüfungen bestanden.
EN: The additional full Level-0 source test has not completed locally. Two
read-only remote queries timed out, for Intake Review and Architecture.
Neither attempt is a pass. The separate package proofs above remain valid;
this aggregate test must pass before delivery, for example in native PR CI.
Two local documentation-architecture checks passed.

DE: [Eigener aktueller Kontext](../security/secure-development/2026-10-24-home-baseline-documentation-patch-rollout/evidence-matrix.md)
erhält historische Evidence und menschliche Entscheidungen. Baseline, Delta,
Closure und Image impact werden getrennt geprüft. Technisches Ready erteilt
keine Produkt-, Risiko-, C5-, Konformitäts- oder Zertifizierungsfreigabe.
Die beiden Intake-Metadatenkorrekturen halten Schema und Berechtigungen gleich;
bisher gültige Receipts bleiben gültig, unbekannte Versionen blockieren weiter.
EN: The separate linked context preserves historical evidence and human
decisions. Its four gates are checked separately. Technical Ready does not
grant product, risk, C5, conformity or certification approval. Two authorized
intake metadata corrections retain schemas and permissions; valid older
receipts remain valid and unknown versions still block.

DE: Frühere Fehlversuche wurden nicht als Pass gewertet: ein Mindestversionstest
mit falscher aktueller Kombination, der zunächst falsche BOM-Vergleich des
temporären Lock-Renderers und ein GitHub-Verbindungstimeout. Der Renderer wurde
korrigiert; der unveränderte kanonische Hash-/Paritätstest besteht danach.
Keine Modellaufrufe, neue Routing-Entwicklung, Stufe B/C, Toolchain-Wartung,
Community-Einreichung oder weiterer Flotten-Rollout.
EN: Earlier failed attempts are not passes: an inapplicable minimum-cohort
invocation, the temporary lock renderer's initial BOM comparison bug and a
GitHub timeout. The renderer was corrected and unchanged canonical hash/parity
tests pass afterwards. No model calls, new routing development, B/C stage,
maintenance, community submission or wider fleet rollout occurred.

DE: Documentation Impact: `UpdateRequired` für aktuelle Anleitung/Quellenbindung,
`GeneratedUpdate` für Installation und Statistik. Zielgruppe sind die vier
IHK-IT-Berufe samt vier Fachinformatik-Fachrichtungen sowie Entwickelnde ohne
Spezialwissen. Deutsch zuerst, gleichwertiges Englisch, B2 und anwendbare
WCAG 2.2 AA bleiben Qualitätsziele. Die vorliegenden technischen Prüfungen
ersetzen keine gesonderte menschliche Abnahme.
EN: Documentation impact separates current instructions/source bindings from
generated installation/statistics. Audiences are all four IHK IT occupations,
all four IT-specialist disciplines and developers without specialist knowledge.
German first, equivalent English, B2 and applicable WCAG 2.2 AA remain targets,
not acceptance inferred from static checks.
