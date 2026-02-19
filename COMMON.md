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
- Do not add dependencies without clear justification.
- Never commit secrets, keys, tokens, or credentials.

## Testing and Validation

- Add tests for new behavior and bug fixes where feasible.
- Run the narrowest relevant checks first, then broader project checks.
- If validation cannot be run, state this explicitly.

## Documentation

- Keep documentation factual and current with behavior.
- Update README or local docs when workflows or commands change.
- Prefer concise docs with links to deeper references.

## Safety and Change Discipline

- Do not perform destructive actions without explicit approval.
- Avoid unrelated refactors while completing focused tasks.
- If unexpected workspace changes appear, pause and confirm direction.

## Technology Modules

Check `~/.local/share/agents/instructions/` for further instructions to follow.
You will find files relating to certain technologies, services and programming 
languages.

Read only the files used in the project.

Currently we have specific coding standards for:
- Languages:
  - Swift
  - Python
  - Javascript
- Technologies:
  - SwiftUI 
- Services:
  - Github (eg for making pull requests)

## Workflow Modules

Load workflow/tooling guidance only when relevant:

- `instructions/services/github.md`

## Tool Profiles

Tool-specific notes live in:

- `agents/codex/README.md`
- `agents/opencode/README.md`
- `agents/copilot/README.md`
