# Swift Instructions

Use this module only when the project uses Swift.

## Core Expectations

- Prefer modern Swift concurrency (`async/await`, actors, structured tasks).
- Avoid `DispatchQueue.main.async` when actor isolation is the correct model.
- Favor value types unless reference semantics are required.
- Mark classes `final` unless inheritance is intentional.
- Avoid force unwraps and `try!` except in provably safe cases.

## Code Organization

- Prefer one primary type per file.
- Keep type and file names aligned.
- Use small, explicit APIs and avoid broad utility dumping.
- Keep protocol conformances clear and localized.

## Safety and Clarity

- Make actor isolation explicit for UI-facing or shared mutable state.
- Prefer typed errors for domain failures.
- Avoid hidden global state.

## Validation

- Run package or target-specific builds/tests first.
- Run full project checks before completion.
