# Agents Repository

This repository is the shared home for agent resources used across Elegant Chaos projects.

GitHub: [github.com/elegantchaos/Agents](https://github.com/elegantchaos/Agents)

It provides:

- shared baseline guidance in `~/.local/share/agents/COMMON.md`
- shared Codex rule files under `~/.local/share/agents/codex/rules/`
- shared skills under `~/.local/share/agents/skills/`, maintained with the standalone `agt` command

## First Use

Clone this repository to:

- `~/.local/share/agents`

Install AgentTools with Mint, then initialize and link the published shared skills:

```bash
mint install elegantchaos/AgentTools
agt skills sync --all
agt skills link
agt rules sync
```

## Shared Rules

Shared reusable Codex approval rules live in `codex/rules/`. Use `agt rules sync` to copy them into `~/.codex/rules/` as generated regular files. The runtime-only `default.rules` file is intentionally not stored in this repository.

## Shared Skills

Published shared skills live under `skills/` in this repository and are linked into `~/.agents/skills/`.
Most published skills are git submodules.
Repo-local operational skills such as `skills/refresh-skill/` live alongside them because they are tightly coupled to this repository.
Runtime names come from the discovered `name:` field in each skill's `SKILL.md`.

## Maintenance Skills

- Use the `refresh` skill to update shared resources, sync and link published skill submodules, optionally research shared guidance improvements, and refresh a project's `AGENTS.md`.
