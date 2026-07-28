# Contract: CLI Probe Result

Eine CLI gilt erst nach einer begrenzten, seiteneffektarmen Funktionsprobe als
nutzbar. Die Probe verwendet eine Argumentliste ohne Shell, eine eigene
Prozessgruppe, standardmäßig fünf Sekunden und höchstens 2 KiB bereinigte
Evidence.

| Status | Bedeutung |
|---|---|
| `Available` | Funktionsprobe war erfolgreich |
| `Missing` | Kein ausführbarer Befehl wurde aufgelöst |
| `Unusable` | Befehl wurde aufgelöst, Probe scheiterte |
| `TimedOut` | Zeitgrenze erreicht; Prozessgruppe wurde beendet |
| `CapabilityBlocked` | Begrenzte Evidence belegt eine Container-/Capability-Sperre |

Ein nicht erfolgreicher Required-Status bleibt in der Abschlussaggregation
erhalten. Evidence enthält keine Tokens oder privaten absoluten Pfade.
