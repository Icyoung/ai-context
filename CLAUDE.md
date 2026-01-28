# Project Instructions for Claude Code

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

Key principle:
```
Global context defines the law.
Project context defines the truth.
```

Decision recording policy (Must/Ask/Skip):
- **Must record**: evaluations, architectural recommendations, naming changes, trade-offs
- **Ask first**: medium importance or uncertain
- Write decision **before replying** when "Must record" applies.

## Pre-flight Checklist (BEFORE EVERY REPLY)

**STOP. Before you reply, check:**

1. **Open decisions?** → Read, understand, execute, then resolve. NEVER resolve blindly.
2. **Is this an evaluation/analysis/recommendation?** → Write decision FIRST, reply AFTER.
3. **Is this a trade-off or architectural choice?** → Write decision FIRST, reply AFTER.

**Default behavior must be: Check → Record → Reply (not Reply → Maybe record)**

Failure to follow this checklist defeats the purpose of the protocol.
<!-- /ai-context -->
