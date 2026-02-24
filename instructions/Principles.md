# Engineering Principles

Relevance: include this file for most software projects. It defines shared design and implementation principles for humans and agents.

## Why this file exists

This module explains the reasoning style that should guide engineering decisions when project-specific rules are incomplete or ambiguous.

## How to apply these principles

- Use principles as decision heuristics, not rigid laws.
- When principles conflict, prioritize user-visible correctness and long-term maintainability.
- If a change increases complexity, state why the complexity is necessary.
- When unsure, prioritize correctness and safety over micro-optimization.
- Prefer local changes over broad refactors.
- Keep public surface area intentionally small.
- Align with established project patterns unless there is strong reason to diverge.

## Principles

### KISS (Keep It Simple)

Prefer the simplest implementation that satisfies current requirements.

Signals of over-engineering:
- abstractions introduced without repeated need
- generic frameworks created for one-off behavior

### YAGNI (Build What Is Needed)

Do not implement speculative flexibility.

Practical use:
- delay optional abstraction until concrete reuse appears
- default to tighter visibility and narrower APIs

### DRY (Don't Repeat Yourself)

Reduce duplicated behavior when it lowers defects and maintenance cost.

Practical use:
- deduplicate business logic before presentation details
- avoid abstractions that hide intent across unrelated contexts
- maintain a single authoritative source for mutable facts and derive projections from it

### Make Illegal States Unrepresentable

Use types, enums, and constrained interfaces to prevent illegal states.

### Dependency Injection

Prefer constructor or parameter injection over hidden globals.

### Composition Over Inheritance

Prefer small composable types and protocol boundaries to deep hierarchies.

### Command-Query Separation (CQS)

Avoid methods that both mutate state and return complex derived outputs.

### Law of Demeter (Least Knowledge)

Minimize coupling by avoiding deep dependency chains and leaky boundaries.

### Structured Concurrency

Be explicit about actor/threading boundaries and shared mutable state ownership.

### Design by Contract

Define and enforce preconditions, postconditions, and invariants at boundaries.

Practical use:
- validate contract assumptions at module/API boundaries
- fail early with clear diagnostics when contracts are violated

### Idempotency

Design side-effecting operations so repeated execution with the same input yields the same externally visible result where feasible.

Practical use:
- use idempotency keys for retried requests that create or mutate resources
- make retries safe in networked/distributed workflows

## Guidance for Agent Outputs

- Keep diffs focused and easy to review.
- Briefly explain architectural tradeoffs when changing structure.
- If adding abstraction, name the concrete duplication or risk it resolves.

## References

- KISS: C.A.R. Hoare, "The Emperor's Old Clothes" (1981), https://dl.acm.org/doi/10.1145/358549.358561
- YAGNI: Martin Fowler, "YAGNI", https://martinfowler.com/bliki/Yagni.html
- DRY: Andrew Hunt and David Thomas, "The Pragmatic Programmer"
- Make Illegal States Unrepresentable: Alexis King, "Parse, don't validate", https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/
- Dependency Injection: Martin Fowler, "Inversion of Control Containers and the Dependency Injection pattern", https://martinfowler.com/articles/injection.html
- Composition Over Inheritance: Erich Gamma et al., "Design Patterns"; Joshua Bloch, "Effective Java"
- Command-Query Separation: Bertrand Meyer, "Object-Oriented Software Construction"; Martin Fowler, "CommandQuerySeparation", https://martinfowler.com/bliki/CommandQuerySeparation.html
- Law of Demeter: Karl Lieberherr et al., OOPSLA 1988, https://dl.acm.org/doi/10.1145/62083.62084
- Structured Concurrency: Swift Evolution SE-0304, https://github.com/swiftlang/swift-evolution/blob/main/proposals/0304-structured-concurrency.md
- Design by Contract: Eiffel, "Design by Contract", https://www.eiffel.org/doc/eiffel/ET-_Design_by_Contract_%28tm%29%2C_Assertions_and_Exceptions
- Idempotency: RFC 9110 Section 9.2.2, https://www.rfc-editor.org/rfc/rfc9110#section-9.2.2
