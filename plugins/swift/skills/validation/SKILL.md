---
name: validation
description: Run tests, formatting and validation for Swift repositories that use AgentTools (`agt format` and `agt validate`, formerly ReleaseTools' `rt validate`). Use whenever tests need to run, including the failing and passing steps of red/green TDD, and when code has been changed. It reformats code, runs linters, builds relevant targets, and executes tests to ensure code quality and functionality.
---

# Swift Validation

Run tests, formatting and validation for Swift repositories through AgentTools.

Read `references/workflow.md` before running validation.

## Scope

Use this skill only for Swift repositories that validate with `agt validate`, or with the deprecated `rt validate` it replaces.

Do not use it for Python, Ruby, JavaScript, or other non-Swift projects unless that project explicitly adopts `agt validate` as its validation command. Use the repository's documented language-specific validation workflow instead.

## Use This Skill When

- tests need to run during development, including each red and green step of TDD
- code has changed in a Swift repository that uses `agt validate` or `rt validate`
- you need a standard narrow-to-broad validation pass
- you need consistent reporting for passed, failed, or skipped validation

## Workflow

1. Run commands from the repository root.
2. Get `agt` with this skill's `scripts/ensure-agt.sh`, as described in `references/workflow.md`.
3. Follow the Swift validation workflow in `references/workflow.md`.
   Run every test through `agt validate`, using `--target` for a single target; never run `swift test` or `xcodebuild` directly.
4. After `agt format`, read its lint findings. It reports PASS even when it finds problems; fix every finding in files you changed before validating.
5. Report results using the output rules in `references/workflow.md`.

## References

- `references/workflow.md`: getting `agt`, command list, targeted test runs, format-then-validate workflow, and output checklist
