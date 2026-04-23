# Shared `.codex` Baseline

Canonical, shareable subset of `~/.codex`.

## Contents

- `config.toml.template` (sanitized from `~/.codex/config.toml`)
- `rules/*.rules` (sym-linked into `~/.codex/rules`)

We do not track other files in `~/.codex` - they are ephemeral, tied to the local machine, and/or contain secrets.

## Update Procedure

- Pull this project from git to ensure we have the latest changes
- Examine `~/.codex` and `~/.agents` suggest updates to the config file (in both directions)
- Offer to add symlinks into `~/.agents` for missing rules
- Offer to move new rules into here and replace the originals with sym-links
- Keep `config.toml.template` sanitized: remove machine-local paths and trust mappings
- Keep rules and skills sanitized and portable: avoid absolute paths or other machine-specific entries
- Suggest other improvements we could make to Codex-related files and features
- Offer to commit and push changes to git

## Public Skill Repositories

Public sharing usually uses one repository per skill under `elegantchaos/`.

Published operational skill checkouts live inside this repository as git submodules under `../skills/`.
Repo-local operational skills live under `../skills/` as normal tracked files when they are tightly coupled to this repository.
Runtime symlinks for shared skills should live in `~/.agents/skills`.

This repository stores:

- published shared skills in `../skills/`
- repo-local refresh workflow guidance in `../skills/refresh-skill/`
- helper scripts in `../scripts/skills-public/`

Before linking runtime skill directories, initialize the shared skill submodules and run the publication audit/link workflows.

### Common Paths

The following paths are ok to use, as they will exist on all machines:

- ~/.codex
- ~/.agents
- ~/.local/share/agents
- ~/Developer/Projects
- ~/Developer/Websites
