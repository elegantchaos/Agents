# Swift Validation Workflow

If `rt` is not installed, prompt the user to install ReleaseTools from:

- https://github.com/elegantchaos/ReleaseTools

## Commands

- Comprehensive mode:
  - `rt validate`
- Targeted mode:
  - `rt validate --target <target-name>`

## Required Workflow

If only an individual target has been changed, you may run targeted validation first to quickly validate the impacted target for errors.

If targeted validation fails, stop validation at that point.

When quick targeted validation passes, or if it would not save time, run comprehensive validation.

If validation fails, stop the standard Swift validation, analyze the output, and report the failure clearly. Do not treat successful earlier stages as a successful validation result. For example, if formatting and lint pass but the workspace build fails, report `rt validate` as failed.

## Failure Classification

Classify a validation failure before deciding what to do next.

A source failure is caused by code, tests, project configuration, or generated project inputs within the requested change's scope. Examples include compiler errors, test failures, linter failures, and incorrect build settings.

When a source failure can be corrected within the user's request without a material design decision, fix it and rerun the failed validation command. Otherwise, report the failure and ask the user for direction.

An external blockage prevents validation without indicating an error in the changed source. Examples include a locked build database, a missing SDK, unavailable credentials, an unavailable service, or a network failure.

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

## Release Tools

We own the `rt` command, and the source code can usually be found in `~/Developer/Projects/ReleaseTools`.

Check that the installed version of `rt` in the path matches the latest tagged version. If not, suggest that the user updates to the latest version.

If validation fails due to blockages or other structural problems, consider whether the `rt` command could be improved to prevent them.

If there are improvements that could be made to the `rt validate` command, or new commands that could be added to `rt`, suggest them.
