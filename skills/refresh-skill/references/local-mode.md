# Local Project Pass

Use the local project pass after the global pass when refreshing one project's `AGENTS.md`.

## Shared Inputs

Resolve shared guidance from the team's shared agents repository:

- `~/.local/share/agents/COMMON.md`
- relevant shared skills under `~/.local/share/agents/skills/`

Required working inputs:

- target project repository
- target project's existing `AGENTS.md`, if present
- repo evidence for project identity and stack detection, such as `README*`, package metadata, manifests, and top-level docs

## Target Output

Produce a compact, project-targeted `AGENTS.md` with exactly these sections:

- `Project Specific Rules`
- `Standard Rules`
- `Skills`

When inserting shared references into the `Skills` section:

- use skill names, not explicit file paths
- use plain text, not markdown links

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
- Read `~/.local/share/agents/COMMON.md`, so restated baseline rules in an existing `AGENTS.md` can be recognised.
- Read the shared skill instructions relevant to the detected stack and workflows when the shared baseline delegates detailed guidance to those skills.
- Detect technologies in use from repo evidence such as `.swift`, `Package.swift`, `.xcodeproj`, `pyproject.toml`, `requirements*.txt`, `package.json`, and `tsconfig.json`.

### Write `Project Specific Rules`

If `AGENTS.md` already exists:

- Retain project-specific policies, constraints, architecture notes, and workflows at the top.
- Remove or rewrite only clearly obsolete or contradictory local rules.

If `AGENTS.md` does not exist:

- Start `Project Specific Rules` with exactly two bullets by default.
- Make the first bullet a concise, durable statement of what the repository is for.
- Derive the first bullet from current repo evidence such as `README*`, package metadata, manifests, or top-level docs.
- Keep the first bullet short and factual.
- Make the second bullet exactly: "Keep a development journal in `Extras/Journal/`."
- Do not add other extra bullets unless the user explicitly asks for them.

### Write `Standard Rules`

`Standard Rules` references the shared baseline instead of restating it. The section contains exactly this line and nothing else:

```markdown
Read and follow @~/.local/share/agents/COMMON.md before starting work.
```

- Write the line as plain text, never inside backticks or a code block. Claude Code expands a bare `@path` as an import when it loads `AGENTS.md`; Codex and other agents read it as an instruction to open the file.
- When an existing `AGENTS.md` restates baseline rules from `COMMON.md`, replace them with the import line.
- When an existing restated rule is genuine repository policy that goes beyond the baseline, move it to `Project Specific Rules` instead of dropping it.
- When an existing `AGENTS.md` keeps a journal or decision log, in any section, keep it enabled with the matching opt-in bullet from the `Project Records` section of `COMMON.md` in `Project Specific Rules`.
- Do not add stack-specific, skill-owned, or workflow rules to this section; they belong in `Skills` or, for explicit repository overrides, in `Project Specific Rules`.

### Write `Skills`

- For software repositories, include `coding-standards` by default.
- For Swift repositories, include `swift:language` by default (from the `swift` plugin in this repository).
- For JavaScript or TypeScript repositories, include `javascript` by default.
- For Python repositories, include `python` by default.
- Refer to shared skills by name (using backticks - eg `my-skill`) when they are available in the current environment. If a required skill is unavailable, preserve the equivalent baseline guidance directly in `AGENTS.md` instead of emitting a dead reference.
- Add one bullet per shared skill that is in scope for the project.
- Use an imperative instruction for each bullet, such as "Use the `codex-git` skill for git operations." or "Follow the `coding-standards` skill for all coding."
- Include only the skills relevant to the detected stack and workflows.
- Treat each referenced skill or shared guide as the source of truth for that domain.
- If the repository intentionally overrides a referenced skill or shared guide, state that override explicitly in `Project Specific Rules`.

### Offer a Decision Log

Make this offer only on a project's first refresh under the current contract: when `AGENTS.md` is missing, or its `Standard Rules` is not yet the `COMMON.md` import line. Skip it when the project already keeps a decision log.

- Ask whether to enable a decision log and backfill it.
- If the user agrees, add the decision-log opt-in bullet to `Project Specific Rules`.
- To backfill, gather candidate decisions already established in the project, from design documents, the journal, `README*`, and the code's structure and dependencies. Present them as a short list, each with a one-line summary and its evidence.
- Record only the candidates the user confirms, following the `Decisions` rules in `COMMON.md`. List unconfirmed or still-emerging candidates as deferred in a journal entry when the project keeps a journal; otherwise report them.
- If the user declines, do not ask again on later refreshes.

### Finish

- At the bottom of `AGENTS.md`, add "To refresh this file, use the `refresh` skill."
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

- `Standard Rules` contains exactly the `COMMON.md` import line, as plain text outside backticks and code blocks.
- No other part of `AGENTS.md` restates rules owned by `COMMON.md`.
- No `Project Specific Rules` bullet weakens or contradicts `COMMON.md` unless it is stated as an explicit repository override.
- Explicit skill references appear only under `Skills`, apart from the regeneration note.
- The repository has no `CLAUDE.md`, `.claude/CLAUDE.md`, or `CLAUDE.local.md`. Any of these stops Claude Code reading `AGENTS.md` by default. Never create one; if one exists, report it and ask whether to remove it or fold its content into `AGENTS.md`.

## Softened Requirement Phrases

Remove softening phrases from mandatory clauses in `Project Specific Rules` and `Skills`. For example:

- `when practical`
- `where feasible`
- `if possible`
- `try to`
- `ideally`
