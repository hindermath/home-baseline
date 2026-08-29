---
name: speckit-secure-development-review
description: Validate one named secure-development gate with bounded evidence authority
compatibility: Requires a Spec Kit project and the secure-development assurance preset
metadata:
  author: github-spec-kit
  source: preset:secure-development-assurance-governance
---

# Secure Development Review

Use for $speckit-secure-development-review <baseline|delta|closure|image-impact> <context-id> <training|mixed|development>.

Validate only the named gate and context. Write only explicitly authorized
review evidence inside that context. Fail closed on drift, missing evidence,
invalid status combinations, or missing authority. Preserve technical
validation, pilot authorization, project acceptance, and general release as
four separate decisions. HOSK/GWDG is external comparison only.
