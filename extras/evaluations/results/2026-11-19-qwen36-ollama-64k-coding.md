# Qwen3.6 Ollama 64k: Coding Evaluation

## Configuration

- Date: 19 November 2026. Fresh fixture baseline `da5491cb3e1ddd5090ea37b37886510457828d2e`; pinned Agents guidance revision `35f8960fdd5efa4cdaaa7edeee604a1e93079fe4`.
- Harness: Claude Code CLI 2.1.281, fresh persistent session `6de1684a-3297-40a0-b1b3-f108c1bb7d9f`; baseline plugin 0.8.37, Swift plugin 0.12.1, built-in agents-md. Thinking enabled. Hooks and external MCP disabled. No operator time limit.
- Provider: restricted-account Ollama 0.40.16 on loopback; `qwen36-evaluation:64k-coding`, alias of the existing `qwen3.6:35b-a3b-q4_K_M` GGUF (manifest digest `07d35212591fc27746f0a317c975a6d68754fb38e9053d82e25f06057af28522`). No weight conversion or download.
- Context: 65,536. Sampling: temperature 0.6, top-p 0.95, top-k 20, min-p 0, presence penalty 0, repeat penalty 1. The Ollama model alias is retained only for this run and was unloaded afterward.

## Result

Claude Code completed normally after **1,676.54 seconds (27 minutes 57 seconds)**, with 35 tool calls. The model extended the parser and added one test file. Formatting, linting and the ByteCount build passed. Its `agt validate --target ByteCount` test phase ended with signal 5.

The model attributed the crash to sandboxing. That explanation is not supported by the evidence: the same canonical validation command ran independently, and a selected Swift Testing case passed in this environment. Filtering to the existing overflow test reproduced signal 5 specifically on `18446744073709551616`. The parser uses full-width multiplication but then performs a checked `lo + digit`; that final addition overflows and traps. A focused probe for the partial unit `1Ki` independently traps with `Index out of range` because the unit-boundary condition admits a three-byte read when only two bytes remain. Neither issue depends on sandbox permissions.

The model's tests also contain two incorrect expectations: `0KiB` is expected to return `nil`, although the implementation returns the correct zero; and an input ending in newline is expected to parse, although the requested grammar rejects non-space/tab whitespace. Both tests fail when run separately. The model did identify that its zero-unit expectation was wrong in its final response, but left the failing test in place.

The fixed acceptance suite's seven valid-input cases passed. Its invalid-input group crashed on the overflowing decimal. Three separately labelled supplemental decimal-overflow probes passed; they do not cover the final-digit addition case. The focused partial-unit probe trapped. Therefore this candidate fails correctness. The fixture's `agt validate --target ByteCount` filter runs `ByteCountTests` but does not run a separate `ByteCountAcceptanceTests` suite; the latter was run explicitly after the model stopped.

## Instruction And Test Discipline

The model read VOICE.md, COMMON.md and fixture AGENTS.md, stayed inside the disposable fixture, preserved the manifest/API and did not inspect evaluator checks. It wrote tests before implementation and attempted a red run, but that direct command was denied, so a relevant red result was not demonstrated. It never invoked the available `Skill` tool or loaded the applicable baseline/Swift skills required by the fixture instructions. The final report accurately acknowledged a test crash but incorrectly attributed its cause to sandboxing and overstated that the runner itself could not start; it did not report that the overflow test caused the trap.

## Evidence And Limits

The original transcript, launch settings, summary, candidate snapshot, model logs and private evaluator checks are retained under `/Volumes/Models/evaluations/byte-count-v1/Archive/2026-11-19/qwen36-ollama-64k-coding/`. The original model source and tests were preserved before evaluator checks were added. The fixture remains available for inspection. No model-generated code was corrected. This is one run of a local 35B model under one task and does not establish general coding capability or hosted-harness performance. No hosted inference was used.
