---
name: tools
description: Installs, updates and finds the standard command-line tools (Mint, AgentTools' `agt`, ReleaseTools' `rt` and SwiftWorkflowBuilder's `swift ci`), and handles a missing command, an old release or a blocked install. Use before running one of them when it may be missing or out of date, or when a subcommand or option is not recognised.
---

# Standard Tools

Other skills say which commands to run; this skill says how to get the tools and what each is for.

| Tool | Command | Install | Use for |
| --- | --- | --- | --- |
| [Mint](https://github.com/yonaskolb/Mint) | `mint` | `brew install mint` | Installing the others |
| [AgentTools](https://github.com/elegantchaos/AgentTools) | `agt` | `scripts/ensure-agt.sh` | Worktrees, dependency preparation, formatting, validation and shared-resource maintenance |
| [ReleaseTools](https://github.com/elegantchaos/ReleaseTools) | `rt` | `mint install elegantchaos/ReleaseTools` | Release tasks such as `rt changes`; its `rt validate` is deprecated in favour of `agt validate` |
| [SwiftWorkflowBuilder](https://github.com/elegantchaos/SwiftWorkflowBuilder) | `swift ci` | `mint install elegantchaos/SwiftWorkflowBuilder` | Generating a Swift package's GitHub Actions workflows with `swift ci generate`, in place of ActionBuilder |

## Finding a Tool

Mint installs executables in `~/.mint/bin`. When a command is not on `PATH`, use `~/.mint/bin/<command>` before treating it as missing. `swift ci` runs the installed `swift-ci`, which needs `~/.mint/bin` on `PATH`; otherwise run `~/.mint/bin/swift-ci` directly.

For `agt`, run this skill's `scripts/ensure-agt.sh`. It prints the absolute path to `agt`, installs AgentTools (and Mint, via Homebrew) when it is missing, and installs the latest release with `--update`.

## Keeping Tools Current

Every session starts by installing the latest AgentTools and ReleaseTools, as `COMMON.md` describes, so skills assume the latest release and do not name minimum versions. `mint install` changes nothing when the newest release is already installed. Install SwiftWorkflowBuilder the same way before using it.

Before relying on a subcommand or option, check `<command> --help`. If it is missing, update the tool once (`scripts/ensure-agt.sh --update` for `agt`, `mint install` for the others), use the path it prints, and check again. Report a version gap only if the updated tool still lacks it.

During development of one of these tools, an explicitly supplied source build can be used.

## Blocked Installation

Installing or updating needs network access and writes outside the workspace; building a tool also needs SwiftPM's caches. When the sandbox blocks it, request outside-sandbox execution for that one install command through the runtime's approval process, or ask the user to run it, giving the exact command. If neither is possible, continue with the installed tool and report that it may be out of date.

Do not reconstruct an installation with ad hoc commands, and do not change sandbox settings to get around the block.

## Copies of `ensure-agt.sh`

A plugin can only use files inside it, so another plugin that needs `agt` carries its own copy of `scripts/ensure-agt.sh`. This skill's copy is canonical, and `agt refresh` warns when another copy differs from it. Change this copy first and then the others, in the same PR.
