#!/usr/bin/env python3
"""Contract, integration, parity, and mutation tests for CI budget governance."""

from __future__ import annotations

import copy
import importlib.util
import json
import pathlib
import os
import subprocess
import tempfile
import unittest
from unittest import mock


ROOT = pathlib.Path(__file__).resolve().parents[2]
ENGINE_PATH = ROOT / "scripts/lib/agentic_workspace_fleet.py"
FIXTURES = pathlib.Path(__file__).resolve().parent / "ci-budget-governance/fixtures"


def load_engine():
    spec = importlib.util.spec_from_file_location("agentic_workspace_fleet", ENGINE_PATH)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


class ContractBoundaryTests(unittest.TestCase):
    """The red-first contract slice rejects every accepted unsafe boundary."""

    @classmethod
    def setUpClass(cls):
        cls.engine = load_engine()
        cls.profiles_path = ROOT / "scripts/config/ci-budget-profiles.json"
        cls.paths_path = ROOT / "scripts/config/ci-budget-path-contracts.json"
        cls.workflow_path = (
            ROOT / "scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml"
        )
        cls.negative = json.loads(
            (FIXTURES / "contracts/negative-cases.json").read_text(encoding="utf-8")
        )

    def test_valid_contracts_load_once_and_have_separate_hashes(self):
        contracts = self.engine.load_ci_budget_contracts(
            self.profiles_path, self.paths_path, self.workflow_path
        )
        self.assertRegex(contracts["profileRegistryHash"], r"^[0-9a-f]{64}$")
        self.assertRegex(contracts["pathContractHash"], r"^[0-9a-f]{64}$")
        self.assertNotEqual(
            contracts["profileRegistryHash"], contracts["pathContractHash"]
        )
        self.assertEqual(contracts["loadCounts"], {"profiles": 1, "paths": 1})

    def test_unknown_gate_reference_is_rejected(self):
        paths = json.loads(self.paths_path.read_text(encoding="utf-8"))
        paths["pathContracts"][0]["gateIds"] = [self.negative["unknownGateId"]]
        self._assert_mutated_contract_rejected(paths=paths)

    def test_unknown_product_job_reference_is_rejected(self):
        paths = json.loads(self.paths_path.read_text(encoding="utf-8"))
        product = next(item for item in paths["pathContracts"] if item["category"] == "product")
        product["productJobId"] = self.negative["unknownProductJobId"]
        self._assert_mutated_contract_rejected(paths=paths)

    def test_second_embedded_path_contract_source_is_rejected(self):
        profiles = json.loads(self.profiles_path.read_text(encoding="utf-8"))
        profiles["pathContracts"] = []
        self._assert_mutated_contract_rejected(profiles=profiles)

    def test_schema_extra_fields_are_rejected(self):
        profiles = json.loads(self.profiles_path.read_text(encoding="utf-8"))
        profiles["profiles"][0]["unexpected"] = self.negative["extraProfileField"]
        self._assert_mutated_contract_rejected(profiles=profiles)

    def test_unsafe_components_are_rejected(self):
        for value in self.negative["unsafeValues"]:
            with self.subTest(value=repr(value)):
                with self.assertRaises(self.engine.ContractError):
                    self.engine.validate_ci_input_component(value)

    def test_symlink_escape_is_rejected(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            root = pathlib.Path(temp_dir)
            outside = root.parent / "outside-ci-budget-governance"
            link = root / "link"
            link.symlink_to(outside)
            with self.assertRaises(self.engine.ContractError):
                self.engine.resolve_ci_contained_path(root, pathlib.PurePosixPath("link/file"))

    def test_denormalized_profile_id_mismatch_is_rejected(self):
        mismatch = self.negative["denormalizedProfileMismatch"]
        with self.assertRaises(self.engine.ContractError):
            self.engine.require_matching_profile_ids(
                "fixture-repository", mismatch["assignment"], mismatch["inventory"]
            )

    def _assert_mutated_contract_rejected(self, *, profiles=None, paths=None):
        with tempfile.TemporaryDirectory() as temp_dir:
            temporary = pathlib.Path(temp_dir)
            profile_file = temporary / "profiles.json"
            path_file = temporary / "paths.json"
            profile_file.write_text(
                json.dumps(
                    profiles
                    if profiles is not None
                    else json.loads(self.profiles_path.read_text(encoding="utf-8"))
                ),
                encoding="utf-8",
            )
            path_file.write_text(
                json.dumps(
                    paths
                    if paths is not None
                    else json.loads(self.paths_path.read_text(encoding="utf-8"))
                ),
                encoding="utf-8",
            )
            with self.assertRaises(self.engine.ContractError):
                self.engine.load_ci_budget_contracts(
                    profile_file, path_file, self.workflow_path
                )


class VerticalSliceTests(unittest.TestCase):
    """Bash and PowerShell must each start exactly one shared engine process."""

    HEAD = "a" * 40

    def _run_wrapper(self, command: list[str]) -> tuple[subprocess.CompletedProcess[str], int]:
        with tempfile.TemporaryDirectory() as temporary_dir:
            temporary = pathlib.Path(temporary_dir)
            counter = temporary / "engine-count.txt"
            evidence = temporary / "evidence"
            env = os.environ.copy()
            env.update(
                {
                    "HOME": str(temporary / "home"),
                    "HB_CI_PROFILES": str(FIXTURES / "vertical-slice/profiles.json"),
                    "HB_CI_PATH_CONTRACTS": str(FIXTURES / "vertical-slice/path-contracts.json"),
                    "HB_CI_REPOSITORY_ID": "private-governance-fixture",
                    "HB_CI_FIXTURE_HEAD": self.HEAD,
                    "HB_CI_EVIDENCE_ROOT": str(evidence),
                    "HB_CI_ENGINE_COUNTER_FILE": str(counter),
                }
            )
            completed = subprocess.run(
                command, cwd=ROOT, env=env, text=True, capture_output=True, check=False
            )
            starts = len(counter.read_text(encoding="utf-8").splitlines()) if counter.exists() else 0
            self.assertFalse(any(evidence.rglob("*.json")))
            return completed, starts

    def test_bash_and_powershell_preview_share_contract_and_one_process(self):
        bash_result, bash_starts = self._run_wrapper(
            ["bash", "scripts/maintain-agentic-workspace.sh", "--ci-gate", "--dry-run"]
        )
        powershell_result, powershell_starts = self._run_wrapper(
            ["pwsh", "-NoProfile", "-File", "scripts/maintain-agentic-workspace.ps1", "-CiGate", "-WhatIf"]
        )
        self.assertEqual(bash_result.returncode, 0, bash_result.stderr)
        self.assertEqual(powershell_result.returncode, 0, powershell_result.stderr)
        self.assertEqual(bash_starts, 1)
        self.assertEqual(powershell_starts, 1)
        expected_order = [
            "Profil / Profile:", "Entscheidung / Decision:", "Status:", "Blocker:",
            "Naechste Aktion / Next action:", "Gate-Set-Hash:",
        ]
        for result in (bash_result, powershell_result):
            positions = [result.stdout.index(label) for label in expected_order]
            self.assertEqual(positions, sorted(positions))
        bash_hash = next(line for line in bash_result.stdout.splitlines() if line.startswith("Gate-Set-Hash:"))
        powershell_hash = next(line for line in powershell_result.stdout.splitlines() if line.startswith("Gate-Set-Hash:"))
        self.assertEqual(bash_hash, powershell_hash)

    def _engine_command(
        self,
        profiles: pathlib.Path,
        paths: pathlib.Path,
        evidence: pathlib.Path,
        *extra: str,
    ) -> list[str]:
        return [
            "python3", "scripts/lib/agentic_workspace_fleet.py", "ci-gate",
            "--repository-root", ".", "--profiles", str(profiles),
            "--path-contracts", str(paths),
            "--workflow-template", str(ROOT / "scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml"),
            "--repository-id", "private-governance-fixture",
            "--fixture-head", self.HEAD,
            "--evidence-root", str(evidence),
            *extra,
        ]

    def _mutated_profiles(self, temporary: pathlib.Path, mutation) -> pathlib.Path:
        source = json.loads((FIXTURES / "vertical-slice/profiles.json").read_text(encoding="utf-8"))
        mutation(source)
        destination = temporary / "profiles.json"
        destination.write_text(json.dumps(source), encoding="utf-8")
        return destination

    def test_real_slice_publishes_ordered_atomic_success(self):
        with tempfile.TemporaryDirectory() as temporary_dir:
            temporary = pathlib.Path(temporary_dir)
            evidence_root = temporary / "evidence"
            completed = subprocess.run(
                self._engine_command(
                    FIXTURES / "vertical-slice/profiles.json",
                    FIXTURES / "vertical-slice/path-contracts.json",
                    evidence_root,
                ),
                cwd=ROOT, text=True, capture_output=True, check=False,
            )
            self.assertEqual(completed.returncode, 0, completed.stderr)
            evidence_path = evidence_root / "private-governance-fixture" / f"{self.HEAD}.json"
            payload = json.loads(evidence_path.read_text(encoding="utf-8"))
            self.assertEqual(
                list(payload),
                ["schemaVersion", "repositoryId", "headCommit", "ciProfile", "gateSetHash", "platform", "generatedAt", "hookVersion", "status", "results"],
            )
            self.assertEqual([item["order"] for item in payload["results"]], [1, 2])
            self.assertEqual(evidence_path.stat().st_mode & 0o777, 0o600)
            self.assertFalse(any(evidence_path.parent.glob(f".{evidence_path.name}.*")))

    def test_sparse_selected_gate_subset_is_reindexed_in_executed_evidence(self):
        with tempfile.TemporaryDirectory() as temporary_dir:
            evidence_root = pathlib.Path(temporary_dir) / "evidence"
            completed = subprocess.run(
                [
                    "python3", "scripts/lib/agentic_workspace_fleet.py", "ci-gate",
                    "--repository-root", ".",
                    "--profiles", "scripts/config/ci-budget-profiles.json",
                    "--path-contracts", "scripts/config/ci-budget-path-contracts.json",
                    "--workflow-template", "scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml",
                    "--repository-id", "home-baseline",
                    "--fixture-head", self.HEAD,
                    "--evidence-root", str(evidence_root),
                    "--changed-path", "docs/security/security-checklist.md",
                ],
                cwd=ROOT,
                text=True,
                capture_output=True,
                check=False,
            )
            self.assertEqual(completed.returncode, 0, completed.stderr)
            payload = json.loads(
                (evidence_root / "home-baseline" / f"{self.HEAD}.json").read_text(
                    encoding="utf-8"
                )
            )
            self.assertEqual([item["order"] for item in payload["results"]], [1, 2])
            self.assertEqual(
                [item["gateId"] for item in payload["results"]],
                ["security-contract", "documentation-contract"],
            )

    def test_preview_does_not_replace_existing_evidence(self):
        with tempfile.TemporaryDirectory() as temporary_dir:
            temporary = pathlib.Path(temporary_dir)
            evidence_root = temporary / "evidence"
            existing = evidence_root / "private-governance-fixture" / f"{self.HEAD}.json"
            existing.parent.mkdir(parents=True)
            existing.write_text('{"sentinel":true}\n', encoding="utf-8")
            completed = subprocess.run(
                self._engine_command(
                    FIXTURES / "vertical-slice/profiles.json",
                    FIXTURES / "vertical-slice/path-contracts.json",
                    evidence_root,
                    "--dry-run",
                ),
                cwd=ROOT, text=True, capture_output=True, check=False,
            )
            self.assertEqual(completed.returncode, 0, completed.stderr)
            self.assertEqual(existing.read_text(encoding="utf-8"), '{"sentinel":true}\n')

    def test_gate_failure_invalidates_old_success(self):
        with tempfile.TemporaryDirectory() as temporary_dir:
            temporary = pathlib.Path(temporary_dir)
            profiles = self._mutated_profiles(
                temporary,
                lambda value: value["gateSets"][0]["gates"][1].update(
                    {"arguments": ["-c", "raise SystemExit(7)"]}
                ),
            )
            evidence_root = temporary / "evidence"
            existing = evidence_root / "private-governance-fixture" / f"{self.HEAD}.json"
            existing.parent.mkdir(parents=True)
            existing.write_text('{"status":"Passed"}\n', encoding="utf-8")
            completed = subprocess.run(
                self._engine_command(profiles, FIXTURES / "vertical-slice/path-contracts.json", evidence_root),
                cwd=ROOT, text=True, capture_output=True, check=False,
            )
            self.assertEqual(completed.returncode, 1)
            self.assertFalse(existing.exists())

    def test_missing_gate_and_timeout_fail_without_evidence(self):
        mutations = (
            lambda value: value["gateSets"][0]["gates"][0].update({"executable": "definitely-missing-ci-tool"}),
            lambda value: value["gateSets"][0]["gates"][0].update(
                {"arguments": ["-c", "import time; time.sleep(2)"], "timeoutSeconds": 1}
            ),
        )
        for mutation in mutations:
            with self.subTest(mutation=mutation), tempfile.TemporaryDirectory() as temporary_dir:
                temporary = pathlib.Path(temporary_dir)
                profiles = self._mutated_profiles(temporary, mutation)
                evidence = temporary / "evidence"
                completed = subprocess.run(
                    self._engine_command(profiles, FIXTURES / "vertical-slice/path-contracts.json", evidence),
                    cwd=ROOT, text=True, capture_output=True, check=False,
                )
                self.assertNotEqual(completed.returncode, 0)
                self.assertFalse(any(evidence.rglob("*.json")))

    def test_head_change_fails_closed(self):
        with tempfile.TemporaryDirectory() as temporary_dir:
            temporary = pathlib.Path(temporary_dir)
            sequence = temporary / "heads.txt"
            sequence.write_text(f"{self.HEAD}\n{'b' * 40}\n", encoding="utf-8")
            env = os.environ.copy()
            env["HB_CI_HEAD_SEQUENCE_FILE"] = str(sequence)
            command = self._engine_command(
                FIXTURES / "vertical-slice/profiles.json",
                FIXTURES / "vertical-slice/path-contracts.json",
                temporary / "evidence",
            )
            head_index = command.index("--fixture-head")
            del command[head_index:head_index + 2]
            completed = subprocess.run(command, cwd=ROOT, env=env, text=True, capture_output=True, check=False)
            self.assertEqual(completed.returncode, 1)
            self.assertFalse(any((temporary / "evidence").rglob("*.json")))

    def test_gate_set_change_fails_closed(self):
        with tempfile.TemporaryDirectory() as temporary_dir:
            temporary = pathlib.Path(temporary_dir)
            profiles = self._mutated_profiles(temporary, lambda value: None)
            mutation_code = (
                "import json,pathlib;"
                f"p=pathlib.Path({str(profiles)!r});"
                "d=json.loads(p.read_text());"
                "d['gateSets'][0]['version']='1.0.1';"
                "p.write_text(json.dumps(d))"
            )
            value = json.loads(profiles.read_text(encoding="utf-8"))
            value["gateSets"][0]["gates"][0]["arguments"] = ["-c", mutation_code]
            profiles.write_text(json.dumps(value), encoding="utf-8")
            evidence = temporary / "evidence"
            completed = subprocess.run(
                self._engine_command(profiles, FIXTURES / "vertical-slice/path-contracts.json", evidence),
                cwd=ROOT, text=True, capture_output=True, check=False,
            )
            self.assertEqual(completed.returncode, 1, completed.stderr)
            self.assertFalse(any(evidence.rglob("*.json")))

    def test_symlink_parent_and_metachar_repository_id_are_rejected(self):
        with tempfile.TemporaryDirectory() as temporary_dir:
            temporary = pathlib.Path(temporary_dir)
            target = temporary / "target"
            target.mkdir()
            link = temporary / "evidence-link"
            link.symlink_to(target)
            for evidence, repository_id in ((link, "private-governance-fixture"), (temporary / "safe", "bad;id")):
                command = self._engine_command(
                    FIXTURES / "vertical-slice/profiles.json",
                    FIXTURES / "vertical-slice/path-contracts.json",
                    evidence,
                )
                repository_index = command.index("--repository-id")
                command[repository_index + 1] = repository_id
                completed = subprocess.run(command, cwd=ROOT, text=True, capture_output=True, check=False)
                self.assertEqual(completed.returncode, 2)
            self.assertFalse(any(target.rglob("*.json")))

    def test_keyboard_interrupt_maps_to_130(self):
        engine = load_engine()
        with mock.patch.object(engine, "load_ci_budget_contracts", side_effect=KeyboardInterrupt):
            namespace = mock.Mock()
            self.assertEqual(engine.execute_ci_gate(namespace), 130)


class _FleetFixtureMixin:
    @classmethod
    def setUpClass(cls):
        cls.engine = load_engine()
        cls.profiles_path = ROOT / "scripts/config/ci-budget-profiles.json"
        cls.paths_path = ROOT / "scripts/config/ci-budget-path-contracts.json"
        cls.workflow_path = ROOT / "scripts/templates/ci-budget-governance/private-governance-minimal-gate.yml"
        cls.ruleset_path = ROOT / "scripts/templates/ci-budget-governance/private-governance-ruleset.json"
        cls.contracts = cls.engine.load_ci_budget_contracts(
            cls.profiles_path, cls.paths_path, cls.workflow_path
        )
        cls.manifest = json.loads(
            (ROOT / "scripts/config/agentic-workspace-fleet.json").read_text(encoding="utf-8")
        )
        cls.authoritative = cls.engine.authoritative_ci_repositories(
            ROOT, cls.manifest, cls.contracts["profiles"]
        )
        profile_by_id = {
            item["profileId"]: item for item in cls.contracts["profiles"]["profiles"]
        }
        cls.raw_rows = [
            {
                "repositoryId": item["repositoryId"],
                "remoteIdentity": item["remoteIdentity"],
                "visibility": profile_by_id[item["assignmentProfileId"]]["requiredVisibility"],
                "defaultBranch": item["defaultBranch"],
                "workflows": [],
            }
            for item in cls.authoritative
        ]

    def validated_rows(self, rows=None):
        return self.engine.validate_ci_inventory(
            copy.deepcopy(self.raw_rows if rows is None else rows),
            self.authoritative,
            self.contracts["profiles"],
            source_revision="fixture-full-48-v1",
            observed_at="2026-08-20T00:00:00Z",
        )


class HookEvidenceRulesetTests(_FleetFixtureMixin, unittest.TestCase):
    """The local hook and the independent server contract fail closed."""

    def test_private_governance_policy_is_lean_and_independent_of_hook(self):
        policy = self.engine.simulate_private_governance_policy(
            self.workflow_path, self.ruleset_path
        )
        self.assertTrue(policy["pullRequestRequired"])
        self.assertEqual(policy["requiredStatusChecks"], ["home-baseline/ci-minimal-gate"])
        self.assertEqual(policy["blockedWritePaths"], ["api", "direct", "web"])
        self.assertFalse(policy["adminBypassNormalPath"])
        self.assertFalse(policy["remoteConverged"])
        self.assertFalse(policy["hookRequiredForServerEnforcement"])

    def test_ruleset_negative_matrix_blocks_bypass_and_broad_workflows(self):
        workflow_source = self.workflow_path.read_text(encoding="utf-8")
        ruleset_source = json.loads(self.ruleset_path.read_text(encoding="utf-8"))
        mutations = [
            ("workflow", workflow_source.replace("  - pull_request", "  - push")),
            ("workflow", workflow_source.replace("fullBuild: false", "fullBuild: true")),
            ("workflow", workflow_source.replace("pathDependent: true", "pathDependent: false")),
            ("ruleset", {**ruleset_source, "requiredStatusChecks": []}),
            ("ruleset", {**ruleset_source, "requiredStatusChecks": ["a", "b"]}),
            ("ruleset", {**ruleset_source, "blockedWritePaths": ["direct", "web"]}),
            ("ruleset", {**ruleset_source, "adminBypassNormalPath": True}),
            ("ruleset", {**ruleset_source, "remoteConverged": True}),
        ]
        for kind, mutation in mutations:
            with self.subTest(kind=kind), tempfile.TemporaryDirectory() as temporary_dir:
                temporary = pathlib.Path(temporary_dir)
                workflow = temporary / "workflow.yml"
                ruleset = temporary / "ruleset.json"
                workflow.write_text(mutation if kind == "workflow" else workflow_source, encoding="utf-8")
                ruleset.write_text(
                    json.dumps(mutation if kind == "ruleset" else ruleset_source), encoding="utf-8"
                )
                with self.assertRaises(self.engine.CIGateBlocked):
                    self.engine.simulate_private_governance_policy(workflow, ruleset)

    def test_hook_keeps_secret_scan_and_exact_private_evidence_contract(self):
        source = (ROOT / "scripts/hooks/pre-push").read_text(encoding="utf-8")
        self.assertIn("run_gitleaks_range_scan", source)
        self.assertIn("verify_ci_gate_evidence", source)
        self.assertIn("hookVersion') == '1.0.0'", source)
        self.assertIn("gateSetHash", source)
        self.assertNotIn("git push", source)


class FleetClassificationTests(_FleetFixtureMixin, unittest.TestCase):
    """The Level-0 self record and 47 active Git targets map one-to-one."""

    def test_authoritative_union_has_48_rows_and_three_required_canaries(self):
        self.assertEqual(len(self.authoritative), 48)
        ids = {item["repositoryId"] for item in self.authoritative}
        self.assertIn("home-baseline", ids)
        self.assertNotIn("spec-kit-preset-projects", ids)
        assignments = {
            item["repositoryId"]: item["profileId"]
            for item in self.contracts["profiles"]["assignments"]
        }
        self.assertEqual(
            {key for key, value in assignments.items() if value == "public-canary"},
            {"home-baseline", "agent-operations-cockpit", "tui-vision"},
        )

    def test_complete_inventory_copies_assignment_and_orders_rows(self):
        rows = self.validated_rows()
        self.assertEqual([row["repositoryId"] for row in rows], sorted(row["repositoryId"] for row in rows))
        self.assertTrue(all("profileId" in row for row in rows))
        self.assertTrue(all("source" not in row and "sourceRevision" not in row for row in rows))

    def test_missing_duplicate_collection_visibility_and_profile_drift_block(self):
        cases = []
        missing = copy.deepcopy(self.raw_rows[:-1])
        cases.append(missing)
        duplicate = copy.deepcopy(self.raw_rows)
        duplicate[-1] = copy.deepcopy(duplicate[0])
        cases.append(duplicate)
        collection = copy.deepcopy(self.raw_rows)
        collection[0]["repositoryId"] = "spec-kit-preset-projects"
        cases.append(collection)
        visibility = copy.deepcopy(self.raw_rows)
        visibility[0]["visibility"] = "public" if visibility[0]["visibility"] == "private" else "private"
        cases.append(visibility)
        profile = copy.deepcopy(self.raw_rows)
        profile[0]["profileId"] = "public-canary"
        cases.append(profile)
        for rows in cases:
            with self.subTest(repository_count=len(rows)), self.assertRaises(self.engine.CIGateBlocked):
                self.validated_rows(rows)

    def test_fixture_snapshot_rejects_source_mix_and_partial_refresh(self):
        mixed = copy.deepcopy(self.raw_rows)
        mixed[0]["source"] = "GitHubReadOnly"
        with self.assertRaises(self.engine.ContractError):
            self.validated_rows(mixed)
        with self.assertRaises(self.engine.ContractError):
            self.engine.validate_ci_inventory(
                self.raw_rows, self.authoritative, self.contracts["profiles"],
                source_revision="", observed_at="2026-08-20T00:00:00Z",
            )

    def test_github_adapter_uses_minimized_get_only_rows(self):
        calls = []
        expected_by_slug = {
            self.engine._github_repository_slug(item["remoteIdentity"]): item
            for item in self.authoritative
        }
        profiles = {item["profileId"]: item for item in self.contracts["profiles"]["profiles"]}

        def transport(endpoint):
            calls.append(endpoint)
            item = expected_by_slug[endpoint.removeprefix("repos/")]
            return {
                "html_url": item["remoteIdentity"],
                "private": profiles[item["assignmentProfileId"]]["requiredVisibility"] == "private",
                "default_branch": item["defaultBranch"],
                "token": "must-not-propagate",
                "owner": {"login": "must-not-propagate"},
            }

        revision, observed, rows = self.engine.github_read_only_inventory(
            self.authoritative, transport=transport, observed_at="2026-08-20T00:00:00Z"
        )
        self.assertRegex(revision, r"^[0-9a-f]{64}$")
        self.assertEqual(observed, "2026-08-20T00:00:00Z")
        self.assertEqual(len(calls), 48)
        self.assertTrue(all(call.startswith("repos/") for call in calls))
        self.assertNotIn("token", json.dumps(rows))
        self.assertNotIn("must-not-propagate", json.dumps(rows))
        self.validated_rows(rows)

    def test_retry_is_bounded_and_auth_failure_is_not_retried(self):
        transient = subprocess.CompletedProcess(
            [], 1, "", "error connecting to api.github.com; check your internet connection"
        )
        success = subprocess.CompletedProcess([], 0, '{"ok":true}', "")
        with mock.patch("subprocess.run", side_effect=[transient, success]) as runner, mock.patch("time.sleep"):
            self.assertEqual(self.engine._github_get_json("repos/example/repo"), {"ok": True})
            self.assertEqual(runner.call_count, 2)
        auth = subprocess.CompletedProcess([], 1, "", "HTTP 401 authentication failed")
        with mock.patch("subprocess.run", return_value=auth) as runner:
            with self.assertRaises(self.engine.ContractError):
                self.engine._github_get_json("repos/example/repo")
            self.assertEqual(runner.call_count, 1)


class WorkflowPathBudgetTests(_FleetFixtureMixin, unittest.TestCase):
    """Path unions, five profiles, special jobs, and Decimal cost stay explicit."""

    def test_path_union_keeps_security_with_documentation_and_orders_jobs(self):
        decision = self.engine.evaluate_ci_paths(
            self.contracts, ["docs/security/threat-model.md", "scripts/hooks/pre-push"]
        )
        self.assertIn("security-paths", decision["matchedPathContractIds"])
        self.assertIn("documentation-paths", decision["matchedPathContractIds"])
        self.assertIn("security-contract", decision["gateIds"])
        docs_only = self.engine.evaluate_ci_paths(self.contracts, ["docs/guide.md"])
        self.assertEqual(docs_only["productJobIds"], [])

    def test_six_casetracker_jobs_are_deduplicated(self):
        paths = [
            f"SecureCaseTrackerProjects/SecureCaseTracker-{language}/src/file.txt"
            for language in ("CSharp", "Go", "Java", "Python", "Rust", "Swift")
        ]
        decision = self.engine.evaluate_ci_paths(self.contracts, paths + paths)
        self.assertEqual(len(decision["productJobIds"]), 6)
        self.assertEqual(decision["productJobIds"], sorted(decision["productJobIds"]))

    def test_private_profiles_have_no_automatic_main_full_build(self):
        paths = self.engine.evaluate_ci_paths(
            self.contracts, ["SecureCaseTrackerProjects/SecureCaseTracker-Swift/src/App.swift"]
        )
        pr = self.engine.simulate_ci_workflow_policy(
            "private-product", "secure-casetracker-swift", "pull_request", paths
        )
        self.assertEqual(pr["plannedJobs"], [{"jobId": "casetracker-swift", "runner": "ubuntu-latest"}])
        main = self.engine.simulate_ci_workflow_policy(
            "private-product", "secure-casetracker-swift", "push", paths
        )
        self.assertEqual(main["gateDecision"], "Blocked")
        self.assertEqual(main["plannedJobs"], [])
        macos = self.engine.simulate_ci_workflow_policy(
            "private-product", "secure-casetracker-swift", "schedule", paths
        )
        self.assertEqual(macos["plannedJobs"][0]["runner"], "macos-latest")

    def test_release_please_canaries_and_presets_follow_distinct_policies(self):
        empty = {"productJobIds": []}
        for event in ("pull_request", "push"):
            self.assertEqual(
                self.engine.simulate_ci_workflow_policy(
                    "private-governance-scaffold", "private-release-please", event, empty
                )["gateDecision"],
                "Blocked",
            )
        self.assertEqual(
            self.engine.simulate_ci_workflow_policy(
                "private-governance-scaffold", "private-release-please", "workflow_dispatch", empty
            )["plannedJobs"][0]["jobId"],
            "release-please",
        )
        self.assertEqual(
            self.engine.simulate_ci_workflow_policy(
                "public-preset", "preset-security", "pull_request", empty
            )["gateDecision"],
            "FleetPipeline",
        )
        for repository_id in ("home-baseline", "agent-operations-cockpit", "tui-vision"):
            self.assertEqual(
                self.engine.simulate_ci_workflow_policy(
                    "public-canary", repository_id, "pull_request", empty
                )["gateDecision"],
                "PublicCI",
            )

    def test_decimal_budget_stays_below_target_and_copilot_is_separate(self):
        projection = self.engine.project_ci_costs(
            self.contracts["profiles"]["budgetAssumptions"]
        )
        self.assertLess(float(projection["privateActionsMinutesPerMonth"]), 500)
        self.assertEqual(projection["privateMonthlyBudgetMinutes"], 3000)
        self.assertEqual(projection["copilotReviewRunnerMinutes"], "15")
        self.assertNotEqual(
            projection["privateActionsMinutesPerMonth"], projection["copilotReviewRunnerMinutes"]
        )

    def test_missing_negative_or_duplicate_budget_inputs_fail_closed(self):
        assumptions = self.contracts["profiles"]["budgetAssumptions"]
        with self.assertRaises(self.engine.CIGateBlocked):
            self.engine.project_ci_costs(assumptions, demand_runs=None)
        with self.assertRaises(self.engine.ContractError):
            self.engine.project_ci_costs(assumptions, recurring_jobs=-1)
        with self.assertRaises(self.engine.CIGateBlocked):
            self.engine.project_ci_costs(assumptions, recurring_duration_seconds=3600)


class RolloutDeterminismMutationTests(_FleetFixtureMixin, unittest.TestCase):
    """Stage A emits deterministic local plans and has no write vocabulary."""

    def test_full_plan_has_equal_ordered_sets_and_no_remote_convergence(self):
        rows = self.validated_rows()
        plan = self.engine.build_ci_inventory_rollout_plan(
            self.contracts, self.authoritative, rows,
            source="Fixture", source_revision="fixture-full-48-v1",
            generated_at="2026-08-20T00:00:00Z",
        )
        self.assertEqual(plan["stage"], "A")
        self.assertEqual(plan["deliveryMode"], "LocalImplementation")
        self.assertFalse(plan["mutationsPerformed"])
        self.assertEqual(
            [row["repositoryId"] for row in plan["repositories"]],
            [row["repositoryId"] for row in plan["rollout"]],
        )
        self.assertTrue(all(not row["remoteConverged"] for row in plan["rollout"]))
        self.assertRegex(plan["profileRegistryHash"], r"^[0-9a-f]{64}$")
        self.assertRegex(plan["pathContractHash"], r"^[0-9a-f]{64}$")
        self.assertNotEqual(plan["profileRegistryHash"], plan["pathContractHash"])

    def test_repetition_is_byte_stable_with_fixed_clock(self):
        rows = self.validated_rows()
        arguments = dict(
            source="Fixture", source_revision="fixture-full-48-v1",
            generated_at="2026-08-20T00:00:00Z",
        )
        first = self.engine.build_ci_inventory_rollout_plan(
            self.contracts, self.authoritative, rows, **arguments
        )
        second = self.engine.build_ci_inventory_rollout_plan(
            self.contracts, self.authoritative, copy.deepcopy(rows), **arguments
        )
        self.assertEqual(
            json.dumps(first, sort_keys=True, separators=(",", ":")),
            json.dumps(second, sort_keys=True, separators=(",", ":")),
        )

    def test_mutation_spy_blocks_remote_delivery_and_admin_surfaces(self):
        forbidden = [
            ("POST", "repos/example/repo/rulesets"),
            ("PUT", "repos/example/repo/contents/file"),
            ("PATCH", "repos/example/repo"),
            ("DELETE", "repos/example/repo/hooks/1"),
            ("COMMIT", "."), ("PUSH", "origin"), ("MERGE", "main"),
            ("HOME-SYNC", "~/"), ("G4", "intake-series"),
            ("GET", "repos/example/repo/rulesets"),
        ]
        for action, target in forbidden:
            with self.subTest(action=action, target=target), self.assertRaises(self.engine.ContractError):
                self.engine.assert_stage_a_operation(action, target)
        self.engine.assert_stage_a_operation("GET", "repos/example/repo")


class PlatformParityAccessibilityTests(_FleetFixtureMixin, unittest.TestCase):
    """Both wrappers expose one text-first business contract without color."""

    def test_bash_and_powershell_preview_are_fieldwise_equivalent(self):
        env = os.environ.copy()
        env.update({
            "HB_CI_PROFILES": str(FIXTURES / "vertical-slice/profiles.json"),
            "HB_CI_PATH_CONTRACTS": str(FIXTURES / "vertical-slice/path-contracts.json"),
            "HB_CI_REPOSITORY_ID": "private-governance-fixture",
            "HB_CI_FIXTURE_HEAD": "a" * 40,
        })
        commands = [
            ["bash", "scripts/maintain-agentic-workspace.sh", "--ci-gate", "--dry-run"],
            ["pwsh", "-NoProfile", "-File", "scripts/maintain-agentic-workspace.ps1", "-CiGate", "-WhatIf"],
        ]
        outputs = []
        for command in commands:
            completed = subprocess.run(command, cwd=ROOT, env=env, text=True, capture_output=True, check=False)
            self.assertEqual(completed.returncode, 0, completed.stderr)
            fields = [line for line in completed.stdout.splitlines() if ":" in line]
            outputs.append(fields)
            self.assertNotRegex(completed.stdout, r"\x1b\[[0-9;]*m")
        self.assertEqual(outputs[0], outputs[1])

    def test_platform_text_and_unsafe_boundaries_normalize_identically(self):
        self.assertEqual(self.engine._ci_platform(), "macos")
        for value in (" leading", "-option", "a;meta", "unicode-ä"):
            if value.startswith("-"):
                with self.assertRaises(self.engine.ContractError):
                    self.engine._normalize_changed_path(value)
            else:
                self.assertEqual(self.engine._normalize_changed_path(value), value)
        for value in ("../escape", "line\nbreak", "nul\0byte", "back\\slash"):
            with self.assertRaises(self.engine.ContractError):
                self.engine._normalize_changed_path(value)

    def test_shell_surfaces_keep_strict_safe_contracts(self):
        bash = (ROOT / "scripts/maintain-agentic-workspace.sh").read_text(encoding="utf-8")
        powershell = (ROOT / "scripts/maintain-agentic-workspace.ps1").read_text(encoding="utf-8")
        self.assertIn("set -euo pipefail", bash)
        self.assertNotIn("eval ", bash)
        self.assertIn("Set-StrictMode -Version Latest", powershell)
        self.assertNotIn("Invoke-Expression", powershell)
        self.assertIn("function Invoke-HBAgenticWorkspaceMaintenance", powershell)
        self.assertIn("$ciExitCode = $LASTEXITCODE", powershell)


if __name__ == "__main__":
    unittest.main()
