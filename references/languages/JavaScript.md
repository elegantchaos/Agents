# JavaScript and TypeScript Guidance

Relevance: include this file when the project contains JavaScript or TypeScript (`package.json`, `.js`, `.ts`, frontend or Node tooling).

## Core Expectations

- Prefer TypeScript when the project supports it.
- Keep async behavior explicit and avoid unhandled promises.
- Favor clear module boundaries and explicit data flow.
- Avoid hidden mutable global state.

## Reliability Guidance

- Validate external input at boundaries.
- Handle runtime failures explicitly.
- Keep runtime assumptions (browser, Node, edge) explicit in module design.

## Dependencies and Tooling

- Reuse existing lint/format/build/test setup.
- Avoid adding dependencies without clear need.
- Keep scripts deterministic and CI-friendly.

## Validation Expectations

- Run tests, lint, and type-checks relevant to changed files.
- If full validation is skipped, report what was not run and why.
