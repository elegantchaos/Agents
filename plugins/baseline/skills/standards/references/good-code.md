# Writing Good Code

Use this file when you need a shared definition of code quality across languages and frameworks.

Good code has these properties:

- It works. It does what it is meant to do without defects.
- We know it works. Validation provides evidence that the code is fit for purpose.
- It solves the right problem rather than just producing a plausible implementation.
- It is modern and idiomatic for its language and platform.
- It handles failure paths predictably and communicates useful diagnostic information.
- It is simple and minimal: it does what is needed without unnecessary machinery.
- It is protected by tests or other relevant validation so regressions are easier to catch.
- It is documented at the right level, and that documentation stays aligned with current behavior.
- It leaves the system easier to change by avoiding needless rigidity and needless speculative abstraction.
- It satisfies the non-functional qualities that matter for the software in question, such as accessibility, reliability, security, maintainability, observability, scalability, testability, and usability.

When quality dimensions conflict, prefer correctness and safety first, then maintainability and clarity, then performance work that is justified by real needs.
