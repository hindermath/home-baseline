# Research: Preset Profile and Worktree Hardening

## Decision 1: Ein gemeinsamer Fleet-Freshness-Vertrag

Der bestehende Python-Flottenkern bleibt die einzige strukturierte
Entscheidungsstelle für Fetch, Default-Ref, Upstream, Ahead/Behind, Pull und
Bericht. Bash und PowerShell rufen denselben Vertrag auf, statt die
Klassifikation erneut auseinanderlaufend zu implementieren.

Ein Ziel wird auch bei Dirty, Detached, Branch- oder Upstream-Befund zuerst
soweit sicher möglich remote aktualisiert. Die Zustandsklassifikation bestimmt
danach, ob Pull und spätere Mutationen erlaubt sind. Die Bestandsaufnahme läuft
für alle folgenden Ziele weiter.

## Decision 2: Freshness ist eine globale Barriere

Lock, Log und atomarer Run-Report sind Kontroll-Evidence und dürfen vor der
Barriere entstehen. Home-Sync, Registry-Anpassung, Propagation,
Preset-Reparatur, Paketmanager und Toolchain sind Domainmutationen und bleiben
gesperrt, bis Level 0 und alle 43 aktiven Git-Ziele vollständig erfolgreich
klassifiziert sind. Die Collection wird separat read-only inventarisiert.

Diese Reihenfolge ersetzt die bisherige Orchestrierung, in der Level 0 und
Home-Sync vor dem Flottenvertrag lagen.

## Decision 3: Default-Branch ohne Namensheuristik

Die Reihenfolge lautet:

1. gültigen lokalen `refs/remotes/origin/HEAD` lesen;
2. sonst `git ls-remote --symref origin HEAD` read-only auswerten;
3. exakt den ermittelten Ref fetchen beziehungsweise nach dem Fetch prüfen;
4. symbolischen Namen, Tracking-Ref und Commit gemeinsam als Evidence binden.

`main`, `master` oder `trunk` werden nicht geraten. Fehlende, mehrdeutige oder
abweichende Evidence bleibt blockierend.

## Decision 4: Pull ist eine enge Konjunktion

Pull ist nur zulässig, wenn Arbeitsbaum und Index sauber sind, HEAD auf dem
kanonischen Default-Branch liegt, der Upstream eindeutig dazu gehört,
`ahead=0` und `behind>0` gilt. Der einzige erlaubte Aufruf ist Fast-forward.
Alle anderen Zustände bleiben lesbar inventarisiert, aber mutationsgesperrt.

## Decision 5: Lease statt breiter Worktree-Bereinigung

Jeder isolierte Preset-Prüf-Worktree erhält vor der Registrierung einen
atomaren Lease unter dem reservierten Home-Baseline-State. Der Lease bindet
Schema, Lauf, Prozessstart-Identität, Repository, Remote-Ref, Commit,
Worktree-Pfad und UTC-Zeit.

Recovery entfernt nur dann, wenn Lease, State-Pfad, Repository,
Git-Worktree-Registrierung und Prozesszustand zusammenpassen. PID-Existenz
allein genügt wegen Wiederverwendung nicht. Fremde oder unvollständige
Evidence wird erhalten und als Befund gemeldet.

## Decision 6: Cleanup-Autorität verfällt bei Zustandswechsel

Eine Kandidatenliste ist kein dauerhafter Löschauftrag. Nach Branchwechsel,
Commitwechsel, Worktree-Entfernung, Restore oder anderer relevanter
Zustandsänderung wird die Menge neu inventarisiert. Nur manifest- oder
leasegebundene einzelne eigene Pfade dürfen entfernt werden. `git clean`,
Reset, Stash und rekursives Löschen in Nutzer-Checkouts bleiben ausgeschlossen.

## Decision 7: Profile bleiben datengetrieben

Der Profilkatalog bestimmt die Preset-Konfiguration. Weder Shell noch Tests
setzen elf als feste Obergrenze voraus. Ein synthetisch erweitertes Profil
muss ohne Programmänderung auflösbar sein.

Registry-Konsistenz ist eine reine Prüfung: bekannte Nicht-MSL-Sprachen mit
`msl` sowie bekannte MSL-Sprachen mit unbegründetem `non-msl` erzeugen einen
Befund. Automatische Korrektur ist ausgeschlossen, weil kuratierte
Projektbegründungen Owner-Evidence benötigen.

## S-ADR-017-01: Freshness vor Domainmutation

**Context**: Teilweise aktuelle Remote-Refs können Home-, Registry- und
Toolchain-Schritte auf einer falschen Flottenbasis erlauben.

**Decision**: Alle sicheren Fetch-Versuche und die vollständige
Flottenklassifikation liegen vor jeder Domainmutation.

**Consequences**: Der Lauf kann länger bis zur ersten Mutation brauchen, kennt
dafür die gesamte Flotte und endet bei jedem Pflichtbefund fail-closed.

## S-ADR-017-02: Gemeinsamer Kern, plattformgerechte Adapter

**Context**: Eigenständige Bash- und PowerShell-Klassifikationen bergen
Semantikdrift.

**Decision**: Strukturierte Policy bleibt im Python-Kern; Shells steuern nur
plattformgerechte Aufrufe, Hilfe und Lifecycle.

**Consequences**: Fixture-Parität wird direkt messbar. Python 3 bleibt eine
bestehende Pflichtvoraussetzung.

## Arc42 Security View

- **Context boundary**: lokale Flotte, lokale State-Verzeichnisse und
  ausdrücklich deklarierte `origin`-Remotes.
- **Building blocks**: Orchestrator, Fleet Engine, Manifest/Profile Catalog,
  Git adapter, Lease store, atomic report.
- **Runtime sequence**: control evidence → recovery audit → all fetch attempts
  → classification/report → barrier decision → optional domain phases.
- **Deployment**: rein lokale CLI auf macOS/Linux/Windows; keine Server- oder
  Cloudkomponente.
- **Cross-cutting concepts**: least privilege, fail closed, atomic evidence,
  exact path ownership, no target-provider writes, text-first diagnostics.

## Threat and Risk Model

| Grenze / Risiko | STRIDE/CIA/CAPEC-Sicht | Mitigation | Restrisiko |
|---|---|---|---|
| Remote → Tracking Ref | Spoofing/Stale Evidence | symbolischer HEAD, Fetch-Resultat und Commit gemeinsam binden | Remote kann während des Laufs erneut fortschreiten; Exact-Head-Regel |
| Manifest → lokaler Pfad | Tampering/Path Escape | HOME-relative validierte Pfade, keine Symlink-Ziele | lokale privilegierte Manipulation bleibt möglich |
| PID → Lease Owner | Spoofing durch PID-Reuse | Prozessstart-Identität plus Repository-/Pfadbindung | Plattform liefert möglicherweise begrenzte Prozessmetadaten; dann nicht löschen |
| Worktree → Cleanup | Tampering/Data loss | reservierter State, Git-Registrierungsabgleich, exakte Freigabe | unklare Reste benötigen manuelle Prüfung |
| Früher Zielbefund → spätere Ziele | Denial of evidence | Audit läuft für alle Ziele weiter | mehrere Timeouts erhöhen Laufzeit; jeder Versuch bleibt begrenzt |
| Report → Mutation | Elevation of privilege | globale Barriere, atomarer Status, keine implizite Freigabe | Hardwareausfall bewahrt letzte vollständige Evidence |
| Registry → Governance | Tampering/Silent repair | read-only Konsistenzbefund, Hashvergleich | Owner muss echte Ausnahme später entscheiden |

## Rejected Alternatives

- Home-Sync vor der Flotte: verletzt die Freshness-Barriere.
- Dirty vor Fetch sofort beenden: lässt Remote-Tracking-Informationen
  absichtlich veraltet.
- Nur `main`/`master` als Fallback: schließt gültige Default-Branches aus und
  rät Governance.
- PID allein als Lease-Nachweis: unsicher bei Wiederverwendung.
- Globales `git worktree prune` oder `git clean`: zu breite Eigentumsgrenze.
- Feste Preset-Anzahl: altert bei optionalen Profilen.
- Automatische MSL-Korrektur: überschreibt kuratierte Projektentscheidung.
