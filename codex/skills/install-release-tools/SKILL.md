---
name: install-release-tools
description: Install or update ElegantChaos ReleaseTools so the `rt` command is available via Mint. Use when a user asks to install, reinstall, refresh, or update ReleaseTools/`rt`, or when release automation depends on `rt` being present.
---

# Install Release Tools

Run Mint to install or update ReleaseTools and confirm that `rt` is available.

## Workflow

1. Check whether `mint` exists:

```bash
which mint
```

2. If `mint` is missing, stop and tell the user Mint is required before installing ReleaseTools.

3. Check whether `rt` is already installed and capture its current version/path (if present):

```bash
which rt
rt --version
```

4. If `which rt` resolves outside `$HOME/.mint/bin`, treat it as a non-Mint install and stop with:
- `ReleaseTools <version> installed (not via Mint).`

5. Otherwise (missing, or found in `$HOME/.mint/bin`), install or update ReleaseTools:

```bash
mint install ReleaseTools
```

6. Capture the resolved executable path and post-install version:

```bash
which rt
rt --version
```

7. Emit exactly one final status line, using this decision logic:
- If ReleaseTools was not installed before step 5 and is installed after step 6:
  `ReleaseTools <version> installed.`
- If ReleaseTools was installed before step 5 from `$HOME/.mint/bin` and the version changed after step 6:
  `ReleaseTools <old_version> updated to <new_version>.`
- If ReleaseTools was installed before step 5 from `$HOME/.mint/bin` and the version is unchanged after step 6:
  `ReleaseTools <version> already installed.`
- If ReleaseTools was installed before step 5 from outside `$HOME/.mint/bin`:
  `ReleaseTools <version> installed (not via Mint).`

8. If step 5 fails, report actionable Mint error details and do not emit one of the success status lines.

## Notes

- `mint install ReleaseTools` is the canonical command for both install and update.
- Use `which rt` (not `mint which rt`) to detect whether `rt` is installed at all.
- Parse `<version>` from `rt --version` output (for example, from `ReleaseTools 4.0.1 (1)` use `4.0.1`).
- Determine "via Mint" by checking whether the resolved `rt` path is within `$HOME/.mint/bin`.
- Do not modify shell startup files in this skill. If PATH issues appear, report them and ask the user before making environment changes.
