---
name: validation
description: Run and report a Swift project's formatting, linting, compilation, and test checks using its documented workflow, including ReleaseTools where adopted.
---

# Swift validation

- Discover the repository's canonical validation workflow and required coverage before running checks. Use `rt` where the project adopts ReleaseTools; otherwise use its documented commands.
- Select checks appropriate to the changed targets and project policy. An IDE build does not automatically satisfy formatting, linting, test, or broader platform requirements.
- Keep Xcode tooling conditional on an Xcode project and available tools. Do not require Xcode or install ReleaseTools merely because a project contains Swift.
- Report commands run, passed stages, failures or blockers, skipped checks and reasons, and residual coverage gaps. Partial success is not a full validation pass.
- Correct source failures within the authorized scope and rerun the affected checks. Apply the repository's existing failure-handling policy for external blockers; do not claim an alternative check provides equivalent coverage without evidence.
