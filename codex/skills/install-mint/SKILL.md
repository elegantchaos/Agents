---
name: install-mint
description: Install or update Mint so the `mint` command is available. Use when a workflow depends on Mint and `which mint` fails, or when a user asks to install, reinstall, refresh, or update Mint.
---

# Install Mint

Install Mint with Homebrew and confirm that `mint` is available.

## Workflow

1. Check whether Homebrew exists:

```bash
which brew
```

2. If Homebrew is missing, stop and tell the user Homebrew is required before installing Mint.

3. Capture pre-install state:

```bash
which mint
mint --version
```

4. Install or update Mint:

```bash
brew install mint
```

5. Capture post-install state:

```bash
which mint
mint --version
```

6. Emit exactly one final status line, using this decision logic:
- If Mint was not installed before step 4 and is installed after step 5:
  `Mint <version> installed.`
- If Mint was installed before step 4 and the version changed after step 5:
  `Mint <old_version> updated to <new_version>.`
- If Mint was installed before step 4 and the version is unchanged after step 5:
  `Mint <version> already installed.`

7. If step 4 fails, report actionable Homebrew error details and do not emit one of the success status lines.

## Notes

- `brew install mint` is the canonical command for both install and update in this workflow.
- Parse `<version>` from `mint --version` output by extracting the version token from the command output.
- Do not modify shell startup files in this skill. If PATH issues appear, report them and ask the user before making environment changes.
