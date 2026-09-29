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

`agt`, from [AgentTools](https://github.com/elegantchaos/AgentTools), is the only tool this repository needs. With [Homebrew](https://brew.sh) installed, install it, or update it to the latest release, with the `baseline` plugin's helper, which installs Mint first if it is missing and prints the path to `agt` (usually `~/.mint/bin/agt`):

```bash
~/.local/share/agents/plugins/baseline/skills/refresh/scripts/ensure-agt.sh --update
```

Then, from the repository root, run `agt refresh`. It syncs and links the shared skills, lets both runtimes' sandboxes write the caches that Swift validation needs (`agt sandbox configure`, which merges this machine's paths into `~/.claude/settings.json` and `~/.codex/config.toml`), and installs the shared plugins in Claude Code and Codex (skipping a runtime that is not installed):

```bash
agt refresh
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
