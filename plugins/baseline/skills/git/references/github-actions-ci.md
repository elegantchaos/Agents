# GitHub Actions CI Triage

Use this workflow only for failing GitHub Actions checks on a pull request.

1. Confirm `gh` authentication with `gh auth status`; request user authentication if needed.
2. Resolve the PR from an explicit reference or the current branch.
3. Inspect checks with `gh pr checks` and obtain failing Actions run details and logs with `gh run view`.
4. If a check belongs to another provider, identify it as external and report it without attempting diagnosis.
5. Summarize the observed failure, relevant log evidence, and likely root cause. Do not overstate certainty when logs are missing.
6. If the user authorized fixing the failure, implement a focused, evidence-based fix within that scope. For diagnosis-only requests, report the proposed fix. Ask before expanding scope or choosing a material tradeoff that the request does not resolve.
7. After a fix, run relevant local validation and recheck the PR status. State residual risk and any external failures.
