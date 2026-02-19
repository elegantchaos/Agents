#!/bin/bash
# Purpose: Run Swift package tests for one or more local package paths.
# Usage: ./test-all
#
# Copy into a project and customize PACKAGE_PATHS.

set -euo pipefail

PACKAGE_PATHS=(
  "Dependencies/Core"
)

for path in "${PACKAGE_PATHS[@]}"; do
  echo "Testing $path"
  swift test --package-path "$path" --quiet --no-parallel --disable-xctest
done
