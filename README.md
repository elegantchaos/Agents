# Agents Repository

This repository stores canonical agent-related instructions, shared configuration, and reusable utilities.

It is intended for:

- keeping a stable base of instructions that can be copied into project repos
- storing reusable language/technology guidance that can be referenced on demand
- maintaining global config that can optionally be symlinked into place (for example from `~/.codex`)

## Installation

We expect this project to live in:

- `~/.local/share/agents`

This allows other projects to refer to files within it.

## Usage

Use this repo in two ways:

1. Copying:
   - Copy files (for example `AGENTS.md` templates) into a project.
   - Modify them locally in the project.
   - Manually merge useful changes back into this repo.
2. Linking:
   - Keep canonical files here and symlink from tool-specific locations.
   - Best for truly global config that should stay identical across machines.

## Structure

- `AGENTS.md`: local instructions for this project only
- `instructions/COMMON.md`: shared baseline rules for inclusion in rebuilt `AGENTS.md`
- `codex/skills/agents-refresh/WORKFLOW.md`: process for regenerating project instruction artifacts
- `instructions/`: modular instructions loaded only when relevant
- `templates/`: starter templates for project-level agent files
- `agents/`: tool-specific notes (Codex app, opencode CLI, Copilot/VSCode)
- `scripts/`: reusable helper scripts
- `skills/`: reusable skills and skill docs
- `rules/`: reusable rules/checklists/policies
- `config/`: canonical config files intended for copy or symlink workflows
