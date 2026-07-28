# Contract: Swift Installation on Ubuntu

Der automatisierte Pfad ist ausschließlich für Swiftly `1.1.2`, Swift `6.3.3`
und Ubuntu 22.04/24.04 auf `x86_64` oder `aarch64` aktiviert. Swiftly-Version,
Swift-Version, architekturbezogene Swift.org-URL und SHA-256 stehen gemeinsam
in der Required-CLI-Registry. Ubuntu 20.04 sowie jede unbekannte oder
unvollständige Kombination stoppen vor Mutation und nennen ein
Upgrade-/Support-Follow-up.

Der Bootstrap wird nach HTTPS-Download vor Extraktion per SHA-256 geprüft.
Swiftly läuft unbeaufsichtigt mit `--no-modify-profile`; die aktuelle Shell
lädt die erzeugte Umgebung explizit. Nachgelagerte Systemabhängigkeiten werden
nur bei aktueller `--allow-admin-prompts`-Autorität ausgeführt. Abschließend
muss `swift --version` im selben Prozesskontext erfolgreich sein.

Dry-run und Compare-only laden, extrahieren, installieren und verändern kein
Profil. Ein zweiter erfolgreicher Lauf erkennt Swift als vorhanden.
