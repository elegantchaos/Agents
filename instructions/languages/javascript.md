# JavaScript Instructions

Use this module only when the project uses JavaScript or TypeScript.

## Core Expectations

- Prefer TypeScript for new code when the project supports it.
- Keep async flows explicit and avoid unhandled promises.
- Favor pure functions and explicit data flow over hidden mutable state.
- Keep modules focused and avoid overly broad utility files.

## Reliability

- Validate external input boundaries.
- Handle runtime failures explicitly; avoid silent catches.
- Keep browser/node assumptions explicit in module boundaries.

## Dependencies and Tooling

- Reuse existing framework and lint/format setup.
- Avoid adding dependencies without clear need.
- Keep scripts deterministic and CI-friendly.

## Validation

- Run the project test/lint/type-check commands relevant to changed files.
- If full validation is skipped, report the gap.
