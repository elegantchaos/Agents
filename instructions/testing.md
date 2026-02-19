# Testing Guidelines

## Baseline expectations

- Add unit tests for new behavior.
- Use the existing test style in the repository, and prefer migration-friendly test patterns.
- Prefer unit tests over UI tests when feasible.

## Validation commands

If validation scripts (`validate-changes`, `validate-target` exist,
run them after code changes.

They should validate the code and may also lint and format it.

If these scripts don't exist, or fail to run, perform your own checks.

If validation cannot be run at all, state this explicitly.


## Test design

- Test via public/internal interfaces.
- If needed, expose minimal test-support API and clearly label it as testing-only.
- Keep tests explicit and readable.
- Extract shared test helpers to reduces repetition

## Coverage guidance

- Prefer focused tests on changed behavior and edge cases.
- For untested legacy code touched by a change, add tests where practical.
- Document known gaps when a full test is not feasible.
