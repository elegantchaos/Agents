This repository is expected to live at `~/.local/share/agents`.

It is the canonical source for shared agent instructions, templates, skills and configuration.

Each project's `AGENTS.md` file should direct the agent to use:
- `instructions/COMMON.md` for shared baseline rules
- `~/.local/share/skills/refresh-agents-skill/SKILL.md` for regeneration instructions

Since this is itself a project, use the same common guidance baseline here.


## Git Command Style

- Do not use `git -C <path> ...` unless explicitly required. Prefer setting `workdir` to the repository path and running plain `git ...` commands.
- The purpose of this instruction is to allow `git` commands to match against the rules in `git.rules`.
- When performing git operations in Codex.app, use `~/.local/share/skills/codex-git-skill/SKILL.md` for escalation and write-command guidance.
