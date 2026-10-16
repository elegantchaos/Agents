# Draft Release Workflow

## Rules

- Draft releases must target `main` unless the user explicitly asks for another target.
- Generate notes from the verified commit range, then improve them before creating the draft.
- Leave the release in draft state unless the user explicitly asks to publish it.
- Treat draft release URLs with an `untagged-...` slug as normal GitHub behavior. Do not call it out unless the release metadata is wrong.
- Use release tags in `vX.Y.Z` form.
- Derive the release title by removing the leading `v` and, when the version ends in `.0`, dropping only the trailing third component: `v1.2.3` becomes `1.2.3`; `v2.0.0` becomes `2.0`.

## Workflow

1. Resolve the release tag, derived title, previous tag, and intended target. Resolve the target to a commit SHA and verify the notes' starting and ending commits.
2. Inspect remote state before creating or updating the draft.
   - Verify that an existing remote tag resolves to the intended commit. If it differs, stop and report the mismatch; do not move the tag automatically.
   - If the authorized workflow requires publishing a branch or tag, push it and verify the remote commit before proceeding. An already-published target requires no redundant push.
3. Generate notes using repository release tooling when available, such as `rt changes` for projects using ReleaseTools. Otherwise derive them from the verified commit range.
   - Write notes safely as UTF-8 with real newlines using file tools, a quoted heredoc, or a proper argument API that avoids shell interpolation.
   - Store notes in the harness-provided scratchpad directory, otherwise `<repository>/.build/tmp/`; create the directory if needed. Do not use a system temporary directory.
4. Improve the notes with a concise human-readable opening summary and changes supported by the commit range.
5. Create or update the intended draft.
   - On creation, pass the intended tag and explicit target commit: `gh release create <tag> --draft --target <commit-sha> --title <title> --notes-file <notes-path>`.
   - Add `--verify-tag` when using an existing remote tag. Verify its commit separately; `--target` does not move an existing tag.
   - When creating a new tag through release creation, confirm that tag creation is within the authorized release workflow.
   - For an existing draft, inspect its tag and resolved commit first, then use `gh release edit <tag> --draft --title <title> --notes-file <notes-path>`. Do not assume editing a release retargets its Git tag.
6. Read back the release and verify its tag, title, notes, resolved target commit, and draft state. Report any mismatch before further mutation.
7. Hand off the draft for review. Publish only when explicitly authorized.

## Output Checklist

- Report `new_tag`, `previous_tag`, and the target commit SHA.
- Report the exact commit range used for notes.
- Report the draft release URL.
- Confirm that the release remains in draft state.
