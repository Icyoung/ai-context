# Project Instructions for Codex

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
<!-- /ai-context -->
