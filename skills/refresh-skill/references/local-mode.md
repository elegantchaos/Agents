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

1. Load context.
   - Detect whether the target repository already has an `AGENTS.md`.
   - If it exists, read it first.
   - Read `~/.local/share/agents/COMMON.md`.
   - Read the shared skill instructions relevant to the detected stack and workflows when the shared baseline delegates detailed guidance to those skills.
   - Detect technologies in use from repo evidence such as `.swift`, `Package.swift`, `.xcodeproj`, `pyproject.toml`, `requirements*.txt`, `package.json`, and `tsconfig.json`.
2. Write `Project Specific Rules`.
   - If `AGENTS.md` already exists, retain project-specific policies, constraints, architecture notes, and workflows at the top.
   - Remove or rewrite only clearly obsolete or contradictory local rules.
   - If `AGENTS.md` does not exist, start `Project Specific Rules` with exactly one bullet by default.
   - Make that bullet a concise, durable statement of what the repository is for.
   - Derive it from current repo evidence such as `README*`, package metadata, manifests, or top-level docs.
   - Keep it short and factual.
   - Do not add extra bullets unless the user explicitly asks for them.
3. Write `Standard Rules`.
   - Base this section on the shared baseline in `~/.local/share/agents/COMMON.md` and preserve the force of its requirements.
   - Keep this section limited to durable repo-wide obligations and baseline engineering policy.
   - Treat that baseline as minimal, not the home for detailed coding or language guidance.
   - Include its core guidance, including high-level principles, workflow expectations, testing and validation expectations, and safety.
   - Include stack-specific rules here only when they are explicit repository policy that should remain true even if related shared skills or guides change.
   - Prefer concrete, checkable instructions over narrative explanation.
   - Compress for agent ingestion when helpful, but do not weaken meaning.
   - Rewrite shared guidance as direct rules instead of citing local guidance files in this section.
   - Do not mention skills, skill names, or raw `~/...` guidance paths directly in this section.
   - Do not restate procedural, stylistic, framework-specific, language-specific, or workflow-specific guidance that is owned by a referenced skill or shared guide.
   - If a rule would need to change when a referenced skill changes, it belongs in `Skills`, not `Standard Rules`.
   - `Standard Rules` must not silently narrow, pin, or override guidance delegated to `Skills`.
4. Write `Skills`.
   - For software repositories, include `coding-standards` by default.
   - For Swift repositories, include `swift` by default.
   - For JavaScript or TypeScript repositories, include `javascript` by default.
   - For Python repositories, include `python` by default.
   - Refer to shared skills by name when they are available in the current environment. If a required skill is unavailable, preserve the equivalent baseline guidance directly in `AGENTS.md` instead of emitting a dead reference.
   - Add one bullet per shared skill that is in scope for the project.
   - Use an imperative instruction for each bullet, such as `Use the codex-git skill for git operations.` or `Follow the swiftui-pro skill for SwiftUI guidance.`
   - Include only the skills relevant to the detected stack and workflows.
   - Treat each referenced skill or shared guide as the source of truth for that domain.
   - If the repository intentionally overrides a referenced skill or shared guide, state that override explicitly in `Project Specific Rules`.
5. Add the regeneration note.
   - At the bottom of `AGENTS.md`, add `To refresh this file, use the refresh skill.`
6. Verify baseline requirements.
7. Lint for softened requirement language in mandatory clauses.

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

Verify that these clauses remain present in `Standard Rules` with equivalent force:

- testing: red/green TDD for non-UI code
- UI expectation: create previews for UI code
- validation discipline: follow the validation workflow and report skipped checks
- safety: do not perform destructive actions without explicit approval
- safety: if unexpected workspace changes appear, pause and confirm direction
- source quality: prefer trusted primary sources for technical decisions

If any required clause is intentionally omitted, record the rationale in the final response.

Also verify that `Standard Rules` does not contain explicit skill references or raw `~/...` guidance paths, and that those explicit references appear under `Skills` instead.

Also verify that each `Standard Rules` bullet is either baseline policy or durable repository policy, and that no `Standard Rules` bullet would need rewriting solely because an in-scope skill changed.

## Softened Requirement Phrases

Rewrite these phrases out of mandatory clauses unless the source baseline explicitly uses them:

- `when practical`
- `where feasible`
- `if possible`
- `try to`
- `ideally`
