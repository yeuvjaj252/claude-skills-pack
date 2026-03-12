#!/bin/bash

# Claude Skills Pack Uninstaller
# Usage: ./uninstall.sh

set -e

CLAUDE_DIR="$HOME/.claude"

echo "🗑️  Uninstalling Claude Skills Pack..."

# Remove CSP commands only
if [ -d "$CLAUDE_DIR/commands" ]; then
    for f in "$CLAUDE_DIR/commands"/csp-*.md "$CLAUDE_DIR/commands/cook.md"; do
        [ -f "$f" ] && rm -f "$f" && echo "🧹 Removed: $(basename $f)"
    done
    echo "✅ CSP commands removed"
fi

# Remove CSP agents only
if [ -d "$CLAUDE_DIR/agents" ]; then
    for f in "$CLAUDE_DIR/agents"/*.md; do
        [ -f "$f" ] && rm -f "$f" && echo "🧹 Removed: $(basename $f)"
    done
    echo "✅ CSP agents removed"
fi

# Remove CSP skills only (skill-csp-* prefix)
if [ -d "$CLAUDE_DIR/skills" ]; then
    for d in "$CLAUDE_DIR/skills"/skill-csp-*/; do
        [ -d "$d" ] && rm -rf "$d" && echo "🧹 Removed: $(basename $d)"
    done
    [ -f "$CLAUDE_DIR/skills/doc.md" ] && rm -f "$CLAUDE_DIR/skills/doc.md"
    echo "✅ CSP skills removed"
fi

echo ""
echo "🎉 Uninstall complete!"
echo "Run /clear in Claude Code to reload."
