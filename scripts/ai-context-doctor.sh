#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
ai-context-doctor.sh

Quick diagnostics for ai-context installations.

Usage:
  bash scripts/ai-context-doctor.sh
  bash scripts/ai-context-doctor.sh --project <path-to-project-ai-context>

What it checks:
  - Runs ai-context-lint (protocol or project)
  - Verifies decision listing works
  - Warns if ~/.ai-context/protocol is missing
EOF
}

MODE="protocol"
PROJECT_PATH=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)
      MODE="project"
      PROJECT_PATH="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

echo "=== ai-context doctor ==="
echo "Reminder: If you provide evaluation/recommendation/plan, write a decision before replying."

if [[ "$MODE" == "project" ]]; then
  if [[ -z "$PROJECT_PATH" ]]; then
    echo "FAIL: --project requires a path" >&2
    exit 1
  fi
  echo "Mode: project"
  echo "Project: $PROJECT_PATH"
  bash scripts/ai-context-lint.sh --project "$PROJECT_PATH"
  bash scripts/ai-context-decisions.sh -n 1 -d "$PROJECT_PATH/DECISIONS" >/dev/null
else
  echo "Mode: protocol"
  bash scripts/ai-context-lint.sh
  bash scripts/ai-context-decisions.sh -n 1 >/dev/null 2>&1 || true
fi

if [[ ! -d "${HOME}/.ai-context/protocol" ]]; then
  echo "WARN: ${HOME}/.ai-context/protocol not found (install the protocol there for best UX)"
fi

echo "Status: OK"
