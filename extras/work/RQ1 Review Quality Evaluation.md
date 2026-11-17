# RQ1: Review Quality Evaluation

- **Status:** Planned
- **Depends on:** reviews made with baseline 0.8.34 or later
- **Sources:** [Review skill coverage](../journal/2026-11-12-review-skill-coverage.md), [Review decision coverage](../journal/2026-10-21-review-decision-coverage.md), [Agents #47](https://github.com/elegantchaos/Agents/pull/47)

## Finish Condition

At least three reviews made with baseline 0.8.34 or later are assessed against the review skill. Each gap found is either fixed in the skill or declined by Sam with a reason. The assessment checks that each review:

- names the skills it read and reports checklist deviations;
- leaves no applicable skill under Not Checked;
- reaches justified Codebase Effect conclusions about obsolete machinery, possible simplification and duplicated knowledge, instead of describing the change locally.

## Notes

Metadata and validator checks do not close this; it is a behavioural evaluation of real reviews. Bookish reviews are the likeliest evidence.
