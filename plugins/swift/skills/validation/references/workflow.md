# Swift Validation Workflow

## Getting `agt`

Formatting and validation run `agt format` and `agt validate` from AgentTools. Run this skill's `scripts/ensure-agt.sh` to get the path to `agt`; it installs AgentTools (and Mint, via Homebrew) if `agt` is missing.

This skill needs AgentTools 3.1.0 or later, which can run inside an agent's sandbox. Check with `agt --version`, which prints, for example, `AgentTools v3.2.0.`. If the command fails (releases before 3.2.0 have no `--version`) or reports an older release, run `scripts/ensure-agt.sh --update` to install the latest release. This needs network access.

## Commands

- Format and lint every Swift file:
  - `agt format`
- Comprehensive validation:
  - `agt validate`
- Targeted validation:
  - `agt validate --target <target-name>`
- Options:
  - `agt format --help`
  - `agt validate --help`

`agt validate` never modifies the project, so always run `agt format` first.

Some repositories' `AGENTS.md` still name `rt validate`. It is deprecated; use `agt format` followed by `agt validate`, which takes the same options.

## Required Workflow

Run `agt format` after every change. It formats every Swift file in the repository and then lints them, reporting findings without failing. Fix lint findings in files you changed. Report the number of remaining findings elsewhere, but do not fix them unless the user asks.

If only an individual target has been changed, you may then run targeted validation to quickly validate the impacted target for errors.

If targeted validation fails, stop validation at that point.

When quick targeted validation passes, or if it would not save time, run comprehensive validation.

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
