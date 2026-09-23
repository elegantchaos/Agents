# Scripting

For repository-maintained scripts and automation, prefer Swift over shell or another scripting language unless the host environment clearly requires something else.

Treat all scripts as first-class citizens and follow coding standards when writing scripts.

Keep scripts deterministic and explicit about their inputs, outputs, and side effects.

Prefer idempotent script behavior where practical, especially for setup, generation, and maintenance tasks.

Keep reusable logic in modules or libraries and keep entry scripts thin.

Reuse the project's existing runner, task system, and command entry points rather than inventing parallel workflows without a concrete need.

Prefer factoring large scripts into multiple sub-commands, rather than a single monolithic script controlled by many `--arguments`.

Consider usability, clarity and discoverability when designing script CLIs.

Make failure output actionable and concise.

Document non-obvious prerequisites close to the script entry point.
