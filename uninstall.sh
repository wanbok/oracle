#!/bin/bash
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"

echo "Uninstalling claude-oracle..."

rm -f "${CLAUDE_DIR}/agents/oracle.md"
echo "  Removed agent: oracle.md"

rm -rf "${CLAUDE_DIR}/skills/ask-oracle"
echo "  Removed skill: ask-oracle"

echo ""
echo "Done! Oracle has been removed."
