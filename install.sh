#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"

echo "Installing oracle..."

# Check prerequisites
if ! command -v codex &> /dev/null; then
    echo ""
    echo "WARNING: 'codex' CLI not found."
    echo "Install it with: npm install -g @openai/codex"
    echo "Then configure your OpenAI API key."
    echo ""
    echo "Continuing installation anyway..."
    echo ""
fi

# Install agent
mkdir -p "${CLAUDE_DIR}/agents"
ln -sf "${SCRIPT_DIR}/agents/oracle.md" "${CLAUDE_DIR}/agents/oracle.md"
echo "  Linked agent: oracle.md"

# Install skill (/oracle)
mkdir -p "${CLAUDE_DIR}/skills"
ln -sf "${SCRIPT_DIR}/skills/oracle" "${CLAUDE_DIR}/skills/oracle"
echo "  Linked skill: /oracle"

echo ""
echo "Done! Oracle is ready to use."
echo ""
echo "Usage:"
echo "  Skill:  /oracle \"Review this code for security issues\""
echo "  Agent:  Use 'oracle' as a subagent_type in Task tool"
echo "  Team:   Add 'oracle' role to your agent team"
