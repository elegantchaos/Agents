# Engineering Principles

Use this file for design and implementation decisions, regardless of implementation language.

Follow these principles:

- **Don't Repeat Yourself (DRY).** Give each piece of knowledge or business logic one authoritative representation; consolidate duplication when it expresses the same rule.
- **Single Source Of Truth.** Give each fact or state one authoritative owner, and derive other views from it so independently writable copies cannot drift.
- **Keep It Simple, Stupid (KISS).** Choose the simplest design that meets current requirements and makes its behavior easy to understand.
- **You Ain't Gonna Need It (YAGNI).** Implement capabilities when a concrete requirement needs them; avoid speculative abstractions, configuration, and extension points.
- **High Cohesion / Separation Of Concerns.** Group behavior and data that change for the same reason, and give each component a focused responsibility with clear boundaries.
- **Encapsulation / Information Hiding.** Hide internal state and changeable implementation decisions behind small public contracts so collaborators can evolve independently.
- **Make Illegal States Unrepresentable.** Use types and construction rules to prevent invalid combinations of data, reducing the checks callers must remember.
- **Use Dependency Injection.** Supply dependencies explicitly from outside a component so its collaborators are visible and replaceable without hidden global state.
- **Dependency Inversion.** Keep core policy independent of infrastructure details by making those details depend on contracts owned by the core; introduce abstractions where a concrete boundary needs them.
- **Prefer Composition Over Inheritance.** Build behavior by combining focused components; use inheritance only when the subtype genuinely satisfies the parent type's contract.
- **Command-Query Separation.** Separate commands that change state from queries that return data without changing observable state; keep each operation's role clear.
- **The Law Of Demeter / Minimize Coupling.** Depend on a collaborator's public contract, and avoid reaching through it into other objects or relying on its internal structure.
- **Use Structured Concurrency.** Tie concurrent tasks to an explicit scope that owns their lifetime, waits for completion, and coordinates cancellation and failure.
- **Design By Contract.** Define preconditions, postconditions, and invariants explicitly, and enforce them at the boundaries responsible for maintaining them.
- **Idempotency.** Where operations may be retried, make repeated execution have the same intended effect as one execution, preventing duplicate side effects.
- **Least Privilege / Secure Defaults.** Grant only the access needed for an operation, deny access unless explicitly allowed, and preserve those restrictions when failures occur.

## How To Apply These Principles

- Treat principles as strongly preferred.
- If you are tempted to break a principle, or there is a conflict, ask first. Explain the context.
- If principles conflict, prioritize correctness and safety first, then maintainability, then simplicity and clarity, then performance work
- Avoid adding flexibility for hypothetical future needs.
- If a change increases complexity, state why that complexity is necessary now.
- Keep interfaces explicit and intentionally small, and avoid hidden coupling and surprising side effects.
- Prefer following the principles over aligning with established project patterns.
- If a strong project pattern runs counter to the principles, call it out and ask to refactor it.
- Feel free to suggest missing principles that should be added to our list.
