# Example: Using Oracle in a Team

## Scenario

You're running an agent team and want cross-model verification at key checkpoints.

## Team Setup

Include `oracle` in your team composition:

```
Roles:
- pm: Project Manager
- ios-dev: iOS Developer
- qa: QA Engineer
- oracle: Cross-model verification (Sonnet model, read-only)
```

## When to Use Oracle in a Team

| Phase | Who Requests | What Oracle Does |
|-------|-------------|-----------------|
| Design | PM | Validates architecture decisions |
| Development | Developers | Reviews complex algorithms, suggests alternatives |
| QA | QA Engineer | Provides second opinion on code review findings |
| Final | Team Lead | Final cross-model verification pass |

## Communication Pattern

```
Developer → Oracle: "Review this sorting implementation for performance"
Oracle → [reads code] → [calls Codex] → [verifies response]
Oracle → Developer: "Codex suggests using a radix sort for this case. Verified: the suggestion is valid for integer arrays under 10M elements."
Oracle → Team Lead: "Critical finding: potential O(n^2) worst case in the current implementation."
```

## Key Rules

- Oracle is **reactive** — it only acts when asked
- Oracle is **read-only** — it never modifies code
- Oracle reports to the **requester** and escalates critical findings to the **team lead**
