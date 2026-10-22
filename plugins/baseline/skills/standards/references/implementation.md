# Implementation Guidance

Use this file when deciding how broad a change should be and how code should be structured.

## Precedence

- Follow repository-local `AGENTS.md` first.
- Then follow any local guidance explicitly referenced by that `AGENTS.md`.
- Use relevant skills.
- Use `~/.local/share/agents/COMMON.md`.
- Never let shared fallback guidance override explicit local repository rules.

## Project Decisions

- If the project maintains a decision log, read every record in full before proposing a design or changing code. Determine applicability after reading.
- Reuse records already read in the current conversation unless they have changed. Follow additional references only where needed to understand a decision's constraints.
- Apply accepted decisions; consider draft and superseded records as context. Raise unclear status, conflicting decisions, or conflicts with the proposed implementation before proceeding with affected work.
- Existing code, established patterns, and passing tests do not authorize exceptions. Use `baseline:records` for proposed decision changes.
- Report unread records or unchecked constraints explicitly. Do not claim decision compliance while those gaps remain.

## Change Strategy

- Apply focused changes to perform the requested actions.
- Fix root problems, don't layer workarounds.
- Propose a new architecture when it is the best solution. Explain what problem it solves and why it is necessary.
- Modernize code aggressively.
- Ask permission before adding complexity to an existing design. Explain what problem it solves and why it is necessary.

## Refactoring

Refactor aggressively when implementing a requested change. Fix underlying design problems, eliminate duplication, and avoid workarounds.

Understand the affected design and its callers before changing it. Apply the resulting design consistently.

When a new architecture or idiom is introduced, refactor the existing codebase to stay consistent. Avoid a mix of old & new architectures in the same codebase.

Do not leave competing implementations merely to keep the patch small.

For large changes, prefer a series of small refactorings to one large one.

Record issues discovered during implementation. Suggest follow-ups when useful.

### Useful Patterns

Look for refactors that:

- Modernise the code.
- Make it cleaner.
- Make it more consistent.
- Make it more compliant with our guidelines.
- Make it more idiomatic for the language or platform.
- Remove layers that are obsolete or thin wrappers.
- Improve overall test coverage.

## Backwards Compatibility

- Assume that backwards compatibility is not required, unless explicitly requested.
- Assume that you can break existing API contracts, unless explicitly prohibited.
- Do not add shims, aliases, or other layers whose purpose is to preserve superseded APIs or behavior, unless compatibility support is explicitly requested.
- Treat a refactored API, tool, script, or interface as the new source of truth.
- Update known call sites, tests, and documentation as part of the same change.
- If compatibility support is requested, make it explicit and keep its scope tight.
- Treat data preservation as a requirement only when project documentation explicitly requires avoiding data loss, preferably under `Project Specific Rules` in `AGENTS.md`.
- Otherwise, assume existing data can be reset. Do not add migrations, schema-version handling, or data-preservation layers merely to retain it.
- When preservation is required, keep its implementation scoped to the documented requirement.

A project that requires data preservation can state:

> Preserve user data across application updates and storage-format changes.

## Interfaces And Dependencies

- Keep interfaces explicit, intentionally small, and unsurprising.
- Avoid hidden coupling and unexpected side effects.
- Do not add external dependencies without explicit permission and clear justification. Each dependency should remove meaningful complexity or provide capability the standard library and existing dependencies do not supply.
- Keep secrets and credentials out of source control and out of committed configuration.
- Use wrappers and adapters only when they have a concrete responsibility, such as translating an external contract, enforcing isolation, or managing resource lifetime. Explain why that boundary is needed.
- Do not add forwarding or translation layers merely to make an existing design appear to satisfy a guideline. Fix the underlying design.

## Failure Handling And Resource Ownership

- Make failure and cancellation behavior explicit at operation boundaries, including whether partial work can remain. Follow the operation's contract and documented project requirements.
- Propagate failures with enough context to diagnose the cause. Do not silently swallow errors, substitute success-shaped defaults, or expose secrets in diagnostics.
- Give resources a clear owner and lifetime. Release owned resources on success, failure, and cancellation, using the language or framework's established mechanisms.
- Honor cancellation and avoid leaving work running after its owner has finished. Preserve meaningful distinctions between cancellation and failure.
- Add retries only where required. Bound repeated attempts and ensure repetition cannot produce unintended duplicate effects.
- Add transactions, rollback, or recovery machinery only where the operation's contract or documented project requirements require it. Avoid speculative resilience layers.

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
