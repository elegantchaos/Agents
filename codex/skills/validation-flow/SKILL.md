---
name: validation-flow
description: Run standard post-change validation for Swift repositories. Use when code has been changed. It will reformat code, run linters, build for all relevant tagets, and execute tests to ensure code quality and functionality.
---

# Validation Flow

Use ReleaseTools validation via `rt validate`.
Run commands from the root of the repository being validated.
If `rt` is not installed, prompt the user to install ReleaseTools from:
- https://github.com/elegantchaos/ReleaseTools

## Commands

- Comprehensive mode:
  - `rt validate`
- Targeted mode:
  - `rt validate --target <target-name>`

## Required Workflow

If only an individual target has been changed, you may run targeted validation first, to quickly validate the impacted target for errors.

If that fails, you stop validation at that point.

When quick targeted validation passes, or if it would not save time, run comprehensive validation.

If validation fails, analyze the output to identify the cause of failure. Offer to fix the issue and re-run validation.

## Output Checklist

If the validation command succeeeds, produce minimal output confirming success. If warnings were present, mention that there were warnings, but do not list them in the final output. Offer to provide details on the warnings if the user wants to see them.

If the validation command fails, produce output that includes:
- commands run
- pass/fail per command
- skipped checks and reasons
- suggested fixes for any warnings
- suggested fixes for any failures
- suggested next steps based on the results
