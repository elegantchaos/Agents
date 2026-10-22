# Engineering Principle Descriptions

Date: 2026-10-22

Added compact descriptions to all twelve existing principles in the baseline standards reference. The descriptions distinguish shared knowledge from state ownership, scope idempotency to retryable operations, and describe structured task lifetimes and observable query behavior. The principle inventory and application rules are unchanged. Both baseline plugin manifests advance to 0.8.2, following the root README's versioning rule for guidance changes.

Reviewed the reference with its standards skill and sibling quality, implementation, and testing guidance. No decision log is configured or present in this repository. The only direct reference to `principles.md` is the standards skill's required-reference list; its path remains valid.

Proposed additions, pending user review:

- High cohesion and separation of concerns: group work that changes together and give components a focused responsibility.
- Encapsulation and information hiding: hide internal state and changeable implementation decisions behind small contracts.
- Dependency inversion: keep core policy independent of infrastructure details; dependency injection alone does not establish this direction.
- Least privilege and secure defaults: grant only necessary access and deny access unless explicitly allowed.

The first two overlap the existing coupling principle but make responsibility and boundary design explicit. The security addition provides concrete design guidance beyond the general security quality criterion in `good-code.md`.

Sources consulted: [Parnas on modular decomposition](https://www.cs.lafayette.edu/~gexia/cs301/resources/parnas.html), [Microsoft architectural principles](https://learn.microsoft.com/en-us/dotnet/architecture/modern-web-apps-azure/architectural-principles), [Saltzer and Schroeder on information protection](https://web.mit.edu/Saltzer/www/publications/protection/Basic.html), [Fowler on command-query separation](https://martinfowler.com/bliki/CommandQuerySeparation.html), and [RFC 9110 on idempotent methods](https://www.rfc-editor.org/rfc/rfc9110.html#name-idempotent-methods). These informed the review; no new principles were adopted.

Validation: standards skill quick_validate passed using the shared Python environment. JSON parsing confirmed that both manifests declare baseline 0.8.2. A structural check confirmed all twelve principle names and their order are preserved, the application rules are unchanged, and local Markdown links in the standards skill and journal index resolve. `git diff --check` passed. Manual checklist review covered every changed file for concise factual wording, source paths, scope, consistent packaging, and journal accuracy. No executable behavior changed, so runtime tests were not run. Global resource refresh, runtime plugin installation, and AGENTS regeneration were outside this focused document edit; the installed Codex cache has not been updated.

## Follow-up: Recommended Principles Added

Sam approved all four recommended additions. Added compact definitions for high cohesion and separation of concerns, encapsulation and information hiding, dependency inversion, and least privilege and secure defaults. Dependency inversion explicitly ties abstractions to concrete boundaries, preserving the existing KISS and YAGNI guidance. The document now lists sixteen principles; its application rules are unchanged. These additions are part of the same unreleased baseline 0.8.2 update.

Validation: standards skill quick_validate passed. Structural checks confirmed sixteen described principles, unchanged application rules, matching 0.8.2 manifests, and valid journal index links. `git diff --check` passed. Manual checklist review of the three files changed in this follow-up confirmed compact factual descriptions, consistency with the existing principles, and accurate historical records. Runtime tests were skipped because only documentation changed; installed plugin caches remain unchanged.
