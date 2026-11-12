# Review Skill Coverage

A Bookish review of PR #139 assessed the change without reading the `baseline:standards`, `swift:language`, `swift:swiftui` and `swift:testing` skills. It listed them under Not Checked and still gave a verdict. Sam pointed out that this misses the point of a review. Re-reviewing after reading those skills produced several additional should-fix findings.

The review skill made this possible. It required every decision record to be read in full and forbade sampling them, but its Required References only listed the skills, with no rule for the case where they went unread. An unread skill therefore looked like any other reportable coverage gap.

The skill now has a Skill Coverage section beside Decision Coverage. Before assessing any review mode, the reviewer:

- lists the skills that apply, from the project's `AGENTS.md` and each changed file's language and framework;
- reads each `SKILL.md` and every required reference in full;
- checks every file in scope against each checklist.

An unread skill blocks the review rather than becoming a Not Checked item. Time or context limits and general language knowledge do not substitute for reading. A skill that genuinely cannot be read makes the review incomplete, with no verdict.

Both summary templates now name the skills read, Establish Intent includes the reading step, and the checklist requires that no skill appears under Not Checked. Both baseline plugin manifests advance to 0.8.34.

This applies Decision 0001: the change is made at the shared source. Installation is due after merge.
