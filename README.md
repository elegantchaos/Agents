# Agents Repository

This repository is the shared home for agent resources used across Elegant Chaos projects.

GitHub: [github.com/elegantchaos/Agents](https://github.com/elegantchaos/Agents)

It provides:

- shared baseline guidance in `~/.local/share/agents/COMMON.md`
- shared Codex rule files under `~/.local/share/agents/codex/rules/`
- shared skill submodules, scripts, and local control-plane files for published skills

## First Use

Clone this repository to:

- `~/.local/share/agents`

Then initialize and link the published shared skills:

```bash
./scripts/skills-public/sync-skill-repos.sh --all
./scripts/skills-public/link-skill-repos.sh
```

## Shared Rules

Shared reusable Codex approval rules live in `codex/rules/`. Runtime rule files under `~/.codex/rules/` should symlink to these shared files where applicable.

## Shared Skills

Published shared skills live as git submodules under `skills/` in this repository and are linked into `~/.agents/skills/`. Runtime names come from the discovered `name:` field in each skill's `SKILL.md`.

## Maintenance Skills

- Use the `refresh-agents` skill to review or refresh this shared agents repository.
- Use the `refresh-public-skills` skill to sync, link, audit, and verify the published shared skill submodules.
