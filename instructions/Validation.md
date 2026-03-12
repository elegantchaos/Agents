# Validation and Verification

Relevance: include this file for all projects where code changes can be validated by tests, linters, formatters, or build checks.

Use specialist testing skills for framework-specific test design and API guidance. Use this module for validation policy and reporting expectations.

## Baseline Expectations

- Add or update validation relevant to the behavior you changed.
- Prefer red/green development for non-UI behavior where practical.
- Run the narrowest checks that prove the change first, then broaden out.
- If a change cannot be validated fully, report exactly what was skipped and why.

## Validation Workflow

1. Run narrow checks closest to the change first.
2. Run broader project checks next.
3. Use the shared `validation-flow` skill checkout (`~/.local/share/skills/validation-flow-skill`) for standard validation (`rt validate`) when it applies.
4. If validation cannot run, report exactly what was not validated and why.

## Reporting Guidance

When summarizing work:

- list what checks were run
- list what checks were skipped
- call out meaningful residual risk from skipped validation
