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

- **Diff review.** Reviews a pull request, branch, diff, or completed task. Its correctness audit covers the change, the code the change calls or newly depends on, and existing code the change places in a new context, such as a reusable control it puts in a toolbar for the first time. Defects in that newly exercised code are in scope even though the diff does not touch it. Its Codebase Effect investigation follows the change's consequences across the whole codebase, as Process step 4 describes; it is not limited to changed files or direct callers.
- **Full review.** Reviews a whole package, or an entire codebase with all its packages, reading every source file against every reference of every relevant skill. It finds defects that diff reviews miss because the code that contains them never changes. For a package, follow the same process, applied to the whole package: intent becomes the package's purpose as its documentation states it, and the codebase-effect sections cover the whole package, including dead code, duplication, and documentation that no longer matches the code. An entire-codebase review follows its own method and report, in Reviewing an Entire Codebase, because it is more than the sum of its packages' reviews.

After a diff review of a pull request, assess whether a separate full package review would address a meaningful remaining need. Consult the project's journal for previous coverage, considering unreviewed boundaries, substantial subsequent changes, review age and releases. Package size informs scope and feasibility; it is not by itself a reason to repeat a recent review. Recommend a new full review only when you can name its scope and explain what it would resolve. Put it in Follow-ups as a proposed action, not as an ambiguous offer or an implied prerequisite for this PR. Do not list existing full reviews unless one supplies important context for a finding or recommendation.

Record each full review actually performed in the journal as an entry whose title begins "Full Review", stating the date, each package covered with its path, the commit or release reviewed, and whether coverage was complete or partial, listing what a partial review left out. A package's last full review is the latest complete one that names it; compare its reviewed commit or release with the package's latest release when that affects a recommendation. State uncertainty when it limits the assessment.

### Reviewing an Entire Codebase

A codebase review is not a series of package reviews. Its main subject is how the parts fit together: problems that live between packages, in the seams and across the whole, are invisible to a review of any one package, however thorough. Package reviews are one input to it. Work in this order:

1. **Map the whole.** List every package and target with its source size, and state the scope, including whether dependencies the project owns, such as packages in submodules, are in or out; ask when it is unclear. When the scope has more than about 10,000 lines of source, excluding tests, propose splitting the review before starting, since one session cannot read that much in full without skimming: this session keeps the map, the seams and the whole-codebase passes, and each package's in-depth review runs in a separate session that reports back. Wait for the user's choice. Then map the codebase as it is: each package's role and public API, the actual dependency graph against the architecture the documentation and decisions describe, the concepts that more than one package models, and the code that differs by platform.
2. **Review the seams.** At each package boundary, compare how callers actually use an API with how it was designed. Look for mismatched assumptions, workarounds and adapters in callers, leaky or unused abstractions, responsibilities split across packages or duplicated on both sides, and dependencies that run against the intended direction.
3. **Review across the whole.** Look for what only the whole shows: the same job done in more than one package or for more than one platform; one concept modelled differently in different places; special cases kept beside a general mechanism that could represent them, as described under Simplification now possible in Process step 4; cross-cutting concerns, such as error handling, logging, concurrency and isolation, observation, localization and test helpers, handled inconsistently; standards and idioms applied unevenly; and old and new ways of doing something left side by side.
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

Under each: recommended actions first, then conclusions and reasoning about the boundaries and responsibilities examined, supported by specific implementation locations. Use the action-first reporting guidance in Process step 5, including its brief no-action openings. Explain retained distinctions only when they matter to a finding or recommendation; state material coverage limits. Keep detailed search commands and file inventories in working notes unless needed to reproduce a finding.

## Package Findings

### <Package>

Each package's findings, most severe first, with implementation evidence and structural reasoning. A package reviewed in a separate session links or includes that session's report. Keep detailed search commands and file inventories in working notes unless needed to reproduce a finding.

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
- Keep working notes of what you checked, including checks that found nothing: searches and their results, files read, responsibilities traced and the reasoning behind structural conclusions. In the report, give conclusions with implementation evidence and coverage limits; include commands when needed to reproduce a finding. A search inventory alone does not establish a structural conclusion.
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
- Inspect existing validation evidence for the reviewed revision and report its scope, result and any gaps. Do not rerun validation routinely during review. Run a targeted check only when needed to investigate a specific concern or verify evidence that is missing, stale or inconclusive. Full application validation is not a review requirement; the merge workflow owns that gate.

### 3. Standards

- Check each changed file against the checklists of the skills listed in Required References.
- Check the change against the engineering principles and change strategy in `baseline:standards`. Flag workarounds where a root fix was possible, complexity added without justification, and new idioms or architecture not applied consistently across the codebase.
- Check each applicable decision constraint against the change and newly exercised existing code, recording evidence in the decision assessment. Report conflicts explicitly; mark unverified constraints as coverage gaps.
- Check for compliance with the spirit and not just the letter of all applicable standards, principles, and guidelines. Flag thin translation layers that merely wrap existing functionality so that it fits a required standard, without adding real value or addressing the underlying design intent.

### 4. Effect on the Codebase

Answer: **Given this change, what improvements are now unlocked, and what problems are now present elsewhere in the codebase?** This is a change-driven investigation across the whole codebase, including during a diff review. Do not fence it at package boundaries, changed files, direct callers or symbol references, and do not substitute a description of the new code's local design for this investigation.

A full package review has no change to start from, so the package is the subject: ask what its current concepts, responsibilities and assumptions make possible or wrong, inside the package and in the code that relies on it. Apply the rest of this step to those, including dead code, duplication and documentation that no longer matches the code.

Start by identifying the capabilities, representations, constraints, assumptions and ownership the change adds, removes or alters. Search the whole repository for the same concepts, competing mechanisms, special cases and consumers that rely on the old assumptions, even when they share no symbols with the diff. Trace the relevant workflows and boundaries into their implementations: other features, UI surfaces, configuration, persistence, import/export, tests and documentation as applicable. Follow each material consequence until its responsibility and affected consumers are understood; searches locate that code but do not replace reading it.

For each candidate improvement or problem, establish what this change now makes possible or invalid, where the consequence appears, what concrete action would address it, and which constraints justify retaining any distinction. Distinguish a newly unlocked opportunity from an already planned task or unrelated existing defect. Investigate enough to support the recommendation; label unresolved hypotheses and coverage gaps instead of presenting possibilities as findings.

Consider:

- **Made obsolete.** Does the change supersede a concept, representation, responsibility, workflow or architectural boundary? Look for types, protocols, services, packages, configuration and documentation that remain active but whose original purpose has disappeared. Referenced code can still be obsolete: its callers may now be doing unnecessary work. Also check remaining references to removed or renamed symbols and behaviour.
- **Simplification now possible.** What assumptions or capabilities have changed? Could the resulting design use fewer states, representations, layers, dependencies or independently maintained facts? Examine whether types can collapse, ownership can move to one place, special cases can become instances of a general mechanism, or a boundary can disappear. Treat restrictions of the general mechanism as open to examination: a static member, fixed type or non-optional field may be the only reason a special case exists. Explain which distinct responsibilities would remain and why.
- **Duplication.** Look for the same domain rule, state, transformation or orchestration expressed in different places, even under unrelated names or different code structures. Trace who owns each fact and who can change it. Distinguish duplicated knowledge from superficially similar code that serves different contracts. Recommend consolidation only when it produces a clearer owner or shared abstraction.
- **Design clarity.** Can a reader explain where each responsibility belongs and which mechanism to use? Identify competing models, overlapping abstractions, misleading boundaries and documentation that describes a different architecture. Assess whether the change establishes a coherent direction or adds another approach beside the existing ones.

For each material conclusion, explain the relevant design relationship, the implementation evidence and the consequence. For a proposed simplification, describe what would disappear, what would take over its responsibility and which constraints prevent or permit it.

Keep depth proportional to the consequences, not to diff size or physical proximity. This does not require the exhaustive file-by-file audit of a full-codebase review, and that mode's size/splitting gate does not apply merely because the impact search spans the repository. Keep the capability/assumption map, paths traced and rejected opportunities in working notes. Report any material boundary left unexplored and qualify the corresponding conclusion; do not claim a whole-codebase impact assessment from an immediate-caller pass.

Report necessary corrections as findings and independent improvements as follow-ups. Do not manufacture refactoring recommendations to populate these sections.

### 5. Report

Produce one report covering correctness and wider impact, with each problem and recommended fix stated once. Keep correctness defects and their fixes in Findings. Codebase Effect identifies additional structural consequences, newly unlocked improvements or wider problems; it must not repeat Findings or rephrase a local fix as codebase-wide work. Refer to a finding there only when explaining a distinct wider consequence or additional action, making that difference explicit. If no additional consequence was found for a section, use its brief no-action opening rather than filling it with correctness findings.

Write the report primarily to show what needs changing and why. Lead with actionable findings and recommendations; include existing behaviour, prior reviews, settled decisions and completed work only when they are necessary context for a finding, recommendation or material coverage limit. Keep clean checks and detailed inventories in working notes. Do not repeat known follow-ups or planned work as new recommendations unless this review changes their scope, priority or disposition; link the existing destination when needed. Preserve the evidence, validation result and explicit gaps needed to judge the verdict. This applies to every review section, not just follow-ups or codebase effects.

Start each codebase-effect section with the actions recommended for that concern, clearly separated from the supporting assessment. Use a bold **Recommended actions:** label; when there is more than one recommendation, put each in its own Markdown list item beneath the label, with a blank line before the list. A single recommendation can follow the label on the same line. Distinguish fixes needed now from opportunities for later work, and link findings or follow-ups instead of burying recommendations in explanatory prose. When nothing needs doing, open with a brief, section-specific sentence such as **No action needed.**, **No simplifications recommended.**, **No duplication found.** or **No design changes recommended.** Bold the entire no-action opening sentence, just as the recommended-action label is bold. Follow with only the context and evidence needed to justify the assessment; clean sections need no explanatory paragraph by default. Apply this structure to the corresponding whole-codebase sections too; do not invent actions to fill a section.

Report decision deviations in Findings and unresolved coverage gaps in Not Checked, as described in Decision Coverage. Omit clean decision results and a separate Decision Compliance section. In every review mode, distinguish previous validation inspected from checks run during review. Name the revision and scope the evidence covers, and report missing or unverified evidence as a gap; inspecting adequate existing evidence does not require a fresh run. Use this structure:

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

Under each codebase-effect heading, lead with recommended actions or a brief no-action sentence, then give the conclusion and its reasoning, supported by specific implementation locations. For a clean assessment, the brief no-action sentence is sufficient unless context is needed to understand its scope or a related finding. Keep detailed search commands and file inventories in working notes unless they are needed to reproduce a finding. State coverage limits explicitly.

## Follow-ups

Out-of-scope opportunities worth separate work.

## Not Checked

What was skipped or could not be verified, and why.
```

## Checklist

Check before reporting the review:

- The review mode is stated. Any proposed full review names a scope and a concrete remaining need; existing reviews are mentioned only when they supply necessary context.
- The mode was chosen from the request, or the user was asked which was meant.
- For an entire-codebase review, the scope and map are stated, a split was proposed when the scope exceeded about 10,000 lines, the report follows the codebase structure with the seams and whole-codebase findings first, every package has its own findings, and every package or file not read in full is listed.
- Intent is stated, or its absence is a finding.
- Every decision record was read in full and considered internally, or each missing read is explicitly listed as a coverage gap. If no decision log exists, that is stated.
- Every applicable decision constraint has checked evidence or an explicit gap; contradictions are findings, and unclear status or supersession is reported when it affects the review.
- Decision reporting contains only deviations, relevant conflicts or uncertainty, and unresolved coverage gaps; no compliance inventory or clean-result table is included unless explicitly requested. Any incomplete coverage qualifies the verdict as partial and prevents an unqualified ready verdict or architectural compliance claim.
- Every changed file, or for a full review every file in scope, was read in full and checked against the applicable skill checklists.
- The codebase-effect investigation maps changed capabilities and assumptions, searches across the whole codebase and traces their wider consequences beyond direct callers. Recommendations identify what this change unlocks or breaks, the implementation evidence, the action and relevant constraints; unexplored material boundaries are explicit. Local design descriptions and reference inventories do not substitute for this pass. For a full package review, the package's own concepts, responsibilities and assumptions take the place of the change.
- Each codebase-effect section, or corresponding whole-codebase section, opens with recommended actions separated from the assessment, or a brief, bold, section-specific sentence explicitly saying nothing needs doing. Immediate fixes and later opportunities are distinguished.
- One report covers both correctness and wider impact without repeating findings. Every action in Codebase Effect addresses an additional wider consequence or improvement, not the same fix already stated in Findings.
- For a diff or package review, all four codebase-effect sections are present. For an entire-codebase review, the Map, Seams, Across the Whole and Package Findings sections are present. Together they cover obsolete concepts and code, possible simplification, duplication and design clarity, with explicit coverage limits. Every recommendation has implementation evidence and reasoning; a clean section needs only its no-action sentence.
- Every finding has evidence and a recommended action. The report omits known status, clean-check inventories and unchanged plans unless needed to assess a finding, recommendation or material gap.
- Every defect was searched for across the codebase, and all instances are reported.
- Existing validation evidence was assessed for the reviewed revision, with its scope, result and gaps reported separately from any checks run during review. Any new run addresses a specific concern or missing, stale or inconclusive evidence; full application validation is left to the merge workflow.
