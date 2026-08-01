#!/usr/bin/env python3

import copy
import hashlib
import importlib.util
import json
import subprocess
import tempfile
from pathlib import Path


FEATURE_ROOT = Path(__file__).resolve().parents[1]
VALIDATOR_PATH = FEATURE_ROOT / "tools" / "validate_efficiency_guide.py"
CATEGORIES = [
    "Option",
    "Status",
    "ExitCode",
    "Evidence",
    "SafetyBoundary",
    "Distribution",
    "Recovery",
    "Platform",
    "NextAction",
]


def normalized_hash(path: Path) -> str:
    text = path.read_text(encoding="utf-8-sig").replace("\r\n", "\n").replace("\r", "\n")
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


def load_validator():
    spec = importlib.util.spec_from_file_location("efficiency_validator", VALIDATOR_PATH)
    if spec is None or spec.loader is None:
        raise RuntimeError("validator module cannot be loaded")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def write_fixture(root: Path) -> dict:
    guide_de = root / "docs/maintenance/guide.md"
    guide_en = root / "docs/maintenance/guide.en.md"
    source = root / "scripts/source.sh"
    entries = [
        root / "docs/getting-started.md",
        root / "docs/getting-started.en.md",
        root / "docs/maintenance/README.md",
        root / "docs/maintenance/README.en.md",
        root / "docs/architecture/source.md",
        root / "docs/architecture/source.en.md",
        root / "docs/troubleshooting/README.md",
        root / "docs/troubleshooting/README.en.md",
    ]
    for path in [guide_de, guide_en, source, *entries]:
        path.parent.mkdir(parents=True, exist_ok=True)
    anchors = [
        "first-safe-run",
        "regular-operation",
        "maintainer-agent",
        "audit-troubleshooting",
    ]
    guide_de.write_text("\n".join(f'<a id="{anchor}"></a>\n## {anchor}' for anchor in anchors) + "\n", encoding="utf-8")
    guide_en.write_text("\n".join(f'<a id="{anchor}"></a>\n## {anchor}' for anchor in anchors) + "\n", encoding="utf-8")
    source.write_text("\n".join(f"claim-{index}" for index in range(len(CATEGORIES))) + "\n", encoding="utf-8")
    for path in entries:
        path.write_text("# Entry\n", encoding="utf-8")

    subprocess.run(["git", "init", "-q"], cwd=root, check=True)
    subprocess.run(["git", "add", "."], cwd=root, check=True)

    reader_paths = []
    pairs = [
        ("FirstSafeRun", entries[0], entries[1], anchors[0]),
        ("RegularOperation", entries[2], entries[3], anchors[1]),
        ("MaintainerAgent", entries[4], entries[5], anchors[2]),
        ("AuditTroubleshooting", entries[6], entries[7], anchors[3]),
    ]
    for identifier, german, english, anchor in pairs:
        reader_paths.append(
            {
                "id": identifier,
                "germanEntry": german.relative_to(root).as_posix(),
                "englishEntry": english.relative_to(root).as_posix(),
                "guideAnchor": anchor,
                "safeNextAction": "Read the text result and continue only with explicit authority.",
            }
        )

    digest = normalized_hash(source)
    claims = []
    for index, category in enumerate(CATEGORIES):
        claims.append(
            {
                "id": f"AEC{index + 1:03d}",
                "category": category,
                "readerPaths": [pairs[index % 4][0]],
                "languages": ["de", "en"],
                "statement": f"Fixture claim {index + 1}",
                "sourcePath": source.relative_to(root).as_posix(),
                "sourceNormalizedSha256": digest,
                "sourceLocator": f"claim-{index}",
                "sourceState": "Current",
                "proofBoundary": "The fixture proves only deterministic contract validation.",
                "reevaluationTrigger": "The fixture source changes.",
            }
        )

    return {
        "schemaVersion": "1.0",
        "feature": "022-agentic-workspace-efficiency-guide",
        "generatedFromHead": "0" * 40,
        "requiredClaimCategories": CATEGORIES,
        "readerPaths": reader_paths,
        "claims": claims,
        "documentationImpact": {
            "decision": "UpdateRequired",
            "owner": "Fixture Owner",
            "audiences": ["Learners"],
            "readerPaths": [pair[0] for pair in pairs],
            "canonicalSources": [guide_de.relative_to(root).as_posix(), guide_en.relative_to(root).as_posix()],
            "navigationImpact": "Fixture navigation",
            "documentClass": "OperationalGuide",
            "languageStrategy": "GermanFirstEnglishPartner",
            "languagePartners": [guide_de.relative_to(root).as_posix(), guide_en.relative_to(root).as_posix()],
            "platformAndExampleProof": "Fixture proof",
            "distributionClass": "sourceOnly",
            "homeSyncRequired": False,
            "evidence": "evidence.md",
            "reevaluationTrigger": "Fixture changes",
        },
    }


def expect_failure(module, root: Path, matrix: dict, error_class: str) -> None:
    errors = module.validate(root, matrix)
    if not any(error.startswith(f"{error_class}:") for error in errors):
        raise AssertionError(f"expected {error_class}, got {errors}")


def main() -> int:
    module = load_validator()
    with tempfile.TemporaryDirectory(prefix="feature-022-guide-") as temp:
        root = Path(temp)
        valid = write_fixture(root)
        errors = module.validate(root, valid)
        if errors:
            raise AssertionError(f"valid fixture failed: {errors}")

        duplicate = copy.deepcopy(valid)
        duplicate["claims"].append(copy.deepcopy(duplicate["claims"][0]))
        expect_failure(module, root, duplicate, "CLAIM_IDENTITY")

        missing_category = copy.deepcopy(valid)
        missing_category["claims"] = missing_category["claims"][:-1]
        expect_failure(module, root, missing_category, "CLAIM_COVERAGE")

        stale = copy.deepcopy(valid)
        stale["claims"][0]["sourceNormalizedSha256"] = "f" * 64
        expect_failure(module, root, stale, "SOURCE_HASH")

        historical = copy.deepcopy(valid)
        historical["claims"][0]["sourceState"] = "HistoricalBoundary"
        historical["claims"][0]["proofBoundary"] = "Use this as current authority."
        expect_failure(module, root, historical, "HISTORICAL_BOUNDARY")

        bad_partner = copy.deepcopy(valid)
        bad_partner["documentationImpact"]["languagePartners"] = ["docs/maintenance/guide.md"]
        expect_failure(module, root, bad_partner, "LANGUAGE_PARTNER")

        outside = copy.deepcopy(valid)
        outside["claims"][0]["sourcePath"] = "../outside.txt"
        expect_failure(module, root, outside, "SOURCE_PATH")

    print("PASS: Feature 022 source-matrix positive and isolated negative fixtures")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
