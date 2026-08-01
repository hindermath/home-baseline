# Dokumentations-Informationsarchitektur-Audit

## Ergebnis

Der read-only Audit ist mit dem Status `ReadyWithFindings` abgeschlossen. Er
bindet alle Entscheidungen an den eingefrorenen Git-Baum
`4c19093692542ff5001819f9ba2d17a1a1a5d4d7`; spätere Feature-Dateien sind
bewusst nicht Teil des untersuchten Bestands.

| Nachweis | Ergebnis |
|---|---:|
| Dokumentationseinheiten | 2.624 |
| Explizit ausgeschlossene Nicht-UTF-8-Evidence | 1 |
| Leserpfade | 4 |
| Wartungsverträge aus Features 015 bis 019 | 23 |
| Source-/Runtime-Klassen | 3 |
| Findings | 1 |
| D5 / D6 / D7 | 1 / 0 / 0 |

`windows-test-output.txt` ist eine getrackte, generierte UTF-16-Testausgabe.
Sie ist kein aktives UTF-8-Dokument. Der Audit schließt ausschließlich diese
Datei über ihren Roh-SHA-256 aus. Eine unbekannte Binär- oder
Nicht-UTF-8-Datei würde die Erhebung weiterhin blockieren.

## Inventar und Entscheidungen

| Artefaktklasse | Anzahl | Primäre Behandlung |
|---|---:|---|
| `ActiveSemantic` | 830 | Semantisch aktive Dokumentation |
| `AgentSurface` | 981 | Agenten-, Skill-, Command- oder Preset-Oberfläche |
| `Archived` | 142 | Unveränderte historische Evidence |
| `Generated` | 4 | Änderung nur über kanonische Quelle und Renderer |
| `IntakeEvidence` | 667 | Anforderungen, Receipts, Reviews und Feature-Evidence |

Die primären Entscheidungen sind `KeepAsIs` für 2.477 Einheiten,
`ArchiveOnly` für 142 Einheiten, `GeneratedFromSource` für vier Einheiten und
`SplitByTopic` für die Root-README. Jede Einheit besitzt genau eine Klasse und
eine primäre Entscheidung.

## Leserpfade

| Leserpfad | Status | Einstieg und sichere nächste Aktion |
|---|---|---|
| Lernende | `Pass` | `README.md` und `docs/learning-units/START-HERE.md`; danach der ausgewählten Lernreihenfolge folgen |
| Tägliche Nutzung | `Gap` / `DIA001` | Root-README; vor schreibender Wartung Vorschau oder `--check-only` verwenden |
| Maintainer und Agenten | `Gap` / `DIA001` | `AGENTS.md` und Root-README; ausschließlich die kanonische Level-0-Quelle ändern |
| Audit und Fehlersuche | `Pass` | Feature-Evidence und Statistik; vor Wiederverwendung den exakten Head erneut prüfen |

Der Lernpfad ist bereits über `START-HERE.md` begrenzt. Für tägliche Nutzung
und Wartung bleibt die Root-README jedoch zu breit: Sie verlangt Navigation
durch Inhalte für vier unterschiedliche Rollen.

## Finding DIA001

**Schweregrad:** `Medium`  
**Owner:** `DocumentationArchitecture`  
**Nachfolger:** `D5`

Die bilinguale Root-README umfasst 3.683 Zeilen und verbindet Einstieg,
tägliche Bedienung, Wartungsinternas, Architektur, Auditmaterial und
Referenzlinks auf einer primären Seite. Das ist kein Produktfehler. Es erhöht
aber das Risiko, dass Lernende und tägliche Nutzende den sicheren ersten
Schritt oder Maintainer die kanonische Bearbeitungsgrenze übersehen.

D5 soll deshalb einen knappen Root-Einstieg und topic-orientierte Leserpfade
erstellen. Normative Quellen, bestehende Anker, Deutsch-zuerst/Englisch-danach,
WCAG 2.2 AA und textorientierte Nutzung müssen erhalten bleiben. Eine getrennte
englische Begleitdatei ist nur zulässig, wenn Ownership, Synchronisation,
Linkprüfung und Driftkontrolle vollständig definiert werden.

D6 und D7 erhalten keinen Auftrag: Der Audit fand weder einen eigenständigen
Effizienzleitfaden-Fehler noch einen belegten Flotten-Adoptionsbedarf.

## Wartungsverträge

Alle 23 Verträge besitzen Entscheidungen für Root-README, Manpage,
Architektur, Barrierefreiheit, Sicherheit, Skriptreferenz und
Feature-Vertrag. Es bestehen keine Critical- oder High-Widersprüche.

- Feature 015: Windows-Vorschau sowie Ergebnis- und Resume-Autorität.
- Feature 016: Eingabeisolation, Ergebnisaggregation und Exact-Head-Evidence.
- Feature 017: Remote Freshness, sichere Pull-Klassen, Netzwerk-Evidence,
  Worktree-Leases, Bereinigungsgrenze und dynamische Profile.
- Feature 018: Enhanced/Plain/Headless, Vorschau, Default-No, JSONL,
  Unterbrechung, Fallback und kanonisches Ergebnis.
- Feature 019: JSONL-Kontinuität, Report-Ownership, frühe Finalisierung,
  Ergebnisabgleich und Bash-3.2-Delegation.

Der Audit beweist die Konsistenz der veröffentlichten Aussagen mit den
akzeptierten Feature-Verträgen. Er führt keine mutierende Wartung aus und
ersetzt keine Plattform- oder Provider-Gates.

## Source, Runtime und lokaler Zustand

| Klasse | Einheiten | Kanonischer Umgang |
|---|---:|---|
| `homeRuntime` | 240 | In Level 0 ändern, nach Merge kontrolliert zum Host synchronisieren |
| `sourceOnly` | 2.138 | Direkt im versionierten Level-0-Klon lesen und über Review ändern |
| `machineLocal` | 246 | Mit dem besitzenden lokalen Tool pflegen; private Zustände nicht veröffentlichen |

Der Validator gleicht jede der 2.624 Einheiten mit genau einer dieser Klassen
ab. Die Home-Kopie ist Laufzeitverteilung, nicht kanonische Quelle. Lokale
Commits dienen Audit und Wiederherstellung und erteilen keine Remote-Autorität.

## Governance und Proof-Grenze

Zehn anwendbare Presets sind mit `Pass` bewertet. Parallel Autonomous ist für
diese bewusst serielle Serie begründet `N/A`. Agentenflächen und
`.specify/templates/` wurden inventarisiert, aber nicht geändert. Es entstand
kein reproduzierbarer providerneutraler Preset-Defekt; die spätere
Retrospektiventscheidung ist daher `NoPromotion`.

Collector und Validator beweisen Git-Identität, normalisierte Hashes,
Vollständigkeit, Kardinalität, Klassen, Entscheidungen und Referenzen. Sie
beweisen nicht automatisch, ob Prosa didaktisch verständlich ist oder eine
Sprachtrennung fachlich nützlich bleibt. Diese semantischen Aussagen sind die
dokumentierte Review-Entscheidung und werden in D5 erneut geprüft.

## English Summary

The read-only audit is `ReadyWithFindings`. It covers 2,624 documentation units,
four reader paths, 23 maintenance contracts, and all three source/runtime
classes at the frozen pre-feature commit. One medium finding, `DIA001`, routes
to D5: the 3,683-line bilingual root README mixes four reader roles and should
become a concise portal with topic-oriented paths. No evidence justifies D6 or
D7 work. The validator proves identity, hash, cardinality, classification, and
cross-reference integrity; pedagogical clarity remains a semantic review duty.
