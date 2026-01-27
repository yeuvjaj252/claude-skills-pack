#!/bin/bash

# Claude Skills Pack Uninstaller
# Usage: ./uninstall.sh

set -e

CLAUDE_DIR="$HOME/.claude"

echo "🗑️  Uninstalling Claude Skills Pack..."

# Remove commands
if [ -d "$CLAUDE_DIR/commands" ]; then
    rm -rf "$CLAUDE_DIR/commands"
    echo "✅ Commands removed"
fi

# Remove agents
if [ -d "$CLAUDE_DIR/agents" ]; then
    rm -rf "$CLAUDE_DIR/agents"
    echo "✅ Agents removed"
fi

# Remove skills
if [ -d "$CLAUDE_DIR/skills" ]; then
    rm -rf "$CLAUDE_DIR/skills"
    echo "✅ Skills removed"
fi

echo ""
echo "🎉 Uninstall complete!"
echo "Run /clear in Claude Code to reload."
