# Review Decision Coverage

Date: 2026-10-21

Bookish PR #96 exposed a review that selectively read decisions and claimed architectural compliance without checking the governing service decision. Sam clarified that all decision records must be read and considered, with applicability determined after reading.

Updated baseline:review to require complete decision-log reading before assessing implementation or proposed design, an inventory reconciled with status and applicability, and source evidence for applicable constraints. Existing code and passing tests cannot authorize exceptions. Unread records and unchecked constraints make coverage incomplete, require a partial verdict, and prevent architectural compliance claims.

Both report templates and the final checklist require decision coverage. Draft and superseded records remain part of the reading inventory but are not enforced as accepted current policy. The baseline plugin manifests advance to 0.8.1.

The update is limited to the review skill and its packaging. Extending complete decision reading to design and implementation guidance remains a follow-up. Automated semantic compliance checking and independent behavioral evaluation are not part of this update.

Validation: skill-creator quick_validate passed; both manifests parse as JSON and declare 0.8.1; git diff --check passed. Manual inspection checked the reading requirement, applicability and supersession handling, incomplete-coverage verdict restriction, both report templates, and final checklist against the requested changes. Codex plugin add installed baseline 0.8.1, and its review skill matches the canonical source byte for byte. The documented Claude installation reads the canonical source in place; no separate Claude runtime session was tested. No independent behavioral evaluation was run, so structural validation does not establish future reviewer compliance.
