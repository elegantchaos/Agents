---
name: agenttools
description: Obtains and updates `agt`, the AgentTools command-line tool, and handles a missing command, an old release or a blocked install. Use before running any `agt` command when it may be missing or out of date, or when an `agt` subcommand or option is not recognised.
---

# AgentTools

`agt` comes from [AgentTools](https://github.com/elegantchaos/AgentTools) and is installed with Mint. Other skills say which `agt` commands to run; this skill says how to get it.

## Getting `agt`

Run this skill's `scripts/ensure-agt.sh`. It prints the absolute path to `agt`, looking on `PATH` and then in `~/.mint/bin`, and installs AgentTools (and Mint, via Homebrew) when it is missing. `--update` also installs the latest release. Use the printed path when `agt` is not on `PATH`.

Every session starts by installing the latest release, as `COMMON.md` describes, so skills assume it and do not name minimum versions.

## Missing Commands

Before relying on a subcommand or option, check `agt <subcommand> --help`. If it is missing, run `scripts/ensure-agt.sh --update` once, use the path it prints, and check again. Report a version gap only if the updated tool still lacks it.

During AgentTools development, an explicitly supplied source build can be used.

## Blocked Installation

Installing or updating needs network access and writes outside the workspace; building AgentTools also needs SwiftPM's caches. When the sandbox blocks it, request outside-sandbox execution for that one `ensure-agt.sh` invocation through the runtime's approval process, or ask the user to run it, giving the exact command. If neither is possible, continue with the installed tool and report that it may be out of date.

Do not reconstruct the installation with ad hoc commands, and do not change sandbox settings to get around the block.

## Copies of the Script

A plugin can only use files inside it, so another plugin that needs `agt` carries its own copy of `scripts/ensure-agt.sh`. This skill's copy is canonical, and `agt refresh` warns when another copy differs from it. Change this copy first and then the others, in the same PR.
