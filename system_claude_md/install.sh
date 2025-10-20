#!/bin/bash
# Install system-level CLAUDE.md to ~/.claude/

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create ~/.claude if it doesn't exist
mkdir -p ~/.claude

# Copy files
cp "$SCRIPT_DIR/CLAUDE.md" ~/.claude/CLAUDE.md
cp "$SCRIPT_DIR/CLAUDE_CN.md" ~/.claude/CLAUDE_CN.md

echo "✓ Installed CLAUDE.md and CLAUDE_CN.md to ~/.claude/"
