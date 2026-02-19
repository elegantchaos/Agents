# Agents Repository

This repository stores canonical agent-related instructions, shared configuration, and reusable utilities.

It is intended for:

- keeping a stable base of instructions that can be copied into project repos
- storing reusable language/technology guidance that can be referenced on demand
- maintaining global config that can optionally be symlinked into place (for example from `~/.codex`)

## Working Model

Use this repo in two ways:

1. Copy model:
   - Copy files (for example `AGENTS.md` templates) into a project.
   - Modify them locally in the project.
   - Manually merge useful changes back into this repo.
2. Symlink model:
   - Keep canonical files here and symlink from tool-specific locations.
   - Best for truly global config that should stay identical across machines.

## Structure

- `AGENTS.md`: global, cross-project defaults
- `instructions/technologies/`: technology-specific instructions loaded only when relevant
- `templates/`: starter templates for project-level agent files
- `agents/`: tool-specific notes (Codex app, opencode CLI, Copilot/VSCode)
- `scripts/`: reusable helper scripts
- `skills/`: reusable skills and skill docs
- `rules/`: reusable rules/checklists/policies
- `config/`: canonical config files intended for copy or symlink workflows

## First Draft Notes

This is intentionally lightweight. The goal is to start with a stable baseline and evolve it with real usage.
