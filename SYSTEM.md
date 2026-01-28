# AI System Contract

This repository defines the canonical collaboration context
for all AI agents working on a codebase.

## Purpose

Solve two problems with AI coding agents:

1. **Memory sync across agents** — Multiple AI tools (Claude Code, Codex, Cursor, etc.) have no shared memory. Decisions made in one session are lost to others. This protocol makes decisions persist as files, enabling true multi-agent collaboration.

2. **Compensate AI weaknesses** — AI-generated UI tends to be generic ("AI aesthetic"). AI-generated icons are often poor or inconsistent. `UI/` and `ICONS/` provide canonical constraints and references to raise quality.

## Rules

- Files in this repository are authoritative.
- Constraints are hard requirements, not suggestions.
- Silent architectural or semantic decisions are forbidden.
- If conflict or ambiguity exists, stop and ask.
- Shared truth must be written, not remembered.
- `UI/` and `ICONS/` are canonical protocol context (not optional) and must not be removed without an explicit decision.
