# Global Pass

Use the global pass before refreshing a project `AGENTS.md`.
It updates and verifies the shared agents infrastructure itself.

## Scope

- Shared agents repository lives at `~/.local/share/agents`.
- Shared canonical rules live in `~/.local/share/agents/codex/rules/*.rules`.
- Shared canonical baseline guidance lives in `~/.local/share/agents/COMMON.md`.
- Published shared skill submodules live under `~/.local/share/agents/skills/`.
- Repo-local operational skills live under `~/.local/share/agents/skills/` as normal tracked files when they are tightly coupled to this repository.
- The `~/.local/share/agents/scripts/agent-tools` SwiftPM command-line tool manages public skill maintenance.
- Local runtime rules live in `<codex-home>/rules/*.rules`.
- Runtime skill links live under `~/.agents/skills/`.
- `default.rules` is a catch-all and should stay small. It may be empty.

## Path Conventions

- Use raw home-relative `~/...` paths when referring to canonical shared resources under `~/.local/share/agents/`.
- Do not use absolute machine-specific paths such as `/Users/<name>/...` or `/home/<name>/...` in shared guidance, skills, rules, or maintenance docs.
- Do not rely on the current working directory to resolve canonical shared resources.
- Keep one canonical path form per resource family to avoid multiple resolution models.
- When editing shared docs, skills, or rules, update stale path references in the same change.
- If a workflow depends on a standard installation location, state that location explicitly.

## Decision Rules

Promote a rule into a shared `*.rules` file when all of the following are true:

- it authorizes a reusable command family rather than a one-off task
- it is not tied to a specific repository, branch, PR, issue, URL, path, or local history
- it would still make sense on another machine or in another repository using the same tool

Keep or leave a rule in `default.rules` only when it is genuinely not general enough for a shared file and is not safe to discard.

Remove a rule entirely when it is:

- already covered by an existing shared prefix
- tied to absolute machine paths or hardcoded working directories
- specific to one repository, PR, issue, release, URL, search query, JSON filter, or shell body
- a one-off cleanup, recovery, polling, or migration command that does not represent a reusable approval

## Rule Classification

Classify reusable rules by command family:

- `git ...` -> `git.rules`
- `gh ...` -> `github.rules`
- `swift ...` -> `swift.rules`
- `xcodebuild ...` and related Apple build or simulator inspection commands -> `xcode.rules`
- reusable tool wrappers and shared helper CLIs -> `tools.rules`
- non-destructive shell helpers and simple polling helpers -> `misc.rules`

If a command family appears repeatedly and does not fit an existing file cleanly, suggest a new shared rule file rather than stuffing unrelated rules into `default.rules`.

## Workflow

1. Update the shared agents repository.
   - Inspect current git status before pulling.
   - If the shared repository has local changes, do not overwrite them.
   - Pull the configured upstream when safe or when explicitly requested.
   - Report if the repository could not be updated.
2. Refresh public skill submodules and runtime links from the shared agents repository root.
   - Run `swift run agent-tools skills sync --all`.
   - Run `swift run agent-tools skills link`.
   - Run `swift run agent-tools skills status`.
   - Run `swift run agent-tools skills audit --all` for publication readiness, major edits, or explicit audit requests.
   - If the user asked to advance skills to latest upstream commits, fetch/pull each relevant submodule safely, validate, and update the parent repository's submodule pointers.
   - Otherwise, sync to the revisions recorded by the parent repository and report any upstream drift from status.
3. Read shared `~/.local/share/agents/codex/rules/*.rules`.
4. Read `<codex-home>/rules/default.rules` and any runtime `*.rules` files that are not symlinks to shared files.
5. Classify each entry in `default.rules`.
   - promote reusable entries into the correct shared rule file
   - remove entries already covered by shared prefixes
   - remove clearly one-off or machine-specific entries
   - keep only genuine leftovers
6. Sort each shared rule file lexicographically and remove duplicates within and across shared files.
7. Ensure every shared `*.rules` file has a symlink in `<codex-home>/rules/` pointing to `~/.local/share/agents/codex/rules/<name>.rules`.
8. Rewrite `default.rules` with only the remaining leftovers. If none remain, leave it empty.
9. Review the shared agents repository for worthwhile improvements to:
   - workflows and maintenance procedures
   - shared scripts and automation helpers
   - published skills and skill boundaries
   - shared principles and baseline guidance
   - the markdown files at the top level of `~/.local/share/agents/`, especially `COMMON.md`
10. Base those suggestions on:

- current industry practice and established engineering guidance
- observed user behavior and repeated requests
- common patterns in code and repositories the user has been working with recently
- new language, tooling, framework, or platform features
- recurring friction seen in prior rule approvals, scripts, or skill usage

11. Verify the resulting shared files, runtime symlinks, final `default.rules` state, public skill status, and any concrete repo changes you make.

## Verification

Check all of the following before finishing:

- shared agents repository update status is known
- public skill submodules are initialized to the intended revisions
- runtime skill symlinks match discovered skill names
- no stale runtime link remains for retired maintenance skills
- no duplicate entries remain within or across shared rule files
- each shared rule file has a corresponding runtime symlink
- `default.rules` contains no entries already covered by shared prefixes
- `default.rules` contains no obviously machine-specific or one-off entries
- any suggested workflow or guidance changes are tied to concrete evidence or current best practice, not generic preference
