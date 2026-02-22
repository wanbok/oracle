#!/bin/bash
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"

echo "Uninstalling oracle..."

rm -f "${CLAUDE_DIR}/agents/oracle.md"
echo "  Removed agent: oracle.md"

rm -f "${CLAUDE_DIR}/skills/oracle"
echo "  Removed skill: /oracle"

echo ""
echo "Done! Oracle has been removed."
