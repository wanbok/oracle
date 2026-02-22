---
name: oracle
description: "Ask Codex (GPT-5.3) a question via cross-model verification. Reads relevant code, delegates to Codex, quality-checks the response, and presents verified results. Use when you want a second opinion from a different AI model."
allowed-tools: Bash,Read,Grep,Glob
---

# Oracle Ask

Cross-model verification via Codex (GPT-5.3). Read code, delegate to Codex, quality-check, report.

## Workflow

### Step 1: Parse Request

Determine what the user wants:
- **Code review**: specific file/function to review
- **Alternative implementation**: code to reimagine
- **Architecture validation**: design to evaluate
- **General question**: any technical question for Codex

### Step 2: Gather Context

If the request involves project code:
1. Read/Grep the relevant code
2. Keep context focused — only what's necessary

If no code context needed (general question), skip to Step 3.

### Step 3: Call Codex

```bash
timeout 180 codex exec "PROMPT" 2>&1
```

**Prompt rules:**
- Inline relevant code (Codex can't access project files)
- Be specific about what to evaluate
- Match the user's language (Korean question → prepend `한국어로 답변해줘.`)

### Step 4: Quality Check

Before presenting results:
- Is the response relevant?
- Are code suggestions syntactically correct?
- Any obvious errors?

### Step 5: Report

```markdown
## Oracle Result

### Codex Response
[Key findings, quoted or summarized]

### Verification
[Your assessment — agreements, disagreements, caveats]

### Recommendation
[Actionable next steps, if any]
```

## Retry

- Timeout: 180s
- Max 1 retry (refine prompt)
- After 2 failures: report error, suggest manual review
