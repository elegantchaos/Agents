---
name: gh-draft-release
description: Create GitHub draft releases with notes derived from commit history between the new release tag and the previous tag. Use when the user asks to prepare or draft a release (not publish it), especially when they want release notes generated from commits.
---

# GH Draft Release

Create a draft GitHub release and stop before publishing.

## Workflow

1. Confirm release inputs.
- Determine the new release tag (for example `v2.1.0`).
- Determine the target branch/commit (default to `main` unless the user specifies otherwise).

2. Generate release notes with the bundled Swift script.
- Run from the repository root:
  - `swift ~/.codex/skills/gh-draft-release/scripts/generate_release_notes.swift --new-tag <new_tag> --target <target> --output /tmp/<new_tag>-notes.md`
- Optional flags:
  - `--previous-tag <tag>` to force a specific previous release point
  - `--include-merges` to include merge commits
- The script auto-detects the previous tag using `git tag --sort=-v:refname` when `--previous-tag` is omitted.

3. Create or update a draft release with `gh`.
- Create draft release:
  - `gh release create <new_tag> --target <target> --draft --title "<new_tag>" --notes-file /tmp/<new_tag>-notes.md`
- If release already exists, update it:
  - `gh release edit <new_tag> --draft --title "<new_tag>" --notes-file /tmp/<new_tag>-notes.md`

4. Hand off for manual review/publish.
- Report the draft release URL.
- Explicitly state that publishing is left for manual user review.
- Do not run publish commands unless the user explicitly asks.

## Output Checklist

- Provide chosen `new_tag`, `previous_tag`, and `target`.
- Provide the exact commit range used for notes.
- Provide the draft release URL.
- Confirm the release remains in draft state.
