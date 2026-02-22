#!/bin/bash
set -euo pipefail

CLAUDE_DIR="${HOME}/.claude"

echo "Uninstalling oracle..."

rm -f "${CLAUDE_DIR}/agents/oracle.md"
echo "  Removed agent: oracle.md"

echo ""
echo "Done! Oracle has been removed."
