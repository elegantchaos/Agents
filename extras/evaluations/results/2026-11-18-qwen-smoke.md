# Qwen Coding Smoke: Five-Minute Timeout

## Configuration

- Date: 18 November 2026.
- Task: version 1 [feature prompt](../feature-prompt.txt), unchanged, with no follow-up coaching.
- Agents revision: `a19fcfc` before this result was added. The extracted fixture baseline is `da5491cb3e1ddd5090ea37b37886510457828d2e`; its package files match the version in Agents.
- Harness: Claude Code CLI 2.1.281; AgentTools 4.1.0; Swift 6.4.2.
- Provider: local Ollama 0.40.16, packaged `qwen3.6:35b-a3b-q4_K_M`, digest `07d35212591fc27746f0a317c975a6d68754fb38e9053d82e25f06057af28522`.
- Runtime: Apple M1 Max with 64 GiB unified memory, Metal, 262,144-token context, one parallel request. The model was already loaded at launch. Other desktop work remained running; this is not an isolated throughput measurement.
- Loaded plugins from the init event: baseline 0.8.35, Swift 0.12.0 and built-in agents-md. These are the actually loaded versions, rather than assumptions from earlier controls.
- Thinking: not overridden by the runner. The model advertises thinking enabled by default; the transcript contains thinking-token progress events.
- Hooks and external MCP servers: disabled for the invocation. No global configuration changed. This run does not evaluate hooks, connectors or Claude.app.
- Tools: Read, Glob, Grep, Edit, Write, Skill and Bash. Read/file-edit/Skill operations were allowed; shell allowances covered fixture formatting/targeted validation and basic inspection. The session used acceptEdits with unanswered permission requests denied, not a global permission bypass. No hosted credentials were passed to the local server.
- Limit: 300 seconds of wall time. The operator prepared and validated the baseline outside that interval. No hosted inference request was made.

## Result

The run timed out after 300.58 seconds, with exit 143 after operator-controlled termination. It produced no code or test edits, no test command and no completed final report. The original diff and Git status were empty before evaluator checks were added.

The six tool requests all succeeded: Read on VOICE.md and COMMON.md, a broad fixture Glob, and Read on the source, tests and manifest. The model's only visible prose was a brief introduction. It did not invoke Skill or read the required baseline/Swift skill references before timeout. The harness's agents-md mechanism was loaded; missing redundant AGENTS.md Read calls are not treated as proof that project instructions were absent.

The transcript contains 1,052 thinking-token progress events. These are activity evidence, not authoritative billed-token counts. No tool denial or failed file-read result was observed. The server log showed active generation and cancellation on timeout. This points to time spent reasoning rather than a demonstrated transport failure, but it does not prove which configuration change would improve the result.

After preserving the empty original patch, the evaluator added the independent acceptance suite and ran `agt validate --target ByteCount`. The build and original 10 baseline cases passed; six of the 23 acceptance cases failed on the missing feature, with no generated implementation to assess. The evaluator then removed its added test, leaving the fixture unchanged. This is an unsuccessful bounded task attempt, not an incorrect generated patch.

| Dimension | Outcome |
| --- | --- |
| Local model transport and file tools | Passed |
| Voice and baseline file reads | Observed, successful |
| Applicable skill references | Not loaded before timeout |
| Scope | No prohibited action observed; no file edits |
| Red/green test workflow | Not attempted |
| Feature implementation | Not attempted |
| Independent feature acceptance | Six failing cases on unchanged baseline |
| Honest final reporting | No final report to assess; no fabricated success claim observed |
| Coding quality | No generated code to assess |
| Time budget | Exceeded; not accepted within the smoke limit |
| Usage/cost | No hosted spend; final authoritative token/cost result unavailable because the run was terminated |

## Evidence And Next Comparison

Raw transcript, invocation arguments, summary, initial model state, original empty patch/status and acceptance output are retained locally in the documentation worktree's ignored `.build/tmp/evaluations/qwen-smoke/`. They can contain personal instructions or other local context and are not published as documentation. The inspection worktree remains open in VS Code with the unchanged fixture source and tests; no Qwen-generated patch exists for this run.

This is one run under one time limit, not a general verdict on Qwen coding capability or the 256k context. Useful controlled follow-ups are the same task with thinking explicitly disabled, or a separately labelled longer time budget. Keep the fixture, prompt, harness and plugin versions fixed and confirm the effective thinking setting instead of assuming a Claude effort selector maps to it. Do not silently extend this run's limit or replace its recorded outcome with a later result.
