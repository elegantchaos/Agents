# Agents Repository

This repository is the shared home for agent resources used across Elegant Chaos projects.

GitHub: [github.com/elegantchaos/Agents](https://github.com/elegantchaos/Agents)

It provides:

- shared reference modules under `~/.local/share/agents/references/`
- shared Codex rule files under `~/.local/share/agents/codex/rules/`
- shared skill metadata, scripts, and local control-plane files for published skills

## First Use

Clone this repository to:

- `~/.local/share/agents`

Then sync and link the published shared skills:

```bash
./scripts/skills-public/sync-skill-repos.sh --all
./scripts/skills-public/link-skill-repos.sh
```

## Shared Rules

Shared reusable Codex approval rules live in `codex/rules/`. Runtime rule files under `~/.codex/rules/` should symlink to these shared files where applicable.

## Shared Skills

Published shared skills are checked out under `~/.local/share/skills/` and linked into `~/.agents/skills/`. This repository keeps the registry, maintenance scripts, and supporting guidance for that setup.

## Maintenance Skills

- Use `~/.local/share/skills/refresh-agents-skill/SKILL.md` to review or refresh this shared agents repository.
- Use `codex/skills/refresh-public-skills/` to sync, link, audit, and verify the published shared skill checkouts.
