---
name: refresh-rules
description: Rationalize Codex rule approvals by moving generic rules out of default.rules into specific shared rule files, removing project-specific default rules, ensuring symlinks from shared rules into ~/.codex/rules, and sorting/de-duplicating rule files.
---

# Refresh Rules

Clean and normalize Codex command approval rules.

## Scope

- Shared canonical rules live in `~/.local/share/agents/codex/rules/*.rules`.
- Local runtime rules live in `~/.codex/rules/*.rules`.
- `default.rules` should contain only non-project-specific leftovers.

## Classification

Move generic rules by command family:

- `git ...` -> `git.rules`
- `gh ...` -> `github.rules`
- `swift ...` -> `swift.rules`
- `xcodebuild ...` -> `xcode.rules`
- Non-destructive shell helpers (for example `cat`, `ls`, `pwd`, `rg`, `which`) -> `misc.rules`

## Project-Specific Rules To Remove From `default.rules`

Treat these as project-specific/one-off and remove them from `~/.codex/rules/default.rules`:

- Any rule containing absolute machine paths (for example `/Users/...`).
- Any `git -C <hardcoded-path> ...` command.
- Hardcoded repository-specific commands (`gh`, `git` etc) with fixed repo IDs, PR numbers, JSON filters, or inline bodies.
- One-off cleanup commands tied to a specific repo history (for example targeted `rm -rf` paths).

## Required Workflow

1. Read shared `~/.local/share/agents/codex/rules/*.rules`. Read any `~/.codex/rules/*.rules` that are not symlinks to shared files. 
2. Extract generic rules from `~/.codex/rules/default.rules` and append them into the correct shared rule file.
3. Remove clearly project-specific entries from `~/.codex/rules/default.rules`.
4. Sort each shared rule file lexicographically and remove duplicates (both within and across files).
5. Ensure every shared `*.rules` file has a symlink in `~/.codex/rules/` pointing to `~/.local/share/agents/codex/rules/<name>.rules`.
6. Verify links and show a concise diff/status summary.

## Commands

Example normalization loop for shared files:

```bash
for f in ~/.local/share/agents/codex/rules/*.rules; do
  sort -u "$f" -o "$f"
done
```

Example duplicate check across shared files:

```bash
cat ~/.local/share/agents/codex/rules/*.rules | sort | uniq -d
```

Example symlink reconciliation:

```bash
mkdir -p ~/.codex/rules
for f in ~/.local/share/agents/codex/rules/*.rules; do
  ln -sfn "$f" "$HOME/.codex/rules/$(basename "$f")"
done
```

## Output Checklist

Report:

- Rules moved (source -> destination file)
- Rules removed from `default.rules` as project-specific
- Sort/de-dup verification result
- Symlink verification result
- Any ambiguous rules that need user confirmation
- Suggested additional rule files (based on command families that appeared multiple times in `default.rules` during classification)
- Potentially risky rules that may need review