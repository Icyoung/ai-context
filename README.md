# ai-context

A collaboration protocol that constrains AI behavior through explicit, versioned files.

## Core Principle

```
Global context defines the law.
Project context defines the truth.
```

**Files are truth, not memory.**

## Quick Start

```bash
# 1. Setup global protocol (once)
mkdir -p ~/.ai-context
ln -s /path/to/ai-context ~/.ai-context/protocol

# 2. Init project context
# Run "init ai-context" in Claude Code / Codex
```

Recommended install (Git working copy):

```bash
git clone https://github.com/Icyoung/ai-context.git ~/.ai-context/protocol
cd ~/.ai-context/protocol && git pull --ff-only
```

## Architecture

### Global: `~/.ai-context/protocol/` (read-only)

Protocol source. No project data. Law.

### Project: `<project>/.ai-context/` (writable)

```
.ai-context/
├── README.md        # Entry point / how to use this context
├── SYSTEM.md        # Project architecture
├── CONSTRAINTS.md   # Non-negotiable rules
├── ASSUMPTIONS.md   # Current assumptions
├── TERMINOLOGY.md   # Shared vocabulary
└── DECISIONS/       # Append-only log
```

Must be in Git. Must be reviewable. Truth.

## Protocol Structure

```
ai-context/                 # This repo
├── SYSTEM.md               # Protocol definition
├── RULES.md                # Collaboration rules
├── CONSTRAINTS.md          # Protocol constraints
├── DECISION-PROTOCOL.md    # How to write decisions
├── HANDOFF.md              # Session handoff rules
├── CONTEXT-STRUCTURE.md    # Project structure spec
├── TEMPLATES/              # AI behavior constraint
├── UI/                     # AI behavior constraint
├── ICONS/                  # Icon library for AI
├── SKILLS/                 # ai-context-init skill
└── DECISIONS/              # Protocol evolution log (versioned)
```

## For AI Agents

1. Read protocol from `~/.ai-context/protocol/`
2. Read/write context from `<project>/.ai-context/`
3. **Never write to global** — only to project
4. When unsure, write a decision
5. Do not modify TEMPLATES/, UI/, ICONS/ without a decision

## Validate

```bash
# protocol repo
bash scripts/ai-context-lint.sh

# project-local context (in a real project repo)
bash scripts/ai-context-lint.sh --project <path-to-project-ai-context>
```
