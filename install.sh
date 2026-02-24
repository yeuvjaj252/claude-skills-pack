#!/bin/bash

# Claude Skills Pack Installer
# Usage: ./install.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "🚀 Installing Claude Skills Pack..."

# Create directories
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/skills"

# Copy commands
if [ -d "$SCRIPT_DIR/commands" ] && [ "$(ls -A $SCRIPT_DIR/commands 2>/dev/null)" ]; then
    cp -r "$SCRIPT_DIR/commands"/* "$CLAUDE_DIR/commands/"
    echo "✅ Commands installed: $(ls -1 $SCRIPT_DIR/commands | wc -l) files"
fi

# Copy agents
if [ -d "$SCRIPT_DIR/agents" ] && [ "$(ls -A $SCRIPT_DIR/agents 2>/dev/null)" ]; then
    cp -r "$SCRIPT_DIR/agents"/* "$CLAUDE_DIR/agents/"
    echo "✅ Agents installed: $(ls -1 $SCRIPT_DIR/agents | wc -l) files"
fi

# Copy skills
if [ -d "$SCRIPT_DIR/skills" ] && [ "$(ls -A $SCRIPT_DIR/skills 2>/dev/null)" ]; then
    cp -r "$SCRIPT_DIR/skills"/* "$CLAUDE_DIR/skills/"
    echo "✅ Skills installed: $(ls -1 $SCRIPT_DIR/skills | wc -l) folders"
fi

echo ""
echo "🎉 Installation complete!"
echo ""
echo "Next steps:"
echo "  1. Run /clear in Claude Code to reload"
echo "  2. Test with /kehoach, /cook, /csp-backend, /csp-deploy, etc."
