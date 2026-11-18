# Local Inference And Harness Evaluation

## Current Operation

Verified Ollama 0.40.16 serving packaged Qwen3.6 35B A3B Q4_K_M through a system LaunchDaemon as `_ollama`, with Metal and a 65,536-token context. The model returned `LOCAL_OK` with an approximately 50-second cold load. The restricted account cannot traverse Sam's home or read its SSH directory and cannot write shared MLX models. Loopback binding and cloud-disabled settings are configured; this is not an outbound firewall or a complete host security audit.

Moving private models, cache and temporary files from siblings of the external home to inside it allowed launchd inference without adding Full Disk Access or a scoped launcher. A separate log probe and working-service restart succeeded with stdout/stderr inside the external home. Shared MLX data stays outside. Named ACLs allow Sam to browse the home and read current/future logs while private state remains restricted. Boot startup, late/encrypted-volume handling, crash recovery and log rotation are not configured.

The [operating guide](../documentation/Local%20Inference.md) owns current paths, commands, environment and limits. Ignored scratch scripts include superseded layouts and are not promoted as installation tools. AgentTools should own durable commands under [decision 0004](../decisions/0004-agenttools-supporting-commands.md). Stable signing after Mint installation is an agreed direction, not implemented here. No decision or design documents were created or amended.

## Harness Evidence

Packaged Qwen completed real Claude Code instruction reads and skill discovery in about 33 seconds. Codex read voice/baseline but incorrectly reported skills missing in about 185 seconds. Earlier hosted controls passed discovery. These differing contexts/tool definitions are not a controlled speed comparison or coding benchmark. Imported MLX weights failed inference despite successful import; the working alias uses packaged GGUF.

Claude.app local routing remains untested. Sam explicitly requires a safe-to-interrupt signal before reconfiguration or restart because other work is running. Neither Claude.app nor its settings changed. Ollama's GUI starts its own normal-user server, so its documented Desktop gateway integration is not assumed to preserve the restricted account.

## Evaluation Qualification

Added a [coding-harness evaluation](../documentation/Coding%20Harness%20Evaluation.md) with fixed discovery, feature and review prompts. The default smoke task is a small Swift parser feature, using shared skills, red/green tests and independent acceptance checks. Comparisons record effective context, plugin versions, permissions, timing, caches and usage separately. Paid controls are opt-in; there is no maintained runner or automatic hosted fallback.

AgentTools rejected the nested package without a Swift product at the Agents Git root. The procedure extracts the fixture into its own Git repository and uses disposable worktrees, also excluding unrelated shared-repository context. Baseline qualification passed 10 cases. The added 23 acceptance cases produced six expected missing-feature failures; a temporary reference solution passed all 33. AgentTools formatting/lint and full macOS validation of the restored fixture passed. The full fixture run used disposable baseline commit `da5491cb3e1ddd5090ea37b37886510457828d2e`, whose package sources/tests match the published fixture. No model coding run or paid request was made for this suite.

## Bionic Archive And Records

Closed [PR 50](https://github.com/elegantchaos/Agents/pull/50) after publishing annotated tag `archive/bionic-harness-2026-11-18`, resolving to exact PR head `5d69f3da1fdfdfd451af862b9df48c90cb2cf9e7`. The branch/worktree and experimental links remain. Harness/backend separation, invocation-local routing and tool-evidence guidance are carried into the current guides; Bionic-specific startup and LM Studio instructions remain archived.

Completed [LI1](../work/Done/LI1%20Local%20Inference%20And%20Evaluation.md) and linked the documentation in the roadmap. Existing priorities stay intact. Codex's managed-worktree requirement conflicts with the project-local AgentTools creation rule; this task used the required runtime tool and explicitly worked in its returned checkout. Main and the retained Bionic checkout were not used for these edits.

## Service Naming

Prepared the requested permanent label `com.elegantchaos.ollama`, matching plist filename and `.ollama-setup` marker. Only the Label changes in the service configuration; account, model/cache/temp/log paths and startup policy stay unchanged. Updated the operating guide and prepared a one-off administrator rename command with a readiness check and restoration of the previous service on replacement startup failure. Application remains pending Sam's manual administrator command. Historical experimental scripts retain their original names and remain unsuitable for managing the renamed service.

Sam ran the rename successfully. A read-only check confirmed the permanent label running, the previous label absent, the renamed plist and setup marker present, and API version 0.40.16 responding. Updated the operating guide to describe the installed state. No inference rerun was needed for the label-only change.
