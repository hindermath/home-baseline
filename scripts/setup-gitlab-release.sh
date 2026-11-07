#!/usr/bin/env bash
# setup-gitlab-release.sh — Installiert GitLab Release-Automation in ein bestehendes Repo
#
# Usage:
#   bash scripts/setup-gitlab-release.sh [TARGET_REPO] [--gitlab-url URL] [--skip-project-settings] [--force]
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="${SCRIPT_DIR}/templates"
. "${SCRIPT_DIR}/lib/secure-development-hardening.sh"

TARGET_REPO="$PWD"
OPT_GITLAB_URL=""
OPT_EXPECTED_PROJECT=""
OPT_SKIP_PROJECT_SETTINGS=false
OPT_FORCE=false

usage() {
  cat <<'EOF'
USAGE:
  bash scripts/setup-gitlab-release.sh [TARGET_REPO] [OPTIONS]

OPTIONS:
  --gitlab-url URL         GitLab base URL, for example https://gitlab-ce.gwdg.de
  --expected-project ID    Exact HOST/GROUP/PROJECT authorization for project settings
  --skip-project-settings  Do not enable ci_push_repository_for_job_token_allowed
  --force                  Overwrite release-gitlab.sh and CHANGELOG.md if present
  -h, --help               Show this help
EOF
}

short_path() {
  printf '%s' "${1/#$HOME/~}"
}

normalize_repo_path() {
  local path="$1"
  path="${path/#\~/$HOME}"
  printf '%s' "${path%/}"
}

install_template_atomic() {
  local source="$1" repo="$2" relative="$3" executable="${4:-false}"
  local target="$repo/$relative" parent temp
  sdh_assert_safe_managed_destination "$repo" "$relative"
  parent="$(dirname "$target")"
  mkdir -p "$parent"
  sdh_assert_safe_managed_destination "$repo" "$relative"
  temp="$(mktemp "$parent/.$(basename "$target").XXXXXX")"
  cp -- "$source" "$temp"
  if [ "$executable" = true ]; then chmod 700 "$temp"; fi
  sdh_assert_safe_managed_destination "$repo" "$relative"
  mv -f -- "$temp" "$target"
}

parse_gitlab_remote() {
  local remote="$1" authority path
  REMOTE_HOST=""
  REMOTE_PATH=""
  case "$remote" in
    https://*)
      authority="${remote#https://}"
      [ "$authority" != "${authority#*/}" ] || return 1
      path="${authority#*/}"
      authority="${authority%%/*}"
      [[ "$authority" != *"@"* ]] || return 1
      REMOTE_HOST="$authority"
      REMOTE_PATH="${path%.git}"
      ;;
    git@*:*)
      REMOTE_HOST="${remote#git@}"
      REMOTE_HOST="${REMOTE_HOST%%:*}"
      REMOTE_PATH="${remote#*:}"
      REMOTE_PATH="${REMOTE_PATH%.git}"
      ;;
    ssh://git@*/*)
      authority="${remote#ssh://git@}"
      REMOTE_HOST="${authority%%/*}"
      REMOTE_PATH="${authority#*/}"
      REMOTE_PATH="${REMOTE_PATH%.git}"
      ;;
    *) return 1 ;;
  esac
  [[ "$REMOTE_HOST" =~ ^[A-Za-z0-9.-]+(:[0-9]+)?$ ]] || return 1
  [[ "$REMOTE_PATH" =~ ^[A-Za-z0-9._-]+(/[A-Za-z0-9._-]+)+$ ]] || return 1
  [[ "/$REMOTE_PATH/" != *"/../"* ]] || return 1
}

gitlab_url_host() {
  local value="$1" authority
  [[ "$value" == https://* ]] || return 1
  authority="${value#https://}"
  authority="${authority%/}"
  [[ "$authority" != */* && "$authority" != *"@"* ]] || return 1
  [[ "$authority" =~ ^[A-Za-z0-9.-]+(:[0-9]+)?$ ]] || return 1
  printf '%s\n' "$authority"
}

ensure_release_stage() {
  local ci_file="$1"
  local tmp_file

  if grep -Eq '^stages:[[:space:]]*\[[^]]*\brelease\b[^]]*\]' "$ci_file" \
    || grep -Eq '^[[:space:]]*-[[:space:]]*release[[:space:]]*$' "$ci_file"; then
    return 0
  fi

  tmp_file="$(mktemp "${ci_file}.stage.XXXXXX")"
  if grep -Eq '^stages:[[:space:]]*\[.*\]' "$ci_file"; then
    awk '
      BEGIN { done = 0 }
      {
        if (!done && $0 ~ /^stages:[[:space:]]*\[.*\][[:space:]]*$/) {
          sub(/\][[:space:]]*$/, ", release]")
          done = 1
        }
        print
      }
    ' "$ci_file" > "$tmp_file"
  elif grep -Eq '^stages:[[:space:]]*$' "$ci_file"; then
    awk '
      BEGIN { in_stages = 0; inserted = 0 }
      /^stages:[[:space:]]*$/ {
        print
        in_stages = 1
        next
      }
      {
        if (in_stages && $0 !~ /^[[:space:]]*-[[:space:]]+/) {
          print "  - release"
          inserted = 1
          in_stages = 0
        }
        print
      }
      END {
        if (in_stages && !inserted) {
          print "  - release"
        }
      }
    ' "$ci_file" > "$tmp_file"
  else
    {
      printf 'stages:\n  - release\n\n'
      cat "$ci_file"
    } > "$tmp_file"
  fi

  mv -f -- "$tmp_file" "$ci_file"
}

enable_job_token_push() {
  local target_repo="$1"
  local remote_url gitlab_host repo_path encoded_path

  if $OPT_SKIP_PROJECT_SETTINGS; then
    echo "  INFO: GitLab project settings skipped"
    return 0
  fi

  remote_url="$(git -C "$target_repo" remote get-url origin 2>/dev/null || true)"
  if [ -z "$remote_url" ]; then
    echo "  WARN: origin remote missing — project setting not changed"
    return 0
  fi

  if ! parse_gitlab_remote "$remote_url"; then
    echo "  WARN: origin remote is not a supported credential-free GitLab URL"
    return 0
  fi
  repo_path="$REMOTE_PATH"

  if ! command -v glab >/dev/null 2>&1; then
    echo "  WARN: glab not installed — project setting not changed"
    return 0
  fi

  if [ -n "$OPT_GITLAB_URL" ]; then
    if ! gitlab_host="$(gitlab_url_host "$OPT_GITLAB_URL")"; then
      echo "  WARN: --gitlab-url must be a credential-free HTTPS host"
      return 0
    fi
    if [ "$gitlab_host" != "$REMOTE_HOST" ]; then
      echo "  WARN: --gitlab-url host does not match origin; project setting not changed"
      return 0
    fi
  else
    gitlab_host="$REMOTE_HOST"
  fi

  if [ -z "$gitlab_host" ]; then
    echo "  WARN: could not derive GitLab host from origin remote"
    return 0
  fi

  if [ -z "$OPT_EXPECTED_PROJECT" ]; then
    echo "  WARN: --expected-project is required before changing project settings"
    return 0
  fi
  if [ "$OPT_EXPECTED_PROJECT" != "${gitlab_host}/${repo_path}" ]; then
    echo "  WARN: expected GitLab project does not match origin; project setting not changed"
    return 0
  fi

  if ! GITLAB_HOST="$gitlab_host" glab auth status >/dev/null 2>&1; then
    echo "  WARN: not authenticated for GitLab host ${gitlab_host}"
    return 0
  fi

  encoded_path="${repo_path//\//%2F}"
  if GITLAB_HOST="$gitlab_host" glab api --method PUT \
    "projects/${encoded_path}?ci_push_repository_for_job_token_allowed=true" >/dev/null 2>&1; then
    echo "  OK: enabled ci_push_repository_for_job_token_allowed for ${repo_path}"
  else
    echo "  WARN: could not enable ci_push_repository_for_job_token_allowed for ${repo_path}"
  fi
}

while [ $# -gt 0 ]; do
  case "$1" in
    --gitlab-url)
      OPT_GITLAB_URL="${2:-}"
      [ -n "$OPT_GITLAB_URL" ] || { echo "ERROR: --gitlab-url requires a value" >&2; exit 2; }
      shift
      ;;
    --expected-project)
      OPT_EXPECTED_PROJECT="${2:-}"
      [ -n "$OPT_EXPECTED_PROJECT" ] || { echo "ERROR: --expected-project requires a value" >&2; exit 2; }
      shift
      ;;
    --skip-project-settings)
      OPT_SKIP_PROJECT_SETTINGS=true
      ;;
    --force)
      OPT_FORCE=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --*)
      echo "ERROR: unknown option $1" >&2
      usage >&2
      exit 2
      ;;
    *)
      TARGET_REPO="$1"
      ;;
  esac
  shift
done

TARGET_REPO="$(normalize_repo_path "$TARGET_REPO")"

for required in \
  "${TEMPLATES_DIR}/release-gitlab.sh.tmpl" \
  "${TEMPLATES_DIR}/gitlab-release-job.yml.tmpl" \
  "${TEMPLATES_DIR}/changelog-template.md"; do
  if [ ! -f "$required" ]; then
    echo "ERROR: missing template $(short_path "$required")" >&2
    exit 1
  fi
done

if [ -L "$TARGET_REPO" ] || [ ! -e "$TARGET_REPO/.git" ]; then
  echo "ERROR: target is not a git repository: $(short_path "$TARGET_REPO")" >&2
  exit 2
fi
TARGET_REPO="$(cd "$TARGET_REPO" && pwd -P)"
git_root="$(git -C "$TARGET_REPO" rev-parse --show-toplevel 2>/dev/null || true)"
[ -n "$git_root" ] || { echo "ERROR: target is not a git repository root" >&2; exit 2; }
git_root="$(cd "$git_root" && pwd -P)"
[ "$git_root" = "$TARGET_REPO" ] || { echo "ERROR: target must be the exact repository root" >&2; exit 2; }

for managed_path in scripts/release-gitlab.sh CHANGELOG.md .gitlab-ci.yml; do
  sdh_assert_safe_managed_destination "$TARGET_REPO" "$managed_path"
done

echo "GitLab release automation"
echo "Target: $(short_path "$TARGET_REPO")"

if [ ! -e "${TARGET_REPO}/scripts/release-gitlab.sh" ] || $OPT_FORCE; then
  install_template_atomic "${TEMPLATES_DIR}/release-gitlab.sh.tmpl" "$TARGET_REPO" scripts/release-gitlab.sh true
  echo "  OK: wrote scripts/release-gitlab.sh"
else
  echo "  INFO: scripts/release-gitlab.sh already present"
fi

if [ ! -f "${TARGET_REPO}/CHANGELOG.md" ] || $OPT_FORCE; then
  install_template_atomic "${TEMPLATES_DIR}/changelog-template.md" "$TARGET_REPO" CHANGELOG.md false
  echo "  OK: wrote CHANGELOG.md"
else
  echo "  INFO: CHANGELOG.md already present"
fi

ci_file="${TARGET_REPO}/.gitlab-ci.yml"
job_template="$(cat "${TEMPLATES_DIR}/gitlab-release-job.yml.tmpl")"

if [ ! -f "$ci_file" ]; then
  ci_tmp="$(mktemp "${TARGET_REPO}/.gitlab-ci.XXXXXX")"
  {
    printf 'stages:\n  - release\n\n'
    printf '%s\n' "$job_template"
  } > "$ci_tmp"
  sdh_assert_safe_managed_destination "$TARGET_REPO" '.gitlab-ci.yml'
  mv -f -- "$ci_tmp" "$ci_file"
  echo "  OK: created .gitlab-ci.yml"
else
  ci_tmp="$(mktemp "${TARGET_REPO}/.gitlab-ci.XXXXXX")"
  cp -- "$ci_file" "$ci_tmp"
  ensure_release_stage "$ci_tmp"
  if grep -q 'home-baseline gitlab release automation' "$ci_tmp"; then
    echo "  INFO: release job already present in .gitlab-ci.yml"
  else
    printf '\n%s\n' "$job_template" >> "$ci_tmp"
    echo "  OK: appended release job to .gitlab-ci.yml"
  fi
  sdh_assert_safe_managed_destination "$TARGET_REPO" '.gitlab-ci.yml'
  mv -f -- "$ci_tmp" "$ci_file"
fi

enable_job_token_push "$TARGET_REPO"

echo "Done."
