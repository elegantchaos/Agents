# Shared `.codex` Config

This folder contains canonical, shareable `.codex` files derived from `/Users/sam/.codex`.

## Included

- `AGENTS.md`
- `config.toml.template` (sanitized template; not a direct copy)
- `rules/` (`default.rules`, `git.rules`, `swift.rules`)
- `automations/templates/` (sanitized templates)

## Excluded

These are intentionally not tracked because they are secret, ephemeral, or machine-specific:

- `auth.json`
- `sessions/`, `archived_sessions/`
- `sqlite/`
- `log/`
- `tmp/`
- `shell_snapshots/`
- `worktrees/`
- `.codex-global-state.json`
- `models_cache.json`
- `vendor_imports/`
- `skills/.system/` managed content
- `version.json`
- machine-specific `projects.*` trust mappings from `config.toml`

## Usage

Copy or symlink selected files into `~/.codex`.

Recommended pattern:

1. Copy `config.toml.template` to `~/.codex/config.toml`.
2. Fill in local paths and any machine-specific settings.
3. Copy/symlink `AGENTS.md` and `rules/*.rules`.
