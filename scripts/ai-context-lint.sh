#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
ai-context-lint.sh

Validate ai-context protocol/project context structure.

Usage:
  bash scripts/ai-context-lint.sh
  bash scripts/ai-context-lint.sh --project <path-to-project-ai-context>

Exit codes:
  0  OK
  1  Validation failed
EOF
}

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  FAILED=1
}

check_file() {
  local path="$1"
  if [[ ! -f "$path" ]]; then
    fail "Missing file: $path"
  fi
}

check_dir() {
  local path="$1"
  if [[ ! -d "$path" ]]; then
    fail "Missing directory: $path"
  fi
}

check_any_glob() {
  local pattern="$1"
  shopt -s nullglob
  local matches=($pattern)
  shopt -u nullglob
  if (( ${#matches[@]} == 0 )); then
    fail "Missing: $pattern"
  fi
}

lint_protocol_repo() {
  check_file README.md
  check_file SYSTEM.md
  check_file RULES.md
  check_file CONSTRAINTS.md
  check_file ASSUMPTIONS.md
  check_file TERMINOLOGY.md
  check_file DECISION-PROTOCOL.md
  check_file CONTEXT-STRUCTURE.md
  check_file HANDOFF.md
  check_file .gitignore

  check_dir UI
  check_dir ICONS

  # This repo is the protocol itself; project-local truth (including decisions) must live in .ai-context/,
  # and should not be shipped as part of the protocol distribution.
  if ! grep -qE '^[[:space:]]*\.ai-context/([[:space:]]*(#.*)?)?$' .gitignore; then
    fail ".gitignore must ignore .ai-context/ (project-local truth) for the protocol repo"
  fi

  # This repo is the protocol itself. Decisions belong to project-local truth, not protocol law.
  # Do not require a repo-level DECISIONS/ directory here.
  if [[ -d "DECISIONS" ]]; then
    fail "Protocol repo should not have a root DECISIONS/ directory; use .ai-context/DECISIONS/ instead"
  fi

  if ! grep -qi 'UI/' SYSTEM.md || ! grep -qi 'ICONS/' SYSTEM.md || ! grep -qi 'canonical' SYSTEM.md; then
    fail "SYSTEM.md must explicitly state that UI/ and ICONS/ are canonical protocol context"
  fi

  if ! find ICONS -type f -name '*.svg' -print -quit | grep -q .; then
    fail "ICONS/ should contain at least one .svg reference icon (low content density is not a deletion signal)"
  fi

  check_file ICONS/libraries/lucide/LICENSE
  check_file ICONS/libraries/heroicons/LICENSE
}

lint_project_context() {
  local root="$1"
  check_dir "$root"
  check_file "$root/README.md"
  check_file "$root/SYSTEM.md"
  check_file "$root/CONSTRAINTS.md"
  check_file "$root/ASSUMPTIONS.md"
  check_file "$root/TERMINOLOGY.md"
  check_dir "$root/DECISIONS"
}

main() {
  FAILED=0

  if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
    usage
    exit 0
  fi

  if [[ "${1:-}" == "--project" ]]; then
    if [[ $# -ne 2 ]]; then
      usage >&2
      exit 1
    fi
    lint_project_context "$2"
  else
    lint_protocol_repo
  fi

  if [[ "$FAILED" -ne 0 ]]; then
    exit 1
  fi

  echo "OK"
}

main "$@"
