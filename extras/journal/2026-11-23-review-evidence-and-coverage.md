# Review Evidence And Coverage

The [shared review skill](../../plugins/baseline/skills/review/SKILL.md) now requires correctness findings to explain what triggers the defect, what happens, and why the impact warrants the assigned severity. The [Codex review rubric](https://github.com/openai/codex/blob/main/codex-rs/prompts/templates/review/rubric.md) informed that wording. [Claude Code's verification pass](https://code.claude.com/docs/en/code-review) informed the guidance for an optional second reviewer. The main reviewer checks and deduplicates those findings before assigning severity and issuing a verdict.

Skill coverage includes relevant references even when they are optional or unlabelled. Full package and codebase reviews still read every reference of each applicable skill. Missing reading or checklist coverage makes the review incomplete and blocks a verdict.

Both baseline manifests advance to 0.8.39 for distribution through the shared installation workflow. The comparison used published workflows and the Codex rubric. Comparative review performance remains unmeasured.
