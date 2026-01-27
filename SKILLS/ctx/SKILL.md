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

Check `.ai-context/` exists. If missing, tell user to run `ai-context-init`.

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
- Total decisions count
- Any issues found
- Ready to work

## Output format

```
=== ai-context status ===
Project: <cwd>
Decisions: N total
Latest: DECISION XXXX: <title>

[Latest decision content]

Status: Ready ✓
```
