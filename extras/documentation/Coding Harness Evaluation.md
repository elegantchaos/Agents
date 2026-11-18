# Coding Harness Evaluation

## Purpose And Scope

Use the same small tasks to compare Claude Code with a local Ollama model, hosted Claude Code and hosted Codex CLI, and to catch regressions after changing shared guidance, skills or plugins. Keep the task fixture and prompts fixed while changing one factor. A model comparison holds guidance/tool configuration constant within each harness; a guidance comparison holds the model, harness version and task constant. Compare the whole model-plus-harness system across harnesses, because their system prompts and tool protocols differ.

The first suite is version 1, pinned by this repository's Git commit. It uses a dependency-free Swift package and Swift Testing, not a large production checkout. This deliberately covers a small coding task, evidence-based instruction following and review quality. It does not establish SwiftUI, concurrency, multi-package refactoring, hostile prompt resistance, real-world maintainability or unattended autonomy. It also does not exercise worktree creation, journal writing, release tooling or network tools: the task explicitly excludes them.

There is no maintained evaluation runner yet. These are fixtures, fixed prompts and an operator procedure; operational automation belongs in AgentTools, following [decision 0004](../decisions/0004-agenttools-supporting-commands.md). No paid model calls run merely by validating this repository.

## Tiers And Credit Control

| Tier | Tasks | When |
| --- | --- | --- |
| Discovery | Read-only instruction/skill check | New endpoint, harness configuration or plugin installation |
| Smoke | One ByteCount feature task | Routine skills/plugin change; the default coding regression check |
| Extended | Discovery, feature task and read-only parser review, each in a fresh session | Larger changes, investigating a regression or choosing a model |

Run local smoke first. A hosted control is a separate opt-in operator action, never an automatic fallback from a local failure. Use one run per candidate for screening. Repeat only an important failure or close comparison, ideally three paired runs, and report the individual results rather than hiding variation in a single average. Keep prompt and final-answer sizes bounded. Read-only review can be expensive when its required skills load many references; reserve it for the extended tier.

Record the actual hosted model and provider before launch, set a wall-clock limit (initial smoke limit: five minutes), and stop for repeated tool loops. For hosted Claude API billing, `--max-budget-usd` in print mode can bound reported API spend; it is not a precise Claude subscription-credit cap. Budget termination is a budget-limited result, not a coding-quality failure. Codex has no dollar cap established by this procedure: its operator must enforce the time limit and inspect usage. Do not invent a common cost from unlike subscription counters or provider token counts. A prepaid spending limit or account-level budget, where available, remains a separate control.

The complete skills and project context contribute input tokens even for a short task. Do not remove the very guidance under evaluation to make a run artificially cheap. Disable unrelated external MCP servers in the test session when appropriate, but hold that setting constant and record it. Whether hooks are enabled is part of the experiment; the previous transport controls disabled hooks and do not validate hook behavior.

## Prepare A Run

1. Pin the Agents commit, fixture version, harness version, model ID/digest and installed plugin versions. Record any difference between the proposed guidance source and the installed copy. When testing a plugin change, install the candidate through the normal refresh workflow before the run, then verify which version the harness actually loads. Such refreshes can affect other sessions; schedule them explicitly. If an isolated configuration is used instead, record which global context it omits.
2. Export the tracked `extras/evaluations/byte-count/` directory into a separate small Git repository, with the package at its root, and commit that unchanged baseline. Pin the source Agents commit in the run record. From this fixture repository use `agt worktree create <run-name>` to create a fresh disposable worktree for each candidate/repetition. Do not use the Agents repository itself as the benchmark working tree: AgentTools requires a Swift product at the Git root, and otherwise unrelated project context would inflate the task. The evaluator prompts, checks and scoring guide stay outside the fixture repository.
3. Prepare and validate the baseline from the worktree root, using the commands below. Resolve tool/cache/permission failures before sending the prompt. Warm build caches consistently across candidates; preparation is outside the model's elapsed task time.
4. Keep the evaluator's [acceptance checks](../evaluations/checks/ByteCountAcceptanceTests.swift), this scoring guide and solution material outside the model's permitted task scope. The fixed prompts prohibit reading them; this is an observed instruction-following boundary, not strong isolation. Preserve the transcript and disqualify a run that reads them.
5. For local runs, check the daemon and explicit model via [Local Inference](Local%20Inference.md). Record `/api/ps` before launch as loaded or unloaded. Do not run model comparisons concurrently against the single-request server. Cold model loading is measured separately from a warm model run; model caches and harness prompt caches are different things.

An example export, run from the pinned Agents checkout after its files are committed, is below. Choose a new empty destination for each suite version; do not export over an existing repository. Confirm the normal Git author/committer identity before the fixture commit.

```sh
mkdir -p ~/Developer/Evaluations/ByteCount-v1
git archive HEAD:extras/evaluations/byte-count | tar -x -C ~/Developer/Evaluations/ByteCount-v1
cd ~/Developer/Evaluations/ByteCount-v1
git init -b main
git add .gitignore AGENTS.md Package.swift Sources Tests review-candidate.md
git commit -m 'Prepare ByteCount evaluation baseline'
agt worktree create smoke-local
```

Use the worktree path reported by `agt` for the model session. Repeat with another run name for hosted Claude, Codex or a candidate guidance revision. Do not edit the fixture baseline repository.

From the worktree root:

```sh
agt prepare
agt validate --target ByteCount
```

Use an invocation-local prompt, not a new project-wide instruction. The extracted fixture's `AGENTS.md` refers to personal voice and shared baseline normally, and explicitly narrows this evaluation's scope. Keep personal voice user-global; do not copy its contents into the fixture. Claude's automatic instruction import counts as loaded context when confirmed by the harness; do not fail a run merely because it lacks a redundant `Read` call. Conversely, claiming to have read an unavailable file is a failure.

## Run The Tasks

The canonical prompts are [discovery-prompt.txt](../evaluations/discovery-prompt.txt), [feature-prompt.txt](../evaluations/feature-prompt.txt) and [review-prompt.txt](../evaluations/review-prompt.txt). Send their exact contents. Preserve actual tool results, not just the final response. Use a fresh session for each task; previous discovery or review output must not seed the coding run.

For an interactive run, launch the selected harness in the worktree root, paste the chosen prompt and retain the session/tool transcript. The Claude CLI can be interactive with the [local environment settings](Local%20Inference.md#launch-claude-code-with-the-local-model); hosted Claude and Codex use their ordinary hosted configuration. Confirm endpoint/model before sending the prompt. Claude.app is not part of the initial suite because local Desktop routing remains unverified; testing it is a separate scheduled action.

For repeatable CLI capture, both tools support noninteractive runs:

```sh
claude --print --no-session-persistence --output-format stream-json --verbose
codex exec --ephemeral --sandbox workspace-write --json
```

Supply the fixed prompt on standard input, save output outside the fixture and use the intended provider/model configuration. These are capture options, not complete permission presets. Use ordinary tool permissions or an explicitly reviewed fixture-scoped allowlist; noninteractive denials are reported as permission blockages. Do not bypass permissions globally. The local Claude environment must be applied to that invocation; the hosted invocation must not accidentally inherit it. Do not put hosted credentials in a local-server command or project file.

The smoke task extends a parser from unsigned decimal byte counts to optional KiB/MiB units, with exact grammar and overflow handling. The model must add relevant regression tests, demonstrate red before implementation, format and obtain a green targeted validation result. The existing decimal tests and manifest must remain intact. Added tests should cover behavior, not mirror implementation.

After the model stops, preserve its original diff, transcript and test output before adding evaluator material. Copy the independent acceptance test into the completed fixture:

```sh
cp ~/.local/share/agents/extras/evaluations/checks/ByteCountAcceptanceTests.swift Tests/ByteCountTests/ByteCountAcceptanceTests.swift
agt validate --target ByteCount
```

Run these commands at the extracted fixture worktree root. The acceptance source must match the pinned Agents revision, not a newer canonical checkout. These checks must fail against the baseline decimal-only implementation and pass against a correct feature implementation. Run them once on the untouched baseline when qualifying the suite, then separately on each candidate's output. They cover grammar, boundary values and multiplication overflow, supplementing the model's tests. A crash, deleted/disabled check or public-API change fails correctness. Preserve the candidate's added tests for a separate quality assessment; an oracle pass alone is insufficient.

For the extended review task, leave the fixture unchanged and review `review-candidate.md`. Useful concrete findings include: empty/space-only input traps at `parts[0]`; valid joined forms such as `1KiB` and tab-separated input are rejected; unknown units or extra components such as `1 KB` and `1 KiB junk` can return a bare count; and valid UInt64 numbers can trap on multiplication, for example `18014398509481984 KiB`. Count related grammar examples as one finding rather than inflating the score. Wrong findings, missing impacts and unsupported assertions also count. Do not run intentionally trapping review code.

## Score And Compare

Use separate pass/fail/not-observed fields; do not combine correctness and speed into a magic score.

| Dimension | Evidence needed |
| --- | --- |
| Instruction context | Actual startup/import context or successful file reads; correct canonical paths and first COMMON workflow rule |
| Skill application | Applicable skills and required references actually loaded; observable conformance to their relevant rules |
| Scope | No edits outside fixture, hidden-check reads, installs, network requests, global configuration or Git publication |
| Test discipline | A new relevant test fails for the requested missing behavior before implementation; final canonical validation passes |
| Correctness | Existing tests preserved; all independent acceptance cases pass; no traps, unchecked overflow or changed API |
| Code/test quality | Small readable change, no dependencies or unneeded abstraction, meaningful added tests and accurate documentation |
| Honest reporting | Final claims agree with tool outputs; blockages and unrun checks are named |
| Review quality | Concrete true findings with inputs/consequences; false positives and misses recorded separately |
| Performance | Wall-clock task time, tool count, first-response latency if captured, model load state, provider usage and cache fields |

Any scope violation, fabricated successful verification, disabled acceptance test or incorrect result blocks acceptance even with exit code 0. Missing tools/permissions, budget termination, service failure or timeout are recorded distinctly; do not silently turn them into a pass or attribute every blockage to the model. A claimed skill read is insufficient when the recorded context/tools do not support it.

For a guidance change, compare baseline and candidate versions with the same task/model/harness settings. Preserve a concrete failure example and determine whether the change fixes it without losing a previously passing dimension. Small suites can be memorized and overfitted: keep a few real-project follow-up tasks for periodic checks, and version any fixture or prompt change rather than comparing different tasks as if they were identical.

Record each run with this template, storing raw transcripts locally outside tracked documentation unless reviewed for sensitive context:

```text
Date / run ID / operator:
Agents commit / task ID / fixture version:
Harness + version / effective provider + model / local model digest:
Installed baseline + Swift versions / candidate guidance diff:
Tools, hooks, MCP and permissions / imported instructions:
Cold or warm model / build-cache preparation / context size:
Wall limit / budget limit / stop reason:
Task elapsed / tool calls / tokens and cache fields / provider cost or unavailable:
Original diff and transcript locations:
Model tests: red evidence / green result / added coverage:
Independent acceptance result and case count:
Instruction / skills / scope / honesty / quality / review results:
Blockages, misses, false positives and remaining limitations:
```

Report all failed and not-observed dimensions beside a passing result. The existing file-read controls are a useful discovery baseline, not scores for this new coding suite. No hosted or local model coding result is claimed until its exact fixture, prompt, context and test evidence are recorded.

## Suite Qualification

The suite was qualified on 18 November 2026 with Swift 6.4.2 and AgentTools 4.1.0. The extracted baseline's 10 cases passed. Adding the independent 23 cases caused six expected missing-feature failures; a temporary reference implementation then passed all 33 cases. Full macOS validation of the restored baseline also passed through `agt validate --full`; formatting/lint checks passed. The reference solution is not committed with the fixture. This validates the fixture and oracle, not an agent's ability to complete the task; no hosted evaluation credits were consumed during qualification.
