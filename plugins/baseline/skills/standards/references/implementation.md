# Implementation Guidance

Use this file when deciding how broad a change should be and how code should be structured.

## Precedence

- Follow repository-local `AGENTS.md` first.
- Then follow any local guidance explicitly referenced by that `AGENTS.md`.
- Use relevant skills.
- Use `~/.local/share/agents/COMMON.md`.
- Never let shared fallback guidance override explicit local repository rules.

## Change Strategy

- Apply focused changes to perform the requested actions.
- Fix root problems, don't layer workarounds.
- Propose a new architecture when it is the best solution. Explain what problem it solves and why it is necessary.
- Modernize code aggressively.
- Ask permission before adding complexity to an existing design. Explain what problem it solves and why it is necessary.

## Refactoring

Refactor aggressively to avoid code duplication, and to keep the codebase consistent and modern, even if it risks breaking backwards compatibility.

Prefer a series of small refactorings to one large one.

When a new architecture or idiom is introduced, refactor the existing codebase to stay consistent. Avoid a mix of old & new architectures in the same codebase.

Scope refactoring to the task at hand: for cleanup, review, and modernisation requests, use a wide scope across the whole codebase; for new code and bug fixes, use a narrower scope.

### Wide Scope

Look for codebase-wide refactors that:

- Modernise the code.
- Make it cleaner.
- Make it more consistent.
- Make it more compliant with our guidelines.
- Make it more idiomatic for the language or platform.
- Remove layers that are obsolete or thin wrappers.
- Improve overall test coverage.

### Narrow Scope

- Prefer minimal, focused changes that solve the requested problem.
- Add or update tests for new behaviour.
- Suggest wide scope refactors for follow-up.

## Backwards Compatibility

- Assume that backwards compatibility is not required, unless explicitly requested.
- Assume that you can break existing API contracts, unless explicitly prohibited.
- Do not add shims, wrappers, adapters, aliases, or backward-compatibility layers, unless explicitly requested.
- Treat a refactored API, tool, script, or interface as the new source of truth.
- Update known call sites, tests, and documentation as part of the same change.
- If compatibility support is requested, make it explicit and keep its scope tight.

## Interfaces And Dependencies

- Keep interfaces explicit, intentionally small, and unsurprising.
- Avoid hidden coupling and unexpected side effects.
- Do not add dependencies without clear justification.
- Keep secrets and credentials out of source control and out of committed configuration.
- Avoid creating thin wrappers that forward or take closures, just to conform to an interface or to fix dependency issues.

## Formatting

- Prefer formatters and linters over manual stylistic rewriting.
- Use project configuration or language-specific guidance to determine format/lint tooling.

## Documentation

- Keep documentation factual, concise, and aligned with current behavior.
- Update when workflows, commands, designs, architecture or implementation changes.
- Avoid historical framing. Describe what the code does _now_.
- Remove stale or contradictory docs rather than layering new text on top.
- Retain roadmap and planning documentation if it is still relevant; remove if implemented.
- If specifically instructed to produce a migration guide, you can provide historical context, otherwise avoid it.

## Comments

- Update whenever code is touched.
- Do not use to restate symbol names or obvious control flow.
- Remove stale or contradictory comments rather than layering new text on top.
- Avoid referring to previous behaviour, migrations, legacy in comments.
- State what the code does now, not what it used to do.
- Explain _why_, not just _what_.
- Retain `TODO:` comments if they are still relevant; remove them if they have been implemented.

### Inline Comments

- Reserve inline comments for subtle logic that a future maintainer could misread.
- Focus on intent, invariants, side effects, and non-obvious constraints.

### Documentation Comments

- Add to all types and members, including private members
- For the benefit of someone browsing the code.
- To allow IDEs to surface documentation in their UIs.
- They should be compact but informative.
- They do not need to slavishly repeat every parameter or return type.
- Scale type comments to the type's significance. A small value or helper may need one
  precise sentence; a service, coordinator or central model needs enough context to explain
  its purpose and design to someone who has not read its members.

For significant types:

- Lead with the concrete job and outcome. Say what the type does for its callers; phrases
  such as "manages state" or "maintains the route" are incomplete without naming that state
  or explaining the operation.
- Explain the state or resources it owns and the main operations it performs. Name key
  collaborators and say what work is delegated to them when this clarifies responsibility.
- Explain how callers use the type, including distinct read and mutation interfaces when
  present. Include lifecycle, persistence, side effects or constraints that affect correct use.
- Check each claim against the implementation and relevant design documentation. Describe
  implemented behaviour, preserve meaningful limits, and avoid promises based on intended
  architecture alone.
- Keep the explanation selective. Do not catalogue every member, repeat signatures or pad
  simple types to a fixed length.

For example, "Owns import state" gives little guidance. "Reads source files through
registered importers, holds reconciled proposals for review, and writes accepted records
through storage. Views observe the pending proposal; commands start or apply the import."
explains the responsibility and usage.

When reviewing comments, check their meaning separately from documentation lint. Ask
whether a reader can explain what the type does, what it owns and how to use it without
opening its implementation. Revise vague summaries even when every declaration has a comment.

## Path Portability

- Do not embed machine-specific absolute paths in committed code, documentation, or configuration.
- Prefer repository-relative paths for resources that live in the current repository.
- Use `~/...` home-relative paths for shared resources outside the repository.
