# Engineering Principles

Use this file for design and implementation decisions, regardless of implementation language.

## Required Principles

- DRY
- Single Source Of Truth

## Preferred Principles

- KISS
- YAGNI
- Make Illegal States Unrepresentable
- Use Dependency Injection
- Prefer Composition Over Inheritance
- Command-Query Separation
- Apply The Law Of Demeter / Minimize Coupling
- Use Structured Concurrency
- Design By Contract
- Idempotency

## How To Apply These Principles

- Treat principles as strongly preferred.
- If you are tempted to break a principle, ask first. Explain why you need to.
- If principles conflict, prioritize correctness and safety first, then maintainability, then simplicity and clarity, then performance work, then flexibility for hypothetical future needs.
- If a change increases complexity, state why that complexity is necessary now.
- Prefer local, focused changes over broad refactors unless architecture changes are required, or you are being asked to clean up or improve consistency or code health.
- Keep interfaces explicit and intentionally small, and avoid hidden coupling and surprising side effects.
- Prefer following the principles over aligning with established project patterns.
- If a strong project pattern runs counter to the principles, call it out and ask to refactor it.
- Feel free to suggest missing principles that should be added to our list.
