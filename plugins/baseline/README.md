# Baseline plugin

Elegant Chaos baseline skills, packaged as one plugin for Claude Code and Codex. They hold the task-specific detail behind the always-on rules in [COMMON.md](../../COMMON.md).

| Skill | Owns |
| --- | --- |
| [baseline:standards](skills/standards/SKILL.md) | Cross-language code quality, engineering principles, change scope, testing, scripting, and source selection |
| [baseline:git](skills/git/SKILL.md) | Git and GitHub workflows, pull requests, draft releases, review feedback, and CI triage |
| [baseline:review](skills/review/SKILL.md) | Broad reviews of pull requests and completed work: correctness, standards, and the change's effect on the wider codebase |
| [baseline:records](skills/records/SKILL.md) | Design-document shape, development journals, decision logs and review logs, including backfilling a decision log |
| [baseline:refresh](skills/refresh/SKILL.md) | Maintaining shared agent resources and refreshing a project's `AGENTS.md` |
| [baseline:summaries](skills/summaries/SKILL.md) | Summaries of recent work, suggestions for the coming week, project overviews, and start-of-day briefings, from journals and git history |

`baseline:refresh` includes `scripts/ensure-agt.sh`, which prints the path to `agt`, installing AgentTools (and Mint, via Homebrew) when it is missing. `--update` also installs the latest AgentTools release.

## Installation

`agt refresh`, run from the repository root, installs this plugin in both runtimes. See the [Swift plugin](../swift/README.md) for the manual commands; substitute `baseline` for `swift`.

## Git skill installation

The Git skill is `baseline:git`. Project `AGENTS.md` files should select that name;
`baseline:refresh` generates it for Git repositories.

When installing this version over an installation with the standalone `codex-git`
skill, remove only the `codex-git` symlinks in `~/.codex/skills/` and
`~/.claude/skills/` whose target is the retired
`~/.local/share/agents/skills/codex-git-skill` checkout. Preserve any real directory
or link to another source. `agt skills link` does not prune retired links.
Check the retired checkout for local work before removing it; preserve any such
work separately. Then run `agt refresh` from the canonical shared checkout and
refresh project `AGENTS.md` files that still select `codex-git`.
Start a fresh session or reload plugins to load `baseline:git`.

## Licence

MIT, © Elegant Chaos. See [LICENSE](LICENSE).
