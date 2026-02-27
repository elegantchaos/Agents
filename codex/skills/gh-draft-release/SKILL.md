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

2. Generate release notes with `rt changes`.
- Run from the repository root:
  - `rt changes --end <target> > /tmp/<new_tag>-notes.md`
  - use `rt changes --help` for options to customize the output.
  - do not use the `--summary` flag, as the notes will be improved with LLM in the next step. 
- The command auto-detects the previous tag when `--start` is omitted.

3. Impove the generated notes with LLM.
- Update the generated notes file. 
- It should begin with a human friendly paragraph summarising key changes.

4. Create or update a draft release with `gh`.
- Create draft release:
  - `gh release create <new_tag> --target <target> --draft --title "<new_tag>" --notes-file /tmp/<new_tag>-notes.md`
- If release already exists, update it:
  - `gh release edit <new_tag> --draft --title "<new_tag>" --notes-file /tmp/<new_tag>-notes.md`

5. Hand off for manual review/publish.
- Report the draft release URL.
- Explicitly state that publishing is left for manual user review.
- Do not run publish commands unless the user explicitly asks.

## Output Checklist

- Provide chosen `new_tag`, `previous_tag`, and `target`.
- Provide the exact commit range used for notes.
- Provide the draft release URL.
- Confirm the release remains in draft state.
