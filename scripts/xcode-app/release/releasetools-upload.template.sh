#!/bin/bash
# Purpose: ReleaseTools-based multi-platform submission template.
# Usage: ./upload
#
# Copy into a project and customize:
# - SCHEME_* variables
# - SUBMIT_* flags
# - APP_STORE_URL (optional)

set -euo pipefail

SCHEME_IOS="${SCHEME_IOS:-Project}"
SCHEME_MACOS="${SCHEME_MACOS:-Project}"
SCHEME_TVOS="${SCHEME_TVOS:-Project-tvOS}"

SUBMIT_IOS="${SUBMIT_IOS:-1}"
SUBMIT_MACOS="${SUBMIT_MACOS:-1}"
SUBMIT_TVOS="${SUBMIT_TVOS:-0}"

APP_STORE_URL="${APP_STORE_URL:-}"

rt tag

if [ "$SUBMIT_IOS" = "1" ]; then
  rt submit --platform=iOS --scheme="$SCHEME_IOS"
fi

if [ "$SUBMIT_TVOS" = "1" ]; then
  rt submit --platform=tvOS --scheme="$SCHEME_TVOS"
fi

if [ "$SUBMIT_MACOS" = "1" ]; then
  rt submit --platform=macOS --scheme="$SCHEME_MACOS"
fi

git push --tags --force

if [ -n "$APP_STORE_URL" ]; then
  open "$APP_STORE_URL"
fi
