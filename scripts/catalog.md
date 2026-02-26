# Script Catalog

This catalog is based on script files found in:

- `~/Developer/Projects/Stack/Extras/Scripts`
- `~/Developer/Projects/ActionStatus/Extras/Scripts`

## Multi-Repo Script Names

Only script names appearing in 2+ repos are considered canonical here.

- `upload` (5 repos)
- `upload-macOS` (3 repos)
- `screenshots` (3 repos)
- `rt` (3 repos)
- `install-xcpretty` (3 repos)
- `bootstrap-tools` (3 repos)
- `upload.template` (2 repos)
- `upload-iOS` (2 repos)
- `embed` (2 repos)
- `downloads` (2 repos)

## Included Templates In This Repo

- `xcode-app/release/releasetools-upload.template.sh` (`upload`)
- `xcode-app/build-phases/embed-resign.template.sh` (`embed`)

## Excluded For Now

Even with repeated names, these are currently omitted because they are either tool-link convenience wrappers or highly project-specific workflows:

- `screenshots`
- `downloads`
- `rt`
- `bootstrap-tools`
- `install-xcpretty`
- `format-all-source`
- `lint-all-source`
- platform-specific upload wrappers (`upload-iOS`, `upload-macOS`)
