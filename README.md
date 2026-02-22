# claude-oracle

Cross-model verification for [Claude Code](https://claude.com/claude-code). Bridges Claude with [Codex (GPT-5.3)](https://github.com/openai/codex) to get second opinions on code reviews, alternative implementations, and architectural decisions.

[한국어](README.ko.md)

## Why?

Different AI models have different strengths and blind spots. By asking a second model to review your code, you catch issues that a single model might miss. Oracle automates this cross-verification workflow.

## Prerequisites

- [Claude Code](https://claude.com/claude-code) installed
- [Codex CLI](https://github.com/openai/codex) installed and configured with an OpenAI API key

```bash
npm install -g @openai/codex
```

## Install

```bash
git clone https://github.com/wanbok/claude-oracle.git
cd claude-oracle
chmod +x install.sh
./install.sh
```

This symlinks the agent into your `~/.claude/agents/` directory.

## Usage

### As a Custom Agent

Reference `oracle` as a `subagent_type` when spawning agents via the Task tool:

```
Task(subagent_type="oracle", prompt="Review this code for security issues: ...")
```

### As a Team Role

Add `oracle` to your agent team for continuous cross-model verification during development. See [examples/team-usage.md](examples/team-usage.md).

## What It Does

```
You ask a question
       │
       ▼
 Oracle reads the
 relevant code (Read/Grep)
       │
       ▼
 Constructs a prompt with
 inline code context
       │
       ▼
 Sends to Codex CLI
 (timeout: 180s)
       │
       ▼
 Quality-checks the
 Codex response
       │
       ▼
 Reports verified results
 back to you
```

Oracle is **read-only** — it never edits your files. It only suggests; you decide what to apply.

## Backend Configuration

Oracle uses [Codex CLI](https://github.com/openai/codex) by default, but you can swap the backend by editing the `codex exec` command in `agents/oracle.md`.

| Backend | Command | Notes |
|---------|---------|-------|
| **Codex CLI** (default) | `codex exec "prompt"` | Requires OpenAI API key |
| **Ollama** | `ollama run llama3 "prompt"` | Local, free, no API key |
| **OpenRouter** | `curl` to OpenRouter API | Multi-model access, pay-per-use |
| **Google Gemini** | `gemini "prompt"` | Requires Google AI API key |

To switch backends, replace the `codex exec` pattern in `agents/oracle.md` — the "How to Call Codex" section.

## Uninstall

```bash
./uninstall.sh
```

## License

MIT
