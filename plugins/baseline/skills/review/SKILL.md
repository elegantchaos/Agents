---
name: review
description: Performs a broad review of a pull request, branch, diff, plan, or another agent's completed work, covering correctness, conformance to our standards, design quality, and the change's effect on the wider codebase. Use when asked to review any of these. Use in preference to built-in review commands, which focus on bugs in the diff.
---

# Review

A review answers three questions:

1. Does the change do what it set out to do, correctly?
2. Does it meet our standards?
3. Is the codebase better for it, and what does it make possible or necessary next?

The third question matters as much as the first two. A change can be correct and compliant and still leave the codebase more confusing, duplicated, or inconsistent. Answering it requires reading beyond the diff.

## Rules

- Review the whole change. Do not stop after the first few findings.
- Read beyond the diff: every changed file in full, the callers of changed code, and sibling code that does similar jobs.
- Back every finding with evidence: a `file:line`, a search result, or a test outcome. Mark findings you could not confirm as unverified.
- When you find a defect, search the whole codebase for other instances of it, including code the change did not touch. Report every instance found.
- Record what you checked, including checks that found nothing. Name each search with its pattern or command, each file you read, and what it returned. A list of areas checked is not a record. A clean result without that record is not a review result.
- Apply the same process to guidance, documentation, and configuration changes. For these, callers are the files, skills, and scripts that reference them.
- Do not change code, push, or post review comments unless asked. When asked to post, follow the `codex-git` skill's review-comment guidance.
- Use this skill in preference to built-in review commands, such as Claude Code's `/code-review` or Codex's `/review`. They can supplement the correctness pass. They do not replace this process.

## Required References

- The `baseline:standards` skill, its required references, and any language or framework skills that apply to the changed files.
- The project's `AGENTS.md`, and its decision log when it keeps one.

## Process

### 1. Establish Intent

- Read the PR description, linked issues, commit messages, and relevant journal entries and decisions.
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
- Check that the change does not conflict with recorded decisions.

### 4. Effect on the Codebase

Work through each item. Record the searches and reads you did for each, whatever they found.

- **Made obsolete.** For each symbol, file, option, or behaviour the change removes, renames, or replaces, search for remaining references in code, tests, documentation, comments, configuration, and scripts. Look for code that existed only to support the old behaviour.
- **Simplification now possible.** For each edge case, state, or input the change eliminates or makes impossible, find the guards, branches, fallbacks, tests, and documentation that handled it. List those that can now be removed or simplified.
- **Duplication.** For each new function, type, or significant block, search for existing code that does the same or a similar job: related names, the same APIs or libraries, and similar shapes. Report duplication the change introduces, and existing duplicates the change makes easier to merge.
- **Design clarity.** For each new concept, type, or layer, check whether it overlaps an existing one, and whether names and boundaries make clear which to use. Flag old and new ways of doing the same thing left side by side. Check that documentation describing the design still matches it.

Report work beyond the change's scope as a follow-up, separate from issues that block the change.

### 5. Report

Use this structure:

```markdown
## Summary

Intent, verdict (ready, ready after fixes, or needs rework), and the most important findings, in two or three sentences.

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

- Intent is stated, or its absence is a finding.
- Every changed file was read in full and checked against the applicable skill checklists.
- All four codebase-effect sections are present, each with a "Checked:" record naming specific searches and files.
- Every finding has evidence and a recommended action.
- Every defect was searched for across the codebase, and all instances are reported.
- Tests and linters were run, or Not Checked says why not.
