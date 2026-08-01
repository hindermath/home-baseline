# Contract: Level-0 Documentation Architecture

## Entry Contract

`README.md` and `README.en.md` are concise, equivalent entry points. Each links
to the other language, the documentation portal, all four reader paths, the
safe preview-first maintenance action, security/A11Y boundaries, and the
Level-0 source/Home Runtime explanation.

## Portal Contract

`docs/README.md` and `docs/README.en.md` expose task-oriented areas while
retaining existing canonical directories. Each reader path provides
prerequisites, ordered steps, deeper references, and one exact next action.

## Migration Contract

`documentation-migration.json` binds the accepted source hash and every former
top-level README section to exactly one decision and target. The validator must
reject omissions, duplicates, unsupported decisions, missing targets, broken
language partners, broken links, private paths, and non-zero D6/D7 counts.

## Governance Contract

Every relevant change records exactly one of `UpdateRequired`,
`NoUpdateRequired`, `GeneratedUpdate`, or `FollowUp`, plus audience, reader
path, ownership, navigation, class, language, platform, distribution, sync,
evidence, and reevaluation data. `FollowUp` includes owner, risk, due date,
review trigger, evidence, and scope reason.

## Scope Contract

The feature changes documentation, documentation governance, templates, agent
guidance, feature-local tests, evidence, Series closeout, and statistics only.
Runtime, API, dependencies, maintenance behavior, fleet state, D6, and D7 remain
unchanged.
