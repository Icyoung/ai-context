---
name: ai-context-lint
description: |
  Validate ai-context protocol and project-local context structure.
  Use when: (1) Checking protocol integrity, (2) A repo is missing context files, (3) Someone proposes deleting "unused" context.
  This skill treats canonical context as enforceable via file inspection.
---

# AI Context Lint / Validator

## Workflow

1. **Ask what to validate**:
   - Protocol repo (this repository)
   - Project-local `ai-context/` directory

2. **Run lint**:
   - Protocol: `bash scripts/ai-context-lint.sh`
   - Project: `bash scripts/ai-context-lint.sh --project <path>`

3. **If lint fails**:
   - Report missing items as the source of truth
   - Propose minimal patches
   - If removal/renaming is intended, require an explicit decision first

## Notes

- `UI/` and `ICONS/` are canonical protocol context and must not be removed without an explicit decision.

