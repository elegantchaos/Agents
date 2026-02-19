# Script Catalog (First Pass)

This is a first-pass classification of scripts found in:

- `/Users/sam/Developer/Projects/Stack/Extras/Scripts`
- `/Users/sam/Developer/Projects/ActionStatus/Extras/Scripts`

## Shared Patterns

- `validate-changes`: common concept, project-specific implementation
- `validate-target`: common concept, project-specific package/workspace layout
- `upload`, `upload-*`: ReleaseTools-based submission flows

## Recommended Buckets

- `xcode-app/validation`
  - `validate-changes`
  - `validate-target`
- `xcode-app/release`
  - `upload`
  - `upload-iOS`, `upload-macOS`, `upload-tvOS`
  - `upload.template`
- `xcode-app/build-phases`
  - `embed` (re-sign embedded frameworks/bundles/xpcs)
- `xcode-app/diagnostics`
  - `cloudkit-log.sh`
  - `check-infos.sh`
  - `screenshots`
  - `downloads` (project-local convenience)
- `swift-cli/validation`
  - `test-all`
  - `format-all-source`
  - `lint-all-source`

## Notes

- Most scripts are reusable as templates, not drop-in shared binaries.
- `validate-*` scripts are best parameterized per repo (workspace name, package paths, schemes, platforms).
- ReleaseTools scripts should isolate app-specific values (scheme names, App Store URLs) into variables.
