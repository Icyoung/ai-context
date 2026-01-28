---
status: open
---
# DECISION 0010: Protocol Repo Distribution, Decision Log Location, and Lint Enforcement

Date: 2026-01-28
Author: Human / AI

## Context

该仓库是 **协议本身**，需要开放给其他用户使用（作为 `~/.ai-context/protocol` 的来源），而不是把本仓库当作一个“普通项目”去维护自己的 project-local `.ai-context/`。

因此，本仓库不应要求把 `.ai-context/` 纳入 Git 或随协议分发；同时又需要保证协议演进的决策日志依然是可审计、可 review、可 diff 的。

此外，历史决策（DECISION 0002 vs DECISION 0006）对“协议仓库的决策日志应放在哪里”存在冲突，需要统一。

## Decision

1. **协议仓库（本仓库）的决策日志**使用仓库根目录 `DECISIONS/`（纳入 Git，随协议分发）。
2. **项目仓库（用户实际项目）的决策日志**使用 `<project>/.ai-context/DECISIONS/`（纳入项目 Git，作为项目真相）。
3. 本协议仓库的 `.ai-context/`（若存在）仅用于本地开发/演示，不作为协议分发的一部分，且应默认被 `.gitignore` 忽略。
4. `scripts/ai-context-lint.sh` 必须以文件检查方式强制上述规则（protocol lint 检查 `DECISIONS/` 存在；并检查 `.gitignore` 忽略 `.ai-context/`）。

## Implications

- 更新 `scripts/ai-context-lint.sh` 的 protocol 校验：不再要求 `.ai-context/`；改为要求 `DECISIONS/` 至少包含 `0001-*.md`。
- 更新 `scripts/ai-context-decisions.sh`：在协议仓库中可读取 `DECISIONS/`；在项目中默认读取 `.ai-context/DECISIONS/`（可自动探测或通过参数指定）。
- 文档（如 `DECISION-PROTOCOL.md`）需要明确“协议仓库 vs 项目仓库”两种决策日志位置，避免新人困惑。

