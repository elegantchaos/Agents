# LP1: Language Skills As Plugins

- **Status:** Proposed
- **Depends on:** nothing
- **Sources:** [Decision log](../journal/2026-11-05-decision-log.md), [Decision 0002](../decisions/0002-language-skills-and-plugins.md), [Shared skills](../../README.md#shared-skills)

## Finish Condition

The JavaScript, Python and Ruby skills are packaged as language plugins, installed by `agt refresh` in both runtimes, and the README and any affected decision describe the new arrangement.

## Notes

Inspect ownership and migration details first: the skills are independently maintained submodules today. Existing submodules and runtime links stay in use until the migration lands. Split by language if one PR is too large.
