# Global Agent Notes

## Pull Request CLI Quoting
- Backticks are allowed in PR titles/bodies, but never pass Markdown with backticks directly in inline `gh pr ... --body "..."` shell arguments.
- For `gh pr create` / `gh pr edit`, use a safe method for rich Markdown bodies:
  - preferred: write body to a temp file and pass `--body-file <path>`
  - alternative: use a single-quoted heredoc (`<<'EOF'`) to prevent shell substitution
- Before executing PR commands, verify the final shell command cannot trigger command substitution from body content.
