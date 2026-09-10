# Sicherheit verlinkter Intake-Evidence / Linked Intake Evidence Security

## Umfang / Scope

Der Renderer liest ein repositorylokales Manifest und explizite
Feature-Evidence, validiert nicht vertrauenswürdige Strings und erzeugt
Markdown. Es gibt kein Netzwerk, keine Authentifizierung, keine
Autorisierungsentscheidung, keine neue Kryptografie, keine Produkt-API und
keine neue Abhängigkeit.

*The renderer reads a repository-local manifest and explicit feature evidence,
validates untrusted strings, and produces Markdown. There is no network,
authentication, authorization decision, new cryptography, product API, or new
dependency.*

## STRIDE und CIA

| Risiko | CIA-Bezug | Proportionale Kontrolle |
|---|---|---|
| Spoofing: ähnlich benanntes Feature wird als Proof ausgegeben | Integrität | Nur genau ein expliziter vorhandener Proof; Ähnlichkeit ist kein Nachweis. |
| Tampering: Manifest, Kante oder Quelle ändert sich während Publication | Integrität | Normalisierte Eingabehashes, Recheck vor Replace, atomarer Multi-Output-Rollback. |
| Repudiation: ein Teilgate verschwindet in einem Summenpass | Integrität/Nachvollziehbarkeit | Getrennte `10/10`, `6/6`, Latest-`1/1` und Backlog-`1/1` Evidence. |
| Information disclosure: Pfad/Credential/Stack gelangt in Fehler | Vertraulichkeit | Der zentrale öffentliche Diagnosepfad redigiert credential-förmige Werte in allen `LIE001`–`LIE012`-Familien; sichere relative Subjects bleiben erhalten, Private Roots, Controls und PS-Stackdaten fehlen. |
| Denial of service: ungültige Daten erzeugen Teiloutputs | Verfügbarkeit/Integrität | Fail-closed vor Publication; begrenzte lineare Verarbeitung; vollständiger Rollback. |
| Elevation of privilege: Manifestwert wird als Befehl/Option interpretiert | Integrität | Kein `eval`/`Invoke-Expression`; Manifestdaten werden nie ausgeführt; Optionspfade scheitern. |

*The controls protect confidentiality, integrity, and availability at the
local file-rendering boundary. They do not claim protection for an absent
network or identity system.*

## CAPEC, SSDF und CWE

- CAPEC-126 (Path Traversal) wird durch lexikalische und physische
  Repository-Containment-Prüfung einschließlich Symlinks behandelt.
- CAPEC-88 (OS Command Injection) und Optionsinjektion werden durch reine
  Datenverarbeitung, Quotes, `--`-Grenzen und das Verbot von `eval` sowie
  `Invoke-Expression` behandelt.
- HTML-/Markup-Injektion wird kontextuell durch Entities für `&`, `<` und `>`
  plus Markdown-Escaping begrenzt; der eigene `<br>`-Separator wird erst danach
  eingefügt.
- NIST SSDF PW.4/PW.5 und RV.1 werden proportional durch Threat-Modell,
  sichere Implementierung, Negativtests, Review und aktuelle Evidence erfüllt.
- Relevante CWE-Klassen sind CWE-20 (Input Validation), CWE-22 (Path
  Traversal), CWE-78 (Command Injection), CWE-79/CWE-116 (Markup und Output
  Encoding) sowie CWE-209 (Information Exposure Through an Error Message).

*These mappings are scoped mitigations, not a certification claim. The paired
tests call the real public CLI with synthetic private-root,
credential-shaped, control-character, and HTML-shaped inputs.*

Die supersedierende Regression prüft zusätzlich sichere und
credential-förmige relative Subjects getrennt für Missing-File (`LIE004`) und
Unknown-Endpoint (`LIE007`) und wertet Standard-Output sowie Standard-Error
separat aus. Der vorherige absolute `LIE003`-Fall allein war für diese Grenze
nicht ausreichend. Details und Lineage stehen in
`specs/032-linked-intake-evidence/diagnostic-remediation-2026-09-10.md`.

*The superseding regression separately covers safe and credential-shaped
relative subjects for missing-file and unknown-endpoint errors. The earlier
absolute `LIE003` case alone did not prove this boundary.*

## T021-Disposition und Abhängigkeiten

| Standard/Familie | Status für diesen Slice | Begründung / Trigger |
|---|---|---|
| MSL-Kontext; Bash; PowerShell 7 | Applicable, erfüllt | Produktkontexte bleiben MSL; Shellregeln, Strict Mode und top-level Catch geprüft. Trigger: Laufzeit-/Sprachwechsel. |
| NIST SSDF; CWE Top 25; STRIDE/CIA; CAPEC | Applicable, erfüllt | Eingabe-, Pfad-, Ausgabe- und Fehlergrenzen oben sowie in Paar-Tests. Trigger: neue Trust Boundary. |
| OWASP SAMM | Applicable, erfüllt | Requirements und Verification sind durch Spec/Tasks/Negativtests nachvollziehbar. Trigger: Programm-/Reviewmodell ändert sich. |
| OWASP ASVS | N/A | Keine Web/API/Auth/Session-Fläche. Trigger: solche Fläche tritt in den Diff. |
| SBOM; VEX; AI-SBOM; SLSA; OpenSSF Scorecard | N/A | Keine Dependency, Release-, Image-, AI-Runtime- oder Supply-Chain-Auswahl. Trigger: entsprechender Scope. |
| Zero Trust; BSI C3A; BSI C5 | N/A | Keine Netzwerk-, Cloud- oder Remote-Access-Grenze. Trigger: Service/Cloud tritt ein. |
| NIS2; CRA; EU AI Act; DORA | N/A | Keine neue Markt-, Betreiber-, AI-System- oder Finanz-ICT-Entscheidung. Trigger: regulierter Produkt-/Service-Scope. |
| Secure Development Assurance v0.1.3 | Applicable als unveränderter Validatorvertrag; Produkt/Image `N/A / Not Assessed` | Kontext bleibt `home-baseline-assurance-v013`/`training`. Trigger: Kontext-, Risiko-, Preset-, Produkt- oder Imageänderung. |

`git diff --name-only` und der ungetrackte Status enthalten keine Paket-,
Lock-, Projekt- oder Dependency-Datei. Diese Nullmenge ist der
Dependency-Nachweis dieses Slices; ein späterer solcher Pfad wäre ein Hard Stop.

*The tracked diff and untracked status contain no package, lock, project, or
dependency file. That empty set is this slice's dependency proof; any later
such path is a hard stop.*

Owner: Home Repository Owner. Reviewer: Security/Architecture Reviewer des
Feature-032-Slices. Restrisiko: native Plattformunterschiede und unabhängiger
Review bleiben offen. Re-Evaluation bei Eingabe-, Ausgabe-, Prozess-,
Dependency-, Netzwerk-, Produkt- oder Trust-Boundary-Änderung.
