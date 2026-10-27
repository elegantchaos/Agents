# Decision Records Without Plans

Bookish decision records pointed at implementation plans and status: "Implementation is planned in…", "List Implementation gives the proposed delivery order", "not yet implemented", and a reference to an implementation slice. Each goes out of date once the work lands. The `baseline:records` skill caused it, by telling agents to link decisions to "design and implementation documents for fuller models, mechanisms, examples and delivery plans".

The user edited the skill, and the agent reviewed and completed the edit:

- Decision records leave out details that will go out of date or are likely to change, such as planned implementation work or temporary technical decisions.
- They link design documents for fuller models, mechanisms and examples, and do not link implementation plans, delivery order or implementation status. "Delivery plans" was dropped from the list of things to link, which the new rule contradicted.
- The decision compliance checklist checks for both.

The same PR includes the user's VOICE.md edit: the greeting now suits the time, context or project, with fresh examples, and the series title uses underscores for emphasis. Baseline 0.8.19.
