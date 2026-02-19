#!/bin/bash
# Purpose: Validate local changes for an Xcode app repository.
# Usage: ./validate-changes [--clean]
#
# Copy into a project and set:
# - WORKSPACE
# - SCHEMES
# - DESTINATIONS
# - optional package build/test steps

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"
cd "$(readlink -f .)/../.."
ROOT="$(pwd)"

WORKSPACE="${WORKSPACE:-Project.xcworkspace}"
SCHEMES=(${SCHEMES:-Project})
DESTINATIONS=(${DESTINATIONS:-"generic/platform=iOS" "generic/platform=macOS"})

FORCE_CLEAN=0
if [ "${1:-}" = "--clean" ] || [ "${1:-}" = "-c" ]; then
  FORCE_CLEAN=1
fi

CACHE_ROOT="$ROOT/.build/cache"
VERIFY_ROOT="$ROOT/.build/verify"
DERIVED_DATA_PATH="$ROOT/.build/derived-data"
mkdir -p "$CACHE_ROOT/clang-module-cache" "$CACHE_ROOT/swift-module-cache" "$CACHE_ROOT/xdg-cache" "$CACHE_ROOT/home" "$VERIFY_ROOT"
export HOME="$CACHE_ROOT/home"
export CLANG_MODULE_CACHE_PATH="$CACHE_ROOT/clang-module-cache"
export SWIFTPM_MODULECACHE_OVERRIDE="$CACHE_ROOT/swift-module-cache"
export XDG_CACHE_HOME="$CACHE_ROOT/xdg-cache"

if [ "$FORCE_CLEAN" -eq 1 ]; then
  rm -rf "$ROOT/.build"
fi

CHANGED_SWIFT_FILES=()
while IFS= read -r line; do
  CHANGED_SWIFT_FILES+=("$line")
done < <(
  {
    git diff --name-only -- "*.swift"
    git diff --cached --name-only -- "*.swift"
    git ls-files --others --exclude-standard -- "*.swift"
  } | awk '!seen[$0]++'
)

if [ "${#CHANGED_SWIFT_FILES[@]}" -gt 0 ]; then
  swift format --in-place "${CHANGED_SWIFT_FILES[@]}"
  swift format lint "${CHANGED_SWIFT_FILES[@]}"
fi

XCODE_ACTION=(build)
if [ "$FORCE_CLEAN" -eq 1 ]; then
  XCODE_ACTION=(clean build)
  rm -rf "$DERIVED_DATA_PATH"
fi

for scheme in "${SCHEMES[@]}"; do
  for destination in "${DESTINATIONS[@]}"; do
    safe_dest="$(echo "$destination" | tr -cs '[:alnum:]' '_')"
    log="$VERIFY_ROOT/validate_changes_${scheme}_${safe_dest}.log"
    xcodebuild \
      -workspace "$ROOT/$WORKSPACE" \
      -scheme "$scheme" \
      -destination "$destination" \
      -derivedDataPath "$DERIVED_DATA_PATH" \
      CODE_SIGNING_ALLOWED=NO \
      "${XCODE_ACTION[@]}" >"$log" 2>&1
    echo "build log: $log"
  done
done
