# Swift Validation Workflow

## Getting `agt`

Formatting and validation run `agt format` and `agt validate` from AgentTools. Run this skill's `scripts/ensure-agt.sh` to get the path to `agt`; it installs AgentTools (and Mint, via Homebrew) if `agt` is missing.

Before dependency preparation, check `agt prepare --help`. If it is missing, run this skill's `scripts/ensure-agt.sh --update` once, use the absolute executable path it returns, and check again. Report a version gap only if the updated tool still lacks preparation. If the bootstrap is blocked, follow Failure Classification rather than running it outside the sandbox automatically. During AgentTools development, an explicitly supplied source build can be used.

## Commands

- Prepare dependencies in an existing checkout without building targets or running tests:
  - `agt prepare`
- List dependency preparation steps:
  - `agt prepare --plan`
- Format and lint every Swift file:
  - `agt format`
- Targeted validation of one target, including uncommitted edits:
  - `agt validate --target <target-name>`
- Change-scoped validation of the committed changes against `main`:
  - `agt validate`
- Full validation of the committed tree:
  - `agt validate --full`
- Start full validation in the background when preparing to merge:
  - `agt validate --full --background`
- Report the background result, or wait for a full pass for the current commit:
  - `agt validate --status`
  - `agt validate --wait --full`
- List the steps validation would run, with their commands, without running them:
  - `agt validate --plan` or `agt validate --full --plan`
- Options:
  - `agt format --help`
  - `agt validate --help`

These modes need an AgentTools release that has `--full`. If `agt validate --help` does not list it, run `scripts/ensure-agt.sh --update` once and use the path it returns.

`agt validate` never modifies the development checkout's source, so always run `agt format` first.

Builds during validation may re-resolve Swift package dependencies and update Xcode and SwiftPM `Package.resolved` files. Keep those updates; do not revert them.

Targeted validation builds the named target from the live checkout, uncommitted edits included, for macOS, and runs the test targets that depend on it. When no package defines the target, it builds the Xcode scheme of that name for macOS.

Change-scoped and full validation check committed code only. They refuse a checkout with staged, unstaged or untracked changes, including in submodules, so commit first. They build the pinned commit in a separate validation worktree that AgentTools keeps under `.build/agt-validation/`, so later edits or branch switches do not affect a run.

Change-scoped validation selects what the diff from the merge base with local `main` (or `origin/main`) touched: package targets and their dependent tests, whole packages for manifest, resolution or submodule changes, and the macOS product scheme for app sources and Xcode build inputs. It ignores documentation and other non-build changes. When nothing relevant changed, including on `main` itself, it runs nothing and still reports success. That result validates nothing; never report it, or any change-scoped result, as full validation.

Full validation builds every product scheme for every platform the product supports, then runs, platform by platform, the product's tests and the tests of the local Swift packages that are part of the product, on simulators where needed. Packages in git submodules are tested unless the project sets `testSubmodules` to `never`. Projects configure schemes, platforms, test platforms, submodule testing, and excluded packages in `.agt/config.json`, with per-machine overrides in `.agt/local/config.json`; see `agt validate --help`. Do not create or change these files unless the user asks.

Background validation runs detached, so work can continue while it runs. Its result records the commit and scope it checked. `agt validate --status` reports both. `agt validate --wait --full` waits for a running background validation, then fails unless full validation passed for the checkout's current commit; it also fails when the checkout has uncommitted changes, when a newer run replaced it, or when none has run. Without `--full`, `--wait` accepts a change-scoped pass, so always pass `--full` when a full result is required. A new change-scoped or full run from the same checkout stops a background run that is still going. Targeted validation and other checkouts use separate build directories and locks, so they neither stop it nor wait for it.

Use `agt validate --plan` when you need to know what validation covers, for example to report which schemes, platforms, packages, and tests were checked, or to explain a skipped check. Validation caches what it discovers about the project, so the first run in a checkout is slower than later ones.

Some repositories' `AGENTS.md` still name `rt validate`. It is deprecated; use `agt format` followed by `agt validate`.

## Running Tests During Development

### Prepare Before TDD

For a new worktree, follow `baseline:git`, which owns creation, bootstrap recovery, authorization and runtime integration. For an existing fresh checkout, run `agt prepare` before the first red test.

Preparation resolves dependencies into the same per-package SwiftPM scratch directories and Xcode DerivedData directories validation uses. Product-scheme preparation alone does not warm the separate SwiftPM directories used by targeted tests. It evaluates manifests and may update `Package.resolved`, but does not build targets, run tests or boot simulators. A passing preparation result is not validation evidence.

Some sandboxes deny dependency `.git/config` and `.git/hooks` writes even inside writable checkout directories. Claude's and Codex's protected paths differ by runtime, version and configuration; do not assume every nested `.git` path is denied in both. A writable SwiftPM repository cache does not remove the need to materialise local Git checkouts. An empty Git template directory fixes only sample-hook copying.

Where these restrictions apply to an existing checkout, request approval for one `agt prepare` run outside the sandbox through the runtime's configured approval process, or ask the user to run it. Automatic review can handle that request when enabled; do not add a separate human-confirmation step after it authorises the action. AgentTools does not escalate itself, but standing runtime rules can authorise external execution before the command starts; check effective policy rather than assuming a successful command was sandboxed. Name the command, explain that it evaluates dependency manifests, and keep ordinary builds and tests inside the sandbox unless the user has authorised a specific exception. Do not add a standing exception unless the user explicitly authorises one.

Repeat preparation after dependency graph changes, switching to revisions that need different dependencies, removing checkout directories or `agt validate --clean`. Worktree creation does not copy ignored machine-local configuration; account for any needed settings explicitly. Preparation and targeted validation share a checkout lock: execution requires another operation on that lock to finish. Both `--plan` commands wait for the current lock holder, reporting its PID and operation. Change-scoped and full validation prepare dependencies in their own validation worktree as they run, so `agt prepare` does not cover them. Retain a partially prepared checkout and use the reported resume command. Report remaining failures as external blockages or source failures according to their evidence.

Run every test through `agt validate`, including the failing and passing steps of red/green TDD. Do not run `swift test`, `xcodebuild test` or another runner directly: `agt` is the approved workflow, and inside an agent's sandbox it turns off SwiftPM's and Xcode's own sandboxes, which otherwise fail when nested.

For a red or green step, run `agt validate --target <target-name>`, naming the target under test. It builds that target and runs every test target that depends on it, so the new test's failure and its neighbours' results arrive together. Red and green steps are uncommitted, so they always use `--target`. `agt` has no per-test filter; run the whole target.

If `agt` itself is blocked, classify the blockage as described under Failure Classification. Do not fall back to a direct test runner, or step outside the sandbox to run one, without the user's permission.

## Required Workflow

Run `agt format` after every change. It formats every Swift file in the repository and then lints them, reporting findings without failing. Fix lint findings in files you changed. Report the number of remaining findings elsewhere, but do not fix them unless the user asks.

Then, after each meaningful code change, run `agt validate --target <target-name>` for each target the change touched. After committing, run `agt validate` to check everything the branch's commits touched. Fix failures before continuing. Targeted and change-scoped validation are enough while developing, committing, and opening a PR. Report which one ran; neither is full validation.

Agents may start full validation optimistically in the background while continuing other work, without prior confirmation, including before asking the user whether a full result is needed. Commit first, then use `agt validate --full --background`. Starting a background run does not require waiting for completion. Wait when the user agrees that a full result is needed, or when an already-authorized action requires it, such as merging a PR. Do not ask again when the user has already authorized that action.

Before merging the PR, require full validation to pass locally for the PR's latest commit that changes more than documentation files. Use `agt validate --wait --full` on a clean checkout of that commit to confirm a passing full background result. The result counts only for the commit it ran on, so after a later documentation-only commit `--wait --full` fails and `--status` reports the result as being for a different checkout state; in that case confirm with `git diff --name-only <validated-commit> HEAD` that every later change is a documentation file, and rely on the recorded result. If the result is for another commit for any other reason, or missing, start full validation again and wait, or run `agt validate --full` in the foreground. Do not run foreground validation merely to check a background run: it stops the background run and starts again. After a commit that changes code, tests, configuration or other build inputs, run full validation again before merging; a commit that changes only documentation files, such as guides, journal entries and decision records, does not need it.

Record the passing full result on the PR, naming the commit it ran on, before merging. Until CI runs full validation as a required check, the person merging must verify this local result; GitHub branch protection alone cannot enforce it.

Passing targeted or change-scoped validation is not full validation; report which one ran.

If validation fails, stop the standard Swift validation, analyze the output, and report the failure clearly. Do not treat successful earlier stages as a successful validation result. For example, if formatting passes but the workspace build fails, report `agt validate` as failed.

## Failure Classification

Classify a validation failure before deciding what to do next.

A source failure is caused by code, tests, project configuration, or generated project inputs within the requested change's scope. Examples include compiler errors, test failures, linter failures, and incorrect build settings.

When a source failure can be corrected within the user's request without a material design decision, fix it and rerun the failed validation command. Otherwise, report the failure and ask the user for direction.

An external blockage prevents validation without indicating an error in the changed source. Examples include a locked build database, a missing SDK, unavailable credentials, an unavailable service, or a network failure.

A dependency clone or checkout failing with `Operation not permitted` or `Permission denied` on `.git/config`, `.git/config.lock` or `.git/hooks` is a dependency-preparation blockage. Follow Prepare Before TDD above: request approval for `agt prepare` outside the sandbox, or ask the user to run it, then retry the same `agt validate` command inside the sandbox. Do not rerun the entire validation outside merely to populate dependencies. Cache permissions and network failures are separate failure classes; preparation advice does not fix them.

A sandbox that denies writes to `~/Library/Caches/org.swift.swiftpm` or the per-user clang module cache ("Operation not permitted") is an external blockage. Run `scripts/ensure-agt.sh --update`, which needs network access, to install the latest AgentTools release and get the path to `agt`. Then ask the user to run `<path> sandbox configure`, giving the absolute path it printed, and to start a new session. That command lets Claude Code's and Codex's sandboxes write those caches. If the sandbox also blocks `ensure-agt.sh --update`, which builds AgentTools with SwiftPM, ask the user to run it too.

Apart from that update, for an external blockage, do not modify the environment or run separate fallback verification automatically. Report the validation as blocked, identify the blocker and skipped stages, then request permission for any proposed fallback command.

Before separate fallback verification for an external blockage, ask the user for permission, naming:

- the exact fallback command;
- why the standard validation did not complete;
- what the fallback can verify; and
- what it cannot verify.

When the user approves a fallback for a specific project and failure class, remember that approval for future occurrences of the same failure class in that project. Do not extend it to different fallback commands or different validation failures.

After approved fallback verification completes, report it separately from the blocked validation and retain the residual risk from the skipped validation stages.

## Output Checklist

If the validation command succeeds, produce minimal output confirming success. If warnings were present, mention that there were warnings, but do not list them in the final output. Offer to provide details on the warnings if the user wants to see them.

If the validation command fails, produce output that includes:

- commands run
- pass/fail per command
- the first failing stage and its relevant error
- skipped checks and reasons
- residual verification risk
- suggested fixes for any warnings
- suggested fixes for any failures
- suggested next steps based on the results

## AgentTools

We own the `agt` command, and the source code can usually be found in `~/Developer/Projects/AgentTools`.

If validation fails due to blockages or other structural problems, consider whether `agt format` or `agt validate` could be improved to prevent them.

If there are improvements that could be made to `agt format` or `agt validate`, suggest them.
