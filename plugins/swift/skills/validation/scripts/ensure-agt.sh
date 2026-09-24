#!/usr/bin/env bash
# Prints the path to the `agt` command, installing AgentTools with Mint if it is missing.
# With --update, also installs the latest AgentTools release (this needs network access).
# Identical copies live in each plugin that needs `agt`; scripts/refresh reports any drift.
set -euo pipefail

# Resolves a command from PATH, falling back to ~/.mint/bin for Mint-installed tools.
resolve() {
  command -v "$1" 2>/dev/null || { [ -x "$HOME/.mint/bin/$1" ] && echo "$HOME/.mint/bin/$1"; } || true
}

agt=$(resolve agt)
if [ -n "$agt" ] && [ "${1:-}" != "--update" ]; then
  echo "$agt"
  exit 0
fi

mint=$(resolve mint)
if [ -z "$mint" ]; then
  if ! command -v brew >/dev/null; then
    echo "agt needs Mint, and Mint needs Homebrew. Install Homebrew (https://brew.sh), then re-run." >&2
    exit 1
  fi
  brew install mint >&2
  mint=$(resolve mint)
fi

"$mint" install elegantchaos/AgentTools >&2
agt=$(resolve agt)
[ -n "$agt" ] || { echo "AgentTools installed, but agt was not found on PATH or in ~/.mint/bin." >&2; exit 1; }
echo "$agt"
