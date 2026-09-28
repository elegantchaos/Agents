# Swift Validation Workflow

## Getting `agt`

Formatting and validation run `agt format` and `agt validate` from AgentTools. Run this skill's `scripts/ensure-agt.sh` to get the path to `agt`; it installs AgentTools (and Mint, via Homebrew) if `agt` is missing.

This skill needs AgentTools 3.6.0 or later, which adds full validation in the background. Check with `agt --version`, which prints, for example, `AgentTools v3.6.0.`. If the command fails (releases before 3.2.0 have no `--version`) or reports an older release, run `scripts/ensure-agt.sh --update` to install the latest release. This needs network access.

## Commands

- Format and lint every Swift file:
  - `agt format`
- Fast validation of the uncommitted changes, then full validation in the background when preparing to merge:
  - `agt validate --fast --background`
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

## Required Workflow

Run `agt format` after every change. It formats every Swift file in the repository and then lints them, reporting findings without failing. Fix lint findings in files you changed. Report the number of remaining findings elsewhere, but do not fix them unless the user asks.

Then run `agt validate --fast` after each meaningful code change. Fix failures before continuing. Fast validation is enough while developing, committing, and opening a PR. Report it as fast validation, not comprehensive validation.

Before merging the PR, run `agt validate` locally on a clean checkout of its final head and require it to pass. You may start this with `agt validate --fast --background` once the change is ready for review, then use `agt validate --wait` to confirm a passing full result for that tree. If the result is stale or missing, run `agt validate` in the foreground. Do not run foreground validation merely to check a background run: it stops the background run and starts again. After any change to the PR head, run full validation again before merging.

Record the passing full result on the PR before merging. Until CI runs full validation as a required check, the person merging must verify this local result; GitHub branch protection alone cannot enforce it.

Passing fast validation is not comprehensive validation; report which one ran.

If validation fails, stop the standard Swift validation, analyze the output, and report the failure clearly. Do not treat successful earlier stages as a successful validation result. For example, if formatting passes but the workspace build fails, report `agt validate` as failed.

## Failure Classification

Classify a validation failure before deciding what to do next.

A source failure is caused by code, tests, project configuration, or generated project inputs within the requested change's scope. Examples include compiler errors, test failures, linter failures, and incorrect build settings.

When a source failure can be corrected within the user's request without a material design decision, fix it and rerun the failed validation command. Otherwise, report the failure and ask the user for direction.

An external blockage prevents validation without indicating an error in the changed source. Examples include a locked build database, a missing SDK, unavailable credentials, an unavailable service, or a network failure.

A sandbox that denies writes to `~/Library/Caches/org.swift.swiftpm` or the per-user clang module cache ("Operation not permitted") is an external blockage. Ask the user to run `~/.local/share/agents/scripts/refresh`, which allows those caches in Claude Code's and Codex's sandboxes, then start a new session.

For an external blockage, do not modify the environment or run separate fallback verification automatically. Report the validation as blocked, identify the blocker and skipped stages, then request permission for any proposed fallback command.

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
