#!/usr/bin/env python3
"""Validate and maintain the declared workspace fleet without provider writes."""

from __future__ import annotations

import argparse
import json
import os
import pathlib
import re
import shutil
import subprocess
import sys
import tempfile
import time
import uuid
from datetime import datetime, timezone
from urllib.parse import urlsplit


VALID_KINDS = {"git-repository", "collection"}
VALID_CLASSES = {"canonical-fleet", "preset"}
VALID_FORGES = {"github", "gitlab", "codeberg", "forgejo", "generic-git"}
BLOCKING_STATES = {
    "AHEAD",
    "DIVERGED",
    "DIRTY",
    "DETACHED",
    "PATH_CONFLICT",
    "REMOTE_MISMATCH",
    "BRANCH_MISMATCH",
    "MISSING_UPSTREAM",
    "UNAVAILABLE",
}


class ContractError(ValueError):
    """Raised when the desired-state contract is unsafe or inconsistent."""


def utc_now() -> str:
    return datetime.now(timezone.utc).replace(microsecond=0).isoformat().replace("+00:00", "Z")


def run_git(repository: pathlib.Path | None, *arguments: str, check: bool = True) -> subprocess.CompletedProcess[str]:
    command = ["git"]
    if repository is not None:
        command.extend(["-C", str(repository)])
    command.extend(arguments)
    result = subprocess.run(command, text=True, capture_output=True, check=False)
    if check and result.returncode != 0:
        detail = (result.stderr or result.stdout).strip().splitlines()
        raise RuntimeError(detail[-1] if detail else f"git exited {result.returncode}")
    return result


def normalize_remote(remote: str) -> str:
    value = remote.strip().replace("\\", "/")
    parsed = urlsplit(value)
    if parsed.scheme in {"http", "https"}:
        if parsed.username or parsed.password:
            raise ContractError("remote URLs with embedded credentials are forbidden")
        value = f"{parsed.scheme.lower()}://{parsed.netloc.lower()}{parsed.path}"
    return value.rstrip("/").removesuffix(".git").lower()


def validate_relative_path(raw: object) -> pathlib.PurePosixPath:
    if not isinstance(raw, str) or not raw or "\\" in raw or raw.startswith("/"):
        raise ContractError(f"unsafe HOME-relative path: {raw!r}")
    value = pathlib.PurePosixPath(raw)
    if any(part in {"", ".", ".."} for part in value.parts):
        raise ContractError(f"unsafe HOME-relative path: {raw!r}")
    return value


def load_manifest(path: pathlib.Path) -> dict:
    try:
        data = json.loads(path.read_text(encoding="utf-8-sig"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise ContractError(f"manifest cannot be read: {exc}") from exc
    if not isinstance(data, dict) or data.get("schemaVersion") != "1.0":
        raise ContractError("unsupported manifest schemaVersion")
    targets = data.get("targets")
    if not isinstance(targets, list) or not targets:
        raise ContractError("targets must be a non-empty array")

    ids: set[str] = set()
    paths: dict[str, dict] = {}
    remotes: set[str] = set()
    for index, target in enumerate(targets):
        if not isinstance(target, dict):
            raise ContractError(f"targets[{index}] must be an object")
        allowed = {
            "id", "kind", "level", "path", "active", "maintenanceClass",
            "remote", "forge", "defaultBranch", "memberDiscovery",
        }
        unknown = set(target) - allowed
        if unknown:
            raise ContractError(f"unknown target fields at targets[{index}]: {sorted(unknown)}")
        required = {"id", "kind", "level", "path", "active", "maintenanceClass"}
        if not required.issubset(target):
            raise ContractError(f"missing target fields at targets[{index}]")
        target_id = target.get("id")
        if not isinstance(target_id, str) or not re.fullmatch(r"[a-z0-9][a-z0-9-]*", target_id):
            raise ContractError(f"targets[{index}].id is invalid")
        if target_id in ids:
            raise ContractError(f"duplicate target id: {target_id}")
        ids.add(target_id)
        kind = target.get("kind")
        level = target.get("level")
        maintenance_class = target.get("maintenanceClass")
        if kind not in VALID_KINDS or level not in {1, 2} or maintenance_class not in VALID_CLASSES:
            raise ContractError(f"invalid target classification: {target_id}")
        if not isinstance(target.get("active"), bool):
            raise ContractError(f"active must be boolean: {target_id}")
        relative = validate_relative_path(target.get("path"))
        path_key = relative.as_posix().casefold()
        if path_key in paths:
            raise ContractError(f"duplicate target path: {relative}")
        paths[path_key] = target
        if kind == "collection":
            forbidden = {"remote", "forge", "defaultBranch"} & target.keys()
            if forbidden or target.get("memberDiscovery") != "declared-targets":
                raise ContractError(f"invalid collection fields: {target_id}")
        else:
            branch = target.get("defaultBranch")
            if target.get("forge") not in VALID_FORGES or not isinstance(branch, str) or not branch.strip():
                raise ContractError(f"invalid Git target fields: {target_id}")
            remote = target.get("remote")
            if not isinstance(remote, str) or not remote:
                raise ContractError(f"missing remote: {target_id}")
            normalized = normalize_remote(remote)
            if normalized in remotes and target.get("active"):
                raise ContractError(f"duplicate active remote: {remote}")
            if target.get("active"):
                remotes.add(normalized)

    # Eltern werden exakt deklariert, damit Discovery keine unbekannten Ziele legitimiert.
    # Parents are explicit so discovery cannot legitimize unknown targets.
    for target in targets:
        if target["level"] != 2:
            continue
        parent = pathlib.PurePosixPath(target["path"]).parent
        parent_target = paths.get(parent.as_posix().casefold())
        if not parent_target or parent_target["level"] != 1 or not parent_target.get("active"):
            raise ContractError(f"orphan Level-2 target: {target['id']}")
    return data


def target_result(target: dict, **values: object) -> dict:
    result = {
        "targetId": target["id"],
        "path": target["path"],
        "kind": target["kind"],
        "maintenanceClass": target["maintenanceClass"],
        "status": "CURRENT",
        "action": "NONE",
        "result": "Pass",
        "branch": target.get("defaultBranch", "N/A"),
        "upstream": "N/A",
        "ahead": 0,
        "behind": 0,
        "findingCode": "N/A",
        "nextAction": "N/A",
    }
    result.update(values)
    return result


def classify_repository(target: dict, path: pathlib.Path, mode: str) -> dict:
    if path.is_symlink() or (path.exists() and not path.is_dir()):
        return target_result(target, status="PATH_CONFLICT", result="Blocked", findingCode="PathConflict",
                             nextAction="Konfliktpfad nach manueller Prüfung entfernen oder verschieben / remove or relocate it after review.")
    if not path.exists():
        if mode == "check-only":
            return target_result(target, status="MISSING", action="CLONE_REQUIRED", result="Blocked",
                                 findingCode="MissingTarget", nextAction="Nach Remote-Prüfung im Update-Modus ausführen / run update after reviewing the remote.")
        if mode == "dry-run":
            return target_result(target, status="MISSING", action="WOULD_CLONE", result="Warning",
                                 findingCode="MissingTarget", nextAction="Update-Modus zum Klonen ausführen / run update to clone this target.")
        return clone_repository(target, path)
    if not (path / ".git").exists():
        return target_result(target, status="PATH_CONFLICT", result="Blocked", findingCode="PathConflict",
                             nextAction="Nicht-Git-Verzeichnis prüfen; es wird nie automatisch entfernt / review the directory; it is never removed.")

    branch = run_git(path, "symbolic-ref", "--quiet", "--short", "HEAD", check=False)
    if branch.returncode != 0:
        return target_result(target, status="DETACHED", result="Blocked", findingCode="DetachedHead",
                             nextAction="Deklarierten Branch manuell auswählen / select the declared branch manually.")
    branch_name = branch.stdout.strip()
    if branch_name != target["defaultBranch"]:
        return target_result(target, status="BRANCH_MISMATCH", result="Blocked", branch=branch_name,
                             findingCode="BranchMismatch", nextAction="Nach Prüfung zum deklarierten Branch wechseln / switch after review.")
    origin = run_git(path, "remote", "get-url", "origin", check=False)
    if origin.returncode != 0 or normalize_remote(origin.stdout) != normalize_remote(target["remote"]):
        return target_result(target, status="REMOTE_MISMATCH", result="Blocked", branch=branch_name,
                             findingCode="RemoteMismatch", nextAction="origin nur nach manueller Prüfung korrigieren / correct origin only after review.")
    dirty = run_git(path, "status", "--porcelain=v1", "--untracked-files=all").stdout
    if dirty:
        return target_result(target, status="DIRTY", result="Blocked", branch=branch_name,
                             findingCode="DirtyWorktree", nextAction="Lokale Arbeit ausdrücklich committen, stashen oder verwerfen / handle local work explicitly.")
    if mode != "dry-run":
        fetch = run_git(path, "fetch", "--prune", check=False)
        if fetch.returncode != 0:
            return target_result(target, status="UNAVAILABLE", result="Blocked", branch=branch_name,
                                 findingCode="FetchFailed", nextAction="Remote-Zugriff wiederherstellen und erneut ausführen / restore access and retry.")
    upstream = run_git(path, "rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{upstream}", check=False)
    if upstream.returncode != 0:
        return target_result(target, status="MISSING_UPSTREAM", result="Blocked", branch=branch_name,
                             findingCode="MissingUpstream", nextAction="Deklarierten origin-Branch als Upstream setzen / set the declared origin branch as upstream.")
    upstream_name = upstream.stdout.strip()
    counts = run_git(path, "rev-list", "--left-right", "--count", f"HEAD...{upstream_name}").stdout.split()
    ahead, behind = map(int, counts)
    if ahead and behind:
        return target_result(target, status="DIVERGED", result="Blocked", branch=branch_name, upstream=upstream_name,
                             ahead=ahead, behind=behind, findingCode="Diverged",
                             nextAction="Divergenz manuell lösen; kein Reset oder Force-Push / resolve manually; no reset or force push.")
    if ahead:
        return target_result(target, status="AHEAD", result="Blocked", branch=branch_name, upstream=upstream_name,
                             ahead=ahead, findingCode="Ahead", nextAction="Lokale Commits separat prüfen und pushen / review and push separately.")
    if behind:
        if mode == "check-only":
            return target_result(target, status="BEHIND", action="PULL_REQUIRED", result="Blocked",
                                 branch=branch_name, upstream=upstream_name, behind=behind,
                                 findingCode="Behind", nextAction="Update-Modus für Fast-forward ausführen / run update for fast-forward.")
        if mode == "dry-run":
            return target_result(target, status="BEHIND", action="WOULD_PULL", result="Warning",
                                 branch=branch_name, upstream=upstream_name, behind=behind,
                                 findingCode="Behind", nextAction="Update-Modus zum Fast-forward ausführen / run update to fast-forward.")
        pull = run_git(path, "pull", "--ff-only", check=False)
        if pull.returncode != 0:
            return target_result(target, status="UNAVAILABLE", action="PULL", result="Failed",
                                 branch=branch_name, upstream=upstream_name, behind=behind,
                                 findingCode="PullFailed", nextAction="Log prüfen, manuell reparieren und erneut ausführen / inspect, repair and retry.")
        return target_result(target, status="UPDATED", action="PULL", branch=branch_name, upstream=upstream_name)
    return target_result(target, branch=branch_name, upstream=upstream_name)


def clone_repository(target: dict, path: pathlib.Path) -> dict:
    path.parent.mkdir(parents=True, exist_ok=True)
    # Erst der geprüfte Geschwisterklon wird atomar sichtbar; Teilklone bleiben nie Sollzustand.
    # Only a verified sibling becomes visible; partial clones never become desired state.
    temporary = pathlib.Path(tempfile.mkdtemp(prefix=f".{path.name}.clone-", dir=path.parent))
    try:
        shutil.rmtree(temporary)
        clone = run_git(None, "clone", "--origin", "origin", "--branch", target["defaultBranch"],
                        "--single-branch", "--", target["remote"], str(temporary), check=False)
        if clone.returncode != 0:
            return target_result(target, status="UNAVAILABLE", action="CLONE", result="Failed",
                                 findingCode="CloneFailed", nextAction="Remote prüfen und erneut ausführen; Ziel nicht akzeptiert / inspect and retry; target not accepted.")
        origin = run_git(temporary, "remote", "get-url", "origin").stdout
        branch = run_git(temporary, "branch", "--show-current").stdout.strip()
        dirty = run_git(temporary, "status", "--porcelain=v1", "--untracked-files=all").stdout
        if normalize_remote(origin) != normalize_remote(target["remote"]) or branch != target["defaultBranch"] or dirty:
            return target_result(target, status="UNAVAILABLE", action="CLONE", result="Failed",
                                 findingCode="CloneVerificationFailed",
                                 nextAction="Temporäre Clone-Evidence prüfen; Ziel nicht akzeptiert / inspect clone evidence; target not accepted.")
        os.replace(temporary, path)
        return target_result(target, status="CREATED", action="CLONE", branch=branch,
                             upstream=f"origin/{branch}")
    finally:
        if temporary.exists():
            shutil.rmtree(temporary, ignore_errors=True)


def collection_result(target: dict, path: pathlib.Path, mode: str) -> dict:
    if path.is_symlink() or (path.exists() and not path.is_dir()):
        return target_result(target, status="PATH_CONFLICT", result="Blocked", findingCode="PathConflict",
                             nextAction="Konfliktpfad nach manueller Prüfung entfernen oder verschieben / remove or relocate it after review.")
    if path.exists():
        return target_result(target)
    if mode == "check-only":
        return target_result(target, status="MISSING", action="CREATE_REQUIRED", result="Blocked",
                             findingCode="MissingCollection", nextAction="Update-Modus zum Erstellen der Collection ausführen / run update to create it.")
    if mode == "dry-run":
        return target_result(target, status="MISSING", action="WOULD_CREATE", result="Warning",
                             findingCode="MissingCollection", nextAction="Update-Modus zum Erstellen der Collection ausführen / run update to create it.")
    path.mkdir(parents=True)
    return target_result(target, status="CREATED", action="CREATE")


def derive_status(results: list[dict], mode: str) -> tuple[str, int]:
    if any(item["result"] == "Failed" for item in results):
        return "PARTIAL", 1
    if any(item["result"] == "Blocked" for item in results):
        return "DRIFT", 1
    if any(item["result"] == "Warning" for item in results):
        return "DRIFT", 1
    return "SUCCESS", 0


def write_report(path: pathlib.Path, report: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    # Der atomare Austausch erhält die letzte vollständige Evidence bei Schreibfehlern.
    # Atomic replacement preserves the last complete evidence on write failure.
    temporary = path.with_name(f".{path.name}.{uuid.uuid4().hex}.tmp")
    temporary.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    os.replace(temporary, path)


def execute_fleet(args: argparse.Namespace) -> int:
    started = time.monotonic()
    started_at = utc_now()
    run_id = args.run_id or str(uuid.uuid4())
    try:
        manifest = load_manifest(args.manifest)
    except ContractError as exc:
        report = {
            "schemaVersion": "1.0", "runId": run_id, "platform": sys.platform, "mode": args.mode,
            "startedAt": started_at, "completedAt": utc_now(), "overallStatus": "FAILED", "exitCode": 2,
            "stages": [{"stageId": "fleet", "status": "Failed", "exitCode": 2, "durationMs": 0,
                        "summary": str(exc), "nextAction": "Manifest korrigieren und erneut ausführen / correct the manifest and retry."}],
            "targets": [], "toolchain": [], "findings": [{"code": "ManifestInvalid", "severity": "Fatal",
            "summary": str(exc), "nextAction": "Manifest korrigieren und erneut ausführen / correct the manifest and retry."}],
            "artifacts": {"logPath": str(args.log), "reportPath": str(args.report)}
        }
        write_report(args.report, report)
        print(f"ERROR\tmanifest\tFAILED\t{exc}")
        return 2

    home = args.home_dir.resolve()
    results: list[dict] = []
    for target in manifest["targets"]:
        if not target["active"]:
            continue
        relative = validate_relative_path(target["path"])
        target_path = home.joinpath(*relative.parts)
        result = (collection_result(target, target_path, args.mode)
                  if target["kind"] == "collection"
                  else classify_repository(target, target_path, args.mode))
        results.append(result)
        print(f"TARGET\t{target['id']}\t{result['status']}\t{result['action']}\t{result['nextAction']}")

    overall, exit_code = derive_status(results, args.mode)
    findings = [
        {"targetId": item["targetId"], "code": item["findingCode"],
         "severity": "Blocking" if item["result"] in {"Blocked", "Failed"} else "Warning",
         "summary": item["status"], "nextAction": item["nextAction"]}
        for item in results if item["findingCode"] != "N/A"
    ]
    report = {
        "schemaVersion": "1.0", "runId": run_id, "platform": sys.platform, "mode": args.mode,
        "startedAt": started_at, "completedAt": utc_now(), "overallStatus": overall, "exitCode": exit_code,
        "stages": [{"stageId": "fleet", "status": "Passed" if exit_code == 0 else "Blocked",
                    "exitCode": exit_code, "durationMs": int((time.monotonic() - started) * 1000),
                    "summary": f"{len(results)} active targets evaluated.",
                    "nextAction": "N/A" if exit_code == 0 else "Blockierende Zielbefunde beheben / resolve blocking target findings."}],
        "targets": results, "toolchain": [], "findings": findings,
        "counts": {
            "targets": len(results),
            "passed": sum(item["result"] == "Pass" for item in results),
            "warnings": sum(item["result"] == "Warning" for item in results),
            "blocked": sum(item["result"] == "Blocked" for item in results),
            "failed": sum(item["result"] == "Failed" for item in results)
        },
        "artifacts": {"logPath": str(args.log), "reportPath": str(args.report)}
    }
    write_report(args.report, report)
    print(f"SUMMARY\tfleet\t{overall}\t{exit_code}\t{args.report}")
    return exit_code


def record_stage(args: argparse.Namespace) -> int:
    try:
        report = json.loads(args.report.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"ERROR\treport\tFAILED\t{exc}")
        return 2
    stages = report.setdefault("stages", [])
    stages[:] = [item for item in stages if item.get("stageId") != args.stage_id]
    stages.append({
        "stageId": args.stage_id,
        "status": args.status,
        "exitCode": args.exit_code,
        "durationMs": args.duration_ms,
        "summary": args.summary,
        "nextAction": args.next_action,
    })
    report["completedAt"] = utc_now()
    statuses = {item.get("status") for item in stages}
    if "Failed" in statuses:
        report["overallStatus"], report["exitCode"] = "FAILED", 2
    elif "Blocked" in statuses:
        report["overallStatus"], report["exitCode"] = "PARTIAL", 1
    elif "Warning" in statuses and report.get("overallStatus") == "SUCCESS":
        report["overallStatus"] = "SUCCESS_WITH_WARNINGS"
    write_report(args.report, report)
    return 0


def validate_registry(args: argparse.Namespace) -> int:
    try:
        manifest = load_manifest(args.manifest)
        registry = json.loads(args.registry.read_text(encoding="utf-8-sig"))
    except (ContractError, OSError, UnicodeError, json.JSONDecodeError) as exc:
        print(f"REGISTRY\tFAILED\t{exc}")
        return 2
    expected = {
        item["path"].casefold()
        for item in manifest["targets"]
        if item["active"] and item["kind"] == "git-repository"
        and item["maintenanceClass"] == "canonical-fleet"
    }
    entries = registry.get("repositories", []) if isinstance(registry, dict) else registry
    if not isinstance(entries, list):
        print("REGISTRY\tFAILED\trepositories must be an array")
        return 2
    actual: set[str] = set()
    for entry in entries:
        if not isinstance(entry, dict) or not isinstance(entry.get("path"), str):
            print("REGISTRY\tFAILED\tinvalid repository entry")
            return 2
        path = validate_relative_path(entry["path"]).as_posix().casefold()
        if path not in expected:
            print(f"REGISTRY\tFAILED\tnon-canonical propagation target: {entry['path']}")
            return 2
        if path in actual:
            print(f"REGISTRY\tFAILED\tduplicate propagation target: {entry['path']}")
            return 2
        actual.add(path)
    missing = expected - actual
    if missing:
        print(f"REGISTRY\tDRIFT\tmissing canonical targets: {len(missing)}")
        return 1
    print(f"REGISTRY\tCURRENT\tcanonical targets: {len(actual)}")
    return 0


def list_canonical_repositories(args: argparse.Namespace) -> int:
    """Print active canonical Git repositories as level/path TSV records."""
    try:
        manifest = load_manifest(args.manifest)
    except ContractError as exc:
        print(f"REPOSITORIES\tFAILED\t{exc}", file=sys.stderr)
        return 2

    home = args.home_dir.resolve()
    repositories: list[tuple[int, pathlib.Path]] = []
    for target in manifest["targets"]:
        if (
            not target["active"]
            or target["kind"] != "git-repository"
            or target["maintenanceClass"] != "canonical-fleet"
        ):
            continue
        relative = validate_relative_path(target["path"])
        repository = home.joinpath(*relative.parts).resolve()
        try:
            repository.relative_to(home)
        except ValueError:
            print(
                f"REPOSITORIES\tFAILED\ttarget resolves outside HOME: {target['path']}",
                file=sys.stderr,
            )
            return 2
        if args.existing_only and not (repository / ".git").is_dir():
            continue
        repositories.append((target["level"], repository))

    for level, repository in sorted(repositories, key=lambda item: (item[0], str(item[1]).casefold())):
        print(f"{level}\t{repository}")
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)
    fleet = subparsers.add_parser("fleet")
    fleet.add_argument("--manifest", type=pathlib.Path, required=True)
    fleet.add_argument("--home-dir", type=pathlib.Path, required=True)
    fleet.add_argument("--mode", choices=("check-only", "dry-run", "update"), required=True)
    fleet.add_argument("--report", type=pathlib.Path, required=True)
    fleet.add_argument("--log", type=pathlib.Path, required=True)
    fleet.add_argument("--run-id")
    fleet.set_defaults(handler=execute_fleet)
    stage = subparsers.add_parser("stage")
    stage.add_argument("--report", type=pathlib.Path, required=True)
    stage.add_argument("--stage-id", required=True)
    stage.add_argument("--status", choices=("Passed", "Warning", "Blocked", "Failed", "Skipped"), required=True)
    stage.add_argument("--exit-code", type=int, required=True)
    stage.add_argument("--duration-ms", type=int, default=0)
    stage.add_argument("--summary", required=True)
    stage.add_argument("--next-action", default="N/A")
    stage.set_defaults(handler=record_stage)
    registry = subparsers.add_parser("registry")
    registry.add_argument("--manifest", type=pathlib.Path, required=True)
    registry.add_argument("--registry", type=pathlib.Path, required=True)
    registry.set_defaults(handler=validate_registry)
    repositories = subparsers.add_parser("canonical-repositories")
    repositories.add_argument("--manifest", type=pathlib.Path, required=True)
    repositories.add_argument("--home-dir", type=pathlib.Path, required=True)
    repositories.add_argument("--existing-only", action="store_true")
    repositories.set_defaults(handler=list_canonical_repositories)
    return parser


def main() -> int:
    arguments = build_parser().parse_args()
    return arguments.handler(arguments)


if __name__ == "__main__":
    raise SystemExit(main())
