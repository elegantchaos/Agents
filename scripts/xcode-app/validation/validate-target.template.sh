#!/bin/bash
# Purpose: Validate a single target by name, preferring Swift package targets before Xcode targets.
# Usage: ./validate-target <target-name>
#
# Copy into a project and set:
# - SPM_PACKAGE_DIRS
# - XCODE_PROJECT
# - XCODE_WORKSPACE

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"
cd "$(readlink -f .)/../.."
ROOT="$(pwd)"

if [ "$#" -ne 1 ]; then
  echo "Usage: ./validate-target <target-name>"
  exit 1
fi

TARGET_NAME="$1"
TARGET_SAFE_NAME="$(echo "$TARGET_NAME" | tr -cs '[:alnum:]' '_')"

SPM_PACKAGE_DIRS=(
  "$ROOT/Dependencies/Core"
)
XCODE_PROJECT="$ROOT/Project.xcodeproj"
XCODE_WORKSPACE="$ROOT/Project.xcworkspace"

VERIFY_ROOT="$ROOT/.build/verify"
mkdir -p "$VERIFY_ROOT"

for package_dir in "${SPM_PACKAGE_DIRS[@]}"; do
  [ -f "$package_dir/Package.swift" ] || continue
  if swift package --package-path "$package_dir" describe --type json | jq -e --arg target "$TARGET_NAME" '.targets[].name | select(. == $target)' >/dev/null 2>&1; then
    build_log="$VERIFY_ROOT/validate_target_${TARGET_SAFE_NAME}_spm_build.log"
    test_log="$VERIFY_ROOT/validate_target_${TARGET_SAFE_NAME}_spm_test.log"
    swift build --package-path "$package_dir" --target "$TARGET_NAME" --disable-sandbox >"$build_log" 2>&1

    test_target="$TARGET_NAME"
    if ! swift package --package-path "$package_dir" describe --type json | jq -e --arg target "$test_target" '.targets[] | select(.name == $target and .type == "test")' >/dev/null 2>&1; then
      test_target="${TARGET_NAME}Tests"
    fi
    if swift package --package-path "$package_dir" describe --type json | jq -e --arg target "$test_target" '.targets[] | select(.name == $target and .type == "test")' >/dev/null 2>&1; then
      swift test --package-path "$package_dir" --disable-sandbox --filter "$test_target" >"$test_log" 2>&1
      echo "test log: $test_log"
    fi

    echo "build log: $build_log"
    exit 0
  fi
done

build_log="$VERIFY_ROOT/validate_target_${TARGET_SAFE_NAME}_xcode_build.log"
xcodebuild \
  -workspace "$XCODE_WORKSPACE" \
  -scheme "$TARGET_NAME" \
  -destination "generic/platform=macOS" \
  CODE_SIGNING_ALLOWED=NO \
  build >"$build_log" 2>&1
echo "build log: $build_log"
