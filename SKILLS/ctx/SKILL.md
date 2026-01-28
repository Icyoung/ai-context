---
name: ctx
description: |
  Quick ai-context status check. Shows decisions and context health.
  Use when: (1) Starting a session, (2) User says "ctx", (3) Need quick context refresh.
  For full initialization, use ai-context-init instead.
---

# AI Context Quick Check

## What this does

Fast context check for daily use. Run at session start or anytime.

## Workflow

### 1. Verify structure exists

Check a decision log exists:
- Project repos: `.ai-context/`
- Protocol repo: `DECISIONS/`

If neither exists, tell user to run `ai-context-init` (for project repos) or install the protocol repo (for protocol usage).

### 2. List all decisions

```bash
bash scripts/ai-context-decisions.sh -l
```

### 3. Show latest decision

```bash
bash scripts/ai-context-decisions.sh -n 1
```

### 4. Report status

Brief summary:
- Open decisions count (need attention)
- Total decisions count
- Any issues found
- Ready to work

## Output format

```
=== ai-context status ===
Project: <cwd>
Decisions: N open, M total
Latest open: DECISION XXXX: <title>

[Latest decision content]

Status: Ready ✓
```

## Notes

- Script defaults to showing only `open` decisions
- Resolved decisions are skipped (already processed)
- Use `-s all` to see all decisions regardless of status
