# AgentTools Skill

How to get `agt` was written out in four places: `COMMON.md`, `baseline:refresh`, `baseline:git` and `swift:validation`. The git skill reached into the refresh skill's folder for the script. The git and validation skills disagreed about a blocked install: one said to use the runtime's approval process, the other not to step outside the sandbox automatically.

`baseline:agenttools` now owns `ensure-agt.sh` and the rules around it: getting the path, checking a subcommand or option exists and updating once if not, and a blocked install, where the agent asks for approval for that one invocation or asks Sam to run it, and otherwise carries on with the installed tool and reports it. The other skills point to it, and `COMMON.md` names it. `swift:validation` keeps its copy of the script, since a plugin can only use its own files.

`agt refresh` checks the copies against a hard-coded canonical path, so AgentTools needs a release with the new path before this merges. Baseline plugin 0.8.39, Swift plugin 0.12.2.
