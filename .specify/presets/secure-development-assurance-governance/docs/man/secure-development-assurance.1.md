# secure-development-assurance(1)

## NAME

secure-development-assurance — Secure-Development-Evidence validieren

## SYNOPSIS

validate-secure-development-assurance.sh status [evidence-dir]

validate-secure-development-assurance.sh review <gate> <context-id> <mode>

## DESCRIPTION

Validiert die vier Secure-Development-Gates und hält technische Validierung,
Pilotfreigabe, Projektabnahme und allgemeine Freigabe getrennt. status ist
read-only. review validiert nur den benannten, bereits vorhandenen Kontext.

## ENGLISH

Validates the four secure-development gates while preserving independent
human decision boundaries. Status inspection is read-only.
