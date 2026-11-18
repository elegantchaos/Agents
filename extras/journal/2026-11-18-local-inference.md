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

## Context Capacity

Sam selected the packaged model’s full 262,144-token context, retaining it unless actual use proves unusable. Prepared a context-only launchd configuration change and an administrator restart command. Application and inference verification remain pending; earlier tests used 65,536 tokens.

Sam applied the context-only service change. Confirmed the running launchd environment has `OLLAMA_CONTEXT_LENGTH=262144`; a short request with no `num_ctx` override returned `LOCAL_OK`. `/api/ps` reports a 262,144-token context and 28,767,472,842 bytes (26.8 GiB) of GPU allocation. The cold load took 56.3 seconds; the 17-token prompt used thinking disabled. Ollama and llama-server still run as `_ollama`. This does not validate long-input throughput, memory peaks or full-window answer quality; 256k remains selected.

## First Coding Smoke

Ran the fixed feature task through local Claude Code with packaged Qwen, 256k context, default thinking, baseline 0.8.35 and Swift 0.12.0 as reported by the harness. The model was warm, the extracted fixture baseline passed before launch, and hooks/external MCP were disabled. It timed out at 300.58 seconds without edits or tests. All six file tools succeeded; required skill references were not read. Independent acceptance found six missing-feature failures on unchanged baseline code. No hosted credits were used. The [run record](../evaluations/results/2026-11-18-qwen-smoke.md) separates evidence, limits and follow-ups. Opened the unchanged fixture source/tests in a new VS Code window at Sam’s request, explaining that no generated patch exists. Removed only the evaluator-added acceptance file after saving its output; the fixture worktree is clean and retained for inspection.

## Thinking-Off Coding Attempt

Retained the [thinking-off result](../evaluations/results/2026-11-18-qwen-thinking-off.md). The earlier one-hour attempt had produced incorrect parsing and invalid overflow-test expectations; Sam requested its generated changes and raw run artifacts be removed, and the fixture was restored to its clean baseline. Its last targeted validation had failed with nine issues. No fresh default-thinking run was started after that reset.

The fresh thinking-off attempt had session persistence and no operator deadline. A temporary loopback relay supplied an explicit disabled thinking field because Claude omitted it despite its local thinking controls. Preflight and all coding requests confirmed the setting. Qwen stopped normally after 149.70 seconds with a plan, seven successful file tools and no edits/tests. The fixture remains unchanged; no acceptance rerun was needed against the same qualified baseline. Reopened its source in VS Code. No hosted inference calls occurred; Claude.app and the larger-model download were not interrupted. Updated the evaluation procedure to distinguish unbounded runs and preserve resumable sessions.
