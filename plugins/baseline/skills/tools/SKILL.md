---
name: tools
description: Keeps the standard command-line tools installed and current, and finds them, for Mint, AgentTools (`agt`), ReleaseTools (`rt`) and SwiftWorkflowBuilder (`swift ci`). Use at the start of every session, and whenever a task uses AgentTools, `agt`, ReleaseTools, `rt`, SwiftWorkflowBuilder or `swift ci`, including when one is missing or the sandbox blocks installing it.
---

# Standard Tools

Other skills say which commands to run; this skill says how to get the tools and what each is for.

| Tool | Command | Install | Use for |
| --- | --- | --- | --- |
| [Mint](https://github.com/yonaskolb/Mint) | `mint` | `brew install mint` | Installing the others |
| [AgentTools](https://github.com/elegantchaos/AgentTools) | `agt` | `mint install elegantchaos/AgentTools` | Worktrees, dependency preparation, formatting, validation and shared-resource maintenance |
| [ReleaseTools](https://github.com/elegantchaos/ReleaseTools) | `rt` | `mint install elegantchaos/ReleaseTools` | Release tasks such as `rt changes`; its `rt validate` is deprecated in favour of `agt validate` |
| [SwiftWorkflowBuilder](https://github.com/elegantchaos/SwiftWorkflowBuilder) | `swift ci` | `mint install elegantchaos/SwiftWorkflowBuilder` | Generating a Swift package's GitHub Actions workflows with `swift ci generate`, in place of ActionBuilder |

## Start of Session

Before other work, run `mint install elegantchaos/AgentTools` and `mint install elegantchaos/ReleaseTools`. Each changes nothing when the newest release is already installed. Install SwiftWorkflowBuilder the same way before its first use in a session. Skills assume the latest release of every tool.

## Finding a Tool

Mint installs executables in `~/.mint/bin`. When a command is not on `PATH`, use `~/.mint/bin/<command>` before treating it as missing. `swift ci` runs the installed `swift-ci`, which needs `~/.mint/bin` on `PATH`; otherwise run `~/.mint/bin/swift-ci` directly.

## Missing Tools

If Mint itself is missing, the machine has not been set up for these tools. Report it, and ask the user to run `brew install mint` and then the `mint install` commands above.

During development of one of these tools, an explicitly supplied source build can be used.

## Blocked Installation

Installing needs network access and writes outside the workspace, and building a tool also needs SwiftPM's caches. When the sandbox blocks an install, request outside-sandbox execution for that one `mint install` command through the runtime's approval process, or ask the user to run it, giving the exact command. If neither is possible, continue with the installed tool and report that it may be out of date.

Do not reconstruct an installation with ad hoc commands, and do not change sandbox settings to get around the block.
