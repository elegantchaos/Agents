# Significant Type Documentation

Bookish's service review found that documentation comments could pass lint while
giving a reader little understanding of a type's job. Statements such as
"maintains the route" named a broad responsibility but omitted its concrete state,
operations and caller usage.

Updated `baseline:standards`' implementation reference to require useful explanations
for significant types, scaled to their complexity. Comments identify the concrete
job and outcome, state or resources owned, important collaborators and intended
use. Lifecycle, persistence and side effects are included when they affect callers.
Claims are checked against the implementation and relevant design documentation;
the guidance distinguishes meaning review from documentation-presence lint.

Added a checklist item to the standards skill. The Swift language skill references
the shared criteria from its documentation guidance and checklist, with service
state/operation/access surfaces as a Swift-specific application. No new skill or
duplicated set of general criteria was introduced.

Changes are isolated on `feature/type-documentation`. Both skills passed
skill-creator's `quick_validate.py` with the shared agent Python interpreter.
Manually checked the required reference routes, scope and the criteria against
Bookish's revised service comments; whitespace checks passed. There are no script
or executable changes to test. Plugin releases and runtime refresh are pending.
