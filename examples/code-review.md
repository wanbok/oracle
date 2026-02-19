# Example: Code Review Second Opinion

## Scenario

You have a function and want Codex to review it for potential issues.

## Prompt

```
/ask-oracle Review this function for edge cases and potential bugs
```

Or reference a specific file:

```
/ask-oracle Review the authentication middleware in src/middleware/auth.ts
```

## What Happens

1. Oracle reads the file/function you referenced
2. Inlines the code into a Codex prompt
3. Codex analyzes for bugs, edge cases, security issues
4. Oracle verifies Codex's suggestions make sense
5. You get a structured report with findings and recommendations
