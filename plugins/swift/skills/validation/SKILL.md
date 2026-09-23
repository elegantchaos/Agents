---
name: validation
description: Run standard post-change validation for Swift repositories that use ReleaseTools. Use when code has been changed. It reformats code, runs linters, builds relevant targets, and executes tests to ensure code quality and functionality.
---

# Swift Validation

Run standard ReleaseTools validation for Swift repositories.

Read `references/workflow.md` before running validation.

## Scope

Use this skill only for Swift repositories that use ReleaseTools and `rt validate`.

Do not use it for Python, Ruby, JavaScript, or other non-Swift projects unless that project explicitly adopts `rt validate` as its validation command. Use the repository's documented language-specific validation workflow instead.

## Use This Skill When

- code has changed in a Swift repository that uses `rt validate`
- you need a standard narrow-to-broad validation pass
- you need consistent reporting for passed, failed, or skipped validation

## Workflow

1. Run commands from the repository root.
2. If `rt` is missing, ask the user to install ReleaseTools first.
3. Follow the Swift validation workflow in `references/workflow.md`.
4. Report results using the output rules in `references/workflow.md`.

## References

- `references/workflow.md`: command list, targeted-vs-comprehensive workflow, and output checklist
