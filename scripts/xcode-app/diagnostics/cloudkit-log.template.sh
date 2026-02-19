#!/bin/bash
# Purpose: Stream CoreData/CloudKit logs for an app process.
# Usage: ./cloudkit-log "<process-name>"

set -euo pipefail

PROCESS_NAME="${1:-Project App}"

log stream --info --debug --predicate "process = \"$PROCESS_NAME\" and (subsystem = \"com.apple.coredata\" or subsystem = \"com.apple.cloudkit\")"
