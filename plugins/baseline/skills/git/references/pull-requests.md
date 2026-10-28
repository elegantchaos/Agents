# Pull Request Workflow

## Rules

- Make every change to `main` through a pull request. Keep direct pushes and local merges off `main`.
- Inspect branch protection or rulesets when relevant. Configure them only when requested. Do not require a full-validation status check until CI actually runs it reliably for the repository.
- Before merging, verify that the repository's required full validation passed for the PR's latest commit that changes more than documentation files. Record the result and that commit in the PR. Rerun it after a later commit changes code, tests, configuration or other build inputs; a commit that changes only documentation files, such as guides, journal entries and decision records, does not need it.
- Honor established change scope. Inspect status and the diff, stage explicit paths, and preserve unrelated work. Ask only when ownership or intended scope is ambiguous; do not default to `git add -A` in a mixed tree.
- Push the intended head before creating a PR or publishing new commits. Editing only a PR title or body does not require a push.
- If a required push fails, stop the dependent PR operation and report the exact push error.
- Default new PRs to ready for review: normally a PR is opened when the work is ready to enter review. Use a draft only when explicitly opening the PR early for incomplete work or when the user requests a draft.

## Workflow

1. Resolve the repository, head branch, base branch, and authorized change scope.
2. Inspect divergence from the intended base. Integrate the base when needed for authorized work; being behind alone does not require an unsolicited pull.
3. When publishing commits, validate and push the intended head. Confirm the branch before pushing when needed.
4. Write a concise, factual description explaining the change and its purpose, with explicit validation results and gaps.
   - Use a structured body argument when a suitable connector supports the operation.
   - For `gh pr create` or `gh pr edit`, write the body safely to a UTF-8 file with real newlines and pass `--body-file`. Do not use inline `--body` for multiline Markdown.
   - Use file tools, a quoted heredoc, or a proper argument API to create the file without interpolating backticks, dollar signs, or command substitutions. `--body-file` does not make an unsafe file-writing command safe.
   - Store the file in the harness-provided scratchpad directory, otherwise `<repository>/.build/tmp/`. Create the directory if needed; do not use a system temporary directory.
5. Create a ready-for-review PR, using a draft only for the exceptions above, or edit the intended PR using the selected interface.
6. Read back the final remote title, body, URL and draft state through the connector or `gh pr view --json title,body,url,isDraft`. Verify content, line breaks and the intended readiness state.
