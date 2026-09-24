# Agents Repository

This repository is the shared home for agent resources used across Elegant Chaos projects.

GitHub: [github.com/elegantchaos/Agents](https://github.com/elegantchaos/Agents)

It provides:

- shared baseline guidance in `~/.local/share/agents/COMMON.md`
- shared Codex rule files under `~/.local/share/agents/runtimes/codex/rules/`
- shared skills under `~/.local/share/agents/skills/`, maintained with the standalone `agt` command
- plugins under `plugins/`, maintained directly in this repository and installable in Claude Code and Codex: the [baseline plugin](plugins/baseline/README.md) (coding standards, project records, refresh) and the [Swift plugin](plugins/swift/README.md)

## First Use

Clone this repository to:

- `~/.local/share/agents`

With [Homebrew](https://brew.sh) installed, run the refresh script. It installs Mint and `agt` if they are missing (and updates `agt` to the latest release), syncs and links the shared skills, and installs the shared plugins in Claude Code and Codex (skipping a runtime whose CLI is not on `PATH`):

```bash
~/.local/share/agents/scripts/refresh
```

Then synchronize the shared Codex rules:

```bash
agt rules sync
```

After that, use the `baseline:refresh` skill for routine maintenance.

## Shared Rules

Shared reusable Codex approval rules live in `runtimes/codex/rules/`. Use `agt rules sync` to copy them into `~/.codex/rules/` as generated regular files. The runtime-only `default.rules` file is intentionally not stored in this repository.

## Shared Skills

Published shared skills live under `skills/` in this repository and are linked into `~/.codex/skills/` and `~/.claude/skills/` by `agt skills link`.
Published skills are git submodules. Skills we maintain directly live in the plugins instead.
Runtime names come from the discovered `name:` field in each skill's `SKILL.md`.

## Maintenance

- Use the `baseline:refresh` skill to update shared resources, sync and link published skill submodules, install or refresh the plugins, optionally research shared guidance improvements, and refresh a project's `AGENTS.md`.
