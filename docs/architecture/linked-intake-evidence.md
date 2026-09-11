# Architektur verlinkter Intake-Evidence / Linked Intake Evidence Architecture

## Kontext und Datenfluss / Context and data flow

```text
Kanonisches Series-Manifest + explizite Feature-Evidence
  -> strikte UTF-8-, Schema-, Pfad-, Typ- und Proof-Validierung
  -> typisierte Fünf-Felder-Projektion im Speicher
  -> Vergleich beider Markdown-Kandidaten
  -> Check-Ergebnis oder atomare lokale Publication mit Recheck/Rollback
```

*The only trust boundary is from repository files treated as untrusted data
into validated in-memory projection values. The renderer-owned output boundary
is local Markdown. No external component, service, deployment, or network
boundary is added.*

## Qualitätsziele und Szenarien / Quality goals and scenarios

| Ziel | Szenario | Messbares Ergebnis |
|---|---|---|
| Integrität | Eine Kante wird umgedreht, umtypisiert oder rebound. | Der einzelne Negativfall liefert seinen erwarteten Blocker; kein Write. |
| Sicherheit | Sichere und credential-förmige relative Inputs erreichen Missing-File- und Unknown-Endpoint-Diagnosen; private Roots oder Controls erreichen `LIE003`. | Stabiler Code, sichere DE-vor-EN-Abhilfe und nützlicher redigierter Kontext in Standard-Error; kein synthetischer Credentialwert, privater Root, Control oder PowerShell-Stack in beiden Streams. |
| Barrierearme Verständlichkeit | Tabelle wird in Quellreihenfolge linear gelesen. | Fünf Feldlabels, vollständige Dateinamen, jede direkte Kante und nächste Aktion bleiben erkennbar. |
| Determinismus | Gleiche Eingaben werden ein zweites Mal geschrieben. | Bytegleiche Ausgaben und `writes=0`. |
| Wiederherstellbarkeit | Fehler tritt nach erstem Replace auf. | Beide Alt-Ausgaben sind wiederhergestellt; keine Renderer-Tempdatei bleibt. |
| Wartbarkeit | Bash und PowerShell erhalten denselben neuen Grenzfall. | Paar-Tests sind semantisch gleich und nutzen keine neue Dependency. |

## arc42 Section 8 und Entscheidungsgrenze

Die querschnittlichen Konzepte sind Pfad-Containment, striktes Encoding,
kontextuelles Markdown/HTML-Escaping, eindeutige Proof-Auflösung,
candidate-first Publication, atomarer Rollback, Idempotenz, sichere
Diagnoseprojektion und Paarparität.
Diese Konzepte bleiben in den vorhandenen beiden Bibliotheken und öffentlichen
Wrappern; es entsteht kein neuer Baustein.

*The cross-cutting concepts are path containment, strict encoding, contextual
Markdown/HTML escaping, unique proof resolution, candidate-first publication,
atomic rollback, idempotence, safe diagnostic projection, and pair parity.
They stay in the existing two
libraries and public wrappers; no new building block is introduced.*

ADR/S-ADR ist `N/A`, weil weder kanonischer Owner, Komponentenzerlegung,
externe Schnittstelle, Deployment noch Trust Boundary geändert wird. Trigger
für eine neue Entscheidung ist genau eine Änderung an einer dieser Grenzen.

*ADR/S-ADR is `N/A` because no canonical owner, component decomposition,
external interface, deployment, or trust boundary changes. Any such change
triggers reevaluation.*

## Didaktische Kommentarprüfung

- Path Containment: Kommentare erklären, warum abgelehnte Bytes nicht in
  öffentliche Diagnosen zurückgespiegelt werden.
- Ambiguität/Proof: bestehende Logik bleibt fail-closed; kein neuer
  Dateinamen-Ratemechanismus wurde ergänzt.
- Atomarer Rollback und Idempotenz: bestehende Why-Kommentare und Tests bleiben
  bindend; die US4-Änderung greift nicht in die Transaktion ein.
- Escaping: neue Kommentare markieren die Vertrauensgrenze, damit eigenes
  `<br>` nach, nicht vor dem Escaping eingefügt wird.
- Diagnosen: Kommentare begründen einzeilige Control-Begrenzung,
  Credential-Redaktion und den Erhalt sicherer repositoryrelativer Subjects.

*Comments explain the reason and proof boundary, not the obvious operation.
No comment claims a human review, assistive-device test, or native-platform
result that did not occur.*

Owner: Home Repository Owner. Reviewer: Feature-032 Architecture Reviewer.
Restrisiko: native Windows-/Linux-Parität und unabhängiger Review bleiben
`Open`. Re-Evaluation bei Quellen-, Komponenten-, Schnittstellen-,
Deployment-, Trust-Boundary- oder Transaktionsänderung.
