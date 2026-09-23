#!/usr/bin/env bash
# Prints the path to the `agt` command, installing AgentTools with Mint first if it is missing.
set -euo pipefail

# Resolves a Mint-installed command from PATH, falling back to ~/.mint/bin.
resolve() {
  command -v "$1" 2>/dev/null || { [ -x "$HOME/.mint/bin/$1" ] && echo "$HOME/.mint/bin/$1"; } || true
}

agt=$(resolve agt)
if [ -z "$agt" ]; then
  mint=$(resolve mint)
  if [ -z "$mint" ]; then
    echo "agt is missing and Mint is not installed. Install Mint (brew install mint), then re-run." >&2
    exit 1
  fi
  "$mint" install elegantchaos/AgentTools >&2
  agt=$(resolve agt)
  [ -n "$agt" ] || { echo "AgentTools installed, but agt was not found on PATH or in ~/.mint/bin." >&2; exit 1; }
fi

echo "$agt"
