---
status: open
---
# DECISION 0011: Add `doctor` Checks and `skills.sh` Skill Management Script

Date: 2026-01-28
Author: Human / AI

## Context

为了让协议对外开放使用更顺畅，需要：

- 在“结构校验（lint）”之外，提供更面向用户的快速诊断（doctor）能力。
- 用一个脚本来管理/分发 `SKILLS/`（用户希望使用 `skills.sh`），减少手工复制并统一入口。

同时需要澄清概念：`skills.sh` 是 **工具脚本**（帮助安装/同步技能文件），而 “skill” 是给 AI 工具读取的 **SKILL.md 文档**；两者互补但不等价。

## Decision

1. 保留 `scripts/ai-context-lint.sh` 作为 **严格的结构校验器**（适合 CI/自动化）。
2. 新增 `scripts/ai-context-doctor.sh` 作为 **面向人类的诊断入口**：组合运行 lint + 关键运行时检查，并给出可执行的下一步建议。
3. 新增 `scripts/skills.sh` 作为 **技能管理脚本**：列出/安装/同步 `SKILLS/` 到目标目录（例如 Codex/Claude/自定义路径）。
4. 协议仓库内 `SKILLS/<name>/SKILL.md` 文件名大小写统一，避免跨平台路径问题。

## Implications

- 文档中应把 “lint vs doctor” 的定位差异说清楚（lint=严格检查，doctor=快速排障）。
- `skills.sh` 不取代 skill，本质是把 `SKILLS/` 的内容分发到各工具需要的位置。

