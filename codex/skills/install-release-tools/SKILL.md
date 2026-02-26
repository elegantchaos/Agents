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

3. Install or update ReleaseTools:

```bash
mint install elegantchaos/ReleaseTools
```

4. Verify the tool is available:

```bash
mint which rt || command -v rt
```

5. Report:
- whether installation/update succeeded
- the resolved executable path (if available)
- any actionable failure details from Mint output

## Notes

- Prefer idempotent behavior: running `mint install elegantchaos/ReleaseTools` multiple times is acceptable.
- Do not modify shell startup files in this skill. If PATH issues appear, report them and ask the user before making environment changes.
