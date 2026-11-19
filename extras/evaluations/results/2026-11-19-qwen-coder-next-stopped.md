# Qwen Coder Next: Operator-Stopped Evaluation

## Outcome

Sam stopped this run on 19 November 2026 after **53,115.59 seconds (14 hours 45 minutes 16 seconds)**. It had made 36 tool calls and had not completed the coding task. The latest implementation compiled, but its tests crashed with `String index is out of bounds`. There was no final model report, passing final validation or independent acceptance result.

This is an **incomplete, operator-stopped configuration evaluation**, not a full end-to-end model score or a timeout failure. Sam judged the configuration probably impractical as it stood. The observed speed and unresolved failures support that operational conclusion; they do not establish how the model would perform with a smaller context, different placement or a less memory-constrained system. No generated code was repaired by the evaluator.

## Configuration

- Task: unchanged version 1 [feature prompt](../feature-prompt.txt), with no coaching; separate clean fixture at baseline `da5491cb3e1ddd5090ea37b37886510457828d2e`. Preparation and baseline targeted validation passed before launch. The prior model's output stayed in its separate worktree.
- Guidance source: Agents merge `373efdc1e93dd5aaec757cf9983927a0459af391`. Claude Code CLI 2.1.281 loaded baseline 0.8.35, Swift 0.12.1 and built-in agents-md. AgentTools was 4.2.0. These differ from the earlier Qwen3.6 trials, so this is not a comparison changing only the model.
- Model: local Ollama 0.40.16, `qwen3-coder-next:q4_K_M`, digest `ca06e9e4087c714d44355bf954099187890e63084b4a632b8e9956c4b9492074`, 79.7B parameters and approximately 51.7 GB of downloaded GGUF data. The model has no separate thinking mode.
- Runtime: Apple M1 Max, 64 GiB memory, Metal, **262,144-token context throughout**. The last observed request used about 39,852 prompt tokens. The runner reserved a 6 GiB KV cache and reported approximately 59.4 GB total allocation, including 54.3 GB on the GPU. Logs also showed CPU-resident model data. Generation and batch thread counts were both 8, matching the machine's 8 performance cores; it also has 2 efficiency cores. Metal, Accelerate and ARM vector support were enabled.
- Conditions: Sam reported high memory pressure at launch; the machine was not reserved exclusively for this test. Generation was often about 0.2–0.3 tokens/second. A late 15-second system-wide sample measured approximately 33 MiB/s of swap reads and 10 MiB/s of swap writes, with about 14 GiB of swap occupied. This is evidence of active paging, not a measurement attributing all paging to this process.
- Harness: fresh persistent session, local endpoint, file/Skill/Bash tool configuration matching the previous attempts, acceptEdits, no unattended permission approval, hooks and external MCP disabled. Hosted credentials were removed. No operator wall-clock deadline was set.

## Transport Calibration

Before the scored attempt, a tiny readiness request at 256k returned `LOCAL_CODER_OK` after approximately 335 seconds, including 159 seconds loading. An initial coding launch then suffered an API retry while Ollama was still processing the prompt. The operator stopped that untouched attempt after 586.40 seconds to remove the transport timers; it produced no code or tool calls. Its evidence is preserved separately.

The fresh attempt disabled `API_FORCE_IDLE_TIMEOUT`, `CLAUDE_ENABLE_STREAM_WATCHDOG` and `CLAUDE_ENABLE_BYTE_WATCHDOG` with invocation-local values of `0`, and set `API_TIMEOUT_MS=2147483647`. That last setting extends the header wait; it is not an overall task deadline. The [Claude network documentation](https://code.claude.com/docs/en/network-config#streaming-idle-watchdogs) explains the independent timers. The installed binary recognises these controls. No further API retries were observed. No global Claude settings, Claude.app session or Ollama service configuration changed.

Initial prompt processing took roughly 25 minutes before the first tool call. Subsequent requests reused prompt cache entries, so that initial delay should not be treated as the cost of every turn. Prefix reuse and generation speed did not make the whole coding task practical in this run.

## State At Interruption

The model changed only the parser and test file among tracked files: 57 added source lines and 38 added test lines, with six source lines removed. It added tests, attempted implementation and iterated through compiler errors and runtime crashes. Several direct Swift commands bypassed the documented `agt` workflow. No Skill invocation or explicit guidance/reference read was recorded; this does not prove imported instruction context was absent.

The latest test process exited with signal 5 after a successful build. The unfinished source used UTF-8 byte offsets as Swift character offsets, consistent with the reproduced string-index crash on the existing non-ASCII-input coverage. The final snapshot also assigned a KiB multiplier of 1 and discarded the multiplication-overflow flag. These are observations of unfinished output, not a completed correctness score. The evaluator did not add acceptance checks, run further quality experiments or fix those defects after the stop request.

The test Claude process was terminated at Sam's request, resulting in exit 143 with no normal result event. Ollama then acknowledged unloading this model; `/api/ps` returned an empty model list. The restricted-account daemon remains available, with its context default unchanged.

## Retained Evidence

The final code, original patch/status, complete transcript, invocation/session metadata, last build/test logs, SHA-256 snapshot manifest and initial transport attempt are preserved privately under `~/Developer/Evaluations/ByteCount-v1/Archive/2026-11-18/qwen-coder-next-unbounded/`. An earlier in-progress checkpoint is retained alongside it. The fixture worktree also keeps the generated files unmodified.

The archive includes the earlier available Qwen attempts, fixed task, prompts and acceptance checks. The previously deleted one-hour run remains unavailable, as Sam had explicitly requested its removal before this retention policy. Raw transcripts may contain personal instruction context and are not included in this repository. Creating a permanent evaluation repository and publishing selected material to GitHub is deferred. No hosted inference cost was incurred by the model calls.

## Archive Relocation

On 19 November, after Sam took ownership of the volume root, moved the private archive to `/Volumes/Models/evaluations/byte-count-v1/Archive/`. All 103 files (6,022,421 bytes) matched their source SHA-256 hashes and file modes before the original was removed. The archive remains owned by Sam with directory mode `700`; Ollama service ownership was unchanged. The run evidence is now under the `2026-11-18/qwen-coder-next-unbounded/` subdirectory there.
