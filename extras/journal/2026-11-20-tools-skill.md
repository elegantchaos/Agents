# Standard Tools Skill

How to get `agt` was written out in four places: `COMMON.md`, `baseline:refresh`, `baseline:git` and `swift:validation`. The git skill reached into the refresh skill's folder for the script. The git and validation skills disagreed about a blocked install: one said to use the runtime's approval process, the other not to step outside the sandbox automatically. Mint, ReleaseTools and SwiftWorkflowBuilder had no shared guidance at all beyond `COMMON.md`'s session-start install.

`baseline:tools` now covers all four tools: what each is for, how to install it, finding it in `~/.mint/bin`, checking a subcommand exists and updating once if not, and a blocked install, where the agent asks for approval for that one command or asks Sam to run it, and otherwise carries on with the installed tool and reports it. It owns `ensure-agt.sh`. The other skills point to it, and `COMMON.md` keeps only the session-start install and a pointer. `swift:validation` keeps its copy of the script, since a plugin can only use its own files.

`agt refresh` checks the script copies against a hard-coded canonical path, so AgentTools needs a release with the new path before this merges. Baseline plugin 0.8.38, Swift plugin 0.12.2.
