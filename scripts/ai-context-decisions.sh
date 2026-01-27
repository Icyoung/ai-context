#!/usr/bin/env bash
set -euo pipefail

# ai-context-decisions.sh
# Show latest decisions from project context

usage() {
  cat <<'EOF'
ai-context-decisions.sh

Show recent decisions from .ai-context/DECISIONS/

Usage:
  bash scripts/ai-context-decisions.sh [options]

Options:
  -n <num>    Show last N decisions (default: 1)
  -l          List all decisions (titles only)
  -a          Show all decisions (full content)
  --help      Show this help
EOF
}

DECISIONS_DIR=".ai-context/DECISIONS"
NUM=1
LIST_ONLY=0
SHOW_ALL=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -n)
      NUM="$2"
      shift 2
      ;;
    -l)
      LIST_ONLY=1
      shift
      ;;
    -a)
      SHOW_ALL=1
      shift
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

if [[ ! -d "$DECISIONS_DIR" ]]; then
  echo "No decisions directory found at $DECISIONS_DIR" >&2
  exit 1
fi

# Get sorted decision files (newest first by filename)
FILES=()
while IFS= read -r f; do
  FILES+=("$f")
done < <(ls -1 "$DECISIONS_DIR"/*.md 2>/dev/null | sort -r)

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "No decisions found."
  exit 0
fi

if [[ $LIST_ONLY -eq 1 ]]; then
  echo "=== Decisions (${#FILES[@]} total) ==="
  for f in "${FILES[@]}"; do
    title=$(head -1 "$f" | sed 's/^# //')
    echo "  $(basename "$f"): $title"
  done
  exit 0
fi

if [[ $SHOW_ALL -eq 1 ]]; then
  NUM=${#FILES[@]}
fi

echo "=== Latest Decision(s) ==="
echo ""

for ((i=0; i<NUM && i<${#FILES[@]}; i++)); do
  f="${FILES[$i]}"
  echo "--- $(basename "$f") ---"
  cat "$f"
  echo ""
done
