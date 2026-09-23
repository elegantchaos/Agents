# Research Phase

Use this phase when requested, when maintaining the shared agents repository itself, or when concrete evidence suggests a skill or shared rule is stale.

## Scope

Research should improve shared guidance, not create speculative churn.
Good candidates include:

- language or framework skills that may lag current platform practice
- skills derived from known external source material, such as Paul Hudson's Swift guidance
- automation workflows that have repeated friction or manual repair steps
- public examples of high-quality skill structure, boundaries, or checklists

## Source Quality

Use trusted primary sources whenever possible:

- official language, framework, and vendor documentation
- official migration guides, release notes, and API references
- source repositories or authoritative examples from the original project
- clearly attributed expert material when primary documentation is incomplete

Treat blog posts, examples, and community discussions as supporting evidence, not as sole authority for mandatory rules.

## Seed Sources

When looking for new skills, skill structure ideas, or candidate guidance improvements, include these recurring seed sources when they match the research question:

- `https://github.com/twostraws/swift-agent-skills`: curated Swift and Apple platform agent skill directory; use it to discover candidate Swift, SwiftUI, SwiftData, Swift concurrency, Swift Testing, accessibility, app-store, architecture, performance, security, and tooling skills.
- `https://simonwillison.net/`: high-signal AI, tooling, LLM, and software engineering writing; use it for emerging agent practice, evaluation ideas, tool-use patterns, and workflow design.
- `https://build.ms/`: skill-building and agent workflow material; use it for skill structure, packaging, and authoring patterns.

Before borrowing from any seed source:

- read the candidate material directly
- check licensing and attribution expectations
- prefer adapting the underlying practice over copying wording
- cross-check technical claims against primary documentation when they would become mandatory guidance

## Workflow

1. State the research question and the skill or reference file it may affect.
2. Collect only the source material needed for that question.
3. Compare current guidance against the sources and classify findings as:
   - `add`: missing guidance that is durable and broadly useful
   - `revise`: existing guidance that is stale, unclear, or too broad
   - `leave`: source material that does not justify a change
4. Propose only high-confidence additions or revisions that fit the skill's boundary.
5. Explain where each accepted proposal would belong.
   - Put procedural or domain-specific guidance in the owning skill, not in `COMMON.md` or generated `Standard Rules`.
   - Put durable repo-wide baseline policy in `COMMON.md` only when it is not owned by a narrower skill.
6. Ask the user for confirmation before implementing any research-driven addition or revision.
7. Do not edit skills, shared references, or `COMMON.md` from the research phase unless the user explicitly approves the proposed change set.
8. Record sources, rationale, and pending confirmation status in the final response.

## Automation Guidance

For regular automations, keep research bounded.
Prefer a rotating focus area, such as one skill family per run, rather than broad open-ended research across every skill.
If no concrete stale area is known, skip research and report that it was skipped to keep the refresh idempotent.
Automated research runs must stop after proposing changes and opening an inbox item; they must not apply research-driven edits without user confirmation.
