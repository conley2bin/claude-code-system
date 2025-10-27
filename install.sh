#!/bin/bash
# Install system-level CLAUDE.md and commands to ~/.claude/

set -e  # Exit on error

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create ~/.claude directory if it doesn't exist
mkdir -p ~/.claude

echo "Installing Claude Code system files..."

# Copy CLAUDE.md files
echo "  • Copying CLAUDE.md..."
cp "$SCRIPT_DIR/CLAUDE.md" ~/.claude/CLAUDE.md

echo "  • Copying CLAUDE_CN.md..."
cp "$SCRIPT_DIR/CLAUDE_CN.md" ~/.claude/CLAUDE_CN.md

# Copy commands directory
if [ -d "$SCRIPT_DIR/commands" ]; then
    echo "  • Copying slash commands..."
    # Create commands directory in ~/.claude
    mkdir -p ~/.claude/commands

    # Copy all command files
    cp "$SCRIPT_DIR/commands"/*.md ~/.claude/commands/ 2>/dev/null || true

    # Count commands copied
    cmd_count=$(ls ~/.claude/commands/*.md 2>/dev/null | wc -l)
    echo "    → $cmd_count command(s) installed"
fi

echo ""
echo "✓ Installation complete!"
echo ""
echo "Installed files:"
echo "  - ~/.claude/CLAUDE.md"
echo "  - ~/.claude/CLAUDE_CN.md"
echo "  - ~/.claude/commands/ (slash commands)"
echo ""
echo "Available slash commands:"
if [ -d ~/.claude/commands ]; then
    for cmd in ~/.claude/commands/*.md; do
        if [ -f "$cmd" ]; then
            basename "$cmd" .md | sed 's/^/  \//g'
        fi
    done
fi
echo ""
