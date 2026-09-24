# Baseline plugin

Elegant Chaos baseline skills, packaged as one plugin for Claude Code and Codex. They hold the task-specific detail behind the always-on rules in [COMMON.md](../../COMMON.md).

| Skill | Owns |
| --- | --- |
| [baseline:standards](skills/standards/SKILL.md) | Cross-language code quality, engineering principles, change scope, testing, scripting, and source selection |
| [baseline:records](skills/records/SKILL.md) | Development journals and decision logs, including backfilling a decision log |
| [baseline:refresh](skills/refresh/SKILL.md) | Maintaining shared agent resources and refreshing a project's `AGENTS.md` |

`baseline:refresh` includes `scripts/ensure-agt.sh`, which prints the path to `agt`, installing AgentTools (and Mint, via Homebrew) when it is missing. `--update` also installs the latest AgentTools release.

## Installation

The repository's `scripts/refresh` installs this plugin in both runtimes. See the [Swift plugin](../swift/README.md) for the manual commands; substitute `baseline` for `swift`.

## Licence

MIT, © Elegant Chaos. See [LICENSE](LICENSE).
