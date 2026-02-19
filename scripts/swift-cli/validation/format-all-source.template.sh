#!/bin/bash
# Purpose: Format Swift source trees with swift-format.
# Usage: ./format-all-source
#
# Copy into a repo and adjust TARGET_DIRS if needed.

set -euo pipefail

TARGET_DIRS=(
  Source
  Tests
)

for dir in "${TARGET_DIRS[@]}"; do
  if [ -d "$dir" ]; then
    swift format --recursive --in-place "$dir"
  fi
done
