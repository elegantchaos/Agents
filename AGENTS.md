# Project Specific Rules

- This repository is the canonical home for shared agent references, skills, and configuration.
- This repository is expected to live at `~/.local/share/agents`.
- Because this repository owns the shared baseline, agents working here should edit shared guidance at the source files and skill repos rather than creating duplicate local copies.
- Keep a development journal in `extras/journal/`.

# Standard Rules

1. Locate the shared agents content before starting work. Use `~/.local/share/agents/` when available; otherwise obtain it from https://github.com/elegantchaos/Agents.
2. You must read @~/.local/share/agents/COMMON.md before starting work, and follow the instructions in it at all times (use `COMMON.md` from the GitHub copy when the local one is unavailable).
3. Resolve the skill names below from that same content, including skills provided by plugins.
4. For each skill required by the task, read its `SKILL.md` and every reference it marks as required before starting the work, and follow them. Required references are part of the skill's rules, not optional background.
5. Follow the guidelines in all code you write or change, even where the surrounding code does not.
6. Before reporting work complete, check each changed file against the required skills' checklists, and report the result and any exceptions.
7. Report any required guidance you cannot access.

- Follow the `baseline:standards` skill for all coding.
- Use the `baseline:records` skill for the development journal.
- Use the `codex-git` skill for git and GitHub operations.
- Use the `baseline:refresh` skill for shared resource maintenance, public skill sync/link/status checks, optional guidance research, and project `AGENTS.md` refreshes.

To refresh this file, use the `baseline:refresh` skill.
