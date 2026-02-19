# Python Instructions

Use this module only when the project uses Python.

## Core Expectations

- Prefer clear, explicit code over implicit magic.
- Use type hints for public functions and non-trivial internal APIs.
- Keep functions small and side effects obvious.
- Avoid broad exception swallowing; handle expected errors precisely.

## Environment and Dependencies

- Use the project-managed virtual environment/tooling.
- Do not introduce new dependencies without justification.
- Pin or constrain versions according to project conventions.

## Project Structure

- Keep reusable logic in modules, not scripts.
- Keep CLI/task scripts thin wrappers around module logic.
- Add docstrings where behavior is not obvious from naming.

## Validation

- Run relevant tests/lint/type checks for changed code.
- If checks cannot run, state exactly what was not validated.
