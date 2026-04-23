# Agents Repository

This repository is the shared home for agent resources used across Elegant Chaos projects.

GitHub: [github.com/elegantchaos/Agents](https://github.com/elegantchaos/Agents)

It provides:

- shared baseline guidance in `~/.local/share/agents/COMMON.md`
- shared Codex rule files under `~/.local/share/agents/codex/rules/`
- shared skills under `~/.local/share/agents/skills/` plus `agent-tools`, the SwiftPM maintenance tool that manages them

## First Use

Clone this repository to:

- `~/.local/share/agents`

Then initialize and link the published shared skills:

```bash
swift run agent-tools skills sync --all
swift run agent-tools skills link
```

## Shared Rules

Shared reusable Codex approval rules live in `codex/rules/`. Runtime rule files under `~/.codex/rules/` should symlink to these shared files where applicable.

## Shared Skills

Published shared skills live under `skills/` in this repository and are linked into `~/.agents/skills/`.
Most published skills are git submodules.
Repo-local operational skills such as `skills/refresh-skill/` live alongside them because they are tightly coupled to this repository.
Runtime names come from the discovered `name:` field in each skill's `SKILL.md`.

## Maintenance Skills

- Use the `refresh` skill to update shared resources, sync and link published skill submodules, optionally research shared guidance improvements, and refresh a project's `AGENTS.md`.
