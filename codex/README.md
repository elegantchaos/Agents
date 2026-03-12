# Shared `.codex` Baseline

Canonical, shareable subset of `/Users/sam/.codex`.

## Contents

- `config.toml.template` (sanitized from `~/.codex/config.toml`)
- `automations/templates/*.toml` (sanitized from `~/.codex/automations/*/automation.toml`)
- `rules/*.rules` (sym-linked into `~/.codex/rules`)
- `skills/*` (sym-linked into `~/.codex/skills`)
- `automations/*/automation.toml` (sym-linked into `~/.codex/automations/*/`)

We do not track other files in `~/.codex` - they are ephemeral, tied to the local machine, and/or contain secrets.

## Update Procedure

- Pull this project from git to ensure we have the latest changes
- Examine `~/.codex` and `~/.agents` suggest updates to the config file (in both directions)
- Offer to add symlinks into `~/.agents` for missing rules
- Offer to add symlinks into `~/.codex` for missing automations and skills
- Offer to move new rules, automations into here and replace the originals with sym-links 
- Keep `config.toml.template` sanitized: remove machine-local paths and trust mappings.
- Keep rules/skills/automatiions sanitized and portable: avoid absolute paths or other machine-specific entries
- Suggest other improvements we could make to Codex-related files and features.
- Offer to commit and push changes to git.

## Public Skill Repositories

Public sharing uses one repository per skill under `elegantchaos/`.

Operational skill checkouts live outside this repository, under `~/.local/share/skills` by default.
Runtime symlinks for published shared skills should live in `~/.agents/skills`.

This repository stores:

- registry metadata in `skills/public-skill-registry.json`
- role guidance in `skills/skill-role-map.md`
- refresh tooling in `skills/refresh-public-skills/`
- helper scripts in `../scripts/skills-public/`
- local control-plane files under `skills/` for orchestration only

Before linking runtime skill directories, run the publication audit and sync workflows.

### Common Paths

The following paths are ok to use, as they will exist on all machines:

- ~/.codex
- ~/.agents
- ~/.local/share/agents
- ~/Developer/Projects
- ~/Developer/Websites
