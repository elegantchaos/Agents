---
name: review
description: Performs a broad review of a pull request, branch, diff, plan, or another agent's completed work, covering correctness, conformance to our standards, design quality, and the change's effect on the wider codebase, or a full review of a whole package or codebase. Use when asked to review any of these. Use in preference to built-in review commands, which focus on bugs in the diff.
---

# Review

A review answers three questions:

1. Does the change do what it set out to do, correctly?
2. Does it meet our standards?
3. Is the codebase better for it, and what does it make possible or necessary next?

The third question matters as much as the first two. A change can be correct and compliant and still leave the codebase more confusing, duplicated, or inconsistent. Answering it requires reading beyond the diff.

## Decision Coverage

This requirement applies to every review mode, including plans and design documents.

Before assessing the implementation or proposed design, enumerate the project's complete decision log and read every decision record in full. Determine applicability after reading each record; do not select records by title, keyword, diff scope, or perceived relevance. An index, summary, search excerpt, previous review, or an author's compliance claim does not substitute for reading the records. Follow references needed to understand their constraints. If the project has no decision log, record that explicitly.

Keep the complete decision assessment in internal working notes: each record's status and applicability, its binding constraints, and the evidence checked, including newly exercised existing code. Independently verify the author's assessment. Consider draft and superseded records in context, but do not enforce them as accepted current policy.

Report only deviations from decisions, conflicts or unclear status that affect the review, and unresolved coverage gaps. Put deviations in Findings with the governing decision, conflicting evidence and recommended action; put unread records or unchecked constraints in Not Checked. Do not include an inventory, compliance table, per-decision clean results, non-applicability explanations or a separate compliance appendix in the report or journal unless the user explicitly requests one. Complete checking does not require exhaustive reporting.

Existing code patterns, passing tests, and compiler acceptance do not establish compliance with a decision or authorize an exception. Report contradictions as findings with the governing constraint and conflicting evidence. Do not silently reinterpret a decision to fit the implementation.

If any record is unread or an applicable constraint remains unchecked, decision coverage is incomplete. Continue useful review work, identify every gap and its reason in Not Checked, and qualify the verdict as partial. Do not issue an unqualified ready verdict or claim architectural compliance. Time or context limits do not justify silently sampling the decision log. Resolve coverage gaps before making a complete compliance claim.

## Review Modes

Choose the mode from the request, and state it at the start of the review:

| Request                                                       | Mode                               | Report                                                                         |
| ------------------------------------------------------------- | ---------------------------------- | ------------------------------------------------------------------------------ |
| A pull request, branch, commit range, diff, or completed task | Diff review                        | The structure in Process step 5                                                |
| A named package, module, or target                            | Full review of that package        | The structure in Process step 5, with the package's purpose in place of intent |
| The codebase, the project, or the repository                  | Full review of the entire codebase | The structure in Reviewing an Entire Codebase                                  |
| A plan or design document                                     | Diff review of the document        | The structure in Process step 5                                                |

When a request fits more than one row, or none, ask which is meant.

- **Diff review.** Reviews a pull request, branch, diff, or completed task. Its scope is the change, the code the change calls or newly depends on, and existing code the change places in a new context, such as a reusable control it puts in a toolbar for the first time. Defects in that newly exercised code are in scope even though the diff does not touch it.
- **Full review.** Reviews a whole package, or an entire codebase with all its packages, reading every source file against every reference of every relevant skill. It finds defects that diff reviews miss because the code that contains them never changes. For a package, follow the same process, applied to the whole package: intent becomes the package's purpose as its documentation states it, and the codebase-effect sections cover the whole package, including dead code, duplication, and documentation that no longer matches the code. An entire-codebase review follows its own method and report, in Reviewing an Entire Codebase, because it is more than the sum of its packages' reviews.

After a diff review of a pull request, also offer a full review of each package the change touches when either:

- the package has at most 5,000 lines of source, excluding tests; or
- its last full review is more than 30 days old or predates its last release, or no full review is recorded.

Find the last full review in the project's journal. Record each full review there as an entry whose title begins "Full Review", stating the date, each package covered with its path, the commit or release reviewed, and whether coverage was complete or partial, listing what a partial review left out. A package's last full review is the latest complete one that names it; compare its reviewed commit or release with the package's latest release. Say when you cannot tell.

### Reviewing an Entire Codebase

A codebase review is not a series of package reviews. Its main subject is how the parts fit together: problems that live between packages, in the seams and across the whole, are invisible to a review of any one package, however thorough. Package reviews are one input to it. Work in this order:

1. **Map the whole.** List every package and target with its source size, and state the scope, including whether dependencies the project owns, such as packages in submodules, are in or out; ask when it is unclear. When the scope has more than about 10,000 lines of source, excluding tests, propose splitting the review before starting, since one session cannot read that much in full without skimming: this session keeps the map, the seams and the whole-codebase passes, and each package's in-depth review runs in a separate session that reports back. Wait for the user's choice. Then map the codebase as it is: each package's role and public API, the actual dependency graph against the architecture the documentation and decisions describe, the concepts that more than one package models, and the code that differs by platform.
2. **Review the seams.** At each package boundary, compare how callers actually use an API with how it was designed. Look for mismatched assumptions, workarounds and adapters in callers, leaky or unused abstractions, responsibilities split across packages or duplicated on both sides, and dependencies that run against the intended direction.
3. **Review across the whole.** Look for what only the whole shows: the same job done in more than one package or for more than one platform; one concept modelled differently in different places; special cases kept beside a general mechanism that could represent them, as described under Special cases the general form can absorb in Process step 4; cross-cutting concerns, such as error handling, logging, concurrency and isolation, observation, localization and test helpers, handled inconsistently; standards and idioms applied unevenly; and old and new ways of doing something left side by side.
4. **Each package in depth.** Give each package its own full review, every file read in full and checked against the applicable skill checklists, informed by the map, so that findings about a package's fit with the rest are made there too. When the review is split, give each package session the map so it can judge fit, and keep the map, seams and whole-codebase passes in the main session so they are not lost between reports.
5. **Report.** Report decision deviations and unresolved gaps as described in Decision Coverage; omit clean decision results. Use the structure below. Lead with the codebase-level findings, from the seams and the whole. A report made only of per-package findings is not a codebase review, and one that sampled files is reported as sampled, never as complete.

```markdown
## Summary

The codebase's purpose, the scope reviewed, a verdict on its overall health, and the most important findings, in three or four sentences. Qualify the verdict as partial when decision coverage is incomplete; do not claim architectural compliance.

## Map

Each package's role, size and public API in a line or two; the dependency graph, noting where it departs from the documented architecture and decisions; concepts modelled in more than one package; code that differs by platform.

## Codebase Findings

Most severe first, from the seams and the whole-codebase pass. Each with severity (blocking, should fix, or suggestion), the packages involved, evidence, and recommended action.

### Seams

### Across the Whole

Under each: findings, then "Checked:" listing each boundary, search pattern or command, and file read, and what it returned.

## Package Findings

### <Package>

Each package's findings, most severe first, then "Checked:" with its files read and searches made. A package reviewed in a separate session links or includes that session's report.

## Follow-ups

Larger work the review suggests, such as consolidating duplicated code into a shared package.

## Not Checked

Every package or file not read in full, and anything else skipped or unverified, and why.
```

## Rules

- Review the whole change. Do not stop after the first few findings.
- Read beyond the diff: every changed file in full, the callers of changed code, the code the change newly depends on or places in a new context, and sibling code that does similar jobs.
- Back every finding with evidence: a `file:line`, a search result, or a test outcome. Mark findings you could not confirm as unverified.
- When you find a defect, search the whole codebase for other instances of it, including code the change did not touch. Report every instance found.
- Record what you checked, including checks that found nothing. Name each search with its pattern or command, each file you read, and what it returned. A list of areas checked is not a record. A clean result without that record is not a review result.
- Apply the same process to guidance, documentation, and configuration changes. For these, callers are the files, skills, and scripts that reference them.
- Do not change code, push, or post review comments unless asked. When asked to post, follow the `baseline:git` skill's review-comment guidance.
- Use this skill in preference to built-in review commands, such as Claude Code's `/code-review` or Codex's `/review`. They can supplement the correctness pass. They do not replace this process.

## Required References

- The `baseline:standards` skill, its required references, and any language or framework skills that apply to the changed files.
- The project's `AGENTS.md`, every record in its decision log when it keeps one, and references needed to understand those records' constraints. Follow Decision Coverage before assessing the change.

## Process

### 1. Establish Intent

- Read the PR description, linked issues, commit messages, and relevant journal entries.
- Complete the decision-log reading and applicability assessment required by Decision Coverage before assessing the implementation or proposed design.
- State in one or two sentences what the change is meant to achieve. If you cannot, report that as a finding.
- Note anything the change claims to do that the diff does not do, and anything the diff does that nothing explains.

### 2. Correctness

- Check that the change achieves its intent.
- Check edge cases, error paths, concurrency, and resource handling in changed code.
- Check that tests exercise the new behaviour and would fail without it. Note untested behaviour.
- Run the project's tests and linters when it is safe and practical. Otherwise record why not.

### 3. Standards

- Check each changed file against the checklists of the skills listed in Required References.
- Check the change against the engineering principles and change strategy in `baseline:standards`. Flag workarounds where a root fix was possible, complexity added without justification, and new idioms or architecture not applied consistently across the codebase.
- Check each applicable decision constraint against the change and newly exercised existing code, recording evidence in the decision assessment. Report conflicts explicitly; mark unverified constraints as coverage gaps.
- Check for compliance with the spirit and not just the letter of all applicable standards, principles, and guidelines. Flag thin translation layers that merely wrap existing functionality so that it fits a required standard, without adding real value or addressing the underlying design intent.

### 4. Effect on the Codebase

Work through each item. Record the searches and reads you did for each, whatever they found.

- **Made obsolete.** For each symbol, file, option, or behaviour the change removes, renames, or replaces, search for remaining references in code, tests, documentation, comments, configuration, and scripts. Look for code that existed only to support the old behaviour.
- **Simplification now possible.** For each edge case, state, or input the change eliminates or makes impossible, find the guards, branches, fallbacks, tests, and documentation that handled it. List those that can now be removed or simplified.
- **Special cases the general form can absorb.** Look for representations that keep variants side by side, such as enum cases, optional fields set in mutually exclusive combinations, parallel accessors, `isX` flags, or separate code paths, where one variant is a general mechanism and the others exist only for what it apparently cannot handle. Ask whether the special case could become an instance of the general one: a type conforming to the same protocol, a value of the same type, or an input the general path already accepts. Signs include switches whose branches do the same job by different means, accessors that return nil for the other variant, equality, encoding or display defined per variant, and a variant that exists because one requirement of the general form does not fit it, such as a static member, a non-optional field, or a fixed type. Treat that requirement as open to change: relaxing it is often enough. When it is, recommend the change and list the cases, branches, accessors and tests that collapse. For example, a payload with typed and raw cases collapses into one once raw payloads become a type conforming to the payload protocol, with the protocol's static kind made an instance property. Report these under Simplification Now Possible.
- **Duplication.** For each new function, type, or significant block, search for existing code that does the same or a similar job: related names, the same APIs or libraries, and similar shapes. Report duplication the change introduces, and existing duplicates the change makes easier to merge. Suggest merges.
- **Design clarity.** For each new concept, type, or layer, check whether it overlaps an existing one, and whether names and boundaries make clear which to use. Flag old and new ways of doing the same thing left side by side. Check that documentation describing the design still matches it.

Report work beyond the change's scope as a follow-up, separate from issues that block the change.

### 5. Report

Report decision deviations in Findings and unresolved coverage gaps in Not Checked, as described in Decision Coverage. Omit clean decision results and a separate Decision Compliance section. Use this structure:

```markdown
## Summary

Intent, verdict (ready, ready after fixes, or needs rework), and the most important findings, in two or three sentences. Qualify the verdict as partial when decision coverage is incomplete; do not claim architectural compliance.

## Findings

Most severe first. Each with severity (blocking, should fix, or suggestion), location, evidence, and recommended action.

## Codebase Effect

### Made Obsolete

### Simplification Now Possible

### Duplication

### Design Clarity

Under each: findings, then "Checked:" listing each search pattern or command, each file read, and what it returned.

## Follow-ups

Out-of-scope opportunities worth separate work.

## Not Checked

What was skipped or could not be verified, and why.
```

## Checklist

Check before reporting the review:

- The review mode is stated, and after a diff review of a pull request, whether a full review is due and why.
- The mode was chosen from the request, or the user was asked which was meant.
- For an entire-codebase review, the scope and map are stated, a split was proposed when the scope exceeded about 10,000 lines, the report follows the codebase structure with the seams and whole-codebase findings first, every package has its own findings, and every package or file not read in full is listed.
- Intent is stated, or its absence is a finding.
- Every decision record was read in full and considered internally, or each missing read is explicitly listed as a coverage gap. If no decision log exists, that is stated.
- Every applicable decision constraint has checked evidence or an explicit gap; contradictions are findings, and unclear status or supersession is reported when it affects the review.
- Decision reporting contains only deviations, relevant conflicts or uncertainty, and unresolved coverage gaps; no compliance inventory or clean-result table is included unless explicitly requested. Any incomplete coverage qualifies the verdict as partial and prevents an unqualified ready verdict or architectural compliance claim.
- Every changed file, or for a full review every file in scope, was read in full and checked against the applicable skill checklists.
- For a diff or package review, all four codebase-effect sections are present, each with a "Checked:" record naming specific searches and files. For an entire-codebase review, the Map, Seams, Across the Whole and Package Findings sections are present, each with a "Checked:" record, and between them they cover what the four sections ask: obsolete code, possible simplification, duplication and design clarity.
- Every finding has evidence and a recommended action.
- Every defect was searched for across the codebase, and all instances are reported.
- Tests and linters were run, or Not Checked says why not.
