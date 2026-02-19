---
name: ask-oracle
description: "Ask Codex (GPT-5.3) a question via cross-model verification. Reads relevant code, delegates to Codex, quality-checks the response, and presents verified results. Use when you want a second opinion from a different AI model."
---

# Ask Oracle

Cross-model verification skill. Bridges Claude Code with Codex (GPT-5.3) for second opinions, alternative implementations, and architectural validation.

## Prerequisites

- [Codex CLI](https://github.com/openai/codex) installed and configured
- OpenAI API key set up for Codex

Verify with:
```bash
codex exec "echo hello" 2>&1
```

## Workflow

### Step 1: Understand the Request

Parse what the user wants verified:
- **Code review**: specific file/function to review
- **Alternative implementation**: code to reimagine
- **Architecture validation**: design to evaluate
- **Bug investigation**: bug to diagnose
- **General question**: any technical question

### Step 2: Gather Context

If the request involves project code:
1. Use Read/Grep to find and read the relevant code
2. Identify the key sections needed for the Codex prompt
3. Keep context focused — include only what's necessary

### Step 3: Construct and Send Codex Prompt

Build the prompt with inline code and clear instructions:

```bash
timeout 180 codex exec "PROMPT_HERE" 2>&1
```

**Prompt rules:**
- Always inline the relevant code (Codex can't access project files)
- Be specific about what you want evaluated
- Include constraints and context
- Match the user's language

**Template:**
```
[Optional language instruction]

Context: [Background]

Code:
```[lang]
[Relevant code inline]
```

Task: [What to evaluate/suggest]

Constraints:
- [Any constraints]
```

### Step 4: Quality Check

Before presenting results, verify:
- [ ] Response is relevant to the request
- [ ] Code suggestions are syntactically correct
- [ ] No obvious logical errors
- [ ] Recommendations are practical

### Step 5: Present Results

Format the output clearly:

```markdown
## Oracle Verification Result

### Question
[What was asked]

### Codex Response
[Key findings from Codex, quoted or summarized]

### Verification Notes
[Your assessment of the Codex response — agreements, disagreements, caveats]

### Recommendation
[Actionable next steps, if any]
```

## Retry Policy

- Timeout: 180 seconds per call
- Max 1 retry on failure (refine prompt to be more specific)
- After 2 failures: report the error honestly, suggest manual review

## Examples

### Code Review
User: "이 함수 Codex한테 리뷰 받아줘"
→ Read the function → Inline in Codex prompt → Quality check → Report

### Alternative Implementation
User: "Ask Codex for a better way to implement this sorting logic"
→ Read current code → Ask Codex for alternatives → Compare approaches → Report

### Architecture Check
User: "Have Codex evaluate this API design"
→ Read API code/docs → Ask Codex to critique → Verify feedback → Report
