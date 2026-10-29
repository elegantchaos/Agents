# Swift Validation Workflow

## Getting `agt`

Formatting and validation run `agt format` and `agt validate` from AgentTools. Run this skill's `scripts/ensure-agt.sh` to get the path to `agt`; it installs AgentTools (and Mint, via Homebrew) if `agt` is missing.

## Commands

- Prepare dependencies in an existing checkout without building targets or running tests:
  - `agt prepare`
- List dependency preparation steps:
  - `agt prepare --plan`
- Format and lint every Swift file:
  - `agt format`
- Fast validation of the uncommitted changes, then full validation in the background when preparing to merge:
  - `agt validate --fast --background`
- Start full validation in the background directly, including on a clean checkout:
  - `agt validate --background`
- Fast validation of the uncommitted changes only:
  - `agt validate --fast`
- Report, or wait for, the result of background validation:
  - `agt validate --status`
  - `agt validate --wait`
- Fast validation of one target:
  - `agt validate --target <target-name>`
- Comprehensive validation:
  - `agt validate`
- List the steps validation would run, with their commands, without running them:
  - `agt validate --plan` or `agt validate --fast --plan`
- Options:
  - `agt format --help`
  - `agt validate --help`

`agt validate` never modifies the project's source, so always run `agt format` first.

Builds during validation may re-resolve Swift package dependencies and update Xcode and SwiftPM `Package.resolved` files. Keep those updates; do not revert them.

Fast validation builds, for macOS, only the package targets, packages, or product that the uncommitted changes touched, and runs the test targets that depend on them. It ignores changes that do not affect a build, such as documentation, and runs nothing when there are none.

Comprehensive validation builds every product scheme for every platform the product supports, then runs, platform by platform, the product's tests and the tests of the local Swift packages that are part of the product, on simulators where needed. Local packages in git submodules are tested only when the submodule has changed. Projects configure schemes, platforms, test platforms, submodule testing, and excluded packages in `.agt/config.json`, with per-machine overrides in `.agt/local/config.json`; see `agt validate --help`. Do not create or change these files unless the user asks.

Background validation runs detached, so work can continue while it runs. Its result records a fingerprint of the working tree, including untracked files, and counts only for that tree. `agt validate --wait` waits for a running background validation, then fails unless full validation passed for the current working tree; it fails the same way when the tree changed while validation ran, when a newer run replaced it, or when none has run. Starting background validation again when it has already passed for the current tree does nothing. Any new `agt validate` run stops a background validation that is still running, so the two never compete for build directories.

Use `agt validate --plan` when you need to know what validation covers, for example to report which schemes, platforms, packages, and tests were checked, or to explain a skipped check. Validation caches what it discovers about the project in `.build/agt`, so the first run in a project is slower than later ones.

Some repositories' `AGENTS.md` still name `rt validate`. It is deprecated; use `agt format` followed by `agt validate`.

## Running Tests During Development

### Prepare Before TDD

Create new worktrees with `agt worktree create <name>` following `baseline:git`; it initialises submodules and runs preparation. For an existing fresh checkout, run `agt prepare` before the first red test. This requires an AgentTools release providing these commands; check their help and report an unavailable release rather than substituting a direct build or test command. An explicitly supplied source build can be used while developing AgentTools.

Preparation resolves dependencies into the same per-package SwiftPM scratch directories and Xcode DerivedData directories validation uses. Product-scheme preparation alone does not warm the separate SwiftPM directories used by targeted tests. It evaluates manifests and may update `Package.resolved`, but does not build targets, run tests or boot simulators. A passing preparation result is not validation evidence.

Some sandboxes deny dependency `.git/config` and `.git/hooks` writes even inside writable checkout directories. Claude's and Codex's protected paths differ by runtime, version and configuration; do not assume every nested `.git` path is denied in both. A writable SwiftPM repository cache does not remove the need to materialise local Git checkouts. An empty Git template directory fixes only sample-hook copying.

Where these restrictions apply, obtain permission for one `agt prepare` run outside the sandbox before TDD, or ask the user to run it. For a new worktree, the approved `agt worktree create` invocation can cover creation, submodule initialisation and preparation together. Neither command escalates itself. Name the command, explain that it evaluates dependency manifests, and keep ordinary builds and tests inside the sandbox. Do not add a standing exception unless the user explicitly authorises one.

Repeat preparation after dependency graph changes, switching to revisions that need different dependencies, removing checkout directories or `agt validate --clean`. Worktree creation does not copy ignored machine-local configuration; account for any needed settings explicitly. Preparation and validation share a checkout lock: wait for another foreground operation to finish; preparation stops an existing background validation before resolving. Retain a partially prepared checkout and use the reported resume command. Report remaining failures as external blockages or source failures according to their evidence.

Run every test through `agt validate`, including the failing and passing steps of red/green TDD. Do not run `swift test`, `xcodebuild test` or another runner directly: `agt` is the approved workflow, and inside an agent's sandbox it turns off SwiftPM's and Xcode's own sandboxes, which otherwise fail when nested.

For a red or green step, run `agt validate --target <target-name>`, naming the target under test. It builds that target and runs every test target that depends on it, so the new test's failure and its neighbours' results arrive together. `agt validate --fast` does the same for every target the uncommitted changes touch. `agt` has no per-test filter; run the whole target.

If `agt` itself is blocked, classify the blockage as described under Failure Classification. Do not fall back to a direct test runner, or step outside the sandbox to run one, without the user's permission.

## Required Workflow

Run `agt format` after every change. It formats every Swift file in the repository and then lints them, reporting findings without failing. Fix lint findings in files you changed. Report the number of remaining findings elsewhere, but do not fix them unless the user asks.

Then run `agt validate --fast` after each meaningful code change. Fix failures before continuing. Fast validation is enough while developing, committing, and opening a PR. Report it as fast validation, not comprehensive validation.

Agents may start full validation optimistically in the background while continuing other work, without prior confirmation, including before asking the user whether a full result is needed. Use `agt validate --background`, or `agt validate --fast --background` to run fast validation first and start full validation only if it passes. Starting a background run does not require waiting for completion. Wait when the user agrees that a full result is needed, or when an already-authorized action requires it, such as merging a PR. Do not ask again when the user has already authorized that action.

Before merging the PR, require full validation to pass locally on a clean checkout of the PR's latest commit that changes more than documentation files. Use `agt validate --wait` to confirm a passing full background result for that tree. The result counts only for the exact tree it ran on, so a documentation-only commit added afterwards makes `--wait` report it as stale; in that case confirm with `git diff --name-only <validated-commit> HEAD` that every later change is a documentation file, and rely on the recorded result. If the result is stale for any other reason, or missing, start full validation again and wait, or run `agt validate` in the foreground. Do not run foreground validation merely to check a background run: it stops the background run and starts again. After a commit that changes code, tests, configuration or other build inputs, run full validation again before merging; a commit that changes only documentation files, such as guides, journal entries and decision records, does not need it.

Record the passing full result on the PR, naming the commit it ran on, before merging. Until CI runs full validation as a required check, the person merging must verify this local result; GitHub branch protection alone cannot enforce it.

Passing fast validation is not comprehensive validation; report which one ran.

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
