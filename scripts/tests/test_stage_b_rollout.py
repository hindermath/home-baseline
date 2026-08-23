#!/usr/bin/env python3
"""Red-first contracts and acceptance tests for the Stage-B fleet rollout."""

from __future__ import annotations

import importlib.util
import json
import os
import pathlib
import shutil
import subprocess
import tempfile
import unittest
import uuid
from unittest import mock


ROOT = pathlib.Path(__file__).resolve().parents[2]
ENGINE_PATH = ROOT / "scripts/lib/agentic_workspace_fleet.py"
ACCEPTANCE_PATH = ROOT / "scripts/tests/run_stage_b_rollout_acceptance.py"
FIXTURES = pathlib.Path(__file__).resolve().parent / "stage-b-rollout/fixtures"
CONTRACTS = ROOT / "specs/030-stage-b-rollout/contracts"
RUNTIME_SCHEMAS = ROOT / "scripts/config"


def load_engine():
    spec = importlib.util.spec_from_file_location("agentic_workspace_fleet_stage_b", ENGINE_PATH)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


def load_acceptance():
    spec = importlib.util.spec_from_file_location("stage_b_rollout_acceptance", ACCEPTANCE_PATH)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


class ContractTests(unittest.TestCase):
    """Stage-B documents are closed-world, versioned, and directly bound."""

    @classmethod
    def setUpClass(cls):
        cls.engine = load_engine()
        cls.cases = json.loads(
            (FIXTURES / "contracts/semantic-cases.json").read_text(encoding="utf-8")
        )

    def test_all_five_runtime_schemas_match_the_accepted_contracts(self):
        observed = self.engine.load_stage_b_schema_contracts(ROOT)
        self.assertEqual(observed["versions"], self.cases["expectedVersions"])
        self.assertEqual(observed["drift"], [])

    def test_mixed_versions_are_rejected(self):
        with self.assertRaisesRegex(self.engine.ContractError, "version"):
            self.engine.validate_stage_b_document_set(self.cases["mixedVersions"])

    def test_unknown_fields_are_rejected_before_semantic_use(self):
        with self.assertRaisesRegex(self.engine.ContractError, "unknown"):
            self.engine.validate_stage_b_closed_world(
                self.cases["unknownFieldDocument"], {"schemaVersion", "planSha256"}, "fixture"
            )

    def test_plan_hash_binding_is_direct(self):
        with self.assertRaisesRegex(self.engine.ContractError, "planSha256"):
            self.engine.require_stage_b_plan_binding(
                self.cases["wrongPlanBinding"], self.cases["expectedPlanSha256"]
            )

    def test_run_id_and_evidence_path_binding_are_direct(self):
        with self.assertRaisesRegex(self.engine.ContractError, "runId|path"):
            self.engine.require_stage_b_run_path_binding(
                self.cases["wrongRunPath"], self.cases["runId"]
            )

    def test_plan_and_mutable_state_fields_remain_separate(self):
        with self.assertRaisesRegex(self.engine.ContractError, "mutable|plan"):
            self.engine.validate_stage_b_plan_state_separation(
                self.cases["planWithMutableAuthority"]
            )

    def test_schema_drift_is_detected(self):
        with tempfile.TemporaryDirectory() as directory:
            target = pathlib.Path(directory) / "stage-b-rollout-plan.schema.json"
            target.write_bytes((CONTRACTS / target.name).read_bytes() + b"\n")
            with self.assertRaisesRegex(self.engine.ContractError, "drift"):
                self.engine.require_stage_b_schema_match(
                    CONTRACTS / target.name, target
                )

    def test_stage_a_contract_history_is_unchanged(self):
        for relative, expected in self.cases["stageAContractHashes"].items():
            with self.subTest(path=relative):
                self.assertEqual(self.engine.normalized_file_sha256(ROOT / relative), expected)


class ProviderBoundaryTests(unittest.TestCase):
    """Provider reads and writes use validated, non-shell argument arrays."""

    def test_read_arguments_reject_free_urls_and_metacharacters(self):
        engine = load_engine()
        self.assertEqual(
            engine.build_stage_b_gh_read_args("hindermath/repository", "pulls/1"),
            ["gh", "api", "repos/hindermath/repository/pulls/1", "--method", "GET"],
        )
        for endpoint in ("https://example.test/private", "../outside", "pulls;touch-owned"):
            with self.subTest(endpoint=endpoint):
                with self.assertRaises(engine.ContractError):
                    engine.build_stage_b_gh_read_args("hindermath/repository", endpoint)

    def test_numeric_provider_identity_and_fixed_host_are_required(self):
        engine = load_engine()
        for repository_id, host in (("0", "api.github.com"), ("abc", "api.github.com"), ("1", "127.0.0.1")):
            with self.subTest(repository_id=repository_id, host=host):
                with self.assertRaises(engine.ContractError):
                    engine.validate_stage_b_provider_identity(
                        repository_id, "hindermath/repository", host
                    )

    def test_transient_reads_are_bounded_and_writes_are_not_retried(self):
        engine = load_engine()
        responses = [
            engine.subprocess.CompletedProcess([], 124, stdout="", stderr="timeout"),
            engine.subprocess.CompletedProcess([], 0, stdout="{}", stderr=""),
        ]
        runner = mock.Mock(side_effect=responses)
        result = engine.run_stage_b_provider_read(
            "hindermath/repository", "rulesets", runner=runner, attempts=5
        )
        self.assertEqual(result["classification"], "Passed")
        self.assertEqual(result["attemptCount"], 2)
        self.assertEqual(runner.call_count, 2)


class EvidenceLedgerTests(unittest.TestCase):
    """No partial or schema-invalid evidence may be published."""

    def _write_schema(self, directory: pathlib.Path) -> pathlib.Path:
        schema = directory / "schema.json"
        schema.write_text(
            json.dumps(
                {
                    "type": "object",
                    "additionalProperties": False,
                    "required": ["schemaVersion", "status"],
                    "properties": {
                        "schemaVersion": {"const": "1.0"},
                        "status": {"enum": ["Passed", "Blocked"]},
                    },
                }
            ),
            encoding="utf-8",
        )
        return schema

    def test_atomic_publisher_replaces_valid_evidence_restrictively(self):
        engine = load_engine()
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            schema = self._write_schema(root)
            target = root / "operational/result.json"
            engine.publish_stage_b_evidence(
                target, {"schemaVersion": "1.0", "status": "Blocked"}, schema
            )
            digest = engine.publish_stage_b_evidence(
                target, {"schemaVersion": "1.0", "status": "Passed"}, schema
            )
            self.assertRegex(digest, r"^[0-9a-f]{64}$")
            self.assertEqual(json.loads(target.read_text(encoding="utf-8"))["status"], "Passed")
            if os.name == "nt":
                current_sid = engine._restrict_stage_b_evidence_permissions(
                    target, platform_name="nt"
                )
                acl_script = (
                    "$path=[Environment]::GetEnvironmentVariable('STAGE_B_EVIDENCE_PATH');"
                    "$acl=Get-Acl -LiteralPath $path;"
                    "$rules=@($acl.Access|ForEach-Object{[pscustomobject]@{"
                    "Sid=$_.IdentityReference.Translate([Security.Principal.SecurityIdentifier]).Value;"
                    "Type=[string]$_.AccessControlType}});"
                    "[pscustomobject]@{Protected=$acl.AreAccessRulesProtected;Rules=$rules}|"
                    "ConvertTo-Json -Compress -Depth 4"
                )
                acl_environment = os.environ.copy()
                acl_environment["STAGE_B_EVIDENCE_PATH"] = str(target)
                acl_result = subprocess.run(
                    ["pwsh", "-NoProfile", "-Command", acl_script],
                    text=True, capture_output=True, check=False, env=acl_environment,
                )
                self.assertEqual(acl_result.returncode, 0, acl_result.stderr)
                acl = json.loads(acl_result.stdout)
                self.assertTrue(acl["Protected"])
                rules = acl["Rules"] if isinstance(acl["Rules"], list) else [acl["Rules"]]
                self.assertTrue(rules)
                self.assertEqual({rule["Sid"] for rule in rules}, {current_sid})
                self.assertEqual({rule["Type"] for rule in rules}, {"Allow"})
            else:
                self.assertEqual(target.stat().st_mode & 0o777, 0o600)
            self.assertFalse(list(target.parent.glob(f".{target.name}.*")))

    def test_windows_dacl_is_protected_before_atomic_replace(self):
        engine = load_engine()
        with tempfile.TemporaryDirectory() as directory:
            target = pathlib.Path(directory) / "result.json"
            target.write_text("{}\n", encoding="utf-8")
            runner = mock.Mock(side_effect=[
                subprocess.CompletedProcess([], 0, stdout='"runner","S-1-5-21-42"\n', stderr=""),
                subprocess.CompletedProcess([], 0, stdout="processed 1 file", stderr=""),
            ])
            sid = engine._restrict_stage_b_evidence_permissions(
                target, platform_name="nt", runner=runner
            )
            self.assertEqual(sid, "S-1-5-21-42")
            acl_call = runner.call_args_list[1]
            self.assertEqual(
                acl_call.args[0][:4],
                ["pwsh.exe", "-NoProfile", "-NonInteractive", "-Command"],
            )
            self.assertIn("SetAccessRuleProtection($true,$false)", acl_call.args[0][4])
            self.assertIn("RemoveAccessRuleSpecific", acl_call.args[0][4])
            self.assertIn("AddAccessRule", acl_call.args[0][4])
            self.assertEqual(acl_call.kwargs["env"]["STAGE_B_EVIDENCE_PATH"], str(target))
            self.assertEqual(
                acl_call.kwargs["env"]["STAGE_B_EVIDENCE_SID"], "S-1-5-21-42"
            )

    def test_dacl_failure_preserves_previous_evidence(self):
        engine = load_engine()
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            schema = self._write_schema(root)
            target = root / "operational/result.json"
            engine.publish_stage_b_evidence(
                target, {"schemaVersion": "1.0", "status": "Blocked"}, schema
            )
            original = target.read_bytes()
            with mock.patch.object(
                engine,
                "_restrict_stage_b_evidence_permissions",
                side_effect=engine.ContractError("fixture DACL failure"),
            ):
                with self.assertRaisesRegex(engine.ContractError, "DACL failure"):
                    engine.publish_stage_b_evidence(
                        target, {"schemaVersion": "1.0", "status": "Passed"}, schema
                    )
            self.assertEqual(target.read_bytes(), original)
            self.assertFalse(list(target.parent.glob(f".{target.name}.*")))

    def test_windows_durability_path_never_opens_a_directory_descriptor(self):
        engine = load_engine()
        with tempfile.TemporaryDirectory() as directory:
            target = pathlib.Path(directory) / "result.json"
            target.write_text("{}\n", encoding="utf-8")
            real_open = engine.os.open

            def deny_directory_descriptor(subject, flags):
                if pathlib.Path(subject) == target.parent:
                    raise PermissionError("Windows directory descriptors are unavailable")
                self.assertTrue(flags & engine.os.O_RDWR)
                return real_open(subject, flags)

            with mock.patch.object(engine.os, "open", side_effect=deny_directory_descriptor):
                engine._sync_stage_b_evidence_metadata(target, platform_name="nt")

    def test_invalid_or_restricted_evidence_is_never_published(self):
        engine = load_engine()
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            schema = self._write_schema(root)
            target = root / "operational/result.json"
            with self.assertRaises(engine.ContractError):
                engine.publish_stage_b_evidence(
                    target, {"schemaVersion": "1.0", "status": "Unknown"}, schema
                )
            self.assertFalse(target.exists())
            with self.assertRaises(engine.ContractError):
                engine.publish_stage_b_evidence(
                    target,
                    {"schemaVersion": "1.0", "status": "Passed", "token": "fixture"},
                    schema,
                )
            self.assertFalse(target.exists())


class FleetPreflightTests(unittest.TestCase):
    """The dynamic fleet and immutable plan remain exact and mutation-free."""

    @classmethod
    def setUpClass(cls):
        cls.engine = load_engine()
        cls.manifest = json.loads(
            (ROOT / "scripts/config/agentic-workspace-fleet.json").read_text(encoding="utf-8")
        )
        cls.profiles = json.loads(
            (ROOT / "scripts/config/ci-budget-profiles.json").read_text(encoding="utf-8")
        )
        cls.profile_by_id = {
            item["repositoryId"]: item["profileId"] for item in cls.profiles["assignments"]
        }
        visibility_by_profile = {
            item["profileId"]: item["requiredVisibility"] for item in cls.profiles["profiles"]
        }
        targets = [
            {
                "id": "home-baseline", "remote": "https://github.com/hindermath/home-baseline.git",
                "defaultBranch": "main",
            },
            *[
                item for item in cls.manifest["targets"]
                if item.get("active") and item.get("kind") == "git-repository"
            ],
        ]
        cls.inventory = [
            {
                "repositoryId": item["id"],
                "providerRepositoryId": str(index),
                "remoteIdentity": item["remote"],
                "slug": pathlib.PurePosixPath(item["remote"].removesuffix(".git")).parts[-2] + "/" + pathlib.PurePosixPath(item["remote"].removesuffix(".git")).name,
                "profileId": cls.profile_by_id[item["id"]],
                "visibility": visibility_by_profile[cls.profile_by_id[item["id"]]],
                "defaultBranch": item["defaultBranch"],
                "defaultHead": subprocess.run(
                    ["git", "-C", str(ROOT), "rev-parse", "HEAD"],
                    text=True, capture_output=True, check=True,
                ).stdout.strip() if item["id"] == "home-baseline" else "a" * 40,
                "defaultTree": "b" * 40,
                "localRepositoryRootHash": "c" * 64,
                "environmentRegistryHash": "a" * 64,
                "observedAt": "2026-08-23T00:00:00Z",
            }
            for index, item in enumerate(targets, start=1)
        ]

    def test_preflight_proves_exact_dynamic_set_and_g3(self):
        snapshot = self.engine.StageBFleetPreflight(ROOT).execute(self.inventory)
        fixture = json.loads(
            (FIXTURES / "preflight/valid/fleet-set.json").read_text(encoding="utf-8")
        )
        self.assertEqual(snapshot["repositoryIdsHash"], fixture["repositoryIdsHash"])
        self.assertEqual(snapshot["g3ReviewedHead"], self.engine.STAGE_B_G3_REVIEWED_HEAD)
        self.assertEqual(snapshot["g3MergeCommit"], self.engine.STAGE_B_G3_MERGE_COMMIT)
        self.assertEqual(snapshot["writes"], 0)

    def test_assignment_or_provider_set_drift_blocks_before_write(self):
        with self.assertRaisesRegex(self.engine.ContractError, "set equality"):
            self.engine.StageBFleetPreflight(ROOT).execute(self.inventory[:-1])

    def test_stable_identity_rejects_remote_or_numeric_id_drift(self):
        drift = dict(self.inventory[0], providerRepositoryId="0")
        with self.assertRaises(self.engine.ContractError):
            self.engine.stage_b_stable_identity(drift)

    def test_provider_lifecycle_allows_only_bound_personal_forks(self):
        allowed = (
            ("cc65", "hindermath/cc65", "cc65/cc65"),
            ("tvision", "hindermath/tvision", "magiblot/tvision"),
        )
        for repository_id, slug, parent in allowed:
            with self.subTest(repository_id=repository_id):
                self.engine.validate_stage_b_provider_lifecycle(
                    {"archived": False, "fork": True, "parent": {"full_name": parent}},
                    repository_id,
                    slug,
                )

        blocked = (
            ({"archived": False, "fork": True, "parent": {"full_name": "other/upstream"}}, "cc65", "hindermath/cc65"),
            ({"archived": False, "fork": True, "parent": {"full_name": "cc65/cc65"}}, "other", "hindermath/other"),
            ({"archived": True, "fork": False}, "cc65", "hindermath/cc65"),
        )
        for metadata, repository_id, slug in blocked:
            with self.subTest(repository_id=repository_id, metadata=metadata):
                with self.assertRaises(self.engine.ContractError):
                    self.engine.validate_stage_b_provider_lifecycle(
                        metadata, repository_id, slug
                    )

    def test_read_only_git_tree_calculation_matches_current_tree_without_write(self):
        head = subprocess.run(
            ["git", "-C", str(ROOT), "rev-parse", "HEAD"],
            text=True, capture_output=True, check=True,
        ).stdout.strip()
        expected_tree = subprocess.run(
            ["git", "-C", str(ROOT), "rev-parse", f"{head}^{{tree}}"],
            text=True, capture_output=True, check=True,
        ).stdout.strip()
        entries = self.engine._stage_b_git_tree_entries(ROOT, head)
        self.assertEqual(self.engine._stage_b_tree_sha(entries), expected_tree)

    def test_environment_context_uses_exact_public_preset_fallback(self):
        with tempfile.TemporaryDirectory() as directory:
            repository = pathlib.Path(directory)
            (repository / "preset.yml").write_text(
                'schema_version: "1.0"\npreset:\n  id: "fixture"\n', encoding="utf-8"
            )
            readme = repository / "README.md"
            readme.write_text("# Fixture preset\n", encoding="utf-8")

            first = self.engine._stage_b_environment_hash(
                repository, "preset-fixture", "public-preset"
            )
            self.assertRegex(first, r"^[0-9a-f]{64}$")

            readme.write_text("# Changed fixture preset\n", encoding="utf-8")
            second = self.engine._stage_b_environment_hash(
                repository, "preset-fixture", "public-preset"
            )
            self.assertNotEqual(first, second)

    def test_environment_context_fallback_remains_fail_closed(self):
        with tempfile.TemporaryDirectory() as directory:
            repository = pathlib.Path(directory)
            (repository / "preset.yml").write_text(
                'schema_version: "1.0"\npreset:\n  id: "fixture"\n', encoding="utf-8"
            )
            readme = repository / "README.md"
            readme.write_text("# Fixture preset\n", encoding="utf-8")

            with self.assertRaisesRegex(
                self.engine.ContractError, "environment registry context is missing"
            ):
                self.engine._stage_b_environment_hash(
                    repository, "not-a-preset", "public-product"
                )

            readme.unlink()
            with self.assertRaisesRegex(
                self.engine.ContractError, "environment registry context is missing"
            ):
                self.engine._stage_b_environment_hash(
                    repository, "preset-fixture", "public-preset"
                )

    def test_workflow_adapter_requires_complete_public_inventory(self):
        complete = {
            "total_count": 1,
            "workflows": [{"path": ".github/workflows/ci.yml", "state": "active"}],
        }
        with mock.patch.object(self.engine, "_stage_b_github_get_json", return_value=complete):
            refs = self.engine._stage_b_workflow_gate_refs(
                "hindermath/example", "public-product", "example"
            )
        self.assertEqual(refs[0]["gateId"], "ci")
        incomplete = {"total_count": 2, "workflows": complete["workflows"]}
        with mock.patch.object(self.engine, "_stage_b_github_get_json", return_value=incomplete):
            with self.assertRaisesRegex(self.engine.ContractError, "pagination"):
                self.engine._stage_b_workflow_gate_refs(
                    "hindermath/example", "public-product", "example"
                )

    def test_workflow_adapter_separates_provider_managed_system_workflows(self):
        inventory = {
            "total_count": 5,
            "workflows": [
                {"path": ".github/workflows/ci.yml", "state": "active"},
                {
                    "path": "dynamic/agents/copilot-pull-request-reviewer",
                    "state": "active",
                },
                {
                    "path": "dynamic/copilot-pull-request-reviewer/copilot-pull-request-reviewer",
                    "state": "active",
                },
                {
                    "path": "dynamic/copilot-swe-agent/copilot",
                    "state": "active",
                },
                {
                    "path": "dynamic/dependabot/dependabot-updates",
                    "state": "active",
                },
            ],
        }
        with mock.patch.object(self.engine, "_stage_b_github_get_json", return_value=inventory):
            refs = self.engine._stage_b_workflow_gate_refs(
                "hindermath/example", "public-product", "example"
            )
        self.assertEqual([item["gateId"] for item in refs], ["ci"])

        for unsafe_path in (
            "dynamic/untrusted/workflow",
            "dynamic/copilot-pull-request-reviewer/untrusted",
            "dynamic/copilot-swe-agent/untrusted",
        ):
            unsafe = {
                "total_count": 1,
                "workflows": [{"path": unsafe_path, "state": "active"}],
            }
            with self.subTest(unsafe_path=unsafe_path):
                with mock.patch.object(
                    self.engine, "_stage_b_github_get_json", return_value=unsafe
                ):
                    with self.assertRaisesRegex(
                        self.engine.ContractError, "workflow path is unsafe"
                    ):
                        self.engine._stage_b_workflow_gate_refs(
                            "hindermath/example", "public-product", "example"
                        )

    def test_ruleset_adapter_plans_create_from_live_absence(self):
        identity = dict(self.inventory[0], profileId="private-governance-scaffold")
        template = ROOT / "scripts/templates/ci-budget-governance/private-governance-ruleset.json"
        with mock.patch.object(self.engine, "_stage_b_github_get_json", return_value=[]):
            plan_hash = self.engine._stage_b_ruleset_plan_hash(
                "hindermath/example", identity, template
            )
        self.assertRegex(plan_hash, r"^[0-9a-f]{64}$")
        drift = dict(self.inventory[0], remoteIdentity="https://github.com/hindermath/other.git")
        with self.assertRaises(self.engine.ContractError):
            self.engine.stage_b_stable_identity(drift)

    def test_ruleset_adapter_blocks_possibly_paginated_inventory(self):
        identity = dict(self.inventory[0], profileId="private-governance-scaffold")
        template = ROOT / "scripts/templates/ci-budget-governance/private-governance-ruleset.json"
        summaries = [{"id": index, "name": f"other-{index}"} for index in range(1, 101)]
        with mock.patch.object(self.engine, "_stage_b_github_get_json", return_value=summaries):
            with self.assertRaisesRegex(self.engine.ContractError, "pagination"):
                self.engine._stage_b_ruleset_plan_hash(
                    "hindermath/example", identity, template,
                )

    def test_dirty_divergent_and_stale_git_states_block(self):
        base = {
            "repositoryId": "fixture", "status": [], "ahead": 0, "behind": 0,
            "localHead": "a" * 40, "remoteHead": "a" * 40,
            "defaultBranch": "main", "observedDefaultBranch": "main",
        }
        self.engine.validate_stage_b_git_state(base)
        for mutation in (
            {"status": [" M unrelated.txt"]}, {"ahead": 1},
            {"remoteHead": "b" * 40}, {"observedDefaultBranch": "master"},
        ):
            with self.subTest(mutation=mutation), self.assertRaises(self.engine.ContractError):
                self.engine.validate_stage_b_git_state({**base, **mutation})

    def test_planner_is_schema_valid_and_contains_no_mutable_authority(self):
        snapshot = self.engine.StageBFleetPreflight(ROOT).execute(self.inventory)
        assignments = self.profiles["assignments"]
        targets = [
            {
                "repositoryId": item["repositoryId"], "baselineHead": item["defaultHead"],
                "baselineTree": item["defaultTree"], "defaultBranch": item["defaultBranch"],
                "stageAPlanHash": "c" * 64, "gateSetHash": "d" * 64,
                "pathContractHash": "e" * 64, "changes": [], "candidateTree": item["defaultTree"],
                "workflowAction": "N/A", "rulesetPlanHash": "N/A", "mergeMethod": "N/A",
                "requiredLocalGates": [], "requiredRemoteGates": [],
            }
            for item in self.inventory
        ]
        plan = self.engine.StageBRolloutPlanner().build(snapshot, assignments, targets)
        schema = json.loads(
            (ROOT / "scripts/config/stage-b-rollout-plan.schema.json").read_text(encoding="utf-8")
        )
        self.engine.validate_stage_b_schema_instance(plan, schema)
        self.assertEqual(plan["firstMutation"], "N/A")
        self.assertFalse(self.engine.STAGE_B_MUTABLE_PLAN_FIELDS & set(plan))

    def _all_noop_plan_and_state(self):
        snapshot = self.engine.StageBFleetPreflight(ROOT).execute(self.inventory)
        targets = [
            {
                "repositoryId": item["repositoryId"], "baselineHead": item["defaultHead"],
                "baselineTree": item["defaultTree"], "defaultBranch": item["defaultBranch"],
                "stageAPlanHash": "c" * 64, "gateSetHash": "d" * 64,
                "pathContractHash": "e" * 64, "changes": [], "candidateTree": item["defaultTree"],
                "workflowAction": "N/A", "rulesetPlanHash": "N/A", "mergeMethod": "N/A",
                "requiredLocalGates": [], "requiredRemoteGates": [],
            }
            for item in self.inventory
        ]
        plan = self.engine.StageBRolloutPlanner().build(snapshot, self.profiles["assignments"], targets)
        return plan, self.engine.build_stage_b_run_state(plan)

    def test_prepared_state_is_pending_closed_and_has_no_bypass(self):
        _, state = self._all_noop_plan_and_state()
        authority = state["authorityBinding"]
        self.assertEqual(
            {key: authority[key] for key in (
                "status", "source", "authorizedAt", "validatedAt",
                "externalWriteGate", "adminBypass",
            )},
            {
                "status": "Pending", "source": "N/A", "authorizedAt": "N/A",
                "validatedAt": "N/A", "externalWriteGate": "Closed",
                "adminBypass": "NotAuthorized",
            },
        )

    def test_capture_timestamps_do_not_change_semantic_snapshot_or_plan_hashes(self):
        first_inventory = json.loads(json.dumps(self.inventory))
        second_inventory = json.loads(json.dumps(self.inventory))
        for item in second_inventory:
            item["observedAt"] = "2026-08-24T00:00:00Z"
        source_revision = "f" * 64
        first_snapshot = self.engine.StageBFleetPreflight(ROOT).execute(
            first_inventory, source="Fixture", source_revision=source_revision,
        )
        second_snapshot = self.engine.StageBFleetPreflight(ROOT).execute(
            second_inventory, source="Fixture", source_revision=source_revision,
        )
        self.assertNotEqual(first_snapshot["capturedAt"], second_snapshot["capturedAt"])
        self.assertEqual(first_snapshot["inputSetHash"], second_snapshot["inputSetHash"])
        self.assertEqual(first_snapshot["fleetSnapshotHash"], second_snapshot["fleetSnapshotHash"])

        targets = [
            {
                "repositoryId": item["repositoryId"], "baselineHead": item["defaultHead"],
                "baselineTree": item["defaultTree"], "defaultBranch": item["defaultBranch"],
                "stageAPlanHash": "c" * 64, "gateSetHash": "d" * 64,
                "pathContractHash": "e" * 64, "changes": [],
                "candidateTree": item["defaultTree"], "workflowAction": "N/A",
                "rulesetPlanHash": "N/A", "mergeMethod": "N/A",
                "requiredLocalGates": [], "requiredRemoteGates": [],
            }
            for item in first_inventory
        ]
        planner = self.engine.StageBRolloutPlanner()
        first_plan = planner.build(first_snapshot, self.profiles["assignments"], targets)
        second_plan = planner.build(second_snapshot, self.profiles["assignments"], targets)
        self.assertNotEqual(first_plan["createdAt"], second_plan["createdAt"])
        self.assertEqual(first_plan["planHash"], second_plan["planHash"])

    def test_publication_failure_before_plan_leaves_no_authoritative_artifact(self):
        plan, state = self._all_noop_plan_and_state()
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            plan_path, state_path = root / "rollout-plan.json", root / "stage-b-run-state.json"
            with self.assertRaisesRegex(RuntimeError, "before-plan"):
                self.engine.publish_stage_b_preflight(
                    plan_path, state_path, plan, state,
                    RUNTIME_SCHEMAS / "stage-b-rollout-plan.schema.json",
                    RUNTIME_SCHEMAS / "stage-b-run-state.schema.json",
                    failure_injector=lambda boundary: (_ for _ in ()).throw(RuntimeError(boundary)),
                )
            self.assertFalse(plan_path.exists())
            self.assertFalse(state_path.exists())

    def test_publication_failure_before_state_leaves_replaceable_orphan_plan(self):
        plan, state = self._all_noop_plan_and_state()
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            plan_path, state_path = root / "rollout-plan.json", root / "stage-b-run-state.json"

            def fail_before_state(boundary):
                if boundary == "before-state-publish":
                    raise RuntimeError(boundary)

            with self.assertRaisesRegex(RuntimeError, "before-state"):
                self.engine.publish_stage_b_preflight(
                    plan_path, state_path, plan, state,
                    RUNTIME_SCHEMAS / "stage-b-rollout-plan.schema.json",
                    RUNTIME_SCHEMAS / "stage-b-run-state.schema.json",
                    failure_injector=fail_before_state,
                )
            self.assertTrue(plan_path.is_file())
            self.assertFalse(state_path.exists())
            self.engine.publish_stage_b_preflight(
                plan_path, state_path, plan, state,
                RUNTIME_SCHEMAS / "stage-b-rollout-plan.schema.json",
                RUNTIME_SCHEMAS / "stage-b-run-state.schema.json",
            )
            self.assertTrue(state_path.is_file())

    def test_state_without_matching_plan_is_invalid(self):
        _, state = self._all_noop_plan_and_state()
        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            state_path = root / "stage-b-run-state.json"
            self.engine._atomic_stage_b_json(state_path, state)
            with self.assertRaisesRegex(self.engine.ContractError, "without its bound plan"):
                self.engine.validate_stage_b_published_state(
                    root, state_path,
                    RUNTIME_SCHEMAS / "stage-b-rollout-plan.schema.json",
                    RUNTIME_SCHEMAS / "stage-b-run-state.schema.json",
                )

    def test_ac_sbr_001_rejects_fixture_only_plan_evidence(self):
        acceptance = load_acceptance()
        plan = {
            "targets": [{"repositoryId": "home-baseline"}],
            "waves": [{"repositoryIds": ["home-baseline"]}],
            "stageAReference": {
                "reviewedHead": self.engine.STAGE_B_G3_REVIEWED_HEAD,
                "mergeCommit": self.engine.STAGE_B_G3_MERGE_COMMIT,
                "postMergeEvidenceSha256": "a" * 64,
            },
            "planHash": "b" * 64,
            "fleetSnapshotHash": "c" * 64,
        }

        class FakeEngine:
            @staticmethod
            def load_stage_b_document(path, schema):
                return plan

            @staticmethod
            def validate_stage_b_plan_semantics(value):
                return None

            @staticmethod
            def load_stage_b_live_inputs(root):
                return {"source": "Fixture"}

        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            plan_path = root / acceptance.STAGE_B_PLAN_PATH
            plan_path.parent.mkdir(parents=True)
            plan_path.write_text("{}\n", encoding="utf-8")
            with mock.patch.object(acceptance, "load_engine", return_value=FakeEngine):
                with self.assertRaisesRegex(ValueError, "fixture-only"):
                    acceptance.build_ac_sbr_001_live_binding(root)

    def test_ac_sbr_001_binds_published_path_normalized_hash_fleet_and_g3(self):
        acceptance = load_acceptance()
        reviewed = self.engine.STAGE_B_G3_REVIEWED_HEAD
        merge = self.engine.STAGE_B_G3_MERGE_COMMIT
        evidence_hash = "a" * 64
        plan = {
            "targets": [{"repositoryId": "home-baseline"}],
            "waves": [{"repositoryIds": ["home-baseline"]}],
            "stageAReference": {
                "reviewedHead": reviewed, "mergeCommit": merge,
                "postMergeEvidenceSha256": evidence_hash,
            },
            "planHash": "b" * 64, "fleetSnapshotHash": "c" * 64,
        }
        snapshot = {
            "repositoryIds": ["home-baseline"], "repositoryIdsHash": "d" * 64,
            "g3ReviewedHead": reviewed, "g3MergeCommit": merge,
            "g3PostMergeEvidenceSha256": evidence_hash,
        }

        class FakePreflight:
            def __init__(self, root):
                pass

            def execute(self, inventory, **kwargs):
                return snapshot

        class FakeEngine:
            StageBFleetPreflight = FakePreflight

            @staticmethod
            def load_stage_b_document(path, schema):
                return plan

            @staticmethod
            def validate_stage_b_plan_semantics(value):
                return None

            @staticmethod
            def load_stage_b_live_inputs(root):
                return {
                    "source": "GitHubReadOnly", "sourceRevision": "e" * 64,
                    "providerInventory": [],
                }

        with tempfile.TemporaryDirectory() as directory:
            root = pathlib.Path(directory)
            plan_path = root / acceptance.STAGE_B_PLAN_PATH
            plan_path.parent.mkdir(parents=True)
            plan_path.write_text("{}\r\n", encoding="utf-8")
            with mock.patch.object(acceptance, "load_engine", return_value=FakeEngine):
                binding = acceptance.build_ac_sbr_001_live_binding(root)
            self.assertEqual(binding["rolloutPlanPath"], acceptance.STAGE_B_PLAN_PATH.as_posix())
            self.assertEqual(binding["rolloutPlanSha256"], acceptance.normalized_sha256(plan_path))
            self.assertTrue(binding["dynamicFleetEquality"])
            self.assertEqual(binding["g3Basis"]["reviewedHead"], reviewed)


class ExternalWriteGateTests(unittest.TestCase):
    """Only an exact current authority binding can open one write boundary."""

    def test_exact_open_gate_passes_and_any_drift_blocks(self):
        engine = load_engine()
        plan_hash, scope_hash, ids_hash, delivery_hash = (character * 64 for character in "abcd")
        state = {
            "authorityBinding": {
                "status": "Authorized", "deliveryMode": "MergeAndSync", "runId": engine.STAGE_B_RUN_ID,
                "planSha256": plan_hash, "scopeHash": scope_hash,
                "repositoryIdsHash": ids_hash, "externalWriteGate": "Open",
            }
        }
        arguments = {
            "expected_run_id": engine.STAGE_B_RUN_ID,
            "expected_plan_sha256": plan_hash,
            "expected_scope_hash": scope_hash,
            "expected_repository_ids_hash": ids_hash,
            "expected_delivery_set_hash": delivery_hash,
            "actual_delivery_set_hash": delivery_hash,
        }
        engine.validate_external_write_gate(state, **arguments)
        for key, value in (("status", "Pending"), ("externalWriteGate", "Closed"), ("planSha256", "f" * 64)):
            drifted = json.loads(json.dumps(state))
            drifted["authorityBinding"][key] = value
            with self.subTest(key=key), self.assertRaises(engine.ContractError):
                engine.validate_external_write_gate(drifted, **arguments)

    def test_preview_never_opens_external_write_gate(self):
        engine = load_engine()
        state = {"authorityBinding": {"externalWriteGate": "Closed"}}
        with self.assertRaises(engine.ContractError):
            engine.validate_external_write_gate(
                state, expected_run_id=engine.STAGE_B_RUN_ID,
                expected_plan_sha256="a" * 64, expected_scope_hash="b" * 64,
                expected_repository_ids_hash="c" * 64,
                expected_delivery_set_hash="d" * 64, actual_delivery_set_hash="d" * 64,
            )


class PublicCanaryVerticalSliceTests(unittest.TestCase):
    """Representative canary proves a complete lifecycle before fleet breadth."""

    class FakeProvider:
        def __init__(self, fixture):
            self.fixture = fixture
            self.writes = []
            self.existing = None

        def read_existing_result(self, run_id, repository_id, plan_hash):
            return self.existing

        def ensure_branch(self, branch, baseline):
            self.writes.append("Branch")
            return "Created"

        def materialize_changes(self, planned):
            return json.loads(json.dumps(planned))

        def prepare_candidate(self):
            return {"headSha": self.fixture["candidateHead"], "treeSha": self.fixture["candidateTree"]}

        def run_local_gate(self, command, head):
            return {
                "gateId": "local-tests", "headSha": head, "workflow": "Local",
                "job": "unit", "runnerOrPlatform": "macOS",
                "executedCommand": command, "result": "Passed",
            }

        def run_secret_scan(self, head):
            return {"result": "Passed", "headSha": head, "restrictedFindings": 0}

        def stage_and_commit(self, planned, tree):
            self.writes.append("Commit")
            return {"headSha": self.fixture["candidateHead"], "treeSha": tree, "stagedDiffCheck": "Passed"}

        def push(self, branch, head):
            self.writes.append("Push")

        def ensure_pull_request(self, branch, head, diff_hash, run_id):
            self.writes.append("PullRequest")
            return {"number": 101, "headSha": head, "count": 1}

        def read_remote_gate(self, number, gate_id):
            return {
                "gateId": gate_id, "headSha": self.fixture["candidateHead"],
                "workflow": "CI", "job": gate_id, "runnerOrPlatform": "GitHub",
                "executedCommand": "python3 -m unittest", "result": "Passed",
            }

        def read_review(self, number):
            return {"status": "Approved", "headSha": self.fixture["candidateHead"]}

        def merge(self, number, method, admin=False):
            self.writes.append("AdminMerge" if admin else "Merge")
            return {"result": "Merged", "mergeCommit": "7" * 40, "providerActionId": "merge-001"}

        def sync_default(self, default_branch, merge_commit):
            self.writes.append("DefaultSync")
            return {"defaultBranch": default_branch, "localHead": merge_commit, "remoteHead": merge_commit}

        def final_provider_hash(self):
            return "8" * 64

    def setUp(self):
        engine = load_engine()
        self.engine = engine
        self.fixture = json.loads(
            (FIXTURES / "vertical-slice/agent-operations-cockpit.json").read_text(encoding="utf-8")
        )

    def test_preview_after_red_slice_remains_write_free(self):
        provider = self.FakeProvider(self.fixture)
        result = self.engine.StageBTargetTransaction(
            self.fixture, provider, preview=True
        ).execute()
        self.assertEqual(result["outcome"], "Preview")
        self.assertEqual(result["writes"], 0)
        self.assertEqual(provider.writes, [])

    def test_green_public_canary_lifecycle_is_exact_and_complete(self):
        provider = self.FakeProvider(self.fixture)
        result = self.engine.StageBTargetTransaction(self.fixture, provider).execute()
        self.assertEqual(result["outcome"], "Converged")
        self.assertEqual(
            result["events"],
            ["Branch", "PreMerge", "Commit", "Push", "PullRequest", "ReviewAndGates", "Merge", "DefaultSync", "PostMerge"],
        )
        self.assertFalse(result["adminBypass"]["used"])
        self.assertRegex(result["preMergeSha256"], r"^[0-9a-f]{64}$")
        self.assertRegex(result["postMergeSha256"], r"^[0-9a-f]{64}$")

    def test_resume_reconciles_existing_result_without_duplicate_write(self):
        provider = self.FakeProvider(self.fixture)
        first = self.engine.StageBTargetTransaction(self.fixture, provider).execute()
        writes_after_first = list(provider.writes)
        provider.existing = first
        second = self.engine.StageBTargetTransaction(self.fixture, provider).execute()
        self.assertTrue(second["reconciled"])
        self.assertEqual(second["writes"], 0)
        self.assertEqual(provider.writes, writes_after_first)


class RegularDeliveryTests(unittest.TestCase):
    """Exact diff, gate, review, merge fallback, and evidence remain bound."""

    def setUp(self):
        self.engine = load_engine()
        self.fixture = json.loads(
            (FIXTURES / "vertical-slice/agent-operations-cockpit.json").read_text(encoding="utf-8")
        )

    def test_observed_blob_or_mode_drift_blocks_before_commit(self):
        provider = PublicCanaryVerticalSliceTests.FakeProvider(self.fixture)
        provider.materialize_changes = mock.Mock(
            return_value=[{**self.fixture["plannedChanges"][0], "blobAfter": "f" * 40}]
        )
        with self.assertRaisesRegex(self.engine.ContractError, "diff differs"):
            self.engine.StageBTargetTransaction(self.fixture, provider).execute()
        self.assertNotIn("Commit", provider.writes)

    def test_merge_method_falls_back_in_fixed_order(self):
        provider = PublicCanaryVerticalSliceTests.FakeProvider(self.fixture)
        methods = []

        def merge(number, method, admin=False):
            methods.append((method, admin))
            if method == "merge":
                return {"result": "Refused", "classification": "MethodUnavailable"}
            return {"result": "Merged", "mergeCommit": "7" * 40, "providerActionId": "merge-002"}

        provider.merge = merge
        result = self.engine.StageBTargetTransaction(self.fixture, provider).execute()
        self.assertEqual(methods, [("merge", False), ("squash", False)])
        self.assertEqual(result["outcome"], "Converged")

    def test_premerge_and_postmerge_are_published_to_separate_paths(self):
        provider = PublicCanaryVerticalSliceTests.FakeProvider(self.fixture)
        with tempfile.TemporaryDirectory() as directory:
            result = self.engine.StageBTargetTransaction(
                self.fixture, provider, evidence_root=pathlib.Path(directory)
            ).execute()
            repository_root = pathlib.Path(directory) / "repositories/agent-operations-cockpit"
            self.assertTrue((repository_root / "premerge.json").is_file())
            self.assertTrue((repository_root / "postmerge.json").is_file())
            self.assertEqual(
                result["postMerge"]["preMergeEvidenceSha256"], result["preMergeSha256"]
            )


class AdminBypassEvidenceTests(unittest.TestCase):
    """Admin bypass is protection-only and never replaces independent evidence."""

    def test_fresh_bound_exception_is_used_only_after_regular_protection_refusal(self):
        engine = load_engine()
        fixture = json.loads(
            (FIXTURES / "vertical-slice/agent-operations-cockpit.json").read_text(encoding="utf-8")
        )
        fixture["adminBypassAuthority"] = {
            "runId": fixture["runId"], "repositoryId": fixture["repositoryId"],
            "prHead": fixture["candidateHead"], "scope": "ProtectionOnlyMerge",
            "authorizedAt": "2026-08-21T20:00:00Z", "expiresAt": "2099-08-22T20:00:00Z",
            "reason": "Required protection-only exception after full evidence",
        }
        provider = PublicCanaryVerticalSliceTests.FakeProvider(fixture)

        def merge(number, method, admin=False):
            if admin:
                return {"result": "Merged", "mergeCommit": "7" * 40, "providerActionId": "admin-001"}
            return {"result": "Refused", "classification": "ProtectionOnlyRefusal", "method": method}

        provider.merge = merge
        result = engine.StageBTargetTransaction(fixture, provider).execute()
        self.assertTrue(result["adminBypass"]["used"])
        self.assertEqual(
            sorted(result["adminBypass"]["independentEvidenceHashes"]),
            ["acceptance", "preMerge", "review", "security"],
        )

    def test_stale_or_unbound_exception_is_rejected(self):
        engine = load_engine()
        fixture = json.loads(
            (FIXTURES / "vertical-slice/agent-operations-cockpit.json").read_text(encoding="utf-8")
        )
        fixture["adminBypassAuthority"] = {
            "runId": fixture["runId"], "repositoryId": "other",
            "prHead": fixture["candidateHead"], "scope": "ProtectionOnlyMerge",
            "expiresAt": "2026-08-20T00:00:00Z",
        }
        provider = PublicCanaryVerticalSliceTests.FakeProvider(fixture)
        provider.merge = mock.Mock(
            return_value={"result": "Refused", "classification": "ProtectionOnlyRefusal"}
        )
        with self.assertRaises(engine.ContractError):
            engine.StageBTargetTransaction(fixture, provider).execute()


class PrivateRulesetTests(unittest.TestCase):
    """The independent private default-branch server contract is exact."""

    class Provider:
        def __init__(self, before, desired):
            self.current = before
            self.desired = desired
            self.writes = 0
            self.restores = 0

        def read_ruleset(self, repository_id, ruleset_id):
            return json.loads(json.dumps(self.current))

        def write_ruleset(self, repository_id, ruleset_id, desired):
            self.writes += 1
            self.current = json.loads(json.dumps(desired))
            return "ruleset-001"

        def restore_ruleset(self, repository_id, ruleset_id, before, restore_hash):
            self.restores += 1
            self.current = before

    def test_exact_private_ruleset_updates_once_and_verifies(self):
        engine = load_engine()
        fixture = json.loads(
            (FIXTURES / "delivery/private-ruleset.json").read_text(encoding="utf-8")
        )
        provider = self.Provider({"state": "old"}, fixture["desiredRuleset"])
        result = engine.StageBRulesetTransaction(fixture, provider).execute()
        self.assertEqual(result["action"], "Update")
        self.assertEqual(provider.writes, 1)
        self.assertEqual(provider.restores, 0)

    def test_additional_status_or_bypass_actor_is_rejected_before_write(self):
        engine = load_engine()
        fixture = json.loads(
            (FIXTURES / "delivery/private-ruleset.json").read_text(encoding="utf-8")
        )
        fixture["desiredRuleset"]["bypassActors"] = ["fixture"]
        provider = self.Provider({}, fixture["desiredRuleset"])
        with self.assertRaises(engine.ContractError):
            engine.StageBRulesetTransaction(fixture, provider).execute()
        self.assertEqual(provider.writes, 0)


class SecurityBoundaryTests(unittest.TestCase):
    """Injection, SSRF, path, redaction, retry, and provider classes fail closed."""

    def test_unsafe_components_and_provider_endpoints_are_rejected(self):
        engine = load_engine()
        for value in ("repo;touch-owned", "--admin", "../outside", "repo\0id", "repo\r\nid"):
            with self.subTest(value=repr(value)), self.assertRaises(engine.ContractError):
                engine.validate_ci_input_component(value)
        for endpoint in ("--admin", "https://127.0.0.1/private", "../outside", "pulls;owned"):
            with self.subTest(endpoint=endpoint), self.assertRaises(engine.ContractError):
                engine.build_stage_b_gh_read_args("hindermath/repository", endpoint)

    def test_provider_failure_classes_are_disjoint(self):
        engine = load_engine()
        cases = [
            (0, "", "Passed"), (124, "timeout", "TransientRead"),
            (1, "billing quota", "BillingOrQuotaRefusal"),
            (1, "HTTP 403 forbidden", "ProviderRefusal"),
            (1, "compiler failed", "TechnicalFailure"),
        ]
        self.assertEqual(
            [engine.classify_stage_b_provider_failure(code, detail) for code, detail, _ in cases],
            [expected for _, _, expected in cases],
        )

    def test_redaction_limits_diagnostics_and_removes_secrets(self):
        engine = load_engine()
        text = "token=fixture-secret " + ("x" * 5000)
        redacted = engine._redact_stage_b_text(text)
        self.assertNotIn("fixture-secret", redacted)
        self.assertLessEqual(len(redacted), 4096)


class NoOpTests(unittest.TestCase):
    """No-op is positive semantic/provider convergence and creates no empty PR."""

    def test_fully_converged_noop_has_zero_git_or_pr_writes(self):
        engine = load_engine()
        cases = json.loads(
            (FIXTURES / "no-op/no-op-cases.json").read_text(encoding="utf-8")
        )["cases"]
        converged = next(item for item in cases if item["caseId"] == "fully-converged")
        result = engine.evaluate_stage_b_noop(converged)
        self.assertEqual(result["outcome"], "NoOpConverged")
        self.assertEqual(
            (result["branchWrites"], result["commitWrites"], result["pullRequestWrites"]),
            (0, 0, 0),
        )

    def test_semantic_or_provider_drift_never_becomes_noop(self):
        engine = load_engine()
        cases = json.loads(
            (FIXTURES / "no-op/no-op-cases.json").read_text(encoding="utf-8")
        )["cases"]
        for case in cases:
            if case["expected"] == "Blocked":
                with self.subTest(case=case["caseId"]), self.assertRaises(engine.ContractError):
                    engine.evaluate_stage_b_noop(case)

    def test_ruleset_only_case_opens_no_git_lifecycle(self):
        engine = load_engine()
        case = next(
            item for item in json.loads(
                (FIXTURES / "no-op/no-op-cases.json").read_text(encoding="utf-8")
            )["cases"] if item["caseId"] == "ruleset-only"
        )
        result = engine.evaluate_stage_b_noop(case)
        self.assertEqual(result["outcome"], "RulesetTransaction")
        self.assertEqual(result["pullRequestWrites"], 0)


class StopResumeIdempotencyTests(unittest.TestCase):
    """The first hard failure persists one safe boundary and resume is exact."""

    def setUp(self):
        self.engine = load_engine()
        self.state = {
            "status": "Delivering", "stateHash": "0" * 64,
            "rolloutPlanBinding": {"planSha256": "a" * 64},
            "fleetSnapshotHash": "b" * 64,
            "authorityBinding": {"authorityHash": "c" * 64, "externalWriteGate": "Closed"},
            "currentRepositoryId": "home-baseline", "resumeCount": 0,
            "targetResults": [
                {"repositoryId": "agent-operations-cockpit", "outcome": "Converged"},
                {"repositoryId": "home-baseline", "outcome": "Stopped"},
            ],
        }

    def test_stop_is_atomic_before_next_target_and_resume_preserves_success(self):
        with tempfile.TemporaryDirectory() as directory:
            path = pathlib.Path(directory) / "state.json"
            stopped = self.engine.persist_stage_b_stop(
                self.state, path, category="Provider", reason="fixture refusal",
                in_flight_operation="PullRequest", last_safe_boundary="CanaryOneConverged",
                next_action="Resume at home-baseline after provider revalidation.",
            )
            self.assertTrue(path.is_file())
            self.assertEqual(stopped["status"], "Stopped")
            resumed = self.engine.resume_stage_b_state(
                stopped, plan_sha256="a" * 64, fleet_snapshot_hash="b" * 64,
                authority_hash="c" * 64, provider_hash="d" * 64, budget_hash="e" * 64,
            )
            self.assertEqual(resumed["currentRepositoryId"], "home-baseline")
            self.assertEqual(resumed["targetResults"][0]["outcome"], "Converged")
            self.assertEqual(resumed["resumeCount"], 1)

    def test_resume_drift_blocks_without_changing_prior_results(self):
        stopped = {**self.state, "status": "Stopped"}
        with self.assertRaises(self.engine.ContractError):
            self.engine.resume_stage_b_state(
                stopped, plan_sha256="f" * 64, fleet_snapshot_hash="b" * 64,
                authority_hash="c" * 64, provider_hash="d" * 64, budget_hash="e" * 64,
            )
        self.assertEqual(stopped["targetResults"][0]["outcome"], "Converged")

    def test_idempotency_key_is_stable_and_action_specific(self):
        values = dict(
            run_id=self.engine.STAGE_B_RUN_ID, repository_id="home-baseline",
            baseline_head="1" * 40, candidate_head="2" * 40, plan_sha256="a" * 64,
        )
        first = self.engine.stage_b_idempotency_key(action="pull-request", **values)
        second = self.engine.stage_b_idempotency_key(action="pull-request", **values)
        merge = self.engine.stage_b_idempotency_key(action="merge", **values)
        self.assertEqual(first, second)
        self.assertNotEqual(first, merge)


class _WaveFixtureMixin:
    def wave_targets(self):
        return {
            "public-canaries": [
                {"repositoryId": item, "profileId": "public-canary"}
                for item in ("agent-operations-cockpit", "home-baseline", "tui-vision")
            ],
            "public-products": [{
                "repositoryId": "public-product-a", "profileId": "public-product",
                "preserveRequiredPublicCI": True, "environmentGates": ["build"],
            }],
            "private-products": [{
                "repositoryId": "private-product-a", "profileId": "private-product",
                "pathDependentProductGates": True, "unconditionalMainRebuild": False,
            }],
            "private-governance-scaffold": [{
                "repositoryId": "private-governance-a", "profileId": "private-governance-scaffold",
                "requiredStatusChecks": ["home-baseline/ci-minimal-gate"],
                "requiredApprovingReviews": 1, "strictStatusChecks": True,
                "bypassActors": [], "fullPullRequestBuild": False, "fullMainBuild": False,
            }],
            "public-presets": [{
                "repositoryId": "public-preset-a", "profileId": "public-preset",
                "repositoryWorkflows": [], "fleetPipelineEvidence": True,
            }],
        }


class WaveOrderTests(_WaveFixtureMixin, unittest.TestCase):
    """Canaries and four profile waves are deterministic and strictly serial."""

    def test_exact_wave_and_repository_order_has_one_writer(self):
        engine = load_engine()

        def target_handler(target):
            return {
                "repositoryId": target["repositoryId"], "outcome": "Converged",
                "resultSha256": engine.canonical_json_hash(target),
            }

        def budget_handler(wave_id, results, predecessor):
            return {"result": "Pass", "projectionSha256": engine.canonical_json_hash([wave_id, predecessor])}

        coordinator = engine.StageBWaveCoordinator(target_handler, budget_handler)
        results = coordinator.execute(self.wave_targets(), "a" * 64)
        self.assertEqual([item["waveId"] for item in results], list(engine.STAGE_B_WAVES))
        self.assertEqual(coordinator.maximum_active_writers, 1)
        self.assertEqual(
            coordinator.started[:3], ["agent-operations-cockpit", "home-baseline", "tui-vision"]
        )

    def test_first_hard_failure_starts_no_later_target_or_wave(self):
        engine = load_engine()
        started = []

        def target_handler(target):
            started.append(target["repositoryId"])
            outcome = "Blocked" if target["repositoryId"] == "home-baseline" else "Converged"
            return {"repositoryId": target["repositoryId"], "outcome": outcome, "resultSha256": "a" * 64}

        coordinator = engine.StageBWaveCoordinator(
            target_handler, lambda *_: {"result": "Pass", "projectionSha256": "b" * 64}
        )
        with self.assertRaisesRegex(engine.ContractError, "stop before next"):
            coordinator.execute(self.wave_targets(), "c" * 64)
        self.assertEqual(started, ["agent-operations-cockpit", "home-baseline"])


class ProfileContractTests(_WaveFixtureMixin, unittest.TestCase):
    """Each Stage-B profile preserves its accepted CI/ruleset boundary."""

    def test_all_five_profile_contracts_pass(self):
        engine = load_engine()
        for targets in self.wave_targets().values():
            for target in targets:
                engine.validate_stage_b_profile_contract(target["profileId"], target)

    def test_broad_private_build_or_public_preset_workflow_blocks(self):
        engine = load_engine()
        private = self.wave_targets()["private-products"][0]
        with self.assertRaises(engine.ContractError):
            engine.validate_stage_b_profile_contract(
                "private-product", {**private, "unconditionalMainRebuild": True}
            )
        preset = self.wave_targets()["public-presets"][0]
        with self.assertRaises(engine.ContractError):
            engine.validate_stage_b_profile_contract(
                "public-preset", {**preset, "repositoryWorkflows": ["extra.yml"]}
            )


class BudgetProjectionTests(unittest.TestCase):
    """Five causal Decimal projections protect the strict private-minute target."""

    def setUp(self):
        self.engine = load_engine()
        self.projector = self.engine.StageBBudgetProjector()
        self.base = {
            "wave_id": "public-canaries", "plan_sha256": "a" * 64,
            "fleet_snapshot_hash": "b" * 64, "wave_result_sha256": "c" * 64,
            "predecessor_result_sha256": "N/A", "expected_predecessor_sha256": "N/A",
            "provider_fresh": True, "provider_observed_at": "2026-08-21T20:00:00Z",
            "copilot_categories": {
                "review-runner-time": "0", "premium-requests": "0", "seat-consumption": "0"
            },
        }

    def test_decimal_projection_passes_strictly_below_500(self):
        result = self.projector.project(minutes_per_week="100.00", **self.base)
        self.assertEqual(result["projectedPrivateMonthlyMinutes"], "433.333333")
        self.assertEqual(result["result"], "Pass")

    def test_boundary_missing_stale_and_predecessor_drift_block(self):
        boundary = self.projector.project(
            minutes_per_week="115.3846153846153846153846154", **self.base
        )
        self.assertEqual(boundary["result"], "Blocked")
        for changes in (
            {"minutes_per_week": "Missing"},
            {"minutes_per_week": "100", "provider_fresh": False},
            {"minutes_per_week": "100", "expected_predecessor_sha256": "d" * 64},
        ):
            arguments = {**self.base, **changes}
            with self.subTest(changes=changes), self.assertRaises(self.engine.ContractError):
                self.projector.project(**arguments)


class TerminalFleetEvidenceTests(unittest.TestCase):
    """Terminal evidence has exact ID/count, direct plan, wave, and budget bindings."""

    def test_exact_terminal_set_converges(self):
        engine = load_engine()
        plan_hash = "a" * 64
        ids = ["a-repository", "b-repository"]
        repositories = [
            {"repositoryId": item, "outcome": "Converged", "planSha256": plan_hash}
            for item in ids
        ]
        waves = [
            {"waveId": wave, "planSha256": plan_hash} for wave in engine.STAGE_B_WAVES
        ]
        budgets = [
            {"waveId": wave, "planSha256": plan_hash, "result": "Pass", "projectionSha256": str(index) * 64}
            for index, wave in enumerate(engine.STAGE_B_WAVES, start=1)
        ]
        isolation = engine.build_stage_b_g4_isolation(
            baseline_hashes={key: "b" * 64 for key in ("g4", "intakeSeries", "copilot", "account", "subscription")},
            current_hashes={key: "b" * 64 for key in ("g4", "intakeSeries", "copilot", "account", "subscription")},
        )
        evidence = engine.StageBTerminalVerifier().verify(
            run_id=engine.STAGE_B_RUN_ID, plan_id="11111111-1111-4111-8111-111111111111",
            plan_sha256=plan_hash, fleet_snapshot_hash="c" * 64,
            authoritative_repository_ids=ids, repository_results=repositories,
            wave_results=waves, budget_projections=budgets,
            level0_control_plane={"status": "Synchronized"}, g4_isolation=isolation,
        )
        self.assertEqual(evidence["convergedRepositoryCount"], evidence["authoritativeRepositoryCount"])
        self.assertTrue(all(value == 0 for value in evidence["redaction"].values()))

    def test_duplicate_or_missing_repository_blocks(self):
        engine = load_engine()
        with self.assertRaises(engine.ContractError):
            engine.StageBTerminalVerifier().verify(
                run_id=engine.STAGE_B_RUN_ID, plan_id=str(uuid.uuid4()), plan_sha256="a" * 64,
                fleet_snapshot_hash="b" * 64, authoritative_repository_ids=["a", "b"],
                repository_results=[{"repositoryId": "a", "outcome": "Converged", "planSha256": "a" * 64}],
                wave_results=[], budget_projections=[], level0_control_plane={}, g4_isolation={},
            )


class G4IsolationTests(unittest.TestCase):
    """G4, series, Copilot, account, and subscription remain unchanged."""

    def test_exact_isolation_has_only_separate_follow_up(self):
        engine = load_engine()
        values = {key: "a" * 64 for key in ("g4", "intakeSeries", "copilot", "account", "subscription")}
        result = engine.build_stage_b_g4_isolation(
            baseline_hashes=values, current_hashes=dict(values)
        )
        self.assertEqual(result["executedActions"], [])
        self.assertIn("separately authorized", result["nextExactAction"])

    def test_any_isolation_drift_blocks(self):
        engine = load_engine()
        baseline = {key: "a" * 64 for key in ("g4", "intakeSeries", "copilot", "account", "subscription")}
        current = dict(baseline, copilot="b" * 64)
        with self.assertRaises(engine.ContractError):
            engine.build_stage_b_g4_isolation(
                baseline_hashes=baseline, current_hashes=current
            )


class PlatformParityTests(unittest.TestCase):
    """Both adapters preserve one text-first contract without shell evaluation."""

    @classmethod
    def setUpClass(cls):
        engine = load_engine()
        cls.cases = json.loads(
            (FIXTURES / "platform-parity/cases.json").read_text(encoding="utf-8")
        )
        cls.expected_labels = [
            "Run-ID / Run ID", "Autoritaetsstatus / Authority status",
            "Dynamische Zielanzahl / Dynamic target count", "Wellen / Waves",
            "Erste Mutation / First mutation", "Budgetstatus / Budget status",
            "Entscheidung / Decision", "Status", "Blocker",
            "Naechste Aktion / Next action", "Planziel / Plan target",
            "State-Ziel / State target", "Vollstaendiger Plan / Complete plan",
        ]
        manifest = json.loads(
            (ROOT / "scripts/config/agentic-workspace-fleet.json").read_text(encoding="utf-8")
        )
        profiles = json.loads(
            (ROOT / "scripts/config/ci-budget-profiles.json").read_text(encoding="utf-8")
        )
        profile_by_id = {item["repositoryId"]: item["profileId"] for item in profiles["assignments"]}
        visibility = {item["profileId"]: item["requiredVisibility"] for item in profiles["profiles"]}
        head = subprocess.run(
            ["git", "-C", str(ROOT), "rev-parse", "HEAD"],
            text=True, capture_output=True, check=True,
        ).stdout.strip()
        source_targets = [
            {"id": "home-baseline", "remote": "https://github.com/hindermath/home-baseline.git", "defaultBranch": "main"},
            *[item for item in manifest["targets"] if item.get("active") and item.get("kind") == "git-repository"],
        ]
        inventory = []
        targets = []
        for index, item in enumerate(source_targets, start=1):
            repository_id = item["id"]
            profile_id = profile_by_id[repository_id]
            remote = pathlib.PurePosixPath(item["remote"].removesuffix(".git"))
            baseline_head = head if repository_id == "home-baseline" else "a" * 40
            inventory.append({
                "repositoryId": repository_id, "providerRepositoryId": str(index),
                "remoteIdentity": item["remote"], "slug": f"{remote.parts[-2]}/{remote.name}",
                "profileId": profile_id, "visibility": visibility[profile_id],
                "defaultBranch": item["defaultBranch"], "defaultHead": baseline_head,
                "defaultTree": "b" * 40, "localRepositoryRootHash": "c" * 64,
                "environmentRegistryHash": "d" * 64, "observedAt": "2026-08-23T00:00:00Z",
            })
            targets.append({
                "repositoryId": repository_id, "baselineHead": baseline_head,
                "baselineTree": "b" * 40, "defaultBranch": item["defaultBranch"],
                "stageAPlanHash": "c" * 64, "gateSetHash": "d" * 64,
                "pathContractHash": "e" * 64, "changes": [], "candidateTree": "b" * 40,
                "workflowAction": "N/A", "rulesetPlanHash": "N/A", "mergeMethod": "N/A",
                "requiredLocalGates": [], "requiredRemoteGates": [],
            })
        cls.fixture_input = {
            "source": "Fixture", "sourceRevision": engine.canonical_json_hash(inventory),
            "providerInventory": inventory, "assignments": profiles["assignments"], "targets": targets,
        }

    def run_wrapper(self, command, *, home="", bind_run_id=True):
        environment = os.environ.copy()
        with tempfile.TemporaryDirectory() as directory:
            fixture_path = pathlib.Path(directory) / "stage-b-input.json"
            fixture_path.write_text(json.dumps(self.fixture_input), encoding="utf-8")
            environment.update({
                "HOME": home,
                "HB_STAGE_B_WAVE_ID": "public-canaries",
                "HB_STAGE_B_REPOSITORY_ID": "agent-operations-cockpit",
                "HB_STAGE_B_PROFILE_ID": "public-canary",
                "HB_STAGE_B_TEST_MODE": "1",
                "HB_STAGE_B_TEST_FIXTURE": str(fixture_path),
            })
            if bind_run_id:
                environment["HB_STAGE_B_RUN_ID"] = "954ff259-ffed-44a8-883f-28742b031a9b"
            else:
                environment.pop("HB_STAGE_B_RUN_ID", None)
            return subprocess.run(
                command, cwd=ROOT, env=environment, text=True,
                stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False,
            )

    def bash_executable(self):
        if os.name != "nt":
            return "bash"
        candidates = []
        git_executable = shutil.which("git")
        if git_executable:
            candidates.append(pathlib.Path(git_executable).parent.parent / "bin/bash.exe")
        for environment_name in ("ProgramFiles", "ProgramFiles(x86)"):
            program_files = os.environ.get(environment_name)
            if program_files:
                candidates.append(pathlib.Path(program_files) / "Git/bin/bash.exe")
        for candidate in candidates:
            if candidate.is_file():
                return str(candidate)
        self.fail("Git-for-Windows Bash is required for native adapter parity")

    def test_bash_and_powershell_preview_have_identical_linear_semantics(self):
        commands = [
            [self.bash_executable(), "scripts/maintain-agentic-workspace.sh", "--stage-b-action", "preflight", "--dry-run"],
            ["pwsh", "-NoProfile", "-File", "scripts/maintain-agentic-workspace.ps1", "-StageBAction", "Preflight", "-WhatIf"],
        ]
        results = [self.run_wrapper(command) for command in commands]
        for result in results:
            self.assertEqual(
                result.returncode, 0,
                f"stdout:\n{result.stdout}\nstderr:\n{result.stderr}",
            )
            labels = [line.split(":", 1)[0] for line in result.stdout.splitlines()]
            self.assertEqual(labels, self.expected_labels)
        self.assertEqual(results[0].stdout, results[1].stdout)

    def test_empty_home_is_not_a_stage_b_dependency(self):
        result = self.run_wrapper([
            self.bash_executable(), "scripts/maintain-agentic-workspace.sh",
            "--stage-b-action", "preflight", "--dry-run",
        ])
        self.assertEqual(
            result.returncode, 0,
            f"stdout:\n{result.stdout}\nstderr:\n{result.stderr}",
        )

    def test_documented_preview_resolves_run_id_without_hidden_environment(self):
        commands = [
            [self.bash_executable(), "scripts/maintain-agentic-workspace.sh", "--stage-b-action", "preflight", "--dry-run"],
            ["pwsh", "-NoProfile", "-File", "scripts/maintain-agentic-workspace.ps1", "-StageBAction", "Preflight", "-WhatIf"],
        ]
        for command in commands:
            with self.subTest(command=command):
                result = self.run_wrapper(command, bind_run_id=False)
                self.assertEqual(
                    result.returncode, 0,
                    f"stdout:\n{result.stdout}\nstderr:\n{result.stderr}",
                )
                self.assertIn(
                    "Run-ID / Run ID: 954ff259-ffed-44a8-883f-28742b031a9b",
                    result.stdout,
                )

    def test_fixture_adapter_cannot_publish_plan_or_state(self):
        result = self.run_wrapper([
            self.bash_executable(), "scripts/maintain-agentic-workspace.sh",
            "--stage-b-action", "preflight",
        ])
        self.assertEqual(result.returncode, 2)
        self.assertIn("fixture input is forbidden", result.stderr)

    def test_whitespace_unicode_and_metacharacter_ids_fail_closed(self):
        engine = load_engine()
        for case in self.cases["cases"]:
            repository_id = case.get("repositoryId")
            if repository_id is None:
                continue
            with self.subTest(case=case["caseId"]), self.assertRaises(engine.ContractError):
                engine.validate_ci_input_component(repository_id)

    def test_wrappers_have_safe_process_and_preview_contracts(self):
        bash = (ROOT / "scripts/maintain-agentic-workspace.sh").read_text(encoding="utf-8")
        powershell = (ROOT / "scripts/maintain-agentic-workspace.ps1").read_text(encoding="utf-8")
        self.assertIn("set -euo pipefail", bash)
        self.assertNotIn("eval ", bash)
        self.assertIn("Set-StrictMode -Version Latest", powershell)
        self.assertNotIn("Invoke-Expression", powershell)
        self.assertIn("& $stageBPythonCommand $stageBFleetEngine @stageBArguments", powershell)
        self.assertIn("MINGW*|MSYS*|CYGWIN*) candidates=(python python3)", bash)
        self.assertIn("printf '%s\\n' \"$candidate\"", bash)
        self.assertIn("if ($IsWindows) { @('python', 'python3') }", powershell)


if __name__ == "__main__":
    raise SystemExit(unittest.main())
