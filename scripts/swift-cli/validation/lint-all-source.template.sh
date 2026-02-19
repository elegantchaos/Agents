#!/bin/bash
# Purpose: Lint Swift source trees with swift-format.
# Usage: ./lint-all-source
#
# Copy into a repo and adjust TARGET_DIRS if needed.

set -euo pipefail

TARGET_DIRS=(
  Source
  Tests
)

for dir in "${TARGET_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    swift format lint --recursive --strict "$dir"
  fi
done
