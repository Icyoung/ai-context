---
name: ctx
description: |
  Bootstrap the ai-context protocol for AI-assisted coding projects.
  Use when: (1) Starting work on a new project, (2) User says "ctx", "init context", or "initialize context",
  (3) Need to create or validate project .ai-context structure.
  This skill ensures all AI agents share understanding through files, not model memory.
---

# AI Context Protocol Bootstrapper

## Core Principle

```
Global context defines the law.
Project context defines the truth.
```

## Workflow

### Step 1: Ensure global protocol exists

Check `~/.ai-context/protocol/`. If missing, **clone** from GitHub:

```bash
git clone https://github.com/Icyoung/ai-context.git ~/.ai-context/protocol
```

To update existing protocol:
```bash
cd ~/.ai-context/protocol && git pull --ff-only
```

**Offline fallback** (if GitHub unavailable):
```bash
mkdir -p ~/.ai-context/protocol
cp -r ${AI_CONTEXT_REPO:-/path/to/ai-context}/{SYSTEM.md,RULES.md,CONSTRAINTS.md,ASSUMPTIONS.md,TERMINOLOGY.md,DECISION-PROTOCOL.md,HANDOFF.md,CONTEXT-STRUCTURE.md,TEMPLATES,UI,ICONS} ~/.ai-context/protocol/
```

### Step 2: Create project-local context

Target: `<cwd>/.ai-context/`

If exists → validate structure, report missing files.

If missing → create:
```
.ai-context/
├── README.md
├── SYSTEM.md
├── CONSTRAINTS.md
├── ASSUMPTIONS.md
├── TERMINOLOGY.md
└── DECISIONS/
```

### Step 3: Configure auto-check on session start

Create/append ai-context instructions to both:
- `CLAUDE.md` (for Claude Code)
- `AGENTS.md` (for Codex)

**Check if already configured:** Look for `<!-- ai-context -->` marker.

If not configured, append:

```markdown
<!-- ai-context -->
## ai-context Protocol

This project follows the ai-context protocol. On session start, automatically:

1. Run `bash scripts/ai-context-decisions.sh -l` to list all decisions
2. Run `bash scripts/ai-context-decisions.sh -n 1` to show latest decision
3. Report status briefly

Key files:
- `.ai-context/SYSTEM.md` - System overview
- `.ai-context/CONSTRAINTS.md` - Non-negotiable rules
- `.ai-context/ASSUMPTIONS.md` - Current assumptions
- `.ai-context/TERMINOLOGY.md` - Shared vocabulary
- `.ai-context/DECISIONS/` - Decision log (append-only)

Decision recording policy (Must/Ask/Skip):
- **Must record**: evaluations, architectural recommendations, naming changes, trade-offs
- **Ask first**: medium importance or uncertain
- Write decision **before replying** when "Must record" applies.
<!-- /ai-context -->
```

## Red Line

**Never write decisions or assumptions to global (~/.ai-context/).**

Global = read-only protocol source.
Project = writable truth.

## File Templates

### SYSTEM.md
```markdown
# System Overview

[Describe the system architecture and purpose]
```

### CONSTRAINTS.md
```markdown
# Constraints

- [Non-negotiable rules]
```

### ASSUMPTIONS.md
```markdown
# Assumptions

- [Current assumptions, update when they change]
```

### TERMINOLOGY.md
```markdown
# Terminology

| Term | Definition |
|------|------------|
```

### DECISIONS/

```markdown
# DECISION XXXX: <Title>

Date:
Author:

## Context
## Decision
## Implications
```

## Decision Recording

### Must record (no confirmation needed)

- Project evaluation / analysis
- Architectural recommendations
- Naming or structure changes
- Improvement plans
- Trade-off decisions
- Any advice that affects future work

### May ask first

- Minor observations
- Uncertain whether it's significant

## Protocol Reminders

- Files are authoritative, not conversations
- Decisions are append-only
- When unsure, write a decision
- If conflict exists, stop and ask
