# Full Review: Baseline Standards Skill

Date: 2026-10-22

## Summary

Full review of `plugins/baseline/skills/standards/`, covering all eight files: the skill, six references, and runtime metadata. Reviewed commit `d6996a24492fd68523fcfbf19220645b9b90bd8c` with the current uncommitted principle descriptions and four approved additions. Coverage is complete for the skill's written guidance; agent behavior was not evaluated. Verdict: ready after clarifications to the adapter prohibition and compatibility scope. The strongest further improvements make decision compliance, tests, failure behavior, and completion checks more explicit. This review proposes changes; it does not apply them.

## Decision Compliance

No decision log is configured or present in this repository. Checked root `AGENTS.md` and the complete `extras/` file inventory. Reviewed `COMMON.md`, the baseline review and records skills, and the October 21 decision-coverage journal entry for governing context. The existing expectation to inspect decisions is present in COMMON and records; complete reading and evidence-backed applicability are explicit in review only.

## Findings

1. **Should fix: distinguish useful adapters from empty forwarding layers.** `references/implementation.md:53` prohibits all wrappers and adapters unless requested; line 64 more precisely targets wrappers created merely to satisfy an interface or fix dependency issues. The blanket rule can obstruct a substantive adapter that translates an external contract or enforces an isolation boundary. Retain the prohibition on compatibility scaffolding and superficial compliance layers; judge other boundary components by their concrete responsibility and necessity.

2. **Should fix: separate API freedom from data safety.** `references/implementation.md:51-56` allows breaking API contracts and updating known callers, without addressing persisted data or external consumers. Retain the default freedom to refactor APIs, but require explicit consideration of stored formats, interchange, and consumers outside the checkout. Permission to break an API does not establish permission to discard or silently reinterpret user data. Require a deliberate migration, rejection, or reset policy where those boundaries change.

3. **Suggestion: extend decision coverage to design and implementation.** `SKILL.md:13-18` and `references/implementation.md:5-11` omit a decision-reading and applicability step. `COMMON.md:9` requires inspection, and `baseline:review` requires complete reading before assessment. Make the equivalent preparation explicit before proposing or implementing a design, with conflicts raised before editing. Keep detailed decision-record maintenance in records. The October 21 journal already identifies this extension as a follow-up.

4. **Suggestion: make scope and escalation rules unambiguous.** `references/implementation.md:18-29` combines aggressive modernization, whole-codebase consistency, and task-scoped refactoring. `references/principles.md:27-28` requires asking about conflicts and also supplies a priority order. State which rule controls when they overlap: finish the coherent change within authorized scope, identify broader work separately, and specify which tradeoffs the existing priority order resolves versus which require user approval. Preserve the user's control over actual exceptions and architectural changes.

5. **Suggestion: require tests to demonstrate the intended regression.** `references/testing.md:5-16` requires red/green TDD and behavior-focused tests, but does not explicitly require observing the expected failure before the fix or checking that the failure has the right cause. Add this distinction, and require isolation from persistent preferences, caches, clocks, and other shared state when relevant. Do not require new tests for edits that change no executable behavior. Google's [review guidance](https://google.github.io/eng-practices/review/reviewer/looking-for.html#tests) independently emphasizes verifying that tests fail when the behavior is broken.

6. **Suggestion: add a compact failure and resource section.** `references/good-code.md:11` calls for predictable failures, and `references/principles.md:19` covers structured task lifetimes. The implementation reference does not give operational checks for partial writes, cancellation, cleanup, retries, or error suppression. Require explicit failure outcomes, cleanup of owned resources, a stated policy for partial mutation, and actionable diagnostics without secrets. Keep language-specific mechanisms in specialist skills.

7. **Suggestion: reconcile requirements with the completion checklist.** `SKILL.md:44-51` checks tests, documentation, roots, duplication, and lint, but omits decision compliance, scope, data boundaries, dependency authorization, and whether required validation actually passed. Dependency policy is also split between `references/implementation.md:62` (justification) and `references/testing.md:59` (explicit permission). Put the authoritative dependency policy in implementation, retain a reference from testing if needed, and add a short checklist item for each material requirement.

## Codebase Effect

### Made Obsolete

No guidance is removed by this review. If the dependency-policy recommendation is accepted, replace the weaker duplicate with a reference to the owning section.

Checked: `rg -n 'standards|references/(good-code|principles|implementation|testing|scripting|external)\.md' plugins/baseline/skills plugins/baseline/README.md COMMON.md` identified the standards entry point, baseline review dependency, and refresh selection rules. No reference rename is proposed.

### Simplification Now Possible

One dependency policy and an explicit scope rule would remove competing interpretations without adding a new workflow or skill.

Checked: read all six standards references and `SKILL.md` in full; compared the permission and justification clauses, the wide/narrow scope sections, and the principles' application rules.

### Duplication

Avoid copying the full review or records procedures into standards. State the implementation obligation and reference the owning procedure. Keep the checklist as a short verification aid.

Checked: `rg -n 'decision|compatib|adapter|wrapp|complexity|ask first|prioritize|debug|measure|benchmark|cancel|cleanup|atomic|transaction|rollback|data loss|injection|quot' plugins/baseline/skills COMMON.md` found the decision and permission rules described above, and additional command-text handling already owned by the Git skill.

### Design Clarity

The skill's file boundaries remain useful: principles for design tradeoffs, implementation for operational rules, testing for evidence, external for sources, and scripting for automation. Improve those sections before adding more principle names.

Checked: read the standards runtime metadata and baseline plugin README, inspected the eight-file skill inventory, and searched standards plus COMMON for `decisions|decision log|stored|persisted|migration|atomic|rollback|resource|timeout|red|fails|failing|isolation|version|benchmark|performance|external dependencies|clear justification`. These confirm high-level failure coverage but no dedicated data-safety or resource-management policy. Performance guidance already requires justified need; a benchmark instruction is a lower-priority refinement.

## Follow-ups

If revisions are approved, apply the clarifications before new policy additions, then reconcile the checklist. A small set of example tasks could evaluate whether agents respect decision constraints, avoid empty wrappers, preserve data, and produce meaningful failing tests. Structural validation alone cannot establish these behaviors.

## Not Checked

No runtime tests, skill validator, plugin installation, full repository validation, or agent-behavior evaluation was run: this pass assesses written guidance and only records its findings. The eight files inside the skill were read in full; files elsewhere in the repository were inspected only as named contextual dependencies or search results. The unavailable Google testing-blog page was not used as evidence. No standards policy or plugin version was changed by this review.
