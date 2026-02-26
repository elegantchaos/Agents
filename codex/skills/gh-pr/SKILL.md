---
name: gh-pr
description: Use this skill when creating or editing GitHub pull requests with gh CLI. It enforces safe PR body handling by always using --body-file, never inline --body.
---

# gh-pr

## Overview

Create and edit GitHub pull requests with gh while avoiding shell interpolation mistakes in markdown bodies.

## Rules

- Always use --body-file for PR descriptions.
- Never use inline --body for multi-line markdown.
- Prefer creating a temporary markdown file, then passing it to gh pr create or gh pr edit.
- After updating body text, verify with gh pr view --json body,url.

## Workflow

1. Build PR body in a file.

Example:
cat > /tmp/pr-body.md <<'BODY_END'
## Summary
- item 1
- item 2

## Validation
- check 1
BODY_END

2. Create PR with body file.

gh pr create \
  --repo <owner/repo> \
  --base <base-branch> \
  --head <head-branch> \
  --title "<title>" \
  --body-file /tmp/pr-body.md

3. If PR exists or body needs correction, edit with body file.

gh pr edit <number> \
  --repo <owner/repo> \
  --body-file /tmp/pr-body.md

4. Verify final text.

gh pr view <number> --repo <owner/repo> --json body,url

## Notes

- Keep PR summaries concise and factual.
- Include explicit validation bullets.
- If shell interpolation risk exists (backticks, $, parentheses), using --body-file avoids command mangling.
