#!/usr/bin/env python3
"""Collect a deterministic, read-only documentation-family inventory."""

from __future__ import annotations

import argparse
import concurrent.futures
import datetime as dt
import hashlib
import json
import pathlib
import subprocess


DOCUMENT_SUFFIXES = {".md", ".rst", ".adoc", ".txt", ".html", ".htm"}


def run_git(repo: pathlib.Path, *args: str, allow_failure: bool = False) -> str:
    result = subprocess.run(
        ["git", "-C", str(repo), *args],
        check=False,
        text=True,
        capture_output=True,
    )
    if result.returncode and not allow_failure:
        raise RuntimeError(f"git {' '.join(args)} failed for {repo.name}")
    return result.stdout.strip()


def sha256(path: pathlib.Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def family(path: str) -> str:
    lowered = path.lower()
    name = pathlib.PurePosixPath(path).name.lower()
    if (
        name in {"agents.md", "claude.md", "gemini.md"}
        or "copilot-instructions" in lowered
        or "/agents/" in lowered
    ):
        return "agent-guidance"
    if (
        "constitution" in lowered
        or "/security/" in lowered
        or "/secure-development/" in lowered
        or "/accessibility/" in lowered
        or "/architecture/" in lowered
    ):
        return "governance"
    if (
        lowered.startswith("specs/")
        or "lastenheft" in lowered
        or "pflichtenheft" in lowered
    ):
        return "feature-and-intake-evidence"
    if "learning" in lowered or "lern" in lowered or "ausbildung" in lowered:
        return "learner-guidance"
    if (
        "project-statistics" in lowered
        or name == "stats.md"
        or "/generated/" in lowered
    ):
        return "generated-and-statistics"
    if name.startswith("readme") or "/man/" in lowered or "/scripts/" in lowered:
        return "usage-and-operations"
    return "other-documentation"


def collect_repository(
    target_id: str,
    level: int,
    home_path: str,
    repo: pathlib.Path,
    declared_remote: str | None,
    level0: bool = False,
) -> tuple[dict, list[dict]]:
    record = {
        "targetId": target_id,
        "level": level,
        "homePath": home_path,
        "declaredRemote": declared_remote or "",
        "observedRemote": "",
        "defaultBranch": "",
        "currentBranch": "",
        "commit": "",
        "worktreeClass": "",
        "reachability": "",
        "auditStatus": "",
    }
    areas: list[dict] = []
    if not repo.exists():
        record.update(reachability="Missing", worktreeClass="Unavailable", auditStatus="Blocked")
        areas.append(blocked_area(target_id, level, "Repository path is missing."))
        return record, areas

    top = run_git(repo, "rev-parse", "--show-toplevel", allow_failure=True)
    if not top:
        record.update(reachability="NotGit", worktreeClass="Unavailable", auditStatus="Blocked")
        areas.append(blocked_area(target_id, level, "Registered path is not a Git checkout."))
        return record, areas

    record["reachability"] = "LocalCheckout"
    record["commit"] = run_git(repo, "rev-parse", "HEAD")
    record["currentBranch"] = run_git(repo, "branch", "--show-current") or "DETACHED"
    record["observedRemote"] = run_git(
        repo, "remote", "get-url", "origin", allow_failure=True
    )
    remote_head = run_git(
        repo, "symbolic-ref", "--short", "refs/remotes/origin/HEAD", allow_failure=True
    )
    record["defaultBranch"] = remote_head.removeprefix("origin/") if remote_head else ""
    status = run_git(repo, "status", "--porcelain=v1")
    record["worktreeClass"] = (
        "FeatureWorktree" if level0 else ("Dirty" if status else "Clean")
    )

    tracked = run_git(repo, "ls-files").splitlines()
    docs = [
        path
        for path in tracked
        if pathlib.PurePosixPath(path).suffix.lower() in DOCUMENT_SUFFIXES
        and not path.startswith(("_site/", "node_modules/", ".git/"))
    ]
    if not docs:
        record["auditStatus"] = "Reviewed"
        areas.append(
            {
                "areaId": f"{target_id}:documentation",
                "targetId": target_id,
                "level": level,
                "family": "documentation",
                "paths": [],
                "decision": "NotApplicable",
                "claim": "",
                "evidence": [],
                "rationale": "No tracked documentation surface exists at the assessed commit.",
                "generatedContract": "N/A",
                "learnerA11yResult": "N/A",
                "residualRisk": "Low",
                "reevaluationTrigger": "Re-evaluate when a documentation file is added.",
            }
        )
        return record, areas

    grouped: dict[str, list[str]] = {}
    for path in docs:
        grouped.setdefault(family(path), []).append(path)
    for name, paths in sorted(grouped.items()):
        paths.sort()
        evidence = [
            f"commit:{record['commit']}",
            f"tracked-count:{len(paths)}",
            *[f"path:{path}" for path in paths[:5]],
        ]
        areas.append(
            {
                "areaId": f"{target_id}:{name}",
                "targetId": target_id,
                "level": level,
                "family": name,
                "paths": paths,
                "decision": "CurrentAndSupported",
                "claim": "The tracked documentation family exists in the exact assessed Git state.",
                "evidence": evidence,
                "rationale": "The inventory is derived from Git-tracked files at the recorded commit; semantic claims remain bounded to the cited files.",
                "generatedContract": (
                    "ReviewRequired"
                    if name == "generated-and-statistics"
                    else "N/A"
                ),
                "learnerA11yResult": (
                    "ReviewRequired"
                    if name in {"learner-guidance", "usage-and-operations"}
                    else "N/A"
                ),
                "residualRisk": "Low",
                "reevaluationTrigger": "Re-evaluate when the commit, tracked paths, or governing documentation changes.",
            }
        )
    record["auditStatus"] = "Reviewed"
    return record, areas


def blocked_area(target_id: str, level: int, reason: str) -> dict:
    return {
        "areaId": f"{target_id}:repository",
        "targetId": target_id,
        "level": level,
        "family": "repository",
        "paths": [],
        "decision": "Blocked",
        "claim": "",
        "evidence": [],
        "rationale": reason,
        "generatedContract": "Blocked",
        "learnerA11yResult": "Blocked",
        "residualRisk": "Unknown",
        "reevaluationTrigger": "Re-evaluate when a clean, identifiable checkout is available.",
    }


def run_homogeneity(target_id: str, level: int, repo: pathlib.Path) -> dict:
    script = repo / "scripts" / "check-homogeneity.sh"
    if not script.exists():
        return {
            "targetId": target_id,
            "level": level,
            "result": "N/A",
            "exitCode": None,
            "observations": [],
            "rationale": "No repository-owned homogeneity wrapper exists.",
        }
    try:
        result = subprocess.run(
            ["bash", str(script), "--dry-run", "--no-patch", "."],
            cwd=repo,
            check=False,
            text=True,
            capture_output=True,
            timeout=180,
        )
    except subprocess.TimeoutExpired:
        return {
            "targetId": target_id,
            "level": level,
            "result": "Blocked",
            "exitCode": 124,
            "observations": ["TIMEOUT: homogeneity exceeded 180 seconds"],
            "rationale": "Repository-native validation did not complete.",
        }
    observations = [
        line.strip()
        for line in result.stdout.splitlines()
        if "WARN:" in line or "FAIL:" in line
    ]
    return {
        "targetId": target_id,
        "level": level,
        "result": "Pass" if result.returncode == 0 else "Finding",
        "exitCode": result.returncode,
        "observations": observations,
        "rationale": "Read-only repository-owned homogeneity dry-run.",
    }


def apply_native_findings(
    areas: list[dict], validations: list[dict], repositories: list[dict]
) -> list[dict]:
    area_by_key = {(area["targetId"], area["family"]): area for area in areas}
    commit_by_target = {
        repository["targetId"]: repository.get("commit", "")
        for repository in repositories
    }
    findings: list[dict] = []
    candidates: list[tuple[str, int, str, str]] = []
    for validation in validations:
        for observation in validation["observations"]:
            if "bilingual-section-missing" in observation:
                path = observation.split()[1]
                family_name = (
                    "agent-guidance"
                    if path.upper() in {"AGENTS.MD", "CLAUDE.MD", "GEMINI.MD"}
                    else "usage-and-operations"
                )
                candidates.append(
                    (
                        validation["targetId"],
                        validation["level"],
                        family_name,
                        f"{path}: required bilingual section is missing",
                    )
                )
            elif "generated documentation drifted" in observation:
                candidates.append(
                    (
                        validation["targetId"],
                        validation["level"],
                        "usage-and-operations",
                        "docs/scripts reference differs from the canonical script inventory",
                    )
                )
            elif validation["result"] in {"Finding", "Blocked"}:
                candidates.append(
                    (
                        validation["targetId"],
                        validation["level"],
                        "other-documentation",
                        observation,
                    )
                )

    for number, (target_id, level, family_name, summary) in enumerate(
        candidates, start=1
    ):
        area = area_by_key.get((target_id, family_name))
        if area is None:
            area = next(area for area in areas if area["targetId"] == target_id)
        area["decision"] = (
            "GeneratedDrift"
            if "canonical script inventory" in summary
            else "UpdateRequired"
        )
        area["rationale"] = (
            "Repository-native read-only validation reproduced a documentation discrepancy."
        )
        finding_id = f"DOC{number:03d}"
        findings.append(
            {
                "findingId": finding_id,
                "areaId": area["areaId"],
                "severity": "Medium",
                "summary": summary,
                "evidence": [
                    f"commit:{commit_by_target[target_id]}",
                    "command:bash scripts/check-homogeneity.sh --dry-run --no-patch .",
                ],
                "ownerLevel": f"Level{level}",
                "owner": target_id,
                "residualRisk": "Learners or maintainers may receive incomplete or stale guidance.",
                "correctionBoundary": "Documentation and deterministic documentation-generation evidence only.",
                "reevaluationTrigger": "Re-run repository-native Homogeneity after the owner updates the cited documentation.",
                "handoff": "D2" if level == 0 else "D3",
            }
        )
    return findings


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--repo", type=pathlib.Path, required=True)
    parser.add_argument(
        "--level0-native-repo",
        type=pathlib.Path,
        help="Optional clean worktree of the recorded Level-0 base commit.",
    )
    parser.add_argument("--home", type=pathlib.Path, required=True)
    parser.add_argument("--manifest", type=pathlib.Path, required=True)
    parser.add_argument("--snapshot", type=pathlib.Path, required=True)
    parser.add_argument("--audit", type=pathlib.Path, required=True)
    args = parser.parse_args()

    manifest = json.loads(args.manifest.read_text(encoding="utf-8"))
    repositories: list[dict] = []
    areas: list[dict] = []
    validation_targets: list[tuple[str, int, pathlib.Path]] = []
    level0_record, level0_areas = collect_repository(
        "level0",
        0,
        "home-baseline-source",
        args.repo,
        "https://github.com/hindermath/home-baseline.git",
        level0=True,
    )
    repositories.append(level0_record)
    areas.extend(level0_areas)
    validation_targets.append(
        ("level0", 0, args.level0_native_repo or args.repo)
    )

    for target in manifest["targets"]:
        record, target_areas = collect_repository(
            target["id"],
            int(target["level"]),
            target["path"],
            args.home / target["path"],
            target.get("remote"),
        )
        repositories.append(record)
        areas.extend(target_areas)
        validation_targets.append(
            (target["id"], int(target["level"]), args.home / target["path"])
        )

    captured = dt.datetime.now(dt.timezone.utc).replace(microsecond=0).isoformat()
    with concurrent.futures.ThreadPoolExecutor(max_workers=4) as executor:
        native_validation = list(
            executor.map(
                lambda item: run_homogeneity(*item),
                validation_targets,
            )
        )
    findings = apply_native_findings(areas, native_validation, repositories)
    snapshot = {
        "schemaVersion": "1.0",
        "capturedAt": captured,
        "level0Commit": level0_record["commit"],
        "fleetManifestPath": "scripts/config/agentic-workspace-fleet.json",
        "fleetManifestSha256": sha256(args.manifest),
        "repositories": repositories,
    }
    audit = {
        "schemaVersion": "1.0",
        "status": "Ready",
        "capturedAt": captured,
        "decisionVocabulary": [
            "CurrentAndSupported",
            "UpdateRequired",
            "GeneratedDrift",
            "HistoricalEvidence",
            "IntentionalDeviation",
            "FollowUp",
            "NotApplicable",
            "Blocked",
        ],
        "areas": areas,
        "findings": findings,
        "nativeValidation": native_validation,
    }
    args.snapshot.write_text(
        json.dumps(snapshot, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    args.audit.write_text(
        json.dumps(audit, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
