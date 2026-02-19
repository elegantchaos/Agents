# Global Agent Defaults

These instructions are intended to be broadly applicable across projects, languages, and host tools.

## Scope

- Prefer minimal, focused changes that solve the requested problem.
- Preserve existing architecture and style unless change is explicitly requested.
- Fix root causes when practical; avoid layering temporary workarounds.

## Workflow

1. Understand the request and boundaries.
2. Inspect relevant code and docs before editing.
3. Make the smallest coherent change set.
4. Add or update tests for behavior changes.
5. Run project validation commands.
6. Summarize what changed, why, and remaining risks.

## Engineering Principles

- Correctness first, then clarity, then convenience.
- Keep interfaces small and explicit.
- Prefer simple, maintainable designs over clever shortcuts.
- Avoid hidden coupling and surprising side effects.
- Avoid excessively long methods.
- Avoid single-line wrapper methods.
- Always comment methods and types to explain their purpose.
- Use comments sparingly inside methods, to explain non-obvious code.
- Do not add dependencies without clear justification.
- Never commit secrets, keys, tokens, or credentials.
- See `instructions/principles.md` for context.


## Testing and Validation

- Add tests for new behavior and bug fixes where feasible.
- Run the narrowest relevant checks first, then broader project checks.
- If validation cannot be run, state this explicitly.

## Research

If in doubt, research a topic and present options before diving in.
See `instructions/trusted-sources.md` for research, validating uncertain facts, choosing citations, or resolving conflicting technical claims.
Feel free to suggest additional sources.

## Documentation

- Keep documentation factual and current with behavior.
- Update README or local docs when workflows or commands change.
- Document the architecture, calling out the guiding principles.
- Document the implementation, calling out issues.
- Prefer concise docs with links to deeper references.

## Safety and Change Discipline

- Do not perform destructive actions without explicit approval.
- Avoid unrelated refactors while completing focused tasks.
- If unexpected workspace changes appear, pause and confirm direction.

## Further Guideance

Load relevant files from `instructions/`.

Use this routing index to decide quickly:

- `instructions/languages/swift.md`: Load for `.swift`, `Package.swift`, SwiftPM, Xcode targets, or Swift concurrency/code-style decisions. Skip for non-Swift repos.
- `instructions/languages/python.md`: Load for `.py`, Python tooling (`pyproject.toml`, `requirements*.txt`), packaging, typing, or test/lint setup in Python repos.
- `instructions/languages/javascript.md`: Load for JS/TS files, `package.json`, Node/browser tooling, npm/pnpm/yarn workflows, and frontend/backend JS patterns.
- `instructions/technologies/swiftui.md`: Load when touching SwiftUI views, modifiers, state/data flow (`@State`, `@Observable`, `@Environment`), navigation, or previews.
- `instructions/services/github.md`: Load for branches, commits, PRs, issues, Actions workflows, CODEOWNERS, release flow, and review etiquette.
