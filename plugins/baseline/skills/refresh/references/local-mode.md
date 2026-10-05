# Local Project Pass

Use the local project pass after the global pass when refreshing one project's `AGENTS.md`.

## Shared Inputs

Resolve the shared agents content locally at `~/.local/share/agents/`, with https://github.com/elegantchaos/Agents as the fallback when the local content is unavailable.

- Read `COMMON.md` from the resolved content.
- Resolve relevant skills by name from that same content, including skills supplied by plugins.
- When obtaining the repository, include any skill submodules required for the task.
- Report any required guidance that cannot be accessed.

Required working inputs:

- target project repository
- target project's existing `AGENTS.md`, if present
- repo evidence for project identity and stack detection, such as `README*`, package metadata, manifests, source code, and top-level docs

## Target Output

Produce a compact, project-targeted `AGENTS.md` with exactly these sections:

- `Project Specific Rules`
- `Standard Rules`

Use `../assets/AGENTS.md` as the canonical output template. Replace only `{{PROJECT_SPECIFIC_RULES}}` and `{{SKILL_BULLETS}}`; preserve all other bytes, including headings, numbering, wording, blank lines, and the final newline. For an existing project, retain its project-specific block verbatim, allowing the structural-migration exception below. The skill list is selected for the project.

When inserting skill references into `Standard Rules`:

- use skill names, not explicit file paths
- use backticks around skill names, not markdown links

## Path Conventions

- Use raw home-relative `~/...` paths when referring to canonical shared resources under `~/.local/share/agents/`.
- Use repository-relative paths only for files that are expected to exist inside the target repository.
- Do not emit absolute machine-specific paths such as `/Users/<name>/...` or `/home/<name>/...` in generated `AGENTS.md` files.
- Do not rely on the current working directory to resolve canonical shared resources in generated guidance.
- Keep one canonical path form per resource family to avoid multiple resolution models.

## Workflow

### Load Context

- Detect whether the target repository already has an `AGENTS.md`.
- If it exists, read it first.
- Read `COMMON.md` from the resolved shared content, so restated baseline rules in an existing `AGENTS.md` can be recognised.
- Read the shared skill instructions relevant to the detected stack and workflows when the shared baseline delegates detailed guidance to those skills.
- Detect technologies in use from repo evidence such as `.swift`, `Package.swift`, `.xcodeproj`, `pyproject.toml`, `requirements*.txt`, `package.json`, and `tsconfig.json`.

### Write `Project Specific Rules`

If `AGENTS.md` already exists:

- Retain the contents of `Project Specific Rules` verbatim, including its purpose statement, policies, constraints, architecture notes, workflows, and record opt-ins.
- During structural migration, relocate existing repository policies and record opt-ins into `Project Specific Rules`, preserving their wording and meaning. This may extend the block while retaining its existing prose verbatim.
- Policy changes require explicit user instruction. Additional project-record opt-ins require user agreement. Flag suspected obsolete or contradictory policies for review.

If `AGENTS.md` does not exist:

- Start `Project Specific Rules` with exactly two bullets by default.
- Make the first bullet a concise, durable statement of what the repository is for.
- Derive the first bullet from current repo evidence such as `README*`, package metadata, manifests, or top-level docs.
- Keep the first bullet short and factual.
- Make the second bullet exactly: "Keep a development journal in `Extras/Journal/`."
- Do not add other extra bullets unless the user explicitly asks for them.

### Write `Standard Rules`

Render `Standard Rules` from `../assets/AGENTS.md` verbatim, substituting only its skill-list placeholder. The template is the single source of truth for the seven numbered instructions and regeneration note. Agents resolve the shared content before reading COMMON.md. Rule 2's `@~/.local/share/agents/COMMON.md` is written without backticks so that Claude Code imports the file at launch; keep it that way.

- Replace restated baseline rules with the numbered instructions.
- Move genuine repository policy that goes beyond the baseline to `Project Specific Rules`.
- Relocate existing journal and decision-log opt-ins from other sections into `Project Specific Rules`, preserving their wording and meaning. Use the matching bullets from `COMMON.md` for newly agreed opt-ins.
- Move existing skill selections from a separate `Skills` section into `Standard Rules`; remove the separate heading.

### Select Skill Bullets

- For software repositories, include `baseline:standards` by default.
- For Swift repositories, include `swift:language` by default for all Swift code.
- For JavaScript or TypeScript repositories, include `javascript` by default.
- For Python repositories, include `python` by default.
- Refer to shared skills by name in backticks. Resolve them from the shared content even when they are absent from the current runtime's available-skills list. Report a required skill that cannot be found; do not emit a dead reference or copy its instructions into AGENTS.md.
- Add one imperative bullet per relevant skill. Use these exact bullets when applicable:
  - Follow the `baseline:standards` skill for all coding.
  - Use the `baseline:records` skill for the development journal and decision log.
  - Use the `codex-git` skill for git and GitHub operations.
  - Use the `swift:language` skill for all Swift code.
  - Also use the `swift:swiftui` skill for SwiftUI code.
  - Also use the `swift:testing` skill for Swift Testing work.
  - Also use the `swift:concurrency` skill for actor isolation and shared mutable state.
- Adapt only the record types in the `baseline:records` bullet if the project enables just one.
- Include `baseline:records` when project records are enabled and `codex-git` when the project uses git. Keep the order above for applicable entries; add other project-relevant skills with similarly direct wording.
- Select skills based on the repository's stack and workflows. Give each selected skill its full domain scope; do not restrict it to the current integration or implementation detail that established its relevance.
- Include `swift:swiftui` for Swift projects with user interface work or SwiftUI integration. Its instruction covers all SwiftUI code, including future UI work.
- Prefer "Also use" for additive skills: specialist guidance supplements the language or baseline skill. Keep the base skill instruction broad, such as "for all Swift code".
- Treat each referenced skill as the source of truth for its domain. State intentional repository overrides in `Project Specific Rules`.

### Offer a Decision Log

Make this offer only on a project's first adoption of the shared baseline: when `AGENTS.md` is missing, or it has neither the previous COMMON.md import line nor the new numbered instructions. Migrating from the previous format alone does not trigger another offer. Skip it when the project already keeps a decision log or the user has already declined.

- Ask whether to enable a decision log and backfill it.
- If the user agrees, add the decision-log opt-in bullet to `Project Specific Rules`.
- Backfill the log with the `baseline:records` skill.
- If the user declines, do not ask again on later refreshes.

### Finish

- Keep the regeneration note from the template unchanged at the bottom of `AGENTS.md`.
- Run the Baseline Verification checks below.
- Lint for softened requirement language in mandatory clauses.

## Fresh File Rules

For fresh-file creation, do not put any of the following into `Project Specific Rules`:

- platform versions
- folder layout
- formatter or linter choices
- test framework
- CI details
- current architecture or implementation style
- concurrency settings
- API design preferences
- paths to shared references or shared skills
- validation workflow
- git or GitHub workflow rules
- stack detection evidence

Good sentence patterns:

- `This repository is a <project type> for <project purpose>.`
- `This repository contains <product/system> for <purpose>.`
- `This repository is the <library/service/app/tool> that <does X>.`

## Baseline Verification

Verify that:

- The file has exactly the two required sections and no separate `Skills` section.
- The output matches `../assets/AGENTS.md` byte for byte after substituting the two placeholders.
- Existing project-specific prose is unchanged except for explicitly requested policy changes. Structural migration may relocate existing policies and record opt-ins into `Project Specific Rules` without changing their wording or meaning. Skill selection varies with the detected stack and workflows.
- `Standard Rules` contains the template's seven numbered instructions outside a code block, followed by project-relevant skill bullets.
- Skill names resolve from the shared content, including plugin-provided skills; report any missing required guidance.
- Skill bullets cover their domain without restrictions based only on the current implementation.
- No other part of `AGENTS.md` restates rules owned by `COMMON.md`.
- No `Project Specific Rules` bullet weakens or contradicts `COMMON.md` unless it is stated as an explicit repository override.
- Explicit skill references appear only under `Standard Rules`, apart from the regeneration note.
- The repository has no `CLAUDE.md`, `.claude/CLAUDE.md`, or `CLAUDE.local.md`. Any of these stops Claude Code reading `AGENTS.md` by default. Never create one; if one exists, report it and ask whether to remove it or fold its content into `AGENTS.md`.

## Softened Requirement Phrases

Remove softening phrases from mandatory clauses in `Project Specific Rules` and `Standard Rules`. For example:

- `when practical`
- `where feasible`
- `if possible`
- `try to`
- `ideally`
