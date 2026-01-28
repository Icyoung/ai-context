#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
skills.sh

Manage protocol skills (copy SKILLS/<name>/SKILL.md into a tool's skills directory).

Usage:
  bash scripts/skills.sh list
  bash scripts/skills.sh install <name|all> [--target <dir> | --codex | --agents]

Targets:
  --codex   Install into ${CODEX_HOME:-$HOME/.codex}/skills
  --agents  Install into $HOME/.agents/skills
  --target  Install into an explicit directory

Notes:
  - This script is a helper tool; the "skills" are the SKILL.md documents themselves.
EOF
}

cmd="${1:-}"
shift || true

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_src="${repo_root}/SKILLS"

case "$cmd" in
  list)
    find "$skills_src" -mindepth 1 -maxdepth 1 -type d -print | sed 's|.*/||' | sort
    exit 0
    ;;
  install)
    name="${1:-}"
    shift || true
    if [[ -z "$name" ]]; then
      echo "FAIL: install requires <name|all>" >&2
      usage >&2
      exit 1
    fi

    target=""
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --target)
          target="$2"
          shift 2
          ;;
        --codex)
          target="${CODEX_HOME:-$HOME/.codex}/skills"
          shift
          ;;
        --agents)
          target="$HOME/.agents/skills"
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

    if [[ -z "$target" ]]; then
      echo "FAIL: specify a target with --codex, --agents, or --target" >&2
      exit 1
    fi

    mkdir -p "$target"

    install_one() {
      local skill_name="$1"
      local src_dir="${skills_src}/${skill_name}"
      local src_file="${src_dir}/SKILL.md"
      local dst_dir="${target}/${skill_name}"
      local dst_file="${dst_dir}/SKILL.md"

      if [[ ! -f "$src_file" ]]; then
        echo "FAIL: missing ${src_file}" >&2
        exit 1
      fi

      mkdir -p "$dst_dir"
      cp "$src_file" "$dst_file"
      echo "Installed: ${skill_name} -> ${dst_file}"
    }

    if [[ "$name" == "all" ]]; then
      while IFS= read -r d; do
        install_one "$d"
      done < <(find "$skills_src" -mindepth 1 -maxdepth 1 -type d -print | sed 's|.*/||' | sort)
    else
      install_one "$name"
    fi
    ;;
  ""|--help|-h)
    usage
    exit 0
    ;;
  *)
    echo "Unknown command: $cmd" >&2
    usage >&2
    exit 1
    ;;
esac

