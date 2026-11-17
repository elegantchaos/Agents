# Work Items

A work item is one piece of work small enough to finish, review and verify in a single PR. Each open item has a file in this folder, and the [roadmap](../../ROADMAP.md) lists them in order. The roadmap and these items drive the work; nobody should need to read a review or the journal to find out what is left to do.

## The File

Name the file `<ID> <Title>.md`, such as `WT1 Fresh-Session Worktree Acceptance.md`. An ID is a short prefix for the area of work and a number, and it never changes or gets reused.

```markdown
# <ID>: <Title>

- **Status:** Started | Planned | Proposed | Parked
- **Depends on:** other items or releases, or nothing
- **Sources:** the reviews, journal entries, decisions or PRs it came from

## Finish Condition

What is true when this is done, in terms that can be checked.

## Notes

Optional: what is already delivered, what a parked item waits for and where to resume, choices still open.

## Outcome

Written when the work is done: what was delivered, with the PR and journal entry as evidence.
```

- **Started:** work is under way.
- **Planned:** agreed and not started.
- **Proposed:** Sam has not confirmed it.
- **Parked:** set aside deliberately. The notes say why, and where to resume.

Link to the skill, decision or journal entry that owns the detail, and do not copy it. An item that grows beyond one PR is split into several. Work in other projects belongs in their own records; an item here covers only what the shared guidance needs from it.

## Lifecycle

1. **Create** an item when work is agreed or proposed, or when a review closes with a finding left unaddressed. Add it to the roadmap in the same PR.
2. **Update** its status and notes in the PR that starts, parks or resumes it.
3. **Finish** it in the PR that completes the work: write the Outcome, delete the Status line, move the file to `Done/`, remove it from the roadmap's lists, add the result to the roadmap's Delivered section when it changes what the shared guidance provides, and correct any links to it.

Make these updates in the same PR as the work, written as the state once it merges. Never open a separate PR only to record that another merged.

A finding that several reviews raise is one item naming each of them under Sources. Small related findings share an item when one PR would fix them together.

`Done/` is history. Nothing there needs reading to plan new work.
