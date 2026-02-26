# Shared `.codex` Baseline

Canonical, shareable subset of `/Users/sam/.codex`.

## Contents

- `config.toml.template` (sanitized from `~/.codex/config.toml`)
- `automations/templates/*.toml` (sanitized from `~/.codex/automations/*/automation.toml`)
- `rules/*.rules` (sym-linked into `~/.codex/rules`)
- `skills/*` (sym-linked into `~/.codex/skills`)
- `automations/*/automation.toml` (sym-linked into `~/.codex/automations/*/`)

We do not track other files in `~/.codex` - they are ephemeral, tied to the local machine, and/or contain secrets.

## Update Rules

- Examine `~/.codex` and suggest updates to the config file (in both directions)
- Offer to add symlinks into `~/.codex` for missing rules, automations and skills
- Offer to move new rules, automations and skill from `~/.codex` into here and replace the originals with sym-links 
- Keep `config.toml.template` sanitized: remove machine-local paths and trust mappings.
- Keep rules/skills/automatiions sanitized: avoid absolute paths or other machine-specific entries
- Suggest other improvements we could make to Codex-related files and features.
