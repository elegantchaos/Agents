## Project Specific Rules

- This repository is the canonical home for shared agent references, skills, and configuration.
- This repository is expected to live at `~/.local/share/agents`.
- Because this repository owns the shared baseline, agents working here should edit shared guidance at the source files and skill repos rather than creating duplicate local copies.

## Standard Rules

Read and follow @~/.local/share/agents/COMMON.md before starting work.

## Skills

- Follow the `baseline:standards` skill for cross-language coding standards, engineering principles, implementation guidance, and repository hygiene guidance.
- Follow the `ruby` skill for baseline Ruby language guidance outside framework-specific specialist skills.
- Follow the `swift:language` skill for baseline Swift language guidance.
- Use the `swift:validation` skill when validating Swift code changes.
- Use the `codex-git` skill for git and GitHub operations.
- Use the `baseline:refresh` skill for shared resource maintenance, public skill sync/link/status checks, optional guidance research, and project `AGENTS.md` refreshes.

To refresh this file, use the `baseline:refresh` skill.
