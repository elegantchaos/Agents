#!/bin/bash
# Purpose: Re-sign embedded bundles/frameworks/xpcs for macOS app builds.
# Usage: Add as an Xcode build phase script.
#
# Derived from ActionStatus `Extras/Scripts/embed`.

set -euo pipefail
shopt -s nullglob

if [[ "${PLATFORM_NAME:-}" != "macosx" ]]; then
  exit 0
fi

IDENTITY="${EXPANDED_CODE_SIGN_IDENTITY:-}"
if [ -z "$IDENTITY" ]; then
  IDENTITY="-"
fi

BUILT_RESOURCES_DIR="${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
BUILT_FRAMEWORKS_DIR="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
BUILT_XPCSERVICES_DIR="${TARGET_BUILD_DIR}/${XPCSERVICES_FOLDER_PATH}"

resign() {
  codesign --verbose --force --deep --options runtime --sign "$IDENTITY" "$1" >/dev/null
}

resign_bundles() {
  local path="$1"
  [ -d "$path" ] || return 0
  pushd "$path" >/dev/null
  for bundle in *.bundle; do
    [ "$bundle" = "Settings.bundle" ] && continue
    resign "$bundle"
  done
  popd >/dev/null
}

resign_frameworks() {
  local path="$1"
  [ -d "$path" ] || return 0
  pushd "$path" >/dev/null
  for framework in *.framework; do
    resign_bundles "$framework/Versions/A/Resources"
    resign "$framework/Versions/A"
  done
  popd >/dev/null
}

resign_xpcs() {
  local path="$1"
  [ -d "$path" ] || return 0
  pushd "$path" >/dev/null
  for xpc in *.xpc; do
    resign "$xpc"
  done
  popd >/dev/null
}

resign_bundles "$BUILT_RESOURCES_DIR"
resign_frameworks "$BUILT_FRAMEWORKS_DIR"
resign_xpcs "$BUILT_XPCSERVICES_DIR"
